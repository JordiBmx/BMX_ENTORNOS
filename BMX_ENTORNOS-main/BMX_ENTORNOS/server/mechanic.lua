ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- REGISTROS

RegisterServerEvent('enp-mechanic:getJob')
AddEventHandler('enp-mechanic:getJob',function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('enp-mechanic:setJob', xPlayers[i],xPlayer.job.name)
		end
	end
end)

RegisterServerEvent('enp-mechanic:alert')
AddEventHandler('enp-mechanic:alert', function(message, x, y, z)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'mechanic' then
			
			TriggerClientEvent('enp-mechanic:setBlip', xPlayers[i], x, y, z)
		end
	end
end)

RegisterServerEvent('enp-mechanic:entorno:alert')
AddEventHandler('enp-mechanic:entorno:alert', function(message, x, y, z)
		TriggerClientEvent('enp-mechanic:setBlip', xPlayers[i], x, y, z)
end)

RegisterServerEvent('enp-mechanic:sendNotify')
AddEventHandler('enp-mechanic:sendNotify', function( msg, location, pos, IdPlayer  )
	TriggerClientEvent('enp-mechanic:sendNotify', -1, msg, location, pos, IdPlayer )
	LosgTaxi('**LLAMADA MECANICOS:**\n\n **ID del Player:** '..IdPlayer..'  \n**Llamada Mecanico:** '..msg..  '\n **Localización:** ' ..location.. '\n  **Distancia Aprox.** ' ..pos)	
end, false)

LosgMechanic = function(message)
    PerformHttpRequest(Config['LogsMechanic'], function(err, text, headers) end, 
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