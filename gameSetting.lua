local game={}
game.type="game"
local contact=require("contact")


love.window.setTitle("龙猫")
love.graphics.setBackgroundColor(10, 10, 50)
game.world = love.physics.newWorld(0, 9.8*100, false)
love.physics.setMeter(20)
--game.world:setCallbacks(contact.start,contact.over)
local body = love.physics.newBody(game.world, 0, 0)
local shape = love.physics.newChainShape(true, 0, 0, 800, 0, 800, 600, 0, 600)
local fixture = love.physics.newFixture(body, shape)
fixture:setUserData({obj=game})

camera:setPosition(0,0)
camera:setWindow(0,0,800,600)



function camera:shake()
	if game.shake==true then 
        local maxShake = 5
        local atenuationSpeed = 4
        game.shakeIntensity = math.max(0 , game.shakeIntensity - atenuationSpeed * 0.02)

        if game.shakeIntensity > 0 then
            local x,y = self:getPosition()
            x = x + (100 - 200*math.random(game.shakeIntensity)) * 0.02
            y = y + (100 - 200*math.random(game.shakeIntensity)) * 0.02
            self:setPosition(x,y)
        else
            game.shake=false
        end
    end
end
return game
