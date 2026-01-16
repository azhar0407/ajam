-- Fish It - Performance & Fishing Cheat
-- Real Working Cheats for Android

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Wait for game
if not game:IsLoaded() then
    game.Loaded:Wait()
end
task.wait(2)

-- CONFIG
local Config = {
    FastFish = false,      -- No delay fishing
    NoAnimations = false,  -- Remove animations
    BoostFPS = false,      -- Performance boost
    AutoFish = false,      -- Auto toggle game's auto fish
    InstantBait = false,   -- Instant bait throw
    HidePlayers = false,   -- Hide other players
    SimpleWater = false,   -- Simple water graphics
    RemoveEffects = false, -- Remove visual effects
    NoParticles = false,   -- Remove particles
    LowGraphics = false    -- Ultra low graphics
}

-- REMOTE CACHE
local Remotes = {}

-- FIND KEY REMOTES
local function setupRemotes()
    print("🔍 Setting up remotes...")
    
    -- Fishing remotes
    Remotes.UpdateAutoFish = ReplicatedStorage:FindFirstChild("RF/UpdateAutoFishingState", true)
    Remotes.ChargeRod = ReplicatedStorage:FindFirstChild("RF/ChargeFishingRod", true)
    Remotes.CancelInputs = ReplicatedStorage:FindFirstChild("RF/CancelFishingInputs", true)
    Remotes.RequestMinigame = ReplicatedStorage:FindFirstChild("RF/RequestFishingMinigameStarted", true)
    Remotes.FishCaught = ReplicatedStorage:FindFirstChild("RE/FishCaught", true)
    Remotes.FishingCompleted = ReplicatedStorage:FindFirstChild("RE/FishingCompleted", true)
    Remotes.BaitCast = ReplicatedStorage:FindFirstChild("RE/BaitCastVisual", true)
    Remotes.PlayEffect = ReplicatedStorage:FindFirstChild("RE/PlayFishingEffect", true)
    
    -- Check which remotes exist
    for name, remote in pairs(Remotes) do
        if remote then
            print("✅ " .. name)
        else
            print("❌ " .. name .. " (not found)")
        end
    end
    
    return Remotes
end

-- ============================================
-- 🎣 FAST FISHING (NO DELAY)
-- ============================================

local function enableFastFishing()
    Config.FastFish = true
    print("⚡ Enabling Fast Fishing...")
    
    -- Hook untuk mengurangi delay
    if Remotes.ChargeRod then
        -- Instant charge
        local originalCharge = Remotes.ChargeRod.InvokeServer
        Remotes.ChargeRod.InvokeServer = function(self, ...)
            return true -- Instant success
        end
    end
    
    -- Hook untuk instant minigame
    if Remotes.RequestMinigame then
        local originalRequest = Remotes.RequestMinigame.InvokeServer
        Remotes.RequestMinigame.InvokeServer = function(self, ...)
            -- Immediately complete minigame
            if Remotes.FishingCompleted then
                Remotes.FishingCompleted:FireServer()
            end
            return true
        end
    end
    
    -- Fishing loop yang cepat
    spawn(function()
        while Config.FastFish do
            -- Fast fishing cycle
            if Remotes.ChargeRod then
                pcall(function() Remotes.ChargeRod:InvokeServer() end)
            end
            
            -- Fast catch
            if Remotes.FishCaught then
                pcall(function()
                    Remotes.FishCaught:FireServer({
                        name = "Fast Fish",
                        value = 100
                    })
                end)
            end
            
            task.wait(0.5) -- Very fast cycle
        end
    end)
    
    print("✅ Fast Fishing enabled!")
end

-- ============================================
-- 🎭 NO ANIMATIONS
-- ============================================

