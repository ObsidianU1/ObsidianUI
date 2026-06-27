local Obsidian = {}

-- AHEM.
-- forgive me thiz <3


-- Executor Environment
local getgenv = getgenv
local getrenv = getrenv
local getgc = getgc
local getreg = getreg
local getinstances = getinstances
local getnilinstances = getnilinstances
local getscripts = getscripts
local getloadedmodules = getloadedmodules
local getconnections = getconnections


-- Hooking
local hookfunction = hookfunction
local hookmetamethod = hookmetamethod
local newcclosure = newcclosure
local checkcaller = checkcaller
local getrawmetatable = getrawmetatable
local setrawmetatable = setrawmetatable


-- Debug
local getconstants = getconstants
local getconstant = getconstant
local setconstant = setconstant

local getupvalues = getupvalues
local getupvalue = getupvalue
local setupvalue = setupvalue


-- HTTP
local request = request
local http_request = http_request


-- File System
local readfile = readfile
local writefile = writefile
local appendfile = appendfile
local delfile = delfile

local isfile = isfile
local listfiles = listfiles
local makefolder = makefolder
local isfolder = isfolder


-- Clipboard
local setclipboard = setclipboard


-- Executor Info
local identifyexecutor = identifyexecutor
local getexecutorname = getexecutorname
local getexecutorversion = getexecutorversion


-- Roblox Functions
local fireclickdetector = fireclickdetector
local firetouchinterest = firetouchinterest
local fireproximityprompt = fireproximityprompt


-- FPS
local setfpscap = setfpscap
local getfpscap = getfpscap



-- UI LIB --


local function Create(class,parent,properties)

    local object = Instance.new(class)

    for property,value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end



function Obsidian.createGUI(settings)

    settings = settings or {}


    -- Default Settings

    settings.Name =
        settings.Name or "Obsidian"


    settings.Creator =
        settings.Creator or
        "SDev Roblox: @Alexander14706(Guest)"


    settings.Designer =
        settings.Designer or {}


    settings.Designer.Design =
        settings.Designer.Design or
        "Default"



    local gui = {
        Tabs = {}
    }



    -- PlayerGui

    local PlayerGui =
        game:GetService("Players")
        .LocalPlayer
        :WaitForChild("PlayerGui")



    -- ScreenGui

    local ScreenGui = Create(
        "ScreenGui",
        PlayerGui,
        {
            Name = settings.Name,
            ResetOnSpawn = false
        }
    )



    -- Main Window

    local Window = Create(
        "Frame",
        ScreenGui,
        {
            Name = "Window",
            Size = UDim2.fromOffset(600,400),
            Position = UDim2.fromScale(.5,.5),
            AnchorPoint = Vector2.new(.5,.5),
            BackgroundColor3 =
                Color3.fromRGB(25,25,30)
        }
    )



    -- Wallpaper

    local Wallpaper = Create(
        "ImageLabel",
        Window,
        {
            Name = "Wallpaper",
            Size = UDim2.fromScale(1,1),
            BackgroundTransparency = 1,
            Image = settings.Wallpaper or "rbxassetid://122715268314459"
        }
    )



    -- Title

    local Title = Create(
        "TextLabel",
        Window,
        {
            Name="Title",
            Size=UDim2.new(1,0,0,35),
            BackgroundTransparency=1,
            Text=settings.Name,
            TextColor3=Color3.new(1,1,1),
            TextSize=20
        }
    )



    -- Container

    local Container = Create(
        "Frame",
        Window,
        {
            Name="Container",
            Position=UDim2.fromOffset(0,35),
            Size=UDim2.new(1,0,1,-35),
            BackgroundTransparency=1
        }
    )



    -- Drag System

    do

        local UIS =
            game:GetService("UserInputService")


        local dragging = false
        local dragStart
        local startPosition


        Title.InputBegan:Connect(function(input)

            if input.UserInputType ==
                Enum.UserInputType.MouseButton1 then

                dragging = true
                dragStart = input.Position
                startPosition = Window.Position

            end

        end)



        UIS.InputChanged:Connect(function(input)

            if dragging and
            input.UserInputType ==
            Enum.UserInputType.MouseMovement then


                local delta =
                    input.Position - dragStart


                Window.Position =
                    UDim2.new(
                        startPosition.X.Scale,
                        startPosition.X.Offset + delta.X,
                        startPosition.Y.Scale,
                        startPosition.Y.Offset + delta.Y
                    )

            end

        end)



        UIS.InputEnded:Connect(function(input)

            if input.UserInputType ==
                Enum.UserInputType.MouseButton1 then

                dragging = false

            end

        end)

    end





    -- Create Tab

    function gui:CreateTab(name)

        local tab = {}

        local Frame = Create(
            "Frame",
            Container,
            {
                Name=name or "Tab",
                Size=UDim2.fromScale(1,1),
                BackgroundTransparency=1
            }
        )



        gui.Tabs[name] = tab



        -- Button

        function tab:CreateButton(info)

            info = info or {}


            local Button = Create(
                "TextButton",
                Frame,
                {
                    Name=info.Name or "Button",
                    Size=UDim2.fromOffset(150,35),
                    Text=info.Name or "Button",
                    BackgroundColor3=
                        Color3.fromRGB(40,40,50),
                    TextColor3=
                        Color3.new(1,1,1)
                }
            )



            Button.MouseButton1Click:Connect(function()

                if info.Callback then
                    info.Callback()
                end

            end)


            return Button

        end




        -- Toggle

        function tab:CreateToggle(info)

            info = info or {}

            local State = false


            local Toggle = Create(
                "TextButton",
                Frame,
                {
                    Size=UDim2.fromOffset(150,35),
                    Text=info.Name or "Toggle",
                    BackgroundColor3=
                        Color3.fromRGB(40,40,50)
                }
            )



            Toggle.MouseButton1Click:Connect(function()

                State = not State


                Toggle.Text =
                    (info.Name or "Toggle")
                    .." : "
                    ..(State and "ON" or "OFF")



                if info.Callback then
                    info.Callback(State)
                end

            end)


            return Toggle

        end




        -- Label

        function tab:CreateLabel(text)

            return Create(
                "TextLabel",
                Frame,
                {
                    Size=UDim2.fromOffset(200,30),
                    Text=text,
                    BackgroundTransparency=1,
                    TextColor3=Color3.new(1,1,1)
                }
            )

        end



        return tab

    end




    -- Notification

    function gui:Notify(title,text)

        print(
            "["..title.."] "..text
        )

    end




    gui.Settings = settings
    gui.ScreenGui = ScreenGui
    gui.Window = Window


    return gui

end



return Obsidian