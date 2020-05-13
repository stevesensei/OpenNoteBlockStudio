// draw_window_minecraft() 
var x1, y1, a, b, c, stabx, stabw, str, nsel;
curs = cr_default
x1 = floor(window_width / 2 - 245)
y1 = floor(window_height / 2 - 225)
draw_window(x1, y1, x1 + 490, y1 + 450)
draw_set_font(fnt_mainbold)
draw_text(x1 + 8, y1 + 8, "Minecraft兼容性")
draw_set_font(fnt_main)
draw_text(x1 + 16, y1 + 32, "由于原版音符盒的限制,这首曲子必须符合标准为了\n能够顺利导入游戏.")

yy = y1 + 50

b = 8
str[0] = "Schematic"
str[1] = "数据包"
nsel = -1

// Draw tabs
for (a = 0; a < 2; a += 1) {
    c = mouse_rectangle(x1 + b, yy + 28, string_width(str[a]) + 12, 18)
    if (selected_tab_mc = a) {
        stabx = b - 2
        stabw = string_width(str[a]) + 15
    } else {
        draw_sprite(spr_tabbuttons, 0 + 3 * c + 6 * theme, x1 + b, yy + 28)
        draw_sprite_ext(spr_tabbuttons, 1 + 3 * c + 6 * theme, x1 + b + 2, yy + 28, string_width(str[a]) / 2 + 4, 1, 0, -1, 1)
        draw_sprite(spr_tabbuttons, 2 + 3 * c + 6 * theme, x1 + b + string_width(str[a]) + 10, yy + 28)
        draw_text(x1 + b + 6, yy + 30, str[a])
    }
    if (mouse_check_button_pressed(mb_left) && c) nsel = a
    b += string_width(str[a]) + 12
}
if (theme = 0) {
    draw_set_color(c_white)
    draw_rectangle(x1 + 6, yy + 46, x1 + 484, yy + 350, 0) 
    draw_set_color(make_color_rgb(137, 140, 149))
    draw_rectangle(x1 + 6, yy + 46, x1 + 484, yy + 350, 1)
    draw_set_color(c_white)
    draw_rectangle(x1 + stabx, yy + 26, x1 + stabx + stabw, yy + 26 + 20, 0)
    draw_set_color(make_color_rgb(137, 140, 149))
    draw_rectangle(x1 + stabx, yy + 26, x1 + stabx + stabw, yy + 26 + 20, 1)
    draw_set_color(c_white)
    draw_rectangle(x1 + stabx + 1, yy + 46, x1 + stabx + stabw - 1, yy + 47, 0)
    draw_theme_color()
    draw_text(x1 + stabx + 8, yy + 28, str[selected_tab_mc])
} else if(theme = 1){
    draw_sprite(spr_tabbuttons, 12, x1 + stabx - 1, yy + 26)
    draw_sprite_ext(spr_tabbuttons, 13, x1 + stabx + 1, yy + 26, stabw / 2 - 1, 1, 0, -1, 1)
    draw_sprite(spr_tabbuttons, 14, x1 + stabx + stabw - 1, yy + 26)
    draw_text(x1 + stabx + 8, yy + 28, str[selected_tab_mc])
	draw_window(x1 + 6, yy + 46, x1 + 484, yy + 350)
} else {
	draw_set_color(c_dark)
    draw_rectangle(x1 + 6, yy + 46, x1 + 484, yy + 350, 0) 
    draw_set_color(make_color_rgb(137, 140, 149))
    draw_rectangle(x1 + 6, yy + 46, x1 + 484, yy + 350, 1)
    draw_set_color(c_dark)
    draw_rectangle(x1 + stabx, yy + 26, x1 + stabx + stabw, yy + 26 + 20, 0)
    draw_set_color(make_color_rgb(137, 140, 149))
    draw_rectangle(x1 + stabx, yy + 26, x1 + stabx + stabw, yy + 26 + 20, 1)
    draw_set_color(c_dark)
    draw_rectangle(x1 + stabx + 1, yy + 46, x1 + stabx + stabw - 1, yy + 47, 0)
    draw_theme_color()
    draw_text(x1 + stabx + 8, yy + 28, str[selected_tab_mc])
}
if (nsel > -1) selected_tab_mc = nsel
selected_tab_mc += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
if (selected_tab_mc < 0) selected_tab_mc = 1
if (selected_tab_mc > 1) selected_tab_mc = 0