local function removeAnimations()
    Config.NoAnimations = true
    print("🎭 Removing animations...")
    
    -- Remove character animations
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 32 -- Increase walk speed
            humanoid.JumpPower = 75 -- Increase jump power
            
            -- Disable animation scripts
            for _, child in pairs(player.Character:GetDescendants()) do
                if child:IsA("Animation") then
                    child:Destroy()
                elseif child:IsA("AnimationController") then
                    child:Destroy()
                end
            end
        end
    end
    
    -- Remove fishing animations
    spawn(function()
        while Config.NoAnimations do
            -- Find and remove fishing animations
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:find("Animation") or obj.Name:find("Anim") then
                    if obj:IsA("Animation") or obj:IsA("AnimationTrack") then
                        pcall(function() obj:Destroy() end)
                    end
                end
                
                -- Remove particles
                if Config.NoParticles then
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                        pcall(function() obj:Destroy() end)
                    end
                end
            end
            
            task.wait(2)
        end
    end)
    
    print("✅ Animations removed!")
end

-- ============================================
-- ⚡ BOOST FPS
-- ============================================

local function boostFPS()
    Config.BoostFPS = true
    print("⚡ Boosting FPS...")
    
    -- Graphics settings
    settings().Rendering.QualityLevel = 1
    settings().Rendering.MeshCacheSize = 0
    
    -- Lighting optimizations
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.Brightness = 2
    Lighting.Outlines = false
    Lighting.Technology = Enum.Technology.Compatibility
    
    -- Terrain
    if Workspace.Terrain then
        Workspace.Terrain.WaterWaveSize = 0
        Workspace.Terrain.WaterWaveSpeed = 0
        Workspace.Terrain.WaterReflectance = 0
        Workspace.Terrain.WaterTransparency = 0
    end
    
    -- Remove decorative objects
    spawn(function()
        while Config.BoostFPS do
            for _, obj in pairs(Workspace:GetDescendants()) do
                -- Remove unnecessary objects
                if obj:IsA("Part") then
                    if obj.Material == Enum.Material.Neon or obj.Material == Enum.Material.Glass then
                        obj.Material = Enum.Material.Plastic
                    end
                    
                    if obj.Transparency > 0.5 then
                        obj.Transparency = 1
                    end
                end
                
                -- Remove particles
                if Config.NoParticles and obj:IsA("ParticleEmitter") then
                    pcall(function() obj:Destroy() end)
                end
            end
            task.wait(5)
        end
    end)
    
    print("✅ FPS boosted!")
end

-- ============================================
-- 🌊 SIMPLE WATER
-- ============================================

local function enableSimpleWater()
    Config.SimpleWater = true
    print("🌊 Simplifying water...")
    
    if Workspace.Terrain then
        Workspace.Terrain.WaterColor = Color3.fromRGB(100, 150, 255)
        Workspace.Terrain.WaterTransparency = 0.5
        Workspace.Terrain.WaterWaveSize = 0
        Workspace.Terrain.WaterWaveSpeed = 0
    end
    
    -- Remove water particles
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:find("Water") or obj.Name:find("Splash") then
            if obj:IsA("ParticleEmitter") then
                pcall(function() obj:Destroy() end)
            end
        end
    end
    
    print("✅ Water simplified!")
end

-- ============================================
-- 🚫 REMOVE EFFECTS
-- ============================================

local function removeEffects()
    Config.RemoveEffects = true
    print("🚫 Removing visual effects...")
    
    -- Hook fishing effects
    if Remotes.PlayEffect then
        local originalPlay = Remotes.PlayEffect.FireServer
        Remotes.PlayEffect.FireServer = function() end -- Disable effects
    end
    
    if Remotes.BaitCast then
        local originalBait = Remotes.BaitCast.FireServer
        Remotes.BaitCast.FireServer = function() end -- Disable bait effects
    end
    
    -- Remove existing effects
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:find("Effect") or obj.Name:find("Particle") or obj.Name:find("Sparkle") then
            if obj:IsA("Part") or obj:IsA("ParticleEmitter") or obj:IsA("Beam") then
                pcall(function() obj:Destroy() end)
            end
        end
    end
    
    print("✅ Effects removed!")
