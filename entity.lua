minetest.register_entity("lootbox_drop:lootcrate", {
    initial_properties = {
        physical = true,
        collide_with_objects = false,
        collisionbox = {-0.45, 0, -0.45, 0.45, 0.9, 0.45},
        visual = "mesh",
        mesh = "Crate1.bbmodel",
        textures = {"crate.png"},
        static_save = true,
    },

    landed = false,

    on_activate = function(self)
        self.object:set_velocity({x = 0, y = -6, z = 0})
    end,

    on_step = function(self)
        if self.landed then return end

        local pos = self.object:get_pos()
        if not pos then return end

        local under = {x = pos.x, y = pos.y - 0.6, z = pos.z}
        local node = minetest.get_node_or_nil(under)

        if node and node.name ~= "air" then
            self.landed = true
            self.object:set_velocity({x = 0, y = 0, z = 0})
            self.object:set_pos({
                x = pos.x,
                y = math.floor(pos.y) + 0.05,
                z = pos.z
            })

            minetest.chat_send_all("A lootcrate has landed!")
        end
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end

        local inv = clicker:get_inventory()
        if inv then
            inv:add_item("main", "default:diamond 3")
            inv:add_item("main", "default:gold_ingot 5")
        end

        minetest.chat_send_player(
            clicker:get_player_name(),
            "You opened the lootcrate!"
        )

        self.object:remove()
    end,
})
