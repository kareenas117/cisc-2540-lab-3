extends Area2D

func _on_body_entered(body):
	if body.name == "player":
		var main = get_tree().root.get_node("MainWorld")  # find main scene
		main.add_score(1)  # add 1 point
		queue_free()
