extends Camera2D

func _ready():
	var viewport = get_viewport_rect().size / 1024
	var zoom_factor = min(viewport.x, viewport.y)
	zoom = Vector2(zoom_factor, zoom_factor)
