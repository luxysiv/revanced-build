#!/bin/bash
# Revanced build
source tools.sh
release=$(curl -s "https://api.github.com/repos/revanced/revanced-patches/releases/latest")
asset=$(echo "$release" | jq -r '.assets[] | select(.name | test("revanced-patches.*\\.jar$")) | .browser_download_url')
curl -sL -O "$asset"
ls revanced-patches*.jar >> new.txt
rm -f revanced-patches*.jar
release=$(curl -s "https://api.github.com/repos/luxysiv/yt/releases/latest")
asset=$(echo "$release" | jq -r '.assets[] | select(.name == "revanced-version.txt") | .browser_download_url')
curl -sL -O "$asset"
if diff -q revanced-version.txt new.txt >/dev/null ; then
echo "Old patch!!! Not build"
exit 1
else
rm -f *.txt
dl_gh "revanced" 
# Messenger
get_patches_key "messenger"
get_apk_arch "messenger" "messenger" "facebook-2/messenger/messenger"
patch "messenger" "messenger-revanced"
# Patch Twitch 
get_patches_key "twitch"
get_ver "block-video-ads" "tv.twitch.android.app"
get_apk "twitch" "twitch" "twitch-interactive-inc/twitch/twitch"
patch "twitch" "twitch-revanced"
# Patch Tiktok 
get_patches_key "tiktok"
get_ver "sim-spoof" "com.ss.android.ugc.trill"
get_apk "tiktok" "tik-tok-including-musical-ly" "tiktok-pte-ltd/tik-tok-including-musical-ly/tik-tok-including-musical-ly"
patch "tiktok" "tiktok-revanced"
# Patch YouTube 
get_patches_key "youtube-revanced"
get_ver "video-ads" "com.google.android.youtube"
get_apk "youtube" "youtube" "google-inc/youtube/youtube"
patch "youtube" "youtube-revanced"
# Patch YouTube Music 
get_patches_key "youtube-music-revanced"
get_ver "hide-get-premium" "com.google.android.apps.youtube.music"
get_apk_arch "youtube-music" "youtube-music" "google-inc/youtube-music/youtube-music"
patch "youtube-music" "youtube-music-revanced"
ls revanced-patches*.jar >> revanced-version.txt
fi
