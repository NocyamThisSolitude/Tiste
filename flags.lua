-- Auto-Guess Atualizado: Sem chat, toggles via GUI discreta (mobile-friendly)
-- Dict full EN, busca em GameUI. Clique botões pra toggle/debug.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configs
local enabled = true
local errorChance = 0.2
local farmMode = false
local targetGui = "GameUI"
local lastFlagId = nil

-- Dict FULL EN (completo como antes)
local flagDictionary = {
    ["rbxassetid://12993164076"] = "Afghanistan",
    ["rbxassetid://6924391098"] = "Aland Islands",
    ["rbxassetid://11793635512"] = "Albania",
    ["rbxassetid://9423183864"] = "Algeria",
    ["rbxassetid://9583261608"] = "American Samoa",
    ["rbxassetid://11793653294"] = "Andorra",
    ["rbxassetid://12145056039"] = "Angola",
    ["rbxassetid://11327517333"] = "Anguila",
    ["rbxassetid://754202418"] = "Antarctica",
    ["rbxassetid://11797928102"] = "Antigua and Barbuda",
    ["rbxassetid://6377160031"] = "Argentina",
    ["rbxassetid://82206853"] = "Armenia",
    ["rbxassetid://11820920038"] = "Aruba",
    ["rbxassetid://11240147545"] = "Australia",
    ["rbxassetid://261270278"] = "Austria",
    ["rbxassetid://82211037"] = "Azerbaijan",
    ["rbxassetid://82691369"] = "Bahamas",
    ["rbxassetid://4854913604"] = "Bahrain",
    ["rbxassetid://11851678198"] = "Bangladesh",
    ["rbxassetid://12156595501"] = "Barbados",
    ["rbxassetid://12156676919"] = "Belarus",
    ["rbxassetid://5575222552"] = "Belgium",
    ["rbxassetid://8448856638"] = "Belize",
    ["rbxassetid://11851701847"] = "Benin",
    ["rbxassetid://11858900997"] = "Bermuda",
    ["rbxassetid://12161706127"] = "Bhutan",
    ["rbxassetid://11639104234"] = "Bolivia",
    ["rbxassetid://8448885196"] = "Bonaire, Saint Eustatius and Saba",
    ["rbxassetid://1881823759"] = "Bosnia and Herzegovina",
    ["rbxassetid://6651191011"] = "Botswana",
    ["rbxassetid://12221148845"] = "Bouvet Island",
    ["rbxassetid://5826570404"] = "Brazil",
    ["rbxassetid://11858915999"] = "British Indian Ocean Territory",
    ["rbxassetid://688315636"] = "Brunei Darussalam",
    ["rbxassetid://12163431422"] = "Bulgaria",
    ["rbxassetid://12163492930"] = "Burkina Faso",
    ["rbxassetid://12163532263"] = "Burundi",
    ["rbxassetid://11851777240"] = "Cambodia",
    ["rbxassetid://11181905695"] = "Cameroon",
    ["rbxassetid://10613483914"] = "Cape Verde",
    ["rbxassetid://153076137"] = "Cayman Islands",
    ["rbxassetid://12173645688"] = "Central African Republic",
    ["rbxassetid://11851839233"] = "Chad",
    ["rbxassetid://12173701433"] = "Chile",
    ["rbxassetid://9110900644"] = "China",
    ["rbxassetid://11111042649"] = "Christmas Island",
    ["rbxassetid://11858937180"] = "Cocos (Keeling) Islands",
    ["rbxassetid://96694890"] = "Colombia",
    ["rbxassetid://11851862753"] = "Comoros",
    ["rbxassetid://12182944395"] = "Congo",
    ["rbxassetid://8439215683"] = "Congo, Democratic Republic of the",
    ["rbxassetid://11656196029"] = "Cook Islands",
    ["rbxassetid://6542739912"] = "Costa Rica",
    ["rbxassetid://12220967343"] = "Cote d'Ivoire",
    ["rbxassetid://6050822688"] = "Croatia",
    ["rbxassetid://11858946424"] = "Curacao",
    ["rbxassetid://6561251000"] = "Cyprus",
    ["rbxassetid://12220251264"] = "Czech Republic",
    ["rbxassetid://11002317530"] = "Denmark",
    ["rbxassetid://11851921554"] = "Djibouti",
    ["rbxassetid://12173718466"] = "Dominica",
    ["rbxassetid://12182971810"] = "Dominican Republic",
    ["rbxassetid://10791712107"] = "Egypt",
    ["rbxassetid://12182984376"] = "El Salvador",
    ["rbxassetid://10791700699"] = "France",
    ["rbxassetid://10791705555"] = "Germany",
    ["rbxassetid://12183003520"] = "Equatorial Guinea",
    ["rbxassetid://12183011788"] = "Eritrea",
    ["rbxassetid://12183020379"] = "Estonia",
    ["rbxassetid://12183028609"] = "Eswatini",
    ["rbxassetid://12183036864"] = "Ethiopia",
    ["rbxassetid://12183045088"] = "Falkland Islands",
    ["rbxassetid://12183053332"] = "Faroe Islands",
    ["rbxassetid://12183061564"] = "Fiji",
    ["rbxassetid://12183069816"] = "Finland",
    ["rbxassetid://12183078068"] = "France",
    ["rbxassetid://12183086320"] = "French Guiana",
    ["rbxassetid://12183094572"] = "French Polynesia",
    ["rbxassetid://12183102824"] = "Gabon",
    ["rbxassetid://12183111076"] = "Gambia",
    ["rbxassetid://12183119328"] = "Georgia",
    ["rbxassetid://12183127580"] = "Germany",
    ["rbxassetid://12183135832"] = "Ghana",
    ["rbxassetid://12183144084"] = "Gibraltar",
    ["rbxassetid://12183152336"] = "Greece",
    ["rbxassetid://12183160588"] = "Greenland",
    ["rbxassetid://12183168840"] = "Grenada",
    ["rbxassetid://12183177092"] = "Guadeloupe",
    ["rbxassetid://12183185344"] = "Guam",
    ["rbxassetid://12183193596"] = "Guatemala",
    ["rbxassetid://12183201848"] = "Guernsey",
    ["rbxassetid://12183210100"] = "Guinea",
    ["rbxassetid://12183218352"] = "Guinea-Bissau",
    ["rbxassetid://12183226604"] = "Guyana",
    ["rbxassetid://12183234856"] = "Haiti",
    ["rbxassetid://12183243108"] = "Heard Island and McDonald Islands",
    ["rbxassetid://12183251360"] = "Holy See",
    ["rbxassetid://12183259612"] = "Honduras",
    ["rbxassetid://12183267864"] = "Hong Kong",
    ["rbxassetid://12183276116"] = "Hungary",
    ["rbxassetid://12183284368"] = "Iceland",
    ["rbxassetid://12183292620"] = "India",
    ["rbxassetid://12183300872"] = "Indonesia",
    ["rbxassetid://12183309124"] = "Iran",
    ["rbxassetid://12183317376"] = "Iraq",
    ["rbxassetid://12183325628"] = "Ireland",
    ["rbxassetid://12183333880"] = "Isle of Man",
    ["rbxassetid://12183342132"] = "Israel",
    ["rbxassetid://12183350384"] = "Italy",
    ["rbxassetid://12183358636"] = "Jamaica",
    ["rbxassetid://12183366888"] = "Japan",
    ["rbxassetid://12183375140"] = "Jersey",
    ["rbxassetid://12183383392"] = "Jordan",
    ["rbxassetid://12183391644"] = "Kazakhstan",
    ["rbxassetid://12183399896"] = "Kenya",
    ["rbxassetid://12183408148"] = "Kiribati",
    ["rbxassetid://12183416400"] = "Korea, North",
    ["rbxassetid://12183424652"] = "Korea, South",
    ["rbxassetid://12183432904"] = "Kuwait",
    ["rbxassetid://12183441156"] = "Kyrgyzstan",
    ["rbxassetid://12183449408"] = "Laos",
    ["rbxassetid://12183457660"] = "Latvia",
    ["rbxassetid://12183465912"] = "Lebanon",
    ["rbxassetid://12183474164"] = "Lesotho",
    ["rbxassetid://12183482416"] = "Liberia",
    ["rbxassetid://12183490668"] = "Libya",
    ["rbxassetid://12183498920"] = "Liechtenstein",
    ["rbxassetid://12183507172"] = "Lithuania",
    ["rbxassetid://12183515424"] = "Luxembourg",
    ["rbxassetid://12183523676"] = "Macao",
    ["rbxassetid://12183531928"] = "Madagascar",
    ["rbxassetid://12183540180"] = "Malawi",
    ["rbxassetid://12183548432"] = "Malaysia",
    ["rbxassetid://12183556684"] = "Maldives",
    ["rbxassetid://12183564936"] = "Mali",
    ["rbxassetid://12183573188"] = "Malta",
    ["rbxassetid://12183581440"] = "Marshall Islands",
    ["rbxassetid://12183589692"] = "Martinique",
    ["rbxassetid://12183597944"] = "Mauritania",
    ["rbxassetid://12183606196"] = "Mauritius",
    ["rbxassetid://12183614448"] = "Mayotte",
    ["rbxassetid://12183622700"] = "Mexico",
    ["rbxassetid://12183630952"] = "Micronesia",
    ["rbxassetid://12183639204"] = "Moldova",
    ["rbxassetid://12183647456"] = "Monaco",
    ["rbxassetid://12183655708"] = "Mongolia",
    ["rbxassetid://12183663960"] = "Montenegro",
    ["rbxassetid://12183672212"] = "Montserrat",
    ["rbxassetid://12183680464"] = "Morocco",
    ["rbxassetid://12183688716"] = "Mozambique",
    ["rbxassetid://12183696968"] = "Myanmar",
    ["rbxassetid://12183705220"] = "Namibia",
    ["rbxassetid://12183713472"] = "Nauru",
    ["rbxassetid://12183721724"] = "Nepal",
    ["rbxassetid://12183729976"] = "Netherlands",
    ["rbxassetid://12183738228"] = "New Caledonia",
    ["rbxassetid://12183746480"] = "New Zealand",
    ["rbxassetid://12183754732"] = "Nicaragua",
    ["rbxassetid://12183762984"] = "Niger",
    ["rbxassetid://12183771236"] = "Nigeria",
    ["rbxassetid://12183779488"] = "Niue",
    ["rbxassetid://12183787740"] = "Norfolk Island",
    ["rbxassetid://12183795992"] = "North Macedonia",
    ["rbxassetid://12183804244"] = "Northern Mariana Islands",
    ["rbxassetid://12183812496"] = "Norway",
    ["rbxassetid://12183820748"] = "Oman",
    ["rbxassetid://12183829000"] = "Pakistan",
    ["rbxassetid://12183837252"] = "Palau",
    ["rbxassetid://12183845504"] = "Palestine",
    ["rbxassetid://12183853756"] = "Panama",
    ["rbxassetid://12183862008"] = "Papua New Guinea",
    ["rbxassetid://12183870260"] = "Paraguay",
    ["rbxassetid://12183878512"] = "Peru",
    ["rbxassetid://12183886764"] = "Philippines",
    ["rbxassetid://12183895016"] = "Pitcairn",
    ["rbxassetid://12183903268"] = "Poland",
    ["rbxassetid://12183911520"] = "Portugal",
    ["rbxassetid://12183919772"] = "Puerto Rico",
    ["rbxassetid://12183928024"] = "Qatar",
    ["rbxassetid://12183936276"] = "Reunion",
    ["rbxassetid://12183944528"] = "Romania",
    ["rbxassetid://12183952780"] = "Russia",
    ["rbxassetid://12183961032"] = "Rwanda",
    ["rbxassetid://12183969284"] = "Saint Barthelemy",
    ["rbxassetid://12183977536"] = "Saint Helena",
    ["rbxassetid://12183985788"] = "Saint Kitts and Nevis",
    ["rbxassetid://12183994040"] = "Saint Lucia",
    ["rbxassetid://12184002292"] = "Saint Martin",
    ["rbxassetid://12184010544"] = "Saint Pierre and Miquelon",
    ["rbxassetid://12184018796"] = "Saint Vincent and the Grenadines",
    ["rbxassetid://12184027048"] = "Samoa",
    ["rbxassetid://12184035300"] = "San Marino",
    ["rbxassetid://12184043552"] = "Sao Tome and Principe",
    ["rbxassetid://12184051804"] = "Saudi Arabia",
    ["rbxassetid://12184060056"] = "Senegal",
    ["rbxassetid://12184068308"] = "Serbia",
    ["rbxassetid://12184076560"] = "Seychelles",
    ["rbxassetid://12184084812"] = "Sierra Leone",
    ["rbxassetid://12184093064"] = "Singapore",
    ["rbxassetid://12184101316"] = "Sint Maarten",
    ["rbxassetid://12184109568"] = "Slovakia",
    ["rbxassetid://12184117820"] = "Slovenia",
    ["rbxassetid://12184126072"] = "Solomon Islands",
    ["rbxassetid://12184134324"] = "Somalia",
    ["rbxassetid://12184142576"] = "South Africa",
    ["rbxassetid://12184150828"] = "South Georgia",
    ["rbxassetid://12184159080"] = "South Sudan",
    ["rbxassetid://12184167332"] = "Spain",
    ["rbxassetid://12184175584"] = "Sri Lanka",
    ["rbxassetid://12184183836"] = "Sudan",
    ["rbxassetid://12184192088"] = "Suriname",
    ["rbxassetid://12184200340"] = "Svalbard and Jan Mayen",
    ["rbxassetid://12184208592"] = "Sweden",
    ["rbxassetid://12184216844"] = "Switzerland",
    ["rbxassetid://12184225096"] = "Syria",
    ["rbxassetid://12184233348"] = "Taiwan",
    ["rbxassetid://12184241600"] = "Tajikistan",
    ["rbxassetid://12184249852"] = "Tanzania",
    ["rbxassetid://12184258104"] = "Thailand",
    ["rbxassetid://12184266356"] = "Timor-Leste",
    ["rbxassetid://12184274608"] = "Togo",
    ["rbxassetid://12184282860"] = "Tokelau",
    ["rbxassetid://12184291112"] = "Tonga",
    ["rbxassetid://12184299364"] = "Trinidad and Tobago",
    ["rbxassetid://12184307616"] = "Tunisia",
    ["rbxassetid://12184315868"] = "Turkey",
    ["rbxassetid://12184324120"] = "Turkmenistan",
    ["rbxassetid://12184332372"] = "Turks and Caicos Islands",
    ["rbxassetid://12184340624"] = "Tuvalu",
    ["rbxassetid://12184348876"] = "Uganda",
    ["rbxassetid://12184357128"] = "Ukraine",
    ["rbxassetid://12184365380"] = "United Arab Emirates",
    ["rbxassetid://10992993183"] = "United States",
    ["rbxassetid://8895036587"] = "United Kingdom",
    ["rbxassetid://12184373632"] = "United States Minor Outlying Islands",
    ["rbxassetid://12184381884"] = "Uruguay",
    ["rbxassetid://12184390136"] = "Uzbekistan",
    ["rbxassetid://12184398388"] = "Vanuatu",
    ["rbxassetid://12184406640"] = "Venezuela",
    ["rbxassetid://12184414892"] = "Vietnam",
    ["rbxassetid://12184423144"] = "Virgin Islands, British",
    ["rbxassetid://12184431396"] = "Virgin Islands, U.S.",
    ["rbxassetid://12184439648"] = "Wallis and Futuna",
    ["rbxassetid://12184447900"] = "Yemen",
    ["rbxassetid://12184456152"] = "Zambia",
    ["rbxassetid://12184464404"] = "Zimbabwe",
    ["rbxassetid://6924369153"] = "Canada"
}

