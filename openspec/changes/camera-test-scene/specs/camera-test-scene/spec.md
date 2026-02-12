## ADDED Requirements

### Requirement: 场景包含中心参照立方体
测试场景 SHALL 在中心位置(0, 0, 0)包含一个可见的3D立方体作为参照物。

#### Scenario: 立方体可见性
- **WHEN** 场景被加载
- **THEN** 立方体显示在场景中心(0, 0, 0)
- **AND** 立方体在所有视角下清晰可见

### Requirement: 相机使用正交投影
相机 SHALL 配置为正交投影模式(Orthographic projection)。

#### Scenario: 正交投影验证
- **WHEN** 场景运行时
- **THEN** 相机投影模式设置为ORTHOGRAPHIC
- **AND** 平行线在渲染中保持平行

### Requirement: 相机设置为45度俯视角度
相机 SHALL 位于45度俯视角度，能够看到立方体的顶面和侧面。

#### Scenario: 默认相机角度
- **WHEN** 场景初始化完成
- **THEN** 相机位于(10, 10, 10)位置(相对于立方体)
- **AND** 相机朝向中心点(0, 0, 0)
- **AND** 俯视角度约为45度

### Requirement: 相机可以围绕立方体旋转
用户 SHALL 能够控制相机围绕中心立方体旋转查看。

#### Scenario: 鼠标拖拽旋转
- **WHEN** 用户按住鼠标左键并拖拽
- **THEN** 相机围绕中心点水平旋转
- **AND** 相机保持恒定距离和俯视角度

#### Scenario: 滚轮缩放
- **WHEN** 用户使用鼠标滚轮
- **THEN** 正交相机的视口大小(SIZE)相应调整
- **AND** 立方体显示大小随之变化

### Requirement: 场景包含基础光照
场景 SHALL 包含必要的光照以确保立方体可见。

#### Scenario: 默认光照配置
- **WHEN** 场景加载时
- **THEN** 存在至少一个DirectionalLight3D光源
- **AND** 立方体表面可见且有阴影/明暗对比

### Requirement: 相机旋转控制平滑
相机旋转 SHALL 响应及时且平滑，无卡顿或延迟。

#### Scenario: 流畅的相机运动
- **WHEN** 用户持续拖拽鼠标旋转相机
- **THEN** 相机运动以60 FPS流畅更新
- **AND** 无可见的抖动或延迟
