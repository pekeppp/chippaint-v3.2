# 芯绘 · CHIPPAINT v3.2

**基于 RISC-V 与 FPGA 异构架构的 2D 图形渲染加速引擎**

图形渲染的核心负载是像素搬运：精灵合成与逐帧重绘由大量规则的位块操作构成。本作品在 Efinix
Titanium Ti60 FPGA 上实现一枚挂载于 AXI4 总线的 2D 位块传输（BitBlt）加速引擎，把逻辑与像素
分开：RISC-V 只负责游戏逻辑与指令下发，而像素级的搬运、Alpha 混合、色键抠图与区域裁剪全部由
硬件流水线完成。上屏用三缓冲轮转取代整帧拷贝，最耗带宽的一步被移出关键路径；显示输出侧以两倍
上采样加颜色查找表，把 960×540 的帧缓冲推到 1920×1080 而带宽不增。

引擎由 **12 个自研 RTL 模块**构成，配套 **24 个 testbench** 的回归体系、两套可上板演示固件与一份
完整设计报告。

## 特性

- **12 个自研 RTL 模块**，以 AXI4 从机接入 SoC，AXI4-Lite 寄存器组下发命令与属性。
- **绘制收敛到唯一出口**：指令与属性严格配对，从机制上排除错配。
- **像素流水线硬件化**：搬运、填充、Alpha 混合、色键抠图、区域裁剪。
- **三缓冲轮转上屏**：取代整帧拷贝；"清屏不破坏正在上屏的缓冲"由硬件互斥保证。
- **2× 上采样 + CLUT**：规格提升不带来带宽增量。
- **可量化**：同屏元素全部由硬件绘制，可自动爬坡压测极限。

## 目录结构

| 路径 | 说明 |
| --- | --- |
| `docs/` | 《芯绘CHIPPAINT_设计报告》Word + PDF |
| `rtl/` | 加速器 RTL，12 个自研模块 |
| `rtl/tb/` | 24 个 testbench、AXI 从机存储模型、`run_regress.ps1` 回归脚本 |
| `release/FinalDemo/` | 综合演示固件（C，Eclipse CDT 工程 + makefile） |
| `release/GameDemo/` | 弹幕游戏演示固件（C） |
| `release/*.hex` | 两份预编译 SoC 固件镜像（v3.2） |
| `tools/serial_console.html` | Web 串口上位机，纯 HTML，浏览器直接打开 |
| `tools/game_console1.html` | GameDemo 弹幕游戏上位机（计算机键盘 → 串口 → FPGA） |
| `ARC_2DRA/rtl/` | SoC 顶层 `ddr3_example_top.v`、DDR3 控制器、`video/` 视频通路、`blt/` 加速器包装、存储测试 |
| `ARC_2DRA/par/ddr_demo_ti60/` | Efinix Efinity 工程：工程 XML、IP、DDR3 约束、嵌入式软件 BSP、`outflow/` 综合布线全套产物 |

## 硬件平台

| 项 | 值 |
| --- | --- |
| FPGA | Efinix Titanium **Ti60F225**（时序模型 I3） |
| 工具链 | Efinity **2026.1.132** |
| 顶层模块 | `ddr3_example_top` |
| 帧缓冲 | DDR3，960×540×16 bpp RGB565（行 stride 1920 B） |
| 输出 | 2× 上采样 + CLUT → 1920×1080 |
| 总线 | AXI4（数据通道）/ AXI4-Lite（寄存器） |

## 仿真

需要 Icarus Verilog（`iverilog` / `vvp`，可用 oss-cad-suite）。`rtl/tb/run_regress.ps1` 开头把 PATH
指向 `C:\oss-cad-suite\bin`，按本机路径改一行即可。

```powershell
cd rtl\tb
powershell -NoProfile -ExecutionPolicy Bypass -File .\run_regress.ps1
```

回归包含若干 A/B 对照项（`-DPIXEL_PACK_PINGPONG_OFF`、`-DWR_CMD_END_FLUSH_OFF`、
`-DBLT_WR_ORDER_OFF` 等），用于复现被推翻的旧结论与已修 Bug。产物（`sim_*.vvp`、`log_*.txt`、
`compile_*.txt`）落在当前目录。

## 综合与烧录

用 Efinity 打开 `ARC_2DRA/par/ddr_demo_ti60/ddr_demo_ti60.xml`，Run 完整流程。仓库中保留了完整
`outflow/`，可直接取用：

- `ddr_demo_ti60.bit` — FPGA 比特流
- `ddr_demo_ti60.hex` — 配置镜像
- `ddr_demo_ti60.timing.rpt`、`ddr_demo_ti60.hier_util.rpt`、`ddr_demo_ti60.route.rpt` — 时序 / 资源 / 布线报告
- `*.map.v` — 门级网表

## 上板演示

1. 烧录 `ARC_2DRA/par/ddr_demo_ti60/outflow/ddr_demo_ti60.bit`。
2. 用 Chrome / Edge 打开 `tools/serial_console.html`（Web Serial，需串口权限），连上板卡串口。
3. 游戏演示：打开 `tools/game_console1.html`，计算机键盘输入经串口送入 FPGA，画面由硬件绘制，板载按键一个都不用。

## 关于仓库体积

本仓库刻意保留了完整的综合、布局布线与时序产物（`outflow/` 约 735 MB，其中 60 余个演示固件 hex
与门级网表占大头），因此总体积接近 800 MB，克隆会比较慢。**只想读设计的话，`rtl/`、
`ARC_2DRA/rtl/`、`docs/` 三处就够了**，其余是打包产物。

## 许可

Efinix BSP、IP 与参考设计部分遵循其原始许可（见各文件头）。自研 RTL、固件与文档版权归作者所有。
