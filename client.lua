local voiceModes = {}

local proximityRangeTimeout = 0;
local proximityRangeMarkerReachTimeOut = false

function CreateProximityRangeTimeout()
    proximityRangeTimeout = 2
    Citizen.CreateThread(function()
        repeat
            Wait(1000)
            proximityRangeTimeout = proximityRangeTimeout - 1
        until (proximityRangeTimeout <= 0)
        proximityRangeMarkerReachTimeOut = true
        Wait(1)
        proximityRangeMarkerReachTimeOut = false
    end)
end

function CreateProximityRange(proximityRange)
    proximityRangeMarkerReachTimeOut = true
    Wait(1)
    proximityRangeMarkerReachTimeOut = false
    
    if proximityRangeTimeout <= 0 then 
        CreateProximityRangeTimeout()
    end
    proximityRangeTimeout = 2
    
    Citizen.CreateThread(function()
        while not proximityRangeMarkerReachTimeOut do
            Wait(0)
            Client.DrawMarker(proximityRange)
        end
    end)
    
    exports['h-notify']:Alert("SPRACHWEITE", "Sprachweite: " .. proximityRange .. "M", 3000, 'info')
end

TriggerEvent("pma-voice:settingsCallback", function(voiceSettings)
    voiceModes = voiceSettings.voiceModes
end)

AddEventHandler('pma-voice:setTalkingMode', function(mode)
    if voiceModes[mode] then
        CreateProximityRange(voiceModes[mode][1])
    else
        print("invalide weite lol")
    end
end)