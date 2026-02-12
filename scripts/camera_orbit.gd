extends Camera3D

# Camera orbit parameters
var distance: float = 17.32  # Distance from center (√(10²+10²+10²) = √300 ≈ 17.32)
var current_angle: float = 0.0  # Horizontal rotation angle in radians
var target_angle: float = 0.0   # Target angle for smooth interpolation
var is_dragging: bool = false
var drag_start_pos: Vector2

# Configuration
const ROTATION_SPEED: float = 0.005  # Mouse sensitivity
const ZOOM_SPEED: float = 2.0        # Scroll wheel sensitivity
const MIN_SIZE: float = 5.0          # Minimum orthographic size
const MAX_SIZE: float = 30.0         # Maximum orthographic size
const SMOOTHING: float = 10.0        # Interpolation speed for smooth rotation

func _ready():
	# Set initial camera position at (10, 10, 10)
	position = Vector3(10, 10, 10)
	
	# Calculate initial angle based on position
	current_angle = atan2(position.x, position.z)
	target_angle = current_angle
	
	# Ensure camera looks at center
	look_at(Vector3.ZERO, Vector3.UP)
	
	# Set initial orthographic size
	size = 10.0

func _input(event):
	# Handle mouse button press/release
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			if is_dragging:
				drag_start_pos = event.position
		
		# Handle scroll wheel for zoom
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			size = clamp(size - ZOOM_SPEED, MIN_SIZE, MAX_SIZE)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			size = clamp(size + ZOOM_SPEED, MIN_SIZE, MAX_SIZE)
	
	# Handle mouse motion while dragging
	elif event is InputEventMouseMotion and is_dragging:
		var delta_x = event.relative.x
		target_angle -= delta_x * ROTATION_SPEED

func _process(delta):
	# Smoothly interpolate current angle to target angle
	current_angle = lerp(current_angle, target_angle, SMOOTHING * delta)
	
	# Calculate new position maintaining 45-degree elevation
	# Keep the same distance but rotate around Y axis
	var x = distance * sin(current_angle) * 0.577  # 0.577 ≈ 1/√3 to maintain 45° angle
	var y = distance * 0.577  # Height component (sin(45°) ≈ 0.707, but we need to maintain ratio)
	var z = distance * cos(current_angle) * 0.577
	
	# Position at (10, 10, 10) equivalent distance with rotation
	# Distance from origin = √(10² + 10² + 10²) = √300 ≈ 17.32
	# For 45° angle: y = distance * sin(45°), xz plane distance = distance * cos(45°)
	var horizontal_dist = sqrt(200.0)  # Distance in XZ plane = √(10² + 10²) = √200 ≈ 14.14
	
	position.x = horizontal_dist * sin(current_angle + PI/4)
	position.y = 10.0  # Maintain constant height for 45° angle
	position.z = horizontal_dist * cos(current_angle + PI/4)
	
	# Always look at center
	look_at(Vector3.ZERO, Vector3.UP)
