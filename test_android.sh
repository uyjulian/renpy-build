#!/bin/bash

set -e


ROOT="$(dirname $(readlink -f $0))"

pushd "$ROOT"
./build.py --platform android rebuild rapt rapt-sdl2
popd


rm -f "$ROOT/renpy/rapt/Sdk"
ln -s "/home/tom/ab/android/Sdk" "$ROOT/renpy/rapt/Sdk"
mkdir -p "$ROOT/renpy/rapt/project"
cp -a /home/tom/ab/android/local.properties "$ROOT/renpy/rapt/project"

pushd "$ROOT/renpy/rapt"
export PGS4A_NO_TERMS=1
python android.py installsdk
popd

if [ "$1" != "" ]; then
    $ROOT/renpy/renpy.sh $ROOT/renpy/launcher android_build "$1" installDebug --launch
fi

# sleep 1
# adb shell input keyevent KEYCODE_HOME

# sleep 1
# adb shell am start -n com.starcadets.themorningstar/org.renpy.android.PythonSDLActivity
