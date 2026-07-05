-- EVOMON ULTIMATE ASSISTANCE MOD MENU (BETUL)
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

if CoreGui:FindFirstChild("EvomonUltimateMenu") then
	CoreGui.EvomonUltimateMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EvomonUltimateMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(32, 32, 48)
Title.Text = "🧬 EVOMON ULTIMATE MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 520)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.Parent = Scroll

local function AddButton(text, color)
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(1, 0, 0, 40)
	Btn.BackgroundColor3 = color
	Btn.Text = text
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Font = Enum.Font.SourceSansBold
	Btn.TextSize = 14
	Btn.Parent = Scroll
	
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Btn
	return Btn
end

local CombatBtn    = AddButton("⚔️ One-Hit & Auto-Attack: MATI", Color3.fromRGB(180, 40, 40))
local AutoQuestBtn = AddButton("🗺️ Auto NPC & Quest: MATI", Color3.fromRGB(210, 120, 0))
local ClaimDaily   = AddButton("🎁 Claim Daily Reward (Pintas)", Color3.fromRGB(140, 40, 180))
local OpenShop     = AddButton("🛒 Buka Kedai / Gamepass UI", Color3.fromRGB(0, 140, 100))
local OpenInv      = AddButton("🎒 Buka Inventory Evomon", Color3.fromRGB(100, 100, 110))
local TeleportSpawn= AddButton("🚪 Teleport: Main Center", Color3.fromRGB(0, 100, 180))
local TeleportWild = AddButton("🐉 Teleport: Kawasan Evomon Liar", Color3.fromRGB(18, 80, 200)) -- Pembetulan di sini (18s -> 18)

local AutoAttack = false
local AutoQuest = false

CombatBtn.MouseButton1Click:Connect(function()
	AutoAttack = not AutoAttack
	if AutoAttack then
		CombatBtn.Text = "⚔️ Auto-Attack: AKTIF"
		CombatBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
	else
		CombatBtn.Text = "⚔️ Auto-Attack: MATI"
		CombatBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
	end
end)

RunService.Heartbeat:Connect(function()
	if AutoAttack and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		local tool = Player.Character:FindFirstChildOfClass("Tool")
		if tool then 
			tool:Activate()
		end
		
		for _, v in pairs(workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= Player.Name then
				local enemyHum = v:FindFirstChildOfClass("Humanoid")
				if enemyHum and enemyHum.Health > 0 then
					local dist = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
					if dist < 20 then
						enemyHum.Health = 0
					end
				end
			end
		end
	end
end)

AutoQuestBtn.MouseButton1Click:Connect(function()
	autoQuest = not autoQuest
	if autoQuest then
		AutoQuestBtn.Text = "🗺️ Auto Quest: AKTIF"
		AutoQuestBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
	else
		AutoQuestBtn.Text = "🗺️ Auto Quest: MATI"
		AutoQuestBtn.BackgroundColor3 = Color3.fromRGB(210, 120, 0)
	end
end)

OpenShop.MouseButton1Click:Connect(function()
	local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
	if PlayerGui then
		for _, v in pairs(PlayerGui:GetDescendants()) do
			if v:IsA("Frame") and (v.Name:lower():match("shop") or v.Name:lower():match("gamepass")) then
				v.Visible = not v.Visible
			end
		end
	end
end)

OpenInv.MouseButton1Click:Connect(function()
	local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
	if PlayerGui then
		for _, v in pairs(PlayerGui:GetDescendants()) do
			if v:IsA("Frame") and (v.Name:lower():match("inv") or v.Name:lower():match("bag") or v.Name:lower():match("pet")) then
				v.Visible = not v.Visible
			end
		end
	end
end)

ClaimDaily.MouseButton1Click:Connect(function()
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") and (v.Name:lower():match("daily") or v.Name:lower():match("reward")) then
			v:FireServer()
		end
	end
end)

TeleportSpawn.MouseButton1Click:Connect(function()
	if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
	end
end)

TeleportWild.MouseButton1Click:Connect(function()
	if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		for _, v in pairs(workspace:GetChildren()) do
			if v:IsA("Model") and (v.Name:lower():match("zone") or v.Name:lower():match("wild")) then
				Player.Character.HumanoidRootPart.CFrame = v:GetPivot()
				break
			end
		end
	end
end)

