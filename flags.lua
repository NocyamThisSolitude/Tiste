-- One-Shot Print: Roda uma vez, printa GUIs/Flag/Hub, para. Zero lag.
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

print("\n[One-Shot] Estrutura da PlayerGui (só visíveis):")

for _, gui in pairs(playerGui:GetChildren()) do
    if gui:IsA("ScreenGui") and gui.Enabled then
            print("--- GUI: " .. gui.Name .. " ---")
                    local foundFlag = false
                            local foundHub = false
                                    for _, child in pairs(gui:GetChildren()) do  -- Só 1 nível pra leveza
                                                if child:IsA("ImageLabel") and child.Image and child.Image:match("rbxassetid://%d+") then
                                                                print("  FLAG: " .. child.Name .. " (ImageLabel) | ID: " .. child.Image)
                                                                                foundFlag = true
                                                                                            end
                                                                                                        if child:IsA("TextBox") and child.Visible and child.Position.Y.Scale > 0.7 then
                                                                                                                        print("  HUB INPUT: " .. child.Name .. " (TextBox) | Placeholder: '" .. (child.PlaceholderText or "nenhum") .. "' | Pos: " .. tostring(child.Position))
                                                                                                                                        foundHub = true
                                                                                                                                                    end
                                                                                                                                                            end
                                                                                                                                                                    if foundFlag then print("  [FLAG ACHADA NESSA GUI]") end
                                                                                                                                                                            if foundHub then print("  [HUB ACHADO NESSA GUI]") end
                                                                                                                                                                                end
                                                                                                                                                                                end

                                                                                                                                                                                print("[One-Shot] Fim! Copie os prints acima.")