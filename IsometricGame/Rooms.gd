extends Spatial

onready var Player_Y = get_node("KinematicBody").Y_lvl

func _process(delta):
	$KinematicBody/Control/Label.text = str($KinematicBody.Y_lvl)

