# Lino-UI-Lib

![Screenshot 2023-09-17 144644](https://github.com/3345-c-a-t-s-u-s/Lino-UI-Lib/assets/117000269/eddddf83-e435-4a32-a4b8-cefc46b9b208)

# Example

```lua
local UILib = require(script.Parent)
local Window = UILib:NewWindow("Window")
local Noify = UILib:NewNoify()

local Tab = Window:NewTab("Tab")
local ThemeTab = Window:NewTab("Theme")

Tab:NewLabel("Example Tab")

Tab:NewButton('Button',function()
	print('Button')
	Noify:Notify("Button",'UI',3)
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

ThemeTab:NewColorPicker('Default',UILib.DefaultColor,function(a)
	UILib.DefaultColor=a
	Window:UpdateTheme()
end)

ThemeTab:NewColorPicker('Blackground',UILib.BlackgroundColor,function(a)
	UILib.BlackgroundColor=a
	Window:UpdateTheme()
end)

ThemeTab:NewColorPicker('Text Color',UILib.TextColor,function(a)
	UILib.TextColor=a
	Window:UpdateTheme()
end)

ThemeTab:NewColorPicker('Scrolling Color',UILib.ScrollingColor,function(a)
	UILib.ScrollingColor=a
	Window:UpdateTheme()
end)

ThemeTab:NewColorPicker('DropShadow Color',UILib.DropShadowColor,function(a)
	UILib.DropShadowColor=a
	Window:UpdateTheme()
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
