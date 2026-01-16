-- Fish It - ULTIMATE CHEAT PACK v1.0
-- ALL FEATURES IN ONE SCRIPT
-- Compatible with Delta Executor Android

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Wait for game
if not game:IsLoaded() then
    game.Loaded:Wait()
end
task.wait(2)

-- CONFIGURATION
local Config = {
    AutoFish = false,
    AutoSell = false,
    AutoBuy = false,
    NoCooldown = false,
    PerfectTiming = false,
    UnlimitedBait = false,
    SpeedHack = 1,
    MultiCatch = 1,
    GodMode = false,
    FreeShop = false,
    AllSkins = false,
    ESPEnabled = false,
    RadarHack = false,
    AutoGift = false,
    QuestAuto = false
}

-- DATA STORAGE
local RemoteCache = {}
local HookedRemotes = {}
local OriginalFunctions = {}
local FishESP = {}
local PlayerESP = {}
local CatchCount = 0
local TotalCoins = 0
local SessionStart = os.time()

-- FIND ALL REMOTES
local function findRemotes()
    print("🔍 Finding all fishing remotes...")
    
    local function findRemote(name)
        return ReplicatedStorage:FindFirstChild(name, true) or 
               ReplicatedStorage:WaitForChild(name, 5)
    end
    
    -- Fishing Remotes
    RemoteCache.UpdateAutoFish = findRemote("RF/UpdateAutoFishingState")
    RemoteCache.ChargeRod = findRemote("RF/ChargeFishingRod")
    RemoteCache.CancelInputs = findRemote("RF/CancelFishingInputs")
    RemoteCache.RequestMinigame = findRemote("RF/RequestFishingMinigameStarted")
    RemoteCache.FishCaught = findRemote("RE/FishCaught")
    RemoteCache.FishingCompleted = findRemote("RE/FishingCompleted")
    RemoteCache.FishingStopped = findRemote("RE/FishingStopped")
    RemoteCache.EquipBait = findRemote("RE/EquipBait")
    RemoteCache.BaitCastVisual = findRemote("RE/BaitCastVisual")
    RemoteCache.BaitSpawned = findRemote("RE/BaitSpawned")
    RemoteCache.BaitDestroyed = findRemote("RE/BaitDestroyed")
    RemoteCache.PurchaseRod = findRemote("RF/PurchaseFishingRod")
    RemoteCache.PurchaseBait = findRemote("RF/PurchaseBait")
    RemoteCache.UpdateRadar = findRemote("RF/UpdateFishingRadar")
    RemoteCache.PlayEffect = findRemote("RE/PlayFishingEffect")
    RemoteCache.FishingMinigameChanged = findRemote("RE/FishingMinigameChanged")
    RemoteCache.CaughtFishVisual = findRemote("RE/CaughtFishVisual")
    RemoteCache.ObtainedNewFish = findRemote("RE/ObtainedNewFishNotification")
    
    -- Shop & Economy
    RemoteCache.PromptPurchase = findRemote("RE/PromptProductPurchase")
    RemoteCache.ProductCompleted = findRemote("RE/ProductPurchaseCompleted")
    RemoteCache.ProductFinished = findRemote("RE/ProductPurchaseFinished")
    RemoteCache.UpdateAutoSell = findRemote("RF/UpdateAutoSellThreshold")
    RemoteCache.PurchaseSkinCrate = findRemote("RF/PurchaseSkinCrate")
    RemoteCache.RollSkinCrate = findRemote("RE/RollSkinCrate")
    
    -- Equipment & Skins
    RemoteCache.EquipRodSkin = findRemote("RE/EquipRodSkin")
    RemoteCache.UnequipRodSkin = findRemote("RE/UnequipRodSkin")
    RemoteCache.EquipBaitSkin = findRemote("RE/EquipBaitSkin")
    RemoteCache.UnequipBaitSkin = findRemote("RE/UnequipBaitSkin")
    RemoteCache.EquipItem = findRemote("RE/EquipItem")
    RemoteCache.UnequipItem = findRemote("RE/UnequipItem")
    RemoteCache.FavoriteItem = findRemote("RE/FavoriteItem")
    RemoteCache.FavoriteStateChanged = findRemote("RE/FavoriteStateChanged")
    
    -- Quests & Gifts
    RemoteCache.ClaimMegalodon = findRemote("RF/RF_ClaimMegalodonQuest")
    RemoteCache.SetGiftReceiver = findRemote("RF/SetGiftReceiver")
    RemoteCache.RemoveGiftReceiver = findRemote("RF/RemoveGiftReceiver")
    RemoteCache.UseGift = findRemote("RF/UseGiftFromInventory")
    RemoteCache.ClaimNotification = findRemote("RE/ClaimNotification")
    
    -- UI & Effects
    RemoteCache.TextNotification = findRemote("RE/TextNotification")
    RemoteCache.ClientDialogue = findRemote("RE/ClientDialogue")
    RemoteCache.PlaySound = findRemote("RE/PlaySound")
    
    -- Print found remotes
    for name, remote in pairs(RemoteCache) do
        if remote then
            print("✅ " .. name)
        else
            print("❌ " .. name .. " (not found)")
        end
    end
    
    return RemoteCache
