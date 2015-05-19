-- clientside includes
AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_init.lua')

include('shared.lua')

GM.Zombie = nil
GM.Hand = nil

GM.MouseOffsetX = 0
GM.MouseOffsetY = 0

function GM:Initialize()
	
end

function GM:InitPostEntity()
	self.Hand = ents.Create('su_hand')
	self.Hand:Spawn()
end

net.Receive('ZS_MouseOffset', function()
	GAMEMODE.MouseOffsetX = net.ReadFloat()
	GAMEMODE.MouseOffsetY = net.ReadFloat()
end)

util.AddNetworkString('ZS_MouseOffset')