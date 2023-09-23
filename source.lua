gethui = gethui or function() return game:FindFirstChild('CoreGui') or game.Players.LocalPlayer.PlayerGui end

local TweenService = game:GetService('TweenService')
local UIPB = gethui()
local TextService = game:GetService('TextService')
local UserInputServie = game:GetService('UserInputService')
local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
local IsKeying = false

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
	local ef=Instance.new("UIStroke")
	ripple.Active = false
	ripple.Name = "ripple"
	ripple.Parent = Parent
	ripple.BackgroundColor3 = Lino.RippleColor
	ripple.ZIndex = Parent.ZIndex or 7
	ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	ripple.Size = UDim2.new(0,0,0,0)
	ripple.SizeConstraint = Enum.SizeConstraint.RelativeYY
	ef.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	ef.Color=Color3.fromRGB(255, 255, 255)
	ef.Thickness=2
	ef.Parent=ripple
	ef.Transparency=1
	
	TweenService:Create(ef,TweenInfo.new(0.1),{Transparency=0}):Play()
	
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

	coroutine.wrap(function()
		TweenService:Create(ef,TweenInfo.new(2),{Transparency=.1}):Play()
		TweenService:Create(ripple,TweenInfo.new(2),{Size = Size_UP,BackgroundTransparency = 1}):Play()
		task.wait(0.1)
		TweenService:Create(ripple,TweenInfo.new(2),{Size = Size_UP,BackgroundTransparency = 1}):Play()
		task.wait(0.1)
		TweenService:Create(ripple,TweenInfo.new(2),{Size = Size_UP,BackgroundTransparency = 1}):Play()
		task.wait(0.1)
		TweenService:Create(ripple,TweenInfo.new(2),{Size = Size_UP,BackgroundTransparency = 1}):Play()
	end)()

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
	repeat task.wait(0.01) until not IsKeying

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

	Frame.Active = false
	Header.Active = true

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

	Frame:SetAttribute("Theme","BackgroundColor3 BlackgroundColor")

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

	DropShadow:SetAttribute("Theme","ImageColor3 DropShadowColor")

	Header.Name = "Header"
	Header.Parent = Frame
	Header.BackgroundColor3 = Lino.DefaultColor
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0.100000001, 0)
	Header:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
	Title:SetAttribute("Theme","TextColor3 TextColor")

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

	CloseButton:SetAttribute("Theme","TextColor3 TextColor")

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
	TabButtons:SetAttribute("Theme","ScrollBarImageColor3 ScrollingColor")

	UIListLayout.Parent = TabButtons
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Frame_2.Parent = left
	Frame_2.AnchorPoint = Vector2.new(0.5, 1)
	Frame_2.BackgroundColor3 = Lino.DefaultColor
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0.5, 0, 0.99000001, 0)
	Frame_2.Size = UDim2.new(0.949999988, 0, 0.115500003, 0)
	Frame_2:SetAttribute('Theme',"BackgroundColor3 DefaultColor")
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
	UserName.Text = "#"..tostring(plr.UserId):sub(0,5)..tostring('***')
	UserName.TextColor3 = Lino.TextColor
	UserName.TextScaled = true
	UserName.TextSize = 14.000
	UserName.TextWrapped = true
	UserName.TextXAlignment = Enum.TextXAlignment.Left
	UserName:SetAttribute("Theme","TextColor3 TextColor")

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
		TabButton:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
		TextLabel:SetAttribute("Theme","TextColor3 TextColor")

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
		Tab:SetAttribute("Theme","ScrollBarImageColor3 ScrollingColor")

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
			Label:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			Button:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			Toggle:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			Textbox:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			TextBox:SetAttribute("Theme","TextColor3 TextColor")
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
			Keybind:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			Key:SetAttribute("Theme","TextColor3 TextColor")

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
			Slider:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			ValueText:SetAttribute("Theme","TextColor3 TextColor")

			local function UpdateText()
				local a = TextService:GetTextSize(ValueText.Text,ValueText.TextSize,ValueText.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(ValueText,TweenInfo.new(0.3),{Size = UDim2.new(0,a.X + 9,0.349999994, 0)}):Play()
			end

			local danger = false

			Frame.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = true
				end
			end)

			Frame.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = false
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
			Dropdown.BackgroundColor3 = Lino.BlackColor
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			Dropdown:SetAttribute('Theme',"BackgroundColor3 BlackColor")

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
			Top:SetAttribute("Theme","BackgroundColor3 DefaultColor")

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
			DropdownIcon:SetAttribute("Theme","TextColor3 TextColor")

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
			Title:SetAttribute("Theme","TextColor3 TextColor")

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
			ValueText:SetAttribute("Theme","TextColor3 TextColor")

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
			ScrollingFrame:SetAttribute("Theme","ScrollBarImageColor3 ScrollingColor")


			UIAspectRatioConstraint_3.Parent = ScrollingFrame
			UIAspectRatioConstraint_3.AspectRatio = 3.500
			UIAspectRatioConstraint_3.AspectType = Enum.AspectType.ScaleWithParentSize

			local function UpdateText()
				local size1 = TextService:GetTextSize(Title.Text,Title.TextSize,Title.Font,Vector2.new(math.huge,math.huge))
				local size2 = TextService:GetTextSize(ValueText.Text,ValueText.TextSize,ValueText.Font,Vector2.new(math.huge,math.huge))

				TweenService:Create(ValueText,TweenInfo.new(0.4),{Size = UDim2.new(0, size2.X + 11, 0.550000012, 0)}):Play()
				TweenService:Create(Title,TweenInfo.new(0.4),{Size = UDim2.new(0, size1.X + 15, 0.550000012, 0)}):Play()
			end

			local function atran(number)
				for i,v : TextButton in ipairs(ScrollingFrame:GetChildren()) do
					if v:isA('TextButton') then
						v:SetAttribute("MainTran",number)
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

				Button:SetAttribute("Theme","TextColor3 TextColor")
				Button:SetAttribute("Theme2","BackgroundColor3 DefaultColor")

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

		function TabFunctions:NewColorPicker(ColorPickerName,Default,callback)
			Default=Default or Color3.fromRGB(255, 255, 255)
			callback=callback or function()

			end

			local ColorPicker = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Top = Instance.new("Frame")
			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
			local TextFont = Instance.new("Frame")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local Title = Instance.new("TextLabel")
			local Icon = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local InputButton = Instance.new("TextButton")
			local MainFrame = Instance.new("Frame")
			local RGB = Instance.new("ImageLabel")
			local Marker = Instance.new("Frame")
			local ImageLabel = Instance.new("ImageLabel")
			local Value = Instance.new("ImageLabel")
			local Marker_2 = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")

			ColorPicker.Name = "ColorPicker"
			ColorPicker.Parent = Tab
			ColorPicker.BackgroundColor3 = Lino.BlackColor
			ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ColorPicker.BorderSizePixel = 0
			ColorPicker.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			ColorPicker:SetAttribute('Theme',"BackgroundColor3 BlackColor")
			UIListLayout.Parent = ColorPicker
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 3)

			UIAspectRatioConstraint.Parent = ColorPicker
			UIAspectRatioConstraint.AspectRatio = 10.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = ColorPicker

			UIStroke.Transparency = 1.000
			UIStroke.Color = Color3.fromRGB(85, 85, 85)
			UIStroke.Parent = ColorPicker

			Top.Name = "Top"
			Top.Parent = ColorPicker
			Top.BackgroundColor3 = Lino.DefaultColor

			Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Top.BorderSizePixel = 0
			Top.Size = UDim2.new(1, 0, 1, 0)
			Top.ZIndex = 4
			Top:SetAttribute('Theme',"BackgroundColor3 DefaultColor")

			UIAspectRatioConstraint_2.Parent = Top
			UIAspectRatioConstraint_2.AspectRatio = 10.000
			UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize

			TextFont.Name = "TextFont"
			TextFont.Parent = Top
			TextFont.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextFont.BackgroundTransparency = 1.000
			TextFont.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextFont.BorderSizePixel = 0
			TextFont.Position = UDim2.new(0.0250002109, 0, 0, 0)
			TextFont.Size = UDim2.new(0.79044497, 0, 1, 0)
			TextFont.ZIndex = 5

			UIListLayout_2.Parent = TextFont
			UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

			Title.Name = "Title"
			Title.Parent = TextFont
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.517898083, 0, 0.499999583, 0)
			Title.Size = UDim2.new(0.758300483, 66, 0.550000012, 0)
			Title.ZIndex = 7
			Title.Font = Enum.Font.RobotoMono
			Title.Text = ColorPickerName or "ColorPicker"
			Title.TextColor3 = Lino.TextColor
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title:SetAttribute("Theme","TextColor3 TextColor")
			Icon.Name = "Icon"
			Icon.Parent = Top
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundColor3 = Default
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.980000019, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.125, 0, 0.550000012, 0)
			Icon.ZIndex = 9

			UICorner_2.CornerRadius = UDim.new(0.5, 0)
			UICorner_2.Parent = Icon

			UIStroke_2.Color = Color3.fromRGB(18, 18, 18)
			UIStroke_2.Parent = Icon

			InputButton.Name = "InputButton"
			InputButton.Parent = Icon
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.ZIndex = 1000
			InputButton.Font = Enum.Font.SourceSans
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000

			MainFrame.Name = "MainFrame"
			MainFrame.Parent = ColorPicker
			MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MainFrame.BackgroundTransparency = 1.000
			MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			MainFrame.Size = UDim2.new(0.949999988, 0, 0.5, 0)
			MainFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX
			MainFrame.Visible = false

			RGB.Name = "RGB"
			RGB.Parent = MainFrame
			RGB.AnchorPoint = Vector2.new(0.5, 0)
			RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			RGB.BorderColor3 = Color3.fromRGB(40, 40, 40)
			RGB.BorderSizePixel = 2
			RGB.ClipsDescendants = true
			RGB.Position = UDim2.new(0.421602249, 0, 0.0900298506, 0)
			RGB.Size = UDim2.new(0.75, 0, 0.75, 0)
			RGB.SizeConstraint = Enum.SizeConstraint.RelativeYY
			RGB.ZIndex = 4
			RGB.Image = "rbxassetid://1433361550"
			RGB.SliceCenter = Rect.new(10, 10, 90, 90)

			Marker.Name = "Marker"
			Marker.Parent = RGB
			Marker.AnchorPoint = Vector2.new(0.5, 0.5)
			Marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Marker.BackgroundTransparency = 1.000
			Marker.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Marker.BorderSizePixel = 0
			Marker.Position = UDim2.new(0.5, 0, 0.5, 0)
			Marker.Size = UDim2.new(0, 4, 0, 4)
			Marker.ZIndex = 5

			ImageLabel.Parent = Marker
			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.BackgroundTransparency = 1.000
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ImageLabel.Size = UDim2.new(2, 0, 2, 0)
			ImageLabel.ZIndex = 5
			ImageLabel.Image = "rbxassetid://12845252201"

			Value.Name = "Value"
			Value.Parent = MainFrame
			Value.AnchorPoint = Vector2.new(0.5, 0)
			Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderColor3 = Color3.fromRGB(40, 40, 40)
			Value.BorderSizePixel = 2
			Value.Position = UDim2.new(0.732019007, 0, 0.0900298506, 0)
			Value.Size = UDim2.new(0.0567957126, 0, 0.736706376, 0)
			Value.ZIndex = 4
			Value.Image = "rbxassetid://359311684"
			Value.SliceCenter = Rect.new(10, 10, 90, 90)

			Marker_2.Name = "Marker"
			Marker_2.Parent = Value
			Marker_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Marker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Marker_2.BackgroundTransparency = 1.000
			Marker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Marker_2.BorderSizePixel = 0
			Marker_2.Position = UDim2.new(0.5, 0, 0, 0)
			Marker_2.Size = UDim2.new(1, 4, 0, 2)
			Marker_2.ZIndex = 5

			TextLabel.Parent = Marker_2
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(1, 0, 0, 0)
			TextLabel.Size = UDim2.new(2, 0, 5, 0)
			TextLabel.ZIndex = 5
			TextLabel.Font = Enum.Font.RobotoMono
			TextLabel.Text = "<"
			TextLabel.TextColor3 = Lino.TextColor
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel:SetAttribute("Theme","TextColor3 TextColor")
			UIAspectRatioConstraint_3.Parent = MainFrame
			UIAspectRatioConstraint_3.AspectRatio = 2.000
			UIAspectRatioConstraint_3.AspectType = Enum.AspectType.ScaleWithParentSize
			UIAspectRatioConstraint_3.DominantAxis = Enum.DominantAxis.Height

			local function UpdateText()
				local size1 = TextService:GetTextSize(Title.Text,Title.TextSize,Title.Font,Vector2.new(math.huge,math.huge))
				TweenService:Create(Title,TweenInfo.new(0.4),{Size = UDim2.new(0, size1.X + 15, 0.550000012, 0)}):Play()
			end

			local function atran(number)
				TweenService:Create(RGB,TweenInfo.new(0.4),{BackgroundTransparency=number,ImageTransparency=number}):Play()
				TweenService:Create(ImageLabel,TweenInfo.new(0.4),{ImageTransparency=number}):Play()
				TweenService:Create(TextLabel,TweenInfo.new(0.4),{TextTransparency=number}):Play()
				TweenService:Create(Value,TweenInfo.new(0.4),{ImageTransparency=number}):Play()

				RGB:SetAttribute('MainTran',number)
				ImageLabel:SetAttribute('MainTran',number)
				TextLabel:SetAttribute('MainTran',number)
				Value:SetAttribute('MainTran',number)

			end

			local function toggle(ca)
				coroutine.wrap(function()
					if ca then
						MainFrame.Visible = true
						TweenService:Create(UIAspectRatioConstraint,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{AspectRatio = 1.7}):Play()
						task.wait(0.1)
						atran(0)
					else
						TweenService:Create(UIAspectRatioConstraint,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{AspectRatio = 10}):Play()
						atran(1)

						task.wait(0.55)

						if UIAspectRatioConstraint.AspectRatio == 10 then
							MainFrame.Visible = false
						end
					end
				end)()
			end

			toggle(false)

			local sdwasdw=false
			local db_g=false
			local is_touch_12=false
			InputButton.MouseButton1Click:Connect(function()
				Create_Ripple(Top)
				sdwasdw=not sdwasdw

				toggle(sdwasdw)
			end)

			RGB.InputBegan:Connect(function(a)
				if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then
					db_g=true
				end
			end)

			local function RGBToHSV(rgb)
				local r, g, b = rgb.r, rgb.g, rgb.b
				local max = math.max(r, g, b)
				local min = math.min(r, g, b)
				local hue, saturation, value

				if max == min then
					hue = 0
				elseif max == r then
					hue = ((g - b) / (max - min)) % 6
				elseif max == g then
					hue = ((b - r) / (max - min)) + 2
				elseif max == b then
					hue = ((r - g) / (max - min)) + 4
				end

				hue = math.floor(hue * 60)
				if hue < 0 then
					hue = hue + 360
				end

				if max == 0 then
					saturation = 0
				else
					saturation = 1 - (min / max)
				end

				value = max

				return Color3.new(hue / 360, saturation, value)
			end

			RGB.InputEnded:Connect(function(a)
				if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then
					db_g=false

				end
			end)

			Value.InputBegan:Connect(function(a)
				if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then
					is_touch_12=true
				end
			end)

			Value.InputEnded:Connect(function(a)
				if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then
					is_touch_12=false

				end
			end)

			local val=RGBToHSV(Default)
			local color_data = {val.R,val.G,val.B}

			local function setColor(hue,sat,val)
				color_data = {hue or color_data[1],sat or color_data[2],val or color_data[3]}
				Default = Color3.fromHSV(color_data[1],color_data[2],color_data[3])
				Icon.BackgroundColor3=Default

				callback(Default)
			end

			local function loads()
				Icon.BackgroundColor3=Default
				Marker_2.Position=UDim2.new(0.5,0,color_data[3],0)
				Marker.Position = UDim2.new(color_data[1],0,color_data[2]-1,0)
			end

			local function inBounds(frame)
				local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
				local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
				return math.clamp(x,0,maxX)/maxX,math.clamp(y,0,maxY)/maxY
			end

			local function UpdateRGB()
				if db_g then
					local x,y = inBounds(RGB)
					if x and y then
						Marker.Position = UDim2.new(x,0,y,0)
						setColor(1 - x,1 - y)
					end
				end

				if is_touch_12 then

					local x,y = inBounds(Value)
					if x and y then
						Marker_2.Position = UDim2.new(0.5,0,y,0)
						setColor(nil,nil,1 - y)
					end
				end
			end

			UserInputServie.InputChanged:Connect(function(a)
				if db_g or is_touch_12 then
					UpdateRGB()
				end
			end)

			loads()
		end

		return TabFunctions
	end

	local function UI_Toggle(val,timea,k)
		coroutine.wrap(function()
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
		Frame.Size = UDim2.new(0,0,0.25,150)
		UI_Toggle(nil,0,1)
		task.wait(0.01)
		Frame.Size = UDim2.new(0,0,0.25,150)
		UI_Toggle(nil,0,1)
		TweenInfo.new(0.1)
		Frame.Size = UDim2.new(0,0,0.25,150)
		UI_Toggle(nil,0,1)
		Frame.Size = UDim2.new(0,0,0.25,150)
		Frame.Position = UDim2.new(0.1,0,.5,0)
		Frame.BackgroundTransparency = 1
		TweenService:Create(Frame,TweenInfo.new(1.5,Enum.EasingStyle.Quint),{Size = UDim2.new(0.25, 225, 0.25, 150),BackgroundTransparency=0,Position=UDim2.new(0.5,0,0.5,0)}):Play()
		task.wait(1.65)
		UI_Toggle(true,1)
	end

	coroutine.wrap(function()
		Frame.Size = UDim2.new(0,0,0.25,150)
		Frame.Size = UDim2.new(0,0,0.25,150)
		Frame.Position = UDim2.new(0.1,0,.5,0)
		Frame.BackgroundTransparency = 1
		UI_Toggle(nil,0,1)
		task.wait(1.5)
		if Frame.Size == UDim2.new(0,0,0.25,150) then
			UI_Toggle(nil,0,1)
			TweenService:Create(Frame,TweenInfo.new(1.5,Enum.EasingStyle.Quint),{Size = UDim2.new(0.25, 225, 0.25, 150),BackgroundTransparency=0,Position=UDim2.new(0.5,0,0.5,0)}):Play()
			task.wait(1.75)
			UI_Toggle(true,1)
		end
	end)()

	local function get_arge(text:string)
		local space=text:find(" ")

		local a2=text:sub(space+1)
		local a1=text:sub(0,space-1)
		return {a1,a2}
	end

	function WindowFunctions:UpdateTheme()
		for i,v :GuiObject in ipairs(ScreenGui:GetDescendants()) do
			--ScrollingFrame:SetAttribute("Theme2","BackgroundColor3 DefaultColor")
			if v:GetAttribute('Theme') then
				local arges =get_arge(v:GetAttribute('Theme'))

				local g,n =	pcall(function()
					if v[arges[1]] then
						if Lino[arges[2]] then
							v[arges[1]]=Lino[arges[2]]
						else
							print(arges[2])
						end
					end
				end)


			end

			if v:GetAttribute('Theme2') then
				local arges =get_arge(v:GetAttribute('Theme2'))

				pcall(function()
					if v[arges[1]] then
						if Lino[arges[2]] then
							v[arges[1]]=Lino[arges[2]]
						end
					end
				end)
			end
		end
	end
	
	function WindowFunctions:UIToggle(ToggleName,Default,callback)
		Default=Default or false
		callback=callback or function()
			
		end
		
		local UIToggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local DropShadow = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local Icon = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ToggleIcon = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local InputButton = Instance.new("TextButton")

		UIToggle.Name = "UIToggle"
		UIToggle.Parent = ScreenGui
		UIToggle.BackgroundColor3 = Lino.BlackgroundColor
		UIToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UIToggle.BorderSizePixel = 0
		UIToggle.Position = UDim2.new(0.0392196327, 0, 0.0475543551, 0)
		UIToggle.Size = UDim2.new(0.200000003, 0, 0.200000003, 0)
		UIToggle.SizeConstraint = Enum.SizeConstraint.RelativeYY
		UIToggle.ZIndex = 10
		UIToggle.Active=true
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = UIToggle

		DropShadow.Name = "DropShadow"
		DropShadow.Parent = UIToggle
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1.000
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 47, 1, 47)
		DropShadow.ZIndex = 9
		DropShadow.Image = "rbxassetid://6014261993"
		DropShadow.ImageColor3 = Lino.DropShadowColor
		DropShadow.ImageTransparency = 0.500
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

		Title.Name = "Title"
		Title.Parent = UIToggle
		Title.AnchorPoint = Vector2.new(0.5, 0)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.5, 0, 0.13593477, 0)
		Title.Size = UDim2.new(1.00000012, 0, 0.23491846, 0)
		Title.ZIndex = 11
		Title.Font = Enum.Font.RobotoMono
		Title.Text = ToggleName or "Toggle"
		Title.TextColor3 = Lino.TextColor
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextWrapped = true

		Icon.Name = "Icon"
		Icon.Parent = UIToggle
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.75, 0)
		Icon.Size = UDim2.new(0.75, 0, 0.300000012, 0)
		Icon.ZIndex = 12

		UICorner_2.CornerRadius = UDim.new(0.5, 0)
		UICorner_2.Parent = Icon

		UIStroke.Color = Color3.fromRGB(255, 255, 255)
		UIStroke.Parent = Icon

		ToggleIcon.Name = "ToggleIcon"
		ToggleIcon.Parent = Icon
		ToggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ToggleIcon.BorderSizePixel = 0
		ToggleIcon.Position = UDim2.new(0.25, 0, 0.5, 0)
		ToggleIcon.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		ToggleIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ToggleIcon.ZIndex = 13

		UICorner_3.CornerRadius = UDim.new(0.5, 0)
		UICorner_3.Parent = ToggleIcon

		InputButton.Name = "InputButton"
		InputButton.Parent = UIToggle
		InputButton.AnchorPoint = Vector2.new(0.5, 0.5)
		InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InputButton.BackgroundTransparency = 1.000
		InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputButton.BorderSizePixel = 0
		InputButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		InputButton.Size = UDim2.new(0.98, 0, 0.98, 0)
		InputButton.ZIndex = 1000
		InputButton.Font = Enum.Font.SourceSans
		InputButton.Text = ""
		InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		InputButton.TextSize = 14.000
		InputButton.TextTransparency = 1.000
		
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
			Default=not Default
			valuechanger(Default)
			callback(Default)
		end)
		
		local dragToggle = nil
		local dragSpeed = 0.05
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(UIToggle, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end

		UIToggle.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = UIToggle.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)

		game:GetService('UserInputService').InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end)
		
		local Funtions={}
		
		function Funtions:Text(a)
			Title.Text=tostring(a)
		end
		
		function Funtions:Value(s)
			Default=s
			valuechanger(s)
			callback(s)
		end
		
		function Funtions:SetUI(value)
			if value then
				UIToggle.Visible=true
			else
				UIToggle.Visible=false
			end
		end
		
		return Funtions
	end
	
	function WindowFunctions:UIButton(ButtonName,callback)
		local UIButton = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local DropShadow = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local InputButton = Instance.new("TextButton")

		UIButton.Name = "UIButton"
		UIButton.Parent = ScreenGui
		UIButton.BackgroundColor3 = Lino.BlackgroundColor
		UIButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UIButton.BorderSizePixel = 0
		UIButton.Position = UDim2.new(0.184030563, 0, 0.0475543551, 0)
		UIButton.Size = UDim2.new(0.200000003, 0, 0.200000003, 0)
		UIButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
		UIButton.ZIndex = 10

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = UIButton

		DropShadow.Name = "DropShadow"
		DropShadow.Parent = UIButton
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1.000
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 47, 1, 47)
		DropShadow.ZIndex = 9
		DropShadow.Image = "rbxassetid://6014261993"
		DropShadow.ImageColor3 = Lino.DropShadowColor
		DropShadow.ImageTransparency = 0.500
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

		Title.Name = "Title"
		Title.Parent = UIButton
		Title.AnchorPoint = Vector2.new(0.5, 0)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.50000006, 0, 0.365214646, 0)
		Title.Size = UDim2.new(1.00000012, 0, 0.23491846, 0)
		Title.ZIndex =11
		Title.Font = Enum.Font.RobotoMono
		Title.Text = ButtonName or"Button"
		Title.TextColor3 = Lino.TextColor
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextWrapped = true

		InputButton.Name = "InputButton"
		InputButton.Parent = UIButton
		InputButton.AnchorPoint = Vector2.new(0.5, 0.5)
		InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InputButton.BackgroundTransparency = 1.000
		InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputButton.BorderSizePixel = 0
		InputButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		InputButton.Size = UDim2.new(0.98, 0, 0.98, 0)
		InputButton.ZIndex = 1000
		InputButton.Font = Enum.Font.SourceSans
		InputButton.Text = ""
		InputButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		InputButton.TextSize = 14.000
		InputButton.TextTransparency = 1.000
		
		local dragToggle = nil
		local dragSpeed = 0.05
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(UIButton, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end

		UIButton.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = UIButton.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)

		game:GetService('UserInputService').InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end)
		
		InputButton.MouseButton1Click:Connect(function()
			Create_Ripple(InputButton)
			callback()
		end)
		
		local Funtions={}

		function Funtions:Text(a)
			Title.Text=tostring(a)
		end

		function Funtions:SetUI(value)
			if value then
				UIButton.Visible=true
			else
				UIButton.Visible=false
			end
		end

		return Funtions
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
			local text = tostring(NoifyText.Text)..tostring(" ")..tostring(NoifyBy.Text)
			local size = TextService:GetTextSize(text,NoifyText.TextSize,NoifyText.Font,Vector2.new(math.huge,math.huge))

			TweenService:Create(NoifyFrame,TweenInfo.new(0.3),{Size = UDim2.new(0,size.X + 3.5,sizeold.Y.Scale,0)}):Play()
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

