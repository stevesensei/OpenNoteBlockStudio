// draw_window_greeting()
var x1, y1, a, b, c, d, e, m;
curs = cr_default
x1 = floor(window_width / 2 - 350)
y1 = floor(window_height / 2 - 210)
draw_window(x1, y1, x1 + 700, y1 + 430)
draw_sprite_ext(spr_logo, 0, x1 + 64, y1 + 50, 0.55, 0.55, 0, c_white, 1)
draw_set_font(fnt_info_med_bold)
draw_text_center(x1 + 132, y1 + 213, "Open Minecraft Note Block Studio")
draw_set_font(fnt_mainbold)
if (check_update) {
    if (update = -1) {
        draw_set_color(c_red)
        draw_text_center(x1 + 132, y1 + 248, "无法检查更新")
    }
    if (update = 0) {
        //draw_set_color(c_gray)
        draw_text_center(x1 + 132, y1 + 248, "检查更新中...")
    }
    if (update = 1) {
        draw_set_color(33023)
        draw_text_center(x1 + 132, y1 + 248, "有新的更新啦")
    }
    if (update = 2) {
        draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
        draw_text_center(x1 + 132, y1 + 248, "当前是最新版本!")
    }
    if (update = 3) {
        draw_set_color(c_lime)
        draw_text_center(x1 + 132, y1 + 248, "升级成功!")
    }
} else {
    draw_set_color(c_red)
    draw_text_center(x1 + 132, y1 + 248, "你关闭了检查更新")
}
draw_set_font(fnt_main)
draw_theme_color()
draw_text_center(x1 + 132, y1 + 233, "版本 " + version + " - 发布日期 " + version_date)
draw_text_center(x1 + 132, y1 + 280, "开源 Minecraft Note Block Studio")
draw_set_color(make_color_rgb(62, 144, 255))
draw_text_center(x1 + 132, y1 + 296, "www.git.io/fjQH3")
draw_line(x1 + 85, y1 + 309, x1 + 177, y1 + 309)

a = mouse_rectangle(x1 + 86, y1 + 298, 92, 12)
if (a) {
    curs = cr_handpoint
    if (mouse_check_button_pressed(mb_left))
        open_url("https://git.io/fjQH3")
}

draw_theme_color()
draw_text_center(x1 + 132, y1 + 340, "原作者:David Norgren")
draw_set_color(make_color_rgb(62, 144, 255))
draw_text_center(x1 + 132, y1 + 356, "www.stuffbydavid.com")
draw_line(x1 + 70, y1 + 369, x1 + 193, y1 + 369)
a = mouse_rectangle(x1 + 71, y1 + 358, 123, 12)
if (a) {
    curs = cr_handpoint
    if (mouse_check_button_pressed(mb_left))
        open_url("http://www.stuffbydavid.com")
}
draw_set_color(c_white)
draw_line(x1 + 270, y1 + 24, x1 + 270, y1 + 396)
draw_set_alpha(0.25)
draw_theme_color()
draw_line(x1 + 269, y1 + 24, x1 + 269, y1 + 396)
draw_set_alpha(1)
draw_theme_color()
draw_text(x1 + 290, y1 + 20, "想做些什么呢~")

b = x1 + 300
c = y1 + 48
a = mouse_rectangle(b, c, 224, 32)
a += (a && (mouse_check_button(mb_left) || mouse_check_button_released(mb_left)))
draw_sprite(spr_frame2, a + 3 * theme, b, c)
draw_sprite(spr_bigicons, 0, b + (a > 1), c + (a > 1))
draw_text(b + 48 + (a > 1), c + 9 + (a > 1), "创建新曲子")
if (a = 2 && mouse_check_button_released(mb_left)) window = 0

c += 44
b = x1 + 300
a = mouse_rectangle(b, c, 224, 32)
a += (a && (mouse_check_button(mb_left) || mouse_check_button_released(mb_left)))
draw_sprite(spr_frame2, a + 3 * theme, b, c)
draw_sprite(spr_bigicons, 1, b + (a > 1), c + (a > 1))
draw_text(b + 48 + (a > 1), c + 9 + (a > 1), "加载工程")
if (a = 2 && mouse_check_button_released(mb_left)) {
    load_song("")
    return 1
}
b = x1 + 320
for (a = 0; a < 11; a += 1) {
    if (recent_song[a] = "") break
    if (a = 0) {
        c += 36
        draw_text(b - 20, c, "最近歌曲:")
        c += 16
    }

    popup_set_window(b, c, 320, 16, recent_song[a])
    m = mouse_rectangle(b, c, 320, 16)
    m += m && mouse_check_button(mb_left)
    if (m > 0 && mouse_check_button_released(mb_left)) {
        if (!file_exists_lib(recent_song[a])) {
            message("无法找到文件:\n" + recent_song[a], "错误")
            for (d = 0; d < 10; d += 1) {
                if (recent_song[d] = recent_song[a]) {
                    for (e = d; e < 10; e += 1) {
                        recent_song[e] = recent_song[e + 1]
                        recent_song_time[e] = recent_song_time[e + 1]
                    }
                }
            }
            recent_song[10] = ""
            recent_song_time[10] = 0
        } else {
            load_song(recent_song[a])
        }
    }
    draw_sprite(spr_frame5, theme * 3 + m, b, c)
    draw_text(b + 2 + (m = 2), c + 1 + (m = 2), string_truncate(filename_name(recent_song[a]), 220))
    draw_set_halign(fa_right)
    draw_text(b + 316 + (m = 2), c + 1 + (m = 2), seconds_to_str(floor(date_second_span(recent_song_time[a], date_current_datetime()))))
    draw_set_halign(fa_left)
    c += 16
}
c += 10
if (recent_song[0] = "")
 c += 34
b = x1 + 300
a = mouse_rectangle(b, c, 224, 32)
a += (a && (mouse_check_button(mb_left) || mouse_check_button_released(mb_left)))
draw_sprite(spr_frame2, a + 3 * theme, b, c)
draw_sprite(spr_bigicons, 2, b + (a > 1), c + (a > 1))
draw_text(b + 48 + (a > 1), c + 9 + (a > 1), "从midi创建新工程")
if (a = 2 && mouse_check_button_released(mb_left)) open_midi("")

b = x1 + 300
c += 44
a = mouse_rectangle(b, c, 224, 32)
a += (a && (mouse_check_button(mb_left) || mouse_check_button_released(mb_left)))
draw_sprite(spr_frame2, a + 3 * theme, b, c)
draw_sprite(spr_bigicons, 6, b + (a > 1), c + (a > 1))
draw_text(b + 48 + (a > 1), c + 9 + (a > 1), "教程视频(需要科学上网)")
if (a = 2 && mouse_check_button_released(mb_left)) open_url("http://www.youtube.com/playlist?list=PL7EA4F0D271DA6E86")

window_set_cursor(curs)
