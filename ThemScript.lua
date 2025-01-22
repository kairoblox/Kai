local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/CLAYKingMod/ScriptAllGames/refs/heads/main/CLAYKingModXAppleMod?token=GHSAT0AAAAAAC5VO6O7WIHL2NXBZS3I53I2Z4PWSPQ')))()

local Window = OrionLib:MakeWindow({Name = "CLAYKingModXAppleMod", HidePremium = false, SaveConfig = true, ConfigFolder = "dxl_bf"})

local Tab = Window:MakeTab({
	Name = "Blox Fruits",
	Icon = "rbxassetid://9933991033",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "Trẩu Roblox",
	Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/TrauHub/refs/heads/main/TrauTX"))()
  	end    
})