function Lino:SettupKeySystem(TitleName,ButtonText,LinkToGetKey,callback)
	callback = callback or function() return true end
	ButtonText = ButtonText or "Get Key"
	LinkToGetKey = LinkToGetKey or "1234"
	TitleName = TitleName or "Key System"
	IsKeying = true

	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local HeadLabl = Instance.new("TextLabel")
	local Frame_2 = Instance.new("Frame")
	local GetButton = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local SubmitButton = Instance.new("TextButton")
	local UICorner_2 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local TextBox = Instance.new("TextBox")

	local function settupvaluee(val,ta)
		if val then
			Frame.Position = UDim2.new(0.5,0,.9,0)
			TweenService:Create(Frame,TweenInfo.new(1.5,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(.5,.5)}):Play()

			for i,v:ImageLabel in ipairs(ScreenGui:GetDescendants()) do
				if  v:isA('TextLabel') or v:isA('TextBox') then
					local oold = v.TextTransparency
					v.TextTransparency =  1
					TweenService:Create(v,TweenInfo.new(ta),{TextTransparency = oold}):Play()

					if v.BackgroundTransparency ~= 1 then
						local oold = v.BackgroundTransparency
						v.BackgroundTransparency =  1
						TweenService:Create(v,TweenInfo.new(ta),{BackgroundTransparency = oold}):Play()
					end
				end

				if  v:isA('Frame') then
					local oold = v.BackgroundTransparency
					v.BackgroundTransparency =  1
					TweenService:Create(v,TweenInfo.new(ta),{BackgroundTransparency = oold}):Play()
				end

				if  v:isA('ImageLabel') then
					local oold = v.ImageTransparency
					v.ImageTransparency =  1
					TweenService:Create(v,TweenInfo.new(ta),{ImageTransparency = oold}):Play()
				end
			end
		else
			TweenService:Create(Frame,TweenInfo.new(1.5,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(.5,1.1)}):Play()

			for i,v:ImageLabel in ipairs(ScreenGui:GetDescendants()) do
				pcall(function()
					TweenService:Create(v,TweenInfo.new(ta),{TextTransparency = 1}):Play()
				end)
				pcall(function()
					TweenService:Create(v,TweenInfo.new(ta),{BackgroundTransparency = 1}):Play()
				end)

				pcall(function()
					TweenService:Create(v,TweenInfo.new(ta),{BackgroundTransparency = 1}):Play()
				end)

				pcall(function()
					TweenService:Create(v,TweenInfo.new(ta),{ImageTransparency = 1}):Play()
				end)
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
	Frame.Size = UDim2.new(0.150000006, 150, 0.150000006, 100)

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Frame
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = -2
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	HeadLabl.Name = "HeadLabl"
	HeadLabl.Parent = Frame
	HeadLabl.AnchorPoint = Vector2.new(0.5, 0)
	HeadLabl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeadLabl.BackgroundTransparency = 1.000
	HeadLabl.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadLabl.BorderSizePixel = 0
	HeadLabl.Position = UDim2.new(0.5, 0, 0.0500000007, 0)
	HeadLabl.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)
	HeadLabl.Font = Enum.Font.RobotoMono
	HeadLabl.Text = TitleName or "Key System"
	HeadLabl.TextColor3 = Lino.TextColor
	HeadLabl.TextScaled = true
	HeadLabl.TextSize = 14.000
	HeadLabl.TextWrapped = true

	Frame_2.Parent = Frame
	Frame_2.AnchorPoint = Vector2.new(0.5, 0)
	Frame_2.BackgroundColor3 = Lino.DefaultColor
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0.5, 0, 0.272905767, 0)
	Frame_2.Size = UDim2.new(1, 0, 0.00999999978, 0)

	GetButton.Name = "GetButton"
	GetButton.Parent = Frame
	GetButton.AnchorPoint = Vector2.new(0.5, 0)
	GetButton.BackgroundColor3 = Lino.DefaultColor
	GetButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GetButton.BorderSizePixel = 0
	GetButton.Position = UDim2.new(0.245955393, 0, 0.786188662, 0)
	GetButton.Size = UDim2.new(0.400000006, 0, 0.165038258, 0)
	GetButton.Font = Enum.Font.RobotoMono
	GetButton.Text = ButtonText or "Get Key"
	GetButton.TextColor3 = Lino.TextColor
	GetButton.TextScaled = true
	GetButton.TextSize = 14.000
	GetButton.TextWrapped = true

	UICorner.CornerRadius = UDim.new(0, 2)
	UICorner.Parent = GetButton

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = GetButton

	SubmitButton.Name = "SubmitButton"
	SubmitButton.Parent = Frame
	SubmitButton.AnchorPoint = Vector2.new(0.5, 0)
	SubmitButton.BackgroundColor3 = Lino.DefaultColor
	SubmitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SubmitButton.BorderSizePixel = 0
	SubmitButton.Position = UDim2.new(0.750702143, 0, 0.786188662, 0)
	SubmitButton.Size = UDim2.new(0.400000006, 0, 0.165038258, 0)
	SubmitButton.Font = Enum.Font.RobotoMono
	SubmitButton.Text = "Submit"
	SubmitButton.TextColor3 = Lino.TextColor
	SubmitButton.TextScaled = true
	SubmitButton.TextSize = 14.000
	SubmitButton.TextWrapped = true

	UICorner_2.CornerRadius = UDim.new(0, 2)
	UICorner_2.Parent = SubmitButton

	UIStroke_2.Transparency = 0.650
	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_2.Parent = SubmitButton

	TextBox.Parent = Frame
	TextBox.AnchorPoint = Vector2.new(0.5, 0)
	TextBox.BackgroundColor3 = Lino.DefaultColor
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0.5, 0, 0.493442565, 0)
	TextBox.Size = UDim2.new(0.949999988, 0, 0.100000001, 0)
	TextBox.ClearTextOnFocus = false
	TextBox.Font = Enum.Font.RobotoMono
	TextBox.PlaceholderText = "Paste Key"
	TextBox.Text = ""
	TextBox.TextColor3 = Lino.TextColor
	TextBox.TextScaled = true
	TextBox.TextSize = 14.000
	TextBox.TextWrapped = true
	TextBox.TextXAlignment = Enum.TextXAlignment.Left

	settupvaluee(true,0.5)

	GetButton.MouseButton1Click:Connect(function()
		Create_Ripple(GetButton)

		pcall(function()
			setclipboard(tostring(LinkToGetKey))
		end)

		pcall(function()
			toclipboard(tostring(LinkToGetKey))
		end)
	end)

	local ischecking = false

	SubmitButton.MouseButton1Click:Connect(function()
		if ischecking then
			return
		end

		ischecking = true

		SubmitButton.Text = "Checking"

		local a = pcall(function()
			if callback(TextBox.Text) then
				SubmitButton.TextColor3 = Color3.fromHSV(0.269278, 1, 1)
				TweenService:Create(SubmitButton,TweenInfo.new(0.4),{TextColor3 = Lino.TextColor}):Play()
				settupvaluee(false,.65)
				SubmitButton.Text = "Pass"

				task.wait(0.2)

				IsKeying = false
			else 
				SubmitButton.TextColor3 = Color3.fromHSV(0.997389, 1, 1)
				TweenService:Create(SubmitButton,TweenInfo.new(0.4),{TextColor3 = Lino.TextColor}):Play()
				IsKeying = true
				SubmitButton.Text = "Submit"
			end
		end)


		if not a then
			SubmitButton.TextColor3 = Color3.fromHSV(0.997389, 1, 1)
			TweenService:Create(SubmitButton,TweenInfo.new(0.4),{TextColor3 = Lino.TextColor}):Play()
			IsKeying = true
			SubmitButton.Text = "Submit"
		end

		ischecking = false
	end)
end

return Lino
