require("core.core")

Attribute = Entity:new({
    name = "Invalid Attribute",
})

Attack = Entity:new({
    name = "Invalid Attack",
})

Card = Entity:new({
    name = "Invalid Card",
    attributes = {},
    attacks = {},
})

Game = Object:new({
    name=nil,
    activeAttributes = {},
    entities = {},
    enemy = Card:new({name="Invalid Enemy"}),
    score = 0,
})


function Game:_addAttribute(attribute, target)
    local attributeList = self.activeAttributes[attribute]
    if attributeList == nil then
        attributeList = {}
        self.activeAttributes[attribute] = attributeList
    end
    if #attributeList == 0 then
        attribute.onFirstAdded(self)
    end
    attributeList[#attributeList+1] = target
end

function Game:_subAttribute(attribute, target)
    local attributeList = self.activeAttributes[attribute]
    for i = #attributeList, 1, -1 do
        if attributeList[i] == target then
            table.remove(attributeList, i)
            break
        end
    end

    if #attributeList == 0 then
        attribute.onLastSubbed(self)
    end
end

function Game:_attack(attack, source, target)
    local power = source.power + attack.power
    power = power - target.power
    self.score = self.score + power
end

function Game:endTurn()
    if self.enemy == nil then
        return
    end
    for _, entity in ipairs(self.entities) do
        for _, attack in ipairs(entity.attacks) do
            self:_attack(attack, entity, self.enemy)
        end
    end
end

function Game:playCard(card)
    self.entities[#self.entities+1] = card
    for _, attribute in ipairs(card.attributes) do
        self:_addAttribute(attribute, card)
    end
end