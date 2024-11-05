extends CharacterBody2D


const SPEED = 3000.0
const JUMP_VELOCITY = -2000.0
@onready var animation := $AnimatedSprite2D
var is_jumping = false
var direction

func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_jumping = true

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
		



	_setState()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")

	
func _setState():
	var state = "idle"
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity += get_gravity() * -3
	
	if direction:
		velocity.x = direction * SPEED
		animation.play("rum")
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
	
	
	if !is_on_floor():
		state = "jumping"
		if velocity.y > 0:
			velocity.y = 3000
			animation.play("jump_out")
	
	if direction != 0:
		state = "run"
	
	if animation.name != state:
		animation.play(state)
	


	move_and_slide()
