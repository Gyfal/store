script_name("BHP")

script_author("IZD4TXXX")
script_description("OF THE BEST")
script_version("BURN")
script_version_number(17)
require "lib.moonloader"
local dlstatus = require('moonloader').download_status
--local update_ini_url = 'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=12mceg8g3f2WFeS2Lgx7Np9AVn2bllY9g'
local updating = false
local download_id = nil
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
local encoding = require 'encoding'
encoding.default = 'CP866'
u8 = encoding.UTF8
local main_window = imgui.ImBool(false)
local elements = {
	checkboxes = {
		aupd = imgui.ImBool(false),
		aim = imgui.ImBool(false),
		auto = imgui.ImBool(false),
		trigger = imgui.ImBool(false),
		reverse = imgui.ImBool(false),
		skipOut = imgui.ImBool(false),
		skipFar = imgui.ImBool(false),
		skipNPCs = imgui.ImBool(false),
		skipDead = imgui.ImBool(false),
		skipPaused = imgui.ImBool(false),
		checkBuildings = imgui.ImBool(false),
		checkVehicles = imgui.ImBool(false),
		checkActors = imgui.ImBool(false),
		checkObjects = imgui.ImBool(false),
		checkParticles = imgui.ImBool(false),
		trigger_checkSolid = imgui.ImBool(false),
		trigger_car = imgui.ImBool(false),
		trigger_ped = imgui.ImBool(false),
		trigger_object = imgui.ImBool(false),
		trigger_particle = imgui.ImBool(false),
		trigger_seeThrough = imgui.ImBool(false),
		trigger_ignoreSomeObjects = imgui.ImBool(false),
		trigger_shotThrough  = imgui.ImBool(false),
		checkProtected = imgui.ImBool(false),
		checkDrive = imgui.ImBool(false),
		checkClist = imgui.ImBool(false),
		checkSkin = imgui.ImBool(false),
		checkStun = imgui.ImBool(false),
		findbone = imgui.ImBool(false),
		findbone_inversion = imgui.ImBool(false),
		findcolor = imgui.ImBool(false),
		findcolor_inversion = imgui.ImBool(false),
		findmodel = imgui.ImBool(false),
		findmodel_inversion = imgui.ImBool(false),
		findweapon = imgui.ImBool(false),
		findweapon_inversion = imgui.ImBool(false),
		fieldofvisible = imgui.ImBool(false),
		fieldofvisible_visible = imgui.ImBool(false),
	},
	sliders = {
		time = imgui.ImInt(1),
		radius = imgui.ImFloat(0.0),
		trigger_radius = imgui.ImFloat(0.0),
		fieldofvisible_border_red = imgui.ImInt(0),
		fieldofvisible_border_green = imgui.ImInt(0),
		fieldofvisible_border_blue = imgui.ImInt(0),
		fieldofvisible_border_alpha = imgui.ImInt(0),
		fieldofvisible_bcolor_red = imgui.ImInt(0),
		fieldofvisible_bcolor_green = imgui.ImInt(0),
		fieldofvisible_bcolor_blue = imgui.ImInt(0),
		fieldofvisible_bcolor_alpha = imgui.ImInt(0),
		fieldofvisible_radians = imgui.ImFloat(0.0),
	},
	buffers = {
		bone_id = imgui.ImBuffer(16),
		color_id = imgui.ImBuffer(16),
		model_id = imgui.ImBuffer(16),
		weapon_id = imgui.ImBuffer(16),
	}
}
local config = inicfg.load({
settings =
{
	aupd = elements.checkboxes.aupd.v,
	aim = elements.checkboxes.aim.v,
	auto = elements.checkboxes.auto.v,
	time = elements.sliders.time.v,
	radius = elements.sliders.radius.v,
	trigger = elements.checkboxes.trigger.v,
	reverse = elements.checkboxes.reverse.v,
	skipOut = elements.checkboxes.skipOut.v,
	skipFar = elements.checkboxes.skipFar.v,
	skipNPCs = elements.checkboxes.skipNPCs.v,
	skipDead = elements.checkboxes.skipDead.v,
	skipPaused = elements.checkboxes.skipPaused.v,
	checkBuildings = elements.checkboxes.checkBuildings.v,
	checkVehicles = elements.checkboxes.checkVehicles.v,
	checkActors = elements.checkboxes.checkActors.v,
	checkObjects = elements.checkboxes.checkObjects.v,
	checkParticles = elements.checkboxes.checkParticles.v,
	trigger_checkSolid = elements.checkboxes.trigger_checkSolid.v,
	trigger_car = elements.checkboxes.trigger_car.v,
	trigger_ped = elements.checkboxes.trigger_ped.v,
	trigger_object = elements.checkboxes.trigger_object.v,
	trigger_particle = elements.checkboxes.trigger_particle.v,
	trigger_seeThrough = elements.checkboxes.trigger_seeThrough.v,
	trigger_ignoreSomeObjects = elements.checkboxes.trigger_ignoreSomeObjects.v,
	trigger_shotThrough = elements.checkboxes.trigger_shotThrough.v,
	checkProtected = elements.checkboxes.checkProtected.v,
	checkDrive = elements.checkboxes.checkDrive.v,
	checkClist = elements.checkboxes.checkClist.v,
	checkSkin = elements.checkboxes.checkSkin.v,
	checkStun = elements.checkboxes.checkStun.v,
	findbone = elements.checkboxes.findbone.v,
	findcolor = elements.checkboxes.findcolor.v,
	findmodel = elements.checkboxes.findmodel.v,
	findweapon = elements.checkboxes.findweapon.v,
	findbone_inversion = elements.checkboxes.findbone_inversion.v,
	findcolor_inversion = elements.checkboxes.findcolor_inversion.v,
	findmodel_inversion = elements.checkboxes.findmodel_inversion.v,
	findweapon_inversion = elements.checkboxes.findweapon_inversion.v,
	fieldofvisible = elements.checkboxes.fieldofvisible.v,
	trigger_radius = elements.sliders.trigger_radius.v,
	fieldofvisible_visible = elements.checkboxes.fieldofvisible_visible.v,
	fieldofvisible_border_red = elements.sliders.fieldofvisible_border_red.v,
	fieldofvisible_border_green = elements.sliders.fieldofvisible_border_green.v,
	fieldofvisible_border_blue = elements.sliders.fieldofvisible_border_blue.v,
	fieldofvisible_border_alpha = elements.sliders.fieldofvisible_border_alpha.v,
	fieldofvisible_bcolor_red = elements.sliders.fieldofvisible_bcolor_red.v,
	fieldofvisible_bcolor_green = elements.sliders.fieldofvisible_bcolor_green.v,
	fieldofvisible_bcolor_blue = elements.sliders.fieldofvisible_bcolor_blue.v,
	fieldofvisible_bcolor_alpha = elements.sliders.fieldofvisible_bcolor_alpha.v,
	fieldofvisible_radians = elements.sliders.fieldofvisible_radians.v
}
})
local file_bones = getWorkingDirectory()..'/config/'..script.this.filename..'.bones.txt'
local file_colors = getWorkingDirectory()..'/config/'..script.this.filename..'.colors.txt'
local file_models = getWorkingDirectory()..'/config/'..script.this.filename..'.models.txt'
local file_weapons = getWorkingDirectory()..'/config/'..script.this.filename..'.weapons.txt'
local file_bones_list
local file_colors_list
local file_models_list
local file_weapons_list
local anims = {'DAM_armL_frmBK', 'DAM_armL_frmFT', 'DAM_armL_frmLT', 'DAM_armR_frmBK', 'DAM_armR_frmFT', 'DAM_armR_frmRT', 'DAM_LegL_frmBK', 'DAM_LegL_frmFT', 'DAM_LegL_frmLT', 'DAM_LegR_frmBK', 'DAM_LegR_frmFT', 'DAM_LegR_frmRT', 'DAM_stomach_frmBK', 'DAM_stomach_frmFT', 'DAM_stomach_frmLT', 'DAM_stomach_frmRT'}
local ffi = require "ffi"
local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
local pedBodyParts = {BONE_PELVIS1={x=0.0,y=0.0,z=0.0,i=1},BONE_PELVIS={x=0.0,y=0.0,z=0.0,i=2},BONE_SPINE1={x=0.0,y=0.0,z=0.0,i=3},BONE_UPPERTORSO={x=0.0,y=0.0,z=0.0,i=4},BONE_NECK={x=0.0,y=0.0,z=0.0,i=5},BONE_HEAD2={x=0.0,y=0.0,z=0.0,i=6},BONE_HEAD1={x=0.0,y=0.0,z=0.0,i=7},BONE_HEAD={x=0.0,y=0.0,z=0.0,i=8},BONE_RIGHTUPPERTORSO={x=0.0,y=0.0,z=0.0,i=21},BONE_RIGHTSHOULDER={x=0.0,y=0.0,z=0.0,i=22},BONE_RIGHTELBOW={x=0.0,y=0.0,z=0.0,i=23},BONE_RIGHTWRIST={x=0.0,y=0.0,z=0.0,i=24},BONE_RIGHTHAND={x=0.0,y=0.0,z=0.0,i=25},BONE_RIGHTTHUMB={x=0.0,y=0.0,z=0.0,i=26},BONE_LEFTUPPERTORSO={x=0.0,y=0.0,z=0.0,i=31},BONE_LEFTSHOULDER={x=0.0,y=0.0,z=0.0,i=32},BONE_LEFTELBOW={x=0.0,y=0.0,z=0.0,i=33},BONE_LEFTWRIST={x=0.0,y=0.0,z=0.0,i=34},BONE_LEFTHAND={x=0.0,y=0.0,z=0.0,i=35},BONE_LEFTTHUMB={x=0.0,y=0.0,z=0.0,i=36},BONE_LEFTHIP={x=0.0,y=0.0,z=0.0,i=41},BONE_LEFTKNEE={x=0.0,y=0.0,z=0.0,i=42},BONE_LEFTANKLE={x=0.0,y=0.0,z=0.0,i=43},BONE_LEFTFOOT={x=0.0,y=0.0,z=0.0,i=44},BONE_RIGHTHIP={x=0.0,y=0.0,z=0.0,i=51},BONE_RIGHTKNEE={x=0.0,y=0.0,z=0.0,i=52},BONE_RIGHTANKLE={x=0.0,y=0.0,z=0.0,i=53},BONE_RIGHTFOOT={x=0.0,y=0.0,z=0.0,i=54}}
function imgui.OnDrawFrame()
	if main_window.v then
		imgui.SetNextWindowSize(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver)
		imgui.Begin(script.this.name..' '..script.this.version_num..' '..script.this.version..' '..'BY'..' '..script.this.authors[1], main_window)
		if imgui.Checkbox(u8'Autoupdating', elements.checkboxes.aupd) then
			config.settings.aupd = elements.checkboxes.aupd.v
			save_ini()
		end
		PaintTrigger()
		PaintAim()
		imgui.End()
	end
