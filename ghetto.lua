local sampev = require 'lib.samp.events'
local zone = {
  [-1] = false;
  [0] = {1849,-1054,2069,-945};
  [1] = {2069,-1108,2175,-945};
  [2] = {2175,-1108,2279,-945};
  [3] = {2279,-1047,2475,-945};
  [4] = {2475,-1047,2642,-945};
  [5] = {2642,-1047,2730,-945};
  [6] = {2730,-1047,2949,-945};
  [7] = {1849,-1135,2069,-1054};
  [8] = {2069,-1220,2175,-1108};
  [9] = {2175,-1220,2279,-1108};
  [10] = {2279,-1154,2400,-1047};
  [11] = {2400,-1154,2571,-1047};
  [12] = {2571,-1154,2642,-1047};
  [13] = {2642,-1154,2730,-1047};
  [14] = {2730,-1154,2949,-1047};
  [15] = {1849,-1260,2069,-1135};
  [16] = {1849,-1340,1964,-1260};
  [17] = {1964,-1340,2069,-1260};
  [18] = {2069,-1300,2166,-1220};
  [19] = {2166,-1300,2279,-1220};
  [20] = {2279,-1300,2370,-1154};
  [21] = {2370,-1256,2451,-1154};
  [22] = {2451,-1256,2570,-1154};
  [23] = {2570,-1256,2642,-1154};
  [24] = {2642,-1256,2730,-1154};
  [25] = {2730,-1256,2949,-1154};
  [26] = {1849,-1463,1986,-1340};
  [27] = {1986,-1384,2069,-1340};
  [28] = {1986,-1463,2122,-1384};
  [29] = {2069,-1384,2166,-1300};
  [30] = {2166,-1384,2279,-1300};
  [31] = {2279,-1384,2370,-1300};
  [32] = {2370,-1326,2451,-1256};
  [33] = {2370,-1384,2451,-1326};
  [34] = {2451,-1369,2511,-1256};
  [35] = {2451,-1444,2511,-1369};
  [36] = {2511,-1444,2570,-1256};
  [37] = {2570,-1350,2642,-1256};
  [38] = {2570,-1444,2642,-1350};
  [39] = {2642,-1394,2730,-1256};
  [40] = {2730,-1386,2796,-1256};
  [41] = {2796,-1386,2949,-1256};
  [42] = {1849,-1612,1986,-1463};
  [43] = {1986,-1612,2122,-1463};
  [44] = {2122,-1497,2212,-1384};
  [45] = {2122,-1612,2212,-1497};
  [46] = {2212,-1484,2279,-1384};
  [47] = {2279,-1484,2342,-1384};
  [48] = {2212,-1565,2342,-1484};
  [49] = {2342,-1444,2451,-1384};
  [50] = {2342,-1524,2431,-1444};
  [51] = {2431,-1504,2550,-1444};
  [52] = {2550,-1504,2642,-1444};
  [53] = {2642,-1504,2730,-1394};
  [54] = {2730,-1488,2823,-1386};
  [55] = {2823,-1488,2949,-1386};
  [56] = {1821,-1752,1941,-1612};
  [57] = {1941,-1752,2001,-1612};
  [58] = {2001,-1672,2081,-1612};
  [59] = {2001,-1752,2081,-1672};
  [60] = {2081,-1752,2212,-1612};
  [61] = {2212,-1658,2342,-1565};
  [62] = {2212,-1737,2342,-1658};
  [63] = {2342,-1658,2431,-1524};
  [64] = {2342,-1737,2431,-1658};
  [65] = {2431,-1611,2550,-1504};
  [66] = {2550,-1611,2642,-1504};
  [67] = {2431,-1737,2627,-1611};
  [68] = {2642,-1611,2730,-1504};
  [69] = {2730,-1657,2823,-1488};
  [70] = {2823,-1657,2949,-1488};
  [71] = {2627,-1657,2730,-1611};
  [72] = {1849,-1856,1961,-1752};
  [73] = {1961,-1812,2081,-1752};
  [74] = {2081,-1894,2212,-1752};
  [75] = {2212,-1852,2326,-1737};
  [76] = {2326,-1852,2413,-1737};
  [77] = {2413,-1852,2511,-1737};
  [78] = {2511,-1852,2627,-1737};
  [79] = {2627,-1890,2885,-1657};
  [80] = {1849,-1932,1961,-1856};
  [81] = {1961,-1932,2081,-1812};
  [82] = {2081,-1932,2212,-1894};
  [83] = {2212,-1894,2313,-1852};
  [84] = {2212,-1972,2313,-1894};
  [85] = {2313,-1972,2413,-1852};
  [86] = {2413,-1932,2511,-1852};
  [87] = {2511,-1932,2627,-1852};
  [88] = {2627,-1932,2714,-1890};
  [89] = {2714,-1994,2769,-1890};
  [90] = {2769,-1994,2885,-1890};
  [91] = {1659,-2086,1821,-2021};
  [92] = {1821,-2049,1882,-1932};
  [93] = {1882,-2049,1961,-1932};
  [94] = {1961,-2049,2212,-1998};
  [95] = {2212,-2049,2413,-1972};
  [96] = {2413,-2049,2583,-1932};
  [97] = {2583,-2049,2714,-1932};
  [98] = {2714,-2049,2885,-1994};
  [99] = {1659,-2166,1821,-2086};
  [100] = {1821,-2166,1961,-2049};
  [101] = {1961,-2109,2092,-2049};
  [102] = {1961,-2166,2092,-2109};
  [103] = {1961,-1998,2212,-1932};
  };



local actived = false;
local clo = os.clock()
local spisok = {}

function main()
if not isSampLoaded() or not isSampfuncsLoaded() then return end
while not isSampAvailable() do wait(100) end
wait(-1)
end

