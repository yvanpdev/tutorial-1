extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta: float) -> void:
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
	
	
	# laser shooting input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start()
		$GPUParticles2D.emitting = true
		laser.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var grenade_position = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade.emit(grenade_position, player_direction)
		
func _on_laser_reload_timer_timeout() -> void:
	can_laser = true
	
func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
	
