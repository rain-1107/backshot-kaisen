extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimatedSprite2D/AnimationPlayer

enum {
	MOVING,
	ATTACKING
}

var state = MOVING

func _physics_process(delta):
	match state:
		MOVING:
			# Add the gravity.
			if not is_on_floor():
				velocity.y += gravity * delta
			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
			if Input.is_action_just_pressed("attack_light") and is_on_floor():
				state = ATTACKING
			var direction = Input.get_axis("move_left", "move_right")
			if direction:
				velocity.x = direction * SPEED
				animated_sprite_2d.play("walking")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				animated_sprite_2d.play("idle")
			move_and_slide()
		ATTACKING:
			animation_player.play("attack_light")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack_light":
		state = MOVING
