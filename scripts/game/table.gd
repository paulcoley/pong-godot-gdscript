extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var p1_score = 0
var p2_score = 0
export(int) var victory_score = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var global_variables = get_node("/root/Global")
	var ai_paddle = get_node("paddle2")
	ai_paddle.set_ai(global_variables.is_ai_match)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_left_goal_body_entered(body):
	if body.name.nocasecmp_to("ball") == 0:
		body.reset_position()
		p2_score += 1
		var label = get_node_or_null("UI/p2_score")
		label.text = str(p2_score)
		victory_check()


func _on_right_goal_body_entered(body):
	if body.name.nocasecmp_to("ball") == 0:
		body.reset_position()
		p1_score += 1
		var label = get_node_or_null("UI/p1_score")
		label.text = str(p1_score)
		victory_check()


func victory_check():
	var p1_victory = p1_score >= victory_score
	var p2_victory = p2_score >= victory_score
	
	if p1_victory || p2_victory:
		var ball = get_node_or_null("ball")
		ball.speed = 0
		
		var mvictory = get_node_or_null("UI/victory_message")
		var bgame_over = get_node_or_null("UI/bgame_over")
		
		if p1_victory:
			mvictory.text = "Player 1 won!"
		else:
			mvictory.text = "Player 2 won!"
		
		mvictory.show()
		bgame_over.show()


func _on_bgame_over_pressed():
		get_tree().change_scene("res://scenes/ui/main_menu.tscn")
