extends CharacterBody2D

@export var speed: int = 35
@export var analog_deadzone: float = 0.2
@onready var anim_player = $AnimationPlayer

func handleInput() -> void:
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	# normalize direction to ensure consistent direction speed in all directions :)
	direction = direction.normalized()
	
	# apply deadzone for controller support
	if direction.length() < analog_deadzone:
		direction = Vector2.ZERO
	
	velocity = direction * speed

func updateAnimation() -> void:
	if velocity.length() == 0:
		if anim_player.is_playing():
			anim_player.stop()
		return
	var direction = ""
	if velocity.x != 0:
		direction = "left" if velocity.x < 0 else "right"
	if velocity.y != 0:
		direction = "up" if velocity.y < 0 else "down"
	anim_player.play("walk_" + direction)
	
func _physics_process(_delta) -> void:
	handleInput()
	move_and_slide()
	updateAnimation()
