#!/bin/bash
# 用法: ./render.sh input.html output.png [width] [height] [scale]
# input.html 需要包含 <html data-theme="__THEME__"> 占位符
# 固定用浅色主题（不再按时间自动切换深浅色，统一减少变量）
set -e

INPUT="$1"
OUTPUT="$2"
WIDTH="${3:-520}"
HEIGHT="${4:-560}"
SCALE="${5:-3}"
THEME="light"

TMP=$(mktemp --suffix=.html)
sed "s/__THEME__/${THEME}/g" "$INPUT" > "$TMP"

CHROME=/opt/pw-browsers/chromium-1194/chrome-linux/chrome
"$CHROME" \
  --headless=new --disable-gpu --no-sandbox \
  --window-size="${WIDTH},${HEIGHT}" --hide-scrollbars \
  --force-device-scale-factor="$SCALE" \
  --default-background-color=00000000 \
  --screenshot="$OUTPUT" \
  "file://$TMP" 2>/dev/null

rm -f "$TMP"
echo "已生成 $OUTPUT（主题: 浅色固定）"
