script_name("mod click warp 0.2")
script_authors("FYP", "we_sux team","Sambrero")

require"lib.moonloader"
require"lib.sampfuncs"
local sampev = require 'lib.samp.events'
local Vector3D = require "vector3d"

--- Config
keyToggle = VK_MBUTTON
keyApply = VK_LBUTTON


local org = {
   {-2029.9012,-116.3285,1035.1719}; -- АШ 
   {1171.3220,-1330.0962,4001.1001}; -- Болька
   {-1911.2126,-1686.6864,22.2730}; -- Шахта
   {2385.9270,1023.5077,10.8203}; -- СТО ЛВ
   {1150.7069,-1354.0807,3001.0845}; -- Болька
   {1424.5803,1056.5237,1058.7816}; -- smi
   {2621.3926,1294.0730,1051.7072}; -- мафии
   {1408.8944,-35.9216,1000.9170}; -- мэрия инта
   {2084.1331,2232.5151,1027.6945}; -- Мэрия инта
   {246.3628,74.8152,1003.6406}; -- lspd
   {-2063.3955,447.9360,2975.7600}; --мвд
   {246.0701,113.7878,1003.2188}; -- sfpd
   {1715.7902,936.4308,1029.9963}; -- fbi
   {253.9650,177.4646,1003.0234}; -- lvpd
   {1249.5895,-813.3230,1084.0078}; -- MZ
   {1801.7827,-1300.0222,33.1250,127}; -- TV
   {2450.0366,-1698.2258,1013.5078}; -- grovr
   {-42.5133,1408.9464,1084.4297}; -- balls
   {319.7732,1120.9149,1083.8828}; -- vagos
   {-68.8488,1356.1466,1080.2109}; -- rifa
   {219.6274,1243.4010,1082.1406}; -- aztec
   {1615.9365,887.1974,1025.2916}; -- MO
   {374.1482,1764.6196,1029.5328}; -- SV
   {1839.0155,657.2422,1017.9464}; -- Столовая МО
   {2563.3250,2192.5801,1046.9353}; -- штаб
   {394.8276,2537.9648,59.6592}; -- ВЫшка ВВС
   {1064.8464,1243.1301,1033.9541}; -- BBC
   {1571.5736,1671.6882,1021.5129}; -- ъх 

   -- Чтобы добавить свои координаты необходимо указать их в {x,y,z}, после закрывающей скобки "}" поставить ЗАПЯТУЮ или ; (Пример: {0,0,0}; )
}

local spawn = {
  ["lv"] = {2845.4182,1291.0607,11.3906};
  ["ls"] = {1755.2966,-1897.4805,13.5567};
  ["sf"] = {-1969.4761,158.1847,27.6875};
  ["mp"] = {1477.4438,-1696.5891,14.0469}; -- мЕрия
}




--- Main
function main()
  if not isSampfuncsLoaded() then return end
  initializeRender()
  print("warp loading. mod by sambrero")


  sampRegisterChatCommand("spawn", function(id)
    if tonumber(id) and sampIsPlayerConnected(tonumber(id)) then
      local curX, curY, curZ  = getCharCoordinates(playerPed)
      for k,v in pairs(org) do
        print(getDistanceBetweenCoords3d(v[1], v[2], 0, curX, curY, 0) < 150)
        if getDistanceBetweenCoords3d(v[1], v[2], 0, curX, curY, 0) < 150 then
          tp(v[1],v[2],v[3])
          sampSendChat("/gethere "..tonumber(id).." 1")
          return true
        end
      end
    end
  end)

  sampRegisterChatCommand("mp", mp )

  sampRegisterChatCommand("respawn", respawn)
  

  local arr = {}
  local sed = os.clock()
  local t = true;
  last = -1
  
  while true do

  if vne then
    --calculateZone(getCharCoordinates(PLAYER_PED),terri[TerraId][1],terri[TerraId][2])
  end
    --calculateZone(getCharCoordinates(PLAYER_PED))
