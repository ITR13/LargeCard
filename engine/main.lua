require("core.prototypes")
require("enemies.basicenemies")

local game = Game:new({})
game:playCard(Joe)
game:endTurn()
print(game.score)