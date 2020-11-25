extends KinematicBody2D

export var health : float = 3

func hit(dmg: float):
	health -= dmg
	if health <= 0:
		die()

func die():
	print("Ueaaaaargh")
