#!/bin/sh
# Script (more like header with var definitions) for testing colors and
# other ESC tags.  In ANSI and in ESC/P2.  Script is best used as sourced
# into file and then tagging/replacing only with short variable names. 
#
# Logic behind variable names: 
# Color (long): 
# Type(ANSI or ESC/P) underscore /
# C(for color) Color_number Color_name underscore /
# Foreground or Background
#
# Color (short): 
# a or e (for ANSI or ESC/P) /
# single letter color name /
# f or b for Foreground or Background
#
# Attributes (long): 
# Type(ANSI or ESC/P) underscore /
# Atribute_name underscore /
# O or C for Open or Close
#
# Attributes (short): 
# a or e (for ANSI or ESC/P) / 
# two letter Atribute_name /
# O or C for Open or Close
#
# RES is ANSI restore, and RST is ESC/P printer initialization.
# 
# Short variable names defined here allow for clean and easy readable 
# ESC tagged text; please see (and uncomment to test) functions 
# ANSItest and ESCPtest near the end.
#
# Besides readability, once doc is tagged with short ANSI names
# simple swap '$a'/'$e' will allow for doc to be ESC/P2 print file.
#
# I hope that this will help with writing terminfo/termcap deffinitions.
#
# I also hope that someone will find this useful :D
# twitter.com/vmisev
# 11/2023 
#--------------------------------------::--------------------------------------#
# 
# ANSI ESC colors and attributes
#--------------------------------------::--------------------------------------#
ansi_C0Black_Fg='[30m'
ansi_C0Black_Bg='[40m'
ansi_C1Red_Fg='[31m'
ansi_C1Red_Bg='[41m'
ansi_C2Green_Fg='[32m'
ansi_C2Green_Bg='[42m'
ansi_C3Yellow_Fg='[33m'
ansi_C3Yellow_Bg='[43m'
ansi_C4Blue_Fg='[34m'
ansi_C4Blue_Bg='[44m'
ansi_C5Magenta_Fg='[35m'
ansi_C5Magenta_Bg='[45m'
ansi_C6Cyan_Fg='[36m'
ansi_C6Cyan_Bg='[46m'
ansi_C7White_Fg='[37m'
ansi_C7White_Bg='[47m'
ansi_CDefault_Fg='[39m'
ansi_CDefault_Bg='[49m'
ansi_bold_o='[1m'
ansi_bold_c='[22m'
ansi_dim_o='[2m'
ansi_dim_c='[22m'
ansi_italic_o='[3m'
ansi_italic_c='[23m'
ansi_underline_o='[4m'
ansi_underline_c='[24m'
ansi_sblink_o='[5m'
ansi_sblink_c='[25m'
ansi_fblink_o='[6m'
ansi_fblink_c='[26m'
ansi_inverse_o='[7m'
ansi_inverse_c='[27m'
ansi_hidden_o='[8m'
ansi_hidden_c='[28m'
ansi_strike_o='[9m'
ansi_strike_c='[29m'
ansi_Rs='[0m'
#
#--------------------------------------::--------------------------------------#
# 
# ANSI ESC colors and attributes - short variable names
#--------------------------------------::--------------------------------------#
RES=$ansi_Rs
akf=$ansi_C0Black_Fg
akb=$ansi_C0Black_Bg
arf=$ansi_C1Red_Fg
arb=$ansi_C1Red_Bg
agf=$ansi_C2Green_Fg
agb=$ansi_C2Green_Bg
ayf=$ansi_C3Yellow_Fg
ayb=$ansi_C3Yellow_Fg
abf=$ansi_C4Blue_Fg
abb=$ansi_C4Blue_Bg
amf=$ansi_C5Magenta_Fg
amb=$ansi_C5Magenta_Bg
acf=$ansi_C6Cyan_Fg
acb=$ansi_C6Cyan_Bg
awf=$ansi_C7White_Fg
awb=$ansi_C7White_Bg
abdo=$ansi_bold_o
abdc=$ansi_bold_c
abso=$ansi_dim_o
absc=$ansi_dim_c
aito=$ansi_italic_o
aitc=$ansi_italic_c
aulo=$ansi_underline_o
aulc=$ansi_underline_c
ablo=$ansi_sblink_o
ablc=$ansi_sblink_c
aino=$ansi_inverse_o
ainc=$ansi_inverse_c
asto=$ansi_strike_o
astc=$ansi_strike_c
#--------------------------------------::--------------------------------------#
#
#--------------------------------------::--------------------------------------#
# 
# ESC/P2 colors (VGA pallete) and attributes
# For real printer use just ^[r(number_from_varName)
#--------------------------------------::--------------------------------------#
escp_C0Black_Fg='r0r'
escp_C0Black_Bg='r|0r'
escp_C1Magenta_Fg='r11141290r'
escp_C1Magenta_Bg='r|11141290r'
escp_C2Cyan_Fg='r11184641r'
escp_C2Cyan_Bg='r|11184641r'
escp_C3Blue_Fg='r11141120r'
escp_C3Blue_Bg='r|11141120r'
escp_C4Yellow_Fg='r59110r'
escp_C4Yellow_Bg='r|59110r'
escp_C5Red_Fg='r170r'
escp_C5Red_Bg='r|170r'
escp_C6Green_Fg='r43520r'
escp_C6Green_Bg='r|43520r'
escp_C7White_Fg='r16777215r'
escp_C7White_Bg='r|16777215r'
escp_CDefault_Fg='rr'
escp_CDefault_Bg='rr'
escp_CDefault='rr'
escp_bold_o='E'
escp_bold_c='F'
escp_italic_o='4'
escp_italic_c='5'
escp_underline_o='-1'
escp_underline_c='-0'
#escp_dim_o='q3'
#escp_dim_c='q1'
#escp_inverse_o='B1'
#escp_inverse_c='B0'
#escp_strike_o='(-32'
#escp_strike_c='(-30'
#--------------------------------------::--------------------------------------#
# ESC/P2 initialize printer.
#--------------------------------------::--------------------------------------#
escp_Rs='@'
#
#--------------------------------------::--------------------------------------#
# 
# ESC/P2 ESC colors and attributes - short variable names
#--------------------------------------::--------------------------------------#
RST=$escp_Rs
ekf=$escp_C0Black_Fg
ekb=$escp_C0Black_Bg
emf=$escp_C1Magenta_Fg
emb=$escp_C1Magenta_Bg
ecf=$escp_C2Cyan_Fg
ecb=$escp_C2Cyan_Bg
ebf=$escp_C3Blue_Fg
ebb=$escp_C3Blue_Bg
eyf=$escp_C4Yellow_Fg
eyb=$escp_C4Yellow_Fg
erf=$escp_C5Red_Fg
erb=$escp_C5Red_Bg
egf=$escp_C6Green_Fg
egb=$escp_C6Green_Bg
ewf=$escp_C7White_Fg
ewb=$escp_C7White_Bg
ebdo=$escp_bold_o
ebdc=$escp_bold_c
eito=$escp_italic_o
eitc=$escp_italic_c
eulo=$escp_underline_o
eulc=$escp_underline_c
eclr=$escp_CDefault
ecla=$ebdc$eitc$eulc$eclr
#ebso=$escp_dim_o
#ebsc=$escp_dim_c
#eino=$escp_inverse_o # ?
#einc=$escp_inverse_c # ?
#esto=$escp_strike_o
#estc=$escp_strike_c
#--------------------------------------::--------------------------------------#
#
ANSItest () {
echo '\n| Normal text | '$abdo'Bold'$abdc' |  '$aito'Italic'$aitc' | '$aulo'Underline'$aulc' | '$ablo'Blink'$ablc' |  '$aino'Inverse'$ainc' | '$asto'Strike'$astc
echo '| Normal text | '$abdo$aito$aulo'Bold Italic Underline'$aulc$aitc$abdc' | '$abdo$aino'Bold Inverse'$ainc$abdc' | '$aulo$asto'Underline Strike |'$astc$aulc
echo $awb$akf' 0 Black '$RES$arf' 1 Red '$agf' 2 Green'$ayf' 3 Yellow '$abf' 4 Blue '$amf' 5 Magenta '$acf' 6 Cyan '$awf' 7 White \n\n'$awc'.'
}
#
ESCPtest () {
echo '\n| Normal text | '$ebdo'Bold'$ecla' |  '$eito'Italic'$ecla' | '$eulo'Underline'$ecla' | '
echo '| Normal text |  '$ebdo$eito'Bold Italic'$ecla'  |  '$ebdo$eito$eulo'Bold Italic Underline'$ecla'  |  '$eito$eulo'Italic Underline  |'$ecla
echo $ekf' 0 Black '$erf' 1 Red '$egf' 2 Green'$eyf' 3 Yellow '$ebf' 4 Blue '$emf' 5 Magenta '$ecf' 6 Cyan '$ewf' 7 White \n\n'$ewc$ecla'.'
}
#
#ANSItest
#ESCPtest > ESCPtest.prn
#--------------------------------------::--------------------------------------#
