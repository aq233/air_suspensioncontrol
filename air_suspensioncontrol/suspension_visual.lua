-- suspension_visual.lua
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(vehicle) then
            local height = Entity(vehicle).state.suspensionHeight or 0.0
            -- 通过FiveM API或其他合法方式修改车辆高度（此处为伪代码）
            SetVehicleSuspensionHeight(vehicle, height)
        end
    end
end)