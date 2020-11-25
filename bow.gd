extends Node2D

export var distance : float = 9
export var fire_force : float = 50
export var max_arrows : int = 30
export var sprites_path : NodePath
var sprites_node : Node2D

export var arrows_path : NodePath
var arrows_node : Node2D
var arrows : Array
var arrow_scene = preload("res://Launched arrow.tscn")
var old_mouse_pos = Vector2()

func _ready():
	sprites_node = get_node(sprites_path)
	assert(sprites_node != null)
	arrows_node = get_node(arrows_path)
	assert(arrows_node != null)
	
	old_mouse_pos = get_local_mouse_position();

func _process(_delta):
	var joy_right_x = Input.get_joy_axis(0, JOY_AXIS_2);
	var joy_right_y = Input.get_joy_axis(0, JOY_AXIS_3);
	var mouse_pos = get_local_mouse_position()
	
	var bow_relative_pos : Vector2;
	
	if abs(joy_right_x) > .4 || abs(joy_right_y) > .4:
		bow_relative_pos = Vector2(joy_right_x, joy_right_y).normalized()
	elif old_mouse_pos != mouse_pos :
		old_mouse_pos = mouse_pos
		bow_relative_pos = mouse_pos.normalized()
	else :
		if Input.is_action_just_pressed("shoot"):
			bow_relative_pos = mouse_pos.normalized()
		else:
			return
	
	bow_relative_pos *= distance
	
	sprites_node.position = bow_relative_pos
	sprites_node.rotation = bow_relative_pos.angle()
	
	if Input.is_action_just_pressed("shoot"):
		shoot_arrow(bow_relative_pos)

func shoot_arrow(bow_relative_pos : Vector2):
	var arrow = arrow_scene.instance()
	arrow.position = get_parent().position + position + bow_relative_pos
	arrow.rotation = bow_relative_pos.angle()
	arrow.apply_central_impulse(bow_relative_pos * fire_force)
	
	arrows_node.add_child(arrow)
	arrows.append(arrow)
	if arrows.size() > max_arrows:
		var removed_arrow = arrows[0]
		arrows.remove(0)
		arrows_node.remove_child(removed_arrow)
