extends KinematicBody2D

export (int) var run_speed = 250
export (int) var jump_speed = -600
export (int) var gravity = 1200

export (int) var health = 3

var idle_anim = "h3_idle"
var walk_anim = "h3_walk"

var action_left = false
var action_right = false
var action_jump = false

var velocity = Vector2()
var jumping = false


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right') or action_right
	var left = Input.is_action_pressed('ui_left') or action_left
	var jump = Input.is_action_just_pressed('ui_select') or action_jump

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		emit_signal("camera_right")
		velocity.x += run_speed
	if left:
		emit_signal("camera_left")
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
		action_jump = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	
	if health == 3:
		idle_anim = "h3_idle"
		walk_anim = "h3_walk"
	elif health == 2:
		idle_anim = "h2_idle"
		walk_anim = "h2_walk"
	elif health == 1:
		idle_anim = "h1_idle"
		walk_anim = "h1_walk"
	
	if velocity.x != 0 and is_on_floor():
		$RobotSprite.animation = walk_anim
		$RobotSprite.flip_h = velocity.x < 0
	elif velocity.y > 0 and not is_on_floor():
		$RobotSprite.animation = idle_anim
	elif velocity.y < 0 and not is_on_floor():
		$RobotSprite.animation = idle_anim
	elif velocity.x == 0 and is_on_floor():
		$RobotSprite.animation = idle_anim

func _ready():
	$RobotSprite.animation = idle_anim
	$RobotSprite.play()
	jump()

func move_Right():
	action_left = false
	action_right = true
func move_Left():
	action_right = false
	action_left = true
func jump():
	action_jump = true
func dont_Move():
	action_left = false
	action_right = false
	
func die():
	print("robot dead!")
