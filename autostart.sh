#!/bin/bash
# 自启动脚本 仅作参考

set +e

# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# notify
# swaync -c ~/.config/mango/swaync/config.jsonc -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &
swaync >/dev/null 2>&1 &

# night light
wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

# wallpaper
swaybg -i ~/.config/mango/wallpaper/wallpaper.jpg >/dev/null 2>&1 &

# top bar
# waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

# Top Bar (Loads from ~/.config/waybar/config.jsonc automatically)
waybar >/dev/null 2>&1 &

# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
# wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# bluetooth 
blueman-applet >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &

# Permission authentication
/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

# inhibit by audio
sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
swayosd-server >/dev/null 2>&1 &


# --- 5. Clipboard Manager ---
# (Note: We REMOVED 'wl-clip-persist' to save battery)
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
wl-paste --type image --watch cliphist store >/dev/null 2>&1 &

# # --- 6. Power Management (CRITICAL FOR LEGION) ---
# # Prevents sleep while audio is playing (Spotify/YouTube)
# sway-audio-idle-inhibit >/dev/null 2>&1 &

# Idle Daemon: Lock screen after 5 mins, screen off after 10
# (Requires 'swayidle' and 'swaylock' to be installed)
swayidle -w \
    timeout 300 'swaylock -f' \
    timeout 600 'wdisplays --output eDP-1 --off' \
    resume 'wdisplays --output eDP-1 --on' \
    before-sleep 'swaylock -f' >/dev/null 2>&1 &