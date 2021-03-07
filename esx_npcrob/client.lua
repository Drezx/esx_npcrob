ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local robbed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 38) then
            local aiming, thisPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
            if aiming then
                local pCoords = GetEntityCoords(GetPlayerPed(-1), true)
                local tCoords = GetEntityCoords(thisPed, true)
                if DoesEntityExist(thisPed) and IsEntityAPed(thisPed) then
                    if robbed then
                        ESX.ShowNotification('Wait before next rob')
                    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true) >= 2 then
                        ESX.ShowNotification('~r~Too far')
                    else
                        proccess(thisPed)
                    end
                end
            end
        end
    end
end)

function proccess(thisPed)
    robbed = true
    TaskStandStill(thisPed, 6000)
    FreezeEntityPosition(thisPed, true)
    ESX.ShowHelpNotification('~r~Robbing ~s~people, ~y~wait...')
    Citizen.Wait(6000)
    ESX.TriggerServerCallback('esx_npcrob', function(amount)
        ESX.ShowNotification('You robbed ~g~'..amount.."$")
    end)
    FreezeEntityPosition(thisPed, false)
    Citizen.Wait(4000)
    robbed = false
end