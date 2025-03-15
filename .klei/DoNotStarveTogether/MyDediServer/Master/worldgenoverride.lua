KLEI     1 return {
	override_enabled = true,
	worldgen_preset = "RELAXED",
	settings_preset = "RELAXED",
	overrides = {
	    autumn = "longseason",  -- 秋天變長
	    winter = "shortseason", -- 冬天變短
	    spring = "shortseason", -- 春天變短
	    summer = "shortseason", -- 夏天變短
	    world_size = "medium",   -- 可以使用 "small", "large" 或 "huge"
	    land_branching = "least",  -- 減少分支，使地形更環狀
	    loop = "always",  -- 強制讓陸地形成環狀
	    no_wormholes_to_disconnected_tiles = true,  -- 確保所有地區相連
	    layout_mode = "RestrictNodesByKey",  -- 讓世界地形排列更緊密
	},
}
