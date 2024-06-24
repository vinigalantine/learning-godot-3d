extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

func initialize(start_position, player_position):
	#Place mob and rotate it towards the player
	look_at_from_position(start_position, player_position, Vector3.UP)
	#Rotate randomly within range of -45 and +45, to not move directly towards the player
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	#Calc random speed
	var random_speed = randi_range(min_speed, max_speed)
	#Calc forward speed
	velocity = Vector3.FORWARD * random_speed
	#Rotate velocity vector based on mob's Y
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	$AnimationPlayer.speed_scale = random_speed / min_speed

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func squash():
	squashed.emit()
	queue_free()
