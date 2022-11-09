extends KinematicBody

var dir = Vector3()
var vel = Vector3()
var capncrunch = Vector3()
var speed = 4
var jumpStrength = 2
var dashStrength = 30
var gravity = 5
var dashing = false
var canShoot = true
var health = 1

const bulletPath = preload("res://Bullet.tscn"	)

#func cartesian_to_isometric(cartesian):
#	var screen_pos = Vector2()
#	screen_pos.x = cartesian.x - cartesian.y
#	screen_pos.y = (cartesian.x + cartesian.y)/2
#	return screen_pos

func _process(delta):
	$Control/Label.text = str(vel)
	if health <= 0:
		death()



func raycast_mouse_pos():
	var spaceState = get_world().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(rayOrigin, rayEnd)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()



func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.global_transform.origin = $Position3D.global_transform.origin
	bullet.vel = raycast_mouse_pos() - bullet.global_transform.origin
	canShoot = false
	yield(get_tree().create_timer(0.2), "timeout")
	canShoot = true



func dash():
	vel = dir.normalized() * dashStrength
	dashing = true
	yield(get_tree().create_timer(0.5),"timeout")
	dashing = false
	pass



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
	
	
	
	if Input.is_action_pressed("shoot") && canShoot == true:
		shoot()
		health -= 1
	
	if Input.is_action_just_pressed("move_dash") && dashing == false:
		dash()
	
	
	
	if not is_on_floor():
		capncrunch.y -= gravity * delta
		
	if Input.is_action_just_pressed("move_jump") && is_on_floor():
		capncrunch.y = jumpStrength
		print("jump")
	
	
	
	move_and_slide(capncrunch, Vector3.UP)
	
	dir = dir.normalized()
	#vel = dir * speed
	vel.x = lerp(vel.x, dir.x * speed, 0.2)
	vel.z = lerp(vel.z, dir.z * speed, 0.2)
	move_and_slide(vel, Vector3.UP)



func charSelected():
	#check what character was selected
	#load models
	#load characteristics
	pass

func _ready():
	charSelected()



func death():
	#Play animation
	#Type You Died on screen
	#Quick restart of exit to hub?
	print("you died")
	pass
