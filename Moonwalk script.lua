-- LocalScript dentro de StarterGui -> ScreenGui

-- Crear el botón en la pantalla
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.9, 0) -- abajo centrado
button.Text = "Moonwalk"
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = gui

-- Estado
local moonwalking = false

-- Función para activar/desactivar
button.MouseButton1Click:Connect(function()
	moonwalking = not moonwalking
	if moonwalking then
		button.Text = "Moonwalk ON"
	else
		button.Text = "Moonwalk OFF"
	end
end)

-- Bucle para simular moonwalk
game:GetService("RunService").RenderStepped:Connect(function()
	if moonwalking then
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			local humanoid = char.Humanoid

			-- Forzar que siempre mire adelante pero se mueva atrás
			if humanoid.MoveDirection.Magnitude > 0 then
				char:SetPrimaryPartCFrame(
					CFrame.new(char.PrimaryPart.Position, char.PrimaryPart.Position + humanoid.MoveDirection)
				)
				char.PrimaryPart.CFrame = char.PrimaryPart.CFrame * CFrame.new(0,0,0.2) -- se mueve hacia atrás
			end
		end
	end
end)
