require("card")
math.randomseed( os.time() )

game = {}

game.Load = function()
    game.cards = {}
    game.id1 = nil
    game.id2 = nil
    game.nbreEssais = NB_ESSAIS
    game.counter = 0
    game.score = 0
    game.score = 0
    
    game.mainFont = love.graphics.newFont("fonts/StrangeShadow.ttf", 50)
    game.secondFont = love.graphics.newFont("fonts/Aileron-Regular.otf", 20)

    local c
    for i=1, NB_SPRITES do
        for j=1, 2 do
            c = card.new(i, PATH_SPRITES .. tostring(i) .. ".png")
            game.AddCard(c)
        end
    end

    -- afficher les cases d'une façon aléatoire
    local c = {}
    for i=1, #game.cards do
        c[i] = i
    end
    for i=1, #game.cards do
        local rnd = math.random(1, #c)
        game.cards[i].rnd = c[rnd]
        table.remove(c, rnd)
    end

    local temp = {}
    for i=1, #game.cards do
        temp[i] = game.cards[game.cards[i].rnd]
    end
    for i=1, #game.cards do
        game.cards[i] = temp[i]
    end
end

game.Update = function(dt)
    game.counter = game.counter + dt
    if game.counter > 1 then
        game.CheckDouble()
    end
end

game.Draw = function()
    if game.score < #game.cards then
        local x, y
        for i=1, #game.cards do
            x = ((i-1) % NB_COL) * SIZE_CARD + OFFSET
            y = math.floor((i-1) / NB_COL) * SIZE_CARD + OFFSET
            game.cards[i].Draw(x, y, 0, SCALE, SCALE)
        end
    else
        love.graphics.setFont(game.mainFont)
        love.graphics.printf("Game Over", 0, 230, 600, "center")
        love.graphics.setFont(game.secondFont)
        love.graphics.printf("Appuyer sur 'SPACE' pour recommencer le jeu.", 0, 350, 600, "center")
    end
end

game.MousePressed = function()
    if game.score < #game.cards then
        if game.nbreEssais > 0 then
            local X = math.floor((love.mouse.getX() - OFFSET) / SIZE_CARD) + 1
            local Y = math.floor((love.mouse.getY() - OFFSET) / SIZE_CARD) + 1
            
            game.cards[X + (Y-1) * NB_COL].state = 2

            game.nbreEssais = game.nbreEssais - 1

            if game.nbreEssais == 1 then
                game.id1 = X + (Y-1) * NB_COL
            elseif game.nbreEssais == 0 then
                game.id2 = X + (Y-1) * NB_COL
                game.counter = 0
            end
        end
    end
end

game.KeyPressed = function(key)
    if game.score == #game.cards and key == "space" then
        game.Load()
    end
end

game.CheckDouble = function()
    if game.nbreEssais == 0 then
        if game.cards[game.id1].id == game.cards[game.id2].id then
            game.cards[game.id1].state = nil
            game.cards[game.id2].state = nil
            game.score = game.score + 2
        else
            game.cards[game.id1].state = 1
            game.cards[game.id2].state = 1
        end
            
        game.nbreEssais = NB_ESSAIS
    end
end

game.AddCard = function(card)
    table.insert(game.cards, card)
end

return game