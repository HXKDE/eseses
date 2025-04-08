repeat task.wait() until game.IsLoaded
repeat task.wait() until game.GameId ~= 0

if HXKDE and HXKDE.Loaded then
    HXKDE.SomeBitchass.UI:Push({
        Title = "Skidd Hub",
        Description = "Script already running!",
        Duration = 5
    }) return
end

--[[if HXKDE and (HXKDE.Game and not HXKDE.Loaded) then
    HXKDE.SomeBitchass.UI:Push({
        Title = "Skidd Hub",
        Description = "Something went wrong!",
        Duration = 5
    }) return
end]]

local PlayerService = game:GetService("Players")
repeat task.wait() until PlayerService.LocalPlayer
local LocalPlayer = PlayerService.LocalPlayer

local Branch, NotificationTime, IsLocal = ...
--local ClearTeleportQueue = clear_teleport_queue
local QueueOnTeleport = queue_on_teleport

local function GetFile(File)
    return IsLocal and readfile("HXKDE/" .. File)
    or game:HttpGet(("%s%s"):format(HXKDE.Source, File))
end

local function LoadScript(Script)
    return loadstring(GetFile(Script .. ".lua"), Script)()
end

local function GetGameInfo()
    for Id, Info in pairs(Parvus.Games) do
        if tostring(game.GameId) == Id then
            return Info
        end
    end

    return HXKDE.SomeBitchass
end

getgenv().Parvus = {
    Source = "https://github.com/HXKDE/eseses/tree/SomeBitchass" .. Branch .. "/",

    Games = {
        ["Universal" ] = { Name = "Universal",                  Script = "Universal"  },
        ["1168263273"] = { Name = "Bad Business",               Script = "Games/BB"   },
        ["3360073263"] = { Name = "Bad Business PTR",           Script = "Games/BB"   },
        ["1586272220"] = { Name = "Steel Titans",               Script = "Games/ST"   },
        ["807930589" ] = { Name = "The Wild West",              Script = "Games/TWW"  },
        ["580765040" ] = { Name = "RAGDOLL UNIVERSE",           Script = "Games/RU"   },
        ["187796008" ] = { Name = "Those Who Remain",           Script = "Games/TWR"  },
        ["358276974" ] = { Name = "Apocalypse Rising 2",        Script = "Games/AR2"  },
        ["3495983524"] = { Name = "Apocalypse Rising 2 Dev.",   Script = "Games/AR2"  },
        ["1054526971"] = { Name = "Blackhawk Rescue Mission 5", Script = "Games/BRM5" }
    }
}

HXKDE.SomeBitchass = LoadScript("Utilities/Main")
HXKDE.SomeBitchass.UI = LoadScript("Utilities/UI")
HXKDE.SomeBitchass.Physics = LoadScript("Utilities/Physics")
HXKDE.SomeBitchass.Drawing = LoadScript("Utilities/Drawing")

HXKDE.Cursor = GetFile("Utilities/ArrowCursor.png")
HXKDE.Loadstring = GetFile("Utilities/Loadstring")
HXKDE.Loadstring = Parvus.Loadstring:format(
    Parvus.Source, Branch, NotificationTime, tostring(IsLocal)
)

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.InProgress then
        --ClearTeleportQueue()
        QueueOnTeleport(Parvus.Loadstring)
    end
end)

HXKDE.Game = GetGameInfo()
LoadScript(Parvus.Game.Script)
HXKDE.Loaded = true

HXKDE.SomeBitchass.UI:Push({
    Title = "Skidd Hub",
    Description = Parvus.Game.Name .. " loaded!\n\nThis script is open sourced\nIf you have paid for this script\nOr had to go thru ads\nYou have been scammed.",
    Duration = NotificationTime
})