end

-- ============================================
-- 🎣 INSTANT BAIT THROW
-- ============================================

local function enableInstantBait()
    Config.InstantBait = true
    print("🎣 Enabling Instant Bait...")
    
    -- Hook bait throwing
    if Remotes.ChargeRod then
        spawn(function()
            while Config.InstantBait do
                -- Continuously charge for instant bait
                pcall(function()
                    Remotes.ChargeRod:InvokeServer()
                end)
                task.wait(0.1)
            end
        end)
    end
    
    -- Auto complete fishing
    if Remotes.RequestMinigame then
        local original = Remotes.RequestMinigame.InvokeServer
        Remotes.RequestMinigame.InvokeServer = function(self, ...)
            -- Immediately return success
            if Remotes.FishingCompleted then
                Remotes.FishingCompleted:FireServer()
            end
            return true
        end
    end
    
    print("✅ Instant Bait enabled!")
end

-- ============================================
-- 👤 HIDE PLAYERS
-- ============================================

local function hidePlayers()
    Config.HidePlayers = true
    print("👤 Hiding other players...")
    
    spawn(function()
        while Config.HidePlayers do
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    -- Make other players transparent
                    for _, part in pairs(otherPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
    
    print("✅ Players hidden!")
end

-- ============================================
-- 📱 SIMPLE GUI
-- ============================================

local function createSimpleGUI()
    -- Remove old GUI
    if player.PlayerGui:FindFirstChild("PerfCheatGUI") then
        player.PlayerGui.PerfCheatGUI:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PerfCheatGUI"
    ScreenGui.Parent = player.PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    Header.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Text = "🎣 PERFORMANCE CHEAT"
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = Header
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Text = "X"
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0.05, 0)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Header
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Scroll Frame
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -10, 1, -50)
    ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.Parent = MainFrame
    
    -- Function to create toggle
    local yPos = 0
    local function createToggle(name, configKey, desc, func)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -10, 0, 50)
        ToggleFrame.Position = UDim2.new(0, 5, 0, yPos)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ToggleFrame.Parent = ScrollFrame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 5)
        ToggleCorner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Text = name
        Label.Size = UDim2.new(0.7, 0, 0.6, 0)
        Label.Position = UDim2.new(0.05, 0, 0.1, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local Desc = Instance.new("TextLabel")
        Desc.Text = desc
        Desc.Size = UDim2.new(0.9, 0, 0.3, 0)
        Desc.Position = UDim2.new(0.05, 0, 0.7, 0)
        Desc.BackgroundTransparency = 1
        Desc.TextColor3 = Color3.fromRGB(180, 180, 180)
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 11
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.Parent = ToggleFrame
        
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Text = Config[configKey] and "ON" or "OFF"
        ToggleBtn.Size = UDim2.new(0.2, 0, 0.6, 0)
        ToggleBtn.Position = UDim2.new(0.75, 0, 0.2, 0)
        ToggleBtn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.Parent = ToggleFrame
        
        ToggleBtn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            ToggleBtn.Text = Config[configKey] and "ON" or "OFF"
            ToggleBtn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            
            -- Execute function
            if func then
                func()
            end
        end)
        
        yPos = yPos + 55
        return ToggleFrame
    end
    
    -- Create all toggles
    createToggle("⚡ Fast Fishing", "FastFish", "No delay fishing", enableFastFishing)
    createToggle("🎭 No Animations", "NoAnimations", "Remove all animations", removeAnimations)
    createToggle("🆙 Boost FPS", "BoostFPS", "Increase performance", boostFPS)
    createToggle("🎣 Instant Bait", "InstantBait", "Throw bait instantly", enableInstantBait)
    createToggle("👤 Hide Players", "HidePlayers", "Hide other players", hidePlayers)
    createToggle("🌊 Simple Water", "SimpleWater", "Low quality water", enableSimpleWater)
    createToggle("🚫 Remove Effects", "RemoveEffects", "Remove visual effects", removeEffects)
    createToggle("✨ No Particles", "NoParticles", "Remove all particles", function()
        Config.NoParticles = true
        print("✨ Particles disabled!")
    end)
    
    -- Ultra Low Graphics Button
    local UltraBtn = Instance.new("TextButton")
    UltraBtn.Text = "💀 ULTRA LOW GRAPHICS"
    UltraBtn.Size = UDim2.new(1, -20, 0, 40)
    UltraBtn.Position = UDim2.new(0, 10, 0, yPos)
    UltraBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    UltraBtn.TextColor3 = Color3.new(1, 1, 1)
    UltraBtn.Font = Enum.Font.GothamBold
    UltraBtn.Parent = ScrollFrame
    
    UltraBtn.MouseButton1Click:Connect(function()
        -- Activate all performance features
        Config.FastFish = true
        Config.NoAnimations = true
        Config.BoostFPS = true
        Config.InstantBait = true
        Config.HidePlayers = true
        Config.SimpleWater = true
        Config.RemoveEffects = true
        Config.NoParticles = true
        
        -- Execute all functions
        enableFastFishing()
        removeAnimations()
        boostFPS()
        enableInstantBait()
        hidePlayers()
        enableSimpleWater()
        removeEffects()
        
        print("💀 ULTRA LOW GRAPHICS ACTIVATED!")
        UltraBtn.Text = "✅ ACTIVATED!"
        UltraBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end)
    
    yPos = yPos + 50
    
    -- Stats
    local StatsFrame = Instance.new("Frame")
    StatsFrame.Size = UDim2.new(1, -10, 0, 60)
    StatsFrame.Position = UDim2.new(0, 5, 0, yPos)
    StatsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    StatsFrame.Parent = ScrollFrame
    
    local FPSLabel = Instance.new("TextLabel")
    FPSLabel.Name = "FPSLabel"
    FPSLabel.Text = "FPS: --"
    FPSLabel.Size = UDim2.new(1, 0, 0.5, 0)
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.TextColor3 = Color3.new(1, 1, 1)
    FPSLabel.Font = Enum.Font.GothamBold
    FPSLabel.Parent = StatsFrame
    
    local PingLabel = Instance.new("TextLabel")
    PingLabel.Text = "Ping: --"
    PingLabel.Size = UDim2.new(1, 0, 0.5, 0)
    PingLabel.Position = UDim2.new(0, 0, 0.5, 0)
    PingLabel.BackgroundTransparency = 1
    PingLabel.TextColor3 = Color3.new(1, 1, 1)
    PingLabel.Font = Enum.Font.Gotham
    PingLabel.Parent = StatsFrame
    
    -- FPS Counter
    local lastTime = tick()
    local frameCount = 0
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        
        if tick() - lastTime >= 1 then
            local fps = math.floor(frameCount)
            FPSLabel.Text = "FPS: " .. fps
            frameCount = 0
            lastTime = tick()
        end
    end)
    
    -- Set canvas size
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 70)
    
    return ScreenGui
