#!/bin/bash
echo "Welcome to Tejas's OTA Generator!"
read -p "Enter your IPA link : " ipalink
read -p "Enter your bundle identifier : " bundleid
read -p "Enter your app version: " appversion
read -p "Enter your display name: " displayname
read -p "Enter plist name : " plistname
cp ota.plist $plistname
echo Writing plist....
/usr/libexec/PlistBuddy -c "Set :items:0:assets:0:url $ipalink" "$plistname"
/usr/libexec/PlistBuddy -c "Set :items:0:metadata:bundle-identifier $bundleid" "$plistname"
/usr/libexec/PlistBuddy -c "Set :items:0:metadata:bundle-version $appversion" "$plistname"
/usr/libexec/PlistBuddy -c "Set :items:0:metadata:title $displayname" "$plistname"
echo Written plist to $plistname
