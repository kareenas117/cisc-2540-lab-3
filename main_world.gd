extends Node2D

var score = 0
@onready var coin_scene = preload("res://coin.tscn")
@onready var rng = RandomNumberGenerator.new()

func add_score(points):
	score += points
	$ScoreLabel.text = "Score: " + str(score)
	print("Scored! New score:", score)

	# Stop the game at 10 points
	if score >= 10:
		print("🎉 You win! Game over.")
		$WinningLabel.visible = true
		get_tree().paused = true
		return

	# wait briefly before spawning the next coin
	await get_tree().create_timer(0.5).timeout
	print("Spawning new coin...")
	spawn_coin()


func spawn_coin():
	print("Coin spawn started")
	var coin = coin_scene.instantiate()
	rng.randomize()

	# Safely get player position
	var player_node = get_node_or_null("Player")
	var player_pos = Vector2.ZERO
	if player_node:
		player_pos = player_node.position
	else:
		print("⚠️ Player not found in MainWorld!")

	# Define playable area manually
	var left_limit = 0
	var right_limit = 600
	var top_limit = -10
	var bottom_limit = 280
	var margin = 10

	var rand_x: float
	var rand_y: float
	var new_pos: Vector2
	var tries = 0

	print("Playable area:", left_limit, right_limit, top_limit, bottom_limit)

	while tries < 50:
		rand_x = rng.randf_range(left_limit + margin, right_limit - margin)
		rand_y = rng.randf_range(top_limit + margin, bottom_limit - margin)
		new_pos = Vector2(rand_x, rand_y)
		tries += 1

		# Ensure coin not too close to player
		if new_pos.distance_to(player_pos) > 100:
			break

	coin.position = new_pos
	get_parent().add_child(coin)
	coin.z_index = 10
	print("✅ Coin added at:", coin.position)
