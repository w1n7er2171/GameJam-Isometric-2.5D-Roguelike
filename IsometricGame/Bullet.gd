extends KinematicBody

var vel = Vector3()
var speed = 10

func _physics_process(delta):
	var collision_info = move_and_collide(vel.normalized()* delta * speed)
