# Custom Video Intro

A mod for Gen1Recomp which lets users replace the intro video at the start of the game. Please note that the copyright screen right at the start is unskippable and will rain all kinds of hell if I try to mess with that

Drop any .ogv video files into `/assets` you want to replace as the intro. You can place multiple videos, in which case the mod will cycle between a different video each time at random. It's possible for the same video to play multiple times in a row, such is the nature of randomness. This is not a bug unless it happens a statistically improbable number of times

IMPORTANT NOTE! - Supports .ogv format video only! Due to limitations with the Love 2D engine this is beyond the control of mod makers, Recomp developers and my tiny brain, only .ogv video works. If you want to use .mp4, .webm etc you need to convert them to .ogv first. To assist this I've included some conversion scripts for Linux, Mac and Windows users. Instructions follow further down

There are also many online video converters to .ogv which will do the job well enough. Remember to check settings and make the quality as high as you can. The Recomp can take it, and the video is flushed from memory after it plays

You can skip the intro video just like the usual one by pressing Start/Enter/A button



## Converting video files on Linux/Steam Deck/Mac OS
You must have FFmpeg installed, many Linux distros do by default. Mac users may need to install this

On Steam Deck you'll need to do this in Desktop Mode

Locate `convert.sh`, you need to allow this to be executed as a program (feel free to inspect the script it just runs an ffmpeg command to do the conversion). Either open permissions on the file and tick "Allow executing file as program", or in terminal and in the same directory as `convert.sh` run: `chmod +x ./convert.sh` (without quotes)

Open a terminal window and drag `convert.sh` into it. Then drag each video you wish to convert to .ogv format. Then hit enter. It can bulk convert multiple videos at a time. Videos will appear in the same directory your terminal is in (you may want to `cd` to a preferred location before doing the conversions)

Alternatively you can open a terminal in the mod directory and use `./convert.sh {video_name_1}.{extension} {video_name_2}.{extension}` etc

When you have the converted .ogv video files move them into `/assets` in the mod folder


## Converting video files on Windows
(I haven't tested this on Windows, please report any bugs)

You must have FFmpeg installed, or have the FFmpeg .exe in the same directory as `convert.bat`

Select one or many videos for conversion and drag them onto `convert.bat`. The converted .ogv video files will appear in the same directory as `converted.bat`, you can then move them into `/assets`



## Converting videos on other devices and OSes
For other devices you'll either need to do the conversion on a Linux/Mac/Windows machine, or find an online converter tool



## Android Issues
On Android, due to further limitations with the Love 2D engine you won't be able to drag and drop videos into the `/assets` folder. Instead use the following steps:

1. Download the latest release of this mod from https://github.com/ty-mcdk/custom-video-intro/releases
2. Unzip the mod (you may need a 3rd party app if one isn't already installed on your device)
3. Place .ogv format videos inside `(unzipped mod folder)/assets`
4. Compress/zip the mod folder once again with the added video files inside
5. Open the game launcher
6. Select the option to import the mod zip

Unfortunately our hands are tied and there is literally no other way of doing this if you have a restricted Android device (typically phones)



# Limitations
Only supports .ogv format video



# Future plans

Gen2 support (next update)




## Installation

1. Download the latest .zip release.
2. Drag mod into the launcher with the mods tab open. Alternatively place extract the mod from the .zip file and place it into your mods/ directory.
3. Launch the game. The engine will automatically mount the mod. Custom boot videos automatically play when the mod is enabled