extends RigidBody2D

func _ready():
	pass # Replace with function body.

func _on_Launched_arrow_body_entered(body: Node2D):
	if body.name != "Player":
		sleeping = true
		if body.has_method("hit"):
			print("Hit body %s" % body.name)
			body.hit(1)
