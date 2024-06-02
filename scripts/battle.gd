extends Node2D


const MAX_HEALTH = 10
var enemy_health = MAX_HEALTH
var last_key = 1

@onready var health = $Health
@onready var key = $Key

var key_list = [KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9]

# Called when the node enters the scene tree for the first time.
func _ready():
	key_list.shuffle()
	var key1 = change_key("key1", key_list[0])
	var key2 = change_key("key2", key_list[1])
	key.text = key1 + " " + key2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("key1") and last_key == 2:
		enemy_health -= 1
		last_key = 1
	if Input.is_action_just_pressed("key2") and last_key == 1:
		enemy_health -= 1
		last_key = 2
	if enemy_health < 0:
		enemy_health = MAX_HEALTH
		key_list.shuffle()
		var key1 = change_key("key1", key_list[0])
		var key2 = change_key("key2", key_list[1])
		key.text = key1 + " " + key2
	health.text = str(enemy_health)

func change_key(action_name, key_code):
	var key = InputEventKey.new()
	key.keycode = key_code
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, key)
	return OS.get_keycode_string(key_code)
