script_name("DL plus")
script_author("Garret remake Jeki Sambrero")
require "lib.sampfuncs"
require "lib.moonloader"


if not doesDirectoryExist(getWorkingDirectory()..'\\config\\') then
    createDirectory(getWorkingDirectory()..'\\config\\')
    sampAddChatMessage("creat directory", -1 )
  end

local inicfg = require 'inicfg'

local cfg = inicfg.load({
  settings = {
  Dist = 40,
  Active = true}})
-- cfg.settings.Dist
-- cfg.settings.Active

function carspeed(xzche)
  local idspeed = {
    [400] = "88",
    [401] = "82",
    [402] = "103",
    [403] = "61",
    [404] = "74",
    [405] = "91",
    [406] = "61",
    [407] = "82",
    [408] = "65",
    [409] = "88",
    [410] = "72",
    [411] = "123",
    [412] = "94",
    [413] = "61",
    [414] = "59",
    [415] = "107",
    [416] = "85",
    [417] = "155",
    [418] = "65",
    [419] = "82",
    [420] = "81",
    [421] = "85",
    [422] = "78",
    [423] = "55",
    [424] = "75",
    [425] = "155",
    [426] = "96",
    [427] = "92",
    [428] = "87",
    [429] = "112",
    [430] = "93",
    [431] = "72",
    [432] = "52",
    [433] = "61",
    [434] = "93",
    [435] = "155",
    [436] = "83",
    [437] = "88",
    [438] = "79",
    [439] = "93",
    [440] = "76",
    [441] = "42",
    [442] = "77",
    [443] = "70",
    [444] = "61",
    [445] = "91",
    [446] = "100",
    [447] = "155",
    [448] = "110",
    [449] = "155",
    [450] = "25",
    [451] = "107",
    [452] = "100",
    [453] = "35",
    [454] = "71",
    [455] = "87",
    [456] = "59",
    [457] = "53",
    [458] = "87",
    [459] = "76",
    [460] = "155",
    [461] = "110",
    [462] = "110",
    [463] = "115",
    [464] = "155",
    [465] = "155",
    [466] = "82",
    [467] = "78",
    [468] = "105",
    [469] = "155",
    [470] = "87",
    [471] = "62",
    [472] = "72",
    [473] = "57",
    [474] = "83",
    [475] = "96",
    [476] = "155",
    [477] = "103",
    [478] = "65",
    [479] = "78",
    [480] = "102",
    [481] = "155",
    [482] = "87",
    [483] = "68",
    [484] = "40",
    [485] = "55",
    [486] = "0",
    [487] = "155",
    [488] = "155",
    [489] = "62",
    [490] = "87",
    [491] = "83",
    [492] = "78",
    [493] = "36",
    [494] = "119",
    [495] = "98",
    [496] = "90",
    [497] = "155",
    [498] = "60",
    [499] = "69",
    [500] = "78",
    [501] = "155",
    [502] = "119",
    [503] = "119",
    [504] = "96",
    [505] = "62",
    [506] = "99",
    [507] = "92",
    [508] = "60",
    [509] = "70",
    [510] = "80",
    [511] = "155",
    [512] = "155",
    [513] = "155",
    [514] = "67",
    [515] = "80",
    [516] = "87",
    [517] = "87",
    [518] = "91",
    [519] = "155",
    [520] = "155",
    [521] = "117",
    [522] = "130",
    [523] = "155",
    [524] = "71",
    [525] = "89",
    [526] = "88",
    [527] = "83",
    [528] = "98",
    [529] = "83",
    [530] = "34",
    [531] = "40",
    [532] = "62",
    [533] = "93",
    [534] = "94",
    [535] = "88",
    [536] = "96",
    [537] = "160",
    [538] = "101",
    [539] = "56",
    [540] = "83",
    [541] = "113",
    [542] = "91",
    [543] = "84",
    [544] = "82",
    [545] = "82",
    [546] = "83",
    [547] = "79",
    [548] = "155",
    [549] = "85",
    [550] = "80",
    [551] = "87",
    [552] = "68",
    [553] = "155",
    [554] = "81",
    [555] = "88",
    [556] = "62",
    [557] = "62",
    [558] = "87",
    [559] = "99",
    [560] = "94",
    [561] = "85",
    [562] = "99",
    [563] = "155",
    [564] = "50",
    [565] = "91",
    [566] = "89",
    [567] = "96",
    [568] = "81",
    [569] = "0",
    [570] = "0",
    [571] = "56",
    [572] = "33",
    [573] = "62",
    [574] = "34",
    [575] = "88",
    [576] = "88",
    [577] = "155",
    [578] = "73",
    [579] = "88",
    [580] = "85",
    [581] = "120",
    [582] = "76",
    [583] = "48",
    [584] = "2",
    [585] = "85",
    [586] = "110",
    [587] = "91",
    [588] = "61",
    [589] = "90",
    [590] = "160",
    [591] = "20",
    [592] = "155",
    [593] = "155",
    [594] = "34",
    [595] = "70",
    [596] = "97",
    [597] = "97",
    [598] = "97",
    [599] = "88",
    [600] = "84",
    [601] = "62",
    [602] = "94",
    [603] = "95",
    [604] = "82",
    [605] = "84",
    [606] = "52",
    [607] = "52",
    [608] = "1",
    [609] = "61",
    [610] = "15",
    [611] = "15" 
 }
 return idspeed[xzche]
 end


