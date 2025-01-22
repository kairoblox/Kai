local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/CLAYKingMod/ScriptAllGames/dd73e5cf891f9ea1238fbeebdc27a9bc7f107eae/CLAYKingModXAppleMod')))()

local Window = OrionLib:MakeWindow({Name = "CLAYKingModXAppleMod", HidePremium = false, SaveConfig = true, ConfigFolder = "dxl_bf"})

local Tab = Window:MakeTab({
	Name = "Blox Fruit",
	Icon = "rbxassetid://9933991033",
	PremiumOnly = false
})

local Tab2 = Window:MakeTab({
	Name = "Blue Lock: Rivals",
	Icon = "rbxassetid://9933991033",
	PremiumOnly = false
})

local Tab3 = Window:MakeTab({
	Name = "Mod Game",
	Icon = "rbxassetid://9933991033",
	PremiumOnly = false
})

local Tab4 = Window:MakeTab({
	Name = "Function BloxFruit",
	Icon = "rbxassetid://9933991033",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "NEW: Alchemy",
	Callback = function()
       loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
  	end    
})
Tab:AddButton({
	Name = "NEW: Banana",
	Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptRUs/BananaHub/main/BananaHub.lua"))()
  	end    
})
Tab:AddButton({
	Name = "NEW: BLUE X",
	Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/EN.lua"))()
  	end    
})

Tab:AddButton({
	Name = "Chests Farm",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NickelHUBB/SonicTuru/main/ChestFarmOp"))()
end    
})

Tab3:AddButton({
	Name = "Fix Lag",
	Callback = function()
        repeat wait(5) until game:IsLoaded()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
end
})

Tab3:AddButton({
	Name = "Anti Kick",
	Callback = function()
        repeat wait(5) until game:IsLoaded()
     loadstring(game:HttpGet("https://pastebin.com/raw/FPfaukXN"))()
end
})


Tab3:AddButton({
	Name = "Fruit Finder",
	Callback = function()
        repeat wait(5) until game:IsLoaded()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/AdminusGames/Blox_Fruits_Sniper/main/.lua'))()
  	end    
})

Tab4:AddButton({
	Name = "Arceus X",
	Callback = function()
        repeat wait(5) until game:IsLoaded()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
end
})
