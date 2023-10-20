extends Area3D

@export var move_speed: float = 2.0
@export var move_dir: Vector3

var start_pos: Vector3
var target_pos: Vector3

func _ready():
	start_pos = global_position
	target_pos = start_pos + move_dir

func _process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_dir
		else:
			target_pos = start_pos


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
