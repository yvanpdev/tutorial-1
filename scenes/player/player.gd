extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser
signal grenade

func _process(_delta: float) -> void:
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		print("shoot laser")
		can_laser = false
		$LaserReloadTimer.start()
		laser.emit()
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		print("shoot grenade")
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade.emit()
		
func _on_laser_reload_timer_timeout() -> void:
	can_laser = true
	
func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
	