function main()
if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("dist", function(param)
     if #param ~= 0 and tonumber(param) > 0 then
      cfg.settings.Dist = param
      DIST = cfg.settings.Dist
      sampAddChatMessage(("Радиус прорисовки установлен на %d м."):format(DIST), -1  )
      del_3d()
      inicfg.save(cfg)
      inicfg.save(cfg,"dist.ini")
        else
         sampAddChatMessage("invalid param", -1 )
        end 
   end)

   sampRegisterChatCommand("dist3d", function()
     cfg.settings.Active = not cfg.settings.Active
     sampAddChatMessage(("Скрипт: %s"):format(cfg.settings.Active and "включен!" or "{FF0000}выключен!"), -1  )
     if not cfg.settings.Active then
        del_3d()
     end
     inicfg.save(cfg)
     inicfg.save(cfg,"dist.ini")
   end  )

   del_3d()
   print("/dist [dist] | /dist3d ")
   sampAddChatMessage("I JOB's",-1  )
                  --  R | G | B | A
   Color = join_argb(220,220,220,220) -- <<<
   DIST = cfg.settings.Dist
   while true do
      wait(10)
      if cfg.settings.Active then 
      local pPedX, pPedY, pPedZ = getCharCoordinates(PLAYER_PED)
      BOL_SH, BOL_Vehicle = findAllRandomVehiclesInSphere(pPedX, pPedY, pPedZ, DIST, true, true)
        if BOL_SH  then
        Bool_handle,SV_ID = sampGetVehicleIdByCarHandle(BOL_Vehicle)
            if doesVehicleExist(BOL_Vehicle) then
            Id_Car = getCarModel(BOL_Vehicle)
            --endtext = string.format("Модель: %s[%i]\nСкорость: %.1f/%.1f Км/ч\nHP: %i | ID: %i", getNameOfVehicleModel(Id_Car), Id_Car, getCarSpeed(BOL_Vehicle) * 2, carspeed(Id_Car),getCarHealth(BOL_Vehicle), SV_ID)
            endtext = string.format("Модель: %s[%i]\nСкорость: %.1f Км/ч\nHP: %i | ID: %i", getNameOfVehicleModel(Id_Car), Id_Car, getCarSpeed(BOL_Vehicle) * 2, getCarHealth(BOL_Vehicle), SV_ID)
                if not sampIs3dTextDefined(SV_ID) then
                    sampCreate3dTextEx(SV_ID,endtext,Color,0,0,0,DIST,false,-1,SV_ID)
                elseif sampIs3dTextDefined(SV_ID) then
                    text,color,floatX,floatY,floatZ,Distan,boolIgnore,intPlayer,Carid = sampGet3dTextInfoById(SV_ID)
                    if not Distan == DIST then
                        sampDestroy3dText(SV_ID)
                    elseif Distan == DIST and text ~= endtext then
                        --sampDestroy3dText(SV_ID)
                        sampCreate3dTextEx(SV_ID,endtext,Color,0,0,0,DIST,false,-1,SV_ID)
                    end
                end 
            end 
        end
      end
   end
end


function del_3d()
   for i = 1, 2048 do
   sampDestroy3dText(i)
   end
end

function join_argb(r, g, b, a)
  local argb = b  -- b
  argb = bit.bor(argb, bit.lshift(g, 8))  -- g
  argb = bit.bor(argb, bit.lshift(r, 16)) -- r
  argb = bit.bor(argb, bit.lshift(a, 24)) -- a
  return argb
end
