#!/usr/bin/env fontforge

# convert the source font to TTF format
Open($1)
CIDFlatten()
Generate("tmp.ttf")
Close()

# There is bug in IE/Edge that a font must have the space (0x20) glyph mapped.
# Otherwise, there would be some whitespaces shown as "block" on the screen.
#
# @see https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/10160748/
# @see https://github.com/sapegin/grunt-webfont/issues/333
# @see https://github.com/FontCustom/fontcustom/issues/176

# copy the space glyph from the fixer
Open($2)
Select(0u20)
Copy()
Close()

# paste the copied space glyph and regenerated a fixed font
Open("tmp.ttf")
Select(0u20)
Paste()
# generate WOFF for legacy IE/Edge
Generate($1:r + ".woff")
Close()
