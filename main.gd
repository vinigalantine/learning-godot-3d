extends Node

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/Retry.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	#Ramdom location
	var mob_spawn_location = get_node("SpawnPath/SpwanLocation")
	#Ramdom offset
	mob_spawn_location.progress_ratio = randf()
	
	
	var player_position  = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	#Spawn
	add_child(mob)
	
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())

func _on_player_hit():
	$MobTimer.stop() # Replace with function body.
	$UserInterface/Retry.show()	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
