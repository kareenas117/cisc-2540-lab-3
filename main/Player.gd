extends CharacterBody2D

const SPEED = 200.0

func _physics_process(delta):
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1

	velocity = input_direction.normalized() * SPEED
	move_and_slide()
	
