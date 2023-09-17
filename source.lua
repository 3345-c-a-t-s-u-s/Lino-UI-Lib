gethui = gethui or function() return game:FindFirstChild('CoreGui') or game.Players.LocalPlayer.PlayerGui end

local TweenService = game:GetService('TweenService')
local UIPB = gethui()
local TextService = game:GetService('TextService')
local UserInputServie = game:GetService('UserInputService')
local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()

local Lino = {
	DefaultColor = Color3.fromRGB(44, 44, 44),
	BlackgroundColor = Color3.fromRGB(27, 27, 27),
	BlackColor = Color3.fromRGB(24, 24, 24),
	TextColor = Color3.fromRGB(255, 255, 255),
	ScrollingColor = Color3.fromRGB(255, 255, 255),
	DropShadowColor = Color3.fromRGB(0, 0, 0),
	ButtonColor = Color3.fromRGB(72, 72, 72),
	RippleColor = Color3.fromRGB(255, 255, 255),
	ToggleOn = Color3.fromRGB(255, 255, 255),
	ToggleOff = Color3.fromRGB(255, 255, 255)
}

local function CalculateDistance<Info...>(pointA, pointB)
	return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
end

function Create_Ripple<Effect...>(Parent : Frame, ___)
	Parent.ClipsDescendants = true
	local ripple = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")

	ripple.Active = false
	ripple.Name = "ripple"
	ripple.Parent = Parent
	ripple.BackgroundColor3 = Lino.RippleColor
	ripple.ZIndex = Parent.ZIndex or 7
	ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	ripple.Size = UDim2.new(0,0,0,0)
	ripple.SizeConstraint = Enum.SizeConstraint.RelativeYY

	UICorner.CornerRadius = UDim.new(0.25, 0)
	UICorner.Parent = ripple

	local buttonAbsoluteSize = Parent.AbsoluteSize
	local buttonAbsolutePosition = Parent.AbsolutePosition

	local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
	local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)

	ripple.BackgroundTransparency = 0.84
	ripple.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
	ripple.Parent = Parent

	local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
	local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
	local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
	local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))

	local Size_UP = UDim2.new(50,0,50,0)

	if (___) ~= nil then
		Size_UP = Parent.Size
	end

	TweenService:Create(ripple,TweenInfo.new(2),{Size = Size_UP,BackgroundTransparency = 1}):Play()

	if (___) ~= nil then
		TweenService:Create(ripple,TweenInfo.new(0.2),{Position =UDim2.new(0.5,0,0.5,0)}):Play()
	end
	game:GetService('Debris'):AddItem(ripple,2.2)
end


local function CreateButton()
	local InputButton = Instance.new("TextButton")

	InputButton.Name = "InputButton"
	InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InputButton.BackgroundTransparency = 1.000
	InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputButton.BorderSizePixel = 0
	InputButton.Size = UDim2.new(1, 0, 1, 0)
	InputButton.Font = Enum.Font.SourceSans
	InputButton.Text = ""
	InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	InputButton.TextSize = 14.000
	InputButton.TextTransparency = 1.000
	InputButton.ZIndex = 100

	return InputButton
