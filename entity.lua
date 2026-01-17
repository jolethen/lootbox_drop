mobs:register_mob("modname:crate", {
    type = "npc",
    passive = true,
    attack_type = "dogfight",
    reach = 0,
    damage = 0,

    hp_min = 400,
    hp_max = 500,
    armor = 100,

    collisionbox = {-0.35, 0, -0.35, 0.35, 1.8, 0.35},
    visual = "mesh",
    mesh = "crate.glb",
    textures = {"crate.png"},
    visual_size = {x = 2, y = 2},

    walk_velocity = 0,
    run_velocity = 0,
    view_range = 0,

    -- ⚠ mobs_redo CANNOT handle 60 speed properly
    -- Use 30 even if animation was authored at 60 FPS
    animation = {
        speed_normal = 0,
        speed_run = 0,

        -- 60 FPS, 1 second each
        stand_start = 0,
        stand_end   = 0,

        walk_start  = 0,
        walk_end    = 0,

        run_start   = 0,
        run_end     = 0,

        punch_start = 0,
        punch_end   = 0,
    },

    makes_footstep_sound = false,

    water_damage = 0,
    lava_damage = 0,
    light_damage = 0,

    fear_height = 0,
       do_custom = function(self, dtime)
        -- timer so we don't spawn particles every single tick
        self.smoke_timer = (self.smoke_timer or 0) + dtime
        if self.smoke_timer < 0.15 then return end
        self.smoke_timer = 0

        local pos = self.object:get_pos()
        if not pos then return end

        minetest.add_particle({
            pos = {x = pos.x, y = pos.y + 1.6, z = pos.z},
            velocity = {x = math.random(-5,5)/50, y = 1.5, z = math.random(-5,5)/50},
            acceleration = {x = 0, y = 0.2, z = 0},
            expirationtime = math.random(40,55) / 10,
            size = math.random(6,10),
            texture = "smoke.png",
            glow = 0,
        })
    end,

})
