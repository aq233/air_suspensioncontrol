-- air_suspension.lua

-- 配置部分
local config = {
    animationDuration = 1000, -- 动画持续时间（毫秒）
    defaultHeights = {0.0, 0.02, 0.03, 0.06, 0.08} -- 默认高度值
}

-- 存储变量
local currentLevel = 1
local targetHeight = 0.0
local isAnimating = false

-- 注册切换档位命令
for i = 1, 5 do
    RegisterCommand('airlift'..i, function(source, args)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if currentLevel ~= i then
                currentLevel = i
                targetHeight = config.defaultHeights[currentLevel]
                TriggerAirLiftAnimation(vehicle)
                TriggerEvent('chat:addMessage', { args = { '^2气动避震档位已切换至: ' .. i .. ' (高度: ' .. targetHeight .. ')' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1当前已经是档位: ' .. i } })
            end
        else
            TriggerEvent('chat:addMessage', { args = { '^1错误: 你必须在车辆内才能使用此命令。' } })
        end
    end, false)
end

-- 注册设置档位高度命令
for i = 1, 5 do
    RegisterCommand('setairlift'..i, function(source, args)
        if args[1] then
            local value = tonumber(args[1])
            if value then
                config.defaultHeights[i] = value
                TriggerEvent('chat:addMessage', { args = { '^2档位 ' .. i .. ' 高度已设置为: ' .. value } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1错误: 请输入有效的数字。' } })
            end
        else
            TriggerEvent('chat:addMessage', { args = { '^1用法: /setairlift' .. i .. ' [高度值]' } })
        end
    end, false)
end

-- 气动动画函数（基于FiveM的悬挂修改）
function TriggerAirLiftAnimation(vehicle)
    if isAnimating then return end
    isAnimating = true

    local startTime = GetGameTimer()
    local initialHeight = Entity(vehicle).state.suspensionHeight or 0.0 -- 使用实体状态存储高度

    Citizen.CreateThread(function()
        while isAnimating do
            local timer = GetGameTimer() - startTime
            local progress = timer / config.animationDuration

            if progress < 1.0 then
                -- 使用缓动函数平滑过渡
                local easedProgress = math.sin(progress * math.pi * 0.5)
                local currentHeight = initialHeight + (targetHeight - initialHeight) * easedProgress

                -- 修改悬挂高度（通过FiveM实体状态）
                Entity(vehicle).state:set('suspensionHeight', currentHeight, true)

                Citizen.Wait(0)
            else
                Entity(vehicle).state:set('suspensionHeight', targetHeight, true)
                isAnimating = false
                break
            end
        end
    end)
end

-- 初始化提示
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    print("气动避震系统已加载！使用以下命令：")
    print("/airlift1 到 /airlift5 - 切换档位")
    print("/setairlift1 [高度值] 到 /setairlift5 [高度值] - 设置档位高度")
end)