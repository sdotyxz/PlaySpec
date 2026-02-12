## Why

需要一个专门的测试场景来验证Godot中正交相机的渲染行为和视觉效果。当前的开发流程中缺乏标准化的相机测试环境，导致相机参数调整时需要反复在真实场景中验证。

## What Changes

- 创建一个新的Godot场景文件 `test/camera_test_scene.tscn`
- 场景中心放置一个可见的3D立方体作为参照物
- 配置正交投影相机(Orthographic Camera)
- 相机设置45度俯视角度
- 实现相机围绕立方体旋转的控制逻辑
- 添加基础光照以确保立方体可见

## Capabilities

### New Capabilities

- `camera-test-scene`: 3D相机测试场景，包含正交投影相机配置和立方体参照物

### Modified Capabilities

<!-- 无修改现有能力 -->

## Impact

- 新增测试场景文件
- 可能新增相机控制脚本
- 无API变更
- 无依赖变更
- 仅用于开发和测试，不影响生产代码
