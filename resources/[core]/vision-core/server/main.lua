-- [[ CHICAGO DRILL MECHANICS ]]
local isGangsta = false

-- GANGSTA MODE: Nembak Satu Tangan & Slide
RegisterCommand('gangsta', function()
    isGangsta = not isGangsta
    local ped = PlayerPedId()
    
    if isGangsta then
        RequestAnimSet("move_m@gangster@var_i")
        while not HasAnimSetLoaded("move_m@gangster@var_i") do Wait(0) end
        SetPedMovementClipset(ped, "move_m@gangster@var_i", 1.0)
        SetWeaponAnimationOverride(ped, `Gang1H`) -- Nembak miring satu tangan
        print("Chicago Mode: ON 😈")
    else
        ResetPedMovementClipset(ped, 0.0)
        ResetWeaponAnimationOverride(ped)
    end
end)

-- DRIVE-BY SYNC
SetPlayerCanDoDriveBy(PlayerId(), true)
