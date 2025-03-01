fx_version 'cerulean'
game 'gta5'
lua54 'yes'
-- 资源元数据
author 'YourName'
description 'Advanced Air Suspension System for FiveM'
version '1.2.0'

-- 客户端脚本
client_scripts {
    'client.lua',          -- 主逻辑脚本
    'suspension_visual.lua' -- 悬挂视觉效果处理（可选分离）
}

-- 服务端脚本（若需要存储数据可添加）
-- server_scripts {
--     'server.lua'
-- }

-- 共享配置（若需外部配置文件）
-- shared_scripts {
--     'config.lua'
-- }

-- 资源依赖声明（若需要其他资源支持）
-- dependencies {
--     'es_extended',       -- 示例：ESX框架依赖
--     'ox_lib'             -- 示例：OX库
-- }

-- 文件引用（确保资源包含所需文件）
files {
    -- 'data/*.meta',       -- 若有自定义handling数据
    -- 'ui/*.html'          -- 若有界面文件
}

-- 状态包支持（用于实体状态同步）
lua54 'yes'                -- 启用Lua 5.4语法（兼容性更好）
use_experimental_fxv2_oal 'yes' -- 启用新版资源加载器