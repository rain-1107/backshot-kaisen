extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var last_direction = Vector2(0, 0)

@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.1)
	if direction == Vector2(0, 0):
		if abs(last_direction.x) > abs(last_direction.y):
			animated_sprite_2d.flip_h = last_direction.x < 0
			animated_sprite_2d.play("idle_horizontal")
		elif last_direction.y > 0:
			animated_sprite_2d.play("idle_down")
		else:
			animated_sprite_2d.play("idle_up")
	else:
		self.velocity = direction * SPEED
		move_and_slide()
		if abs(direction.x) > abs(direction.y):
			animated_sprite_2d.flip_h = direction.x < 0
			animated_sprite_2d.play("walking_horizontal")
		elif direction.y > 0:
			animated_sprite_2d.play("walking_down")
		else:
			animated_sprite_2d.play("walking_up")
		last_direction = direction