end
function switch()
	while true do
		wait(0)
		if isKeyJustPressed(VK_HOME) and not sampIsChatInputActive() then
			main_window.v = not main_window.v
		end
	end
end
function argbToHex(argb)
	local hexadecimal = '0X'
	for key, value in pairs(argb) do
		local hex = ''
		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex
		end
		if(string.len(hex) == 0)then
			hex = '00'
		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end
	return hexadecimal
end
function trigger()
	while true do
		wait(0)
		if elements.checkboxes.trigger.v then
			if isKeyDown(VK_RBUTTON) then
				local cam_x, cam_y, cam_z = getActiveCameraCoordinates()
				local width_crosshair, heigth_crosshair = convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
				local aim_x, aim_y, aim_z = convertScreenCoordsToWorld3D(width_crosshair, heigth_crosshair, elements.sliders.trigger_radius.v)
				local result, colPoint = processLineOfSight(cam_x, cam_y, cam_z, aim_x, aim_y, aim_z, elements.checkboxes.trigger_checkSolid.v, elements.checkboxes.trigger_car.v, elements.checkboxes.trigger_ped.v, elements.checkboxes.trigger_object.v, elements.checkboxes.trigger_particle.v, elements.checkboxes.trigger_seeThrough.v, elements.checkboxes.trigger_ignoreSomeObjects.v, elements.checkboxes.trigger_shotThrough.v)
				if result then
					if isLineOfSightClear(cam_x, cam_y, cam_z, colPoint.pos[1], colPoint.pos[2], colPoint.pos[3], not elements.checkboxes.trigger_checkSolid.v, not elements.checkboxes.trigger_car.v, not elements.checkboxes.trigger_ped.v, not elements.checkboxes.trigger_object.v, not elements.checkboxes.trigger_particle.v) then
						local continue = true
						if colPoint.entityType == 2 then
							if isCharInCar(playerPed, getVehiclePointerHandle(colPoint.entity)) then
								continue = false
							end
						elseif colPoint.entityType == 3 then
							if playerPed == getCharPointerHandle(colPoint.entity) then
								continue = false
							end
						end
						if continue then
							writeMemory(0xB7347A, 4, 255, 0)
						end
					end
				end
			end
		end
	end
