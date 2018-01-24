require("constants")

local myGame = require("game")

function love.load()
    myGame.Load()
end

function love.update(dt)
    myGame.Update(dt)
end

function love.draw()
    myGame.Draw()
end

function love.mousepressed()
    myGame.MousePressed()
end

function love.keypressed(key)
    myGame.KeyPressed(key)
end