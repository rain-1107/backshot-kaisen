extends CanvasLayer

@onready var player_battle = %PlayerBattle
@onready var health_bar = $MarginContainer/HBoxContainer/VBoxContainer/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	player_battle.health_changed.connect(update_health_bar)
	update_health_bar()
	

func update_health_bar():
	health_bar.value = player_battle.health