end
function Lino:NewWindow(WindowName)
	local WindowFunctions = {
		Keybind = Enum.KeyCode.X
	}

	local Tabs = {}
	local UIToggle = true
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local Header = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local CloseButton = Instance.new("TextButton")
	local UIStroke = Instance.new("UIStroke")
	local left = Instance.new("Frame")
	local TabButtons = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Frame_2 = Instance.new("Frame")
	local UserImage = Instance.new("ImageLabel")
	local UserName = Instance.new("TextLabel")
	local center = Instance.new("Frame")

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		TabButtons.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
	end)

	local function SaveTran()
		for i,v : Frame? |ImageLabel? |TextLabel? |TextButton? |TextBox? |UIStroke? in ipairs(Frame:GetDescendants()) do
			if v:isA('Frame') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.BackgroundTransparency)
				end
			end

			if v:isA('ImageLabel') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.ImageTransparency)
				end
			end

			if v:isA('TextLabel') or v:isA('TextButton') or v:isA('TextBox') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.TextTransparency)
				end
			end

			if v:isA('UIStroke') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.Transparency)
				end
			end
		end
	end


	ScreenGui.Parent = UIPB
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

	Frame.Parent = ScreenGui
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Lino.BlackgroundColor
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.new(0.25, 225, 0.25, 150)

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Frame
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = -2
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageColor3 = Lino.DropShadowColor
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	Header.Name = "Header"
	Header.Parent = Frame
	Header.BackgroundColor3 = Lino.DefaultColor
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0.100000001, 0)

	Title.Name = "Title"
	Title.Parent = Header
	Title.AnchorPoint = Vector2.new(0.5, 0.5)
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.46093744, 0, 0.499999881, 0)
	Title.Size = UDim2.new(0.901875019, 0, 0.550000012, 0)
	Title.Font = Enum.Font.RobotoMono
	Title.Text = WindowName or "Leno UI Lib"
	Title.TextColor3 = Lino.TextColor
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Header
	CloseButton.AnchorPoint = Vector2.new(0, 0.5)
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 1.000
	CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Position = UDim2.new(0.943000019, 0, 0.5, 0)
	CloseButton.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
	CloseButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
	CloseButton.Font = Enum.Font.RobotoMono
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Lino.TextColor
	CloseButton.TextScaled = true
	CloseButton.TextSize = 14.000
	CloseButton.TextWrapped = true

	UIStroke.Color = Color3.fromRGB(29, 29, 29)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = CloseButton

	left.Name = "left"
	left.Parent = Frame
	left.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	left.BorderColor3 = Color3.fromRGB(0, 0, 0)
	left.BorderSizePixel = 0
	left.Position = UDim2.new(0.00844588131, 0, 0.121130548, 0)
	left.Size = UDim2.new(0.240118265, 0, 0.856258333, 0)

	TabButtons.Name = "TabButtons"
	TabButtons.Parent = left
	TabButtons.Active = true
	TabButtons.AnchorPoint = Vector2.new(0.5, 0.5)
	TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabButtons.BackgroundTransparency = 1.000
	TabButtons.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0.500000119, 0, 0.456518203, 0)
	TabButtons.Size = UDim2.new(0.949999869, 0, 0.863036275, 0)
	TabButtons.ZIndex = 5
	TabButtons.ScrollBarThickness = 1
	TabButtons.ScrollBarImageColor3 = Lino.ScrollingColor

	UIListLayout.Parent = TabButtons
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Frame_2.Parent = left
	Frame_2.AnchorPoint = Vector2.new(0.5, 1)
	Frame_2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0.5, 0, 0.99000001, 0)
	Frame_2.Size = UDim2.new(0.949999988, 0, 0.115500003, 0)

	UserImage.Name = "UserImage"
	UserImage.Parent = Frame_2
	UserImage.AnchorPoint = Vector2.new(0, 0.5)
	UserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserImage.BackgroundTransparency = 1.000
	UserImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserImage.BorderSizePixel = 0
	UserImage.Position = UDim2.new(0.00999999978, 0, 0.5, 0)
	UserImage.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
	UserImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
	UserImage.Image = game.Players:GetUserThumbnailAsync(plr.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)

	UserName.Name = "UserName"
	UserName.Parent = Frame_2
	UserName.AnchorPoint = Vector2.new(0, 0.5)
	UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserName.BackgroundTransparency = 1.000
	UserName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserName.BorderSizePixel = 0
	UserName.Position = UDim2.new(0.314332396, 0, 0.500000596, 0)
	UserName.Size = UDim2.new(0.679667532, 0, 0.75, 0)
	UserName.Font = Enum.Font.RobotoMono
	UserName.Text = "#"..tostring(plr.UserId)
	UserName.TextColor3 = Lino.TextColor
	UserName.TextScaled = true
	UserName.TextSize = 14.000
	UserName.TextWrapped = true
	UserName.TextXAlignment = Enum.TextXAlignment.Left

	center.Name = "center"
	center.Parent = Frame
	center.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	center.BorderColor3 = Color3.fromRGB(0, 0, 0)
	center.BorderSizePixel = 0
	center.Position = UDim2.new(0.261824071, 0, 0.121130548, 0)
	center.Size = UDim2.new(0.725103319, 0, 0.856258333, 0)

	function WindowFunctions:NewTab(TabName)
		local TabFunctions = {}

		local TabButton = Instance.new("Frame")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		local ImageLabel = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")

		TabButton.Name = "TabButton"
		TabButton.Parent = TabButtons
		TabButton.BackgroundColor3 = Lino.DefaultColor
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0.949999988, 0, 0.5, 0)

		UIAspectRatioConstraint.Parent = TabButton
		UIAspectRatioConstraint.AspectRatio = 5
		UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

		ImageLabel.Parent = TabButton
		ImageLabel.AnchorPoint = Vector2.new(0.0500000007, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ImageLabel.Image = "rbxassetid://14790054905"

		TextLabel.Parent = TabButton
		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.244083703, 0, 0.499999911, 0)
		TextLabel.Size = UDim2.new(1, 0, 0.75, 0)
		TextLabel.Font = Enum.Font.RobotoMono
		TextLabel.Text = TabName or "Tab"
		TextLabel.TextColor3 = Lino.TextColor
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = TabButton

		local Tab = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			Tab.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
		end)

		Tab.Name = "Tab"
		Tab.Parent = center
		Tab.Active = true
		Tab.AnchorPoint = Vector2.new(0.5, 0.5)
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Position = UDim2.new(0.5, 0, 0.5, 0)
		Tab.Size = UDim2.new(0.949999988, 0, 0.949999988, 0)
		Tab.ZIndex = 5
		Tab.ScrollBarThickness = 1
		Tab.ScrollBarImageColor3 = Lino.ScrollingColor

		UIListLayout.Parent = Tab
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		local function call(val)
			if val then
				Tab.Visible = true
				TweenService:Create(TabButton,TweenInfo.new(0.2),{BackgroundColor3 = Lino.ButtonColor}):Play()
			else
				Tab.Visible = false
				TweenService:Create(TabButton,TweenInfo.new(0.2),{BackgroundColor3 = Lino.DefaultColor}):Play()
			end
		end

		if #Tabs == 0 then
			call(true)
		else
			call(false)
		end

		table.insert(Tabs,{Tab,call})
		local button = CreateButton()

		button.Parent = TabButton

		button.MouseButton1Click:Connect(function()
			Create_Ripple(button)
			for i,v in ipairs(Tabs) do
				if v[1]==Tab then
					v[2](true)
				else
					v[2](false)
				end
			end
		end)

		function TabFunctions:NewLabel(LabelName)
			local Label = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Bar = Instance.new("ImageLabel")
			local UIGradient = Instance.new("UIGradient")

			Label.Name = "Label"
			Label.Parent = Tab
			Label.BackgroundColor3 = Lino.DefaultColor
			Label.BackgroundTransparency = 1.000
			Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(0.949999988, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Label
			UIAspectRatioConstraint.AspectRatio = 15.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Label

			Title.Name = "Title"
			Title.Parent = Label
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.5, 0, 0.5, 0)
			Title.Size = UDim2.new(0, 32, 0.550000012, 0)
			Title.ZIndex = 5
			Title.Font = Enum.Font.RobotoMono
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.Text = LabelName
			Title:SetAttribute("d3",0)

			Bar.Name = "Bar"
			Bar.Parent = Label
			Bar.AnchorPoint = Vector2.new(0.5, 0.5)
			Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Bar.BackgroundTransparency = 1.000
			Bar.Position = UDim2.new(0.5, 0, 0.5, 0)
			Bar.Size = UDim2.new(1, 0, 0.200000003, 0)
			Bar.ZIndex = 4
			Bar.Image = "http://www.roblox.com/asset/?id=7935669488"

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.17, 0.00), NumberSequenceKeypoint.new(0.49, 0.00), NumberSequenceKeypoint.new(0.83, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = Bar
			local function Update()
				local size = TextService:GetTextSize(Title.Text,Title.TextSize,Title.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(Title,TweenInfo.new(0.2),{Size = UDim2.new(0, size.X + 10, 0.550000012, 0)}):Play()
			end

			Update()

			local LabelFunctions = {}

			function LabelFunctions:Text(new)
				Title.Text = tostring(new)
				Update()
			end

			return LabelFunctions
		end

		function TabFunctions:NewButton(ButtonName,callback)
			callback=callback or function() end

			local Button = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local UIGradient = Instance.new("UIGradient")
			local InputButton = Instance.new("TextButton")
			local UIStroke = Instance.new("UIStroke")

			Button.Name = "Button"
			Button.Parent = Tab
			Button.BackgroundColor3 = Lino.DefaultColor
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			Button.ZIndex = 8

			UIAspectRatioConstraint.Parent = Button
			UIAspectRatioConstraint.AspectRatio = 10.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Button

			Title.Name = "Title"
			Title.Parent = Button
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.5, 0, 0.499999821, 0)
			Title.Size = UDim2.new(0.925812483, 0, 0.549999952, 0)
			Title.ZIndex = 5
			Title.Font = Enum.Font.RobotoMono
			Title.Text = ButtonName or "Button"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.ZIndex = 9

			Icon.Name = "Icon"
			Icon.Parent = Button
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(1, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
			Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon.Image = "rbxassetid://14790054905"
			Icon.ZIndex = 9

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.739, 0.97), NumberSequenceKeypoint.new(0.740001, 0.00), NumberSequenceKeypoint.new(1.00, 0.00)}
			UIGradient.Parent = Icon

			InputButton.Name = "InputButton"
			InputButton.Parent = Button
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.Font = Enum.Font.SourceSans
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.ZIndex = 1000

			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Button

			InputButton.MouseButton1Click:Connect(function()
				Create_Ripple(InputButton)
				callback()
			end)

			local ButtonFunctions = {}

			function ButtonFunctions:Text(a)
				Title.Text = tostring(a)
			end

			function ButtonFunctions:Fire(...)
				callback(...)
			end

			return ButtonFunctions
		end

		function TabFunctions:NewToggle(ToggleName,Default,callback)
			Default = Default or false callback = callback or function ()

			end

			local Toggle = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local InputButton = Instance.new("TextButton")
			local UIStroke = Instance.new("UIStroke")
			local Icon = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local ToggleIcon = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")

			Toggle.Name = "Toggle"
			Toggle.Parent = Tab
			Toggle.BackgroundColor3 = Lino.DefaultColor
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			Toggle.ZIndex = 6

			UIAspectRatioConstraint.Parent = Toggle
			UIAspectRatioConstraint.AspectRatio = 10.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Toggle

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.441921741, 0, 0.499999821, 0)
			Title.Size = UDim2.new(0.809655964, 0, 0.549999952, 0)
			Title.ZIndex = 7
			Title.Font = Enum.Font.RobotoMono
			Title.Text = ToggleName or "Toggle"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			InputButton.Name = "InputButton"
			InputButton.Parent = Toggle
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.Font = Enum.Font.SourceSans
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.ZIndex = 1000
			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Toggle

			Icon.Name = "Icon"
			Icon.Parent = Toggle
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.980000019, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.125, 0, 0.550000012, 0)
			Icon.ZIndex = 9

			UICorner_2.CornerRadius = UDim.new(0.5, 0)
			UICorner_2.Parent = Icon

			UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_2.Parent = Icon

			ToggleIcon.Name = "ToggleIcon"
			ToggleIcon.Parent = Icon
			ToggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleIcon.BorderSizePixel = 0
			ToggleIcon.Position = UDim2.new(0.25, 0, 0.5, 0)
			ToggleIcon.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
			ToggleIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			ToggleIcon.ZIndex = 9

			UICorner_3.CornerRadius = UDim.new(0.5, 0)
			UICorner_3.Parent = ToggleIcon

			local function valuechanger(val)
				if val then
					TweenService:Create(ToggleIcon,TweenInfo.new(0.25,Enum.EasingStyle.Quint),{Position = UDim2.new(0.75,0,0.5,0),BackgroundColor3=Lino.ToggleOn}):Play()
				else
					TweenService:Create(ToggleIcon,TweenInfo.new(0.25,Enum.EasingStyle.Quint),{Position = UDim2.new(0.25,0,0.5,0),BackgroundColor3=Lino.ToggleOff}):Play()
				end
			end

			valuechanger(Default)


			InputButton.MouseButton1Click:Connect(function()
				Create_Ripple(InputButton)
				Default = not Default
				valuechanger(Default)
				callback(Default)
			end)

			local ToggleFunctions = {}

			function ToggleFunctions:Value(val)
				Default = val
				valuechanger(Default)
				callback(Default)
			end

			function ToggleFunctions:Text(a)
				Title.Text = tostring(a)
			end

			return ToggleFunctions
		end

		function TabFunctions:NewTextbox(TextboxName,InputText,callback)
			InputText = InputText or ""
			callback = callback or function() end
			local MaxLine = 5

			local Textbox = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
			local UIStroke = Instance.new("UIStroke")
			local Frame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local TextBox = Instance.new("TextBox")

			Textbox.Name = "Textbox"
			Textbox.Parent = Tab
			Textbox.BackgroundColor3 = Lino.DefaultColor
			Textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Textbox.BorderSizePixel = 0
			Textbox.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			Textbox.ZIndex = 6
			UIAspectRatioConstraint.Parent = Textbox
			UIAspectRatioConstraint.AspectRatio = 6.560
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Textbox

			Title.Name = "Title"
			Title.Parent = Textbox
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.5, 0, 0.350000441, 0)
			Title.Size = UDim2.new(0.925812483, 0, 0.329, 0)
			Title.ZIndex = 7
			Title.Font = Enum.Font.RobotoMono
			Title.Text = TextboxName or "Textbox"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIAspectRatioConstraint_2.Parent = Title
			UIAspectRatioConstraint_2.AspectRatio = 15.000
			UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize

			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Textbox

			Frame.Parent = Textbox
			Frame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.025, 0,0.67, 0)
			Frame.Size = UDim2.new(0.95, 0,0.241, 0)
			Frame.ZIndex = 8

			UICorner_2.CornerRadius = UDim.new(0, 1)
			UICorner_2.Parent = Frame

			UIStroke_2.Transparency = 0.750
			UIStroke_2.Color = Color3.fromRGB(185, 185, 185)
			UIStroke_2.Parent = Frame

			TextBox.Parent = Frame
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.Size = UDim2.new(1, 0, 1, 0)
			TextBox.ZIndex = 9
			TextBox.ClearTextOnFocus = false
			TextBox.Font = Enum.Font.RobotoMono
			TextBox.MultiLine = true
			TextBox.Text = ""
			TextBox.TextColor3 = Lino.TextColor
			TextBox.TextScaled = true
			TextBox.TextSize = 10.000
			TextBox.TextTransparency = 0.500
			--TextBox.TextWrapped = true
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.PlaceholderText = InputText
			TextBox.TextYAlignment = Enum.TextYAlignment.Center


			local function update()
				local tez = (#TextBox.Text >= 1 and TextBox.Text) or TextBox.PlaceholderText
				local textsize = TextService:GetTextSize(tez,TextBox.TextSize,Enum.Font.RobotoMono,Vector2.new(math.huge,math.huge))

				TweenService:Create(Frame,TweenInfo.new(0.1),{Size = UDim2.new(0, math.clamp(textsize.X + 10,0,293), 0.241, 0)}):Play()

			end

			TextBox:GetPropertyChangedSignal('Text'):Connect(function()
				update()
			end)

			update()

			TextBox.FocusLost:Connect(function()
				callback(TextBox.Text)
			end)

			local TextboxFunctions = {}

			function TextboxFunctions:Text(a)
				Title.Text = tostring(a)
			end

			function TextboxFunctions:InputText(a)
				TextBox.PlaceholderText = tostring(a)
				update()
			end

			function TextboxFunctions:Value(a)
				TextBox.Text = tostring(a)
				update()
				callback(a)
			end

			return TextboxFunctions
		end

		function TabFunctions:NewKeybind(KeybindName,Default,callback)
			Default = Default or nil
			callback = callback or function() end

			local function getname(a)
				if not a then
					return "None"
				end

				return a.Name
			end

			local Keybind = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local InputButton = Instance.new("TextButton")
			local UIStroke = Instance.new("UIStroke")
			local Icon = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local Key = Instance.new("TextLabel")

			Keybind.Name = "Keybind"
			Keybind.Parent = Tab
			Keybind.BackgroundColor3 = Lino.DefaultColor
			Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Keybind.BorderSizePixel = 0
			Keybind.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			Keybind.ZIndex = 6

			UIAspectRatioConstraint.Parent = Keybind
			UIAspectRatioConstraint.AspectRatio = 10.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Keybind

			Title.Name = "Title"
			Title.Parent = Keybind
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.349211216, 0, 0.500000298, 0)
			Title.Size = UDim2.new(0.624234915, 0, 0.549999952, 0)
			Title.ZIndex = 7
			Title.Font = Enum.Font.RobotoMono
			Title.Text = KeybindName or "Keybind"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			InputButton.Name = "InputButton"
			InputButton.Parent = Keybind
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.ZIndex = 7
			InputButton.Font = Enum.Font.SourceSans
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.ZIndex = 1000
			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Keybind

			Icon.Name = "Icon"
			Icon.Parent = Keybind
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.980000019, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.125, 0, 0.550000012, 0)
			Icon.ZIndex = 7

			UICorner_2.CornerRadius = UDim.new(0.100000001, 0)
			UICorner_2.Parent = Icon

			UIStroke_2.Transparency = 0.500
			UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_2.Parent = Icon

			Key.Name = "Key"
			Key.Parent = Icon
			Key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Key.BackgroundTransparency = 1.000
			Key.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Key.BorderSizePixel = 0
			Key.Size = UDim2.new(1, 0, 1, 0)
			Key.Font = Enum.Font.RobotoMono
			Key.Text = getname(Default) or "None"
			Key.TextColor3 = Lino.TextColor
			Key.TextScaled = true
			Key.TextSize = 14.000
			Key.TextTransparency = 0.500
			Key.TextWrapped = true
			Key.ZIndex = 10

			local function UpdateText()
				local size = TextService:GetTextSize(Key.Text,Key.TextSize,Key.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(Icon,TweenInfo.new(0.2),{Size = UDim2.new(0, size.X + 9, 0.550000012, 0)}):Play()
			end

			local Binding = false
			InputButton.MouseButton1Click:Connect(function()
				if Binding then
					return
				end
				Binding =  true

				local targetloadded = nil

				local hook = UserInputServie.InputBegan:Connect(function(is)
					if is.KeyCode ~= Enum.KeyCode.Unknown then
						targetloadded = is.KeyCode
					end
				end)

				Key.Text = "..."
				repeat task.wait() UpdateText() until targetloadded or not Binding
				Binding =false
				if hook then
					hook:Disconnect()
				end
				if targetloadded then
					Key.Text = getname(targetloadded)
					Default = targetloadded
					UpdateText() 
					callback(targetloadded)
				end
				return
			end)

			UpdateText()

			local KeybindFunctions = {}

			function KeybindFunctions:Text(a)
				Title.Text = tostring(a)
			end

			function KeybindFunctions:Value(l)
				Key.Text = getname(l)
				Default = l
				UpdateText() 
				callback(l)
			end

			return KeybindFunctions
		end

		function TabFunctions:NewSlider(SliderName,Min,Max,Default,callback)
			Min = Min or 1
			Max = Max or 100
			Default = Default or Min
			callback = callback or function() end

			local Slider = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIStroke = Instance.new("UIStroke")
			local Frame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Movement = Instance.new("Frame")
			local Circle = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local ValueText = Instance.new("TextLabel")

			Slider.Name = "Slider"
			Slider.Parent = Tab
			Slider.BackgroundColor3 = Lino.DefaultColor
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0.949999988, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Slider
			UIAspectRatioConstraint.AspectRatio = 8.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Slider

			Title.Name = "Title"
			Title.Parent = Slider
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.441921741, 0, 0.350000441, 0)
			Title.Size = UDim2.new(0.809655964, 0, 0.42093721, 0)
			Title.ZIndex = 5
			Title.Font = Enum.Font.RobotoMono
			Title.Text = SliderName or "Slider"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Slider

			Frame.Parent = Slider
			Frame.AnchorPoint = Vector2.new(0.5, 0)
			Frame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.5, 0, 0.649999976, 0)
			Frame.Size = UDim2.new(0.949999988, 0, 0.25, 0)
			Frame.ZIndex = 6

			UICorner_2.CornerRadius = UDim.new(0, 1)
			UICorner_2.Parent = Frame

			Movement.Name = "Movement"
			Movement.Parent = Frame
			Movement.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
			Movement.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Movement.BorderSizePixel = 0
			Movement.Size = UDim2.new(0.025, 0, 1, 0)
			Movement.ZIndex = 6


			local dasd = Instance.new('UIListLayout')
			dasd.FillDirection = Enum.FillDirection.Horizontal
			dasd.HorizontalAlignment = Enum.HorizontalAlignment.Right
			dasd.VerticalAlignment = Enum.VerticalAlignment.Center
			dasd.Parent = Movement

			Circle.Name = "Circle"
			Circle.Parent = Movement
			Circle.AnchorPoint = Vector2.new(1, 0)
			Circle.BackgroundColor3 = Color3.fromRGB(208, 208, 208)
			Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Circle.BorderSizePixel = 0
			Circle.Position = UDim2.new(1, 0, 0, 0)
			Circle.Size = UDim2.new(1.10000002, 0, 1.10000002, 0)
			Circle.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Circle.ZIndex = 8

			UICorner_3.CornerRadius = UDim.new(0.5, 0)
			UICorner_3.Parent = Circle

			UIStroke_2.Transparency = 0.750
			UIStroke_2.Color = Color3.fromRGB(185, 185, 185)
			UIStroke_2.Parent = Frame

			ValueText.Name = "ValueText"
			ValueText.Parent = Slider
			ValueText.AnchorPoint = Vector2.new(1, 0.5)
			ValueText.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			ValueText.BackgroundTransparency = 1.000
			ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueText.BorderSizePixel = 0
			ValueText.Position = UDim2.new(0.980000019, 0, 0.349999994, 0)
			ValueText.Size = UDim2.new(0, 51, 0.349999994, 0)
			ValueText.ZIndex = 5
			ValueText.Font = Enum.Font.RobotoMono
			ValueText.Text = tostring(Default)..tostring("/")..tostring(Max)
			ValueText.TextColor3 = Lino.TextColor
			ValueText.TextScaled = true
			ValueText.TextSize = 15.000
			ValueText.TextWrapped = true
			ValueText.TextXAlignment = Enum.TextXAlignment.Right

			local function UpdateText()
				local a = TextService:GetTextSize(ValueText.Text,ValueText.TextSize,ValueText.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(ValueText,TweenInfo.new(0.3),{Size = UDim2.new(0,a.X + 9,0.349999994, 0)}):Play()
			end

			local danger = false

			Frame.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = true
					--Dbg_can_move = false
				end
			end)

			Frame.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = false
					--Dbg_can_move = true
				end
			end)

			local function Set(call,input,va)
				if call == "Input" then
					if danger and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						local SizeScale = math.clamp(((input.Position.X - Frame.AbsolutePosition.X) / Frame.AbsoluteSize.X), 0, 1)
						local Valuea = math.floor(((Max - Min) * SizeScale) + Min)
						local Size = UDim2.fromScale(math.clamp(SizeScale,0.025,1), 1)
						ValueText.Text = tostring(Valuea)..tostring("/")..tostring(Max)
						TweenService:Create(Movement,TweenInfo.new(0.1),{Size = Size}):Play()
						callback(Valuea)
					end
				else
					if not va then
						local min = Default
						local max = Max

						ValueText.Text = tostring(min)..tostring("/")..tostring(max)
						local size = UDim2.new((min/Max),0,1,0)
						TweenService:Create(Movement,TweenInfo.new(0.1),{Size = size}):Play()
						callback(Default)
					else
						ValueText.Text = tostring(va)..tostring("/")..tostring(Max)
						local size = UDim2.new((va/Max),0,1,0)
						TweenService:Create(Movement,TweenInfo.new(0.2),{Size = size}):Play()
					end

				end

				UpdateText()
			end

			UserInputServie.InputChanged:Connect(function(a)
				Set("Input",a)
			end)

			Set()

			local SliderFunctions = {}

			function SliderFunctions:Value(a)
				Set(nil,nil,a)
			end

			function SliderFunctions:Text(a)
				Title.Text = tostring(a)
			end

			return SliderFunctions
		end

		function TabFunctions:NewDropdown(DropdownName,info,Default,callback)
			info = info or {}
			callback = callback or function() end
			Default = Default or info[1]

			local Dropdown = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Top = Instance.new("Frame")
			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
			local Icon = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local DropdownIcon = Instance.new("TextLabel")
			local InputButton = Instance.new("TextButton")
			local TextFont = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local Title = Instance.new("TextLabel")
			local ValueText = Instance.new("TextLabel")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIListLayout_3 = Instance.new("UIListLayout")

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Tab
			Dropdown.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(0.949999988, 0, 0.5, 0)


			UIListLayout_2.Parent = ScrollingFrame
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 3)

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				ScrollingFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout_2.AbsoluteContentSize.Y + 5)
			end)

			UIListLayout_3.Parent = Dropdown
			UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 3)

			UIAspectRatioConstraint.Parent = Dropdown
			UIAspectRatioConstraint.AspectRatio = 10.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Dropdown

			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = Dropdown

			Top.Name = "Top"
			Top.Parent = Dropdown
			Top.BackgroundColor3 = Lino.DefaultColor
			Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Top.BorderSizePixel = 0
			Top.Size = UDim2.new(1, 0, 1, 0)
			Top.ZIndex = 4

			UIAspectRatioConstraint_2.Parent = Top
			UIAspectRatioConstraint_2.AspectRatio = 10.000
			UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize

			Icon.Name = "Icon"
			Icon.Parent = Top
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.980000019, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
			Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon.ZIndex = 7

			UICorner_2.CornerRadius = UDim.new(0.100000001, 0)
			UICorner_2.Parent = Icon

			UIStroke_2.Transparency = 0.500
			UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_2.Parent = Icon

			DropdownIcon.Name = "DropdownIcon"
			DropdownIcon.Parent = Icon
			DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownIcon.BackgroundTransparency = 1.000
			DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownIcon.BorderSizePixel = 0
			DropdownIcon.Rotation = 90.000
			DropdownIcon.Size = UDim2.new(1, 0, 1, 0)
			DropdownIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			DropdownIcon.ZIndex = 6
			DropdownIcon.Font = Enum.Font.RobotoMono
			DropdownIcon.Text = ">"
			DropdownIcon.TextColor3 = Lino.TextColor
			DropdownIcon.TextScaled = true
			DropdownIcon.TextSize = 14.000
			DropdownIcon.TextWrapped = true

			InputButton.Name = "InputButton"
			InputButton.Parent = Top
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.ZIndex = 7
			InputButton.Font = Enum.Font.SourceSans
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.ZIndex = 1000
			TextFont.Name = "TextFont"
			TextFont.Parent = Top
			TextFont.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextFont.BackgroundTransparency = 1.000
			TextFont.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextFont.BorderSizePixel = 0
			TextFont.Position = UDim2.new(0.0250002109, 0, 0, 0)
			TextFont.Size = UDim2.new(0.79044497, 0, 1, 0)
			TextFont.ZIndex = 5

			UIListLayout.Parent = TextFont
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			Title.Name = "Title"
			Title.Parent = TextFont
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.294359416, 0, 0.500000298, 0)
			Title.Size = UDim2.new(0, 61, 0.550000012, 0)
			Title.ZIndex = 7
			Title.Font = Enum.Font.RobotoMono
			Title.Text = DropdownName or "Dropdown"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			ValueText.Name = "ValueText"
			ValueText.Parent = TextFont
			ValueText.AnchorPoint = Vector2.new(0.5, 0.5)
			ValueText.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			ValueText.BackgroundTransparency = 1.000
			ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueText.BorderSizePixel = 0
			ValueText.Position = UDim2.new(0.294359416, 0, 0.500000298, 0)
			ValueText.Size = UDim2.new(0, 35, 0.550000012, 0)
			ValueText.ZIndex = 7
			ValueText.Font = Enum.Font.RobotoMono
			ValueText.Text = "None"
			ValueText.TextColor3 = Lino.TextColor
			ValueText.TextScaled = true
			ValueText.TextSize = 15.000
			ValueText.TextTransparency = 0.500
			ValueText.TextWrapped = true

			ScrollingFrame.Parent = Dropdown
			ScrollingFrame.Active = true
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScrollingFrame.BackgroundTransparency = 1.000
			ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame.BorderSizePixel = 0
			ScrollingFrame.Size = UDim2.new(0.970000029, 0, 0.5, 0)
			ScrollingFrame.Visible = false
			ScrollingFrame.ZIndex = 5
			ScrollingFrame.ScrollBarThickness = 1
			ScrollingFrame.ScrollBarImageColor3 = Lino.ScrollingColor

			UIAspectRatioConstraint_3.Parent = ScrollingFrame
			UIAspectRatioConstraint_3.AspectRatio = 3.500
			UIAspectRatioConstraint_3.AspectType = Enum.AspectType.ScaleWithParentSize

			local function UpdateText()
				local size1 = TextService:GetTextSize(Title.Text,Title.TextSize,Title.Font,Vector2.new(math.huge,math.huge))
				local size2 = TextService:GetTextSize(ValueText.Text,ValueText.TextSize,ValueText.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(ValueText,TweenInfo.new(0.4),{Size = UDim2.new(0, size2.X + 9, 0.550000012, 0)}):Play()
				TweenService:Create(Title,TweenInfo.new(0.4),{Size = UDim2.new(0, size1.X + 9, 0.550000012, 0)}):Play()
			end

			local function atran(number)
				for i,v : TextButton in ipairs(ScrollingFrame:GetChildren()) do
					if v:isA('TextButton') then
						TweenService:Create(v,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{TextTransparency = number,BackgroundTransparency=number}):Play()
					end
				end

				TweenService:Create(ScrollingFrame,TweenInfo.new(0.1,Enum.EasingStyle.Quint),{ScrollBarImageTransparency = number}):Play()
			end

			UpdateText()

			local togglle_val = false
			local choose = nil

			local function toggle(ca)
				coroutine.wrap(function()
					if ca then
						ScrollingFrame.Visible = true
						TweenService:Create(DropdownIcon,TweenInfo.new(0.5),{Rotation = -90}):Play()
						TweenService:Create(UIAspectRatioConstraint,TweenInfo.new(0.5),{AspectRatio = 2.5}):Play()
						task.wait(0.1)
						atran(0)
					else
						TweenService:Create(UIAspectRatioConstraint,TweenInfo.new(0.5),{AspectRatio = 10}):Play()
						TweenService:Create(DropdownIcon,TweenInfo.new(0.5),{Rotation = 90}):Play()
						atran(1)

						task.wait(0.5)

						if  DropdownIcon.Rotation == 90 then
							ScrollingFrame.Visible = false
						end

					end
				end)()
			end

			toggle(false)

			InputButton.MouseButton1Click:Connect(function()
				Create_Ripple(InputButton)
				togglle_val = not togglle_val
				toggle(togglle_val)
				UpdateText()
			end)

			local function get_button()
				local Button = Instance.new("TextButton")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")

				Button.Name = "Button"
				Button.Parent = ScrollingFrame
				Button.BackgroundColor3 = Lino.DefaultColor
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0.949999988, 0, 0.5, 0)
				Button.Font = Enum.Font.RobotoMono
				Button.Text = "Item"
				Button.TextColor3 = Lino.TextColor
				Button.TextScaled = true
				Button.TextSize = 14.000
				Button.TextWrapped = true
				Button.ZIndex = 6

				UIAspectRatioConstraint.Parent = Button
				UIAspectRatioConstraint.AspectRatio = 10.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 3)
				UICorner.Parent = Button

				return Button
			end

			local function rander()
				for i,v : TextButton in ipairs(ScrollingFrame:GetChildren()) do
					if v:isA('TextButton') then
						v:Destroy()
					end
				end

				for i,v in ipairs(info) do
					local utton = get_button()

					utton.Text = tostring(v)
					utton.Parent = ScrollingFrame

					local function set()
						choose = v
						ValueText.Text = tostring(v)
						UpdateText()
						coroutine.wrap(function()
							pcall(function()
								callback(v)
							end)
						end)()
					end

					utton.MouseButton1Click:Connect(set)

					if v==Default then
						set()
					end
				end
			end

			rander()

			local DropdownFunctions = {}

			function DropdownFunctions:Text(a)
				Title.Text =  tostring(a)
			end

			function DropdownFunctions:Get()
				return choose
			end

			function DropdownFunctions:Set(a)
				choose = a
				ValueText.Text = tostring(a)
				UpdateText()
				callback(a)
			end

			function DropdownFunctions:Refresh(new,def)
				info = new or info
				def = def or info[1]
				Default = def
				rander()
			end

			return DropdownFunctions
		end

		return TabFunctions
	end

	local function UI_Toggle(val,timea,k)
		SaveTran()
		if timea == 0 then
			Frame.BackgroundTransparency = k
			for i,v :GuiObject in ipairs(Frame:GetDescendants()) do
				pcall(function()
					if v:GetAttribute('MainTran') then
						pcall(function()
							v.BackgroundTransparency = k
						end)

						pcall(function()
							if v:GetAttribute('d3') then
								v.BackgroundTransparency  = k
							end
						end)

						pcall(function()
							v.ImageTransparency =k
						end)

						pcall(function()
							v.TextTransparency = k
						end)

						pcall(function()
							v.Transparency = k
						end)
					else
						if v:isA('ScrollingFrame') then
							v.ScrollBarThickness = k
						end
					end

				end)
			end
			return
		end

		if val then
			center.Visible = true
			left.Visible = true
			TweenService:Create(Frame,TweenInfo.new(timea - 0.1),{BackgroundTransparency = 0}):Play()
			for i,v :GuiObject in ipairs(Frame:GetDescendants()) do
				pcall(function()
					--if not v:IsDescendantOf(Header) and v~= Header then
					if v:GetAttribute('MainTran') then

						pcall(function()
							if v:GetAttribute('d3') then
								TweenService:Create(v,TweenInfo.new(timea),{BackgroundTransparency = 0}):Play()
							end
						end)

						if v:isA('Frame') then
							if v:GetAttribute('MainTran') then
								TweenService:Create(v,TweenInfo.new(timea),{BackgroundTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('ImageLabel') then
							if v:GetAttribute('MainTran') then
								TweenService:Create(v,TweenInfo.new(timea),{ImageTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('TextLabel') or v:isA('TextButton') or v:isA('TextBox') then
							if v:GetAttribute('MainTran') then
								TweenService:Create(v,TweenInfo.new(timea),{TextTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('UIStroke') then
							if v:GetAttribute('MainTran') then
								TweenService:Create(v,TweenInfo.new(timea),{Transparency = v:GetAttribute('MainTran')}):Play()
							end
						end
					else
						if v:isA('ScrollingFrame') then
							TweenService:Create(v,TweenInfo.new(timea),{ScrollBarThickness = 1}):Play()
						end
					end
					--end
				end)
			end
		else
			TweenService:Create(Frame,TweenInfo.new(timea + 0.4),{BackgroundTransparency = 1}):Play()
			for i,v :GuiObject in ipairs(Frame:GetDescendants()) do
				pcall(function()
					if not v:IsDescendantOf(Header) and v~= Header then
						if v:GetAttribute('MainTran') then
							pcall(function()
								TweenService:Create(v,TweenInfo.new(timea),{BackgroundTransparency = 1}):Play()
							end)

							pcall(function()
								TweenService:Create(v,TweenInfo.new(timea),{ImageTransparency = 1}):Play()
							end)

							pcall(function()
								TweenService:Create(v,TweenInfo.new(timea),{TextTransparency = 1}):Play()
							end)

							pcall(function()
								TweenService:Create(v,TweenInfo.new(timea),{Transparency = 1}):Play()
							end)
						else
							if v:isA('ScrollingFrame') then
								TweenService:Create(v,TweenInfo.new(timea),{ScrollBarThickness = 0}):Play()
							end
						end
					end


				end)
			end
		end

		coroutine.wrap(function()
			task.wait(timea + 0.4)

			if Frame.BackgroundTransparency == 1 then
				center.Visible = false
				left.Visible = false
			end
		end)()
	end

	CloseButton.MouseButton1Click:Connect(function()
		Create_Ripple(CloseButton)
		UIToggle = not UIToggle
		UI_Toggle(UIToggle,0.43)
	end)

	local dragToggle = nil
	local dragSpeed = 0.05
	local dragStart = nil
	local startPos = nil

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(Frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end

	Header.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UserInputServie.InputBegan:Connect(function(a,t)
		if  a.KeyCode == WindowFunctions.Keybind then
			if not t then
				UIToggle = not UIToggle
				UI_Toggle(UIToggle,0.43)
			end
		end
	end)

	UserInputServie.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)

	function WindowFunctions:OnStartEffect()
		UI_Toggle(nil,0,1)
		task.wait(0.01)
		UI_Toggle(nil,0,1)
		TweenInfo.new(0.1)
		UI_Toggle(nil,0,1)
		Frame.Size = UDim2.new(0,0,0.25,150)
		Frame.Position = UDim2.new(0.1,0,.5,0)
		TweenService:Create(Frame,TweenInfo.new(1.5,Enum.EasingStyle.Quint),{Size = UDim2.new(0.25, 225, 0.25, 150),BackgroundTransparency=0,Position=UDim2.new(0.5,0,0.5,0)}):Play()
		task.wait(1.65)
		UI_Toggle(true,1)
	end

	return WindowFunctions
end

function Lino:NewNoify()
	local Noify = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Noify.Name = "Noify"
	Noify.Parent = UIPB
	Noify.ResetOnSpawn = false

	Frame.Parent = Noify
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 1.000
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.790707588, 0, 0.456861466, 0)
	Frame.Size = UDim2.new(0.200000003, 0, 0.526154876, 0)

	UIListLayout.Parent = Frame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 3)

	local Functions = {}

	function Functions:Notify(Text,Subject,Time,callback)
		Subject = Subject or "Notification"
		Time = Time or 4
		callback = callback or function() end
		Text = tostring(Text or nil)
		local NoifyFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local DropShadow = Instance.new("ImageLabel")
		local NoifyBy = Instance.new("TextLabel")
		local Countdown = Instance.new("Frame")
		local NoifyText = Instance.new("TextLabel")
		local sizeold = UDim2.new(0, 300, 0.10000006, 0)
		 
		NoifyFrame.Name = "NoifyFrame"
		NoifyFrame.Parent = Frame
		NoifyFrame.BackgroundColor3 = Lino.BlackgroundColor
		NoifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NoifyFrame.BorderSizePixel = 0
		NoifyFrame.Position = UDim2.new(-0.475916475, 0, 0.849999964, 0)
		NoifyFrame.Size = sizeold
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = NoifyFrame

		DropShadow.Name = "DropShadow"
		DropShadow.Parent = NoifyFrame
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1.000
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 37, 1, 37)
		DropShadow.ZIndex = -2
		DropShadow.Image = "rbxassetid://6014261993"
		DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropShadow.ImageTransparency = 0.500
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

		NoifyBy.Name = "NoifyBy"
		NoifyBy.Parent = NoifyFrame
		NoifyBy.AnchorPoint = Vector2.new(0.5, 0)
		NoifyBy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NoifyBy.BackgroundTransparency = 1.000
		NoifyBy.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NoifyBy.BorderSizePixel = 0
		NoifyBy.Position = UDim2.new(0.5, 0, 0.0999967828, 0)
		NoifyBy.Size = UDim2.new(0.949999988, 0, 0.25, 0)
		NoifyBy.ZIndex = 4
		NoifyBy.Font = Enum.Font.RobotoMono
		NoifyBy.Text = Subject or "Noify"
		NoifyBy.TextColor3 = Lino.TextColor
		NoifyBy.TextScaled = true
		NoifyBy.TextSize = 14.000
		NoifyBy.TextWrapped = true
		NoifyBy.TextXAlignment = Enum.TextXAlignment.Left
		NoifyBy.RichText = true

		Countdown.Name = "Countdown"
		Countdown.Parent = NoifyFrame
		Countdown.AnchorPoint = Vector2.new(0, 1)
		Countdown.BackgroundColor3 = Lino.DefaultColor
		Countdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Countdown.BorderSizePixel = 0
		Countdown.Position = UDim2.new(0, 0, 1, 0)
		Countdown.Size = UDim2.new(0, 0, 0.200000003, 0)

		NoifyText.Name = "NoifyText"
		NoifyText.Parent = NoifyFrame
		NoifyText.AnchorPoint = Vector2.new(0.5, 0)
		NoifyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NoifyText.BackgroundTransparency = 1.000
		NoifyText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NoifyText.BorderSizePixel = 0
		NoifyText.Position = UDim2.new(0.530685842, 0, 0.400001585, 0)
		NoifyText.Size = UDim2.new(0.888628125, 0, 0.349999994, 0)
		NoifyText.ZIndex = 4
		NoifyText.Font = Enum.Font.RobotoMono
		NoifyText.Text = Text or "Noify"
		NoifyText.TextColor3 = Lino.TextColor
		NoifyText.TextScaled = true
		NoifyText.TextSize = 10.000
		NoifyText.TextWrapped = true
		NoifyText.TextXAlignment = Enum.TextXAlignment.Right
		NoifyText.RichText = true

		local function UpdateText()
			local size = TextService:GetTextSize(NoifyText.Text,NoifyText.TextSize,NoifyText.Font,Vector2.new(math.huge,math.huge))

			TweenService:Create(NoifyFrame,TweenInfo.new(0.3),{Size = UDim2.new(0,size.X + 9,sizeold.Y.Scale,0)}):Play()
		end

		local function Effect(val,s)
			if val then
				TweenService:Create(Countdown,TweenInfo.new(s),{BackgroundTransparency = 0}):Play()
				TweenService:Create(NoifyText,TweenInfo.new(s),{TextTransparency = 0}):Play()
				TweenService:Create(NoifyBy,TweenInfo.new(s),{TextTransparency = 0}):Play()
				TweenService:Create(DropShadow,TweenInfo.new(s),{ImageTransparency = 0.5}):Play()
				TweenService:Create(NoifyFrame,TweenInfo.new(s),{BackgroundTransparency = 0}):Play()
			else
				TweenService:Create(Countdown,TweenInfo.new(s),{BackgroundTransparency = 1}):Play()
				TweenService:Create(NoifyText,TweenInfo.new(s),{TextTransparency = 1}):Play()
				TweenService:Create(NoifyBy,TweenInfo.new(s),{TextTransparency = 1}):Play()
				TweenService:Create(DropShadow,TweenInfo.new(s),{ImageTransparency = 1}):Play()
				TweenService:Create(NoifyFrame,TweenInfo.new(s),{BackgroundTransparency = 1}):Play()
			end
		end

		coroutine.wrap(function()
			Effect(false,0)
			NoifyFrame.Size = UDim2.new(0,0,0,0)
			task.wait(0.1)
			Effect(true,0.4)
			UpdateText()
			Countdown.Size = UDim2.new(0,0,.2,0)
			local tween = TweenService:Create(Countdown,TweenInfo.new(Time),{Size = UDim2.new(1,0,0.2,0)})
			tween:Play()
			UpdateText()
			tween.Completed:Wait()
			UpdateText()
			task.wait(0.3)
			TweenService:Create(NoifyFrame,TweenInfo.new(0.3),{Size = UDim2.new(0,0,0,0)}):Play()
			Effect(false,1)
			task.wait(1)
			NoifyFrame:Destroy()
		end)()
	end

	return Functions
end

return Lino