end
function paint()
	while true do
		wait(0)
		if elements.checkboxes.aim.v then
			if elements.checkboxes.fieldofvisible.v then
				if elements.checkboxes.fieldofvisible_visible.v then
					local width, heigth = getScreenResolution()
					local fov = getCameraFov() * 0.0174533
					local coeficent = width / fov
					local distance =  elements.sliders.fieldofvisible_radians.v * coeficent
					local width_crosshair, heigth_crosshair = convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
					local border_color_table = {elements.sliders.fieldofvisible_border_alpha.v, elements.sliders.fieldofvisible_border_red.v, elements.sliders.fieldofvisible_border_green.v, elements.sliders.fieldofvisible_border_blue.v}
					local border_color = argbToHex(border_color_table)
					local color_table = {elements.sliders.fieldofvisible_bcolor_alpha.v, elements.sliders.fieldofvisible_bcolor_red.v, elements.sliders.fieldofvisible_bcolor_green.v, elements.sliders.fieldofvisible_bcolor_blue.v}
					local color = argbToHex(color_table)
					renderDrawBoxWithBorder(width_crosshair-(distance/2), heigth_crosshair-(distance/2), distance, distance, color, 1, border_color)
				end
			end
		end
	end
end
function gui()
	while true do
		wait(0)
		imgui.Process = main_window.v
	end
