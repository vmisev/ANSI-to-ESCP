#!/bin/sh
# ansi2escp2.sh © @freebsdfrau '23
exec 9<<-'EOF'
# remove xterm, DEC, bracketed paste signals
    s/\x1b\[\?[^\x07]*\x07//g
    s/\x1b\[?2004[h|l]//g
    s/\x1b\[?1049[h|l]//g
    s/\x1b\[22;0;0t//g
    s/\x1b\[?1h//g
    s/\x1b=//g

# Convert compound ANSI to simple ANSI
: 9
    s/\(\x1b\[\)\([^;]*\);/\1\2m\1/g
t 9

# fix 00m
    s/\x1b\[00m/\x1b\[0m/g

# Remove leading/implied zeroes
    s/\(\x1b\[\)0\([^m]\{0,\}m\)/\1\2/g

# Not supported in ESC/P2, so removed
#    s/\x1b\[[5|25|6|26|8|28]m//g # Slow/Fast Blink, Hidden
# v2 with Striketrough and Dim removed as well
    s/\x1b\[[2|5|25|6|26|8|28|9|29]m//g # Dim, Slow/Fast Blink, 
                                        # Hidden, Striketrough
# Translate ANSI to ESC-P2
    s/\x1b\[1m/\x1bE/g # Bold on
    s/\x1b\[22m/\x1bF/g # Bold off
    s/\x1b\[3m/\x1b4/g # Italic on
    s/\x1b\[23m/\x1b5/g # Italic off
    s/\x1b\[4m/\x1b\-1/g # Underline on
    s/\x1b\[24m/\x1b\-0/g # Underline off
#
# Rarely used Striketrough is not supported by Printfil
# but I think codes sould work on real printer
#    s/\x1b\[9m/\x1b(-32/g' # Striketrough on
#    s/\x1b\[29m/\x1b(-30/g # Striketrough off
#
# We don't have inverse, so we are using: 
# Inverse ver 1: bold italic underline for stand out
#    s/\(\x1b\)\[7m/\1E\14\1\-1/g
#    s/\(\x1b\)\[27m/\1F\15\1\-0/g
#
# Inverse ver 2: yellow fg on blue bg  
    s/\x1b\[7m/\x1br\x0F59110\|11141120\x1br\x10/g
    s/\(\x1b\)\[27m/\1r\x0f\1r\x10/g
#
# Inverse ver 3: remove
#    s/\x1b\[7m//g
#    s/\x1b\[27m//g

# Colors
    s/\x1b\[30m/\x1br\x0F0\x1br\x10/g # black fg
    s/\x1b\[40m/\x1br\x0F\|0\x1br\x10/g # black bg
    s/\x1b\[31m/\x1br\x0F170\x1br\x10/g # red fg
    s/\x1b\[41m/\x1br\x0F\|170\x1br\x10/g # red bg
    s/\x1b\[32m/\x1br\x0F43520\x1br\x10/g # green fg
    s/\x1b\[42m/\x1br\x0F\|43520\x1br\x10/g # green bg
    s/\x1b\[33m/\x1br\x0F59110\x1br\x10/g # yellow fg
    s/\x1b\[43m/\x1br\x0F\|59110\x1br\x10/g # yellow bg 
    s/\x1b\[34m/\x1br\x0F11141120\x1br\x10/g # blue fg
    s/\x1b\[34m/\x1br\x0F\|11141120\x1br\x10/g # blue bg
    s/\x1b\[35m/\x1br\x0F11141290\x1br\x10/g # magenta fg
    s/\x1b\[45m/\x1br\x0F\|11141290\x1br\x10/g # magenta bg 
    s/\x1b\[36m/\x1br\x0F11184641\x1br\x10/g # cyan fg 
    s/\x1b\[46m/\x1br\x0F\|11184641\x1br\x10/g # cyan bg
    s/\x1b\[39m/\x1br\x0F\x1br\x10/g # default fg 
    s/\x1b\[49m/\x1br\x0F\|\x1br\x10/g # default bg

# Attribute Reset
    s/\(\x1b\)\[m/\1F\15\1-0\1r\x0f\1r\x10/g

# Strip remaining unconverted ANSI
    s/\x1b\[[K|Kl|\>|\?1x]//g
    s/\x1b\]0m//g
    s/\x1b\[[[:alnum:]]\{1,\}m//g
    s/\x1b\[//g
EOF

ANSI2ESCP2=$( cat <&9 )

#if [ -t 0 -a $# -lt 1 ]; then
#    script -aqt0 /dev/null
#else
#    cat "$@"
#fi | sed -e "$ANSI2ESCP2"

while read line ;do 
    sed -e "$ANSI2ESCP2"  > ~/ESCP.prn
done
