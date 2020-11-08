#!/bin/bash

# 状态栏
~/.dwm/dwm-status.sh &
# 窗口渲染器
picom -b &
# 壁纸
~/.dwm/wp-autochange.sh &
# 换键
~/.dwm/setxmodmap-us.sh &

