-- Debug Script: Mapeia GUI/Flag/Input no "Adivinhe a Bandeira"
-- Rode no executor, aguarde bandeira aparecer. Prints no console!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("[Debug] Iniciado! Checando a cada 1s por flags...")

local function printHierarchy(parent, indent)
    indent = indent or ""
    for _, child in pairs(parent:GetChildren()) do
        local path = child:GetFullName():gsub("PlayerGui.", "")
        local extra = ""
        if child:IsA("ImageLabel") then
            extra = " | Image: " .. (child.Image or "nil")
        elseif child:IsA("TextBox") then
            extra = " | Placeholder: '" .. (child.PlaceholderText or "nil") .. "' | Pos: " .. tostring(child.Position)
        end
        print(indent .. child.Name .. " (" .. child.ClassName .. ")" .. extra .. " | Path: PlayerGui." .. path)
        if #child:GetChildren() > 0 then
            printHierarchy(child, indent .. "  ")
        end
    end
end

RunService.Heartbeat:Connect(function()
    local foundFlag = false
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("ImageLabel") and child.Image:match("rbxassetid://%d+") then
                    print("\n[Debug] *** BANDEIRA ENCONTRADA! ***")
                    print("Flag Image: " .. child.Name .. " | ID: " .. child.Image)
                    print("Em GUI: " .. gui.Name)
                    printHierarchy(playerGui, "")
                    foundFlag = true
                end
                if child:IsA("TextBox") and child.Visible and child.Position.Y.Scale > 0.7 then  -- Hub embaixo
                    print("\n[Debug] *** HUB INPUT ENCONTRADO! ***")
                    print("TextBox: " .. child.Name .. " | Placeholder: '" .. (child.PlaceholderText or "") .. "' | Pos: " .. tostring(child.Position))
                    print("Em GUI: " .. child.Parent.Name)
                end
            end
        end
    end
    if foundFlag then
        print("[Debug] Parando loop após detecção. Copie os prints acima!")
        -- Comenta o connect abaixo se quiser parar
    end
    wait(1)  -- Checa a cada 1s pra não lagar
end)
