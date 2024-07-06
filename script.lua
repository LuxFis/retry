-- Настройки
local slowDistance = 10  -- Расстояние для замедления
local stopDistance = 5   -- Расстояние для остановки

-- Функция для обработки действий
local function handleApproach()
    -- Соединение с событием обновления
    game:GetService("RunService").Stepped:Connect(function()
        -- Перебор всех игроков в игре
        for _, player in ipairs(game.Players:GetPlayers()) do
            -- Игрок, который не является локальным игроком
            if player ~= game.Players.LocalPlayer then
                -- Получение персонажа игрока
                local character = player.Character
                if character then
                    -- Получение корневой части Humanoid
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Получение корневой части Humanoid локального игрока
                        local localCharacter = game.Players.LocalPlayer.Character
                        local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                        
                        -- Вычисление расстояния между локальным игроком и другими игроками
                        local distance = (localHumanoidRootPart.Position - humanoidRootPart.Position).magnitude

                        -- Если игрок подходит на расстояние для остановки, останавливаем его
                        if distance < stopDistance then
                            humanoidRootPart.Anchored = true
                            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        elseif distance < slowDistance then
                            -- Если игрок подходит на расстояние для замедления, замедляем его
                            local slowdownFactor = 0.5  -- Фактор замедления (можно изменить)
                            humanoidRootPart.Velocity = humanoidRootPart.Velocity * slowdownFactor
                        end
                    end
                end
            end
        end
    end)
end

-- Запускаем функцию обработки
handleApproach()