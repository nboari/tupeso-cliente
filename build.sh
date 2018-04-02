#!/bin/bash
# -*- ENCODING: UTF-8 -*-
polymer build
cd build
cordova create cordova com.nbormi.tupeso "Tu peso"
cd cordova && rm www/* -r
cp ../polymer/* www/ -r
cd www/ 
sed -i "s%<base href=\"/\">%<base href=\"file:///android_asset/www/\">%g" "index.html" 
cd .. 
cordova platforms add android
cordova plugin add cordova-plugin-statusbar 
cordova plugin add cordova-plugin-splashscreen 
cordova plugin add cordova-plugin-headercolor 
# sed -i "s%name=\"android\">%name=\"android\"><edit-config file=\"AndroidManifest.xml\" mode=\"merge\" target=\"/manifest/application\"><application android:theme=\"@android:style/Theme.Black.NoTitleBar\" /></edit-config>%g" "config.xml" 
cordova run android
if [[ $1 = "-f" ]]; then
    cd ../..
    firebase login
    firebase deploy
fi
exit