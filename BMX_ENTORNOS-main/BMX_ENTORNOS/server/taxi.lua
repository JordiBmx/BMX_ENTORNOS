ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- REGISTROS

RegisterServerEvent('enp-taxi:getJob')
AddEventHandler('enp-taxi:getJob',function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('enp-taxi:setJob', xPlayers[i],xPlayer.job.name)
		end
	end
end)

RegisterServerEvent('enp-taxi:alert')
AddEventHandler('enp-taxi:alert', function(message, x, y, z)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'taxi' then
			
			TriggerClientEvent('enp-taxi:setBlip', xPlayers[i], x, y, z)
		end
	end
end)

RegisterServerEvent('enp-taxi:entorno:alert')
AddEventHandler('enp-taxi:entorno:alert', function(message, x, y, z)
		TriggerClientEvent('enp-taxi:setBlip', xPlayers[i], x, y, z)
end)

RegisterServerEvent('enp-taxi:sendNotify')
AddEventHandler('enp-taxi:sendNotify', function( msg, location, pos, IdPlayer  )
	TriggerClientEvent('enp-taxi:sendNotify', -1, msg, location, pos, IdPlayer )
	LosgTaxi('**LLAMADA TAXI:**\n\n **ID del Player:** '..IdPlayer..'  \n**Llamada Taxi:** '..msg..  '\n **Localización:** ' ..location.. '\n  **Distancia Aprox.** ' ..pos)	
end, false)

LosgTaxi = function(message)
    PerformHttpRequest(Config['LogsTaxi'], function(err, text, headers) end, 
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