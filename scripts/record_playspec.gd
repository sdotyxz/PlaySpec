# PlaySpec 视频录制脚本 - 自动旋转版本
# 录制相机测试场景，相机会自动旋转展示

extends SceneTree

const SCENE_PATH := "res://test/camera_test_scene.tscn"
const RECORDING_DURATION := 30.0  # 录制30秒

func _init():
	print("🎬 Starting PlaySpec video recording with auto-rotation...")
	
	var scene_resource = load(SCENE_PATH)
	if scene_resource == null:
		push_error("Failed to load scene: " + SCENE_PATH)
		quit()
		return
	
	var scene = scene_resource.instantiate()
	root.add_child(scene)
	
	# 等待场景稳定
	await process_frame
	await process_frame
	await process_frame
	
	# 启用相机自动旋转模式（调用方法而非设置meta）
	var camera = scene.get_node_or_null("Camera")
	if camera and camera.has_method("enable_auto_rotate"):
		camera.enable_auto_rotate()
		print("   ✓ Auto-rotation enabled on camera")
	else:
		print("   ⚠ Camera not found or auto-rotate not available")
	
	print("   ✓ Scene loaded, recording started")
	print("   Duration: " + str(RECORDING_DURATION) + " seconds")
	
	# 录制指定时长
	await create_timer(RECORDING_DURATION).timeout
	
	print("   ✓ Recording complete")
	quit()
