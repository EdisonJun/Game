extends Area2D

@export var slime_speed : float = -50

var slime_killed : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not slime_killed:
		position += Vector2(slime_speed, 0) * delta


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not slime_killed: 
		print("hit player")
		body.game_over()


func _on_bullet_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		slime_killed = true
		$AnimatedSprite2D.play("Killed")
		area.queue_free()
		get_tree().current_scene.score += 1
		
		$Monster_Killed.play()
		
		await get_tree().create_timer(0.5).timeout
		queue_free()
