ESX = nil
blip = nil
oldblip = nil
blips = {}
local target = {}


Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
  end
end)

AddEventHandler('playerSpawned', function(spawn)
  TriggerServerEvent('enp-entorno:getJob')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerEvent('enp-entorno:getJob')
end)

TriggerServerEvent('enp-entorno:getJob')

RegisterNetEvent('enp-entorno:setJob')
AddEventHandler('enp-entorno:setJob',function(theJob)
    job = theJob
end)

        
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/forzar', 'Obligatorio para robar vehiculos de NPC')
    TriggerEvent('chat:addSuggestion', '/entorno', 'Obligatorio para hacer rol de entorno')
end)

RegisterNetEvent('enp-entorno:forzar:sendNotify')
AddEventHandler('enp-entorno:forzar:sendNotify', function( modelo, r, g, b, matricula, location, pos, IdPlayer )
  target.pos = pos
  print(json.encode(target.pos))
  coords = GetEntityCoords(GetPlayerPed(-1))
  dist = CalculateTravelDistanceBetweenPoints(coords.x,coords.y,coords.z,target.pos.x,target.pos.y,target.pos.z) / 1000
  if job == 'police' then 
    TriggerEvent("pNotify:SetQueueMax", "forzar", 5)
    TriggerEvent('pNotify:SendNotification',{text = "Robo de Vehiculo  </br></br> Modelo: "..modelo.."  </br> Color: <div style='width:30px;height:15px;display:inline-block;background-color:rgb(" .. r .. "," .. g .. "," .. b .. ")'></div> </br> Matricula: "..matricula.." </br> Ubicación: "..location.."</br>  Distancia: "..dist.." Km</br> <p> </p><b style='color:#3efe00'>[E Aceptar] </b> <b style='color:#fe0000'>[Q Denegar] </b>", 
      timeout = 15000,
      type = "info",
      progressBar = true,
      layout     = "centerRight",
      animation = {
        open = "gta_effects_fade_in",
        close = "gta_effects_fade_out"
      }
    })    
  end
end)

RegisterNetEvent('enp-entorno:entorno:sendNotify')
AddEventHandler('enp-entorno:entorno:sendNotify', function( msg, location, pos, IdPlayer )
  if job == 'police' then 
    target.pos = pos
    print(json.encode(target.pos))
    coords = GetEntityCoords(GetPlayerPed(-1))
    dist = CalculateTravelDistanceBetweenPoints(coords.x,coords.y,coords.z,target.pos.x,target.pos.y,target.pos.z) / 1000
    TriggerEvent("pNotify:SetQueueMax", "forzar", 5)
    TriggerEvent('pNotify:SendNotification',{text = "Entorno  </br> "..msg.."  en  "..location.." </br>  Distancia: "..dist.." Km </br> <p> </p><b style='color:#3efe00'>[E Aceptar] </b> <b style='color:#fe0000'>[Q Denegar] </b>", 
    timeout = 15000,
      type = "info",
      progressBar = true,
      layout     = "centerRight",
      animation = {
        open = "gta_effects_fade_in",
        close = "gta_effects_fade_out"
      }
    })
  end  
end)

RegisterNetEvent('enp-entorno:setBlip')
AddEventHandler('enp-entorno:setBlip', function(x, y, z)


    contador = 6000

    entorno_llamada = true 
    Citizen.CreateThread(function()
      blipPos = vector3(x, y, z)
      blip = AddBlipForCoord(x, y, z)
      SetBlipSprite(blip, Config['Police'].SetBlipSprite)
      SetBlipScale(blip, Config['Police'].SetBlipScale)
      SetBlipColour(blip, Config['Police'].SetBlipColour)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config['Police'].TextBlip )
      EndTextCommandSetBlipName(blip)
      table.insert(blips, blip)

      activarcontador = true
      
      
      while entorno_llamada do
        if IsControlJustReleased(1, 38) then
          TriggerEvent("pNotify:SendNotification", {
            text = 'Has aceptado la llamada',
            theme = 'sunset',
            timeout = 3000,
            layout = "centerRight",
            queue = "forzar"
          })
          activarcontador2 = true
          entorno_llamada = false
          TriggerEvent('enp-entorno:remblip', blip)
          SetNewWaypoint(tonumber(x), tonumber(y))
        elseif IsControlJustReleased(1, 44) then
          TriggerEvent("pNotify:SendNotification", {
            text = 'Has rechazado la llamada',
            theme = 'sunset',
            timeout = 3000,
            layout = "centerRight",
            queue = "forzar"
          })
          entorno_llamada = false
          blipPos = nil  
          RemoveBlip(blip)
        end

        contador = contador - 1
        if contador <= 0 then
          entorno_llamada = false 
          RemoveBlip(blip)
        end
        Citizen.Wait(0)
      end 

    end)
end)

RegisterNetEvent('enp-entorno:remblip')
AddEventHandler('enp-entorno:remblip', function(blip)
  local newblip = blip
  Wait(180000)
  RemoveBlip(newblip)
end)

Citizen.CreateThread(function()
  local contador2 = 10
  while activarcontador2 == true do
    print ('activado')
    Citizen.Wait(1000)
    if contador2 <= 0 then
      blipPos = nil 
      RemoveBlip(blip)
      activarcontador2 = false
    else
      contador2 = contador2 - 1
      print (contador2)
    end
  end 
end)

RegisterCommand("forzar", function(source, args)
    local playername = GetPlayerName(PlayerId())
    local IdPlayer = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local estaDentro = IsPedInAnyVehicle(ped, false)
    local model = GetEntityModel(veh)
    local vehicleModel = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
    local vehiculo = GetVehiclePedIsIn(ped)
    local r, g, b = GetVehicleColor(vehiculo)
    primary = Config['ColorNames'][tostring(primary)]
    local modelo = GetDisplayNameFromVehicleModel(vehicleModel)
    local matricula = GetVehicleNumberPlateText(vehiculo)
    local pos = GetEntityCoords(GetPlayerPed(-1))

    if estaDentro then
      
      TriggerServerEvent('enp-entorno:forzar:sendNotify', modelo, r, g, b, matricula, location, pos, IdPlayer )
      TriggerServerEvent('enp-entorno:alert', x, y, z)
      TriggerEvent('chatMessage', '[^1FORZAR^0]', {255,255,255}, 'Has enviado un forzar.')
    else
      TriggerEvent('chatMessage', '[^1FORZAR^0]', {255,255,255}, 'No estás en ningún vehiculo.')
    end
end)


RegisterCommand("entorno", function(source, args)
  local IdPlayer = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
  local playername = GetPlayerName(PlayerId())
  local ped = GetPlayerPed(PlayerId())
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  local pos = GetEntityCoords(GetPlayerPed(-1))

  if args[1] == nil then
    TriggerEvent('chatMessage', '[^1ENTORNO^0]', {255,255,255}, 'Has enviado un entorno.')
  else
    TriggerServerEvent('enp-entorno:entorno:sendNotify', msg, location, pos, IdPlayer)
    TriggerServerEvent('enp-entorno:alert', x, y, z)
  end
end)