end
function main()
	repeat
		wait(0)
	until isSampAvailable()
	load_ini()
	if elements.checkboxes.aupd.v then
		download_ini()
	end
	context()
	lua_thread.create(trigger)
	lua_thread.create(paint)
	lua_thread.create(gui)
	lua_thread.create(switch)
	while true do
		wait(elements.sliders.time.v)
		if elements.checkboxes.findbone.v then
			file_bones_list = lines_from(file_bones)
		end
		if elements.checkboxes.findcolor.v then
			file_colors_list = lines_from(file_colors)
		end
		if elements.checkboxes.findmodel.v then
			file_models_list = lines_from(file_models)
		end
		if elements.checkboxes.findweapon.v then
			file_weapons_list = lines_from(file_weapons)
		end
		if elements.checkboxes.aim.v then
			if (not elements.checkboxes.auto.v and isKeyDown(VK_LBUTTON)) or (elements.checkboxes.auto.v and isKeyDown(VK_RBUTTON)) then
				if isPlayerPlaying(playerHandle) then
					if (not elements.checkboxes.checkDrive.v) or (elements.checkboxes.checkDrive.v and (not isCharInAnyCar(playerPed))) then
						if (not elements.checkboxes.checkStun.v) or (elements.checkboxes.checkStun.v and CheckStuned()) then
							local cam_x, cam_y, cam_z = getActiveCameraCoordinates()
							local found, ped = findAllRandomCharsInSphere(cam_x, cam_y, cam_z, elements.sliders.radius.v, false, elements.checkboxes.skipDead.v)
							if found then
								local aim_distance_m = 0.0
								local ped_protection = 0
								local ped_protection_minimal = 0
								local yaw_distance = 0.0
								local yaw_distance_minimal = 0.0
								local yaw_distance_minimal_gen = 0.0
								local pitch_distance = 0.0
								local pitch_distance_minimal = 0.0
								local pitch_distance_minimal_gen = 0.0
								local src_pitch = fix(representIntAsFloat(readMemory(0xB6F248, 4, false)))
								local src_yaw = fix(representIntAsFloat(readMemory(0xB6F258, 4, false)))
								local src_pitch_module = math.abs(src_pitch)
								local src_yaw_module = math.abs(src_yaw)
								local coefficent_pitch = 0.0
								local coefficent_yaw = 0.0
								local ped_weapon = getCurrentCharWeapon(playerPed)
								if (not elements.checkboxes.findweapon.v) or (elements.checkboxes.findweapon.v and (elements.checkboxes.findweapon_inversion.v == (lines_find(file_weapons_list, ped_weapon)))) then
									if (ped_weapon >= 22 and ped_weapon <= 29) or ped_weapon == 32 then
										coefficent_pitch = -0.0778
										coefficent_yaw = 0.04253
									elseif ped_weapon == 30 or ped_weapon == 31 then
										coefficent_pitch = -0.052
										coefficent_yaw = 0.028
									elseif ped_weapon == 33 then
										coefficent_pitch = -0.0357
										coefficent_yaw = 0.01897
									end
									repeat
										local bool_npc = false
										local bool_afk = false
										local ped_protection_minimal_bool = false
										if ((not elements.checkboxes.checkSkin.v) or (elements.checkboxes.checkSkin.v and not (getCharModel(ped) == getCharModel(playerPed)))) and ((not elements.checkboxes.findmodel.v) or (elements.checkboxes.findmodel.v and (elements.checkboxes.findmodel_inversion.v == (lines_find(file_models_list, getCharModel(ped)))))) then
											if elements.checkboxes.checkProtected.v then
												ped_protection = sampGetPlayerHealth(select(2, sampGetPlayerIdByCharHandle(ped))) + sampGetPlayerArmor(select(2, sampGetPlayerIdByCharHandle(ped)))
												if (ped_protection_minimal == 0) or (ped_protection <= ped_protection_minimal)  then
													ped_protection_minimal_bool = true
												end
											end
											if (not elements.checkboxes.checkProtected.v) or (elements.checkboxes.checkProtected.v and (ped_protection_minimal_bool)) then
												if ((not elements.checkboxes.checkClist.v) or (elements.checkboxes.checkClist.v and not (sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(ped))) == sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(playerPed)))))) and ((not elements.checkboxes.findcolor.v) or (elements.checkboxes.findcolor.v and (elements.checkboxes.findcolor_inversion.v == (lines_find(file_colors_list, sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(ped)))))))) then
													if elements.checkboxes.skipNPCs.v then
														local bool_pid, pid = sampGetPlayerIdByCharHandle(ped)
														if bool_pid then
															if sampIsPlayerNpc(pid) then
																bool_npc = true
															end
														end
													end
													if elements.checkboxes.skipPaused.v then
														local bool_pid, pid = sampGetPlayerIdByCharHandle(ped)
														if bool_pid then
															if sampIsPlayerPaused(pid) then
																bool_afk = true
															end
														end
													end
													if ((elements.checkboxes.skipNPCs.v and not bool_npc) or not elements.checkboxes.skipNPCs.v) and ((elements.checkboxes.skipPaused.v and not bool_afk) or not elements.checkboxes.skipPaused.v) then
														for key,value in pairs(pedBodyParts) do
															if ((not elements.checkboxes.findbone.v) or (elements.checkboxes.findbone.v and (elements.checkboxes.findbone_inversion.v == (lines_find(file_bones_list, pedBodyParts[key].i))))) then
																pedBodyParts[key].x, pedBodyParts[key].y, pedBodyParts[key].z = getBodyPartCoordinates(pedBodyParts[key].i, ped)
																local aim_x = pedBodyParts[key].x
																local aim_y = pedBodyParts[key].y
																local aim_z = pedBodyParts[key].z
																if not elements.checkboxes.skipOut.v or (elements.checkboxes.skipOut.v and isPointOnScreen(aim_x, aim_y, aim_z, 0.0)) then
																	if isLineOfSightClear(cam_x, cam_y, cam_z, aim_x, aim_y, aim_z, elements.checkboxes.checkBuildings.v, elements.checkboxes.checkVehicles.v, elements.checkboxes.checkActors.v, elements.checkboxes.checkObjects.v, elements.checkboxes.checkParticles.v) then
																		local aim_distance_n = getDistanceBetweenCoords3d(cam_x, cam_y, cam_z, aim_x, aim_y, aim_z)
																		if (not elements.checkboxes.skipFar.v) or (elements.checkboxes.skipFar.v and ( (aim_distance_m == 0.0) or (aim_distance_m > aim_distance_n) )) then
																			aim_distance_m = aim_distance_n
																			local yaw = fix(math.rad(getHeadingFromVector2d(aim_x - cam_x, aim_y - cam_y)-90.0) + coefficent_yaw)
																			local pitch = fix(math.atan2(aim_z - cam_z, math.sqrt( math.pow(aim_x - cam_x, 2) + math.pow(aim_y - cam_y, 2))) + coefficent_pitch)
																			local yaw_module = math.abs(yaw)
																			local pitch_module = math.abs(pitch)
																			local yaw_distance_module = 0.0
																			local pitch_distance_module = 0.0
																			--distantion define
																			if ((src_yaw > 0.0) and (yaw < 0.0)) or ((yaw > 0.0) and (src_yaw < 0.0)) then
																				yaw_distance_module = src_yaw_module + yaw_module
																			else
																				if (src_yaw_module > yaw_module) then
																					yaw_distance_module = src_yaw_module - yaw_module
																				elseif (yaw_module > src_yaw_module) then
																					yaw_distance_module = yaw_module - src_yaw_module
																				end
																			end
																			if ((src_pitch > 0.0) and (pitch < 0.0)) or ((pitch > 0.0) and (src_pitch < 0.0)) then
																				pitch_distance_module = src_pitch_module + pitch_module
																			else
																				if (src_pitch_module > pitch_module) then
																					pitch_distance_module = src_pitch_module - pitch_module
																				elseif (pitch_module > src_pitch_module) then
																					pitch_distance_module = pitch_module - src_pitch_module
																				end
																			end
																			--defined
																			--aiming start
																			if not (yaw_distance_module == 0.0) then
																				--begin
																				if src_yaw > yaw then
																					if (yaw_distance_module > math.pi) then	--exception
																						yaw_distance_module = (math.pi*2 - yaw_distance_module)
																						yaw_distance = yaw_distance_module / elements.sliders.time.v
																					else
																						yaw_distance = - yaw_distance_module / elements.sliders.time.v
																					end
																				else
																					if (yaw_distance_module > math.pi) then	--exception
																						yaw_distance_module = (math.pi*2 - yaw_distance_module)
																						yaw_distance = - yaw_distance_module / elements.sliders.time.v
																					else
																						yaw_distance = yaw_distance_module / elements.sliders.time.v
																					end
																				end
																				--end
																			end
																			if not (pitch_distance_module == 0.0) then
																				--begin
																				if src_pitch > pitch then
																					if (pitch_distance_module > math.pi) then	--exception
																						pitch_distance_module = (math.pi*2 - pitch_distance_module)
																						pitch_distance = pitch_distance_module / elements.sliders.time.v
																					else
																						pitch_distance = - pitch_distance_module / elements.sliders.time.v
																					end
																				else
																					if (pitch_distance_module > math.pi) then	--exception
																						pitch_distance_module = (math.pi*2 - pitch_distance_module)
																						pitch_distance = - pitch_distance_module / elements.sliders.time.v
																					else
																						pitch_distance = pitch_distance_module / elements.sliders.time.v
																					end
																				end
																				--end
																			end
																			--aiming stop
																			if not elements.checkboxes.fieldofvisible.v or (elements.checkboxes.fieldofvisible.v and (yaw_distance_module < elements.sliders.fieldofvisible_radians.v) and (pitch_distance_module < elements.sliders.fieldofvisible_radians.v)) then
																				if elements.checkboxes.reverse.v then
																					if yaw_distance > 0.0 then
																						yaw_distance = (yaw_distance_module - yaw_distance)
																					else
																						yaw_distance = - (yaw_distance_module + yaw_distance)
																					end
																					if pitch_distance > 0.0 then
																						pitch_distance = (pitch_distance_module - pitch_distance)
																					else
																						pitch_distance = - (pitch_distance_module + pitch_distance)
																					end
																				end
																				if yaw_distance_minimal == 0.0 or pitch_distance_minimal == 0.0 or math.abs(yaw_distance) < math.abs(yaw_distance_minimal) or math.abs(pitch_distance) < math.abs(pitch_distance_minimal) then
																					yaw_distance_minimal = yaw_distance
																					pitch_distance_minimal = pitch_distance
																				end
																			end
																		end
																	end
																end
															end
														end
														if yaw_distance_minimal_gen == 0.0 or pitch_distance_minimal_gen == 0.0 or math.abs(yaw_distance_minimal) < math.abs(yaw_distance_minimal_gen) or math.abs(pitch_distance_minimal) < math.abs(pitch_distance_minimal_gen) then
															if elements.checkboxes.checkProtected.v then
																ped_protection_minimal = ped_protection
															end
															yaw_distance_minimal_gen = yaw_distance_minimal
															pitch_distance_minimal_gen = pitch_distance_minimal
														end
													end
												end
											end
										end
										found, ped = findAllRandomCharsInSphere(cam_x, cam_y, cam_z, elements.sliders.radius.v, true, elements.checkboxes.skipDead.v)
									until not found
									setCameraPositionUnfixed(src_pitch + pitch_distance_minimal_gen, src_yaw + yaw_distance_minimal_gen)
								end
							end
						end
					end
				end
			end
		end
	end
