#!/bin/bash
# -*- ENCODING: UTF-8 -*-
polymer build
firebase deploy
cd build
rm android -rf
cordova create android com.nbormi.tupeso "Tu peso"
cd android && rm www/* -r
cp ../default/* www/ -r
cd www/ 
sed -i "s%<base href=\"/\">%<base href=\"file:///android_asset/www/\">%g" "index.html" 
cd .. 
cordova platforms add android 
cordova plugin add cordova-plugin-statusbar 
cordova plugin add cordova-plugin-splashscreen 
cordova plugin add cordova-plugin-headercolor 
cordova run android
exit