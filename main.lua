local orb = peripheral.wrap("front")
local bridge = peripheral.wrap("bottom")

local utils = require('utils')
local recipes = require('recipes')

local sleepTime = 1

while true do 
    local bool, recipe = utils.getCrafting(bridge, recipes)
    if bool == true then
        local endOfLoop = 1
        while endOfLoop == 1 do
            local boolTwo, invData = utils.checkSlots(recipe)
            if boolTwo == true then
                while endOfLoop == 1 do
                    local emptyOrb = utils.orbIsEmpty(orb)
                    if emptyOrb == true then
                        local flagEnd, invData = utils.craft(invData)
                        if flagEnd == true then
                            endOfLoop = 42
                        end
                    end
                    sleep(sleepTime)
                end
            end
            sleep(sleepTime)
        end
    end
    sleep(sleepTime)
end
