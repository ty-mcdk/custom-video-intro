return function(mod)
    local boot_video = nil
    local video_finished = false
    local video_started = false
    local show_video = false
    local assets_dir = "assets"

    -- Scan the assets directory for .ogv files
    local items = mod:list(assets_dir)
    local ogv_files = {}

    if items then
        for _, filename in ipairs(items) do
            if filename:sub(-4):lower() == ".ogv" then
                local filepath = assets_dir .. "/" .. filename
                local info = mod:info(filepath)
                
                if info and info.type == "file" then
                    table.insert(ogv_files, filepath)
                end
            end
        end
    end

    -- Exit smoothly if no video is found
    if #ogv_files == 0 then
        print("[CustomBoot] No .ogv files found in '" .. assets_dir .. "'. Skipping custom boot.")
        return
    end

    -- Pick a random video
    local chosen_index = love.math.random(1, #ogv_files)
    local video_file = ogv_files[chosen_index]
    
    local resolved_path = mod.assets:path(video_file)
    local success, result = pcall(love.graphics.newVideo, resolved_path)
    
    if success then
        boot_video = result
        print("[CustomBoot] Randomly selected startup video: " .. resolved_path)
        
        -- Hook the engine's update loop
        mod.hooks:wrap("core.update", function(next, game, dt)
            local top = game.stack and game.stack:top()
            
            -- Check if we are currently running the IntroMovie
            if top and top.exitToTitle and top.phase then
                
                -- Wait for the copyright screen to run
                if top.phase == 1 then
                    return next(game, dt)
                end
                
                -- After copyright screen done
                if not video_finished then
                    show_video = true
                    
                    if not video_started and boot_video then
                        boot_video:play()
                        video_started = true
                    end
                    
                    if boot_video and boot_video:isPlaying() then
                        local skip_requested = false
                        
                        if love.keyboard.isDown("return") or love.keyboard.isDown("escape") or love.keyboard.isDown("space") then
                            skip_requested = true
                        end
                        
                        local joysticks = love.joystick.getJoysticks()
                        for _, joystick in ipairs(joysticks) do
                            if joystick:isGamepadDown("a") or joystick:isGamepadDown("start") then
                                skip_requested = true
                            end
                        end

                        if skip_requested then
                            boot_video:pause()
                            video_finished = true
                        end
                    elseif video_started then
                        video_finished = true
                    end
                    
                    if video_finished then
                        -- The moment the video ends, trigger the engine's native skip function
                        show_video = false
                        top:exitToTitle()
                    else
                        -- Return without calling next() to freeze the engine while the video plays
                        return
                    end
                end
            end
            
            -- Normal gameplay tick resumes
            return next(game, dt)
        end)
        
        -- 2. Hook the whole-window composite
        mod.hooks:wrap("render.compose", function(next, renderer, ctx)
            -- Draw the custom video over the frozen engine
            if show_video and boot_video and boot_video:isPlaying() then
                local r, g, b, a = love.graphics.getColor()
                
                love.graphics.clear(0, 0, 0, 1)
                love.graphics.setColor(1, 1, 1, 1)
                
                local vid_w, vid_h = boot_video:getDimensions()
                local scale = math.min(ctx.ww / vid_w, ctx.wh / vid_h)
                local offset_x = (ctx.ww - (vid_w * scale)) / 2
                local offset_y = (ctx.wh - (vid_h * scale)) / 2
                
                love.graphics.draw(boot_video, offset_x, offset_y, 0, scale, scale)
                love.graphics.setColor(r, g, b, a)
                
                return true
            end
            
            -- Clean up memory and reveal the game
            if video_finished and boot_video then 
                boot_video:release() 
                boot_video = nil
            end
            
            return next(renderer, ctx)
        end)

    else
        print("[CustomBoot] ERROR loading video: " .. tostring(result))
    end
end