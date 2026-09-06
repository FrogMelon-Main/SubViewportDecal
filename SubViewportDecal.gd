@tool
@icon("SubViewportDecal.svg")
extends Decal
class_name SubViewportDecal

##[color=yellow]Warning:[/color] SubViewport sizes larger than 512 x 512 may decrease performance on weaker hardware.[br]
## @experimental

@export var update_in_editor: bool = false
@export var source_viewport: SubViewport:
	set(value):
		source_viewport = value

		if is_inside_tree():
			call_deferred("_initialize_texture")
@export_range(1, 60, 1) var update_frame_break: int = 2

var subviewport_texture: ImageTexture
var frame_counter := 0
var updating := false


func _ready() -> void:
	if source_viewport:
		source_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		call_deferred("_initialize_texture")


func _process(_delta: float) -> void:
	if not source_viewport:
		return

	if Engine.is_editor_hint():
		var focused := get_window().has_focus()

		if not focused:
			source_viewport.render_target_update_mode = SubViewport.UPDATE_DISABLED
			return

		source_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

		if not update_in_editor:
			return

	frame_counter += 1

	if frame_counter < update_frame_break:
		return

	frame_counter = 0

	if not updating:
		_update_texture()


func _initialize_texture() -> void:
	if not source_viewport:
		texture_albedo = null
		subviewport_texture = null
		return

	if Engine.is_editor_hint() and not update_in_editor:
		return

	if Engine.is_editor_hint() and not get_window().has_focus():
		return

	updating = true

	await RenderingServer.frame_post_draw

	if Engine.is_editor_hint() and not get_window().has_focus():
		updating = false
		return

	if not is_instance_valid(source_viewport):
		updating = false
		return

	var image := source_viewport.get_texture().get_image()

	if image.is_empty():
		updating = false
		return

	subviewport_texture = ImageTexture.create_from_image(image)
	texture_albedo = subviewport_texture

	updating = false


func _update_texture() -> void:
	if not source_viewport:
		return

	if Engine.is_editor_hint() and not get_window().has_focus():
		return

	if not subviewport_texture:
		_initialize_texture()
		return

	updating = true

	await RenderingServer.frame_post_draw

	if Engine.is_editor_hint() and not get_window().has_focus():
		updating = false
		return

	if not is_instance_valid(source_viewport):
		updating = false
		return

	var image := source_viewport.get_texture().get_image()

	if image.is_empty():
		updating = false
		return

	subviewport_texture.set_image(image)

	updating = false
