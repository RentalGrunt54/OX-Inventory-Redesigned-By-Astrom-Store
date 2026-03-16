if not lib then return end

local lastTargetPed = nil
local lastTargetAlpha = 255

local function clearHighlight()
    if lastTargetPed and DoesEntityExist(lastTargetPed) then
        SetEntityAlpha(lastTargetPed, 255, false)
        SetEntityDrawOutline(lastTargetPed, false)
    end
    lastTargetPed = nil
end

local function rotationToDirection(rotation)
	local z = math.rad(rotation.z)
	local x = math.rad(rotation.x)
	local num = math.abs(math.cos(x))
	return vec3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

local function screenToWorld(cursorX, cursorY)
    local camRot = GetFinalRenderedCamRot(2)
    local camPos = GetFinalRenderedCamCoord()
    local fov = GetFinalRenderedCamFov()
    local aspectRatio = GetAspectRatio(false)

    local verticalX = camRot.x
    local verticalY = 0.0
    local verticalZ = camRot.z

    local horizontalX = 0.0
    local horizontalY = 0.0
    local horizontalZ = camRot.z + 90.0

    local forward = rotationToDirection(camRot)
    local up = rotationToDirection(vec3(verticalX + 90.0, verticalY, verticalZ))
    local right = rotationToDirection(vec3(horizontalX, horizontalY, horizontalZ))

    local tanFov = math.tan(math.rad(fov) * 0.5)

    local worldPos = camPos + (forward * 1.0) + (right * (cursorX - 0.5) * aspectRatio * tanFov * 2.0) + (up * (0.5 - cursorY) * tanFov * 2.0)
    local direction = worldPos - camPos

    return camPos, direction
end

local function getTargetAtCursor(cursorX, cursorY)
    local camPos, direction = screenToWorld(cursorX, cursorY)
    local destination = camPos + direction * 50.0
    local rayHandle = StartShapeTestCapsule(camPos.x, camPos.y, camPos.z, destination.x, destination.y, destination.z, 0.2, 12, cache.ped, 4)
    
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    if hit and entityHit ~= 0 and GetEntityType(entityHit) == 1 then -- type 1 is ped
        if IsPedAPlayer(entityHit) and entityHit ~= cache.ped then
            return entityHit
        end
    end
    return nil
end

RegisterNUICallback('updateDragTarget', function(data, cb)
    if not data or not data.x or not data.y then
        clearHighlight()
        return cb(1)
    end

    local targetPed = getTargetAtCursor(data.x, data.y)

    if targetPed ~= lastTargetPed then
        clearHighlight()
        if targetPed then
            lastTargetPed = targetPed
            SetEntityAlpha(targetPed, 180, false)
            SetEntityDrawOutline(targetPed, true)
            SetEntityDrawOutlineColor(255, 255, 255, 200)
        end
    end

    cb(1)
end)

RegisterNUICallback('giveToTargetAtCursor', function(data, cb)
    local targetPed = getTargetAtCursor(data.x, data.y)
    clearHighlight()
    
    if targetPed then
        local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))
        if targetId and targetId > 0 then
            TriggerServerEvent('ox_inventory:giveItem', data.slot, targetId, data.count or 1)
            lib.requestAnimDict('mp_common')
            TaskPlayAnim(cache.ped, 'mp_common', 'givetake1_a', 1.0, 1.0, 2000, 50, 0.0, 0, 0, 0)
            RemoveAnimDict('mp_common')
        end
    end
    cb(1)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        clearHighlight()
    end
end)
