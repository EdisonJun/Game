extends CharacterBody2D

@export var move_speed : float = 150

@export var animator : AnimatedSprite2D

var is_game_over : bool = false

@export var bullet_scene : PackedScene
# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		$Runing.stop()
	elif not $Runing.playing:
		$Runing.play()
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity = move_speed * Input.get_vector("Left", "Right", "Up", "Down")
		
		if velocity == Vector2.ZERO:
			animator.play("Idle")
		else:
			animator.play("Run")
		
		move_and_slide()
	
		
func game_over():
	if not is_game_over:
		
		is_game_over = true
		animator.play("Dead")
		
		get_tree().current_scene.show_game_over()
		
		$"Game Over".play()
		
		$RestartTimer.start()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return 
		
	$FireSound.play()
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(75, 25)
	get_tree().current_scene.add_child(bullet_node)
	print("fire")


func _reload_sence() -> void:
	get_tree().reload_current_scene() # Replace with function body.
