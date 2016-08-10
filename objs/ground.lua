local ground=class("ground")

function ground:initialize(x,y,vert,texture)
	self.x=x or 0
	self.y=y or 800
	self.vert=vert or math.randomPolygon(20,10)
	self.vert=require("libs/smooth")(self.vert,1,3)
	table.insert(self.vert, self.vert[#self.vert-1])
	table.insert(self.vert,0)
	table.insert(self.vert,0)
	table.insert(self.vert,0)
	--table.insert(self.vert,1,self.vert[1])
	--table.insert(self.vert,2,0)
	
	self.texture=texture or love.graphics.newImage("texture/ground.png")
	self.texture:setWrap("repeat", "repeat")
	self.meshVert={}

	if love.math.isConvex(self.vert) then
		local triangles = love.math.triangulate( self.vert )
		for i,v in ipairs(triangles) do
			table.insert(self.meshVert, {v[1],v[2],v[1]/256,v[2]/128})
			table.insert(self.meshVert, {v[3],v[4],v[3]/256,v[4]/128})
			table.insert(self.meshVert, {v[5],v[6],v[5]/256,v[6]/128})
		end
		self.mesh = love.graphics.newMesh(self.meshVert,self.texture,"triangles")
	else 
		for i=1,#self.vert,2 do
			table.insert(self.meshVert,{self.vert[i],self.vert[i+1],self.vert[i]/256,self.vert[i+1]/128})
		end
		self.mesh = love.graphics.newMesh(self.meshVert,self.texture)
	end

	self.body = love.physics.newBody(game.world, self.x, self.y)
	local physicShape={}
	table.insert(physicShape, self.vert[#self.vert-1])
	table.insert(physicShape, self.vert[#self.vert])
	for i=#self.vert-2,1,-2 do
		if math.getDistance(self.vert[i-1],self.vert[i],self.vert[i+1],self.vert[i+2])>20 then
			table.insert(physicShape, self.vert[i-1])
			table.insert(physicShape, self.vert[i])
		end
	end
	self.shape = love.physics.newChainShape(true, unpack(physicShape))
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setFriction(30);
end

function ground:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.mesh, self.x, self.y)
	local vert= math.polygonTrans(self.x,self.y,0,1,self.vert)
	love.graphics.line(unpack(vert))
end


return ground