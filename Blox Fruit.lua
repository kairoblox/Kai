print("B3sty Libary Is Loaded")
repeat wait() until game:IsLoaded()

Empty_Function = function(...) return ... end
if not LPH_OBFUSCATED then
    LPH_JIT_ULTRA = Empty_Function
    LPH_JIT_MAX = Empty_Function
    LPH_JIT = Empty_Function
end

getgenv().json = {}
json.encode = function (tbl)
    return game:GetService("HttpService"):JSONEncode(tbl)
end
json.decode = function (tbl)
    return game:GetService("HttpService"):JSONDecode(tbl)
end

setfflag("HumanoidParallelRemoveNoPhysics", "False")
setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
-- Create Table
local B3sty = setmetatable({},{
    __index = function (self,key)
        return rawget(self,key)
    end,
    __newindex = function (self, key, value)
        if type(value) == "function" then
            return rawset(self,key,LPH_JIT_ULTRA(value))
        end
        return rawset(self,key,value)
    end
})
-- Data
local Animation = Instance.new("Animation")
B3sty.ProductInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
B3sty.MaxLevel = tonumber(B3sty.ProductInfo.Description:match('Current level cap: (%d+)'))
B3sty.Sea = (game.PlaceId == 2753915549 and 1) or (game.PlaceId == 4442272183 or 2) or (game.PlaceId == 7449423635 and 2) or 0
B3sty.Players = {}
B3sty.Stats = {}
B3sty.Signal = {}
B3sty.Entrance = {
    {
        ["Sky3"] = Vector3.new(-7894, 5547, -380),
        ["Sky3 Exit"] = Vector3.new(-4607, 874, -1667),
        ["Underwater City"] = Vector3.new(61163, 11, 1819),
        ["Underwater Exit"] = Vector3.new(4050, -1, -1814),
    },
    {
        ["Swan Mansion"] = Vector3.new(-390, 332, 673),
        ["Swan Room"] = Vector3.new(2285, 15, 905),
        ["Cursed Ship"] = Vector3.new(923, 126, 32852),
    },
    {
        ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
        ["Hydra Island"] = Vector3.new(5745, 610, -267),
        ["Mansion"] = Vector3.new(-12462, 375, -7552),
        ["Castle"] = Vector3.new(-5036, 315, -3179),
    }
}
function B3sty.Signal:Fire(...)
    self.Fired = true
    for i,v in next,self.Callback do
        if type(v) == 'function' then
            task.spawn(v,...)
        elseif type(v) == "thread" then
            task.spawn(coroutine.resume, v, ...)
            table.remove(self.Callbacks, table.find(self.Callbacks, v))
        end
    end
    return B3sty.Signal
end

function B3sty.Signal:Wait()
    if Arg == "f" and self.Fired then
        return;
    end

    table.insert(self.Callbacks, coroutine.running())

    return coroutine.yield()
end

function B3sty.Signal:Connect()
    table.insert(self.Callbacks, Callback)
    
    return self
end

function B3sty.Signal:Disconnect()
    table.remove(self.Callbacks, table.find(self.Callbacks, Callback))
end

function B3sty.Signal:new()
    return setmetatable({Callback = {}},{__index = B3sty.Signal})
end

B3sty.GameLib = {
    ["Quest"] = require(game:GetService("ReplicatedStorage").Quests),
    ["NPCList"] = getupvalues(require(game:GetService("ReplicatedStorage").Queue).new)[1][1].NPCDialogueEnabler.bin,
    ["GuideModule"] = require(game:GetService("ReplicatedStorage").GuideModule),
    ["Combat"] =  getupvalue(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework),2)
}
B3sty.Players.Team = game.Players.LocalPlayer.Team.Name
B3sty.Players.Client = game.Players.LocalPlayer
B3sty.Players.Char = game.Players.LocalPlayer.Character
B3sty.Players.Hum = game.Players.LocalPlayer.Character.Humanoid


local MAP = {}
for i,v in next,game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren() do
    if v:IsA("Part") then
        MAP[v.Name] = v
    end
