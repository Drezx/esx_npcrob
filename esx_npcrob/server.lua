ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

ESX.RegisterServerCallback('esx_npcrob', function(source, what) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local rand = math.random(500, 1500)
    xPlayer.addMoney(rand)
    what(rand)
end)