// Draw content
yy += 65
if (selected_tab_mc = 0) { // Schematic

	if(tempo = 10 || tempo = 5 || tempo = 2.5){
		// compatible
		draw_sprite(spr_yesno, 1, x1 + 25, yy + 8)
	} else {
		// not compatible
		draw_sprite(spr_yesno, 0, x1 + 25, yy + 8)
	}

	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "歌曲速度必须是 2.5, 5或10 ticks每秒")
	draw_set_font(fnt_main)

	if (tempo = 10 || tempo = 5 || tempo = 2.5) {    
		draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
	    draw_text(x1 + 45, yy + 16, "当前速度是" + string(tempo) + " ticks每秒.")
	} else {
		draw_set_color(c_red)
	    draw_text(x1 + 45, yy + 16, "当前速度是" + string(tempo) + " ticks每秒.")
	    if (draw_button2(x1 + 45, yy + 34, 140, "修复速度")) {
	        var otempo = tempo
	        if (otempo > 10) tempo = 10
	        if (otempo < 10) tempo = 10
	        if (otempo < 7.5) tempo = 5
	        if (otempo < 3.75) tempo = 2.5
	    }
	}
	draw_theme_color()

	yy += 90
	draw_sprite(spr_yesno, block_outside = 0, x1 + 25, yy + 8)
	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "所有的音符必须在minecraft所支持的两个八度范围内.")
	draw_set_font(fnt_main)
	if (block_outside > 0) {    
	    draw_set_color(c_red)
	    if (block_outside = 1) {
	        draw_text(x1 + 45, yy + 16, "当前有一个音符超出范围.")
	    } else {
	        draw_text(x1 + 45, yy + 16, "当前有" + string(block_outside) + "个音符超出范围")
	    }
	    if (draw_button2(x1 + 45, yy + 34, 130, "选择音符")) {
	        select_outside()
	        window = 0
	    }
	    if (draw_button2(x1 + 185, yy + 34, 100, "转换音符")) {
	        if (question("要转换音符到范围内吗?", "转换音符")) {
	            select_all(-1, 0)
	            selection_transpose()
	            selection_place(0)
	        }
	    }
	} else {
	    draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
	    draw_text(x1 + 45, yy + 16, "恭喜!没有音符超出范围.")
	}
	draw_theme_color()

	yy += 90
	draw_sprite(spr_yesno, block_custom = 0, x1 + 25, yy + 8)
	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "不使用自定义乐器.")
	draw_set_font(fnt_main)
	if (block_custom > 0) {    
	    draw_set_color(c_red)
	    if (block_custom = 1) draw_text(x1 + 45, yy + 16, "当前有一个音符使用自定义乐器.")
	    else draw_text(x1 + 45, yy + 16, "当前有 " + string(block_custom) + " 个音符使用自定义乐器.")
	    if (draw_button2(x1 + 45, yy + 34, 160, "选择音符")) {
	        select_custom()
	        window = 0
	    }
	} else {
	    draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
	    draw_text(x1 + 45, yy + 16, "没有音符使用自定义乐器")
	}
	draw_theme_color()
	
} else { // Datapack
	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "虽然导出数据包歌曲速度没有限制.")
	draw_set_font(fnt_main)
	draw_text(x1 + 45, yy + 16, "不过,速度 0.25, 0.5, 1, 1.25, 2, 2.5, 4, 5, 10，20 t/s 会更好.")

	if (tempo = 20 || tempo = 10 || tempo = 5 || tempo = 4 || tempo = 2.5 || tempo = 2 || tempo = 1.25 || tempo = 1 || tempo = 0.5 || tempo = 0.25) {    
		draw_sprite(spr_yesno, 1, x1 + 25, yy + 8)	
		draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
		draw_text(x1 + 45, yy + 32, "速度是 " + string(tempo) + " ticks每秒.")
	} else {
		draw_sprite(spr_yesno, 2, x1 + 25, yy + 8)	
	    draw_set_color(c_orange)
	    draw_text(x1 + 45, yy + 32, "速度是 " + string(tempo) + " ticks每秒.")
		if (draw_button2(x1 + 45, yy + 50, 180, "为数据包优化速度")) {
		    var otempo
			otempo = tempo
			if (otempo >= 15) tempo = 20
	        if (otempo < 15) tempo = 10
	        if (otempo < 7.5) tempo = 5
	        if (otempo < 4.5) tempo = 4
	        if (otempo < 3.25) tempo = 2.5
			if (otempo < 2.25) tempo = 2
			if (otempo < 1.625) tempo = 1.25
			if (otempo < 1.125) tempo = 1
			if (otempo < 0.75) tempo = 0.5
			if (otempo < 0.375) tempo = 0.25
	    }
	}
	draw_theme_color()

	yy += 90
	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "如果使用数据包, 您可以将支持的范围扩展到6个八度音阶.")
	draw_set_font(fnt_main)
	draw_text(x1 + 45, yy + 16, "如不使用,所有的音符都应该在2个八度范围内")	
	if (block_outside > 0) {
	draw_sprite(spr_yesno, 2, x1 + 25, yy + 8)
	    draw_set_color(c_orange)
	    if (block_outside = 1) {
	        draw_text(x1 + 45, yy + 32, "当前有一个音符超出范围.")
	    } else {
	        draw_text(x1 + 45, yy + 32, "当前有 " + string(block_outside) + " 个音符超出范围.")
	    }
	    if (draw_button2(x1 + 45, yy + 50, 130, "Select affected blocks")) {
	        select_outside()
	        window = 0
	    }
	    if (draw_button2(x1 + 185, yy + 50, 100, "转换音符")) {
	        if (question("要转换音符到范围内吗?", "转换音符")) {
	            select_all(-1, 0)
	            selection_transpose()
	            selection_place(0)
	        }
	    }
	} else {
		draw_sprite(spr_yesno, 1, x1 + 25, yy + 8)
	    draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
	    draw_text(x1 + 45, yy + 32, "恭喜!没有音符超出范围.")
	}
	draw_theme_color()

	yy += 90
	draw_set_font(fnt_mainbold)
	draw_text(x1 + 45, yy, "使用资源包,你可以在歌曲中使用自定义乐器")
	draw_set_font(fnt_main)
	draw_text(x1 + 45, yy + 16, "如果不使用,请确保没有自定义乐器")
	if (block_custom > 0) {
		draw_sprite(spr_yesno, 2, x1 + 25, yy + 8)
	    draw_set_color(c_orange)
	    if (block_custom = 1) draw_text(x1 + 45, yy + 32, "当前有一个音符使用自定义乐器.")
	    else draw_text(x1 + 45, yy + 32, "当前有 " + string(block_custom) + " 个音符使用自定义乐器.")
		if (draw_button2(x1 + 45, yy + 50, 160, "选择音符")) {
	        select_custom()
	        window = 0
	    }
	} else {
		draw_sprite(spr_yesno, 1, x1 + 25, yy + 8)
	    draw_set_color(c_green)
		if (theme == 2) draw_set_color(c_lime)
	    draw_text(x1 + 45, yy + 32, "没有音符使用自定义乐器")
	}
	draw_theme_color()
}

if (draw_button2(x1 + 240 - 36, y1 + 413, 72, "确定")) window = 0
window_set_cursor(cr_default)
