-- Переменные для настройки
local slowDistance = 10  -- Расстояние, на котором начинается замедление
local stopDistance = 5   -- Расстояние, на котором персонажи останавливаются

-- Функция для проверки расстояния и изменения скорости
local function handleApproach()
    game:GetService("RunService").Stepped:Connect(function()
        -- Проверяем каждого игрока в игре
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local localCharacter = game.Players.LocalPlayer.Character
                        local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                        
                        local distance = (localHumanoidRootPart.Position - humanoidRootPart.Position).magnitude

                        -- Если игрок подошел на расстояние stopDistance, останавливаем его
                        if distance < stopDistance then
                            humanoidRootPart.Anchored = true
                            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        elseif distance < slowDistance then
                            -- Если игрок подошел на расстояние slowDistance, замедляем его
                            local slowdownFactor = 0.5  -- Фактор замедления (можно изменить)
                            humanoidRootPart.Velocity = humanoidRootPart.Velocity * slowdownFactor
                        end
                    end
                end
            end
        end
    end)
end

-- Запускаем функцию проверки расстояния
handleApproach()