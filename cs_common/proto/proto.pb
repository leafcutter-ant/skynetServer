
�
base/scene.protobase"e
PosInfo	
v (
x (
y (
z (
face_x (
face_y (
face_z ("^
	PlayerAoi#
block (2.base.PlayerAoiBlock
pos_info (2
pid (
PlayerAoiBlock
mask (
X
base/role.protobase"

SimpleRole
pid (
Role
account (	
pid (
�
base/war.protobase"-
PlayerWarriorStatus

hp (

mp (

wid (
pos (
status (2.base.PlayerWarriorStatus"D
WarCamp
camp_id (
player_list (2.base.PlayerWarrior
h
client/login.proto"#
C2GSLoginAccount
account (	"-

account (	
pid (
?
client/other.proto"

	C2GSGMCmd
cmd (	
u
client/scene.protobase/scene.proto"M
C2GSSyncPos
scene_id (
eid (
pos_info (2
�
client/war.proto"\
C2GSWarSkill
war_id (
action_wlist (
select_wlist (
skill_id (
C2GSWarNormalAttack
war_id (

action_wid (

select_wid (
C2GSWarProtect
war_id (

action_wid (

select_wid (

war_id (

action_wid (
�
server/login.protobase/role.proto"
	GS2CHello
time (
GS2CLoginError
pid (
errcode (
GS2CLoginAccount
account (	#
	role_list (2.base.SimpleRole")

role (2
.base.Role
3
server/other.proto"

time (
�
server/scene.protobase/scene.proto"1

scene_id (
map_id (
GS2CEnterScene
scene_id (
eid (
pos_info (2
GS2CEnterAoi
scene_id (
eid (
type (

aoi_player (2.base.PlayerAoi"-
GS2CLeaveAoi
scene_id (
eid (
GS2CSyncAoi
scene_id (
eid (
block_player (2.base.PlayerAoiBlock"M
GS2CSyncPos
scene_id (
eid (
pos_info (2
�	
server/war.protobase/war.proto"@
GS2CWarStart
war_id (
	camp_list (2

GS2CWarEnd
war_id (
GS2CWarBoutStart
war_id (
bout_id (
GS2CWarBoutEnd
war_id (
bout_id (
GS2CWarAddWarrior
war_id (
type (
warrior (2.base.PlayerWarrior"K
GS2CWarSkillStart
war_id (
action_wlist (
skill_id (
GS2CWarSkillEnd
war_id (
action_wlist (
skill_id (
GS2CWarNormalAttackStart
war_id (

action_wid (

select_wid (
GS2CWarNormalAttackEnd
war_id (

action_wid (
GS2CWarMagicStart
war_id (
action_wlist (
select_wlist (
magic_id (
GS2CWarMagicEnd
war_id (
action_wlist (
magic_id (
GS2CWarProtectStart
war_id (

action_wid (

select_wid (
GS2CWarProtectEnd
war_id (

action_wid (
GS2CWarEscapeStart
war_id (

action_wid (
GS2CWarEscapeEnd
war_id (

action_wid (

war_id (
wid (
type (
damage ("l
GS2CWarWarriorStatus
war_id (
wid (
type (
status (2.base.PlayerWarriorStatus