end
function CheckStuned()
	for k, v in pairs(anims) do
		if isCharPlayingAnim(playerPed, v) then
			return false
		end
	end
	return true
end
function fix(angle)
	while angle > math.pi do
		angle = angle - (math.pi*2)
	end
	while angle < -math.pi do
		angle = angle + (math.pi*2)
	end
	return angle
end
function context()
	imgui.SwitchContext()
	colors[clr.Text] = 										ImVec4(0.80, 0.80, 0.83, 1.00)
  colors[clr.TextDisabled] = 						ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.WindowBg] = 								ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ChildWindowBg] = 					ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.PopupBg] = 								ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.Border] = 									ImVec4(0.80, 0.80, 0.83, 0.88)
  colors[clr.BorderShadow] = 						ImVec4(0.92, 0.91, 0.88, 0.00)
  colors[clr.FrameBg] = 								ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.FrameBgHovered] = 					ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.FrameBgActive] = 					ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.TitleBg] = 								ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.TitleBgCollapsed] = 				ImVec4(1.00, 0.98, 0.95, 0.75)
  colors[clr.TitleBgActive] = 					ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.MenuBarBg] = 							ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarBg] = 						ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarGrab] = 					ImVec4(1.00, 0.30, 0.00, 0.30)
  colors[clr.ScrollbarGrabHovered] = 		ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.ScrollbarGrabActive] = 		ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.ComboBg] = 								ImVec4(0.19, 0.18, 0.21, 1.00)
  colors[clr.CheckMark] = 							ImVec4(0.80, 0.80, 0.83, 0.61)
	colors[clr.SliderGrab] = 							ImVec4(0.80, 0.80, 0.83, 0.61)
  colors[clr.SliderGrabActive] = 				ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.Button] = 									ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ButtonHovered] = 					ImVec4(1.00, 0.36, 0.00, 1.00)
  colors[clr.ButtonActive] = 						ImVec4(1.00, 0.30, 0.00, 1.00)
  colors[clr.Header] = 									ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.HeaderHovered] = 					ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.HeaderActive] = 						ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ResizeGrip] = 							ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.ResizeGripHovered] = 			ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.ResizeGripActive] =			 	ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.CloseButton] = 						ImVec4(0.40, 0.39, 0.38, 0.16)
  colors[clr.CloseButtonHovered] = 			ImVec4(0.40, 0.39, 0.38, 0.39)
  colors[clr.CloseButtonActive] = 			ImVec4(0.40, 0.39, 0.38, 1.00)
  colors[clr.PlotLines] = 							ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotLinesHovered] = 				ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.PlotHistogram] = 					ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotHistogramHovered] = 		ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.TextSelectedBg] = 					ImVec4(0.25, 1.00, 0.00, 0.43)
  colors[clr.ModalWindowDarkening] = 		ImVec4(1.00, 0.98, 0.95, 0.73)
end
function save_ini()
	inicfg.save(config, script.this.filename..'.ini')
