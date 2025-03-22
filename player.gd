extends CharacterBody2D



const SPEED = 200.0
const JUMP_VELOCITY = -250.0
var stop = false
func jump(): 
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
func _physics_process(delta: float) -> void:
	if stop == false:
		$AnimatedSprite2D.play()
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_select"):
			jump()

		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_select"):
			stop = true
			var actionables = $actionable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				stop = true
				actionables[0].action()
				return
				

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
	else:
		pass




func _on_dialogue_label_finished_typing() -> void:
	stop = false
