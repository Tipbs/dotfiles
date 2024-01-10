#!/bin/bash

# start waybar if not started
if ! pgrep -x "waybar" > /dev/null; then
	waybar &
fi

# current checksums
config=~/.config/waybar/config.jsonc
style=~/.config/waybar/style.css
current_checksum_config=$(md5sum $config)
current_checksum_style=$(md5sum $style)

# loop forever
while true; do
	# new checksums
	new_checksum_config=$(md5sum $config)
	new_checksum_style=$(md5sum $style)

	# if checksums are different
	if [ "$current_checksum_config" != "$new_checksum_config" ] || [ "$current_checksum_style" != "$new_checksum_style" ]; then
		# kill waybar
		killall waybar

		# start waybar
		waybar &

		# update checksums
		current_checksum_config=$new_checksum_config
		current_checksum_style=$new_checksum_style
	fi
  sleep 3
done

