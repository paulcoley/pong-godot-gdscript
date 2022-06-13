extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Controller {
	PLAYER_1,
	PLAYER_2,
	AI,
}

export (Controller) var current_controller
export(float, 1000) var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var up_p1 = Input.is_action_pressed("player_1_up")
	var up_p2 = Input.is_action_pressed("player_2_up")
	var down_p1 = Input.is_action_pressed("player_1_down")
	var down_p2 = Input.is_action_pressed("player_2_down")
	
	match current_controller:
		Controller.AI:
			move_to_ball(delta)
		Controller.PLAYER_1:
			if up_p1:
				move_and_collide(delta * speed * Vector2(0, -1))
			elif down_p1:
				move_and_collide(delta * speed * Vector2(0, 1))
		Controller.PLAYER_2:
			if up_p2:
				move_and_collide(delta * speed * Vector2(0, -1))
			elif down_p2:
				move_and_collide(delta * speed * Vector2(0, 1))


func set_ai(has_ai):
	if has_ai:
		current_controller = Controller.AI


func move_to_ball(delta):
	var ball = get_node("/root/table/ball")
	if ball:
		var ball_pos = ball.position.y
		var vertical_extent = self.get_node("CollisionShape2D").shape.extents.y
		if ball_pos < self.position.y - vertical_extent:
			move_and_collide(delta * speed * Vector2(0, -1))
		elif ball_pos > self.position.y + vertical_extent:
			move_and_collide(delta * speed * Vector2(0, 1))
