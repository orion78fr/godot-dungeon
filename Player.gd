extends KinematicBody2D

export var move_speed : float = 120
export var anim_idle : String = "idle"
export var anim_running : String = "run"

export var sprite_path : NodePath
var sprite_node : AnimatedSprite

func _ready():
	sprite_node = get_node(sprite_path)
	assert(sprite_node != null)

func _physics_process(_delta):
	var joy_left_x = Input.get_joy_axis(0, JOY_AXIS_0);
	var joy_left_y = Input.get_joy_axis(0, JOY_AXIS_1);
	
	var motion : Vector2;
	
	if abs(joy_left_x) > .2 || abs(joy_left_y) > .2:
		motion = Vector2(joy_left_x, joy_left_y)
	else:
		motion = Vector2(0,0)
		
		if Input.is_action_pressed("move_left"):
			motion.x -= 1
		if Input.is_action_pressed("move_right"):
			motion.x += 1
		if Input.is_action_pressed("move_up"):
			motion.y -= 1
		if Input.is_action_pressed("move_down"):
			motion.y += 1
		
	motion = motion.normalized()
	
	#Engine.time_scale = min(motion.length()+.1, 1)
	
	motion *= move_speed
	
	move_and_slide(motion)
	
	if motion.length() != 0:
		sprite_node.play(anim_running)
	else:
		sprite_node.play(anim_idle)
	
	if motion.x > 0:
		sprite_node.flip_h = false
	elif motion.x < 0:
		sprite_node.flip_h = true
