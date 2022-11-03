extends KinematicBody

var dir = Vector3()
var vel
var capncrunch = Vector3()
var speed = 5
var jump_strength = 2
var is_on_ground = false
var Player_before_jump_pos
var gravity = 5
export var Y_lvl = 1

#func cartesian_to_isometric(cartesian):
#	var screen_pos = Vector2()
#	screen_pos.x = cartesian.x - cartesian.y
#	screen_pos.y = (cartesian.x + cartesian.y)/2
#	return screen_pos

func _process(delta):
	$Control/Label.text = str(vel)

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	elif Input.is_action_pressed("move_left"):
		dir.x -= 1
	else: dir.x = 0
	if Input.is_action_pressed("move_up"):
		dir.z -= 1
	elif Input.is_action_pressed("move_down"):
		dir.z += 1
	else: dir.z = 0
	
	
	
	if not is_on_floor():
		capncrunch.y -= gravity * delta
		
	if Input.is_action_just_pressed("move_jump") && is_on_floor():
		capncrunch.y = jump_strength
	
	move_and_slide(capncrunch, Vector3.UP)
	
	
#	vel = cartesian_to_isometric(vel.normalized())
	
	dir = dir.normalized()
	vel = dir * speed
	move_and_slide(vel, Vector3.UP)
	
	print(vel, ", ", Player_before_jump_pos, ", dir:", dir, ", IOG: ", is_on_ground)
