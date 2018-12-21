
local M = {}

local C2GS = {}
local GS2C = {}
M.C2GS = C2GS
M.GS2C = GS2C

local C2GS_BY_NAME = {}
local GS2C_BY_NAME = {}
M.C2GS_BY_NAME = C2GS_BY_NAME
M.GS2C_BY_NAME = GS2C_BY_NAME

--C2GS BEGIN

local C2GS_DEFINES = {}

C2GS_DEFINES.login = {
    C2GSLoginAccount = 1001,
    C2GSLoginRole = 1002,
}

C2GS_DEFINES.scene = {
    C2GSSyncPos = 2001,
}

C2GS_DEFINES.other = {
    C2GSHeartBeat = 3001,
    C2GSGMCmd = 3002,
}

C2GS_DEFINES.war = {
    C2GSWarSkill = 4001,
    C2GSWarNormalAttack = 4002,
    C2GSWarProtect = 4003,
    C2GSWarEscape = 4004,
}

--C2GS END

--GS2C BEGIN

local GS2C_DEFINES = {}

GS2C_DEFINES.login = {
    GS2CHello = 1001,
    GS2CLoginError = 1002,
    GS2CLoginAccount = 1003,
    GS2CLoginRole = 1004,
}

GS2C_DEFINES.scene = {
    GS2CShowScene = 2001,
    GS2CEnterScene = 2002,
    GS2CEnterAoi = 2003,
    GS2CLeaveAoi = 2004,
    GS2CSyncAoi = 2005,
    GS2CSyncPos = 2006,
}

GS2C_DEFINES.other = {
    GS2CHeartBeat = 3001,
}

GS2C_DEFINES.war = {
    GS2CWarStart = 4001,
    GS2CWarEnd = 4002,
    GS2CWarBoutStart = 4003,
    GS2CWarBoutEnd = 4004,
    GS2CWarAddWarrior = 4005,
    GS2CWarSkillStart = 4006,
    GS2CWarSkillEnd = 4007,
    GS2CWarNormalAttackStart = 4008,
    GS2CWarNormalAttackEnd = 4009,
    GS2CWarMagicStart = 4010,
    GS2CWarMagicEnd = 4011,
    GS2CWarProtectStart = 4012,
    GS2CWarProtectEnd = 4013,
    GS2CWarEscapeStart = 4014,
    GS2CWarEscapeEnd = 4015,
    GS2CWarDamage = 4016,
    GS2CWarWarriorStatus = 4017,
}

--GS2C END

for k, v in pairs(C2GS_DEFINES) do
    for k2, v2 in pairs(v) do
        assert(not C2GS[v2], string.format("netdefines C2GS error %s %s %s", k, k2, v2))
        assert(not C2GS_BY_NAME[k2], string.format("netdefines C2GS_BY_NAME error %s %s %s", k, k2, v2))
        C2GS[v2] = {k, k2}
        C2GS_BY_NAME[k2] = v2
    end
end

for k, v in pairs(GS2C_DEFINES) do
    for k2, v2 in pairs(v) do
        assert(not GS2C[v2], string.format("netdefines GS2C error %s %s %s", k, k2, v2))
        assert(not GS2C_BY_NAME[k2], string.format("netdefines GS2C_BY_NAME error %s %s %s", k, k2, v2))
        GS2C[v2] = {k, k2}
        GS2C_BY_NAME[k2] = v2
    end
end

return M