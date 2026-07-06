#!/bin/bash
# 用法: ./render.sh input.html output.png [width] [height] [scale]
# input.html 需要包含 <html data-theme="__THEME__"> 占位符
# 会根据新加坡时间（18:00-06:00 用 dark，其余 light）自动选择主题
set -e

INPUT="$1"
OUTPUT="$2"
WIDTH="${3:-520}"
HEIGHT="${4:-560}"
SCALE="${5:-3}"

HOUR=$(TZ=Asia/Singapore date +%H)
HOUR=$((10#$HOUR))
if [ "$HOUR" -ge 18 ] || [ "$HOUR" -lt 6 ]; then
  THEME="dark"
else
  THEME="light"
fi

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
echo "已生成 $OUTPUT（主题: $THEME，新加坡时间 ${HOUR}点）"