end

-- ============================================
-- 🚀 MANUAL FISHING WITH CHEATS
-- ============================================

local function manualFishingCheat()
    print("🎣 Manual Fishing Cheat Activated!")
    
    -- Setup faster fishing
    if Remotes.ChargeRod then
        spawn(function()
            while true do
                -- Auto charge when holding mouse
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    pcall(function()
                        Remotes.ChargeRod:InvokeServer()
                    end)
                end
                task.wait(0.05)
            end
        end)
    end
    
    -- Auto complete minigame
    if Remotes.RequestMinigame then
        local original = Remotes.RequestMinigame.InvokeServer
        Remotes.RequestMinigame.InvokeServer = function(self, ...)
            -- Skip minigame, auto complete
            if Remotes.FishingCompleted then
                task.wait(0.1)
                Remotes.FishingCompleted:FireServer()
            end
            return true
        end
    end
    
    -- Faster fish caught
    if Remotes.FishCaught then
        spawn(function()
            while true do
                -- Check if we're fishing
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    task.wait(1) -- Wait a bit
                    pcall(function()
                        Remotes.FishCaught:FireServer({
                            name = "Cheated Fish",
                            value = 500
                        })
                    end)
                end
                task.wait(0.5)
            end
        end)
    end
end

-- ============================================
-- 📞 COMMAND SYSTEM
-- ============================================

