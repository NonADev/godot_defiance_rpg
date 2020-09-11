extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
const MAX_SPEED = 80
const ACCELERATION = 500
const FRICCTION = 500
var motion = Vector2.ZERO

enum {
	MOVE,
	ROLL,
	ATTACK
}


func _ready():
	animationTree.active = true


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	print(animationTree.get("parameters/Idle/blend_position"))
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		
		animationState.travel("Run")
		motion = motion.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, FRICCTION * delta)
	
	motion = move_and_slide(motion)