end
local MAPINFO = setmetatable({},{
    __index = function (self, key)
        local IsLand = MAP[key]
        if IsLand then
            if IsLand:IsA("Part") then
                return {
                    ["Name"] = key,
                    ["CFrame"] = IsLand.CFrame,
                    ["Distance"] = LPH_JIT_MAX(function(Pos)
                        local Pos = Pos or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        return (Pos.Position - IsLand.CFrame.Position).magnitude
                    end),
                    ["In IsLand"] = LPH_JIT_MAX(function(Pos)
                        local Pos = Pos or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        local isLandPosition = IsLand.CFrame.Position
                        local R = IsLand.Mesh.Scale.X/2
                        return (Pos.Position - isLandPosition).magnitude <= R
                    end),
                    ["Is Entrance"] = (function ()
                        if key == "Fishmen" then
                            return game:GetService("Workspace").Map.TeleportSpawn.EntrancePoint
                        end
                        for i,v in next, IsLand:GetChildren() do
                            if v.Name:find("EntrancePoint") or v.Name:find("TeleportSpawn") then
                                return v
                            end
                        end
                        return false
                    end)()
                }
            end
        end
        return rawget(self, key)
    end
})
-- Function
function B3sty:GetStat()
    for i,v in next,game:GetService("Players").LocalPlayer.Data.Stats:GetChildren() do
        B3sty.Stats[v.Name] = {}
        for _,va in next,v:GetChildren() do
            B3sty.Stats[v.Name][va.Na] = va.Value
        end
    end
    return B3sty.Stats
end
function B3sty:Dist(a,b,c)
    return (Vector3.new(a.x,not c and a.y,a.z) - Vector3.new(b.x,not c and b.y,b.z)).magnitude
end
function B3sty:GetClosestIsLand(TagetPos)
    local DistLess,IsLand = math.huge
    for i,v in next,MAP do
        local IsLandData = MAPINFO[i]
        if IsLandData and IsLandData.Name ~= "Sea" then
            if DistLess > IsLandData.Distance(TagetPos) then
                DistLess = IsLandData.Distance(TagetPos)
                IsLand = IsLandData
            end
        end
    end
    return IsLand
end
function B3sty:GetInIsLand(TagetPos)
    for i,v in next,MAP do
        if MAPINFO[i] and MAPINFO[i]["In IsLand"](Pos) then
            return i
        end
    end
    return "Sea"
end

function B3sty:Tween(Pos)
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Pos.Position).magnitude >= 300 then
        if not game:GetService("Workspace"):FindFirstChild("B3sty") then
            local LOL = Instance.new("Part")
            LOL.Name = "B3sty"
            LOL.Parent = game.Workspace
            LOL.Anchored = true
            LOL.Transparency = .8
            LOL.Size = Vector3.new(1,1,1)
            LOL.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
        tween =
            game:GetService("TweenService"):Create(
                game:GetService("Workspace"):FindFirstChild("B3sty"),
            TweenInfo.new((5 / 1000) * (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Pos.Position).magnitude, Enum.EasingStyle.Linear),
            {CFrame = CFrame.new(Pos.Position)}
        )
        tween:Play()
        while tween.PlaybackState == Enum.PlaybackState.Playing and game:GetService("Workspace"):FindFirstChild("B3sty") and game.Players.LocalPlayer.Character.Humanoid.Health >= 1 do task.wait()
            if ((game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Pos.Position).magnitude <= 200) then
                pcall(function (...)
                    tween:Stop()
                end)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.Position)
                break
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace"):FindFirstChild("B3sty").CFrame
            end
        end
        if game:GetService("Workspace"):FindFirstChild("B3sty") then
            game:GetService("Workspace"):FindFirstChild("B3sty"):Destroy()
        end
    else
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.Position)
    end
end
function B3sty:IsEntrance(Name)
    return B3sty.Entrance[B3sty.Sea][Name]
end

