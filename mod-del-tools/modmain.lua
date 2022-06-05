-- 1. 初始化删除
-- 永久删除配置
local del_mode = GetModConfigData("del_mode")
-- 删除撤销缓存
local delStack = {}
-- delete按键按住标志
local deleteKeyDown = false

-- 判断是否属于装填物品
local function InInv(b)
    local inv = b.components.inventoryitem
    return inv and inv.owner and true or false
end

-- 判断是否可删除
local function CanDelete(inst)
    if inst and inst ~= TheWorld and not InInv(inst) and inst.Transform then
        -- 没有userid的玩家也可以被删除
        if inst:HasTag("player") then
            if inst.userid == nil or inst.userid == "" then
                return true
            end
        else
            return true
        end
    end
    return false
end

-- 按模式删除
local function delInMode(obj, isRight)
    -- 不能删除
    if not CanDelete(obj) then return end
    -- 默认删除模式
    if del_mode == 0 then
        table.insert(delStack, obj)
        obj:RemoveFromScene()
        -- 永久删除模式
    elseif del_mode == 1 then
        obj:Remove()
        -- 智能删除模式
    else
        -- 右键永久删除
        if isRight then
            obj:Remove()
        else
            table.insert(delStack, obj)
            obj:RemoveFromScene()
        end
    end

end

-- 范围删除
local function delRange(x, y, forverFlag)
    local ents = GLOBAL.TheSim:FindEntities(x, y, 30, 3)
    for _, obj in pairs(ents) do
        if CanDelete(obj) then
            if obj.components then
                if obj.components.burnable then
                    obj.components.burnable:Extinguish(true)
                end
                if obj.components.firefx then
                    if obj.components.firefx.extinguishsoundtest then
                        obj.components.firefx.extinguishsoundtest = function()
                            return true
                        end
                    end
                    obj.components.firefx:Extinguish()
                end
            end
            -- 判断物品非以下属性，则进行删除
            if (not (obj.prefab == "minerhatlight" or "lanternlight" or
                "yellowamuletlight" or "slurperlight" or "redlanternlight" or
                "lighterfire" or "torchfire" or "torchfire_rag" or
                "torchfire_spooky" or "torchfire_shadow")) or
                (obj.entity:GetParent() == nil) then
                delInMode(obj, forverFlag)
            end
        end
    end
end

-- 2. 读取配置
-- 3. 捕获删除按钮事件
print(
    "+++++++++++++++++++++++++++++++快捷删除加载+++++++++++++++++++++++++++++++++")
GLOBAL.TheInput:AddKeyHandler(function(key, down) -- 监听键盘事件
    print("点击事件：key = ", key)
    deleteKeyDown = down
    if key == GLOBAL.KEY_DELETE then -- [
        -- todo: 触发删除
        local obj = GLOBAL.TheInput:GetWorldEntityUnderMouse()
        delInMode(obj, false)
    end
end)

-- MOUSEBUTTON_LEFT = 1000
-- MOUSEBUTTON_RIGHT = 1001
-- 鼠标点击事件
GLOBAL.TheInput:AddMouseButtonHandler(function(button, down, x, y)
    print("鼠标事件：", button, "down=", down, "x,y = ", x, y)
    -- 鼠标左键
    if button == GLOBAL.MOUSEBUTTON_LEFT and down then
        if deleteKeyDown then
            delRange(x, y, false)
        end
    -- 鼠标右键
    elseif button == GLOBAL.MOUSEBUTTON_RIGHT and down then
        if deleteKeyDown then
            print("永久删除！")
            delRange(x, y, true)
        else
            print("撤销删除！")
            local reObj = table.remove(delStack)
            if reObj ~= nil then reObj:ReturnToScene() end
        end
    end
end)
-- 3.1 获取鼠标点击的物品
print(
    "++++++++++++++++++++++++++++++快捷删除加载完成++++++++++++++++++++++++++++++++")

