extends CharacterBody3D

var move_speed: float = 4.0
var jump_force: float = 8.0
var gravity: float = 20.0

var score: float

var facing_angle: float

@onready var model : MeshInstance3D = get_node("CharacterVampire")
@onready var score_label: Label = get_node("Label")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_pressed("jump"):
		velocity.y = jump_force
	
	var input = Input.get_vector("move_left", "move_right", 'move_forward', "move_backward")
	
	velocity.x = input.x * move_speed
	velocity.z = input.y * move_speed
	
	move_and_slide()
	
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()
	
	# model.rotation.y = facing_angle
	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)
	
	if global_position.y < -5:
		game_over()

func game_over():
	get_tree().reload_current_scene()

func add_score(amount):
	score += amount
	score_label.text = str("Score: ", score)
