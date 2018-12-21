local global = require "global"
local skynet = require "skynet"
local interactive =  require "base.interactive"

local itembase = import(service_path("item/itembase"))

function NewItem(sid)
    local o = CItem:New(sid)
    return o
end

CItem = {}
CItem.__index = CItem
inherit(CItem,itembase.CItem)

function CItem:New(sid)
    local o = super(CItem).New(self,sid)
    return o
end

function CItem:TrueUse()
    local iCostAmount = self:GetUseCostAmount()
    self:AddAmount(-iCostAmount,"itemuse")
end