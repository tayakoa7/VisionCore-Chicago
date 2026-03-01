fx_version 'cerulean'
game 'gta5'
lua54 'yes' -- Standar 2026 untuk performa 1.9k player

author 'VisionCore Team & [Nama Lo]'
description 'Next-Gen Chicago Framework for High-Population Servers'

shared_scripts { 'config.lua' }
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Wajib install oxmysql
    'server/main.lua'
}
client_scripts { 'client/main.lua' }

