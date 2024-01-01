extends CharacterBody2D

@export var speed: int = 35
@onready var anim_player = $AnimationPlayer
func handleInput() -> void:
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction * speed

func updateAnimation() -> void:
	if velocity.length() == 0:
		anim_player.stop()
		return
	var direction = ""
	if velocity.x != 0:
		direction = "left" if velocity.x < 0 else "right"
	if velocity.y != 0:
		direction = "up" if velocity.y < 0 else "down"
	anim_player.play("walk_" + direction)
	
func _physics_process(delta) -> void:
	handleInput()
	move_and_slide()
	updateAnimation()
