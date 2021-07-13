extends KinematicBody2D

var dir
export var SIZE = 125
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Actions {
	Turn,
	Move
}
var input_buffer
# Called when the node enters the scene tree for the first time.
func _ready():
	dir = -1
	input_buffer = []
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	var action = null
	if len(input_buffer)>0:
		action = input_buffer.pop_back()
	
	if action != null:
		if action == Actions.Turn:
			dir *= -1
		step()

func _input(event):
	var stepped = false
	if event.is_action_pressed("space"):
		input_buffer.push_front(Actions.Move)
	elif event.is_action_pressed("ctrl"):
		input_buffer.push_front(Actions.Turn)
		
		
			
func step():
	var col = test_move(transform, Vector2(dir * (SIZE-25), -SIZE))
	translate(Vector2(dir * (SIZE-25), -SIZE))
	get_tree().root.get_node("Node2D/Steps").stepped()
	if not col:
		get_tree().quit()
	