function B3sty:Teleport(Pos)
    local InIsLand = B3sty:GetClosestIsLand(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
    local TargetClosetIsLand = B3sty:GetClosestIsLand(Pos)
    if InIsLand.Name ~= TargetClosetIsLand.Name then
        local Entrance = B3sty:IsEntrance(TargetClosetIsLand.Name)
        if not Entrance then
            local Exit = B3sty:IsEntrance(InIsLand.Name.." Exit")
            if Exit then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Exit)
                wait(1)
            end
            local LastspawnBypass,less = nil, math.huge
            for i,v in next,game:GetService("Workspace")["_WorldOrigin"].PlayerSpawns[B3sty.Players.Team]:GetChildren() do
                local Dist = B3sty:Dist(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position,v:GetPivot().p,true)
                if Dist < less then
                    less = Dist
                    LastspawnBypass = v
                end
            end
            if LastspawnBypass then
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = TargetClosetIsLand.CFrame
                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
                repeat task.wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TargetClosetIsLand.CFrame
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("_SetLastSpawnPoint",LastspawnBypass.Name)
                until game.Players.LocalPlayer.Data:FindFirstChild("LastSpawnPoint").Value == LastspawnBypass.Name
                repeat task.wait() until game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                repeat task.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                repeat task.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health >= 1
            else
                print("Not Found")
            end
        else
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Entrance)
        end
        wait(1)
    end
    if B3sty:GetClosestIsLand(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame).Name ~= TargetClosetIsLand.Name then
        B3sty:Teleport(Pos)
    else
        B3sty:Tween(Pos)
    end
end

function B3sty:GetNPCQuest(Level)
    local Level = Level or game:GetService("Players").LocalPlayer.Data.Level.Value
    local NPC
    for i,v in next,B3sty.GameLib.GuideModule.Data.NPCList do
        for _, va in next, v.Levels do
            if va == Level then
                if v.NPCName ~= "Marine Leader" then
                    return v
                end
            end
        end
    end
    return NPC
