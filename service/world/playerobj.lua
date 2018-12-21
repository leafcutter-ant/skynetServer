--import module

local global = require "global"
local skynet = require "skynet"
local interactive = require "base.interactive"

local playerctrl = import(service_path("playerctrl.init"))

function NewPlayer(...)
    local o = CPlayer:New(...)
    return o
end

CPlayer = {}
CPlayer.__index = CPlayer
inherit(CPlayer, logic_base_cls())

function CPlayer:New(mConn, mRole)
    local o = super(CPlayer).New(self)

    o.m_iNetHandle = mConn.handle
    o.m_iPid = mRole.pid
    o.m_sAccount = mRole.account
    o.m_iDisconnectedTime = nil
    o.m_fHeartBeatTime = get_time()

    o.m_oBaseCtrl = playerctrl.NewBaseCtrl(self.m_iPid)
    o.m_oActiveCtrl = playerctrl.NewActiveCtrl(self.m_iPid)

    return o
end

function CPlayer:Release()
    self.m_oBaseCtrl:Release()
    self.m_oActiveCtrl:Release()
    super(CPlayer).Release(self)
end

function CPlayer:GetAccount()
    return self.m_sAccount
end

function CPlayer:GetPid()
    return self.m_iPid
end

function CPlayer:GetConn()
    local oWorldMgr = global.oWorldMgr
    return oWorldMgr:GetConnection(self.m_iNetHandle)
end

function CPlayer:SetNetHandle(iNetHandle)
    self.m_iNetHandle = iNetHandle
    if iNetHandle then
        self.m_iDisconnectedTime = nil
    else
        self.m_iDisconnectedTime = get_msecond()
        self:OnDisconnected()
    end
end

function CPlayer:Send(sMessage, mData)
    local oConn = self:GetConn()
    if oConn then
        oConn:Send(sMessage, mData)
    end
end

function CPlayer:MailAddr()
    local oConn = self:GetConn()
    if oConn then
        return oConn:MailAddr()
    end
end

function CPlayer:OnLogout()
    local oSceneMgr = global.oSceneMgr
    oSceneMgr:OnLogout(self)
    --disconnect
    local oWorldMgr = global.oWorldMgr
    local oConn = self:GetConn()
    if oConn then
        oWorldMgr:KickConnection(oConn.m_iHandle)
    end
    --save db
    self:SaveDb()
end

function CPlayer:OnLogin(bReEnter)
    self:Send("GS2CLoginRole", {role = {account = self:GetAccount(), pid = self:GetPid()}})
    self.m_fHeartBeatTime = get_time()

    local oSceneMgr = global.oSceneMgr
    oSceneMgr:OnLogin(self, bReEnter)

    if not bReEnter then
        self:Schedule()
    end
end

function CPlayer:OnDisconnected()
    local oSceneMgr = global.oSceneMgr
    oSceneMgr:OnDisconnected(self)
end

function CPlayer:Schedule()
    local f1
    f1 = function ()
        self:DelTimeCb("_CheckSaveDb")
        self:AddTimeCb("_CheckSaveDb", 5*60*1000, f1)
        self:_CheckSaveDb()
    end
    f1()

    local f2
    f2 = function ()
        self:DelTimeCb("_CheckHeartBeat")
        self:AddTimeCb("_CheckHeartBeat", 10*1000, f2)
        self:_CheckHeartBeat()
    end
    f2()
end

function CPlayer:SaveDb()
    if self.m_oBaseCtrl:IsDirty() then
        local mData = self.m_oBaseCtrl:Save()
        interactive.Send(".gamedb", "playerdb", "SavePlayerBase", {pid = self:GetPid(), data = mData})
        self.m_oBaseCtrl:UnDirty()
    end
    if self.m_oActiveCtrl:IsDirty() then
        local mData = self.m_oActiveCtrl:Save()
        interactive.Send(".gamedb", "playerdb", "SavePlayerActive", {pid = self:GetPid(), data = mData})
        self.m_oActiveCtrl:UnDirty()
    end
end

function CPlayer:ClientHeartBeat()
    self.m_fHeartBeatTime = get_time()
    self:Send("GS2CHeartBeat", {time = math.floor(self.m_fHeartBeatTime)})
end

function CPlayer:_CheckSaveDb()
    assert(not self:IsRelease(), "_CheckSaveDb fail")
    self:SaveDb()
end

function CPlayer:_CheckHeartBeat()
    assert(not self:IsRelease(), "_CheckHeartBeat fail")
    local fTime = get_time()
    if fTime - self.m_fHeartBeatTime >= 3*60 then
        local oWorldMgr = global.oWorldMgr
        oWorldMgr:Logout(self:GetPid())
    end
end