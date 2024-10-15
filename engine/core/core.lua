Object = {}

function Object:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    for k, v in pairs(self) do
        if o[k] == nil and type(v) == "table" then
            o[k] = {}
            for k2, v2 in pairs(v) do
                o[k][k2] = v2
            end
        end
    end

    return o
end

Entity = Object:new({
    name = "Invalid Entity",
    power = 0,
})