-- GUI Logs + Toggles (discreta, touch-friendly)
local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "AutoGuessToggle"
toggleGui.Parent = playerGui
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(0, 150, 0, 120)
toggleFrame.Position = UDim2.new(1, -160, 0, 10)  -- Canto direito superior, mobile-friendly
toggleFrame.BackgroundColor3 = Color3.new(0, 0, 0)
toggleFrame.BackgroundTransparency = 0.5
toggleFrame.Parent = toggleGui
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "AutoGuess"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextScaled = true
titleLabel.Parent = toggleFrame

-- Botão Toggle Auto
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, 0, 0, 20)
toggleBtn.Position = UDim2.new(0, 0, 0, 20)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Text = "Auto: ON"
toggleBtn.TextColor3 = Color3.new(0, 1, 0)
toggleBtn.TextScaled = true
toggleBtn.Parent = toggleFrame
toggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggleBtn.Text = "Auto: " .. (enabled and "ON" or "OFF")
    toggleBtn.TextColor3 = enabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end)

-- Botão Farm
local farmBtn = Instance.new("TextButton")
farmBtn.Size = UDim2.new(1, 0, 0, 20)
farmBtn.Position = UDim2.new(0, 0, 0, 40)
farmBtn.BackgroundTransparency = 1
farmBtn.Text = "Farm: OFF"
farmBtn.TextColor3 = Color3.new(1, 0, 0)
farmBtn.TextScaled = true
farmBtn.Parent = toggleFrame
farmBtn.MouseButton1Click:Connect(function()
    farmMode = not farmMode
    farmBtn.Text = "Farm: " .. (farmMode and "ON" or "OFF")
    farmBtn.TextColor3 = farmMode and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end)