local function setupCommands()
    print("💬 Commands available:")
    print("   /fast - Enable fast fishing")
    print("   /nofx - Remove animations/effects")
    print("   /fps  - Boost FPS")
    print("   /hide - Hide other players")
    print("   /water - Simple water")
    print("   /manual - Manual fishing cheat")
    print("   /ultra - Ultra low graphics")
    print("   /gui - Toggle GUI")
    
    -- Chat listener
    player.Chatted:Connect(function(msg)
        msg = msg:lower()
        
        if msg == "/fast" then
            enableFastFishing()
        elseif msg == "/nofx" then
            removeAnimations()
            removeEffects()
        elseif msg == "/fps" then
            boostFPS()
        elseif msg == "/hide" then
            hidePlayers()
        elseif msg == "/water" then
            enableSimpleWater()
        elseif msg == "/manual" then
            manualFishingCheat()
        elseif msg == "/ultra" then
            -- Activate all performance cheats
            enableFastFishing()
            removeAnimations()
            boostFPS()
            hidePlayers()
            enableSimpleWater()
            removeEffects()
            print("💀 All performance cheats activated!")
        elseif msg == "/gui" then
            local gui = player.PlayerGui:FindFirstChild("PerfCheatGUI")
            if gui then
                gui.Enabled = not gui.Enabled
            else
                createSimpleGUI()
            end
        end
    end)
end

-- ============================================
-- 🚀 MAIN EXECUTION
-- ============================================

print("\n" .. string.rep("=", 50))
print("🎣 FISH IT - PERFORMANCE CHEAT")
print("⚡ Fast Fishing + FPS Boost + No Animations")
print(string.rep("=", 50))

-- Setup remotes
setupRemotes()

-- Create GUI
task.wait(1)
createSimpleGUI()

-- Setup commands
setupCommands()

-- Auto enable some features
task.wait(2)
boostFPS()
enableSimpleWater()

print("\n✅ CHEAT LOADED!")
print("📱 GUI created! Use commands or GUI toggles")
print("🎮 Commands: /fast /fps /nofx /hide /water")
print("🎯 Manual fishing is now SUPER FAST!")
print(string.rep("=", 50))

-- Keybinds
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        -- Toggle GUI
        local gui = player.PlayerGui:FindFirstChild("PerfCheatGUI")
        if gui then
            gui.Enabled = not gui.Enabled
        else
            createSimpleGUI()
        end
    elseif input.KeyCode == Enum.KeyCode.F2 then
        -- Toggle fast fishing
        Config.FastFish = not Config.FastFish
        if Config.FastFish then
            enableFastFishing()
            print("⚡ Fast Fishing ON")
        else
            print("⚡ Fast Fishing OFF")
        end
    elseif input.KeyCode == Enum.KeyCode.F3 then
        -- Ultra low graphics
        boostFPS()
        removeAnimations()
        enableSimpleWater()
        hidePlayers()
        print("💀 Ultra low graphics activated!")
    end
end)

-- Performance monitor
spawn(function()
    while true do
        -- Keep FPS boosted
        if Config.BoostFPS then
            settings().Rendering.QualityLevel = 1
            Lighting.GlobalShadows = false
        end
        
        -- Keep players hidden
        if Config.HidePlayers then
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    for _, part in pairs(otherPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                        end
                    end
                end
            end
        end
        
        task.wait(2)
    end
end)
