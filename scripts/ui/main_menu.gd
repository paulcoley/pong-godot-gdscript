extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello Main Menu!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BExit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_BPlay_pressed():
	var global_variables = get_node("/root/Global")
	global_variables.is_ai_match = false
	get_tree().change_scene("res://scenes/game/table.tscn")


func _on_BPlayAI_pressed():
	var global_variables = get_node("/root/Global")
	global_variables.is_ai_match = true
	get_tree().change_scene("res://scenes/game/table.tscn")
