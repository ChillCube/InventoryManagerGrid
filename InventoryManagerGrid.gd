@tool
extends GridArranger2D
class_name InventoryManagerGrid2D

@export var inventory : Inventory:
	set(val):
		inventory = val;
		if length > 0:
			grid_height = max(min_grid_height, ceili(inventory.get_total_count() / float(length)));
@export var frame_sprite : Texture2D
@export var number_source : NumberResource
@export var min_grid_height : int = 0
@export var length : int:
	set(val):
		length = val;
		grid_length = val;
		if inventory and length > 0:
			grid_height = max(min_grid_height, ceili(inventory.get_total_count() / float(length)));

func override_slot_class(val : String) -> String:
	return "InventoryFrame2D"

func adding_child(child: Node, id: int) -> void:
	pass

func child_modifyer(child : Node2D) -> Node2D:
	child.set("texture", frame_sprite);
	child.set("inventory", inventory);
	child.number_source = number_source
	return child;

func child_modifyer_after_creation(child : Node2D) -> Node2D:
	child.set("slot", child.get_index());
	return child;

func _ready():
	super();
	grid_height = max(min_grid_height, ceili(inventory.get_total_count() / float(length)));
