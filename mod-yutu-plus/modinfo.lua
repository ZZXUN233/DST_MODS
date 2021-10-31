name = "神话玉兔补丁"
version = "1.0.4"
description = "version: " .. version .. [[

神话玉兔补丁:
人物：支持设置不挑食，支持飞行时不过冷；
药篓: 支持存放其它物品，支持保鲜设置，支持设置开局自带一个；
捣药杵：支持攻击距离设置，支持攻击伤害设置；
后续需求待添加中。。

为我星桥宝贝做的mod。

]]
author = "zzxun"

forumthread = ""

api_version = 10
priority = -1000000001 -- 一定要在神话mod的后面加载，不然属性会被覆盖

-- This lets the clients know that they need to download the mod before they can join a server that is using it.
all_clients_require_mod = true

-- This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

-- Let the mod system know that this mod is functional with Don't Starve Together
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

-- These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"myth", "神话", "书说", "补丁", "玉兔"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- mod依赖
mod_dependencies = {
    {workshop = "workshop-1699194522"},
    {workshop = "workshop-1991746508"}
}

local opt_Empty = {
	{description = "", data = 0},
}
local function title(title,hover)
	return {
		name = title,
		hover = hover,
		options = opt_Empty,
		default = 0,
	}
end
local enable_opt = {
	{description = "是", data = true},
	{description = "否", data = false},
}

local yutu_damage_range = {
    {description = "原始", data = -0.3},
    {description = "加强", data = 1}
}

local yutu_damage = {
    {description = "51", data = 51},
    {description = "61", data = 61},
    {description = "71", data = 71},
    {description = "81", data = 81},
    {description = "91", data = 91}
}
-- 设置
configuration_options = {
    title("玉兔人物设置："),
    {
        name = "yutu_diet_settings",
        label = "玉兔是否只吃素",
        hover = "设置玉兔的饮食习惯",
        options = enable_opt,
        default = true
    },
    {
        name = "yutu_fly_setting",
        label = "玉兔飞行去除过冷",
        hover = "设置玉兔飞行时去除过冷",
        options = enable_opt,
        default = true
    },

    title("玉兔捣药杵设置："),
    {
        name = "yutu_damage_range",
        label = "捣药杵攻击范围设置",
        hover = "设置捣药杵的攻击范围",
        options = yutu_damage_range,
        default = -0.3
    },
    {
        name = "yutu_damage",
        label = "捣药杵攻击伤害设置",
        hover = "设置玉兔捣药杵的攻击伤害",
        options = yutu_damage,
        default = 51
    },

    title("玉兔药篓设置："),
    {
        name = "yaolou_containe_all",
        label = "是否支持存放其它物品",
        hover = "玉兔药篓是否药支持存放其它物品",
        options = enable_opt,
        default = true
    },
    {
        name = "fresh_forever",
        label = "药篓永久保鲜",
        hover = "设置药篓为永久保鲜，默认关闭下为冰箱保鲜",
        options = enable_opt,
        default = false
    },
    {
        name = "start_with_yaolou",
        label = "开局自带设置",
        hover = "玉兔是否选择开局自带一个药篓",
        options = enable_opt,
        default = true
    }
}
