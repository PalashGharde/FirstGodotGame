extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -300.0
var Defend = false
var Attack = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#if Input.is_action_just_pressed("defend") and is_on_floor():
		#animated_sprite_2d.play("DefendMode")
	#	Defend = true
	#	animated_sprite_2d.play("DefendHold")
		
	if Input.is_action_pressed("defend") and is_on_floor():
		if Defend == false:
			animated_sprite_2d.play("DefendMode")
			Defend = true
			
		
		
	#if animated_sprite_2d.animation == "DefendMode" and animated_sprite_2d.is_playing():
		#return  # Do not change animations while entering defend.
	
		
	if Input.is_action_just_released("defend")  and is_on_floor():
		Defend = false
		
	if Input.is_action_just_pressed("attack1") and is_on_floor():
		Attack = true
		animated_sprite_2d.play("Attack1")
		Attack = false
		
	if animated_sprite_2d.animation == "Attack1" and animated_sprite_2d.is_playing():
		return  # Do not change animations while attacking.
	else:
		Attack = false  # Reset attack after animation completes.
	

	# Get the input direction -1, 0, 1 and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip based on Direction
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
		
	if is_on_floor():	
		if direction == 0:
			if Defend == false:
				animated_sprite_2d.play("Idle")
			else:
				animated_sprite_2d.play("DefendHold")
		else:
			animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Jump")
		
	
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
