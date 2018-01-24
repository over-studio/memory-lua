card = {}

card.new = function (id, img)
    local this = self or {}

    this.id = id
    this.rnd = 0
    this.state = 1
    this.img = love.graphics.newImage(img)

    this.Draw = function(x, y, r, sx, sy)
        if this.state == 1 then
            love.graphics.rectangle("fill", x, y, 100, 100)
        elseif this.state == 2 then
            love.graphics.draw(this.img, x, y, r, sx, sy)
        end
        --love.graphics.print(this.rnd, x+80, y-15)
    end

    return this
end