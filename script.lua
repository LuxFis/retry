-- Переменные для настройки
local slowDistance = 10  -- Расстояние, на котором начинается замедление
local stopDistance = 5   -- Расстояние, на котором персонажи останавливаются

-- Функция для проверки расстояния и изменения скорости
local function handleApproach()
    while true do
        wait(0.5)  -- Проверяем расстояние каждые 0.5 секунды (можно изменить интервал)

        -- Проверяем каждого игрока в игре
        for _, player in ipairs(delta.players:getPlayers()) do
            if player ~= delta.localPlayer then
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local localCharacter = delta.localPlayer.Character
                        local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                        
                        local distance = (localHumanoidRootPart.Position - humanoidRootPart.Position).magnitude

                        -- Если игрок подошел на расстояние stopDistance, останавливаем его
                        if distance < stopDistance then
                            delta.network:invoke("MoveCharacter", player, localHumanoidRootPart.Position)
                        elseif distance < slowDistance then
                            -- Если игрок подошел на расстояние slowDistance, замедляем его
                            local slowdownFactor = 0.5  -- Фактор замедления (можно изменить)
                            local newPosition = (localHumanoidRootPart.Position - humanoidRootPart.Position) * slowdownFactor

                            delta.network:invoke("MoveCharacter", player, newPosition)
                        end
                    end
                end
            end
        end
    end
end

-- Запускаем функцию проверки расстояния
handleApproach()