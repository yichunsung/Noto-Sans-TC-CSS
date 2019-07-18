#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

fontforge="C:\Program Files (x86)\FontForgeBuilds\bin\fontforge.exe"
fontforgeScript="${SCRIPT_DIR}/woff2_to_woff_fontforge.sh"

# the font to provider the space glyph
spaceGlyphFont="${SCRIPT_DIR}/space-glyph-provider.ttf"

pushd "${SCRIPT_DIR}" || exit

for fontDir in noto_sans_*/; do
    pushd "${fontDir}" || exit

    for woff2File in *.woff2; do
        fileName=$(basename -- "${woff2File}")
        fileNameNoExt="${fileName%.*}"
        fileExt="${fileName##*.}"

        echo
        echo "[Directory] ${fontDir}"
        echo "[Processing] ${woff2File}"

        "${fontforge}" "${fontforgeScript}" "${fileName}" "${spaceGlyphFont}"

        rm -f tmp.ttf
    done

    popd || exit
done

popd || exit
