# Custom Boot Video - Differences

* **Engine Loop & Rendering Hooks:** 
Instead of bypassing the modding API or hijacking global LÖVE2D functions, the mod utilizes the engine's official `mod.hooks:wrap` architecture. By hooking into `core.update` and `render.compose`, it safely intercepts the game's execution. During playback, it starves the engine of delta time (`dt`) to freeze background logic, while taking temporary control of the window composite to render the video.

* **Dynamic File Randomization:**
The mod does not hardcode specific filenames. It dynamically scans the mod's `assets/` directory at runtime using `mod:list()`, identifying all valid `.ogv` files and selecting one at random for each boot via `love.math.random()`.

* **Native State Machine Bypass:**
Rather than simulating virtual button presses or fast-forwarding the engine's internal clock, the mod interacts directly with the game's state stack. It monitors the `IntroMovie` state and allows its initial copyright sequence (Phase 1) to play naturally[cite: 2]. The moment Phase 2 begins, the mod freezes the sequence and plays the custom video[cite: 2]. Upon completion, it calls the engine's native `exitToTitle()` function to instantly and cleanly bypass the remaining Game Freak and Nidorino animations[cite: 2].

* **Non-Destructive Restoration & Memory Cleanup:**
The mod leaves no permanent footprint on the engine's execution. Once the custom video completes and the Title Screen is built, it immediately calls `release()` to purge the video file from system RAM. The hooks then seamlessly pass control back to the vanilla engine by continuously returning `next()`, allowing normal gameplay to resume with zero overhead.