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

getgenv().HXKDE = {
    Source = "https://github.com/HXKDE/eseses/tree/SomeBitchass" .. Branch .. "/",

    Games = {
        ["358276974" ] = { Name = "Apocalypse Rising 2",        Script = "Games/AR2"  }
        
    }
}

HXKDE.SomeBitchass = LoadScript("SomeBitchass/Main")
HXKDE.SomeBitchass.UI = LoadScript("SomeBitchass/UI")
HXKDE.SomeBitchass.Physics = LoadScript("SomeBitchass/Physics")
HXKDE.SomeBitchass.Drawing = LoadScript("SomeBitchass/Drawing")

HXKDE.Cursor = GetFile("SomeBitchass/ArrowCursor.png")
HXKDE.Loadstring = GetFile("SomeBitchass/Loadstring")
HXKDE.Loadstring = HXKDE.Loadstring:format(
    HXKDE.Source, Branch, NotificationTime, tostring(IsLocal)
)

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.InProgress then
        --ClearTeleportQueue()
        QueueOnTeleport(HXKDE.Loadstring)
    end
end)

HXKDE.Game = GetGameInfo()
LoadScript(HXKDE.SomeBitchass.Script)
HXKDE.Loaded = true

HXKDE.SomeBitchass.UI:Push({
    Title = "Skidd Hub",
    Description = HXKDE.SomeBitchass.Name .. " loaded!\n\nThis script is open sourced\nIf you have paid for this script\nOr had to go thru ads\nYou have been scammed.",
    Duration = NotificationTime
})