end
function load_ini()
	local ini_file = inicfg.load(config, script.this.filename..'.ini')
	if ini_file then
		elements.checkboxes.aim.v = ini_file.settings.aim
		elements.checkboxes.auto.v = ini_file.settings.auto
		elements.checkboxes.aupd.v = ini_file.settings.aupd
		elements.sliders.time.v = ini_file.settings.time
		elements.sliders.radius.v = ini_file.settings.radius
		elements.checkboxes.trigger.v = ini_file.settings.trigger
		elements.checkboxes.reverse.v = ini_file.settings.reverse
		elements.checkboxes.skipOut.v = ini_file.settings.skipOut
		elements.checkboxes.skipFar.v = ini_file.settings.skipFar
		elements.checkboxes.skipNPCs.v = ini_file.settings.skipNPCs
		elements.checkboxes.skipDead.v = ini_file.settings.skipDead
		elements.checkboxes.skipPaused.v = ini_file.settings.skipPaused
		elements.checkboxes.checkBuildings.v = ini_file.settings.checkBuildings
		elements.checkboxes.checkVehicles.v = ini_file.settings.checkVehicles
		elements.checkboxes.checkActors.v = ini_file.settings.checkActors
		elements.checkboxes.checkObjects.v = ini_file.settings.checkObjects
		elements.checkboxes.checkParticles.v = ini_file.settings.checkParticles
		elements.checkboxes.trigger_checkSolid.v = ini_file.settings.trigger_checkSolid
		elements.checkboxes.trigger_car.v = ini_file.settings.trigger_car
		elements.checkboxes.trigger_ped.v = ini_file.settings.trigger_ped
		elements.checkboxes.trigger_object.v = ini_file.settings.trigger_object
		elements.checkboxes.trigger_particle.v = ini_file.settings.trigger_particle
		elements.checkboxes.trigger_seeThrough.v = ini_file.settings.trigger_seeThrough
		elements.checkboxes.trigger_ignoreSomeObjects.v = ini_file.settings.trigger_ignoreSomeObjects
		elements.checkboxes.trigger_shotThrough.v = ini_file.settings.trigger_shotThrough
		elements.checkboxes.checkProtected.v = ini_file.settings.checkProtected
		elements.checkboxes.checkDrive.v = ini_file.settings.checkDrive
		elements.checkboxes.checkClist.v = ini_file.settings.checkClist
		elements.checkboxes.checkSkin.v = ini_file.settings.checkSkin
		elements.checkboxes.checkStun.v = ini_file.settings.checkStun
		elements.checkboxes.findbone.v = ini_file.settings.findbone
		elements.checkboxes.findcolor.v = ini_file.settings.findcolor
		elements.checkboxes.findmodel.v = ini_file.settings.findmodel
		elements.checkboxes.findweapon.v = ini_file.settings.findweapon
		elements.checkboxes.findbone_inversion.v = ini_file.settings.findbone_inversion
		elements.checkboxes.findcolor_inversion.v = ini_file.settings.findcolor_inversion
		elements.checkboxes.findmodel_inversion.v = ini_file.settings.findmodel_inversion
		elements.checkboxes.findweapon_inversion.v = ini_file.settings.findweapon_inversion
		elements.checkboxes.fieldofvisible.v = ini_file.settings.fieldofvisible
		elements.sliders.trigger_radius.v = ini_file.settings.trigger_radius
		elements.checkboxes.fieldofvisible_visible.v = ini_file.settings.fieldofvisible_visible
		elements.sliders.fieldofvisible_border_red.v = ini_file.settings.fieldofvisible_border_red
		elements.sliders.fieldofvisible_border_green.v = ini_file.settings.fieldofvisible_border_green
		elements.sliders.fieldofvisible_border_blue.v = ini_file.settings.fieldofvisible_border_blue
		elements.sliders.fieldofvisible_border_alpha.v = ini_file.settings.fieldofvisible_border_alpha
		elements.sliders.fieldofvisible_bcolor_red.v = ini_file.settings.fieldofvisible_bcolor_red
		elements.sliders.fieldofvisible_bcolor_green.v = ini_file.settings.fieldofvisible_bcolor_green
		elements.sliders.fieldofvisible_bcolor_blue.v = ini_file.settings.fieldofvisible_bcolor_blue
		elements.sliders.fieldofvisible_bcolor_alpha.v = ini_file.settings.fieldofvisible_bcolor_alpha
		elements.sliders.fieldofvisible_radians.v = ini_file.settings.fieldofvisible_radians
	else
		config.settings.aupd = elements.checkboxes.aupd.v
		config.settings.aim = elements.checkboxes.aim.v
		config.settings.auto = elements.checkboxes.auto.v
		config.settings.time = elements.sliders.time.v
		config.settings.radius = elements.sliders.radius.v
		config.settings.trigger = elements.checkboxes.trigger.v
		config.settings.reverse = elements.checkboxes.reverse.v
		config.settings.skipOut = elements.checkboxes.skipOut.v
		config.settings.skipFar = elements.checkboxes.skipFar.v
		config.settings.skipNPCs = elements.checkboxes.skipNPCs.v
		config.settings.skipDead = elements.checkboxes.skipDead.v
		config.settings.skipPaused = elements.checkboxes.skipPaused.v
		config.settings.checkBuildings = elements.checkboxes.checkBuildings.v
		config.settings.checkVehicles = elements.checkboxes.checkVehicles.v
		config.settings.checkActors = elements.checkboxes.checkActors.v
		config.settings.checkObjects = elements.checkboxes.checkObjects.v
		config.settings.checkParticles = elements.checkboxes.checkParticles.v
		config.settings.trigger_checkSolid = elements.checkboxes.trigger_checkSolid.v
		config.settings.trigger_car = elements.checkboxes.trigger_car.v
		config.settings.trigger_ped = elements.checkboxes.trigger_ped.v
		config.settings.trigger_object = elements.checkboxes.trigger_object.v
		config.settings.trigger_particle = elements.checkboxes.trigger_particle.v
		config.settings.trigger_seeThrough = elements.checkboxes.trigger_seeThrough.v
		config.settings.trigger_ignoreSomeObjects = elements.checkboxes.trigger_ignoreSomeObjects.v
		config.settings.trigger_shotThrough = elements.checkboxes.trigger_shotThrough.v
		config.settings.checkProtected = elements.checkboxes.checkProtected.v
		config.settings.checkDrive = elements.checkboxes.checkDrive.v
		config.settings.checkClist = elements.checkboxes.checkClist.v
		config.settings.checkSkin = elements.checkboxes.checkSkin.v
		config.settings.checkStun = elements.checkboxes.checkStun.v
		config.settings.findbone = elements.checkboxes.findbone.v
		config.settings.findcolor = elements.checkboxes.findcolor.v
		config.settings.findmodel = elements.checkboxes.findmodel.v
		config.settings.findweapon = elements.checkboxes.findweapon.v
		config.settings.findbone_inversion = elements.checkboxes.findbone_inversion.v
		config.settings.findcolor_inversion = elements.checkboxes.findcolor_inversion.v
		config.settings.findmodel_inversion = elements.checkboxes.findmodel_inversion.v
		config.settings.findweapon_inversion = elements.checkboxes.findweapon_inversion.v
		config.settings.fieldofvisible = elements.checkboxes.fieldofvisible.v
		config.settings.trigger_radius = elements.sliders.trigger_radius.v
		config.settings.fieldofvisible_visible = elements.checkboxes.fieldofvisible_visible.v
		config.settings.fieldofvisible_border_red = elements.sliders.fieldofvisible_border_red.v
		config.settings.fieldofvisible_border_green = elements.sliders.fieldofvisible_border_green.v
		config.settings.fieldofvisible_border_blue = elements.sliders.fieldofvisible_border_blue.v
		config.settings.fieldofvisible_border_alpha = elements.sliders.fieldofvisible_border_alpha.v
		config.settings.fieldofvisible_bcolor_red = elements.sliders.fieldofvisible_bcolor_red.v
		config.settings.fieldofvisible_bcolor_green = elements.sliders.fieldofvisible_bcolor_green.v
		config.settings.fieldofvisible_bcolor_blue = elements.sliders.fieldofvisible_bcolor_blue.v
		config.settings.fieldofvisible_bcolor_alpha = elements.sliders.fieldofvisible_bcolor_alpha.v
		config.settings.fieldofvisible_radians = elements.sliders.fieldofvisible_radians.v
		save_ini()
	end
end
function download_ini()
	download_id = downloadUrlToFile(update_ini_url, getWorkingDirectory()..'/config/'..script.this.filename..'.upd.ini' , download_handler)
	repeat wait(0)
	until (download_id == nil)
	CheckUpdates()
end
function download_lua()
	download_id = downloadUrlToFile(script.this.url, getWorkingDirectory()..'/'..script.this.filename , download_handler)
	repeat wait(0)
	until (download_id == nil)
	thisScript():reload()
end
function CheckUpdates()
	local ini_file = inicfg.load(config, script.this.filename..'.upd.ini')
	if ini_file.script.version > script.this.version_num then
		download_lua()
	end
end
function download_handler(id, status, p1, p2)
  if status == dlstatus.STATUS_DOWNLOADINGDATA then
		--загрузка
  elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
		--завершено
		download_id = nil
  end
end
function file_create(file)
	local f = io.open( file, "w" )
	f:close()
end
function file_exists(file)
  local f = io.open(file, "r")
  if f then f:close() end
  return f ~= nil
end
function lines_from(file)
  if not file_exists(file) then
		file_create(file)
		return {}
	end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end
function lines_find(array, value)
	for k,v in pairs(array) do
		if (tonumber(v) == value) then
			return true
		end
  end
	return false
