-- Debug Manual Zero Lag: Aperta F1 pra printar estrutura (só uma vez)
-- Sem loop, sem freeze!

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("[Debug Manual] Carregado! Aperta F1 no jogo pra printar GUIs/Flag/Hub (uma vez só).")

local printed = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F1 and not printed then
                printed = true
                        print("\n[Debug] *** PRINT MANUAL ATIVADO! *** (Estrutura da PlayerGui)")

                                for _, gui in pairs(playerGui:GetChildren()) do
                                            if gui:IsA("ScreenGui") and gui.Enabled then
                                                            print("\n--- GUI: " .. gui.Name .. " ---")
                                                                            for _, child in pairs(gui:GetDescendants()) do
                                                                                                if child:IsA("ImageLabel") and child.Image:match("rbxassetid://%d+") then
                                                                                                                        print("FLAG ENCONTRADA: " .. child.Name .. " (ImageLabel) | ID: " .. child.Image .. " | Parent: " .. child.Parent.Name)
                                                                                                                                            end
                                                                                                                                                                if child:IsA("TextBox") and child.Visible and child.AbsolutePosition.Y > workspace.CurrentCamera.ViewportSize.Y * 0.7 then
                                                                                                                                                                                        print("HUB INPUT ENCONTRADO: " .. child.Name .. " (TextBox) | Placeholder: '" .. (child.PlaceholderText or "nenhum") .. "' | Pos: " .. tostring(child.Position) .. " | Parent: " .. child.Parent.Name)
                                                                                                                                                                                                            end
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                        print("[Debug] Print feito! Copie os ENCONTRADO acima e pare o script se quiser.")
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            end)