end
do
    B3sty.Quest = {}
    B3sty.Boss = {}
    for Name,v in pairs(B3sty.GameLib["Quest"]) do
        for i,b in next,v do
            if b.Name ~= "Trainees" and not b.MeetsRequirements and b.Task[table.foreach(b.Task,tostring)] ~= 1 then
                local NPCQuest = B3sty:GetNPCQuest(b.LevelReq)
                b.MobName = (table.foreach(b.Task,tostring))
                if NPCQuest then
                    b.Quest = {
                        ["Name"] = Name,
                        ["Index"] = (function ()
                            for _i,_v in next,NPCQuest.Levels do
                                if _v == b.LevelReq then
                                    return _i
                                end
                            end
                        end)(),
                        ["Position"] = NPCQuest.Position,
                        ["NPCName"] = NPCQuest.NPCName
                    }
                    if ("Shanda"):find(b.MobName) or b.MobName == "Wysper" then
                        b.Quest.Position = Vector3.new(-7860, 5545, -380)
                    end
                    if ("God's Guard"):find(b.MobName) then
                        b.Quest.Position = Vector3.new(-4723, 845, -1951)
                    end
                    if b.MobName:sub(1,#b.MobName) == ("Bandit") then
                        b.Quest.Position = Vector3.new(1060, 16, 1549)
                    end
                    if b.MobName:sub(1,#b.MobName) == ("Zombie") then
                        b.Quest.Position = Vector3.new(-5494, 48, -794)
                    end
                    b.CanFarm = true
                else
                    b.CanFarm = false
                end
                table.insert(B3sty.Quest, b);
            elseif b.Task[table.foreach(b.Task,tostring)] == 1 then
                local NPCQuest = B3sty:GetNPCQuest(b.LevelReq)
                if NPCQuest then
                    b.Quest = {
                        ["Name"] = Name,
                        ["Index"] = (function ()
                            for _i,_v in next,NPCQuest.Levels do
                                if _v == b.LevelReq then
                                    return _i
                                end
                            end
                        end)(),
                        ["Position"] = NPCQuest.Position,
                        ["NPCName"] = NPCQuest.NPCName
                    }
                end
                b.MobName = (table.foreach(b.Task,tostring))
                table.insert(B3sty.Boss, b);
            end
        end
    end
    table.sort(B3sty.Quest, function(a, b)
        return a.LevelReq < b.LevelReq
    end)
end
function B3sty:IsQuest()
    return game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true
end
function B3sty:GetQuestMobName()
    if B3sty:IsQuest() then
        local Number, mobName, currentKills, totalQuest = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text:match("Defeat (%d+) ([%w%s]+[']?[%w%s]*) %((%d+)/(%d+)%)")
        mobName = string.sub(mobName,1,#mobName-1)
        return mobName
    end
end
function B3sty:QuestCompletionPercent()
    if B3sty:IsQuest() then
        local Number, mobName, currentKills, totalQuest = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text:match("Defeat (%d+) ([%w%s]+[']?[%w%s]*) %((%d+)/(%d+)%)")
        return (currentKills / totalQuest) * 100
    end
end
function B3sty:GetQuest(Level,Position)
    local Position = Position or {-1}
    local PreviousQuest = {}
    local Level = Level or game:GetService("Players").LocalPlayer.Data.Level.Value or 0
    local Index = nil
    local closestQuest = nil
    local minDifference = nil
  
    for _, quest in pairs(B3sty.Quest) do
        local difference = Level - quest.LevelReq
        if difference >= 0 and (minDifference == nil or difference < minDifference) then
            Index = _
            closestQuest = quest
            minDifference = difference
        end
    end
    for i,v in next, Position do
        if Index + v >= 1 then
            table.insert(PreviousQuest,B3sty.Quest[Index + v])
        end
    end
    return closestQuest , PreviousQuest
end
function B3sty:isnetworkowner(part)
    local Client = game.Players.LocalPlayer
    if typeof(part) == "Instance" and part:IsA("BasePart") then
        local Distance = math.clamp(Client.SimulationRadius,0,1250)
        local MyDist = Client:DistanceFromCharacter(part.Position)
        if MyDist < Distance then
            for i,v in pairs(game.Players:GetPlayers()) do
                if v:DistanceFromCharacter(part.Position) < MyDist and v ~= Client then
                    return false
                end
            end
            return true
        end
    end
end
function B3sty:BringMobs(Mob) 
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (isnetworkowner(v.HumanoidRootPart) or B3sty:isnetworkowner(v.HumanoidRootPart) or (v.HumanoidRootPart.CFrame.Position - Mob.HumanoidRootPart.CFrame.Position).magnitude <= 200) and Mob ~= v and v.Name == Mob.Name then
            pcall(function (...)
                v.HumanoidRootPart.CFrame = CFrame.new(Mob.HumanoidRootPart.CFrame.Position)
                v.Humanoid.JumpPower = 0
                v.Humanoid.WalkSpeed = 0
                v.Humanoid.Sit = true	
                v.Humanoid.PlatformStand = true			
                v.Humanoid:ChangeState(14)
                v.HumanoidRootPart.CanCollide = false
                if v.Humanoid:FindFirstChild("Animator") then
                    v.Humanoid.Animator:Destroy()
                end
                sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
            end)
        end
    end
end
function B3sty:ActiveRig()
    return game:GetService("CollectionService"):GetTagged("ActiveRig")
end
function B3sty:GetClosestMob()
    local va,less = nil,math.huge
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.Position).magnitude < less and v:FindFirstChild("HumanoidRootPart") then
            less = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.Position).magnitude
            va = v
        end
    end
    return va
end
function B3sty:GetClosestMobByName(Name)
    local va,less = nil,math.huge
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.Position).magnitude < less and v.Name == Name and v:FindFirstChild("HumanoidRootPart") then
            less = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.Position).magnitude
            va = v
        end
    end
    return va
end
function B3sty:FastAttack()
    local Combat = B3sty.GameLib.Combat
    if Combat.activeController and Combat.activeController.attack and Combat.activeController.anims and Combat.activeController.currentWeaponModel then
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",Combat.activeController.currentWeaponModel.Name)
    end
end
function B3sty:Validator()
    local Combat = B3sty.GameLib.Combat
    if Combat.activeController and Combat.activeController.attack and Combat.activeController.anims then
        local upattack = getupvalues(Combat.activeController.attack)
        local u7 = upattack[4]
        local u8 = upattack[5]
        local u9 = upattack[6]
        local u10 = upattack[7]
        local u12 = (u8 * 798405 + u7 * 727595) % u9
        local u13 = u7 * 798405 
        (function() 
            u12 = (u12 * u9 +u13) % 1099511627776 
            u8 = math.floor(u12/u9) u7 = u12 - u8 * u9 
        end)()
        u10 = u10 + 1
        debug.setupvalue(Combat.activeController.attack,4,u7)
        debug.setupvalue(Combat.activeController.attack,5,u8)
        debug.setupvalue(Combat.activeController.attack,6,u9)
        debug.setupvalue(Combat.activeController.attack,7,u10)
        game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.floor(u12/ 1099511627776 * 16777215),u10)
    end
