ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- REGISTROS

RegisterServerEvent('enp-entorno:getJob')
AddEventHandler('enp-entorno:getJob',function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('enp-entorno:setJob', xPlayers[i],xPlayer.job.name)
		end
	end
end)

RegisterServerEvent('enp-entorno:alert')
AddEventHandler('enp-entorno:alert', function(x, y, z)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			
			TriggerClientEvent('enp-entorno:setBlip', xPlayers[i], x, y, z)
		end
	end
end)

RegisterServerEvent('enp-entorno:entorno:alert')
AddEventHandler('enp-entorno:entorno:alert', function(x, y, z)
		TriggerClientEvent('enp-entorno:setBlip', xPlayers[i], x, y, z)
end)

RegisterServerEvent('enp-entorno:forzar:sendNotify')
AddEventHandler('enp-entorno:forzar:sendNotify', function( modelo, r, g, b, matricula, location, pos, IdPlayer  )
	TriggerClientEvent('enp-entorno:forzar:sendNotify', -1, modelo, r, g, b, matricula, location, pos, IdPlayer  )
	LogsForzar('**Entorno Forzar:**\n\n **ID del Player:** '..IdPlayer..'  \n**Modelo vehículo:** '..modelo..  '\n **Color vehículo:** ' ..r, g, b.. '\n  **Matrícula:** ' ..matricula.. '\n **Localización:** ' ..location.. '\n **Distancia Aprox.** ' ..pos)	
end, false)


RegisterServerEvent('enp-entorno:entorno:sendNotify')
AddEventHandler('enp-entorno:entorno:sendNotify', function( msg, location, pos, IdPlayer  )
	TriggerClientEvent('enp-entorno:entorno:sendNotify', -1, msg, location, pos, IdPlayer )
	LogsEntornos('**Entornos:**\n\n **ID del Player:** '..IdPlayer..'  \n**Mensaje:** '..msg..  '\n **Localización:** ' ..location.. '\n  **Distancia Aprox. ** ' ..pos)	
end, false)

-- Funciones 

LogsForzar = function(message)
    PerformHttpRequest(Config['LogsForzar'], function(err, text, headers) end, 
    'POST', json.encode(
        {username = "Terminator ᵈᵉᵛ", 
        embeds = {
            {["color"] = color, 
            ["author"] = {
            ["name"] = "Terminator ᵈᵉᵛ",
            ["icon_url"] = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg"},
            ["description"] = "".. message .."",
            ["footer"] = {
            ["text"] = "©Terminator ᵈᵉᵛ - "..os.date("%x %X %p"),
            ["icon_url"] = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg",},}
        }, avatar_url = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg"}), {['Content-Type'] = 'application/json' })
end

LogsEntornos = function(message)
    PerformHttpRequest(Config['LogsEntornos'], function(err, text, headers) end, 
    'POST', json.encode(
        {username = "Terminator ᵈᵉᵛ", 
        embeds = {
            {["color"] = color, 
            ["author"] = {
            ["name"] = "Terminator ᵈᵉᵛ",
            ["icon_url"] = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg"},
            ["description"] = "".. message .."",
            ["footer"] = {
            ["text"] = "©Terminator ᵈᵉᵛ - "..os.date("%x %X %p"),
            ["icon_url"] = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg",},}
        }, avatar_url = "https://cdn.discordapp.com/attachments/757628160878706699/786281875064225792/log.jpg"}), {['Content-Type'] = 'application/json' })
end