end

-- HOOKING SYSTEM
local function hookRemote(remote, newFunction)
    if not remote or HookedRemotes[remote] then return false end
    
    local original
    if remote:IsA("RemoteFunction") then
        original = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            return newFunction(original, self, ...)
        end
    elseif remote:IsA("RemoteEvent") then
        original = remote.FireServer
        remote.FireServer = function(self, ...)
            return newFunction(original, self, ...)
        end
    end
    
    if original then
        OriginalFunctions[remote] = original
        HookedRemotes[remote] = true
        return true
    end
    return false
end

-- ============================================
-- 🎣 FISHING FEATURES
-- ============================================

-- AUTO FISHING
local function startAutoFishing()
    if not RemoteCache.UpdateAutoFish then return end
    
    Config.AutoFish = true
    spawn(function()
        while Config.AutoFish do
            pcall(function()
                RemoteCache.UpdateAutoFish:InvokeServer(true)
                
                if Config.NoCooldown then
                    RemoteCache.ChargeRod:InvokeServer()
                end
                
                if Config.PerfectTiming then
                    RemoteCache.RequestMinigame:InvokeServer()
                    task.wait(0.2)
                    RemoteCache.FishingCompleted:FireServer()
                end
                
                if Config.MultiCatch > 1 then
                    for i = 1, Config.MultiCatch do
                        RemoteCache.FishCaught:FireServer({value = 1000})
                        CatchCount = CatchCount + 1
                    end
                else
                    RemoteCache.FishCaught:FireServer({value = 1000})
                    CatchCount = CatchCount + 1
                end
                
                if Config.AutoSell then
                    RemoteCache.UpdateAutoSell:InvokeServer(100)
                end
            end)
            
            task.wait(3 / Config.SpeedHack)
        end
    end)
end

local function stopAutoFishing()
    Config.AutoFish = false
    if RemoteCache.UpdateAutoFish then
        pcall(function()
            RemoteCache.UpdateAutoFish:InvokeServer(false)
        end)
    end
end

-- NO COOLDOWN FISHING
local function enableNoCooldown()
    if not RemoteCache.ChargeRod then return end
    
    Config.NoCooldown = true
    hookRemote(RemoteCache.ChargeRod, function(original, self, ...)
        return true -- Instant charge
    end)
end

-- PERFECT TIMING
local function enablePerfectTiming()
    Config.PerfectTiming = true
    if RemoteCache.FishCaught then
        hookRemote(RemoteCache.FishCaught, function(original, self, ...)
            local args = {...}
            if #args > 0 and type(args[1]) == "table" then
                args[1].perfect = true
            end
            return original(self, unpack(args))
        end)
    end
end

-- UNLIMITED BAIT
local function enableUnlimitedBait()
    Config.UnlimitedBait = true
    if RemoteCache.BaitDestroyed then
        RemoteCache.BaitDestroyed.FireServer = function() end -- Never destroy bait
    end
end

-- SPEED HACK
local function setSpeedHack(multiplier)
    Config.SpeedHack = multiplier
    
    if multiplier > 1 then
        RunService.Heartbeat:Connect(function(delta)
            if Config.SpeedHack > 1 then
                game:GetService("ScriptContext").DeltaTime = delta / Config.SpeedHack
            end
        end)
    end
end

-- MULTI-CATCH
local function setMultiCatch(count)
    Config.MultiCatch = count
end

-- ============================================
-- 💰 ECONOMY FEATURES
-- ============================================