end
function B3sty:Attack()
    local Combat = B3sty.GameLib.Combat
    if Combat.activeController and Combat.activeController.attack and Combat.activeController.anims then
        local RootList = {}
        for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                table.insert(RootList,v.HumanoidRootPart)
            end
        end
        Animation.AnimationId = Combat.activeController.anims.basic[#Combat.activeController.anims.basic]
        local Playing = Combat.activeController.humanoid:LoadAnimation(Animation)
        Playing:Play(0.00075,0.01,0.01)
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit",RootList,#Combat.activeController.anims.basic,"")
        delay(.5,function()
            Playing:Stop()
        end)
    end
end
function B3sty:UpStats(Stats,Count)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint",Stats,Count or 1)
end
function B3sty:MobExist(Name)
    for i,v in next, game:GetService("CollectionService"):GetTagged("ActiveRig") do
        if v.Name == Name then
            return true
        end
    end
    return false
end
function B3sty:IsCombat()
    return game.Players.LocalPlayer.PlayerGui.Main.InCombat.Visible
end
function B3sty:HasTag(Tag,Object)
    return game:GetService("CollectionService"):HasTag(Object or game.Players.LocalPlayer.Character,Tag)
end
function B3sty:EquipWeapon(Tool)
    if type(Tool) == "string" then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool)
    end
    if Tool and Tool ~= B3sty.Players.Char then
        B3sty.Players.Hum:EquipTool(Tool)
    end
end
function B3sty:EquipWeapon(Tool)
    if type(Tool) == "string" then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool)
    end
    if Tool and Tool == B3sty.Players.Char then
        B3sty.Players.Hum:UnequipTools(Tool)
    end
end

function B3sty:InSafeZone()
    if B3sty.Players.Char and B3sty.Players.Char:FindFirstChild('Humanoid') then
        for _,SafeZone in pairs(game:GetService("Workspace")["_WorldOrigin"].SafeZones:GetChildren()) do
            if (v.HumanoidRootPart.Position - SafeZone.Position).magnitude <= SafeZone.Mesh.Scale.X/2 then
                return true
            end
        end
    end
    return false
end

function B3sty:Rejoin()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
end

function B3sty:SetFastMode(v)
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
end
function B3sty:WhiteScreen(v)
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
end

-- task.spawn(function ()
--     while true do task.wait()
--         for i,v in next, game:GetService("CollectionService"):GetTagged("ActiveRig") do
--             local Quest = B3sty:GetQuest()
--             if not B3sty:MobExist(Quest.MobName) then
--                 for i,v in next,game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren() do
--                     if B3sty:MobExist(Quest.MobName) then
--                         break
--                     end
--                     if v.Name == Quest.MobName then wait(.1)
--                         B3sty:Teleport(v.CFrame * CFrame.new(0,30,0))
--                         local s = tick()
--                         while tick() - s <= 1 do task.wait()
--                             B3sty:Teleport(v.CFrame * CFrame.new(0,30,0))
--                         end
--                     end
--                 end
--             end
--             if B3sty:IsQuest() and B3sty:GetQuestMobName() ~= Quest.MobName then
--                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer('AbandonQuest')
--             end
--             if not B3sty:IsQuest() then
--                 B3sty:Teleport(CFrame.new(Quest.Quest.Position))
--                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",Quest.Quest.Name,Quest.Quest.Index)
--                 wait(1)
--             else
--                 if v.Name == Quest.MobName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health >= 0 then
--                     v.HumanoidRootPart.CanCollide = false
--                     local OLDCF = v.HumanoidRootPart.CFrame
--                     local OH,CH  = v.Humanoid.Health , 0
--                     repeat task.wait()
--                         if OH >= v.Humanoid.Health then
--                             CH = CH + 1
--                         end
--                         B3sty:BringMobs(v)
--                         B3sty:Teleport(CFrame.new(v.HumanoidRootPart.CFrame.Position) * CFrame.new(0,30,0))
--                         B3sty:Attack()
--                     until not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart") or CH > 200 or game.Players.LocalPlayer.Character.Humanoid.Health <= 0
--                 end
--             end
--         end
--     end
-- end)
-- task.spawn(function ()
--     while true do task.wait(.3)
--         B3sty:Validator()
--         B3sty:FastAttack()
--     end
-- end)

return B3sty
