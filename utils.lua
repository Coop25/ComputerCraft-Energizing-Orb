local utils = {}

function utils.print(isClear, str)
    if isClear == true then
        term.clear()
        term.setCursorPos(1,1)
    end
    print(str) 
end

function recipieContains(arr, val)
    for i=1,#arr do
       if arr[i].name == val then 
          return true, i
       end
    end
    return false
end

function invDataContains(arr, name)
    if table.getn(arr) == 0 then
        return false, 0
    end
    for i=1,#arr do
       if arr[i].name == name then 
          return true, i
       end
    end
    return false, 0
end

function utils.checkSlots(recipe)
    local index = 1
    local invData = {}
    while( index < 17 ) do
        utils.print(true, "Checking Slot: " .. index)
        local data = turtle.getItemDetail(index)
        if data then 
            local bool, i = recipieContains(recipe, data.name)
            if bool == true then
                local bool, y = invDataContains(invData, data.name)
                if bool == false then
                    table.insert(invData, {
                        name = data.name,
                        count = data.count,
                        amount = recipe[i].amount,
                        slots = { index },
                    })
                else
                    invData[y].count = invData[y].count + data.count
                    table.insert(invData[y].slots, index)
                end
            end
        end
        index = index + 1
        sleep(0.1)
    end
    if table.getn(invData) == table.getn(recipe) then
        return true, invData
    else
        return false, {}
    end
end


function utils.getCrafting(bridge, recipes)
    for i = 1, #recipes do
        if bridge.isItemCrafting(recipes[i].autoCraft) then
            return true, recipes[i]
        end
    end
    return false, {}
end

function utils.craft(data)
    local flagEnd = false
    local counts = ""
    for i = 1, #data do
        local slotCount = turtle.getItemCount(data[i].slots[1])
        if slotCount <= data[i].amount then
            turtle.select(data[i].slots[1])
            turtle.drop(slotCount)
            table.remove(data[i].slots, 1)
            local remaining = data[i].amount - slotCount
            if remaining > 0 then
                turtle.select(data[i].slots[1])
                turtle.drop(remaining)
            end
            data[i].count = data[i].count - data[i].amount
        else
            turtle.select(data[i].slots[1])
            turtle.drop(data[i].amount)
            data[i].count = data[i].count - data[i].amount
        end
        counts = counts .. "\n" .. data[i].name .. ": " .. data[i].count
        if data[i].count == 0 then
            flagEnd = true
        end
        utils.print(true, "Inserting: " .. counts)
    end
    return flagEnd, data
end

function utils.orbIsEmpty(orb)
    local orbInv = orb.list()
    local i = 1
    while(i < 8) do
        if orbInv[i] ~= nil then
            return false
        end
        i = i + 1
    end
    return true
end

return utils