-- FREE SHOP
local function enableFreeShop()
    Config.FreeShop = true
    
    if RemoteCache.ProductCompleted then
        hookRemote(RemoteCache.ProductCompleted, function(original, self, productId, price)
            -- Set price to 0
            return original(self, productId, 0)
        end)
    end
    
    if RemoteCache.PromptPurchase then
        hookRemote(RemoteCache.PromptPurchase, function(original, self, productId)
            -- Auto confirm purchase
            if RemoteCache.ProductCompleted then
                RemoteCache.ProductCompleted:FireServer(productId, 0)
            end
            return original(self, productId)
        end)
    end
end

-- AUTO BUY BEST ITEMS
local function autoBuyBestItems()
    Config.AutoBuy = true
    
    spawn(function()
        while Config.AutoBuy do
            -- Buy best fishing rod
            if RemoteCache.PurchaseRod then
                pcall(function()
                    RemoteCache.PurchaseRod:InvokeServer("LEGENDARY_ROD") -- Change ID as needed
                end)
            end
            
            -- Buy best bait
            if RemoteCache.PurchaseBait then
                pcall(function()
                    RemoteCache.PurchaseBait:InvokeServer("LEGENDARY_BAIT") -- Change ID as needed
                end)
            end
            
            -- Buy skin crates
            if RemoteCache.PurchaseSkinCrate then
                pcall(function()
                    RemoteCache.PurchaseSkinCrate:InvokeServer()
                end)
            end
            
            task.wait(10)
        end
    end)
end

-- AUTO SELL
local function enableAutoSell(threshold)
    Config.AutoSell = true
    
    if RemoteCache.UpdateAutoSell then
        RemoteCache.UpdateAutoSell:InvokeServer(threshold or 100) -- 100% auto sell
    end
    
    -- Hook fish caught for immediate selling
    if RemoteCache.FishCaught then
        local original = RemoteCache.FishCaught.FireServer
        RemoteCache.FishCaught.FireServer = function(self, ...)
            local result = original(self, ...)
            
            -- Auto sell logic
            if Config.AutoSell then
                -- Add sell value to total
                TotalCoins = TotalCoins + 1000 -- Adjust based on fish value
            end
            
            return result
        end
    end
end

-- COIN FARMER
local function startCoinFarmer()
    spawn(function()
        while true do
            if RemoteCache.FishCaught then
                -- Spam rare fish catches for maximum coins
                for i = 1, 10 do
                    pcall(function()
                        RemoteCache.FishCaught:FireServer({
                            name = "Megalodon",
                            rarity = "Legendary",
                            value = 10000
                        })
                        TotalCoins = TotalCoins + 10000
                    end)
                end
            end
            task.wait(1)
        end
    end)
end

-- ============================================
-- 🎨 COSMETIC FEATURES
-- ============================================

-- ALL SKINS UNLOCKER
local function unlockAllSkins()
    Config.AllSkins = true
    
    local skins = {
        "DRAGON_ROD_SKIN",
        "PHOENIX_ROD_SKIN", 
        "KRAKEN_BAIT_SKIN",
        "GOLDEN_BAIT_SKIN",
        "RAINBOW_FISH_SKIN"
    }
    
    for _, skin in ipairs(skins) do
        -- Equip rod skins
        if RemoteCache.EquipRodSkin then
            pcall(function()
                RemoteCache.EquipRodSkin:FireServer(skin)
            end)
        end
        
        -- Equip bait skins
        if RemoteCache.EquipBaitSkin then
            pcall(function()
                RemoteCache.EquipBaitSkin:FireServer(skin)
            end)
        end
    end
    
    -- Roll skin crates for free
    if RemoteCache.RollSkinCrate then
        for i = 1, 20 do
            pcall(function()
                RemoteCache.RollSkinCrate:FireServer()
            end)
        end
    end
end

-- INVISIBLE FISHING
local function enableInvisibleFishing()
    if RemoteCache.BaitCastVisual then
        RemoteCache.BaitCastVisual.FireServer = function() end
    end
    
    if RemoteCache.CaughtFishVisual then
        RemoteCache.CaughtFishVisual.FireServer = function() end
    end
    
    if RemoteCache.PlayEffect then
        RemoteCache.PlayEffect.FireServer = function() end
    end
end

-- ============================================
-- 📊 ESP & VISUAL FEATURES
-- ============================================

