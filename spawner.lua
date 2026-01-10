local SKY_HEIGHT = 80

local function drop_from_sky(target_pos)
    if not target_pos then return end

    local spawn_pos = {
        x = target_pos.x,
        y = target_pos.y + SKY_HEIGHT,
        z = target_pos.z,
    }

    minetest.add_entity(spawn_pos, "lootbox_drop:lootcrate")
    minetest.chat_send_all("🚀 A lootcrate is dropping from the sky!")
end

-- 🛠 ADMIN COMMAND
minetest.register_chatcommand("drop_lootcrate", {
    description = "Drop a lootcrate from the sky (current pos or x y z)",
    privs = {server = true},

    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local x, y, z = param:match("^(%-?%d+)%s+(%-?%d+)%s+(%-?%d+)$")

        if x and y and z then
            drop_from_sky({
                x = tonumber(x),
                y = tonumber(y),
                z = tonumber(z),
            })
            return true, "Lootcrate dropped at set coordinates!"
        else
            local p = player:get_pos()
            drop_from_sky({
                x = p.x + 2,
                y = p.y,
                z = p.z + 2,
            })
            return true, "Lootcrate dropped beside you!"
        end
    end,
})