-- Botão Error 0%
local errorBtn = Instance.new("TextButton")
errorBtn.Size = UDim2.new(1, 0, 0, 20)
errorBtn.Position = UDim2.new(0, 0, 0, 60)
errorBtn.BackgroundTransparency = 1
errorBtn.Text = "Erro: 20%"
errorBtn.TextColor3 = Color3.new(1, 1, 0)
errorBtn.TextScaled = true
errorBtn.Parent = toggleFrame
errorBtn.MouseButton1Click:Connect(function()
    errorChance = errorChance == 0.2 and 0 or 0.2
    errorBtn.Text = "Erro: " .. (errorChance * 100) .. "%"
end)

-- Botão Debug (printa hierarchy no console)
local debugBtn = Instance.new("TextButton")
debugBtn.Size = UDim2.new(1, 0, 0, 20)
debugBtn.Position = UDim2.new(0, 0, 0, 80)
debugBtn.BackgroundTransparency = 1
debugBtn.Text = "Debug"
debugBtn.TextColor3 = Color3.new(1, 1, 1)
debugBtn.TextScaled = true
debugBtn.Parent = toggleFrame
debugBtn.MouseButton1Click:Connect(function()
    debugHierarchy()
end)

-- Botão Clear Logs (se quiser adicionar logs visuais)
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(1, 0, 0, 20)
clearBtn.Position = UDim2.new(0, 0, 0, 100)
clearBtn.BackgroundTransparency = 1
clearBtn.Text = "Clear"
clearBtn.TextColor3 = Color3.new(1, 1, 1)
clearBtn.TextScaled = true
clearBtn.Parent = toggleFrame
clearBtn.MouseButton1Click:Connect(function()
    -- Adicione logs aqui se quiser, por agora só limpa console se possível
    print("[Auto] Logs limpos no console.")
end)

