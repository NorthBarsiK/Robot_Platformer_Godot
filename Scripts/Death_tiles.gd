extends TileMap

signal player_die

func _on_death_area_body_entered(body):
	emit_signal("player_die")
