local orb = peripheral.wrap("front")
local bridge = peripheral.wrap("bottom")

local utils = require('utils')
local recipes = require('recipes')

local sleepTime = 5

while true do 
    utils.print(true, "Checking For Empty Orb")
    local emptyOrb = utils.orbIsEmpty(orb)
    if emptyOrb == true then
        utils.print(true, "Checking For Craft")
        local bool, recipe = utils.getCrafting(bridge, recipes)
        if bool == true then
            local boolTwo, invData = utils.checkSlots(recipe.recipe)
            if boolTwo == true then
                utils.print(true, "Crafting")
                local flagEnd, invData = utils.craft(invData)
                while flagEnd == false do
                    utils.print(true, "Checking For Empty Orb")
                    local emptyOrb = utils.orbIsEmpty(orb)
                    if emptyOrb == true then
                        flagEnd, invData = utils.craft(invData)
                    end
                    sleep(sleepTime)
                end
            end
        end
    end
    sleep(sleepTime)
end
