Client = {}

@param proximityRange number
@return nil
Client.DrawMarker = function(proximityRange)
    local coords = GetEntityCoords(PlayerPedId())
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)

    if isInVehicle then
        coords = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false))
        coords = vector3(coords.x, coords.y, coords.z + -0.5)
    else
        coords = vector3(coords.x, coords.y, coords.z - 1.0)
    end

    ---@diagnostic disable-next-line: missing-parameter
    DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, proximityRange*2.0, proximityRange*2.0, 0.5, 0, 255, 255, 100, false, true, 2, nil, nil, false)
end
