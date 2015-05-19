AddCSLuaFile()

ENT.Type = 'anim'
ENT.Base = 'base_anim'

ENT.AutomaticFrameAdvance = true

ENT.Position = Vector(0, 50, -60)
ENT.DownPosition = Vector(0, 0, -15)
ENT.Angles = Angle(170, 0, 120)

if SERVER then
	
	function ENT:Initialize()
		self:SetModel('models/Kleiner.mdl')
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		--self:Spawn()
		
		--TranslatePhysBoneToBone
		--Entity:ManipulateBoneScale( Bone, TargetScale )
	end
	
	function ENT:Think()
		local oldPos = self:GetPos()
		local oldAng = self:GetAngles()
		
		local handPos = GAMEMODE.CamPos + self.Position + (Entity(1):KeyDown(IN_ATTACK) and self.DownPosition or Vector(0, 0, 0))
		
		local newPos = handPos + Vector(GAMEMODE.MouseOffsetX * 1.5, GAMEMODE.MouseOffsetY * 2.2, 0)
		local newAng = self.Angles
		
		local lerpPos = LerpVector(0.1, oldPos, newPos)
		local lerpAng = LerpAngle(0.1, oldAng, newAng)
		
		self:SetPos(lerpPos)
		self:SetAngles(lerpAng)
		
		self:NextThink(CurTime())
		
		return true
		
		--local newPos = GAMEMODE.CamPos + self.Position + Vector(GAMEMODE.MouseOffsetX * 1.5, GAMEMODE.MouseOffsetY * 2.2, 0)
		
		--if input.IsMouseDown(MOUSE_LEFT) then
		--	newPos = newPos + self.DownPosition
		--end
		
		--self:SetPos(newPos)
		--self:SetAngles(self.Angles)
	end
	
end

if CLIENT then
	
	local armBones = {
		'ValveBiped.Bip01_R_Hand',
		'ValveBiped.Bip01_R_Wrist',
		'ValveBiped.Bip01_R_Ulna',
		'ValveBiped.Bip01_R_Forearm',
		'ValveBiped.Bip01_R_Elbow',
		'ValveBiped.Bip01_R_UpperArm',
		'ValveBiped.Bip01_R_Bicep',
		'ValveBiped.Bip01_R_Trapezius',
		'ValveBiped.Bip01_R_Finger0',
		'ValveBiped.Bip01_R_Finger1',
		'ValveBiped.Bip01_R_Finger2',
		'ValveBiped.Bip01_R_Finger3',
		'ValveBiped.Bip01_R_Finger4',
		'ValveBiped.Bip01_R_Finger01',
		'ValveBiped.Bip01_R_Finger02',
		'ValveBiped.Bip01_R_Finger11',
		'ValveBiped.Bip01_R_Finger12',
		'ValveBiped.Bip01_R_Finger21',
		'ValveBiped.Bip01_R_Finger22',
		'ValveBiped.Bip01_R_Finger31',
		'ValveBiped.Bip01_R_Finger32',
		'ValveBiped.Bip01_R_Finger41',
		'ValveBiped.Bip01_R_Finger42'
	}
	
	ENT.armBoneIndexes = {}
	
	function ENT:Initialize()
		for _, bone in pairs(armBones) do
			index = self:LookupBone(bone)
			
			if index then
				table.insert(self.armBoneIndexes, index)
			end
		end
	end
	
	function ENT:Draw()
		for i = 0, self:GetBoneCount() do
			if not table.HasValue(self.armBoneIndexes, i) then
				--self:BoneScale(i, 0)
				self:ManipulateBoneScale(i, Vector(0, 0, 0))
			end
		end
		
		self:DrawModel()
	end
	
	-- from tiramisu 2
	function ENT:BoneScale(boneid, scale)
		local matBone = self:GetBoneMatrix(boneid)
		
		if matBone then
			matBone:Scale(Vector(scale, scale, scale))
			self:SetBoneMatrix(boneid, matBone)
		end
	end

	
end