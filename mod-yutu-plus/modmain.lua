local fresh_forever = GetModConfigData("fresh_forever")
local start_with_yaolou = GetModConfigData("start_with_yaolou")
local yaolou_containe_all = GetModConfigData("yaolou_containe_all")

local yutu_damage_range = GetModConfigData("yutu_damage_range")
local yutu_damage = GetModConfigData("yutu_damage")

local yutu_diet_settings = GetModConfigData("yutu_diet_settings")
local yutu_fly_setting = GetModConfigData("yutu_fly_setting")

-- local require = GLOBAL.require
-- local Vector3 = GLOBAL.Vector3
-- local container = require("container")
local containers = require("containers")
local params = containers.params

-- local function _itemtestfn(container, item, slot)
--     return true
-- end

-- function params.myth_bamboo_basket.itemtestfn(container, item, slot)
--     return true
-- end

if yaolou_containe_all == true then
    function params.myth_bamboo_basket.itemtestfn(container, item, slot)
        return true
    end
end
-- 玉兔药篓设置
-- AddPrefabPostInit(
--     "myth_bamboo_basket",
--     function(inst)
--         params.myth_bamboo_basket.itemtestfn = _itemtestfn
--     end
-- )

-- 捣药杵设置
AddPrefabPostInit("medicine_pestle_myth", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst.components.weapon:SetDamage(yutu_damage)
        inst.components.weapon:SetRange(yutu_damage_range)
    end
end)

-- 去除玉兔飞行时过冷
if yutu_fly_setting == true then
    AddPrefabPostInit("flyerfx_yutu_fx", function(inst)
        if GLOBAL.TheWorld.ismastersim then
            inst:RemoveComponent("heater")
            -- inst.components.heater.heat = 0
            -- inst.components.heater:SetThermics(false, true)
        end
    end)
end


if yutu_diet_settings == false then
    AddPrefabPostInit("myth_yutu", function(inst)
        if GLOBAL.TheWorld.ismastersim then
            -- inst.components.eater:SetDiet({FOODGROUP.OMNI}, {FOODGROUP.OMNI})
            inst:RemoveComponent("eater")
            inst:AddComponent("eater")
        end
    end)
end

-- inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
-- if fresh_forever == false then
-- -- TUNING.PERISH_FRIDGE_MULT = .5
-- end

if fresh_forever == true then TUNING.PERISH_FRIDGE_MULT = -100000 end

if start_with_yaolou == true then
    local function playerSpawner(PlayerSpawner, inst)
        inst:ListenForEvent("ms_newplayercharacterspawned", function(a, b)
            if b.player.prefab == "myth_yutu" then
                -- 玉兔玩家自动生成一个药篓
                b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab(
                                                           "myth_bamboo_basket"))
                -- b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("myth_bamboo"))
                -- b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("myth_bamboo"))
                -- b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("myth_bamboo"))
                -- b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("rope"))
                -- b.player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("rope"))
                --    Ingredient("myth_bamboo", 3),
                --    Ingredient("rope", 2)
            end
        end)
    end
    AddComponentPostInit("playerspawner", playerSpawner)
end
