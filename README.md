# Lino-UI-Lib

![Screenshot 2023-09-17 144644](https://github.com/3345-c-a-t-s-u-s/Lino-UI-Lib/assets/117000269/eddddf83-e435-4a32-a4b8-cefc46b9b208)

# Example

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Linona-UI-Lib/main/source"))()
local Window = UILib:NewWindow("Window")
local Noify = UILib:NewNoify()

local Tab = Window:NewTab("Tab")

Tab:NewLabel("Example Tab")

Tab:NewButton('Button',function()
	print('Button')
end)

Tab:NewToggle("Toggle",false,function(val)
	print("Toggle",val)
end)

Tab:NewSlider("Slider",1,100,1,function(val)
	print("Slider",val)
end)

Tab:NewKeybind("Keybind",nil,function(val)
	print('Keybind',val)
end)

Tab:NewTextbox("Textbox","Input",function(val)
	print("Textbox",val)
end)

Tab:NewDropdown("Dropdown",{"Item 1","Item 2","Item 3"},"Item 1",function(val)
	print("Dropdown",val)
end)
```
## Confix

```lua
-- COLOR --

UILib.TextColor
UILib.ToggleOn
UILib.ScrollingColor
UILib.DropShadowColor
UILib.ButtonColor
UILib.RippleColor
UILib.BlackgroundColor
UILib.DefaultColor
UILib.BlackColor

----------

Window.Keybind
```
