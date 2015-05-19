-- clientside includes
include('shared.lua')

GM.MouseOffsetX = 0
GM.MouseOffsetY = 0

function GM:CalcView(ply, origin, angles, fov)
	local view = {}
	
	view.origin = self.CamPos + Vector(0, 10, 0) + Vector(self.MouseOffsetX, self.MouseOffsetY, 0)
	view.angles = self.CamAng
	view.fov = 70
	
	return view
end

function GM:Draw()
	self.BaseClass:Draw()
end

function GM:Think()
	self.BaseClass:Think()
	
	local centerX = ScrW() / 2
	self.MouseOffsetX = (gui.MouseX() - centerX) / 20
	
	local centerY = ScrH() / 2
	self.MouseOffsetY = (centerY - gui.MouseY()) / 80
	
	net.Start('ZS_MouseOffset')
		net.WriteFloat(self.MouseOffsetX)
		net.WriteFloat(self.MouseOffsetY)
	net.SendToServer()
	
	gui.EnableScreenClicker(true)
end

function GM:HUDShouldDraw()
	return false
end

function GM:GUIMousePressed(mc, vec)
	if mc == MOUSE_LEFT then
		RunConsoleCommand("+attack")
	end
	
	if mc == MOUSE_RIGHT then
		RunConsoleCommand("+attack2")
	end
end

function GM:GUIMouseReleased(mc)
	if mc == MOUSE_LEFT then
		RunConsoleCommand("-attack")
	end
	
	if mc == MOUSE_RIGHT then
		RunConsoleCommand("-attack2")
	end
end