--1157
  --if sampGetPlayerAnimationId(190) ~= last then
    --last = sampGetPlayerAnimationId(190)
    --msg(sampGetPlayerAnimationId(190))
  --end
  
  --[[if sampGetPlayerAnimationId(23) == 1157 and t then
    sed = os.clock()
    t = false
  end  

  if sampGetPlayerAnimationId(23) == 1157 and not t then
    print(os.clock() - sed)
  end ]]
  
  





    while isPauseMenuActive() do
      if cursorEnabled then
        showCursor(false)
      end
      wait(100)
    end

    if isKeyDown(keyToggle) and  spectate then
      cursorEnabled = not cursorEnabled
      showCursor(cursorEnabled)
      while isKeyDown(keyToggle) do wait(80) end
    end

    if cursorEnabled  then
      local mode = sampGetCursorMode()
      if mode == 0 then
        showCursor(true)
      end
      local sx, sy = getCursorPos()
      local sw, sh = getScreenResolution()
      -- is cursor in game window bounds?
      if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
        local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
        local camX, camY, camZ = getActiveCameraCoordinates()
        -- search for the collision point
        local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
        if result and colpoint.entity ~= 0 then
          local normal = colpoint.normal
          local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
          local zOffset = 300
          if normal[3] >= 0.5 then zOffset = 1 end
          -- search for the ground position vertically down
          local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
            true, true, false, true, false, false, false)
          if result then
            pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

            local curX, curY, curZ  = getCharCoordinates(playerPed)
            

            sy = sy - 2
            sx = sx - 2

            local tpIntoCar = nil
            

            createPointMarker(pos.x, pos.y, pos.z)

            -- teleport!
            if isKeyDown(keyApply) then
                tp(pos.x,pos.y,pos.z + 0.2)
                sampSendChat("/gethere "..spectate_id.." 1")
                removePointMarker()
              while isKeyDown(keyApply) do wait(0) end
              showCursor(false)
            end
          end
        end
      end
    end
    wait(0)
    removePointMarker()
  end
end

function initializeRender()
  font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
end



--- Functions

function respawn(arg)
  if arg and arg:match("%d+%s+%w+") then
      local id, respa = arg:match("(%d+)%s+(%w+)")
      if spawn[(respa:lower())] then 
          local v = spawn[(respa:lower())]
          tp(v[1],v[2],v[3])
          --sampSendChat("/setvw 0")
          --sampSendChat("/setint 0")
          sampSendChat("/gethere "..tonumber(id).." 1")
      else
        msg("Нет такой орг! LS | SF | LV")
      end
    else
      msg("Ошибка ввода. /spawn [id] [spawn]")
    end
end

function mp(id)
  if id --[[and sampIsPlayerConnected(tonumber(id))]] then
    sampSendChat(("/ans %d Вы выбыли с МП | Используйте /back"):format(tonumber(id)))
    respawn(("%d mp"):format(id))
  end
end

function createPointMarker(x, y, z)
  pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end

function removePointMarker()
  if pointMarker then
    removeUser3dMarker(pointMarker)
    pointMarker = nil
  end
end


function showCursor(toggle)
  if toggle then
    sampSetCursorMode(CMODE_LOCKCAM)
  else
    sampToggleCursor(false)
  end
  cursorEnabled = toggle
end

function msg(text)
  return sampAddChatMessage("[warp] {DCDCDC}" .. text,0x2777F0)
end


function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    -- from SAMP.Lua
    local raknet = require 'samp.raknet'
    require 'samp.synchronization'

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    -- copy player's sync data to the allocated memory
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    -- function to send packet
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    -- metatable to access sync data and 'send' function
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

-- SAMP EVENT


function sampev.onServerMessage(color, text)
  if color and text and isGameWindowForeground() and not isPauseMenuActive() and not isGamePaused() then
    if text:match("%[SP%] (.*)%[(%d+)%]") and color == 1728027135 then
      local nick,id = text:match("%[SP%] (.*)%[(%d+)%]")
      spectate_id = id
      nickLast = nick
      return true
    end
  end
end

function sampev.onSpectatePlayer(id,typs)
  id = tonumber(id)
  if not id then return msg('Подсказка: /sp id', 0xAFAFAF) end
  local res, ped = sampGetCharHandleBySampPlayerId(id)
  waiting = false
  if res and sampIsPlayerConnected(id) then 
    if spectate then
      spectate_ped = ped
      spectate_id = id
      nickLast = sampGetPlayerNickname(id)
    else
      dmove = true
      spectate = true
      spectate_ped = ped
      spectate_id = id
      nickLast = sampGetPlayerNickname(id)
    end
  end
end
 
function sampev.onTogglePlayerSpectating(bools)
   if not bools then 
    spectate = bools;
    dmove = false;
     _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    mynick = sampGetPlayerNickname(myid)
    spectate_id = -1
    nickLast = ""
   end
end
 
function sampev.onSpectateVehicle(id,type)
  local id = tonumber(id)
    if not id then return msg('Подсказка: /sp id', 0xAFAFAF) end
    waiting = false
      if not spectate then
        dmove = true
        spectate = true
      end
end


function sampev.onPlayerQuit(id)
  if spectate and id == spectate_id then
    spectate = false
    dmove = false
  end
end

local waiting = false

function sampev.onSendSpawn()
  if spectate then
    spectate = false
    dmove = false
  end
end

function tp(x,y,z)
  local data = samp_create_sync_data('player')
  data.position.x = x
  data.position.y = y
  data.position.z = z
  data.send()
end







