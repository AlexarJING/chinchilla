print(love.graphics.getRendererInfo())
require("libs/util")
class=require("libs/middleclass")
require("libs/bintable")
softbody=require("objs/soft")
slime_root=require("objs/slime")
slime_ball=require("objs/ball")
slime_rect=require("objs/rect")
slime_polygon=require("objs/polygon")
camera=require("libs/gamera").new(0,0,10*800,4*600)
game=require "gameSetting"
touch=require("touch")
ground=require("objs/ground")

local antiCount=2
local points={}


local dataCtrl=require("data")
dataCtrl:load()
for i,v in ipairs(game.data.stage[1]) do
    if v.type=="ground" then ground:new(x,y,v.vert,v.texture) end
end


function love.load() 
	game.slimes={}
	game.ground={}
	table.insert(game.slimes,slime_rect:new("test",400,100,60)) 
    
end


function love.draw()
    camera:draw(function()
    touch:draw()
    for i,v in ipairs(game.ground) do
        v:draw()
    end
    for i,v in ipairs(game.slimes) do
    	v:draw()
    end
    if #points>2 then love.graphics.line(unpack(points)) end
    end)
end

function camCtrl()
    local x,y = camera:getPosition()
    if   love.keyboard.isDown("left") then
        camera:setPosition(x-10,y)
    end
    if   love.keyboard.isDown("right") then
        camera:setPosition(x+10,y)
    end
    if   love.keyboard.isDown("up") then
        camera:setPosition(x,y-10)
    end
    if   love.keyboard.isDown("down") then
        camera:setPosition(x,y+10)
    end    
end

function love.update(dt) 
    camCtrl()
    touch:update()
    --antiCount=antiCount-dt
    if antiCount<0 then
    	antiCount=2
    	local slime=slime_ball:new("test",100,500,60)
    	table.insert(game.slimes,slime)
    	slime.body.centerBody:applyForce(500000,-1000000)
    end
    
    for i=#game.slimes,1,-1 do
    	if game.slimes[i].dead then
    		table.remove(game.slimes, i)
    	end
    end
    for i,v in ipairs(game.slimes) do
    	if v.body.slideResults then
    		local xA,yA,vertA,xB,yB,vertB=v.body:divise()
	    	v.body:destroy()
	    	local slime=slime_polygon:new("test",xA,yA,vertA)
	    	slime.body.antiCount=1
	    	table.insert(game.slimes,slime)
	    	local slime=slime_polygon:new("test",xB,yB,vertB)
	    	slime.body.antiCount=1
	    	table.insert(game.slimes,slime)
    	end
    	v:update()
    end
    game.world:update(dt)

end 


function insertPoints()

    if  love.keyboard.isDown("a") then
        local x, y = love.mouse.getPosition()
        table.insert(points, x)
        table.insert(points, y)
    end
end




function love.keypressed(key,isrepeat) --Callback function triggered when a key is pressed.
	if key=="1" then
        for i=1,#points,2 do
            points[i+1]=points[i+1]-600
        end
        local x, y = love.mouse.getPosition()
       table.insert(game.ground,ground:new(x,y,points))
       points={0,600,0,500}
    end
    if key=="0" then
        dataCtrl:save()
    end

    if key=="n" then
        table.insert(game.slimes,slime_ball:new("test",400,100,50))
    end
end

function love.mousepressed(x, y, button) 
    insertPoints()
end


function love.keyreleased(key)
    
end

function love.textinput(text)
    
end

function love.mousereleased(x, y, button)
    
end

--[[
function love.quit() --Callback function triggered when the game is closed.
end 
function love.resize(w,h) --Called when the window is resized.
end 
function love.textinput(text) --Called when text has been entered by the user.
end 
function love.threaderror(thread, err ) --Callback function triggered when a Thread encounters an error.
end 
function love.visible() --Callback function triggered when window is shown or hidden.
end 
function love.mousefocus(f)--Callback function triggered when window receives or loses mouse focus.
end
function love.mousepressed(x,y,button) --Callback function triggered when a mouse button is pressed.
end 
function love.mousereleased(x,y,button)--Callback function triggered when a mouse button is released.
end 
function love.errhand(err) --The error handler, used to display error messages.
end 
function love.focus(f) --Callback function triggered when window receives or loses focus.
end 
function love.keypressed(key,isrepeat) --Callback function triggered when a key is pressed.
end
function love.keyreleased(key) --Callback function triggered when a key is released.
end 
function love.run() --The main function, containing the main loop. A sensible default is used when left out.
end
]]