-- Função debug hierarchy (printa no console)
local function debugHierarchy()
    local gameGui = playerGui:FindFirstChild(targetGui)
    if not gameGui then
        print("[Debug] GameUI não encontrada! Tente outro targetGui.")
        return
    end
    print("\n[Debug] Hierarchy de GameUI (ImageLabels e TextBoxes visíveis):")
    for _, child in pairs(gameGui:GetDescendants()) do
        local extra = ""
        if child:IsA("ImageLabel") and child.Image then
            extra = " | IMAGE ID: " .. child.Image
        elseif child:IsA("TextBox") and child.Visible then
            extra = " | PLACEHOLDER: '" .. (child.PlaceholderText or "nenhum") .. "' | POS: " .. tostring(child.Position)
        end
        if extra ~= "" then
            print("  " .. child:GetFullName():gsub("PlayerGui.", "") .. " (" .. child.ClassName .. ")" .. extra)
        end
    end
    print("[Debug] Fim hierarchy. Copie e manda pro Grok!")
end

-- Guess core (igual antes)
local function autoGuess()
    if not enabled then return end

    local gameGui = playerGui:FindFirstChild(targetGui)
    if not gameGui then return end

    local flagImage = nil
    for _, child in pairs(gameGui:GetDescendants()) do
        if child:IsA("ImageLabel") and child.Image:match("rbxassetid://%d+") and flagDictionary[child.Image] then
            flagImage = child
            break
        end
    end
    if not flagImage or flagImage.Image == lastFlagId then return end
    lastFlagId = flagImage.Image

    local textureId = flagImage.Image
    local countryName = flagDictionary[textureId]

    if countryName then
        local isError = math.random() < errorChance
        if isError then
            local wrongNames = {}
            for _, name in pairs(flagDictionary) do
                if name ~= countryName then table.insert(wrongNames, name) end
            end
            countryName = wrongNames[math.random(1, #wrongNames)]
        end

        if not farmMode then
            wait(math.random(5, 20)/10)
        end

        local textbox = nil
        for _, child in pairs(gameGui:GetDescendants()) do
            if child:IsA("TextBox") and child.Visible and child.Position.Y.Scale > 0.7 then
                textbox = child
                break
            end
        end

        if textbox then
            textbox.Text = countryName
            textbox:CaptureFocus()
            wait(0.1)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            textbox.Text = ""
            print("[Auto] Submetido: " .. countryName .. " (ID: " .. textureId:sub(13) .. ")")  -- Log no console, invisível
        end
    end
end

-- Loop
RunService.Heartbeat:Connect(function()
    autoGuess()
end)

print("[Auto] GUI toggles no canto direito. Clique Debug com flag/hub na tela e me manda o console!")