-- FISH ESP (WALLHACK)
local function createFishESP()
    Config.ESPEnabled = true
    
    local function createESP(object, color)
        if not object or not object.Parent then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "FishESP"
        highlight.FillColor = color
        highlight.OutlineColor = color
        highlight.FillTransparency = 0.3
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = object
        
        FishESP[object] = highlight
    end
    
    -- Find fish in workspace
    spawn(function()
        while Config.ESPEnabled do
            for _, fish in pairs(Workspace:GetChildren()) do
                if fish.Name:lower():find("fish") then
                    if not FishESP[fish] then
                        createESP(fish, Color3.fromRGB(0, 255, 0))
                    end
                end
            end
            
            -- Clean up destroyed fish
            for fish, highlight in pairs(FishESP) do
                if not fish.Parent then
                    highlight:Destroy()
                    FishESP[fish] = nil
                end
            end
            
            task.wait(1)
        end
    end)
end

-- PLAYER ESP
local function createPlayerESP()
    spawn(function()
        while Config.ESPEnabled do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    if not PlayerESP[plr] then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "PlayerESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = plr.Character
                        
                        -- Add billboard with player name
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "PlayerName"
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = plr.Character
                        
                        local label = Instance.new("TextLabel")
                        label.Text = plr.Name
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.new(1, 1, 1)
                        label.TextStrokeTransparency = 0
                        label.Font = Enum.Font.GothamBold
                        label.Parent = billboard
                        
                        PlayerESP[plr] = {highlight = highlight, billboard = billboard}
                    end
                end
            end
            
            -- Clean up
            for plr, esp in pairs(PlayerESP) do
                if not plr.Parent or not plr.Character then
                    if esp.highlight then esp.highlight:Destroy() end
                    if esp.billboard then esp.billboard:Destroy() end
                    PlayerESP[plr] = nil
                end
            end
            
            task.wait(2)
        end
    end)
end

-- RADAR HACK
local function enableRadarHack()
    Config.RadarHack = true
    
    if RemoteCache.UpdateRadar then
        hookRemote(RemoteCache.UpdateRadar, function(original, self)
            -- Force radar to show ALL fish
            local fakeData = {
                fishCount = 50,
                rareFish = 10,
                positions = {}
            }
            
            -- Generate fake positions
            for i = 1, 20 do
                table.insert(fakeData.positions, {
                    x = math.random(-100, 100),
                    y = 0,
                    z = math.random(-100, 100),
                    type = "Legendary"
                })
            end
            
            return fakeData
        end)
    end
end

-- ============================================
-- 🎁 GIFT & QUEST FEATURES
-- ============================================

-- AUTO GIFT SYSTEM
local function enableAutoGift()
    Config.AutoGift = true
    
    spawn(function()
        while Config.AutoGift do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player then
                    -- Set as gift receiver
                    if RemoteCache.SetGiftReceiver then
                        pcall(function()
                            RemoteCache.SetGiftReceiver:InvokeServer(plr)
                        end)
                    end
                    
                    -- Send gift
                    if RemoteCache.UseGift then
                        pcall(function()
                            RemoteCache.UseGift:InvokeServer("LEGENDARY_GIFT")
                        end)
                    end
                end
            end
            task.wait(30)
        end
    end)
end

-- QUEST AUTOMATOR
local function enableQuestAuto()
    Config.QuestAuto = true
    
    -- Auto claim megalodon quest
    if RemoteCache.ClaimMegalodon then
        spawn(function()
            while Config.QuestAuto do
                pcall(function()
                    RemoteCache.ClaimMegalodon:InvokeServer()
                end)
                task.wait(60)
            end
        end)
    end
    
    -- Auto claim all notifications
    if RemoteCache.ClaimNotification then
        spawn(function()
            while Config.QuestAuto do
                pcall(function()
                    RemoteCache.ClaimNotification:FireServer()
                end)
                task.wait(10)
            end
        end)
    end
end

-- ============================================
-- ⚡ GOD MODE (ALL FEATURES)
-- ============================================

local function enableGodMode()
    print("⚡ ACTIVATING GOD MODE...")
    
    -- Activate ALL features
    startAutoFishing()
    enableNoCooldown()
    enablePerfectTiming()
    enableUnlimitedBait()
    setSpeedHack(10)
    setMultiCatch(10)
    enableFreeShop()
    enableAutoSell(100)
    unlockAllSkins()
    enableInvisibleFishing()
    createFishESP()
    createPlayerESP()
    enableRadarHack()
    enableAutoGift()
    enableQuestAuto()
    
    -- Start coin farmer
    startCoinFarmer()
    
    -- Auto buy best items
    autoBuyBestItems()
    
    Config.GodMode = true
    print("⚡ GOD MODE ACTIVATED!")
