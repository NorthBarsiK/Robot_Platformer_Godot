extends CanvasLayer

signal MOVE_LEFT
signal MOVE_RIGHT
signal JUMP
signal STOP_MOVE

func _on_Left_button_down():
	emit_signal("MOVE_LEFT")

func _on_Right_button_down():
	emit_signal("MOVE_RIGHT")

func _dont_Move():
	emit_signal("STOP_MOVE")

func Jump():
	emit_signal("JUMP")
