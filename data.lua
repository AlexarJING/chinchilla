local data={}

local file= love.filesystem.newFile("data.dat")

function data:save()
	file:open("w")
	local data=bintable.packtable(table.copy(game.data))
	file:write(data)
	file:close()
	return data
end


function data:load()
	file:open("r")
	local data=file:read()
	file:close()
	if data==nil then self:new();return end
	local tab=bintable.unpackdata(data)
	table.copy(tab,game.data)
end

function data:new()
	game.data={
		player={},
		stage={
			{}
		}
	}


end

return data