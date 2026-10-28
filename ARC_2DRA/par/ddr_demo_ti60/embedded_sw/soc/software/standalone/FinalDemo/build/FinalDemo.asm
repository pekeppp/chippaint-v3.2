
build/FinalDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00007197          	auipc	gp,0x7
    1004:	68818193          	addi	gp,gp,1672 # 8688 <__global_pointer$>

00001008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
    1008:	00043117          	auipc	sp,0x43
    100c:	93810113          	addi	sp,sp,-1736 # 43940 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1010:	00005517          	auipc	a0,0x5
    1014:	11450513          	addi	a0,a0,276 # 6124 <_data>
	la a1, _data
    1018:	00005597          	auipc	a1,0x5
    101c:	10c58593          	addi	a1,a1,268 # 6124 <_data>
	la a2, _edata
    1020:	00007617          	auipc	a2,0x7
    1024:	eac60613          	addi	a2,a2,-340 # 7ecc <g_cmd_t0>
	bgeu a1, a2, 2f
    1028:	00c5fc63          	bgeu	a1,a2,1040 <init+0x38>
1:
	lw t0, (a0)
    102c:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
    1030:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
    1034:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
    1038:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
    103c:	fec5e8e3          	bltu	a1,a2,102c <init+0x24>
2:

	/* Clear bss section */
	la a0, __bss_start
    1040:	00007517          	auipc	a0,0x7
    1044:	e8c50513          	addi	a0,a0,-372 # 7ecc <g_cmd_t0>
	la a1, _end
    1048:	00042597          	auipc	a1,0x42
    104c:	8f058593          	addi	a1,a1,-1808 # 42938 <_end>
	bgeu a0, a1, 2f
    1050:	00b57863          	bgeu	a0,a1,1060 <init+0x58>
1:
	sw zero, (a0)
    1054:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
    1058:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
    105c:	feb56ce3          	bltu	a0,a1,1054 <init+0x4c>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
    1060:	010000ef          	jal	1070 <__libc_init_array>
#endif

	call main
    1064:	0a0000ef          	jal	1104 <main>

00001068 <mainDone>:
mainDone:
    j mainDone
    1068:	0000006f          	j	1068 <mainDone>

0000106c <_init>:


	.globl _init
_init:
    ret
    106c:	00008067          	ret

Disassembly of section .text:

00001070 <__libc_init_array>:
    1070:	ff010113          	addi	sp,sp,-16
    1074:	00812423          	sw	s0,8(sp)
    1078:	01212023          	sw	s2,0(sp)
    107c:	00005797          	auipc	a5,0x5
    1080:	0a878793          	addi	a5,a5,168 # 6124 <_data>
    1084:	00005417          	auipc	s0,0x5
    1088:	0a040413          	addi	s0,s0,160 # 6124 <_data>
    108c:	00112623          	sw	ra,12(sp)
    1090:	00912223          	sw	s1,4(sp)
    1094:	40878933          	sub	s2,a5,s0
    1098:	02878063          	beq	a5,s0,10b8 <__libc_init_array+0x48>
    109c:	40295913          	srai	s2,s2,0x2
    10a0:	00000493          	li	s1,0
    10a4:	00042783          	lw	a5,0(s0)
    10a8:	00148493          	addi	s1,s1,1
    10ac:	00440413          	addi	s0,s0,4
    10b0:	000780e7          	jalr	a5
    10b4:	ff24e8e3          	bltu	s1,s2,10a4 <__libc_init_array+0x34>
    10b8:	00005797          	auipc	a5,0x5
    10bc:	06c78793          	addi	a5,a5,108 # 6124 <_data>
    10c0:	00005417          	auipc	s0,0x5
    10c4:	06440413          	addi	s0,s0,100 # 6124 <_data>
    10c8:	40878933          	sub	s2,a5,s0
    10cc:	40295913          	srai	s2,s2,0x2
    10d0:	00878e63          	beq	a5,s0,10ec <__libc_init_array+0x7c>
    10d4:	00000493          	li	s1,0
    10d8:	00042783          	lw	a5,0(s0)
    10dc:	00148493          	addi	s1,s1,1
    10e0:	00440413          	addi	s0,s0,4
    10e4:	000780e7          	jalr	a5
    10e8:	ff24e8e3          	bltu	s1,s2,10d8 <__libc_init_array+0x68>
    10ec:	00c12083          	lw	ra,12(sp)
    10f0:	00812403          	lw	s0,8(sp)
    10f4:	00412483          	lw	s1,4(sp)
    10f8:	00012903          	lw	s2,0(sp)
    10fc:	01010113          	addi	sp,sp,16
    1100:	00008067          	ret

00001104 <main>:
 *   原来固定成 HALF_H，所以即便单模式给了整屏高度，物块也只在上面 260 行里弹
 *   —— 就是"切到纯 CPU/纯硬件时仍只渲染一半"的原因。 */
static int vrg_h(int path)  { return (path == PATH_SPLIT) ? HALF_H : (FB_HEIGHT - TOP_Y0); }

int main(int argc, char **argv)
{
    1104:	f3010113          	addi	sp,sp,-208
    1108:	0c112623          	sw	ra,204(sp)
    110c:	0c812423          	sw	s0,200(sp)
    1110:	0c912223          	sw	s1,196(sp)
    1114:	0d212023          	sw	s2,192(sp)
    1118:	0b312e23          	sw	s3,188(sp)
    111c:	0b412c23          	sw	s4,184(sp)
    1120:	0b512a23          	sw	s5,180(sp)
    1124:	0b612823          	sw	s6,176(sp)
    1128:	0b712623          	sw	s7,172(sp)
    112c:	0b812423          	sw	s8,168(sp)
    1130:	0b912223          	sw	s9,164(sp)
    1134:	0ba12023          	sw	s10,160(sp)
    1138:	09b12e23          	sw	s11,156(sp)
    int      path  = PATH_HW;          /* ★ 默认：纯硬件整屏 */
    int      scene = SC_FILL;
    int      n     = N_MIN;            /* ★ 默认 N=25 */
    int      n_cmd = N_MIN;            /* '=' 行缓冲结算出的 N（nline_feed 的出口） */
    113c:	01900793          	li	a5,25
    1140:	08f12623          	sw	a5,140(sp)
    /* ★ 三个计数器共用同一个 1Hz 窗口、同一次清零（见 osd_service 调用点）：
     *   hw_frames/cpu_frames 数的是两侧各自的**渲染趟数**，scr_frames 数的是
     *   **整帧 COPY 真正完成的次数** = 上屏帧数 —— 屏幕的流畅度只看最后一个。 */
    uint32_t hw_frames = 0, cpu_frames = 0, scr_frames = 0;
    uint32_t t_scene, t_now = 0;
    int hw_i = 0, hw_frame_pushed = 0;
    1144:	08012423          	sw	zero,136(sp)
     *                 只在"没有翻转在飞"的时刻落地，避免和轮转打架。
     *   split_hw_wait 1 = HW 半区本趟已画完，正在等下一个帧边界（把节奏压到 60Hz） */
    int split_setup = 0, split_hw_wait = 0;
#endif
    /* 快照失效标志：场景位置变过 ⇒ 等本侧下一趟起点再重拍（保证一趟内 tx,ty 恒定） */
    int snap_hw = 0, snap_cpu = 0;
    1148:	08012223          	sw	zero,132(sp)
    114c:	08012023          	sw	zero,128(sp)
    uint32_t back_t0 = 0;

    rect_t vrg;
    vrg.x0 = 0; vrg.y0 = 0; vrg.w = FB_WIDTH; vrg.h = HALF_H;
    1150:	06012823          	sw	zero,112(sp)
    1154:	06012a23          	sw	zero,116(sp)
    1158:	3c000793          	li	a5,960
    115c:	06f12c23          	sw	a5,120(sp)
    1160:	10400793          	li	a5,260
    1164:	06f12e23          	sw	a5,124(sp)

    (void)argc; (void)argv;

    bsp_init();                       /* ★ 必须最先调用：UART 时钟分频在这里配置 */
    1168:	789010ef          	jal	30f0 <bsp_init>

    bsp_printf("\r\n===== FinalDemo: HW accel vs pure CPU, same screen =====\r\n");
    116c:	00007537          	lui	a0,0x7
    1170:	c6c50513          	addi	a0,a0,-916 # 6c6c <_data+0xb48>
    1174:	7ed030ef          	jal	5160 <bsp_printf>
    bsp_printf("FB=%x BACK=%x ATLAS=%x SPR=%dx%d\r\n",
    1178:	8201a703          	lw	a4,-2016(gp) # 7ea8 <g_blk>
    117c:	00070793          	mv	a5,a4
    1180:	002016b7          	lui	a3,0x201
    1184:	00501637          	lui	a2,0x501
    1188:	003015b7          	lui	a1,0x301
    118c:	00007537          	lui	a0,0x7
    1190:	cac50513          	addi	a0,a0,-852 # 6cac <_data+0xb88>
    1194:	7cd030ef          	jal	5160 <bsp_printf>
               (unsigned)FB_BASE, (unsigned)FB_BACK, (unsigned)ATLAS_BASE, SPR_W, SPR_H);
    bsp_printf("blk: %dx%d sprite, runtime-switchable %d/%d/%d (key k cycles 16->32->64->16,\r\n",
    1198:	8201a583          	lw	a1,-2016(gp) # 7ea8 <g_blk>
    119c:	04000793          	li	a5,64
    11a0:	02000713          	li	a4,32
    11a4:	01000693          	li	a3,16
    11a8:	00058613          	mv	a2,a1
    11ac:	00007537          	lui	a0,0x7
    11b0:	cd050513          	addi	a0,a0,-816 # 6cd0 <_data+0xbac>
    11b4:	7ad030ef          	jal	5160 <bsp_printf>
               SPR_W, SPR_H, BLK_LO, BLK_MID, BLK_HI);
    bsp_printf("     atlas rebuilt + scene re-init at every step)\r\n");
    11b8:	00007537          	lui	a0,0x7
    11bc:	d2050513          	addi	a0,a0,-736 # 6d20 <_data+0xbfc>
    11c0:	7a1030ef          	jal	5160 <bsp_printf>
    bsp_printf("layout: info 0-16 | HW 16-276 | sep | CPU 280-540\r\n");
    11c4:	00007537          	lui	a0,0x7
    11c8:	d5450513          	addi	a0,a0,-684 # 6d54 <_data+0xc30>
    11cc:	795030ef          	jal	5160 <bsp_printf>
    bsp_printf("default: path=HW only, clear_per_pass=1, advance=time, N=%d\r\n", n);
    11d0:	01900593          	li	a1,25
    11d4:	00007537          	lui	a0,0x7
    11d8:	d8850513          	addi	a0,a0,-632 # 6d88 <_data+0xc64>
    11dc:	785030ef          	jal	5160 <bsp_printf>
    bsp_printf("cmd: 1/2/3 scene FILL/ALPHA/KEY, s/c/h path SPLIT/CPU/HW\r\n");
    11e0:	00007537          	lui	a0,0x7
    11e4:	dc850513          	addi	a0,a0,-568 # 6dc8 <_data+0xca4>
    11e8:	779030ef          	jal	5160 <bsp_printf>
    bsp_printf("     n or + N+%d, - N-%d, a/A alpha-/+, e clear-per-pass,\r\n", N_STEP, N_STEP);
    11ec:	01900613          	li	a2,25
    11f0:	01900593          	li	a1,25
    11f4:	00007537          	lui	a0,0x7
    11f8:	e0450513          	addi	a0,a0,-508 # 6e04 <_data+0xce0>
    11fc:	765030ef          	jal	5160 <bsp_printf>
    bsp_printf("     =N exact N (%d..%d clamped, e.g. =1375 + Enter),\r\n", N_MIN, N_MAX);
    1200:	00001637          	lui	a2,0x1
    1204:	77060613          	addi	a2,a2,1904 # 1770 <main+0x66c>
    1208:	01900593          	li	a1,25
    120c:	00007537          	lui	a0,0x7
    1210:	e4050513          	addi	a0,a0,-448 # 6e40 <_data+0xd1c>
    1214:	74d030ef          	jal	5160 <bsp_printf>
    bsp_printf("     t time/frame advance, k blk 16/32/64 (cycles), r reset, ? help\r\n");
    1218:	00007537          	lui	a0,0x7
    121c:	e7850513          	addi	a0,a0,-392 # 6e78 <_data+0xd54>
    1220:	741030ef          	jal	5160 <bsp_printf>
    bsp_printf("     l list mode (DDR descriptor table) on/off -- DEFAULT OFF\r\n");
    1224:	00007537          	lui	a0,0x7
    1228:	ec050513          	addi	a0,a0,-320 # 6ec0 <_data+0xd9c>
    122c:	735030ef          	jal	5160 <bsp_printf>
    bsp_printf("       (l takes effect at the next frame boundary, reply: EV dl on/off pending)\r\n");
    1230:	00007537          	lui	a0,0x7
    1234:	f0050513          	addi	a0,a0,-256 # 6f00 <_data+0xddc>
    1238:	729030ef          	jal	5160 <bsp_printf>
    bsp_printf("       DL WATCHDOG: 1 retry/event; a 2nd event within 1s disables list mode\r\n");
    123c:	00007537          	lui	a0,0x7
    1240:	f5450513          	addi	a0,a0,-172 # 6f54 <_data+0xe30>
    1244:	71d030ef          	jal	5160 <bsp_printf>
    bsp_printf("       cost: EV dl list done / EV cmd path done (n=.. cycles=.. cyc/sprite=..)\r\n");
    1248:	00007537          	lui	a0,0x7
    124c:	fa450513          	addi	a0,a0,-92 # 6fa4 <_data+0xe80>
    1250:	711030ef          	jal	5160 <bsp_printf>

    blt_init();
    1254:	374020ef          	jal	35c8 <blt_init>
#if FB_FLIP_PUBLISH
    /* ★ 先与实际在屏的缓冲对齐：FB_STAT[0] = 扫描输出**已经生效**的选择。
     *   不假设复位值 —— 这样"不复位 FPGA 直接重跑程序"也不会把后台缓冲画错
     *   （重跑时上一轮的翻转可能还生效着）。 */
    g_disp_sel = fb_stat_sel();
    1258:	7a9010ef          	jal	3200 <fb_stat_sel>
    125c:	00050793          	mv	a5,a0
    1260:	8ca1ae23          	sw	a0,-1828(gp) # 7f64 <g_disp_sel>
#if FB_TRIPLE_BUFFER
    /* ★v2.7 三缓冲轮转初值：本趟画 disp+1，另一块（disp+2）交给清屏引擎预清。
     *   必须在这里（osd_blit/铺底之前）就把 g_fb_back 定下来，否则信息条会画错缓冲。 */
    g_draw3      = (int)((g_disp_sel + 1u) % 3u);
    1264:	00150513          	addi	a0,a0,1
    1268:	00300493          	li	s1,3
    126c:	02957533          	remu	a0,a0,s1
    1270:	82a1a423          	sw	a0,-2008(gp) # 7eb0 <g_draw3>
    g_clr3       = (int)((g_disp_sel + 2u) % 3u);
    1274:	00278793          	addi	a5,a5,2
    1278:	0297f7b3          	remu	a5,a5,s1
    127c:	82f1a223          	sw	a5,-2012(gp) # 7eac <g_clr3>
    g_clr_need   = 1;                  /* 本趟开始时给清屏引擎下第一条命令 */
    1280:	00100a93          	li	s5,1
    1284:	8d51a623          	sw	s5,-1844(gp) # 7f54 <g_clr_need>
    g_pass_armed = 0;
    1288:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
    g_fb_back    = fb_of_sel((uint32_t)g_draw3);
    128c:	74d010ef          	jal	31d8 <fb_of_sel>
    1290:	82a1a623          	sw	a0,-2004(gp) # 7eb4 <g_fb_back>
#else
    g_fb_back  = fb_of_sel(g_disp_sel ^ 1u);
#endif
#endif
    build_atlas();                    /* 精灵图集：开机按 BLK_LO=16 建（引擎与 CPU 都从这里取数；'k' 会重跑） */
    1294:	63c020ef          	jal	38d0 <build_atlas>
    spr_mask_report();                /* ★S3：图集一重建就报掩码（含"一块都标不上"这种读数） */
    1298:	7f9030ef          	jal	5290 <spr_mask_report>
    cpu_fill32(g_fb_back, 0, 0, FB_WIDTH, FB_HEIGHT, COL_BG);      /* 整屏近黑铺底 */
    129c:	00800793          	li	a5,8
    12a0:	21c00713          	li	a4,540
    12a4:	3c000693          	li	a3,960
    12a8:	00000613          	li	a2,0
    12ac:	00000593          	li	a1,0
    12b0:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    12b4:	6b4020ef          	jal	3968 <cpu_fill32>
    cache_evict();
    12b8:	194020ef          	jal	344c <cache_evict>

    /* ★ 未对齐写入自检：CPU 侧曾因奇数 x 做 32bit 存储而整机静默停死。
     *   这两行能在开机第一秒就暴露该类问题（打印不出来或值不对 = 有问题）。 */
    cpu_fill32(g_fb_back, 33, 500, 8, 2, 0xF800u);
    12bc:	000107b7          	lui	a5,0x10
    12c0:	80078793          	addi	a5,a5,-2048 # f800 <__global_pointer$+0x7178>
    12c4:	00200713          	li	a4,2
    12c8:	00800693          	li	a3,8
    12cc:	1f400613          	li	a2,500
    12d0:	02100593          	li	a1,33
    12d4:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    12d8:	690020ef          	jal	3968 <cpu_fill32>
    cpu_fill32(g_fb_back, 32, 502, 9, 2, 0x07E0u);
    12dc:	7e000793          	li	a5,2016
    12e0:	00200713          	li	a4,2
    12e4:	00900693          	li	a3,9
    12e8:	1f600613          	li	a2,502
    12ec:	02000593          	li	a1,32
    12f0:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    12f4:	674020ef          	jal	3968 <cpu_fill32>
    bsp_printf("aligncheck %x %x %x %x (expect f800 f800 07e0 07e0)\r\n",
               (unsigned)(*(volatile uint16_t *)(g_fb_back + 500u * FB_STRIDE + 33u * 2u)),
    12f8:	82c1a783          	lw	a5,-2004(gp) # 7eb4 <g_fb_back>
    12fc:	000ea737          	lui	a4,0xea
    1300:	64270713          	addi	a4,a4,1602 # ea642 <__freertos_irq_stack_top+0xa6d02>
    1304:	00e78733          	add	a4,a5,a4
    1308:	00075583          	lhu	a1,0(a4)
               (unsigned)(*(volatile uint16_t *)(g_fb_back + 500u * FB_STRIDE + 40u * 2u)),
    130c:	000ea737          	lui	a4,0xea
    1310:	65070713          	addi	a4,a4,1616 # ea650 <__freertos_irq_stack_top+0xa6d10>
    1314:	00e78733          	add	a4,a5,a4
    1318:	00075603          	lhu	a2,0(a4)
               (unsigned)(*(volatile uint16_t *)(g_fb_back + 502u * FB_STRIDE + 32u * 2u)),
    131c:	000eb737          	lui	a4,0xeb
    1320:	54070713          	addi	a4,a4,1344 # eb540 <__freertos_irq_stack_top+0xa7c00>
    1324:	00e78733          	add	a4,a5,a4
    1328:	00075683          	lhu	a3,0(a4)
               (unsigned)(*(volatile uint16_t *)(g_fb_back + 502u * FB_STRIDE + 40u * 2u)));
    132c:	000eb737          	lui	a4,0xeb
    1330:	55070713          	addi	a4,a4,1360 # eb550 <__freertos_irq_stack_top+0xa7c10>
    1334:	00e787b3          	add	a5,a5,a4
    1338:	0007d703          	lhu	a4,0(a5)
    bsp_printf("aligncheck %x %x %x %x (expect f800 f800 07e0 07e0)\r\n",
    133c:	00007537          	lui	a0,0x7
    1340:	ff850513          	addi	a0,a0,-8 # 6ff8 <_data+0xed4>
    1344:	61d030ef          	jal	5160 <bsp_printf>
    bsp_printf("selfcheck: STATUS=%x COUNT=%d SCAN=%x FB=%x DL=%x\r\n",
               (unsigned)blt_stat(), (unsigned)blt_cnt(), (unsigned)blt_rd(BLT_SCAN_DBG),
    1348:	224020ef          	jal	356c <blt_stat>
    134c:	00050b13          	mv	s6,a0
    1350:	200020ef          	jal	3550 <blt_cnt>
    1354:	00050b93          	mv	s7,a0
    1358:	02000513          	li	a0,32
    135c:	66d010ef          	jal	31c8 <blt_rd>
    1360:	00050c13          	mv	s8,a0
               (unsigned)blt_rd(BLT_FB_STAT), (unsigned)blt_rd(BLT_DL_VERSION));
    1364:	02800513          	li	a0,40
    1368:	661010ef          	jal	31c8 <blt_rd>
    136c:	00050c93          	mv	s9,a0
    1370:	08000513          	li	a0,128
    1374:	655010ef          	jal	31c8 <blt_rd>
    1378:	00050793          	mv	a5,a0
    bsp_printf("selfcheck: STATUS=%x COUNT=%d SCAN=%x FB=%x DL=%x\r\n",
    137c:	000c8713          	mv	a4,s9
    1380:	000c0693          	mv	a3,s8
    1384:	000b8613          	mv	a2,s7
    1388:	000b0593          	mv	a1,s6
    138c:	00007537          	lui	a0,0x7
    1390:	03050513          	addi	a0,a0,48 # 7030 <_data+0xf0c>
    1394:	5cd030ef          	jal	5160 <bsp_printf>

    scene_init(n, g_seed, 0);
    1398:	00000613          	li	a2,0
    139c:	81c1a583          	lw	a1,-2020(gp) # 7ea4 <g_seed>
    13a0:	01900513          	li	a0,25
    13a4:	100030ef          	jal	44a4 <scene_init>
    cache_evict();
    13a8:	0a4020ef          	jal	344c <cache_evict>

    /* ★ 信息条开机就画好：先组串 → 落屏 → 再整屏上屏，这样**第一帧**顶上就有读数，
     *   而不是黑条空等一秒。t_now 同时作为 1Hz 统计窗口与场景时间基的起点。 */
    t_now    = tick32();
    13ac:	5f1010ef          	jal	319c <tick32>
    13b0:	00050b93          	mv	s7,a0
    13b4:	04a12223          	sw	a0,68(sp)
    t_scene  = t_now;
    g_osd_t0 = t_now;
    13b8:	8aa1aa23          	sw	a0,-1868(gp) # 7f3c <g_osd_t0>
    osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    13bc:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    13c0:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    13c4:	00000713          	li	a4,0
    13c8:	00100693          	li	a3,1
    13cc:	08000613          	li	a2,128
    13d0:	00000593          	li	a1,0
    13d4:	01900513          	li	a0,25
    13d8:	559020ef          	jal	4130 <osd_build>
    osd_blit(g_osd_line, path_label(path));
    13dc:	00200513          	li	a0,2
    13e0:	381020ef          	jal	3f60 <path_label>
    13e4:	00050593          	mv	a1,a0
    13e8:	8ec18513          	addi	a0,gp,-1812 # 7f74 <g_osd_line>
    13ec:	6b9020ef          	jal	42a4 <osd_blit>
    g_osd_dirty = 0;
    13f0:	8001ac23          	sw	zero,-2024(gp) # 7ea0 <g_osd_dirty>
#if FB_TRIPLE_BUFFER
    /* ★v2.7 三缓冲：显示 A / 画 B / 预清 C。
     *   另外两块（还没画过的那两块）在这里各铺一次底（只此一次），免得显示到 DDR 上电随机值。
     *   ★ 当前绘制的这块（g_fb_back = g_draw3）**不能**再铺一次 —— 上面 osd_blit 已经把
     *     信息条画进去了，再铺会把信息条擦掉。 */
    cpu_fill32(fb_of_sel((uint32_t)((g_draw3 + 1) % 3)), 0, 0, FB_WIDTH, FB_HEIGHT, COL_BG);
    13f4:	8281a503          	lw	a0,-2008(gp) # 7eb0 <g_draw3>
    13f8:	00150513          	addi	a0,a0,1
    13fc:	02956533          	rem	a0,a0,s1
    1400:	5d9010ef          	jal	31d8 <fb_of_sel>
    1404:	00800793          	li	a5,8
    1408:	21c00713          	li	a4,540
    140c:	3c000693          	li	a3,960
    1410:	00000613          	li	a2,0
    1414:	00000593          	li	a1,0
    1418:	550020ef          	jal	3968 <cpu_fill32>
    cpu_fill32(fb_of_sel((uint32_t)((g_draw3 + 2) % 3)), 0, 0, FB_WIDTH, FB_HEIGHT, COL_BG);
    141c:	8281a503          	lw	a0,-2008(gp) # 7eb0 <g_draw3>
    1420:	00250513          	addi	a0,a0,2
    1424:	02956533          	rem	a0,a0,s1
    1428:	5b1010ef          	jal	31d8 <fb_of_sel>
    142c:	00800793          	li	a5,8
    1430:	21c00713          	li	a4,540
    1434:	3c000693          	li	a3,960
    1438:	00000613          	li	a2,0
    143c:	00000593          	li	a1,0
    1440:	528020ef          	jal	3968 <cpu_fill32>
    g_bar_ok[0] = 0; g_bar_ok[1] = 0; g_bar_ok[2] = 0;
    1444:	8c018823          	sb	zero,-1840(gp) # 7f58 <g_bar_ok>
    1448:	8d018793          	addi	a5,gp,-1840 # 7f58 <g_bar_ok>
    144c:	000780a3          	sb	zero,1(a5)
    1450:	00078123          	sb	zero,2(a5)
    g_bar_ok[(uint32_t)g_draw3] = 1;      /* 信息条已经在"本趟要画的那块"里了 */
    1454:	8281a703          	lw	a4,-2008(gp) # 7eb0 <g_draw3>
    1458:	00f707b3          	add	a5,a4,a5
    145c:	01578023          	sb	s5,0(a5)
    g_flip_req = g_disp_sel;              /* 没有在途请求 */
    1460:	8dc1a703          	lw	a4,-1828(gp) # 7f64 <g_disp_sel>
    1464:	8ce1ac23          	sw	a4,-1832(gp) # 7f60 <g_flip_req>
    cache_evict();
    1468:	7e5010ef          	jal	344c <cache_evict>
    bsp_printf("publish: FLIPx3 (disp=%d draw=%d clr=%d, clear-engine on)\r\n",
    146c:	8241a683          	lw	a3,-2012(gp) # 7eac <g_clr3>
    1470:	8281a603          	lw	a2,-2008(gp) # 7eb0 <g_draw3>
    1474:	8dc1a583          	lw	a1,-1828(gp) # 7f64 <g_disp_sel>
    1478:	00007537          	lui	a0,0x7
    147c:	06450513          	addi	a0,a0,100 # 7064 <_data+0xf40>
    1480:	4e1030ef          	jal	5160 <bsp_printf>
    bsp_printf("publish: FLIP (no full-screen COPY; disp_sel=%d FB_SEL=0x%X FB_STAT=0x%X)\r\n",
               (int)g_disp_sel, (unsigned)BLT_FB_SEL, (unsigned)BLT_FB_STAT);
#endif
#if FB_IRQ_PACING
    /* ★v2.7 IRQ 帧节拍：开 FRAME 中断使能（0x14 bit1）。默认关 = 与改动前一致。 */
    blt_wr(BLT_IRQ_EN, blt_rd(BLT_IRQ_EN) | BLT_IRQ_FRAME);
    1484:	01400513          	li	a0,20
    1488:	541010ef          	jal	31c8 <blt_rd>
    148c:	00256593          	ori	a1,a0,2
    1490:	01400513          	li	a0,20
    1494:	525010ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_IRQ_STATUS, BLT_IRQ_FRAME);        /* 先清掉可能已有的挂起 */
    1498:	00200593          	li	a1,2
    149c:	01000513          	li	a0,16
    14a0:	519010ef          	jal	31b8 <blt_wr>
    bsp_printf("pacing: IRQ (frame-boundary IRQ_STATUS[1], IRQ_EN[1] on)\r\n");
    14a4:	00007537          	lui	a0,0x7
    14a8:	0a050513          	addi	a0,a0,160 # 70a0 <_data+0xf7c>
    14ac:	4b5030ef          	jal	5160 <bsp_printf>
    uint32_t back_t0 = 0;
    14b0:	04012023          	sw	zero,64(sp)
    int split_setup = 0, split_hw_wait = 0;
    14b4:	02012223          	sw	zero,36(sp)
    14b8:	00000d93          	li	s11,0
    int hw_done = 0, cpu_done = 0, back_busy = 0;
    14bc:	00000413          	li	s0,0
    14c0:	00012a23          	sw	zero,20(sp)
    14c4:	00012823          	sw	zero,16(sp)
    int size_repaint = 0;
    14c8:	04012a23          	sw	zero,84(sp)
    int repaint_hw = 1, repaint_cpu = 1;
    14cc:	00100793          	li	a5,1
    14d0:	00f12e23          	sw	a5,28(sp)
    14d4:	02f12423          	sw	a5,40(sp)
    int cpu_i = 0;
    14d8:	00000913          	li	s2,0
    int pend_adv = 0;                  /* 帧率模式下攒下的待推步数（慢时间片里结算） */
    14dc:	02012e23          	sw	zero,60(sp)
    int frame_adv = 0;                 /* ★ 't'：0=按墙钟时间推进  1=每发布一帧推进一步 */
    14e0:	00000c13          	li	s8,0
    int clear_pp = 1;                  /* ★ 'e' 默认 ON：每趟整片重铺背景（硬件侧） */
    14e4:	02f12a23          	sw	a5,52(sp)
    int hw_fifo_full = 0;              /* 上一圈 FIFO_COUNT 读满（纯硬件模式下据此低频轮询） */
    14e8:	04012623          	sw	zero,76(sp)
    int hw_i = 0, hw_frame_pushed = 0;
    14ec:	00012c23          	sw	zero,24(sp)
    uint32_t hw_frames = 0, cpu_frames = 0, scr_frames = 0;
    14f0:	02012623          	sw	zero,44(sp)
    14f4:	02012023          	sw	zero,32(sp)
    14f8:	02012c23          	sw	zero,56(sp)
    uint32_t it = 0;
    14fc:	00000993          	li	s3,0
    unsigned alpha = 128u;
    1500:	08000793          	li	a5,128
    1504:	02f12823          	sw	a5,48(sp)
    int      n     = N_MIN;            /* ★ 默认 N=25 */
    1508:	01900c93          	li	s9,25
    int      scene = SC_FILL;
    150c:	00000d13          	li	s10,0
    int      path  = PATH_HW;          /* ★ 默认：纯硬件整屏 */
    1510:	00200493          	li	s1,2
    1514:	6b80106f          	j	2bcc <main+0x1ac8>
        /* ============ 慢时间片（每 32 圈）：UART + 时间 + 场景 + 1Hz 统计 ============
         * ★ 旧版这些工作全在"每圈"里做：1 次 UART 状态读 + 3 次 tick()（每次 3 个
         *   CLINT 寄存器读）= 10 次外设总线事务/圈，占空转期总线事务的绝大部分。
         *   收敛到 1/32 频率后：稳态平均每圈只多 0.03 次总线读。 */
        if ((it & SLOW_MASK) == 0u) {
            int c = uart_poll_char();
    1518:	641020ef          	jal	4358 <uart_poll_char>
    151c:	00050b13          	mv	s6,a0
            t_now = tick32();
    1520:	47d010ef          	jal	319c <tick32>
    1524:	00050b93          	mv	s7,a0

            /* ---------------- 串口命令（交互全部走这里） ---------------- */
            if (c) {
    1528:	080b1a63          	bnez	s6,15bc <main+0x4b8>
            }

            /* ---------------- 场景推进：两种模式互斥 ----------------
             * 时间模式（默认）  ：按墙钟推进，40ms 一步 = 25 步/秒（与帧率无关）。
             * 帧率模式（'t'）   ：目标在"一帧被发布上屏之后"才前进一步 ⇒ 运动锁在帧率上。 */
            vrg.h = vrg_h(path);          /* 虚拟区域跟着路径变（单模式 = 整屏高） */
    152c:	00048513          	mv	a0,s1
    1530:	41d030ef          	jal	514c <vrg_h>
    1534:	06a12e23          	sw	a0,124(sp)
            if (!frame_adv) {
    1538:	540c1663          	bnez	s8,1a84 <main+0x980>
                pend_adv = 0;
                if ((uint32_t)(t_now - t_scene) >= (uint32_t)SCENE_TICKS) {
    153c:	04412783          	lw	a5,68(sp)
    1540:	40fb8733          	sub	a4,s7,a5
    1544:	003d17b7          	lui	a5,0x3d1
    1548:	8ff78793          	addi	a5,a5,-1793 # 3d08ff <__freertos_irq_stack_top+0x38cfbf>
    154c:	4ee7ea63          	bltu	a5,a4,1a40 <main+0x93c>
                pend_adv = 0;
    1550:	03812e23          	sw	s8,60(sp)

            /* ---------------- 1Hz 帧率统计（值没变就不重画信息条） ----------------
             * 调用点先用**更便宜的内联判断**挡一道：没到点一个函数调用都不发。
             * ★ hw/cpu/scr 三个计数在这里**一起清零** ⇒ 三个数字共享同一个窗口，
             *   屏幕上 HW=/CPU=/SCR= 可以直接横向对比。 */
            if (((uint32_t)(t_now - g_osd_t0) >= (uint32_t)BSP_CLINT_HZ) &&
    1554:	8b41a703          	lw	a4,-1868(gp) # 7f3c <g_osd_t0>
    1558:	40eb8733          	sub	a4,s7,a4
    155c:	05f5e7b7          	lui	a5,0x5f5e
    1560:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f1a7bf>
    1564:	00e7e463          	bltu	a5,a4,156c <main+0x468>
    1568:	6740106f          	j	2bdc <main+0x1ad8>
                osd_service(t_now, hw_frames, cpu_frames, scr_frames,
    156c:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    1570:	00f12423          	sw	a5,8(sp)
    1574:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    1578:	00f12223          	sw	a5,4(sp)
    157c:	01812023          	sw	s8,0(sp)
    1580:	03412883          	lw	a7,52(sp)
    1584:	03012803          	lw	a6,48(sp)
    1588:	000d0793          	mv	a5,s10
    158c:	000c8713          	mv	a4,s9
    1590:	02c12683          	lw	a3,44(sp)
    1594:	02012603          	lw	a2,32(sp)
    1598:	03812583          	lw	a1,56(sp)
    159c:	000b8513          	mv	a0,s7
    15a0:	3fd020ef          	jal	419c <osd_service>
            if (((uint32_t)(t_now - g_osd_t0) >= (uint32_t)BSP_CLINT_HZ) &&
    15a4:	00051463          	bnez	a0,15ac <main+0x4a8>
    15a8:	6340106f          	j	2bdc <main+0x1ad8>
                            n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode)) {
                hw_frames = 0; cpu_frames = 0; scr_frames = 0;
    15ac:	03412623          	sw	s4,44(sp)
    15b0:	03412023          	sw	s4,32(sp)
    15b4:	03412c23          	sw	s4,56(sp)
    15b8:	6240106f          	j	2bdc <main+0x1ad8>
                int nl = nline_feed(c, &n_cmd);
    15bc:	08c10593          	addi	a1,sp,140
    15c0:	000b0513          	mv	a0,s6
    15c4:	5c9020ef          	jal	438c <nline_feed>
    15c8:	00050a93          	mv	s5,a0
                if (nl == NL_OK) {
    15cc:	00200793          	li	a5,2
    15d0:	02f50a63          	beq	a0,a5,1604 <main+0x500>
                } else if (nl == NL_ERR) {
    15d4:	fff00793          	li	a5,-1
    15d8:	04f50663          	beq	a0,a5,1624 <main+0x520>
                } else if (nl == NL_NONE) {
    15dc:	3e051863          	bnez	a0,19cc <main+0x8c8>
                    if (c == '1' || c == '2' || c == '3') {
    15e0:	fd5b0793          	addi	a5,s6,-43
    15e4:	04e00713          	li	a4,78
    15e8:	40f76c63          	bltu	a4,a5,1a00 <main+0x8fc>
    15ec:	00279793          	slli	a5,a5,0x2
    15f0:	00008737          	lui	a4,0x8
    15f4:	b0870713          	addi	a4,a4,-1272 # 7b08 <_data+0x19e4>
    15f8:	00e787b3          	add	a5,a5,a4
    15fc:	0007a783          	lw	a5,0(a5)
    1600:	00078067          	jr	a5
                    n = n_cmd;               /* 已在 nline_feed 里钳到 [N_MIN, N_MAX] */
    1604:	08c12c83          	lw	s9,140(sp)
                    bsp_printf("\r\nEV N=%d\r\n", n);     /* 回显**实际生效**的值 */
    1608:	000c8593          	mv	a1,s9
    160c:	00007537          	lui	a0,0x7
    1610:	0dc50513          	addi	a0,a0,220 # 70dc <_data+0xfb8>
    1614:	34d030ef          	jal	5160 <bsp_printf>
                    scene_change = 1; disp_change = 1;
    1618:	00100b13          	li	s6,1
    161c:	00100a93          	li	s5,1
    1620:	3b40006f          	j	19d4 <main+0x8d0>
                    bsp_printf("\r\nEV N=ERR\r\n");       /* 非数字 / 太长 / 空数字 */
    1624:	00007537          	lui	a0,0x7
    1628:	0e850513          	addi	a0,a0,232 # 70e8 <_data+0xfc4>
    162c:	335030ef          	jal	5160 <bsp_printf>
                int disp_change  = 0;    /* 显示内容变了才重画信息条（事件驱动） */
    1630:	00000b13          	li	s6,0
                int scene_change = 0;
    1634:	00000a93          	li	s5,0
    1638:	39c0006f          	j	19d4 <main+0x8d0>
                        scene = (c == '1') ? SC_FILL : ((c == '2') ? SC_ALPHA : SC_KEY);
    163c:	03100793          	li	a5,49
    1640:	00fb0863          	beq	s6,a5,1650 <main+0x54c>
    1644:	03200793          	li	a5,50
    1648:	02fb0463          	beq	s6,a5,1670 <main+0x56c>
    164c:	00200a93          	li	s5,2
                        bsp_printf("\r\nEV scene=%d (0=FILL 1=ALPHA 2=KEY)\r\n", scene);
    1650:	000a8593          	mv	a1,s5
    1654:	00007537          	lui	a0,0x7
    1658:	0f850513          	addi	a0,a0,248 # 70f8 <_data+0xfd4>
    165c:	305030ef          	jal	5160 <bsp_printf>
                        scene = (c == '1') ? SC_FILL : ((c == '2') ? SC_ALPHA : SC_KEY);
    1660:	000a8d13          	mv	s10,s5
                        scene_change = 1; disp_change = 1;
    1664:	00100b13          	li	s6,1
    1668:	00100a93          	li	s5,1
    166c:	3680006f          	j	19d4 <main+0x8d0>
                        scene = (c == '1') ? SC_FILL : ((c == '2') ? SC_ALPHA : SC_KEY);
    1670:	00100a93          	li	s5,1
    1674:	fddff06f          	j	1650 <main+0x54c>
                        disp_change = 1; bsp_printf("\r\nEV path=0 SPLIT\r\n"); }
    1678:	00007537          	lui	a0,0x7
    167c:	12050513          	addi	a0,a0,288 # 7120 <_data+0xffc>
    1680:	2e1030ef          	jal	5160 <bsp_printf>
                        split_setup = 1; split_hw_wait = 0;   /* 原地画：落到"正在显示"的那块上 */
    1684:	03512223          	sw	s5,36(sp)
                    } else if (c == 's' || c == 'S') { path = PATH_SPLIT; repaint_hw = repaint_cpu = 1;
    1688:	000a8493          	mv	s1,s5
                        disp_change = 1; bsp_printf("\r\nEV path=0 SPLIT\r\n"); }
    168c:	00100b13          	li	s6,1
                        split_setup = 1; split_hw_wait = 0;   /* 原地画：落到"正在显示"的那块上 */
    1690:	00100d93          	li	s11,1
                    } else if (c == 's' || c == 'S') { path = PATH_SPLIT; repaint_hw = repaint_cpu = 1;
    1694:	00100793          	li	a5,1
    1698:	00f12e23          	sw	a5,28(sp)
    169c:	02f12423          	sw	a5,40(sp)
                        disp_change = 1; bsp_printf("\r\nEV path=0 SPLIT\r\n"); }
    16a0:	3340006f          	j	19d4 <main+0x8d0>
                        disp_change = 1; bsp_printf("\r\nEV path=1 CPU only\r\n"); }
    16a4:	00007537          	lui	a0,0x7
    16a8:	13450513          	addi	a0,a0,308 # 7134 <_data+0x1010>
    16ac:	2b5030ef          	jal	5160 <bsp_printf>
                        split_setup = 2; split_hw_wait = 0;   /* 离开 SPLIT：恢复三缓冲轮转 */
    16b0:	03512223          	sw	s5,36(sp)
                        disp_change = 1; bsp_printf("\r\nEV path=1 CPU only\r\n"); }
    16b4:	00100b13          	li	s6,1
                        split_setup = 2; split_hw_wait = 0;   /* 离开 SPLIT：恢复三缓冲轮转 */
    16b8:	00200d93          	li	s11,2
                    else if (c == 'c' || c == 'C')   { path = PATH_CPU;   repaint_hw = repaint_cpu = 1;
    16bc:	00100793          	li	a5,1
    16c0:	00f12e23          	sw	a5,28(sp)
    16c4:	02f12423          	sw	a5,40(sp)
    16c8:	00100493          	li	s1,1
                        disp_change = 1; bsp_printf("\r\nEV path=1 CPU only\r\n"); }
    16cc:	3080006f          	j	19d4 <main+0x8d0>
                        disp_change = 1; bsp_printf("\r\nEV path=2 HW only\r\n"); }
    16d0:	00007537          	lui	a0,0x7
    16d4:	14c50513          	addi	a0,a0,332 # 714c <_data+0x1028>
    16d8:	289030ef          	jal	5160 <bsp_printf>
                        split_setup = 2; split_hw_wait = 0;   /* 离开 SPLIT：恢复三缓冲轮转 */
    16dc:	03512223          	sw	s5,36(sp)
                        disp_change = 1; bsp_printf("\r\nEV path=2 HW only\r\n"); }
    16e0:	00100b13          	li	s6,1
                        split_setup = 2; split_hw_wait = 0;   /* 离开 SPLIT：恢复三缓冲轮转 */
    16e4:	00200d93          	li	s11,2
                    else if (c == 'h' || c == 'H')   { path = PATH_HW;    repaint_hw = repaint_cpu = 1;
    16e8:	00100793          	li	a5,1
    16ec:	00f12e23          	sw	a5,28(sp)
    16f0:	02f12423          	sw	a5,40(sp)
    16f4:	00200493          	li	s1,2
                        disp_change = 1; bsp_printf("\r\nEV path=2 HW only\r\n"); }
    16f8:	2dc0006f          	j	19d4 <main+0x8d0>
                        n += N_STEP; if (n > N_MAX) n = N_MIN; scene_change = 1; disp_change = 1;
    16fc:	019c8c93          	addi	s9,s9,25
    1700:	000017b7          	lui	a5,0x1
    1704:	77078793          	addi	a5,a5,1904 # 1770 <main+0x66c>
    1708:	0197d463          	bge	a5,s9,1710 <main+0x60c>
    170c:	01900c93          	li	s9,25
                        bsp_printf("\r\nEV N=%d\r\n", n); }
    1710:	000c8593          	mv	a1,s9
    1714:	00007537          	lui	a0,0x7
    1718:	0dc50513          	addi	a0,a0,220 # 70dc <_data+0xfb8>
    171c:	245030ef          	jal	5160 <bsp_printf>
                        n += N_STEP; if (n > N_MAX) n = N_MIN; scene_change = 1; disp_change = 1;
    1720:	00100b13          	li	s6,1
    1724:	00100a93          	li	s5,1
                        bsp_printf("\r\nEV N=%d\r\n", n); }
    1728:	2ac0006f          	j	19d4 <main+0x8d0>
                        n -= N_STEP; if (n < N_MIN) n = N_MAX; scene_change = 1; disp_change = 1;
    172c:	fe7c8c93          	addi	s9,s9,-25
    1730:	01800793          	li	a5,24
    1734:	0197c663          	blt	a5,s9,1740 <main+0x63c>
    1738:	00001cb7          	lui	s9,0x1
    173c:	770c8c93          	addi	s9,s9,1904 # 1770 <main+0x66c>
                        bsp_printf("\r\nEV N=%d\r\n", n); }
    1740:	000c8593          	mv	a1,s9
    1744:	00007537          	lui	a0,0x7
    1748:	0dc50513          	addi	a0,a0,220 # 70dc <_data+0xfb8>
    174c:	215030ef          	jal	5160 <bsp_printf>
                        n -= N_STEP; if (n < N_MIN) n = N_MAX; scene_change = 1; disp_change = 1;
    1750:	00100b13          	li	s6,1
    1754:	00100a93          	li	s5,1
    1758:	27c0006f          	j	19d4 <main+0x8d0>
                    else if (c == 'e' || c == 'E') { clear_pp = !clear_pp;
    175c:	03412783          	lw	a5,52(sp)
    1760:	0017cb13          	xori	s6,a5,1
                        if (!clear_pp) repaint_hw = 1;   /* 立即重铺一次，切模式后状态一致 */
    1764:	00078663          	beqz	a5,1770 <main+0x66c>
    1768:	00100793          	li	a5,1
    176c:	02f12423          	sw	a5,40(sp)
                        bsp_printf("\r\nEV clear_per_pass=%d (1=every pass refills the HW region)\r\n", clear_pp); }
    1770:	000b0593          	mv	a1,s6
    1774:	00007537          	lui	a0,0x7
    1778:	16450513          	addi	a0,a0,356 # 7164 <_data+0x1040>
    177c:	1e5030ef          	jal	5160 <bsp_printf>
                    else if (c == 'e' || c == 'E') { clear_pp = !clear_pp;
    1780:	03612a23          	sw	s6,52(sp)
                        disp_change = 1;
    1784:	00100b13          	li	s6,1
                        bsp_printf("\r\nEV clear_per_pass=%d (1=every pass refills the HW region)\r\n", clear_pp); }
    1788:	24c0006f          	j	19d4 <main+0x8d0>
                    else if (c == 't' || c == 'T') { frame_adv = !frame_adv;
    178c:	001c4c13          	xori	s8,s8,1
                        bsp_printf("\r\nEV advance=%d (0=time 25 step/s, 1=one step per published frame)\r\n",
    1790:	000c0593          	mv	a1,s8
    1794:	00007537          	lui	a0,0x7
    1798:	1a450513          	addi	a0,a0,420 # 71a4 <_data+0x1080>
    179c:	1c5030ef          	jal	5160 <bsp_printf>
                        t_scene = t_now;                 /* 切回时间模式时别攒出一大跳 */
    17a0:	05712223          	sw	s7,68(sp)
                        disp_change = 1;
    17a4:	00100b13          	li	s6,1
                        bsp_printf("\r\nEV advance=%d (0=time 25 step/s, 1=one step per published frame)\r\n",
    17a8:	22c0006f          	j	19d4 <main+0x8d0>
                        g_blk = blk_next(g_blk);
    17ac:	8201a503          	lw	a0,-2016(gp) # 7ea8 <g_blk>
    17b0:	1b5010ef          	jal	3164 <blk_next>
    17b4:	82a1a023          	sw	a0,-2016(gp) # 7ea8 <g_blk>
                        build_atlas();
    17b8:	118020ef          	jal	38d0 <build_atlas>
                        spr_mask_report();        /* ★S3：掩码跟着图集一起换（同一个函数里算的） */
    17bc:	2d5030ef          	jal	5290 <spr_mask_report>
                        bsp_printf("\r\nEV size=%d\r\n", g_blk); }
    17c0:	8201a583          	lw	a1,-2016(gp) # 7ea8 <g_blk>
    17c4:	00007537          	lui	a0,0x7
    17c8:	1ec50513          	addi	a0,a0,492 # 71ec <_data+0x10c8>
    17cc:	195030ef          	jal	5160 <bsp_printf>
                        scene_change = 1; disp_change = 1;
    17d0:	00100b13          	li	s6,1
    17d4:	00100a93          	li	s5,1
                        size_repaint = SIZE_REPAINT_ROUNDS;   /* 另外两块缓冲补铺（见声明处） */
    17d8:	00200793          	li	a5,2
    17dc:	04f12a23          	sw	a5,84(sp)
                        bsp_printf("\r\nEV size=%d\r\n", g_blk); }
    17e0:	1f40006f          	j	19d4 <main+0x8d0>
                    else if (c == 'a') { if (alpha >= 32u)  alpha -= 32u;
    17e4:	01f00793          	li	a5,31
    17e8:	03012703          	lw	a4,48(sp)
    17ec:	00e7f663          	bgeu	a5,a4,17f8 <main+0x6f4>
    17f0:	fe070793          	addi	a5,a4,-32
    17f4:	02f12823          	sw	a5,48(sp)
                        disp_change = 1; bsp_printf("\r\nEV alpha=%d\r\n", (int)alpha); }
    17f8:	03012583          	lw	a1,48(sp)
    17fc:	00007537          	lui	a0,0x7
    1800:	1fc50513          	addi	a0,a0,508 # 71fc <_data+0x10d8>
    1804:	15d030ef          	jal	5160 <bsp_printf>
    1808:	00100b13          	li	s6,1
    180c:	1c80006f          	j	19d4 <main+0x8d0>
                    else if (c == 'A') { if (alpha <= 223u) alpha += 32u;
    1810:	0df00793          	li	a5,223
    1814:	03012703          	lw	a4,48(sp)
    1818:	00e7e663          	bltu	a5,a4,1824 <main+0x720>
    181c:	02070793          	addi	a5,a4,32
    1820:	02f12823          	sw	a5,48(sp)
                        disp_change = 1; bsp_printf("\r\nEV alpha=%d\r\n", (int)alpha); }
    1824:	03012583          	lw	a1,48(sp)
    1828:	00007537          	lui	a0,0x7
    182c:	1fc50513          	addi	a0,a0,508 # 71fc <_data+0x10d8>
    1830:	131030ef          	jal	5160 <bsp_printf>
    1834:	00100b13          	li	s6,1
    1838:	19c0006f          	j	19d4 <main+0x8d0>
                    else if (c == 'r' || c == 'R') { scene_change = 1; g_seed += 0x9E3779B9u;
    183c:	81c1a783          	lw	a5,-2020(gp) # 7ea4 <g_seed>
    1840:	9e378737          	lui	a4,0x9e378
    1844:	9b970713          	addi	a4,a4,-1607 # 9e3779b9 <__freertos_irq_stack_top+0x9e334079>
    1848:	00e787b3          	add	a5,a5,a4
    184c:	80f1ae23          	sw	a5,-2020(gp) # 7ea4 <g_seed>
                        bsp_printf("\r\nEV reset\r\n"); }
    1850:	00007537          	lui	a0,0x7
    1854:	20c50513          	addi	a0,a0,524 # 720c <_data+0x10e8>
    1858:	109030ef          	jal	5160 <bsp_printf>
                int disp_change  = 0;    /* 显示内容变了才重画信息条（事件驱动） */
    185c:	000a8b13          	mv	s6,s5
                    else if (c == 'r' || c == 'R') { scene_change = 1; g_seed += 0x9E3779B9u;
    1860:	00100a93          	li	s5,1
                        bsp_printf("\r\nEV reset\r\n"); }
    1864:	1700006f          	j	19d4 <main+0x8d0>
                        int want = (g_dl_want >= 0) ? g_dl_want : g_dl_mode;
    1868:	8101a783          	lw	a5,-2032(gp) # 7e98 <g_dl_want>
    186c:	04f12423          	sw	a5,72(sp)
    1870:	0407c663          	bltz	a5,18bc <main+0x7b8>
                        int next = !want;
    1874:	04812783          	lw	a5,72(sp)
    1878:	0017b713          	seqz	a4,a5
    187c:	04e12823          	sw	a4,80(sp)
                        if (next && !dl_supported()) {
    1880:	04078463          	beqz	a5,18c8 <main+0x7c4>
                        } else if (next == g_dl_mode) {
    1884:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    1888:	05012703          	lw	a4,80(sp)
    188c:	04e78863          	beq	a5,a4,18dc <main+0x7d8>
                            g_dl_want = next;
    1890:	05012703          	lw	a4,80(sp)
    1894:	80e1a823          	sw	a4,-2032(gp) # 7e98 <g_dl_want>
                            bsp_printf("\r\nEV dl %s pending (takes effect at the next frame boundary)\r\n",
    1898:	04812783          	lw	a5,72(sp)
    189c:	06079a63          	bnez	a5,1910 <main+0x80c>
    18a0:	000065b7          	lui	a1,0x6
    18a4:	3f458593          	addi	a1,a1,1012 # 63f4 <_data+0x2d0>
    18a8:	00007537          	lui	a0,0x7
    18ac:	23c50513          	addi	a0,a0,572 # 723c <_data+0x1118>
    18b0:	0b1030ef          	jal	5160 <bsp_printf>
                int disp_change  = 0;    /* 显示内容变了才重画信息条（事件驱动） */
    18b4:	000a8b13          	mv	s6,s5
    18b8:	11c0006f          	j	19d4 <main+0x8d0>
                        int want = (g_dl_want >= 0) ? g_dl_want : g_dl_mode;
    18bc:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    18c0:	04f12423          	sw	a5,72(sp)
    18c4:	fb1ff06f          	j	1874 <main+0x770>
                        if (next && !dl_supported()) {
    18c8:	219030ef          	jal	52e0 <dl_supported>
    18cc:	00050b13          	mv	s6,a0
    18d0:	fa051ae3          	bnez	a0,1884 <main+0x780>
                int scene_change = 0;
    18d4:	00050a93          	mv	s5,a0
    18d8:	0fc0006f          	j	19d4 <main+0x8d0>
                            g_dl_want = -1;                  /* 又按回来了 ⇒ 撤销待生效请求 */
    18dc:	fff00693          	li	a3,-1
    18e0:	80d1a823          	sw	a3,-2032(gp) # 7e98 <g_dl_want>
                            bsp_printf("\r\nEV dl %s pending cancelled\r\n",
    18e4:	02078063          	beqz	a5,1904 <main+0x800>
    18e8:	000065b7          	lui	a1,0x6
    18ec:	3f458593          	addi	a1,a1,1012 # 63f4 <_data+0x2d0>
    18f0:	00007537          	lui	a0,0x7
    18f4:	21c50513          	addi	a0,a0,540 # 721c <_data+0x10f8>
    18f8:	069030ef          	jal	5160 <bsp_printf>
                int disp_change  = 0;    /* 显示内容变了才重画信息条（事件驱动） */
    18fc:	000a8b13          	mv	s6,s5
    1900:	0d40006f          	j	19d4 <main+0x8d0>
                            bsp_printf("\r\nEV dl %s pending cancelled\r\n",
    1904:	000065b7          	lui	a1,0x6
    1908:	3f858593          	addi	a1,a1,1016 # 63f8 <_data+0x2d4>
    190c:	fe5ff06f          	j	18f0 <main+0x7ec>
                            bsp_printf("\r\nEV dl %s pending (takes effect at the next frame boundary)\r\n",
    1910:	000065b7          	lui	a1,0x6
    1914:	3f858593          	addi	a1,a1,1016 # 63f8 <_data+0x2d4>
    1918:	f91ff06f          	j	18a8 <main+0x7a4>
                        g_dl_chunk = (g_dl_chunk == 8u) ? 12u : ((g_dl_chunk == 12u) ? DL_CFG_CHUNK_MAX : 8u);
    191c:	8341a783          	lw	a5,-1996(gp) # 7ebc <g_dl_chunk>
    1920:	00800713          	li	a4,8
    1924:	02e78a63          	beq	a5,a4,1958 <main+0x854>
    1928:	00c00713          	li	a4,12
    192c:	02e78263          	beq	a5,a4,1950 <main+0x84c>
    1930:	00800593          	li	a1,8
    1934:	82b1aa23          	sw	a1,-1996(gp) # 7ebc <g_dl_chunk>
                        g_dl_armed = 0;
    1938:	8801ac23          	sw	zero,-1896(gp) # 7f20 <g_dl_armed>
                        bsp_printf("\r\nEV dl chunk=%d (writes 0x74 on the next arm; per-command path unaffected)\r\n",
    193c:	00007537          	lui	a0,0x7
    1940:	27c50513          	addi	a0,a0,636 # 727c <_data+0x1158>
    1944:	01d030ef          	jal	5160 <bsp_printf>
                        disp_change = 1;
    1948:	00100b13          	li	s6,1
                        bsp_printf("\r\nEV dl chunk=%d (writes 0x74 on the next arm; per-command path unaffected)\r\n",
    194c:	0880006f          	j	19d4 <main+0x8d0>
                        g_dl_chunk = (g_dl_chunk == 8u) ? 12u : ((g_dl_chunk == 12u) ? DL_CFG_CHUNK_MAX : 8u);
    1950:	00f00593          	li	a1,15
    1954:	fe1ff06f          	j	1934 <main+0x830>
    1958:	00c00593          	li	a1,12
    195c:	fd9ff06f          	j	1934 <main+0x830>
                        g_dl_wm = (g_dl_wm == 4u) ? 6u : ((g_dl_wm == 6u) ? 8u : 4u);
    1960:	8301a783          	lw	a5,-2000(gp) # 7eb8 <g_dl_wm>
    1964:	00400713          	li	a4,4
    1968:	02e78a63          	beq	a5,a4,199c <main+0x898>
    196c:	00600713          	li	a4,6
    1970:	02e78263          	beq	a5,a4,1994 <main+0x890>
    1974:	00400593          	li	a1,4
    1978:	82b1a823          	sw	a1,-2000(gp) # 7eb8 <g_dl_wm>
                        g_dl_armed = 0;
    197c:	8801ac23          	sw	zero,-1896(gp) # 7f20 <g_dl_armed>
                        bsp_printf("\r\nEV dl wm=%d (writes 0x74 on the next arm; per-command path unaffected)\r\n",
    1980:	00007537          	lui	a0,0x7
    1984:	2cc50513          	addi	a0,a0,716 # 72cc <_data+0x11a8>
    1988:	7d8030ef          	jal	5160 <bsp_printf>
                        disp_change = 1;
    198c:	00100b13          	li	s6,1
                        bsp_printf("\r\nEV dl wm=%d (writes 0x74 on the next arm; per-command path unaffected)\r\n",
    1990:	0440006f          	j	19d4 <main+0x8d0>
                        g_dl_wm = (g_dl_wm == 4u) ? 6u : ((g_dl_wm == 6u) ? 8u : 4u);
    1994:	00800593          	li	a1,8
    1998:	fe1ff06f          	j	1978 <main+0x874>
    199c:	00600593          	li	a1,6
    19a0:	fd9ff06f          	j	1978 <main+0x874>
                        bsp_printf("\r\ncmd: 1/2/3=scene FILL/ALPHA/KEY   s/c/h=path SPLIT/CPU/HW\r\n"
    19a4:	00001737          	lui	a4,0x1
    19a8:	77070713          	addi	a4,a4,1904 # 1770 <main+0x66c>
    19ac:	01900693          	li	a3,25
    19b0:	01900613          	li	a2,25
    19b4:	01900593          	li	a1,25
    19b8:	00007537          	lui	a0,0x7
    19bc:	31850513          	addi	a0,a0,792 # 7318 <_data+0x11f4>
    19c0:	7a0030ef          	jal	5160 <bsp_printf>
                int disp_change  = 0;    /* 显示内容变了才重画信息条（事件驱动） */
    19c4:	000a8b13          	mv	s6,s5
    19c8:	00c0006f          	j	19d4 <main+0x8d0>
    19cc:	00000b13          	li	s6,0
                int scene_change = 0;
    19d0:	00000a93          	li	s5,0
                if (scene_change) {
    19d4:	020a9a63          	bnez	s5,1a08 <main+0x904>
                if (disp_change)
    19d8:	b40b0ae3          	beqz	s6,152c <main+0x428>
                    osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    19dc:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    19e0:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    19e4:	000c0713          	mv	a4,s8
    19e8:	03412683          	lw	a3,52(sp)
    19ec:	03012603          	lw	a2,48(sp)
    19f0:	000d0593          	mv	a1,s10
    19f4:	000c8513          	mv	a0,s9
    19f8:	738020ef          	jal	4130 <osd_build>
    19fc:	b31ff06f          	j	152c <main+0x428>
                } else if (nl == NL_NONE) {
    1a00:	000a8b13          	mv	s6,s5
    1a04:	fd1ff06f          	j	19d4 <main+0x8d0>
                    scene_init(n, g_seed, (scene == SC_FILL) ? 0 : 1);
    1a08:	01a03633          	snez	a2,s10
    1a0c:	81c1a583          	lw	a1,-2020(gp) # 7ea4 <g_seed>
    1a10:	000c8513          	mv	a0,s9
    1a14:	291020ef          	jal	44a4 <scene_init>
                    hw_i = 0; hw_frame_pushed = 0; cpu_i = 0; pend_adv = 0;
    1a18:	08012423          	sw	zero,136(sp)
                    snap_hw = snap_cpu = 0;   /* scene_init 已把 tx,ty 对齐到 x,y */
    1a1c:	08012023          	sw	zero,128(sp)
    1a20:	08012223          	sw	zero,132(sp)
                    repaint_hw = repaint_cpu = 1;
    1a24:	01512e23          	sw	s5,28(sp)
    1a28:	03512423          	sw	s5,40(sp)
                    hw_i = 0; hw_frame_pushed = 0; cpu_i = 0; pend_adv = 0;
    1a2c:	00000913          	li	s2,0
    1a30:	02012e23          	sw	zero,60(sp)
                    hw_fifo_full = 0;
    1a34:	04012623          	sw	zero,76(sp)
                    hw_i = 0; hw_frame_pushed = 0; cpu_i = 0; pend_adv = 0;
    1a38:	00012c23          	sw	zero,24(sp)
    1a3c:	f9dff06f          	j	19d8 <main+0x8d4>
                    int steps = 0;
    1a40:	000c0a93          	mv	s5,s8
                    do { scene_step_both(n, &vrg, &snap_hw, &snap_cpu); steps++; }
    1a44:	08010693          	addi	a3,sp,128
    1a48:	08410613          	addi	a2,sp,132
    1a4c:	07010593          	addi	a1,sp,112
    1a50:	000c8513          	mv	a0,s9
    1a54:	611020ef          	jal	4864 <scene_step_both>
    1a58:	001a8a93          	addi	s5,s5,1
                    while ((uint32_t)(tick32() - t_scene) >= (uint32_t)SCENE_TICKS &&
    1a5c:	740010ef          	jal	319c <tick32>
    1a60:	41750533          	sub	a0,a0,s7
    1a64:	003d17b7          	lui	a5,0x3d1
    1a68:	8ff78793          	addi	a5,a5,-1793 # 3d08ff <__freertos_irq_stack_top+0x38cfbf>
    1a6c:	04a7f063          	bgeu	a5,a0,1aac <main+0x9a8>
    1a70:	00700793          	li	a5,7
    1a74:	fd57d8e3          	bge	a5,s5,1a44 <main+0x940>
                pend_adv = 0;
    1a78:	03812e23          	sw	s8,60(sp)
                    t_scene = t_now;
    1a7c:	05712223          	sw	s7,68(sp)
    1a80:	ad5ff06f          	j	1554 <main+0x450>
            } else if (pend_adv > 0) {
    1a84:	03c12a83          	lw	s5,60(sp)
    1a88:	ad5056e3          	blez	s5,1554 <main+0x450>
                scene_step_both(n, &vrg, &snap_hw, &snap_cpu);
    1a8c:	08010693          	addi	a3,sp,128
    1a90:	08410613          	addi	a2,sp,132
    1a94:	07010593          	addi	a1,sp,112
    1a98:	000c8513          	mv	a0,s9
    1a9c:	5c9020ef          	jal	4864 <scene_step_both>
                pend_adv--;
    1aa0:	fffa8793          	addi	a5,s5,-1
    1aa4:	02f12e23          	sw	a5,60(sp)
    1aa8:	aadff06f          	j	1554 <main+0x450>
                pend_adv = 0;
    1aac:	03812e23          	sw	s8,60(sp)
                    t_scene = t_now;
    1ab0:	05712223          	sw	s7,68(sp)
    1ab4:	aa1ff06f          	j	1554 <main+0x450>
         *   2 = 离开 SPLIT ⇒ 恢复三缓冲轮转（画下一块、清再下一块）
         * 切换时把两趟索引清零 + 强制整片重铺，避免半趟内容画进刚换的目标里。 */
        if (!back_busy && split_setup) {
            int was = split_setup;               /* 先记下来：下面会清零 */
            if (was == 1) {
                g_draw3    = (int)g_disp_sel;
    1ab8:	8dc1a503          	lw	a0,-1828(gp) # 7f64 <g_disp_sel>
    1abc:	82a1a423          	sw	a0,-2008(gp) # 7eb0 <g_draw3>
                g_fb_back  = fb_of_sel(g_disp_sel);
    1ac0:	718010ef          	jal	31d8 <fb_of_sel>
    1ac4:	82a1a623          	sw	a0,-2004(gp) # 7eb4 <g_fb_back>
                g_clr_need = 0;
    1ac8:	8c01a623          	sw	zero,-1844(gp) # 7f54 <g_clr_need>
    1acc:	1540106f          	j	2c20 <main+0x1b1c>
             * 2) 到点的 1Hz 统计/组串也在这个窗口里做（osd_service 自带门控，
             *    慢时间片里那次调用会直接返回，不会重复算；调用点还先用内联判断
             *    挡一道，没到点连函数调用都不发）。
             * 3) 有界退避 + 低频轮询：每 4 圈才读一次 BLT_STATUS，其余圈纯 ALU 空转，
             *    **一个外设寄存器都不碰**（旧版这里每圈 1 次状态 + 3 次 CLINT 读）。 */
            if (snap_hw)  { scene_snap(g_sc[SIDE_HW],  n); snap_hw  = 0; }
    1ad0:	000c8593          	mv	a1,s9
    1ad4:	00008537          	lui	a0,0x8
    1ad8:	fb850513          	addi	a0,a0,-72 # 7fb8 <g_sc>
    1adc:	485020ef          	jal	4760 <scene_snap>
    1ae0:	08012223          	sw	zero,132(sp)
    1ae4:	1a00106f          	j	2c84 <main+0x1b80>
            if (snap_cpu) { scene_snap(g_sc[SIDE_CPU], n); snap_cpu = 0; }
    1ae8:	000c8593          	mv	a1,s9
    1aec:	00025537          	lui	a0,0x25
    1af0:	47850513          	addi	a0,a0,1144 # 25478 <__global_pointer$+0x1cdf0>
    1af4:	46d020ef          	jal	4760 <scene_snap>
    1af8:	08012023          	sw	zero,128(sp)
    1afc:	1940106f          	j	2c90 <main+0x1b8c>
            if (((uint32_t)(t_now - g_osd_t0) >= (uint32_t)BSP_CLINT_HZ) &&
                osd_service(t_now, hw_frames, cpu_frames, scr_frames,
    1b00:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    1b04:	00f12423          	sw	a5,8(sp)
    1b08:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    1b0c:	00f12223          	sw	a5,4(sp)
    1b10:	01812023          	sw	s8,0(sp)
    1b14:	03412883          	lw	a7,52(sp)
    1b18:	03012803          	lw	a6,48(sp)
    1b1c:	000d0793          	mv	a5,s10
    1b20:	000c8713          	mv	a4,s9
    1b24:	02c12683          	lw	a3,44(sp)
    1b28:	02012603          	lw	a2,32(sp)
    1b2c:	03812583          	lw	a1,56(sp)
    1b30:	000b8513          	mv	a0,s7
    1b34:	668020ef          	jal	419c <osd_service>
            if (((uint32_t)(t_now - g_osd_t0) >= (uint32_t)BSP_CLINT_HZ) &&
    1b38:	00051463          	bnez	a0,1b40 <main+0xa3c>
    1b3c:	16c0106f          	j	2ca8 <main+0x1ba4>
                            n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode)) {
                hw_frames = 0; cpu_frames = 0; scr_frames = 0;
    1b40:	02012623          	sw	zero,44(sp)
    1b44:	02012023          	sw	zero,32(sp)
    1b48:	02012c23          	sw	zero,56(sp)
    1b4c:	15c0106f          	j	2ca8 <main+0x1ba4>
                    back_busy  = 0;
#if FB_TRIPLE_BUFFER
                    /* ★v2.7 三缓冲轮转：刚画完的这块上屏了，接下来
                     *   画 = 之前预清好的那块，清 = 刚腾出来的旧显示缓冲。 */
                    {
                        int old_disp = (int)g_disp_sel;
    1b50:	8dc1a683          	lw	a3,-1828(gp) # 7f64 <g_disp_sel>
                        g_disp_sel   = g_flip_req;
    1b54:	8cf1ae23          	sw	a5,-1828(gp) # 7f64 <g_disp_sel>
                        g_draw3      = g_clr3;
    1b58:	8241a503          	lw	a0,-2012(gp) # 7eac <g_clr3>
    1b5c:	82a1a423          	sw	a0,-2008(gp) # 7eb0 <g_draw3>
                        g_clr3       = old_disp;
    1b60:	82d1a223          	sw	a3,-2012(gp) # 7eac <g_clr3>
                        g_clr_need   = 1;          /* 下一趟开始时给清屏引擎下新命令 */
    1b64:	00100713          	li	a4,1
    1b68:	8ce1a623          	sw	a4,-1844(gp) # 7f54 <g_clr_need>
                        g_pass_armed = 0;
    1b6c:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
                        g_fb_back    = fb_of_sel((uint32_t)g_draw3);
    1b70:	668010ef          	jal	31d8 <fb_of_sel>
    1b74:	82a1a623          	sw	a0,-2004(gp) # 7eb4 <g_fb_back>
                    }
#else
                    g_disp_sel = g_flip_req;
                    g_fb_back  = fb_of_sel(g_disp_sel ^ 1u);   /* 新的后台缓冲 */
#endif
                    scr_frames++;                              /* 这一帧真的上屏了 */
    1b78:	02c12783          	lw	a5,44(sp)
    1b7c:	00178793          	addi	a5,a5,1
    1b80:	02f12623          	sw	a5,44(sp)
                    if (frame_adv && pend_adv < MAX_STEPS) pend_adv++;
    1b84:	000c0c63          	beqz	s8,1b9c <main+0xa98>
    1b88:	00700793          	li	a5,7
    1b8c:	03c12703          	lw	a4,60(sp)
    1b90:	00e7c663          	blt	a5,a4,1b9c <main+0xa98>
    1b94:	00170793          	addi	a5,a4,1
    1b98:	02f12e23          	sw	a5,60(sp)
                    /* 新后台缓冲里是**两帧前**的内容：clear_pp 关掉时要整片重铺一次，
                     * 否则这一轮没动的物块会留着上一轮的残影（clear_pp=1 每趟本来就重铺）。
                     * ★ 刚切过方块尺寸（size_repaint>0）时同样补铺：轮转到的这块里还是
                     *   **旧尺寸**的方块，不盖掉就会和新尺寸的混在同一帧里（见 'k' 命令
                     *   与 SIZE_REPAINT_ROUNDS）。补铺只加"重铺请求"，发布协议未改。 */
                    if (!clear_pp || size_repaint > 0) {
    1b9c:	03412783          	lw	a5,52(sp)
    1ba0:	04078a63          	beqz	a5,1bf4 <main+0xaf0>
    1ba4:	05412783          	lw	a5,84(sp)
    1ba8:	00f05c63          	blez	a5,1bc0 <main+0xabc>
                        repaint_hw = 1; repaint_cpu = 1;
                        if (size_repaint > 0) size_repaint--;
    1bac:	05412783          	lw	a5,84(sp)
    1bb0:	fff78793          	addi	a5,a5,-1
    1bb4:	04f12a23          	sw	a5,84(sp)
                        repaint_hw = 1; repaint_cpu = 1;
    1bb8:	00812e23          	sw	s0,28(sp)
    1bbc:	02812423          	sw	s0,40(sp)
                    /* ★v2.13：'l' 的待生效切换就在**这一刻**落地 —— 这里正是"帧发布边界"：
                     *   本帧已经上屏（FB_STAT 确认翻转生效）、本帧那张表已被 DFU 消费完、
                     *   引擎的像素也已写提交，而下一趟从 hw_i==0 重新开始
                     *   ⇒ 不会切在一张表中间，也不会在同一帧里混用两条路径
                     *   （内部还有"确实没有表在飞"的保险，见 dl_apply_pending()）。 */
                    if (dl_apply_pending())
    1bc0:	764030ef          	jal	5324 <dl_apply_pending>
    1bc4:	00050413          	mv	s0,a0
    1bc8:	06050863          	beqz	a0,1c38 <main+0xb34>
                        osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    1bcc:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    1bd0:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    1bd4:	000c0713          	mv	a4,s8
    1bd8:	03412683          	lw	a3,52(sp)
    1bdc:	03012603          	lw	a2,48(sp)
    1be0:	000d0593          	mv	a1,s10
    1be4:	000c8513          	mv	a0,s9
    1be8:	548020ef          	jal	4130 <osd_build>
                    back_busy  = 0;
    1bec:	00000413          	li	s0,0
    1bf0:	0480006f          	j	1c38 <main+0xb34>
                        if (size_repaint > 0) size_repaint--;
    1bf4:	05412783          	lw	a5,84(sp)
    1bf8:	faf04ae3          	bgtz	a5,1bac <main+0xaa8>
                        repaint_hw = 1; repaint_cpu = 1;
    1bfc:	00812e23          	sw	s0,28(sp)
    1c00:	02812423          	sw	s0,40(sp)
    1c04:	fbdff06f          	j	1bc0 <main+0xabc>
                } else if ((uint32_t)(tick32() - back_t0) > (uint32_t)FLIP_TIMEOUT_TICKS) {
                    g_flip_to++;
                    if (g_flip_to == 1u)
                        bsp_printf("\r\nEV flip timeout, FB_STAT=%x\r\n",
                                   (unsigned)blt_rd(BLT_FB_STAT));
    1c08:	02800513          	li	a0,40
    1c0c:	5bc010ef          	jal	31c8 <blt_rd>
    1c10:	00050593          	mv	a1,a0
                        bsp_printf("\r\nEV flip timeout, FB_STAT=%x\r\n",
    1c14:	00007537          	lui	a0,0x7
    1c18:	73050513          	addi	a0,a0,1840 # 7730 <_data+0x160c>
    1c1c:	544030ef          	jal	5160 <bsp_printf>
    1c20:	0f40106f          	j	2d14 <main+0x1c10>
                    blt_wr(BLT_FB_SEL, g_flip_req);       /* 重发请求，继续有界等待 */
                    back_t0 = tick32();
                } else {
                    cpu_backoff(BLT_WAIT_NOP);
    1c24:	03000513          	li	a0,48
    1c28:	580010ef          	jal	31a8 <cpu_backoff>
    1c2c:	00c0006f          	j	1c38 <main+0xb34>
                } else {
                    cpu_backoff(BLT_WAIT_NOP);
                }
#endif
            } else {
                cpu_backoff(BLT_WAIT_NOP);
    1c30:	03000513          	li	a0,48
    1c34:	574010ef          	jal	31a8 <cpu_backoff>
        /* ---------------- 硬件侧：每趟"整片重铺 + 画全部块"，位置用本趟快照 ----------------
         * 全部画在后台缓冲里；屏幕看到的是上面那条整帧 COPY。
         * ★ clear_pp=1（默认）：本趟先 FILL 整片渲染区为背景色，再画 N 块，
         *   **不发任何逐块擦除指令** —— 上板验证：黑拖尾与 KEY 四角闪烁都消失。
         * ★ clear_pp=0：退回 comptest2 的"逐块擦旧矩形再画"（留给板上 A/B 对比）。 */
        int hw_go = (!back_busy && path != PATH_CPU);
    1c38:	12041463          	bnez	s0,1d60 <main+0xc5c>
    1c3c:	00100793          	li	a5,1
    1c40:	1ef48463          	beq	s1,a5,1e28 <main+0xd24>
    1c44:	00100a13          	li	s4,1
    1c48:	11c0006f          	j	1d64 <main+0xc60>
        } else if (path == PATH_SPLIT) {
    1c4c:	0c049463          	bnez	s1,1d14 <main+0xc10>
            if (cpu_done) cpu_done = 0;
    1c50:	01412783          	lw	a5,20(sp)
    1c54:	00078463          	beqz	a5,1c5c <main+0xb58>
    1c58:	00912a23          	sw	s1,20(sp)
            if (hw_done)  { hw_done = 0; split_hw_wait = 1; }
    1c5c:	01012783          	lw	a5,16(sp)
    1c60:	00079863          	bnez	a5,1c70 <main+0xb6c>
            if (split_hw_wait && ((it & SPLIT_IRQ_MASK) == 0u)) {
    1c64:	02412783          	lw	a5,36(sp)
    1c68:	fc0788e3          	beqz	a5,1c38 <main+0xb34>
    1c6c:	00c0006f          	j	1c78 <main+0xb74>
            if (hw_done)  { hw_done = 0; split_hw_wait = 1; }
    1c70:	01012783          	lw	a5,16(sp)
    1c74:	02f12223          	sw	a5,36(sp)
            if (split_hw_wait && ((it & SPLIT_IRQ_MASK) == 0u)) {
    1c78:	0ff9f793          	zext.b	a5,s3
    1c7c:	00078663          	beqz	a5,1c88 <main+0xb84>
    1c80:	00912823          	sw	s1,16(sp)
    1c84:	fb5ff06f          	j	1c38 <main+0xb34>
                uint32_t irq = blt_rd(BLT_IRQ_STATUS);
    1c88:	01000513          	li	a0,16
    1c8c:	53c010ef          	jal	31c8 <blt_rd>
                if (irq & BLT_IRQ_FRAME) {
    1c90:	00257513          	andi	a0,a0,2
    1c94:	00051663          	bnez	a0,1ca0 <main+0xb9c>
    1c98:	00912823          	sw	s1,16(sp)
    1c9c:	f9dff06f          	j	1c38 <main+0xb34>
                    blt_wr(BLT_IRQ_STATUS, BLT_IRQ_FRAME);   /* W1C：清本场 */
    1ca0:	00200593          	li	a1,2
    1ca4:	01000513          	li	a0,16
    1ca8:	510010ef          	jal	31b8 <blt_wr>
                    scr_frames++;                            /* 真正上屏的一帧（60Hz） */
    1cac:	02c12783          	lw	a5,44(sp)
    1cb0:	00178793          	addi	a5,a5,1
    1cb4:	02f12623          	sw	a5,44(sp)
                    if (frame_adv && pend_adv < MAX_STEPS) pend_adv++;
    1cb8:	000c0c63          	beqz	s8,1cd0 <main+0xbcc>
    1cbc:	00700793          	li	a5,7
    1cc0:	03c12703          	lw	a4,60(sp)
    1cc4:	00e7c663          	blt	a5,a4,1cd0 <main+0xbcc>
    1cc8:	00170793          	addi	a5,a4,1
    1ccc:	02f12e23          	sw	a5,60(sp)
                    if (dl_apply_pending())
    1cd0:	654030ef          	jal	5324 <dl_apply_pending>
    1cd4:	00a12823          	sw	a0,16(sp)
    1cd8:	00051863          	bnez	a0,1ce8 <main+0xbe4>
                    split_hw_wait = 0;
    1cdc:	01012783          	lw	a5,16(sp)
    1ce0:	02f12223          	sw	a5,36(sp)
    1ce4:	f55ff06f          	j	1c38 <main+0xb34>
                        osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    1ce8:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    1cec:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    1cf0:	000c0713          	mv	a4,s8
    1cf4:	03412683          	lw	a3,52(sp)
    1cf8:	03012603          	lw	a2,48(sp)
    1cfc:	000d0593          	mv	a1,s10
    1d00:	000c8513          	mv	a0,s9
    1d04:	42c020ef          	jal	4130 <osd_build>
                    split_hw_wait = 0;
    1d08:	02912223          	sw	s1,36(sp)
                        osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    1d0c:	00912823          	sw	s1,16(sp)
    1d10:	f29ff06f          	j	1c38 <main+0xb34>
        } else if ((path == PATH_CPU || hw_done) && (path == PATH_HW || cpu_done)) {
    1d14:	00100793          	li	a5,1
    1d18:	00f48a63          	beq	s1,a5,1d2c <main+0xc28>
    1d1c:	01012783          	lw	a5,16(sp)
    1d20:	f0078ce3          	beqz	a5,1c38 <main+0xb34>
    1d24:	00200793          	li	a5,2
    1d28:	00f48663          	beq	s1,a5,1d34 <main+0xc30>
    1d2c:	01412783          	lw	a5,20(sp)
    1d30:	f00784e3          	beqz	a5,1c38 <main+0xb34>
            cache_evict();                 /* 与 COPY 路径同一位置：保证 CPU 像素对内存有序 */
    1d34:	718010ef          	jal	344c <cache_evict>
            g_flip_req = (uint32_t)g_draw3;
    1d38:	8281a583          	lw	a1,-2008(gp) # 7eb0 <g_draw3>
    1d3c:	8cb1ac23          	sw	a1,-1832(gp) # 7f60 <g_flip_req>
            blt_wr(BLT_FB_SEL, g_flip_req);
    1d40:	02400513          	li	a0,36
    1d44:	474010ef          	jal	31b8 <blt_wr>
            back_t0   = tick32();
    1d48:	454010ef          	jal	319c <tick32>
    1d4c:	04a12023          	sw	a0,64(sp)
            hw_done = 0; cpu_done = 0;
    1d50:	00812a23          	sw	s0,20(sp)
    1d54:	00812823          	sw	s0,16(sp)
            back_busy = 1;
    1d58:	00100413          	li	s0,1
    1d5c:	eddff06f          	j	1c38 <main+0xb34>
        int hw_go = (!back_busy && path != PATH_CPU);
    1d60:	00000a13          	li	s4,0
#if FB_FLIP_PUBLISH && SPLIT_INPLACE
        /* ★★ SPLIT 原地画：HW 半区本趟已画完、正在等帧边界 ⇒ 这一段整体跳过，
         *   节拍就被压到 60Hz（屏幕本来就只按 60Hz 采样，多画纯属浪费带宽，
         *   还会和 CPU 半区抢 DDR）。此刻没有表在飞（hw_done = 本趟列表已消费完），
         *   所以挂起一个帧周期不会触发 DL 看门狗。 */
        if (path == PATH_SPLIT && split_hw_wait) hw_go = 0;
    1d64:	00049663          	bnez	s1,1d70 <main+0xc6c>
    1d68:	02412783          	lw	a5,36(sp)
    1d6c:	4c0796e3          	bnez	a5,2a38 <main+0x1934>
#endif
        if (hw_go) {
    1d70:	4c0a04e3          	beqz	s4,2a38 <main+0x1934>
             * ★ 完成判据只用 DL_STATUS（本模式不再轮询逐条状态/FIFO_COUNT）。 */
            /* ★ 出错后的交接必须排在 g_dl_mode 判断**之前**：出错时列表路径可能已经被
             *   停用（dl_disable），也可能还开着等**看门狗自动重试**（v2.14）—— 两种情况下
             *   DFU 都可能还在把已展开的命令跑完，必须等它落 BUSY 才能安全地重新 arm 或
             *   交回逐条路径（硬件在 S_PUSH 期间会压住 CPU 对 0x08 的写口）。 */
            if (g_dl_fbwait) {
    1d74:	8841aa83          	lw	s5,-1916(gp) # 7f0c <g_dl_fbwait>
    1d78:	140a8c63          	beqz	s5,1ed0 <main+0xdcc>
                int poll = ((path != PATH_HW) || ((it & BLT_WAIT_MASK) == 0u)) ? 1 : 0;
    1d7c:	00200793          	li	a5,2
    1d80:	00f49663          	bne	s1,a5,1d8c <main+0xc88>
    1d84:	0039f793          	andi	a5,s3,3
    1d88:	0a079463          	bnez	a5,1e30 <main+0xd2c>
                if (poll) {
                    uint32_t fst  = blt_rd(BLT_DL_STATUS);
    1d8c:	05c00513          	li	a0,92
    1d90:	438010ef          	jal	31c8 <blt_rd>
    1d94:	00050a93          	mv	s5,a0
                    int      idle = ((fst & DL_ST_BUSY) == 0u);
    1d98:	00157b13          	andi	s6,a0,1
                    if (idle || ((uint32_t)(tick32() - g_dl_ft0) > (uint32_t)DL_FBWAIT_TICKS)) {
    1d9c:	0a0b1063          	bnez	s6,1e3c <main+0xd38>
                        /* ★v2.14 post-mortem：只有**真的等到 BUSY=0** 才有意义 —— 此时
                         *   S_ERR/S_END 已经走完、perf_r 刚被写入（dl_fetch.v:643-663），
                         *   所以这一行的 perf= 才是**这张出错表**的真实周期数（GO→出错→引擎收尾），
                         *   拿它和 tmo= 一比就知道"离超时差多远"。20ms 上界到点但 DFU 还 BUSY 时
                         *   不打印（那会儿 PERF 还是上一张表的，打出来只会误导）。 */
                        if (idle && g_dl_postmortem) {
    1da0:	8701a783          	lw	a5,-1936(gp) # 7ef8 <g_dl_postmortem>
    1da4:	0a079c63          	bnez	a5,1e5c <main+0xd58>
                            bsp_printf("EV dl post-mortem: perf=%d tmo=%d (this list, GO->ERR->BUSY=0)\r\n",
                                       (int)blt_rd(BLT_DL_PERF), (int)(DL_TIMEOUT_TICKS & 0xFFFFu));
                        }
                        /* 没等到 BUSY=0（20ms 上界到点）也把这一行作废：那会儿 PERF 还是旧的，
                         * 留到下一次交接打出来只会误导。 */
                        g_dl_postmortem = 0;
    1da8:	8601a823          	sw	zero,-1936(gp) # 7ef8 <g_dl_postmortem>
                        /* 停了（或有界超时）：本趟作废、从零重画 */
                        g_dl_fbwait = 0; g_dl_inflight = 0; g_dl_pend = -1; g_dl_pend_last = 0;
    1dac:	8801a223          	sw	zero,-1916(gp) # 7f0c <g_dl_fbwait>
    1db0:	8801aa23          	sw	zero,-1900(gp) # 7f1c <g_dl_inflight>
    1db4:	fff00713          	li	a4,-1
    1db8:	80e1aa23          	sw	a4,-2028(gp) # 7e9c <g_dl_pend>
    1dbc:	8801a423          	sw	zero,-1912(gp) # 7f10 <g_dl_pend_last>
                        hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    1dc0:	08012423          	sw	zero,136(sp)
#if FB_FLIP_PUBLISH && FB_TRIPLE_BUFFER
                        g_pass_armed = 0;
    1dc4:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
#endif
                        if (g_dl_retry_pend) {
    1dc8:	8681a783          	lw	a5,-1944(gp) # 7ef0 <g_dl_retry_pend>
    1dcc:	00f12c23          	sw	a5,24(sp)
    1dd0:	460782e3          	beqz	a5,2a34 <main+0x1930>
                             *     不会切在一张表中间；
                             *   · g_dl_report=1 由 arm 分支自动置上 ⇒ 重试那张表照样做"第一张表
                             *     读数 + 像素落地探针"（原有的两条保证一个都不少）；
                             *   · ★ 一帧只有 ~19ms，而 dl_wd_decide() 保证两次"重新起趟"至少隔
                             *     1s ⇒ 同一个帧里**绝不可能**重开第二趟。 */
                            g_dl_retry_pend = 0;
    1dd4:	8601a423          	sw	zero,-1944(gp) # 7ef0 <g_dl_retry_pend>
                            if (!idle) {
    1dd8:	0a0b0e63          	beqz	s6,1e94 <main+0xd90>
                                g_dl_retry_bad++;
    1ddc:	8601a783          	lw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
    1de0:	00178793          	addi	a5,a5,1
    1de4:	86f1a023          	sw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
                                bsp_printf("EV dl retry %d/%d failed (DFU still BUSY after %d ticks)\r\n",
    1de8:	001e86b7          	lui	a3,0x1e8
    1dec:	48068693          	addi	a3,a3,1152 # 1e8480 <__freertos_irq_stack_top+0x1a4b40>
    1df0:	00100613          	li	a2,1
    1df4:	86c1a583          	lw	a1,-1940(gp) # 7ef4 <g_dl_retry_n>
    1df8:	00007537          	lui	a0,0x7
    1dfc:	7a050513          	addi	a0,a0,1952 # 77a0 <_data+0x167c>
    1e00:	360030ef          	jal	5160 <bsp_printf>
                                           g_dl_retry_n, DL_RETRY_MAX, (int)DL_FBWAIT_TICKS);
                                dl_wd_summary("retry aborted: DFU never went idle");
    1e04:	00007537          	lui	a0,0x7
    1e08:	7dc50513          	addi	a0,a0,2012 # 77dc <_data+0x16b8>
    1e0c:	469030ef          	jal	5a74 <dl_wd_summary>
                                dl_disable("WATCHDOG: DFU never went idle");
    1e10:	00008537          	lui	a0,0x8
    1e14:	80050513          	addi	a0,a0,-2048 # 7800 <_data+0x16dc>
    1e18:	4a9030ef          	jal	5ac0 <dl_disable>
                        hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    1e1c:	03412423          	sw	s4,40(sp)
    1e20:	00012c23          	sw	zero,24(sp)
    1e24:	4150006f          	j	2a38 <main+0x1934>
        int hw_go = (!back_busy && path != PATH_CPU);
    1e28:	00040a13          	mv	s4,s0
    1e2c:	f45ff06f          	j	1d70 <main+0xc6c>
                        }
                    } else {
                        cpu_backoff(BLT_WAIT_NOP);
                    }
                } else {
                    cpu_backoff(BLT_WAIT_NOP);
    1e30:	03000513          	li	a0,48
    1e34:	374010ef          	jal	31a8 <cpu_backoff>
    1e38:	4010006f          	j	2a38 <main+0x1934>
                    if (idle || ((uint32_t)(tick32() - g_dl_ft0) > (uint32_t)DL_FBWAIT_TICKS)) {
    1e3c:	360010ef          	jal	319c <tick32>
    1e40:	8801a783          	lw	a5,-1920(gp) # 7f08 <g_dl_ft0>
    1e44:	40f50533          	sub	a0,a0,a5
    1e48:	001e87b7          	lui	a5,0x1e8
    1e4c:	48078793          	addi	a5,a5,1152 # 1e8480 <__freertos_irq_stack_top+0x1a4b40>
    1e50:	06a7fa63          	bgeu	a5,a0,1ec4 <main+0xdc0>
                        if (idle && g_dl_postmortem) {
    1e54:	f40b1ae3          	bnez	s6,1da8 <main+0xca4>
    1e58:	f49ff06f          	j	1da0 <main+0xc9c>
                            g_dl_postmortem = 0;
    1e5c:	8601a823          	sw	zero,-1936(gp) # 7ef8 <g_dl_postmortem>
                            dl_status_dump("post-mortem", fst);
    1e60:	000a8593          	mv	a1,s5
    1e64:	00007537          	lui	a0,0x7
    1e68:	75050513          	addi	a0,a0,1872 # 7750 <_data+0x162c>
    1e6c:	594030ef          	jal	5400 <dl_status_dump>
                                       (int)blt_rd(BLT_DL_PERF), (int)(DL_TIMEOUT_TICKS & 0xFFFFu));
    1e70:	07c00513          	li	a0,124
    1e74:	354010ef          	jal	31c8 <blt_rd>
    1e78:	00050593          	mv	a1,a0
                            bsp_printf("EV dl post-mortem: perf=%d tmo=%d (this list, GO->ERR->BUSY=0)\r\n",
    1e7c:	00010637          	lui	a2,0x10
    1e80:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x7977>
    1e84:	00007537          	lui	a0,0x7
    1e88:	75c50513          	addi	a0,a0,1884 # 775c <_data+0x1638>
    1e8c:	2d4030ef          	jal	5160 <bsp_printf>
    1e90:	f19ff06f          	j	1da8 <main+0xca4>
                                g_dl_armed  = 0;
    1e94:	8801ac23          	sw	zero,-1896(gp) # 7f20 <g_dl_armed>
                                g_dl_report = 1;
    1e98:	00100713          	li	a4,1
    1e9c:	86e1ae23          	sw	a4,-1924(gp) # 7f04 <g_dl_report>
                                g_dl_stall_seen = 0;
    1ea0:	8601aa23          	sw	zero,-1932(gp) # 7efc <g_dl_stall_seen>
                                bsp_printf("EV dl retry %d/%d start (fresh arm, this pass from hw_i=0)\r\n",
    1ea4:	00100613          	li	a2,1
    1ea8:	86c1a583          	lw	a1,-1940(gp) # 7ef4 <g_dl_retry_n>
    1eac:	00008537          	lui	a0,0x8
    1eb0:	82050513          	addi	a0,a0,-2016 # 7820 <_data+0x16fc>
    1eb4:	2ac030ef          	jal	5160 <bsp_printf>
                        hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    1eb8:	03412423          	sw	s4,40(sp)
    1ebc:	00012c23          	sw	zero,24(sp)
    1ec0:	3790006f          	j	2a38 <main+0x1934>
                        cpu_backoff(BLT_WAIT_NOP);
    1ec4:	03000513          	li	a0,48
    1ec8:	2e0010ef          	jal	31a8 <cpu_backoff>
    1ecc:	36d0006f          	j	2a38 <main+0x1934>
                }
            } else if (g_dl_mode) {
    1ed0:	89c1ab03          	lw	s6,-1892(gp) # 7f24 <g_dl_mode>
    1ed4:	760b0463          	beqz	s6,263c <main+0x1538>
                int y0   = hw_y0(path);
    1ed8:	00048513          	mv	a0,s1
    1edc:	22c030ef          	jal	5108 <hw_y0>
    1ee0:	04a12823          	sw	a0,80(sp)
                int poll = ((path != PATH_HW) || ((it & BLT_WAIT_MASK) == 0u)) ? 1 : 0;
    1ee4:	00200793          	li	a5,2
    1ee8:	08f48663          	beq	s1,a5,1f74 <main+0xe70>
    1eec:	05412423          	sw	s4,72(sp)
                int armed_ok = 1;

                /* ★v2.13 关→开时的一次性配置**带回读校验**：不过就当场退回逐条路径。
                 * 校验内容与理由见 dl_arm()/dl_arm_verify() —— 覆盖的正是"只有场景 2/3
                 * 会踩"的几何表那条链路（配置寄存器读回、几何表读回、W/H/行距非 0）。 */
                if (!g_dl_armed) {
    1ef0:	8981a783          	lw	a5,-1896(gp) # 7f20 <g_dl_armed>
    1ef4:	08078c63          	beqz	a5,1f8c <main+0xe88>
                    hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
#if FB_FLIP_PUBLISH && FB_TRIPLE_BUFFER
                    g_pass_armed = 0;
#endif
                    osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
                } else if (g_dl_inflight) {
    1ef8:	8941ab03          	lw	s6,-1900(gp) # 7f1c <g_dl_inflight>
    1efc:	4c0b0e63          	beqz	s6,23d8 <main+0x12d4>
                    /* ① 乒乓：把下一段写进另一张缓冲。
                     *    描述符只是 DDR 存储（一次 MMIO 都没有），不打扰 DFU 取指。 */
                    if (g_dl_pend < 0 && hw_i < n) {
    1f00:	8141a783          	lw	a5,-2028(gp) # 7e9c <g_dl_pend>
    1f04:	1207c063          	bltz	a5,2024 <main+0xf20>
                        cache_evict();             /* 硬件紧接着要读这批描述符 */
                        g_dl_pend = 1 - g_dl_buf; g_dl_pend_n = c; g_dl_pend_last = last;
                        g_dl_pend_sp = hw_i - i0;
                    }
                    /* ② 低频轮询本表：DONE 电平（含引擎写提交）或 ERR 锁存 */
                    if (poll) {
    1f08:	04812783          	lw	a5,72(sp)
    1f0c:	4c078063          	beqz	a5,23cc <main+0x12c8>
                        uint32_t st = blt_rd(BLT_DL_STATUS);
    1f10:	05c00513          	li	a0,92
    1f14:	2b4010ef          	jal	31c8 <blt_rd>
    1f18:	00050a13          	mv	s4,a0
                        /* ★v2.14 STALL 必须在这里**粘住**：它是组合位，出错后进 S_ERR 就恒 0
                         *   （理由见 dl_status_dump()），只有在"表还在飞"的每次轮询里记下来，
                         *   出错时才能回答"这张表是不是被饿住过"。 */
                        if (st & DL_ST_STALL) g_dl_stall_seen = 1;
    1f1c:	01057793          	andi	a5,a0,16
    1f20:	00078663          	beqz	a5,1f2c <main+0xe28>
    1f24:	00100713          	li	a4,1
    1f28:	86e1aa23          	sw	a4,-1932(gp) # 7efc <g_dl_stall_seen>
                        if (st & DL_ST_ERR) {
    1f2c:	004a7793          	andi	a5,s4,4
    1f30:	1a079463          	bnez	a5,20d8 <main+0xfd4>
                            hw_frame_pushed = 0; repaint_hw = 1;
#if FB_FLIP_PUBLISH && FB_TRIPLE_BUFFER
                            g_pass_armed = 0;
#endif
                            osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
                        } else if (!(st & DL_ST_BUSY)) {
    1f34:	001a7793          	andi	a5,s4,1
    1f38:	300790e3          	bnez	a5,2a38 <main+0x1934>
                            /* 本表消费完（DONE；ABORTED 也走这里）⇒ 它那张缓冲重新可写 */
                            if (g_dl_report) {
    1f3c:	87c1a783          	lw	a5,-1924(gp) # 7f04 <g_dl_report>
    1f40:	34079863          	bnez	a5,2290 <main+0x118c>
                                }
                            }
                            /* ★v2.15 成本行：这张表**跑完了**（BUSY=0 之后 DL_PERF 才是这张表的
                             *   周期数）⇒ 记一行"n / cycles / cyc/sprite"，1Hz 门控不刷屏。
                             *   放在"重试 ok"之前打：先给数、再给结论，日志顺序更好读。 */
                            dl_cost_report(g_dl_inflight_sp);
    1f44:	84c1a503          	lw	a0,-1972(gp) # 7ed4 <g_dl_inflight_sp>
    1f48:	44d030ef          	jal	5b94 <dl_cost_report>
                            /* ★v2.15 重试成功的判据：那张重试表**跑完了且没报错**、而且
                             *   上面的像素探针也没把它否掉（探针不过时 dl_disable() 已经把
                             *   g_dl_mode 清 0 ⇒ 这里绝不会把"没画像素"报成 ok）。
                             *   成功后**没有"恢复额度"这回事**了：策略是"一次事件一次机会"，
                             *   下一次看门狗事件会重新走一遍 dl_wd_decide()（距上次 >1s 才重试）。 */
                            if (g_dl_retry_n && g_dl_mode) {
    1f4c:	86c1a583          	lw	a1,-1940(gp) # 7ef4 <g_dl_retry_n>
    1f50:	00058663          	beqz	a1,1f5c <main+0xe58>
    1f54:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    1f58:	40079063          	bnez	a5,2358 <main+0x1254>
                                bsp_printf("EV dl retry %d/%d ok (cumulative ok=%d bad=%d)\r\n",
                                           g_dl_retry_n, DL_RETRY_MAX,
                                           (int)g_dl_retry_ok, (int)g_dl_retry_bad);
                                g_dl_retry_n = 0;
                            }
                            if (g_dl_mode && g_dl_pend >= 0) {
    1f5c:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    1f60:	00078663          	beqz	a5,1f6c <main+0xe68>
    1f64:	8141a503          	lw	a0,-2028(gp) # 7e9c <g_dl_pend>
    1f68:	40055c63          	bgez	a0,2380 <main+0x127c>
                                      g_fb_back + (uint32_t)y0 * FB_STRIDE);
                                g_dl_buf = g_dl_pend; g_dl_pend = -1;
                                g_dl_inflight_sp = g_dl_pend_sp;   /* 成本行的 n= 跟着这张表走 */
                                if (g_dl_pend_last) { g_dl_pend_last = 0; hw_frame_pushed = 1; }
                            } else {
                                g_dl_inflight = 0;     /* 下一圈在下面那个分支里收尾/继续发 */
    1f6c:	8801aa23          	sw	zero,-1900(gp) # 7f1c <g_dl_inflight>
    1f70:	2c90006f          	j	2a38 <main+0x1934>
                int poll = ((path != PATH_HW) || ((it & BLT_WAIT_MASK) == 0u)) ? 1 : 0;
    1f74:	0039f793          	andi	a5,s3,3
    1f78:	00079663          	bnez	a5,1f84 <main+0xe80>
    1f7c:	05412423          	sw	s4,72(sp)
    1f80:	f71ff06f          	j	1ef0 <main+0xdec>
    1f84:	05512423          	sw	s5,72(sp)
    1f88:	f69ff06f          	j	1ef0 <main+0xdec>
                    armed_ok = dl_arm();
    1f8c:	6c0030ef          	jal	564c <dl_arm>
    1f90:	00050b13          	mv	s6,a0
                    g_dl_armed = armed_ok;
    1f94:	88a1ac23          	sw	a0,-1896(gp) # 7f20 <g_dl_armed>
                    g_dl_report = armed_ok;
    1f98:	86a1ae23          	sw	a0,-1924(gp) # 7f04 <g_dl_report>
                    g_dl_probe_px = 0;
    1f9c:	8601ac23          	sw	zero,-1928(gp) # 7f00 <g_dl_probe_px>
                if (!armed_ok) {
    1fa0:	f4051ce3          	bnez	a0,1ef8 <main+0xdf4>
                    if (g_dl_retry_n) {
    1fa4:	86c1a583          	lw	a1,-1940(gp) # 7ef4 <g_dl_retry_n>
    1fa8:	04059863          	bnez	a1,1ff8 <main+0xef4>
                    g_dl_retry_n = 0; g_dl_retry_pend = 0;
    1fac:	8601a623          	sw	zero,-1940(gp) # 7ef4 <g_dl_retry_n>
    1fb0:	8601a423          	sw	zero,-1944(gp) # 7ef0 <g_dl_retry_pend>
                    g_dl_postmortem = 0;
    1fb4:	8601a823          	sw	zero,-1936(gp) # 7ef8 <g_dl_postmortem>
                    g_dl_mode = 0; g_dl_want = -1;
    1fb8:	8801ae23          	sw	zero,-1892(gp) # 7f24 <g_dl_mode>
    1fbc:	fff00713          	li	a4,-1
    1fc0:	80e1a823          	sw	a4,-2032(gp) # 7e98 <g_dl_want>
                    hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    1fc4:	08012423          	sw	zero,136(sp)
                    g_pass_armed = 0;
    1fc8:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
                    osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    1fcc:	00000813          	li	a6,0
    1fd0:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    1fd4:	000c0713          	mv	a4,s8
    1fd8:	03412683          	lw	a3,52(sp)
    1fdc:	03012603          	lw	a2,48(sp)
    1fe0:	000d0593          	mv	a1,s10
    1fe4:	000c8513          	mv	a0,s9
    1fe8:	148020ef          	jal	4130 <osd_build>
                    hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    1fec:	03412423          	sw	s4,40(sp)
    1ff0:	01612c23          	sw	s6,24(sp)
    1ff4:	2450006f          	j	2a38 <main+0x1934>
                        g_dl_retry_bad++;
    1ff8:	8601a783          	lw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
    1ffc:	00178793          	addi	a5,a5,1
    2000:	86f1a023          	sw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
                        bsp_printf("EV dl retry %d/%d failed (re-arm verification failed)\r\n",
    2004:	00100613          	li	a2,1
    2008:	00008537          	lui	a0,0x8
    200c:	86050513          	addi	a0,a0,-1952 # 7860 <_data+0x173c>
    2010:	150030ef          	jal	5160 <bsp_printf>
                        dl_wd_summary("retry re-arm verification failed");
    2014:	00008537          	lui	a0,0x8
    2018:	89850513          	addi	a0,a0,-1896 # 7898 <_data+0x1774>
    201c:	259030ef          	jal	5a74 <dl_wd_summary>
    2020:	f8dff06f          	j	1fac <main+0xea8>
                    if (g_dl_pend < 0 && hw_i < n) {
    2024:	08812a03          	lw	s4,136(sp)
    2028:	ef9a50e3          	bge	s4,s9,1f08 <main+0xe04>
                        int c = 0, last = 0;
    202c:	06012423          	sw	zero,104(sp)
    2030:	06012623          	sw	zero,108(sp)
                        int rep = (hw_i == 0 && repaint_hw) ? dl_rep_id(path) : -1;
    2034:	000a1e63          	bnez	s4,2050 <main+0xf4c>
    2038:	02812783          	lw	a5,40(sp)
    203c:	08078a63          	beqz	a5,20d0 <main+0xfcc>
    2040:	00048513          	mv	a0,s1
    2044:	1a1020ef          	jal	49e4 <dl_rep_id>
    2048:	00050b13          	mv	s6,a0
    204c:	0080006f          	j	2054 <main+0xf50>
    2050:	fff00b13          	li	s6,-1
                        dl_build((uint32_t *)DL_LIST_ADDR(1 - g_dl_buf), &hw_i, n, scene,
    2054:	8901a783          	lw	a5,-1904(gp) # 7f18 <g_dl_buf>
    2058:	00100513          	li	a0,1
    205c:	40f50533          	sub	a0,a0,a5
    2060:	01151513          	slli	a0,a0,0x11
    2064:	06c10793          	addi	a5,sp,108
    2068:	00f12023          	sw	a5,0(sp)
    206c:	06810893          	addi	a7,sp,104
    2070:	000b0813          	mv	a6,s6
    2074:	03412783          	lw	a5,52(sp)
    2078:	03012703          	lw	a4,48(sp)
    207c:	000d0693          	mv	a3,s10
    2080:	000c8613          	mv	a2,s9
    2084:	08810593          	addi	a1,sp,136
    2088:	00821337          	lui	t1,0x821
    208c:	00650533          	add	a0,a0,t1
    2090:	169020ef          	jal	49f8 <dl_build>
                        if (rep >= 0) repaint_hw = 0;
    2094:	000b4463          	bltz	s6,209c <main+0xf98>
    2098:	03512423          	sw	s5,40(sp)
                        cache_evict();             /* 硬件紧接着要读这批描述符 */
    209c:	3b0010ef          	jal	344c <cache_evict>
                        g_dl_pend = 1 - g_dl_buf; g_dl_pend_n = c; g_dl_pend_last = last;
    20a0:	8901a703          	lw	a4,-1904(gp) # 7f18 <g_dl_buf>
    20a4:	00100793          	li	a5,1
    20a8:	40e787b3          	sub	a5,a5,a4
    20ac:	80f1aa23          	sw	a5,-2028(gp) # 7e9c <g_dl_pend>
    20b0:	06812703          	lw	a4,104(sp)
    20b4:	88e1a623          	sw	a4,-1908(gp) # 7f14 <g_dl_pend_n>
    20b8:	06c12703          	lw	a4,108(sp)
    20bc:	88e1a423          	sw	a4,-1912(gp) # 7f10 <g_dl_pend_last>
                        g_dl_pend_sp = hw_i - i0;
    20c0:	08812783          	lw	a5,136(sp)
    20c4:	414787b3          	sub	a5,a5,s4
    20c8:	84f1a423          	sw	a5,-1976(gp) # 7ed0 <g_dl_pend_sp>
    20cc:	e3dff06f          	j	1f08 <main+0xe04>
                        int rep = (hw_i == 0 && repaint_hw) ? dl_rep_id(path) : -1;
    20d0:	fff00b13          	li	s6,-1
    20d4:	f81ff06f          	j	2054 <main+0xf50>
                            uint32_t ew    = dl_err_report();
    20d8:	78c030ef          	jal	5864 <dl_err_report>
    20dc:	00a12c23          	sw	a0,24(sp)
                            int      wd    = ((ew & 0xFFu) == 0x10u);
    20e0:	0ff57a13          	zext.b	s4,a0
                            int      spent = (g_dl_retry_n != 0);   /* 错的正是上一次重试 */
    20e4:	86c1ab03          	lw	s6,-1940(gp) # 7ef4 <g_dl_retry_n>
    20e8:	016037b3          	snez	a5,s6
    20ec:	04f12823          	sw	a5,80(sp)
                            uint32_t now   = tick32();
    20f0:	0ac010ef          	jal	319c <tick32>
                            int      again = 0;
    20f4:	06012623          	sw	zero,108(sp)
                            if (wd) {
    20f8:	01000793          	li	a5,16
    20fc:	04fa0063          	beq	s4,a5,213c <main+0x1038>
                            uint32_t gap   = 0xFFFFFFFFu;           /* 默认 = "很久以前"（没出过事件）*/
    2100:	fff00793          	li	a5,-1
    2104:	02f12423          	sw	a5,40(sp)
                            if (spent) {
    2108:	060b1263          	bnez	s6,216c <main+0x1068>
                            if (wd)
    210c:	01000793          	li	a5,16
    2110:	08fa0e63          	beq	s4,a5,21ac <main+0x10a8>
                                if (wd) {
    2114:	01000793          	li	a5,16
    2118:	0cfa0663          	beq	s4,a5,21e4 <main+0x10e0>
                                } else if (spent) {
    211c:	160b0263          	beqz	s6,2280 <main+0x117c>
                                    dl_wd_summary("retry failed with a deterministic error");
    2120:	00008537          	lui	a0,0x8
    2124:	98450513          	addi	a0,a0,-1660 # 7984 <_data+0x1860>
    2128:	14d030ef          	jal	5a74 <dl_wd_summary>
                                    dl_disable("DL_ERR");
    212c:	00008537          	lui	a0,0x8
    2130:	9ac50513          	addi	a0,a0,-1620 # 79ac <_data+0x1888>
    2134:	18d030ef          	jal	5ac0 <dl_disable>
    2138:	0d00006f          	j	2208 <main+0x1104>
                                g_dl_wd_events++;
    213c:	85c1a783          	lw	a5,-1956(gp) # 7ee4 <g_dl_wd_events>
    2140:	00178793          	addi	a5,a5,1
    2144:	84f1ae23          	sw	a5,-1956(gp) # 7ee4 <g_dl_wd_events>
                                if (g_dl_wd_last != 0)
    2148:	8581a783          	lw	a5,-1960(gp) # 7ee0 <g_dl_wd_last>
    214c:	00078a63          	beqz	a5,2160 <main+0x105c>
                                    gap = (uint32_t)(now - g_dl_wd_last);
    2150:	40f507b3          	sub	a5,a0,a5
    2154:	02f12423          	sw	a5,40(sp)
                                g_dl_wd_last = now;
    2158:	84a1ac23          	sw	a0,-1960(gp) # 7ee0 <g_dl_wd_last>
    215c:	fadff06f          	j	2108 <main+0x1004>
                            uint32_t gap   = 0xFFFFFFFFu;           /* 默认 = "很久以前"（没出过事件）*/
    2160:	fff00793          	li	a5,-1
    2164:	02f12423          	sw	a5,40(sp)
    2168:	ff1ff06f          	j	2158 <main+0x1054>
                                g_dl_retry_bad++;
    216c:	8601a783          	lw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
    2170:	00178793          	addi	a5,a5,1
    2174:	86f1a023          	sw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
                                bsp_printf("EV dl retry %d/%d failed (code=%x %s)\r\n",
    2178:	86c1a703          	lw	a4,-1940(gp) # 7ef4 <g_dl_retry_n>
    217c:	04e12c23          	sw	a4,88(sp)
    2180:	01812503          	lw	a0,24(sp)
    2184:	6c5020ef          	jal	5048 <dl_err_name>
    2188:	00050713          	mv	a4,a0
    218c:	000a0693          	mv	a3,s4
    2190:	00100613          	li	a2,1
    2194:	05812583          	lw	a1,88(sp)
    2198:	00008537          	lui	a0,0x8
    219c:	8bc50513          	addi	a0,a0,-1860 # 78bc <_data+0x1798>
    21a0:	7c1020ef          	jal	5160 <bsp_printf>
                                g_dl_retry_n = 0;
    21a4:	8601a623          	sw	zero,-1940(gp) # 7ef4 <g_dl_retry_n>
    21a8:	f65ff06f          	j	210c <main+0x1008>
                                verdict = dl_wd_decide(spent, gap, &again);
    21ac:	06c10613          	addi	a2,sp,108
    21b0:	02812583          	lw	a1,40(sp)
    21b4:	05012503          	lw	a0,80(sp)
    21b8:	399020ef          	jal	4d50 <dl_wd_decide>
                            if (verdict == DL_WD_RETRY) {
    21bc:	00100793          	li	a5,1
    21c0:	f4f51ae3          	bne	a0,a5,2114 <main+0x1010>
                                g_dl_retry_n    = 1;        /* 本事件唯一的一次重试 */
    21c4:	86f1a623          	sw	a5,-1940(gp) # 7ef4 <g_dl_retry_n>
                                g_dl_retry_pend = 1;
    21c8:	86f1a423          	sw	a5,-1944(gp) # 7ef0 <g_dl_retry_pend>
                                bsp_printf("EV dl retry %d/%d pending (WATCHDOG: wait BUSY=0, re-arm, resend this pass)\r\n",
    21cc:	00100613          	li	a2,1
    21d0:	00100593          	li	a1,1
    21d4:	00008537          	lui	a0,0x8
    21d8:	8e450513          	addi	a0,a0,-1820 # 78e4 <_data+0x17c0>
    21dc:	785020ef          	jal	5160 <bsp_printf>
    21e0:	0280006f          	j	2208 <main+0x1104>
                                    if (spent)
    21e4:	060b1e63          	bnez	s6,2260 <main+0x115c>
                                    else if (again)
    21e8:	06c12783          	lw	a5,108(sp)
    21ec:	08078263          	beqz	a5,2270 <main+0x116c>
                                        dl_wd_summary("2nd watchdog within 1s window");
    21f0:	00008537          	lui	a0,0x8
    21f4:	94850513          	addi	a0,a0,-1720 # 7948 <_data+0x1824>
    21f8:	07d030ef          	jal	5a74 <dl_wd_summary>
                                    dl_disable("WATCHDOG");
    21fc:	00008537          	lui	a0,0x8
    2200:	97850513          	addi	a0,a0,-1672 # 7978 <_data+0x1854>
    2204:	0bd030ef          	jal	5ac0 <dl_disable>
                            g_dl_postmortem = 1;        /* BUSY 落定后补一行本表真实 PERF */
    2208:	00100793          	li	a5,1
    220c:	86f1a823          	sw	a5,-1936(gp) # 7ef8 <g_dl_postmortem>
                            g_dl_fbwait = 1; g_dl_ft0 = tick32();
    2210:	88f1a223          	sw	a5,-1916(gp) # 7f0c <g_dl_fbwait>
    2214:	789000ef          	jal	319c <tick32>
    2218:	88a1a023          	sw	a0,-1920(gp) # 7f08 <g_dl_ft0>
                            g_dl_inflight = 0; g_dl_pend = -1; g_dl_pend_last = 0;
    221c:	8801aa23          	sw	zero,-1900(gp) # 7f1c <g_dl_inflight>
    2220:	fff00713          	li	a4,-1
    2224:	80e1aa23          	sw	a4,-2028(gp) # 7e9c <g_dl_pend>
    2228:	8801a423          	sw	zero,-1912(gp) # 7f10 <g_dl_pend_last>
                            g_pass_armed = 0;
    222c:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
                            osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    2230:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    2234:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    2238:	000c0713          	mv	a4,s8
    223c:	03412683          	lw	a3,52(sp)
    2240:	03012603          	lw	a2,48(sp)
    2244:	000d0593          	mv	a1,s10
    2248:	000c8513          	mv	a0,s9
    224c:	6e5010ef          	jal	4130 <osd_build>
                            hw_frame_pushed = 0; repaint_hw = 1;
    2250:	04812783          	lw	a5,72(sp)
    2254:	02f12423          	sw	a5,40(sp)
    2258:	01512c23          	sw	s5,24(sp)
    225c:	7dc0006f          	j	2a38 <main+0x1934>
                                        dl_wd_summary("retry also failed");
    2260:	00008537          	lui	a0,0x8
    2264:	93450513          	addi	a0,a0,-1740 # 7934 <_data+0x1810>
    2268:	00d030ef          	jal	5a74 <dl_wd_summary>
    226c:	f91ff06f          	j	21fc <main+0x10f8>
                                        dl_wd_summary("watchdog event");   /* 防御：dl_wd_decide 不会给这个组合 */
    2270:	00008537          	lui	a0,0x8
    2274:	96850513          	addi	a0,a0,-1688 # 7968 <_data+0x1844>
    2278:	7fc030ef          	jal	5a74 <dl_wd_summary>
    227c:	f81ff06f          	j	21fc <main+0x10f8>
                                    dl_disable("DL_ERR");   /* 确定性错误：直接退回逐条 */
    2280:	00008537          	lui	a0,0x8
    2284:	9ac50513          	addi	a0,a0,-1620 # 79ac <_data+0x1888>
    2288:	039030ef          	jal	5ac0 <dl_disable>
    228c:	f7dff06f          	j	2208 <main+0x1104>
                                g_dl_report = 0;
    2290:	8601ae23          	sw	zero,-1924(gp) # 7f04 <g_dl_report>
                                           (unsigned)st, (int)(st >> DL_ST_CONSUMED_SH),
    2294:	010a5a93          	srli	s5,s4,0x10
                                           (int)blt_rd(BLT_DL_PERF));
    2298:	07c00513          	li	a0,124
    229c:	72d000ef          	jal	31c8 <blt_rd>
    22a0:	00050693          	mv	a3,a0
                                bsp_printf("EV dl 1st list: STATUS=%x consumed=%d perf=%d\r\n",
    22a4:	000a8613          	mv	a2,s5
    22a8:	000a0593          	mv	a1,s4
    22ac:	00008537          	lui	a0,0x8
    22b0:	9b450513          	addi	a0,a0,-1612 # 79b4 <_data+0x1890>
    22b4:	6ad020ef          	jal	5160 <bsp_printf>
                                if (!dl_pixel_probe()) {
    22b8:	75c030ef          	jal	5a14 <dl_pixel_probe>
    22bc:	00050a13          	mv	s4,a0
    22c0:	c80512e3          	bnez	a0,1f44 <main+0xe40>
                                    if (g_dl_retry_n) {
    22c4:	86c1a583          	lw	a1,-1940(gp) # 7ef4 <g_dl_retry_n>
    22c8:	06059263          	bnez	a1,232c <main+0x1228>
                                    dl_disable("1st list drew no pixels");
    22cc:	00008537          	lui	a0,0x8
    22d0:	a3850513          	addi	a0,a0,-1480 # 7a38 <_data+0x1914>
    22d4:	7ec030ef          	jal	5ac0 <dl_disable>
                                    g_dl_fbwait = 1; g_dl_ft0 = tick32();
    22d8:	00100713          	li	a4,1
    22dc:	88e1a223          	sw	a4,-1916(gp) # 7f0c <g_dl_fbwait>
    22e0:	6bd000ef          	jal	319c <tick32>
    22e4:	88a1a023          	sw	a0,-1920(gp) # 7f08 <g_dl_ft0>
                                    g_dl_inflight = 0; g_dl_pend = -1; g_dl_pend_last = 0;
    22e8:	8801aa23          	sw	zero,-1900(gp) # 7f1c <g_dl_inflight>
    22ec:	fff00713          	li	a4,-1
    22f0:	80e1aa23          	sw	a4,-2028(gp) # 7e9c <g_dl_pend>
    22f4:	8801a423          	sw	zero,-1912(gp) # 7f10 <g_dl_pend_last>
                                    g_pass_armed = 0;
    22f8:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
                                    osd_build(n, scene, alpha, clear_pp, frame_adv, g_blk, g_dl_mode);
    22fc:	89c1a803          	lw	a6,-1892(gp) # 7f24 <g_dl_mode>
    2300:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    2304:	000c0713          	mv	a4,s8
    2308:	03412683          	lw	a3,52(sp)
    230c:	03012603          	lw	a2,48(sp)
    2310:	000d0593          	mv	a1,s10
    2314:	000c8513          	mv	a0,s9
    2318:	619010ef          	jal	4130 <osd_build>
                                    hw_frame_pushed = 0; repaint_hw = 1;
    231c:	04812783          	lw	a5,72(sp)
    2320:	02f12423          	sw	a5,40(sp)
    2324:	01412c23          	sw	s4,24(sp)
    2328:	c1dff06f          	j	1f44 <main+0xe40>
                                        g_dl_retry_bad++;
    232c:	8601a783          	lw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
    2330:	00178793          	addi	a5,a5,1
    2334:	86f1a023          	sw	a5,-1952(gp) # 7ee8 <g_dl_retry_bad>
                                        bsp_printf("EV dl retry %d/%d failed (list ran but drew no pixels)\r\n",
    2338:	00100613          	li	a2,1
    233c:	00008537          	lui	a0,0x8
    2340:	9e450513          	addi	a0,a0,-1564 # 79e4 <_data+0x18c0>
    2344:	61d020ef          	jal	5160 <bsp_printf>
                                        dl_wd_summary("retry drew no pixels");
    2348:	00008537          	lui	a0,0x8
    234c:	a2050513          	addi	a0,a0,-1504 # 7a20 <_data+0x18fc>
    2350:	724030ef          	jal	5a74 <dl_wd_summary>
    2354:	f79ff06f          	j	22cc <main+0x11c8>
                                g_dl_retry_ok++;
    2358:	8641a683          	lw	a3,-1948(gp) # 7eec <g_dl_retry_ok>
    235c:	00168693          	addi	a3,a3,1
    2360:	86d1a223          	sw	a3,-1948(gp) # 7eec <g_dl_retry_ok>
                                bsp_printf("EV dl retry %d/%d ok (cumulative ok=%d bad=%d)\r\n",
    2364:	8601a703          	lw	a4,-1952(gp) # 7ee8 <g_dl_retry_bad>
    2368:	00100613          	li	a2,1
    236c:	00008537          	lui	a0,0x8
    2370:	a5050513          	addi	a0,a0,-1456 # 7a50 <_data+0x192c>
    2374:	5ed020ef          	jal	5160 <bsp_printf>
                                g_dl_retry_n = 0;
    2378:	8601a623          	sw	zero,-1940(gp) # 7ef4 <g_dl_retry_n>
    237c:	be1ff06f          	j	1f5c <main+0xe58>
                                      g_fb_back + (uint32_t)y0 * FB_STRIDE);
    2380:	78000793          	li	a5,1920
    2384:	05012703          	lw	a4,80(sp)
    2388:	02f707b3          	mul	a5,a4,a5
                                dl_go(g_dl_pend, g_dl_pend_n,
    238c:	82c1a603          	lw	a2,-2004(gp) # 7eb4 <g_fb_back>
    2390:	00c78633          	add	a2,a5,a2
    2394:	88c1a583          	lw	a1,-1908(gp) # 7f14 <g_dl_pend_n>
    2398:	455020ef          	jal	4fec <dl_go>
                                g_dl_buf = g_dl_pend; g_dl_pend = -1;
    239c:	8141a683          	lw	a3,-2028(gp) # 7e9c <g_dl_pend>
    23a0:	88d1a823          	sw	a3,-1904(gp) # 7f18 <g_dl_buf>
    23a4:	fff00713          	li	a4,-1
    23a8:	80e1aa23          	sw	a4,-2028(gp) # 7e9c <g_dl_pend>
                                g_dl_inflight_sp = g_dl_pend_sp;   /* 成本行的 n= 跟着这张表走 */
    23ac:	8481a703          	lw	a4,-1976(gp) # 7ed0 <g_dl_pend_sp>
    23b0:	84e1a623          	sw	a4,-1972(gp) # 7ed4 <g_dl_inflight_sp>
                                if (g_dl_pend_last) { g_dl_pend_last = 0; hw_frame_pushed = 1; }
    23b4:	8881a783          	lw	a5,-1912(gp) # 7f10 <g_dl_pend_last>
    23b8:	68078063          	beqz	a5,2a38 <main+0x1934>
    23bc:	8801a423          	sw	zero,-1912(gp) # 7f10 <g_dl_pend_last>
    23c0:	04812783          	lw	a5,72(sp)
    23c4:	00f12c23          	sw	a5,24(sp)
    23c8:	6700006f          	j	2a38 <main+0x1934>
                            }
                        }
                    } else {
                        cpu_backoff(BLT_WAIT_NOP);
    23cc:	03000513          	li	a0,48
    23d0:	5d9000ef          	jal	31a8 <cpu_backoff>
    23d4:	6640006f          	j	2a38 <main+0x1934>
                    }
                } else {
                    /* 无在飞、无待发：要么发下一段，要么给本趟收尾 */
                    int fin = 0;
                    if (hw_frame_pushed) {
    23d8:	01812783          	lw	a5,24(sp)
    23dc:	06078c63          	beqz	a5,2454 <main+0x1350>
                        /* 半途打开 'l' 的情形：本趟的命令是逐条路径发的 ⇒ 用两条路径
                         * 共同的"引擎真的空闲"判据收尾（DFU 不忙 + 引擎 DONE/FIFO 空） */
                        if (poll && !(blt_rd(BLT_DL_STATUS) & DL_ST_BUSY) &&
    23e0:	04812783          	lw	a5,72(sp)
    23e4:	00078a63          	beqz	a5,23f8 <main+0x12f4>
    23e8:	05c00513          	li	a0,92
    23ec:	5dd000ef          	jal	31c8 <blt_rd>
    23f0:	00157793          	andi	a5,a0,1
    23f4:	04078663          	beqz	a5,2440 <main+0x133c>
                            blt_idle_st(blt_stat())) fin = 1;
                        else cpu_backoff(BLT_WAIT_NOP);
    23f8:	03000513          	li	a0,48
    23fc:	5ad000ef          	jal	31a8 <cpu_backoff>
                    int fin = 0;
    2400:	000b0a13          	mv	s4,s6
                        dl_go(b, c, g_fb_back + (uint32_t)y0 * FB_STRIDE);
                        g_dl_buf = b; g_dl_inflight = 1;
                        g_dl_inflight_sp = hw_i - i0;   /* ★v2.15：成本行按这张表算 */
                        if (last) hw_frame_pushed = 1;
                    }
                    if (fin) {
    2404:	620a0a63          	beqz	s4,2a38 <main+0x1934>
                        /* ★ 与逐条路径**完全同一段收尾**（口径不许有第二套） */
                        hw_frames++; hw_frame_pushed = 0; hw_i = 0;
    2408:	03812783          	lw	a5,56(sp)
    240c:	00178793          	addi	a5,a5,1
    2410:	02f12c23          	sw	a5,56(sp)
    2414:	08012423          	sw	zero,136(sp)
                        hw_fifo_full = 0;
                        hw_done = 1;
                        if (clear_pp) repaint_hw = 1;
    2418:	03412783          	lw	a5,52(sp)
    241c:	00078463          	beqz	a5,2424 <main+0x1320>
    2420:	03412423          	sw	s4,40(sp)
#if FB_FLIP_PUBLISH && FB_TRIPLE_BUFFER
                        g_pass_armed = 0;
    2424:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
#endif
                        /* ★v2.15：半途打开 'l' 时本趟的命令是逐条路径发的 ⇒ 它的秒表在这一刻
                         *   结算（成本行口径见 cmd_cost_report）。列表路径发的表 g_cmd_t0=0 ⇒ 空转。*/
                        cmd_cost_report(n);
    2428:	000c8513          	mv	a0,s9
    242c:	7d4030ef          	jal	5c00 <cmd_cost_report>
                        hw_done = 1;
    2430:	01412823          	sw	s4,16(sp)
                        hw_fifo_full = 0;
    2434:	05612623          	sw	s6,76(sp)
                        hw_frames++; hw_frame_pushed = 0; hw_i = 0;
    2438:	01612c23          	sw	s6,24(sp)
    243c:	5fc0006f          	j	2a38 <main+0x1934>
                            blt_idle_st(blt_stat())) fin = 1;
    2440:	12c010ef          	jal	356c <blt_stat>
    2444:	144010ef          	jal	3588 <blt_idle_st>
                        if (poll && !(blt_rd(BLT_DL_STATUS) & DL_ST_BUSY) &&
    2448:	fa0508e3          	beqz	a0,23f8 <main+0x12f4>
                            blt_idle_st(blt_stat())) fin = 1;
    244c:	04812a03          	lw	s4,72(sp)
    2450:	fb5ff06f          	j	2404 <main+0x1300>
                    } else if (hw_i >= n) {
    2454:	08812a83          	lw	s5,136(sp)
    2458:	fb9ad6e3          	bge	s5,s9,2404 <main+0x1300>
                        int c = 0, last = 0, b = 1 - g_dl_buf;
    245c:	06012423          	sw	zero,104(sp)
    2460:	06012623          	sw	zero,108(sp)
    2464:	8901a783          	lw	a5,-1904(gp) # 7f18 <g_dl_buf>
    2468:	00100713          	li	a4,1
    246c:	40f707b3          	sub	a5,a4,a5
    2470:	04f12423          	sw	a5,72(sp)
                        int rep = (hw_i == 0 && repaint_hw) ? dl_rep_id(path) : -1;
    2474:	000a9e63          	bnez	s5,2490 <main+0x138c>
    2478:	02812783          	lw	a5,40(sp)
    247c:	14078e63          	beqz	a5,25d8 <main+0x14d4>
    2480:	00048513          	mv	a0,s1
    2484:	560020ef          	jal	49e4 <dl_rep_id>
    2488:	04a12c23          	sw	a0,88(sp)
    248c:	00c0006f          	j	2498 <main+0x1394>
    2490:	fff00793          	li	a5,-1
    2494:	04f12c23          	sw	a5,88(sp)
                        if (hw_i == 0 && snap_hw) { scene_snap(g_sc[SIDE_HW], n); snap_hw = 0; }
    2498:	000a9663          	bnez	s5,24a4 <main+0x13a0>
    249c:	08412783          	lw	a5,132(sp)
    24a0:	14079263          	bnez	a5,25e4 <main+0x14e0>
                        if (hw_i == 0 && !g_pass_armed) {
    24a4:	08812783          	lw	a5,136(sp)
    24a8:	00079663          	bnez	a5,24b4 <main+0x13b0>
    24ac:	8c81a783          	lw	a5,-1848(gp) # 7f50 <g_pass_armed>
    24b0:	14078663          	beqz	a5,25fc <main+0x14f8>
                            int first_seg = (hw_i == 0);
    24b4:	08812783          	lw	a5,136(sp)
    24b8:	04f12e23          	sw	a5,92(sp)
                            dl_build((uint32_t *)DL_LIST_ADDR(b), &hw_i, n, scene, alpha, clear_pp,
    24bc:	04812783          	lw	a5,72(sp)
    24c0:	01179513          	slli	a0,a5,0x11
    24c4:	06c10793          	addi	a5,sp,108
    24c8:	00f12023          	sw	a5,0(sp)
    24cc:	06810893          	addi	a7,sp,104
    24d0:	05812803          	lw	a6,88(sp)
    24d4:	03412783          	lw	a5,52(sp)
    24d8:	03012703          	lw	a4,48(sp)
    24dc:	000d0693          	mv	a3,s10
    24e0:	000c8613          	mv	a2,s9
    24e4:	08810593          	addi	a1,sp,136
    24e8:	00821337          	lui	t1,0x821
    24ec:	00650533          	add	a0,a0,t1
    24f0:	508020ef          	jal	49f8 <dl_build>
                            if (rep >= 0) repaint_hw = 0;
    24f4:	05812783          	lw	a5,88(sp)
    24f8:	0007c663          	bltz	a5,2504 <main+0x1400>
    24fc:	01812783          	lw	a5,24(sp)
    2500:	02f12423          	sw	a5,40(sp)
                            if (g_dl_report && first_seg) {
    2504:	87c1a783          	lw	a5,-1924(gp) # 7f04 <g_dl_report>
    2508:	06078863          	beqz	a5,2578 <main+0x1474>
    250c:	05c12783          	lw	a5,92(sp)
    2510:	06079463          	bnez	a5,2578 <main+0x1474>
                                g_dl_probe_px = 0;
    2514:	8601ac23          	sw	zero,-1928(gp) # 7f00 <g_dl_probe_px>
                                if (!(scene == SC_FILL && b0->color == (uint16_t)COL_BG))
    2518:	000d1c63          	bnez	s10,2530 <main+0x142c>
    251c:	000087b7          	lui	a5,0x8
    2520:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2524:	0107d703          	lhu	a4,16(a5)
    2528:	00800793          	li	a5,8
    252c:	04f70663          	beq	a4,a5,2578 <main+0x1474>
                                        + (uint32_t)(b0->ty + y0 + SPR_H / 2) * FB_STRIDE
    2530:	000086b7          	lui	a3,0x8
    2534:	fb868693          	addi	a3,a3,-72 # 7fb8 <g_sc>
    2538:	00e69783          	lh	a5,14(a3)
    253c:	05012703          	lw	a4,80(sp)
    2540:	00e787b3          	add	a5,a5,a4
    2544:	8201a703          	lw	a4,-2016(gp) # 7ea8 <g_blk>
    2548:	00200613          	li	a2,2
    254c:	02c74733          	div	a4,a4,a2
    2550:	00e787b3          	add	a5,a5,a4
                                        + (uint32_t)(b0->tx + SPR_W / 2) * 2u;
    2554:	00c69683          	lh	a3,12(a3)
    2558:	00d70733          	add	a4,a4,a3
    255c:	3c000693          	li	a3,960
    2560:	02d787b3          	mul	a5,a5,a3
    2564:	00e787b3          	add	a5,a5,a4
    2568:	00179793          	slli	a5,a5,0x1
    256c:	82c1a703          	lw	a4,-2004(gp) # 7eb4 <g_fb_back>
    2570:	00e787b3          	add	a5,a5,a4
                                    g_dl_probe_px = g_fb_back
    2574:	86f1ac23          	sw	a5,-1928(gp) # 7f00 <g_dl_probe_px>
                        cache_evict();         /* 写穿屏障：描述符必须对 DDR/引擎可见 */
    2578:	6d5000ef          	jal	344c <cache_evict>
                        dl_go(b, c, g_fb_back + (uint32_t)y0 * FB_STRIDE);
    257c:	05012703          	lw	a4,80(sp)
    2580:	00471793          	slli	a5,a4,0x4
    2584:	40e787b3          	sub	a5,a5,a4
    2588:	00779793          	slli	a5,a5,0x7
    258c:	82c1a603          	lw	a2,-2004(gp) # 7eb4 <g_fb_back>
    2590:	00c78633          	add	a2,a5,a2
    2594:	06812583          	lw	a1,104(sp)
    2598:	04812503          	lw	a0,72(sp)
    259c:	251020ef          	jal	4fec <dl_go>
                        g_dl_buf = b; g_dl_inflight = 1;
    25a0:	04812703          	lw	a4,72(sp)
    25a4:	88e1a823          	sw	a4,-1904(gp) # 7f18 <g_dl_buf>
    25a8:	00100713          	li	a4,1
    25ac:	88e1aa23          	sw	a4,-1900(gp) # 7f1c <g_dl_inflight>
                        g_dl_inflight_sp = hw_i - i0;   /* ★v2.15：成本行按这张表算 */
    25b0:	08812783          	lw	a5,136(sp)
    25b4:	415787b3          	sub	a5,a5,s5
    25b8:	84f1a623          	sw	a5,-1972(gp) # 7ed4 <g_dl_inflight_sp>
                        if (last) hw_frame_pushed = 1;
    25bc:	06c12783          	lw	a5,108(sp)
    25c0:	00079463          	bnez	a5,25c8 <main+0x14c4>
    25c4:	01812a03          	lw	s4,24(sp)
    25c8:	01812783          	lw	a5,24(sp)
    25cc:	01412c23          	sw	s4,24(sp)
                    int fin = 0;
    25d0:	00078a13          	mv	s4,a5
    25d4:	e31ff06f          	j	2404 <main+0x1300>
                        int rep = (hw_i == 0 && repaint_hw) ? dl_rep_id(path) : -1;
    25d8:	fff00793          	li	a5,-1
    25dc:	04f12c23          	sw	a5,88(sp)
    25e0:	eb9ff06f          	j	2498 <main+0x1394>
                        if (hw_i == 0 && snap_hw) { scene_snap(g_sc[SIDE_HW], n); snap_hw = 0; }
    25e4:	000c8593          	mv	a1,s9
    25e8:	00008537          	lui	a0,0x8
    25ec:	fb850513          	addi	a0,a0,-72 # 7fb8 <g_sc>
    25f0:	170020ef          	jal	4760 <scene_snap>
    25f4:	08012223          	sw	zero,132(sp)
    25f8:	eadff06f          	j	24a4 <main+0x13a0>
                            g_pass_armed = 1;
    25fc:	00100713          	li	a4,1
    2600:	8ce1a423          	sw	a4,-1848(gp) # 7f50 <g_pass_armed>
                            repaint_hw = hw_pass_arm(y0, hw_h(path));
    2604:	00048513          	mv	a0,s1
    2608:	309020ef          	jal	5110 <hw_h>
    260c:	00050593          	mv	a1,a0
    2610:	05012503          	lw	a0,80(sp)
    2614:	57d000ef          	jal	3390 <hw_pass_arm>
    2618:	02a12423          	sw	a0,40(sp)
                            rep = repaint_hw ? dl_rep_id(path) : -1;
    261c:	00050a63          	beqz	a0,2630 <main+0x152c>
    2620:	00048513          	mv	a0,s1
    2624:	3c0020ef          	jal	49e4 <dl_rep_id>
    2628:	04a12c23          	sw	a0,88(sp)
    262c:	e89ff06f          	j	24b4 <main+0x13b0>
    2630:	fff00793          	li	a5,-1
    2634:	04f12c23          	sw	a5,88(sp)
    2638:	e7dff06f          	j	24b4 <main+0x13b0>
                    }
                }
            }
            /* ============ 逐条下发路径（**默认**，渲染部分一行未改）============ */
            else if (hw_frame_pushed) {
    263c:	01812783          	lw	a5,24(sp)
    2640:	06078a63          	beqz	a5,26b4 <main+0x15b0>
                /* 等引擎把本趟画完：**一圈最多读一次 STATUS**，同一个状态字复用。
                 * 轮询节奏：SPLIT/CPU 模式下下面 CPU 段每圈都要画一块，退避会拖慢它
                 * ⇒ 那两种模式每圈照读；纯硬件模式 CPU 侧本来就无活可干 ⇒
                 * 每 4 圈读一次 + 其余圈纯 ALU 退避（与 COPY 窗口同一套参数）。 */
                int poll = ((path != PATH_HW) || ((it & BLT_WAIT_MASK) == 0u)) ? 1 : 0;
    2644:	00200793          	li	a5,2
    2648:	00f49663          	bne	s1,a5,2654 <main+0x1550>
    264c:	0039f793          	andi	a5,s3,3
    2650:	04079863          	bnez	a5,26a0 <main+0x159c>
                if (poll && blt_idle_st(blt_stat())) {
    2654:	719000ef          	jal	356c <blt_stat>
    2658:	731000ef          	jal	3588 <blt_idle_st>
    265c:	04050263          	beqz	a0,26a0 <main+0x159c>
                    hw_frames++; hw_frame_pushed = 0; hw_i = 0;
    2660:	03812783          	lw	a5,56(sp)
    2664:	00178793          	addi	a5,a5,1
    2668:	02f12c23          	sw	a5,56(sp)
    266c:	08012423          	sw	zero,136(sp)
                    hw_fifo_full = 0;          /* 新一趟从"未知"开始，第一圈就正常读 */
                    hw_done = 1;
                    if (clear_pp) repaint_hw = 1;
    2670:	03412783          	lw	a5,52(sp)
    2674:	00078663          	beqz	a5,2680 <main+0x157c>
    2678:	01812783          	lw	a5,24(sp)
    267c:	02f12423          	sw	a5,40(sp)
#if FB_TRIPLE_BUFFER
                    g_pass_armed = 0;          /* ★v2.7：下一趟开头重新做"查 clean + 选目标 + 下清屏命令" */
    2680:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
#endif
                    /* ★v2.15 成本行（同口径对照）：本趟是逐条路径推的 + 引擎已空闲 ⇒
                     *   用本趟起点到此刻的墙钟拍数算一次"逐条路径 pi/精灵"，与列表路径那行
                     *   直接比大小。1Hz 门控、稳态每秒最多一行（见 cmd_cost_report）。 */
                    cmd_cost_report(n);
    2684:	000c8513          	mv	a0,s9
    2688:	578030ef          	jal	5c00 <cmd_cost_report>
                    hw_done = 1;
    268c:	01812783          	lw	a5,24(sp)
    2690:	00f12823          	sw	a5,16(sp)
                    hw_fifo_full = 0;          /* 新一趟从"未知"开始，第一圈就正常读 */
    2694:	01612c23          	sw	s6,24(sp)
                    hw_frames++; hw_frame_pushed = 0; hw_i = 0;
    2698:	05612623          	sw	s6,76(sp)
                    cmd_cost_report(n);
    269c:	39c0006f          	j	2a38 <main+0x1934>
                } else if (path == PATH_HW) {
    26a0:	00200793          	li	a5,2
    26a4:	38f49a63          	bne	s1,a5,2a38 <main+0x1934>
                    cpu_backoff(BLT_WAIT_NOP);
    26a8:	03000513          	li	a0,48
    26ac:	2fd000ef          	jal	31a8 <cpu_backoff>
    26b0:	3880006f          	j	2a38 <main+0x1934>
                }
            } else {
                int y0 = hw_y0(path);
    26b4:	00048513          	mv	a0,s1
    26b8:	251020ef          	jal	5108 <hw_y0>
    26bc:	04a12423          	sw	a0,72(sp)
                 *   先按 BLT_WAIT_MASK 退避几圈再读 —— 引擎取一条指令要几十 us、
                 *   而 FIFO 还有 200 条的缓冲，退避 4*~2us 绝不会把引擎饿着，却能把
                 *   "满时每圈一次 COUNT 读"降到 1/4（N=6000 那种长指令流时才走到这里）。
                 *   SPLIT/CPU 模式不这么干：下面 CPU 段每圈都要画一块，退避会拖慢
                 *   CPU 侧的诚实工作量。 */
                if (hw_fifo_full && path == PATH_HW && ((it & BLT_WAIT_MASK) != 0u)) {
    26c0:	04c12783          	lw	a5,76(sp)
    26c4:	02078063          	beqz	a5,26e4 <main+0x15e0>
    26c8:	00200793          	li	a5,2
    26cc:	00f49c63          	bne	s1,a5,26e4 <main+0x15e0>
    26d0:	0039f793          	andi	a5,s3,3
    26d4:	00078863          	beqz	a5,26e4 <main+0x15e0>
                    cpu_backoff(BLT_WAIT_NOP);
    26d8:	03000513          	li	a0,48
    26dc:	2cd000ef          	jal	31a8 <cpu_backoff>
    26e0:	3580006f          	j	2a38 <main+0x1934>
                } else {
                    uint32_t room = blt_push_room();
    26e4:	6b5000ef          	jal	3598 <blt_push_room>
    26e8:	00050a93          	mv	s5,a0
                    /* ★ 一趟的起点：把场景位置冻进 (tx,ty)（hw_i==0 且上一趟已完成）。
                     *   放在 FIFO 余量判断之前 —— 即使这圈 FIFO 满、一条都推不出去，
                     *   快照也已就位，本趟剩下所有块必然用同一个位置。
                     *   ★v2.15：这**也**是一趟的计时起点（成本行的逐条路径口径）：
                     *   只在本趟还没开始计时时置一次，跑完由 cmd_cost_report() 清零。 */
                    if (hw_i == 0 && snap_hw) { scene_snap(g_sc[SIDE_HW], n); snap_hw = 0; }
    26ec:	08812783          	lw	a5,136(sp)
    26f0:	00079663          	bnez	a5,26fc <main+0x15f8>
    26f4:	08412783          	lw	a5,132(sp)
    26f8:	04079863          	bnez	a5,2748 <main+0x1644>
                    if (hw_i == 0 && g_cmd_t0 == 0) g_cmd_t0 = tick32();
    26fc:	08812783          	lw	a5,136(sp)
    2700:	00079663          	bnez	a5,270c <main+0x1608>
    2704:	8441a783          	lw	a5,-1980(gp) # 7ecc <g_cmd_t0>
    2708:	04078c63          	beqz	a5,2760 <main+0x165c>
#if FB_FLIP_PUBLISH && FB_TRIPLE_BUFFER
                    /* ---------------- ★v2.7 三缓冲：本趟开画前的一次性动作 ----------------
                     * ①~⑤ 的顺序与理由见 hw_pass_arm() 的注释（列表路径共用同一段）。
                     *   ④ 不干净 → **退回改动前那条命令式区域清屏**（发一条 FILL 整片）：
                     *      语义与老版本逐位相同，宁可多花 568k 周期也绝不在一张脏底上作画。 */
                    if (hw_i == 0 && !g_pass_armed) {
    270c:	08812783          	lw	a5,136(sp)
    2710:	00079663          	bnez	a5,271c <main+0x1618>
    2714:	8c81a783          	lw	a5,-1848(gp) # 7f50 <g_pass_armed>
    2718:	04078a63          	beqz	a5,276c <main+0x1668>
                        g_pass_armed = 1;
                        repaint_hw = hw_pass_arm(y0, hw_h(path));
                    }
#endif
                    if (repaint_hw && room > 0u) {
    271c:	02812783          	lw	a5,40(sp)
    2720:	00078463          	beqz	a5,2728 <main+0x1624>
    2724:	060a9663          	bnez	s5,2790 <main+0x168c>
                        blt_fill(g_fb_back + (uint32_t)y0 * FB_STRIDE, FB_STRIDE,
                                 FB_WIDTH, (uint32_t)hw_h(path), COL_BG);
                        repaint_hw = 0;
    2728:	04000793          	li	a5,64
    272c:	04912623          	sw	s1,76(sp)
    2730:	05312823          	sw	s3,80(sp)
    2734:	05712c23          	sw	s7,88(sp)
    2738:	03412b83          	lw	s7,52(sp)
    273c:	05412e23          	sw	s4,92(sp)
    2740:	04812b03          	lw	s6,72(sp)
    2744:	1900006f          	j	28d4 <main+0x17d0>
                    if (hw_i == 0 && snap_hw) { scene_snap(g_sc[SIDE_HW], n); snap_hw = 0; }
    2748:	000c8593          	mv	a1,s9
    274c:	00008537          	lui	a0,0x8
    2750:	fb850513          	addi	a0,a0,-72 # 7fb8 <g_sc>
    2754:	00c020ef          	jal	4760 <scene_snap>
    2758:	08012223          	sw	zero,132(sp)
    275c:	fa1ff06f          	j	26fc <main+0x15f8>
                    if (hw_i == 0 && g_cmd_t0 == 0) g_cmd_t0 = tick32();
    2760:	23d000ef          	jal	319c <tick32>
    2764:	84a1a223          	sw	a0,-1980(gp) # 7ecc <g_cmd_t0>
    2768:	fa5ff06f          	j	270c <main+0x1608>
                        g_pass_armed = 1;
    276c:	00100713          	li	a4,1
    2770:	8ce1a423          	sw	a4,-1848(gp) # 7f50 <g_pass_armed>
                        repaint_hw = hw_pass_arm(y0, hw_h(path));
    2774:	00048513          	mv	a0,s1
    2778:	199020ef          	jal	5110 <hw_h>
    277c:	00050593          	mv	a1,a0
    2780:	04812503          	lw	a0,72(sp)
    2784:	40d000ef          	jal	3390 <hw_pass_arm>
    2788:	02a12423          	sw	a0,40(sp)
    278c:	f91ff06f          	j	271c <main+0x1618>
                        blt_fill(g_fb_back + (uint32_t)y0 * FB_STRIDE, FB_STRIDE,
    2790:	78000b13          	li	s6,1920
    2794:	04812783          	lw	a5,72(sp)
    2798:	03678b33          	mul	s6,a5,s6
    279c:	82c1a783          	lw	a5,-2004(gp) # 7eb4 <g_fb_back>
    27a0:	00fb0b33          	add	s6,s6,a5
                                 FB_WIDTH, (uint32_t)hw_h(path), COL_BG);
    27a4:	00048513          	mv	a0,s1
    27a8:	169020ef          	jal	5110 <hw_h>
    27ac:	00050693          	mv	a3,a0
                        blt_fill(g_fb_back + (uint32_t)y0 * FB_STRIDE, FB_STRIDE,
    27b0:	00800713          	li	a4,8
    27b4:	3c000613          	li	a2,960
    27b8:	78000593          	li	a1,1920
    27bc:	000b0513          	mv	a0,s6
    27c0:	64d000ef          	jal	360c <blt_fill>
                        room--;
    27c4:	fffa8a93          	addi	s5,s5,-1
                        repaint_hw = 0;
    27c8:	01812783          	lw	a5,24(sp)
    27cc:	02f12423          	sw	a5,40(sp)
    27d0:	f59ff06f          	j	2728 <main+0x1624>
                         *   其余可以"没动就不擦"。FILL/KEY 是幂等的（重画同一块结果不变），
                         *   而 ALPHA 是 dest = blend(src, dest) —— 不擦就再混一次 ⇒ 一次比
                         *   一次暗。板级现象正是：方块不动时逐帧变暗、每次场景步进（移动后
                         *   才擦）亮度恢复 ⇒ 以 25Hz 周期性忽明忽暗。
                         *   擦 + 画是两条引擎指令 ⇒ need=2，两条一起凑够余量才发，绝不半发。 */
                        if (!clear_pp && ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty)))
    27d4:	000087b7          	lui	a5,0x8
    27d8:	00249713          	slli	a4,s1,0x2
    27dc:	00970733          	add	a4,a4,s1
    27e0:	00271713          	slli	a4,a4,0x2
    27e4:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    27e8:	00e787b3          	add	a5,a5,a4
    27ec:	00a79703          	lh	a4,10(a5)
    27f0:	00e79783          	lh	a5,14(a5)
    27f4:	00f70663          	beq	a4,a5,2800 <main+0x16fc>
                            need = 2u;
    27f8:	00200993          	li	s3,2
    27fc:	0100006f          	j	280c <main+0x1708>
                        uint32_t need = 1u;
    2800:	00100993          	li	s3,1
    2804:	0080006f          	j	280c <main+0x1708>
    2808:	00100993          	li	s3,1
                        if (room < need) break;
    280c:	1f3ae863          	bltu	s5,s3,29fc <main+0x18f8>
                        if (need == 2u)
    2810:	00200793          	li	a5,2
    2814:	10f98a63          	beq	s3,a5,2928 <main+0x1824>
                            blt_fill(g_fb_back + (uint32_t)(b->dy + y0) * FB_STRIDE
                                              + (uint32_t)b->dx * 2u,
                                     FB_STRIDE, b->sz, b->sz, COL_BG);
                        {                                              /* 立刻画到本趟快照位置 */
                            uint32_t dst = g_fb_back + (uint32_t)(b->ty + y0) * FB_STRIDE
    2818:	000087b7          	lui	a5,0x8
    281c:	00249713          	slli	a4,s1,0x2
    2820:	00970733          	add	a4,a4,s1
    2824:	00271713          	slli	a4,a4,0x2
    2828:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    282c:	00e787b3          	add	a5,a5,a4
    2830:	00e79703          	lh	a4,14(a5)
    2834:	01670733          	add	a4,a4,s6
                                                 + (uint32_t)b->tx * 2u;
    2838:	00c79783          	lh	a5,12(a5)
    283c:	00471513          	slli	a0,a4,0x4
    2840:	40e50533          	sub	a0,a0,a4
    2844:	00651513          	slli	a0,a0,0x6
    2848:	00f50533          	add	a0,a0,a5
    284c:	00151513          	slli	a0,a0,0x1
    2850:	82c1a783          	lw	a5,-2004(gp) # 7eb4 <g_fb_back>
                            uint32_t dst = g_fb_back + (uint32_t)(b->ty + y0) * FB_STRIDE
    2854:	00f50533          	add	a0,a0,a5
                            if (scene == SC_FILL)
    2858:	120d0463          	beqz	s10,2980 <main+0x187c>
                                blt_fill(dst, FB_STRIDE, b->sz, b->sz, b->color);
                            else if (scene == SC_ALPHA)
    285c:	00100793          	li	a5,1
    2860:	14fd0863          	beq	s10,a5,29b0 <main+0x18ac>
                                blt_alpha(ATLAS_BASE, dst, SPR_STRIDE, FB_STRIDE,
                                          SPR_W, SPR_H, alpha);
                            else
                                blt_key(ATLAS_BASE, dst, SPR_STRIDE, FB_STRIDE,
    2864:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    2868:	00010837          	lui	a6,0x10
    286c:	81f80813          	addi	a6,a6,-2017 # f81f <__global_pointer$+0x7197>
    2870:	00078713          	mv	a4,a5
    2874:	78000693          	li	a3,1920
    2878:	00179613          	slli	a2,a5,0x1
    287c:	00050593          	mv	a1,a0
    2880:	00201537          	lui	a0,0x201
    2884:	601000ef          	jal	3684 <blt_key>
                                        SPR_W, SPR_H, KEY_COLOR);
                        }
                        b->dx = b->tx; b->dy = b->ty;                  /* 记账：画的就是快照位置 */
    2888:	00008737          	lui	a4,0x8
    288c:	fb870713          	addi	a4,a4,-72 # 7fb8 <g_sc>
    2890:	00249693          	slli	a3,s1,0x2
    2894:	009687b3          	add	a5,a3,s1
    2898:	00279793          	slli	a5,a5,0x2
    289c:	00f707b3          	add	a5,a4,a5
    28a0:	00c79603          	lh	a2,12(a5)
    28a4:	00c79423          	sh	a2,8(a5)
    28a8:	00e79783          	lh	a5,14(a5)
    28ac:	009686b3          	add	a3,a3,s1
    28b0:	00269693          	slli	a3,a3,0x2
    28b4:	00d70733          	add	a4,a4,a3
    28b8:	00f71523          	sh	a5,10(a4)
                        room -= need;
    28bc:	413a8ab3          	sub	s5,s5,s3
                        if (++hw_i >= n) { hw_frame_pushed = 1; break; }
    28c0:	08812783          	lw	a5,136(sp)
    28c4:	00178793          	addi	a5,a5,1
    28c8:	08f12423          	sw	a5,136(sp)
    28cc:	1197dc63          	bge	a5,s9,29e4 <main+0x18e0>
                    while (hw_i < n && room > 0u && budget-- > 0u) {
    28d0:	000a0793          	mv	a5,s4
    28d4:	08812483          	lw	s1,136(sp)
    28d8:	1394da63          	bge	s1,s9,2a0c <main+0x1908>
    28dc:	140a8463          	beqz	s5,2a24 <main+0x1920>
    28e0:	fff78a13          	addi	s4,a5,-1
    28e4:	0e078863          	beqz	a5,29d4 <main+0x18d0>
                        if (!clear_pp && ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty)))
    28e8:	f20b90e3          	bnez	s7,2808 <main+0x1704>
    28ec:	00100793          	li	a5,1
    28f0:	02fd0863          	beq	s10,a5,2920 <main+0x181c>
    28f4:	000087b7          	lui	a5,0x8
    28f8:	00249713          	slli	a4,s1,0x2
    28fc:	00970733          	add	a4,a4,s1
    2900:	00271713          	slli	a4,a4,0x2
    2904:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2908:	00e787b3          	add	a5,a5,a4
    290c:	00879703          	lh	a4,8(a5)
    2910:	00c79783          	lh	a5,12(a5)
    2914:	ecf700e3          	beq	a4,a5,27d4 <main+0x16d0>
                            need = 2u;
    2918:	00200993          	li	s3,2
    291c:	ef1ff06f          	j	280c <main+0x1708>
    2920:	00200993          	li	s3,2
    2924:	ee9ff06f          	j	280c <main+0x1708>
                            blt_fill(g_fb_back + (uint32_t)(b->dy + y0) * FB_STRIDE
    2928:	00008737          	lui	a4,0x8
    292c:	00249793          	slli	a5,s1,0x2
    2930:	009787b3          	add	a5,a5,s1
    2934:	00279793          	slli	a5,a5,0x2
    2938:	fb870713          	addi	a4,a4,-72 # 7fb8 <g_sc>
    293c:	00f70733          	add	a4,a4,a5
    2940:	00a71683          	lh	a3,10(a4)
    2944:	016686b3          	add	a3,a3,s6
                                              + (uint32_t)b->dx * 2u,
    2948:	00871603          	lh	a2,8(a4)
    294c:	00469793          	slli	a5,a3,0x4
    2950:	40d787b3          	sub	a5,a5,a3
    2954:	00679793          	slli	a5,a5,0x6
    2958:	00c787b3          	add	a5,a5,a2
    295c:	00179793          	slli	a5,a5,0x1
    2960:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
                                     FB_STRIDE, b->sz, b->sz, COL_BG);
    2964:	01274603          	lbu	a2,18(a4)
                            blt_fill(g_fb_back + (uint32_t)(b->dy + y0) * FB_STRIDE
    2968:	00800713          	li	a4,8
    296c:	00060693          	mv	a3,a2
    2970:	78000593          	li	a1,1920
    2974:	00a78533          	add	a0,a5,a0
    2978:	495000ef          	jal	360c <blt_fill>
    297c:	e9dff06f          	j	2818 <main+0x1714>
                                blt_fill(dst, FB_STRIDE, b->sz, b->sz, b->color);
    2980:	000087b7          	lui	a5,0x8
    2984:	00249713          	slli	a4,s1,0x2
    2988:	00970733          	add	a4,a4,s1
    298c:	00271713          	slli	a4,a4,0x2
    2990:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2994:	00e787b3          	add	a5,a5,a4
    2998:	0127c603          	lbu	a2,18(a5)
    299c:	0107d703          	lhu	a4,16(a5)
    29a0:	00060693          	mv	a3,a2
    29a4:	78000593          	li	a1,1920
    29a8:	465000ef          	jal	360c <blt_fill>
    29ac:	eddff06f          	j	2888 <main+0x1784>
                                blt_alpha(ATLAS_BASE, dst, SPR_STRIDE, FB_STRIDE,
    29b0:	8201a783          	lw	a5,-2016(gp) # 7ea8 <g_blk>
    29b4:	03012803          	lw	a6,48(sp)
    29b8:	00078713          	mv	a4,a5
    29bc:	78000693          	li	a3,1920
    29c0:	00179613          	slli	a2,a5,0x1
    29c4:	00050593          	mv	a1,a0
    29c8:	00201537          	lui	a0,0x201
    29cc:	47d000ef          	jal	3648 <blt_alpha>
    29d0:	eb9ff06f          	j	2888 <main+0x1784>
    29d4:	04c12483          	lw	s1,76(sp)
    29d8:	05012983          	lw	s3,80(sp)
    29dc:	05812b83          	lw	s7,88(sp)
    29e0:	0380006f          	j	2a18 <main+0x1914>
                        if (++hw_i >= n) { hw_frame_pushed = 1; break; }
    29e4:	04c12483          	lw	s1,76(sp)
    29e8:	05012983          	lw	s3,80(sp)
    29ec:	05812b83          	lw	s7,88(sp)
    29f0:	05c12a03          	lw	s4,92(sp)
    29f4:	01412c23          	sw	s4,24(sp)
    29f8:	0200006f          	j	2a18 <main+0x1914>
    29fc:	04c12483          	lw	s1,76(sp)
    2a00:	05012983          	lw	s3,80(sp)
    2a04:	05812b83          	lw	s7,88(sp)
    2a08:	0100006f          	j	2a18 <main+0x1914>
    2a0c:	04c12483          	lw	s1,76(sp)
    2a10:	05012983          	lw	s3,80(sp)
    2a14:	05812b83          	lw	s7,88(sp)
                    }
                    hw_fifo_full = (room == 0u) ? 1 : 0;   /* 满了 ⇒ 下一圈先退避 */
    2a18:	001ab793          	seqz	a5,s5
    2a1c:	04f12623          	sw	a5,76(sp)
    2a20:	0180006f          	j	2a38 <main+0x1934>
    2a24:	04c12483          	lw	s1,76(sp)
    2a28:	05012983          	lw	s3,80(sp)
    2a2c:	05812b83          	lw	s7,88(sp)
    2a30:	fe9ff06f          	j	2a18 <main+0x1914>
                        hw_i = 0; hw_frame_pushed = 0; repaint_hw = 1;
    2a34:	03412423          	sw	s4,40(sp)
        }

        /* ---------------- CPU 侧：每圈一块，相邻式擦+画，同样用本趟快照 ----------------
         * ★ 语义与 comptest2 完全一致（先擦后画、逐块擦旧矩形），**不跟随 clear_pp**：
         *   这是"纯 CPU"该有的工作量，动了它 CPU-vs-HW 的帧率对比就不诚实了。 */
        if (!back_busy && path != PATH_HW) {
    2a38:	12041663          	bnez	s0,2b64 <main+0x1a60>
    2a3c:	00200793          	li	a5,2
    2a40:	12f48263          	beq	s1,a5,2b64 <main+0x1a60>
            int y0 = cpu_y0(path);
    2a44:	00048513          	mv	a0,s1
    2a48:	6dc020ef          	jal	5124 <cpu_y0>
    2a4c:	00050a13          	mv	s4,a0
            blk_t *b;
            /* 一趟的起点（cpu_i==0）：CPU 侧的快照点，与硬件侧同理 */
            if (cpu_i == 0 && snap_cpu) { scene_snap(g_sc[SIDE_CPU], n); snap_cpu = 0; }
    2a50:	00091663          	bnez	s2,2a5c <main+0x1958>
    2a54:	08012783          	lw	a5,128(sp)
    2a58:	2c079a63          	bnez	a5,2d2c <main+0x1c28>
            if (repaint_cpu) {                 /* 场景/路径刚变过 → 先把这片区域铺背景 */
    2a5c:	01c12783          	lw	a5,28(sp)
    2a60:	2e079263          	bnez	a5,2d44 <main+0x1c40>
                cpu_fill32(g_fb_back, 0, cpu_y0(path), FB_WIDTH, cpu_h(path), COL_BG);
                repaint_cpu = 0;
            }
            b = &g_sc[SIDE_CPU][cpu_i];
            /* 同硬件侧：ALPHA 必须每次重铺背景（否则混合逐次叠加、越来越暗） */
            if ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty))
    2a64:	00100793          	li	a5,1
    2a68:	02fd0863          	beq	s10,a5,2a98 <main+0x1994>
    2a6c:	000087b7          	lui	a5,0x8
    2a70:	00291713          	slli	a4,s2,0x2
    2a74:	01270733          	add	a4,a4,s2
    2a78:	00271713          	slli	a4,a4,0x2
    2a7c:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2a80:	00e787b3          	add	a5,a5,a4
    2a84:	0001d737          	lui	a4,0x1d
    2a88:	00f707b3          	add	a5,a4,a5
    2a8c:	4c879703          	lh	a4,1224(a5)
    2a90:	4cc79783          	lh	a5,1228(a5)
    2a94:	2ef70063          	beq	a4,a5,2d74 <main+0x1c70>
                cpu_fill32(g_fb_back, b->dx, b->dy + y0, b->sz, b->sz, COL_BG);
    2a98:	000087b7          	lui	a5,0x8
    2a9c:	00291713          	slli	a4,s2,0x2
    2aa0:	01270733          	add	a4,a4,s2
    2aa4:	00271713          	slli	a4,a4,0x2
    2aa8:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2aac:	00e787b3          	add	a5,a5,a4
    2ab0:	0001d837          	lui	a6,0x1d
    2ab4:	00f80833          	add	a6,a6,a5
    2ab8:	4ca81603          	lh	a2,1226(a6) # 1d4ca <__global_pointer$+0x14e42>
    2abc:	4d284683          	lbu	a3,1234(a6)
    2ac0:	00800793          	li	a5,8
    2ac4:	00068713          	mv	a4,a3
    2ac8:	01460633          	add	a2,a2,s4
    2acc:	4c881583          	lh	a1,1224(a6)
    2ad0:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    2ad4:	695000ef          	jal	3968 <cpu_fill32>
            if (scene == SC_FILL)
    2ad8:	2c0d0663          	beqz	s10,2da4 <main+0x1ca0>
                cpu_fill32(g_fb_back, b->tx, b->ty + y0, b->sz, b->sz, b->color);
            else if (scene == SC_ALPHA)
    2adc:	00100793          	li	a5,1
    2ae0:	30fd0463          	beq	s10,a5,2de8 <main+0x1ce4>
                cpu_alpha_sprite(b->tx, b->ty + y0, alpha);
            else
                cpu_key_sprite(b->tx, b->ty + y0);
    2ae4:	000087b7          	lui	a5,0x8
    2ae8:	00291713          	slli	a4,s2,0x2
    2aec:	01270733          	add	a4,a4,s2
    2af0:	00271713          	slli	a4,a4,0x2
    2af4:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2af8:	00e787b3          	add	a5,a5,a4
    2afc:	0001d737          	lui	a4,0x1d
    2b00:	00f707b3          	add	a5,a4,a5
    2b04:	4ce79583          	lh	a1,1230(a5)
    2b08:	014585b3          	add	a1,a1,s4
    2b0c:	4cc79503          	lh	a0,1228(a5)
    2b10:	0c8010ef          	jal	3bd8 <cpu_key_sprite>
            b->dx = b->tx; b->dy = b->ty;
    2b14:	00008737          	lui	a4,0x8
    2b18:	00291793          	slli	a5,s2,0x2
    2b1c:	012787b3          	add	a5,a5,s2
    2b20:	00279793          	slli	a5,a5,0x2
    2b24:	fb870713          	addi	a4,a4,-72 # 7fb8 <g_sc>
    2b28:	00f70733          	add	a4,a4,a5
    2b2c:	0001d7b7          	lui	a5,0x1d
    2b30:	00e787b3          	add	a5,a5,a4
    2b34:	4cc79703          	lh	a4,1228(a5) # 1d4cc <__global_pointer$+0x14e44>
    2b38:	4ce79423          	sh	a4,1224(a5)
    2b3c:	4ce79703          	lh	a4,1230(a5)
    2b40:	4ce79523          	sh	a4,1226(a5)
            if (++cpu_i >= n) {
    2b44:	00190913          	addi	s2,s2,1
    2b48:	01994e63          	blt	s2,s9,2b64 <main+0x1a60>
                cpu_i = 0; cpu_frames++;
    2b4c:	02012783          	lw	a5,32(sp)
    2b50:	00178793          	addi	a5,a5,1
    2b54:	02f12023          	sw	a5,32(sp)
    2b58:	00040913          	mv	s2,s0
                cpu_done = 1;
    2b5c:	00100793          	li	a5,1
    2b60:	00f12a23          	sw	a5,20(sp)
         *   就轮到它上屏。所以判据多一个 `!g_bar_ok[]`：内容变了（两个缓冲都作废）
         *   或本缓冲还没画过就重画。稳态下每个缓冲每种内容只画一次。 */
#if FB_FLIP_PUBLISH
#if FB_TRIPLE_BUFFER
        /* ★v2.7 三缓冲：信息条要落在**当前正在画的那块**（g_draw3）里 —— 下一趟就轮到它上屏 */
        if (!back_busy && (g_osd_dirty || !g_bar_ok[g_draw3])) {
    2b64:	06041463          	bnez	s0,2bcc <main+0x1ac8>
    2b68:	8181a783          	lw	a5,-2024(gp) # 7ea0 <g_osd_dirty>
    2b6c:	00079c63          	bnez	a5,2b84 <main+0x1a80>
    2b70:	8281a783          	lw	a5,-2008(gp) # 7eb0 <g_draw3>
    2b74:	8d018713          	addi	a4,gp,-1840 # 7f58 <g_bar_ok>
    2b78:	00e787b3          	add	a5,a5,a4
    2b7c:	0007c783          	lbu	a5,0(a5)
    2b80:	04079663          	bnez	a5,2bcc <main+0x1ac8>
            osd_blit(g_osd_line, path_label(path));
    2b84:	00048513          	mv	a0,s1
    2b88:	3d8010ef          	jal	3f60 <path_label>
    2b8c:	00050593          	mv	a1,a0
    2b90:	8ec18513          	addi	a0,gp,-1812 # 7f74 <g_osd_line>
    2b94:	710010ef          	jal	42a4 <osd_blit>
            /* 分隔条只在分屏模式画：单模式是整屏渲染，中间不该有一条线 */
            if (path == PATH_SPLIT)
    2b98:	28048463          	beqz	s1,2e20 <main+0x1d1c>
                cpu_fill32(g_fb_back, 0, TOP_Y0 + HALF_H, FB_WIDTH, SEP_H, COL_SEP);
            if (g_osd_dirty) { g_bar_ok[0] = 0; g_bar_ok[1] = 0; g_bar_ok[2] = 0; }
    2b9c:	8181a783          	lw	a5,-2024(gp) # 7ea0 <g_osd_dirty>
    2ba0:	00078a63          	beqz	a5,2bb4 <main+0x1ab0>
    2ba4:	8c018823          	sb	zero,-1840(gp) # 7f58 <g_bar_ok>
    2ba8:	8d018793          	addi	a5,gp,-1840 # 7f58 <g_bar_ok>
    2bac:	000780a3          	sb	zero,1(a5)
    2bb0:	00078123          	sb	zero,2(a5)
            g_bar_ok[g_draw3] = 1;
    2bb4:	8281a783          	lw	a5,-2008(gp) # 7eb0 <g_draw3>
    2bb8:	8d018713          	addi	a4,gp,-1840 # 7f58 <g_bar_ok>
    2bbc:	00e787b3          	add	a5,a5,a4
    2bc0:	00100713          	li	a4,1
    2bc4:	00e78023          	sb	a4,0(a5)
            g_osd_dirty = 0;
    2bc8:	8001ac23          	sw	zero,-2024(gp) # 7ea0 <g_osd_dirty>
        it++;
    2bcc:	00198993          	addi	s3,s3,1
        if ((it & SLOW_MASK) == 0u) {
    2bd0:	01f9fa13          	andi	s4,s3,31
    2bd4:	000a1463          	bnez	s4,2bdc <main+0x1ad8>
    2bd8:	941fe06f          	j	1518 <main+0x414>
        if (!back_busy && split_setup) {
    2bdc:	08041a63          	bnez	s0,2c70 <main+0x1b6c>
    2be0:	080d8863          	beqz	s11,2c70 <main+0x1b6c>
            if (was == 1) {
    2be4:	00100793          	li	a5,1
    2be8:	00fd9463          	bne	s11,a5,2bf0 <main+0x1aec>
    2bec:	ecdfe06f          	j	1ab8 <main+0x9b4>
                g_draw3    = (int)((g_disp_sel + 1u) % 3u);
    2bf0:	8dc1a783          	lw	a5,-1828(gp) # 7f64 <g_disp_sel>
    2bf4:	00178513          	addi	a0,a5,1
    2bf8:	00300713          	li	a4,3
    2bfc:	02e57533          	remu	a0,a0,a4
    2c00:	82a1a423          	sw	a0,-2008(gp) # 7eb0 <g_draw3>
                g_clr3     = (int)((g_disp_sel + 2u) % 3u);
    2c04:	00278793          	addi	a5,a5,2
    2c08:	02e7f7b3          	remu	a5,a5,a4
    2c0c:	82f1a223          	sw	a5,-2012(gp) # 7eac <g_clr3>
                g_fb_back  = fb_of_sel((uint32_t)g_draw3);
    2c10:	5c8000ef          	jal	31d8 <fb_of_sel>
    2c14:	82a1a623          	sw	a0,-2004(gp) # 7eb4 <g_fb_back>
                g_clr_need = 1;
    2c18:	00100713          	li	a4,1
    2c1c:	8ce1a623          	sw	a4,-1844(gp) # 7f54 <g_clr_need>
            g_pass_armed       = 0;
    2c20:	8c01a423          	sw	zero,-1848(gp) # 7f50 <g_pass_armed>
            g_bar_ok[g_draw3]  = 0;          /* 新目标里没有信息条 ⇒ 强制重画 */
    2c24:	8281a603          	lw	a2,-2008(gp) # 7eb0 <g_draw3>
    2c28:	8d018793          	addi	a5,gp,-1840 # 7f58 <g_bar_ok>
    2c2c:	00f607b3          	add	a5,a2,a5
    2c30:	00078023          	sb	zero,0(a5)
            hw_i = 0; hw_frame_pushed = 0; cpu_i = 0;
    2c34:	08012423          	sw	zero,136(sp)
            bsp_printf("\r\nEV split inplace=%d draw=%d disp=%d\r\n",
    2c38:	fffd8593          	addi	a1,s11,-1
    2c3c:	8dc1a683          	lw	a3,-1828(gp) # 7f64 <g_disp_sel>
    2c40:	0015b593          	seqz	a1,a1
    2c44:	00007537          	lui	a0,0x7
    2c48:	70850513          	addi	a0,a0,1800 # 7708 <_data+0x15e4>
    2c4c:	514020ef          	jal	5160 <bsp_printf>
            split_setup = 0;
    2c50:	00040d93          	mv	s11,s0
            hw_done = 0; cpu_done = 0;
    2c54:	00812a23          	sw	s0,20(sp)
    2c58:	00812823          	sw	s0,16(sp)
            hw_i = 0; hw_frame_pushed = 0; cpu_i = 0;
    2c5c:	00040913          	mv	s2,s0
    2c60:	00812c23          	sw	s0,24(sp)
            repaint_hw = 1; repaint_cpu = 1;
    2c64:	00100793          	li	a5,1
    2c68:	00f12e23          	sw	a5,28(sp)
    2c6c:	02f12423          	sw	a5,40(sp)
        if (back_busy) {
    2c70:	00041463          	bnez	s0,2c78 <main+0x1b74>
    2c74:	fd9fe06f          	j	1c4c <main+0xb48>
            if (snap_hw)  { scene_snap(g_sc[SIDE_HW],  n); snap_hw  = 0; }
    2c78:	08412783          	lw	a5,132(sp)
    2c7c:	00078463          	beqz	a5,2c84 <main+0x1b80>
    2c80:	e51fe06f          	j	1ad0 <main+0x9cc>
            if (snap_cpu) { scene_snap(g_sc[SIDE_CPU], n); snap_cpu = 0; }
    2c84:	08012783          	lw	a5,128(sp)
    2c88:	00078463          	beqz	a5,2c90 <main+0x1b8c>
    2c8c:	e5dfe06f          	j	1ae8 <main+0x9e4>
            if (((uint32_t)(t_now - g_osd_t0) >= (uint32_t)BSP_CLINT_HZ) &&
    2c90:	8b41a703          	lw	a4,-1868(gp) # 7f3c <g_osd_t0>
    2c94:	40eb8733          	sub	a4,s7,a4
    2c98:	05f5e7b7          	lui	a5,0x5f5e
    2c9c:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f1a7bf>
    2ca0:	00e7f463          	bgeu	a5,a4,2ca8 <main+0x1ba4>
    2ca4:	e5dfe06f          	j	1b00 <main+0x9fc>
            if ((it & BLT_WAIT_MASK) == 0u) {
    2ca8:	0039f793          	andi	a5,s3,3
    2cac:	00078463          	beqz	a5,2cb4 <main+0x1bb0>
    2cb0:	f81fe06f          	j	1c30 <main+0xb2c>
                    uint32_t irq = blt_rd(BLT_IRQ_STATUS);
    2cb4:	01000513          	li	a0,16
    2cb8:	510000ef          	jal	31c8 <blt_rd>
                    if (irq & BLT_IRQ_FRAME) {
    2cbc:	00257513          	andi	a0,a0,2
    2cc0:	02050063          	beqz	a0,2ce0 <main+0x1bdc>
                        blt_wr(BLT_IRQ_STATUS, BLT_IRQ_FRAME);   /* W1C：清本场中断 */
    2cc4:	00200593          	li	a1,2
    2cc8:	01000513          	li	a0,16
    2ccc:	4ec000ef          	jal	31b8 <blt_wr>
                if (flip_ev && (fb_stat_sel() == g_flip_req)) {
    2cd0:	530000ef          	jal	3200 <fb_stat_sel>
    2cd4:	8d81a783          	lw	a5,-1832(gp) # 7f60 <g_flip_req>
    2cd8:	00f51463          	bne	a0,a5,2ce0 <main+0x1bdc>
    2cdc:	e75fe06f          	j	1b50 <main+0xa4c>
                } else if ((uint32_t)(tick32() - back_t0) > (uint32_t)FLIP_TIMEOUT_TICKS) {
    2ce0:	4bc000ef          	jal	319c <tick32>
    2ce4:	04012783          	lw	a5,64(sp)
    2ce8:	40f50533          	sub	a0,a0,a5
    2cec:	009897b7          	lui	a5,0x989
    2cf0:	68078793          	addi	a5,a5,1664 # 989680 <__freertos_irq_stack_top+0x945d40>
    2cf4:	00a7e463          	bltu	a5,a0,2cfc <main+0x1bf8>
    2cf8:	f2dfe06f          	j	1c24 <main+0xb20>
                    g_flip_to++;
    2cfc:	8d41a783          	lw	a5,-1836(gp) # 7f5c <g_flip_to>
    2d00:	00178793          	addi	a5,a5,1
    2d04:	8cf1aa23          	sw	a5,-1836(gp) # 7f5c <g_flip_to>
                    if (g_flip_to == 1u)
    2d08:	00100713          	li	a4,1
    2d0c:	00e79463          	bne	a5,a4,2d14 <main+0x1c10>
    2d10:	ef9fe06f          	j	1c08 <main+0xb04>
                    blt_wr(BLT_FB_SEL, g_flip_req);       /* 重发请求，继续有界等待 */
    2d14:	8d81a583          	lw	a1,-1832(gp) # 7f60 <g_flip_req>
    2d18:	02400513          	li	a0,36
    2d1c:	49c000ef          	jal	31b8 <blt_wr>
                    back_t0 = tick32();
    2d20:	47c000ef          	jal	319c <tick32>
    2d24:	04a12023          	sw	a0,64(sp)
    2d28:	f11fe06f          	j	1c38 <main+0xb34>
            if (cpu_i == 0 && snap_cpu) { scene_snap(g_sc[SIDE_CPU], n); snap_cpu = 0; }
    2d2c:	000c8593          	mv	a1,s9
    2d30:	00025537          	lui	a0,0x25
    2d34:	47850513          	addi	a0,a0,1144 # 25478 <__global_pointer$+0x1cdf0>
    2d38:	229010ef          	jal	4760 <scene_snap>
    2d3c:	08012023          	sw	zero,128(sp)
    2d40:	d1dff06f          	j	2a5c <main+0x1958>
                cpu_fill32(g_fb_back, 0, cpu_y0(path), FB_WIDTH, cpu_h(path), COL_BG);
    2d44:	82c1aa83          	lw	s5,-2004(gp) # 7eb4 <g_fb_back>
    2d48:	00048513          	mv	a0,s1
    2d4c:	3ec020ef          	jal	5138 <cpu_h>
    2d50:	00050713          	mv	a4,a0
    2d54:	00800793          	li	a5,8
    2d58:	3c000693          	li	a3,960
    2d5c:	000a0613          	mv	a2,s4
    2d60:	00000593          	li	a1,0
    2d64:	000a8513          	mv	a0,s5
    2d68:	401000ef          	jal	3968 <cpu_fill32>
                repaint_cpu = 0;
    2d6c:	00812e23          	sw	s0,28(sp)
    2d70:	cf5ff06f          	j	2a64 <main+0x1960>
            if ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty))
    2d74:	000087b7          	lui	a5,0x8
    2d78:	00291713          	slli	a4,s2,0x2
    2d7c:	01270733          	add	a4,a4,s2
    2d80:	00271713          	slli	a4,a4,0x2
    2d84:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2d88:	00e787b3          	add	a5,a5,a4
    2d8c:	0001d737          	lui	a4,0x1d
    2d90:	00f707b3          	add	a5,a4,a5
    2d94:	4ca79703          	lh	a4,1226(a5)
    2d98:	4ce79783          	lh	a5,1230(a5)
    2d9c:	cef71ee3          	bne	a4,a5,2a98 <main+0x1994>
    2da0:	d39ff06f          	j	2ad8 <main+0x19d4>
                cpu_fill32(g_fb_back, b->tx, b->ty + y0, b->sz, b->sz, b->color);
    2da4:	000087b7          	lui	a5,0x8
    2da8:	00291713          	slli	a4,s2,0x2
    2dac:	01270733          	add	a4,a4,s2
    2db0:	00271713          	slli	a4,a4,0x2
    2db4:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2db8:	00e787b3          	add	a5,a5,a4
    2dbc:	0001d5b7          	lui	a1,0x1d
    2dc0:	00f585b3          	add	a1,a1,a5
    2dc4:	4ce59603          	lh	a2,1230(a1) # 1d4ce <__global_pointer$+0x14e46>
    2dc8:	4d25c683          	lbu	a3,1234(a1)
    2dcc:	4d05d783          	lhu	a5,1232(a1)
    2dd0:	00068713          	mv	a4,a3
    2dd4:	01460633          	add	a2,a2,s4
    2dd8:	4cc59583          	lh	a1,1228(a1)
    2ddc:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    2de0:	389000ef          	jal	3968 <cpu_fill32>
    2de4:	d31ff06f          	j	2b14 <main+0x1a10>
                cpu_alpha_sprite(b->tx, b->ty + y0, alpha);
    2de8:	000087b7          	lui	a5,0x8
    2dec:	00291713          	slli	a4,s2,0x2
    2df0:	01270733          	add	a4,a4,s2
    2df4:	00271713          	slli	a4,a4,0x2
    2df8:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    2dfc:	00e787b3          	add	a5,a5,a4
    2e00:	0001d737          	lui	a4,0x1d
    2e04:	00f707b3          	add	a5,a4,a5
    2e08:	4ce79583          	lh	a1,1230(a5)
    2e0c:	03012603          	lw	a2,48(sp)
    2e10:	014585b3          	add	a1,a1,s4
    2e14:	4cc79503          	lh	a0,1228(a5)
    2e18:	4ed000ef          	jal	3b04 <cpu_alpha_sprite>
    2e1c:	cf9ff06f          	j	2b14 <main+0x1a10>
                cpu_fill32(g_fb_back, 0, TOP_Y0 + HALF_H, FB_WIDTH, SEP_H, COL_SEP);
    2e20:	000047b7          	lui	a5,0x4
    2e24:	20878793          	addi	a5,a5,520 # 4208 <osd_service+0x6c>
    2e28:	00400713          	li	a4,4
    2e2c:	3c000693          	li	a3,960
    2e30:	11400613          	li	a2,276
    2e34:	00000593          	li	a1,0
    2e38:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    2e3c:	32d000ef          	jal	3968 <cpu_fill32>
    2e40:	d5dff06f          	j	2b9c <main+0x1a98>

00002e44 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    2e44:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    2e48:	01055513          	srli	a0,a0,0x10
    }
    2e4c:	0ff57513          	zext.b	a0,a0
    2e50:	00008067          	ret

00002e54 <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
    2e54:	ff010113          	addi	sp,sp,-16
    2e58:	00112623          	sw	ra,12(sp)
    2e5c:	00812423          	sw	s0,8(sp)
    2e60:	00912223          	sw	s1,4(sp)
    2e64:	00050413          	mv	s0,a0
    2e68:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    2e6c:	00040513          	mv	a0,s0
    2e70:	fd5ff0ef          	jal	2e44 <uart_writeAvailability>
    2e74:	fe050ce3          	beqz	a0,2e6c <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    2e78:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    2e7c:	00c12083          	lw	ra,12(sp)
    2e80:	00812403          	lw	s0,8(sp)
    2e84:	00412483          	lw	s1,4(sp)
    2e88:	01010113          	addi	sp,sp,16
    2e8c:	00008067          	ret

00002e90 <uart_applyConfig>:
*          value using data length, parity, and stop bit settings from the configuration
*          structure, and writes this value to the UART frame configuration register.
*
******************************************************************************/
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
    2e90:	00c5a783          	lw	a5,12(a1)
    2e94:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
    2e98:	0005a783          	lw	a5,0(a1)
    2e9c:	fff78793          	addi	a5,a5,-1
    2ea0:	0045a703          	lw	a4,4(a1)
    2ea4:	00871713          	slli	a4,a4,0x8
    2ea8:	00e7e7b3          	or	a5,a5,a4
    2eac:	0085a703          	lw	a4,8(a1)
    2eb0:	01071713          	slli	a4,a4,0x10
    2eb4:	00e7e7b3          	or	a5,a5,a4
    2eb8:	00f52623          	sw	a5,12(a0)
    }
    2ebc:	00008067          	ret

00002ec0 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    2ec0:	ff010113          	addi	sp,sp,-16
    2ec4:	00112623          	sw	ra,12(sp)
    2ec8:	00050593          	mv	a1,a0
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    2ecc:	f8010537          	lui	a0,0xf8010
    2ed0:	f85ff0ef          	jal	2e54 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    2ed4:	00c12083          	lw	ra,12(sp)
    2ed8:	01010113          	addi	sp,sp,16
    2edc:	00008067          	ret

00002ee0 <_putchar_s>:

    static void _putchar_s(char *p)
    {
    2ee0:	ff010113          	addi	sp,sp,-16
    2ee4:	00112623          	sw	ra,12(sp)
    2ee8:	00812423          	sw	s0,8(sp)
    2eec:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    2ef0:	00c0006f          	j	2efc <_putchar_s+0x1c>
            _putchar(*(p++));
    2ef4:	00140413          	addi	s0,s0,1
    2ef8:	fc9ff0ef          	jal	2ec0 <_putchar>
        while (*p)
    2efc:	00044503          	lbu	a0,0(s0)
    2f00:	fe051ae3          	bnez	a0,2ef4 <_putchar_s+0x14>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    2f04:	00c12083          	lw	ra,12(sp)
    2f08:	00812403          	lw	s0,8(sp)
    2f0c:	01010113          	addi	sp,sp,16
    2f10:	00008067          	ret

00002f14 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    2f14:	ff010113          	addi	sp,sp,-16
    2f18:	00112623          	sw	ra,12(sp)
    2f1c:	00812423          	sw	s0,8(sp)
    2f20:	00912223          	sw	s1,4(sp)
    2f24:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2f28:	01c00413          	li	s0,28
    2f2c:	0240006f          	j	2f50 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    2f30:	0084d733          	srl	a4,s1,s0
    2f34:	00f77713          	andi	a4,a4,15
    2f38:	000067b7          	lui	a5,0x6
    2f3c:	12478793          	addi	a5,a5,292 # 6124 <_data>
    2f40:	00e787b3          	add	a5,a5,a4
    2f44:	0007c503          	lbu	a0,0(a5)
    2f48:	f79ff0ef          	jal	2ec0 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2f4c:	ffc40413          	addi	s0,s0,-4
    2f50:	fe0450e3          	bgez	s0,2f30 <bsp_printHex+0x1c>
        }
    }
    2f54:	00c12083          	lw	ra,12(sp)
    2f58:	00812403          	lw	s0,8(sp)
    2f5c:	00412483          	lw	s1,4(sp)
    2f60:	01010113          	addi	sp,sp,16
    2f64:	00008067          	ret

00002f68 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    2f68:	ff010113          	addi	sp,sp,-16
    2f6c:	00112623          	sw	ra,12(sp)
    2f70:	00812423          	sw	s0,8(sp)
    2f74:	00912223          	sw	s1,4(sp)
    2f78:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2f7c:	01c00413          	li	s0,28
    2f80:	0240006f          	j	2fa4 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    2f84:	0084d733          	srl	a4,s1,s0
    2f88:	00f77713          	andi	a4,a4,15
    2f8c:	000067b7          	lui	a5,0x6
    2f90:	13878793          	addi	a5,a5,312 # 6138 <_data+0x14>
    2f94:	00e787b3          	add	a5,a5,a4
    2f98:	0007c503          	lbu	a0,0(a5)
    2f9c:	f25ff0ef          	jal	2ec0 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2fa0:	ffc40413          	addi	s0,s0,-4
    2fa4:	fe0450e3          	bgez	s0,2f84 <bsp_printHex_lower+0x1c>

        }
    }
    2fa8:	00c12083          	lw	ra,12(sp)
    2fac:	00812403          	lw	s0,8(sp)
    2fb0:	00412483          	lw	s1,4(sp)
    2fb4:	01010113          	addi	sp,sp,16
    2fb8:	00008067          	ret

00002fbc <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    2fbc:	ff010113          	addi	sp,sp,-16
    2fc0:	00112623          	sw	ra,12(sp)
        _putchar(c);
    2fc4:	0ff57513          	zext.b	a0,a0
    2fc8:	ef9ff0ef          	jal	2ec0 <_putchar>
    }
    2fcc:	00c12083          	lw	ra,12(sp)
    2fd0:	01010113          	addi	sp,sp,16
    2fd4:	00008067          	ret

00002fd8 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    2fd8:	ff010113          	addi	sp,sp,-16
    2fdc:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    2fe0:	f01ff0ef          	jal	2ee0 <_putchar_s>
    }
    2fe4:	00c12083          	lw	ra,12(sp)
    2fe8:	01010113          	addi	sp,sp,16
    2fec:	00008067          	ret

00002ff0 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    2ff0:	fd010113          	addi	sp,sp,-48
    2ff4:	02112623          	sw	ra,44(sp)
    2ff8:	02812423          	sw	s0,40(sp)
    2ffc:	02912223          	sw	s1,36(sp)
    3000:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    3004:	00054663          	bltz	a0,3010 <bsp_printf_d+0x20>
    {
    3008:	00010413          	mv	s0,sp
    300c:	02c0006f          	j	3038 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    3010:	02d00513          	li	a0,45
    3014:	fa9ff0ef          	jal	2fbc <bsp_printf_c>
            val = -val;
    3018:	409004b3          	neg	s1,s1
    301c:	fedff06f          	j	3008 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    3020:	00a00713          	li	a4,10
    3024:	02e4e7b3          	rem	a5,s1,a4
    3028:	03078793          	addi	a5,a5,48
    302c:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    3030:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    3034:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    3038:	fe0494e3          	bnez	s1,3020 <bsp_printf_d+0x30>
    303c:	00010793          	mv	a5,sp
    3040:	fef400e3          	beq	s0,a5,3020 <bsp_printf_d+0x30>
        }
        while (p != buffer)
    3044:	00010793          	mv	a5,sp
    3048:	00f40a63          	beq	s0,a5,305c <bsp_printf_d+0x6c>
            bsp_printf_c(*(--p));
    304c:	fff40413          	addi	s0,s0,-1
    3050:	00044503          	lbu	a0,0(s0)
    3054:	f69ff0ef          	jal	2fbc <bsp_printf_c>
    3058:	fedff06f          	j	3044 <bsp_printf_d+0x54>
    }
    305c:	02c12083          	lw	ra,44(sp)
    3060:	02812403          	lw	s0,40(sp)
    3064:	02412483          	lw	s1,36(sp)
    3068:	03010113          	addi	sp,sp,48
    306c:	00008067          	ret

00003070 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    3070:	ff010113          	addi	sp,sp,-16
    3074:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    3078:	00000713          	li	a4,0
    307c:	00700793          	li	a5,7
    3080:	02e7c063          	blt	a5,a4,30a0 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    3084:	00271693          	slli	a3,a4,0x2
    3088:	ff000793          	li	a5,-16
    308c:	00d797b3          	sll	a5,a5,a3
    3090:	00f577b3          	and	a5,a0,a5
    3094:	00078663          	beqz	a5,30a0 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    3098:	00170713          	addi	a4,a4,1 # 1d001 <__global_pointer$+0x14979>
    309c:	fe1ff06f          	j	307c <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    30a0:	ec9ff0ef          	jal	2f68 <bsp_printHex_lower>
    }
    30a4:	00c12083          	lw	ra,12(sp)
    30a8:	01010113          	addi	sp,sp,16
    30ac:	00008067          	ret

000030b0 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    30b0:	ff010113          	addi	sp,sp,-16
    30b4:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    30b8:	00000713          	li	a4,0
    30bc:	00700793          	li	a5,7
    30c0:	02e7c063          	blt	a5,a4,30e0 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    30c4:	00271693          	slli	a3,a4,0x2
    30c8:	ff000793          	li	a5,-16
    30cc:	00d797b3          	sll	a5,a5,a3
    30d0:	00f577b3          	and	a5,a0,a5
    30d4:	00078663          	beqz	a5,30e0 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    30d8:	00170713          	addi	a4,a4,1
    30dc:	fe1ff06f          	j	30bc <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    30e0:	e35ff0ef          	jal	2f14 <bsp_printHex>
        }
    30e4:	00c12083          	lw	ra,12(sp)
    30e8:	01010113          	addi	sp,sp,16
    30ec:	00008067          	ret

000030f0 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
    30f0:	fe010113          	addi	sp,sp,-32
    30f4:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
    30f8:	00800793          	li	a5,8
    30fc:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
    3100:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
    3104:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
    3108:	06b00793          	li	a5,107
    310c:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
    3110:	00010593          	mv	a1,sp
    3114:	f8010537          	lui	a0,0xf8010
    3118:	d79ff0ef          	jal	2e90 <uart_applyConfig>
    }
    311c:	01c12083          	lw	ra,28(sp)
    3120:	02010113          	addi	sp,sp,32
    3124:	00008067          	ret

00003128 <blk_idx>:
static int blk_idx(int sz) { int i; for (i = 0; i < BLK_N; i++) if (g_blk_tab[i] == sz) return i; return 0; }
    3128:	00050693          	mv	a3,a0
    312c:	00000513          	li	a0,0
    3130:	0080006f          	j	3138 <blk_idx+0x10>
    3134:	00150513          	addi	a0,a0,1 # f8010001 <__freertos_irq_stack_top+0xf7fcc6c1>
    3138:	00200793          	li	a5,2
    313c:	02a7c063          	blt	a5,a0,315c <blk_idx+0x34>
    3140:	000087b7          	lui	a5,0x8
    3144:	00251713          	slli	a4,a0,0x2
    3148:	d8878793          	addi	a5,a5,-632 # 7d88 <g_blk_tab>
    314c:	00e787b3          	add	a5,a5,a4
    3150:	0007a783          	lw	a5,0(a5)
    3154:	fed790e3          	bne	a5,a3,3134 <blk_idx+0xc>
    3158:	00008067          	ret
    315c:	00000513          	li	a0,0
    3160:	00008067          	ret

00003164 <blk_next>:
static int blk_next(int sz) { return g_blk_tab[(blk_idx(sz) + 1) % BLK_N]; }
    3164:	ff010113          	addi	sp,sp,-16
    3168:	00112623          	sw	ra,12(sp)
    316c:	fbdff0ef          	jal	3128 <blk_idx>
    3170:	00150513          	addi	a0,a0,1
    3174:	00300793          	li	a5,3
    3178:	02f56533          	rem	a0,a0,a5
    317c:	000087b7          	lui	a5,0x8
    3180:	00251513          	slli	a0,a0,0x2
    3184:	d8878793          	addi	a5,a5,-632 # 7d88 <g_blk_tab>
    3188:	00a787b3          	add	a5,a5,a0
    318c:	0007a503          	lw	a0,0(a5)
    3190:	00c12083          	lw	ra,12(sp)
    3194:	01010113          	addi	sp,sp,16
    3198:	00008067          	ret

0000319c <tick32>:
        return *((volatile u32*) address);
    319c:	f8b0c7b7          	lui	a5,0xf8b0c
    31a0:	ff87a503          	lw	a0,-8(a5) # f8b0bff8 <__freertos_irq_stack_top+0xf8ac86b8>
static uint32_t tick32(void) { return clint_getTimeLow(BSP_CLINT); }
    31a4:	00008067          	ret

000031a8 <cpu_backoff>:
    if (n == 0u) return;
    31a8:	00050663          	beqz	a0,31b4 <cpu_backoff+0xc>
    __asm__ __volatile__ (
    31ac:	fff50513          	addi	a0,a0,-1
    31b0:	fe051ee3          	bnez	a0,31ac <cpu_backoff+0x4>
}
    31b4:	00008067          	ret

000031b8 <blt_wr>:
static void     blt_wr(uint32_t off, uint32_t v) { *(volatile uint32_t *)(BLT_BASE + off) = v; }
    31b8:	f81007b7          	lui	a5,0xf8100
    31bc:	00f50533          	add	a0,a0,a5
    31c0:	00b52023          	sw	a1,0(a0)
    31c4:	00008067          	ret

000031c8 <blt_rd>:
static uint32_t blt_rd(uint32_t off)             { return *(volatile uint32_t *)(BLT_BASE + off); }
    31c8:	f81007b7          	lui	a5,0xf8100
    31cc:	00f50533          	add	a0,a0,a5
    31d0:	00052503          	lw	a0,0(a0)
    31d4:	00008067          	ret

000031d8 <fb_of_sel>:
    return (s == 2u) ? FB_BUF2 : ((s == 1u) ? FB_BACK : FB_BASE);
    31d8:	00200793          	li	a5,2
    31dc:	00f50e63          	beq	a0,a5,31f8 <fb_of_sel+0x20>
    31e0:	00100793          	li	a5,1
    31e4:	00f50663          	beq	a0,a5,31f0 <fb_of_sel+0x18>
    31e8:	00301537          	lui	a0,0x301
}
    31ec:	00008067          	ret
    return (s == 2u) ? FB_BUF2 : ((s == 1u) ? FB_BACK : FB_BASE);
    31f0:	00501537          	lui	a0,0x501
    31f4:	00008067          	ret
    31f8:	00701537          	lui	a0,0x701
    31fc:	00008067          	ret

00003200 <fb_stat_sel>:
static uint32_t fb_stat_sel(void) { return FB_SEL_STAT_SEL(blt_rd(BLT_FB_STAT)); }
    3200:	ff010113          	addi	sp,sp,-16
    3204:	00112623          	sw	ra,12(sp)
    3208:	02800513          	li	a0,40
    320c:	fbdff0ef          	jal	31c8 <blt_rd>
    3210:	00357513          	andi	a0,a0,3
    3214:	00c12083          	lw	ra,12(sp)
    3218:	01010113          	addi	sp,sp,16
    321c:	00008067          	ret

00003220 <clr_stat>:
static uint32_t clr_stat(void)  { return blt_rd(BLT_CLR_STAT); }
    3220:	ff010113          	addi	sp,sp,-16
    3224:	00112623          	sw	ra,12(sp)
    3228:	04000513          	li	a0,64
    322c:	f9dff0ef          	jal	31c8 <blt_rd>
    3230:	00c12083          	lw	ra,12(sp)
    3234:	01010113          	addi	sp,sp,16
    3238:	00008067          	ret

0000323c <clr_busy>:
static int      clr_busy(void)  { return (clr_stat() & BLT_CLR_STAT_BUSY) ? 1 : 0; }
    323c:	ff010113          	addi	sp,sp,-16
    3240:	00112623          	sw	ra,12(sp)
    3244:	fddff0ef          	jal	3220 <clr_stat>
    3248:	00157513          	andi	a0,a0,1
    324c:	00c12083          	lw	ra,12(sp)
    3250:	01010113          	addi	sp,sp,16
    3254:	00008067          	ret

00003258 <clr_is_clean>:
static int      clr_is_clean(uint32_t k) { return (int)((clr_stat() >> (2u + k)) & 1u); }
    3258:	ff010113          	addi	sp,sp,-16
    325c:	00112623          	sw	ra,12(sp)
    3260:	00812423          	sw	s0,8(sp)
    3264:	00050413          	mv	s0,a0
    3268:	fb9ff0ef          	jal	3220 <clr_stat>
    326c:	00240413          	addi	s0,s0,2
    3270:	00855533          	srl	a0,a0,s0
    3274:	00157513          	andi	a0,a0,1
    3278:	00c12083          	lw	ra,12(sp)
    327c:	00812403          	lw	s0,8(sp)
    3280:	01010113          	addi	sp,sp,16
    3284:	00008067          	ret

00003288 <clr_wait_idle>:
{
    3288:	ff010113          	addi	sp,sp,-16
    328c:	00112623          	sw	ra,12(sp)
    3290:	00812423          	sw	s0,8(sp)
    3294:	00912223          	sw	s1,4(sp)
    uint32_t t0 = tick32();
    3298:	f05ff0ef          	jal	319c <tick32>
    329c:	00050493          	mv	s1,a0
{
    32a0:	00000413          	li	s0,0
    while (clr_busy()) {
    32a4:	f99ff0ef          	jal	323c <clr_busy>
    32a8:	04050263          	beqz	a0,32ec <clr_wait_idle+0x64>
        if ((uint32_t)(tick32() - t0) > (uint32_t)CLR_WAIT_TICKS) { g_clr_to++; return 0; }
    32ac:	ef1ff0ef          	jal	319c <tick32>
    32b0:	40950533          	sub	a0,a0,s1
    32b4:	000f47b7          	lui	a5,0xf4
    32b8:	24078793          	addi	a5,a5,576 # f4240 <__freertos_irq_stack_top+0xb0900>
    32bc:	00a7ee63          	bltu	a5,a0,32d8 <clr_wait_idle+0x50>
        if (++guard > 64) { guard = 0; cpu_backoff(48u); }
    32c0:	00140413          	addi	s0,s0,1
    32c4:	04000793          	li	a5,64
    32c8:	fc87dee3          	bge	a5,s0,32a4 <clr_wait_idle+0x1c>
    32cc:	03000513          	li	a0,48
    32d0:	ed9ff0ef          	jal	31a8 <cpu_backoff>
    32d4:	fcdff06f          	j	32a0 <clr_wait_idle+0x18>
        if ((uint32_t)(tick32() - t0) > (uint32_t)CLR_WAIT_TICKS) { g_clr_to++; return 0; }
    32d8:	8c01a783          	lw	a5,-1856(gp) # 7f48 <g_clr_to>
    32dc:	00178793          	addi	a5,a5,1
    32e0:	8cf1a023          	sw	a5,-1856(gp) # 7f48 <g_clr_to>
    32e4:	00000513          	li	a0,0
    32e8:	0080006f          	j	32f0 <clr_wait_idle+0x68>
    return 1;
    32ec:	00100513          	li	a0,1
}
    32f0:	00c12083          	lw	ra,12(sp)
    32f4:	00812403          	lw	s0,8(sp)
    32f8:	00412483          	lw	s1,4(sp)
    32fc:	01010113          	addi	sp,sp,16
    3300:	00008067          	ret

00003304 <clr_start>:
{
    3304:	ff010113          	addi	sp,sp,-16
    3308:	00112623          	sw	ra,12(sp)
    330c:	00812423          	sw	s0,8(sp)
    3310:	00912223          	sw	s1,4(sp)
    3314:	01212023          	sw	s2,0(sp)
    3318:	00050413          	mv	s0,a0
    331c:	00058913          	mv	s2,a1
    3320:	00060493          	mv	s1,a2
    blt_wr(BLT_CLR_ADDR,   fb_of_sel(k) + (uint32_t)y0 * FB_STRIDE);
    3324:	eb5ff0ef          	jal	31d8 <fb_of_sel>
    3328:	00491793          	slli	a5,s2,0x4
    332c:	412787b3          	sub	a5,a5,s2
    3330:	00779793          	slli	a5,a5,0x7
    3334:	00f505b3          	add	a1,a0,a5
    3338:	02c00513          	li	a0,44
    333c:	e7dff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CLR_STRIDE, FB_STRIDE);
    3340:	78000593          	li	a1,1920
    3344:	03000513          	li	a0,48
    3348:	e71ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CLR_WH,     ((uint32_t)h << 16) | (uint32_t)FB_WIDTH);
    334c:	01049593          	slli	a1,s1,0x10
    3350:	3c05e593          	ori	a1,a1,960
    3354:	03400513          	li	a0,52
    3358:	e61ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CLR_COLOR,  COL_BG);
    335c:	00800593          	li	a1,8
    3360:	03800513          	li	a0,56
    3364:	e55ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CLR_CTRL,   ((uint32_t)k << 2) | BLT_CLR_GO);
    3368:	00241593          	slli	a1,s0,0x2
    336c:	0015e593          	ori	a1,a1,1
    3370:	03c00513          	li	a0,60
    3374:	e45ff0ef          	jal	31b8 <blt_wr>
}
    3378:	00c12083          	lw	ra,12(sp)
    337c:	00812403          	lw	s0,8(sp)
    3380:	00412483          	lw	s1,4(sp)
    3384:	00012903          	lw	s2,0(sp)
    3388:	01010113          	addi	sp,sp,16
    338c:	00008067          	ret

00003390 <hw_pass_arm>:
{
    3390:	fe010113          	addi	sp,sp,-32
    3394:	00112e23          	sw	ra,28(sp)
    3398:	00812c23          	sw	s0,24(sp)
    339c:	00912a23          	sw	s1,20(sp)
    33a0:	01212823          	sw	s2,16(sp)
    33a4:	01312623          	sw	s3,12(sp)
    33a8:	00050993          	mv	s3,a0
    33ac:	00058913          	mv	s2,a1
    if (!clr_wait_idle()) {                        /* ① */
    33b0:	ed9ff0ef          	jal	3288 <clr_wait_idle>
    clean_k = clr_is_clean((uint32_t)g_draw3);     /* ② */
    33b4:	8281a503          	lw	a0,-2008(gp) # 7eb0 <g_draw3>
    33b8:	ea1ff0ef          	jal	3258 <clr_is_clean>
    33bc:	00050413          	mv	s0,a0
    blt_wr(BLT_DRAW_SEL, (uint32_t)g_draw3);       /* ③ */
    33c0:	8281a583          	lw	a1,-2008(gp) # 7eb0 <g_draw3>
    33c4:	04400513          	li	a0,68
    33c8:	df1ff0ef          	jal	31b8 <blt_wr>
    if (clr_stat() & BLT_CLR_STAT_ERR) {           /*    清掉互斥留下的 sticky 错误 */
    33cc:	e55ff0ef          	jal	3220 <clr_stat>
    33d0:	04057793          	andi	a5,a0,64
    33d4:	02079e63          	bnez	a5,3410 <hw_pass_arm+0x80>
    if (!clean_k) g_clr_fb++;                      /* ④ 脏 ⇒ 必须退回命令式清屏 */
    33d8:	00041863          	bnez	s0,33e8 <hw_pass_arm+0x58>
    33dc:	8c41a783          	lw	a5,-1852(gp) # 7f4c <g_clr_fb>
    33e0:	00178793          	addi	a5,a5,1
    33e4:	8cf1a223          	sw	a5,-1852(gp) # 7f4c <g_clr_fb>
    if (g_clr_need) {                              /* ⑤ */
    33e8:	8cc1a783          	lw	a5,-1844(gp) # 7f54 <g_clr_need>
    33ec:	04079463          	bnez	a5,3434 <hw_pass_arm+0xa4>
}
    33f0:	00143513          	seqz	a0,s0
    33f4:	01c12083          	lw	ra,28(sp)
    33f8:	01812403          	lw	s0,24(sp)
    33fc:	01412483          	lw	s1,20(sp)
    3400:	01012903          	lw	s2,16(sp)
    3404:	00c12983          	lw	s3,12(sp)
    3408:	02010113          	addi	sp,sp,32
    340c:	00008067          	ret
        g_clr_err++;
    3410:	8bc1a783          	lw	a5,-1860(gp) # 7f44 <g_clr_err>
    3414:	00178793          	addi	a5,a5,1
    3418:	8af1ae23          	sw	a5,-1860(gp) # 7f44 <g_clr_err>
        blt_wr(BLT_CLR_CTRL, ((uint32_t)g_draw3 << 2) | BLT_CLR_ERRCLR);
    341c:	8281a583          	lw	a1,-2008(gp) # 7eb0 <g_draw3>
    3420:	00259593          	slli	a1,a1,0x2
    3424:	0105e593          	ori	a1,a1,16
    3428:	03c00513          	li	a0,60
    342c:	d8dff0ef          	jal	31b8 <blt_wr>
    3430:	fa9ff06f          	j	33d8 <hw_pass_arm+0x48>
        clr_start((uint32_t)g_clr3, y0, h);
    3434:	00090613          	mv	a2,s2
    3438:	00098593          	mv	a1,s3
    343c:	8241a503          	lw	a0,-2012(gp) # 7eac <g_clr3>
    3440:	ec5ff0ef          	jal	3304 <clr_start>
        g_clr_need = 0;
    3444:	8c01a623          	sw	zero,-1844(gp) # 7f54 <g_clr_need>
    3448:	fa9ff06f          	j	33f0 <hw_pass_arm+0x60>

0000344c <cache_evict>:
    for (i = 0; i < (uint32_t)FLUSH_WORDS; i++) s[i] = 0xA5A50000UL + i;
    344c:	00000793          	li	a5,0
    3450:	0200006f          	j	3470 <cache_evict+0x24>
    3454:	00279693          	slli	a3,a5,0x2
    3458:	00601737          	lui	a4,0x601
    345c:	00d70733          	add	a4,a4,a3
    3460:	a5a506b7          	lui	a3,0xa5a50
    3464:	00d786b3          	add	a3,a5,a3
    3468:	00d72023          	sw	a3,0(a4) # 601000 <__freertos_irq_stack_top+0x5bd6c0>
    346c:	00178793          	addi	a5,a5,1
    3470:	7ff00713          	li	a4,2047
    3474:	fef770e3          	bgeu	a4,a5,3454 <cache_evict+0x8>
}
    3478:	00008067          	ret

0000347c <blt_emit>:
{
    347c:	fe010113          	addi	sp,sp,-32
    3480:	00112e23          	sw	ra,28(sp)
    3484:	00812c23          	sw	s0,24(sp)
    3488:	00912a23          	sw	s1,20(sp)
    348c:	01212823          	sw	s2,16(sp)
    3490:	01312623          	sw	s3,12(sp)
    3494:	01412423          	sw	s4,8(sp)
    3498:	01512223          	sw	s5,4(sp)
    349c:	01612023          	sw	s6,0(sp)
    34a0:	00058b13          	mv	s6,a1
    34a4:	00060a93          	mv	s5,a2
    34a8:	00068a13          	mv	s4,a3
    34ac:	00070993          	mv	s3,a4
    34b0:	00078413          	mv	s0,a5
    34b4:	00080493          	mv	s1,a6
    34b8:	00088913          	mv	s2,a7
    blt_wr(BLT_CMD_FIFO_DATA, op);
    34bc:	00050593          	mv	a1,a0
    34c0:	00800513          	li	a0,8
    34c4:	cf5ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, src);
    34c8:	000b0593          	mv	a1,s6
    34cc:	00800513          	li	a0,8
    34d0:	ce9ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, dst);
    34d4:	000a8593          	mv	a1,s5
    34d8:	00800513          	li	a0,8
    34dc:	cddff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, ss);
    34e0:	000a0593          	mv	a1,s4
    34e4:	00800513          	li	a0,8
    34e8:	cd1ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, ds);
    34ec:	00098593          	mv	a1,s3
    34f0:	00800513          	li	a0,8
    34f4:	cc5ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, (h << 16) | (w & 0xFFFFu));
    34f8:	01049493          	slli	s1,s1,0x10
    34fc:	01041413          	slli	s0,s0,0x10
    3500:	01045413          	srli	s0,s0,0x10
    3504:	0084e5b3          	or	a1,s1,s0
    3508:	00800513          	li	a0,8
    350c:	cadff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, alpha);
    3510:	00090593          	mv	a1,s2
    3514:	00800513          	li	a0,8
    3518:	ca1ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, color);
    351c:	02012583          	lw	a1,32(sp)
    3520:	00800513          	li	a0,8
    3524:	c95ff0ef          	jal	31b8 <blt_wr>
}
    3528:	01c12083          	lw	ra,28(sp)
    352c:	01812403          	lw	s0,24(sp)
    3530:	01412483          	lw	s1,20(sp)
    3534:	01012903          	lw	s2,16(sp)
    3538:	00c12983          	lw	s3,12(sp)
    353c:	00812a03          	lw	s4,8(sp)
    3540:	00412a83          	lw	s5,4(sp)
    3544:	00012b03          	lw	s6,0(sp)
    3548:	02010113          	addi	sp,sp,32
    354c:	00008067          	ret

00003550 <blt_cnt>:
static uint32_t blt_cnt(void)  { return blt_rd(BLT_CMD_FIFO_COUNT); }
    3550:	ff010113          	addi	sp,sp,-16
    3554:	00112623          	sw	ra,12(sp)
    3558:	00c00513          	li	a0,12
    355c:	c6dff0ef          	jal	31c8 <blt_rd>
    3560:	00c12083          	lw	ra,12(sp)
    3564:	01010113          	addi	sp,sp,16
    3568:	00008067          	ret

0000356c <blt_stat>:
static uint32_t blt_stat(void) { return blt_rd(BLT_STATUS); }
    356c:	ff010113          	addi	sp,sp,-16
    3570:	00112623          	sw	ra,12(sp)
    3574:	00400513          	li	a0,4
    3578:	c51ff0ef          	jal	31c8 <blt_rd>
    357c:	00c12083          	lw	ra,12(sp)
    3580:	01010113          	addi	sp,sp,16
    3584:	00008067          	ret

00003588 <blt_idle_st>:
    return ((st & BLT_STATUS_DONE) && (st & BLT_STATUS_FIFO_EMPTY) &&
    3588:	00e57513          	andi	a0,a0,14
            !(st & BLT_STATUS_ERR)) ? 1 : 0;
    358c:	ff650513          	addi	a0,a0,-10 # 700ff6 <__freertos_irq_stack_top+0x6bd6b6>
}
    3590:	00153513          	seqz	a0,a0
    3594:	00008067          	ret

00003598 <blt_push_room>:
{
    3598:	ff010113          	addi	sp,sp,-16
    359c:	00112623          	sw	ra,12(sp)
    uint32_t cnt = blt_cnt();
    35a0:	fb1ff0ef          	jal	3550 <blt_cnt>
    if (cnt > (uint32_t)(BLT_PUSH_LIMIT - 1u)) return 0u;
    35a4:	0c700793          	li	a5,199
    35a8:	00a7ec63          	bltu	a5,a0,35c0 <blt_push_room+0x28>
    return (uint32_t)BLT_PUSH_LIMIT - cnt;
    35ac:	0c800793          	li	a5,200
    35b0:	40a78533          	sub	a0,a5,a0
}
    35b4:	00c12083          	lw	ra,12(sp)
    35b8:	01010113          	addi	sp,sp,16
    35bc:	00008067          	ret
    if (cnt > (uint32_t)(BLT_PUSH_LIMIT - 1u)) return 0u;
    35c0:	00000513          	li	a0,0
    35c4:	ff1ff06f          	j	35b4 <blt_push_room+0x1c>

000035c8 <blt_init>:
{
    35c8:	ff010113          	addi	sp,sp,-16
    35cc:	00112623          	sw	ra,12(sp)
    blt_wr(BLT_CTRL, BLT_CTRL_SOFT_RST);
    35d0:	00400593          	li	a1,4
    35d4:	00000513          	li	a0,0
    35d8:	be1ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_IRQ_STATUS, 1u);                        /* W1C */
    35dc:	00100593          	li	a1,1
    35e0:	01000513          	li	a0,16
    35e4:	bd5ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_IRQ_EN, 0u);
    35e8:	00000593          	li	a1,0
    35ec:	01400513          	li	a0,20
    35f0:	bc9ff0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_CTRL, BLT_CTRL_GO);
    35f4:	00100593          	li	a1,1
    35f8:	00000513          	li	a0,0
    35fc:	bbdff0ef          	jal	31b8 <blt_wr>
}
    3600:	00c12083          	lw	ra,12(sp)
    3604:	01010113          	addi	sp,sp,16
    3608:	00008067          	ret

0000360c <blt_fill>:
{
    360c:	fe010113          	addi	sp,sp,-32
    3610:	00112e23          	sw	ra,28(sp)
    3614:	00060793          	mv	a5,a2
    blt_emit(BLT_OP_FILL, 0u, dst, 0u, ds, w, h, 0xFFu, color);
    3618:	00e12023          	sw	a4,0(sp)
    361c:	0ff00893          	li	a7,255
    3620:	00068813          	mv	a6,a3
    3624:	00058713          	mv	a4,a1
    3628:	00000693          	li	a3,0
    362c:	00050613          	mv	a2,a0
    3630:	00000593          	li	a1,0
    3634:	00100513          	li	a0,1
    3638:	e45ff0ef          	jal	347c <blt_emit>
}
    363c:	01c12083          	lw	ra,28(sp)
    3640:	02010113          	addi	sp,sp,32
    3644:	00008067          	ret

00003648 <blt_alpha>:
{
    3648:	fe010113          	addi	sp,sp,-32
    364c:	00112e23          	sw	ra,28(sp)
    blt_emit(BLT_OP_ALPHA, src, dst, ss, ds, w, h, alpha, 0u);
    3650:	00012023          	sw	zero,0(sp)
    3654:	00080893          	mv	a7,a6
    3658:	00078813          	mv	a6,a5
    365c:	00070793          	mv	a5,a4
    3660:	00068713          	mv	a4,a3
    3664:	00060693          	mv	a3,a2
    3668:	00058613          	mv	a2,a1
    366c:	00050593          	mv	a1,a0
    3670:	00200513          	li	a0,2
    3674:	e09ff0ef          	jal	347c <blt_emit>
}
    3678:	01c12083          	lw	ra,28(sp)
    367c:	02010113          	addi	sp,sp,32
    3680:	00008067          	ret

00003684 <blt_key>:
{
    3684:	fe010113          	addi	sp,sp,-32
    3688:	00112e23          	sw	ra,28(sp)
    blt_emit(BLT_OP_KEY, src, dst, ss, ds, w, h, 0xFFu, key);
    368c:	01012023          	sw	a6,0(sp)
    3690:	0ff00893          	li	a7,255
    3694:	00078813          	mv	a6,a5
    3698:	00070793          	mv	a5,a4
    369c:	00068713          	mv	a4,a3
    36a0:	00060693          	mv	a3,a2
    36a4:	00058613          	mv	a2,a1
    36a8:	00050593          	mv	a1,a0
    36ac:	00300513          	li	a0,3
    36b0:	dcdff0ef          	jal	347c <blt_emit>
}
    36b4:	01c12083          	lw	ra,28(sp)
    36b8:	02010113          	addi	sp,sp,32
    36bc:	00008067          	ret

000036c0 <spr_color>:
    int dx = i - SPR_W / 2, dy = j - SPR_H / 2;
    36c0:	8201a603          	lw	a2,-2016(gp) # 7ea8 <g_blk>
    36c4:	01f65713          	srli	a4,a2,0x1f
    36c8:	00c70733          	add	a4,a4,a2
    36cc:	40175713          	srai	a4,a4,0x1
    36d0:	40e00733          	neg	a4,a4
    36d4:	00a706b3          	add	a3,a4,a0
    36d8:	00b707b3          	add	a5,a4,a1
    int d2 = dx * dx + dy * dy;
    36dc:	02d686b3          	mul	a3,a3,a3
    36e0:	02f787b3          	mul	a5,a5,a5
    36e4:	00f686b3          	add	a3,a3,a5
    int r2 = (SPR_W / 2) * (SPR_W / 2);
    36e8:	02e70833          	mul	a6,a4,a4
    int ri = SPR_W / 2 - SPR_RING;       /* 白环内边界半径（外边界 = SPR_W/2） */
    36ec:	41f65793          	srai	a5,a2,0x1f
    36f0:	0077f793          	andi	a5,a5,7
    36f4:	00c787b3          	add	a5,a5,a2
    36f8:	4037d793          	srai	a5,a5,0x3
    36fc:	40f007b3          	neg	a5,a5
    3700:	40e787b3          	sub	a5,a5,a4
    if (d2 > r2)              return KEY_COLOR;      /* 圆外（含四角）⇒ 色键 */
    3704:	06d84863          	blt	a6,a3,3774 <spr_color+0xb4>
    if (d2 > ri * ri)         return COL_WHITE;      /* 白环 */
    3708:	02f787b3          	mul	a5,a5,a5
    370c:	06d7ca63          	blt	a5,a3,3780 <spr_color+0xc0>
    rr = (unsigned)((i * 31) / (SPR_W - 1));
    3710:	00551793          	slli	a5,a0,0x5
    3714:	40a78533          	sub	a0,a5,a0
    3718:	fff60613          	addi	a2,a2,-1
    371c:	02c54533          	div	a0,a0,a2
    gg = (unsigned)((j * 63) / (SPR_H - 1));
    3720:	00659793          	slli	a5,a1,0x6
    3724:	40b787b3          	sub	a5,a5,a1
    3728:	02c7c7b3          	div	a5,a5,a2
    bb = (unsigned)(31 - ((d2 * 31) / (r2 ? r2 : 1)));
    372c:	00569713          	slli	a4,a3,0x5
    3730:	40d70733          	sub	a4,a4,a3
    3734:	00081463          	bnez	a6,373c <spr_color+0x7c>
    3738:	00100813          	li	a6,1
    373c:	03074733          	div	a4,a4,a6
    3740:	01f00693          	li	a3,31
    3744:	40e68733          	sub	a4,a3,a4
    return (uint16_t)((rr << 11) | (gg << 5) | bb);
    3748:	00b51513          	slli	a0,a0,0xb
    374c:	01051513          	slli	a0,a0,0x10
    3750:	01055513          	srli	a0,a0,0x10
    3754:	00579793          	slli	a5,a5,0x5
    3758:	01079793          	slli	a5,a5,0x10
    375c:	0107d793          	srli	a5,a5,0x10
    3760:	00f56533          	or	a0,a0,a5
    3764:	00e56533          	or	a0,a0,a4
    3768:	01051513          	slli	a0,a0,0x10
    376c:	01055513          	srli	a0,a0,0x10
    3770:	00008067          	ret
    if (d2 > r2)              return KEY_COLOR;      /* 圆外（含四角）⇒ 色键 */
    3774:	00010537          	lui	a0,0x10
    3778:	81f50513          	addi	a0,a0,-2017 # f81f <__global_pointer$+0x7197>
    377c:	00008067          	ret
    if (d2 > ri * ri)         return COL_WHITE;      /* 白环 */
    3780:	00010537          	lui	a0,0x10
    3784:	fff50513          	addi	a0,a0,-1 # ffff <__global_pointer$+0x7977>
}
    3788:	00008067          	ret

0000378c <spr_mask_of>:
{
    378c:	00050893          	mv	a7,a0
    3790:	00060393          	mv	t2,a2
    3794:	00068813          	mv	a6,a3
    for (rt = 0; rt < 4; rt++) {
    3798:	00000293          	li	t0,0
    uint16_t m = 0u;
    379c:	00000513          	li	a0,0
    for (rt = 0; rt < 4; rt++) {
    37a0:	00300793          	li	a5,3
    37a4:	1057c463          	blt	a5,t0,38ac <spr_mask_of+0x120>
{
    37a8:	ff010113          	addi	sp,sp,-16
    37ac:	00812623          	sw	s0,12(sp)
    37b0:	00912423          	sw	s1,8(sp)
    37b4:	0b40006f          	j	3868 <spr_mask_of+0xdc>
                    if (px[j * w + i] != key) { allkey = 0; break; }
    37b8:	00000e13          	li	t3,0
            for (j = y0; j < y1 && allkey; j++)
    37bc:	00168693          	addi	a3,a3,1 # a5a50001 <__freertos_irq_stack_top+0xa5a0c6c1>
    37c0:	03d6dc63          	bge	a3,t4,37f8 <spr_mask_of+0x6c>
    37c4:	020e0a63          	beqz	t3,37f8 <spr_mask_of+0x6c>
                for (i = x0; i < x1; i++)
    37c8:	00030713          	mv	a4,t1
    37cc:	fec758e3          	bge	a4,a2,37bc <spr_mask_of+0x30>
                    if (px[j * w + i] != key) { allkey = 0; break; }
    37d0:	02b687b3          	mul	a5,a3,a1
    37d4:	00e787b3          	add	a5,a5,a4
    37d8:	00179793          	slli	a5,a5,0x1
    37dc:	00f887b3          	add	a5,a7,a5
    37e0:	0007d783          	lhu	a5,0(a5)
    37e4:	01079793          	slli	a5,a5,0x10
    37e8:	0107d793          	srli	a5,a5,0x10
    37ec:	fd0796e3          	bne	a5,a6,37b8 <spr_mask_of+0x2c>
                for (i = x0; i < x1; i++)
    37f0:	00170713          	addi	a4,a4,1
    37f4:	fd9ff06f          	j	37cc <spr_mask_of+0x40>
            if (allkey) m = (uint16_t)(m | (uint16_t)(1u << (rt * 4 + ct)));
    37f8:	020e0063          	beqz	t3,3818 <spr_mask_of+0x8c>
    37fc:	00229713          	slli	a4,t0,0x2
    3800:	01e70733          	add	a4,a4,t5
    3804:	00100793          	li	a5,1
    3808:	00e797b3          	sll	a5,a5,a4
    380c:	01079793          	slli	a5,a5,0x10
    3810:	0107d793          	srli	a5,a5,0x10
    3814:	00a7e533          	or	a0,a5,a0
            int allkey = 1, i, j;
    3818:	00048f13          	mv	t5,s1
        for (ct = 0; ct < 4; ct++) {
    381c:	00300793          	li	a5,3
    3820:	03e7ce63          	blt	a5,t5,385c <spr_mask_of+0xd0>
            int x0 = (w * ct) / 4, x1 = (w * (ct + 1)) / 4;  /* 与 RTL 的 col_t* 同一公式 */
    3824:	02bf07b3          	mul	a5,t5,a1
    3828:	41f7d313          	srai	t1,a5,0x1f
    382c:	00337313          	andi	t1,t1,3
    3830:	00f30333          	add	t1,t1,a5
    3834:	40235313          	srai	t1,t1,0x2
    3838:	001f0493          	addi	s1,t5,1
    383c:	02b487b3          	mul	a5,s1,a1
    3840:	41f7d613          	srai	a2,a5,0x1f
    3844:	00367613          	andi	a2,a2,3
    3848:	00f60633          	add	a2,a2,a5
    384c:	40265613          	srai	a2,a2,0x2
            for (j = y0; j < y1 && allkey; j++)
    3850:	000f8693          	mv	a3,t6
            int allkey = 1, i, j;
    3854:	00100e13          	li	t3,1
            for (j = y0; j < y1 && allkey; j++)
    3858:	f69ff06f          	j	37c0 <spr_mask_of+0x34>
    for (rt = 0; rt < 4; rt++) {
    385c:	00040293          	mv	t0,s0
    3860:	00300793          	li	a5,3
    3864:	0287cc63          	blt	a5,s0,389c <spr_mask_of+0x110>
        int y0 = (h * rt) / 4, y1 = (h * (rt + 1)) / 4;      /* 与 RTL 的 row_t* 同一公式 */
    3868:	027287b3          	mul	a5,t0,t2
    386c:	41f7df93          	srai	t6,a5,0x1f
    3870:	003fff93          	andi	t6,t6,3
    3874:	00ff8fb3          	add	t6,t6,a5
    3878:	402fdf93          	srai	t6,t6,0x2
    387c:	00128413          	addi	s0,t0,1
    3880:	027407b3          	mul	a5,s0,t2
    3884:	41f7de93          	srai	t4,a5,0x1f
    3888:	003efe93          	andi	t4,t4,3
    388c:	00fe8eb3          	add	t4,t4,a5
    3890:	402ede93          	srai	t4,t4,0x2
        for (ct = 0; ct < 4; ct++) {
    3894:	00000f13          	li	t5,0
    3898:	f85ff06f          	j	381c <spr_mask_of+0x90>
}
    389c:	00c12403          	lw	s0,12(sp)
    38a0:	00812483          	lw	s1,8(sp)
    38a4:	01010113          	addi	sp,sp,16
    38a8:	00008067          	ret
    38ac:	00008067          	ret

000038b0 <spr_mask_tiles>:
{
    38b0:	00050793          	mv	a5,a0
    int n = 0;
    38b4:	00000513          	li	a0,0
    while (m) { n += (int)(m & 1u); m = (uint16_t)(m >> 1); }
    38b8:	0100006f          	j	38c8 <spr_mask_tiles+0x18>
    38bc:	0017f713          	andi	a4,a5,1
    38c0:	00e50533          	add	a0,a0,a4
    38c4:	0017d793          	srli	a5,a5,0x1
    38c8:	fe079ae3          	bnez	a5,38bc <spr_mask_tiles+0xc>
}
    38cc:	00008067          	ret

000038d0 <build_atlas>:
{
    38d0:	fe010113          	addi	sp,sp,-32
    38d4:	00112e23          	sw	ra,28(sp)
    38d8:	00812c23          	sw	s0,24(sp)
    38dc:	00912a23          	sw	s1,20(sp)
    38e0:	01212823          	sw	s2,16(sp)
    38e4:	01312623          	sw	s3,12(sp)
    for (j = 0; j < SPR_H; j++)
    38e8:	00000993          	li	s3,0
    38ec:	0340006f          	j	3920 <build_atlas+0x50>
            p[j * SPR_W + i] = spr_color(i, j);
    38f0:	033907b3          	mul	a5,s2,s3
    38f4:	008787b3          	add	a5,a5,s0
    38f8:	00179793          	slli	a5,a5,0x1
    38fc:	002014b7          	lui	s1,0x201
    3900:	00f484b3          	add	s1,s1,a5
    3904:	00098593          	mv	a1,s3
    3908:	00040513          	mv	a0,s0
    390c:	db5ff0ef          	jal	36c0 <spr_color>
    3910:	00a49023          	sh	a0,0(s1) # 201000 <__freertos_irq_stack_top+0x1bd6c0>
        for (i = 0; i < SPR_W; i++)
    3914:	00140413          	addi	s0,s0,1
    3918:	fd244ce3          	blt	s0,s2,38f0 <build_atlas+0x20>
    for (j = 0; j < SPR_H; j++)
    391c:	00198993          	addi	s3,s3,1
    3920:	8201a903          	lw	s2,-2016(gp) # 7ea8 <g_blk>
    3924:	0129d663          	bge	s3,s2,3930 <build_atlas+0x60>
        for (i = 0; i < SPR_W; i++)
    3928:	00000413          	li	s0,0
    392c:	fedff06f          	j	3918 <build_atlas+0x48>
    g_spr_mask = spr_mask_of((const volatile uint16_t *)ATLAS_BASE, SPR_W, SPR_H,
    3930:	000106b7          	lui	a3,0x10
    3934:	81f68693          	addi	a3,a3,-2017 # f81f <__global_pointer$+0x7197>
    3938:	00090613          	mv	a2,s2
    393c:	00090593          	mv	a1,s2
    3940:	00201537          	lui	a0,0x201
    3944:	e49ff0ef          	jal	378c <spr_mask_of>
    3948:	8aa19c23          	sh	a0,-1864(gp) # 7f40 <g_spr_mask>
}
    394c:	01c12083          	lw	ra,28(sp)
    3950:	01812403          	lw	s0,24(sp)
    3954:	01412483          	lw	s1,20(sp)
    3958:	01012903          	lw	s2,16(sp)
    395c:	00c12983          	lw	s3,12(sp)
    3960:	02010113          	addi	sp,sp,32
    3964:	00008067          	ret

00003968 <cpu_fill32>:
    uint32_t two = (uint32_t)color | ((uint32_t)color << 16);
    3968:	01079e93          	slli	t4,a5,0x10
    396c:	00fe8eb3          	add	t4,t4,a5
    int odd = (x & 1);
    3970:	0015ff93          	andi	t6,a1,1
    for (j = 0; j < h; j++) {
    3974:	00000f13          	li	t5,0
    3978:	0480006f          	j	39c0 <cpu_fill32+0x58>
        int rem = w;
    397c:	00068e13          	mv	t3,a3
    3980:	0700006f          	j	39f0 <cpu_fill32+0x88>
            for (i = 0; i < (rem >> 1); i++) q[i] = two;
    3984:	00281893          	slli	a7,a6,0x2
    3988:	011308b3          	add	a7,t1,a7
    398c:	01d8a023          	sw	t4,0(a7)
    3990:	00180813          	addi	a6,a6,1
    3994:	401e5893          	srai	a7,t3,0x1
    3998:	ff1846e3          	blt	a6,a7,3984 <cpu_fill32+0x1c>
        if (rem & 1) p[rem - 1] = color;
    399c:	001e7813          	andi	a6,t3,1
    39a0:	00080e63          	beqz	a6,39bc <cpu_fill32+0x54>
    39a4:	80000837          	lui	a6,0x80000
    39a8:	fff80813          	addi	a6,a6,-1 # 7fffffff <__freertos_irq_stack_top+0x7ffbc6bf>
    39ac:	010e0e33          	add	t3,t3,a6
    39b0:	001e1e13          	slli	t3,t3,0x1
    39b4:	01c30333          	add	t1,t1,t3
    39b8:	00f31023          	sh	a5,0(t1) # 821000 <__freertos_irq_stack_top+0x7dd6c0>
    for (j = 0; j < h; j++) {
    39bc:	001f0f13          	addi	t5,t5,1
    39c0:	02ef5c63          	bge	t5,a4,39f8 <cpu_fill32+0x90>
        volatile uint16_t *p = (volatile uint16_t *)(base + (uint32_t)(y + j) * FB_STRIDE
    39c4:	00cf0833          	add	a6,t5,a2
                                                          + (uint32_t)x * 2u);
    39c8:	00481313          	slli	t1,a6,0x4
    39cc:	41030333          	sub	t1,t1,a6
    39d0:	00631313          	slli	t1,t1,0x6
    39d4:	00b30333          	add	t1,t1,a1
    39d8:	00131313          	slli	t1,t1,0x1
    39dc:	00a30333          	add	t1,t1,a0
        if (odd) { *p++ = color; rem--; }
    39e0:	f80f8ee3          	beqz	t6,397c <cpu_fill32+0x14>
    39e4:	00f31023          	sh	a5,0(t1)
    39e8:	fff68e13          	addi	t3,a3,-1
    39ec:	00230313          	addi	t1,t1,2
            for (i = 0; i < (rem >> 1); i++) q[i] = two;
    39f0:	00000813          	li	a6,0
    39f4:	fa1ff06f          	j	3994 <cpu_fill32+0x2c>
}
    39f8:	00008067          	ret

000039fc <blend565>:
{
    39fc:	00060693          	mv	a3,a2
    unsigned fr = (fg >> 11) & 0x1Fu, fgc = (fg >> 5) & 0x3Fu, fb = fg & 0x1Fu;
    3a00:	00b55713          	srli	a4,a0,0xb
    3a04:	00555613          	srli	a2,a0,0x5
    3a08:	03f67613          	andi	a2,a2,63
    3a0c:	01f57513          	andi	a0,a0,31
    unsigned br = (bg >> 11) & 0x1Fu, bgc = (bg >> 5) & 0x3Fu, bb = bg & 0x1Fu;
    3a10:	00b5d893          	srli	a7,a1,0xb
    3a14:	0055d813          	srli	a6,a1,0x5
    3a18:	03f87813          	andi	a6,a6,63
    3a1c:	01f5f593          	andi	a1,a1,31
    unsigned f8r = (fr << 3) | (fr >> 2), f8g = (fgc << 2) | (fgc >> 4), f8b = (fb << 3) | (fb >> 2);
    3a20:	00371793          	slli	a5,a4,0x3
    3a24:	00275713          	srli	a4,a4,0x2
    3a28:	00e7e7b3          	or	a5,a5,a4
    3a2c:	00261713          	slli	a4,a2,0x2
    3a30:	00465613          	srli	a2,a2,0x4
    3a34:	00c76733          	or	a4,a4,a2
    3a38:	00351613          	slli	a2,a0,0x3
    3a3c:	00255513          	srli	a0,a0,0x2
    3a40:	00a66633          	or	a2,a2,a0
    unsigned b8r = (br << 3) | (br >> 2), b8g = (bgc << 2) | (bgc >> 4), b8b = (bb << 3) | (bb >> 2);
    3a44:	00389513          	slli	a0,a7,0x3
    3a48:	0028d893          	srli	a7,a7,0x2
    3a4c:	011568b3          	or	a7,a0,a7
    3a50:	00281513          	slli	a0,a6,0x2
    3a54:	00485813          	srli	a6,a6,0x4
    3a58:	01056833          	or	a6,a0,a6
    3a5c:	00359513          	slli	a0,a1,0x3
    3a60:	0025d593          	srli	a1,a1,0x2
    3a64:	00b565b3          	or	a1,a0,a1
    unsigned ai  = 255u - a;
    3a68:	0ff00e13          	li	t3,255
    3a6c:	40de0333          	sub	t1,t3,a3
    unsigned r = (f8r * a + b8r * ai + 127u) >> 8;
    3a70:	02d787b3          	mul	a5,a5,a3
    3a74:	02688533          	mul	a0,a7,t1
    3a78:	00a787b3          	add	a5,a5,a0
    3a7c:	07f78793          	addi	a5,a5,127
    3a80:	0087d793          	srli	a5,a5,0x8
    unsigned g = (f8g * a + b8g * ai + 127u) >> 8;
    3a84:	02d70733          	mul	a4,a4,a3
    3a88:	02680533          	mul	a0,a6,t1
    3a8c:	00a70733          	add	a4,a4,a0
    3a90:	07f70713          	addi	a4,a4,127
    3a94:	00875713          	srli	a4,a4,0x8
    unsigned b = (f8b * a + b8b * ai + 127u) >> 8;
    3a98:	02d60633          	mul	a2,a2,a3
    3a9c:	026586b3          	mul	a3,a1,t1
    3aa0:	00d60633          	add	a2,a2,a3
    3aa4:	07f60613          	addi	a2,a2,127
    3aa8:	00865613          	srli	a2,a2,0x8
    if (r > 255u) r = 255u;
    3aac:	00fe7463          	bgeu	t3,a5,3ab4 <blend565+0xb8>
    3ab0:	0ff00793          	li	a5,255
    if (g > 255u) g = 255u;
    3ab4:	0ff00693          	li	a3,255
    3ab8:	00e6f463          	bgeu	a3,a4,3ac0 <blend565+0xc4>
    3abc:	0ff00713          	li	a4,255
    if (b > 255u) b = 255u;
    3ac0:	0ff00693          	li	a3,255
    3ac4:	00c6f463          	bgeu	a3,a2,3acc <blend565+0xd0>
    3ac8:	0ff00613          	li	a2,255
    return (uint16_t)(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3));
    3acc:	0037d513          	srli	a0,a5,0x3
    3ad0:	00b51513          	slli	a0,a0,0xb
    3ad4:	01051513          	slli	a0,a0,0x10
    3ad8:	01055513          	srli	a0,a0,0x10
    3adc:	00275713          	srli	a4,a4,0x2
    3ae0:	00571713          	slli	a4,a4,0x5
    3ae4:	01071713          	slli	a4,a4,0x10
    3ae8:	01075713          	srli	a4,a4,0x10
    3aec:	00e56533          	or	a0,a0,a4
    3af0:	00365613          	srli	a2,a2,0x3
    3af4:	00c56533          	or	a0,a0,a2
}
    3af8:	01051513          	slli	a0,a0,0x10
    3afc:	01055513          	srli	a0,a0,0x10
    3b00:	00008067          	ret

00003b04 <cpu_alpha_sprite>:
{
    3b04:	fd010113          	addi	sp,sp,-48
    3b08:	02112623          	sw	ra,44(sp)
    3b0c:	02812423          	sw	s0,40(sp)
    3b10:	02912223          	sw	s1,36(sp)
    3b14:	03212023          	sw	s2,32(sp)
    3b18:	01312e23          	sw	s3,28(sp)
    3b1c:	01412c23          	sw	s4,24(sp)
    3b20:	01512a23          	sw	s5,20(sp)
    3b24:	01612823          	sw	s6,16(sp)
    3b28:	01712623          	sw	s7,12(sp)
    3b2c:	00050b93          	mv	s7,a0
    3b30:	00058b13          	mv	s6,a1
    3b34:	00060a93          	mv	s5,a2
    for (j = 0; j < SPR_H; j++) {
    3b38:	00000a13          	li	s4,0
    3b3c:	0400006f          	j	3b7c <cpu_alpha_sprite+0x78>
            d[i] = blend565(s[j * SPR_W + i], d[i], alpha);
    3b40:	034907b3          	mul	a5,s2,s4
    3b44:	008787b3          	add	a5,a5,s0
    3b48:	00179793          	slli	a5,a5,0x1
    3b4c:	00201737          	lui	a4,0x201
    3b50:	00f707b3          	add	a5,a4,a5
    3b54:	0007d503          	lhu	a0,0(a5)
    3b58:	00141493          	slli	s1,s0,0x1
    3b5c:	009984b3          	add	s1,s3,s1
    3b60:	0004d583          	lhu	a1,0(s1)
    3b64:	000a8613          	mv	a2,s5
    3b68:	e95ff0ef          	jal	39fc <blend565>
    3b6c:	00a49023          	sh	a0,0(s1)
        for (i = 0; i < SPR_W; i++)
    3b70:	00140413          	addi	s0,s0,1
    3b74:	fd2446e3          	blt	s0,s2,3b40 <cpu_alpha_sprite+0x3c>
    for (j = 0; j < SPR_H; j++) {
    3b78:	001a0a13          	addi	s4,s4,1
    3b7c:	8201a903          	lw	s2,-2016(gp) # 7ea8 <g_blk>
    3b80:	032a5663          	bge	s4,s2,3bac <cpu_alpha_sprite+0xa8>
                                + (uint32_t)(y + j) * FB_STRIDE + (uint32_t)x * 2u);
    3b84:	016a07b3          	add	a5,s4,s6
    3b88:	00479993          	slli	s3,a5,0x4
    3b8c:	40f989b3          	sub	s3,s3,a5
    3b90:	00699993          	slli	s3,s3,0x6
    3b94:	017989b3          	add	s3,s3,s7
    3b98:	00199993          	slli	s3,s3,0x1
    3b9c:	82c1a783          	lw	a5,-2004(gp) # 7eb4 <g_fb_back>
    3ba0:	00f989b3          	add	s3,s3,a5
        for (i = 0; i < SPR_W; i++)
    3ba4:	00000413          	li	s0,0
    3ba8:	fcdff06f          	j	3b74 <cpu_alpha_sprite+0x70>
}
    3bac:	02c12083          	lw	ra,44(sp)
    3bb0:	02812403          	lw	s0,40(sp)
    3bb4:	02412483          	lw	s1,36(sp)
    3bb8:	02012903          	lw	s2,32(sp)
    3bbc:	01c12983          	lw	s3,28(sp)
    3bc0:	01812a03          	lw	s4,24(sp)
    3bc4:	01412a83          	lw	s5,20(sp)
    3bc8:	01012b03          	lw	s6,16(sp)
    3bcc:	00c12b83          	lw	s7,12(sp)
    3bd0:	03010113          	addi	sp,sp,48
    3bd4:	00008067          	ret

00003bd8 <cpu_key_sprite>:
    for (j = 0; j < SPR_H; j++) {
    3bd8:	00000893          	li	a7,0
    3bdc:	04c0006f          	j	3c28 <cpu_key_sprite+0x50>
            if (c != (uint16_t)KEY_COLOR) d[i] = c;
    3be0:	00171693          	slli	a3,a4,0x1
    3be4:	00d806b3          	add	a3,a6,a3
    3be8:	00f69023          	sh	a5,0(a3)
        for (i = 0; i < SPR_W; i++) {
    3bec:	00170713          	addi	a4,a4,1 # 201001 <__freertos_irq_stack_top+0x1bd6c1>
    3bf0:	02c75a63          	bge	a4,a2,3c24 <cpu_key_sprite+0x4c>
            uint16_t c = s[j * SPR_W + i];
    3bf4:	031607b3          	mul	a5,a2,a7
    3bf8:	00e787b3          	add	a5,a5,a4
    3bfc:	00179793          	slli	a5,a5,0x1
    3c00:	002016b7          	lui	a3,0x201
    3c04:	00f687b3          	add	a5,a3,a5
    3c08:	0007d783          	lhu	a5,0(a5)
    3c0c:	01079793          	slli	a5,a5,0x10
    3c10:	0107d793          	srli	a5,a5,0x10
            if (c != (uint16_t)KEY_COLOR) d[i] = c;
    3c14:	000106b7          	lui	a3,0x10
    3c18:	81f68693          	addi	a3,a3,-2017 # f81f <__global_pointer$+0x7197>
    3c1c:	fcd792e3          	bne	a5,a3,3be0 <cpu_key_sprite+0x8>
    3c20:	fcdff06f          	j	3bec <cpu_key_sprite+0x14>
    for (j = 0; j < SPR_H; j++) {
    3c24:	00188893          	addi	a7,a7,1
    3c28:	8201a603          	lw	a2,-2016(gp) # 7ea8 <g_blk>
    3c2c:	02c8d663          	bge	a7,a2,3c58 <cpu_key_sprite+0x80>
                                + (uint32_t)(y + j) * FB_STRIDE + (uint32_t)x * 2u);
    3c30:	00b887b3          	add	a5,a7,a1
    3c34:	00479813          	slli	a6,a5,0x4
    3c38:	40f80833          	sub	a6,a6,a5
    3c3c:	00681813          	slli	a6,a6,0x6
    3c40:	00a80833          	add	a6,a6,a0
    3c44:	00181813          	slli	a6,a6,0x1
    3c48:	82c1a783          	lw	a5,-2004(gp) # 7eb4 <g_fb_back>
    3c4c:	00f80833          	add	a6,a6,a5
        for (i = 0; i < SPR_W; i++) {
    3c50:	00000713          	li	a4,0
    3c54:	f9dff06f          	j	3bf0 <cpu_key_sprite+0x18>
}
    3c58:	00008067          	ret

00003c5c <glyph_of>:
    if (c >= 'a' && c <= 'z') c = (char)(c - 'a' + 'A');
    3c5c:	f9f50793          	addi	a5,a0,-97 # 200f9f <__freertos_irq_stack_top+0x1bd65f>
    3c60:	0ff7f793          	zext.b	a5,a5
    3c64:	01900713          	li	a4,25
    3c68:	00f76663          	bltu	a4,a5,3c74 <glyph_of+0x18>
    3c6c:	fe050513          	addi	a0,a0,-32
    3c70:	0ff57513          	zext.b	a0,a0
    for (i = 0; i < FONT_N; i++) if (g_font[i].c == c) return g_font[i].r;
    3c74:	00000713          	li	a4,0
    3c78:	02300793          	li	a5,35
    3c7c:	02e7ce63          	blt	a5,a4,3cb8 <glyph_of+0x5c>
    3c80:	000087b7          	lui	a5,0x8
    3c84:	00371693          	slli	a3,a4,0x3
    3c88:	00e686b3          	add	a3,a3,a4
    3c8c:	c4478793          	addi	a5,a5,-956 # 7c44 <g_font>
    3c90:	00d787b3          	add	a5,a5,a3
    3c94:	0007c783          	lbu	a5,0(a5)
    3c98:	00a78663          	beq	a5,a0,3ca4 <glyph_of+0x48>
    3c9c:	00170713          	addi	a4,a4,1
    3ca0:	fd9ff06f          	j	3c78 <glyph_of+0x1c>
    3ca4:	000087b7          	lui	a5,0x8
    3ca8:	c4478793          	addi	a5,a5,-956 # 7c44 <g_font>
    3cac:	00f68533          	add	a0,a3,a5
    3cb0:	00150513          	addi	a0,a0,1
    3cb4:	00008067          	ret
    return g_font[0].r;
    3cb8:	00008537          	lui	a0,0x8
    3cbc:	c4550513          	addi	a0,a0,-955 # 7c45 <g_font+0x1>
}
    3cc0:	00008067          	ret

00003cc4 <osd_text>:
{
    3cc4:	fe010113          	addi	sp,sp,-32
    3cc8:	00112e23          	sw	ra,28(sp)
    3ccc:	00812c23          	sw	s0,24(sp)
    3cd0:	00912a23          	sw	s1,20(sp)
    3cd4:	01212823          	sw	s2,16(sp)
    3cd8:	01312623          	sw	s3,12(sp)
    3cdc:	00050493          	mv	s1,a0
    3ce0:	00058913          	mv	s2,a1
    3ce4:	00060993          	mv	s3,a2
    3ce8:	00068413          	mv	s0,a3
    while (*s) {
    3cec:	1000006f          	j	3dec <osd_text+0x128>
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3cf0:	00000613          	li	a2,0
                 | ((bits & 0x80u) ? (uint32_t)fg : (uint32_t)COL_OSD_BG);
    3cf4:	01871593          	slli	a1,a4,0x18
    3cf8:	4185d593          	srai	a1,a1,0x18
    3cfc:	0205c063          	bltz	a1,3d1c <osd_text+0x58>
    3d00:	00000593          	li	a1,0
    3d04:	00b66633          	or	a2,a2,a1
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d08:	00c7a023          	sw	a2,0(a5)
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d0c:	01077613          	andi	a2,a4,16
    3d10:	00060a63          	beqz	a2,3d24 <osd_text+0x60>
    3d14:	01041613          	slli	a2,s0,0x10
    3d18:	0100006f          	j	3d28 <osd_text+0x64>
                 | ((bits & 0x80u) ? (uint32_t)fg : (uint32_t)COL_OSD_BG);
    3d1c:	00040593          	mv	a1,s0
    3d20:	fe5ff06f          	j	3d04 <osd_text+0x40>
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d24:	00000613          	li	a2,0
                 | ((bits & 0x20u) ? (uint32_t)fg : (uint32_t)COL_OSD_BG);
    3d28:	02077593          	andi	a1,a4,32
    3d2c:	00058663          	beqz	a1,3d38 <osd_text+0x74>
    3d30:	00040593          	mv	a1,s0
    3d34:	0080006f          	j	3d3c <osd_text+0x78>
    3d38:	00000593          	li	a1,0
    3d3c:	00b66633          	or	a2,a2,a1
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d40:	00c7a223          	sw	a2,4(a5)
            p[2] = ((bits & 0x04u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d44:	00477613          	andi	a2,a4,4
    3d48:	00060663          	beqz	a2,3d54 <osd_text+0x90>
    3d4c:	01041613          	slli	a2,s0,0x10
    3d50:	0080006f          	j	3d58 <osd_text+0x94>
    3d54:	00000613          	li	a2,0
                 | ((bits & 0x08u) ? (uint32_t)fg : (uint32_t)COL_OSD_BG);
    3d58:	00877593          	andi	a1,a4,8
    3d5c:	00058663          	beqz	a1,3d68 <osd_text+0xa4>
    3d60:	00040593          	mv	a1,s0
    3d64:	0080006f          	j	3d6c <osd_text+0xa8>
    3d68:	00000593          	li	a1,0
    3d6c:	00b66633          	or	a2,a2,a1
            p[2] = ((bits & 0x04u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d70:	00c7a423          	sw	a2,8(a5)
            p[3] = ((bits & 0x01u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3d74:	00177613          	andi	a2,a4,1
    3d78:	00060663          	beqz	a2,3d84 <osd_text+0xc0>
    3d7c:	01041613          	slli	a2,s0,0x10
    3d80:	0080006f          	j	3d88 <osd_text+0xc4>
    3d84:	00000613          	li	a2,0
                 | ((bits & 0x02u) ? (uint32_t)fg : (uint32_t)COL_OSD_BG);
    3d88:	00277713          	andi	a4,a4,2
    3d8c:	00070663          	beqz	a4,3d98 <osd_text+0xd4>
    3d90:	00040713          	mv	a4,s0
    3d94:	0080006f          	j	3d9c <osd_text+0xd8>
    3d98:	00000713          	li	a4,0
    3d9c:	00e66733          	or	a4,a2,a4
            p[3] = ((bits & 0x01u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3da0:	00e7a623          	sw	a4,12(a5)
        for (row = 0; row < 8; row++) {
    3da4:	00168693          	addi	a3,a3,1
    3da8:	00700793          	li	a5,7
    3dac:	02d7ce63          	blt	a5,a3,3de8 <osd_text+0x124>
            uint8_t bits = rp[row];
    3db0:	00d507b3          	add	a5,a0,a3
    3db4:	0007c703          	lbu	a4,0(a5)
                                    + (uint32_t)(y + row) * FB_STRIDE + (uint32_t)x * 2u);
    3db8:	01268633          	add	a2,a3,s2
    3dbc:	00461793          	slli	a5,a2,0x4
    3dc0:	40c787b3          	sub	a5,a5,a2
    3dc4:	00679793          	slli	a5,a5,0x6
    3dc8:	009787b3          	add	a5,a5,s1
    3dcc:	00179793          	slli	a5,a5,0x1
    3dd0:	82c1a603          	lw	a2,-2004(gp) # 7eb4 <g_fb_back>
    3dd4:	00c787b3          	add	a5,a5,a2
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)COL_OSD_BG << 16))
    3dd8:	04077613          	andi	a2,a4,64
    3ddc:	f0060ae3          	beqz	a2,3cf0 <osd_text+0x2c>
    3de0:	01041613          	slli	a2,s0,0x10
    3de4:	f11ff06f          	j	3cf4 <osd_text+0x30>
        x += OSD_GLYPH_W;
    3de8:	00848493          	addi	s1,s1,8
    while (*s) {
    3dec:	0009c503          	lbu	a0,0(s3)
    3df0:	00050a63          	beqz	a0,3e04 <osd_text+0x140>
        const uint8_t *rp = glyph_of(*s++);
    3df4:	00198993          	addi	s3,s3,1
    3df8:	e65ff0ef          	jal	3c5c <glyph_of>
        for (row = 0; row < 8; row++) {
    3dfc:	00000693          	li	a3,0
    3e00:	fa9ff06f          	j	3da8 <osd_text+0xe4>
}
    3e04:	01c12083          	lw	ra,28(sp)
    3e08:	01812403          	lw	s0,24(sp)
    3e0c:	01412483          	lw	s1,20(sp)
    3e10:	01012903          	lw	s2,16(sp)
    3e14:	00c12983          	lw	s3,12(sp)
    3e18:	02010113          	addi	sp,sp,32
    3e1c:	00008067          	ret

00003e20 <app>:
static char *app(char *p, const char *s) { while (*s) *p++ = *s++; return p; }
    3e20:	0100006f          	j	3e30 <app+0x10>
    3e24:	00158593          	addi	a1,a1,1
    3e28:	00f50023          	sb	a5,0(a0)
    3e2c:	00150513          	addi	a0,a0,1
    3e30:	0005c783          	lbu	a5,0(a1)
    3e34:	fe0798e3          	bnez	a5,3e24 <app+0x4>
    3e38:	00008067          	ret

00003e3c <appn>:
{
    3e3c:	ff010113          	addi	sp,sp,-16
    char d[12]; int n = 0, i;
    3e40:	00000793          	li	a5,0
    do { d[n++] = (char)('0' + (v % 10u)); v /= 10u; } while (v && n < 11);
    3e44:	00a00813          	li	a6,10
    3e48:	0305f6b3          	remu	a3,a1,a6
    3e4c:	03068693          	addi	a3,a3,48
    3e50:	01078713          	addi	a4,a5,16
    3e54:	00270733          	add	a4,a4,sp
    3e58:	00178793          	addi	a5,a5,1
    3e5c:	fed70a23          	sb	a3,-12(a4)
    3e60:	00058693          	mv	a3,a1
    3e64:	0305d5b3          	divu	a1,a1,a6
    3e68:	00900713          	li	a4,9
    3e6c:	02d77863          	bgeu	a4,a3,3e9c <appn+0x60>
    3e70:	00a00713          	li	a4,10
    3e74:	fcf758e3          	bge	a4,a5,3e44 <appn+0x8>
    3e78:	00000713          	li	a4,0
    3e7c:	0140006f          	j	3e90 <appn+0x54>
    for (i = 0; i < w - n; i++) *p++ = ' ';
    3e80:	02000693          	li	a3,32
    3e84:	00d50023          	sb	a3,0(a0)
    3e88:	00170713          	addi	a4,a4,1
    3e8c:	00150513          	addi	a0,a0,1
    3e90:	40f606b3          	sub	a3,a2,a5
    3e94:	fed746e3          	blt	a4,a3,3e80 <appn+0x44>
    3e98:	0240006f          	j	3ebc <appn+0x80>
    3e9c:	00000713          	li	a4,0
    3ea0:	ff1ff06f          	j	3e90 <appn+0x54>
    while (n) *p++ = d[--n];
    3ea4:	fff78793          	addi	a5,a5,-1
    3ea8:	01078713          	addi	a4,a5,16
    3eac:	00270733          	add	a4,a4,sp
    3eb0:	ff474703          	lbu	a4,-12(a4)
    3eb4:	00e50023          	sb	a4,0(a0)
    3eb8:	00150513          	addi	a0,a0,1
    3ebc:	fe0794e3          	bnez	a5,3ea4 <appn+0x68>
}
    3ec0:	01010113          	addi	sp,sp,16
    3ec4:	00008067          	ret

00003ec8 <slen>:
static int slen(const char *s) { int n = 0; while (s[n]) n++; return n; }
    3ec8:	00050713          	mv	a4,a0
    3ecc:	00000513          	li	a0,0
    3ed0:	0080006f          	j	3ed8 <slen+0x10>
    3ed4:	00150513          	addi	a0,a0,1
    3ed8:	00a707b3          	add	a5,a4,a0
    3edc:	0007c783          	lbu	a5,0(a5)
    3ee0:	fe079ae3          	bnez	a5,3ed4 <slen+0xc>
    3ee4:	00008067          	ret

00003ee8 <sseq>:
    while (*a && *a == *b) { a++; b++; }
    3ee8:	00c0006f          	j	3ef4 <sseq+0xc>
    3eec:	00150513          	addi	a0,a0,1
    3ef0:	00158593          	addi	a1,a1,1
    3ef4:	00054783          	lbu	a5,0(a0)
    3ef8:	00078663          	beqz	a5,3f04 <sseq+0x1c>
    3efc:	0005c703          	lbu	a4,0(a1)
    3f00:	fee786e3          	beq	a5,a4,3eec <sseq+0x4>
    return (*a == *b) ? 1 : 0;
    3f04:	0005c703          	lbu	a4,0(a1)
    3f08:	40e78533          	sub	a0,a5,a4
}
    3f0c:	00153513          	seqz	a0,a0
    3f10:	00008067          	ret

00003f14 <scpy>:
static void scpy(char *d, const char *s) { while ((*d++ = *s++) != 0) { } }
    3f14:	0005c703          	lbu	a4,0(a1)
    3f18:	00158593          	addi	a1,a1,1
    3f1c:	00e50023          	sb	a4,0(a0)
    3f20:	00150513          	addi	a0,a0,1
    3f24:	fe0718e3          	bnez	a4,3f14 <scpy>
    3f28:	00008067          	ret

00003f2c <scene_name>:
    return (scene == SC_ALPHA) ? "ALPHA" : ((scene == SC_KEY) ? "KEY" : "FILL");
    3f2c:	00100793          	li	a5,1
    3f30:	02f50263          	beq	a0,a5,3f54 <scene_name+0x28>
    3f34:	00200793          	li	a5,2
    3f38:	00f50863          	beq	a0,a5,3f48 <scene_name+0x1c>
    3f3c:	00006537          	lui	a0,0x6
    3f40:	14c50513          	addi	a0,a0,332 # 614c <_data+0x28>
}
    3f44:	00008067          	ret
    return (scene == SC_ALPHA) ? "ALPHA" : ((scene == SC_KEY) ? "KEY" : "FILL");
    3f48:	00006537          	lui	a0,0x6
    3f4c:	15c50513          	addi	a0,a0,348 # 615c <_data+0x38>
    3f50:	00008067          	ret
    3f54:	00006537          	lui	a0,0x6
    3f58:	15450513          	addi	a0,a0,340 # 6154 <_data+0x30>
    3f5c:	00008067          	ret

00003f60 <path_label>:
    return (path == PATH_SPLIT) ? "SPLIT" : ((path == PATH_CPU) ? "CPU ONLY" : "HW ONLY");
    3f60:	02050263          	beqz	a0,3f84 <path_label+0x24>
    3f64:	00100793          	li	a5,1
    3f68:	00f50863          	beq	a0,a5,3f78 <path_label+0x18>
    3f6c:	00006537          	lui	a0,0x6
    3f70:	16050513          	addi	a0,a0,352 # 6160 <_data+0x3c>
}
    3f74:	00008067          	ret
    return (path == PATH_SPLIT) ? "SPLIT" : ((path == PATH_CPU) ? "CPU ONLY" : "HW ONLY");
    3f78:	00006537          	lui	a0,0x6
    3f7c:	17050513          	addi	a0,a0,368 # 6170 <_data+0x4c>
    3f80:	00008067          	ret
    3f84:	00006537          	lui	a0,0x6
    3f88:	16850513          	addi	a0,a0,360 # 6168 <_data+0x44>
    3f8c:	00008067          	ret

00003f90 <fmt_stat>:
{
    3f90:	fe010113          	addi	sp,sp,-32
    3f94:	00112e23          	sw	ra,28(sp)
    3f98:	00812c23          	sw	s0,24(sp)
    3f9c:	00912a23          	sw	s1,20(sp)
    3fa0:	01212823          	sw	s2,16(sp)
    3fa4:	01312623          	sw	s3,12(sp)
    3fa8:	01412423          	sw	s4,8(sp)
    3fac:	01512223          	sw	s5,4(sp)
    3fb0:	01612023          	sw	s6,0(sp)
    3fb4:	00058913          	mv	s2,a1
    3fb8:	00060493          	mv	s1,a2
    3fbc:	00068413          	mv	s0,a3
    3fc0:	00070b13          	mv	s6,a4
    3fc4:	00078993          	mv	s3,a5
    3fc8:	00080a93          	mv	s5,a6
    3fcc:	00088a13          	mv	s4,a7
    if (hw_fps  > 999u) hw_fps  = 999u;        /* 钳位只为把最长串钉死在上界内 */
    3fd0:	3e700793          	li	a5,999
    3fd4:	00b7f463          	bgeu	a5,a1,3fdc <fmt_stat+0x4c>
    3fd8:	3e700913          	li	s2,999
    if (cpu_fps > 999u) cpu_fps = 999u;
    3fdc:	3e700793          	li	a5,999
    3fe0:	0097f463          	bgeu	a5,s1,3fe8 <fmt_stat+0x58>
    3fe4:	3e700493          	li	s1,999
    if (scr_fps >  99u) scr_fps =  99u;
    3fe8:	06300793          	li	a5,99
    3fec:	0087f463          	bgeu	a5,s0,3ff4 <fmt_stat+0x64>
    3ff0:	06300413          	li	s0,99
    p = app(p, "HW=");   p = appn(p, hw_fps,  3);
    3ff4:	000065b7          	lui	a1,0x6
    3ff8:	17c58593          	addi	a1,a1,380 # 617c <_data+0x58>
    3ffc:	e25ff0ef          	jal	3e20 <app>
    4000:	00300613          	li	a2,3
    4004:	00090593          	mv	a1,s2
    4008:	e35ff0ef          	jal	3e3c <appn>
    p = app(p, " CPU="); p = appn(p, cpu_fps, 3);
    400c:	000065b7          	lui	a1,0x6
    4010:	18058593          	addi	a1,a1,384 # 6180 <_data+0x5c>
    4014:	e0dff0ef          	jal	3e20 <app>
    4018:	00300613          	li	a2,3
    401c:	00048593          	mv	a1,s1
    4020:	e1dff0ef          	jal	3e3c <appn>
    p = app(p, " SCR="); p = appn(p, scr_fps, 2);
    4024:	000065b7          	lui	a1,0x6
    4028:	18858593          	addi	a1,a1,392 # 6188 <_data+0x64>
    402c:	df5ff0ef          	jal	3e20 <app>
    4030:	00200613          	li	a2,2
    4034:	00040593          	mv	a1,s0
    4038:	e05ff0ef          	jal	3e3c <appn>
    p = app(p, " SZ=");  p = appn(p, (unsigned)blk, 2);
    403c:	000065b7          	lui	a1,0x6
    4040:	19058593          	addi	a1,a1,400 # 6190 <_data+0x6c>
    4044:	dddff0ef          	jal	3e20 <app>
    4048:	00200613          	li	a2,2
    404c:	02412583          	lw	a1,36(sp)
    4050:	dedff0ef          	jal	3e3c <appn>
    p = app(p, " N=");   p = appn(p, (unsigned)n, 4);
    4054:	000065b7          	lui	a1,0x6
    4058:	19858593          	addi	a1,a1,408 # 6198 <_data+0x74>
    405c:	dc5ff0ef          	jal	3e20 <app>
    4060:	00400613          	li	a2,4
    4064:	000b0593          	mv	a1,s6
    4068:	dd5ff0ef          	jal	3e3c <appn>
    p = app(p, " SC");   p = appn(p, (unsigned)(scene + 1), 1);
    406c:	000065b7          	lui	a1,0x6
    4070:	19c58593          	addi	a1,a1,412 # 619c <_data+0x78>
    4074:	dadff0ef          	jal	3e20 <app>
    4078:	00100613          	li	a2,1
    407c:	00198593          	addi	a1,s3,1
    4080:	dbdff0ef          	jal	3e3c <appn>
    p = app(p, ":");
    4084:	000065b7          	lui	a1,0x6
    4088:	1a058593          	addi	a1,a1,416 # 61a0 <_data+0x7c>
    408c:	d95ff0ef          	jal	3e20 <app>
    4090:	00050413          	mv	s0,a0
    p = app(p, scene_name(scene));
    4094:	00098513          	mv	a0,s3
    4098:	e95ff0ef          	jal	3f2c <scene_name>
    409c:	00050593          	mv	a1,a0
    40a0:	00040513          	mv	a0,s0
    40a4:	d7dff0ef          	jal	3e20 <app>
    p = app(p, " A=");   p = appn(p, alpha, 3);
    40a8:	000065b7          	lui	a1,0x6
    40ac:	1a458593          	addi	a1,a1,420 # 61a4 <_data+0x80>
    40b0:	d71ff0ef          	jal	3e20 <app>
    40b4:	00300613          	li	a2,3
    40b8:	000a8593          	mv	a1,s5
    40bc:	d81ff0ef          	jal	3e3c <appn>
    if (clear_pp)  p = app(p, " E");
    40c0:	040a1063          	bnez	s4,4100 <fmt_stat+0x170>
    if (frame_adv) p = app(p, " FR");
    40c4:	02012783          	lw	a5,32(sp)
    40c8:	04079463          	bnez	a5,4110 <fmt_stat+0x180>
    if (dl)        p = app(p, " L");          /* ★v2.11 列表路径标记（'l' 切换） */
    40cc:	02812783          	lw	a5,40(sp)
    40d0:	04079863          	bnez	a5,4120 <fmt_stat+0x190>
    *p = 0;
    40d4:	00050023          	sb	zero,0(a0)
}
    40d8:	01c12083          	lw	ra,28(sp)
    40dc:	01812403          	lw	s0,24(sp)
    40e0:	01412483          	lw	s1,20(sp)
    40e4:	01012903          	lw	s2,16(sp)
    40e8:	00c12983          	lw	s3,12(sp)
    40ec:	00812a03          	lw	s4,8(sp)
    40f0:	00412a83          	lw	s5,4(sp)
    40f4:	00012b03          	lw	s6,0(sp)
    40f8:	02010113          	addi	sp,sp,32
    40fc:	00008067          	ret
    if (clear_pp)  p = app(p, " E");
    4100:	000065b7          	lui	a1,0x6
    4104:	1a858593          	addi	a1,a1,424 # 61a8 <_data+0x84>
    4108:	d19ff0ef          	jal	3e20 <app>
    410c:	fb9ff06f          	j	40c4 <fmt_stat+0x134>
    if (frame_adv) p = app(p, " FR");
    4110:	000065b7          	lui	a1,0x6
    4114:	1ac58593          	addi	a1,a1,428 # 61ac <_data+0x88>
    4118:	d09ff0ef          	jal	3e20 <app>
    411c:	fb1ff06f          	j	40cc <fmt_stat+0x13c>
    if (dl)        p = app(p, " L");          /* ★v2.11 列表路径标记（'l' 切换） */
    4120:	000065b7          	lui	a1,0x6
    4124:	1b058593          	addi	a1,a1,432 # 61b0 <_data+0x8c>
    4128:	cf9ff0ef          	jal	3e20 <app>
    412c:	fa9ff06f          	j	40d4 <fmt_stat+0x144>

00004130 <osd_build>:
{
    4130:	f9010113          	addi	sp,sp,-112
    4134:	06112623          	sw	ra,108(sp)
    fmt_stat(tmp, g_hw_fps, g_cpu_fps, g_scr_fps, n, scene, alpha, clear_pp, frame_adv, blk, dl);
    4138:	01012423          	sw	a6,8(sp)
    413c:	00f12223          	sw	a5,4(sp)
    4140:	00e12023          	sw	a4,0(sp)
    4144:	00068893          	mv	a7,a3
    4148:	00060813          	mv	a6,a2
    414c:	00058793          	mv	a5,a1
    4150:	00050713          	mv	a4,a0
    4154:	8a81a683          	lw	a3,-1880(gp) # 7f30 <g_scr_fps>
    4158:	8ac1a603          	lw	a2,-1876(gp) # 7f34 <g_cpu_fps>
    415c:	8b01a583          	lw	a1,-1872(gp) # 7f38 <g_hw_fps>
    4160:	01c10513          	addi	a0,sp,28
    4164:	e2dff0ef          	jal	3f90 <fmt_stat>
    if (!sseq(tmp, g_osd_line)) { scpy(g_osd_line, tmp); g_osd_dirty = 1; }
    4168:	8ec18593          	addi	a1,gp,-1812 # 7f74 <g_osd_line>
    416c:	01c10513          	addi	a0,sp,28
    4170:	d79ff0ef          	jal	3ee8 <sseq>
    4174:	00050863          	beqz	a0,4184 <osd_build+0x54>
}
    4178:	06c12083          	lw	ra,108(sp)
    417c:	07010113          	addi	sp,sp,112
    4180:	00008067          	ret
    if (!sseq(tmp, g_osd_line)) { scpy(g_osd_line, tmp); g_osd_dirty = 1; }
    4184:	01c10593          	addi	a1,sp,28
    4188:	8ec18513          	addi	a0,gp,-1812 # 7f74 <g_osd_line>
    418c:	d89ff0ef          	jal	3f14 <scpy>
    4190:	00100713          	li	a4,1
    4194:	80e1ac23          	sw	a4,-2024(gp) # 7ea0 <g_osd_dirty>
}
    4198:	fe1ff06f          	j	4178 <osd_build+0x48>

0000419c <osd_service>:
{
    419c:	fd010113          	addi	sp,sp,-48
    41a0:	02112623          	sw	ra,44(sp)
    41a4:	02812423          	sw	s0,40(sp)
    41a8:	01512a23          	sw	s5,20(sp)
    41ac:	00050313          	mv	t1,a0
    41b0:	00078a93          	mv	s5,a5
    uint32_t el = (uint32_t)(t_now - g_osd_t0);
    41b4:	8b41a403          	lw	s0,-1868(gp) # 7f3c <g_osd_t0>
    41b8:	40850433          	sub	s0,a0,s0
    if (el < (uint32_t)BSP_CLINT_HZ) return 0;         /* 每秒最多算一次 */
    41bc:	05f5ee37          	lui	t3,0x5f5e
    41c0:	0ffe0e13          	addi	t3,t3,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f1a7bf>
    41c4:	008e6e63          	bltu	t3,s0,41e0 <osd_service+0x44>
    41c8:	00000513          	li	a0,0
}
    41cc:	02c12083          	lw	ra,44(sp)
    41d0:	02812403          	lw	s0,40(sp)
    41d4:	01412a83          	lw	s5,20(sp)
    41d8:	03010113          	addi	sp,sp,48
    41dc:	00008067          	ret
    41e0:	02912223          	sw	s1,36(sp)
    41e4:	03212023          	sw	s2,32(sp)
    41e8:	01312e23          	sw	s3,28(sp)
    41ec:	01412c23          	sw	s4,24(sp)
    41f0:	01612823          	sw	s6,16(sp)
    41f4:	01712623          	sw	s7,12(sp)
    41f8:	00058513          	mv	a0,a1
    41fc:	00060993          	mv	s3,a2
    4200:	00068913          	mv	s2,a3
    4204:	00070a13          	mv	s4,a4
    4208:	00080b13          	mv	s6,a6
    420c:	00088b93          	mv	s7,a7
    g_osd_t0  = t_now;
    4210:	8a61aa23          	sw	t1,-1868(gp) # 7f3c <g_osd_t0>
    g_hw_fps  = (uint32_t)(((uint64_t)hw_frames  * (uint64_t)BSP_CLINT_HZ) / el);
    4214:	05f5e4b7          	lui	s1,0x5f5e
    4218:	10048493          	addi	s1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x5f1a7c0>
    421c:	0295b5b3          	mulhu	a1,a1,s1
    4220:	00040613          	mv	a2,s0
    4224:	00000693          	li	a3,0
    4228:	02950533          	mul	a0,a0,s1
    422c:	249010ef          	jal	5c74 <__udivdi3>
    4230:	8aa1a823          	sw	a0,-1872(gp) # 7f38 <g_hw_fps>
    g_cpu_fps = (uint32_t)(((uint64_t)cpu_frames * (uint64_t)BSP_CLINT_HZ) / el);
    4234:	0299b5b3          	mulhu	a1,s3,s1
    4238:	00040613          	mv	a2,s0
    423c:	00000693          	li	a3,0
    4240:	02998533          	mul	a0,s3,s1
    4244:	231010ef          	jal	5c74 <__udivdi3>
    4248:	8aa1a623          	sw	a0,-1876(gp) # 7f34 <g_cpu_fps>
    g_scr_fps = (uint32_t)(((uint64_t)scr_frames * (uint64_t)BSP_CLINT_HZ) / el);
    424c:	029935b3          	mulhu	a1,s2,s1
    4250:	00040613          	mv	a2,s0
    4254:	00000693          	li	a3,0
    4258:	02990533          	mul	a0,s2,s1
    425c:	219010ef          	jal	5c74 <__udivdi3>
    4260:	8aa1a423          	sw	a0,-1880(gp) # 7f30 <g_scr_fps>
    osd_build(n, scene, alpha, clear_pp, frame_adv, blk, dl);
    4264:	03812803          	lw	a6,56(sp)
    4268:	03412783          	lw	a5,52(sp)
    426c:	03012703          	lw	a4,48(sp)
    4270:	000b8693          	mv	a3,s7
    4274:	000b0613          	mv	a2,s6
    4278:	000a8593          	mv	a1,s5
    427c:	000a0513          	mv	a0,s4
    4280:	eb1ff0ef          	jal	4130 <osd_build>
    return 1;
    4284:	00100513          	li	a0,1
    4288:	02412483          	lw	s1,36(sp)
    428c:	02012903          	lw	s2,32(sp)
    4290:	01c12983          	lw	s3,28(sp)
    4294:	01812a03          	lw	s4,24(sp)
    4298:	01012b03          	lw	s6,16(sp)
    429c:	00c12b83          	lw	s7,12(sp)
    42a0:	f2dff06f          	j	41cc <osd_service+0x30>

000042a4 <osd_blit>:
{
    42a4:	ff010113          	addi	sp,sp,-16
    42a8:	00112623          	sw	ra,12(sp)
    42ac:	00812423          	sw	s0,8(sp)
    42b0:	00912223          	sw	s1,4(sp)
    42b4:	01212023          	sw	s2,0(sp)
    42b8:	00050493          	mv	s1,a0
    42bc:	00058413          	mv	s0,a1
    cpu_fill32(g_fb_back, OSD_TEXT_X0, 0, OSD_LEFT_PX, OSD_H, COL_OSD_BG);
    42c0:	00000793          	li	a5,0
    42c4:	01000713          	li	a4,16
    42c8:	20000693          	li	a3,512
    42cc:	00000613          	li	a2,0
    42d0:	00800593          	li	a1,8
    42d4:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    42d8:	e90ff0ef          	jal	3968 <cpu_fill32>
    cpu_fill32(g_fb_back, FB_WIDTH - OSD_RIGHT_PX, 0, OSD_RIGHT_PX, OSD_H, COL_OSD_BG);
    42dc:	00000793          	li	a5,0
    42e0:	01000713          	li	a4,16
    42e4:	04000693          	li	a3,64
    42e8:	00000613          	li	a2,0
    42ec:	38000593          	li	a1,896
    42f0:	82c1a503          	lw	a0,-2004(gp) # 7eb4 <g_fb_back>
    42f4:	e74ff0ef          	jal	3968 <cpu_fill32>
    osd_text(OSD_TEXT_X0, OSD_TEXT_Y, line, COL_WHITE);
    42f8:	00010937          	lui	s2,0x10
    42fc:	fff90693          	addi	a3,s2,-1 # ffff <__global_pointer$+0x7977>
    4300:	00048613          	mv	a2,s1
    4304:	00400593          	li	a1,4
    4308:	00800513          	li	a0,8
    430c:	9b9ff0ef          	jal	3cc4 <osd_text>
    osd_text(FB_WIDTH - OSD_GLYPH_W * slen(lbl), OSD_TEXT_Y, lbl, COL_WHITE);
    4310:	00040513          	mv	a0,s0
    4314:	bb5ff0ef          	jal	3ec8 <slen>
    4318:	07800793          	li	a5,120
    431c:	40a78533          	sub	a0,a5,a0
    4320:	fff90693          	addi	a3,s2,-1
    4324:	00040613          	mv	a2,s0
    4328:	00400593          	li	a1,4
    432c:	00351513          	slli	a0,a0,0x3
    4330:	995ff0ef          	jal	3cc4 <osd_text>
}
    4334:	00c12083          	lw	ra,12(sp)
    4338:	00812403          	lw	s0,8(sp)
    433c:	00412483          	lw	s1,4(sp)
    4340:	00012903          	lw	s2,0(sp)
    4344:	01010113          	addi	sp,sp,16
    4348:	00008067          	ret

0000434c <uart_status_raw>:
    return *(volatile uint32_t *)(UART_TERM + UART_STATUS_OFS);
    434c:	f80107b7          	lui	a5,0xf8010
    4350:	0047a503          	lw	a0,4(a5) # f8010004 <__freertos_irq_stack_top+0xf7fcc6c4>
}
    4354:	00008067          	ret

00004358 <uart_poll_char>:
{
    4358:	ff010113          	addi	sp,sp,-16
    435c:	00112623          	sw	ra,12(sp)
    if ((uart_status_raw() >> 24) == 0u) return 0;
    4360:	fedff0ef          	jal	434c <uart_status_raw>
    4364:	01855513          	srli	a0,a0,0x18
    4368:	00050e63          	beqz	a0,4384 <uart_poll_char+0x2c>
    return (int)(*(volatile uint32_t *)(UART_TERM + UART_DATA_OFS) & 0xFFu);
    436c:	f80107b7          	lui	a5,0xf8010
    4370:	0007a503          	lw	a0,0(a5) # f8010000 <__freertos_irq_stack_top+0xf7fcc6c0>
    4374:	0ff57513          	zext.b	a0,a0
}
    4378:	00c12083          	lw	ra,12(sp)
    437c:	01010113          	addi	sp,sp,16
    4380:	00008067          	ret
    if ((uart_status_raw() >> 24) == 0u) return 0;
    4384:	00000513          	li	a0,0
    4388:	ff1ff06f          	j	4378 <uart_poll_char+0x20>

0000438c <nline_feed>:
{
    438c:	00050793          	mv	a5,a0
    if (!g_nl_on) {
    4390:	8a01a503          	lw	a0,-1888(gp) # 7f28 <g_nl_on>
    4394:	02051263          	bnez	a0,43b8 <nline_feed+0x2c>
        if (c != '=') return NL_NONE;    /* 与 '=' 行无关：原样交回单字符命令分支 */
    4398:	03d00713          	li	a4,61
    439c:	00e78463          	beq	a5,a4,43a4 <nline_feed+0x18>
}
    43a0:	00008067          	ret
        g_nl_on = 1; g_nl_n = 0;         /* 看到 '='：启用行缓冲 */
    43a4:	00100713          	li	a4,1
    43a8:	8ae1a023          	sw	a4,-1888(gp) # 7f28 <g_nl_on>
    43ac:	8a01a223          	sw	zero,-1884(gp) # 7f2c <g_nl_n>
        return NL_MORE;
    43b0:	00100513          	li	a0,1
    43b4:	00008067          	ret
    if (c == '\n' || c == '\r') {        /* 行终止：结算 */
    43b8:	00a00713          	li	a4,10
    43bc:	04e78063          	beq	a5,a4,43fc <nline_feed+0x70>
    43c0:	00d00713          	li	a4,13
    43c4:	02e78c63          	beq	a5,a4,43fc <nline_feed+0x70>
    if (c < '0' || c > '9' || g_nl_n >= (unsigned)NLINE_MAX) {
    43c8:	fd078713          	addi	a4,a5,-48
    43cc:	00900693          	li	a3,9
    43d0:	08e6ec63          	bltu	a3,a4,4468 <nline_feed+0xdc>
    43d4:	8a41a683          	lw	a3,-1884(gp) # 7f2c <g_nl_n>
    43d8:	00b00713          	li	a4,11
    43dc:	08d76663          	bltu	a4,a3,4468 <nline_feed+0xdc>
    g_nl[g_nl_n++] = (char)c;
    43e0:	00168613          	addi	a2,a3,1
    43e4:	8ac1a223          	sw	a2,-1884(gp) # 7f2c <g_nl_n>
    43e8:	8e018713          	addi	a4,gp,-1824 # 7f68 <g_nl>
    43ec:	00d70733          	add	a4,a4,a3
    43f0:	00f70023          	sb	a5,0(a4)
    return NL_MORE;
    43f4:	00100513          	li	a0,1
    43f8:	00008067          	ret
        g_nl_on = 0;
    43fc:	8a01a023          	sw	zero,-1888(gp) # 7f28 <g_nl_on>
        if (g_nl_n == 0u) return NL_ERR; /* "=" 后面一个数字都没有 */
    4400:	8a41a603          	lw	a2,-1884(gp) # 7f2c <g_nl_n>
    4404:	06060863          	beqz	a2,4474 <nline_feed+0xe8>
        for (i = 0; i < g_nl_n; i++) {
    4408:	00000693          	li	a3,0
        v = 0u;
    440c:	00000793          	li	a5,0
    4410:	0080006f          	j	4418 <nline_feed+0x8c>
        for (i = 0; i < g_nl_n; i++) {
    4414:	00168693          	addi	a3,a3,1
    4418:	02c6fc63          	bgeu	a3,a2,4450 <nline_feed+0xc4>
            v = v * 10u + (unsigned)(g_nl[i] - '0');
    441c:	00279713          	slli	a4,a5,0x2
    4420:	00f70733          	add	a4,a4,a5
    4424:	00171713          	slli	a4,a4,0x1
    4428:	8e018793          	addi	a5,gp,-1824 # 7f68 <g_nl>
    442c:	00d787b3          	add	a5,a5,a3
    4430:	0007c783          	lbu	a5,0(a5)
    4434:	00e787b3          	add	a5,a5,a4
    4438:	fd078793          	addi	a5,a5,-48
            if (v > (unsigned)N_MAX) v = (unsigned)N_MAX;
    443c:	00001737          	lui	a4,0x1
    4440:	77070713          	addi	a4,a4,1904 # 1770 <main+0x66c>
    4444:	fcf778e3          	bgeu	a4,a5,4414 <nline_feed+0x88>
    4448:	00070793          	mv	a5,a4
    444c:	fc9ff06f          	j	4414 <nline_feed+0x88>
        if (v < (unsigned)N_MIN) v = (unsigned)N_MIN;   /* 下界同样只钳不拒 */
    4450:	01800713          	li	a4,24
    4454:	00f76463          	bltu	a4,a5,445c <nline_feed+0xd0>
    4458:	01900793          	li	a5,25
        *out = (int)v;
    445c:	00f5a023          	sw	a5,0(a1)
        return NL_OK;
    4460:	00200513          	li	a0,2
    4464:	00008067          	ret
        g_nl_on = 0;                     /* 非数字 / 太长：作废并立即复位 */
    4468:	8a01a023          	sw	zero,-1888(gp) # 7f28 <g_nl_on>
        return NL_ERR;
    446c:	fff00513          	li	a0,-1
    4470:	00008067          	ret
        if (g_nl_n == 0u) return NL_ERR; /* "=" 后面一个数字都没有 */
    4474:	fff00513          	li	a0,-1
    4478:	00008067          	ret

0000447c <lcg>:
static uint32_t lcg(uint32_t *s) { *s = *s * 1664525u + 1013904223u; return (*s >> 16); }
    447c:	00052783          	lw	a5,0(a0)
    4480:	00196737          	lui	a4,0x196
    4484:	60d70713          	addi	a4,a4,1549 # 19660d <__freertos_irq_stack_top+0x152ccd>
    4488:	02e787b3          	mul	a5,a5,a4
    448c:	3c6ef737          	lui	a4,0x3c6ef
    4490:	35f70713          	addi	a4,a4,863 # 3c6ef35f <__freertos_irq_stack_top+0x3c6aba1f>
    4494:	00e787b3          	add	a5,a5,a4
    4498:	00f52023          	sw	a5,0(a0)
    449c:	0107d513          	srli	a0,a5,0x10
    44a0:	00008067          	ret

000044a4 <scene_init>:
{
    44a4:	fd010113          	addi	sp,sp,-48
    44a8:	02112623          	sw	ra,44(sp)
    44ac:	02812423          	sw	s0,40(sp)
    44b0:	02912223          	sw	s1,36(sp)
    44b4:	03212023          	sw	s2,32(sp)
    44b8:	01312e23          	sw	s3,28(sp)
    44bc:	01412c23          	sw	s4,24(sp)
    44c0:	01512a23          	sw	s5,20(sp)
    44c4:	01612823          	sw	s6,16(sp)
    44c8:	00050a93          	mv	s5,a0
    44cc:	00058b13          	mv	s6,a1
    int xr = FB_WIDTH - SCENE_MX(g_blk);
    44d0:	8201a703          	lw	a4,-2016(gp) # 7ea8 <g_blk>
    44d4:	0f000a13          	li	s4,240
    44d8:	40ea0a33          	sub	s4,s4,a4
    44dc:	002a1a13          	slli	s4,s4,0x2
    int yr = HALF_H   - SCENE_MY(g_blk);
    44e0:	00271793          	slli	a5,a4,0x2
    44e4:	00e787b3          	add	a5,a5,a4
    44e8:	01f7d993          	srli	s3,a5,0x1f
    44ec:	00f989b3          	add	s3,s3,a5
    44f0:	4019d993          	srai	s3,s3,0x1
    44f4:	413009b3          	neg	s3,s3
    44f8:	10498993          	addi	s3,s3,260
    for (side = 0; side < NSIDE; side++) {
    44fc:	00000913          	li	s2,0
    4500:	2240006f          	j	4724 <scene_init+0x280>
            b->dx = b->x; b->dy = b->y;                      /* 本侧"已画位置"初始对齐 */
    4504:	000087b7          	lui	a5,0x8
    4508:	00241713          	slli	a4,s0,0x2
    450c:	00870733          	add	a4,a4,s0
    4510:	00271713          	slli	a4,a4,0x2
    4514:	0001d6b7          	lui	a3,0x1d
    4518:	4c068693          	addi	a3,a3,1216 # 1d4c0 <__global_pointer$+0x14e38>
    451c:	02d906b3          	mul	a3,s2,a3
    4520:	00d70733          	add	a4,a4,a3
    4524:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    4528:	00e787b3          	add	a5,a5,a4
    452c:	00079683          	lh	a3,0(a5)
    4530:	00d79423          	sh	a3,8(a5)
    4534:	00279703          	lh	a4,2(a5)
    4538:	00e79523          	sh	a4,10(a5)
            b->tx = b->x; b->ty = b->y;                      /* 本趟快照初始对齐 */
    453c:	00d79623          	sh	a3,12(a5)
    4540:	00e79723          	sh	a4,14(a5)
            b->color = (uint16_t)((((r1 >> 8) & 0x1Fu) << 11) | (((r2 >> 8) & 0x3Fu) << 5)
    4544:	0084d713          	srli	a4,s1,0x8
    4548:	00b71713          	slli	a4,a4,0xb
    454c:	01071713          	slli	a4,a4,0x10
    4550:	01075713          	srli	a4,a4,0x10
    4554:	00855693          	srli	a3,a0,0x8
    4558:	00569693          	slli	a3,a3,0x5
    455c:	7e06f693          	andi	a3,a3,2016
    4560:	00d76733          	or	a4,a4,a3
                                  | ((r1 + r2) & 0x1Fu));
    4564:	00a484b3          	add	s1,s1,a0
    4568:	01f4f493          	andi	s1,s1,31
            b->color = (uint16_t)((((r1 >> 8) & 0x1Fu) << 11) | (((r2 >> 8) & 0x3Fu) << 5)
    456c:	00976733          	or	a4,a4,s1
    4570:	00e79823          	sh	a4,16(a5)
        for (i = 0; i < n; i++) {
    4574:	00140413          	addi	s0,s0,1
    4578:	1b545463          	bge	s0,s5,4720 <scene_init+0x27c>
            uint32_t r1 = lcg(&s), r2 = lcg(&s);
    457c:	00c10513          	addi	a0,sp,12
    4580:	efdff0ef          	jal	447c <lcg>
    4584:	00050493          	mv	s1,a0
    4588:	00c10513          	addi	a0,sp,12
    458c:	ef1ff0ef          	jal	447c <lcg>
            b->sz = (uint8_t)(sz_fixed ? SPR_W : BLK_W);
    4590:	8201a583          	lw	a1,-2016(gp) # 7ea8 <g_blk>
    4594:	0ff5f693          	zext.b	a3,a1
    4598:	000087b7          	lui	a5,0x8
    459c:	00241713          	slli	a4,s0,0x2
    45a0:	00870733          	add	a4,a4,s0
    45a4:	00271713          	slli	a4,a4,0x2
    45a8:	0001d637          	lui	a2,0x1d
    45ac:	4c060613          	addi	a2,a2,1216 # 1d4c0 <__global_pointer$+0x14e38>
    45b0:	02c90633          	mul	a2,s2,a2
    45b4:	00c70733          	add	a4,a4,a2
    45b8:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    45bc:	00e787b3          	add	a5,a5,a4
    45c0:	00d78923          	sb	a3,18(a5)
            b->vx = (int16_t)((int)(r1 % 7u) - 3);
    45c4:	00700613          	li	a2,7
    45c8:	02c4f633          	remu	a2,s1,a2
    45cc:	ffd60613          	addi	a2,a2,-3
    45d0:	00c79223          	sh	a2,4(a5)
            b->vy = (int16_t)((int)(r2 % 5u) - 2);
    45d4:	00500713          	li	a4,5
    45d8:	02e57733          	remu	a4,a0,a4
    45dc:	ffe70713          	addi	a4,a4,-2
    45e0:	00e79323          	sh	a4,6(a5)
            if (!b->vx) b->vx = 1;
    45e4:	02061a63          	bnez	a2,4618 <scene_init+0x174>
    45e8:	00008637          	lui	a2,0x8
    45ec:	00241793          	slli	a5,s0,0x2
    45f0:	008787b3          	add	a5,a5,s0
    45f4:	00279793          	slli	a5,a5,0x2
    45f8:	0001d837          	lui	a6,0x1d
    45fc:	4c080813          	addi	a6,a6,1216 # 1d4c0 <__global_pointer$+0x14e38>
    4600:	03090833          	mul	a6,s2,a6
    4604:	010787b3          	add	a5,a5,a6
    4608:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    460c:	00f607b3          	add	a5,a2,a5
    4610:	00100613          	li	a2,1
    4614:	00c79223          	sh	a2,4(a5)
            if (!b->vy) b->vy = 1;
    4618:	02071a63          	bnez	a4,464c <scene_init+0x1a8>
    461c:	00008737          	lui	a4,0x8
    4620:	00241793          	slli	a5,s0,0x2
    4624:	008787b3          	add	a5,a5,s0
    4628:	00279793          	slli	a5,a5,0x2
    462c:	0001d637          	lui	a2,0x1d
    4630:	4c060613          	addi	a2,a2,1216 # 1d4c0 <__global_pointer$+0x14e38>
    4634:	02c90633          	mul	a2,s2,a2
    4638:	00c787b3          	add	a5,a5,a2
    463c:	fb870713          	addi	a4,a4,-72 # 7fb8 <g_sc>
    4640:	00f707b3          	add	a5,a4,a5
    4644:	00100713          	li	a4,1
    4648:	00e79323          	sh	a4,6(a5)
            b->x  = (int16_t)((int)(r1 % (uint32_t)xr) & ~1);
    464c:	0344f7b3          	remu	a5,s1,s4
    4650:	ffe7f793          	andi	a5,a5,-2
    4654:	01079793          	slli	a5,a5,0x10
    4658:	4107d793          	srai	a5,a5,0x10
    465c:	00008637          	lui	a2,0x8
    4660:	00241713          	slli	a4,s0,0x2
    4664:	00870733          	add	a4,a4,s0
    4668:	00271713          	slli	a4,a4,0x2
    466c:	0001d837          	lui	a6,0x1d
    4670:	4c080813          	addi	a6,a6,1216 # 1d4c0 <__global_pointer$+0x14e38>
    4674:	03090833          	mul	a6,s2,a6
    4678:	01070733          	add	a4,a4,a6
    467c:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    4680:	00e60633          	add	a2,a2,a4
    4684:	00f61023          	sh	a5,0(a2)
            b->y  = (int16_t)(int)(r2 % (uint32_t)yr);
    4688:	03357733          	remu	a4,a0,s3
    468c:	01071713          	slli	a4,a4,0x10
    4690:	41075713          	srai	a4,a4,0x10
    4694:	00e61123          	sh	a4,2(a2)
            if (b->x + b->sz > FB_WIDTH) b->x = (int16_t)(FB_WIDTH - b->sz);
    4698:	0ff5f593          	zext.b	a1,a1
    469c:	00b787b3          	add	a5,a5,a1
    46a0:	3c000613          	li	a2,960
    46a4:	02f65c63          	bge	a2,a5,46dc <scene_init+0x238>
    46a8:	3c000893          	li	a7,960
    46ac:	40d888b3          	sub	a7,a7,a3
    46b0:	00008637          	lui	a2,0x8
    46b4:	00241793          	slli	a5,s0,0x2
    46b8:	008787b3          	add	a5,a5,s0
    46bc:	00279793          	slli	a5,a5,0x2
    46c0:	0001d837          	lui	a6,0x1d
    46c4:	4c080813          	addi	a6,a6,1216 # 1d4c0 <__global_pointer$+0x14e38>
    46c8:	03090833          	mul	a6,s2,a6
    46cc:	010787b3          	add	a5,a5,a6
    46d0:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    46d4:	00f607b3          	add	a5,a2,a5
    46d8:	01179023          	sh	a7,0(a5)
            if (b->y + b->sz > HALF_H)   b->y = (int16_t)(HALF_H   - b->sz);
    46dc:	00b70733          	add	a4,a4,a1
    46e0:	10400793          	li	a5,260
    46e4:	e2e7d0e3          	bge	a5,a4,4504 <scene_init+0x60>
    46e8:	10400613          	li	a2,260
    46ec:	40d60633          	sub	a2,a2,a3
    46f0:	00008737          	lui	a4,0x8
    46f4:	00241793          	slli	a5,s0,0x2
    46f8:	008787b3          	add	a5,a5,s0
    46fc:	00279793          	slli	a5,a5,0x2
    4700:	0001d6b7          	lui	a3,0x1d
    4704:	4c068693          	addi	a3,a3,1216 # 1d4c0 <__global_pointer$+0x14e38>
    4708:	02d906b3          	mul	a3,s2,a3
    470c:	00d787b3          	add	a5,a5,a3
    4710:	fb870713          	addi	a4,a4,-72 # 7fb8 <g_sc>
    4714:	00f707b3          	add	a5,a4,a5
    4718:	00c79123          	sh	a2,2(a5)
    471c:	de9ff06f          	j	4504 <scene_init+0x60>
    for (side = 0; side < NSIDE; side++) {
    4720:	00190913          	addi	s2,s2,1
    4724:	00100793          	li	a5,1
    4728:	0127c863          	blt	a5,s2,4738 <scene_init+0x294>
        uint32_t s = seed;
    472c:	01612623          	sw	s6,12(sp)
        for (i = 0; i < n; i++) {
    4730:	00000413          	li	s0,0
    4734:	e45ff06f          	j	4578 <scene_init+0xd4>
}
    4738:	02c12083          	lw	ra,44(sp)
    473c:	02812403          	lw	s0,40(sp)
    4740:	02412483          	lw	s1,36(sp)
    4744:	02012903          	lw	s2,32(sp)
    4748:	01c12983          	lw	s3,28(sp)
    474c:	01812a03          	lw	s4,24(sp)
    4750:	01412a83          	lw	s5,20(sp)
    4754:	01012b03          	lw	s6,16(sp)
    4758:	03010113          	addi	sp,sp,48
    475c:	00008067          	ret

00004760 <scene_snap>:
    for (i = 0; i < n; i++) { sc[i].tx = sc[i].x; sc[i].ty = sc[i].y; }
    4760:	00000713          	li	a4,0
    4764:	0280006f          	j	478c <scene_snap+0x2c>
    4768:	00271793          	slli	a5,a4,0x2
    476c:	00e787b3          	add	a5,a5,a4
    4770:	00279793          	slli	a5,a5,0x2
    4774:	00f507b3          	add	a5,a0,a5
    4778:	00079683          	lh	a3,0(a5)
    477c:	00d79623          	sh	a3,12(a5)
    4780:	00279683          	lh	a3,2(a5)
    4784:	00d79723          	sh	a3,14(a5)
    4788:	00170713          	addi	a4,a4,1
    478c:	fcb74ee3          	blt	a4,a1,4768 <scene_snap+0x8>
}
    4790:	00008067          	ret

00004794 <scene_step>:
    int xmin = rg->x0, xmax = rg->x0 + rg->w;
    4794:	00062e83          	lw	t4,0(a2)
    4798:	00862f83          	lw	t6,8(a2)
    479c:	01df8fb3          	add	t6,t6,t4
    int ymin = rg->y0, ymax = rg->y0 + rg->h;
    47a0:	00462e03          	lw	t3,4(a2)
    47a4:	00c62f03          	lw	t5,12(a2)
    47a8:	01cf0f33          	add	t5,t5,t3
    for (i = 0; i < n; i++) {
    47ac:	00000893          	li	a7,0
    47b0:	0440006f          	j	47f4 <scene_step+0x60>
        else if (x + w > xmax) { x = xmax - w; b->vx = (int16_t)(-b->vx); }
    47b4:	006682b3          	add	t0,a3,t1
    47b8:	005fdc63          	bge	t6,t0,47d0 <scene_step+0x3c>
    47bc:	406f86b3          	sub	a3,t6,t1
    47c0:	01081813          	slli	a6,a6,0x10
    47c4:	01085813          	srli	a6,a6,0x10
    47c8:	41000833          	neg	a6,a6
    47cc:	01079223          	sh	a6,4(a5)
        if (y < ymin)          { y = ymin;     b->vy = (int16_t)(-b->vy); }
    47d0:	07c75863          	bge	a4,t3,4840 <scene_step+0xac>
    47d4:	01061613          	slli	a2,a2,0x10
    47d8:	01065613          	srli	a2,a2,0x10
    47dc:	40c00633          	neg	a2,a2
    47e0:	00c79323          	sh	a2,6(a5)
    47e4:	000e0713          	mv	a4,t3
        b->x = (int16_t)x;
    47e8:	00d79023          	sh	a3,0(a5)
        b->y = (int16_t)y;
    47ec:	00e79123          	sh	a4,2(a5)
    for (i = 0; i < n; i++) {
    47f0:	00188893          	addi	a7,a7,1
    47f4:	06b8d663          	bge	a7,a1,4860 <scene_step+0xcc>
        blk_t *b = &sc[i];
    47f8:	00289793          	slli	a5,a7,0x2
    47fc:	011787b3          	add	a5,a5,a7
    4800:	00279793          	slli	a5,a5,0x2
    4804:	00f507b3          	add	a5,a0,a5
        int x = b->x + b->vx, y = b->y + b->vy, w = b->sz;
    4808:	00079683          	lh	a3,0(a5)
    480c:	00479803          	lh	a6,4(a5)
    4810:	010686b3          	add	a3,a3,a6
    4814:	00279703          	lh	a4,2(a5)
    4818:	00679603          	lh	a2,6(a5)
    481c:	00c70733          	add	a4,a4,a2
    4820:	0127c303          	lbu	t1,18(a5)
        if (x < xmin)          { x = xmin;     b->vx = (int16_t)(-b->vx); }
    4824:	f9d6d8e3          	bge	a3,t4,47b4 <scene_step+0x20>
    4828:	01081813          	slli	a6,a6,0x10
    482c:	01085813          	srli	a6,a6,0x10
    4830:	41000833          	neg	a6,a6
    4834:	01079223          	sh	a6,4(a5)
    4838:	000e8693          	mv	a3,t4
    483c:	f95ff06f          	j	47d0 <scene_step+0x3c>
        else if (y + w > ymax) { y = ymax - w; b->vy = (int16_t)(-b->vy); }
    4840:	00670833          	add	a6,a4,t1
    4844:	fb0f52e3          	bge	t5,a6,47e8 <scene_step+0x54>
    4848:	406f0733          	sub	a4,t5,t1
    484c:	01061613          	slli	a2,a2,0x10
    4850:	01065613          	srli	a2,a2,0x10
    4854:	40c00633          	neg	a2,a2
    4858:	00c79323          	sh	a2,6(a5)
    485c:	f8dff06f          	j	47e8 <scene_step+0x54>
}
    4860:	00008067          	ret

00004864 <scene_step_both>:
{
    4864:	fe010113          	addi	sp,sp,-32
    4868:	00112e23          	sw	ra,28(sp)
    486c:	00812c23          	sw	s0,24(sp)
    4870:	00912a23          	sw	s1,20(sp)
    4874:	01212823          	sw	s2,16(sp)
    4878:	01312623          	sw	s3,12(sp)
    487c:	00050413          	mv	s0,a0
    4880:	00058493          	mv	s1,a1
    4884:	00060993          	mv	s3,a2
    4888:	00068913          	mv	s2,a3
    scene_step(g_sc[SIDE_HW],  n, rg);
    488c:	00058613          	mv	a2,a1
    4890:	00050593          	mv	a1,a0
    4894:	00008537          	lui	a0,0x8
    4898:	fb850513          	addi	a0,a0,-72 # 7fb8 <g_sc>
    489c:	ef9ff0ef          	jal	4794 <scene_step>
    scene_step(g_sc[SIDE_CPU], n, rg);
    48a0:	00048613          	mv	a2,s1
    48a4:	00040593          	mv	a1,s0
    48a8:	00025537          	lui	a0,0x25
    48ac:	47850513          	addi	a0,a0,1144 # 25478 <__global_pointer$+0x1cdf0>
    48b0:	ee5ff0ef          	jal	4794 <scene_step>
    *snap_hw  = 1;
    48b4:	00100793          	li	a5,1
    48b8:	00f9a023          	sw	a5,0(s3)
    *snap_cpu = 1;
    48bc:	00f92023          	sw	a5,0(s2)
}
    48c0:	01c12083          	lw	ra,28(sp)
    48c4:	01812403          	lw	s0,24(sp)
    48c8:	01412483          	lw	s1,20(sp)
    48cc:	01012903          	lw	s2,16(sp)
    48d0:	00c12983          	lw	s3,12(sp)
    48d4:	02010113          	addi	sp,sp,32
    48d8:	00008067          	ret

000048dc <dl_put>:
    volatile uint32_t *p = (volatile uint32_t *)list + (i * 4);
    48dc:	00459593          	slli	a1,a1,0x4
    48e0:	00b50533          	add	a0,a0,a1
    p[0] = ((uint32_t)(uint16_t)x) | ((uint32_t)(uint16_t)y << 16);
    48e4:	000105b7          	lui	a1,0x10
    48e8:	fff58593          	addi	a1,a1,-1 # ffff <__global_pointer$+0x7977>
    48ec:	00b67633          	and	a2,a2,a1
    48f0:	01069693          	slli	a3,a3,0x10
    48f4:	00c6e6b3          	or	a3,a3,a2
    48f8:	00d52023          	sw	a3,0(a0)
    p[1] = (spr_id & 0xFFFFu) | ((flags & 0xFFFFu) << 16);
    48fc:	00b77733          	and	a4,a4,a1
    4900:	01079793          	slli	a5,a5,0x10
    4904:	00f76733          	or	a4,a4,a5
    4908:	00e52223          	sw	a4,4(a0)
    p[2] = (key & 0xFFFFu) | ((alpha & 0xFFu) << 16);            /* [31:24] PRIO=0 */
    490c:	00b87833          	and	a6,a6,a1
    4910:	01089893          	slli	a7,a7,0x10
    4914:	00ff06b7          	lui	a3,0xff0
    4918:	00d8f8b3          	and	a7,a7,a3
    491c:	01186833          	or	a6,a6,a7
    4920:	01052423          	sw	a6,8(a0)
    p[3] = (mask & 0xFFFFu)                                      /* [15:0] MASK_ID（S3） */
    4924:	00812783          	lw	a5,8(sp)
    4928:	00b7f7b3          	and	a5,a5,a1
         | ((w_ovr & 0xFFu) << 16) | ((h_ovr & 0xFFu) << 24);
    492c:	00012703          	lw	a4,0(sp)
    4930:	01071713          	slli	a4,a4,0x10
    4934:	00d77733          	and	a4,a4,a3
    4938:	00e7e7b3          	or	a5,a5,a4
    493c:	00412703          	lw	a4,4(sp)
    4940:	01871713          	slli	a4,a4,0x18
    4944:	00e7e7b3          	or	a5,a5,a4
    p[3] = (mask & 0xFFFFu)                                      /* [15:0] MASK_ID（S3） */
    4948:	00f52623          	sw	a5,12(a0)
}
    494c:	00008067          	ret

00004950 <dl_geom_put>:
    volatile uint32_t *p = (volatile uint32_t *)g + (id * 4);
    4950:	00459593          	slli	a1,a1,0x4
    4954:	00b50533          	add	a0,a0,a1
    p[0] = atlas;
    4958:	00c52023          	sw	a2,0(a0)
    p[1] = (stride & 0xFFFFu) | ((keydef & 0xFFFFu) << 16);
    495c:	00010637          	lui	a2,0x10
    4960:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x7977>
    4964:	00c6f6b3          	and	a3,a3,a2
    4968:	01071713          	slli	a4,a4,0x10
    496c:	00e6e6b3          	or	a3,a3,a4
    4970:	00d52223          	sw	a3,4(a0)
    p[2] = (w & 0xFFFFu) | ((h & 0xFFFFu) << 16);
    4974:	00c7f7b3          	and	a5,a5,a2
    4978:	01081813          	slli	a6,a6,0x10
    497c:	0107e7b3          	or	a5,a5,a6
    4980:	00f52423          	sw	a5,8(a0)
    p[3] = (sx & 0xFFFFu) | ((sy & 0xFFFFu) << 16);
    4984:	00c8f8b3          	and	a7,a7,a2
    4988:	00012783          	lw	a5,0(sp)
    498c:	01079793          	slli	a5,a5,0x10
    4990:	00f8e8b3          	or	a7,a7,a5
    4994:	01152623          	sw	a7,12(a0)
}
    4998:	00008067          	ret

0000499c <dl_spr_id>:
{
    499c:	ff010113          	addi	sp,sp,-16
    49a0:	00112623          	sw	ra,12(sp)
    49a4:	00812423          	sw	s0,8(sp)
    49a8:	00050413          	mv	s0,a0
    int i = blk_idx(g_blk);
    49ac:	8201a503          	lw	a0,-2016(gp) # 7ea8 <g_blk>
    49b0:	f78fe0ef          	jal	3128 <blk_idx>
    if (scene == SC_ALPHA) return (unsigned)(DL_G_ALPHA_16 + i);
    49b4:	00100793          	li	a5,1
    49b8:	00f40e63          	beq	s0,a5,49d4 <dl_spr_id+0x38>
    if (scene == SC_KEY)   return (unsigned)(DL_G_KEY_16   + i);
    49bc:	00200793          	li	a5,2
    49c0:	00f40e63          	beq	s0,a5,49dc <dl_spr_id+0x40>
}
    49c4:	00c12083          	lw	ra,12(sp)
    49c8:	00812403          	lw	s0,8(sp)
    49cc:	01010113          	addi	sp,sp,16
    49d0:	00008067          	ret
    if (scene == SC_ALPHA) return (unsigned)(DL_G_ALPHA_16 + i);
    49d4:	00350513          	addi	a0,a0,3
    49d8:	fedff06f          	j	49c4 <dl_spr_id+0x28>
    if (scene == SC_KEY)   return (unsigned)(DL_G_KEY_16   + i);
    49dc:	00650513          	addi	a0,a0,6
    49e0:	fe5ff06f          	j	49c4 <dl_spr_id+0x28>

000049e4 <dl_rep_id>:
    return (path == PATH_SPLIT) ? DL_G_REP_SPLIT : DL_G_REP_FULL;
    49e4:	00051663          	bnez	a0,49f0 <dl_rep_id+0xc>
    49e8:	00900513          	li	a0,9
    49ec:	00008067          	ret
    49f0:	00a00513          	li	a0,10
}
    49f4:	00008067          	ret

000049f8 <dl_build>:
{
    49f8:	fa010113          	addi	sp,sp,-96
    49fc:	04112e23          	sw	ra,92(sp)
    4a00:	04812c23          	sw	s0,88(sp)
    4a04:	04912a23          	sw	s1,84(sp)
    4a08:	05212823          	sw	s2,80(sp)
    4a0c:	05312623          	sw	s3,76(sp)
    4a10:	05412423          	sw	s4,72(sp)
    4a14:	05512223          	sw	s5,68(sp)
    4a18:	05612023          	sw	s6,64(sp)
    4a1c:	03712e23          	sw	s7,60(sp)
    4a20:	03812c23          	sw	s8,56(sp)
    4a24:	03912a23          	sw	s9,52(sp)
    4a28:	03a12823          	sw	s10,48(sp)
    4a2c:	03b12623          	sw	s11,44(sp)
    4a30:	00050913          	mv	s2,a0
    4a34:	00058d93          	mv	s11,a1
    4a38:	00060993          	mv	s3,a2
    4a3c:	00068493          	mv	s1,a3
    4a40:	00070c13          	mv	s8,a4
    4a44:	00078a13          	mv	s4,a5
    4a48:	00080b93          	mv	s7,a6
    4a4c:	01112e23          	sw	a7,28(sp)
    int i = *hw_i, c = 0;
    4a50:	0005a403          	lw	s0,0(a1)
                 : ((scene == SC_ALPHA) ? BLT_OP_ALPHA : BLT_OP_KEY);
    4a54:	00068e63          	beqz	a3,4a70 <dl_build+0x78>
    4a58:	00100793          	li	a5,1
    4a5c:	00f68663          	beq	a3,a5,4a68 <dl_build+0x70>
    4a60:	00300b13          	li	s6,3
    4a64:	0100006f          	j	4a74 <dl_build+0x7c>
    4a68:	00200b13          	li	s6,2
    4a6c:	0080006f          	j	4a74 <dl_build+0x7c>
    4a70:	00100b13          	li	s6,1
    unsigned spr = dl_spr_id(scene);
    4a74:	00048513          	mv	a0,s1
    4a78:	f25ff0ef          	jal	499c <dl_spr_id>
    4a7c:	00050a93          	mv	s5,a0
    unsigned key = (scene == SC_KEY) ? (unsigned)KEY_COLOR : 0u;  /* ALPHA 的 w7 逐位对齐 CPU 路径 = 0 */
    4a80:	00200793          	li	a5,2
    4a84:	02f48c63          	beq	s1,a5,4abc <dl_build+0xc4>
    unsigned al  = (scene == SC_ALPHA) ? alpha : 0xFFu;
    4a88:	00100793          	li	a5,1
    4a8c:	04f48c63          	beq	s1,a5,4ae4 <dl_build+0xec>
    4a90:	00000c93          	li	s9,0
    unsigned msk   = ((scene == SC_KEY) && (g_spr_mask != 0u)) ? (unsigned)g_spr_mask : 0u;
    4a94:	00200793          	li	a5,2
    4a98:	02f48863          	beq	s1,a5,4ac8 <dl_build+0xd0>
    4a9c:	00000d13          	li	s10,0
    4aa0:	0ff00c13          	li	s8,255
    unsigned fl    = (op | DL_F_CLIP) | (msk ? (DL_F_MASKEN | DL_F_MASKMODE01) : 0u);
    4aa4:	00000793          	li	a5,0
    4aa8:	00fb6b33          	or	s6,s6,a5
    4aac:	010b6b13          	ori	s6,s6,16
    if (rep_id >= 0)
    4ab0:	040bde63          	bgez	s7,4b0c <dl_build+0x114>
    int i = *hw_i, c = 0;
    4ab4:	00000593          	li	a1,0
    4ab8:	1580006f          	j	4c10 <dl_build+0x218>
    unsigned key = (scene == SC_KEY) ? (unsigned)KEY_COLOR : 0u;  /* ALPHA 的 w7 逐位对齐 CPU 路径 = 0 */
    4abc:	00010cb7          	lui	s9,0x10
    4ac0:	81fc8c93          	addi	s9,s9,-2017 # f81f <__global_pointer$+0x7197>
    4ac4:	fd1ff06f          	j	4a94 <dl_build+0x9c>
    unsigned msk   = ((scene == SC_KEY) && (g_spr_mask != 0u)) ? (unsigned)g_spr_mask : 0u;
    4ac8:	8b81d783          	lhu	a5,-1864(gp) # 7f40 <g_spr_mask>
    4acc:	02078463          	beqz	a5,4af4 <dl_build+0xfc>
    4ad0:	00078d13          	mv	s10,a5
    unsigned fl    = (op | DL_F_CLIP) | (msk ? (DL_F_MASKEN | DL_F_MASKMODE01) : 0u);
    4ad4:	02078863          	beqz	a5,4b04 <dl_build+0x10c>
    4ad8:	0ff00c13          	li	s8,255
    4adc:	18000793          	li	a5,384
    4ae0:	fc9ff06f          	j	4aa8 <dl_build+0xb0>
    4ae4:	00000d13          	li	s10,0
    4ae8:	00000c93          	li	s9,0
    4aec:	00000793          	li	a5,0
    4af0:	fb9ff06f          	j	4aa8 <dl_build+0xb0>
    unsigned msk   = ((scene == SC_KEY) && (g_spr_mask != 0u)) ? (unsigned)g_spr_mask : 0u;
    4af4:	00000d13          	li	s10,0
    4af8:	0ff00c13          	li	s8,255
    unsigned fl    = (op | DL_F_CLIP) | (msk ? (DL_F_MASKEN | DL_F_MASKMODE01) : 0u);
    4afc:	00000793          	li	a5,0
    4b00:	fa9ff06f          	j	4aa8 <dl_build+0xb0>
    4b04:	0ff00c13          	li	s8,255
    4b08:	fa1ff06f          	j	4aa8 <dl_build+0xb0>
        dl_put(list, c++, 0, 0, (unsigned)rep_id, BLT_OP_FILL | DL_F_CLIP,
    4b0c:	00012423          	sw	zero,8(sp)
    4b10:	00012223          	sw	zero,4(sp)
    4b14:	00012023          	sw	zero,0(sp)
    4b18:	0ff00893          	li	a7,255
    4b1c:	00800813          	li	a6,8
    4b20:	01100793          	li	a5,17
    4b24:	000b8713          	mv	a4,s7
    4b28:	00000693          	li	a3,0
    4b2c:	00000613          	li	a2,0
    4b30:	00000593          	li	a1,0
    4b34:	00090513          	mv	a0,s2
    4b38:	da5ff0ef          	jal	48dc <dl_put>
    4b3c:	00100593          	li	a1,1
    4b40:	0d00006f          	j	4c10 <dl_build+0x218>
        if (!clear_pp && ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty)))
    4b44:	000087b7          	lui	a5,0x8
    4b48:	00241713          	slli	a4,s0,0x2
    4b4c:	00870733          	add	a4,a4,s0
    4b50:	00271713          	slli	a4,a4,0x2
    4b54:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    4b58:	00e787b3          	add	a5,a5,a4
    4b5c:	00a79703          	lh	a4,10(a5)
    4b60:	00e79783          	lh	a5,14(a5)
    4b64:	00f70663          	beq	a4,a5,4b70 <dl_build+0x178>
            need = 2;                                    /* 与逐条路径同一条擦除条件 */
    4b68:	00200713          	li	a4,2
    4b6c:	0100006f          	j	4b7c <dl_build+0x184>
        int need = 1;
    4b70:	00100713          	li	a4,1
    4b74:	0080006f          	j	4b7c <dl_build+0x184>
    4b78:	00100713          	li	a4,1
        if (c + need > DL_DESC_MAX) break;               /* 放不下 ⇒ 留到下一段（顺序不变） */
    4b7c:	00e587b3          	add	a5,a1,a4
    4b80:	000016b7          	lui	a3,0x1
    4b84:	16d7da63          	bge	a5,a3,4cf8 <dl_build+0x300>
        if (need == 2)
    4b88:	00200793          	li	a5,2
    4b8c:	0cf70463          	beq	a4,a5,4c54 <dl_build+0x25c>
        if (scene == SC_FILL)
    4b90:	10049c63          	bnez	s1,4ca8 <dl_build+0x2b0>
            dl_put(list, c++, b->tx, b->ty, spr, BLT_OP_FILL | DL_F_CLIP | DL_F_SZOVR,
    4b94:	00158b93          	addi	s7,a1,1
    4b98:	00008637          	lui	a2,0x8
    4b9c:	00241793          	slli	a5,s0,0x2
    4ba0:	008787b3          	add	a5,a5,s0
    4ba4:	00279793          	slli	a5,a5,0x2
    4ba8:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    4bac:	00f60633          	add	a2,a2,a5
                   (unsigned)b->color, 0xFFu, (unsigned)b->sz, (unsigned)b->sz, 0u);
    4bb0:	01264783          	lbu	a5,18(a2)
            dl_put(list, c++, b->tx, b->ty, spr, BLT_OP_FILL | DL_F_CLIP | DL_F_SZOVR,
    4bb4:	00012423          	sw	zero,8(sp)
    4bb8:	00f12223          	sw	a5,4(sp)
    4bbc:	00f12023          	sw	a5,0(sp)
    4bc0:	0ff00893          	li	a7,255
    4bc4:	01065803          	lhu	a6,16(a2)
    4bc8:	03100793          	li	a5,49
    4bcc:	000a8713          	mv	a4,s5
    4bd0:	00e61683          	lh	a3,14(a2)
    4bd4:	00c61603          	lh	a2,12(a2)
    4bd8:	00090513          	mv	a0,s2
    4bdc:	d01ff0ef          	jal	48dc <dl_put>
    4be0:	000b8593          	mv	a1,s7
        b->dx = b->tx; b->dy = b->ty;                    /* 记账：画的就是快照位置 */
    4be4:	000087b7          	lui	a5,0x8
    4be8:	00241713          	slli	a4,s0,0x2
    4bec:	00870733          	add	a4,a4,s0
    4bf0:	00271713          	slli	a4,a4,0x2
    4bf4:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    4bf8:	00e787b3          	add	a5,a5,a4
    4bfc:	00c79703          	lh	a4,12(a5)
    4c00:	00e79423          	sh	a4,8(a5)
    4c04:	00e79703          	lh	a4,14(a5)
    4c08:	00e79523          	sh	a4,10(a5)
        i++;
    4c0c:	00140413          	addi	s0,s0,1
    while (i < n) {
    4c10:	0f345463          	bge	s0,s3,4cf8 <dl_build+0x300>
        if (!clear_pp && ((scene == SC_ALPHA) || (b->dx != b->tx || b->dy != b->ty)))
    4c14:	f60a12e3          	bnez	s4,4b78 <dl_build+0x180>
    4c18:	00100793          	li	a5,1
    4c1c:	02f48863          	beq	s1,a5,4c4c <dl_build+0x254>
    4c20:	000087b7          	lui	a5,0x8
    4c24:	00241713          	slli	a4,s0,0x2
    4c28:	00870733          	add	a4,a4,s0
    4c2c:	00271713          	slli	a4,a4,0x2
    4c30:	fb878793          	addi	a5,a5,-72 # 7fb8 <g_sc>
    4c34:	00e787b3          	add	a5,a5,a4
    4c38:	00879703          	lh	a4,8(a5)
    4c3c:	00c79783          	lh	a5,12(a5)
    4c40:	f0f702e3          	beq	a4,a5,4b44 <dl_build+0x14c>
            need = 2;                                    /* 与逐条路径同一条擦除条件 */
    4c44:	00200713          	li	a4,2
    4c48:	f35ff06f          	j	4b7c <dl_build+0x184>
    4c4c:	00200713          	li	a4,2
    4c50:	f2dff06f          	j	4b7c <dl_build+0x184>
            dl_put(list, c++, b->dx, b->dy, DL_G_FILL_16,
    4c54:	00158b93          	addi	s7,a1,1
    4c58:	00008637          	lui	a2,0x8
    4c5c:	00241793          	slli	a5,s0,0x2
    4c60:	008787b3          	add	a5,a5,s0
    4c64:	00279793          	slli	a5,a5,0x2
    4c68:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    4c6c:	00f60633          	add	a2,a2,a5
                   (unsigned)COL_BG, 0xFFu, (unsigned)b->sz, (unsigned)b->sz, 0u);
    4c70:	01264783          	lbu	a5,18(a2)
            dl_put(list, c++, b->dx, b->dy, DL_G_FILL_16,
    4c74:	00012423          	sw	zero,8(sp)
    4c78:	00f12223          	sw	a5,4(sp)
    4c7c:	00f12023          	sw	a5,0(sp)
    4c80:	0ff00893          	li	a7,255
    4c84:	00800813          	li	a6,8
    4c88:	03100793          	li	a5,49
    4c8c:	00000713          	li	a4,0
    4c90:	00a61683          	lh	a3,10(a2)
    4c94:	00861603          	lh	a2,8(a2)
    4c98:	00090513          	mv	a0,s2
    4c9c:	c41ff0ef          	jal	48dc <dl_put>
    4ca0:	000b8593          	mv	a1,s7
    4ca4:	eedff06f          	j	4b90 <dl_build+0x198>
            dl_put(list, c++, b->tx, b->ty, spr, fl, key, al, 0u, 0u, msk);
    4ca8:	00158b93          	addi	s7,a1,1
    4cac:	00008637          	lui	a2,0x8
    4cb0:	00241793          	slli	a5,s0,0x2
    4cb4:	008787b3          	add	a5,a5,s0
    4cb8:	00279793          	slli	a5,a5,0x2
    4cbc:	fb860613          	addi	a2,a2,-72 # 7fb8 <g_sc>
    4cc0:	00f60633          	add	a2,a2,a5
    4cc4:	01a12423          	sw	s10,8(sp)
    4cc8:	00012223          	sw	zero,4(sp)
    4ccc:	00012023          	sw	zero,0(sp)
    4cd0:	000c0893          	mv	a7,s8
    4cd4:	000c8813          	mv	a6,s9
    4cd8:	000b0793          	mv	a5,s6
    4cdc:	000a8713          	mv	a4,s5
    4ce0:	00e61683          	lh	a3,14(a2)
    4ce4:	00c61603          	lh	a2,12(a2)
    4ce8:	00090513          	mv	a0,s2
    4cec:	bf1ff0ef          	jal	48dc <dl_put>
    4cf0:	000b8593          	mv	a1,s7
    4cf4:	ef1ff06f          	j	4be4 <dl_build+0x1ec>
    *hw_i = i;
    4cf8:	008da023          	sw	s0,0(s11)
    *cnt  = c;
    4cfc:	01c12783          	lw	a5,28(sp)
    4d00:	00b7a023          	sw	a1,0(a5)
    *last = (i >= n) ? 1 : 0;
    4d04:	01342433          	slt	s0,s0,s3
    4d08:	00143413          	seqz	s0,s0
    4d0c:	06012783          	lw	a5,96(sp)
    4d10:	0087a023          	sw	s0,0(a5)
}
    4d14:	05c12083          	lw	ra,92(sp)
    4d18:	05812403          	lw	s0,88(sp)
    4d1c:	05412483          	lw	s1,84(sp)
    4d20:	05012903          	lw	s2,80(sp)
    4d24:	04c12983          	lw	s3,76(sp)
    4d28:	04812a03          	lw	s4,72(sp)
    4d2c:	04412a83          	lw	s5,68(sp)
    4d30:	04012b03          	lw	s6,64(sp)
    4d34:	03c12b83          	lw	s7,60(sp)
    4d38:	03812c03          	lw	s8,56(sp)
    4d3c:	03412c83          	lw	s9,52(sp)
    4d40:	03012d03          	lw	s10,48(sp)
    4d44:	02c12d83          	lw	s11,44(sp)
    4d48:	06010113          	addi	sp,sp,96
    4d4c:	00008067          	ret

00004d50 <dl_wd_decide>:
    int a = (gap <= DL_WD_WINDOW_TICKS);
    4d50:	05f5e7b7          	lui	a5,0x5f5e
    4d54:	10178793          	addi	a5,a5,257 # 5f5e101 <__freertos_irq_stack_top+0x5f1a7c1>
    4d58:	00f5b7b3          	sltu	a5,a1,a5
    *again = a;
    4d5c:	00f62023          	sw	a5,0(a2)
    if (spent) return DL_WD_OFF;
    4d60:	00051c63          	bnez	a0,4d78 <dl_wd_decide+0x28>
    if (a)     return DL_WD_OFF;
    4d64:	05f5e7b7          	lui	a5,0x5f5e
    4d68:	10078793          	addi	a5,a5,256 # 5f5e100 <__freertos_irq_stack_top+0x5f1a7c0>
    4d6c:	00b7f863          	bgeu	a5,a1,4d7c <dl_wd_decide+0x2c>
    return DL_WD_RETRY;
    4d70:	00100513          	li	a0,1
    4d74:	00008067          	ret
    if (spent) return DL_WD_OFF;
    4d78:	00000513          	li	a0,0
}
    4d7c:	00008067          	ret

00004d80 <dl_geom_fill>:
{
    4d80:	fe010113          	addi	sp,sp,-32
    4d84:	00112e23          	sw	ra,28(sp)
    4d88:	00812c23          	sw	s0,24(sp)
    4d8c:	00050413          	mv	s0,a0
    dl_geom_put(g, DL_G_FILL_16,  ATLAS_BASE, 32u,         (unsigned)KEY_COLOR, 16u, 16u, 0u, 0u);
    4d90:	00012023          	sw	zero,0(sp)
    4d94:	00000893          	li	a7,0
    4d98:	01000813          	li	a6,16
    4d9c:	01000793          	li	a5,16
    4da0:	00010737          	lui	a4,0x10
    4da4:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4da8:	02000693          	li	a3,32
    4dac:	00201637          	lui	a2,0x201
    4db0:	00000593          	li	a1,0
    4db4:	b9dff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_FILL_32,  ATLAS_BASE, 64u,         (unsigned)KEY_COLOR, 32u, 32u, 0u, 0u);
    4db8:	00012023          	sw	zero,0(sp)
    4dbc:	00000893          	li	a7,0
    4dc0:	02000813          	li	a6,32
    4dc4:	02000793          	li	a5,32
    4dc8:	00010737          	lui	a4,0x10
    4dcc:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4dd0:	04000693          	li	a3,64
    4dd4:	00201637          	lui	a2,0x201
    4dd8:	00100593          	li	a1,1
    4ddc:	00040513          	mv	a0,s0
    4de0:	b71ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_FILL_64,  ATLAS_BASE, 128u,        (unsigned)KEY_COLOR, 64u, 64u, 0u, 0u);
    4de4:	00012023          	sw	zero,0(sp)
    4de8:	00000893          	li	a7,0
    4dec:	04000813          	li	a6,64
    4df0:	04000793          	li	a5,64
    4df4:	00010737          	lui	a4,0x10
    4df8:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4dfc:	08000693          	li	a3,128
    4e00:	00201637          	lui	a2,0x201
    4e04:	00200593          	li	a1,2
    4e08:	00040513          	mv	a0,s0
    4e0c:	b45ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_ALPHA_16, ATLAS_BASE, 32u,         (unsigned)KEY_COLOR, 16u, 16u, 0u, 0u);
    4e10:	00012023          	sw	zero,0(sp)
    4e14:	00000893          	li	a7,0
    4e18:	01000813          	li	a6,16
    4e1c:	01000793          	li	a5,16
    4e20:	00010737          	lui	a4,0x10
    4e24:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4e28:	02000693          	li	a3,32
    4e2c:	00201637          	lui	a2,0x201
    4e30:	00300593          	li	a1,3
    4e34:	00040513          	mv	a0,s0
    4e38:	b19ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_ALPHA_32, ATLAS_BASE, 64u,         (unsigned)KEY_COLOR, 32u, 32u, 0u, 0u);
    4e3c:	00012023          	sw	zero,0(sp)
    4e40:	00000893          	li	a7,0
    4e44:	02000813          	li	a6,32
    4e48:	02000793          	li	a5,32
    4e4c:	00010737          	lui	a4,0x10
    4e50:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4e54:	04000693          	li	a3,64
    4e58:	00201637          	lui	a2,0x201
    4e5c:	00400593          	li	a1,4
    4e60:	00040513          	mv	a0,s0
    4e64:	aedff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_ALPHA_64, ATLAS_BASE, 128u,        (unsigned)KEY_COLOR, 64u, 64u, 0u, 0u);
    4e68:	00012023          	sw	zero,0(sp)
    4e6c:	00000893          	li	a7,0
    4e70:	04000813          	li	a6,64
    4e74:	04000793          	li	a5,64
    4e78:	00010737          	lui	a4,0x10
    4e7c:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4e80:	08000693          	li	a3,128
    4e84:	00201637          	lui	a2,0x201
    4e88:	00500593          	li	a1,5
    4e8c:	00040513          	mv	a0,s0
    4e90:	ac1ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_KEY_16,   ATLAS_BASE, 32u,         (unsigned)KEY_COLOR, 16u, 16u, 0u, 0u);
    4e94:	00012023          	sw	zero,0(sp)
    4e98:	00000893          	li	a7,0
    4e9c:	01000813          	li	a6,16
    4ea0:	01000793          	li	a5,16
    4ea4:	00010737          	lui	a4,0x10
    4ea8:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4eac:	02000693          	li	a3,32
    4eb0:	00201637          	lui	a2,0x201
    4eb4:	00600593          	li	a1,6
    4eb8:	00040513          	mv	a0,s0
    4ebc:	a95ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_KEY_32,   ATLAS_BASE, 64u,         (unsigned)KEY_COLOR, 32u, 32u, 0u, 0u);
    4ec0:	00012023          	sw	zero,0(sp)
    4ec4:	00000893          	li	a7,0
    4ec8:	02000813          	li	a6,32
    4ecc:	02000793          	li	a5,32
    4ed0:	00010737          	lui	a4,0x10
    4ed4:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4ed8:	04000693          	li	a3,64
    4edc:	00201637          	lui	a2,0x201
    4ee0:	00700593          	li	a1,7
    4ee4:	00040513          	mv	a0,s0
    4ee8:	a69ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_KEY_64,   ATLAS_BASE, 128u,        (unsigned)KEY_COLOR, 64u, 64u, 0u, 0u);
    4eec:	00012023          	sw	zero,0(sp)
    4ef0:	00000893          	li	a7,0
    4ef4:	04000813          	li	a6,64
    4ef8:	04000793          	li	a5,64
    4efc:	00010737          	lui	a4,0x10
    4f00:	81f70713          	addi	a4,a4,-2017 # f81f <__global_pointer$+0x7197>
    4f04:	08000693          	li	a3,128
    4f08:	00201637          	lui	a2,0x201
    4f0c:	00800593          	li	a1,8
    4f10:	00040513          	mv	a0,s0
    4f14:	a3dff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_REP_SPLIT, 0UL, 0u, 0u, (unsigned)FB_WIDTH, (unsigned)HALF_H, 0u, 0u);
    4f18:	00012023          	sw	zero,0(sp)
    4f1c:	00000893          	li	a7,0
    4f20:	10400813          	li	a6,260
    4f24:	3c000793          	li	a5,960
    4f28:	00000713          	li	a4,0
    4f2c:	00000693          	li	a3,0
    4f30:	00000613          	li	a2,0
    4f34:	00900593          	li	a1,9
    4f38:	00040513          	mv	a0,s0
    4f3c:	a15ff0ef          	jal	4950 <dl_geom_put>
    dl_geom_put(g, DL_G_REP_FULL,  0UL, 0u, 0u, (unsigned)FB_WIDTH,
    4f40:	00012023          	sw	zero,0(sp)
    4f44:	00000893          	li	a7,0
    4f48:	20c00813          	li	a6,524
    4f4c:	3c000793          	li	a5,960
    4f50:	00000713          	li	a4,0
    4f54:	00000693          	li	a3,0
    4f58:	00000613          	li	a2,0
    4f5c:	00a00593          	li	a1,10
    4f60:	00040513          	mv	a0,s0
    4f64:	9edff0ef          	jal	4950 <dl_geom_put>
}
    4f68:	01c12083          	lw	ra,28(sp)
    4f6c:	01812403          	lw	s0,24(sp)
    4f70:	02010113          	addi	sp,sp,32
    4f74:	00008067          	ret

00004f78 <dl_geom_build>:
{
    4f78:	ff010113          	addi	sp,sp,-16
    4f7c:	00112623          	sw	ra,12(sp)
    dl_geom_fill((uint32_t *)DL_GEOM_ADDR);
    4f80:	00801537          	lui	a0,0x801
    4f84:	dfdff0ef          	jal	4d80 <dl_geom_fill>
    cache_evict();      /* CPU 写完 DDR、硬件紧接着要读 ⇒ 写穿屏障 */
    4f88:	cc4fe0ef          	jal	344c <cache_evict>
}
    4f8c:	00c12083          	lw	ra,12(sp)
    4f90:	01010113          	addi	sp,sp,16
    4f94:	00008067          	ret

00004f98 <dl_arm_wait_idle>:
{
    4f98:	ff010113          	addi	sp,sp,-16
    4f9c:	00112623          	sw	ra,12(sp)
    4fa0:	00812423          	sw	s0,8(sp)
    uint32_t t0 = tick32();
    4fa4:	9f8fe0ef          	jal	319c <tick32>
    4fa8:	00050413          	mv	s0,a0
    while (blt_rd(BLT_DL_STATUS) & DL_ST_BUSY)
    4fac:	05c00513          	li	a0,92
    4fb0:	a18fe0ef          	jal	31c8 <blt_rd>
    4fb4:	00157513          	andi	a0,a0,1
    4fb8:	02050063          	beqz	a0,4fd8 <dl_arm_wait_idle+0x40>
        if ((uint32_t)(tick32() - t0) > (uint32_t)DL_ARM_IDLE_TICKS) return 0;
    4fbc:	9e0fe0ef          	jal	319c <tick32>
    4fc0:	40850533          	sub	a0,a0,s0
    4fc4:	000f47b7          	lui	a5,0xf4
    4fc8:	24078793          	addi	a5,a5,576 # f4240 <__freertos_irq_stack_top+0xb0900>
    4fcc:	fea7f0e3          	bgeu	a5,a0,4fac <dl_arm_wait_idle+0x14>
    4fd0:	00000513          	li	a0,0
    4fd4:	0080006f          	j	4fdc <dl_arm_wait_idle+0x44>
    return 1;
    4fd8:	00100513          	li	a0,1
}
    4fdc:	00c12083          	lw	ra,12(sp)
    4fe0:	00812403          	lw	s0,8(sp)
    4fe4:	01010113          	addi	sp,sp,16
    4fe8:	00008067          	ret

00004fec <dl_go>:
{
    4fec:	ff010113          	addi	sp,sp,-16
    4ff0:	00112623          	sw	ra,12(sp)
    4ff4:	00812423          	sw	s0,8(sp)
    4ff8:	00912223          	sw	s1,4(sp)
    4ffc:	00050413          	mv	s0,a0
    5000:	00058493          	mv	s1,a1
    blt_wr(BLT_DL_DST_BASE, dst_base);
    5004:	00060593          	mv	a1,a2
    5008:	07000513          	li	a0,112
    500c:	9acfe0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_COUNT,    (uint32_t)cnt);
    5010:	00048593          	mv	a1,s1
    5014:	05400513          	li	a0,84
    5018:	9a0fe0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_CTRL,     (uint32_t)(DL_CTRL_GO | DL_CTRL_AUTO_GO | DL_CTRL_STRICT |
    501c:	02040263          	beqz	s0,5040 <dl_go+0x54>
    5020:	03500593          	li	a1,53
    5024:	05800513          	li	a0,88
    5028:	990fe0ef          	jal	31b8 <blt_wr>
}
    502c:	00c12083          	lw	ra,12(sp)
    5030:	00812403          	lw	s0,8(sp)
    5034:	00412483          	lw	s1,4(sp)
    5038:	01010113          	addi	sp,sp,16
    503c:	00008067          	ret
    blt_wr(BLT_DL_CTRL,     (uint32_t)(DL_CTRL_GO | DL_CTRL_AUTO_GO | DL_CTRL_STRICT |
    5040:	03100593          	li	a1,49
    5044:	fe1ff06f          	j	5024 <dl_go+0x38>

00005048 <dl_err_name>:
    if (e & 0x01u)       return "DESC_RANGE (base/count/tail)";
    5048:	00157793          	andi	a5,a0,1
    504c:	04079863          	bnez	a5,509c <dl_err_name+0x54>
    if (e & 0x02u)       return "GEOM_INDEX (SPR_ID>=GEOM_MAX, or GEOM_MAX=0)";
    5050:	00257793          	andi	a5,a0,2
    5054:	04079a63          	bnez	a5,50a8 <dl_err_name+0x60>
    if (e & 0x04u)       return "GEOM_RANGE (geom addr off/unaligned)";
    5058:	00457793          	andi	a5,a0,4
    505c:	04079c63          	bnez	a5,50b4 <dl_err_name+0x6c>
    if (e & 0x08u)       return "SPRITE_BOUNDS (off-screen w/o CLIP_EN)";
    5060:	00857793          	andi	a5,a0,8
    5064:	04079e63          	bnez	a5,50c0 <dl_err_name+0x78>
    if (e & 0x10u)       return "WATCHDOG (one descriptor stuck > DL_TIMEOUT)";
    5068:	01057793          	andi	a5,a0,16
    506c:	06079063          	bnez	a5,50cc <dl_err_name+0x84>
    if (e & 0x20u)       return "AXI_RRESP (R channel not OKAY)";
    5070:	02057793          	andi	a5,a0,32
    5074:	06079263          	bnez	a5,50d8 <dl_err_name+0x90>
    if (e & 0x40u)       return "DESC_COUNT (>4095)";
    5078:	04057793          	andi	a5,a0,64
    507c:	06079463          	bnez	a5,50e4 <dl_err_name+0x9c>
    if (e & 0x80u)       return "ZERO_SIZE (W or H == 0; geometry/override)";
    5080:	08057793          	andi	a5,a0,128
    5084:	06079663          	bnez	a5,50f0 <dl_err_name+0xa8>
    if (e & 0x01000000u) return "UNSUPPORTED (MIRROR/SRC_OFF/CHAIN/MASK_MODE)";
    5088:	00751793          	slli	a5,a0,0x7
    508c:	0607c863          	bltz	a5,50fc <dl_err_name+0xb4>
    return "?";
    5090:	00006537          	lui	a0,0x6
    5094:	31450513          	addi	a0,a0,788 # 6314 <_data+0x1f0>
    5098:	00008067          	ret
    if (e & 0x01u)       return "DESC_RANGE (base/count/tail)";
    509c:	00006537          	lui	a0,0x6
    50a0:	1b450513          	addi	a0,a0,436 # 61b4 <_data+0x90>
    50a4:	00008067          	ret
    if (e & 0x02u)       return "GEOM_INDEX (SPR_ID>=GEOM_MAX, or GEOM_MAX=0)";
    50a8:	00006537          	lui	a0,0x6
    50ac:	1d450513          	addi	a0,a0,468 # 61d4 <_data+0xb0>
    50b0:	00008067          	ret
    if (e & 0x04u)       return "GEOM_RANGE (geom addr off/unaligned)";
    50b4:	00006537          	lui	a0,0x6
    50b8:	20450513          	addi	a0,a0,516 # 6204 <_data+0xe0>
    50bc:	00008067          	ret
    if (e & 0x08u)       return "SPRITE_BOUNDS (off-screen w/o CLIP_EN)";
    50c0:	00006537          	lui	a0,0x6
    50c4:	22c50513          	addi	a0,a0,556 # 622c <_data+0x108>
    50c8:	00008067          	ret
    if (e & 0x10u)       return "WATCHDOG (one descriptor stuck > DL_TIMEOUT)";
    50cc:	00006537          	lui	a0,0x6
    50d0:	25450513          	addi	a0,a0,596 # 6254 <_data+0x130>
    50d4:	00008067          	ret
    if (e & 0x20u)       return "AXI_RRESP (R channel not OKAY)";
    50d8:	00006537          	lui	a0,0x6
    50dc:	28450513          	addi	a0,a0,644 # 6284 <_data+0x160>
    50e0:	00008067          	ret
    if (e & 0x40u)       return "DESC_COUNT (>4095)";
    50e4:	00006537          	lui	a0,0x6
    50e8:	2a450513          	addi	a0,a0,676 # 62a4 <_data+0x180>
    50ec:	00008067          	ret
    if (e & 0x80u)       return "ZERO_SIZE (W or H == 0; geometry/override)";
    50f0:	00006537          	lui	a0,0x6
    50f4:	2b850513          	addi	a0,a0,696 # 62b8 <_data+0x194>
    50f8:	00008067          	ret
    if (e & 0x01000000u) return "UNSUPPORTED (MIRROR/SRC_OFF/CHAIN/MASK_MODE)";
    50fc:	00006537          	lui	a0,0x6
    5100:	2e450513          	addi	a0,a0,740 # 62e4 <_data+0x1c0>
}
    5104:	00008067          	ret

00005108 <hw_y0>:
static int hw_y0(int path)  { (void)path; return TOP_Y0; }
    5108:	01000513          	li	a0,16
    510c:	00008067          	ret

00005110 <hw_h>:
static int hw_h(int path)   { return (path == PATH_SPLIT) ? HALF_H : (FB_HEIGHT - TOP_Y0); }
    5110:	00051663          	bnez	a0,511c <hw_h+0xc>
    5114:	10400513          	li	a0,260
    5118:	00008067          	ret
    511c:	20c00513          	li	a0,524
    5120:	00008067          	ret

00005124 <cpu_y0>:
static int cpu_y0(int path) { return (path == PATH_SPLIT) ? BOT_Y0 : TOP_Y0; }
    5124:	00051663          	bnez	a0,5130 <cpu_y0+0xc>
    5128:	11800513          	li	a0,280
    512c:	00008067          	ret
    5130:	01000513          	li	a0,16
    5134:	00008067          	ret

00005138 <cpu_h>:
static int cpu_h(int path)  { return (path == PATH_SPLIT) ? HALF_H : (FB_HEIGHT - TOP_Y0); }
    5138:	00051663          	bnez	a0,5144 <cpu_h+0xc>
    513c:	10400513          	li	a0,260
    5140:	00008067          	ret
    5144:	20c00513          	li	a0,524
    5148:	00008067          	ret

0000514c <vrg_h>:
static int vrg_h(int path)  { return (path == PATH_SPLIT) ? HALF_H : (FB_HEIGHT - TOP_Y0); }
    514c:	00051663          	bnez	a0,5158 <vrg_h+0xc>
    5150:	10400513          	li	a0,260
    5154:	00008067          	ret
    5158:	20c00513          	li	a0,524
    515c:	00008067          	ret

00005160 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    5160:	fc010113          	addi	sp,sp,-64
    5164:	00112e23          	sw	ra,28(sp)
    5168:	00812c23          	sw	s0,24(sp)
    516c:	00912a23          	sw	s1,20(sp)
    5170:	00050493          	mv	s1,a0
    5174:	02b12223          	sw	a1,36(sp)
    5178:	02c12423          	sw	a2,40(sp)
    517c:	02d12623          	sw	a3,44(sp)
    5180:	02e12823          	sw	a4,48(sp)
    5184:	02f12a23          	sw	a5,52(sp)
    5188:	03012c23          	sw	a6,56(sp)
    518c:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    5190:	02410793          	addi	a5,sp,36
    5194:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    5198:	00000413          	li	s0,0
    519c:	01c0006f          	j	51b8 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    51a0:	00c12783          	lw	a5,12(sp)
    51a4:	00478713          	addi	a4,a5,4
    51a8:	00e12623          	sw	a4,12(sp)
    51ac:	0007a503          	lw	a0,0(a5)
    51b0:	e0dfd0ef          	jal	2fbc <bsp_printf_c>
        for (i = 0; format[i]; i++)
    51b4:	00140413          	addi	s0,s0,1
    51b8:	008487b3          	add	a5,s1,s0
    51bc:	0007c503          	lbu	a0,0(a5)
    51c0:	0a050e63          	beqz	a0,527c <bsp_printf+0x11c>
            if (format[i] == '%') {
    51c4:	02500793          	li	a5,37
    51c8:	06f50e63          	beq	a0,a5,5244 <bsp_printf+0xe4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    51cc:	df1fd0ef          	jal	2fbc <bsp_printf_c>
    51d0:	fe5ff06f          	j	51b4 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    51d4:	00c12783          	lw	a5,12(sp)
    51d8:	00478713          	addi	a4,a5,4
    51dc:	00e12623          	sw	a4,12(sp)
    51e0:	0007a503          	lw	a0,0(a5)
    51e4:	df5fd0ef          	jal	2fd8 <bsp_printf_s>
                        break;
    51e8:	fcdff06f          	j	51b4 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    51ec:	00c12783          	lw	a5,12(sp)
    51f0:	00478713          	addi	a4,a5,4
    51f4:	00e12623          	sw	a4,12(sp)
    51f8:	0007a503          	lw	a0,0(a5)
    51fc:	df5fd0ef          	jal	2ff0 <bsp_printf_d>
                        break;
    5200:	fb5ff06f          	j	51b4 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    5204:	00c12783          	lw	a5,12(sp)
    5208:	00478713          	addi	a4,a5,4
    520c:	00e12623          	sw	a4,12(sp)
    5210:	0007a503          	lw	a0,0(a5)
    5214:	e9dfd0ef          	jal	30b0 <bsp_printf_X>
                        break;
    5218:	f9dff06f          	j	51b4 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    521c:	00c12783          	lw	a5,12(sp)
    5220:	00478713          	addi	a4,a5,4
    5224:	00e12623          	sw	a4,12(sp)
    5228:	0007a503          	lw	a0,0(a5)
    522c:	e45fd0ef          	jal	3070 <bsp_printf_x>
                        break;
    5230:	f85ff06f          	j	51b4 <bsp_printf+0x54>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
    5234:	00006537          	lui	a0,0x6
    5238:	31850513          	addi	a0,a0,792 # 6318 <_data+0x1f4>
    523c:	d9dfd0ef          	jal	2fd8 <bsp_printf_s>
                        break;
    5240:	f75ff06f          	j	51b4 <bsp_printf+0x54>
                while (format[++i]) {
    5244:	00140413          	addi	s0,s0,1
    5248:	008487b3          	add	a5,s1,s0
    524c:	0007c783          	lbu	a5,0(a5)
    5250:	f60782e3          	beqz	a5,51b4 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    5254:	fa878793          	addi	a5,a5,-88
    5258:	0ff7f693          	zext.b	a3,a5
    525c:	02000713          	li	a4,32
    5260:	fed762e3          	bltu	a4,a3,5244 <bsp_printf+0xe4>
    5264:	00269793          	slli	a5,a3,0x2
    5268:	00008737          	lui	a4,0x8
    526c:	a8470713          	addi	a4,a4,-1404 # 7a84 <_data+0x1960>
    5270:	00e787b3          	add	a5,a5,a4
    5274:	0007a783          	lw	a5,0(a5)
    5278:	00078067          	jr	a5

        va_end(ap);
    }
    527c:	01c12083          	lw	ra,28(sp)
    5280:	01812403          	lw	s0,24(sp)
    5284:	01412483          	lw	s1,20(sp)
    5288:	04010113          	addi	sp,sp,64
    528c:	00008067          	ret

00005290 <spr_mask_report>:
{
    5290:	ff010113          	addi	sp,sp,-16
    5294:	00112623          	sw	ra,12(sp)
    5298:	00812423          	sw	s0,8(sp)
    529c:	00912223          	sw	s1,4(sp)
    bsp_printf("EV atlas %dx%d keymask=%x marked=%d/16 (KEY dw3[15:0]+FLAGS[7]=1; ALPHA/FILL ignore)\r\n",
    52a0:	8201a403          	lw	s0,-2016(gp) # 7ea8 <g_blk>
    52a4:	8b81d483          	lhu	s1,-1864(gp) # 7f40 <g_spr_mask>
    52a8:	00048513          	mv	a0,s1
    52ac:	e04fe0ef          	jal	38b0 <spr_mask_tiles>
    52b0:	00050713          	mv	a4,a0
    52b4:	00048693          	mv	a3,s1
    52b8:	00040613          	mv	a2,s0
    52bc:	00040593          	mv	a1,s0
    52c0:	00006537          	lui	a0,0x6
    52c4:	36450513          	addi	a0,a0,868 # 6364 <_data+0x240>
    52c8:	e99ff0ef          	jal	5160 <bsp_printf>
}
    52cc:	00c12083          	lw	ra,12(sp)
    52d0:	00812403          	lw	s0,8(sp)
    52d4:	00412483          	lw	s1,4(sp)
    52d8:	01010113          	addi	sp,sp,16
    52dc:	00008067          	ret

000052e0 <dl_supported>:
{
    52e0:	ff010113          	addi	sp,sp,-16
    52e4:	00112623          	sw	ra,12(sp)
    uint32_t v = blt_rd(BLT_DL_VERSION);
    52e8:	08000513          	li	a0,128
    52ec:	eddfd0ef          	jal	31c8 <blt_rd>
    if ((v & 0xFFFFu) >= 2u) return 1;
    52f0:	01051793          	slli	a5,a0,0x10
    52f4:	0117d793          	srli	a5,a5,0x11
    52f8:	00078a63          	beqz	a5,530c <dl_supported+0x2c>
    52fc:	00100513          	li	a0,1
}
    5300:	00c12083          	lw	ra,12(sp)
    5304:	01010113          	addi	sp,sp,16
    5308:	00008067          	ret
    bsp_printf("\r\nEV dl not supported (DL_VERSION=%x, need [15:0]>=2)\r\n", (unsigned)v);
    530c:	00050593          	mv	a1,a0
    5310:	00006537          	lui	a0,0x6
    5314:	3bc50513          	addi	a0,a0,956 # 63bc <_data+0x298>
    5318:	e49ff0ef          	jal	5160 <bsp_printf>
    return 0;
    531c:	00000513          	li	a0,0
    5320:	fe1ff06f          	j	5300 <dl_supported+0x20>

00005324 <dl_apply_pending>:
    if (g_dl_want < 0) return 0;                                   /* 没有待生效请求 */
    5324:	8101a783          	lw	a5,-2032(gp) # 7e98 <g_dl_want>
    5328:	0c07c263          	bltz	a5,53ec <dl_apply_pending+0xc8>
    if (g_dl_inflight || g_dl_pend >= 0 || g_dl_fbwait) return 0;   /* 还有表在飞 ⇒ 再等一帧 */
    532c:	8941a503          	lw	a0,-1900(gp) # 7f1c <g_dl_inflight>
    5330:	0c051263          	bnez	a0,53f4 <dl_apply_pending+0xd0>
    5334:	8141a703          	lw	a4,-2028(gp) # 7e9c <g_dl_pend>
    5338:	0c075263          	bgez	a4,53fc <dl_apply_pending+0xd8>
    533c:	8841a703          	lw	a4,-1916(gp) # 7f0c <g_dl_fbwait>
    5340:	0a071e63          	bnez	a4,53fc <dl_apply_pending+0xd8>
{
    5344:	ff010113          	addi	sp,sp,-16
    5348:	00112623          	sw	ra,12(sp)
    g_dl_mode  = g_dl_want;
    534c:	88f1ae23          	sw	a5,-1892(gp) # 7f24 <g_dl_mode>
    g_dl_want  = -1;
    5350:	fff00693          	li	a3,-1
    5354:	80d1a823          	sw	a3,-2032(gp) # 7e98 <g_dl_want>
    g_dl_armed = 0;                       /* 关→开时下次重新走一遍 dl_arm() */
    5358:	8801ac23          	sw	zero,-1896(gp) # 7f20 <g_dl_armed>
    g_dl_retry_n = 0; g_dl_retry_pend = 0;
    535c:	8601a623          	sw	zero,-1940(gp) # 7ef4 <g_dl_retry_n>
    5360:	8601a423          	sw	zero,-1944(gp) # 7ef0 <g_dl_retry_pend>
    g_dl_wd_events = 0; g_dl_wd_last = 0;
    5364:	8401ae23          	sw	zero,-1956(gp) # 7ee4 <g_dl_wd_events>
    5368:	8401ac23          	sw	zero,-1960(gp) # 7ee0 <g_dl_wd_last>
    g_cmd_t0 = 0;
    536c:	8401a223          	sw	zero,-1980(gp) # 7ecc <g_cmd_t0>
    bsp_printf("\r\nEV dl %s\r\n", g_dl_mode ? "on" : "off");
    5370:	04078463          	beqz	a5,53b8 <dl_apply_pending+0x94>
    5374:	000065b7          	lui	a1,0x6
    5378:	3f458593          	addi	a1,a1,1012 # 63f4 <_data+0x2d0>
    537c:	00006537          	lui	a0,0x6
    5380:	3fc50513          	addi	a0,a0,1020 # 63fc <_data+0x2d8>
    5384:	dddff0ef          	jal	5160 <bsp_printf>
    if (g_dl_mode)
    5388:	89c1a783          	lw	a5,-1892(gp) # 7f24 <g_dl_mode>
    538c:	02079c63          	bnez	a5,53c4 <dl_apply_pending+0xa0>
    bsp_printf("     clr fb=%d to=%d err=%d (cumulative; fb=region repaint in-path)\r\n",
    5390:	8bc1a683          	lw	a3,-1860(gp) # 7f44 <g_clr_err>
    5394:	8c01a603          	lw	a2,-1856(gp) # 7f48 <g_clr_to>
    5398:	8c41a583          	lw	a1,-1852(gp) # 7f4c <g_clr_fb>
    539c:	00006537          	lui	a0,0x6
    53a0:	43850513          	addi	a0,a0,1080 # 6438 <_data+0x314>
    53a4:	dbdff0ef          	jal	5160 <bsp_printf>
    return 1;                              /* 本帧真的换了模式 ⇒ 调用方重画信息条 */
    53a8:	00100513          	li	a0,1
}
    53ac:	00c12083          	lw	ra,12(sp)
    53b0:	01010113          	addi	sp,sp,16
    53b4:	00008067          	ret
    bsp_printf("\r\nEV dl %s\r\n", g_dl_mode ? "on" : "off");
    53b8:	000065b7          	lui	a1,0x6
    53bc:	3f858593          	addi	a1,a1,1016 # 63f8 <_data+0x2d4>
    53c0:	fbdff06f          	j	537c <dl_apply_pending+0x58>
                   (unsigned)blt_rd(BLT_DL_VERSION), (unsigned)DL_GEOM_ADDR,
    53c4:	08000513          	li	a0,128
    53c8:	e01fd0ef          	jal	31c8 <blt_rd>
    53cc:	00050593          	mv	a1,a0
        bsp_printf("     DL_VERSION=%x geom=%x lists=%x/%x\r\n",
    53d0:	00841737          	lui	a4,0x841
    53d4:	008216b7          	lui	a3,0x821
    53d8:	00801637          	lui	a2,0x801
    53dc:	00006537          	lui	a0,0x6
    53e0:	40c50513          	addi	a0,a0,1036 # 640c <_data+0x2e8>
    53e4:	d7dff0ef          	jal	5160 <bsp_printf>
    53e8:	fa9ff06f          	j	5390 <dl_apply_pending+0x6c>
    if (g_dl_want < 0) return 0;                                   /* 没有待生效请求 */
    53ec:	00000513          	li	a0,0
    53f0:	00008067          	ret
    if (g_dl_inflight || g_dl_pend >= 0 || g_dl_fbwait) return 0;   /* 还有表在飞 ⇒ 再等一帧 */
    53f4:	00000513          	li	a0,0
    53f8:	00008067          	ret
}
    53fc:	00008067          	ret

00005400 <dl_status_dump>:
{
    5400:	fe010113          	addi	sp,sp,-32
    5404:	00112e23          	sw	ra,28(sp)
    5408:	00058613          	mv	a2,a1
               (int)(st & 1u), (int)((st >> 1) & 1u), (int)((st >> 2) & 1u),
    540c:	0015d713          	srli	a4,a1,0x1
    5410:	0025d793          	srli	a5,a1,0x2
               (int)((st >> 3) & 1u), (int)((st >> 4) & 1u),
    5414:	0035d813          	srli	a6,a1,0x3
    5418:	0045d893          	srli	a7,a1,0x4
               (int)((st >> 8) & 3u), (int)(st >> DL_ST_CONSUMED_SH),
    541c:	0085d693          	srli	a3,a1,0x8
    5420:	0105d593          	srli	a1,a1,0x10
    bsp_printf("EV dl %s: DL_STATUS=%x BUSY=%d DONE=%d ERR=%d ABORTED=%d STALL=%d ACTIVE_BUF=%d CONSUMED=%d stall_seen=%d\r\n",
    5424:	8741a303          	lw	t1,-1932(gp) # 7efc <g_dl_stall_seen>
    5428:	00612423          	sw	t1,8(sp)
    542c:	00b12223          	sw	a1,4(sp)
    5430:	0036f693          	andi	a3,a3,3
    5434:	00d12023          	sw	a3,0(sp)
    5438:	0018f893          	andi	a7,a7,1
    543c:	00187813          	andi	a6,a6,1
    5440:	0017f793          	andi	a5,a5,1
    5444:	00177713          	andi	a4,a4,1
    5448:	00167693          	andi	a3,a2,1
    544c:	00050593          	mv	a1,a0
    5450:	00006537          	lui	a0,0x6
    5454:	48050513          	addi	a0,a0,1152 # 6480 <_data+0x35c>
    5458:	d09ff0ef          	jal	5160 <bsp_printf>
}
    545c:	01c12083          	lw	ra,28(sp)
    5460:	02010113          	addi	sp,sp,32
    5464:	00008067          	ret

00005468 <dl_reg_chk>:
{
    5468:	ff010113          	addi	sp,sp,-16
    546c:	00112623          	sw	ra,12(sp)
    5470:	00812423          	sw	s0,8(sp)
    5474:	00912223          	sw	s1,4(sp)
    5478:	00058413          	mv	s0,a1
    547c:	00060493          	mv	s1,a2
    uint32_t got = blt_rd(off);
    5480:	d49fd0ef          	jal	31c8 <blt_rd>
    if (got != want) {
    5484:	00851e63          	bne	a0,s0,54a0 <dl_reg_chk+0x38>
    return 1;
    5488:	00100513          	li	a0,1
}
    548c:	00c12083          	lw	ra,12(sp)
    5490:	00812403          	lw	s0,8(sp)
    5494:	00412483          	lw	s1,4(sp)
    5498:	01010113          	addi	sp,sp,16
    549c:	00008067          	ret
        bsp_printf("EV dl arm FAIL %s: wrote %x read %x\r\n", name,
    54a0:	00050693          	mv	a3,a0
    54a4:	00040613          	mv	a2,s0
    54a8:	00048593          	mv	a1,s1
    54ac:	00006537          	lui	a0,0x6
    54b0:	4ec50513          	addi	a0,a0,1260 # 64ec <_data+0x3c8>
    54b4:	cadff0ef          	jal	5160 <bsp_printf>
        return 0;
    54b8:	00000513          	li	a0,0
    54bc:	fd1ff06f          	j	548c <dl_reg_chk+0x24>

000054c0 <dl_arm_verify>:
{
    54c0:	f4010113          	addi	sp,sp,-192
    54c4:	0a112e23          	sw	ra,188(sp)
    dl_geom_fill(exp);                       /* 期望值 = 同一个生成函数 */
    54c8:	00010513          	mv	a0,sp
    54cc:	8b5ff0ef          	jal	4d80 <dl_geom_fill>
    for (i = 0; i < DL_GEOM_N * 4; i++) {
    54d0:	00000513          	li	a0,0
    54d4:	02b00793          	li	a5,43
    54d8:	06a7c663          	blt	a5,a0,5544 <dl_arm_verify+0x84>
        if (ge[i] != exp[i]) {
    54dc:	00251793          	slli	a5,a0,0x2
    54e0:	00801737          	lui	a4,0x801
    54e4:	00f70733          	add	a4,a4,a5
    54e8:	00072603          	lw	a2,0(a4) # 801000 <__freertos_irq_stack_top+0x7bd6c0>
    54ec:	0b078793          	addi	a5,a5,176
    54f0:	002787b3          	add	a5,a5,sp
    54f4:	f507a683          	lw	a3,-176(a5)
    54f8:	00d61663          	bne	a2,a3,5504 <dl_arm_verify+0x44>
    for (i = 0; i < DL_GEOM_N * 4; i++) {
    54fc:	00150513          	addi	a0,a0,1
    5500:	fd5ff06f          	j	54d4 <dl_arm_verify+0x14>
            bsp_printf("EV dl arm FAIL geom[%d].dw%d: wrote %x read %x\r\n",
    5504:	00072703          	lw	a4,0(a4)
    5508:	41f55793          	srai	a5,a0,0x1f
    550c:	01e7d813          	srli	a6,a5,0x1e
    5510:	01050633          	add	a2,a0,a6
    5514:	00367613          	andi	a2,a2,3
    5518:	0037f793          	andi	a5,a5,3
    551c:	00a785b3          	add	a1,a5,a0
    5520:	41060633          	sub	a2,a2,a6
    5524:	4025d593          	srai	a1,a1,0x2
    5528:	00006537          	lui	a0,0x6
    552c:	51450513          	addi	a0,a0,1300 # 6514 <_data+0x3f0>
    5530:	c31ff0ef          	jal	5160 <bsp_printf>
            return 0;
    5534:	00000513          	li	a0,0
}
    5538:	0bc12083          	lw	ra,188(sp)
    553c:	0c010113          	addi	sp,sp,192
    5540:	00008067          	ret
    for (i = DL_G_ALPHA_16; i <= DL_G_KEY_64; i++) {
    5544:	00300593          	li	a1,3
    5548:	00800793          	li	a5,8
    554c:	06b7c263          	blt	a5,a1,55b0 <dl_arm_verify+0xf0>
        unsigned w = (unsigned)(ge[i * 4 + 2] & 0xFFFFu);
    5550:	00459513          	slli	a0,a1,0x4
    5554:	00850693          	addi	a3,a0,8
    5558:	00801737          	lui	a4,0x801
    555c:	00d706b3          	add	a3,a4,a3
    5560:	0006a603          	lw	a2,0(a3) # 821000 <__freertos_irq_stack_top+0x7dd6c0>
    5564:	000107b7          	lui	a5,0x10
    5568:	fff78793          	addi	a5,a5,-1 # ffff <__global_pointer$+0x7977>
    556c:	00f67633          	and	a2,a2,a5
        unsigned h = (unsigned)(ge[i * 4 + 2] >> 16);
    5570:	0006a683          	lw	a3,0(a3)
    5574:	0106d693          	srli	a3,a3,0x10
        unsigned st= (unsigned)(ge[i * 4 + 1] & 0xFFFFu);
    5578:	00450513          	addi	a0,a0,4
    557c:	00a70733          	add	a4,a4,a0
    5580:	00072703          	lw	a4,0(a4) # 801000 <__freertos_irq_stack_top+0x7bd6c0>
    5584:	00f77733          	and	a4,a4,a5
        if (!w || !h || !st) {
    5588:	00060a63          	beqz	a2,559c <dl_arm_verify+0xdc>
    558c:	00068863          	beqz	a3,559c <dl_arm_verify+0xdc>
    5590:	00070663          	beqz	a4,559c <dl_arm_verify+0xdc>
    for (i = DL_G_ALPHA_16; i <= DL_G_KEY_64; i++) {
    5594:	00158593          	addi	a1,a1,1
    5598:	fb1ff06f          	j	5548 <dl_arm_verify+0x88>
            bsp_printf("EV dl arm FAIL geom[%d]: W=%d H=%d stride=%d (must be non-zero)\r\n",
    559c:	00006537          	lui	a0,0x6
    55a0:	54850513          	addi	a0,a0,1352 # 6548 <_data+0x424>
    55a4:	bbdff0ef          	jal	5160 <bsp_printf>
            return 0;
    55a8:	00000513          	li	a0,0
    55ac:	f8dff06f          	j	5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_GEOM_BASE,  DL_GEOM_ADDR,   "GEOM_BASE"))  return 0;
    55b0:	00006637          	lui	a2,0x6
    55b4:	58c60613          	addi	a2,a2,1420 # 658c <_data+0x468>
    55b8:	008015b7          	lui	a1,0x801
    55bc:	06800513          	li	a0,104
    55c0:	ea9ff0ef          	jal	5468 <dl_reg_chk>
    55c4:	f6050ae3          	beqz	a0,5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_GEOM_MAX,   (uint32_t)DL_GEOM_N, "GEOM_MAX")) return 0;
    55c8:	00006637          	lui	a2,0x6
    55cc:	59860613          	addi	a2,a2,1432 # 6598 <_data+0x474>
    55d0:	00b00593          	li	a1,11
    55d4:	06c00513          	li	a0,108
    55d8:	e91ff0ef          	jal	5468 <dl_reg_chk>
    55dc:	f4050ee3          	beqz	a0,5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_DST_STRIDE, (uint32_t)FB_STRIDE, "DST_STRIDE")) return 0;
    55e0:	00006637          	lui	a2,0x6
    55e4:	5a460613          	addi	a2,a2,1444 # 65a4 <_data+0x480>
    55e8:	78000593          	li	a1,1920
    55ec:	08400513          	li	a0,132
    55f0:	e79ff0ef          	jal	5468 <dl_reg_chk>
    55f4:	f40502e3          	beqz	a0,5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_FB_WH,
    55f8:	00006637          	lui	a2,0x6
    55fc:	5b060613          	addi	a2,a2,1456 # 65b0 <_data+0x48c>
    5600:	021c05b7          	lui	a1,0x21c0
    5604:	3c058593          	addi	a1,a1,960 # 21c03c0 <__freertos_irq_stack_top+0x217ca80>
    5608:	08800513          	li	a0,136
    560c:	e5dff0ef          	jal	5468 <dl_reg_chk>
    5610:	f20504e3          	beqz	a0,5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_BASE0,      DL_LIST_ADDR(0), "BASE0"))     return 0;
    5614:	00006637          	lui	a2,0x6
    5618:	5b860613          	addi	a2,a2,1464 # 65b8 <_data+0x494>
    561c:	008215b7          	lui	a1,0x821
    5620:	04c00513          	li	a0,76
    5624:	e45ff0ef          	jal	5468 <dl_reg_chk>
    5628:	f00508e3          	beqz	a0,5538 <dl_arm_verify+0x78>
    if (!dl_reg_chk(BLT_DL_BASE1,      DL_LIST_ADDR(1), "BASE1"))     return 0;
    562c:	00006637          	lui	a2,0x6
    5630:	5c060613          	addi	a2,a2,1472 # 65c0 <_data+0x49c>
    5634:	008415b7          	lui	a1,0x841
    5638:	05000513          	li	a0,80
    563c:	e2dff0ef          	jal	5468 <dl_reg_chk>
    5640:	ee050ce3          	beqz	a0,5538 <dl_arm_verify+0x78>
    return 1;
    5644:	00100513          	li	a0,1
    5648:	ef1ff06f          	j	5538 <dl_arm_verify+0x78>

0000564c <dl_arm>:
{
    564c:	ff010113          	addi	sp,sp,-16
    5650:	00112623          	sw	ra,12(sp)
    5654:	00812423          	sw	s0,8(sp)
    if (!dl_arm_wait_idle()) {
    5658:	941ff0ef          	jal	4f98 <dl_arm_wait_idle>
    565c:	1a050263          	beqz	a0,5800 <dl_arm+0x1b4>
    dl_geom_build();
    5660:	919ff0ef          	jal	4f78 <dl_geom_build>
    blt_wr(BLT_DL_GEOM_BASE,  DL_GEOM_ADDR);                     /* [31:4]，16B 对齐 */
    5664:	008015b7          	lui	a1,0x801
    5668:	06800513          	li	a0,104
    566c:	b4dfd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_GEOM_MAX,   (uint32_t)DL_GEOM_N);
    5670:	00b00593          	li	a1,11
    5674:	06c00513          	li	a0,108
    5678:	b41fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_DST_STRIDE, (uint32_t)FB_STRIDE);
    567c:	78000593          	li	a1,1920
    5680:	08400513          	li	a0,132
    5684:	b35fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_FB_WH,      ((uint32_t)FB_HEIGHT << 16) | (uint32_t)FB_WIDTH);
    5688:	021c05b7          	lui	a1,0x21c0
    568c:	3c058593          	addi	a1,a1,960 # 21c03c0 <__freertos_irq_stack_top+0x217ca80>
    5690:	08800513          	li	a0,136
    5694:	b25fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_BASE0,      DL_LIST_ADDR(0));                  /* 写 BASE 会清 DONE */
    5698:	008215b7          	lui	a1,0x821
    569c:	04c00513          	li	a0,76
    56a0:	b19fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_BASE1,      DL_LIST_ADDR(1));
    56a4:	008415b7          	lui	a1,0x841
    56a8:	05000513          	li	a0,80
    56ac:	b0dfd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_ERR,        DL_ERR_CLR_ALL);                   /* W1C：清掉上次的锁存 */
    56b0:	010005b7          	lui	a1,0x1000
    56b4:	0ff58593          	addi	a1,a1,255 # 10000ff <__freertos_irq_stack_top+0xfbc7bf>
    56b8:	06000513          	li	a0,96
    56bc:	afdfd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_CTRL,       DL_CTRL_AUTO_GO | DL_CTRL_STRICT);
    56c0:	03000593          	li	a1,48
    56c4:	05800513          	li	a0,88
    56c8:	af1fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_TIMEOUT,    DL_TIMEOUT_TICKS);
    56cc:	000105b7          	lui	a1,0x10
    56d0:	fff58593          	addi	a1,a1,-1 # ffff <__global_pointer$+0x7977>
    56d4:	07800513          	li	a0,120
    56d8:	ae1fd0ef          	jal	31b8 <blt_wr>
    blt_wr(BLT_DL_CFG,        DL_CFG_WORD(g_dl_chunk, g_dl_wm));
    56dc:	8341a583          	lw	a1,-1996(gp) # 7ebc <g_dl_chunk>
    56e0:	00459593          	slli	a1,a1,0x4
    56e4:	0ff5f593          	zext.b	a1,a1
    56e8:	8301a783          	lw	a5,-2000(gp) # 7eb8 <g_dl_wm>
    56ec:	00879793          	slli	a5,a5,0x8
    56f0:	00001737          	lui	a4,0x1
    56f4:	f0070713          	addi	a4,a4,-256 # f00 <CUSTOM2+0xea5>
    56f8:	00e7f7b3          	and	a5,a5,a4
    56fc:	00f5e5b3          	or	a1,a1,a5
    5700:	0035e593          	ori	a1,a1,3
    5704:	07400513          	li	a0,116
    5708:	ab1fd0ef          	jal	31b8 <blt_wr>
    cache_evict();
    570c:	d41fd0ef          	jal	344c <cache_evict>
    if (!dl_arm_verify()) {
    5710:	db1ff0ef          	jal	54c0 <dl_arm_verify>
    5714:	00050413          	mv	s0,a0
    5718:	10050463          	beqz	a0,5820 <dl_arm+0x1d4>
    571c:	00912223          	sw	s1,4(sp)
        uint32_t tmo = blt_rd(BLT_DL_TIMEOUT) & 0xFFFFu;
    5720:	07800513          	li	a0,120
    5724:	aa5fd0ef          	jal	31c8 <blt_rd>
    5728:	000107b7          	lui	a5,0x10
    572c:	fff78793          	addi	a5,a5,-1 # ffff <__global_pointer$+0x7977>
    5730:	00f57433          	and	s0,a0,a5
        if (tmo != (DL_TIMEOUT_TICKS & 0xFFFFu))
    5734:	0ef41e63          	bne	s0,a5,5830 <dl_arm+0x1e4>
                   (unsigned)blt_rd(BLT_DL_GEOM_BASE), (int)(blt_rd(BLT_DL_GEOM_MAX) & 0xFFFFu));
    5738:	06800513          	li	a0,104
    573c:	a8dfd0ef          	jal	31c8 <blt_rd>
    5740:	00050493          	mv	s1,a0
    5744:	06c00513          	li	a0,108
    5748:	a81fd0ef          	jal	31c8 <blt_rd>
        bsp_printf("EV dl arm ok: timeout=%d/%d ticks (x%d reset %d, ~753us@87MHz) GEOM_BASE=%x GEOM_MAX=%d\r\n",
    574c:	00010637          	lui	a2,0x10
    5750:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x7977>
    5754:	00c57833          	and	a6,a0,a2
    5758:	00048793          	mv	a5,s1
    575c:	00001737          	lui	a4,0x1
    5760:	01000693          	li	a3,16
    5764:	00040593          	mv	a1,s0
    5768:	00006537          	lui	a0,0x6
    576c:	6b050513          	addi	a0,a0,1712 # 66b0 <_data+0x58c>
    5770:	9f1ff0ef          	jal	5160 <bsp_printf>
            uint32_t want = DL_CFG_WORD(g_dl_chunk, g_dl_wm);
    5774:	8341a403          	lw	s0,-1996(gp) # 7ebc <g_dl_chunk>
    5778:	00441413          	slli	s0,s0,0x4
    577c:	0ff47413          	zext.b	s0,s0
    5780:	8301a783          	lw	a5,-2000(gp) # 7eb8 <g_dl_wm>
    5784:	00879793          	slli	a5,a5,0x8
    5788:	00001737          	lui	a4,0x1
    578c:	f0070713          	addi	a4,a4,-256 # f00 <CUSTOM2+0xea5>
    5790:	00e7f7b3          	and	a5,a5,a4
    5794:	00f46433          	or	s0,s0,a5
    5798:	00346413          	ori	s0,s0,3
            uint32_t got  = blt_rd(BLT_DL_CFG);
    579c:	07400513          	li	a0,116
    57a0:	a29fd0ef          	jal	31c8 <blt_rd>
    57a4:	00050493          	mv	s1,a0
            if ((got & 0xFFFu) != (want & 0xFFFu))
    57a8:	00a447b3          	xor	a5,s0,a0
    57ac:	00001737          	lui	a4,0x1
    57b0:	fff70713          	addi	a4,a4,-1 # fff <CUSTOM2+0xfa4>
    57b4:	00e7f7b3          	and	a5,a5,a4
    57b8:	08079a63          	bnez	a5,584c <dl_arm+0x200>
                       (int)((got >> 4) & 0xFu), (int)((got >> 8) & 0xFu),
    57bc:	0044d593          	srli	a1,s1,0x4
    57c0:	0084d613          	srli	a2,s1,0x8
            bsp_printf("EV dl cfg: CHUNK=%d FIFO_WM=%d (wrote %x read %x; keys x/y cycle, re-arm with l)\r\n",
    57c4:	00048713          	mv	a4,s1
    57c8:	00040693          	mv	a3,s0
    57cc:	00f67613          	andi	a2,a2,15
    57d0:	00f5f593          	andi	a1,a1,15
    57d4:	00006537          	lui	a0,0x6
    57d8:	76050513          	addi	a0,a0,1888 # 6760 <_data+0x63c>
    57dc:	985ff0ef          	jal	5160 <bsp_printf>
    g_dl_stall_seen = 0;          /* 从这一刻起重新观察"取指有没有被饿住"（见状态声明处） */
    57e0:	8601aa23          	sw	zero,-1932(gp) # 7efc <g_dl_stall_seen>
    return 1;
    57e4:	00100413          	li	s0,1
    57e8:	00412483          	lw	s1,4(sp)
}
    57ec:	00040513          	mv	a0,s0
    57f0:	00c12083          	lw	ra,12(sp)
    57f4:	00812403          	lw	s0,8(sp)
    57f8:	01010113          	addi	sp,sp,16
    57fc:	00008067          	ret
    5800:	00050413          	mv	s0,a0
                   (unsigned)blt_rd(BLT_DL_STATUS));
    5804:	05c00513          	li	a0,92
    5808:	9c1fd0ef          	jal	31c8 <blt_rd>
    580c:	00050593          	mv	a1,a0
        bsp_printf("EV dl arm FAIL: DFU still BUSY (DL_STATUS=%x); 0x4C~0x88 writes would be ignored\r\n",
    5810:	00006537          	lui	a0,0x6
    5814:	5c850513          	addi	a0,a0,1480 # 65c8 <_data+0x4a4>
    5818:	949ff0ef          	jal	5160 <bsp_printf>
        return 0;
    581c:	fd1ff06f          	j	57ec <dl_arm+0x1a0>
        bsp_printf("EV dl arm FAIL -> list path stays OFF (per-command continues)\r\n");
    5820:	00006537          	lui	a0,0x6
    5824:	61c50513          	addi	a0,a0,1564 # 661c <_data+0x4f8>
    5828:	939ff0ef          	jal	5160 <bsp_printf>
        return 0;
    582c:	fc1ff06f          	j	57ec <dl_arm+0x1a0>
            bsp_printf("EV dl arm WARN TIMEOUT: wrote %x read %x (0x78 missing? watchdog stays %d ticks)\r\n",
    5830:	000016b7          	lui	a3,0x1
    5834:	00040613          	mv	a2,s0
    5838:	00078593          	mv	a1,a5
    583c:	00006537          	lui	a0,0x6
    5840:	65c50513          	addi	a0,a0,1628 # 665c <_data+0x538>
    5844:	91dff0ef          	jal	5160 <bsp_printf>
    5848:	ef1ff06f          	j	5738 <dl_arm+0xec>
                bsp_printf("EV dl arm WARN CFG: wrote %x read %x (0x74 missing? CHUNK/WM stay at reset 8/4)\r\n",
    584c:	00050613          	mv	a2,a0
    5850:	00040593          	mv	a1,s0
    5854:	00006537          	lui	a0,0x6
    5858:	70c50513          	addi	a0,a0,1804 # 670c <_data+0x5e8>
    585c:	905ff0ef          	jal	5160 <bsp_printf>
    5860:	f5dff06f          	j	57bc <dl_arm+0x170>

00005864 <dl_err_report>:
{
    5864:	fe010113          	addi	sp,sp,-32
    5868:	00112e23          	sw	ra,28(sp)
    586c:	00812c23          	sw	s0,24(sp)
    5870:	00912a23          	sw	s1,20(sp)
    5874:	01212823          	sw	s2,16(sp)
    5878:	01312623          	sw	s3,12(sp)
    587c:	01412423          	sw	s4,8(sp)
    uint32_t e  = blt_rd(BLT_DL_ERR);
    5880:	06000513          	li	a0,96
    5884:	945fd0ef          	jal	31c8 <blt_rd>
    5888:	00050413          	mv	s0,a0
    uint32_t fa = blt_rd(BLT_DL_FAULT_ADDR);
    588c:	06400513          	li	a0,100
    5890:	939fd0ef          	jal	31c8 <blt_rd>
    5894:	00050993          	mv	s3,a0
    uint32_t st = blt_rd(BLT_DL_STATUS);
    5898:	05c00513          	li	a0,92
    589c:	92dfd0ef          	jal	31c8 <blt_rd>
    58a0:	00050493          	mv	s1,a0
    bsp_printf("\r\nEV DL_ERR code=%x (%s) idx=%d unsup=%d fault=%x\r\n",
    58a4:	00040513          	mv	a0,s0
    58a8:	fa0ff0ef          	jal	5048 <dl_err_name>
    58ac:	00050613          	mv	a2,a0
               (unsigned)(e & 0xFFu), dl_err_name(e), (int)((e >> 16) & 0xFFu),
    58b0:	01045913          	srli	s2,s0,0x10
    58b4:	0ff97913          	zext.b	s2,s2
               (int)((e >> 24) & 1u), (unsigned)fa);
    58b8:	01845713          	srli	a4,s0,0x18
    bsp_printf("\r\nEV DL_ERR code=%x (%s) idx=%d unsup=%d fault=%x\r\n",
    58bc:	00098793          	mv	a5,s3
    58c0:	00177713          	andi	a4,a4,1
    58c4:	00090693          	mv	a3,s2
    58c8:	0ff47593          	zext.b	a1,s0
    58cc:	00006537          	lui	a0,0x6
    58d0:	7bc50513          	addi	a0,a0,1980 # 67bc <_data+0x698>
    58d4:	88dff0ef          	jal	5160 <bsp_printf>
    dl_status_dump("status", st);                 /* ★v2.14：解码后的 DL_STATUS + CONSUMED */
    58d8:	00048593          	mv	a1,s1
    58dc:	00006537          	lui	a0,0x6
    58e0:	7f050513          	addi	a0,a0,2032 # 67f0 <_data+0x6cc>
    58e4:	b1dff0ef          	jal	5400 <dl_status_dump>
               (int)blt_rd(BLT_DL_PERF), (int)(DL_TIMEOUT_TICKS & 0xFFFFu));
    58e8:	07c00513          	li	a0,124
    58ec:	8ddfd0ef          	jal	31c8 <blt_rd>
    58f0:	00050593          	mv	a1,a0
    bsp_printf("EV dl perf_prev=%d tmo=%d (this list's PERF comes after BUSY=0)\r\n",
    58f4:	00010637          	lui	a2,0x10
    58f8:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x7977>
    58fc:	00006537          	lui	a0,0x6
    5900:	7f850513          	addi	a0,a0,2040 # 67f8 <_data+0x6d4>
    5904:	85dff0ef          	jal	5160 <bsp_printf>
               (unsigned)blt_rd(BLT_CLR_STAT), (int)blt_rd(BLT_CLR_CYC),
    5908:	04000513          	li	a0,64
    590c:	8bdfd0ef          	jal	31c8 <blt_rd>
    5910:	00050993          	mv	s3,a0
    5914:	04800513          	li	a0,72
    5918:	8b1fd0ef          	jal	31c8 <blt_rd>
    591c:	00050a13          	mv	s4,a0
               (int)(blt_rd(BLT_CLR_STAT) & BLT_CLR_STAT_BUSY),
    5920:	04000513          	li	a0,64
    5924:	8a5fd0ef          	jal	31c8 <blt_rd>
    bsp_printf("EV dl clr: CLR_STAT=%x CLR_CYC=%d busy=%d fb=%d to=%d err=%d\r\n",
    5928:	8bc1a803          	lw	a6,-1860(gp) # 7f44 <g_clr_err>
    592c:	8c01a783          	lw	a5,-1856(gp) # 7f48 <g_clr_to>
    5930:	8c41a703          	lw	a4,-1852(gp) # 7f4c <g_clr_fb>
    5934:	00157693          	andi	a3,a0,1
    5938:	000a0613          	mv	a2,s4
    593c:	00098593          	mv	a1,s3
    5940:	00007537          	lui	a0,0x7
    5944:	83c50513          	addi	a0,a0,-1988 # 683c <_data+0x718>
    5948:	819ff0ef          	jal	5160 <bsp_printf>
        if ((e & 0x10u) && idx)
    594c:	01047793          	andi	a5,s0,16
    5950:	06078e63          	beqz	a5,59cc <dl_err_report+0x168>
    5954:	0104d613          	srli	a2,s1,0x10
    5958:	06090263          	beqz	s2,59bc <dl_err_report+0x158>
            bsp_printf("EV dl hint: descriptor fetch starved at idx=%d (CONSUMED=%d %s idx, stall_seen=%d) -> DDR bandwidth, not the geometry table\r\n",
    595c:	05267a63          	bgeu	a2,s2,59b0 <dl_err_report+0x14c>
    5960:	000066b7          	lui	a3,0x6
    5964:	7b468693          	addi	a3,a3,1972 # 67b4 <_data+0x690>
    5968:	8741a703          	lw	a4,-1932(gp) # 7efc <g_dl_stall_seen>
    596c:	00090593          	mv	a1,s2
    5970:	00007537          	lui	a0,0x7
    5974:	87c50513          	addi	a0,a0,-1924 # 687c <_data+0x758>
    5978:	fe8ff0ef          	jal	5160 <bsp_printf>
    blt_wr(BLT_DL_ERR, DL_ERR_CLR_ALL);          /* W1C，否则 ERR 一直挂着（重试前必须清） */
    597c:	010005b7          	lui	a1,0x1000
    5980:	0ff58593          	addi	a1,a1,255 # 10000ff <__freertos_irq_stack_top+0xfbc7bf>
    5984:	06000513          	li	a0,96
    5988:	831fd0ef          	jal	31b8 <blt_wr>
}
    598c:	00040513          	mv	a0,s0
    5990:	01c12083          	lw	ra,28(sp)
    5994:	01812403          	lw	s0,24(sp)
    5998:	01412483          	lw	s1,20(sp)
    599c:	01012903          	lw	s2,16(sp)
    59a0:	00c12983          	lw	s3,12(sp)
    59a4:	00812a03          	lw	s4,8(sp)
    59a8:	02010113          	addi	sp,sp,32
    59ac:	00008067          	ret
            bsp_printf("EV dl hint: descriptor fetch starved at idx=%d (CONSUMED=%d %s idx, stall_seen=%d) -> DDR bandwidth, not the geometry table\r\n",
    59b0:	000066b7          	lui	a3,0x6
    59b4:	7b868693          	addi	a3,a3,1976 # 67b8 <_data+0x694>
    59b8:	fb1ff06f          	j	5968 <dl_err_report+0x104>
            bsp_printf("EV dl hint: WATCHDOG with idx=0 (no descriptor index) -> check DL_COUNT/BASE\r\n");
    59bc:	00007537          	lui	a0,0x7
    59c0:	8fc50513          	addi	a0,a0,-1796 # 68fc <_data+0x7d8>
    59c4:	f9cff0ef          	jal	5160 <bsp_printf>
    59c8:	fb5ff06f          	j	597c <dl_err_report+0x118>
        else if (e & 0x00000002u)
    59cc:	00247793          	andi	a5,s0,2
    59d0:	02079263          	bnez	a5,59f4 <dl_err_report+0x190>
        else if (e & 0x00000080u)
    59d4:	08047793          	andi	a5,s0,128
    59d8:	02079663          	bnez	a5,5a04 <dl_err_report+0x1a0>
        else if (e & 0x00000020u)
    59dc:	02047793          	andi	a5,s0,32
    59e0:	f8078ee3          	beqz	a5,597c <dl_err_report+0x118>
            bsp_printf("EV dl hint: read channel not OKAY (descriptor or geometry fetch, both possible)\r\n");
    59e4:	00007537          	lui	a0,0x7
    59e8:	9f450513          	addi	a0,a0,-1548 # 69f4 <_data+0x8d0>
    59ec:	f74ff0ef          	jal	5160 <bsp_printf>
    59f0:	f8dff06f          	j	597c <dl_err_report+0x118>
            bsp_printf("EV dl hint: ALPHA/KEY descriptors need the geometry table; FILL+SIZE_OVR does not\r\n");
    59f4:	00007537          	lui	a0,0x7
    59f8:	94c50513          	addi	a0,a0,-1716 # 694c <_data+0x828>
    59fc:	f64ff0ef          	jal	5160 <bsp_printf>
    5a00:	f7dff06f          	j	597c <dl_err_report+0x118>
            bsp_printf("EV dl hint: geometry/override W/H read as 0 (ZERO_SIZE) -> geometry table suspect\r\n");
    5a04:	00007537          	lui	a0,0x7
    5a08:	9a050513          	addi	a0,a0,-1632 # 69a0 <_data+0x87c>
    5a0c:	f54ff0ef          	jal	5160 <bsp_printf>
    5a10:	f6dff06f          	j	597c <dl_err_report+0x118>

00005a14 <dl_pixel_probe>:
    if (!g_dl_probe_px) return 1;
    5a14:	8781a783          	lw	a5,-1928(gp) # 7f00 <g_dl_probe_px>
    5a18:	04078a63          	beqz	a5,5a6c <dl_pixel_probe+0x58>
    px = *(volatile uint16_t *)g_dl_probe_px;
    5a1c:	0007d583          	lhu	a1,0(a5)
    5a20:	01059593          	slli	a1,a1,0x10
    5a24:	0105d593          	srli	a1,a1,0x10
    g_dl_probe_px = 0;
    5a28:	8601ac23          	sw	zero,-1928(gp) # 7f00 <g_dl_probe_px>
    if (px == (uint16_t)COL_BG) {
    5a2c:	00800793          	li	a5,8
    5a30:	00f58663          	beq	a1,a5,5a3c <dl_pixel_probe+0x28>
    return 1;
    5a34:	00100513          	li	a0,1
}
    5a38:	00008067          	ret
{
    5a3c:	ff010113          	addi	sp,sp,-16
    5a40:	00112623          	sw	ra,12(sp)
        bsp_printf("EV dl 1st list drew NOTHING at blk0 sprite centre (px=%x = bg)\r\n",
    5a44:	00007537          	lui	a0,0x7
    5a48:	a4850513          	addi	a0,a0,-1464 # 6a48 <_data+0x924>
    5a4c:	f14ff0ef          	jal	5160 <bsp_printf>
        bsp_printf("EV dl hint: table ran but produced no pixels -> geometry/DFU path suspect\r\n");
    5a50:	00007537          	lui	a0,0x7
    5a54:	a8c50513          	addi	a0,a0,-1396 # 6a8c <_data+0x968>
    5a58:	f08ff0ef          	jal	5160 <bsp_printf>
        return 0;
    5a5c:	00000513          	li	a0,0
}
    5a60:	00c12083          	lw	ra,12(sp)
    5a64:	01010113          	addi	sp,sp,16
    5a68:	00008067          	ret
    if (!g_dl_probe_px) return 1;
    5a6c:	00100513          	li	a0,1
    5a70:	00008067          	ret

00005a74 <dl_wd_summary>:
{
    5a74:	ff010113          	addi	sp,sp,-16
    5a78:	00112623          	sw	ra,12(sp)
    5a7c:	00050713          	mv	a4,a0
    bsp_printf("EV dl disabled after %d watchdog events (ok=%d bad=%d): %s; descriptor fetch %s; press l to re-arm\r\n",
    5a80:	85c1a583          	lw	a1,-1956(gp) # 7ee4 <g_dl_wd_events>
    5a84:	8641a603          	lw	a2,-1948(gp) # 7eec <g_dl_retry_ok>
    5a88:	8601a683          	lw	a3,-1952(gp) # 7ee8 <g_dl_retry_bad>
               g_dl_stall_seen ? "starved (stall_seen=1)"
    5a8c:	8741a783          	lw	a5,-1932(gp) # 7efc <g_dl_stall_seen>
    bsp_printf("EV dl disabled after %d watchdog events (ok=%d bad=%d): %s; descriptor fetch %s; press l to re-arm\r\n",
    5a90:	02078263          	beqz	a5,5ab4 <dl_wd_summary+0x40>
    5a94:	000077b7          	lui	a5,0x7
    5a98:	ad878793          	addi	a5,a5,-1320 # 6ad8 <_data+0x9b4>
    5a9c:	00007537          	lui	a0,0x7
    5aa0:	b1050513          	addi	a0,a0,-1264 # 6b10 <_data+0x9ec>
    5aa4:	ebcff0ef          	jal	5160 <bsp_printf>
}
    5aa8:	00c12083          	lw	ra,12(sp)
    5aac:	01010113          	addi	sp,sp,16
    5ab0:	00008067          	ret
    bsp_printf("EV dl disabled after %d watchdog events (ok=%d bad=%d): %s; descriptor fetch %s; press l to re-arm\r\n",
    5ab4:	000077b7          	lui	a5,0x7
    5ab8:	af078793          	addi	a5,a5,-1296 # 6af0 <_data+0x9cc>
    5abc:	fe1ff06f          	j	5a9c <dl_wd_summary+0x28>

00005ac0 <dl_disable>:
{
    5ac0:	fe010113          	addi	sp,sp,-32
    5ac4:	00112e23          	sw	ra,28(sp)
    5ac8:	00812c23          	sw	s0,24(sp)
    5acc:	00912a23          	sw	s1,20(sp)
    5ad0:	01212823          	sw	s2,16(sp)
    5ad4:	01312623          	sw	s3,12(sp)
    5ad8:	00050593          	mv	a1,a0
    bsp_printf("EV list path OFF (%s), fallback to per-command (key l re-arms)\r\n", why);
    5adc:	00007537          	lui	a0,0x7
    5ae0:	b7850513          	addi	a0,a0,-1160 # 6b78 <_data+0xa54>
    5ae4:	e7cff0ef          	jal	5160 <bsp_printf>
               (unsigned)blt_rd(BLT_DL_GEOM_BASE), (int)(blt_rd(BLT_DL_GEOM_MAX) & 0xFFFFu),
    5ae8:	06800513          	li	a0,104
    5aec:	edcfd0ef          	jal	31c8 <blt_rd>
    5af0:	00050413          	mv	s0,a0
    5af4:	06c00513          	li	a0,108
    5af8:	ed0fd0ef          	jal	31c8 <blt_rd>
    5afc:	00050493          	mv	s1,a0
               (int)(blt_rd(BLT_DL_DST_STRIDE) & 0xFFFFu),
    5b00:	08400513          	li	a0,132
    5b04:	ec4fd0ef          	jal	31c8 <blt_rd>
    5b08:	00050913          	mv	s2,a0
               (int)(blt_rd(BLT_DL_FB_WH) & 0xFFFFu), (int)(blt_rd(BLT_DL_FB_WH) >> 16));
    5b0c:	08800513          	li	a0,136
    5b10:	eb8fd0ef          	jal	31c8 <blt_rd>
    5b14:	00050993          	mv	s3,a0
    5b18:	08800513          	li	a0,136
    5b1c:	eacfd0ef          	jal	31c8 <blt_rd>
    bsp_printf("EV dl cfg readback: GEOM_BASE=%x GEOM_MAX=%d DST_STRIDE=%d FB_WH=%dx%d\r\n",
    5b20:	00010637          	lui	a2,0x10
    5b24:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x7977>
    5b28:	01055793          	srli	a5,a0,0x10
    5b2c:	00c9f733          	and	a4,s3,a2
    5b30:	00c976b3          	and	a3,s2,a2
    5b34:	00c4f633          	and	a2,s1,a2
    5b38:	00040593          	mv	a1,s0
    5b3c:	00007537          	lui	a0,0x7
    5b40:	bbc50513          	addi	a0,a0,-1092 # 6bbc <_data+0xa98>
    5b44:	e1cff0ef          	jal	5160 <bsp_printf>
    blt_wr(BLT_DL_ERR, DL_ERR_CLR_ALL);          /* W1C，否则 ERR 一直挂着 */
    5b48:	010005b7          	lui	a1,0x1000
    5b4c:	0ff58593          	addi	a1,a1,255 # 10000ff <__freertos_irq_stack_top+0xfbc7bf>
    5b50:	06000513          	li	a0,96
    5b54:	e64fd0ef          	jal	31b8 <blt_wr>
    g_dl_mode  = 0;
    5b58:	8801ae23          	sw	zero,-1892(gp) # 7f24 <g_dl_mode>
    g_dl_armed = 0;                              /* 下次 'l' 重新走一遍 dl_arm() */
    5b5c:	8801ac23          	sw	zero,-1896(gp) # 7f20 <g_dl_armed>
    g_dl_want  = -1;                             /* 出错即撤销待生效请求：要再试请重新按 'l' */
    5b60:	fff00713          	li	a4,-1
    5b64:	80e1a823          	sw	a4,-2032(gp) # 7e98 <g_dl_want>
    g_dl_probe_px = 0;
    5b68:	8601ac23          	sw	zero,-1928(gp) # 7f00 <g_dl_probe_px>
    g_dl_retry_n = 0; g_dl_retry_pend = 0;
    5b6c:	8601a623          	sw	zero,-1940(gp) # 7ef4 <g_dl_retry_n>
    5b70:	8601a423          	sw	zero,-1944(gp) # 7ef0 <g_dl_retry_pend>
    g_dl_postmortem = 0;
    5b74:	8601a823          	sw	zero,-1936(gp) # 7ef8 <g_dl_postmortem>
}
    5b78:	01c12083          	lw	ra,28(sp)
    5b7c:	01812403          	lw	s0,24(sp)
    5b80:	01412483          	lw	s1,20(sp)
    5b84:	01012903          	lw	s2,16(sp)
    5b88:	00c12983          	lw	s3,12(sp)
    5b8c:	02010113          	addi	sp,sp,32
    5b90:	00008067          	ret

00005b94 <dl_cost_report>:
{
    5b94:	ff010113          	addi	sp,sp,-16
    5b98:	00112623          	sw	ra,12(sp)
    5b9c:	00812423          	sw	s0,8(sp)
    5ba0:	00050413          	mv	s0,a0
    uint32_t now = tick32();
    5ba4:	df8fd0ef          	jal	319c <tick32>
    if ((uint32_t)(now - g_dl_cost_t0) < DL_COST_TICKS) return;   /* 1s 内最多一行 */
    5ba8:	8541a703          	lw	a4,-1964(gp) # 7edc <g_dl_cost_t0>
    5bac:	40e50733          	sub	a4,a0,a4
    5bb0:	05f5e7b7          	lui	a5,0x5f5e
    5bb4:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f1a7bf>
    5bb8:	00e7ea63          	bltu	a5,a4,5bcc <dl_cost_report+0x38>
}
    5bbc:	00c12083          	lw	ra,12(sp)
    5bc0:	00812403          	lw	s0,8(sp)
    5bc4:	01010113          	addi	sp,sp,16
    5bc8:	00008067          	ret
    g_dl_cost_t0 = now;
    5bcc:	84a1aa23          	sw	a0,-1964(gp) # 7edc <g_dl_cost_t0>
    perf = (int)blt_rd(BLT_DL_PERF);
    5bd0:	07c00513          	li	a0,124
    5bd4:	df4fd0ef          	jal	31c8 <blt_rd>
    5bd8:	00050613          	mv	a2,a0
    bsp_printf("EV dl list done: n=%d cycles=%d cyc/sprite=%d\r\n",
    5bdc:	00805e63          	blez	s0,5bf8 <dl_cost_report+0x64>
    5be0:	028546b3          	div	a3,a0,s0
    5be4:	00040593          	mv	a1,s0
    5be8:	00007537          	lui	a0,0x7
    5bec:	c0850513          	addi	a0,a0,-1016 # 6c08 <_data+0xae4>
    5bf0:	d70ff0ef          	jal	5160 <bsp_printf>
    5bf4:	fc9ff06f          	j	5bbc <dl_cost_report+0x28>
    5bf8:	00000693          	li	a3,0
    5bfc:	fe9ff06f          	j	5be4 <dl_cost_report+0x50>

00005c00 <cmd_cost_report>:
    if (!g_cmd_t0) return;                       /* 本趟没计时（例如这一趟是列表路径发的） */
    5c00:	8441a783          	lw	a5,-1980(gp) # 7ecc <g_cmd_t0>
    5c04:	00079463          	bnez	a5,5c0c <cmd_cost_report+0xc>
    5c08:	00008067          	ret
{
    5c0c:	ff010113          	addi	sp,sp,-16
    5c10:	00112623          	sw	ra,12(sp)
    5c14:	00812423          	sw	s0,8(sp)
    5c18:	00050413          	mv	s0,a0
    now = tick32();
    5c1c:	d80fd0ef          	jal	319c <tick32>
    dt  = (uint32_t)(now - g_cmd_t0);
    5c20:	8441a603          	lw	a2,-1980(gp) # 7ecc <g_cmd_t0>
    5c24:	40c50633          	sub	a2,a0,a2
    g_cmd_t0 = 0;
    5c28:	8401a223          	sw	zero,-1980(gp) # 7ecc <g_cmd_t0>
    if ((uint32_t)(now - g_cmd_cost_t0) < DL_COST_TICKS) return;   /* 1s 内最多一行 */
    5c2c:	8501a683          	lw	a3,-1968(gp) # 7ed8 <g_cmd_cost_t0>
    5c30:	40d506b3          	sub	a3,a0,a3
    5c34:	05f5e737          	lui	a4,0x5f5e
    5c38:	0ff70713          	addi	a4,a4,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f1a7bf>
    5c3c:	02d77063          	bgeu	a4,a3,5c5c <cmd_cost_report+0x5c>
    g_cmd_cost_t0 = now;
    5c40:	84a1a823          	sw	a0,-1968(gp) # 7ed8 <g_cmd_cost_t0>
    bsp_printf("EV cmd path done: n=%d cycles=%d cyc/sprite=%d\r\n",
    5c44:	02805463          	blez	s0,5c6c <cmd_cost_report+0x6c>
    5c48:	028646b3          	div	a3,a2,s0
    5c4c:	00040593          	mv	a1,s0
    5c50:	00007537          	lui	a0,0x7
    5c54:	c3850513          	addi	a0,a0,-968 # 6c38 <_data+0xb14>
    5c58:	d08ff0ef          	jal	5160 <bsp_printf>
}
    5c5c:	00c12083          	lw	ra,12(sp)
    5c60:	00812403          	lw	s0,8(sp)
    5c64:	01010113          	addi	sp,sp,16
    5c68:	00008067          	ret
    bsp_printf("EV cmd path done: n=%d cycles=%d cyc/sprite=%d\r\n",
    5c6c:	00000693          	li	a3,0
    5c70:	fddff06f          	j	5c4c <cmd_cost_report+0x4c>

00005c74 <__udivdi3>:
    5c74:	00060813          	mv	a6,a2
    5c78:	00050893          	mv	a7,a0
    5c7c:	00058713          	mv	a4,a1
    5c80:	0e069063          	bnez	a3,5d60 <__udivdi3+0xec>
    5c84:	12c5fe63          	bgeu	a1,a2,5dc0 <__udivdi3+0x14c>
    5c88:	000107b7          	lui	a5,0x10
    5c8c:	1ef66e63          	bltu	a2,a5,5e88 <__udivdi3+0x214>
    5c90:	010007b7          	lui	a5,0x1000
    5c94:	01800693          	li	a3,24
    5c98:	00f67463          	bgeu	a2,a5,5ca0 <__udivdi3+0x2c>
    5c9c:	01000693          	li	a3,16
    5ca0:	00d65333          	srl	t1,a2,a3
    5ca4:	00002797          	auipc	a5,0x2
    5ca8:	0f078793          	addi	a5,a5,240 # 7d94 <__clz_tab>
    5cac:	006787b3          	add	a5,a5,t1
    5cb0:	0007c783          	lbu	a5,0(a5)
    5cb4:	02000313          	li	t1,32
    5cb8:	00d787b3          	add	a5,a5,a3
    5cbc:	40f306b3          	sub	a3,t1,a5
    5cc0:	00f30c63          	beq	t1,a5,5cd8 <__udivdi3+0x64>
    5cc4:	00d59733          	sll	a4,a1,a3
    5cc8:	00f557b3          	srl	a5,a0,a5
    5ccc:	00d61833          	sll	a6,a2,a3
    5cd0:	00e7e733          	or	a4,a5,a4
    5cd4:	00d518b3          	sll	a7,a0,a3
    5cd8:	01085613          	srli	a2,a6,0x10
    5cdc:	02c75533          	divu	a0,a4,a2
    5ce0:	01081693          	slli	a3,a6,0x10
    5ce4:	0106d693          	srli	a3,a3,0x10
    5ce8:	0108d793          	srli	a5,a7,0x10
    5cec:	02c77733          	remu	a4,a4,a2
    5cf0:	02a685b3          	mul	a1,a3,a0
    5cf4:	01071713          	slli	a4,a4,0x10
    5cf8:	00e7e7b3          	or	a5,a5,a4
    5cfc:	00b7fc63          	bgeu	a5,a1,5d14 <__udivdi3+0xa0>
    5d00:	00f807b3          	add	a5,a6,a5
    5d04:	fff50713          	addi	a4,a0,-1
    5d08:	0107e463          	bltu	a5,a6,5d10 <__udivdi3+0x9c>
    5d0c:	40b7e063          	bltu	a5,a1,610c <__udivdi3+0x498>
    5d10:	00070513          	mv	a0,a4
    5d14:	40b787b3          	sub	a5,a5,a1
    5d18:	02c7d733          	divu	a4,a5,a2
    5d1c:	01089893          	slli	a7,a7,0x10
    5d20:	0108d893          	srli	a7,a7,0x10
    5d24:	02c7f7b3          	remu	a5,a5,a2
    5d28:	02e686b3          	mul	a3,a3,a4
    5d2c:	01079793          	slli	a5,a5,0x10
    5d30:	00f8e8b3          	or	a7,a7,a5
    5d34:	00d8fe63          	bgeu	a7,a3,5d50 <__udivdi3+0xdc>
    5d38:	011808b3          	add	a7,a6,a7
    5d3c:	fff70793          	addi	a5,a4,-1
    5d40:	0108e663          	bltu	a7,a6,5d4c <__udivdi3+0xd8>
    5d44:	ffe70713          	addi	a4,a4,-2
    5d48:	00d8e463          	bltu	a7,a3,5d50 <__udivdi3+0xdc>
    5d4c:	00078713          	mv	a4,a5
    5d50:	01051513          	slli	a0,a0,0x10
    5d54:	00e56533          	or	a0,a0,a4
    5d58:	00000593          	li	a1,0
    5d5c:	00008067          	ret
    5d60:	00d5f863          	bgeu	a1,a3,5d70 <__udivdi3+0xfc>
    5d64:	00000593          	li	a1,0
    5d68:	00000513          	li	a0,0
    5d6c:	00008067          	ret
    5d70:	000107b7          	lui	a5,0x10
    5d74:	1ef6e863          	bltu	a3,a5,5f64 <__udivdi3+0x2f0>
    5d78:	01000737          	lui	a4,0x1000
    5d7c:	01800793          	li	a5,24
    5d80:	00e6f463          	bgeu	a3,a4,5d88 <__udivdi3+0x114>
    5d84:	01000793          	li	a5,16
    5d88:	00f6d833          	srl	a6,a3,a5
    5d8c:	00002717          	auipc	a4,0x2
    5d90:	00870713          	addi	a4,a4,8 # 7d94 <__clz_tab>
    5d94:	01070733          	add	a4,a4,a6
    5d98:	00074703          	lbu	a4,0(a4)
    5d9c:	02000893          	li	a7,32
    5da0:	00f70733          	add	a4,a4,a5
    5da4:	40e88833          	sub	a6,a7,a4
    5da8:	1ee89663          	bne	a7,a4,5f94 <__udivdi3+0x320>
    5dac:	32b6e463          	bltu	a3,a1,60d4 <__udivdi3+0x460>
    5db0:	00c53533          	sltu	a0,a0,a2
    5db4:	00153513          	seqz	a0,a0
    5db8:	00000593          	li	a1,0
    5dbc:	00008067          	ret
    5dc0:	0c060c63          	beqz	a2,5e98 <__udivdi3+0x224>
    5dc4:	000107b7          	lui	a5,0x10
    5dc8:	2ef67c63          	bgeu	a2,a5,60c0 <__udivdi3+0x44c>
    5dcc:	10063713          	sltiu	a4,a2,256
    5dd0:	00173713          	seqz	a4,a4
    5dd4:	00371713          	slli	a4,a4,0x3
    5dd8:	00e656b3          	srl	a3,a2,a4
    5ddc:	00002797          	auipc	a5,0x2
    5de0:	fb878793          	addi	a5,a5,-72 # 7d94 <__clz_tab>
    5de4:	00d787b3          	add	a5,a5,a3
    5de8:	0007c783          	lbu	a5,0(a5)
    5dec:	02000693          	li	a3,32
    5df0:	00e787b3          	add	a5,a5,a4
    5df4:	40f68eb3          	sub	t4,a3,a5
    5df8:	0cf69463          	bne	a3,a5,5ec0 <__udivdi3+0x24c>
    5dfc:	40c587b3          	sub	a5,a1,a2
    5e00:	01065693          	srli	a3,a2,0x10
    5e04:	01061613          	slli	a2,a2,0x10
    5e08:	01065613          	srli	a2,a2,0x10
    5e0c:	00100593          	li	a1,1
    5e10:	02d7d533          	divu	a0,a5,a3
    5e14:	0108d713          	srli	a4,a7,0x10
    5e18:	02d7f7b3          	remu	a5,a5,a3
    5e1c:	02c50333          	mul	t1,a0,a2
    5e20:	01079793          	slli	a5,a5,0x10
    5e24:	00f767b3          	or	a5,a4,a5
    5e28:	0067fc63          	bgeu	a5,t1,5e40 <__udivdi3+0x1cc>
    5e2c:	00f807b3          	add	a5,a6,a5
    5e30:	fff50713          	addi	a4,a0,-1
    5e34:	0107e463          	bltu	a5,a6,5e3c <__udivdi3+0x1c8>
    5e38:	2c67e463          	bltu	a5,t1,6100 <__udivdi3+0x48c>
    5e3c:	00070513          	mv	a0,a4
    5e40:	406787b3          	sub	a5,a5,t1
    5e44:	02d7d733          	divu	a4,a5,a3
    5e48:	01089893          	slli	a7,a7,0x10
    5e4c:	0108d893          	srli	a7,a7,0x10
    5e50:	02d7f7b3          	remu	a5,a5,a3
    5e54:	02c70633          	mul	a2,a4,a2
    5e58:	01079793          	slli	a5,a5,0x10
    5e5c:	00f8e8b3          	or	a7,a7,a5
    5e60:	00c8fe63          	bgeu	a7,a2,5e7c <__udivdi3+0x208>
    5e64:	011808b3          	add	a7,a6,a7
    5e68:	fff70793          	addi	a5,a4,-1
    5e6c:	0108e663          	bltu	a7,a6,5e78 <__udivdi3+0x204>
    5e70:	ffe70713          	addi	a4,a4,-2
    5e74:	00c8e463          	bltu	a7,a2,5e7c <__udivdi3+0x208>
    5e78:	00078713          	mv	a4,a5
    5e7c:	01051513          	slli	a0,a0,0x10
    5e80:	00e56533          	or	a0,a0,a4
    5e84:	00008067          	ret
    5e88:	10063693          	sltiu	a3,a2,256
    5e8c:	0016b693          	seqz	a3,a3
    5e90:	00369693          	slli	a3,a3,0x3
    5e94:	e0dff06f          	j	5ca0 <__udivdi3+0x2c>
    5e98:	00000693          	li	a3,0
    5e9c:	00002797          	auipc	a5,0x2
    5ea0:	ef878793          	addi	a5,a5,-264 # 7d94 <__clz_tab>
    5ea4:	00d787b3          	add	a5,a5,a3
    5ea8:	0007c783          	lbu	a5,0(a5)
    5eac:	00000713          	li	a4,0
    5eb0:	02000693          	li	a3,32
    5eb4:	00e787b3          	add	a5,a5,a4
    5eb8:	40f68eb3          	sub	t4,a3,a5
    5ebc:	f4f680e3          	beq	a3,a5,5dfc <__udivdi3+0x188>
    5ec0:	01d61833          	sll	a6,a2,t4
    5ec4:	00f5d333          	srl	t1,a1,a5
    5ec8:	01085693          	srli	a3,a6,0x10
    5ecc:	02d35e33          	divu	t3,t1,a3
    5ed0:	01081613          	slli	a2,a6,0x10
    5ed4:	01d595b3          	sll	a1,a1,t4
    5ed8:	01065613          	srli	a2,a2,0x10
    5edc:	00f557b3          	srl	a5,a0,a5
    5ee0:	00b7e7b3          	or	a5,a5,a1
    5ee4:	0107d713          	srli	a4,a5,0x10
    5ee8:	01d518b3          	sll	a7,a0,t4
    5eec:	02d37333          	remu	t1,t1,a3
    5ef0:	03c605b3          	mul	a1,a2,t3
    5ef4:	01031313          	slli	t1,t1,0x10
    5ef8:	00676733          	or	a4,a4,t1
    5efc:	00b77e63          	bgeu	a4,a1,5f18 <__udivdi3+0x2a4>
    5f00:	00e80733          	add	a4,a6,a4
    5f04:	fffe0513          	addi	a0,t3,-1
    5f08:	1f076463          	bltu	a4,a6,60f0 <__udivdi3+0x47c>
    5f0c:	1eb77263          	bgeu	a4,a1,60f0 <__udivdi3+0x47c>
    5f10:	ffee0e13          	addi	t3,t3,-2
    5f14:	01070733          	add	a4,a4,a6
    5f18:	40b70733          	sub	a4,a4,a1
    5f1c:	02d75533          	divu	a0,a4,a3
    5f20:	01079793          	slli	a5,a5,0x10
    5f24:	0107d793          	srli	a5,a5,0x10
    5f28:	02d77733          	remu	a4,a4,a3
    5f2c:	02a60333          	mul	t1,a2,a0
    5f30:	01071713          	slli	a4,a4,0x10
    5f34:	00e7e7b3          	or	a5,a5,a4
    5f38:	0067fe63          	bgeu	a5,t1,5f54 <__udivdi3+0x2e0>
    5f3c:	00f807b3          	add	a5,a6,a5
    5f40:	fff50713          	addi	a4,a0,-1
    5f44:	1907ee63          	bltu	a5,a6,60e0 <__udivdi3+0x46c>
    5f48:	1867fc63          	bgeu	a5,t1,60e0 <__udivdi3+0x46c>
    5f4c:	ffe50513          	addi	a0,a0,-2
    5f50:	010787b3          	add	a5,a5,a6
    5f54:	010e1593          	slli	a1,t3,0x10
    5f58:	406787b3          	sub	a5,a5,t1
    5f5c:	00a5e5b3          	or	a1,a1,a0
    5f60:	eb1ff06f          	j	5e10 <__udivdi3+0x19c>
    5f64:	1006b793          	sltiu	a5,a3,256
    5f68:	0017b793          	seqz	a5,a5
    5f6c:	00379793          	slli	a5,a5,0x3
    5f70:	00f6d833          	srl	a6,a3,a5
    5f74:	00002717          	auipc	a4,0x2
    5f78:	e2070713          	addi	a4,a4,-480 # 7d94 <__clz_tab>
    5f7c:	01070733          	add	a4,a4,a6
    5f80:	00074703          	lbu	a4,0(a4)
    5f84:	02000893          	li	a7,32
    5f88:	00f70733          	add	a4,a4,a5
    5f8c:	40e88833          	sub	a6,a7,a4
    5f90:	e0e88ee3          	beq	a7,a4,5dac <__udivdi3+0x138>
    5f94:	00e65e33          	srl	t3,a2,a4
    5f98:	010696b3          	sll	a3,a3,a6
    5f9c:	00de6e33          	or	t3,t3,a3
    5fa0:	00e5d8b3          	srl	a7,a1,a4
    5fa4:	010e5e93          	srli	t4,t3,0x10
    5fa8:	03d8d7b3          	divu	a5,a7,t4
    5fac:	010e1313          	slli	t1,t3,0x10
    5fb0:	010595b3          	sll	a1,a1,a6
    5fb4:	01035313          	srli	t1,t1,0x10
    5fb8:	00e55733          	srl	a4,a0,a4
    5fbc:	00b76733          	or	a4,a4,a1
    5fc0:	01075693          	srli	a3,a4,0x10
    5fc4:	01061633          	sll	a2,a2,a6
    5fc8:	03d8f8b3          	remu	a7,a7,t4
    5fcc:	02f305b3          	mul	a1,t1,a5
    5fd0:	01089893          	slli	a7,a7,0x10
    5fd4:	0116e6b3          	or	a3,a3,a7
    5fd8:	00b6fe63          	bgeu	a3,a1,5ff4 <__udivdi3+0x380>
    5fdc:	00de06b3          	add	a3,t3,a3
    5fe0:	fff78893          	addi	a7,a5,-1
    5fe4:	11c6ea63          	bltu	a3,t3,60f8 <__udivdi3+0x484>
    5fe8:	10b6f863          	bgeu	a3,a1,60f8 <__udivdi3+0x484>
    5fec:	ffe78793          	addi	a5,a5,-2
    5ff0:	01c686b3          	add	a3,a3,t3
    5ff4:	40b686b3          	sub	a3,a3,a1
    5ff8:	03d6d5b3          	divu	a1,a3,t4
    5ffc:	01071713          	slli	a4,a4,0x10
    6000:	01075713          	srli	a4,a4,0x10
    6004:	03d6f6b3          	remu	a3,a3,t4
    6008:	02b308b3          	mul	a7,t1,a1
    600c:	01069693          	slli	a3,a3,0x10
    6010:	00d76733          	or	a4,a4,a3
    6014:	01177e63          	bgeu	a4,a7,6030 <__udivdi3+0x3bc>
    6018:	00ee0733          	add	a4,t3,a4
    601c:	fff58693          	addi	a3,a1,-1
    6020:	0dc76463          	bltu	a4,t3,60e8 <__udivdi3+0x474>
    6024:	0d177263          	bgeu	a4,a7,60e8 <__udivdi3+0x474>
    6028:	ffe58593          	addi	a1,a1,-2
    602c:	01c70733          	add	a4,a4,t3
    6030:	01079793          	slli	a5,a5,0x10
    6034:	00010eb7          	lui	t4,0x10
    6038:	00b7e7b3          	or	a5,a5,a1
    603c:	fffe8693          	addi	a3,t4,-1 # ffff <__global_pointer$+0x7977>
    6040:	00d7f5b3          	and	a1,a5,a3
    6044:	0107d313          	srli	t1,a5,0x10
    6048:	00d676b3          	and	a3,a2,a3
    604c:	01065613          	srli	a2,a2,0x10
    6050:	02d58e33          	mul	t3,a1,a3
    6054:	41170733          	sub	a4,a4,a7
    6058:	02d306b3          	mul	a3,t1,a3
    605c:	010e5893          	srli	a7,t3,0x10
    6060:	02c585b3          	mul	a1,a1,a2
    6064:	00d585b3          	add	a1,a1,a3
    6068:	00b885b3          	add	a1,a7,a1
    606c:	02c30333          	mul	t1,t1,a2
    6070:	00d5f463          	bgeu	a1,a3,6078 <__udivdi3+0x404>
    6074:	01d30333          	add	t1,t1,t4
    6078:	0105d693          	srli	a3,a1,0x10
    607c:	006686b3          	add	a3,a3,t1
    6080:	02d76a63          	bltu	a4,a3,60b4 <__udivdi3+0x440>
    6084:	00d70863          	beq	a4,a3,6094 <__udivdi3+0x420>
    6088:	00078513          	mv	a0,a5
    608c:	00000593          	li	a1,0
    6090:	00008067          	ret
    6094:	000106b7          	lui	a3,0x10
    6098:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x7977>
    609c:	00d5f733          	and	a4,a1,a3
    60a0:	01071713          	slli	a4,a4,0x10
    60a4:	00de7e33          	and	t3,t3,a3
    60a8:	01051533          	sll	a0,a0,a6
    60ac:	01c70733          	add	a4,a4,t3
    60b0:	fce57ce3          	bgeu	a0,a4,6088 <__udivdi3+0x414>
    60b4:	fff78513          	addi	a0,a5,-1
    60b8:	00000593          	li	a1,0
    60bc:	00008067          	ret
    60c0:	010007b7          	lui	a5,0x1000
    60c4:	04f67a63          	bgeu	a2,a5,6118 <__udivdi3+0x4a4>
    60c8:	01065693          	srli	a3,a2,0x10
    60cc:	01000713          	li	a4,16
    60d0:	d0dff06f          	j	5ddc <__udivdi3+0x168>
    60d4:	00000593          	li	a1,0
    60d8:	00100513          	li	a0,1
    60dc:	00008067          	ret
    60e0:	00070513          	mv	a0,a4
    60e4:	e71ff06f          	j	5f54 <__udivdi3+0x2e0>
    60e8:	00068593          	mv	a1,a3
    60ec:	f45ff06f          	j	6030 <__udivdi3+0x3bc>
    60f0:	00050e13          	mv	t3,a0
    60f4:	e25ff06f          	j	5f18 <__udivdi3+0x2a4>
    60f8:	00088793          	mv	a5,a7
    60fc:	ef9ff06f          	j	5ff4 <__udivdi3+0x380>
    6100:	ffe50513          	addi	a0,a0,-2
    6104:	010787b3          	add	a5,a5,a6
    6108:	d39ff06f          	j	5e40 <__udivdi3+0x1cc>
    610c:	ffe50513          	addi	a0,a0,-2
    6110:	010787b3          	add	a5,a5,a6
    6114:	c01ff06f          	j	5d14 <__udivdi3+0xa0>
    6118:	01865693          	srli	a3,a2,0x18
    611c:	01800713          	li	a4,24
    6120:	cbdff06f          	j	5ddc <__udivdi3+0x168>