end

-- ============================================
-- 📱 GUI SYSTEM
-- ============================================

local function createMasterGUI()
    -- Remove old GUI
    if player.PlayerGui:FindFirstChild("UltimateCheatGUI") then
        player.PlayerGui.UltimateCheatGUI:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UltimateCheatGUI"
    ScreenGui.Parent = player.PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    -- Main Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0.4, 0, 0.8, 0)
    MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    
    local Title = Instance.new("TextLabel")
    Title.Text = "🎣 FISH IT ULTIMATE CHEAT v1.0"
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = Header
    
    -- Scrollable Content
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Parent = MainFrame
    ScrollFrame.Size = UDim2.new(1, -10, 1, -50)
    ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.ScrollBarThickness = 6
    
    -- Function to create toggle button
    local function createToggle(name, configKey, yPosition, description)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
        ToggleFrame.Position = UDim2.new(0, 5, 0, yPosition)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        ToggleFrame.Parent = ScrollFrame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 5)
        ToggleCorner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Text = name
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Position = UDim2.new(0.05, 0, 0, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0.2, 0, 0.7, 0)
        ToggleButton.Position = UDim2.new(0.75, 0, 0.15, 0)
        ToggleButton.Text = Config[configKey] and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleButton.TextColor3 = Color3.new(1, 1, 1)
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.Parent = ToggleFrame
        
        local DescLabel = Instance.new("TextLabel")
        DescLabel.Text = description
        DescLabel.Size = UDim2.new(1, -10, 0, 20)
        DescLabel.Position = UDim2.new(0, 5, 1, 0)
        DescLabel.BackgroundTransparency = 1
        DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextSize = 11
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = ToggleFrame
        
        ToggleButton.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            ToggleButton.Text = Config[configKey] and "ON" or "OFF"
            ToggleButton.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            
            -- Execute function based on toggle
            if configKey == "AutoFish" then
                if Config[configKey] then
                    startAutoFishing()
                else
                    stopAutoFishing()
                end
            elseif configKey == "NoCooldown" then
                if Config[configKey] then
                    enableNoCooldown()
                end
            elseif configKey == "PerfectTiming" then
                if Config[configKey] then
                    enablePerfectTiming()
                end
            elseif configKey == "UnlimitedBait" then
                if Config[configKey] then
                    enableUnlimitedBait()
                end
            elseif configKey == "FreeShop" then
                if Config[configKey] then
                    enableFreeShop()
                end
            elseif configKey == "AutoSell" then
                if Config[configKey] then
                    enableAutoSell()
                end
            elseif configKey == "AllSkins" then
                if Config[configKey] then
                    unlockAllSkins()
                end
            elseif configKey == "ESPEnabled" then
                if Config[configKey] then
                    createFishESP()
                    createPlayerESP()
                end
            elseif configKey == "RadarHack" then
                if Config[configKey] then
                    enableRadarHack()
                end
            elseif configKey == "AutoGift" then
                if Config[configKey] then
                    enableAutoGift()
                end
            elseif configKey == "QuestAuto" then
                if Config[configKey] then
                    enableQuestAuto()
                end
            elseif configKey == "AutoBuy" then
                if Config[configKey] then
                    autoBuyBestItems()
                end
            end
        end)
        
        return ToggleFrame
    end
    
    -- Create all toggles
    local yPos = 0
    local toggles = {
        {"🎣 Auto Fishing", "AutoFish", "Automatically catches fish"},
        {"⚡ No Cooldown", "NoCooldown", "Instant fishing charge"},
        {"🎯 Perfect Timing", "PerfectTiming", "Always perfect catches"},
        {"🪱 Unlimited Bait", "UnlimitedBait", "Bait never runs out"},
        {"💰 Free Shop", "FreeShop", "Buy items for free"},
        {"📈 Auto Sell", "AutoSell", "Automatically sell fish"},
        {"🛒 Auto Buy", "AutoBuy", "Auto purchase best items"},
        {"🎨 All Skins", "AllSkins", "Unlock all skins"},
        {"👁️ Fish ESP", "ESPEnabled", "See fish through walls"},
        {"📡 Radar Hack", "RadarHack", "Enhanced radar"},
        {"🎁 Auto Gift", "AutoGift", "Auto send gifts"},
        {"🏆 Quest Auto", "QuestAuto", "Auto complete quests"},
    }
    
    for _, toggleData in ipairs(toggles) do
        local toggle = createToggle(toggleData[1], toggleData[2], yPos, toggleData[3])
        yPos = yPos + 60
    end
    
    -- Speed Hack Slider
    local SpeedFrame = Instance.new("Frame")
    SpeedFrame.Size = UDim2.new(1, -10, 0, 50)
    SpeedFrame.Position = UDim2.new(0, 5, 0, yPos)
    SpeedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    SpeedFrame.Parent = ScrollFrame
    
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Text = "⚡ Speed Hack: " .. Config.SpeedHack .. "x"
    SpeedLabel.Size = UDim2.new(1, 0, 0.5, 0)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
    SpeedLabel.Font = Enum.Font.GothamBold
    SpeedLabel.Parent = SpeedFrame
    
    local SpeedSlider = Instance.new("TextButton")
    SpeedSlider.Text = "Adjust Speed (1-20x)"
    SpeedSlider.Size = UDim2.new(0.8, 0, 0.4, 0)
    SpeedSlider.Position = UDim2.new(0.1, 0, 0.5, 0)
    SpeedSlider.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
    SpeedSlider.Font = Enum.Font.Gotham
    SpeedSlider.Parent = SpeedFrame
    
    SpeedSlider.MouseButton1Click:Connect(function()
        local newSpeed = Config.SpeedHack + 1
        if newSpeed > 20 then newSpeed = 1 end
        Config.SpeedHack = newSpeed
        setSpeedHack(newSpeed)
        SpeedLabel.Text = "⚡ Speed Hack: " .. newSpeed .. "x"
    end)
    
    yPos = yPos + 60
    
    -- Multi-Catch Slider
    local MultiFrame = Instance.new("Frame")
    MultiFrame.Size = UDim2.new(1, -10, 0, 50)
    MultiFrame.Position = UDim2.new(0, 5, 0, yPos)
    MultiFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MultiFrame.Parent = ScrollFrame
    
    local MultiLabel = Instance.new("TextLabel")
    MultiLabel.Text = "🐟 Multi-Catch: " .. Config.MultiCatch .. "x"
    MultiLabel.Size = UDim2.new(1, 0, 0.5, 0)
    MultiLabel.BackgroundTransparency = 1
    MultiLabel.TextColor3 = Color3.new(1, 1, 1)
    MultiLabel.Font = Enum.Font.GothamBold
    MultiLabel.Parent = MultiFrame
    
    local MultiSlider = Instance.new("TextButton")
    MultiSlider.Text = "Adjust Multi-Catch (1-10x)"
    MultiSlider.Size = UDim2.new(0.8, 0, 0.4, 0)
    MultiSlider.Position = UDim2.new(0.1, 0, 0.5, 0)
    MultiSlider.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    MultiSlider.TextColor3 = Color3.new(1, 1, 1)
    MultiSlider.Font = Enum.Font.Gotham
    MultiSlider.Parent = MultiFrame
    
    MultiSlider.MouseButton1Click:Connect(function()
        local newMulti = Config.MultiCatch + 1
        if newMulti > 10 then newMulti = 1 end
        Config.MultiCatch = newMulti
        setMultiCatch(newMulti)
        MultiLabel.Text = "🐟 Multi-Catch: " .. newMulti .. "x"
    end)
    
    yPos = yPos + 60
    
    -- God Mode Button
    local GodButton = Instance.new("TextButton")
    GodButton.Text = "⚡ ACTIVATE GOD MODE"
    GodButton.Size = UDim2.new(1, -20, 0, 50)
    GodButton.Position = UDim2.new(0, 10, 0, yPos)
    GodButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    GodButton.TextColor3 = Color3.new(0, 0, 0)
    GodButton.Font = Enum.Font.GothamBold
    GodButton.TextSize = 16
    GodButton.Parent = ScrollFrame
    
    GodButton.MouseButton1Click:Connect(function()
        enableGodMode()
        GodButton.Text = "⚡ GOD MODE ACTIVE!"
        GodButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    
    yPos = yPos + 70
    
    -- Stats Display
    local StatsFrame = Instance.new("Frame")
    StatsFrame.Size = UDim2.new(1, -10, 0, 80)
    StatsFrame.Position = UDim2.new(0, 5, 0, yPos)
    StatsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    StatsFrame.Parent = ScrollFrame
    
    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Text = "📊 LIVE STATS"
    StatsLabel.Size = UDim2.new(1, 0, 0.3, 0)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.TextColor3 = Color3.new(1, 1, 1)
    StatsLabel.Font = Enum.Font.GothamBold
    StatsLabel.Parent = StatsFrame
    
    local CatchesLabel = Instance.new("TextLabel")
    CatchesLabel.Name = "CatchesLabel"
    CatchesLabel.Text = "🎣 Catches: 0"
    CatchesLabel.Size = UDim2.new(1, 0, 0.25, 0)
    CatchesLabel.Position = UDim2.new(0, 0, 0.3, 0)
    CatchesLabel.BackgroundTransparency = 1
    CatchesLabel.TextColor3 = Color3.new(1, 1, 1)
    CatchesLabel.Font = Enum.Font.Gotham
    CatchesLabel.TextXAlignment = Enum.TextXAlignment.Left
    CatchesLabel.Parent = StatsFrame
    
    local CoinsLabel = Instance.new("TextLabel")
    CoinsLabel.Name = "CoinsLabel"
    CoinsLabel.Text = "💰 Coins Earned: 0"
    CoinsLabel.Size = UDim2.new(1, 0, 0.25, 0)
    CoinsLabel.Position = UDim2.new(0, 0, 0.55, 0)
    CoinsLabel.BackgroundTransparency = 1
    CoinsLabel.TextColor3 = Color3.new(1, 1, 1)
    CoinsLabel.Font = Enum.Font.Gotham
    CoinsLabel.TextXAlignment = Enum.TextXAlignment.Left
    CoinsLabel.Parent = StatsFrame
    
    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Name = "TimeLabel"
    TimeLabel.Text = "⏰ Session: 0s"
    TimeLabel.Size = UDim2.new(1, 0, 0.25, 0)
    TimeLabel.Position = UDim2.new(0, 0, 0.8, 0)
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.TextColor3 = Color3.new(1, 1, 1)
    TimeLabel.Font = Enum.Font.Gotham
    TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    TimeLabel.Parent = StatsFrame
    
    -- Update stats
    spawn(function()
        while ScreenGui.Parent do
            CatchesLabel.Text = "🎣 Catches: " .. CatchCount
            CoinsLabel.Text = "💰 Coins Earned: " .. TotalCoins
            TimeLabel.Text = "⏰ Session: " .. (os.time() - SessionStart) .. "s"
            task.wait(1)
        end
    end)
    
    yPos = yPos + 90
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "✕ CLOSE"
    CloseButton.Size = UDim2.new(1, -20, 0, 40)
    CloseButton.Position = UDim2.new(0, 10, 0, yPos)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = ScrollFrame
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Set canvas size
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
    
    return ScreenGui
end

-- ============================================
-- 🚀 MAIN EXECUTION
-- ============================================

-- Initialize
print("\n" .. string.rep("=", 60))
print("🎣 FISH IT - ULTIMATE CHEAT PACK v1.0")
print("🚀 Loading all features...")
print(string.rep("=", 60))

-- Find all remotes
findRemotes()

-- Create GUI
task.wait(1)
createMasterGUI()

-- Start stats updater
spawn(function()
    while task.wait(5) do
        -- Auto update radar if enabled
        if Config.RadarHack and RemoteCache.UpdateRadar then
            pcall(function()
                RemoteCache.UpdateRadar:InvokeServer()
            end)
        end
    end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        -- Toggle GUI
        local gui = player.PlayerGui:FindFirstChild("UltimateCheatGUI")
        if gui then
            gui.Enabled = not gui.Enabled
        end
    elseif input.KeyCode == Enum.KeyCode.F2 then
        -- Toggle Auto Fish
        Config.AutoFish = not Config.AutoFish
        if Config.AutoFish then
            startAutoFishing()
        else
            stopAutoFishing()
        end
    elseif input.KeyCode == Enum.KeyCode.F3 then
        -- Activate God Mode
        enableGodMode()
    end
end)

print("\n✅ CHEAT PACK LOADED SUCCESSFULLY!")
print("📱 GUI created! Check your screen!")
print("🎮 Keybinds:")
print("   F1 - Toggle GUI")
print("   F2 - Toggle Auto Fish")
print("   F3 - Activate God Mode")
print(string.rep("=", 60))
