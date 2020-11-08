
# 时间
print_date(){
	date '+%Y/%m/%d %H:%M'
}

# 是否充电
get_battery_status() {

	if $(cat /sys/class/power_supply/BAT0/status | grep --quiet Discharging)
	then
		echo -e '\uf578';
	else
		echo -e '\uf583';
	fi
}

# 电量
get_battery_num(){
	cat /sys/class/power_supply/BAT0/capacity
}

# 电量打印
get_bat(){
	echo "$(get_battery_status):$(get_battery_num)"
}

# 内存使用量
get_mem_available_num(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memfree"
}

# 内存总量
get_mem_total_num(){
	memtotal=$(($(grep -m1 'MemTotal:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memtotal"
}

# 内存打印
print_mem(){
	echo -e "\uf6a6:$(get_mem_available_num)/$(get_mem_total_num)M"
}

# 声音打印
print_vol () {
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$VOL" -eq 0 ]; then
            printf "$(echo -e '\uf026'):%s"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 50 ]; then
		printf "$(echo -e '\uf027'):%s" "$VOL"
        else
	    printf "$(echo -e '\uf028'):%s" "$VOL"
        fi
    else
        if [ "$VOL" -eq 0 ]; then
            printf "MUTE"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "\uf026:%s" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "\uf027:%s" "$VOL"
        else
            printf "\uf028:%s" "$VOL"
        fi
    fi
    printf "%s\n" "$SEP2"
}

# 亮度打印
print_backlight() {
	backlight="$(xbacklight -get)"
	echo -e "\ue30d ${backlight}"
}



xsetroot -name " $(print_mem) $(print_vol) $(print_backlight) $(get_bat) $(print_date) "