end
function line_add(file, value)
	local array = lines_from(file)
	array[#array + 1] = value
	rwa_lines(file, array)
end
function line_remove(file, value)
	local array = lines_from(file)
	put_lines(file, array, value)
end
function put_lines(file, array, value)
	local f = io.open(file, "w")
	for k,v in pairs(array) do
		if tonumber(v) then
			if tonumber(v) ~= value then
				f:write(v..'\n')
			end
		end
	end
	f:close()
end
function rwa_lines(file, array)
	local f = io.open(file, "w")
	for k,v in pairs(array) do
		if tonumber(v) then
			if (k == #array) or (k ~= #array and array[k] ~= array[#array]) then
				f:write(v..'\n')
			end
		end
	end
	f:close()
end
function getBodyPartCoordinates(id, handle)
  local pedptr = getCharPointer(handle)
  local vec = ffi.new("float[3]")
  getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
  return vec[0], vec[1], vec[2]
end
function PaintTrigger()
	if imgui.Checkbox(u8'Perfect trigger', elements.checkboxes.trigger) then
		config.settings.trigger = elements.checkboxes.trigger.v
		save_ini()
	end
	if elements.checkboxes.trigger.v then
		if imgui.Checkbox(u8'Check Solid', elements.checkboxes.trigger_checkSolid) then
			config.settings.trigger_checkSolid = elements.checkboxes.trigger_checkSolid.v
			save_ini()
		end
		if imgui.Checkbox(u8'Vehicles', elements.checkboxes.trigger_car) then
			config.settings.trigger_car = elements.checkboxes.trigger_car.v
			save_ini()
		end
		if imgui.Checkbox(u8'Actors', elements.checkboxes.trigger_ped) then
			config.settings.trigger_ped = elements.checkboxes.trigger_ped.v
			save_ini()
		end
		if imgui.Checkbox(u8'Objects', elements.checkboxes.trigger_object) then
			config.settings.trigger_object = elements.checkboxes.trigger_object.v
			save_ini()
		end
		if imgui.Checkbox(u8'Particles', elements.checkboxes.trigger_particle) then
			config.settings.trigger_particle = elements.checkboxes.trigger_particle.v
			save_ini()
		end
		if imgui.Checkbox(u8'See Through', elements.checkboxes.trigger_seeThrough) then
			config.settings.trigger_seeThrough = elements.checkboxes.trigger_seeThrough.v
			save_ini()
		end
		if imgui.Checkbox(u8'Ignore Some Objects', elements.checkboxes.trigger_ignoreSomeObjects) then
			config.settings.trigger_ignoreSomeObjects = elements.checkboxes.trigger_ignoreSomeObjects.v
			save_ini()
		end
		if imgui.Checkbox(u8'Shot Through', elements.checkboxes.trigger_shotThrough) then
			config.settings.trigger_shotThrough = elements.checkboxes.trigger_shotThrough.v
			save_ini()
		end
		if imgui.SliderFloat('Trigger working distance', elements.sliders.trigger_radius, 0.0000000, 3600.0000000) then
			config.settings.trigger_radius = elements.sliders.trigger_radius.v
			save_ini()
		end
	end
end
function PaintAim()
	if imgui.Checkbox(u8'Smooth aim', elements.checkboxes.aim) then
		config.settings.aim = elements.checkboxes.aim.v
		save_ini()
	end
	if elements.checkboxes.aim.v then
		if imgui.Checkbox(u8'Auto aiming', elements.checkboxes.auto) then
			config.settings.auto = elements.checkboxes.auto.v
			save_ini()
		end
		if imgui.Checkbox(u8'Reverse mod', elements.checkboxes.reverse) then
			config.settings.reverse = elements.checkboxes.reverse.v
			save_ini()
		end
		if imgui.Checkbox(u8'Only on screen', elements.checkboxes.skipOut) then
			config.settings.skipOut = elements.checkboxes.skipOut.v
			save_ini()
		end
		if imgui.Checkbox(u8'Nearest points', elements.checkboxes.skipFar) then
			config.settings.skipFar = elements.checkboxes.skipFar.v
			save_ini()
		end
		if imgui.Checkbox(u8'Skip NPC bots', elements.checkboxes.skipNPCs) then
			config.settings.skipNPCs = elements.checkboxes.skipNPCs.v
			save_ini()
		end
		if imgui.Checkbox(u8'Skip deads', elements.checkboxes.skipDead) then
			config.settings.skipDead = elements.checkboxes.skipDead.v
			save_ini()
		end
		if imgui.Checkbox(u8'Skip paused', elements.checkboxes.skipPaused) then
			config.settings.skipPaused = elements.checkboxes.skipPaused.v
			save_ini()
		end
		if imgui.Checkbox(u8'No buildings', elements.checkboxes.checkBuildings) then
			config.settings.checkBuildings = elements.checkboxes.checkBuildings.v
			save_ini()
		end
		if imgui.Checkbox(u8'No vehicles', elements.checkboxes.checkVehicles) then
			config.settings.checkVehicles = elements.checkboxes.checkVehicles.v
			save_ini()
		end
		if imgui.Checkbox(u8'No actors', elements.checkboxes.checkActors) then
			config.settings.checkActors = elements.checkboxes.checkActors.v
			save_ini()
		end
		if imgui.Checkbox(u8'No objects', elements.checkboxes.checkObjects) then
			config.settings.checkObjects = elements.checkboxes.checkObjects.v
			save_ini()
		end
		if imgui.Checkbox(u8'No particles', elements.checkboxes.checkParticles) then
			config.settings.checkParticles = elements.checkboxes.checkParticles.v
			save_ini()
		end
		if imgui.Checkbox(u8'Weakest player', elements.checkboxes.checkProtected) then
			config.settings.checkProtected = elements.checkboxes.checkProtected.v
			save_ini()
		end
		if imgui.Checkbox(u8'Out of driving', elements.checkboxes.checkDrive) then
			config.settings.checkDrive = elements.checkboxes.checkDrive.v
			save_ini()
		end
		if imgui.Checkbox(u8'After the stun', elements.checkboxes.checkStun) then
			config.settings.checkStun = elements.checkboxes.checkStun.v
			save_ini()
		end
		if imgui.Checkbox(u8'Compare colors', elements.checkboxes.checkClist) then
			config.settings.checkClist = elements.checkboxes.checkClist.v
			save_ini()
		end
		if imgui.Checkbox(u8'Compare models', elements.checkboxes.checkSkin) then
			config.settings.checkSkin = elements.checkboxes.checkSkin.v
			save_ini()
		end
		if imgui.Checkbox(u8'Field of visible', elements.checkboxes.fieldofvisible) then
			config.settings.fieldofvisible = elements.checkboxes.fieldofvisible.v
			save_ini()
		end
		if elements.checkboxes.fieldofvisible.v then
			if imgui.Checkbox(u8'Field of visible showing', elements.checkboxes.fieldofvisible_visible) then
				config.settings.fieldofvisible_visible = elements.checkboxes.fieldofvisible_visible.v
				save_ini()
			end
			if elements.checkboxes.fieldofvisible_visible.v then
				--BEGINNING
				if imgui.SliderInt('Red border color', elements.sliders.fieldofvisible_border_red, 0, 255) then
					config.settings.fieldofvisible_border_red = elements.sliders.fieldofvisible_border_red.v
					save_ini()
				end
				if imgui.SliderInt('Green border color', elements.sliders.fieldofvisible_border_green, 0, 255) then
					config.settings.fieldofvisible_border_green = elements.sliders.fieldofvisible_border_green.v
					save_ini()
				end
				if imgui.SliderInt('Blue border color', elements.sliders.fieldofvisible_border_blue, 0, 255) then
					config.settings.fieldofvisible_border_blue = elements.sliders.fieldofvisible_border_blue.v
					save_ini()
				end
				if imgui.SliderInt('Alpha border color', elements.sliders.fieldofvisible_border_alpha, 0, 255) then
					config.settings.fieldofvisible_border_alpha = elements.sliders.fieldofvisible_border_alpha.v
					save_ini()
				end
				if imgui.SliderInt('Red color', elements.sliders.fieldofvisible_bcolor_red, 0, 255) then
					config.settings.fieldofvisible_bcolor_red = elements.sliders.fieldofvisible_bcolor_red.v
					save_ini()
				end
				if imgui.SliderInt('Green color', elements.sliders.fieldofvisible_bcolor_green, 0, 255) then
					config.settings.fieldofvisible_bcolor_green = elements.sliders.fieldofvisible_bcolor_green.v
					save_ini()
				end
				if imgui.SliderInt('Blue color', elements.sliders.fieldofvisible_bcolor_blue, 0, 255) then
					config.settings.fieldofvisible_bcolor_blue = elements.sliders.fieldofvisible_bcolor_blue.v
					save_ini()
				end
				if imgui.SliderInt('Alpha color', elements.sliders.fieldofvisible_bcolor_alpha, 0, 255) then
					config.settings.fieldofvisible_bcolor_alpha = elements.sliders.fieldofvisible_bcolor_alpha.v
					save_ini()
				end
				--ENDING
			end
			if imgui.SliderFloat('Field of visible angle', elements.sliders.fieldofvisible_radians, 0.0, math.pi) then
				config.settings.fieldofvisible_radians = elements.sliders.fieldofvisible_radians.v
				save_ini()
			end
		end
		if imgui.Checkbox(u8'Check bones list', elements.checkboxes.findbone) then
			config.settings.findbone = elements.checkboxes.findbone.v
			save_ini()
		end
		if elements.checkboxes.findbone.v then
			if imgui.Checkbox(u8'Bones list inversion', elements.checkboxes.findbone_inversion) then
				config.settings.findbone_inversion = elements.checkboxes.findbone_inversion.v
				save_ini()
			end
			imgui.InputText(u8'Bone', elements.buffers.bone_id)
			if tonumber(elements.buffers.bone_id.v) then
				if lines_find(file_bones_list, tonumber(elements.buffers.bone_id.v)) then
					if imgui.Button('Remove bone') then
						line_remove(file_bones, tonumber(elements.buffers.bone_id.v))
					end
				else
					if imgui.Button('Add bone') then
						line_add(file_bones, tonumber(elements.buffers.bone_id.v))
					end
				end
			end
		end
		if imgui.Checkbox(u8'Check colors list', elements.checkboxes.findcolor) then
			config.settings.findcolor = elements.checkboxes.findcolor.v
			save_ini()
		end
		if elements.checkboxes.findcolor.v then
			if imgui.Checkbox(u8'Colors list inversion', elements.checkboxes.findcolor_inversion) then
				config.settings.findcolor_inversion = elements.checkboxes.findcolor_inversion.v
				save_ini()
			end
			imgui.InputText(u8'Color', elements.buffers.color_id)
			if tonumber(elements.buffers.color_id.v) then
				if lines_find(file_colors_list, tonumber(elements.buffers.color_id.v)) then
					if imgui.Button('Remove color') then
						line_remove(file_colors, tonumber(elements.buffers.color_id.v))
					end
				else
					if imgui.Button('Add color') then
						line_add(file_colors, tonumber(elements.buffers.color_id.v))
					end
				end
			end
		end
		if imgui.Checkbox(u8'Check models list', elements.checkboxes.findmodel) then
			config.settings.findmodel = elements.checkboxes.findmodel.v
			save_ini()
		end
		if elements.checkboxes.findmodel.v then
			if imgui.Checkbox(u8'Models list inversion', elements.checkboxes.findmodel_inversion) then
				config.settings.findmodel_inversion = elements.checkboxes.findmodel_inversion.v
				save_ini()
			end
			imgui.InputText(u8'Model', elements.buffers.model_id)
			if tonumber(elements.buffers.model_id.v) then
				if lines_find(file_models_list, tonumber(elements.buffers.model_id.v)) then
					if imgui.Button('Remove model') then
						line_remove(file_models, tonumber(elements.buffers.model_id.v))
					end
				else
					if imgui.Button('Add model') then
						line_add(file_models, tonumber(elements.buffers.model_id.v))
					end
				end
			end
		end
		if imgui.Checkbox('Check weapons list', elements.checkboxes.findweapon) then
			config.settings.findweapon = elements.checkboxes.findweapon.v
			save_ini()
		end
		if elements.checkboxes.findweapon.v then
			if imgui.Checkbox(u8'Weapons list inversion', elements.checkboxes.findweapon_inversion) then
				config.settings.findweapon_inversion = elements.checkboxes.findweapon_inversion.v
				save_ini()
			end
			imgui.InputText(u8'Weapon', elements.buffers.weapon_id)
			if tonumber(elements.buffers.weapon_id.v) then
				if lines_find(file_weapons_list, tonumber(elements.buffers.weapon_id.v)) then
					if imgui.Button('Remove weapon') then
						line_remove(file_weapons, tonumber(elements.buffers.weapon_id.v))
					end
				else
					if imgui.Button('Add weapon') then
						line_add(file_weapons, tonumber(elements.buffers.weapon_id.v))
					end
				end
			end
		end
		if imgui.SliderInt('Scale of smoothness', elements.sliders.time, 1, 50) then
			config.settings.time = elements.sliders.time.v
			save_ini()
		end
		if imgui.SliderFloat('Aim working distance', elements.sliders.radius, 0.0000000, 3600.0000000) then
			config.settings.radius = elements.sliders.radius.v
			save_ini()
		end
	end
end
