name = "快捷删除"
version = "1.0.0"
description = "version: " .. version .. [[

快捷删除：鼠标指定物品后，按【delete】按键可以快捷删除物品。
隐藏模式：仅将物品从删除者的屏幕上隐藏，可以点击【鼠标右键】还原物品，重进游戏，物品自动恢复。
永久删除模式：删除的物品不能还原。
智能删除模式：支持按住【delete】按键，【鼠标左键】隐藏（支持撤销）；按住【delete】按键，【鼠标右键】永久删除
]]
author = "zzxun"

forumthread = ""

api_version = 10
-- priority = 0 -- 暂时没有优先级要求

-- This lets the clients know that they need to download the mod before they can join a server that is using it.
all_clients_require_mod = true

-- This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

-- Let the mod system know that this mod is functional with Don't Starve Together
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

-- These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"快捷删除工具"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"


local opt_Empty = {{description = "", data = 0}}
local function title(title, hover)
    return {name = title, hover = hover, options = opt_Empty, default = 0}
end
local enable_opt = {
    {description = "是", data = true}, {description = "否", data = false}
}
local del_modes = {
    {description = "隐藏模式", data = 0},
    {description = "永久删除模式", data = 1},
    {description = "智能删除模式", data = 2}
}

-- 设置
configuration_options = {
    title("快捷删除"), {
        name = "del_mode",
        label = "删除模式选择：",
        hover = "永久删除模式下，不可以通过鼠标右键还原！",
        options = del_modes,
        default = 0
    }
    -- , {
    --     name = "del_range",
    --     label = "捣药杵攻击范围设置",
    --     hover = "设置捣药杵的攻击范围",
    --     options = del_range_options,
    --     default = -0.3
    -- }
}
