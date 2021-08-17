local sleeptime = 1
local blaze = {
    name = "botania:blaze_block",
    count = 0,
    slot = 0,
}
local eye = {
    name = "minecraft:ender_eye",
    count = 0,
    slot = 0,
}
local casing = {
    name = "powah:dielectric_casing",
    count = 0, 
    slot = 0,
}
local cap = {
    name = "powah:capacitor_basic_tiny",
    count = 0,
    slot = 0,
}

function printCustom(isClear, str)
    if isClear == true then
        term.clear()
        term.setCursorPos(1,1)
    end
    print(str) 
end

function checkSlots()
    local index = 1
    while( index < 17 ) do
        printCustom(true, "Checking Slot: " .. index)
        local data = turtle.getItemDetail(index)
        if data then 
            if data.name == blaze.name then
                blaze.count = data.count
                blaze.slot = index
            elseif data.name == eye.name then
                eye.count = data.count
                eye.slot = index
            elseif data.name == casing.name then
                casing.count = data.count
                casing.slot = index
            elseif data.name == cap.name then
                cap.count = data.count
                cap.slot = index
            end
        end
        index = index + 1
        sleep(0.1)
    end
end

function enderCore()
    printCustom(true, "Crafting EnderCore")
    turtle.select(eye.slot)
    turtle.drop(1)
    turtle.select(casing.slot)
    turtle.drop(1)
    turtle.select(cap.slot)
    turtle.drop(1)
    cap.count = cap.count - 1
    casing.count = casing.count - 1
    eye.count = eye.count - 1
    printCustom(false, "Item Counts!")
    printCustom(false, "Capacitor: " .. cap.count)
    printCustom(false, "DielectricCasing: " .. casing.count)
    printCustom(false, "EnderEye: " .. eye.count)
    printCustom(false, "Sleeping for 4 seconds")
    sleep(4)
end

function blazingCrystal()
    printCustom(true, "Crafting BlazingCrystal")
    turtle.select(blaze.slot)
    turtle.drop(1)
    blaze.count = blaze.count - 1
    printCustom(false, "Item Counts!")
    printCustom(false, "BlazeBlock: " .. blaze.count)
    sleep(29)
end

while true do
    if cap.count > 0 and casing.count > 0 and eye.count > 0 then
        enderCore()
    elseif blaze.count > 0 then
        blazingCrystal()
    end
    if (cap.count == 0 and casing.count == 0 and eye.count == 0) and blaze.count == 0 then 
        checkSlots()
    end
    sleep(sleeptime)
end

