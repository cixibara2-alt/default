#!/usr/bin/env python3
"""用法: python3 autocrop.py input.png output.png [padding]
把 render.sh 生成的图裁到内容边界（防止之前"截图不全/留白太多"的问题）。
- 若图片带 alpha 通道（pure-template 透明背景）：按非透明像素的包围盒裁剪。
- 若不透明（card 系列）：按四角背景色，裁掉大片纯色边框。
渲染时 render.sh 的 width/height 尽量给大一点（宁可留白也不要裁到内容），
交给这个脚本收紧，而不是反复猜测精确尺寸。
"""
import sys
from PIL import Image

def autocrop(path_in, path_out, pad=16):
    im = Image.open(path_in)
    if im.mode == "RGBA" and im.getchannel("A").getextrema()[0] < 255:
        bbox = im.getbbox()
    else:
        rgb = im.convert("RGB")
        w, h = rgb.size
        bg = rgb.getpixel((2, 2))
        px = rgb.load()
        def row_is_bg(y):
            return all(px[x, y] == bg for x in range(0, w, 4))
        def col_is_bg(x):
            return all(px[x, y] == bg for y in range(0, h, 4))
        top = 0
        while top < h and row_is_bg(top): top += 1
        bottom = h - 1
        while bottom > 0 and row_is_bg(bottom): bottom -= 1
        left = 0
        while left < w and col_is_bg(left): left += 1
        right = w - 1
        while right > 0 and col_is_bg(right): right -= 1
        bbox = (left, top, right, bottom)
    l, t, r, b = bbox
    l = max(0, l - pad); t = max(0, t - pad)
    r = min(im.width, r + pad); b = min(im.height, b + pad)
    im.crop((l, t, r, b)).save(path_out)

if __name__ == "__main__":
    pad = int(sys.argv[3]) if len(sys.argv) > 3 else 16
    autocrop(sys.argv[1], sys.argv[2], pad)
    print(f"已裁剪 {sys.argv[2]}")
