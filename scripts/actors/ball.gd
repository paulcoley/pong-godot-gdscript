extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction
export(float, 1000) var speed
var rng = RandomNumberGenerator.new()
var start_pos
var bop_sound = preload("res://sounds/game/bop.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	random_direction()
	start_pos = self.position


func _physics_process(delta):
	var movement_vector = delta * speed * direction
	var collision = move_and_collide(movement_vector)
	if collision:
		direction = direction.bounce(collision.normal)
		$AudioStreamPlayer.stream = bop_sound
		$AudioStreamPlayer.play()


func random_direction():
	var x_dir = 0
	var y_dir = 0
	
	while x_dir == 0:
		x_dir = rng.randi_range(-1, 1)
	
	while y_dir == 0:
		y_dir = rng.randi_range(-1, 1)
	
	direction = Vector2(x_dir, y_dir).normalized()


func reset_position():
	self.position = start_pos
	random_direction()
