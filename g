local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local RS = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId

local function ListServers(cursor)
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=10"
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
end

local function SendNotification()
    StarterGui:SetCore("SendNotification", {
        Title = "kylies eggs",
        Text = "skidded",
        Icon = "https://www.roblox.com/asset?id=11104447788",
        Button1 = "thx",
    })
end

local function FindEggs()
    local eggs = {}
    for _, v in pairs(workspace.Ignored:GetChildren()) do
        if string.find(v.Name, "Egg") then
            table.insert(eggs, v)
        end
    end
    return eggs
end

local function TeleportToRandomServer()
    local Delay = 5 -- serverhops after 30 seconds ( change 30 to whatever you want)
    while wait(Delay) do
        Player.Character.HumanoidRootPart.Anchored = true
        local Servers = ListServers()
        local Server = Servers.data[math.random(1,#Servers.data)]
        TPS:TeleportToPlaceInstance(_place, Server.id, Player)
    end
end

RS.Heartbeat:Connect(function()
    local eggs = FindEggs()
    for _, v in pairs(eggs) do
        Player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
        wait(1)
    end
end)

-- Kickstart the processes
SendNotification()
TeleportToRandomServer()