function msg(text)
  if noPause() then 
    return sampAddChatMessage("[Scipt] {DCDCDC}" .. text,0x2777F0)
  end
end

function noPause()
  return (isGameWindowForeground() and not isPauseMenuActive() and not isGamePaused())
end


function sampev.onTextDrawSetString(id,text)
  if actived and id == 25 and noPause() then
    time_sliv,sec_sliv = text:match("Time%:%_(%d)%:(%d+)")
    if tonumber(time_sliv) <= 3 then actived = false; msg("Время слива вне терры вышло") end
  end
end

function sampev.onGangZoneStopFlash()
  TerraId = -1
  actived = false;
end

function sampev.onGangZoneFlash(id)
  if id and noPause() then
    TerraId = tonumber(id)
    actived = true;
  end
end

function test1()
  TerraId = 6
  sampAddChatMessage("START", -1)
  actived = true;
end

function test2()
  sampAddChatMessage("END", -1)
  TerraId = -1
  actived = false;
end

function calculateZone(x,y,playerId,zoneId,nickEnemy,idjop)
  if noPause() then 
    if spisok[playerId] then 
      if os.clock() - spisok[playerId].time > 3 then
        spisok[playerId] = nil
        return true
      end
    elseif not spisok[playerId] then
      local sx,sy,ex,ey = zone[zoneId][1],zone[zoneId][2],zone[zoneId][3],zone[zoneId][4]
      local lev_down = {sx,sy};
      local lev_up = {sx,ey};
      local right_up = {ex,ey};
      local right_down = {ex,sy}
      local left_med = {sx,(sy+ey)/2}
      local right_med = {ex,(sy+ey)/2}
      local up_med = {(sx+ex)/2,ey}
      local down_med = {(sx+ex)/2,sy}
      local all = {lev_down,lev_up,right_up,right_down,left_med,right_med,up_med,down_med}
      spisok[playerId] = {id = playerId; time = os.clock()}
      for k,v in pairs(all) do
        local x = getDistanceBetweenCoords3d(v[1],v[2], 0, x, y, 0)
          if x < 172 then
            return true; 
          end
      end
      if sampIsPlayerConnected(playerId) then
        local enemycolor = nickEnemy;
        if idjop and sampIsPlayerConnected(idjop) then
          local enemycolor = ("{%0.6}%s[%d]"):format(bit.band(sampGetPlayerColor(idjop), 0xFFFFFF),nickEnemy,idjop)
        end
        return sampAddChatMessage(("{FF0000}[Вне терры]{%0.6x}%s[%d] {FF0000} стреляет > %s"):format(bit.band(sampGetPlayerColor(playerId), 0xFFFFFF),
          sampGetPlayerNickname(playerId),
          playerId,
          enemycolor),-1)
      end
    end
  end
end




function sampev.onSendBulletSync(data)
  if noPause() then 
    process_bullet_sync(select(2, sampGetPlayerIdByCharHandle(1)), data)     
  end
end

function sampev.onBulletSync(id, data)
  if actived and noPause() then 
    process_bullet_sync(id, data)
  end
end
 
 function get_vehicle_model(id)
    if noPause() then 
      local res, car = sampGetCarHandleBySampVehicleId(id)
      if res then return getNameOfVehicleModel(getCarModel(car)) else return 'ERROR ' .. tostring(id) end
    end
end
 
function process_bullet_sync(id, data)
  if actived and id and noPause() then
    local O = data.origin
    if data.targetType == 1 and sampIsPlayerConnected(data.targetId) then hit_name = sampGetPlayerNickname(data.targetId); local id_hit = data.targetId; calculateZone(O.x,O.y,id,TerraId,hit_name,data.targetId) end
    if data.targetType == 2 then hit_name = get_vehicle_model(data.targetId); calculateZone(O.x,O.y,id,TerraId,hit_name) end
  end 
end





local last = {"",""}
local arr = {}
local terri = {}



function sampev.onPlayerSync(playerId, data)
    if noPause() then 
    local animId = data.animationId
    for k,v in pairs(arr) do
      if sampIsPlayerConnected(playerId) then 
        local ped = select(2,sampGetCharHandleBySampPlayerId(playerId))
        if tonumber(v.id) == tonumber(playerId) and ped and not isCharInAnyCar(ped) then
          if data.animationId ~= 1157 and v.status and not isCharStopped(ped) and os.clock() - v.time > 1 --[[and not isPlayerDead(ped)]] then
            if os.clock() - v.time < 5.1 then
                local txt = " ,"
                if animId == 1043 then txt = "с помощью ТС," end -- 1224
                msg(("{FF0000}[Warning] {%0.6x}%s[%d] возможно сбил аптечку %sид анимации:%s"):format(bit.band(sampGetPlayerColor(playerId), 0xFFFFFF),k,playerId,txt,tostring(animId)))
                arr[sampGetPlayerNickname(playerId)] = nil
                return {playerId, data}
            else
              arr[sampGetPlayerNickname(playerId)] = nil
              return {playerId, data}
            end
          end
        end
      end
    end
     return {playerId, data}
  end
end





function sampev.onPlayerChatBubble(playerId, color, distance, duration, message)
  if sampIsPlayerConnected(playerId) and noPause() then
    if color == -1721303041 then 
      if (message:lower()):match("%+%d+ hp") then
        --msg(sampGetPlayerNickname(playerId).."["..playerId.."]".."Использовал аптечку")
        arr[sampGetPlayerNickname(playerId)] = nil;
        arr[sampGetPlayerNickname(playerId)] = {status = true; time = os.clock(); id = playerId; warning = 0;}
        return {playerId, color, distance, duration, message}
      end
   end
  end
end

