-- Настройки расстояний
local slowDistance = 10  -- Расстояние для замедления
local stopDistance = 5   -- Расстояние для остановки
local normalWalkSpeed = 16  -- Стандартная скорость ходьбы игрока
local slowWalkSpeed = 4  -- Скорость ходьбы при замедлении

-- Функция для обработки движения игроков
local function handleMovement()
    -- Соединение с событием обновления
    game:GetService("RunService").Stepped:Connect(function()
        -- Перебор всех игроков в игре
        for _, player in ipairs(game.Players:GetPlayers()) do
            -- Игрок, который не локальный игрок
            if player ~= game.Players.LocalPlayer then
                -- Получение персонажа игрока
                local character = player.Character
                if character then
                    -- Получение Humanoid игрока
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        -- Получение корневой части Humanoid
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            -- Получение корневой части Humanoid локального игрока
                            local localCharacter = game.Players.LocalPlayer.Character
                            local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                            
                            -- Вычисление расстояния между локальным игроком и другими игроками
                            local distance = (localHumanoidRootPart.Position - humanoidRootPart.Position).magnitude

                            -- Если игрок находится на расстоянии для остановки, останавливаем его
                            if distance < stopDistance then
                                humanoid.WalkSpeed = 0  -- Останавливаем игрока
                            elseif distance < slowDistance then
                                -- Если игрок находится на расстоянии для замедления, замедляем его
                                humanoid.WalkSpeed = slowWalkSpeed
                            else
                                -- Возвращаем нормальную скорость, если игрок находится вне зоны действия
                                humanoid.WalkSpeed = normalWalkSpeed
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- Запускаем функцию для обработки движения
handleMovement()