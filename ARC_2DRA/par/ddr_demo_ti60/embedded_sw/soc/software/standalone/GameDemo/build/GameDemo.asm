
build/GameDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00008197          	auipc	gp,0x8
    1004:	47818193          	addi	gp,gp,1144 # 9478 <__global_pointer$>

00001008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
    1008:	0001a117          	auipc	sp,0x1a
    100c:	b0810113          	addi	sp,sp,-1272 # 1ab10 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1010:	00006517          	auipc	a0,0x6
    1014:	23c50513          	addi	a0,a0,572 # 724c <_data>
	la a1, _data
    1018:	00006597          	auipc	a1,0x6
    101c:	23458593          	addi	a1,a1,564 # 724c <_data>
	la a2, _edata
    1020:	00008617          	auipc	a2,0x8
    1024:	cac60613          	addi	a2,a2,-852 # 8ccc <g_bul_live>
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
    1040:	00008517          	auipc	a0,0x8
    1044:	c8c50513          	addi	a0,a0,-884 # 8ccc <g_bul_live>
	la a1, _end
    1048:	00019597          	auipc	a1,0x19
    104c:	ac058593          	addi	a1,a1,-1344 # 19b08 <_end>
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
    107c:	00006797          	auipc	a5,0x6
    1080:	1d078793          	addi	a5,a5,464 # 724c <_data>
    1084:	00006417          	auipc	s0,0x6
    1088:	1c840413          	addi	s0,s0,456 # 724c <_data>
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
    10b8:	00006797          	auipc	a5,0x6
    10bc:	19478793          	addi	a5,a5,404 # 724c <_data>
    10c0:	00006417          	auipc	s0,0x6
    10c4:	18c40413          	addi	s0,s0,396 # 724c <_data>
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
    g_dl_i = 0;
    g_clr_fb++;
}

int main(int argc, char **argv)
{
    1104:	fb010113          	addi	sp,sp,-80
    1108:	04112623          	sw	ra,76(sp)
    110c:	04812423          	sw	s0,72(sp)
    1110:	04912223          	sw	s1,68(sp)
    1114:	05212023          	sw	s2,64(sp)
    1118:	03312e23          	sw	s3,60(sp)
    111c:	03412c23          	sw	s4,56(sp)
    1120:	03512a23          	sw	s5,52(sp)
    1124:	03612823          	sw	s6,48(sp)
    1128:	03712623          	sw	s7,44(sp)
    112c:	03812423          	sw	s8,40(sp)
    1130:	03912223          	sw	s9,36(sp)
    uint32_t back_t0 = 0;
    int      repaint = 1;

    (void)argc; (void)argv;

    bsp_init();                       /* ★ 必须最先调用：UART 时钟分频在这里配置 */
    1134:	1fd000ef          	jal	1b30 <bsp_init>

    bsp_printf("\r\n===== GameDemo: high-load interactive danmaku, serial-controlled =====\r\n");
    1138:	00008537          	lui	a0,0x8
    113c:	db850513          	addi	a0,a0,-584 # 7db8 <_data+0xb6c>
    1140:	2dc040ef          	jal	541c <bsp_printf>
    bsp_printf("FB=%x BACK=%x BUF2=%x ATLAS=%x bytes=%d\r\n",
    1144:	000027b7          	lui	a5,0x2
    1148:	c0078793          	addi	a5,a5,-1024 # 1c00 <spi_read+0x3c>
    114c:	00201737          	lui	a4,0x201
    1150:	007016b7          	lui	a3,0x701
    1154:	00501637          	lui	a2,0x501
    1158:	003015b7          	lui	a1,0x301
    115c:	00008537          	lui	a0,0x8
    1160:	e0450513          	addi	a0,a0,-508 # 7e04 <_data+0xbb8>
    1164:	2b8040ef          	jal	541c <bsp_printf>
               (unsigned)FB_BASE, (unsigned)FB_BACK, (unsigned)FB_BUF2,
               (unsigned)ATLAS_BASE, (int)ATLAS_BYTES);
    bsp_printf("playfield: x 0..%d  y %d..%d (info bar y<16 is CPU text)\r\n",
    1168:	21c00693          	li	a3,540
    116c:	01000613          	li	a2,16
    1170:	3c000593          	li	a1,960
    1174:	00008537          	lui	a0,0x8
    1178:	e3050513          	addi	a0,a0,-464 # 7e30 <_data+0xbe4>
    117c:	2a0040ef          	jal	541c <bsp_printf>
               FB_WIDTH, PLAY_Y0, PLAY_Y1);
    bsp_printf("publish: FLIP x3 (no full-screen COPY) + concurrent clear engine\r\n");
    1180:	00008537          	lui	a0,0x8
    1184:	e6c50513          	addi	a0,a0,-404 # 7e6c <_data+0xc20>
    1188:	294040ef          	jal	541c <bsp_printf>
    bsp_printf("default: N=%d path=HW stars=%d sprites 16x16 glow + 32x32 keyed\r\n",
    118c:	8241a603          	lw	a2,-2012(gp) # 8c9c <g_star_n>
    1190:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    1194:	00008537          	lui	a0,0x8
    1198:	eb050513          	addi	a0,a0,-336 # 7eb0 <_data+0xc64>
    119c:	280040ef          	jal	541c <bsp_printf>
               g_ncap, g_star_n);
    bsp_printf("input: PC keyboard over UART 115200 -> '@'+2 hex digits+'\\n'\r\n");
    11a0:	00008537          	lui	a0,0x8
    11a4:	ef450513          	addi	a0,a0,-268 # 7ef4 <_data+0xca8>
    11a8:	274040ef          	jal	541c <bsp_printf>
    bsp_printf("       bit0 up 1 down 2 left 3 right 4 fire 5 focus 6 bomb 7 pause\r\n");
    11ac:	00008537          	lui	a0,0x8
    11b0:	f3450513          	addi	a0,a0,-204 # 7f34 <_data+0xce8>
    11b4:	268040ef          	jal	541c <bsp_printf>
    bsp_printf("cmd: 1/2/3/4 presets, n/+/-/=N, c=CPU h=HW, g=auto-ramp, b, p, r, d, ?\r\n");
    11b8:	00008537          	lui	a0,0x8
    11bc:	f7c50513          	addi	a0,a0,-132 # 7f7c <_data+0xd30>
    11c0:	25c040ef          	jal	541c <bsp_printf>
    bsp_printf("     f=cycle enemy-bullet op FILL/ALPHA/ADD/KEY (also 5/6/7/8)\r\n");
    11c4:	00008537          	lui	a0,0x8
    11c8:	fc850513          	addi	a0,a0,-56 # 7fc8 <_data+0xd7c>
    11cc:	250040ef          	jal	541c <bsp_printf>

    /* ---- 图集：开机由 CPU 生成（引擎与 CPU 参考实现都从这里取数） ---- */
    {
        int id, i, j;
        for (id = 0; id < S_N; id++) {
    11d0:	00000a13          	li	s4,0
    11d4:	0440006f          	j	1218 <main+0x114>
            volatile uint16_t *p = (volatile uint16_t *)(ATLAS_BASE + g_spr_off[id]);
            int w = (int)g_spr_sz[id];
            for (j = 0; j < w; j++)
                for (i = 0; i < w; i++)
                    p[j * w + i] = spr_pixel(id, i, j);
    11d8:	03390433          	mul	s0,s2,s3
    11dc:	00940433          	add	s0,s0,s1
    11e0:	00141413          	slli	s0,s0,0x1
    11e4:	008a8433          	add	s0,s5,s0
    11e8:	00090613          	mv	a2,s2
    11ec:	00048593          	mv	a1,s1
    11f0:	000a0513          	mv	a0,s4
    11f4:	178010ef          	jal	236c <spr_pixel>
    11f8:	00a41023          	sh	a0,0(s0)
                for (i = 0; i < w; i++)
    11fc:	00148493          	addi	s1,s1,1
    1200:	fd34cce3          	blt	s1,s3,11d8 <main+0xd4>
            for (j = 0; j < w; j++)
    1204:	00190913          	addi	s2,s2,1
    1208:	01395663          	bge	s2,s3,1214 <main+0x110>
                for (i = 0; i < w; i++)
    120c:	00000493          	li	s1,0
    1210:	ff1ff06f          	j	1200 <main+0xfc>
        for (id = 0; id < S_N; id++) {
    1214:	001a0a13          	addi	s4,s4,1
    1218:	00700793          	li	a5,7
    121c:	0347ca63          	blt	a5,s4,1250 <main+0x14c>
            volatile uint16_t *p = (volatile uint16_t *)(ATLAS_BASE + g_spr_off[id]);
    1220:	000097b7          	lui	a5,0x9
    1224:	002a1713          	slli	a4,s4,0x2
    1228:	b6478793          	addi	a5,a5,-1180 # 8b64 <g_spr_off>
    122c:	00e787b3          	add	a5,a5,a4
    1230:	0007aa83          	lw	s5,0(a5)
    1234:	002017b7          	lui	a5,0x201
    1238:	00fa8ab3          	add	s5,s5,a5
            int w = (int)g_spr_sz[id];
    123c:	84018793          	addi	a5,gp,-1984 # 8cb8 <g_spr_sz>
    1240:	014787b3          	add	a5,a5,s4
    1244:	0007c983          	lbu	s3,0(a5) # 201000 <__freertos_irq_stack_top+0x1e64f0>
            for (j = 0; j < w; j++)
    1248:	00000913          	li	s2,0
    124c:	fbdff06f          	j	1208 <main+0x104>
        }
    }
    cache_evict();
    1250:	300010ef          	jal	2550 <cache_evict>

    /* ---- 引擎与位流能力 ---- */
    blt_init();
    1254:	7f4010ef          	jal	2a48 <blt_init>
    feat_probe();
    1258:	2f4040ef          	jal	554c <feat_probe>
#if BG_IMAGE
    bg_upload();                                /* ★开机把背景图从 flash 搬进 DDR */
    125c:	494040ef          	jal	56f0 <bg_upload>
#endif
    g_disp_sel = fb_stat_sel();                 /* 与实际在屏的缓冲对齐（重跑程序也安全） */
    1260:	2d0010ef          	jal	2530 <fb_stat_sel>
    1264:	00050793          	mv	a5,a0
    1268:	8ea1a623          	sw	a0,-1812(gp) # 8d64 <g_disp_sel>
    g_draw3    = (int)((g_disp_sel + 1u) % 3u);
    126c:	00150513          	addi	a0,a0,1
    1270:	00300713          	li	a4,3
    1274:	02e57533          	remu	a0,a0,a4
    1278:	82a1a823          	sw	a0,-2000(gp) # 8ca8 <g_draw3>
    g_clr3     = (int)((g_disp_sel + 2u) % 3u);
    127c:	00278793          	addi	a5,a5,2
    1280:	02e7f7b3          	remu	a5,a5,a4
    1284:	82f1a623          	sw	a5,-2004(gp) # 8ca4 <g_clr3>
    g_clr_need = 1;
    1288:	00100713          	li	a4,1
    128c:	8ee1a023          	sw	a4,-1824(gp) # 8d58 <g_clr_need>
    g_fb_back  = fb_of_sel((uint32_t)g_draw3);
    1290:	278010ef          	jal	2508 <fb_of_sel>
    1294:	82a1aa23          	sw	a0,-1996(gp) # 8cac <g_fb_back>

    /* ---- 三块缓冲各自铺一次底（此后背景由清屏引擎负责） ---- */
    stars_reset();
    1298:	73d030ef          	jal	51d4 <stars_reset>
    {
        int k;
        uint32_t sv = g_fb_back;
    129c:	8341a483          	lw	s1,-1996(gp) # 8cac <g_fb_back>
        for (k = 0; k < 3; k++) {
    12a0:	00000413          	li	s0,0
    12a4:	0380006f          	j	12dc <main+0x1d8>
            g_fb_back = fb_of_sel((uint32_t)k);
    12a8:	00040513          	mv	a0,s0
    12ac:	25c010ef          	jal	2508 <fb_of_sel>
    12b0:	82a1aa23          	sw	a0,-1996(gp) # 8cac <g_fb_back>
            cpu_fill32(g_fb_back, 0, 0, FB_WIDTH, FB_HEIGHT, COL_BG);
    12b4:	02100793          	li	a5,33
    12b8:	21c00713          	li	a4,540
    12bc:	3c000693          	li	a3,960
    12c0:	00000613          	li	a2,0
    12c4:	00000593          	li	a1,0
    12c8:	2b8010ef          	jal	2580 <cpu_fill32>
            g_bar_ok[k] = 0;
    12cc:	8dc18793          	addi	a5,gp,-1828 # 8d54 <g_bar_ok>
    12d0:	00f407b3          	add	a5,s0,a5
    12d4:	00078023          	sb	zero,0(a5)
        for (k = 0; k < 3; k++) {
    12d8:	00140413          	addi	s0,s0,1
    12dc:	00200793          	li	a5,2
    12e0:	fc87d4e3          	bge	a5,s0,12a8 <main+0x1a4>
        }
        g_fb_back = sv;
    12e4:	8291aa23          	sw	s1,-1996(gp) # 8cac <g_fb_back>
    }
    g_flip_req = g_disp_sel;
    12e8:	8ec1a703          	lw	a4,-1812(gp) # 8d64 <g_disp_sel>
    12ec:	8ee1a423          	sw	a4,-1816(gp) # 8d60 <g_flip_req>
    cache_evict();
    12f0:	260010ef          	jal	2550 <cache_evict>
    bsp_printf("publish: FLIPx3 (disp=%d draw=%d clr=%d)\r\n",
    12f4:	82c1a683          	lw	a3,-2004(gp) # 8ca4 <g_clr3>
    12f8:	8301a603          	lw	a2,-2000(gp) # 8ca8 <g_draw3>
    12fc:	8ec1a583          	lw	a1,-1812(gp) # 8d64 <g_disp_sel>
    1300:	00008537          	lui	a0,0x8
    1304:	00c50513          	addi	a0,a0,12 # 800c <_data+0xdc0>
    1308:	114040ef          	jal	541c <bsp_printf>
               (int)g_disp_sel, g_draw3, g_clr3);

    /* ---- 帧边界中断使能：翻转确认由扫描输出的场边界事件驱动（不依赖 trap） ---- */
    blt_wr(BLT_IRQ_EN, blt_rd(BLT_IRQ_EN) | BLT_IRQ_FRAME);
    130c:	01400513          	li	a0,20
    1310:	1e8010ef          	jal	24f8 <blt_rd>
    1314:	00256593          	ori	a1,a0,2
    1318:	01400513          	li	a0,20
    131c:	1cc010ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_IRQ_STATUS, BLT_IRQ_FRAME);
    1320:	00200593          	li	a1,2
    1324:	01000513          	li	a0,16
    1328:	1c0010ef          	jal	24e8 <blt_wr>

    /* ---- 开机自检：未对齐存储 / 精灵夹紧 / 属性字 / 定点混合 / 图集 / 信息条 / 帧预算 ---- */
    {
        uint16_t px0, px1;
        ent_t t;
        cpu_fill32(g_fb_back, 33, 500, 8, 2, 0xF800u);
    132c:	000107b7          	lui	a5,0x10
    1330:	80078793          	addi	a5,a5,-2048 # f800 <__global_pointer$+0x6388>
    1334:	00200713          	li	a4,2
    1338:	00800693          	li	a3,8
    133c:	1f400613          	li	a2,500
    1340:	02100593          	li	a1,33
    1344:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    1348:	238010ef          	jal	2580 <cpu_fill32>
        cpu_fill32(g_fb_back, 32, 502, 9, 2, 0x07E0u);
    134c:	7e000793          	li	a5,2016
    1350:	00200713          	li	a4,2
    1354:	00900693          	li	a3,9
    1358:	1f600613          	li	a2,502
    135c:	02000593          	li	a1,32
    1360:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    1364:	21c010ef          	jal	2580 <cpu_fill32>
        px0 = *(volatile uint16_t *)(g_fb_back + 500u * FB_STRIDE + 33u * 2u);
    1368:	8341a703          	lw	a4,-1996(gp) # 8cac <g_fb_back>
    136c:	000ea7b7          	lui	a5,0xea
    1370:	64278793          	addi	a5,a5,1602 # ea642 <__freertos_irq_stack_top+0xcfb32>
    1374:	00f707b3          	add	a5,a4,a5
    1378:	0007d583          	lhu	a1,0(a5)
        px1 = *(volatile uint16_t *)(g_fb_back + 502u * FB_STRIDE + 40u * 2u);
    137c:	000eb7b7          	lui	a5,0xeb
    1380:	55078793          	addi	a5,a5,1360 # eb550 <__freertos_irq_stack_top+0xd0a40>
    1384:	00f70733          	add	a4,a4,a5
    1388:	00075603          	lhu	a2,0(a4) # 201000 <__freertos_irq_stack_top+0x1e64f0>
        bsp_printf("aligncheck %x %x (expect f800 07e0)\r\n", (unsigned)px0, (unsigned)px1);
    138c:	00008537          	lui	a0,0x8
    1390:	03850513          	addi	a0,a0,56 # 8038 <_data+0xdec>
    1394:	088040ef          	jal	541c <bsp_printf>
        /* ent_clamp 的边界行为（与主机自检里跑的是同一份源码） */
        t.x = (int16_t)FP(-50); t.y = (int16_t)FP(PLAY_Y1 + 99); t.vx = 8; t.vy = 8;
    1398:	e7000793          	li	a5,-400
    139c:	00f11a23          	sh	a5,20(sp)
    13a0:	000017b7          	lui	a5,0x1
    13a4:	3f878793          	addi	a5,a5,1016 # 13f8 <main+0x2f4>
    13a8:	00f11b23          	sh	a5,22(sp)
    13ac:	00800793          	li	a5,8
    13b0:	00f11c23          	sh	a5,24(sp)
    13b4:	00f11d23          	sh	a5,26(sp)
        t.sz = SZ_B; t.r = 4; t.kind = S_B0; t.life = 1;
    13b8:	01000793          	li	a5,16
    13bc:	00f10ea3          	sb	a5,29(sp)
    13c0:	00400793          	li	a5,4
    13c4:	00f10f23          	sb	a5,30(sp)
    13c8:	00300793          	li	a5,3
    13cc:	00f10e23          	sb	a5,28(sp)
    13d0:	00100a13          	li	s4,1
    13d4:	01410fa3          	sb	s4,31(sp)
        ent_clamp(&t);
    13d8:	01410513          	addi	a0,sp,20
    13dc:	30d010ef          	jal	2ee8 <ent_clamp>
        bsp_printf("clampcheck x=%d y=%d vx=%d (expect 0 %d neg)\r\n",
                   PX(t.x), PX(t.y), (int)t.vx, PLAY_Y1 - SZ_B);
    13e0:	01411583          	lh	a1,20(sp)
    13e4:	01611603          	lh	a2,22(sp)
        bsp_printf("clampcheck x=%d y=%d vx=%d (expect 0 %d neg)\r\n",
    13e8:	20c00713          	li	a4,524
    13ec:	01811683          	lh	a3,24(sp)
    13f0:	40365613          	srai	a2,a2,0x3
    13f4:	4035d593          	srai	a1,a1,0x3
    13f8:	00008537          	lui	a0,0x8
    13fc:	06050513          	addi	a0,a0,96 # 8060 <_data+0xe14>
    1400:	01c040ef          	jal	541c <bsp_printf>
        bsp_printf("selfcheck: STATUS=%x COUNT=%d SCAN=%x DL_VER=%x\r\n",
                   (unsigned)blt_stat(), (unsigned)blt_cnt(), (unsigned)blt_rd(BLT_SCAN_DBG),
    1404:	5e8010ef          	jal	29ec <blt_stat>
    1408:	00050413          	mv	s0,a0
    140c:	5c4010ef          	jal	29d0 <blt_cnt>
    1410:	00050493          	mv	s1,a0
    1414:	02000513          	li	a0,32
    1418:	0e0010ef          	jal	24f8 <blt_rd>
    141c:	00050913          	mv	s2,a0
                   (unsigned)blt_rd(BLT_DL_VERSION));
    1420:	08000513          	li	a0,128
    1424:	0d4010ef          	jal	24f8 <blt_rd>
    1428:	00050713          	mv	a4,a0
        bsp_printf("selfcheck: STATUS=%x COUNT=%d SCAN=%x DL_VER=%x\r\n",
    142c:	00090693          	mv	a3,s2
    1430:	00048613          	mv	a2,s1
    1434:	00040593          	mv	a1,s0
    1438:	00008537          	lui	a0,0x8
    143c:	09050513          	addi	a0,a0,144 # 8090 <_data+0xe44>
    1440:	7dd030ef          	jal	541c <bsp_printf>
    }
    boot_selfcheck();
    1444:	31c040ef          	jal	5760 <boot_selfcheck>

    game_reset();
    1448:	64d030ef          	jal	5294 <game_reset>
    g_state = GS_TITLE;
    144c:	8a01a423          	sw	zero,-1880(gp) # 8d20 <g_state>
    osd_build();
    1450:	360030ef          	jal	47b0 <osd_build>
    osd_blit();
    1454:	349030ef          	jal	4f9c <osd_blit>
    g_bar_ok[g_draw3] = 1;
    1458:	8301a783          	lw	a5,-2000(gp) # 8ca8 <g_draw3>
    145c:	8dc18713          	addi	a4,gp,-1828 # 8d54 <g_bar_ok>
    1460:	00e787b3          	add	a5,a5,a4
    1464:	01478023          	sb	s4,0(a5)
    cache_evict();
    1468:	0e8010ef          	jal	2550 <cache_evict>

    t_now = tick32(); g_t_fps = t_now; t_st = t_now;
    146c:	060010ef          	jal	24cc <tick32>
    1470:	00050a93          	mv	s5,a0
    1474:	86a1a023          	sw	a0,-1952(gp) # 8cd8 <g_t_fps>
    uint32_t back_t0 = 0;
    1478:	00000913          	li	s2,0
    int      back_busy = 0;
    147c:	00000993          	li	s3,0
    int      frame_started = 0;
    1480:	00000a13          	li	s4,0
    uint32_t it = 0;
    1484:	00000413          	li	s0,0
    1488:	27c0006f          	j	1704 <main+0x600>
    for (;;) {
        it++;

        /* ---------- 串口：每 4 圈一次（输入延迟 ≈ 几十 µs，远小于一帧） ---------- */
        if ((it & 3u) == 0u) {
            serial_drain();
    148c:	4a9040ef          	jal	6134 <serial_drain>
            if ((it & 255u) == 0u) {
    1490:	0ff47793          	zext.b	a5,s0
    1494:	26079e63          	bnez	a5,1710 <main+0x60c>
                t_now = tick32();
    1498:	034010ef          	jal	24cc <tick32>
    149c:	00050b13          	mv	s6,a0
                /* 按键看门狗：500ms 没收到包 ⇒ 全部松开（标签切走/拔线都安全） */
                if (g_keys_live && (uint32_t)(t_now - g_key_t) > (uint32_t)KEY_WD_TICKS) {
    14a0:	87c1a783          	lw	a5,-1924(gp) # 8cf4 <g_keys_live>
    14a4:	02078063          	beqz	a5,14c4 <main+0x3c0>
    14a8:	8801a703          	lw	a4,-1920(gp) # 8cf8 <g_key_t>
    14ac:	40e50733          	sub	a4,a0,a4
    14b0:	02faf7b7          	lui	a5,0x2faf
    14b4:	08078793          	addi	a5,a5,128 # 2faf080 <__freertos_irq_stack_top+0x2f94570>
    14b8:	00e7f663          	bgeu	a5,a4,14c4 <main+0x3c0>
                    g_keys_live = 0;
    14bc:	8601ae23          	sw	zero,-1924(gp) # 8cf4 <g_keys_live>
                    g_keymask = 0u;
    14c0:	8801a423          	sw	zero,-1912(gp) # 8d00 <g_keymask>
                }
                /* 1Hz 帧率窗口：两个路径各记一个数，**都留在屏幕上** */
                if ((uint32_t)(t_now - g_t_fps) >= (uint32_t)BSP_CLINT_HZ) {
    14c4:	8601ab83          	lw	s7,-1952(gp) # 8cd8 <g_t_fps>
    14c8:	417b0bb3          	sub	s7,s6,s7
    14cc:	05f5e7b7          	lui	a5,0x5f5e
    14d0:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <__freertos_irq_stack_top+0x5f435ef>
    14d4:	2377fe63          	bgeu	a5,s7,1710 <main+0x60c>
                    uint32_t el = (uint32_t)(t_now - g_t_fps);
                    int f_hw = (int)(((uint64_t)g_hw_frames * (uint64_t)BSP_CLINT_HZ) / el);
    14d8:	8681a503          	lw	a0,-1944(gp) # 8ce0 <g_hw_frames>
    14dc:	05f5ec37          	lui	s8,0x5f5e
    14e0:	100c0c13          	addi	s8,s8,256 # 5f5e100 <__freertos_irq_stack_top+0x5f435f0>
    14e4:	038535b3          	mulhu	a1,a0,s8
    14e8:	000b8613          	mv	a2,s7
    14ec:	00000693          	li	a3,0
    14f0:	03850533          	mul	a0,a0,s8
    14f4:	0a9050ef          	jal	6d9c <__udivdi3>
    14f8:	00050c93          	mv	s9,a0
                    int f_sw = (int)(((uint64_t)g_sw_frames * (uint64_t)BSP_CLINT_HZ) / el);
    14fc:	8641a503          	lw	a0,-1948(gp) # 8cdc <g_sw_frames>
    1500:	038535b3          	mulhu	a1,a0,s8
    1504:	000b8613          	mv	a2,s7
    1508:	00000693          	li	a3,0
    150c:	03850533          	mul	a0,a0,s8
    1510:	08d050ef          	jal	6d9c <__udivdi3>
    1514:	00050b93          	mv	s7,a0
                    int fps_now;
                    g_t_fps = t_now;
    1518:	8761a023          	sw	s6,-1952(gp) # 8cd8 <g_t_fps>
                    /* ★面板计时：只在游玩中累加；回到标题/结束自动停住 */
                    if (g_state == GS_PLAY && !g_pause) g_secs++;
    151c:	8a81a703          	lw	a4,-1880(gp) # 8d20 <g_state>
    1520:	00100793          	li	a5,1
    1524:	06f70863          	beq	a4,a5,1594 <main+0x490>
                    g_hw_frames = 0; g_sw_frames = 0;
    1528:	8601a423          	sw	zero,-1944(gp) # 8ce0 <g_hw_frames>
    152c:	8601a223          	sw	zero,-1948(gp) # 8cdc <g_sw_frames>
                    if (g_mode == MD_HW) { g_hw_fps = (uint32_t)f_hw; fps_now = f_hw; }
    1530:	8201a703          	lw	a4,-2016(gp) # 8c98 <g_mode>
    1534:	00200793          	li	a5,2
    1538:	06f70a63          	beq	a4,a5,15ac <main+0x4a8>
                    else                 { g_sw_fps = (uint32_t)f_sw; fps_now = f_sw; }
    153c:	86a1a823          	sw	a0,-1936(gp) # 8ce8 <g_sw_fps>
                    /* ★ 自动爬坡：每秒一步（规则见 ramp_apply） */
                    {
                        int r = ramp_apply(fps_now, &g_ncap, &g_lim_n, &g_auto);
    1540:	8a018693          	addi	a3,gp,-1888 # 8d18 <g_auto>
    1544:	85818613          	addi	a2,gp,-1960 # 8cd0 <g_lim_n>
    1548:	81c18593          	addi	a1,gp,-2020 # 8c94 <g_ncap>
    154c:	000b8513          	mv	a0,s7
    1550:	054020ef          	jal	35a4 <ramp_apply>
                        if (r == 1)
    1554:	00100793          	li	a5,1
    1558:	06f50063          	beq	a0,a5,15b8 <main+0x4b4>
                            bsp_printf("\r\nEV ramp N=%d fps=%d\r\n", g_ncap, fps_now);
                        else if (r == 2)
    155c:	00200793          	li	a5,2
    1560:	06f50863          	beq	a0,a5,15d0 <main+0x4cc>
                            bsp_printf("\r\nLIMIT N=%d fps=%d ON=%d (hit N_MAX)\r\n",
                                       g_lim_n, fps_now, g_on_screen);
                        else if (r < 0)
    1564:	1a055663          	bgez	a0,1710 <main+0x60c>
                            bsp_printf("\r\nLIMIT N=%d fps=%d ON=%d path=%s (max stable at 60fps)\r\n",
    1568:	8581ab03          	lw	s6,-1960(gp) # 8cd0 <g_lim_n>
    156c:	85c1ac03          	lw	s8,-1956(gp) # 8cd4 <g_on_screen>
    1570:	21c030ef          	jal	478c <path_label>
    1574:	00050713          	mv	a4,a0
    1578:	000c0693          	mv	a3,s8
    157c:	000b8613          	mv	a2,s7
    1580:	000b0593          	mv	a1,s6
    1584:	00008537          	lui	a0,0x8
    1588:	10450513          	addi	a0,a0,260 # 8104 <_data+0xeb8>
    158c:	691030ef          	jal	541c <bsp_printf>
    1590:	1800006f          	j	1710 <main+0x60c>
                    if (g_state == GS_PLAY && !g_pause) g_secs++;
    1594:	8a41a783          	lw	a5,-1884(gp) # 8d1c <g_pause>
    1598:	f80798e3          	bnez	a5,1528 <main+0x424>
    159c:	86c1a783          	lw	a5,-1940(gp) # 8ce4 <g_secs>
    15a0:	00178793          	addi	a5,a5,1
    15a4:	86f1a623          	sw	a5,-1940(gp) # 8ce4 <g_secs>
    15a8:	f81ff06f          	j	1528 <main+0x424>
                    if (g_mode == MD_HW) { g_hw_fps = (uint32_t)f_hw; fps_now = f_hw; }
    15ac:	8791aa23          	sw	s9,-1932(gp) # 8cec <g_hw_fps>
    15b0:	000c8b93          	mv	s7,s9
    15b4:	f8dff06f          	j	1540 <main+0x43c>
                            bsp_printf("\r\nEV ramp N=%d fps=%d\r\n", g_ncap, fps_now);
    15b8:	000b8613          	mv	a2,s7
    15bc:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    15c0:	00008537          	lui	a0,0x8
    15c4:	0c450513          	addi	a0,a0,196 # 80c4 <_data+0xe78>
    15c8:	655030ef          	jal	541c <bsp_printf>
    15cc:	1440006f          	j	1710 <main+0x60c>
                            bsp_printf("\r\nLIMIT N=%d fps=%d ON=%d (hit N_MAX)\r\n",
    15d0:	85c1a683          	lw	a3,-1956(gp) # 8cd4 <g_on_screen>
    15d4:	000b8613          	mv	a2,s7
    15d8:	8581a583          	lw	a1,-1960(gp) # 8cd0 <g_lim_n>
    15dc:	00008537          	lui	a0,0x8
    15e0:	0dc50513          	addi	a0,a0,220 # 80dc <_data+0xe90>
    15e4:	639030ef          	jal	541c <bsp_printf>
    15e8:	1280006f          	j	1710 <main+0x60c>
                 *   锁存 FB_SEL。中断比锁存早几拍到达时，这一场的 IRQ 被白吃，
                 *   只能等下一场才确认 ⇒ **固定每两场发一帧 = 30fps，与负载无关**
                 *   （板上实测：物块很少也只有 29~30 帧）。现在 IRQ 挂到确认成功才清，
                 *   同一场内"中断已到 + FB_STAT 也就位"即可确认，恢复 60fps。 */
                if ((irq & BLT_IRQ_FRAME) && (fb_stat_sel() == g_flip_req)) {
                    blt_wr(BLT_IRQ_STATUS, BLT_IRQ_FRAME);      /* W1C：确认成功才清 */
    15ec:	00200593          	li	a1,2
    15f0:	01000513          	li	a0,16
    15f4:	6f5000ef          	jal	24e8 <blt_wr>
                    int old_disp;
                    back_busy  = 0;
                    old_disp   = (int)g_disp_sel;
    15f8:	8ec1a703          	lw	a4,-1812(gp) # 8d64 <g_disp_sel>
                    g_disp_sel = g_flip_req;
    15fc:	8e81a683          	lw	a3,-1816(gp) # 8d60 <g_flip_req>
    1600:	8ed1a623          	sw	a3,-1812(gp) # 8d64 <g_disp_sel>
                    g_draw3    = g_clr3;
    1604:	82c1a503          	lw	a0,-2004(gp) # 8ca4 <g_clr3>
    1608:	82a1a823          	sw	a0,-2000(gp) # 8ca8 <g_draw3>
                    g_clr3     = old_disp;
    160c:	82e1a623          	sw	a4,-2004(gp) # 8ca4 <g_clr3>
                    g_clr_need = 1;
    1610:	00100493          	li	s1,1
    1614:	8e91a023          	sw	s1,-1824(gp) # 8d58 <g_clr_need>
                    g_fb_back  = fb_of_sel((uint32_t)g_draw3);
    1618:	6f1000ef          	jal	2508 <fb_of_sel>
    161c:	82a1aa23          	sw	a0,-1996(gp) # 8cac <g_fb_back>
                    if (g_mode == MD_SW) g_sw_frames++; else g_hw_frames++;
    1620:	8201a783          	lw	a5,-2016(gp) # 8c98 <g_mode>
    1624:	02978863          	beq	a5,s1,1654 <main+0x550>
    1628:	8681a783          	lw	a5,-1944(gp) # 8ce0 <g_hw_frames>
    162c:	00178793          	addi	a5,a5,1
    1630:	86f1a423          	sw	a5,-1944(gp) # 8ce0 <g_hw_frames>
                    frame_started = 0;                 /* 下一圈开新的一帧 */
                    /* ★ 4Hz 状态行：给上位机做记分板用。
                     *   为什么不每帧打：115200 下 ~87µs/字节是**阻塞**的（uart_write 等 TX 余量），
                     *   每帧一行的串口时间会直接吃掉帧预算。4Hz × ~48B ≈ 190B/s ≈ 1.7% CPU。 */
                    if ((uint32_t)(tick32() - t_st) >= (uint32_t)ST_PERIOD_TICKS) {
    1634:	699000ef          	jal	24cc <tick32>
    1638:	41550733          	sub	a4,a0,s5
    163c:	017d87b7          	lui	a5,0x17d8
    1640:	83f78793          	addi	a5,a5,-1985 # 17d783f <__freertos_irq_stack_top+0x17bcd2f>
    1644:	02e7e063          	bltu	a5,a4,1664 <main+0x560>
                    back_busy  = 0;
    1648:	00000993          	li	s3,0
                    frame_started = 0;                 /* 下一圈开新的一帧 */
    164c:	00000a13          	li	s4,0
                    cpu_backoff(BLT_WAIT_NOP);
                }
            } else {
                cpu_backoff(BLT_WAIT_NOP);
            }
            continue;
    1650:	0b40006f          	j	1704 <main+0x600>
                    if (g_mode == MD_SW) g_sw_frames++; else g_hw_frames++;
    1654:	8641a783          	lw	a5,-1948(gp) # 8cdc <g_sw_frames>
    1658:	00178793          	addi	a5,a5,1
    165c:	86f1a223          	sw	a5,-1948(gp) # 8cdc <g_sw_frames>
    1660:	fd5ff06f          	j	1634 <main+0x530>
                        t_st = tick32();
    1664:	669000ef          	jal	24cc <tick32>
    1668:	00050a93          	mv	s5,a0
                                   (g_mode == MD_SW) ? (int)g_sw_fps : (int)g_hw_fps,
    166c:	8201a503          	lw	a0,-2016(gp) # 8c98 <g_mode>
                        bsp_printf("ST fps=%d n=%d on=%d sc=%d lv=%d hp=%d bm=%d md=%s\r\n",
    1670:	00100793          	li	a5,1
    1674:	04f50663          	beq	a0,a5,16c0 <main+0x5bc>
                                   (g_mode == MD_SW) ? (int)g_sw_fps : (int)g_hw_fps,
    1678:	8741a583          	lw	a1,-1932(gp) # 8cec <g_hw_fps>
                        bsp_printf("ST fps=%d n=%d on=%d sc=%d lv=%d hp=%d bm=%d md=%s\r\n",
    167c:	81c1a603          	lw	a2,-2020(gp) # 8c94 <g_ncap>
    1680:	85c1a683          	lw	a3,-1956(gp) # 8cd4 <g_on_screen>
    1684:	8941a703          	lw	a4,-1900(gp) # 8d0c <g_score>
    1688:	8101a783          	lw	a5,-2032(gp) # 8c88 <g_level>
    168c:	8181a803          	lw	a6,-2024(gp) # 8c90 <g_hp>
    1690:	8141a883          	lw	a7,-2028(gp) # 8c8c <g_bomb>
    1694:	00100313          	li	t1,1
    1698:	02650863          	beq	a0,t1,16c8 <main+0x5c4>
    169c:	00007537          	lui	a0,0x7
    16a0:	2d850513          	addi	a0,a0,728 # 72d8 <_data+0x8c>
    16a4:	00a12023          	sw	a0,0(sp)
    16a8:	00008537          	lui	a0,0x8
    16ac:	14050513          	addi	a0,a0,320 # 8140 <_data+0xef4>
    16b0:	56d030ef          	jal	541c <bsp_printf>
                    back_busy  = 0;
    16b4:	00000993          	li	s3,0
                    frame_started = 0;                 /* 下一圈开新的一帧 */
    16b8:	00000a13          	li	s4,0
    16bc:	0480006f          	j	1704 <main+0x600>
                                   (g_mode == MD_SW) ? (int)g_sw_fps : (int)g_hw_fps,
    16c0:	8701a583          	lw	a1,-1936(gp) # 8ce8 <g_sw_fps>
    16c4:	fb9ff06f          	j	167c <main+0x578>
                        bsp_printf("ST fps=%d n=%d on=%d sc=%d lv=%d hp=%d bm=%d md=%s\r\n",
    16c8:	00008537          	lui	a0,0x8
    16cc:	db450513          	addi	a0,a0,-588 # 7db4 <_data+0xb68>
    16d0:	fd5ff06f          	j	16a4 <main+0x5a0>
                                   (unsigned)blt_rd(BLT_FB_STAT));
    16d4:	02800513          	li	a0,40
    16d8:	621000ef          	jal	24f8 <blt_rd>
    16dc:	00050593          	mv	a1,a0
                        bsp_printf("\r\nEV flip timeout, FB_STAT=%x\r\n",
    16e0:	00008537          	lui	a0,0x8
    16e4:	17850513          	addi	a0,a0,376 # 8178 <_data+0xf2c>
    16e8:	535030ef          	jal	541c <bsp_printf>
    16ec:	0700006f          	j	175c <main+0x658>
                    cpu_backoff(BLT_WAIT_NOP);
    16f0:	03000513          	li	a0,48
    16f4:	5e5000ef          	jal	24d8 <cpu_backoff>
    16f8:	00c0006f          	j	1704 <main+0x600>
                cpu_backoff(BLT_WAIT_NOP);
    16fc:	03000513          	li	a0,48
    1700:	5d9000ef          	jal	24d8 <cpu_backoff>
        it++;
    1704:	00140413          	addi	s0,s0,1
        if ((it & 3u) == 0u) {
    1708:	00347493          	andi	s1,s0,3
    170c:	d80480e3          	beqz	s1,148c <main+0x388>
        if (back_busy) {
    1710:	06098263          	beqz	s3,1774 <main+0x670>
            if ((it & BLT_WAIT_MASK) == 0u) {
    1714:	fe0494e3          	bnez	s1,16fc <main+0x5f8>
                uint32_t irq = blt_rd(BLT_IRQ_STATUS);
    1718:	01000513          	li	a0,16
    171c:	5dd000ef          	jal	24f8 <blt_rd>
                if ((irq & BLT_IRQ_FRAME) && (fb_stat_sel() == g_flip_req)) {
    1720:	00257513          	andi	a0,a0,2
    1724:	00050863          	beqz	a0,1734 <main+0x630>
    1728:	609000ef          	jal	2530 <fb_stat_sel>
    172c:	8e81a783          	lw	a5,-1816(gp) # 8d60 <g_flip_req>
    1730:	eaf50ee3          	beq	a0,a5,15ec <main+0x4e8>
                } else if ((uint32_t)(tick32() - back_t0) > (uint32_t)FLIP_TIMEOUT_TICKS) {
    1734:	599000ef          	jal	24cc <tick32>
    1738:	41250533          	sub	a0,a0,s2
    173c:	009897b7          	lui	a5,0x989
    1740:	68078793          	addi	a5,a5,1664 # 989680 <__freertos_irq_stack_top+0x96eb70>
    1744:	faa7f6e3          	bgeu	a5,a0,16f0 <main+0x5ec>
                    g_flip_to++;
    1748:	8e41a783          	lw	a5,-1820(gp) # 8d5c <g_flip_to>
    174c:	00178793          	addi	a5,a5,1
    1750:	8ef1a223          	sw	a5,-1820(gp) # 8d5c <g_flip_to>
                    if (g_flip_to == 1u)
    1754:	00100713          	li	a4,1
    1758:	f6e78ee3          	beq	a5,a4,16d4 <main+0x5d0>
                    blt_wr(BLT_FB_SEL, g_flip_req);    /* 重发请求，继续有界等待 */
    175c:	8e81a583          	lw	a1,-1816(gp) # 8d60 <g_flip_req>
    1760:	02400513          	li	a0,36
    1764:	585000ef          	jal	24e8 <blt_wr>
                    back_t0 = tick32();
    1768:	565000ef          	jal	24cc <tick32>
    176c:	00050913          	mv	s2,a0
    1770:	f95ff06f          	j	1704 <main+0x600>
        }

        /* ---------- 本帧起点：推进一帧游戏 + 组清单 + 画信息条 ---------- */
        if (!frame_started) {
    1774:	040a0a63          	beqz	s4,17c8 <main+0x6c4>
            frame_started = 1;
            continue;
        }

        /* ---------- 纯 CPU 对照路径：整帧由 CPU 画（诚实分母） ---------- */
        if (g_mode == MD_SW) {
    1778:	8201a483          	lw	s1,-2016(gp) # 8c98 <g_mode>
    177c:	00100793          	li	a5,1
    1780:	08f48263          	beq	s1,a5,1804 <main+0x700>
            back_t0    = tick32();
            continue;
        }

        /* ---------- 硬件路径：分块把本帧清单推进 FIFO ---------- */
        if (g_dl_i < g_dl_n) { push_chunk(); continue; }
    1784:	8b01a703          	lw	a4,-1872(gp) # 8d28 <g_dl_i>
    1788:	8b41a783          	lw	a5,-1868(gp) # 8d2c <g_dl_n>
    178c:	0af74463          	blt	a4,a5,1834 <main+0x730>

        /* ---------- 清单推完：等引擎空闲（有界）→ 画中央字幕 → 请求翻转 ---------- */
        if (!wait_engine_idle()) { blt_recover("engine never went idle"); frame_started = 0; continue; }
    1790:	40d030ef          	jal	539c <wait_engine_idle>
    1794:	00050493          	mv	s1,a0
    1798:	0a050263          	beqz	a0,183c <main+0x738>
        overlay_draw();                        /* ★ 必须等引擎画完再写，否则会被引擎覆盖 */
    179c:	15d030ef          	jal	50f8 <overlay_draw>
        cache_evict();
    17a0:	5b1000ef          	jal	2550 <cache_evict>
        blt_wr(BLT_FB_SEL, (uint32_t)g_draw3);
    17a4:	8301a583          	lw	a1,-2000(gp) # 8ca8 <g_draw3>
    17a8:	02400513          	li	a0,36
    17ac:	53d000ef          	jal	24e8 <blt_wr>
        g_flip_req = (uint32_t)g_draw3;
    17b0:	8301a703          	lw	a4,-2000(gp) # 8ca8 <g_draw3>
    17b4:	8ee1a423          	sw	a4,-1816(gp) # 8d60 <g_flip_req>
        back_busy  = 1;
        back_t0    = tick32();
    17b8:	515000ef          	jal	24cc <tick32>
    17bc:	00050913          	mv	s2,a0
        back_busy  = 1;
    17c0:	000a0993          	mv	s3,s4
    17c4:	f41ff06f          	j	1704 <main+0x600>
            game_tick();
    17c8:	505040ef          	jal	64cc <game_tick>
            repaint = hw_pass_arm();
    17cc:	3a4010ef          	jal	2b70 <hw_pass_arm>
            build_draw_list(repaint);
    17d0:	108020ef          	jal	38d8 <build_draw_list>
            g_on_screen = dl_sprite_count();
    17d4:	340020ef          	jal	3b14 <dl_sprite_count>
    17d8:	84a1ae23          	sw	a0,-1956(gp) # 8cd4 <g_on_screen>
            osd_build();
    17dc:	7d5020ef          	jal	47b0 <osd_build>
            osd_blit();
    17e0:	7bc030ef          	jal	4f9c <osd_blit>
            g_bar_ok[g_draw3] = 1;
    17e4:	8301a783          	lw	a5,-2000(gp) # 8ca8 <g_draw3>
    17e8:	8dc18713          	addi	a4,gp,-1828 # 8d54 <g_bar_ok>
    17ec:	00e787b3          	add	a5,a5,a4
    17f0:	00100713          	li	a4,1
    17f4:	00e78023          	sb	a4,0(a5)
            g_dl_i = 0;
    17f8:	8a01a823          	sw	zero,-1872(gp) # 8d28 <g_dl_i>
            frame_started = 1;
    17fc:	00100a13          	li	s4,1
            continue;
    1800:	f05ff06f          	j	1704 <main+0x600>
            cpu_render_frame();
    1804:	1b5020ef          	jal	41b8 <cpu_render_frame>
            overlay_draw();
    1808:	0f1030ef          	jal	50f8 <overlay_draw>
            cache_evict();
    180c:	545000ef          	jal	2550 <cache_evict>
            blt_wr(BLT_FB_SEL, (uint32_t)g_draw3);
    1810:	8301a583          	lw	a1,-2000(gp) # 8ca8 <g_draw3>
    1814:	02400513          	li	a0,36
    1818:	4d1000ef          	jal	24e8 <blt_wr>
            g_flip_req = (uint32_t)g_draw3;
    181c:	8301a703          	lw	a4,-2000(gp) # 8ca8 <g_draw3>
    1820:	8ee1a423          	sw	a4,-1816(gp) # 8d60 <g_flip_req>
            back_t0    = tick32();
    1824:	4a9000ef          	jal	24cc <tick32>
    1828:	00050913          	mv	s2,a0
            back_busy  = 1;
    182c:	00048993          	mv	s3,s1
            continue;
    1830:	ed5ff06f          	j	1704 <main+0x600>
        if (g_dl_i < g_dl_n) { push_chunk(); continue; }
    1834:	3a8020ef          	jal	3bdc <push_chunk>
    1838:	ecdff06f          	j	1704 <main+0x600>
        if (!wait_engine_idle()) { blt_recover("engine never went idle"); frame_started = 0; continue; }
    183c:	00008537          	lui	a0,0x8
    1840:	19850513          	addi	a0,a0,408 # 8198 <_data+0xf4c>
    1844:	4e4050ef          	jal	6d28 <blt_recover>
    1848:	00048a13          	mv	s4,s1
    184c:	eb9ff06f          	j	1704 <main+0x600>

00001850 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    1850:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    1854:	01055513          	srli	a0,a0,0x10
    }
    1858:	0ff57513          	zext.b	a0,a0
    185c:	00008067          	ret

00001860 <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
    1860:	ff010113          	addi	sp,sp,-16
    1864:	00112623          	sw	ra,12(sp)
    1868:	00812423          	sw	s0,8(sp)
    186c:	00912223          	sw	s1,4(sp)
    1870:	00050413          	mv	s0,a0
    1874:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    1878:	00040513          	mv	a0,s0
    187c:	fd5ff0ef          	jal	1850 <uart_writeAvailability>
    1880:	fe050ce3          	beqz	a0,1878 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    1884:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    1888:	00c12083          	lw	ra,12(sp)
    188c:	00812403          	lw	s0,8(sp)
    1890:	00412483          	lw	s1,4(sp)
    1894:	01010113          	addi	sp,sp,16
    1898:	00008067          	ret

0000189c <uart_applyConfig>:
*          value using data length, parity, and stop bit settings from the configuration
*          structure, and writes this value to the UART frame configuration register.
*
******************************************************************************/
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
    189c:	00c5a783          	lw	a5,12(a1) # 30100c <__freertos_irq_stack_top+0x2e64fc>
    18a0:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
    18a4:	0005a783          	lw	a5,0(a1)
    18a8:	fff78793          	addi	a5,a5,-1
    18ac:	0045a703          	lw	a4,4(a1)
    18b0:	00871713          	slli	a4,a4,0x8
    18b4:	00e7e7b3          	or	a5,a5,a4
    18b8:	0085a703          	lw	a4,8(a1)
    18bc:	01071713          	slli	a4,a4,0x10
    18c0:	00e7e7b3          	or	a5,a5,a4
    18c4:	00f52623          	sw	a5,12(a0)
    }
    18c8:	00008067          	ret

000018cc <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
    18cc:	000f47b7          	lui	a5,0xf4
    18d0:	24078793          	addi	a5,a5,576 # f4240 <__freertos_irq_stack_top+0xd9730>
    18d4:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    18d8:	0000c7b7          	lui	a5,0xc
    18dc:	ff878793          	addi	a5,a5,-8 # bff8 <__global_pointer$+0x2b80>
    18e0:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
    18e4:	00062783          	lw	a5,0(a2) # 501000 <__freertos_irq_stack_top+0x4e64f0>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    18e8:	02a585b3          	mul	a1,a1,a0
    18ec:	00f58733          	add	a4,a1,a5
    18f0:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    18f4:	40f707b3          	sub	a5,a4,a5
    18f8:	fe07dce3          	bgez	a5,18f0 <clint_uDelay+0x24>
    18fc:	00008067          	ret

00001900 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    1900:	ff010113          	addi	sp,sp,-16
    1904:	00112623          	sw	ra,12(sp)
    1908:	00050593          	mv	a1,a0
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    190c:	f8010537          	lui	a0,0xf8010
    1910:	f51ff0ef          	jal	1860 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1914:	00c12083          	lw	ra,12(sp)
    1918:	01010113          	addi	sp,sp,16
    191c:	00008067          	ret

00001920 <_putchar_s>:

    static void _putchar_s(char *p)
    {
    1920:	ff010113          	addi	sp,sp,-16
    1924:	00112623          	sw	ra,12(sp)
    1928:	00812423          	sw	s0,8(sp)
    192c:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    1930:	00c0006f          	j	193c <_putchar_s+0x1c>
            _putchar(*(p++));
    1934:	00140413          	addi	s0,s0,1
    1938:	fc9ff0ef          	jal	1900 <_putchar>
        while (*p)
    193c:	00044503          	lbu	a0,0(s0)
    1940:	fe051ae3          	bnez	a0,1934 <_putchar_s+0x14>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1944:	00c12083          	lw	ra,12(sp)
    1948:	00812403          	lw	s0,8(sp)
    194c:	01010113          	addi	sp,sp,16
    1950:	00008067          	ret

00001954 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    1954:	ff010113          	addi	sp,sp,-16
    1958:	00112623          	sw	ra,12(sp)
    195c:	00812423          	sw	s0,8(sp)
    1960:	00912223          	sw	s1,4(sp)
    1964:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1968:	01c00413          	li	s0,28
    196c:	0240006f          	j	1990 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    1970:	0084d733          	srl	a4,s1,s0
    1974:	00f77713          	andi	a4,a4,15
    1978:	000077b7          	lui	a5,0x7
    197c:	24c78793          	addi	a5,a5,588 # 724c <_data>
    1980:	00e787b3          	add	a5,a5,a4
    1984:	0007c503          	lbu	a0,0(a5)
    1988:	f79ff0ef          	jal	1900 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    198c:	ffc40413          	addi	s0,s0,-4
    1990:	fe0450e3          	bgez	s0,1970 <bsp_printHex+0x1c>
        }
    }
    1994:	00c12083          	lw	ra,12(sp)
    1998:	00812403          	lw	s0,8(sp)
    199c:	00412483          	lw	s1,4(sp)
    19a0:	01010113          	addi	sp,sp,16
    19a4:	00008067          	ret

000019a8 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    19a8:	ff010113          	addi	sp,sp,-16
    19ac:	00112623          	sw	ra,12(sp)
    19b0:	00812423          	sw	s0,8(sp)
    19b4:	00912223          	sw	s1,4(sp)
    19b8:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    19bc:	01c00413          	li	s0,28
    19c0:	0240006f          	j	19e4 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    19c4:	0084d733          	srl	a4,s1,s0
    19c8:	00f77713          	andi	a4,a4,15
    19cc:	000077b7          	lui	a5,0x7
    19d0:	26078793          	addi	a5,a5,608 # 7260 <_data+0x14>
    19d4:	00e787b3          	add	a5,a5,a4
    19d8:	0007c503          	lbu	a0,0(a5)
    19dc:	f25ff0ef          	jal	1900 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    19e0:	ffc40413          	addi	s0,s0,-4
    19e4:	fe0450e3          	bgez	s0,19c4 <bsp_printHex_lower+0x1c>

        }
    }
    19e8:	00c12083          	lw	ra,12(sp)
    19ec:	00812403          	lw	s0,8(sp)
    19f0:	00412483          	lw	s1,4(sp)
    19f4:	01010113          	addi	sp,sp,16
    19f8:	00008067          	ret

000019fc <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    19fc:	ff010113          	addi	sp,sp,-16
    1a00:	00112623          	sw	ra,12(sp)
        _putchar(c);
    1a04:	0ff57513          	zext.b	a0,a0
    1a08:	ef9ff0ef          	jal	1900 <_putchar>
    }
    1a0c:	00c12083          	lw	ra,12(sp)
    1a10:	01010113          	addi	sp,sp,16
    1a14:	00008067          	ret

00001a18 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    1a18:	ff010113          	addi	sp,sp,-16
    1a1c:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    1a20:	f01ff0ef          	jal	1920 <_putchar_s>
    }
    1a24:	00c12083          	lw	ra,12(sp)
    1a28:	01010113          	addi	sp,sp,16
    1a2c:	00008067          	ret

00001a30 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    1a30:	fd010113          	addi	sp,sp,-48
    1a34:	02112623          	sw	ra,44(sp)
    1a38:	02812423          	sw	s0,40(sp)
    1a3c:	02912223          	sw	s1,36(sp)
    1a40:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    1a44:	00054663          	bltz	a0,1a50 <bsp_printf_d+0x20>
    {
    1a48:	00010413          	mv	s0,sp
    1a4c:	02c0006f          	j	1a78 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    1a50:	02d00513          	li	a0,45
    1a54:	fa9ff0ef          	jal	19fc <bsp_printf_c>
            val = -val;
    1a58:	409004b3          	neg	s1,s1
    1a5c:	fedff06f          	j	1a48 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    1a60:	00a00713          	li	a4,10
    1a64:	02e4e7b3          	rem	a5,s1,a4
    1a68:	03078793          	addi	a5,a5,48
    1a6c:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    1a70:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    1a74:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    1a78:	fe0494e3          	bnez	s1,1a60 <bsp_printf_d+0x30>
    1a7c:	00010793          	mv	a5,sp
    1a80:	fef400e3          	beq	s0,a5,1a60 <bsp_printf_d+0x30>
        }
        while (p != buffer)
    1a84:	00010793          	mv	a5,sp
    1a88:	00f40a63          	beq	s0,a5,1a9c <bsp_printf_d+0x6c>
            bsp_printf_c(*(--p));
    1a8c:	fff40413          	addi	s0,s0,-1
    1a90:	00044503          	lbu	a0,0(s0)
    1a94:	f69ff0ef          	jal	19fc <bsp_printf_c>
    1a98:	fedff06f          	j	1a84 <bsp_printf_d+0x54>
    }
    1a9c:	02c12083          	lw	ra,44(sp)
    1aa0:	02812403          	lw	s0,40(sp)
    1aa4:	02412483          	lw	s1,36(sp)
    1aa8:	03010113          	addi	sp,sp,48
    1aac:	00008067          	ret

00001ab0 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    1ab0:	ff010113          	addi	sp,sp,-16
    1ab4:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    1ab8:	00000713          	li	a4,0
    1abc:	00700793          	li	a5,7
    1ac0:	02e7c063          	blt	a5,a4,1ae0 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1ac4:	00271693          	slli	a3,a4,0x2
    1ac8:	ff000793          	li	a5,-16
    1acc:	00d797b3          	sll	a5,a5,a3
    1ad0:	00f577b3          	and	a5,a0,a5
    1ad4:	00078663          	beqz	a5,1ae0 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    1ad8:	00170713          	addi	a4,a4,1
    1adc:	fe1ff06f          	j	1abc <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    1ae0:	ec9ff0ef          	jal	19a8 <bsp_printHex_lower>
    }
    1ae4:	00c12083          	lw	ra,12(sp)
    1ae8:	01010113          	addi	sp,sp,16
    1aec:	00008067          	ret

00001af0 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    1af0:	ff010113          	addi	sp,sp,-16
    1af4:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    1af8:	00000713          	li	a4,0
    1afc:	00700793          	li	a5,7
    1b00:	02e7c063          	blt	a5,a4,1b20 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1b04:	00271693          	slli	a3,a4,0x2
    1b08:	ff000793          	li	a5,-16
    1b0c:	00d797b3          	sll	a5,a5,a3
    1b10:	00f577b3          	and	a5,a0,a5
    1b14:	00078663          	beqz	a5,1b20 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    1b18:	00170713          	addi	a4,a4,1
    1b1c:	fe1ff06f          	j	1afc <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    1b20:	e35ff0ef          	jal	1954 <bsp_printHex>
        }
    1b24:	00c12083          	lw	ra,12(sp)
    1b28:	01010113          	addi	sp,sp,16
    1b2c:	00008067          	ret

00001b30 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
    1b30:	fe010113          	addi	sp,sp,-32
    1b34:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
    1b38:	00800793          	li	a5,8
    1b3c:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
    1b40:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
    1b44:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
    1b48:	06b00793          	li	a5,107
    1b4c:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
    1b50:	00010593          	mv	a1,sp
    1b54:	f8010537          	lui	a0,0xf8010
    1b58:	d45ff0ef          	jal	189c <uart_applyConfig>
    }
    1b5c:	01c12083          	lw	ra,28(sp)
    1b60:	02010113          	addi	sp,sp,32
    1b64:	00008067          	ret

00001b68 <spi_cmdAvailability>:
    1b68:	00452503          	lw	a0,4(a0) # f8010004 <__freertos_irq_stack_top+0xf7ff54f4>
 * @return The availability of command buffer space (lower 16 bits of SPI buffer)
 *
 ******************************************************************************/
    static u32 spi_cmdAvailability(u32 reg){
        return read_u32(reg + SPI_BUFFER) & 0xFFFF;
    }
    1b6c:	01051513          	slli	a0,a0,0x10
    1b70:	01055513          	srli	a0,a0,0x10
    1b74:	00008067          	ret

00001b78 <spi_rspOccupancy>:
    1b78:	00452503          	lw	a0,4(a0)
 * @return The occupancy of response buffer space (upper 16 bits of SPI buffer)
 *
 ******************************************************************************/
    static u32 spi_rspOccupancy(u32 reg){
        return read_u32(reg + SPI_BUFFER) >> 16;
    }
    1b7c:	01055513          	srli	a0,a0,0x10
    1b80:	00008067          	ret

00001b84 <spi_write>:
 * @param reg The base address of the SPI register
 *
 * @param data The data to be written
 *
 ******************************************************************************/
    static void spi_write(u32 reg, u8 data){
    1b84:	ff010113          	addi	sp,sp,-16
    1b88:	00112623          	sw	ra,12(sp)
    1b8c:	00812423          	sw	s0,8(sp)
    1b90:	00912223          	sw	s1,4(sp)
    1b94:	00050413          	mv	s0,a0
    1b98:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
    1b9c:	00040513          	mv	a0,s0
    1ba0:	fc9ff0ef          	jal	1b68 <spi_cmdAvailability>
    1ba4:	fe050ce3          	beqz	a0,1b9c <spi_write+0x18>
        write_u32(data | SPI_CMD_WRITE, reg + SPI_DATA);
    1ba8:	1004e493          	ori	s1,s1,256
        *((volatile u32*) address) = data;
    1bac:	00942023          	sw	s1,0(s0)
    }
    1bb0:	00c12083          	lw	ra,12(sp)
    1bb4:	00812403          	lw	s0,8(sp)
    1bb8:	00412483          	lw	s1,4(sp)
    1bbc:	01010113          	addi	sp,sp,16
    1bc0:	00008067          	ret

00001bc4 <spi_read>:
 * @param reg The base address of the SPI register
 *
 * @return The data read from the SPI data register
 *
 ******************************************************************************/   
    static u8 spi_read(u32 reg){
    1bc4:	ff010113          	addi	sp,sp,-16
    1bc8:	00112623          	sw	ra,12(sp)
    1bcc:	00812423          	sw	s0,8(sp)
    1bd0:	00050413          	mv	s0,a0
        while(spi_cmdAvailability(reg) == 0);
    1bd4:	00040513          	mv	a0,s0
    1bd8:	f91ff0ef          	jal	1b68 <spi_cmdAvailability>
    1bdc:	fe050ce3          	beqz	a0,1bd4 <spi_read+0x10>
    1be0:	20000793          	li	a5,512
    1be4:	00f42023          	sw	a5,0(s0)
        write_u32(SPI_CMD_READ, reg + SPI_DATA);
        while(spi_rspOccupancy(reg) == 0);
    1be8:	00040513          	mv	a0,s0
    1bec:	f8dff0ef          	jal	1b78 <spi_rspOccupancy>
    1bf0:	fe050ce3          	beqz	a0,1be8 <spi_read+0x24>
        return *((volatile u32*) address);
    1bf4:	00042503          	lw	a0,0(s0)
        return read_u32(reg + SPI_DATA);
    }
    1bf8:	0ff57513          	zext.b	a0,a0
    1bfc:	00c12083          	lw	ra,12(sp)
    1c00:	00812403          	lw	s0,8(sp)
    1c04:	01010113          	addi	sp,sp,16
    1c08:	00008067          	ret

00001c0c <spi_select>:
 *
 * @param reg The base address of the SPI register
 * @param slaveId The ID of the slave device to select
 *
 ******************************************************************************/
    static void spi_select(u32 reg, u32 slaveId){
    1c0c:	ff010113          	addi	sp,sp,-16
    1c10:	00112623          	sw	ra,12(sp)
    1c14:	00812423          	sw	s0,8(sp)
    1c18:	00912223          	sw	s1,4(sp)
    1c1c:	00050413          	mv	s0,a0
    1c20:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
    1c24:	00040513          	mv	a0,s0
    1c28:	f41ff0ef          	jal	1b68 <spi_cmdAvailability>
    1c2c:	fe050ce3          	beqz	a0,1c24 <spi_select+0x18>
        write_u32(slaveId | 0x80 | SPI_CMD_SS, reg + SPI_DATA);
    1c30:	000017b7          	lui	a5,0x1
    1c34:	88078793          	addi	a5,a5,-1920 # 880 <CUSTOM2+0x825>
    1c38:	00f4e4b3          	or	s1,s1,a5
        *((volatile u32*) address) = data;
    1c3c:	00942023          	sw	s1,0(s0)
    }
    1c40:	00c12083          	lw	ra,12(sp)
    1c44:	00812403          	lw	s0,8(sp)
    1c48:	00412483          	lw	s1,4(sp)
    1c4c:	01010113          	addi	sp,sp,16
    1c50:	00008067          	ret

00001c54 <spi_diselect>:
 *
 * @param reg The base address of the SPI register
 * @param slaveId The ID of the slave device to deselect
 *
 ******************************************************************************/  
    static void spi_diselect(u32 reg, u32 slaveId){
    1c54:	ff010113          	addi	sp,sp,-16
    1c58:	00112623          	sw	ra,12(sp)
    1c5c:	00812423          	sw	s0,8(sp)
    1c60:	00912223          	sw	s1,4(sp)
    1c64:	00050413          	mv	s0,a0
    1c68:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
    1c6c:	00040513          	mv	a0,s0
    1c70:	ef9ff0ef          	jal	1b68 <spi_cmdAvailability>
    1c74:	fe050ce3          	beqz	a0,1c6c <spi_diselect+0x18>
        write_u32(slaveId | 0x00 | SPI_CMD_SS, reg + SPI_DATA);
    1c78:	000017b7          	lui	a5,0x1
    1c7c:	80078793          	addi	a5,a5,-2048 # 800 <CUSTOM2+0x7a5>
    1c80:	00f4e4b3          	or	s1,s1,a5
    1c84:	00942023          	sw	s1,0(s0)
    }
    1c88:	00c12083          	lw	ra,12(sp)
    1c8c:	00812403          	lw	s0,8(sp)
    1c90:	00412483          	lw	s1,4(sp)
    1c94:	01010113          	addi	sp,sp,16
    1c98:	00008067          	ret

00001c9c <spi_applyConfig>:
 * @param reg The base address of the SPI register
 * @param config Pointer to a Spi_Config structure containing the configuration settings
 *
 ******************************************************************************/
    static void spi_applyConfig(u32 reg, Spi_Config *config){
        write_u32((config->cpol << 0) | (config->cpha << 1) | (config->mode << 4), reg + SPI_CONFIG);
    1c9c:	0005a783          	lw	a5,0(a1)
    1ca0:	0045a703          	lw	a4,4(a1)
    1ca4:	00171713          	slli	a4,a4,0x1
    1ca8:	00e7e7b3          	or	a5,a5,a4
    1cac:	0085a703          	lw	a4,8(a1)
    1cb0:	00471713          	slli	a4,a4,0x4
    1cb4:	00e7e7b3          	or	a5,a5,a4
    1cb8:	00f52423          	sw	a5,8(a0)
        write_u32(config->clkDivider, reg + SPI_CLK_DIVIDER);
    1cbc:	00c5a783          	lw	a5,12(a1)
    1cc0:	02f52023          	sw	a5,32(a0)
        write_u32(config->ssSetup, reg + SPI_SS_SETUP);
    1cc4:	0105a783          	lw	a5,16(a1)
    1cc8:	02f52223          	sw	a5,36(a0)
        write_u32(config->ssHold, reg + SPI_SS_HOLD);
    1ccc:	0145a783          	lw	a5,20(a1)
    1cd0:	02f52423          	sw	a5,40(a0)
        write_u32(config->ssDisable, reg + SPI_SS_DISABLE);
    1cd4:	0185a783          	lw	a5,24(a1)
    1cd8:	02f52623          	sw	a5,44(a0)
    }
    1cdc:	00008067          	ret

00001ce0 <spi_waitXferBusy>:
* @brief This function wait for SPI Transfer to complete.
    * 
    * @param reg SPI base address 
*
******************************************************************************/
    static void spi_waitXferBusy(u32 reg){
    1ce0:	ff010113          	addi	sp,sp,-16
    1ce4:	00112623          	sw	ra,12(sp)
    1ce8:	00812423          	sw	s0,8(sp)
    1cec:	00050413          	mv	s0,a0

#ifdef SYSTEM_SPI_2_IO_CTRL
    	if(reg == SYSTEM_SPI_2_IO_CTRL) cmdFifo_depth = SYSTEM_SPI_2_IO_PARAMETER_CMD_FIFO_DEPTH;
#endif

    	bsp_uDelay(1);
    1cf0:	f8b00637          	lui	a2,0xf8b00
    1cf4:	05f5e5b7          	lui	a1,0x5f5e
    1cf8:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5f435f0>
    1cfc:	00100513          	li	a0,1
    1d00:	bcdff0ef          	jal	18cc <clint_uDelay>
    	while(spi_cmdAvailability(reg) != cmdFifo_depth);
    1d04:	00040513          	mv	a0,s0
    1d08:	e61ff0ef          	jal	1b68 <spi_cmdAvailability>
    1d0c:	10000793          	li	a5,256
    1d10:	fef51ae3          	bne	a0,a5,1d04 <spi_waitXferBusy+0x24>
    }
    1d14:	00c12083          	lw	ra,12(sp)
    1d18:	00812403          	lw	s0,8(sp)
    1d1c:	01010113          	addi	sp,sp,16
    1d20:	00008067          	ret

00001d24 <spiFlash_select>:
    * @param spi SPI port base address 
    * @param cs 32-bit bitwise setting. Set 1 to enable particular bit. 
*
******************************************************************************/

    static void spiFlash_select(u32 spi, u32 cs){
    1d24:	ff010113          	addi	sp,sp,-16
    1d28:	00112623          	sw	ra,12(sp)
        spi_select(spi, cs);
    1d2c:	ee1ff0ef          	jal	1c0c <spi_select>
    }
    1d30:	00c12083          	lw	ra,12(sp)
    1d34:	01010113          	addi	sp,sp,16
    1d38:	00008067          	ret

00001d3c <spiFlash_diselect>:
    * 
    * @param spi SPI port base address 
    * @param cs 32-bit bitwise setting. Set 1 to disable particular bit. 
*
******************************************************************************/
    static void spiFlash_diselect(u32 spi, u32 cs){
    1d3c:	ff010113          	addi	sp,sp,-16
    1d40:	00112623          	sw	ra,12(sp)
        spi_diselect(spi, cs);
    1d44:	f11ff0ef          	jal	1c54 <spi_diselect>
    }
    1d48:	00c12083          	lw	ra,12(sp)
    1d4c:	01010113          	addi	sp,sp,16
    1d50:	00008067          	ret

00001d54 <spiFlash_init_>:
* @brief This function initialize SPI port with default settings
    * 
    * @param spi SPI port base address
*
******************************************************************************/
    static void spiFlash_init_(u32 spi){
    1d54:	fd010113          	addi	sp,sp,-48
    1d58:	02112623          	sw	ra,44(sp)
    1d5c:	02812423          	sw	s0,40(sp)
    1d60:	00050413          	mv	s0,a0
        Spi_Config spiCfg;
        spiCfg.cpol = 0;
    1d64:	00012223          	sw	zero,4(sp)
        spiCfg.cpha = 0;
    1d68:	00012423          	sw	zero,8(sp)
        spiCfg.mode = 0;
    1d6c:	00012623          	sw	zero,12(sp)
        spiCfg.clkDivider = 2;
    1d70:	00200793          	li	a5,2
    1d74:	00f12823          	sw	a5,16(sp)
        spiCfg.ssSetup = 5;
    1d78:	00500713          	li	a4,5
    1d7c:	00e12a23          	sw	a4,20(sp)
        spiCfg.ssHold = 2;
    1d80:	00f12c23          	sw	a5,24(sp)
        spiCfg.ssDisable = 7;
    1d84:	00700793          	li	a5,7
    1d88:	00f12e23          	sw	a5,28(sp)
        spi_applyConfig(spi, &spiCfg);
    1d8c:	00410593          	addi	a1,sp,4
    1d90:	f0dff0ef          	jal	1c9c <spi_applyConfig>
        spi_waitXferBusy(spi); 
    1d94:	00040513          	mv	a0,s0
    1d98:	f49ff0ef          	jal	1ce0 <spi_waitXferBusy>
    }
    1d9c:	02c12083          	lw	ra,44(sp)
    1da0:	02812403          	lw	s0,40(sp)
    1da4:	03010113          	addi	sp,sp,48
    1da8:	00008067          	ret

00001dac <spiFlash_init>:
    * @param spi SPI port base address
    * @param gpio GPIO port base address 
    * @param cs 32-bit bitwise chip select setting.
*
******************************************************************************/
    static void spiFlash_init(u32 spi, u32 cs){
    1dac:	ff010113          	addi	sp,sp,-16
    1db0:	00112623          	sw	ra,12(sp)
    1db4:	00812423          	sw	s0,8(sp)
    1db8:	00912223          	sw	s1,4(sp)
    1dbc:	00050413          	mv	s0,a0
    1dc0:	00058493          	mv	s1,a1
        spiFlash_init_(spi);
    1dc4:	f91ff0ef          	jal	1d54 <spiFlash_init_>
        spiFlash_diselect(spi, cs);
    1dc8:	00048593          	mv	a1,s1
    1dcc:	00040513          	mv	a0,s0
    1dd0:	f6dff0ef          	jal	1d3c <spiFlash_diselect>
    }
    1dd4:	00c12083          	lw	ra,12(sp)
    1dd8:	00812403          	lw	s0,8(sp)
    1ddc:	00412483          	lw	s1,4(sp)
    1de0:	01010113          	addi	sp,sp,16
    1de4:	00008067          	ret

00001de8 <spiFlash_manufacturer_id_>:
    *
    * @param spi SPI port base address
    * @param cs 32-bit bitwise chip select setting.
*
******************************************************************************/
    static inline u8 spiFlash_manufacturer_id_(u32 spi, u32 cs){
    1de8:	ff010113          	addi	sp,sp,-16
    1dec:	00112623          	sw	ra,12(sp)
    1df0:	00812423          	sw	s0,8(sp)
    1df4:	00050413          	mv	s0,a0
#if defined(GD25_FLASH)
        spi_write(spi, 0x9E);
#else
        spi_write(spi, READ_MANUFACTURER);
    1df8:	09f00593          	li	a1,159
    1dfc:	d89ff0ef          	jal	1b84 <spi_write>
        // spi_write(spi, 0x00);
        // spi_write(spi, 0x00);
        // spi_write(spi, 0x00);
#endif
        u8 mid = spi_read(spi);
    1e00:	00040513          	mv	a0,s0
    1e04:	dc1ff0ef          	jal	1bc4 <spi_read>
    1e08:	00050413          	mv	s0,a0
        bsp_uDelay(300);
    1e0c:	f8b00637          	lui	a2,0xf8b00
    1e10:	05f5e5b7          	lui	a1,0x5f5e
    1e14:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5f435f0>
    1e18:	12c00513          	li	a0,300
    1e1c:	ab1ff0ef          	jal	18cc <clint_uDelay>
        return mid;
    }
    1e20:	00040513          	mv	a0,s0
    1e24:	00c12083          	lw	ra,12(sp)
    1e28:	00812403          	lw	s0,8(sp)
    1e2c:	01010113          	addi	sp,sp,16
    1e30:	00008067          	ret

00001e34 <spiFlash_wake_>:
*        start communicating with the device.
    * 
    * @param spi SPI port base address
*
******************************************************************************/
    static void spiFlash_wake_(u32 spi){
    1e34:	ff010113          	addi	sp,sp,-16
    1e38:	00112623          	sw	ra,12(sp)
        spi_write(spi, 0xAB);        
    1e3c:	0ab00593          	li	a1,171
    1e40:	d45ff0ef          	jal	1b84 <spi_write>
    }
    1e44:	00c12083          	lw	ra,12(sp)
    1e48:	01010113          	addi	sp,sp,16
    1e4c:	00008067          	ret

00001e50 <spiFlash_exit4ByteAddr_>:
    * @param spi SPI port base address
    * @param cs 32-bit bitwise chip select setting
    * @param mid 8-bit SPI Flash Manufacturer ID.
*
******************************************************************************/
    static void spiFlash_exit4ByteAddr_(u32 spi, u32 cs, u8 mid){
    1e50:	ff010113          	addi	sp,sp,-16
    1e54:	00112623          	sw	ra,12(sp)
        switch(mid){
    1e58:	09d00793          	li	a5,157
    1e5c:	00f60c63          	beq	a2,a5,1e74 <spiFlash_exit4ByteAddr_+0x24>
            case 0x9D: 
                spi_write(spi, 0x29);
                break; 
            default: 
                spi_write(spi, 0xE9);
    1e60:	0e900593          	li	a1,233
    1e64:	d21ff0ef          	jal	1b84 <spi_write>
                break; 
        }
    }
    1e68:	00c12083          	lw	ra,12(sp)
    1e6c:	01010113          	addi	sp,sp,16
    1e70:	00008067          	ret
                spi_write(spi, 0x29);
    1e74:	02900593          	li	a1,41
    1e78:	d0dff0ef          	jal	1b84 <spi_write>
                break; 
    1e7c:	fedff06f          	j	1e68 <spiFlash_exit4ByteAddr_+0x18>

00001e80 <spiFlash_exit4ByteAddr>:
*
* @param spi SPI port base address
* @param cs 32-bit bitwise chip select setting
*
******************************************************************************/
    static void spiFlash_exit4ByteAddr(u32 spi, u32 cs){
    1e80:	ff010113          	addi	sp,sp,-16
    1e84:	00112623          	sw	ra,12(sp)
    1e88:	00812423          	sw	s0,8(sp)
    1e8c:	00912223          	sw	s1,4(sp)
    1e90:	01212023          	sw	s2,0(sp)
    1e94:	00050413          	mv	s0,a0
    1e98:	00058493          	mv	s1,a1
        spiFlash_select(spi,cs);
    1e9c:	e89ff0ef          	jal	1d24 <spiFlash_select>
        u8 mid = spiFlash_manufacturer_id_(spi, cs); 
    1ea0:	00048593          	mv	a1,s1
    1ea4:	00040513          	mv	a0,s0
    1ea8:	f41ff0ef          	jal	1de8 <spiFlash_manufacturer_id_>
    1eac:	00050913          	mv	s2,a0
        spiFlash_diselect(spi,cs);
    1eb0:	00048593          	mv	a1,s1
    1eb4:	00040513          	mv	a0,s0
    1eb8:	e85ff0ef          	jal	1d3c <spiFlash_diselect>
        spi_waitXferBusy(spi);
    1ebc:	00040513          	mv	a0,s0
    1ec0:	e21ff0ef          	jal	1ce0 <spi_waitXferBusy>
        spiFlash_select(spi,cs);
    1ec4:	00048593          	mv	a1,s1
    1ec8:	00040513          	mv	a0,s0
    1ecc:	e59ff0ef          	jal	1d24 <spiFlash_select>
        spiFlash_exit4ByteAddr_(spi, cs, mid); 
    1ed0:	00090613          	mv	a2,s2
    1ed4:	00048593          	mv	a1,s1
    1ed8:	00040513          	mv	a0,s0
    1edc:	f75ff0ef          	jal	1e50 <spiFlash_exit4ByteAddr_>
        spiFlash_diselect(spi,cs);
    1ee0:	00048593          	mv	a1,s1
    1ee4:	00040513          	mv	a0,s0
    1ee8:	e55ff0ef          	jal	1d3c <spiFlash_diselect>
        spi_waitXferBusy(spi);
    1eec:	00040513          	mv	a0,s0
    1ef0:	df1ff0ef          	jal	1ce0 <spi_waitXferBusy>
    }
    1ef4:	00c12083          	lw	ra,12(sp)
    1ef8:	00812403          	lw	s0,8(sp)
    1efc:	00412483          	lw	s1,4(sp)
    1f00:	00012903          	lw	s2,0(sp)
    1f04:	01010113          	addi	sp,sp,16
    1f08:	00008067          	ret

00001f0c <spiFlash_wake>:
*
* @param spi SPI port base address
* @param cs 32-bit bitwise chip select setting.
*
******************************************************************************/
    static void spiFlash_wake(u32 spi, u32 cs){
    1f0c:	ff010113          	addi	sp,sp,-16
    1f10:	00112623          	sw	ra,12(sp)
    1f14:	00812423          	sw	s0,8(sp)
    1f18:	00912223          	sw	s1,4(sp)
    1f1c:	00050413          	mv	s0,a0
    1f20:	00058493          	mv	s1,a1
        spiFlash_select(spi,cs);
    1f24:	e01ff0ef          	jal	1d24 <spiFlash_select>
        spiFlash_wake_(spi);
    1f28:	00040513          	mv	a0,s0
    1f2c:	f09ff0ef          	jal	1e34 <spiFlash_wake_>
        spiFlash_diselect(spi,cs);
    1f30:	00048593          	mv	a1,s1
    1f34:	00040513          	mv	a0,s0
    1f38:	e05ff0ef          	jal	1d3c <spiFlash_diselect>
        spi_waitXferBusy(spi);
    1f3c:	00040513          	mv	a0,s0
    1f40:	da1ff0ef          	jal	1ce0 <spi_waitXferBusy>
        bsp_uDelay(100); // make sure the Flash fully awake
    1f44:	f8b00637          	lui	a2,0xf8b00
    1f48:	05f5e5b7          	lui	a1,0x5f5e
    1f4c:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5f435f0>
    1f50:	06400513          	li	a0,100
    1f54:	979ff0ef          	jal	18cc <clint_uDelay>
    }
    1f58:	00c12083          	lw	ra,12(sp)
    1f5c:	00812403          	lw	s0,8(sp)
    1f60:	00412483          	lw	s1,4(sp)
    1f64:	01010113          	addi	sp,sp,16
    1f68:	00008067          	ret

00001f6c <spiFlash_f2m_>:
    * @param flashAddress The flash address to read the data
    * @param memoryAddress The RAM address to write the data
    * @param size The size of data to copy
*
******************************************************************************/
    static void spiFlash_f2m_(u32 spi, u32 flashAddress, u32 memoryAddress, u32 size){
    1f6c:	fe010113          	addi	sp,sp,-32
    1f70:	00112e23          	sw	ra,28(sp)
    1f74:	00812c23          	sw	s0,24(sp)
    1f78:	00912a23          	sw	s1,20(sp)
    1f7c:	01212823          	sw	s2,16(sp)
    1f80:	01312623          	sw	s3,12(sp)
    1f84:	00050913          	mv	s2,a0
    1f88:	00058493          	mv	s1,a1
    1f8c:	00060413          	mv	s0,a2
    1f90:	00068993          	mv	s3,a3
        spi_write(spi, 0x0B);
    1f94:	00b00593          	li	a1,11
    1f98:	bedff0ef          	jal	1b84 <spi_write>
        spi_write(spi, flashAddress >> 16);
    1f9c:	0104d593          	srli	a1,s1,0x10
    1fa0:	0ff5f593          	zext.b	a1,a1
    1fa4:	00090513          	mv	a0,s2
    1fa8:	bddff0ef          	jal	1b84 <spi_write>
        spi_write(spi, flashAddress >>  8);
    1fac:	0084d593          	srli	a1,s1,0x8
    1fb0:	0ff5f593          	zext.b	a1,a1
    1fb4:	00090513          	mv	a0,s2
    1fb8:	bcdff0ef          	jal	1b84 <spi_write>
        spi_write(spi, flashAddress >>  0);
    1fbc:	0ff4f593          	zext.b	a1,s1
    1fc0:	00090513          	mv	a0,s2
    1fc4:	bc1ff0ef          	jal	1b84 <spi_write>
        spi_write(spi, 0);
    1fc8:	00000593          	li	a1,0
    1fcc:	00090513          	mv	a0,s2
    1fd0:	bb5ff0ef          	jal	1b84 <spi_write>
        uint8_t *ram = (uint8_t *) memoryAddress;
        for(u32 idx = 0;idx < size;idx++){
    1fd4:	00000493          	li	s1,0
    1fd8:	0180006f          	j	1ff0 <spiFlash_f2m_+0x84>
            u8 value = spi_read(spi);
    1fdc:	00090513          	mv	a0,s2
    1fe0:	be5ff0ef          	jal	1bc4 <spi_read>
            *ram++ = value;
    1fe4:	00a40023          	sb	a0,0(s0)
        for(u32 idx = 0;idx < size;idx++){
    1fe8:	00148493          	addi	s1,s1,1
            *ram++ = value;
    1fec:	00140413          	addi	s0,s0,1
        for(u32 idx = 0;idx < size;idx++){
    1ff0:	ff34e6e3          	bltu	s1,s3,1fdc <spiFlash_f2m_+0x70>
        }
    }
    1ff4:	01c12083          	lw	ra,28(sp)
    1ff8:	01812403          	lw	s0,24(sp)
    1ffc:	01412483          	lw	s1,20(sp)
    2000:	01012903          	lw	s2,16(sp)
    2004:	00c12983          	lw	s3,12(sp)
    2008:	02010113          	addi	sp,sp,32
    200c:	00008067          	ret

00002010 <spiFlash_f2m>:
* @param flashAddress The flash address to read the data
* @param memoryAddress The RAM address to write the data
* @param size The size of data to copy
*
******************************************************************************/
    static void spiFlash_f2m(u32 spi, u32 cs, u32 flashAddress, u32 memoryAddress, u32 size){
    2010:	fe010113          	addi	sp,sp,-32
    2014:	00112e23          	sw	ra,28(sp)
    2018:	00812c23          	sw	s0,24(sp)
    201c:	00912a23          	sw	s1,20(sp)
    2020:	01212823          	sw	s2,16(sp)
    2024:	01312623          	sw	s3,12(sp)
    2028:	01412423          	sw	s4,8(sp)
    202c:	00050413          	mv	s0,a0
    2030:	00058493          	mv	s1,a1
    2034:	00060913          	mv	s2,a2
    2038:	00068993          	mv	s3,a3
    203c:	00070a13          	mv	s4,a4
        spiFlash_select(spi,cs);
    2040:	ce5ff0ef          	jal	1d24 <spiFlash_select>
        spiFlash_f2m_(spi, flashAddress, memoryAddress, size);
    2044:	000a0693          	mv	a3,s4
    2048:	00098613          	mv	a2,s3
    204c:	00090593          	mv	a1,s2
    2050:	00040513          	mv	a0,s0
    2054:	f19ff0ef          	jal	1f6c <spiFlash_f2m_>
        spiFlash_diselect(spi,cs);
    2058:	00048593          	mv	a1,s1
    205c:	00040513          	mv	a0,s0
    2060:	cddff0ef          	jal	1d3c <spiFlash_diselect>
    }
    2064:	01c12083          	lw	ra,28(sp)
    2068:	01812403          	lw	s0,24(sp)
    206c:	01412483          	lw	s1,20(sp)
    2070:	01012903          	lw	s2,16(sp)
    2074:	00c12983          	lw	s3,12(sp)
    2078:	00812a03          	lw	s4,8(sp)
    207c:	02010113          	addi	sp,sp,32
    2080:	00008067          	ret

00002084 <attr_word>:
    return ((uint32_t)(blend & 0xFu) << 0)
    2084:	00f57513          	andi	a0,a0,15
         | ((uint32_t)(fmt   & 0x3u) << 4)
    2088:	00459593          	slli	a1,a1,0x4
    208c:	0305f593          	andi	a1,a1,48
    2090:	00b56533          	or	a0,a0,a1
         | ((uint32_t)(ga    & 0xFFu) << 6)
    2094:	00661613          	slli	a2,a2,0x6
    2098:	000047b7          	lui	a5,0x4
    209c:	fc078793          	addi	a5,a5,-64 # 3fc0 <add565+0x78>
    20a0:	00f67633          	and	a2,a2,a5
    20a4:	00c56533          	or	a0,a0,a2
         | ((uint32_t)(flags & 0x3u) << 24);
    20a8:	01869693          	slli	a3,a3,0x18
    20ac:	030007b7          	lui	a5,0x3000
    20b0:	00f6f6b3          	and	a3,a3,a5
}
    20b4:	00d56533          	or	a0,a0,a3
    20b8:	00008067          	ret

000020bc <attr_blend>:
static unsigned attr_blend(uint32_t w) { return (unsigned)(w & 0xFu); }
    20bc:	00f57513          	andi	a0,a0,15
    20c0:	00008067          	ret

000020c4 <attr_fmt>:
static unsigned attr_fmt(uint32_t w)   { return (unsigned)((w >> 4) & 0x3u); }
    20c4:	00455513          	srli	a0,a0,0x4
    20c8:	00357513          	andi	a0,a0,3
    20cc:	00008067          	ret

000020d0 <attr_ga>:
static unsigned attr_ga(uint32_t w)    { return (unsigned)((w >> 6) & 0xFFu); }
    20d0:	00655513          	srli	a0,a0,0x6
    20d4:	0ff57513          	zext.b	a0,a0
    20d8:	00008067          	ret

000020dc <attr_flags>:
static unsigned attr_flags(uint32_t w) { return (unsigned)((w >> 24) & 0x3u); }
    20dc:	01855513          	srli	a0,a0,0x18
    20e0:	00357513          	andi	a0,a0,3
    20e4:	00008067          	ret

000020e8 <bulm_eff_name>:
    if (g_bulm == BULM_ADD && !g_glow) return g_bulm_name[BULM_KEY];
    20e8:	8381a703          	lw	a4,-1992(gp) # 8cb0 <g_bulm>
    20ec:	00200793          	li	a5,2
    20f0:	00f70e63          	beq	a4,a5,210c <bulm_eff_name+0x24>
    return g_bulm_name[g_bulm];
    20f4:	000097b7          	lui	a5,0x9
    20f8:	00271713          	slli	a4,a4,0x2
    20fc:	b5478793          	addi	a5,a5,-1196 # 8b54 <g_bulm_name>
    2100:	00e787b3          	add	a5,a5,a4
    2104:	0007a503          	lw	a0,0(a5)
    2108:	00008067          	ret
    if (g_bulm == BULM_ADD && !g_glow) return g_bulm_name[BULM_KEY];
    210c:	8fc1a783          	lw	a5,-1796(gp) # 8d74 <g_glow>
    2110:	fe0792e3          	bnez	a5,20f4 <bulm_eff_name+0xc>
    2114:	00007537          	lui	a0,0x7
    2118:	27450513          	addi	a0,a0,628 # 7274 <_data+0x28>
}
    211c:	00008067          	ret

00002120 <player_pal>:
    switch (c) {
    2120:	fbf50513          	addi	a0,a0,-65
    2124:	0ff57713          	zext.b	a4,a0
    2128:	00400793          	li	a5,4
    212c:	04e7e463          	bltu	a5,a4,2174 <player_pal+0x54>
    2130:	00271513          	slli	a0,a4,0x2
    2134:	000087b7          	lui	a5,0x8
    2138:	66078793          	addi	a5,a5,1632 # 8660 <_data+0x1414>
    213c:	00f50533          	add	a0,a0,a5
    2140:	00052783          	lw	a5,0(a0)
    2144:	00078067          	jr	a5
    2148:	00009537          	lui	a0,0x9
    214c:	edf50513          	addi	a0,a0,-289 # 8edf <g_star+0x123>
    2150:	00008067          	ret
    case 'C': return 0x0064u;
    2154:	06400513          	li	a0,100
    2158:	00008067          	ret
    case 'D': return 0xF7FFu;
    215c:	0000f537          	lui	a0,0xf
    2160:	7ff50513          	addi	a0,a0,2047 # f7ff <__global_pointer$+0x6387>
    2164:	00008067          	ret
    case 'E': return 0xCFDFu;
    2168:	0000d537          	lui	a0,0xd
    216c:	fdf50513          	addi	a0,a0,-33 # cfdf <__global_pointer$+0x3b67>
    2170:	00008067          	ret
    default:    return TRANS_KEY;
    2174:	00000513          	li	a0,0
    2178:	00008067          	ret
    case 'B': return 0x2314u;
    217c:	00002537          	lui	a0,0x2
    2180:	31450513          	addi	a0,a0,788 # 2314 <spr_glow+0x68>
}
    2184:	00008067          	ret

00002188 <spr_player>:
    if (i < 0 || i >= SZ_PR || j < 0 || j >= SZ_PR) return TRANS_KEY;
    2188:	01f00793          	li	a5,31
    218c:	04a7e063          	bltu	a5,a0,21cc <spr_player+0x44>
    2190:	0405c263          	bltz	a1,21d4 <spr_player+0x4c>
    2194:	04b7c463          	blt	a5,a1,21dc <spr_player+0x54>
{
    2198:	ff010113          	addi	sp,sp,-16
    219c:	00112623          	sw	ra,12(sp)
    return player_pal(g_player_px[j][i]);
    21a0:	000097b7          	lui	a5,0x9
    21a4:	00259593          	slli	a1,a1,0x2
    21a8:	ac478793          	addi	a5,a5,-1340 # 8ac4 <g_player_px>
    21ac:	00b787b3          	add	a5,a5,a1
    21b0:	0007a783          	lw	a5,0(a5)
    21b4:	00a787b3          	add	a5,a5,a0
    21b8:	0007c503          	lbu	a0,0(a5)
    21bc:	f65ff0ef          	jal	2120 <player_pal>
}
    21c0:	00c12083          	lw	ra,12(sp)
    21c4:	01010113          	addi	sp,sp,16
    21c8:	00008067          	ret
    if (i < 0 || i >= SZ_PR || j < 0 || j >= SZ_PR) return TRANS_KEY;
    21cc:	00000513          	li	a0,0
    21d0:	00008067          	ret
    21d4:	00000513          	li	a0,0
    21d8:	00008067          	ret
    21dc:	00000513          	li	a0,0
}
    21e0:	00008067          	ret

000021e4 <enemy_pal>:
    switch (c) {
    21e4:	fbf50513          	addi	a0,a0,-65
    21e8:	0ff57713          	zext.b	a4,a0
    21ec:	00400793          	li	a5,4
    21f0:	04e7e663          	bltu	a5,a4,223c <enemy_pal+0x58>
    21f4:	00271513          	slli	a0,a4,0x2
    21f8:	000087b7          	lui	a5,0x8
    21fc:	67478793          	addi	a5,a5,1652 # 8674 <_data+0x1428>
    2200:	00f50533          	add	a0,a0,a5
    2204:	00052783          	lw	a5,0(a0)
    2208:	00078067          	jr	a5
    220c:	0000f537          	lui	a0,0xf
    2210:	a4750513          	addi	a0,a0,-1465 # ea47 <__global_pointer$+0x55cf>
    2214:	00008067          	ret
    case 'C': return 0x3842u;
    2218:	00004537          	lui	a0,0x4
    221c:	84250513          	addi	a0,a0,-1982 # 3842 <dl_bullet+0x7a>
    2220:	00008067          	ret
    case 'D': return 0xFED8u;
    2224:	00010537          	lui	a0,0x10
    2228:	ed850513          	addi	a0,a0,-296 # fed8 <__global_pointer$+0x6a60>
    222c:	00008067          	ret
    case 'E': return 0x8F9Fu;
    2230:	00009537          	lui	a0,0x9
    2234:	f9f50513          	addi	a0,a0,-97 # 8f9f <g_star+0x1e3>
    2238:	00008067          	ret
    default:    return TRANS_KEY;
    223c:	00000513          	li	a0,0
    2240:	00008067          	ret
    case 'B': return 0xA8E5u;
    2244:	0000b537          	lui	a0,0xb
    2248:	8e550513          	addi	a0,a0,-1819 # a8e5 <__global_pointer$+0x146d>
}
    224c:	00008067          	ret

00002250 <spr_enemy>:
    if (i < 0 || i >= SZ_EN || j < 0 || j >= SZ_EN) return TRANS_KEY;
    2250:	01f00793          	li	a5,31
    2254:	04a7e063          	bltu	a5,a0,2294 <spr_enemy+0x44>
    2258:	0405c263          	bltz	a1,229c <spr_enemy+0x4c>
    225c:	04b7c463          	blt	a5,a1,22a4 <spr_enemy+0x54>
{
    2260:	ff010113          	addi	sp,sp,-16
    2264:	00112623          	sw	ra,12(sp)
    return enemy_pal(g_enemy_px[j][i]);
    2268:	000097b7          	lui	a5,0x9
    226c:	00259593          	slli	a1,a1,0x2
    2270:	a4478793          	addi	a5,a5,-1468 # 8a44 <g_enemy_px>
    2274:	00b787b3          	add	a5,a5,a1
    2278:	0007a783          	lw	a5,0(a5)
    227c:	00a787b3          	add	a5,a5,a0
    2280:	0007c503          	lbu	a0,0(a5)
    2284:	f61ff0ef          	jal	21e4 <enemy_pal>
}
    2288:	00c12083          	lw	ra,12(sp)
    228c:	01010113          	addi	sp,sp,16
    2290:	00008067          	ret
    if (i < 0 || i >= SZ_EN || j < 0 || j >= SZ_EN) return TRANS_KEY;
    2294:	00000513          	li	a0,0
    2298:	00008067          	ret
    229c:	00000513          	li	a0,0
    22a0:	00008067          	ret
    22a4:	00000513          	li	a0,0
}
    22a8:	00008067          	ret

000022ac <spr_glow>:
    int dx = i * 2 - n + 1;
    22ac:	00151793          	slli	a5,a0,0x1
    22b0:	ff178793          	addi	a5,a5,-15
    int dy = j * 2 - n + 1;
    22b4:	00159593          	slli	a1,a1,0x1
    22b8:	ff158593          	addi	a1,a1,-15
    int d2 = dx * dx + dy * dy;
    22bc:	02f787b3          	mul	a5,a5,a5
    22c0:	02b585b3          	mul	a1,a1,a1
    22c4:	00b787b3          	add	a5,a5,a1
    if (d2 >= r2) return TRANS_KEY;
    22c8:	0ff00713          	li	a4,255
    22cc:	08f74863          	blt	a4,a5,235c <spr_glow+0xb0>
    t  = (unsigned)((d2 * 255) / r2);          /* 0 圆心 .. 255 边缘 */
    22d0:	00879713          	slli	a4,a5,0x8
    22d4:	40f70733          	sub	a4,a4,a5
    22d8:	41f75793          	srai	a5,a4,0x1f
    22dc:	0ff7f793          	zext.b	a5,a5
    22e0:	00e787b3          	add	a5,a5,a4
    22e4:	4087d793          	srai	a5,a5,0x8
    i8 = 255u - t;
    22e8:	0ff00713          	li	a4,255
    22ec:	40f707b3          	sub	a5,a4,a5
    i8 = (i8 * i8) / 255u;                     /* 平方衰减：中心亮、边缘柔 */
    22f0:	02f787b3          	mul	a5,a5,a5
    22f4:	02e7d733          	divu	a4,a5,a4
    if (i8 < 32u) return TRANS_KEY;
    22f8:	000026b7          	lui	a3,0x2
    22fc:	fdf68693          	addi	a3,a3,-33 # 1fdf <spiFlash_f2m_+0x73>
    2300:	06f6f263          	bgeu	a3,a5,2364 <spr_glow+0xb8>
    r = (unsigned)(((base >> 11) & 0x1Fu) * i8 / 255u);
    2304:	00b65513          	srli	a0,a2,0xb
    2308:	02e50533          	mul	a0,a0,a4
    230c:	0ff00693          	li	a3,255
    2310:	02d55533          	divu	a0,a0,a3
    g = (unsigned)(((base >>  5) & 0x3Fu) * i8 / 255u);
    2314:	00565793          	srli	a5,a2,0x5
    2318:	03f7f793          	andi	a5,a5,63
    231c:	02e787b3          	mul	a5,a5,a4
    2320:	02d7d7b3          	divu	a5,a5,a3
    b = (unsigned)(( base        & 0x1Fu) * i8 / 255u);
    2324:	01f67613          	andi	a2,a2,31
    2328:	02e60633          	mul	a2,a2,a4
    232c:	02d65633          	divu	a2,a2,a3
    return (uint16_t)((r << 11) | (g << 5) | b);
    2330:	00b51513          	slli	a0,a0,0xb
    2334:	01051513          	slli	a0,a0,0x10
    2338:	01055513          	srli	a0,a0,0x10
    233c:	00579793          	slli	a5,a5,0x5
    2340:	01079793          	slli	a5,a5,0x10
    2344:	0107d793          	srli	a5,a5,0x10
    2348:	00f56533          	or	a0,a0,a5
    234c:	00c56533          	or	a0,a0,a2
    2350:	01051513          	slli	a0,a0,0x10
    2354:	01055513          	srli	a0,a0,0x10
    2358:	00008067          	ret
    if (d2 >= r2) return TRANS_KEY;
    235c:	00000513          	li	a0,0
    2360:	00008067          	ret
    if (i8 < 32u) return TRANS_KEY;
    2364:	00000513          	li	a0,0
}
    2368:	00008067          	ret

0000236c <spr_pixel>:
{
    236c:	ff010113          	addi	sp,sp,-16
    2370:	00112623          	sw	ra,12(sp)
    2374:	00050793          	mv	a5,a0
    2378:	00058513          	mv	a0,a1
    237c:	00060593          	mv	a1,a2
    switch (id) {
    2380:	00600713          	li	a4,6
    2384:	06f76c63          	bltu	a4,a5,23fc <spr_pixel+0x90>
    2388:	00279793          	slli	a5,a5,0x2
    238c:	00008737          	lui	a4,0x8
    2390:	68870713          	addi	a4,a4,1672 # 8688 <_data+0x143c>
    2394:	00e787b3          	add	a5,a5,a4
    2398:	0007a783          	lw	a5,0(a5)
    239c:	00078067          	jr	a5
    case S_PR: return spr_player(i, j);
    23a0:	de9ff0ef          	jal	2188 <spr_player>
}
    23a4:	00c12083          	lw	ra,12(sp)
    23a8:	01010113          	addi	sp,sp,16
    23ac:	00008067          	ret
    case S_EN: return spr_enemy(i, j);
    23b0:	ea1ff0ef          	jal	2250 <spr_enemy>
    23b4:	ff1ff06f          	j	23a4 <spr_pixel+0x38>
    case S_SH: return spr_glow(i, j, COL_CYAN);
    23b8:	7ff00613          	li	a2,2047
    23bc:	ef1ff0ef          	jal	22ac <spr_glow>
    23c0:	fe5ff06f          	j	23a4 <spr_pixel+0x38>
    case S_B0: return spr_glow(i, j, 0xF81Fu);
    23c4:	00010637          	lui	a2,0x10
    23c8:	81f60613          	addi	a2,a2,-2017 # f81f <__global_pointer$+0x63a7>
    23cc:	ee1ff0ef          	jal	22ac <spr_glow>
    23d0:	fd5ff06f          	j	23a4 <spr_pixel+0x38>
    case S_B1: return spr_glow(i, j, 0x07FFu);
    23d4:	7ff00613          	li	a2,2047
    23d8:	ed5ff0ef          	jal	22ac <spr_glow>
    23dc:	fc9ff06f          	j	23a4 <spr_pixel+0x38>
    case S_B2: return spr_glow(i, j, COL_AMBER);
    23e0:	00010637          	lui	a2,0x10
    23e4:	d2060613          	addi	a2,a2,-736 # fd20 <__global_pointer$+0x68a8>
    23e8:	ec5ff0ef          	jal	22ac <spr_glow>
    23ec:	fb9ff06f          	j	23a4 <spr_pixel+0x38>
    case S_B3: return spr_glow(i, j, COL_GREEN);
    23f0:	7e000613          	li	a2,2016
    23f4:	eb9ff0ef          	jal	22ac <spr_glow>
    23f8:	fadff06f          	j	23a4 <spr_pixel+0x38>
    default:   return spr_glow(i, j, COL_WHITE);
    23fc:	00010637          	lui	a2,0x10
    2400:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x6b87>
    2404:	ea9ff0ef          	jal	22ac <spr_glow>
    2408:	f9dff06f          	j	23a4 <spr_pixel+0x38>

0000240c <glyph_found>:
    if (c >= 'a' && c <= 'z') c = (char)(c - 'a' + 'A');
    240c:	f9f50793          	addi	a5,a0,-97
    2410:	0ff7f793          	zext.b	a5,a5
    2414:	01900713          	li	a4,25
    2418:	00f76663          	bltu	a4,a5,2424 <glyph_found+0x18>
    241c:	fe050513          	addi	a0,a0,-32
    2420:	0ff57513          	zext.b	a0,a0
    for (i = 0; i < FONT_N; i++) if (g_font[i].c == c) return 1;
    2424:	00000713          	li	a4,0
    2428:	02900793          	li	a5,41
    242c:	02e7c463          	blt	a5,a4,2454 <glyph_found+0x48>
    2430:	000097b7          	lui	a5,0x9
    2434:	00371693          	slli	a3,a4,0x3
    2438:	00e686b3          	add	a3,a3,a4
    243c:	8c878793          	addi	a5,a5,-1848 # 88c8 <g_font>
    2440:	00d787b3          	add	a5,a5,a3
    2444:	0007c783          	lbu	a5,0(a5)
    2448:	00a78a63          	beq	a5,a0,245c <glyph_found+0x50>
    244c:	00170713          	addi	a4,a4,1
    2450:	fd9ff06f          	j	2428 <glyph_found+0x1c>
    return 0;
    2454:	00000513          	li	a0,0
    2458:	00008067          	ret
    for (i = 0; i < FONT_N; i++) if (g_font[i].c == c) return 1;
    245c:	00100513          	li	a0,1
}
    2460:	00008067          	ret

00002464 <glyph_of>:
    if (c >= 'a' && c <= 'z') c = (char)(c - 'a' + 'A');
    2464:	f9f50793          	addi	a5,a0,-97
    2468:	0ff7f793          	zext.b	a5,a5
    246c:	01900713          	li	a4,25
    2470:	00f76663          	bltu	a4,a5,247c <glyph_of+0x18>
    2474:	fe050513          	addi	a0,a0,-32
    2478:	0ff57513          	zext.b	a0,a0
    for (i = 0; i < FONT_N; i++) if (g_font[i].c == c) return g_font[i].r;
    247c:	00000713          	li	a4,0
    2480:	02900793          	li	a5,41
    2484:	02e7ce63          	blt	a5,a4,24c0 <glyph_of+0x5c>
    2488:	000097b7          	lui	a5,0x9
    248c:	00371693          	slli	a3,a4,0x3
    2490:	00e686b3          	add	a3,a3,a4
    2494:	8c878793          	addi	a5,a5,-1848 # 88c8 <g_font>
    2498:	00d787b3          	add	a5,a5,a3
    249c:	0007c783          	lbu	a5,0(a5)
    24a0:	00a78663          	beq	a5,a0,24ac <glyph_of+0x48>
    24a4:	00170713          	addi	a4,a4,1
    24a8:	fd9ff06f          	j	2480 <glyph_of+0x1c>
    24ac:	000097b7          	lui	a5,0x9
    24b0:	8c878793          	addi	a5,a5,-1848 # 88c8 <g_font>
    24b4:	00f68533          	add	a0,a3,a5
    24b8:	00150513          	addi	a0,a0,1
    24bc:	00008067          	ret
    return g_font[0].r;
    24c0:	00009537          	lui	a0,0x9
    24c4:	8c950513          	addi	a0,a0,-1847 # 88c9 <g_font+0x1>
}
    24c8:	00008067          	ret

000024cc <tick32>:
        return *((volatile u32*) address);
    24cc:	f8b0c7b7          	lui	a5,0xf8b0c
    24d0:	ff87a503          	lw	a0,-8(a5) # f8b0bff8 <__freertos_irq_stack_top+0xf8af14e8>
static uint32_t tick32(void) { return clint_getTimeLow(BSP_CLINT); }
    24d4:	00008067          	ret

000024d8 <cpu_backoff>:
    if (n == 0u) return;
    24d8:	00050663          	beqz	a0,24e4 <cpu_backoff+0xc>
    __asm__ __volatile__ (
    24dc:	fff50513          	addi	a0,a0,-1
    24e0:	fe051ee3          	bnez	a0,24dc <cpu_backoff+0x4>
}
    24e4:	00008067          	ret

000024e8 <blt_wr>:
static void     blt_wr(uint32_t off, uint32_t v) { *(volatile uint32_t *)(BLT_BASE + off) = v; }
    24e8:	f81007b7          	lui	a5,0xf8100
    24ec:	00f50533          	add	a0,a0,a5
    24f0:	00b52023          	sw	a1,0(a0)
    24f4:	00008067          	ret

000024f8 <blt_rd>:
static uint32_t blt_rd(uint32_t off)             { return *(volatile uint32_t *)(BLT_BASE + off); }
    24f8:	f81007b7          	lui	a5,0xf8100
    24fc:	00f50533          	add	a0,a0,a5
    2500:	00052503          	lw	a0,0(a0)
    2504:	00008067          	ret

00002508 <fb_of_sel>:
    return (s == 2u) ? FB_BUF2 : ((s == 1u) ? FB_BACK : FB_BASE);
    2508:	00200793          	li	a5,2
    250c:	00f50e63          	beq	a0,a5,2528 <fb_of_sel+0x20>
    2510:	00100793          	li	a5,1
    2514:	00f50663          	beq	a0,a5,2520 <fb_of_sel+0x18>
    2518:	00301537          	lui	a0,0x301
}
    251c:	00008067          	ret
    return (s == 2u) ? FB_BUF2 : ((s == 1u) ? FB_BACK : FB_BASE);
    2520:	00501537          	lui	a0,0x501
    2524:	00008067          	ret
    2528:	00701537          	lui	a0,0x701
    252c:	00008067          	ret

00002530 <fb_stat_sel>:
static uint32_t fb_stat_sel(void) { return blt_rd(BLT_FB_STAT) & 3UL; }
    2530:	ff010113          	addi	sp,sp,-16
    2534:	00112623          	sw	ra,12(sp)
    2538:	02800513          	li	a0,40
    253c:	fbdff0ef          	jal	24f8 <blt_rd>
    2540:	00357513          	andi	a0,a0,3
    2544:	00c12083          	lw	ra,12(sp)
    2548:	01010113          	addi	sp,sp,16
    254c:	00008067          	ret

00002550 <cache_evict>:
    for (i = 0; i < (uint32_t)FLUSH_WORDS; i++) s[i] = 0xA5A50000UL + i;
    2550:	00000793          	li	a5,0
    2554:	0200006f          	j	2574 <cache_evict+0x24>
    2558:	00279693          	slli	a3,a5,0x2
    255c:	00601737          	lui	a4,0x601
    2560:	00d70733          	add	a4,a4,a3
    2564:	a5a506b7          	lui	a3,0xa5a50
    2568:	00d786b3          	add	a3,a5,a3
    256c:	00d72023          	sw	a3,0(a4) # 601000 <__freertos_irq_stack_top+0x5e64f0>
    2570:	00178793          	addi	a5,a5,1 # f8100001 <__freertos_irq_stack_top+0xf80e54f1>
    2574:	7ff00713          	li	a4,2047
    2578:	fef770e3          	bgeu	a4,a5,2558 <cache_evict+0x8>
}
    257c:	00008067          	ret

00002580 <cpu_fill32>:
    uint32_t two = (uint32_t)color | ((uint32_t)color << 16);
    2580:	01079e93          	slli	t4,a5,0x10
    2584:	00fe8eb3          	add	t4,t4,a5
    int odd = (x & 1);
    2588:	0015ff93          	andi	t6,a1,1
    if (w <= 0 || h <= 0) return;
    258c:	08d05663          	blez	a3,2618 <cpu_fill32+0x98>
    2590:	08e05463          	blez	a4,2618 <cpu_fill32+0x98>
    for (j = 0; j < h; j++) {
    2594:	00000f13          	li	t5,0
    2598:	0480006f          	j	25e0 <cpu_fill32+0x60>
        int rem = w;
    259c:	00068e13          	mv	t3,a3
    25a0:	0700006f          	j	2610 <cpu_fill32+0x90>
            for (i = 0; i < (rem >> 1); i++) q[i] = two;
    25a4:	00281893          	slli	a7,a6,0x2
    25a8:	011308b3          	add	a7,t1,a7
    25ac:	01d8a023          	sw	t4,0(a7)
    25b0:	00180813          	addi	a6,a6,1
    25b4:	401e5893          	srai	a7,t3,0x1
    25b8:	ff1846e3          	blt	a6,a7,25a4 <cpu_fill32+0x24>
        if (rem & 1) p[rem - 1] = color;
    25bc:	001e7813          	andi	a6,t3,1
    25c0:	00080e63          	beqz	a6,25dc <cpu_fill32+0x5c>
    25c4:	80000837          	lui	a6,0x80000
    25c8:	fff80813          	addi	a6,a6,-1 # 7fffffff <__freertos_irq_stack_top+0x7ffe54ef>
    25cc:	010e0e33          	add	t3,t3,a6
    25d0:	001e1e13          	slli	t3,t3,0x1
    25d4:	01c30333          	add	t1,t1,t3
    25d8:	00f31023          	sh	a5,0(t1)
    for (j = 0; j < h; j++) {
    25dc:	001f0f13          	addi	t5,t5,1
    25e0:	02ef5c63          	bge	t5,a4,2618 <cpu_fill32+0x98>
        volatile uint16_t *p = (volatile uint16_t *)(base + (uint32_t)(y + j) * FB_STRIDE
    25e4:	00cf0833          	add	a6,t5,a2
                                                          + (uint32_t)x * 2u);
    25e8:	00481313          	slli	t1,a6,0x4
    25ec:	41030333          	sub	t1,t1,a6
    25f0:	00631313          	slli	t1,t1,0x6
    25f4:	00b30333          	add	t1,t1,a1
    25f8:	00131313          	slli	t1,t1,0x1
    25fc:	00a30333          	add	t1,t1,a0
        if (odd) { *p++ = color; rem--; }
    2600:	f80f8ee3          	beqz	t6,259c <cpu_fill32+0x1c>
    2604:	00f31023          	sh	a5,0(t1)
    2608:	fff68e13          	addi	t3,a3,-1 # a5a4ffff <__freertos_irq_stack_top+0xa5a354ef>
    260c:	00230313          	addi	t1,t1,2
            for (i = 0; i < (rem >> 1); i++) q[i] = two;
    2610:	00000813          	li	a6,0
    2614:	fa1ff06f          	j	25b4 <cpu_fill32+0x34>
}
    2618:	00008067          	ret

0000261c <blt_emit>:
{
    261c:	fe010113          	addi	sp,sp,-32
    2620:	00112e23          	sw	ra,28(sp)
    2624:	00812c23          	sw	s0,24(sp)
    2628:	00912a23          	sw	s1,20(sp)
    262c:	01212823          	sw	s2,16(sp)
    2630:	01312623          	sw	s3,12(sp)
    2634:	01412423          	sw	s4,8(sp)
    2638:	01512223          	sw	s5,4(sp)
    263c:	01612023          	sw	s6,0(sp)
    2640:	00058b13          	mv	s6,a1
    2644:	00060a93          	mv	s5,a2
    2648:	00068a13          	mv	s4,a3
    264c:	00070993          	mv	s3,a4
    2650:	00078913          	mv	s2,a5
    2654:	00080413          	mv	s0,a6
    2658:	00088493          	mv	s1,a7
    if (g_attr_on) blt_wr(BLT_ATTR_PORT, attr);       /* ★ 必须在 8 个命令字之前 */
    265c:	8f01a783          	lw	a5,-1808(gp) # 8d68 <g_attr_on>
    2660:	08079c63          	bnez	a5,26f8 <blt_emit+0xdc>
    blt_wr(BLT_CMD_FIFO_DATA, op);
    2664:	000b0593          	mv	a1,s6
    2668:	00800513          	li	a0,8
    266c:	e7dff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, src);
    2670:	000a8593          	mv	a1,s5
    2674:	00800513          	li	a0,8
    2678:	e71ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, dst);
    267c:	000a0593          	mv	a1,s4
    2680:	00800513          	li	a0,8
    2684:	e65ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, ss);
    2688:	00098593          	mv	a1,s3
    268c:	00800513          	li	a0,8
    2690:	e59ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, ds);
    2694:	00090593          	mv	a1,s2
    2698:	00800513          	li	a0,8
    269c:	e4dff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, (h << 16) | (w & 0xFFFFu));
    26a0:	01049593          	slli	a1,s1,0x10
    26a4:	01041413          	slli	s0,s0,0x10
    26a8:	01045413          	srli	s0,s0,0x10
    26ac:	0085e5b3          	or	a1,a1,s0
    26b0:	00800513          	li	a0,8
    26b4:	e35ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, alpha);
    26b8:	02012583          	lw	a1,32(sp)
    26bc:	00800513          	li	a0,8
    26c0:	e29ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CMD_FIFO_DATA, color);
    26c4:	02412583          	lw	a1,36(sp)
    26c8:	00800513          	li	a0,8
    26cc:	e1dff0ef          	jal	24e8 <blt_wr>
}
    26d0:	01c12083          	lw	ra,28(sp)
    26d4:	01812403          	lw	s0,24(sp)
    26d8:	01412483          	lw	s1,20(sp)
    26dc:	01012903          	lw	s2,16(sp)
    26e0:	00c12983          	lw	s3,12(sp)
    26e4:	00812a03          	lw	s4,8(sp)
    26e8:	00412a83          	lw	s5,4(sp)
    26ec:	00012b03          	lw	s6,0(sp)
    26f0:	02010113          	addi	sp,sp,32
    26f4:	00008067          	ret
    if (g_attr_on) blt_wr(BLT_ATTR_PORT, attr);       /* ★ 必须在 8 个命令字之前 */
    26f8:	00050593          	mv	a1,a0
    26fc:	08c00513          	li	a0,140
    2700:	de9ff0ef          	jal	24e8 <blt_wr>
    2704:	f61ff06f          	j	2664 <blt_emit+0x48>

00002708 <e_fill>:
{ blt_emit(ATTR_DEFAULT, BLT_OP_FILL, 0u, dst, 0u, ds, w, h, 0xFFu, color); }
    2708:	fd010113          	addi	sp,sp,-48
    270c:	02112623          	sw	ra,44(sp)
    2710:	02812423          	sw	s0,40(sp)
    2714:	02912223          	sw	s1,36(sp)
    2718:	03212023          	sw	s2,32(sp)
    271c:	01312e23          	sw	s3,28(sp)
    2720:	01412c23          	sw	s4,24(sp)
    2724:	00050413          	mv	s0,a0
    2728:	00058493          	mv	s1,a1
    272c:	00060913          	mv	s2,a2
    2730:	00068993          	mv	s3,a3
    2734:	00070a13          	mv	s4,a4
    2738:	00000693          	li	a3,0
    273c:	0ff00613          	li	a2,255
    2740:	00000593          	li	a1,0
    2744:	00000513          	li	a0,0
    2748:	93dff0ef          	jal	2084 <attr_word>
    274c:	01412223          	sw	s4,4(sp)
    2750:	0ff00793          	li	a5,255
    2754:	00f12023          	sw	a5,0(sp)
    2758:	00098893          	mv	a7,s3
    275c:	00090813          	mv	a6,s2
    2760:	00048793          	mv	a5,s1
    2764:	00000713          	li	a4,0
    2768:	00040693          	mv	a3,s0
    276c:	00000613          	li	a2,0
    2770:	00100593          	li	a1,1
    2774:	ea9ff0ef          	jal	261c <blt_emit>
    2778:	02c12083          	lw	ra,44(sp)
    277c:	02812403          	lw	s0,40(sp)
    2780:	02412483          	lw	s1,36(sp)
    2784:	02012903          	lw	s2,32(sp)
    2788:	01c12983          	lw	s3,28(sp)
    278c:	01812a03          	lw	s4,24(sp)
    2790:	03010113          	addi	sp,sp,48
    2794:	00008067          	ret

00002798 <e_key>:
{ blt_emit(ATTR_DEFAULT, BLT_OP_KEY, src, dst, ss, ds, w, h, 0xFFu, key); }
    2798:	fd010113          	addi	sp,sp,-48
    279c:	02112623          	sw	ra,44(sp)
    27a0:	02812423          	sw	s0,40(sp)
    27a4:	02912223          	sw	s1,36(sp)
    27a8:	03212023          	sw	s2,32(sp)
    27ac:	01312e23          	sw	s3,28(sp)
    27b0:	01412c23          	sw	s4,24(sp)
    27b4:	01512a23          	sw	s5,20(sp)
    27b8:	01612823          	sw	s6,16(sp)
    27bc:	00050413          	mv	s0,a0
    27c0:	00058493          	mv	s1,a1
    27c4:	00060913          	mv	s2,a2
    27c8:	00068993          	mv	s3,a3
    27cc:	00070a13          	mv	s4,a4
    27d0:	00078a93          	mv	s5,a5
    27d4:	00080b13          	mv	s6,a6
    27d8:	00000693          	li	a3,0
    27dc:	0ff00613          	li	a2,255
    27e0:	00000593          	li	a1,0
    27e4:	00000513          	li	a0,0
    27e8:	89dff0ef          	jal	2084 <attr_word>
    27ec:	01612223          	sw	s6,4(sp)
    27f0:	0ff00793          	li	a5,255
    27f4:	00f12023          	sw	a5,0(sp)
    27f8:	000a8893          	mv	a7,s5
    27fc:	000a0813          	mv	a6,s4
    2800:	00098793          	mv	a5,s3
    2804:	00090713          	mv	a4,s2
    2808:	00048693          	mv	a3,s1
    280c:	00040613          	mv	a2,s0
    2810:	00300593          	li	a1,3
    2814:	e09ff0ef          	jal	261c <blt_emit>
    2818:	02c12083          	lw	ra,44(sp)
    281c:	02812403          	lw	s0,40(sp)
    2820:	02412483          	lw	s1,36(sp)
    2824:	02012903          	lw	s2,32(sp)
    2828:	01c12983          	lw	s3,28(sp)
    282c:	01812a03          	lw	s4,24(sp)
    2830:	01412a83          	lw	s5,20(sp)
    2834:	01012b03          	lw	s6,16(sp)
    2838:	03010113          	addi	sp,sp,48
    283c:	00008067          	ret

00002840 <e_glow>:
{
    2840:	fd010113          	addi	sp,sp,-48
    2844:	02112623          	sw	ra,44(sp)
    2848:	02812423          	sw	s0,40(sp)
    284c:	02912223          	sw	s1,36(sp)
    2850:	03212023          	sw	s2,32(sp)
    2854:	01312e23          	sw	s3,28(sp)
    2858:	01412c23          	sw	s4,24(sp)
    285c:	01512a23          	sw	s5,20(sp)
    2860:	00050413          	mv	s0,a0
    2864:	00058493          	mv	s1,a1
    2868:	00060913          	mv	s2,a2
    286c:	00068993          	mv	s3,a3
    2870:	00070a13          	mv	s4,a4
    2874:	00078a93          	mv	s5,a5
    if (g_attr_on)
    2878:	8f01a783          	lw	a5,-1808(gp) # 8d68 <g_attr_on>
    287c:	06078463          	beqz	a5,28e4 <e_glow+0xa4>
    2880:	00080613          	mv	a2,a6
        blt_emit(attr_word(ATTR_BLEND_ADD, ATTR_FMT_565, ga, 0u),
    2884:	00000693          	li	a3,0
    2888:	00000593          	li	a1,0
    288c:	00200513          	li	a0,2
    2890:	ff4ff0ef          	jal	2084 <attr_word>
    2894:	00012223          	sw	zero,4(sp)
    2898:	0ff00793          	li	a5,255
    289c:	00f12023          	sw	a5,0(sp)
    28a0:	000a8893          	mv	a7,s5
    28a4:	000a0813          	mv	a6,s4
    28a8:	00098793          	mv	a5,s3
    28ac:	00090713          	mv	a4,s2
    28b0:	00048693          	mv	a3,s1
    28b4:	00040613          	mv	a2,s0
    28b8:	00200593          	li	a1,2
    28bc:	d61ff0ef          	jal	261c <blt_emit>
}
    28c0:	02c12083          	lw	ra,44(sp)
    28c4:	02812403          	lw	s0,40(sp)
    28c8:	02412483          	lw	s1,36(sp)
    28cc:	02012903          	lw	s2,32(sp)
    28d0:	01c12983          	lw	s3,28(sp)
    28d4:	01812a03          	lw	s4,24(sp)
    28d8:	01412a83          	lw	s5,20(sp)
    28dc:	03010113          	addi	sp,sp,48
    28e0:	00008067          	ret
        blt_emit(ATTR_DEFAULT, BLT_OP_KEY, src, dst, ss, ds, w, h, 0xFFu, TRANS_KEY);
    28e4:	00000693          	li	a3,0
    28e8:	0ff00613          	li	a2,255
    28ec:	00000593          	li	a1,0
    28f0:	00000513          	li	a0,0
    28f4:	f90ff0ef          	jal	2084 <attr_word>
    28f8:	00012223          	sw	zero,4(sp)
    28fc:	0ff00793          	li	a5,255
    2900:	00f12023          	sw	a5,0(sp)
    2904:	000a8893          	mv	a7,s5
    2908:	000a0813          	mv	a6,s4
    290c:	00098793          	mv	a5,s3
    2910:	00090713          	mv	a4,s2
    2914:	00048693          	mv	a3,s1
    2918:	00040613          	mv	a2,s0
    291c:	00300593          	li	a1,3
    2920:	cfdff0ef          	jal	261c <blt_emit>
}
    2924:	f9dff06f          	j	28c0 <e_glow+0x80>

00002928 <e_alpha>:
{
    2928:	fd010113          	addi	sp,sp,-48
    292c:	02112623          	sw	ra,44(sp)
    2930:	02812423          	sw	s0,40(sp)
    2934:	02912223          	sw	s1,36(sp)
    2938:	03212023          	sw	s2,32(sp)
    293c:	01312e23          	sw	s3,28(sp)
    2940:	01412c23          	sw	s4,24(sp)
    2944:	01512a23          	sw	s5,20(sp)
    2948:	01612823          	sw	s6,16(sp)
    294c:	00050493          	mv	s1,a0
    2950:	00058913          	mv	s2,a1
    2954:	00060993          	mv	s3,a2
    2958:	00068a13          	mv	s4,a3
    295c:	00070a93          	mv	s5,a4
    2960:	00078b13          	mv	s6,a5
    2964:	00080413          	mv	s0,a6
    blt_emit(ATTR_DEFAULT, BLT_OP_ALPHA, src, dst, ss, ds, w, h, alpha & 0xFFu, 0u);
    2968:	00000693          	li	a3,0
    296c:	0ff00613          	li	a2,255
    2970:	00000593          	li	a1,0
    2974:	00000513          	li	a0,0
    2978:	f0cff0ef          	jal	2084 <attr_word>
    297c:	00012223          	sw	zero,4(sp)
    2980:	0ff47413          	zext.b	s0,s0
    2984:	00812023          	sw	s0,0(sp)
    2988:	000b0893          	mv	a7,s6
    298c:	000a8813          	mv	a6,s5
    2990:	000a0793          	mv	a5,s4
    2994:	00098713          	mv	a4,s3
    2998:	00090693          	mv	a3,s2
    299c:	00048613          	mv	a2,s1
    29a0:	00200593          	li	a1,2
    29a4:	c79ff0ef          	jal	261c <blt_emit>
}
    29a8:	02c12083          	lw	ra,44(sp)
    29ac:	02812403          	lw	s0,40(sp)
    29b0:	02412483          	lw	s1,36(sp)
    29b4:	02012903          	lw	s2,32(sp)
    29b8:	01c12983          	lw	s3,28(sp)
    29bc:	01812a03          	lw	s4,24(sp)
    29c0:	01412a83          	lw	s5,20(sp)
    29c4:	01012b03          	lw	s6,16(sp)
    29c8:	03010113          	addi	sp,sp,48
    29cc:	00008067          	ret

000029d0 <blt_cnt>:
static uint32_t blt_cnt(void)  { return blt_rd(BLT_CMD_FIFO_COUNT); }
    29d0:	ff010113          	addi	sp,sp,-16
    29d4:	00112623          	sw	ra,12(sp)
    29d8:	00c00513          	li	a0,12
    29dc:	b1dff0ef          	jal	24f8 <blt_rd>
    29e0:	00c12083          	lw	ra,12(sp)
    29e4:	01010113          	addi	sp,sp,16
    29e8:	00008067          	ret

000029ec <blt_stat>:
static uint32_t blt_stat(void) { return blt_rd(BLT_STATUS); }
    29ec:	ff010113          	addi	sp,sp,-16
    29f0:	00112623          	sw	ra,12(sp)
    29f4:	00400513          	li	a0,4
    29f8:	b01ff0ef          	jal	24f8 <blt_rd>
    29fc:	00c12083          	lw	ra,12(sp)
    2a00:	01010113          	addi	sp,sp,16
    2a04:	00008067          	ret

00002a08 <blt_idle_st>:
    return ((st & BLT_STATUS_DONE) && (st & BLT_STATUS_FIFO_EMPTY) &&
    2a08:	00e57513          	andi	a0,a0,14
            !(st & BLT_STATUS_ERR)) ? 1 : 0;
    2a0c:	ff650513          	addi	a0,a0,-10 # 700ff6 <__freertos_irq_stack_top+0x6e64e6>
}
    2a10:	00153513          	seqz	a0,a0
    2a14:	00008067          	ret

00002a18 <blt_push_room>:
{
    2a18:	ff010113          	addi	sp,sp,-16
    2a1c:	00112623          	sw	ra,12(sp)
    uint32_t cnt = blt_cnt();
    2a20:	fb1ff0ef          	jal	29d0 <blt_cnt>
    if (cnt > (uint32_t)(BLT_PUSH_LIMIT - 1u)) return 0u;
    2a24:	0c700793          	li	a5,199
    2a28:	00a7ec63          	bltu	a5,a0,2a40 <blt_push_room+0x28>
    return (uint32_t)BLT_PUSH_LIMIT - cnt;
    2a2c:	0c800793          	li	a5,200
    2a30:	40a78533          	sub	a0,a5,a0
}
    2a34:	00c12083          	lw	ra,12(sp)
    2a38:	01010113          	addi	sp,sp,16
    2a3c:	00008067          	ret
    if (cnt > (uint32_t)(BLT_PUSH_LIMIT - 1u)) return 0u;
    2a40:	00000513          	li	a0,0
    2a44:	ff1ff06f          	j	2a34 <blt_push_room+0x1c>

00002a48 <blt_init>:
{
    2a48:	ff010113          	addi	sp,sp,-16
    2a4c:	00112623          	sw	ra,12(sp)
    blt_wr(BLT_CTRL, BLT_CTRL_SOFT_RST);
    2a50:	00400593          	li	a1,4
    2a54:	00000513          	li	a0,0
    2a58:	a91ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_IRQ_STATUS, 7u);                        /* W1C 三位全清 */
    2a5c:	00700593          	li	a1,7
    2a60:	01000513          	li	a0,16
    2a64:	a85ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_IRQ_EN, 0u);
    2a68:	00000593          	li	a1,0
    2a6c:	01400513          	li	a0,20
    2a70:	a79ff0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CTRL, BLT_CTRL_GO);
    2a74:	00100593          	li	a1,1
    2a78:	00000513          	li	a0,0
    2a7c:	a6dff0ef          	jal	24e8 <blt_wr>
}
    2a80:	00c12083          	lw	ra,12(sp)
    2a84:	01010113          	addi	sp,sp,16
    2a88:	00008067          	ret

00002a8c <clr_stat>:
static uint32_t clr_stat(void) { return blt_rd(BLT_CLR_STAT); }
    2a8c:	ff010113          	addi	sp,sp,-16
    2a90:	00112623          	sw	ra,12(sp)
    2a94:	04000513          	li	a0,64
    2a98:	a61ff0ef          	jal	24f8 <blt_rd>
    2a9c:	00c12083          	lw	ra,12(sp)
    2aa0:	01010113          	addi	sp,sp,16
    2aa4:	00008067          	ret

00002aa8 <clr_busy>:
static int      clr_busy(void) { return (clr_stat() & BLT_CLR_STAT_BUSY) ? 1 : 0; }
    2aa8:	ff010113          	addi	sp,sp,-16
    2aac:	00112623          	sw	ra,12(sp)
    2ab0:	fddff0ef          	jal	2a8c <clr_stat>
    2ab4:	00157513          	andi	a0,a0,1
    2ab8:	00c12083          	lw	ra,12(sp)
    2abc:	01010113          	addi	sp,sp,16
    2ac0:	00008067          	ret

00002ac4 <clr_is_clean>:
static int      clr_is_clean(uint32_t k) { return (int)((clr_stat() >> (2u + k)) & 1u); }
    2ac4:	ff010113          	addi	sp,sp,-16
    2ac8:	00112623          	sw	ra,12(sp)
    2acc:	00812423          	sw	s0,8(sp)
    2ad0:	00050413          	mv	s0,a0
    2ad4:	fb9ff0ef          	jal	2a8c <clr_stat>
    2ad8:	00240413          	addi	s0,s0,2
    2adc:	00855533          	srl	a0,a0,s0
    2ae0:	00157513          	andi	a0,a0,1
    2ae4:	00c12083          	lw	ra,12(sp)
    2ae8:	00812403          	lw	s0,8(sp)
    2aec:	01010113          	addi	sp,sp,16
    2af0:	00008067          	ret

00002af4 <clr_wait_idle>:
{
    2af4:	ff010113          	addi	sp,sp,-16
    2af8:	00112623          	sw	ra,12(sp)
    2afc:	00812423          	sw	s0,8(sp)
    2b00:	00912223          	sw	s1,4(sp)
    uint32_t t0 = tick32();
    2b04:	9c9ff0ef          	jal	24cc <tick32>
    2b08:	00050493          	mv	s1,a0
{
    2b0c:	00000413          	li	s0,0
    while (clr_busy()) {
    2b10:	f99ff0ef          	jal	2aa8 <clr_busy>
    2b14:	04050263          	beqz	a0,2b58 <clr_wait_idle+0x64>
        if ((uint32_t)(tick32() - t0) > (uint32_t)CLR_WAIT_TICKS) { g_clr_to++; return 0; }
    2b18:	9b5ff0ef          	jal	24cc <tick32>
    2b1c:	40950533          	sub	a0,a0,s1
    2b20:	000f47b7          	lui	a5,0xf4
    2b24:	24078793          	addi	a5,a5,576 # f4240 <__freertos_irq_stack_top+0xd9730>
    2b28:	00a7ee63          	bltu	a5,a0,2b44 <clr_wait_idle+0x50>
        if (++guard > 64) { guard = 0; cpu_backoff(48u); }
    2b2c:	00140413          	addi	s0,s0,1
    2b30:	04000793          	li	a5,64
    2b34:	fc87dee3          	bge	a5,s0,2b10 <clr_wait_idle+0x1c>
    2b38:	03000513          	li	a0,48
    2b3c:	99dff0ef          	jal	24d8 <cpu_backoff>
    2b40:	fcdff06f          	j	2b0c <clr_wait_idle+0x18>
        if ((uint32_t)(tick32() - t0) > (uint32_t)CLR_WAIT_TICKS) { g_clr_to++; return 0; }
    2b44:	8d41a783          	lw	a5,-1836(gp) # 8d4c <g_clr_to>
    2b48:	00178793          	addi	a5,a5,1
    2b4c:	8cf1aa23          	sw	a5,-1836(gp) # 8d4c <g_clr_to>
    2b50:	00000513          	li	a0,0
    2b54:	0080006f          	j	2b5c <clr_wait_idle+0x68>
    return 1;
    2b58:	00100513          	li	a0,1
}
    2b5c:	00c12083          	lw	ra,12(sp)
    2b60:	00812403          	lw	s0,8(sp)
    2b64:	00412483          	lw	s1,4(sp)
    2b68:	01010113          	addi	sp,sp,16
    2b6c:	00008067          	ret

00002b70 <hw_pass_arm>:
{
    2b70:	ff010113          	addi	sp,sp,-16
    2b74:	00112623          	sw	ra,12(sp)
    2b78:	00812423          	sw	s0,8(sp)
    2b7c:	00912223          	sw	s1,4(sp)
    (void)clr_wait_idle();                                     /* ① 超时交给硬件互斥兜底 */
    2b80:	f75ff0ef          	jal	2af4 <clr_wait_idle>
    clean_k = clr_is_clean((uint32_t)g_draw3);                 /* ② */
    2b84:	8301a503          	lw	a0,-2000(gp) # 8ca8 <g_draw3>
    2b88:	f3dff0ef          	jal	2ac4 <clr_is_clean>
    2b8c:	00050413          	mv	s0,a0
    blt_wr(BLT_DRAW_SEL, (uint32_t)g_draw3);                   /* ③ */
    2b90:	8301a583          	lw	a1,-2000(gp) # 8ca8 <g_draw3>
    2b94:	04400513          	li	a0,68
    2b98:	951ff0ef          	jal	24e8 <blt_wr>
    if (clr_stat() & BLT_CLR_STAT_ERR) {                       /*    清掉互斥留下的 sticky 错误 */
    2b9c:	ef1ff0ef          	jal	2a8c <clr_stat>
    2ba0:	04057513          	andi	a0,a0,64
    2ba4:	02051863          	bnez	a0,2bd4 <hw_pass_arm+0x64>
    if (!clean_k) g_clr_fb++;                                  /* ④ */
    2ba8:	00041863          	bnez	s0,2bb8 <hw_pass_arm+0x48>
    2bac:	8d81a783          	lw	a5,-1832(gp) # 8d50 <g_clr_fb>
    2bb0:	00178793          	addi	a5,a5,1
    2bb4:	8cf1ac23          	sw	a5,-1832(gp) # 8d50 <g_clr_fb>
    g_clr_need = 0;            /* ★真图背景：背景由 bg_copy 负责，清屏引擎停用 */
    2bb8:	8e01a023          	sw	zero,-1824(gp) # 8d58 <g_clr_need>
}
    2bbc:	00143513          	seqz	a0,s0
    2bc0:	00c12083          	lw	ra,12(sp)
    2bc4:	00812403          	lw	s0,8(sp)
    2bc8:	00412483          	lw	s1,4(sp)
    2bcc:	01010113          	addi	sp,sp,16
    2bd0:	00008067          	ret
        g_clr_err++;
    2bd4:	8d01a783          	lw	a5,-1840(gp) # 8d48 <g_clr_err>
    2bd8:	00178793          	addi	a5,a5,1
    2bdc:	8cf1a823          	sw	a5,-1840(gp) # 8d48 <g_clr_err>
        blt_wr(BLT_CLR_CTRL, ((uint32_t)g_draw3 << 2) | BLT_CLR_ERRCLR);
    2be0:	8301a583          	lw	a1,-2000(gp) # 8ca8 <g_draw3>
    2be4:	00259593          	slli	a1,a1,0x2
    2be8:	0105e593          	ori	a1,a1,16
    2bec:	03c00513          	li	a0,60
    2bf0:	8f9ff0ef          	jal	24e8 <blt_wr>
    2bf4:	fb5ff06f          	j	2ba8 <hw_pass_arm+0x38>

00002bf8 <uart_status_raw>:
    return *(volatile uint32_t *)(UART_TERM + UART_STATUS_OFS);
    2bf8:	f80107b7          	lui	a5,0xf8010
    2bfc:	0047a503          	lw	a0,4(a5) # f8010004 <__freertos_irq_stack_top+0xf7ff54f4>
}
    2c00:	00008067          	ret

00002c04 <uart_poll_char>:
{
    2c04:	ff010113          	addi	sp,sp,-16
    2c08:	00112623          	sw	ra,12(sp)
    if ((uart_status_raw() >> 24) == 0u) return 0;
    2c0c:	fedff0ef          	jal	2bf8 <uart_status_raw>
    2c10:	01855513          	srli	a0,a0,0x18
    2c14:	00050e63          	beqz	a0,2c30 <uart_poll_char+0x2c>
    return (int)(*(volatile uint32_t *)(UART_TERM + UART_DATA_OFS) & 0xFFu);
    2c18:	f80107b7          	lui	a5,0xf8010
    2c1c:	0007a503          	lw	a0,0(a5) # f8010000 <__freertos_irq_stack_top+0xf7ff54f0>
    2c20:	0ff57513          	zext.b	a0,a0
}
    2c24:	00c12083          	lw	ra,12(sp)
    2c28:	01010113          	addi	sp,sp,16
    2c2c:	00008067          	ret
    if ((uart_status_raw() >> 24) == 0u) return 0;
    2c30:	00000513          	li	a0,0
    2c34:	ff1ff06f          	j	2c24 <uart_poll_char+0x20>

00002c38 <kp_hexval>:
    if (c >= '0' && c <= '9') return c - '0';
    2c38:	fd050713          	addi	a4,a0,-48
    2c3c:	00900793          	li	a5,9
    2c40:	02e7f263          	bgeu	a5,a4,2c64 <kp_hexval+0x2c>
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    2c44:	f9f50793          	addi	a5,a0,-97
    2c48:	00500713          	li	a4,5
    2c4c:	02f77063          	bgeu	a4,a5,2c6c <kp_hexval+0x34>
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    2c50:	fbf50793          	addi	a5,a0,-65
    2c54:	00500713          	li	a4,5
    2c58:	00f76e63          	bltu	a4,a5,2c74 <kp_hexval+0x3c>
    2c5c:	fc950513          	addi	a0,a0,-55
    2c60:	00008067          	ret
    if (c >= '0' && c <= '9') return c - '0';
    2c64:	00070513          	mv	a0,a4
    2c68:	00008067          	ret
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    2c6c:	fa950513          	addi	a0,a0,-87
    2c70:	00008067          	ret
    return -1;
    2c74:	fff00513          	li	a0,-1
}
    2c78:	00008067          	ret

00002c7c <kp_feed>:
{
    2c7c:	00050793          	mv	a5,a0
    if (!g_kp_on) {
    2c80:	8c81a503          	lw	a0,-1848(gp) # 8d40 <g_kp_on>
    2c84:	02051463          	bnez	a0,2cac <kp_feed+0x30>
        if (c != '@') return KP_NONE;        /* 与本包无关：原样交回命令分支 */
    2c88:	04000713          	li	a4,64
    2c8c:	00e78463          	beq	a5,a4,2c94 <kp_feed+0x18>
}
    2c90:	00008067          	ret
        g_kp_on = 1; g_kp_n = 0; g_kp_v = 0u;
    2c94:	00100713          	li	a4,1
    2c98:	8ce1a423          	sw	a4,-1848(gp) # 8d40 <g_kp_on>
    2c9c:	8c01a223          	sw	zero,-1852(gp) # 8d3c <g_kp_n>
    2ca0:	8c01a023          	sw	zero,-1856(gp) # 8d38 <g_kp_v>
        return KP_MORE;
    2ca4:	00100513          	li	a0,1
    2ca8:	00008067          	ret
    if (c == '\n' || c == '\r') {            /* 行结束：结算，必须恰好两位 */
    2cac:	00a00713          	li	a4,10
    2cb0:	04e78a63          	beq	a5,a4,2d04 <kp_feed+0x88>
    2cb4:	00d00713          	li	a4,13
    2cb8:	04e78663          	beq	a5,a4,2d04 <kp_feed+0x88>
{
    2cbc:	ff010113          	addi	sp,sp,-16
    2cc0:	00112623          	sw	ra,12(sp)
    h = kp_hexval(c);
    2cc4:	00078513          	mv	a0,a5
    2cc8:	f71ff0ef          	jal	2c38 <kp_hexval>
    if (h < 0 || g_kp_n >= 2) { g_kp_on = 0; return KP_ERR; }   /* 非十六进制 / 太长：作废 */
    2ccc:	04054a63          	bltz	a0,2d20 <kp_feed+0xa4>
    2cd0:	8c41a703          	lw	a4,-1852(gp) # 8d3c <g_kp_n>
    2cd4:	00100793          	li	a5,1
    2cd8:	04e7c463          	blt	a5,a4,2d20 <kp_feed+0xa4>
    g_kp_v = (g_kp_v << 4) | (unsigned)h;
    2cdc:	8c01a783          	lw	a5,-1856(gp) # 8d38 <g_kp_v>
    2ce0:	00479793          	slli	a5,a5,0x4
    2ce4:	00a7e533          	or	a0,a5,a0
    2ce8:	8ca1a023          	sw	a0,-1856(gp) # 8d38 <g_kp_v>
    g_kp_n++;
    2cec:	00170713          	addi	a4,a4,1
    2cf0:	8ce1a223          	sw	a4,-1852(gp) # 8d3c <g_kp_n>
    return KP_MORE;
    2cf4:	00100513          	li	a0,1
}
    2cf8:	00c12083          	lw	ra,12(sp)
    2cfc:	01010113          	addi	sp,sp,16
    2d00:	00008067          	ret
        g_kp_on = 0;
    2d04:	8c01a423          	sw	zero,-1848(gp) # 8d40 <g_kp_on>
        if (g_kp_n != 2) return KP_ERR;
    2d08:	8c41a503          	lw	a0,-1852(gp) # 8d3c <g_kp_n>
    2d0c:	00200793          	li	a5,2
    2d10:	00f51e63          	bne	a0,a5,2d2c <kp_feed+0xb0>
        *mask = g_kp_v & 0xFFu;
    2d14:	8c01c783          	lbu	a5,-1856(gp) # 8d38 <g_kp_v>
    2d18:	00f5a023          	sw	a5,0(a1)
        return KP_OK;
    2d1c:	00008067          	ret
    if (h < 0 || g_kp_n >= 2) { g_kp_on = 0; return KP_ERR; }   /* 非十六进制 / 太长：作废 */
    2d20:	8c01a423          	sw	zero,-1848(gp) # 8d40 <g_kp_on>
    2d24:	fff00513          	li	a0,-1
    2d28:	fd1ff06f          	j	2cf8 <kp_feed+0x7c>
        if (g_kp_n != 2) return KP_ERR;
    2d2c:	fff00513          	li	a0,-1
    2d30:	00008067          	ret

00002d34 <nline_feed>:
{
    2d34:	00050793          	mv	a5,a0
    if (!g_nl_on) {
    2d38:	8b81a503          	lw	a0,-1864(gp) # 8d30 <g_nl_on>
    2d3c:	02051263          	bnez	a0,2d60 <nline_feed+0x2c>
        if (c != '=') return NL_NONE;
    2d40:	03d00713          	li	a4,61
    2d44:	00e78463          	beq	a5,a4,2d4c <nline_feed+0x18>
}
    2d48:	00008067          	ret
        g_nl_on = 1; g_nl_n = 0;
    2d4c:	00100713          	li	a4,1
    2d50:	8ae1ac23          	sw	a4,-1864(gp) # 8d30 <g_nl_on>
    2d54:	8a01ae23          	sw	zero,-1860(gp) # 8d34 <g_nl_n>
        return NL_MORE;
    2d58:	00100513          	li	a0,1
    2d5c:	00008067          	ret
    if (c == '\n' || c == '\r') {
    2d60:	00a00713          	li	a4,10
    2d64:	04e78263          	beq	a5,a4,2da8 <nline_feed+0x74>
    2d68:	00d00713          	li	a4,13
    2d6c:	02e78e63          	beq	a5,a4,2da8 <nline_feed+0x74>
    if (c < '0' || c > '9' || g_nl_n >= (unsigned)NLINE_MAX) { g_nl_on = 0; return NL_ERR; }
    2d70:	fd078713          	addi	a4,a5,-48
    2d74:	00900693          	li	a3,9
    2d78:	08e6ec63          	bltu	a3,a4,2e10 <nline_feed+0xdc>
    2d7c:	8bc1a683          	lw	a3,-1860(gp) # 8d34 <g_nl_n>
    2d80:	00b00713          	li	a4,11
    2d84:	08d76663          	bltu	a4,a3,2e10 <nline_feed+0xdc>
    g_nl[g_nl_n++] = (char)c;
    2d88:	00168613          	addi	a2,a3,1
    2d8c:	8ac1ae23          	sw	a2,-1860(gp) # 8d34 <g_nl_n>
    2d90:	0001a737          	lui	a4,0x1a
    2d94:	afc70713          	addi	a4,a4,-1284 # 19afc <g_nl>
    2d98:	00d70733          	add	a4,a4,a3
    2d9c:	00f70023          	sb	a5,0(a4)
    return NL_MORE;
    2da0:	00100513          	li	a0,1
    2da4:	00008067          	ret
        g_nl_on = 0;
    2da8:	8a01ac23          	sw	zero,-1864(gp) # 8d30 <g_nl_on>
        if (g_nl_n == 0u) return NL_ERR;
    2dac:	8bc1a883          	lw	a7,-1860(gp) # 8d34 <g_nl_n>
    2db0:	06088663          	beqz	a7,2e1c <nline_feed+0xe8>
        for (i = 0; i < g_nl_n; i++) {
    2db4:	00000513          	li	a0,0
        v = 0u;
    2db8:	00000813          	li	a6,0
    2dbc:	0080006f          	j	2dc4 <nline_feed+0x90>
        for (i = 0; i < g_nl_n; i++) {
    2dc0:	00150513          	addi	a0,a0,1
    2dc4:	03157c63          	bgeu	a0,a7,2dfc <nline_feed+0xc8>
            v = v * 10u + (unsigned)(g_nl[i] - '0');
    2dc8:	00281713          	slli	a4,a6,0x2
    2dcc:	01070733          	add	a4,a4,a6
    2dd0:	00171713          	slli	a4,a4,0x1
    2dd4:	0001a7b7          	lui	a5,0x1a
    2dd8:	afc78793          	addi	a5,a5,-1284 # 19afc <g_nl>
    2ddc:	00a787b3          	add	a5,a5,a0
    2de0:	0007c783          	lbu	a5,0(a5)
    2de4:	00e787b3          	add	a5,a5,a4
    2de8:	fd078793          	addi	a5,a5,-48
            if (v > (unsigned)nmax) v = (unsigned)nmax;
    2dec:	00068813          	mv	a6,a3
    2df0:	fcf6e8e3          	bltu	a3,a5,2dc0 <nline_feed+0x8c>
            v = v * 10u + (unsigned)(g_nl[i] - '0');
    2df4:	00078813          	mv	a6,a5
    2df8:	fc9ff06f          	j	2dc0 <nline_feed+0x8c>
        if (v < (unsigned)nmin) v = (unsigned)nmin;
    2dfc:	00c86463          	bltu	a6,a2,2e04 <nline_feed+0xd0>
    2e00:	00080613          	mv	a2,a6
        *out = (int)v;
    2e04:	00c5a023          	sw	a2,0(a1)
        return NL_OK;
    2e08:	00200513          	li	a0,2
    2e0c:	00008067          	ret
    if (c < '0' || c > '9' || g_nl_n >= (unsigned)NLINE_MAX) { g_nl_on = 0; return NL_ERR; }
    2e10:	8a01ac23          	sw	zero,-1864(gp) # 8d30 <g_nl_on>
    2e14:	fff00513          	li	a0,-1
    2e18:	00008067          	ret
        if (g_nl_n == 0u) return NL_ERR;
    2e1c:	fff00513          	li	a0,-1
    2e20:	00008067          	ret

00002e24 <lcg>:
static uint32_t lcg(uint32_t *s) { *s = *s * 1664525u + 1013904223u; return (*s >> 16); }
    2e24:	00052783          	lw	a5,0(a0)
    2e28:	00196737          	lui	a4,0x196
    2e2c:	60d70713          	addi	a4,a4,1549 # 19660d <__freertos_irq_stack_top+0x17bafd>
    2e30:	02e787b3          	mul	a5,a5,a4
    2e34:	3c6ef737          	lui	a4,0x3c6ef
    2e38:	35f70713          	addi	a4,a4,863 # 3c6ef35f <__freertos_irq_stack_top+0x3c6d484f>
    2e3c:	00e787b3          	add	a5,a5,a4
    2e40:	00f52023          	sw	a5,0(a0)
    2e44:	0107d513          	srli	a0,a5,0x10
    2e48:	00008067          	ret

00002e4c <rnd>:
static uint32_t rnd(void) { return lcg(&g_seed); }
    2e4c:	ff010113          	addi	sp,sp,-16
    2e50:	00112623          	sw	ra,12(sp)
    2e54:	82818513          	addi	a0,gp,-2008 # 8ca0 <g_seed>
    2e58:	fcdff0ef          	jal	2e24 <lcg>
    2e5c:	00c12083          	lw	ra,12(sp)
    2e60:	01010113          	addi	sp,sp,16
    2e64:	00008067          	ret

00002e68 <isin>:
static int isin(int a) { return (int)g_sin64[a & 63]; }
    2e68:	03f57513          	andi	a0,a0,63
    2e6c:	000097b7          	lui	a5,0x9
    2e70:	00151513          	slli	a0,a0,0x1
    2e74:	84878793          	addi	a5,a5,-1976 # 8848 <g_sin64>
    2e78:	00a787b3          	add	a5,a5,a0
    2e7c:	00079503          	lh	a0,0(a5)
    2e80:	00008067          	ret

00002e84 <icos>:
static int icos(int a) { return (int)g_sin64[(a + 16) & 63]; }
    2e84:	01050513          	addi	a0,a0,16
    2e88:	03f57513          	andi	a0,a0,63
    2e8c:	000097b7          	lui	a5,0x9
    2e90:	00151513          	slli	a0,a0,0x1
    2e94:	84878793          	addi	a5,a5,-1976 # 8848 <g_sin64>
    2e98:	00a787b3          	add	a5,a5,a0
    2e9c:	00079503          	lh	a0,0(a5)
    2ea0:	00008067          	ret

00002ea4 <isqrt32>:
{
    2ea4:	00050713          	mv	a4,a0
    uint32_t r = 0u, b = 1u << 30;
    2ea8:	400007b7          	lui	a5,0x40000
    while (b > v) b >>= 2;
    2eac:	0080006f          	j	2eb4 <isqrt32+0x10>
    2eb0:	0027d793          	srli	a5,a5,0x2
    2eb4:	fef76ee3          	bltu	a4,a5,2eb0 <isqrt32+0xc>
    uint32_t r = 0u, b = 1u << 30;
    2eb8:	00000513          	li	a0,0
    2ebc:	00c0006f          	j	2ec8 <isqrt32+0x24>
        if (v >= r + b) { v -= r + b; r = (r >> 1) + b; } else { r >>= 1; }
    2ec0:	00155513          	srli	a0,a0,0x1
        b >>= 2;
    2ec4:	0027d793          	srli	a5,a5,0x2
    while (b) {
    2ec8:	00078e63          	beqz	a5,2ee4 <isqrt32+0x40>
        if (v >= r + b) { v -= r + b; r = (r >> 1) + b; } else { r >>= 1; }
    2ecc:	00f506b3          	add	a3,a0,a5
    2ed0:	fed768e3          	bltu	a4,a3,2ec0 <isqrt32+0x1c>
    2ed4:	40d70733          	sub	a4,a4,a3
    2ed8:	00155513          	srli	a0,a0,0x1
    2edc:	00f50533          	add	a0,a0,a5
    2ee0:	fe5ff06f          	j	2ec4 <isqrt32+0x20>
}
    2ee4:	00008067          	ret

00002ee8 <ent_clamp>:
    int sz = (int)e->sz;
    2ee8:	00954603          	lbu	a2,9(a0)
    int x = PX(e->x), y = PX(e->y);
    2eec:	00051683          	lh	a3,0(a0)
    2ef0:	4036d713          	srai	a4,a3,0x3
    2ef4:	00251783          	lh	a5,2(a0)
    2ef8:	4037d793          	srai	a5,a5,0x3
    if (x < 0) { x = 0; e->vx = (int16_t)(-e->vx); }
    2efc:	0606c463          	bltz	a3,2f64 <ent_clamp+0x7c>
    if (x > PLAY_W - sz) { x = PLAY_W - sz; e->vx = (int16_t)(-e->vx); }
    2f00:	30000693          	li	a3,768
    2f04:	40c686b3          	sub	a3,a3,a2
    2f08:	00e6da63          	bge	a3,a4,2f1c <ent_clamp+0x34>
    2f0c:	00455703          	lhu	a4,4(a0)
    2f10:	40e00733          	neg	a4,a4
    2f14:	00e51223          	sh	a4,4(a0)
    2f18:	00068713          	mv	a4,a3
    if (y < PLAY_Y0) { y = PLAY_Y0; e->vy = (int16_t)(-e->vy); }
    2f1c:	00f00693          	li	a3,15
    2f20:	00f6ca63          	blt	a3,a5,2f34 <ent_clamp+0x4c>
    2f24:	00655783          	lhu	a5,6(a0)
    2f28:	40f007b3          	neg	a5,a5
    2f2c:	00f51323          	sh	a5,6(a0)
    2f30:	01000793          	li	a5,16
    if (y > PLAY_Y1 - sz) { y = PLAY_Y1 - sz; e->vy = (int16_t)(-e->vy); }
    2f34:	21c00693          	li	a3,540
    2f38:	40c686b3          	sub	a3,a3,a2
    2f3c:	00f6da63          	bge	a3,a5,2f50 <ent_clamp+0x68>
    2f40:	00655783          	lhu	a5,6(a0)
    2f44:	40f007b3          	neg	a5,a5
    2f48:	00f51323          	sh	a5,6(a0)
    2f4c:	00068793          	mv	a5,a3
    e->x = (int16_t)FP(x); e->y = (int16_t)FP(y);
    2f50:	00371713          	slli	a4,a4,0x3
    2f54:	00e51023          	sh	a4,0(a0)
    2f58:	00379793          	slli	a5,a5,0x3
    2f5c:	00f51123          	sh	a5,2(a0)
}
    2f60:	00008067          	ret
    if (x < 0) { x = 0; e->vx = (int16_t)(-e->vx); }
    2f64:	00455703          	lhu	a4,4(a0)
    2f68:	40e00733          	neg	a4,a4
    2f6c:	00e51223          	sh	a4,4(a0)
    2f70:	00000713          	li	a4,0
    2f74:	f8dff06f          	j	2f00 <ent_clamp+0x18>

00002f78 <bul_alloc>:
    for (i = from; i < to; i++) if (g_bul[i].life == 0) return i;
    2f78:	0080006f          	j	2f80 <bul_alloc+0x8>
    2f7c:	00150513          	addi	a0,a0,1
    2f80:	02b55463          	bge	a0,a1,2fa8 <bul_alloc+0x30>
    2f84:	000137b7          	lui	a5,0x13
    2f88:	00151713          	slli	a4,a0,0x1
    2f8c:	00a70733          	add	a4,a4,a0
    2f90:	00271713          	slli	a4,a4,0x2
    2f94:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    2f98:	00e787b3          	add	a5,a5,a4
    2f9c:	00b7c783          	lbu	a5,11(a5)
    2fa0:	fc079ee3          	bnez	a5,2f7c <bul_alloc+0x4>
    2fa4:	00008067          	ret
    return -1;
    2fa8:	fff00513          	li	a0,-1
}
    2fac:	00008067          	ret

00002fb0 <bul_alloc_enemy>:
    if (g_bul_live >= g_ncap) return -1;          /* 快路径：池满直接拒绝，不扫描 */
    2fb0:	8541a783          	lw	a5,-1964(gp) # 8ccc <g_bul_live>
    2fb4:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    2fb8:	02b7d263          	bge	a5,a1,2fdc <bul_alloc_enemy+0x2c>
{
    2fbc:	ff010113          	addi	sp,sp,-16
    2fc0:	00112623          	sw	ra,12(sp)
    return bul_alloc(PLR_SLOTS, PLR_SLOTS + g_ncap);
    2fc4:	02058593          	addi	a1,a1,32
    2fc8:	02000513          	li	a0,32
    2fcc:	fadff0ef          	jal	2f78 <bul_alloc>
}
    2fd0:	00c12083          	lw	ra,12(sp)
    2fd4:	01010113          	addi	sp,sp,16
    2fd8:	00008067          	ret
    if (g_bul_live >= g_ncap) return -1;          /* 快路径：池满直接拒绝，不扫描 */
    2fdc:	fff00513          	li	a0,-1
}
    2fe0:	00008067          	ret

00002fe4 <bul_fire>:
{
    2fe4:	fe010113          	addi	sp,sp,-32
    2fe8:	00112e23          	sw	ra,28(sp)
    2fec:	00912a23          	sw	s1,20(sp)
    2ff0:	01212823          	sw	s2,16(sp)
    2ff4:	01412423          	sw	s4,8(sp)
    2ff8:	01512223          	sw	s5,4(sp)
    2ffc:	01612023          	sw	s6,0(sp)
    3000:	00050b13          	mv	s6,a0
    3004:	00058913          	mv	s2,a1
    3008:	00060a93          	mv	s5,a2
    300c:	00068a13          	mv	s4,a3
    3010:	00070493          	mv	s1,a4
    int i = bul_alloc_enemy();
    3014:	f9dff0ef          	jal	2fb0 <bul_alloc_enemy>
    if (i < 0) return;
    3018:	0c054663          	bltz	a0,30e4 <bul_fire+0x100>
    301c:	00812c23          	sw	s0,24(sp)
    3020:	01312623          	sw	s3,12(sp)
    3024:	00050413          	mv	s0,a0
    b->x = (int16_t)x; b->y = (int16_t)y;
    3028:	000139b7          	lui	s3,0x13
    302c:	00151793          	slli	a5,a0,0x1
    3030:	00a787b3          	add	a5,a5,a0
    3034:	00279793          	slli	a5,a5,0x2
    3038:	8fc98993          	addi	s3,s3,-1796 # 128fc <g_bul>
    303c:	00f989b3          	add	s3,s3,a5
    3040:	01699023          	sh	s6,0(s3)
    3044:	01299123          	sh	s2,2(s3)
    b->vx = (int16_t)((icos(ang) * spd) >> 8);
    3048:	000a8513          	mv	a0,s5
    304c:	e39ff0ef          	jal	2e84 <icos>
    3050:	03450933          	mul	s2,a0,s4
    3054:	40895913          	srai	s2,s2,0x8
    3058:	01091913          	slli	s2,s2,0x10
    305c:	41095913          	srai	s2,s2,0x10
    3060:	01299223          	sh	s2,4(s3)
    b->vy = (int16_t)((isin(ang) * spd) >> 8);
    3064:	000a8513          	mv	a0,s5
    3068:	e01ff0ef          	jal	2e68 <isin>
    306c:	03450533          	mul	a0,a0,s4
    3070:	40855513          	srai	a0,a0,0x8
    3074:	01051513          	slli	a0,a0,0x10
    3078:	41055513          	srai	a0,a0,0x10
    307c:	00a99323          	sh	a0,6(s3)
    if (b->vx == 0 && b->vy == 0) b->vy = 8;
    3080:	00091863          	bnez	s2,3090 <bul_fire+0xac>
    3084:	00051663          	bnez	a0,3090 <bul_fire+0xac>
    3088:	00800713          	li	a4,8
    308c:	00e99323          	sh	a4,6(s3)
    b->kind = (uint8_t)(S_B0 + (variant & 3));
    3090:	0034f493          	andi	s1,s1,3
    3094:	00348493          	addi	s1,s1,3
    3098:	00013737          	lui	a4,0x13
    309c:	8fc70713          	addi	a4,a4,-1796 # 128fc <g_bul>
    30a0:	00141693          	slli	a3,s0,0x1
    30a4:	008687b3          	add	a5,a3,s0
    30a8:	00279793          	slli	a5,a5,0x2
    30ac:	00f707b3          	add	a5,a4,a5
    30b0:	00978423          	sb	s1,8(a5)
    b->sz   = SZ_B;
    30b4:	01000613          	li	a2,16
    30b8:	00c784a3          	sb	a2,9(a5)
    b->r    = 4;                       /* 敌弹判定半径（比看起来小：弹幕礼仪） */
    30bc:	00400613          	li	a2,4
    30c0:	00c78523          	sb	a2,10(a5)
    b->life = BULLET_LIFE;
    30c4:	00078713          	mv	a4,a5
    30c8:	ff000793          	li	a5,-16
    30cc:	00f705a3          	sb	a5,11(a4)
    g_bul_live++;
    30d0:	8541a783          	lw	a5,-1964(gp) # 8ccc <g_bul_live>
    30d4:	00178793          	addi	a5,a5,1
    30d8:	84f1aa23          	sw	a5,-1964(gp) # 8ccc <g_bul_live>
    30dc:	01812403          	lw	s0,24(sp)
    30e0:	00c12983          	lw	s3,12(sp)
}
    30e4:	01c12083          	lw	ra,28(sp)
    30e8:	01412483          	lw	s1,20(sp)
    30ec:	01012903          	lw	s2,16(sp)
    30f0:	00812a03          	lw	s4,8(sp)
    30f4:	00412a83          	lw	s5,4(sp)
    30f8:	00012b03          	lw	s6,0(sp)
    30fc:	02010113          	addi	sp,sp,32
    3100:	00008067          	ret

00003104 <bul_fire_aim>:
{
    3104:	fd010113          	addi	sp,sp,-48
    3108:	02112623          	sw	ra,44(sp)
    310c:	01312e23          	sw	s3,28(sp)
    3110:	01412c23          	sw	s4,24(sp)
    3114:	01512a23          	sw	s5,20(sp)
    3118:	01612823          	sw	s6,16(sp)
    311c:	01712623          	sw	s7,12(sp)
    3120:	00050b93          	mv	s7,a0
    3124:	00058b13          	mv	s6,a1
    3128:	00060a13          	mv	s4,a2
    312c:	00068a93          	mv	s5,a3
    3130:	00070993          	mv	s3,a4
    int i = bul_alloc_enemy();
    3134:	e7dff0ef          	jal	2fb0 <bul_alloc_enemy>
    if (i < 0) return;
    3138:	14054263          	bltz	a0,327c <bul_fire_aim+0x178>
    313c:	02812423          	sw	s0,40(sp)
    3140:	02912223          	sw	s1,36(sp)
    3144:	03212023          	sw	s2,32(sp)
    3148:	00050913          	mv	s2,a0
    dx = (int)g_px - x; dy = (int)g_py - y;
    314c:	89e19403          	lh	s0,-1890(gp) # 8d16 <g_px>
    3150:	41740433          	sub	s0,s0,s7
    3154:	89c19483          	lh	s1,-1892(gp) # 8d14 <g_py>
    3158:	416484b3          	sub	s1,s1,s6
    d  = isqrt32((uint32_t)(dx * dx + dy * dy));
    315c:	02840533          	mul	a0,s0,s0
    3160:	029487b3          	mul	a5,s1,s1
    3164:	00f50533          	add	a0,a0,a5
    3168:	d3dff0ef          	jal	2ea4 <isqrt32>
    if (d < 1) d = 1;
    316c:	12a05863          	blez	a0,329c <bul_fire_aim+0x198>
    px = (-dy * 256) / d; py = (dx * 256) / d;      /* 垂直单位向量（定标 256） */
    3170:	40900733          	neg	a4,s1
    3174:	00871713          	slli	a4,a4,0x8
    3178:	02a74733          	div	a4,a4,a0
    317c:	00841693          	slli	a3,s0,0x8
    3180:	02a6c633          	div	a2,a3,a0
    b->x = (int16_t)x; b->y = (int16_t)y;
    3184:	000137b7          	lui	a5,0x13
    3188:	00191693          	slli	a3,s2,0x1
    318c:	012686b3          	add	a3,a3,s2
    3190:	00269693          	slli	a3,a3,0x2
    3194:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    3198:	00d787b3          	add	a5,a5,a3
    319c:	01779023          	sh	s7,0(a5)
    31a0:	01679123          	sh	s6,2(a5)
    b->vx = (int16_t)((dx * spd) / d + (px * off) / 256);
    31a4:	03540433          	mul	s0,s0,s5
    31a8:	02a44433          	div	s0,s0,a0
    31ac:	03470733          	mul	a4,a4,s4
    31b0:	41f75693          	srai	a3,a4,0x1f
    31b4:	0ff6f693          	zext.b	a3,a3
    31b8:	00e68733          	add	a4,a3,a4
    31bc:	40875713          	srai	a4,a4,0x8
    31c0:	00e40433          	add	s0,s0,a4
    31c4:	01041413          	slli	s0,s0,0x10
    31c8:	41045413          	srai	s0,s0,0x10
    31cc:	00879223          	sh	s0,4(a5)
    b->vy = (int16_t)((dy * spd) / d + (py * off) / 256);
    31d0:	035484b3          	mul	s1,s1,s5
    31d4:	02a4c4b3          	div	s1,s1,a0
    31d8:	034606b3          	mul	a3,a2,s4
    31dc:	41f6d713          	srai	a4,a3,0x1f
    31e0:	0ff77713          	zext.b	a4,a4
    31e4:	00d70733          	add	a4,a4,a3
    31e8:	40875713          	srai	a4,a4,0x8
    31ec:	00e484b3          	add	s1,s1,a4
    31f0:	01049493          	slli	s1,s1,0x10
    31f4:	4104d493          	srai	s1,s1,0x10
    31f8:	00979323          	sh	s1,6(a5)
    if (b->vx == 0 && b->vy == 0) b->vy = 8;
    31fc:	02041463          	bnez	s0,3224 <bul_fire_aim+0x120>
    3200:	02049263          	bnez	s1,3224 <bul_fire_aim+0x120>
    3204:	000137b7          	lui	a5,0x13
    3208:	00191713          	slli	a4,s2,0x1
    320c:	01270733          	add	a4,a4,s2
    3210:	00271713          	slli	a4,a4,0x2
    3214:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    3218:	00e787b3          	add	a5,a5,a4
    321c:	00800713          	li	a4,8
    3220:	00e79323          	sh	a4,6(a5)
    b->kind = (uint8_t)(S_B0 + (variant & 3));
    3224:	0039f993          	andi	s3,s3,3
    3228:	00398993          	addi	s3,s3,3
    322c:	00013737          	lui	a4,0x13
    3230:	8fc70713          	addi	a4,a4,-1796 # 128fc <g_bul>
    3234:	00191693          	slli	a3,s2,0x1
    3238:	012687b3          	add	a5,a3,s2
    323c:	00279793          	slli	a5,a5,0x2
    3240:	00f707b3          	add	a5,a4,a5
    3244:	01378423          	sb	s3,8(a5)
    b->sz   = SZ_B;
    3248:	01000613          	li	a2,16
    324c:	00c784a3          	sb	a2,9(a5)
    b->r    = 4;
    3250:	00400613          	li	a2,4
    3254:	00c78523          	sb	a2,10(a5)
    b->life = BULLET_LIFE;
    3258:	00078713          	mv	a4,a5
    325c:	ff000793          	li	a5,-16
    3260:	00f705a3          	sb	a5,11(a4)
    g_bul_live++;
    3264:	8541a783          	lw	a5,-1964(gp) # 8ccc <g_bul_live>
    3268:	00178793          	addi	a5,a5,1
    326c:	84f1aa23          	sw	a5,-1964(gp) # 8ccc <g_bul_live>
    3270:	02812403          	lw	s0,40(sp)
    3274:	02412483          	lw	s1,36(sp)
    3278:	02012903          	lw	s2,32(sp)
}
    327c:	02c12083          	lw	ra,44(sp)
    3280:	01c12983          	lw	s3,28(sp)
    3284:	01812a03          	lw	s4,24(sp)
    3288:	01412a83          	lw	s5,20(sp)
    328c:	01012b03          	lw	s6,16(sp)
    3290:	00c12b83          	lw	s7,12(sp)
    3294:	03010113          	addi	sp,sp,48
    3298:	00008067          	ret
    if (d < 1) d = 1;
    329c:	00100513          	li	a0,1
    32a0:	ed1ff06f          	j	3170 <bul_fire_aim+0x6c>

000032a4 <ent_step>:
    if (e->life == 0) return 0;
    32a4:	00b54783          	lbu	a5,11(a0)
    32a8:	08078a63          	beqz	a5,333c <ent_step+0x98>
    e->life--;
    32ac:	fff78793          	addi	a5,a5,-1
    32b0:	00f505a3          	sb	a5,11(a0)
    e->x = (int16_t)(e->x + e->vx);
    32b4:	00055783          	lhu	a5,0(a0)
    32b8:	00455703          	lhu	a4,4(a0)
    32bc:	00e787b3          	add	a5,a5,a4
    32c0:	01079793          	slli	a5,a5,0x10
    32c4:	4107d793          	srai	a5,a5,0x10
    32c8:	00f51023          	sh	a5,0(a0)
    e->y = (int16_t)(e->y + e->vy);
    32cc:	00255703          	lhu	a4,2(a0)
    32d0:	00655683          	lhu	a3,6(a0)
    32d4:	00d70733          	add	a4,a4,a3
    32d8:	01071713          	slli	a4,a4,0x10
    32dc:	41075713          	srai	a4,a4,0x10
    32e0:	00e51123          	sh	a4,2(a0)
    x = PX(e->x); y = PX(e->y);
    32e4:	4037d793          	srai	a5,a5,0x3
    32e8:	40375713          	srai	a4,a4,0x3
    if (wrap) { ent_clamp(e); return 1; }
    32ec:	02059463          	bnez	a1,3314 <ent_step+0x70>
    if (x < -32 || x > PLAY_W + 32 || y < PLAY_Y0 - 48 || y > PLAY_Y1 + 48) { e->life = 0; return 0; }
    32f0:	02078793          	addi	a5,a5,32
    32f4:	34000693          	li	a3,832
    32f8:	02f6ec63          	bltu	a3,a5,3330 <ent_step+0x8c>
    32fc:	fe000793          	li	a5,-32
    3300:	02f74863          	blt	a4,a5,3330 <ent_step+0x8c>
    3304:	24c00793          	li	a5,588
    3308:	02e7c463          	blt	a5,a4,3330 <ent_step+0x8c>
    return 1;
    330c:	00100513          	li	a0,1
}
    3310:	00008067          	ret
{
    3314:	ff010113          	addi	sp,sp,-16
    3318:	00112623          	sw	ra,12(sp)
    if (wrap) { ent_clamp(e); return 1; }
    331c:	bcdff0ef          	jal	2ee8 <ent_clamp>
    3320:	00100513          	li	a0,1
}
    3324:	00c12083          	lw	ra,12(sp)
    3328:	01010113          	addi	sp,sp,16
    332c:	00008067          	ret
    if (x < -32 || x > PLAY_W + 32 || y < PLAY_Y0 - 48 || y > PLAY_Y1 + 48) { e->life = 0; return 0; }
    3330:	000505a3          	sb	zero,11(a0)
    3334:	00058513          	mv	a0,a1
    3338:	00008067          	ret
    if (e->life == 0) return 0;
    333c:	00000513          	li	a0,0
    3340:	00008067          	ret

00003344 <hit_cc>:
    int dx = ax - bx, dy = ay - by, rr = ar + br;
    3344:	40d50533          	sub	a0,a0,a3
    3348:	40e585b3          	sub	a1,a1,a4
    334c:	00f60633          	add	a2,a2,a5
    return (dx * dx + dy * dy) <= (rr * rr);
    3350:	02a50533          	mul	a0,a0,a0
    3354:	02b585b3          	mul	a1,a1,a1
    3358:	00b50533          	add	a0,a0,a1
    335c:	02c60633          	mul	a2,a2,a2
    3360:	00a62533          	slt	a0,a2,a0
}
    3364:	00153513          	seqz	a0,a0
    3368:	00008067          	ret

0000336c <enemy_fire>:
{
    336c:	fe010113          	addi	sp,sp,-32
    3370:	00112e23          	sw	ra,28(sp)
    3374:	00912a23          	sw	s1,20(sp)
    3378:	01212823          	sw	s2,16(sp)
    337c:	01312623          	sw	s3,12(sp)
    3380:	00050493          	mv	s1,a0
    spd = 14 + level * 2; if (spd > 34) spd = 34;
    3384:	00758913          	addi	s2,a1,7
    3388:	00191913          	slli	s2,s2,0x1
    338c:	02200793          	li	a5,34
    3390:	0127d463          	bge	a5,s2,3398 <enemy_fire+0x2c>
    3394:	02200913          	li	s2,34
    ph  = (int)e->phase;
    3398:	00c4c983          	lbu	s3,12(s1)
    switch (e->kind & 3) {
    339c:	00a4c783          	lbu	a5,10(s1)
    33a0:	0037f793          	andi	a5,a5,3
    33a4:	04078263          	beqz	a5,33e8 <enemy_fire+0x7c>
    33a8:	00100713          	li	a4,1
    33ac:	0ce78063          	beq	a5,a4,346c <enemy_fire+0x100>
        bul_fire(e->x, e->y, ph, spd + 4, 2);
    33b0:	00490913          	addi	s2,s2,4
    33b4:	00200713          	li	a4,2
    33b8:	00090693          	mv	a3,s2
    33bc:	00098613          	mv	a2,s3
    33c0:	00249583          	lh	a1,2(s1)
    33c4:	00049503          	lh	a0,0(s1)
    33c8:	c1dff0ef          	jal	2fe4 <bul_fire>
        bul_fire(e->x, e->y, ph + 32, spd + 4, 2);
    33cc:	00200713          	li	a4,2
    33d0:	00090693          	mv	a3,s2
    33d4:	02098613          	addi	a2,s3,32
    33d8:	00249583          	lh	a1,2(s1)
    33dc:	00049503          	lh	a0,0(s1)
    33e0:	c05ff0ef          	jal	2fe4 <bul_fire>
        break;
    33e4:	0680006f          	j	344c <enemy_fire+0xe0>
    33e8:	00812c23          	sw	s0,24(sp)
    33ec:	01412423          	sw	s4,8(sp)
        k = 8 + level * 2 + g_ncap / 192; if (k > 24) k = 24;
    33f0:	00458413          	addi	s0,a1,4
    33f4:	00141413          	slli	s0,s0,0x1
    33f8:	81c1a783          	lw	a5,-2020(gp) # 8c94 <g_ncap>
    33fc:	0c000713          	li	a4,192
    3400:	02e7c7b3          	div	a5,a5,a4
    3404:	00f40433          	add	s0,s0,a5
    3408:	01800793          	li	a5,24
    340c:	0087d463          	bge	a5,s0,3414 <enemy_fire+0xa8>
    3410:	01800413          	li	s0,24
        for (i = 0; i < k; i++) bul_fire(e->x, e->y, ph + (i * 64) / k, spd, i);
    3414:	00000a13          	li	s4,0
    3418:	0280006f          	j	3440 <enemy_fire+0xd4>
    341c:	006a1613          	slli	a2,s4,0x6
    3420:	02864633          	div	a2,a2,s0
    3424:	000a0713          	mv	a4,s4
    3428:	00090693          	mv	a3,s2
    342c:	01360633          	add	a2,a2,s3
    3430:	00249583          	lh	a1,2(s1)
    3434:	00049503          	lh	a0,0(s1)
    3438:	badff0ef          	jal	2fe4 <bul_fire>
    343c:	001a0a13          	addi	s4,s4,1
    3440:	fc8a4ee3          	blt	s4,s0,341c <enemy_fire+0xb0>
    3444:	01812403          	lw	s0,24(sp)
    3448:	00812a03          	lw	s4,8(sp)
    e->phase = (uint8_t)(ph + 5);
    344c:	00598993          	addi	s3,s3,5
    3450:	01348623          	sb	s3,12(s1)
}
    3454:	01c12083          	lw	ra,28(sp)
    3458:	01412483          	lw	s1,20(sp)
    345c:	01012903          	lw	s2,16(sp)
    3460:	00c12983          	lw	s3,12(sp)
    3464:	02010113          	addi	sp,sp,32
    3468:	00008067          	ret
    346c:	00812c23          	sw	s0,24(sp)
    3470:	01412423          	sw	s4,8(sp)
        k = 3 + level; if (k > 7) k = 7;
    3474:	00358413          	addi	s0,a1,3
    3478:	00700793          	li	a5,7
    347c:	0087d463          	bge	a5,s0,3484 <enemy_fire+0x118>
    3480:	00700413          	li	s0,7
        for (i = 0; i < k; i++) bul_fire_aim(e->x, e->y, (i - (k - 1) / 2) * 26, spd + 6, 1);
    3484:	00000a13          	li	s4,0
    3488:	0380006f          	j	34c0 <enemy_fire+0x154>
    348c:	fff40713          	addi	a4,s0,-1
    3490:	01f75793          	srli	a5,a4,0x1f
    3494:	00e787b3          	add	a5,a5,a4
    3498:	4017d793          	srai	a5,a5,0x1
    349c:	40fa07b3          	sub	a5,s4,a5
    34a0:	00100713          	li	a4,1
    34a4:	00690693          	addi	a3,s2,6
    34a8:	01a00613          	li	a2,26
    34ac:	02c78633          	mul	a2,a5,a2
    34b0:	00249583          	lh	a1,2(s1)
    34b4:	00049503          	lh	a0,0(s1)
    34b8:	c4dff0ef          	jal	3104 <bul_fire_aim>
    34bc:	001a0a13          	addi	s4,s4,1
    34c0:	fc8a46e3          	blt	s4,s0,348c <enemy_fire+0x120>
    34c4:	01812403          	lw	s0,24(sp)
    34c8:	00812a03          	lw	s4,8(sp)
    34cc:	f81ff06f          	j	344c <enemy_fire+0xe0>

000034d0 <cyc_of>:
    if (op == DRAW_KEY)                                 { a = CYC_A_KEY;   b = CYC_B_KEY;   }
    34d0:	00200793          	li	a5,2
    34d4:	02f50e63          	beq	a0,a5,3510 <cyc_of+0x40>
    else if (op == DRAW_GLOW || op == DRAW_ALPHA)       { a = CYC_A_ALPHA; b = CYC_B_ALPHA; }
    34d8:	ffd50513          	addi	a0,a0,-3
    34dc:	00100793          	li	a5,1
    34e0:	02a7f263          	bgeu	a5,a0,3504 <cyc_of+0x34>
    else                                                { a = CYC_A_FILL;  b = CYC_B_FILL;  }
    34e4:	40100793          	li	a5,1025
    34e8:	0fc00513          	li	a0,252
    return a + ((uint32_t)(sz * sz) * b) / 1000u;
    34ec:	02b585b3          	mul	a1,a1,a1
    34f0:	02f585b3          	mul	a1,a1,a5
    34f4:	3e800793          	li	a5,1000
    34f8:	02f5d5b3          	divu	a1,a1,a5
}
    34fc:	00a58533          	add	a0,a1,a0
    3500:	00008067          	ret
    else if (op == DRAW_GLOW || op == DRAW_ALPHA)       { a = CYC_A_ALPHA; b = CYC_B_ALPHA; }
    3504:	5fd00793          	li	a5,1533
    3508:	1d000513          	li	a0,464
    350c:	fe1ff06f          	j	34ec <cyc_of+0x1c>
    if (op == DRAW_KEY)                                 { a = CYC_A_KEY;   b = CYC_B_KEY;   }
    3510:	4e700793          	li	a5,1255
    3514:	18e00513          	li	a0,398
    3518:	fd5ff06f          	j	34ec <cyc_of+0x1c>

0000351c <cost_capacity>:
{
    351c:	ff010113          	addi	sp,sp,-16
    3520:	00112623          	sw	ra,12(sp)
    3524:	00812423          	sw	s0,8(sp)
    3528:	00912223          	sw	s1,4(sp)
    352c:	01212023          	sw	s2,0(sp)
    3530:	00050413          	mv	s0,a0
    3534:	00060493          	mv	s1,a2
    3538:	00068913          	mv	s2,a3
    uint32_t per = cyc_of(op, sz);
    353c:	f95ff0ef          	jal	34d0 <cyc_of>
                 : ((op == DRAW_GLOW || op == DRAW_ALPHA) ? CYC_A_ALPHA : CYC_A_FILL);
    3540:	00200793          	li	a5,2
    3544:	04f40c63          	beq	s0,a5,359c <cost_capacity+0x80>
    3548:	ffd40413          	addi	s0,s0,-3
    354c:	00100793          	li	a5,1
    3550:	0487f263          	bgeu	a5,s0,3594 <cost_capacity+0x78>
    3554:	0fc00713          	li	a4,252
    uint32_t budget = (FRAME_TICKS_60FPS / 100u) * (uint32_t)pct;
    3558:	000047b7          	lui	a5,0x4
    355c:	11a78793          	addi	a5,a5,282 # 411a <cpu_blit+0xe6>
    3560:	02f484b3          	mul	s1,s1,a5
    if (dual) per = a + (per - a) / 2u;
    3564:	00090863          	beqz	s2,3574 <cost_capacity+0x58>
    3568:	40e50533          	sub	a0,a0,a4
    356c:	00155513          	srli	a0,a0,0x1
    3570:	00e50533          	add	a0,a0,a4
    if (per == 0u) return 0u;
    3574:	00050463          	beqz	a0,357c <cost_capacity+0x60>
    return budget / per;
    3578:	02a4d533          	divu	a0,s1,a0
}
    357c:	00c12083          	lw	ra,12(sp)
    3580:	00812403          	lw	s0,8(sp)
    3584:	00412483          	lw	s1,4(sp)
    3588:	00012903          	lw	s2,0(sp)
    358c:	01010113          	addi	sp,sp,16
    3590:	00008067          	ret
                 : ((op == DRAW_GLOW || op == DRAW_ALPHA) ? CYC_A_ALPHA : CYC_A_FILL);
    3594:	1d000713          	li	a4,464
    3598:	fc1ff06f          	j	3558 <cost_capacity+0x3c>
    359c:	18e00713          	li	a4,398
    35a0:	fb9ff06f          	j	3558 <cost_capacity+0x3c>

000035a4 <ramp_apply>:
{
    35a4:	00050793          	mv	a5,a0
    int prev = *ncap;
    35a8:	0005a703          	lw	a4,0(a1)
    if (!*auto_on) return 0;
    35ac:	0006a503          	lw	a0,0(a3)
    35b0:	0a050063          	beqz	a0,3650 <ramp_apply+0xac>
    if (fps <= 0) return 0;                       /* 还没有效窗口 */
    35b4:	08f05c63          	blez	a5,364c <ramp_apply+0xa8>
    if (fps >= 58) {
    35b8:	03900513          	li	a0,57
    35bc:	04f55c63          	bge	a0,a5,3614 <ramp_apply+0x70>
        step = prev / 8;
    35c0:	41f75793          	srai	a5,a4,0x1f
    35c4:	0077f793          	andi	a5,a5,7
    35c8:	00e787b3          	add	a5,a5,a4
    35cc:	4037d793          	srai	a5,a5,0x3
        if (step < N_STEP) step = N_STEP;
    35d0:	1ff00513          	li	a0,511
    35d4:	00e54463          	blt	a0,a4,35dc <ramp_apply+0x38>
    35d8:	04000793          	li	a5,64
        if (prev + step >= N_MAX) { *ncap = N_MAX; *lim_n = N_MAX; *auto_on = 0; return 2; }
    35dc:	00e787b3          	add	a5,a5,a4
    35e0:	00001737          	lui	a4,0x1
    35e4:	95f70713          	addi	a4,a4,-1697 # 95f <CUSTOM2+0x904>
    35e8:	00f74863          	blt	a4,a5,35f8 <ramp_apply+0x54>
        *ncap = prev + step;
    35ec:	00f5a023          	sw	a5,0(a1)
        return 1;
    35f0:	00100513          	li	a0,1
    35f4:	00008067          	ret
        if (prev + step >= N_MAX) { *ncap = N_MAX; *lim_n = N_MAX; *auto_on = 0; return 2; }
    35f8:	000017b7          	lui	a5,0x1
    35fc:	96078793          	addi	a5,a5,-1696 # 960 <CUSTOM2+0x905>
    3600:	00f5a023          	sw	a5,0(a1)
    3604:	00f62023          	sw	a5,0(a2)
    3608:	0006a023          	sw	zero,0(a3)
    360c:	00200513          	li	a0,2
    3610:	00008067          	ret
    *ncap = (prev > N_MIN) ? (prev - prev / 8) : N_MIN;
    3614:	04000793          	li	a5,64
    3618:	02e7d663          	bge	a5,a4,3644 <ramp_apply+0xa0>
    361c:	41f75793          	srai	a5,a4,0x1f
    3620:	0077f793          	andi	a5,a5,7
    3624:	00e787b3          	add	a5,a5,a4
    3628:	4037d793          	srai	a5,a5,0x3
    362c:	40f70733          	sub	a4,a4,a5
    3630:	00e5a023          	sw	a4,0(a1)
    *lim_n = *ncap;
    3634:	00e62023          	sw	a4,0(a2)
    *auto_on = 0;
    3638:	0006a023          	sw	zero,0(a3)
    return -1;
    363c:	fff00513          	li	a0,-1
    3640:	00008067          	ret
    *ncap = (prev > N_MIN) ? (prev - prev / 8) : N_MIN;
    3644:	04000713          	li	a4,64
    3648:	fe9ff06f          	j	3630 <ramp_apply+0x8c>
    if (fps <= 0) return 0;                       /* 还没有效窗口 */
    364c:	00000513          	li	a0,0
}
    3650:	00008067          	ret

00003654 <dl_push>:
    if (g_dl_n >= DRAW_MAX) return;
    3654:	8b41ae03          	lw	t3,-1868(gp) # 8d2c <g_dl_n>
    3658:	00001337          	lui	t1,0x1
    365c:	a5f30313          	addi	t1,t1,-1441 # a5f <CUSTOM2+0xa04>
    3660:	05c34863          	blt	t1,t3,36b0 <dl_push+0x5c>
    d = &g_dl[g_dl_n++];
    3664:	001e0e93          	addi	t4,t3,1
    3668:	8bd1aa23          	sw	t4,-1868(gp) # 8d2c <g_dl_n>
    d->x = (int16_t)x; d->y = (int16_t)y;
    366c:	00009eb7          	lui	t4,0x9
    3670:	1bce8e93          	addi	t4,t4,444 # 91bc <g_dl>
    3674:	003e1f13          	slli	t5,t3,0x3
    3678:	41cf0333          	sub	t1,t5,t3
    367c:	00131313          	slli	t1,t1,0x1
    3680:	006e8333          	add	t1,t4,t1
    3684:	00b31023          	sh	a1,0(t1)
    3688:	00c31123          	sh	a2,2(t1)
    d->arg = arg; d->op = op;
    368c:	00d31223          	sh	a3,4(t1)
    3690:	00a30323          	sb	a0,6(t1)
    d->w = (uint8_t)w; d->h = (uint8_t)h;
    3694:	00e303a3          	sb	a4,7(t1)
    3698:	00f30423          	sb	a5,8(t1)
    d->ga = ga; d->sx = sx; d->sy = sy; d->rsv = 0;
    369c:	010304a3          	sb	a6,9(t1)
    36a0:	01130523          	sb	a7,10(t1)
    36a4:	00014783          	lbu	a5,0(sp)
    36a8:	00f305a3          	sb	a5,11(t1)
    36ac:	00030623          	sb	zero,12(t1)
}
    36b0:	00008067          	ret

000036b4 <dl_rect_op>:
{
    36b4:	00058e13          	mv	t3,a1
    int x0 = PX(cx) - sz / 2, y0 = PX(cy) - sz / 2;
    36b8:	40365893          	srai	a7,a2,0x3
    36bc:	01f75613          	srli	a2,a4,0x1f
    36c0:	00e60633          	add	a2,a2,a4
    36c4:	40165613          	srai	a2,a2,0x1
    36c8:	40c00633          	neg	a2,a2
    36cc:	00c885b3          	add	a1,a7,a2
    36d0:	4036d693          	srai	a3,a3,0x3
    36d4:	00d60633          	add	a2,a2,a3
    int x1 = x0 + sz, y1 = y0 + sz;
    36d8:	00b70333          	add	t1,a4,a1
    36dc:	00c70733          	add	a4,a4,a2
    if (x0 < 0)                { sx = -x0; x0 = 0; }
    36e0:	0405c663          	bltz	a1,372c <dl_rect_op+0x78>
    int sx = 0, sy = 0;
    36e4:	00000893          	li	a7,0
    if (y0 < PLAY_Y0)          { sy = PLAY_Y0 - y0; y0 = PLAY_Y0; }
    36e8:	00f00693          	li	a3,15
    36ec:	04c6c663          	blt	a3,a2,3738 <dl_rect_op+0x84>
    36f0:	01000693          	li	a3,16
    36f4:	40c686b3          	sub	a3,a3,a2
    36f8:	01000613          	li	a2,16
    if (x1 > PLAY_W)           x1 = PLAY_W;
    36fc:	30000813          	li	a6,768
    3700:	00685463          	bge	a6,t1,3708 <dl_rect_op+0x54>
    3704:	30000313          	li	t1,768
    if (y1 > FB_HEIGHT)        y1 = FB_HEIGHT;
    3708:	21c00813          	li	a6,540
    370c:	00e85463          	bge	a6,a4,3714 <dl_rect_op+0x60>
    3710:	21c00713          	li	a4,540
    if (x1 <= x0 || y1 <= y0)  { g_clip_drop++; return; }      /* 完全在区外 */
    3714:	0065d463          	bge	a1,t1,371c <dl_rect_op+0x68>
    3718:	02e64463          	blt	a2,a4,3740 <dl_rect_op+0x8c>
    371c:	8ac1a783          	lw	a5,-1876(gp) # 8d24 <g_clip_drop>
    3720:	00178793          	addi	a5,a5,1
    3724:	8af1a623          	sw	a5,-1876(gp) # 8d24 <g_clip_drop>
    3728:	00008067          	ret
    if (x0 < 0)                { sx = -x0; x0 = 0; }
    372c:	40b008b3          	neg	a7,a1
    3730:	00000593          	li	a1,0
    3734:	fb5ff06f          	j	36e8 <dl_rect_op+0x34>
    int sx = 0, sy = 0;
    3738:	00000693          	li	a3,0
    373c:	fc1ff06f          	j	36fc <dl_rect_op+0x48>
{
    3740:	fe010113          	addi	sp,sp,-32
    3744:	00112e23          	sw	ra,28(sp)
    dl_push((uint8_t)op, x0, y0, arg, x1 - x0, y1 - y0, ga, (uint8_t)sx, (uint8_t)sy);
    3748:	0ff6f693          	zext.b	a3,a3
    374c:	00d12023          	sw	a3,0(sp)
    3750:	0ff8f893          	zext.b	a7,a7
    3754:	00078813          	mv	a6,a5
    3758:	40c707b3          	sub	a5,a4,a2
    375c:	40b30733          	sub	a4,t1,a1
    3760:	000e0693          	mv	a3,t3
    3764:	0ff57513          	zext.b	a0,a0
    3768:	eedff0ef          	jal	3654 <dl_push>
}
    376c:	01c12083          	lw	ra,28(sp)
    3770:	02010113          	addi	sp,sp,32
    3774:	00008067          	ret

00003778 <dl_sprite>:
{
    3778:	ff010113          	addi	sp,sp,-16
    377c:	00112623          	sw	ra,12(sp)
    3780:	00050813          	mv	a6,a0
    3784:	00068793          	mv	a5,a3
    dl_rect_op((spr == S_PR || spr == S_EN) ? DRAW_KEY : DRAW_GLOW,
    3788:	00100713          	li	a4,1
    378c:	02a77a63          	bgeu	a4,a0,37c0 <dl_sprite+0x48>
    3790:	00300513          	li	a0,3
               (uint16_t)spr, cx, cy, (int)g_spr_sz[spr], ga);
    3794:	84018713          	addi	a4,gp,-1984 # 8cb8 <g_spr_sz>
    3798:	01070733          	add	a4,a4,a6
    dl_rect_op((spr == S_PR || spr == S_EN) ? DRAW_KEY : DRAW_GLOW,
    379c:	00074703          	lbu	a4,0(a4)
    37a0:	00060693          	mv	a3,a2
    37a4:	00058613          	mv	a2,a1
    37a8:	01081593          	slli	a1,a6,0x10
    37ac:	0105d593          	srli	a1,a1,0x10
    37b0:	f05ff0ef          	jal	36b4 <dl_rect_op>
}
    37b4:	00c12083          	lw	ra,12(sp)
    37b8:	01010113          	addi	sp,sp,16
    37bc:	00008067          	ret
    dl_rect_op((spr == S_PR || spr == S_EN) ? DRAW_KEY : DRAW_GLOW,
    37c0:	00200513          	li	a0,2
    37c4:	fd1ff06f          	j	3794 <dl_sprite+0x1c>

000037c8 <dl_bullet>:
{
    37c8:	ff010113          	addi	sp,sp,-16
    37cc:	00112623          	sw	ra,12(sp)
    int sz = (int)b->sz;
    37d0:	00954703          	lbu	a4,9(a0)
    switch (g_bulm) {
    37d4:	8381a783          	lw	a5,-1992(gp) # 8cb0 <g_bulm>
    37d8:	00100693          	li	a3,1
    37dc:	04d78463          	beq	a5,a3,3824 <dl_bullet+0x5c>
    37e0:	00200693          	li	a3,2
    37e4:	04d78e63          	beq	a5,a3,3840 <dl_bullet+0x78>
    37e8:	06079a63          	bnez	a5,385c <dl_bullet+0x94>
        dl_rect_op(DRAW_FILL, g_spr_fill[b->kind], b->x, b->y, sz, 0u);
    37ec:	00854783          	lbu	a5,8(a0)
    37f0:	000095b7          	lui	a1,0x9
    37f4:	00179793          	slli	a5,a5,0x1
    37f8:	b4458593          	addi	a1,a1,-1212 # 8b44 <g_spr_fill>
    37fc:	00f585b3          	add	a1,a1,a5
    3800:	00000793          	li	a5,0
    3804:	00251683          	lh	a3,2(a0)
    3808:	00051603          	lh	a2,0(a0)
    380c:	0005d583          	lhu	a1,0(a1)
    3810:	00100513          	li	a0,1
    3814:	ea1ff0ef          	jal	36b4 <dl_rect_op>
}
    3818:	00c12083          	lw	ra,12(sp)
    381c:	01010113          	addi	sp,sp,16
    3820:	00008067          	ret
        dl_rect_op(DRAW_ALPHA, (uint16_t)b->kind, b->x, b->y, sz, BUL_ALPHA_V);
    3824:	0a000793          	li	a5,160
    3828:	00251683          	lh	a3,2(a0)
    382c:	00051603          	lh	a2,0(a0)
    3830:	00854583          	lbu	a1,8(a0)
    3834:	00400513          	li	a0,4
    3838:	e7dff0ef          	jal	36b4 <dl_rect_op>
        break;
    383c:	fddff06f          	j	3818 <dl_bullet+0x50>
        dl_rect_op(DRAW_GLOW, (uint16_t)b->kind, b->x, b->y, sz, 255u);
    3840:	0ff00793          	li	a5,255
    3844:	00251683          	lh	a3,2(a0)
    3848:	00051603          	lh	a2,0(a0)
    384c:	00854583          	lbu	a1,8(a0)
    3850:	00300513          	li	a0,3
    3854:	e61ff0ef          	jal	36b4 <dl_rect_op>
        break;
    3858:	fc1ff06f          	j	3818 <dl_bullet+0x50>
        dl_rect_op(DRAW_KEY, (uint16_t)b->kind, b->x, b->y, sz, 0u);
    385c:	00000793          	li	a5,0
    3860:	00251683          	lh	a3,2(a0)
    3864:	00051603          	lh	a2,0(a0)
    3868:	00854583          	lbu	a1,8(a0)
    386c:	00200513          	li	a0,2
    3870:	e45ff0ef          	jal	36b4 <dl_rect_op>
}
    3874:	fa5ff06f          	j	3818 <dl_bullet+0x50>

00003878 <bg_copy>:
{
    3878:	fe010113          	addi	sp,sp,-32
    387c:	00112e23          	sw	ra,28(sp)
    blt_emit(ATTR_DEFAULT, BLT_OP_COPY, BG_DDR,
    3880:	00000693          	li	a3,0
    3884:	0ff00613          	li	a2,255
    3888:	00000593          	li	a1,0
    388c:	00000513          	li	a0,0
    3890:	ff4fe0ef          	jal	2084 <attr_word>
    3894:	8341a603          	lw	a2,-1996(gp) # 8cac <g_fb_back>
    3898:	000086b7          	lui	a3,0x8
    389c:	80068693          	addi	a3,a3,-2048 # 7800 <_data+0x5b4>
    38a0:	00012223          	sw	zero,4(sp)
    38a4:	0ff00793          	li	a5,255
    38a8:	00f12023          	sw	a5,0(sp)
    38ac:	20c00893          	li	a7,524
    38b0:	30000813          	li	a6,768
    38b4:	78000793          	li	a5,1920
    38b8:	60000713          	li	a4,1536
    38bc:	00d606b3          	add	a3,a2,a3
    38c0:	00a01637          	lui	a2,0xa01
    38c4:	00000593          	li	a1,0
    38c8:	d55fe0ef          	jal	261c <blt_emit>
}
    38cc:	01c12083          	lw	ra,28(sp)
    38d0:	02010113          	addi	sp,sp,32
    38d4:	00008067          	ret

000038d8 <build_draw_list>:
{
    38d8:	fe010113          	addi	sp,sp,-32
    38dc:	00112e23          	sw	ra,28(sp)
    38e0:	00812c23          	sw	s0,24(sp)
    g_dl_n = 0;
    38e4:	8a01aa23          	sw	zero,-1868(gp) # 8d2c <g_dl_n>
    g_clip_drop = 0;
    38e8:	8a01a623          	sw	zero,-1876(gp) # 8d24 <g_clip_drop>
    if (repaint) bg_copy();                     /* 真图整片覆盖 = 既清屏又铺底 */
    38ec:	00051663          	bnez	a0,38f8 <build_draw_list+0x20>
        if (sy > PLAY_Y1 - 2)  sy = PLAY_Y1 - 2;
    38f0:	00000413          	li	s0,0
    38f4:	0400006f          	j	3934 <build_draw_list+0x5c>
    if (repaint) bg_copy();                     /* 真图整片覆盖 = 既清屏又铺底 */
    38f8:	f81ff0ef          	jal	3878 <bg_copy>
    38fc:	ff5ff06f          	j	38f0 <build_draw_list+0x18>
        dl_push(DRAW_FILL, sx, sy, g_star[i].col, 2, 2, 0u, 0u, 0u);
    3900:	000096b7          	lui	a3,0x9
    3904:	00341793          	slli	a5,s0,0x3
    3908:	dbc68693          	addi	a3,a3,-580 # 8dbc <g_star>
    390c:	00f686b3          	add	a3,a3,a5
    3910:	00012023          	sw	zero,0(sp)
    3914:	00000893          	li	a7,0
    3918:	00000813          	li	a6,0
    391c:	00200793          	li	a5,2
    3920:	00200713          	li	a4,2
    3924:	0046d683          	lhu	a3,4(a3)
    3928:	00100513          	li	a0,1
    392c:	d29ff0ef          	jal	3654 <dl_push>
    for (i = 0; i < g_star_n; i++) {
    3930:	00140413          	addi	s0,s0,1
    3934:	8241a783          	lw	a5,-2012(gp) # 8c9c <g_star_n>
    3938:	02f45c63          	bge	s0,a5,3970 <build_draw_list+0x98>
        int sx = g_star[i].x, sy = g_star[i].y;
    393c:	000097b7          	lui	a5,0x9
    3940:	00341713          	slli	a4,s0,0x3
    3944:	dbc78793          	addi	a5,a5,-580 # 8dbc <g_star>
    3948:	00e787b3          	add	a5,a5,a4
    394c:	00079583          	lh	a1,0(a5)
    3950:	00279603          	lh	a2,2(a5)
        if (sx > PLAY_W - 2) sx = PLAY_W - 2;               /* 2x2 不许出右边界 */
    3954:	2fe00793          	li	a5,766
    3958:	00b7d463          	bge	a5,a1,3960 <build_draw_list+0x88>
    395c:	2fe00593          	li	a1,766
        if (sy > PLAY_Y1 - 2)  sy = PLAY_Y1 - 2;
    3960:	21a00793          	li	a5,538
    3964:	f8c7dee3          	bge	a5,a2,3900 <build_draw_list+0x28>
    3968:	21a00613          	li	a2,538
    396c:	f95ff06f          	j	3900 <build_draw_list+0x28>
    for (i = 0; i < BUL_TOTAL; i++)
    3970:	00000413          	li	s0,0
    3974:	0340006f          	j	39a8 <build_draw_list+0xd0>
            if (i < PLR_SLOTS) dl_sprite(g_bul[i].kind, g_bul[i].x, g_bul[i].y, 255u); /* 自机弹固定加算 */
    3978:	000137b7          	lui	a5,0x13
    397c:	00141713          	slli	a4,s0,0x1
    3980:	00870733          	add	a4,a4,s0
    3984:	00271713          	slli	a4,a4,0x2
    3988:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    398c:	00e787b3          	add	a5,a5,a4
    3990:	0ff00693          	li	a3,255
    3994:	00279603          	lh	a2,2(a5)
    3998:	00079583          	lh	a1,0(a5)
    399c:	0087c503          	lbu	a0,8(a5)
    39a0:	dd9ff0ef          	jal	3778 <dl_sprite>
    for (i = 0; i < BUL_TOTAL; i++)
    39a4:	00140413          	addi	s0,s0,1
    39a8:	000017b7          	lui	a5,0x1
    39ac:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    39b0:	0487c663          	blt	a5,s0,39fc <build_draw_list+0x124>
        if (g_bul[i].life) {
    39b4:	000137b7          	lui	a5,0x13
    39b8:	00141713          	slli	a4,s0,0x1
    39bc:	00870733          	add	a4,a4,s0
    39c0:	00271713          	slli	a4,a4,0x2
    39c4:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    39c8:	00e787b3          	add	a5,a5,a4
    39cc:	00b7c783          	lbu	a5,11(a5)
    39d0:	fc078ae3          	beqz	a5,39a4 <build_draw_list+0xcc>
            if (i < PLR_SLOTS) dl_sprite(g_bul[i].kind, g_bul[i].x, g_bul[i].y, 255u); /* 自机弹固定加算 */
    39d4:	01f00793          	li	a5,31
    39d8:	fa87d0e3          	bge	a5,s0,3978 <build_draw_list+0xa0>
            else               dl_bullet(&g_bul[i]);                                  /* 敌弹按 g_bulm */
    39dc:	00141793          	slli	a5,s0,0x1
    39e0:	008787b3          	add	a5,a5,s0
    39e4:	00279793          	slli	a5,a5,0x2
    39e8:	00013537          	lui	a0,0x13
    39ec:	8fc50513          	addi	a0,a0,-1796 # 128fc <g_bul>
    39f0:	00f50533          	add	a0,a0,a5
    39f4:	dd5ff0ef          	jal	37c8 <dl_bullet>
    39f8:	fadff06f          	j	39a4 <build_draw_list+0xcc>
    for (i = 0; i < ENEMY_MAX; i++)
    39fc:	00000413          	li	s0,0
    3a00:	0080006f          	j	3a08 <build_draw_list+0x130>
    3a04:	00140413          	addi	s0,s0,1
    3a08:	01700793          	li	a5,23
    3a0c:	0487c063          	blt	a5,s0,3a4c <build_draw_list+0x174>
        if (g_en[i].t) dl_sprite(S_EN, g_en[i].x, g_en[i].y, 0u);
    3a10:	000127b7          	lui	a5,0x12
    3a14:	00441713          	slli	a4,s0,0x4
    3a18:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    3a1c:	00e787b3          	add	a5,a5,a4
    3a20:	00e79783          	lh	a5,14(a5)
    3a24:	fe0780e3          	beqz	a5,3a04 <build_draw_list+0x12c>
    3a28:	000127b7          	lui	a5,0x12
    3a2c:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    3a30:	00e787b3          	add	a5,a5,a4
    3a34:	00000693          	li	a3,0
    3a38:	00279603          	lh	a2,2(a5)
    3a3c:	00079583          	lh	a1,0(a5)
    3a40:	00100513          	li	a0,1
    3a44:	d35ff0ef          	jal	3778 <dl_sprite>
    3a48:	fbdff06f          	j	3a04 <build_draw_list+0x12c>
    if (g_state != GS_OVER && !(g_invuln && ((g_frames >> 1) & 1u)))
    3a4c:	8a81a703          	lw	a4,-1880(gp) # 8d20 <g_state>
    3a50:	00200793          	li	a5,2
    3a54:	02f70663          	beq	a4,a5,3a80 <build_draw_list+0x1a8>
    3a58:	8981a783          	lw	a5,-1896(gp) # 8d10 <g_invuln>
    3a5c:	00078863          	beqz	a5,3a6c <build_draw_list+0x194>
    3a60:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    3a64:	0027f793          	andi	a5,a5,2
    3a68:	00079c63          	bnez	a5,3a80 <build_draw_list+0x1a8>
        dl_sprite(S_PR, g_px, g_py, 0u);
    3a6c:	00000693          	li	a3,0
    3a70:	89c19603          	lh	a2,-1892(gp) # 8d14 <g_py>
    3a74:	89e19583          	lh	a1,-1890(gp) # 8d16 <g_px>
    3a78:	00000513          	li	a0,0
    3a7c:	cfdff0ef          	jal	3778 <dl_sprite>
        if (a > 255u) a = 255u;
    3a80:	00000413          	li	s0,0
    3a84:	0340006f          	j	3ab8 <build_draw_list+0x1e0>
        dl_sprite(S_SP, g_spk[i].x, g_spk[i].y, (uint8_t)a);
    3a88:	000127b7          	lui	a5,0x12
    3a8c:	00141713          	slli	a4,s0,0x1
    3a90:	00870733          	add	a4,a4,s0
    3a94:	00271713          	slli	a4,a4,0x2
    3a98:	47c78793          	addi	a5,a5,1148 # 1247c <g_spk>
    3a9c:	00e787b3          	add	a5,a5,a4
    3aa0:	0ff6f693          	zext.b	a3,a3
    3aa4:	00279603          	lh	a2,2(a5)
    3aa8:	00079583          	lh	a1,0(a5)
    3aac:	00700513          	li	a0,7
    3ab0:	cc9ff0ef          	jal	3778 <dl_sprite>
    for (i = 0; i < SPARK_MAX; i++) {
    3ab4:	00140413          	addi	s0,s0,1
    3ab8:	05f00793          	li	a5,95
    3abc:	0487c463          	blt	a5,s0,3b04 <build_draw_list+0x22c>
        if (!g_spk[i].life) continue;
    3ac0:	000127b7          	lui	a5,0x12
    3ac4:	00141713          	slli	a4,s0,0x1
    3ac8:	00870733          	add	a4,a4,s0
    3acc:	00271713          	slli	a4,a4,0x2
    3ad0:	47c78793          	addi	a5,a5,1148 # 1247c <g_spk>
    3ad4:	00e787b3          	add	a5,a5,a4
    3ad8:	00b7c703          	lbu	a4,11(a5)
    3adc:	fc070ce3          	beqz	a4,3ab4 <build_draw_list+0x1dc>
        a = (unsigned)g_spk[i].life * 255u / 20u;
    3ae0:	00871793          	slli	a5,a4,0x8
    3ae4:	40e787b3          	sub	a5,a5,a4
    3ae8:	01400693          	li	a3,20
    3aec:	02d7d6b3          	divu	a3,a5,a3
        if (a > 255u) a = 255u;
    3af0:	00001737          	lui	a4,0x1
    3af4:	3ff70713          	addi	a4,a4,1023 # 13ff <main+0x2fb>
    3af8:	f8f778e3          	bgeu	a4,a5,3a88 <build_draw_list+0x1b0>
    3afc:	0ff00693          	li	a3,255
    3b00:	f89ff06f          	j	3a88 <build_draw_list+0x1b0>
}
    3b04:	01c12083          	lw	ra,28(sp)
    3b08:	01812403          	lw	s0,24(sp)
    3b0c:	02010113          	addi	sp,sp,32
    3b10:	00008067          	ret

00003b14 <dl_sprite_count>:
    int i, n = 0;
    3b14:	00000513          	li	a0,0
    for (i = 0; i < g_dl_n; i++) if (g_dl[i].op != DRAW_FILL_FULL) n++;
    3b18:	00000713          	li	a4,0
    3b1c:	0080006f          	j	3b24 <dl_sprite_count+0x10>
    3b20:	00170713          	addi	a4,a4,1
    3b24:	8b41a783          	lw	a5,-1868(gp) # 8d2c <g_dl_n>
    3b28:	02f75663          	bge	a4,a5,3b54 <dl_sprite_count+0x40>
    3b2c:	000097b7          	lui	a5,0x9
    3b30:	00371693          	slli	a3,a4,0x3
    3b34:	40e686b3          	sub	a3,a3,a4
    3b38:	00169613          	slli	a2,a3,0x1
    3b3c:	1bc78793          	addi	a5,a5,444 # 91bc <g_dl>
    3b40:	00c787b3          	add	a5,a5,a2
    3b44:	0067c783          	lbu	a5,6(a5)
    3b48:	fc078ce3          	beqz	a5,3b20 <dl_sprite_count+0xc>
    3b4c:	00150513          	addi	a0,a0,1
    3b50:	fd1ff06f          	j	3b20 <dl_sprite_count+0xc>
}
    3b54:	00008067          	ret

00003b58 <spark_add>:
    for (i = 0; i < SPARK_MAX; i++) {
    3b58:	00000693          	li	a3,0
    3b5c:	05f00793          	li	a5,95
    3b60:	06d7cc63          	blt	a5,a3,3bd8 <spark_add+0x80>
        if (g_spk[i].life == 0) {
    3b64:	000127b7          	lui	a5,0x12
    3b68:	00169713          	slli	a4,a3,0x1
    3b6c:	00d70733          	add	a4,a4,a3
    3b70:	00271713          	slli	a4,a4,0x2
    3b74:	47c78793          	addi	a5,a5,1148 # 1247c <g_spk>
    3b78:	00e787b3          	add	a5,a5,a4
    3b7c:	00b7c783          	lbu	a5,11(a5)
    3b80:	00078663          	beqz	a5,3b8c <spark_add+0x34>
    for (i = 0; i < SPARK_MAX; i++) {
    3b84:	00168693          	addi	a3,a3,1
    3b88:	fd5ff06f          	j	3b5c <spark_add+0x4>
            g_spk[i].x = (int16_t)cx; g_spk[i].y = (int16_t)cy;
    3b8c:	00012737          	lui	a4,0x12
    3b90:	47c70713          	addi	a4,a4,1148 # 1247c <g_spk>
    3b94:	00169613          	slli	a2,a3,0x1
    3b98:	00d607b3          	add	a5,a2,a3
    3b9c:	00279793          	slli	a5,a5,0x2
    3ba0:	00f707b3          	add	a5,a4,a5
    3ba4:	00a79023          	sh	a0,0(a5)
    3ba8:	00b79123          	sh	a1,2(a5)
            g_spk[i].vx = 0; g_spk[i].vy = 0;
    3bac:	00079223          	sh	zero,4(a5)
    3bb0:	00079323          	sh	zero,6(a5)
            g_spk[i].kind = S_SP; g_spk[i].sz = SZ_SP; g_spk[i].r = 0;
    3bb4:	00700593          	li	a1,7
    3bb8:	00b78423          	sb	a1,8(a5)
    3bbc:	01000593          	li	a1,16
    3bc0:	00b784a3          	sb	a1,9(a5)
    3bc4:	00078523          	sb	zero,10(a5)
            g_spk[i].life = 20;
    3bc8:	00078713          	mv	a4,a5
    3bcc:	01400793          	li	a5,20
    3bd0:	00f705a3          	sb	a5,11(a4)
            return;
    3bd4:	00008067          	ret
}
    3bd8:	00008067          	ret

00003bdc <push_chunk>:
{
    3bdc:	ff010113          	addi	sp,sp,-16
    3be0:	00112623          	sw	ra,12(sp)
    uint32_t room = blt_push_room();
    3be4:	e35fe0ef          	jal	2a18 <blt_push_room>
    if (room == 0u) { cpu_backoff(BLT_WAIT_NOP); return; }   /* 引擎没跟上：纯 ALU 退避 */
    3be8:	00050c63          	beqz	a0,3c00 <push_chunk+0x24>
    3bec:	00812423          	sw	s0,8(sp)
    3bf0:	00912223          	sw	s1,4(sp)
    3bf4:	00050413          	mv	s0,a0
    uint32_t budget = HW_PUSH_BUDGET;
    3bf8:	04000713          	li	a4,64
    3bfc:	0600006f          	j	3c5c <push_chunk+0x80>
    if (room == 0u) { cpu_backoff(BLT_WAIT_NOP); return; }   /* 引擎没跟上：纯 ALU 退避 */
    3c00:	03000513          	li	a0,48
    3c04:	8d5fe0ef          	jal	24d8 <cpu_backoff>
    3c08:	2200006f          	j	3e28 <push_chunk+0x24c>
            e_fill(g_fb_back + (uint32_t)PLAY_Y0 * FB_STRIDE, FB_STRIDE, PLAY_W, PLAY_H, d->arg);
    3c0c:	00009737          	lui	a4,0x9
    3c10:	00379693          	slli	a3,a5,0x3
    3c14:	40f686b3          	sub	a3,a3,a5
    3c18:	00169693          	slli	a3,a3,0x1
    3c1c:	1bc70793          	addi	a5,a4,444 # 91bc <g_dl>
    3c20:	00d787b3          	add	a5,a5,a3
    3c24:	8341a803          	lw	a6,-1996(gp) # 8cac <g_fb_back>
    3c28:	00008537          	lui	a0,0x8
    3c2c:	80050513          	addi	a0,a0,-2048 # 7800 <_data+0x5b4>
    3c30:	0047d703          	lhu	a4,4(a5)
    3c34:	20c00693          	li	a3,524
    3c38:	30000613          	li	a2,768
    3c3c:	78000593          	li	a1,1920
    3c40:	00a80533          	add	a0,a6,a0
    3c44:	ac5fe0ef          	jal	2708 <e_fill>
        g_dl_i++;
    3c48:	8b01a783          	lw	a5,-1872(gp) # 8d28 <g_dl_i>
    3c4c:	00178793          	addi	a5,a5,1
    3c50:	8af1a823          	sw	a5,-1872(gp) # 8d28 <g_dl_i>
        room--;
    3c54:	fff40413          	addi	s0,s0,-1
    while (g_dl_i < g_dl_n && room > 0u && budget-- > 0u) {
    3c58:	00048713          	mv	a4,s1
    3c5c:	8b01a783          	lw	a5,-1872(gp) # 8d28 <g_dl_i>
    3c60:	8b41a683          	lw	a3,-1868(gp) # 8d2c <g_dl_n>
    3c64:	1ad7de63          	bge	a5,a3,3e20 <push_chunk+0x244>
    3c68:	1c040663          	beqz	s0,3e34 <push_chunk+0x258>
    3c6c:	fff70493          	addi	s1,a4,-1
    3c70:	1a070263          	beqz	a4,3e14 <push_chunk+0x238>
        if (d->op == DRAW_FILL_FULL) {
    3c74:	00009737          	lui	a4,0x9
    3c78:	00379693          	slli	a3,a5,0x3
    3c7c:	40f686b3          	sub	a3,a3,a5
    3c80:	00169693          	slli	a3,a3,0x1
    3c84:	1bc70713          	addi	a4,a4,444 # 91bc <g_dl>
    3c88:	00d70733          	add	a4,a4,a3
    3c8c:	00674803          	lbu	a6,6(a4)
    3c90:	f6080ee3          	beqz	a6,3c0c <push_chunk+0x30>
        } else if (d->op == DRAW_FILL) {
    3c94:	00100713          	li	a4,1
    3c98:	0ce80463          	beq	a6,a4,3d60 <push_chunk+0x184>
            uint32_t ss  = (uint32_t)g_spr_sz[d->arg] * 2u;
    3c9c:	00009737          	lui	a4,0x9
    3ca0:	00379693          	slli	a3,a5,0x3
    3ca4:	40f686b3          	sub	a3,a3,a5
    3ca8:	00169693          	slli	a3,a3,0x1
    3cac:	1bc70713          	addi	a4,a4,444 # 91bc <g_dl>
    3cb0:	00d70733          	add	a4,a4,a3
    3cb4:	00475583          	lhu	a1,4(a4)
    3cb8:	84018693          	addi	a3,gp,-1984 # 8cb8 <g_spr_sz>
    3cbc:	00b686b3          	add	a3,a3,a1
    3cc0:	0006c603          	lbu	a2,0(a3)
    3cc4:	00161613          	slli	a2,a2,0x1
            uint32_t src = ATLAS_BASE + g_spr_off[d->arg]
    3cc8:	000096b7          	lui	a3,0x9
    3ccc:	00259593          	slli	a1,a1,0x2
    3cd0:	b6468693          	addi	a3,a3,-1180 # 8b64 <g_spr_off>
    3cd4:	00b686b3          	add	a3,a3,a1
    3cd8:	0006a683          	lw	a3,0(a3)
                         + (uint32_t)d->sy * ss + (uint32_t)d->sx * 2u;   /* ★ 源裁剪偏移 */
    3cdc:	00b74583          	lbu	a1,11(a4)
    3ce0:	02c585b3          	mul	a1,a1,a2
    3ce4:	00b686b3          	add	a3,a3,a1
    3ce8:	00a74583          	lbu	a1,10(a4)
    3cec:	00159593          	slli	a1,a1,0x1
    3cf0:	00b686b3          	add	a3,a3,a1
            uint32_t src = ATLAS_BASE + g_spr_off[d->arg]
    3cf4:	002015b7          	lui	a1,0x201
    3cf8:	00b68533          	add	a0,a3,a1
            uint32_t dst = g_fb_back + (uint32_t)d->y * FB_STRIDE + (uint32_t)d->x * 2u;
    3cfc:	00271683          	lh	a3,2(a4)
    3d00:	00071583          	lh	a1,0(a4)
    3d04:	00469713          	slli	a4,a3,0x4
    3d08:	40d70733          	sub	a4,a4,a3
    3d0c:	00671713          	slli	a4,a4,0x6
    3d10:	00b70733          	add	a4,a4,a1
    3d14:	00171713          	slli	a4,a4,0x1
    3d18:	8341a683          	lw	a3,-1996(gp) # 8cac <g_fb_back>
    3d1c:	00d705b3          	add	a1,a4,a3
            if (d->op == DRAW_GLOW)       e_glow(src, dst, ss, FB_STRIDE, d->w, d->h, d->ga);
    3d20:	00300713          	li	a4,3
    3d24:	08e80863          	beq	a6,a4,3db4 <push_chunk+0x1d8>
            else if (d->op == DRAW_ALPHA) e_alpha(src, dst, ss, FB_STRIDE, d->w, d->h, d->ga);
    3d28:	00400713          	li	a4,4
    3d2c:	0ae80c63          	beq	a6,a4,3de4 <push_chunk+0x208>
            else                          e_key(src, dst, ss, FB_STRIDE, d->w, d->h, TRANS_KEY);
    3d30:	00009737          	lui	a4,0x9
    3d34:	1bc70713          	addi	a4,a4,444 # 91bc <g_dl>
    3d38:	00379693          	slli	a3,a5,0x3
    3d3c:	40f688b3          	sub	a7,a3,a5
    3d40:	00189893          	slli	a7,a7,0x1
    3d44:	011708b3          	add	a7,a4,a7
    3d48:	00000813          	li	a6,0
    3d4c:	0088c783          	lbu	a5,8(a7)
    3d50:	0078c703          	lbu	a4,7(a7)
    3d54:	78000693          	li	a3,1920
    3d58:	a41fe0ef          	jal	2798 <e_key>
    3d5c:	eedff06f          	j	3c48 <push_chunk+0x6c>
            e_fill(g_fb_back + (uint32_t)d->y * FB_STRIDE + (uint32_t)d->x * 2u,
    3d60:	00009737          	lui	a4,0x9
    3d64:	1bc70713          	addi	a4,a4,444 # 91bc <g_dl>
    3d68:	00379693          	slli	a3,a5,0x3
    3d6c:	40f68633          	sub	a2,a3,a5
    3d70:	00161613          	slli	a2,a2,0x1
    3d74:	00c70633          	add	a2,a4,a2
    3d78:	00261583          	lh	a1,2(a2) # a01002 <__freertos_irq_stack_top+0x9e64f2>
    3d7c:	00061803          	lh	a6,0(a2)
    3d80:	00459513          	slli	a0,a1,0x4
    3d84:	40b50533          	sub	a0,a0,a1
    3d88:	00651513          	slli	a0,a0,0x6
    3d8c:	01050533          	add	a0,a0,a6
    3d90:	00151513          	slli	a0,a0,0x1
    3d94:	8341a803          	lw	a6,-1996(gp) # 8cac <g_fb_back>
    3d98:	00465703          	lhu	a4,4(a2)
    3d9c:	00864683          	lbu	a3,8(a2)
    3da0:	00764603          	lbu	a2,7(a2)
    3da4:	78000593          	li	a1,1920
    3da8:	01050533          	add	a0,a0,a6
    3dac:	95dfe0ef          	jal	2708 <e_fill>
    3db0:	e99ff06f          	j	3c48 <push_chunk+0x6c>
            if (d->op == DRAW_GLOW)       e_glow(src, dst, ss, FB_STRIDE, d->w, d->h, d->ga);
    3db4:	000096b7          	lui	a3,0x9
    3db8:	1bc68693          	addi	a3,a3,444 # 91bc <g_dl>
    3dbc:	00379813          	slli	a6,a5,0x3
    3dc0:	40f80733          	sub	a4,a6,a5
    3dc4:	00171713          	slli	a4,a4,0x1
    3dc8:	00e68733          	add	a4,a3,a4
    3dcc:	00974803          	lbu	a6,9(a4)
    3dd0:	00874783          	lbu	a5,8(a4)
    3dd4:	00774703          	lbu	a4,7(a4)
    3dd8:	78000693          	li	a3,1920
    3ddc:	a65fe0ef          	jal	2840 <e_glow>
    3de0:	e69ff06f          	j	3c48 <push_chunk+0x6c>
            else if (d->op == DRAW_ALPHA) e_alpha(src, dst, ss, FB_STRIDE, d->w, d->h, d->ga);
    3de4:	000096b7          	lui	a3,0x9
    3de8:	1bc68693          	addi	a3,a3,444 # 91bc <g_dl>
    3dec:	00379813          	slli	a6,a5,0x3
    3df0:	40f80733          	sub	a4,a6,a5
    3df4:	00171713          	slli	a4,a4,0x1
    3df8:	00e68733          	add	a4,a3,a4
    3dfc:	00974803          	lbu	a6,9(a4)
    3e00:	00874783          	lbu	a5,8(a4)
    3e04:	00774703          	lbu	a4,7(a4)
    3e08:	78000693          	li	a3,1920
    3e0c:	b1dfe0ef          	jal	2928 <e_alpha>
    3e10:	e39ff06f          	j	3c48 <push_chunk+0x6c>
    3e14:	00812403          	lw	s0,8(sp)
    3e18:	00412483          	lw	s1,4(sp)
    3e1c:	00c0006f          	j	3e28 <push_chunk+0x24c>
    3e20:	00812403          	lw	s0,8(sp)
    3e24:	00412483          	lw	s1,4(sp)
}
    3e28:	00c12083          	lw	ra,12(sp)
    3e2c:	01010113          	addi	sp,sp,16
    3e30:	00008067          	ret
    3e34:	00812403          	lw	s0,8(sp)
    3e38:	00412483          	lw	s1,4(sp)
    3e3c:	fedff06f          	j	3e28 <push_chunk+0x24c>

00003e40 <blend565>:
{
    3e40:	00060693          	mv	a3,a2
    unsigned fr = (fg >> 11) & 0x1Fu, fgc = (fg >> 5) & 0x3Fu, fb = fg & 0x1Fu;
    3e44:	00b55713          	srli	a4,a0,0xb
    3e48:	00555613          	srli	a2,a0,0x5
    3e4c:	03f67613          	andi	a2,a2,63
    3e50:	01f57513          	andi	a0,a0,31
    unsigned br = (bg >> 11) & 0x1Fu, bgc = (bg >> 5) & 0x3Fu, bb = bg & 0x1Fu;
    3e54:	00b5d893          	srli	a7,a1,0xb
    3e58:	0055d813          	srli	a6,a1,0x5
    3e5c:	03f87813          	andi	a6,a6,63
    3e60:	01f5f593          	andi	a1,a1,31
    unsigned f8r = (fr << 3) | (fr >> 2), f8g = (fgc << 2) | (fgc >> 4), f8b = (fb << 3) | (fb >> 2);
    3e64:	00371793          	slli	a5,a4,0x3
    3e68:	00275713          	srli	a4,a4,0x2
    3e6c:	00e7e7b3          	or	a5,a5,a4
    3e70:	00261713          	slli	a4,a2,0x2
    3e74:	00465613          	srli	a2,a2,0x4
    3e78:	00c76733          	or	a4,a4,a2
    3e7c:	00351613          	slli	a2,a0,0x3
    3e80:	00255513          	srli	a0,a0,0x2
    3e84:	00a66633          	or	a2,a2,a0
    unsigned b8r = (br << 3) | (br >> 2), b8g = (bgc << 2) | (bgc >> 4), b8b = (bb << 3) | (bb >> 2);
    3e88:	00389513          	slli	a0,a7,0x3
    3e8c:	0028d893          	srli	a7,a7,0x2
    3e90:	011568b3          	or	a7,a0,a7
    3e94:	00281513          	slli	a0,a6,0x2
    3e98:	00485813          	srli	a6,a6,0x4
    3e9c:	01056833          	or	a6,a0,a6
    3ea0:	00359513          	slli	a0,a1,0x3
    3ea4:	0025d593          	srli	a1,a1,0x2
    3ea8:	00b565b3          	or	a1,a0,a1
    unsigned ai  = 255u - a;
    3eac:	0ff00e13          	li	t3,255
    3eb0:	40de0333          	sub	t1,t3,a3
    unsigned r = (f8r * a + b8r * ai + 127u) >> 8;
    3eb4:	02d787b3          	mul	a5,a5,a3
    3eb8:	02688533          	mul	a0,a7,t1
    3ebc:	00a787b3          	add	a5,a5,a0
    3ec0:	07f78793          	addi	a5,a5,127
    3ec4:	0087d793          	srli	a5,a5,0x8
    unsigned g = (f8g * a + b8g * ai + 127u) >> 8;
    3ec8:	02d70733          	mul	a4,a4,a3
    3ecc:	02680533          	mul	a0,a6,t1
    3ed0:	00a70733          	add	a4,a4,a0
    3ed4:	07f70713          	addi	a4,a4,127
    3ed8:	00875713          	srli	a4,a4,0x8
    unsigned b = (f8b * a + b8b * ai + 127u) >> 8;
    3edc:	02d60633          	mul	a2,a2,a3
    3ee0:	026586b3          	mul	a3,a1,t1
    3ee4:	00d60633          	add	a2,a2,a3
    3ee8:	07f60613          	addi	a2,a2,127
    3eec:	00865613          	srli	a2,a2,0x8
    if (r > 255u) r = 255u;
    3ef0:	00fe7463          	bgeu	t3,a5,3ef8 <blend565+0xb8>
    3ef4:	0ff00793          	li	a5,255
    if (g > 255u) g = 255u;
    3ef8:	0ff00693          	li	a3,255
    3efc:	00e6f463          	bgeu	a3,a4,3f04 <blend565+0xc4>
    3f00:	0ff00713          	li	a4,255
    if (b > 255u) b = 255u;
    3f04:	0ff00693          	li	a3,255
    3f08:	00c6f463          	bgeu	a3,a2,3f10 <blend565+0xd0>
    3f0c:	0ff00613          	li	a2,255
    return (uint16_t)(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3));
    3f10:	0037d513          	srli	a0,a5,0x3
    3f14:	00b51513          	slli	a0,a0,0xb
    3f18:	01051513          	slli	a0,a0,0x10
    3f1c:	01055513          	srli	a0,a0,0x10
    3f20:	00275713          	srli	a4,a4,0x2
    3f24:	00571713          	slli	a4,a4,0x5
    3f28:	01071713          	slli	a4,a4,0x10
    3f2c:	01075713          	srli	a4,a4,0x10
    3f30:	00e56533          	or	a0,a0,a4
    3f34:	00365613          	srli	a2,a2,0x3
    3f38:	00c56533          	or	a0,a0,a2
}
    3f3c:	01051513          	slli	a0,a0,0x10
    3f40:	01055513          	srli	a0,a0,0x10
    3f44:	00008067          	ret

00003f48 <add565>:
{
    3f48:	00060893          	mv	a7,a2
    unsigned fr = (fg >> 11) & 0x1Fu, fgc = (fg >> 5) & 0x3Fu, fb = fg & 0x1Fu;
    3f4c:	00b55713          	srli	a4,a0,0xb
    3f50:	00555813          	srli	a6,a0,0x5
    3f54:	03f87813          	andi	a6,a6,63
    3f58:	01f57513          	andi	a0,a0,31
    unsigned br = (bg >> 11) & 0x1Fu, bgc = (bg >> 5) & 0x3Fu, bb = bg & 0x1Fu;
    3f5c:	00b5d313          	srli	t1,a1,0xb
    3f60:	0055d693          	srli	a3,a1,0x5
    3f64:	03f6f693          	andi	a3,a3,63
    3f68:	01f5f593          	andi	a1,a1,31
    unsigned f8r = (fr << 3) | (fr >> 2), f8g = (fgc << 2) | (fgc >> 4), f8b = (fb << 3) | (fb >> 2);
    3f6c:	00371793          	slli	a5,a4,0x3
    3f70:	00275713          	srli	a4,a4,0x2
    3f74:	00e7e7b3          	or	a5,a5,a4
    3f78:	00281713          	slli	a4,a6,0x2
    3f7c:	00485813          	srli	a6,a6,0x4
    3f80:	01076733          	or	a4,a4,a6
    3f84:	00351613          	slli	a2,a0,0x3
    3f88:	00255513          	srli	a0,a0,0x2
    3f8c:	00a66633          	or	a2,a2,a0
    unsigned b8r = (br << 3) | (br >> 2), b8g = (bgc << 2) | (bgc >> 4), b8b = (bb << 3) | (bb >> 2);
    3f90:	00331813          	slli	a6,t1,0x3
    3f94:	00235313          	srli	t1,t1,0x2
    3f98:	00686833          	or	a6,a6,t1
    3f9c:	00269513          	slli	a0,a3,0x2
    3fa0:	0046d693          	srli	a3,a3,0x4
    3fa4:	00d56533          	or	a0,a0,a3
    3fa8:	00359693          	slli	a3,a1,0x3
    3fac:	0025d593          	srli	a1,a1,0x2
    3fb0:	00b6e5b3          	or	a1,a3,a1
    unsigned r = f8r * ga / 255u + b8r;
    3fb4:	031787b3          	mul	a5,a5,a7
    3fb8:	0ff00693          	li	a3,255
    3fbc:	02d7d7b3          	divu	a5,a5,a3
    3fc0:	010787b3          	add	a5,a5,a6
    unsigned g = f8g * ga / 255u + b8g;
    3fc4:	03170733          	mul	a4,a4,a7
    3fc8:	02d75733          	divu	a4,a4,a3
    3fcc:	00a70733          	add	a4,a4,a0
    unsigned b = f8b * ga / 255u + b8b;
    3fd0:	03160633          	mul	a2,a2,a7
    3fd4:	02d65633          	divu	a2,a2,a3
    3fd8:	00b60633          	add	a2,a2,a1
    if (r > 255u) r = 255u;
    3fdc:	00f6f463          	bgeu	a3,a5,3fe4 <add565+0x9c>
    3fe0:	0ff00793          	li	a5,255
    if (g > 255u) g = 255u;
    3fe4:	0ff00693          	li	a3,255
    3fe8:	00e6f463          	bgeu	a3,a4,3ff0 <add565+0xa8>
    3fec:	0ff00713          	li	a4,255
    if (b > 255u) b = 255u;
    3ff0:	0ff00693          	li	a3,255
    3ff4:	00c6f463          	bgeu	a3,a2,3ffc <add565+0xb4>
    3ff8:	0ff00613          	li	a2,255
    return (uint16_t)(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3));
    3ffc:	0037d513          	srli	a0,a5,0x3
    4000:	00b51513          	slli	a0,a0,0xb
    4004:	01051513          	slli	a0,a0,0x10
    4008:	01055513          	srli	a0,a0,0x10
    400c:	00275713          	srli	a4,a4,0x2
    4010:	00571713          	slli	a4,a4,0x5
    4014:	01071713          	slli	a4,a4,0x10
    4018:	01075713          	srli	a4,a4,0x10
    401c:	00e56533          	or	a0,a0,a4
    4020:	00365613          	srli	a2,a2,0x3
    4024:	00c56533          	or	a0,a0,a2
}
    4028:	01051513          	slli	a0,a0,0x10
    402c:	01055513          	srli	a0,a0,0x10
    4030:	00008067          	ret

00004034 <cpu_blit>:
{
    4034:	fb010113          	addi	sp,sp,-80
    4038:	04112623          	sw	ra,76(sp)
    403c:	04812423          	sw	s0,72(sp)
    4040:	04912223          	sw	s1,68(sp)
    4044:	05212023          	sw	s2,64(sp)
    4048:	03312e23          	sw	s3,60(sp)
    404c:	03412c23          	sw	s4,56(sp)
    4050:	03512a23          	sw	s5,52(sp)
    4054:	03612823          	sw	s6,48(sp)
    4058:	03712623          	sw	s7,44(sp)
    405c:	03812423          	sw	s8,40(sp)
    4060:	03912223          	sw	s9,36(sp)
    4064:	03a12023          	sw	s10,32(sp)
    4068:	01b12e23          	sw	s11,28(sp)
    406c:	00058d13          	mv	s10,a1
    4070:	00c12223          	sw	a2,4(sp)
    4074:	00068a93          	mv	s5,a3
    4078:	00070c93          	mv	s9,a4
    407c:	00f12423          	sw	a5,8(sp)
    4080:	01012623          	sw	a6,12(sp)
    4084:	00088c13          	mv	s8,a7
    4088:	05012983          	lw	s3,80(sp)
    const volatile uint16_t *s = (const volatile uint16_t *)(ATLAS_BASE + g_spr_off[spr]);
    408c:	000097b7          	lui	a5,0x9
    4090:	00251713          	slli	a4,a0,0x2
    4094:	b6478793          	addi	a5,a5,-1180 # 8b64 <g_spr_off>
    4098:	00e787b3          	add	a5,a5,a4
    409c:	0007ab03          	lw	s6,0(a5)
    40a0:	002017b7          	lui	a5,0x201
    40a4:	00fb0b33          	add	s6,s6,a5
    int sw = (int)g_spr_sz[spr];
    40a8:	84018793          	addi	a5,gp,-1984 # 8cb8 <g_spr_sz>
    40ac:	00a78533          	add	a0,a5,a0
    40b0:	00054d83          	lbu	s11,0(a0)
    for (j = 0; j < h; j++) {
    40b4:	00000b93          	li	s7,0
    40b8:	0800006f          	j	4138 <cpu_blit+0x104>
            if (mode == 1)      d[i] = add565(c, d[i], ga);        /* 加算 */
    40bc:	00141493          	slli	s1,s0,0x1
    40c0:	009904b3          	add	s1,s2,s1
    40c4:	0004d583          	lhu	a1,0(s1)
    40c8:	000c0613          	mv	a2,s8
    40cc:	e7dff0ef          	jal	3f48 <add565>
    40d0:	00a49023          	sh	a0,0(s1)
        for (i = 0; i < w; i++) {
    40d4:	00140413          	addi	s0,s0,1
    40d8:	05545e63          	bge	s0,s5,4134 <cpu_blit+0x100>
            uint16_t c = sr[i];
    40dc:	008a07b3          	add	a5,s4,s0
    40e0:	00179793          	slli	a5,a5,0x1
    40e4:	00fb07b3          	add	a5,s6,a5
    40e8:	0007d503          	lhu	a0,0(a5) # 201000 <__freertos_irq_stack_top+0x1e64f0>
    40ec:	01051513          	slli	a0,a0,0x10
    40f0:	01055513          	srli	a0,a0,0x10
            if (mode == 1)      d[i] = add565(c, d[i], ga);        /* 加算 */
    40f4:	00100793          	li	a5,1
    40f8:	fcf982e3          	beq	s3,a5,40bc <cpu_blit+0x88>
            else if (mode == 2) d[i] = blend565(c, d[i], ga);      /* 经典半透明 */
    40fc:	00200793          	li	a5,2
    4100:	00f98c63          	beq	s3,a5,4118 <cpu_blit+0xe4>
            else if (c != TRANS_KEY) d[i] = c;                     /* Color Key */
    4104:	fc0508e3          	beqz	a0,40d4 <cpu_blit+0xa0>
    4108:	00141493          	slli	s1,s0,0x1
    410c:	009904b3          	add	s1,s2,s1
    4110:	00a49023          	sh	a0,0(s1)
    4114:	fc1ff06f          	j	40d4 <cpu_blit+0xa0>
            else if (mode == 2) d[i] = blend565(c, d[i], ga);      /* 经典半透明 */
    4118:	00141493          	slli	s1,s0,0x1
    411c:	009904b3          	add	s1,s2,s1
    4120:	0004d583          	lhu	a1,0(s1)
    4124:	000c0613          	mv	a2,s8
    4128:	d19ff0ef          	jal	3e40 <blend565>
    412c:	00a49023          	sh	a0,0(s1)
    4130:	fa5ff06f          	j	40d4 <cpu_blit+0xa0>
    for (j = 0; j < h; j++) {
    4134:	001b8b93          	addi	s7,s7,1
    4138:	059bd263          	bge	s7,s9,417c <cpu_blit+0x148>
                                + (uint32_t)(y + j) * FB_STRIDE + (uint32_t)x * 2u);
    413c:	00412783          	lw	a5,4(sp)
    4140:	00fb87b3          	add	a5,s7,a5
    4144:	00479913          	slli	s2,a5,0x4
    4148:	40f90933          	sub	s2,s2,a5
    414c:	00691913          	slli	s2,s2,0x6
    4150:	01a90933          	add	s2,s2,s10
    4154:	00191913          	slli	s2,s2,0x1
    4158:	8341a783          	lw	a5,-1996(gp) # 8cac <g_fb_back>
    415c:	00f90933          	add	s2,s2,a5
        const volatile uint16_t *sr = s + (j + sy) * sw + sx;
    4160:	00c12783          	lw	a5,12(sp)
    4164:	00fb8a33          	add	s4,s7,a5
    4168:	03ba0a33          	mul	s4,s4,s11
    416c:	00812783          	lw	a5,8(sp)
    4170:	00fa0a33          	add	s4,s4,a5
        for (i = 0; i < w; i++) {
    4174:	00000413          	li	s0,0
    4178:	f61ff06f          	j	40d8 <cpu_blit+0xa4>
}
    417c:	04c12083          	lw	ra,76(sp)
    4180:	04812403          	lw	s0,72(sp)
    4184:	04412483          	lw	s1,68(sp)
    4188:	04012903          	lw	s2,64(sp)
    418c:	03c12983          	lw	s3,60(sp)
    4190:	03812a03          	lw	s4,56(sp)
    4194:	03412a83          	lw	s5,52(sp)
    4198:	03012b03          	lw	s6,48(sp)
    419c:	02c12b83          	lw	s7,44(sp)
    41a0:	02812c03          	lw	s8,40(sp)
    41a4:	02412c83          	lw	s9,36(sp)
    41a8:	02012d03          	lw	s10,32(sp)
    41ac:	01c12d83          	lw	s11,28(sp)
    41b0:	05010113          	addi	sp,sp,80
    41b4:	00008067          	ret

000041b8 <cpu_render_frame>:
{
    41b8:	fe010113          	addi	sp,sp,-32
    41bc:	00112e23          	sw	ra,28(sp)
    41c0:	00812c23          	sw	s0,24(sp)
    cpu_fill32(g_fb_back, 0, PLAY_Y0, PLAY_W, PLAY_H, COL_BG);   /* 纯软件：整屏铺底也自己干 */
    41c4:	02100793          	li	a5,33
    41c8:	20c00713          	li	a4,524
    41cc:	30000693          	li	a3,768
    41d0:	01000613          	li	a2,16
    41d4:	00000593          	li	a1,0
    41d8:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    41dc:	ba4fe0ef          	jal	2580 <cpu_fill32>
    for (i = 0; i < g_dl_n; i++) {
    41e0:	00000413          	li	s0,0
    41e4:	0300006f          	j	4214 <cpu_render_frame+0x5c>
        if (d->op == DRAW_FILL_FULL)      cpu_fill32(g_fb_back, 0, PLAY_Y0, PLAY_W, PLAY_H, d->arg);
    41e8:	000097b7          	lui	a5,0x9
    41ec:	1bc78793          	addi	a5,a5,444 # 91bc <g_dl>
    41f0:	00d787b3          	add	a5,a5,a3
    41f4:	0047d783          	lhu	a5,4(a5)
    41f8:	20c00713          	li	a4,524
    41fc:	30000693          	li	a3,768
    4200:	01000613          	li	a2,16
    4204:	00000593          	li	a1,0
    4208:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    420c:	b74fe0ef          	jal	2580 <cpu_fill32>
    for (i = 0; i < g_dl_n; i++) {
    4210:	00140413          	addi	s0,s0,1
    4214:	8b41a783          	lw	a5,-1868(gp) # 8d2c <g_dl_n>
    4218:	14f45463          	bge	s0,a5,4360 <cpu_render_frame+0x1a8>
        if (d->op == DRAW_FILL_FULL)      cpu_fill32(g_fb_back, 0, PLAY_Y0, PLAY_W, PLAY_H, d->arg);
    421c:	000097b7          	lui	a5,0x9
    4220:	00341713          	slli	a4,s0,0x3
    4224:	40870733          	sub	a4,a4,s0
    4228:	00171693          	slli	a3,a4,0x1
    422c:	1bc78793          	addi	a5,a5,444 # 91bc <g_dl>
    4230:	00d787b3          	add	a5,a5,a3
    4234:	0067c783          	lbu	a5,6(a5)
    4238:	fa0788e3          	beqz	a5,41e8 <cpu_render_frame+0x30>
        else if (d->op == DRAW_FILL)      cpu_fill32(g_fb_back, d->x, d->y, d->w, d->h, d->arg);
    423c:	00100713          	li	a4,1
    4240:	04e78c63          	beq	a5,a4,4298 <cpu_render_frame+0xe0>
        else if (d->op == DRAW_GLOW)      cpu_blit(d->arg, d->x, d->y, d->w, d->h, d->sx, d->sy, d->ga, 1);
    4244:	00300713          	li	a4,3
    4248:	08e78463          	beq	a5,a4,42d0 <cpu_render_frame+0x118>
        else if (d->op == DRAW_ALPHA)     cpu_blit(d->arg, d->x, d->y, d->w, d->h, d->sx, d->sy, d->ga, 2);
    424c:	00400713          	li	a4,4
    4250:	0ce78463          	beq	a5,a4,4318 <cpu_render_frame+0x160>
        else                              cpu_blit(d->arg, d->x, d->y, d->w, d->h, d->sx, d->sy, 0u, 0);
    4254:	00009537          	lui	a0,0x9
    4258:	00341793          	slli	a5,s0,0x3
    425c:	408787b3          	sub	a5,a5,s0
    4260:	00179713          	slli	a4,a5,0x1
    4264:	1bc50513          	addi	a0,a0,444 # 91bc <g_dl>
    4268:	00e50533          	add	a0,a0,a4
    426c:	00012023          	sw	zero,0(sp)
    4270:	00000893          	li	a7,0
    4274:	00b54803          	lbu	a6,11(a0)
    4278:	00a54783          	lbu	a5,10(a0)
    427c:	00854703          	lbu	a4,8(a0)
    4280:	00754683          	lbu	a3,7(a0)
    4284:	00251603          	lh	a2,2(a0)
    4288:	00051583          	lh	a1,0(a0)
    428c:	00455503          	lhu	a0,4(a0)
    4290:	da5ff0ef          	jal	4034 <cpu_blit>
    4294:	f7dff06f          	j	4210 <cpu_render_frame+0x58>
        else if (d->op == DRAW_FILL)      cpu_fill32(g_fb_back, d->x, d->y, d->w, d->h, d->arg);
    4298:	000095b7          	lui	a1,0x9
    429c:	00341793          	slli	a5,s0,0x3
    42a0:	408787b3          	sub	a5,a5,s0
    42a4:	00179713          	slli	a4,a5,0x1
    42a8:	1bc58593          	addi	a1,a1,444 # 91bc <g_dl>
    42ac:	00e585b3          	add	a1,a1,a4
    42b0:	0045d783          	lhu	a5,4(a1)
    42b4:	0085c703          	lbu	a4,8(a1)
    42b8:	0075c683          	lbu	a3,7(a1)
    42bc:	00259603          	lh	a2,2(a1)
    42c0:	00059583          	lh	a1,0(a1)
    42c4:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    42c8:	ab8fe0ef          	jal	2580 <cpu_fill32>
    42cc:	f45ff06f          	j	4210 <cpu_render_frame+0x58>
        else if (d->op == DRAW_GLOW)      cpu_blit(d->arg, d->x, d->y, d->w, d->h, d->sx, d->sy, d->ga, 1);
    42d0:	00009537          	lui	a0,0x9
    42d4:	00341793          	slli	a5,s0,0x3
    42d8:	408787b3          	sub	a5,a5,s0
    42dc:	00179713          	slli	a4,a5,0x1
    42e0:	1bc50513          	addi	a0,a0,444 # 91bc <g_dl>
    42e4:	00e50533          	add	a0,a0,a4
    42e8:	00100793          	li	a5,1
    42ec:	00f12023          	sw	a5,0(sp)
    42f0:	00954883          	lbu	a7,9(a0)
    42f4:	00b54803          	lbu	a6,11(a0)
    42f8:	00a54783          	lbu	a5,10(a0)
    42fc:	00854703          	lbu	a4,8(a0)
    4300:	00754683          	lbu	a3,7(a0)
    4304:	00251603          	lh	a2,2(a0)
    4308:	00051583          	lh	a1,0(a0)
    430c:	00455503          	lhu	a0,4(a0)
    4310:	d25ff0ef          	jal	4034 <cpu_blit>
    4314:	efdff06f          	j	4210 <cpu_render_frame+0x58>
        else if (d->op == DRAW_ALPHA)     cpu_blit(d->arg, d->x, d->y, d->w, d->h, d->sx, d->sy, d->ga, 2);
    4318:	00009537          	lui	a0,0x9
    431c:	00341793          	slli	a5,s0,0x3
    4320:	408787b3          	sub	a5,a5,s0
    4324:	00179713          	slli	a4,a5,0x1
    4328:	1bc50513          	addi	a0,a0,444 # 91bc <g_dl>
    432c:	00e50533          	add	a0,a0,a4
    4330:	00200793          	li	a5,2
    4334:	00f12023          	sw	a5,0(sp)
    4338:	00954883          	lbu	a7,9(a0)
    433c:	00b54803          	lbu	a6,11(a0)
    4340:	00a54783          	lbu	a5,10(a0)
    4344:	00854703          	lbu	a4,8(a0)
    4348:	00754683          	lbu	a3,7(a0)
    434c:	00251603          	lh	a2,2(a0)
    4350:	00051583          	lh	a1,0(a0)
    4354:	00455503          	lhu	a0,4(a0)
    4358:	cddff0ef          	jal	4034 <cpu_blit>
    435c:	eb5ff06f          	j	4210 <cpu_render_frame+0x58>
}
    4360:	01c12083          	lw	ra,28(sp)
    4364:	01812403          	lw	s0,24(sp)
    4368:	02010113          	addi	sp,sp,32
    436c:	00008067          	ret

00004370 <app>:
static char *app(char *p, const char *s) { while (*s) *p++ = *s++; return p; }
    4370:	0100006f          	j	4380 <app+0x10>
    4374:	00158593          	addi	a1,a1,1
    4378:	00f50023          	sb	a5,0(a0)
    437c:	00150513          	addi	a0,a0,1
    4380:	0005c783          	lbu	a5,0(a1)
    4384:	fe0798e3          	bnez	a5,4374 <app+0x4>
    4388:	00008067          	ret

0000438c <appn>:
{
    438c:	ff010113          	addi	sp,sp,-16
    char d[12]; int n = 0, i;
    4390:	00000793          	li	a5,0
    do { d[n++] = (char)('0' + (v % 10u)); v /= 10u; } while (v && n < 11);
    4394:	00a00813          	li	a6,10
    4398:	0305f6b3          	remu	a3,a1,a6
    439c:	03068693          	addi	a3,a3,48
    43a0:	01078713          	addi	a4,a5,16
    43a4:	00270733          	add	a4,a4,sp
    43a8:	00178793          	addi	a5,a5,1
    43ac:	fed70a23          	sb	a3,-12(a4)
    43b0:	00058693          	mv	a3,a1
    43b4:	0305d5b3          	divu	a1,a1,a6
    43b8:	00900713          	li	a4,9
    43bc:	02d77863          	bgeu	a4,a3,43ec <appn+0x60>
    43c0:	00a00713          	li	a4,10
    43c4:	fcf758e3          	bge	a4,a5,4394 <appn+0x8>
    43c8:	00000713          	li	a4,0
    43cc:	0140006f          	j	43e0 <appn+0x54>
    for (i = 0; i < w - n; i++) *p++ = ' ';
    43d0:	02000693          	li	a3,32
    43d4:	00d50023          	sb	a3,0(a0)
    43d8:	00170713          	addi	a4,a4,1
    43dc:	00150513          	addi	a0,a0,1
    43e0:	40f606b3          	sub	a3,a2,a5
    43e4:	fed746e3          	blt	a4,a3,43d0 <appn+0x44>
    43e8:	0240006f          	j	440c <appn+0x80>
    43ec:	00000713          	li	a4,0
    43f0:	ff1ff06f          	j	43e0 <appn+0x54>
    while (n) *p++ = d[--n];
    43f4:	fff78793          	addi	a5,a5,-1
    43f8:	01078713          	addi	a4,a5,16
    43fc:	00270733          	add	a4,a4,sp
    4400:	ff474703          	lbu	a4,-12(a4)
    4404:	00e50023          	sb	a4,0(a0)
    4408:	00150513          	addi	a0,a0,1
    440c:	fe0794e3          	bnez	a5,43f4 <appn+0x68>
}
    4410:	01010113          	addi	sp,sp,16
    4414:	00008067          	ret

00004418 <slen>:
static int slen(const char *s) { int n = 0; while (s[n]) n++; return n; }
    4418:	00050713          	mv	a4,a0
    441c:	00000513          	li	a0,0
    4420:	0080006f          	j	4428 <slen+0x10>
    4424:	00150513          	addi	a0,a0,1
    4428:	00a707b3          	add	a5,a4,a0
    442c:	0007c783          	lbu	a5,0(a5)
    4430:	fe079ae3          	bnez	a5,4424 <slen+0xc>
    4434:	00008067          	ret

00004438 <fmt_stat>:
{
    4438:	fd010113          	addi	sp,sp,-48
    443c:	02112623          	sw	ra,44(sp)
    4440:	02812423          	sw	s0,40(sp)
    4444:	02912223          	sw	s1,36(sp)
    4448:	03212023          	sw	s2,32(sp)
    444c:	01312e23          	sw	s3,28(sp)
    4450:	01412c23          	sw	s4,24(sp)
    4454:	01512a23          	sw	s5,20(sp)
    4458:	01612823          	sw	s6,16(sp)
    445c:	01712623          	sw	s7,12(sp)
    4460:	00058a93          	mv	s5,a1
    4464:	00060a13          	mv	s4,a2
    4468:	00068b93          	mv	s7,a3
    446c:	00070913          	mv	s2,a4
    4470:	00078493          	mv	s1,a5
    4474:	00080993          	mv	s3,a6
    4478:	00088413          	mv	s0,a7
    447c:	03012b03          	lw	s6,48(sp)
    if (hw_fps > 999u) hw_fps = 999u;
    4480:	3e700793          	li	a5,999
    4484:	00b7f463          	bgeu	a5,a1,448c <fmt_stat+0x54>
    4488:	3e700a93          	li	s5,999
    if (sw_fps > 999u) sw_fps = 999u;
    448c:	3e700793          	li	a5,999
    4490:	0147f463          	bgeu	a5,s4,4498 <fmt_stat+0x60>
    4494:	3e700a13          	li	s4,999
    if (score > SCORE_CAP) score = SCORE_CAP;
    4498:	000f47b7          	lui	a5,0xf4
    449c:	23f78793          	addi	a5,a5,575 # f423f <__freertos_irq_stack_top+0xd972f>
    44a0:	0097d463          	bge	a5,s1,44a8 <fmt_stat+0x70>
    44a4:	00078493          	mv	s1,a5
    if (non > 9999) non = 9999;
    44a8:	000027b7          	lui	a5,0x2
    44ac:	70f78793          	addi	a5,a5,1807 # 270f <e_fill+0x7>
    44b0:	0127d463          	bge	a5,s2,44b8 <fmt_stat+0x80>
    44b4:	00078913          	mv	s2,a5
    p = app(p, "HW=");  p = appn(p, hw_fps, 3);
    44b8:	000075b7          	lui	a1,0x7
    44bc:	27c58593          	addi	a1,a1,636 # 727c <_data+0x30>
    44c0:	eb1ff0ef          	jal	4370 <app>
    44c4:	00300613          	li	a2,3
    44c8:	000a8593          	mv	a1,s5
    44cc:	ec1ff0ef          	jal	438c <appn>
    p = app(p, " SW="); p = appn(p, sw_fps, 3);
    44d0:	000075b7          	lui	a1,0x7
    44d4:	28058593          	addi	a1,a1,640 # 7280 <_data+0x34>
    44d8:	e99ff0ef          	jal	4370 <app>
    44dc:	00300613          	li	a2,3
    44e0:	000a0593          	mv	a1,s4
    44e4:	ea9ff0ef          	jal	438c <appn>
    p = app(p, " N=");  p = appn(p, (unsigned)ncap, 4);
    44e8:	000075b7          	lui	a1,0x7
    44ec:	28858593          	addi	a1,a1,648 # 7288 <_data+0x3c>
    44f0:	e81ff0ef          	jal	4370 <app>
    44f4:	00400613          	li	a2,4
    44f8:	000b8593          	mv	a1,s7
    44fc:	e91ff0ef          	jal	438c <appn>
    p = app(p, " ON="); p = appn(p, (unsigned)non, 4);
    4500:	000075b7          	lui	a1,0x7
    4504:	28c58593          	addi	a1,a1,652 # 728c <_data+0x40>
    4508:	e69ff0ef          	jal	4370 <app>
    450c:	00400613          	li	a2,4
    4510:	00090593          	mv	a1,s2
    4514:	e79ff0ef          	jal	438c <appn>
    p = app(p, " SC="); p = appn(p, (unsigned)score, 6);
    4518:	000075b7          	lui	a1,0x7
    451c:	29458593          	addi	a1,a1,660 # 7294 <_data+0x48>
    4520:	e51ff0ef          	jal	4370 <app>
    4524:	00600613          	li	a2,6
    4528:	00048593          	mv	a1,s1
    452c:	e61ff0ef          	jal	438c <appn>
    p = app(p, " LV="); p = appn(p, (unsigned)(level > 99 ? 99 : level), 2);
    4530:	000075b7          	lui	a1,0x7
    4534:	29c58593          	addi	a1,a1,668 # 729c <_data+0x50>
    4538:	e39ff0ef          	jal	4370 <app>
    453c:	00098593          	mv	a1,s3
    4540:	06300793          	li	a5,99
    4544:	0137d463          	bge	a5,s3,454c <fmt_stat+0x114>
    4548:	06300593          	li	a1,99
    454c:	00200613          	li	a2,2
    4550:	e3dff0ef          	jal	438c <appn>
    p = app(p, " HP="); p = appn(p, (unsigned)(hp < 0 ? 0 : (hp > 9 ? 9 : hp)), 1);
    4554:	000075b7          	lui	a1,0x7
    4558:	2a458593          	addi	a1,a1,676 # 72a4 <_data+0x58>
    455c:	e15ff0ef          	jal	4370 <app>
    4560:	06044a63          	bltz	s0,45d4 <fmt_stat+0x19c>
    4564:	00900793          	li	a5,9
    4568:	0087d463          	bge	a5,s0,4570 <fmt_stat+0x138>
    456c:	00900413          	li	s0,9
    4570:	00040593          	mv	a1,s0
    4574:	00100613          	li	a2,1
    4578:	e15ff0ef          	jal	438c <appn>
    p = app(p, " OP="); p = app(p, op ? op : "?");
    457c:	000075b7          	lui	a1,0x7
    4580:	2ac58593          	addi	a1,a1,684 # 72ac <_data+0x60>
    4584:	dedff0ef          	jal	4370 <app>
    4588:	040b0a63          	beqz	s6,45dc <fmt_stat+0x1a4>
    458c:	000b0593          	mv	a1,s6
    4590:	de1ff0ef          	jal	4370 <app>
    if (star) p = app(p, " S");
    4594:	03412783          	lw	a5,52(sp)
    4598:	04079863          	bnez	a5,45e8 <fmt_stat+0x1b0>
    if (autq) p = app(p, " G");
    459c:	03812783          	lw	a5,56(sp)
    45a0:	04079c63          	bnez	a5,45f8 <fmt_stat+0x1c0>
    *p = 0;
    45a4:	00050023          	sb	zero,0(a0)
}
    45a8:	02c12083          	lw	ra,44(sp)
    45ac:	02812403          	lw	s0,40(sp)
    45b0:	02412483          	lw	s1,36(sp)
    45b4:	02012903          	lw	s2,32(sp)
    45b8:	01c12983          	lw	s3,28(sp)
    45bc:	01812a03          	lw	s4,24(sp)
    45c0:	01412a83          	lw	s5,20(sp)
    45c4:	01012b03          	lw	s6,16(sp)
    45c8:	00c12b83          	lw	s7,12(sp)
    45cc:	03010113          	addi	sp,sp,48
    45d0:	00008067          	ret
    p = app(p, " HP="); p = appn(p, (unsigned)(hp < 0 ? 0 : (hp > 9 ? 9 : hp)), 1);
    45d4:	00000593          	li	a1,0
    45d8:	f9dff06f          	j	4574 <fmt_stat+0x13c>
    p = app(p, " OP="); p = app(p, op ? op : "?");
    45dc:	00007b37          	lui	s6,0x7
    45e0:	278b0b13          	addi	s6,s6,632 # 7278 <_data+0x2c>
    45e4:	fa9ff06f          	j	458c <fmt_stat+0x154>
    if (star) p = app(p, " S");
    45e8:	000075b7          	lui	a1,0x7
    45ec:	2b458593          	addi	a1,a1,692 # 72b4 <_data+0x68>
    45f0:	d81ff0ef          	jal	4370 <app>
    45f4:	fa9ff06f          	j	459c <fmt_stat+0x164>
    if (autq) p = app(p, " G");
    45f8:	000075b7          	lui	a1,0x7
    45fc:	2b858593          	addi	a1,a1,696 # 72b8 <_data+0x6c>
    4600:	d71ff0ef          	jal	4370 <app>
    4604:	fa1ff06f          	j	45a4 <fmt_stat+0x16c>

00004608 <osd_text_bg>:
{
    4608:	fe010113          	addi	sp,sp,-32
    460c:	00112e23          	sw	ra,28(sp)
    4610:	00812c23          	sw	s0,24(sp)
    4614:	00912a23          	sw	s1,20(sp)
    4618:	01212823          	sw	s2,16(sp)
    461c:	01312623          	sw	s3,12(sp)
    4620:	01412423          	sw	s4,8(sp)
    4624:	00050913          	mv	s2,a0
    4628:	00058993          	mv	s3,a1
    462c:	00060a13          	mv	s4,a2
    4630:	00068493          	mv	s1,a3
    4634:	00070413          	mv	s0,a4
    while (*s) {
    4638:	1000006f          	j	4738 <osd_text_bg+0x130>
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    463c:	01041693          	slli	a3,s0,0x10
    4640:	0800006f          	j	46c0 <osd_text_bg+0xb8>
                 | ((bits & 0x80u) ? (uint32_t)fg : (uint32_t)bg);
    4644:	00048613          	mv	a2,s1
    4648:	0880006f          	j	46d0 <osd_text_bg+0xc8>
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    464c:	01041693          	slli	a3,s0,0x10
    4650:	0940006f          	j	46e4 <osd_text_bg+0xdc>
                 | ((bits & 0x20u) ? (uint32_t)fg : (uint32_t)bg);
    4654:	00040613          	mv	a2,s0
    4658:	0980006f          	j	46f0 <osd_text_bg+0xe8>
            p[2] = ((bits & 0x04u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    465c:	01041693          	slli	a3,s0,0x10
    4660:	0a40006f          	j	4704 <osd_text_bg+0xfc>
                 | ((bits & 0x08u) ? (uint32_t)fg : (uint32_t)bg);
    4664:	00040613          	mv	a2,s0
    4668:	0a80006f          	j	4710 <osd_text_bg+0x108>
            p[3] = ((bits & 0x01u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    466c:	01041693          	slli	a3,s0,0x10
    4670:	0b40006f          	j	4724 <osd_text_bg+0x11c>
                 | ((bits & 0x02u) ? (uint32_t)fg : (uint32_t)bg);
    4674:	00040613          	mv	a2,s0
    4678:	00c6e6b3          	or	a3,a3,a2
            p[3] = ((bits & 0x01u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    467c:	00d7a623          	sw	a3,12(a5)
        for (row = 0; row < 8; row++) {
    4680:	00170713          	addi	a4,a4,1
    4684:	00700793          	li	a5,7
    4688:	0ae7c663          	blt	a5,a4,4734 <osd_text_bg+0x12c>
            uint8_t bits = rp[row];
    468c:	00e507b3          	add	a5,a0,a4
    4690:	0007c803          	lbu	a6,0(a5)
                                    + (uint32_t)(y + row) * FB_STRIDE + (uint32_t)x * 2u);
    4694:	013706b3          	add	a3,a4,s3
    4698:	00469793          	slli	a5,a3,0x4
    469c:	40d787b3          	sub	a5,a5,a3
    46a0:	00679793          	slli	a5,a5,0x6
    46a4:	012787b3          	add	a5,a5,s2
    46a8:	00179793          	slli	a5,a5,0x1
    46ac:	8341a683          	lw	a3,-1996(gp) # 8cac <g_fb_back>
    46b0:	00d787b3          	add	a5,a5,a3
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    46b4:	04087693          	andi	a3,a6,64
    46b8:	f80682e3          	beqz	a3,463c <osd_text_bg+0x34>
    46bc:	01049693          	slli	a3,s1,0x10
                 | ((bits & 0x80u) ? (uint32_t)fg : (uint32_t)bg);
    46c0:	01881613          	slli	a2,a6,0x18
    46c4:	41865613          	srai	a2,a2,0x18
    46c8:	f6064ee3          	bltz	a2,4644 <osd_text_bg+0x3c>
    46cc:	00040613          	mv	a2,s0
    46d0:	00c6e6b3          	or	a3,a3,a2
            p[0] = ((bits & 0x40u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    46d4:	00d7a023          	sw	a3,0(a5)
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    46d8:	01087693          	andi	a3,a6,16
    46dc:	f60688e3          	beqz	a3,464c <osd_text_bg+0x44>
    46e0:	01049693          	slli	a3,s1,0x10
                 | ((bits & 0x20u) ? (uint32_t)fg : (uint32_t)bg);
    46e4:	02087613          	andi	a2,a6,32
    46e8:	f60606e3          	beqz	a2,4654 <osd_text_bg+0x4c>
    46ec:	00048613          	mv	a2,s1
    46f0:	00c6e6b3          	or	a3,a3,a2
            p[1] = ((bits & 0x10u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    46f4:	00d7a223          	sw	a3,4(a5)
            p[2] = ((bits & 0x04u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    46f8:	00487693          	andi	a3,a6,4
    46fc:	f60680e3          	beqz	a3,465c <osd_text_bg+0x54>
    4700:	01049693          	slli	a3,s1,0x10
                 | ((bits & 0x08u) ? (uint32_t)fg : (uint32_t)bg);
    4704:	00887613          	andi	a2,a6,8
    4708:	f4060ee3          	beqz	a2,4664 <osd_text_bg+0x5c>
    470c:	00048613          	mv	a2,s1
    4710:	00c6e6b3          	or	a3,a3,a2
            p[2] = ((bits & 0x04u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    4714:	00d7a423          	sw	a3,8(a5)
            p[3] = ((bits & 0x01u) ? ((uint32_t)fg << 16) : ((uint32_t)bg << 16))
    4718:	00187693          	andi	a3,a6,1
    471c:	f40688e3          	beqz	a3,466c <osd_text_bg+0x64>
    4720:	01049693          	slli	a3,s1,0x10
                 | ((bits & 0x02u) ? (uint32_t)fg : (uint32_t)bg);
    4724:	00287813          	andi	a6,a6,2
    4728:	f40806e3          	beqz	a6,4674 <osd_text_bg+0x6c>
    472c:	00048613          	mv	a2,s1
    4730:	f49ff06f          	j	4678 <osd_text_bg+0x70>
        x += OSD_GLYPH_W;
    4734:	00890913          	addi	s2,s2,8
    while (*s) {
    4738:	000a4503          	lbu	a0,0(s4)
    473c:	00050a63          	beqz	a0,4750 <osd_text_bg+0x148>
        const uint8_t *rp = glyph_of(*s++);
    4740:	001a0a13          	addi	s4,s4,1
    4744:	d21fd0ef          	jal	2464 <glyph_of>
        for (row = 0; row < 8; row++) {
    4748:	00000713          	li	a4,0
    474c:	f39ff06f          	j	4684 <osd_text_bg+0x7c>
}
    4750:	01c12083          	lw	ra,28(sp)
    4754:	01812403          	lw	s0,24(sp)
    4758:	01412483          	lw	s1,20(sp)
    475c:	01012903          	lw	s2,16(sp)
    4760:	00c12983          	lw	s3,12(sp)
    4764:	00812a03          	lw	s4,8(sp)
    4768:	02010113          	addi	sp,sp,32
    476c:	00008067          	ret

00004770 <osd_text>:
{
    4770:	ff010113          	addi	sp,sp,-16
    4774:	00112623          	sw	ra,12(sp)
    osd_text_bg(x, y, s, fg, COL_OSD_BG);
    4778:	00000713          	li	a4,0
    477c:	e8dff0ef          	jal	4608 <osd_text_bg>
}
    4780:	00c12083          	lw	ra,12(sp)
    4784:	01010113          	addi	sp,sp,16
    4788:	00008067          	ret

0000478c <path_label>:
static const char *path_label(void) { return (g_mode == MD_SW) ? "PURE CPU" : "HW ACCEL"; }
    478c:	8201a703          	lw	a4,-2016(gp) # 8c98 <g_mode>
    4790:	00100793          	li	a5,1
    4794:	00f70863          	beq	a4,a5,47a4 <path_label+0x18>
    4798:	00007537          	lui	a0,0x7
    479c:	2c850513          	addi	a0,a0,712 # 72c8 <_data+0x7c>
    47a0:	00008067          	ret
    47a4:	00007537          	lui	a0,0x7
    47a8:	2bc50513          	addi	a0,a0,700 # 72bc <_data+0x70>
    47ac:	00008067          	ret

000047b0 <osd_build>:
{
    47b0:	fd010113          	addi	sp,sp,-48
    47b4:	02112623          	sw	ra,44(sp)
    47b8:	02812423          	sw	s0,40(sp)
    47bc:	02912223          	sw	s1,36(sp)
    47c0:	03212023          	sw	s2,32(sp)
    47c4:	01312e23          	sw	s3,28(sp)
    47c8:	01412c23          	sw	s4,24(sp)
    47cc:	01512a23          	sw	s5,20(sp)
    47d0:	01612823          	sw	s6,16(sp)
    fmt_stat(g_osd_line, g_hw_fps, g_sw_fps, g_ncap, g_on_screen, g_score, g_level, g_hp,
    47d4:	8741a403          	lw	s0,-1932(gp) # 8cec <g_hw_fps>
    47d8:	8701a483          	lw	s1,-1936(gp) # 8ce8 <g_sw_fps>
    47dc:	81c1a903          	lw	s2,-2020(gp) # 8c94 <g_ncap>
    47e0:	85c1a983          	lw	s3,-1956(gp) # 8cd4 <g_on_screen>
    47e4:	8941aa03          	lw	s4,-1900(gp) # 8d0c <g_score>
    47e8:	8101aa83          	lw	s5,-2032(gp) # 8c88 <g_level>
    47ec:	8181ab03          	lw	s6,-2024(gp) # 8c90 <g_hp>
    47f0:	8f9fd0ef          	jal	20e8 <bulm_eff_name>
    47f4:	8a01a783          	lw	a5,-1888(gp) # 8d18 <g_auto>
    47f8:	00f12423          	sw	a5,8(sp)
    47fc:	8241a783          	lw	a5,-2012(gp) # 8c9c <g_star_n>
    4800:	00f027b3          	sgtz	a5,a5
    4804:	00f12223          	sw	a5,4(sp)
    4808:	00a12023          	sw	a0,0(sp)
    480c:	000b0893          	mv	a7,s6
    4810:	000a8813          	mv	a6,s5
    4814:	000a0793          	mv	a5,s4
    4818:	00098713          	mv	a4,s3
    481c:	00090693          	mv	a3,s2
    4820:	00048613          	mv	a2,s1
    4824:	00040593          	mv	a1,s0
    4828:	90018513          	addi	a0,gp,-1792 # 8d78 <g_osd_line>
    482c:	c0dff0ef          	jal	4438 <fmt_stat>
}
    4830:	02c12083          	lw	ra,44(sp)
    4834:	02812403          	lw	s0,40(sp)
    4838:	02412483          	lw	s1,36(sp)
    483c:	02012903          	lw	s2,32(sp)
    4840:	01c12983          	lw	s3,28(sp)
    4844:	01812a03          	lw	s4,24(sp)
    4848:	01412a83          	lw	s5,20(sp)
    484c:	01012b03          	lw	s6,16(sp)
    4850:	03010113          	addi	sp,sp,48
    4854:	00008067          	ret

00004858 <pan_num>:
{
    4858:	ff010113          	addi	sp,sp,-16
    485c:	00112623          	sw	ra,12(sp)
    char *q = appn(dst, v, w);
    4860:	b2dff0ef          	jal	438c <appn>
    *q = 0;
    4864:	00050023          	sb	zero,0(a0)
}
    4868:	00c12083          	lw	ra,12(sp)
    486c:	01010113          	addi	sp,sp,16
    4870:	00008067          	ret

00004874 <osd_text2x>:
{
    4874:	fe010113          	addi	sp,sp,-32
    4878:	00112e23          	sw	ra,28(sp)
    487c:	00812c23          	sw	s0,24(sp)
    4880:	00912a23          	sw	s1,20(sp)
    4884:	01212823          	sw	s2,16(sp)
    4888:	01312623          	sw	s3,12(sp)
    488c:	01412423          	sw	s4,8(sp)
    4890:	00050413          	mv	s0,a0
    4894:	00058493          	mv	s1,a1
    4898:	00060a13          	mv	s4,a2
    489c:	00068993          	mv	s3,a3
    48a0:	00070913          	mv	s2,a4
    while (*s) {
    48a4:	0a40006f          	j	4948 <osd_text2x+0xd4>
                uint32_t c    = (bits & (0x80u >> col)) ? (uint32_t)fg : (uint32_t)bg;
    48a8:	00090793          	mv	a5,s2
                uint32_t pair = (c << 16) | c;             /* 一行两个像素 */
    48ac:	01079813          	slli	a6,a5,0x10
    48b0:	00f86833          	or	a6,a6,a5
                int px = x + col * 2;
    48b4:	00169893          	slli	a7,a3,0x1
    48b8:	008888b3          	add	a7,a7,s0
                    + (uint32_t)(y + row * 2) * FB_STRIDE + (uint32_t)px * 2u);
    48bc:	00161713          	slli	a4,a2,0x1
    48c0:	00970733          	add	a4,a4,s1
    48c4:	8341a303          	lw	t1,-1996(gp) # 8cac <g_fb_back>
    48c8:	00471793          	slli	a5,a4,0x4
    48cc:	40e787b3          	sub	a5,a5,a4
    48d0:	00679793          	slli	a5,a5,0x6
    48d4:	011787b3          	add	a5,a5,a7
    48d8:	00179793          	slli	a5,a5,0x1
    48dc:	006787b3          	add	a5,a5,t1
                p[0] = pair;
    48e0:	0107a023          	sw	a6,0(a5)
                    + (uint32_t)(y + row * 2 + 1) * FB_STRIDE + (uint32_t)px * 2u);
    48e4:	00170713          	addi	a4,a4,1
    48e8:	00471793          	slli	a5,a4,0x4
    48ec:	40e787b3          	sub	a5,a5,a4
    48f0:	00679793          	slli	a5,a5,0x6
    48f4:	011787b3          	add	a5,a5,a7
    48f8:	00179793          	slli	a5,a5,0x1
    48fc:	006787b3          	add	a5,a5,t1
                p[0] = pair;
    4900:	0107a023          	sw	a6,0(a5)
            for (col = 0; col < 8; col++) {
    4904:	00168693          	addi	a3,a3,1
    4908:	00700793          	li	a5,7
    490c:	00d7ce63          	blt	a5,a3,4928 <osd_text2x+0xb4>
                uint32_t c    = (bits & (0x80u >> col)) ? (uint32_t)fg : (uint32_t)bg;
    4910:	08000793          	li	a5,128
    4914:	00d7d7b3          	srl	a5,a5,a3
    4918:	00f5f7b3          	and	a5,a1,a5
    491c:	f80786e3          	beqz	a5,48a8 <osd_text2x+0x34>
    4920:	00098793          	mv	a5,s3
    4924:	f89ff06f          	j	48ac <osd_text2x+0x38>
        for (row = 0; row < 8; row++) {
    4928:	00160613          	addi	a2,a2,1
    492c:	00700793          	li	a5,7
    4930:	00c7ca63          	blt	a5,a2,4944 <osd_text2x+0xd0>
            uint8_t bits = rp[row];
    4934:	00c507b3          	add	a5,a0,a2
    4938:	0007c583          	lbu	a1,0(a5)
            for (col = 0; col < 8; col++) {
    493c:	00000693          	li	a3,0
    4940:	fc9ff06f          	j	4908 <osd_text2x+0x94>
        x += 16;
    4944:	01040413          	addi	s0,s0,16
    while (*s) {
    4948:	000a4503          	lbu	a0,0(s4)
    494c:	00050a63          	beqz	a0,4960 <osd_text2x+0xec>
        const uint8_t *rp = glyph_of(*s++);
    4950:	001a0a13          	addi	s4,s4,1
    4954:	b11fd0ef          	jal	2464 <glyph_of>
        for (row = 0; row < 8; row++) {
    4958:	00000613          	li	a2,0
    495c:	fd1ff06f          	j	492c <osd_text2x+0xb8>
}
    4960:	01c12083          	lw	ra,28(sp)
    4964:	01812403          	lw	s0,24(sp)
    4968:	01412483          	lw	s1,20(sp)
    496c:	01012903          	lw	s2,16(sp)
    4970:	00c12983          	lw	s3,12(sp)
    4974:	00812a03          	lw	s4,8(sp)
    4978:	02010113          	addi	sp,sp,32
    497c:	00008067          	ret

00004980 <pan_seg>:
{
    4980:	fe010113          	addi	sp,sp,-32
    4984:	00112e23          	sw	ra,28(sp)
    4988:	00812c23          	sw	s0,24(sp)
    498c:	00912a23          	sw	s1,20(sp)
    4990:	01212823          	sw	s2,16(sp)
    4994:	01312623          	sw	s3,12(sp)
    4998:	01412423          	sw	s4,8(sp)
    499c:	01512223          	sw	s5,4(sp)
    49a0:	01612023          	sw	s6,0(sp)
    49a4:	00050a13          	mv	s4,a0
    49a8:	00058993          	mv	s3,a1
    49ac:	00060493          	mv	s1,a2
    49b0:	00068913          	mv	s2,a3
    49b4:	00070b13          	mv	s6,a4
    49b8:	00078a93          	mv	s5,a5
    for (i = 0; i < n; i++)
    49bc:	00000413          	li	s0,0
    49c0:	01c0006f          	j	49dc <pan_seg+0x5c>
        cpu_fill32(g_fb_back, x + i * 18, y, 16, 10, (i < on) ? c_on : c_off);
    49c4:	000a8793          	mv	a5,s5
    49c8:	00a00713          	li	a4,10
    49cc:	01000693          	li	a3,16
    49d0:	00098613          	mv	a2,s3
    49d4:	badfd0ef          	jal	2580 <cpu_fill32>
    for (i = 0; i < n; i++)
    49d8:	00140413          	addi	s0,s0,1
    49dc:	02945263          	bge	s0,s1,4a00 <pan_seg+0x80>
        cpu_fill32(g_fb_back, x + i * 18, y, 16, 10, (i < on) ? c_on : c_off);
    49e0:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    49e4:	00341593          	slli	a1,s0,0x3
    49e8:	008585b3          	add	a1,a1,s0
    49ec:	00159593          	slli	a1,a1,0x1
    49f0:	014585b3          	add	a1,a1,s4
    49f4:	fd2458e3          	bge	s0,s2,49c4 <pan_seg+0x44>
    49f8:	000b0793          	mv	a5,s6
    49fc:	fcdff06f          	j	49c8 <pan_seg+0x48>
}
    4a00:	01c12083          	lw	ra,28(sp)
    4a04:	01812403          	lw	s0,24(sp)
    4a08:	01412483          	lw	s1,20(sp)
    4a0c:	01012903          	lw	s2,16(sp)
    4a10:	00c12983          	lw	s3,12(sp)
    4a14:	00812a03          	lw	s4,8(sp)
    4a18:	00412a83          	lw	s5,4(sp)
    4a1c:	00012b03          	lw	s6,0(sp)
    4a20:	02010113          	addi	sp,sp,32
    4a24:	00008067          	ret

00004a28 <pan_ship>:
{
    4a28:	fe010113          	addi	sp,sp,-32
    4a2c:	00112e23          	sw	ra,28(sp)
    4a30:	00812c23          	sw	s0,24(sp)
    4a34:	00912a23          	sw	s1,20(sp)
    4a38:	01212823          	sw	s2,16(sp)
    4a3c:	01312623          	sw	s3,12(sp)
    4a40:	00050413          	mv	s0,a0
    4a44:	00058493          	mv	s1,a1
    4a48:	00060913          	mv	s2,a2
    cpu_fill32(g_fb_back, x + 4, y,     4, 3, c);   /* 机头 */
    4a4c:	00060793          	mv	a5,a2
    4a50:	00300713          	li	a4,3
    4a54:	00400693          	li	a3,4
    4a58:	00058613          	mv	a2,a1
    4a5c:	00450593          	addi	a1,a0,4
    4a60:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4a64:	b1dfd0ef          	jal	2580 <cpu_fill32>
    cpu_fill32(g_fb_back, x,     y + 3, 12, 4, c);  /* 机翼 */
    4a68:	00090793          	mv	a5,s2
    4a6c:	00400713          	li	a4,4
    4a70:	00c00693          	li	a3,12
    4a74:	00348613          	addi	a2,s1,3
    4a78:	00040593          	mv	a1,s0
    4a7c:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4a80:	b01fd0ef          	jal	2580 <cpu_fill32>
    cpu_fill32(g_fb_back, x + 3, y + 7, 6, 3, c);   /* 机身 */
    4a84:	00090793          	mv	a5,s2
    4a88:	00300713          	li	a4,3
    4a8c:	00600693          	li	a3,6
    4a90:	00748613          	addi	a2,s1,7
    4a94:	00340593          	addi	a1,s0,3
    4a98:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4a9c:	ae5fd0ef          	jal	2580 <cpu_fill32>
}
    4aa0:	01c12083          	lw	ra,28(sp)
    4aa4:	01812403          	lw	s0,24(sp)
    4aa8:	01412483          	lw	s1,20(sp)
    4aac:	01012903          	lw	s2,16(sp)
    4ab0:	00c12983          	lw	s3,12(sp)
    4ab4:	02010113          	addi	sp,sp,32
    4ab8:	00008067          	ret

00004abc <osd_panel>:
{
    4abc:	fe010113          	addi	sp,sp,-32
    4ac0:	00112e23          	sw	ra,28(sp)
    4ac4:	00812c23          	sw	s0,24(sp)
    4ac8:	00912a23          	sw	s1,20(sp)
    4acc:	01212823          	sw	s2,16(sp)
    unsigned secs = g_secs % 3600u;
    4ad0:	86c1a903          	lw	s2,-1940(gp) # 8ce4 <g_secs>
    4ad4:	000017b7          	lui	a5,0x1
    4ad8:	e1078793          	addi	a5,a5,-496 # e10 <CUSTOM2+0xdb5>
    4adc:	02f97933          	remu	s2,s2,a5
    int hp = g_hp;
    4ae0:	8181a483          	lw	s1,-2024(gp) # 8c90 <g_hp>
    if (hp < 0) hp = 0;
    4ae4:	0004ca63          	bltz	s1,4af8 <osd_panel+0x3c>
    if (hp > 10) hp = 10;
    4ae8:	00a00793          	li	a5,10
    4aec:	0097d863          	bge	a5,s1,4afc <osd_panel+0x40>
    4af0:	00a00493          	li	s1,10
    4af4:	0080006f          	j	4afc <osd_panel+0x40>
    if (hp < 0) hp = 0;
    4af8:	00000493          	li	s1,0
    cpu_fill32(g_fb_back, PANEL_X, OSD_H, FB_WIDTH - PANEL_X, FB_HEIGHT - OSD_H, PANEL_BG);
    4afc:	000017b7          	lui	a5,0x1
    4b00:	86178793          	addi	a5,a5,-1951 # 861 <CUSTOM2+0x806>
    4b04:	20c00713          	li	a4,524
    4b08:	0c000693          	li	a3,192
    4b0c:	01000613          	li	a2,16
    4b10:	30000593          	li	a1,768
    4b14:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4b18:	a69fd0ef          	jal	2580 <cpu_fill32>
    cpu_fill32(g_fb_back, PANEL_X,     OSD_H, 2, FB_HEIGHT - OSD_H, PANEL_ACC);
    4b1c:	7ff00793          	li	a5,2047
    4b20:	20c00713          	li	a4,524
    4b24:	00200693          	li	a3,2
    4b28:	01000613          	li	a2,16
    4b2c:	30000593          	li	a1,768
    4b30:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4b34:	a4dfd0ef          	jal	2580 <cpu_fill32>
    cpu_fill32(g_fb_back, PANEL_X + 2, OSD_H, 1, FB_HEIGHT - OSD_H, 0x2945u);
    4b38:	000037b7          	lui	a5,0x3
    4b3c:	94578793          	addi	a5,a5,-1723 # 2945 <e_alpha+0x1d>
    4b40:	20c00713          	li	a4,524
    4b44:	00100693          	li	a3,1
    4b48:	01000613          	li	a2,16
    4b4c:	30200593          	li	a1,770
    4b50:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4b54:	a2dfd0ef          	jal	2580 <cpu_fill32>
    osd_text2x(PANEL_X + 10, y, "STATUS", PANEL_TTL, PANEL_BG);
    4b58:	00001737          	lui	a4,0x1
    4b5c:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4b60:	000106b7          	lui	a3,0x10
    4b64:	d2068693          	addi	a3,a3,-736 # fd20 <__global_pointer$+0x68a8>
    4b68:	00007637          	lui	a2,0x7
    4b6c:	2dc60613          	addi	a2,a2,732 # 72dc <_data+0x90>
    4b70:	01a00593          	li	a1,26
    4b74:	30a00513          	li	a0,778
    4b78:	cfdff0ef          	jal	4874 <osd_text2x>
    cpu_fill32(g_fb_back, PANEL_X + 10, (uint32_t)(y + 20), 172, 1, 0x2945u);
    4b7c:	000037b7          	lui	a5,0x3
    4b80:	94578793          	addi	a5,a5,-1723 # 2945 <e_alpha+0x1d>
    4b84:	00100713          	li	a4,1
    4b88:	0ac00693          	li	a3,172
    4b8c:	02e00613          	li	a2,46
    4b90:	30a00593          	li	a1,778
    4b94:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4b98:	9e9fd0ef          	jal	2580 <cpu_fill32>
    osd_text2x(PANEL_X + 10, y, "FPS", PANEL_DIM, PANEL_BG);
    4b9c:	00001737          	lui	a4,0x1
    4ba0:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4ba4:	000056b7          	lui	a3,0x5
    4ba8:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4bac:	00007637          	lui	a2,0x7
    4bb0:	2e460613          	addi	a2,a2,740 # 72e4 <_data+0x98>
    4bb4:	03a00593          	li	a1,58
    4bb8:	30a00513          	li	a0,778
    4bbc:	cb9ff0ef          	jal	4874 <osd_text2x>
    pan_num(buf, g_hw_fps, 3);
    4bc0:	00300613          	li	a2,3
    4bc4:	8741a583          	lw	a1,-1932(gp) # 8cec <g_hw_fps>
    4bc8:	00010513          	mv	a0,sp
    4bcc:	c8dff0ef          	jal	4858 <pan_num>
    osd_text2x(PANEL_X + 92, y, buf, PANEL_VAL, PANEL_BG);
    4bd0:	00001737          	lui	a4,0x1
    4bd4:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4bd8:	000106b7          	lui	a3,0x10
    4bdc:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x6b87>
    4be0:	00010613          	mv	a2,sp
    4be4:	03a00593          	li	a1,58
    4be8:	35c00513          	li	a0,860
    4bec:	c89ff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, y, "MODE", PANEL_DIM, PANEL_BG);
    4bf0:	00001737          	lui	a4,0x1
    4bf4:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4bf8:	000056b7          	lui	a3,0x5
    4bfc:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4c00:	00007637          	lui	a2,0x7
    4c04:	2e860613          	addi	a2,a2,744 # 72e8 <_data+0x9c>
    4c08:	05000593          	li	a1,80
    4c0c:	30a00513          	li	a0,778
    4c10:	c65ff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 92, y, (g_mode == MD_SW) ? "CPU" : "HW", PANEL_ACC, PANEL_BG);
    4c14:	8201a703          	lw	a4,-2016(gp) # 8c98 <g_mode>
    4c18:	00100793          	li	a5,1
    4c1c:	16f70e63          	beq	a4,a5,4d98 <osd_panel+0x2dc>
    4c20:	00007637          	lui	a2,0x7
    4c24:	2d860613          	addi	a2,a2,728 # 72d8 <_data+0x8c>
    4c28:	00001737          	lui	a4,0x1
    4c2c:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4c30:	7ff00693          	li	a3,2047
    4c34:	05000593          	li	a1,80
    4c38:	35c00513          	li	a0,860
    4c3c:	c39ff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, y, "OP", PANEL_DIM, PANEL_BG);
    4c40:	00001737          	lui	a4,0x1
    4c44:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4c48:	000056b7          	lui	a3,0x5
    4c4c:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4c50:	00007637          	lui	a2,0x7
    4c54:	2f060613          	addi	a2,a2,752 # 72f0 <_data+0xa4>
    4c58:	06e00593          	li	a1,110
    4c5c:	30a00513          	li	a0,778
    4c60:	c15ff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 92, y, bulm_eff_name(), PANEL_TTL, PANEL_BG);
    4c64:	c84fd0ef          	jal	20e8 <bulm_eff_name>
    4c68:	00050613          	mv	a2,a0
    4c6c:	00001737          	lui	a4,0x1
    4c70:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4c74:	00010437          	lui	s0,0x10
    4c78:	000106b7          	lui	a3,0x10
    4c7c:	d2068693          	addi	a3,a3,-736 # fd20 <__global_pointer$+0x68a8>
    4c80:	06e00593          	li	a1,110
    4c84:	35c00513          	li	a0,860
    4c88:	bedff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, y, "N", PANEL_DIM, PANEL_BG);
    4c8c:	00001737          	lui	a4,0x1
    4c90:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4c94:	000056b7          	lui	a3,0x5
    4c98:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4c9c:	00007637          	lui	a2,0x7
    4ca0:	2f460613          	addi	a2,a2,756 # 72f4 <_data+0xa8>
    4ca4:	08400593          	li	a1,132
    4ca8:	30a00513          	li	a0,778
    4cac:	bc9ff0ef          	jal	4874 <osd_text2x>
    pan_num(buf, (unsigned)g_ncap, 4);
    4cb0:	00400613          	li	a2,4
    4cb4:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    4cb8:	00010513          	mv	a0,sp
    4cbc:	b9dff0ef          	jal	4858 <pan_num>
    osd_text2x(PANEL_X + 92, y, buf, PANEL_VAL, PANEL_BG);
    4cc0:	00001737          	lui	a4,0x1
    4cc4:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4cc8:	fff40693          	addi	a3,s0,-1 # ffff <__global_pointer$+0x6b87>
    4ccc:	00010613          	mv	a2,sp
    4cd0:	08400593          	li	a1,132
    4cd4:	35c00513          	li	a0,860
    4cd8:	b9dff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, y, "ON", PANEL_DIM, PANEL_BG);
    4cdc:	00001737          	lui	a4,0x1
    4ce0:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4ce4:	000056b7          	lui	a3,0x5
    4ce8:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4cec:	00007637          	lui	a2,0x7
    4cf0:	2f860613          	addi	a2,a2,760 # 72f8 <_data+0xac>
    4cf4:	09a00593          	li	a1,154
    4cf8:	30a00513          	li	a0,778
    4cfc:	b79ff0ef          	jal	4874 <osd_text2x>
    pan_num(buf, (unsigned)g_on_screen, 4);
    4d00:	00400613          	li	a2,4
    4d04:	85c1a583          	lw	a1,-1956(gp) # 8cd4 <g_on_screen>
    4d08:	00010513          	mv	a0,sp
    4d0c:	b4dff0ef          	jal	4858 <pan_num>
    osd_text2x(PANEL_X + 92, y, buf, PANEL_VAL, PANEL_BG);
    4d10:	00001737          	lui	a4,0x1
    4d14:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4d18:	fff40693          	addi	a3,s0,-1
    4d1c:	00010613          	mv	a2,sp
    4d20:	09a00593          	li	a1,154
    4d24:	35c00513          	li	a0,860
    4d28:	b4dff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, y, "HP", PANEL_DIM, PANEL_BG);
    4d2c:	00001737          	lui	a4,0x1
    4d30:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4d34:	000056b7          	lui	a3,0x5
    4d38:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4d3c:	00007637          	lui	a2,0x7
    4d40:	2fc60613          	addi	a2,a2,764 # 72fc <_data+0xb0>
    4d44:	0ba00593          	li	a1,186
    4d48:	30a00513          	li	a0,778
    4d4c:	b29ff0ef          	jal	4874 <osd_text2x>
    pan_num(buf, (unsigned)hp, 2);
    4d50:	00200613          	li	a2,2
    4d54:	00048593          	mv	a1,s1
    4d58:	00010513          	mv	a0,sp
    4d5c:	afdff0ef          	jal	4858 <pan_num>
    osd_text2x(PANEL_X + 120, y, buf, PANEL_VAL, PANEL_BG);
    4d60:	00001737          	lui	a4,0x1
    4d64:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4d68:	fff40693          	addi	a3,s0,-1
    4d6c:	00010613          	mv	a2,sp
    4d70:	0ba00593          	li	a1,186
    4d74:	37800513          	li	a0,888
    4d78:	afdff0ef          	jal	4874 <osd_text2x>
    pan_seg(PANEL_X + 10, y + 20, 10, hp,
    4d7c:	00300793          	li	a5,3
    4d80:	0297c263          	blt	a5,s1,4da4 <osd_panel+0x2e8>
    4d84:	00100793          	li	a5,1
    4d88:	0e97da63          	bge	a5,s1,4e7c <osd_panel+0x3c0>
    4d8c:	00010737          	lui	a4,0x10
    4d90:	d2070713          	addi	a4,a4,-736 # fd20 <__global_pointer$+0x68a8>
    4d94:	0140006f          	j	4da8 <osd_panel+0x2ec>
    osd_text2x(PANEL_X + 92, y, (g_mode == MD_SW) ? "CPU" : "HW", PANEL_ACC, PANEL_BG);
    4d98:	00007637          	lui	a2,0x7
    4d9c:	2d460613          	addi	a2,a2,724 # 72d4 <_data+0x88>
    4da0:	e89ff06f          	j	4c28 <osd_panel+0x16c>
    pan_seg(PANEL_X + 10, y + 20, 10, hp,
    4da4:	7e000713          	li	a4,2016
    4da8:	000027b7          	lui	a5,0x2
    4dac:	8e378793          	addi	a5,a5,-1821 # 18e3 <clint_uDelay+0x17>
    4db0:	00048693          	mv	a3,s1
    4db4:	00a00613          	li	a2,10
    4db8:	0ce00593          	li	a1,206
    4dbc:	30a00513          	li	a0,778
    4dc0:	bc1ff0ef          	jal	4980 <pan_seg>
    osd_text2x(PANEL_X + 10, y, "PWR", PANEL_DIM, PANEL_BG);
    4dc4:	00001737          	lui	a4,0x1
    4dc8:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4dcc:	000056b7          	lui	a3,0x5
    4dd0:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4dd4:	00007637          	lui	a2,0x7
    4dd8:	30060613          	addi	a2,a2,768 # 7300 <_data+0xb4>
    4ddc:	0e600593          	li	a1,230
    4de0:	30a00513          	li	a0,778
    4de4:	a91ff0ef          	jal	4874 <osd_text2x>
    pan_num(buf, (unsigned)(g_bomb > 10 ? 10 : g_bomb), 2);
    4de8:	8141a583          	lw	a1,-2028(gp) # 8c8c <g_bomb>
    4dec:	00a00793          	li	a5,10
    4df0:	00b7d463          	bge	a5,a1,4df8 <osd_panel+0x33c>
    4df4:	00a00593          	li	a1,10
    4df8:	00200613          	li	a2,2
    4dfc:	00010513          	mv	a0,sp
    4e00:	a59ff0ef          	jal	4858 <pan_num>
    osd_text2x(PANEL_X + 120, y, buf, PANEL_VAL, PANEL_BG);
    4e04:	00001737          	lui	a4,0x1
    4e08:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4e0c:	000106b7          	lui	a3,0x10
    4e10:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x6b87>
    4e14:	00010613          	mv	a2,sp
    4e18:	0e600593          	li	a1,230
    4e1c:	37800513          	li	a0,888
    4e20:	a55ff0ef          	jal	4874 <osd_text2x>
    pan_seg(PANEL_X + 10, y + 20, 10, (g_bomb > 10 ? 10 : g_bomb), 0x07FFu, 0x18E3u);
    4e24:	8141a683          	lw	a3,-2028(gp) # 8c8c <g_bomb>
    4e28:	00a00793          	li	a5,10
    4e2c:	00d7d463          	bge	a5,a3,4e34 <osd_panel+0x378>
    4e30:	00a00693          	li	a3,10
    4e34:	000027b7          	lui	a5,0x2
    4e38:	8e378793          	addi	a5,a5,-1821 # 18e3 <clint_uDelay+0x17>
    4e3c:	7ff00713          	li	a4,2047
    4e40:	00a00613          	li	a2,10
    4e44:	0fa00593          	li	a1,250
    4e48:	30a00513          	li	a0,778
    4e4c:	b35ff0ef          	jal	4980 <pan_seg>
    osd_text2x(PANEL_X + 10, y, "LIFE", PANEL_DIM, PANEL_BG);
    4e50:	00001737          	lui	a4,0x1
    4e54:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4e58:	000056b7          	lui	a3,0x5
    4e5c:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4e60:	00007637          	lui	a2,0x7
    4e64:	30460613          	addi	a2,a2,772 # 7304 <_data+0xb8>
    4e68:	11200593          	li	a1,274
    4e6c:	30a00513          	li	a0,778
    4e70:	a05ff0ef          	jal	4874 <osd_text2x>
    for (i = 0; i < hp && i < 9; i++)
    4e74:	00000413          	li	s0,0
    4e78:	0240006f          	j	4e9c <osd_panel+0x3e0>
    pan_seg(PANEL_X + 10, y + 20, 10, hp,
    4e7c:	00010737          	lui	a4,0x10
    4e80:	80070713          	addi	a4,a4,-2048 # f800 <__global_pointer$+0x6388>
    4e84:	f25ff06f          	j	4da8 <osd_panel+0x2ec>
        pan_ship(PANEL_X + 10 + i * 18, y + 20, (hp >= 4) ? 0x07E0u : 0xF800u);
    4e88:	00010637          	lui	a2,0x10
    4e8c:	80060613          	addi	a2,a2,-2048 # f800 <__global_pointer$+0x6388>
    4e90:	12600593          	li	a1,294
    4e94:	b95ff0ef          	jal	4a28 <pan_ship>
    for (i = 0; i < hp && i < 9; i++)
    4e98:	00140413          	addi	s0,s0,1
    4e9c:	02945663          	bge	s0,s1,4ec8 <osd_panel+0x40c>
    4ea0:	00800793          	li	a5,8
    4ea4:	0287c263          	blt	a5,s0,4ec8 <osd_panel+0x40c>
        pan_ship(PANEL_X + 10 + i * 18, y + 20, (hp >= 4) ? 0x07E0u : 0xF800u);
    4ea8:	00341513          	slli	a0,s0,0x3
    4eac:	00850533          	add	a0,a0,s0
    4eb0:	00151513          	slli	a0,a0,0x1
    4eb4:	30a50513          	addi	a0,a0,778
    4eb8:	00300793          	li	a5,3
    4ebc:	fc97d6e3          	bge	a5,s1,4e88 <osd_panel+0x3cc>
    4ec0:	7e000613          	li	a2,2016
    4ec4:	fcdff06f          	j	4e90 <osd_panel+0x3d4>
    osd_text2x(PANEL_X + 10, y, "TIME", PANEL_DIM, PANEL_BG);
    4ec8:	00001737          	lui	a4,0x1
    4ecc:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4ed0:	000056b7          	lui	a3,0x5
    4ed4:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4ed8:	00007637          	lui	a2,0x7
    4edc:	30c60613          	addi	a2,a2,780 # 730c <_data+0xc0>
    4ee0:	13e00593          	li	a1,318
    4ee4:	30a00513          	li	a0,778
    4ee8:	98dff0ef          	jal	4874 <osd_text2x>
        q = appn(q, secs / 60u, 2);
    4eec:	03c00413          	li	s0,60
    4ef0:	00200613          	li	a2,2
    4ef4:	028955b3          	divu	a1,s2,s0
    4ef8:	00010513          	mv	a0,sp
    4efc:	c90ff0ef          	jal	438c <appn>
        *q++ = ':';
    4f00:	03a00793          	li	a5,58
    4f04:	00f50023          	sb	a5,0(a0)
        q = appn(q, secs % 60u, 2);
    4f08:	00200613          	li	a2,2
    4f0c:	028975b3          	remu	a1,s2,s0
    4f10:	00150513          	addi	a0,a0,1
    4f14:	c78ff0ef          	jal	438c <appn>
        *q = 0;
    4f18:	00050023          	sb	zero,0(a0)
    osd_text2x(PANEL_X + 92, y, buf, PANEL_VAL, PANEL_BG);
    4f1c:	00001737          	lui	a4,0x1
    4f20:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4f24:	000106b7          	lui	a3,0x10
    4f28:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x6b87>
    4f2c:	00010613          	mv	a2,sp
    4f30:	13e00593          	li	a1,318
    4f34:	35c00513          	li	a0,860
    4f38:	93dff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, FB_HEIGHT - 40, "Z FIRE", PANEL_DIM, PANEL_BG);
    4f3c:	00001737          	lui	a4,0x1
    4f40:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4f44:	000056b7          	lui	a3,0x5
    4f48:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4f4c:	00007637          	lui	a2,0x7
    4f50:	31460613          	addi	a2,a2,788 # 7314 <_data+0xc8>
    4f54:	1f400593          	li	a1,500
    4f58:	30a00513          	li	a0,778
    4f5c:	919ff0ef          	jal	4874 <osd_text2x>
    osd_text2x(PANEL_X + 10, FB_HEIGHT - 22, "X BOMB", PANEL_DIM, PANEL_BG);
    4f60:	00001737          	lui	a4,0x1
    4f64:	86170713          	addi	a4,a4,-1951 # 861 <CUSTOM2+0x806>
    4f68:	000056b7          	lui	a3,0x5
    4f6c:	a6968693          	addi	a3,a3,-1431 # 4a69 <pan_ship+0x41>
    4f70:	00007637          	lui	a2,0x7
    4f74:	31c60613          	addi	a2,a2,796 # 731c <_data+0xd0>
    4f78:	20600593          	li	a1,518
    4f7c:	30a00513          	li	a0,778
    4f80:	8f5ff0ef          	jal	4874 <osd_text2x>
}
    4f84:	01c12083          	lw	ra,28(sp)
    4f88:	01812403          	lw	s0,24(sp)
    4f8c:	01412483          	lw	s1,20(sp)
    4f90:	01012903          	lw	s2,16(sp)
    4f94:	02010113          	addi	sp,sp,32
    4f98:	00008067          	ret

00004f9c <osd_blit>:
{
    4f9c:	ff010113          	addi	sp,sp,-16
    4fa0:	00112623          	sw	ra,12(sp)
    4fa4:	00812423          	sw	s0,8(sp)
    4fa8:	00912223          	sw	s1,4(sp)
    const char *lbl = path_label();
    4fac:	fe0ff0ef          	jal	478c <path_label>
    4fb0:	00050413          	mv	s0,a0
    int lw = slen(g_osd_line);
    4fb4:	90018513          	addi	a0,gp,-1792 # 8d78 <g_osd_line>
    4fb8:	c60ff0ef          	jal	4418 <slen>
    int lx = OSD_GLYPH_W * lw;
    4fbc:	00351693          	slli	a3,a0,0x3
    if (lw > OSD_LEFT_CH) { lw = OSD_LEFT_CH; lx = OSD_LEFT_PX; }
    4fc0:	04000793          	li	a5,64
    4fc4:	00a7d463          	bge	a5,a0,4fcc <osd_blit+0x30>
    4fc8:	20000693          	li	a3,512
    cpu_fill32(g_fb_back, OSD_TEXT_X0, 0, lx, OSD_H, COL_OSD_BG);
    4fcc:	00000793          	li	a5,0
    4fd0:	01000713          	li	a4,16
    4fd4:	00000613          	li	a2,0
    4fd8:	00800593          	li	a1,8
    4fdc:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4fe0:	da0fd0ef          	jal	2580 <cpu_fill32>
    cpu_fill32(g_fb_back, FB_WIDTH - OSD_RIGHT_PX, 0, OSD_RIGHT_PX, OSD_H, COL_OSD_BG);
    4fe4:	00000793          	li	a5,0
    4fe8:	01000713          	li	a4,16
    4fec:	04000693          	li	a3,64
    4ff0:	00000613          	li	a2,0
    4ff4:	38000593          	li	a1,896
    4ff8:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    4ffc:	d84fd0ef          	jal	2580 <cpu_fill32>
    osd_text(OSD_TEXT_X0, OSD_TEXT_Y, g_osd_line, COL_WHITE);
    5000:	000106b7          	lui	a3,0x10
    5004:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x6b87>
    5008:	90018613          	addi	a2,gp,-1792 # 8d78 <g_osd_line>
    500c:	00400593          	li	a1,4
    5010:	00800513          	li	a0,8
    5014:	f5cff0ef          	jal	4770 <osd_text>
    osd_text(FB_WIDTH - OSD_GLYPH_W * slen(lbl), OSD_TEXT_Y, lbl, COL_CYAN);
    5018:	00040513          	mv	a0,s0
    501c:	bfcff0ef          	jal	4418 <slen>
    5020:	07800793          	li	a5,120
    5024:	40a78533          	sub	a0,a5,a0
    5028:	7ff00693          	li	a3,2047
    502c:	00040613          	mv	a2,s0
    5030:	00400593          	li	a1,4
    5034:	00351513          	slli	a0,a0,0x3
    5038:	f38ff0ef          	jal	4770 <osd_text>
    osd_panel();                 /* 右侧信息面板：画在游戏区之外，游戏内容不会覆盖 */
    503c:	a81ff0ef          	jal	4abc <osd_panel>
}
    5040:	00c12083          	lw	ra,12(sp)
    5044:	00812403          	lw	s0,8(sp)
    5048:	00412483          	lw	s1,4(sp)
    504c:	01010113          	addi	sp,sp,16
    5050:	00008067          	ret

00005054 <center_text>:
{
    5054:	fe010113          	addi	sp,sp,-32
    5058:	00112e23          	sw	ra,28(sp)
    505c:	00812c23          	sw	s0,24(sp)
    5060:	00912a23          	sw	s1,20(sp)
    5064:	01212823          	sw	s2,16(sp)
    5068:	01312623          	sw	s3,12(sp)
    506c:	00050913          	mv	s2,a0
    5070:	00058493          	mv	s1,a1
    5074:	00060993          	mv	s3,a2
    int n = slen(s);
    5078:	ba0ff0ef          	jal	4418 <slen>
    int x = (FB_WIDTH - OSD_GLYPH_W * n) / 2;
    507c:	07800413          	li	s0,120
    5080:	40a40433          	sub	s0,s0,a0
    5084:	00241413          	slli	s0,s0,0x2
    if (x < 8) x = 8;
    5088:	00700793          	li	a5,7
    508c:	0087c463          	blt	a5,s0,5094 <center_text+0x40>
    5090:	00800413          	li	s0,8
    if (x + OSD_GLYPH_W * n + 8 > FB_WIDTH) return;
    5094:	00351793          	slli	a5,a0,0x3
    5098:	008787b3          	add	a5,a5,s0
    509c:	3b800713          	li	a4,952
    50a0:	02f75063          	bge	a4,a5,50c0 <center_text+0x6c>
}
    50a4:	01c12083          	lw	ra,28(sp)
    50a8:	01812403          	lw	s0,24(sp)
    50ac:	01412483          	lw	s1,20(sp)
    50b0:	01012903          	lw	s2,16(sp)
    50b4:	00c12983          	lw	s3,12(sp)
    50b8:	02010113          	addi	sp,sp,32
    50bc:	00008067          	ret
    cpu_fill32(g_fb_back, x - 8, y - 4, OSD_GLYPH_W * n + 16, OSD_GLYPH_H + 8, COL_OSD_BG);
    50c0:	00250693          	addi	a3,a0,2
    50c4:	00000793          	li	a5,0
    50c8:	01000713          	li	a4,16
    50cc:	00369693          	slli	a3,a3,0x3
    50d0:	ffc48613          	addi	a2,s1,-4
    50d4:	ff840593          	addi	a1,s0,-8
    50d8:	8341a503          	lw	a0,-1996(gp) # 8cac <g_fb_back>
    50dc:	ca4fd0ef          	jal	2580 <cpu_fill32>
    osd_text(x, y, s, fg);
    50e0:	00098693          	mv	a3,s3
    50e4:	00090613          	mv	a2,s2
    50e8:	00048593          	mv	a1,s1
    50ec:	00040513          	mv	a0,s0
    50f0:	e80ff0ef          	jal	4770 <osd_text>
    50f4:	fb1ff06f          	j	50a4 <center_text+0x50>

000050f8 <overlay_draw>:
{
    50f8:	ff010113          	addi	sp,sp,-16
    50fc:	00112623          	sw	ra,12(sp)
    if (g_state == GS_TITLE) {
    5100:	8a81a783          	lw	a5,-1880(gp) # 8d20 <g_state>
    5104:	02078063          	beqz	a5,5124 <overlay_draw+0x2c>
    } else if (g_pause) {
    5108:	8a41a703          	lw	a4,-1884(gp) # 8d1c <g_pause>
    510c:	06071c63          	bnez	a4,5184 <overlay_draw+0x8c>
    } else if (g_state == GS_OVER) {
    5110:	00200713          	li	a4,2
    5114:	08e78663          	beq	a5,a4,51a0 <overlay_draw+0xa8>
}
    5118:	00c12083          	lw	ra,12(sp)
    511c:	01010113          	addi	sp,sp,16
    5120:	00008067          	ret
        center_text("DANMAKU SURVIVAL", y - 40, COL_CYAN);
    5124:	7ff00613          	li	a2,2047
    5128:	0b000593          	li	a1,176
    512c:	00007537          	lui	a0,0x7
    5130:	32450513          	addi	a0,a0,804 # 7324 <_data+0xd8>
    5134:	f21ff0ef          	jal	5054 <center_text>
        center_text("HW 2D ACCEL DEMO", y - 16, COL_WHITE);
    5138:	00010637          	lui	a2,0x10
    513c:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x6b87>
    5140:	0c800593          	li	a1,200
    5144:	00007537          	lui	a0,0x7
    5148:	33850513          	addi	a0,a0,824 # 7338 <_data+0xec>
    514c:	f09ff0ef          	jal	5054 <center_text>
        center_text("PRESS FIRE (J / SPACE)", y + 28, COL_AMBER);
    5150:	00010637          	lui	a2,0x10
    5154:	d2060613          	addi	a2,a2,-736 # fd20 <__global_pointer$+0x68a8>
    5158:	0f400593          	li	a1,244
    515c:	00007537          	lui	a0,0x7
    5160:	34c50513          	addi	a0,a0,844 # 734c <_data+0x100>
    5164:	ef1ff0ef          	jal	5054 <center_text>
        center_text("WASD MOVE  K FOCUS  L BOMB", y + 52, COL_GRAY);
    5168:	00008637          	lui	a2,0x8
    516c:	41060613          	addi	a2,a2,1040 # 8410 <_data+0x11c4>
    5170:	10c00593          	li	a1,268
    5174:	00007537          	lui	a0,0x7
    5178:	36450513          	addi	a0,a0,868 # 7364 <_data+0x118>
    517c:	ed9ff0ef          	jal	5054 <center_text>
    5180:	f99ff06f          	j	5118 <overlay_draw+0x20>
        center_text("PAUSED", y, COL_AMBER);
    5184:	00010637          	lui	a2,0x10
    5188:	d2060613          	addi	a2,a2,-736 # fd20 <__global_pointer$+0x68a8>
    518c:	0d800593          	li	a1,216
    5190:	00007537          	lui	a0,0x7
    5194:	38050513          	addi	a0,a0,896 # 7380 <_data+0x134>
    5198:	ebdff0ef          	jal	5054 <center_text>
    519c:	f7dff06f          	j	5118 <overlay_draw+0x20>
        center_text("GAME OVER", y - 16, COL_RED);
    51a0:	00010637          	lui	a2,0x10
    51a4:	80060613          	addi	a2,a2,-2048 # f800 <__global_pointer$+0x6388>
    51a8:	0c800593          	li	a1,200
    51ac:	00007537          	lui	a0,0x7
    51b0:	38850513          	addi	a0,a0,904 # 7388 <_data+0x13c>
    51b4:	ea1ff0ef          	jal	5054 <center_text>
        center_text("PRESS FIRE TO RESTART", y + 20, COL_WHITE);
    51b8:	00010637          	lui	a2,0x10
    51bc:	fff60613          	addi	a2,a2,-1 # ffff <__global_pointer$+0x6b87>
    51c0:	0ec00593          	li	a1,236
    51c4:	00007537          	lui	a0,0x7
    51c8:	39450513          	addi	a0,a0,916 # 7394 <_data+0x148>
    51cc:	e89ff0ef          	jal	5054 <center_text>
}
    51d0:	f49ff06f          	j	5118 <overlay_draw+0x20>

000051d4 <stars_reset>:
{
    51d4:	ff010113          	addi	sp,sp,-16
    51d8:	00112623          	sw	ra,12(sp)
    51dc:	00812423          	sw	s0,8(sp)
    51e0:	00912223          	sw	s1,4(sp)
    for (i = 0; i < STAR_MAX; i++) {
    51e4:	00000493          	li	s1,0
    51e8:	0280006f          	j	5210 <stars_reset+0x3c>
            g_star[i].col = (t < 8u)  ? 0xFFFFu      /* 最亮（少量，接近白） */
    51ec:	00010737          	lui	a4,0x10
    51f0:	fff70713          	addi	a4,a4,-1 # ffff <__global_pointer$+0x6b87>
    51f4:	000097b7          	lui	a5,0x9
    51f8:	00349693          	slli	a3,s1,0x3
    51fc:	dbc78793          	addi	a5,a5,-580 # 8dbc <g_star>
    5200:	00d787b3          	add	a5,a5,a3
    5204:	00e79223          	sh	a4,4(a5)
        g_star[i].spd = 0;                           /* 0 = 完全静止（用户要求背景固定） */
    5208:	00078323          	sb	zero,6(a5)
    for (i = 0; i < STAR_MAX; i++) {
    520c:	00148493          	addi	s1,s1,1
    5210:	07f00793          	li	a5,127
    5214:	0697c663          	blt	a5,s1,5280 <stars_reset+0xac>
        g_star[i].x = (int16_t)(rnd() % (uint32_t)(PLAY_W - 2));
    5218:	c35fd0ef          	jal	2e4c <rnd>
    521c:	2fe00793          	li	a5,766
    5220:	02f57533          	remu	a0,a0,a5
    5224:	00009437          	lui	s0,0x9
    5228:	00349793          	slli	a5,s1,0x3
    522c:	dbc40413          	addi	s0,s0,-580 # 8dbc <g_star>
    5230:	00f40433          	add	s0,s0,a5
    5234:	00a41023          	sh	a0,0(s0)
        g_star[i].y = (int16_t)(PLAY_Y0 + (rnd() % (uint32_t)(PLAY_H - 2)));
    5238:	c15fd0ef          	jal	2e4c <rnd>
    523c:	20a00793          	li	a5,522
    5240:	02f57533          	remu	a0,a0,a5
    5244:	01050513          	addi	a0,a0,16
    5248:	00a41123          	sh	a0,2(s0)
            unsigned t = rnd() % 100u;
    524c:	c01fd0ef          	jal	2e4c <rnd>
    5250:	06400793          	li	a5,100
    5254:	02f57533          	remu	a0,a0,a5
            g_star[i].col = (t < 8u)  ? 0xFFFFu      /* 最亮（少量，接近白） */
    5258:	00700793          	li	a5,7
    525c:	f8a7f8e3          	bgeu	a5,a0,51ec <stars_reset+0x18>
    5260:	02500793          	li	a5,37
    5264:	00a7e863          	bltu	a5,a0,5274 <stars_reset+0xa0>
    5268:	0000d737          	lui	a4,0xd
    526c:	e7970713          	addi	a4,a4,-391 # ce79 <__global_pointer$+0x3a01>
    5270:	f85ff06f          	j	51f4 <stars_reset+0x20>
    5274:	00004737          	lui	a4,0x4
    5278:	9e770713          	addi	a4,a4,-1561 # 39e7 <build_draw_list+0x10f>
    527c:	f79ff06f          	j	51f4 <stars_reset+0x20>
}
    5280:	00c12083          	lw	ra,12(sp)
    5284:	00812403          	lw	s0,8(sp)
    5288:	00412483          	lw	s1,4(sp)
    528c:	01010113          	addi	sp,sp,16
    5290:	00008067          	ret

00005294 <game_reset>:
    for (i = 0; i < BUL_TOTAL; i++) g_bul[i].life = 0;
    5294:	00000713          	li	a4,0
    5298:	0240006f          	j	52bc <game_reset+0x28>
    529c:	000137b7          	lui	a5,0x13
    52a0:	00171693          	slli	a3,a4,0x1
    52a4:	00e686b3          	add	a3,a3,a4
    52a8:	00269613          	slli	a2,a3,0x2
    52ac:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    52b0:	00c787b3          	add	a5,a5,a2
    52b4:	000785a3          	sb	zero,11(a5)
    52b8:	00170713          	addi	a4,a4,1
    52bc:	000017b7          	lui	a5,0x1
    52c0:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    52c4:	fce7dce3          	bge	a5,a4,529c <game_reset+0x8>
    for (i = 0; i < SPARK_MAX; i++) g_spk[i].life = 0;
    52c8:	00000713          	li	a4,0
    52cc:	0240006f          	j	52f0 <game_reset+0x5c>
    52d0:	000127b7          	lui	a5,0x12
    52d4:	00171693          	slli	a3,a4,0x1
    52d8:	00e686b3          	add	a3,a3,a4
    52dc:	00269613          	slli	a2,a3,0x2
    52e0:	47c78793          	addi	a5,a5,1148 # 1247c <g_spk>
    52e4:	00c787b3          	add	a5,a5,a2
    52e8:	000785a3          	sb	zero,11(a5)
    52ec:	00170713          	addi	a4,a4,1
    52f0:	05f00793          	li	a5,95
    52f4:	fce7dee3          	bge	a5,a4,52d0 <game_reset+0x3c>
    g_bul_live = 0;
    52f8:	8401aa23          	sw	zero,-1964(gp) # 8ccc <g_bul_live>
    for (i = 0; i < ENEMY_MAX; i++) {
    52fc:	00000713          	li	a4,0
    5300:	03c0006f          	j	533c <game_reset+0xa8>
        g_en[i].t = 0; g_en[i].x = 0; g_en[i].y = 0; g_en[i].vx = 0; g_en[i].vy = 0;
    5304:	000127b7          	lui	a5,0x12
    5308:	00471693          	slli	a3,a4,0x4
    530c:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    5310:	00d787b3          	add	a5,a5,a3
    5314:	00079723          	sh	zero,14(a5)
    5318:	00079023          	sh	zero,0(a5)
    531c:	00079123          	sh	zero,2(a5)
    5320:	00079223          	sh	zero,4(a5)
    5324:	00079323          	sh	zero,6(a5)
        g_en[i].hp = 0; g_en[i].kind = 0; g_en[i].fire = 0; g_en[i].phase = 0;
    5328:	00079423          	sh	zero,8(a5)
    532c:	00078523          	sb	zero,10(a5)
    5330:	000785a3          	sb	zero,11(a5)
    5334:	00078623          	sb	zero,12(a5)
    for (i = 0; i < ENEMY_MAX; i++) {
    5338:	00170713          	addi	a4,a4,1
    533c:	01700793          	li	a5,23
    5340:	fce7d2e3          	bge	a5,a4,5304 <game_reset+0x70>
    g_px = (int16_t)FP(PLAY_W / 2);
    5344:	000017b7          	lui	a5,0x1
    5348:	c0078793          	addi	a5,a5,-1024 # c00 <CUSTOM2+0xba5>
    534c:	88f19f23          	sh	a5,-1890(gp) # 8d16 <g_px>
    g_py = (int16_t)FP(PLAY_Y1 - 70);
    5350:	000017b7          	lui	a5,0x1
    5354:	eb078793          	addi	a5,a5,-336 # eb0 <CUSTOM2+0xe55>
    5358:	88f19e23          	sh	a5,-1892(gp) # 8d14 <g_py>
    g_invuln = 90; g_hp = 3; g_bomb = 3; g_level = 1; g_score = 0;
    535c:	05a00713          	li	a4,90
    5360:	88e1ac23          	sw	a4,-1896(gp) # 8d10 <g_invuln>
    5364:	00300793          	li	a5,3
    5368:	80f1ac23          	sw	a5,-2024(gp) # 8c90 <g_hp>
    536c:	80f1aa23          	sw	a5,-2028(gp) # 8c8c <g_bomb>
    5370:	00100793          	li	a5,1
    5374:	80f1a823          	sw	a5,-2032(gp) # 8c88 <g_level>
    5378:	8801aa23          	sw	zero,-1900(gp) # 8d0c <g_score>
    g_shot_t = 0; g_level_t = 0; g_bomb_req = 0;
    537c:	8801a823          	sw	zero,-1904(gp) # 8d08 <g_shot_t>
    5380:	8801a623          	sw	zero,-1908(gp) # 8d04 <g_level_t>
    5384:	8801a223          	sw	zero,-1916(gp) # 8cfc <g_bomb_req>
    g_state = GS_PLAY; g_pause = 0;
    5388:	8af1a423          	sw	a5,-1880(gp) # 8d20 <g_state>
    538c:	8a01a223          	sw	zero,-1884(gp) # 8d1c <g_pause>
        g_secs = 0;                 /* ★面板 TIME 记的是单局时长：每局开始归零 */
    5390:	8601a623          	sw	zero,-1940(gp) # 8ce4 <g_secs>
    g_frames = 0;
    5394:	8601ac23          	sw	zero,-1928(gp) # 8cf0 <g_frames>
}
    5398:	00008067          	ret

0000539c <wait_engine_idle>:
{
    539c:	ff010113          	addi	sp,sp,-16
    53a0:	00112623          	sw	ra,12(sp)
    53a4:	00812423          	sw	s0,8(sp)
    53a8:	00912223          	sw	s1,4(sp)
    53ac:	01212023          	sw	s2,0(sp)
    uint32_t t0 = tick32();
    53b0:	91cfd0ef          	jal	24cc <tick32>
    53b4:	00050913          	mv	s2,a0
    uint32_t spin = 0;
    53b8:	00000413          	li	s0,0
    53bc:	0100006f          	j	53cc <wait_engine_idle+0x30>
        spin++;
    53c0:	00140413          	addi	s0,s0,1
        cpu_backoff(BLT_WAIT_NOP);
    53c4:	03000513          	li	a0,48
    53c8:	910fd0ef          	jal	24d8 <cpu_backoff>
        if ((spin & BLT_WAIT_MASK) == 0u) {
    53cc:	00347793          	andi	a5,s0,3
    53d0:	fe0798e3          	bnez	a5,53c0 <wait_engine_idle+0x24>
            if (blt_idle_st(blt_stat())) return 1;
    53d4:	e18fd0ef          	jal	29ec <blt_stat>
    53d8:	e30fd0ef          	jal	2a08 <blt_idle_st>
    53dc:	00050493          	mv	s1,a0
    53e0:	00051e63          	bnez	a0,53fc <wait_engine_idle+0x60>
            if ((uint32_t)(tick32() - t0) > (uint32_t)ENGINE_TO_TICKS) return 0;
    53e4:	8e8fd0ef          	jal	24cc <tick32>
    53e8:	41250533          	sub	a0,a0,s2
    53ec:	000f47b7          	lui	a5,0xf4
    53f0:	24078793          	addi	a5,a5,576 # f4240 <__freertos_irq_stack_top+0xd9730>
    53f4:	fca7f6e3          	bgeu	a5,a0,53c0 <wait_engine_idle+0x24>
    53f8:	0080006f          	j	5400 <wait_engine_idle+0x64>
            if (blt_idle_st(blt_stat())) return 1;
    53fc:	00100493          	li	s1,1
}
    5400:	00048513          	mv	a0,s1
    5404:	00c12083          	lw	ra,12(sp)
    5408:	00812403          	lw	s0,8(sp)
    540c:	00412483          	lw	s1,4(sp)
    5410:	00012903          	lw	s2,0(sp)
    5414:	01010113          	addi	sp,sp,16
    5418:	00008067          	ret

0000541c <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    541c:	fc010113          	addi	sp,sp,-64
    5420:	00112e23          	sw	ra,28(sp)
    5424:	00812c23          	sw	s0,24(sp)
    5428:	00912a23          	sw	s1,20(sp)
    542c:	00050493          	mv	s1,a0
    5430:	02b12223          	sw	a1,36(sp)
    5434:	02c12423          	sw	a2,40(sp)
    5438:	02d12623          	sw	a3,44(sp)
    543c:	02e12823          	sw	a4,48(sp)
    5440:	02f12a23          	sw	a5,52(sp)
    5444:	03012c23          	sw	a6,56(sp)
    5448:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    544c:	02410793          	addi	a5,sp,36
    5450:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    5454:	00000413          	li	s0,0
    5458:	01c0006f          	j	5474 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    545c:	00c12783          	lw	a5,12(sp)
    5460:	00478713          	addi	a4,a5,4
    5464:	00e12623          	sw	a4,12(sp)
    5468:	0007a503          	lw	a0,0(a5)
    546c:	d90fc0ef          	jal	19fc <bsp_printf_c>
        for (i = 0; format[i]; i++)
    5470:	00140413          	addi	s0,s0,1
    5474:	008487b3          	add	a5,s1,s0
    5478:	0007c503          	lbu	a0,0(a5)
    547c:	0a050e63          	beqz	a0,5538 <bsp_printf+0x11c>
            if (format[i] == '%') {
    5480:	02500793          	li	a5,37
    5484:	06f50e63          	beq	a0,a5,5500 <bsp_printf+0xe4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    5488:	d74fc0ef          	jal	19fc <bsp_printf_c>
    548c:	fe5ff06f          	j	5470 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    5490:	00c12783          	lw	a5,12(sp)
    5494:	00478713          	addi	a4,a5,4
    5498:	00e12623          	sw	a4,12(sp)
    549c:	0007a503          	lw	a0,0(a5)
    54a0:	d78fc0ef          	jal	1a18 <bsp_printf_s>
                        break;
    54a4:	fcdff06f          	j	5470 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    54a8:	00c12783          	lw	a5,12(sp)
    54ac:	00478713          	addi	a4,a5,4
    54b0:	00e12623          	sw	a4,12(sp)
    54b4:	0007a503          	lw	a0,0(a5)
    54b8:	d78fc0ef          	jal	1a30 <bsp_printf_d>
                        break;
    54bc:	fb5ff06f          	j	5470 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    54c0:	00c12783          	lw	a5,12(sp)
    54c4:	00478713          	addi	a4,a5,4
    54c8:	00e12623          	sw	a4,12(sp)
    54cc:	0007a503          	lw	a0,0(a5)
    54d0:	e20fc0ef          	jal	1af0 <bsp_printf_X>
                        break;
    54d4:	f9dff06f          	j	5470 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    54d8:	00c12783          	lw	a5,12(sp)
    54dc:	00478713          	addi	a4,a5,4
    54e0:	00e12623          	sw	a4,12(sp)
    54e4:	0007a503          	lw	a0,0(a5)
    54e8:	dc8fc0ef          	jal	1ab0 <bsp_printf_x>
                        break;
    54ec:	f85ff06f          	j	5470 <bsp_printf+0x54>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
    54f0:	00007537          	lui	a0,0x7
    54f4:	3ac50513          	addi	a0,a0,940 # 73ac <_data+0x160>
    54f8:	d20fc0ef          	jal	1a18 <bsp_printf_s>
                        break;
    54fc:	f75ff06f          	j	5470 <bsp_printf+0x54>
                while (format[++i]) {
    5500:	00140413          	addi	s0,s0,1
    5504:	008487b3          	add	a5,s1,s0
    5508:	0007c783          	lbu	a5,0(a5)
    550c:	f60782e3          	beqz	a5,5470 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    5510:	fa878793          	addi	a5,a5,-88
    5514:	0ff7f693          	zext.b	a3,a5
    5518:	02000713          	li	a4,32
    551c:	fed762e3          	bltu	a4,a3,5500 <bsp_printf+0xe4>
    5520:	00269793          	slli	a5,a3,0x2
    5524:	00008737          	lui	a4,0x8
    5528:	6a470713          	addi	a4,a4,1700 # 86a4 <_data+0x1458>
    552c:	00e787b3          	add	a5,a5,a4
    5530:	0007a783          	lw	a5,0(a5)
    5534:	00078067          	jr	a5

        va_end(ap);
    }
    5538:	01c12083          	lw	ra,28(sp)
    553c:	01812403          	lw	s0,24(sp)
    5540:	01412483          	lw	s1,20(sp)
    5544:	04010113          	addi	sp,sp,64
    5548:	00008067          	ret

0000554c <feat_probe>:
{
    554c:	ff010113          	addi	sp,sp,-16
    5550:	00112623          	sw	ra,12(sp)
    5554:	00812423          	sw	s0,8(sp)
    blt_wr(BLT_CLIP_X0, 0x00000123UL); blt_wr(BLT_CLIP_X1, 0x00000456UL);
    5558:	12300593          	li	a1,291
    555c:	09000513          	li	a0,144
    5560:	f89fc0ef          	jal	24e8 <blt_wr>
    5564:	45600593          	li	a1,1110
    5568:	09400513          	li	a0,148
    556c:	f7dfc0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_CLIP_Y0, 0x00000789UL); blt_wr(BLT_CLIP_Y1, 0x00000AB0UL);
    5570:	78900593          	li	a1,1929
    5574:	09800513          	li	a0,152
    5578:	f71fc0ef          	jal	24e8 <blt_wr>
    557c:	000015b7          	lui	a1,0x1
    5580:	ab058593          	addi	a1,a1,-1360 # ab0 <CUSTOM2+0xa55>
    5584:	09c00513          	li	a0,156
    5588:	f61fc0ef          	jal	24e8 <blt_wr>
    g_feat_clip = (blt_rd(BLT_CLIP_X0) == 0x123UL) && (blt_rd(BLT_CLIP_X1) == 0x456UL) &&
    558c:	09000513          	li	a0,144
    5590:	f69fc0ef          	jal	24f8 <blt_rd>
                  (blt_rd(BLT_CLIP_Y0) == 0x789UL) && (blt_rd(BLT_CLIP_Y1) == 0xAB0UL);
    5594:	12300793          	li	a5,291
    5598:	06f50663          	beq	a0,a5,5604 <feat_probe+0xb8>
    559c:	00000713          	li	a4,0
    g_feat_clip = (blt_rd(BLT_CLIP_X0) == 0x123UL) && (blt_rd(BLT_CLIP_X1) == 0x456UL) &&
    55a0:	8ee1ac23          	sw	a4,-1800(gp) # 8d70 <g_feat_clip>
    blt_wr(BLT_CLIP_CTRL, 0UL);                 /* ★ 本 Demo 不用裁剪：必须显式关掉 */
    55a4:	00000593          	li	a1,0
    55a8:	0a000513          	li	a0,160
    55ac:	f3dfc0ef          	jal	24e8 <blt_wr>
    blt_wr(BLT_LUT_CTRL, 0UL);
    55b0:	00000593          	li	a1,0
    55b4:	0ac00513          	li	a0,172
    55b8:	f31fc0ef          	jal	24e8 <blt_wr>
    lc = blt_rd(BLT_LUT_CTRL) & 3UL;
    55bc:	0ac00513          	li	a0,172
    55c0:	f39fc0ef          	jal	24f8 <blt_rd>
    55c4:	00357413          	andi	s0,a0,3
    blt_wr(BLT_LUT_CTRL, BLT_LUT_EN | BLT_LUT_BANK);
    55c8:	00300593          	li	a1,3
    55cc:	0ac00513          	li	a0,172
    55d0:	f19fc0ef          	jal	24e8 <blt_wr>
    g_feat_lut = (lc == 0UL) && ((blt_rd(BLT_LUT_CTRL) & 3UL) == (BLT_LUT_EN | BLT_LUT_BANK));
    55d4:	08040263          	beqz	s0,5658 <feat_probe+0x10c>
    55d8:	00000713          	li	a4,0
    55dc:	8ee1aa23          	sw	a4,-1804(gp) # 8d6c <g_feat_lut>
    blt_wr(BLT_LUT_CTRL, 0UL);                  /* 关掉：没写表就不是恒等表，开了会黑屏 */
    55e0:	00000593          	li	a1,0
    55e4:	0ac00513          	li	a0,172
    55e8:	f01fc0ef          	jal	24e8 <blt_wr>
    g_glow = (g_feat_clip && g_feat_lut) ? 1 : 0;
    55ec:	8f81a583          	lw	a1,-1800(gp) # 8d70 <g_feat_clip>
    55f0:	08058663          	beqz	a1,567c <feat_probe+0x130>
    55f4:	8f41a783          	lw	a5,-1804(gp) # 8d6c <g_feat_lut>
    55f8:	0c079c63          	bnez	a5,56d0 <feat_probe+0x184>
    55fc:	00000693          	li	a3,0
    5600:	0800006f          	j	5680 <feat_probe+0x134>
    g_feat_clip = (blt_rd(BLT_CLIP_X0) == 0x123UL) && (blt_rd(BLT_CLIP_X1) == 0x456UL) &&
    5604:	09400513          	li	a0,148
    5608:	ef1fc0ef          	jal	24f8 <blt_rd>
    560c:	45600793          	li	a5,1110
    5610:	00f50663          	beq	a0,a5,561c <feat_probe+0xd0>
                  (blt_rd(BLT_CLIP_Y0) == 0x789UL) && (blt_rd(BLT_CLIP_Y1) == 0xAB0UL);
    5614:	00000713          	li	a4,0
    5618:	f89ff06f          	j	55a0 <feat_probe+0x54>
    561c:	09800513          	li	a0,152
    5620:	ed9fc0ef          	jal	24f8 <blt_rd>
    g_feat_clip = (blt_rd(BLT_CLIP_X0) == 0x123UL) && (blt_rd(BLT_CLIP_X1) == 0x456UL) &&
    5624:	78900793          	li	a5,1929
    5628:	00f50663          	beq	a0,a5,5634 <feat_probe+0xe8>
                  (blt_rd(BLT_CLIP_Y0) == 0x789UL) && (blt_rd(BLT_CLIP_Y1) == 0xAB0UL);
    562c:	00000713          	li	a4,0
    5630:	f71ff06f          	j	55a0 <feat_probe+0x54>
    5634:	09c00513          	li	a0,156
    5638:	ec1fc0ef          	jal	24f8 <blt_rd>
    563c:	000017b7          	lui	a5,0x1
    5640:	ab078793          	addi	a5,a5,-1360 # ab0 <CUSTOM2+0xa55>
    5644:	00f50663          	beq	a0,a5,5650 <feat_probe+0x104>
    5648:	00000713          	li	a4,0
    564c:	f55ff06f          	j	55a0 <feat_probe+0x54>
    5650:	00100713          	li	a4,1
    5654:	f4dff06f          	j	55a0 <feat_probe+0x54>
    g_feat_lut = (lc == 0UL) && ((blt_rd(BLT_LUT_CTRL) & 3UL) == (BLT_LUT_EN | BLT_LUT_BANK));
    5658:	0ac00513          	li	a0,172
    565c:	e9dfc0ef          	jal	24f8 <blt_rd>
    5660:	00357513          	andi	a0,a0,3
    5664:	00300793          	li	a5,3
    5668:	00f50663          	beq	a0,a5,5674 <feat_probe+0x128>
    566c:	00000713          	li	a4,0
    5670:	f6dff06f          	j	55dc <feat_probe+0x90>
    5674:	00100713          	li	a4,1
    5678:	f65ff06f          	j	55dc <feat_probe+0x90>
    g_glow = (g_feat_clip && g_feat_lut) ? 1 : 0;
    567c:	00000693          	li	a3,0
    5680:	8ed1ae23          	sw	a3,-1796(gp) # 8d74 <g_glow>
    g_attr_on = g_glow;                         /* ★ 属性字只在确认存在时才写（配对纪律） */
    5684:	8ed1a823          	sw	a3,-1808(gp) # 8d68 <g_attr_on>
    g_bulm = g_glow ? BULM_ADD : BULM_KEY;
    5688:	04068863          	beqz	a3,56d8 <feat_probe+0x18c>
    568c:	00200713          	li	a4,2
    5690:	82e1ac23          	sw	a4,-1992(gp) # 8cb0 <g_bulm>
    bsp_printf("feat: clip=%d lut=%d attr=%d (attr=>glow ADD, else KEY fallback)\r\n",
    5694:	8f41a603          	lw	a2,-1804(gp) # 8d6c <g_feat_lut>
    5698:	00007537          	lui	a0,0x7
    569c:	3f850513          	addi	a0,a0,1016 # 73f8 <_data+0x1ac>
    56a0:	d7dff0ef          	jal	541c <bsp_printf>
    bsp_printf("bulm: default=%s  (f cycles, 5=FILL 6=ALPHA 7=ADD 8=KEY)\r\n",
    56a4:	a45fc0ef          	jal	20e8 <bulm_eff_name>
    56a8:	00050593          	mv	a1,a0
    56ac:	00007537          	lui	a0,0x7
    56b0:	43c50513          	addi	a0,a0,1084 # 743c <_data+0x1f0>
    56b4:	d69ff0ef          	jal	541c <bsp_printf>
    if (!g_glow)
    56b8:	8fc1a783          	lw	a5,-1796(gp) # 8d74 <g_glow>
    56bc:	02078263          	beqz	a5,56e0 <feat_probe+0x194>
}
    56c0:	00c12083          	lw	ra,12(sp)
    56c4:	00812403          	lw	s0,8(sp)
    56c8:	01010113          	addi	sp,sp,16
    56cc:	00008067          	ret
    g_glow = (g_feat_clip && g_feat_lut) ? 1 : 0;
    56d0:	00100693          	li	a3,1
    56d4:	fadff06f          	j	5680 <feat_probe+0x134>
    g_bulm = g_glow ? BULM_ADD : BULM_KEY;
    56d8:	00300713          	li	a4,3
    56dc:	fb5ff06f          	j	5690 <feat_probe+0x144>
        bsp_printf("feat WARN: v3.2 attr side-port ABSENT -> bullets use Color Key (still correct)\r\n");
    56e0:	00007537          	lui	a0,0x7
    56e4:	47850513          	addi	a0,a0,1144 # 7478 <_data+0x22c>
    56e8:	d35ff0ef          	jal	541c <bsp_printf>
}
    56ec:	fd5ff06f          	j	56c0 <feat_probe+0x174>

000056f0 <bg_upload>:
{
    56f0:	ff010113          	addi	sp,sp,-16
    56f4:	00112623          	sw	ra,12(sp)
    spiFlash_init(SPI, SPI_CS);
    56f8:	00000593          	li	a1,0
    56fc:	f8014537          	lui	a0,0xf8014
    5700:	eacfc0ef          	jal	1dac <spiFlash_init>
    spiFlash_wake(SPI, SPI_CS);
    5704:	00000593          	li	a1,0
    5708:	f8014537          	lui	a0,0xf8014
    570c:	801fc0ef          	jal	1f0c <spiFlash_wake>
    spiFlash_exit4ByteAddr(SPI, SPI_CS);
    5710:	00000593          	li	a1,0
    5714:	f8014537          	lui	a0,0xf8014
    5718:	f68fc0ef          	jal	1e80 <spiFlash_exit4ByteAddr>
    spiFlash_f2m(SPI, SPI_CS, BG_FLASH_ADDR, BG_DDR, BG_BYTES);
    571c:	000c5737          	lui	a4,0xc5
    5720:	80070713          	addi	a4,a4,-2048 # c4800 <__freertos_irq_stack_top+0xa9cf0>
    5724:	00a016b7          	lui	a3,0xa01
    5728:	00100637          	lui	a2,0x100
    572c:	00000593          	li	a1,0
    5730:	f8014537          	lui	a0,0xf8014
    5734:	8ddfc0ef          	jal	2010 <spiFlash_f2m>
    bsp_printf("bg: flash %x -> ddr %x (%d bytes)\r\n",
    5738:	000c56b7          	lui	a3,0xc5
    573c:	80068693          	addi	a3,a3,-2048 # c4800 <__freertos_irq_stack_top+0xa9cf0>
    5740:	00a01637          	lui	a2,0xa01
    5744:	001005b7          	lui	a1,0x100
    5748:	00007537          	lui	a0,0x7
    574c:	4cc50513          	addi	a0,a0,1228 # 74cc <_data+0x280>
    5750:	ccdff0ef          	jal	541c <bsp_printf>
}
    5754:	00c12083          	lw	ra,12(sp)
    5758:	01010113          	addi	sp,sp,16
    575c:	00008067          	ret

00005760 <boot_selfcheck>:
{
    5760:	f8010113          	addi	sp,sp,-128
    5764:	06112e23          	sw	ra,124(sp)
    5768:	06812c23          	sw	s0,120(sp)
    576c:	06912a23          	sw	s1,116(sp)
    5770:	07212823          	sw	s2,112(sp)
    5774:	07312623          	sw	s3,108(sp)
    5778:	07412423          	sw	s4,104(sp)
    577c:	07512223          	sw	s5,100(sp)
    5780:	07612023          	sw	s6,96(sp)
        tv[0].blend = ATTR_BLEND_OP;    tv[0].fmt = ATTR_FMT_565;  tv[0].ga = 255u; tv[0].fl = 0u;
    5784:	00012e23          	sw	zero,28(sp)
    5788:	02012023          	sw	zero,32(sp)
    578c:	0ff00793          	li	a5,255
    5790:	02f12223          	sw	a5,36(sp)
    5794:	02012423          	sw	zero,40(sp)
        tv[1].blend = ATTR_BLEND_ALPHA; tv[1].fmt = ATTR_FMT_4444; tv[1].ga = 128u; tv[1].fl = 0u;
    5798:	00100793          	li	a5,1
    579c:	02f12623          	sw	a5,44(sp)
    57a0:	00200713          	li	a4,2
    57a4:	02e12823          	sw	a4,48(sp)
    57a8:	08000693          	li	a3,128
    57ac:	02d12a23          	sw	a3,52(sp)
    57b0:	02012c23          	sw	zero,56(sp)
        tv[2].blend = ATTR_BLEND_ADD;   tv[2].fmt = ATTR_FMT_565;  tv[2].ga = 96u;  tv[2].fl = 0u;
    57b4:	02e12e23          	sw	a4,60(sp)
    57b8:	04012023          	sw	zero,64(sp)
    57bc:	06000713          	li	a4,96
    57c0:	04e12223          	sw	a4,68(sp)
    57c4:	04012423          	sw	zero,72(sp)
        tv[3].blend = ATTR_BLEND_MUL;   tv[3].fmt = ATTR_FMT_1555; tv[3].ga = 64u;
    57c8:	00300713          	li	a4,3
    57cc:	04e12623          	sw	a4,76(sp)
    57d0:	04f12823          	sw	a5,80(sp)
    57d4:	04000713          	li	a4,64
    57d8:	04e12a23          	sw	a4,84(sp)
        tv[3].fl = ATTR_FLAG_ATEST;
    57dc:	04f12c23          	sw	a5,88(sp)
        int i, bad = 0;
    57e0:	00000993          	li	s3,0
        for (i = 0; i < 4; i++) {
    57e4:	00000413          	li	s0,0
    57e8:	00c0006f          	j	57f4 <boot_selfcheck+0x94>
                attr_ga(w) != tv[i].ga || attr_flags(w) != tv[i].fl) bad++;
    57ec:	00198993          	addi	s3,s3,1
        for (i = 0; i < 4; i++) {
    57f0:	00140413          	addi	s0,s0,1
    57f4:	00300793          	li	a5,3
    57f8:	0687c463          	blt	a5,s0,5860 <boot_selfcheck+0x100>
            uint32_t w = attr_word(tv[i].blend, tv[i].fmt, tv[i].ga, tv[i].fl);
    57fc:	00441793          	slli	a5,s0,0x4
    5800:	06078793          	addi	a5,a5,96
    5804:	002787b3          	add	a5,a5,sp
    5808:	fbc7a903          	lw	s2,-68(a5)
    580c:	fc07aa03          	lw	s4,-64(a5)
    5810:	fc47aa83          	lw	s5,-60(a5)
    5814:	fc87ab03          	lw	s6,-56(a5)
    5818:	000b0693          	mv	a3,s6
    581c:	000a8613          	mv	a2,s5
    5820:	000a0593          	mv	a1,s4
    5824:	00090513          	mv	a0,s2
    5828:	85dfc0ef          	jal	2084 <attr_word>
    582c:	00050493          	mv	s1,a0
            if (attr_blend(w) != tv[i].blend || attr_fmt(w) != tv[i].fmt ||
    5830:	88dfc0ef          	jal	20bc <attr_blend>
    5834:	faa91ce3          	bne	s2,a0,57ec <boot_selfcheck+0x8c>
    5838:	00048513          	mv	a0,s1
    583c:	889fc0ef          	jal	20c4 <attr_fmt>
    5840:	faaa16e3          	bne	s4,a0,57ec <boot_selfcheck+0x8c>
                attr_ga(w) != tv[i].ga || attr_flags(w) != tv[i].fl) bad++;
    5844:	00048513          	mv	a0,s1
    5848:	889fc0ef          	jal	20d0 <attr_ga>
            if (attr_blend(w) != tv[i].blend || attr_fmt(w) != tv[i].fmt ||
    584c:	faaa90e3          	bne	s5,a0,57ec <boot_selfcheck+0x8c>
                attr_ga(w) != tv[i].ga || attr_flags(w) != tv[i].fl) bad++;
    5850:	00048513          	mv	a0,s1
    5854:	889fc0ef          	jal	20dc <attr_flags>
    5858:	f8ab1ae3          	bne	s6,a0,57ec <boot_selfcheck+0x8c>
    585c:	f95ff06f          	j	57f0 <boot_selfcheck+0x90>
        d = attr_word(ATTR_BLEND_OP, ATTR_FMT_565, 255u, 0u);
    5860:	00000693          	li	a3,0
    5864:	0ff00613          	li	a2,255
    5868:	00000593          	li	a1,0
    586c:	00000513          	li	a0,0
    5870:	815fc0ef          	jal	2084 <attr_word>
    5874:	00050613          	mv	a2,a0
        bsp_printf("selfcheck attr: decode_err=%d default=%x match=%d\r\n",
    5878:	00100693          	li	a3,1
    587c:	00098593          	mv	a1,s3
    5880:	00007537          	lui	a0,0x7
    5884:	4f050513          	addi	a0,a0,1264 # 74f0 <_data+0x2a4>
    5888:	b95ff0ef          	jal	541c <bsp_printf>
               (unsigned)blend565(0xF800u, 0x001Fu, 128u),
    588c:	08000613          	li	a2,128
    5890:	01f00593          	li	a1,31
    5894:	00010537          	lui	a0,0x10
    5898:	80050513          	addi	a0,a0,-2048 # f800 <__global_pointer$+0x6388>
    589c:	da4fe0ef          	jal	3e40 <blend565>
    58a0:	00050413          	mv	s0,a0
               (unsigned)add565(0xF800u, 0x001Fu, 255u),
    58a4:	0ff00613          	li	a2,255
    58a8:	01f00593          	li	a1,31
    58ac:	00010537          	lui	a0,0x10
    58b0:	80050513          	addi	a0,a0,-2048 # f800 <__global_pointer$+0x6388>
    58b4:	e94fe0ef          	jal	3f48 <add565>
    58b8:	00050493          	mv	s1,a0
               (unsigned)add565(0x0000u, 0x1234u, 255u));
    58bc:	0ff00613          	li	a2,255
    58c0:	000015b7          	lui	a1,0x1
    58c4:	23458593          	addi	a1,a1,564 # 1234 <main+0x130>
    58c8:	00000513          	li	a0,0
    58cc:	e7cfe0ef          	jal	3f48 <add565>
    58d0:	00050693          	mv	a3,a0
    bsp_printf("selfcheck mix: blend=%x (exp 780F) add=%x (exp F81F) addblack=%x (exp 1234)\r\n",
    58d4:	00048613          	mv	a2,s1
    58d8:	00040593          	mv	a1,s0
    58dc:	00007537          	lui	a0,0x7
    58e0:	52450513          	addi	a0,a0,1316 # 7524 <_data+0x2d8>
    58e4:	b39ff0ef          	jal	541c <bsp_printf>
        int id, bad = 0;
    58e8:	00000913          	li	s2,0
        for (id = 0; id < S_N; id++) {
    58ec:	00000413          	li	s0,0
    58f0:	0080006f          	j	58f8 <boot_selfcheck+0x198>
    58f4:	00140413          	addi	s0,s0,1
    58f8:	00700793          	li	a5,7
    58fc:	0487ce63          	blt	a5,s0,5958 <boot_selfcheck+0x1f8>
            int w = (int)g_spr_sz[id];
    5900:	84018793          	addi	a5,gp,-1984 # 8cb8 <g_spr_sz>
    5904:	008787b3          	add	a5,a5,s0
    5908:	0007c483          	lbu	s1,0(a5)
            if (spr_pixel(id, 0, 0) != TRANS_KEY) bad++;                 /* 左上角（圆/三角外） */
    590c:	00000613          	li	a2,0
    5910:	00000593          	li	a1,0
    5914:	00040513          	mv	a0,s0
    5918:	a55fc0ef          	jal	236c <spr_pixel>
    591c:	00050463          	beqz	a0,5924 <boot_selfcheck+0x1c4>
    5920:	00190913          	addi	s2,s2,1
            if (spr_pixel(id, w - 1, 0) != TRANS_KEY) bad++;             /* 右上角 */
    5924:	00000613          	li	a2,0
    5928:	fff48593          	addi	a1,s1,-1
    592c:	00040513          	mv	a0,s0
    5930:	a3dfc0ef          	jal	236c <spr_pixel>
    5934:	00050463          	beqz	a0,593c <boot_selfcheck+0x1dc>
    5938:	00190913          	addi	s2,s2,1
            if (spr_pixel(id, w / 2, w / 2) == TRANS_KEY) bad++;         /* 中心必须实心 */
    593c:	0014d593          	srli	a1,s1,0x1
    5940:	00058613          	mv	a2,a1
    5944:	00040513          	mv	a0,s0
    5948:	a25fc0ef          	jal	236c <spr_pixel>
    594c:	fa0514e3          	bnez	a0,58f4 <boot_selfcheck+0x194>
    5950:	00190913          	addi	s2,s2,1
    5954:	fa1ff06f          	j	58f4 <boot_selfcheck+0x194>
        bsp_printf("selfcheck atlas: corner_err=%d bytes=%d\r\n", bad, (int)ATLAS_BYTES);
    5958:	00002637          	lui	a2,0x2
    595c:	c0060613          	addi	a2,a2,-1024 # 1c00 <spi_read+0x3c>
    5960:	00090593          	mv	a1,s2
    5964:	00007537          	lui	a0,0x7
    5968:	57450513          	addi	a0,a0,1396 # 7574 <_data+0x328>
    596c:	ab1ff0ef          	jal	541c <bsp_printf>
        fmt_stat(worst, 999u, 999u, N_MAX, 9999, SCORE_CAP, 99, 9, "ALPHA", 1, 1);
    5970:	00100793          	li	a5,1
    5974:	00f12423          	sw	a5,8(sp)
    5978:	00f12223          	sw	a5,4(sp)
    597c:	000077b7          	lui	a5,0x7
    5980:	5a078793          	addi	a5,a5,1440 # 75a0 <_data+0x354>
    5984:	00f12023          	sw	a5,0(sp)
    5988:	00900893          	li	a7,9
    598c:	06300813          	li	a6,99
    5990:	000f47b7          	lui	a5,0xf4
    5994:	23f78793          	addi	a5,a5,575 # f423f <__freertos_irq_stack_top+0xd972f>
    5998:	00002737          	lui	a4,0x2
    599c:	70f70713          	addi	a4,a4,1807 # 270f <e_fill+0x7>
    59a0:	000016b7          	lui	a3,0x1
    59a4:	96068693          	addi	a3,a3,-1696 # 960 <CUSTOM2+0x905>
    59a8:	3e700613          	li	a2,999
    59ac:	3e700593          	li	a1,999
    59b0:	01c10513          	addi	a0,sp,28
    59b4:	a85fe0ef          	jal	4438 <fmt_stat>
        int i, miss = 0;
    59b8:	00000493          	li	s1,0
        for (i = 0; worst[i]; i++) if (!glyph_found(worst[i])) miss++;
    59bc:	00000413          	li	s0,0
    59c0:	0080006f          	j	59c8 <boot_selfcheck+0x268>
    59c4:	00140413          	addi	s0,s0,1
    59c8:	06040793          	addi	a5,s0,96
    59cc:	002787b3          	add	a5,a5,sp
    59d0:	fbc7c503          	lbu	a0,-68(a5)
    59d4:	00050a63          	beqz	a0,59e8 <boot_selfcheck+0x288>
    59d8:	a35fc0ef          	jal	240c <glyph_found>
    59dc:	fe0514e3          	bnez	a0,59c4 <boot_selfcheck+0x264>
    59e0:	00148493          	addi	s1,s1,1
    59e4:	fe1ff06f          	j	59c4 <boot_selfcheck+0x264>
        for (i = 0; path_label()[i]; i++) if (!glyph_found(path_label()[i])) miss++;
    59e8:	00000413          	li	s0,0
    59ec:	0080006f          	j	59f4 <boot_selfcheck+0x294>
    59f0:	00140413          	addi	s0,s0,1
    59f4:	d99fe0ef          	jal	478c <path_label>
    59f8:	00850533          	add	a0,a0,s0
    59fc:	00054503          	lbu	a0,0(a0)
    5a00:	00050a63          	beqz	a0,5a14 <boot_selfcheck+0x2b4>
    5a04:	a09fc0ef          	jal	240c <glyph_found>
    5a08:	fe0514e3          	bnez	a0,59f0 <boot_selfcheck+0x290>
    5a0c:	00148493          	addi	s1,s1,1
    5a10:	fe1ff06f          	j	59f0 <boot_selfcheck+0x290>
        bsp_printf("selfcheck osd: len=%d px=%d limit=%d gap=%d missing_glyph=%d\r\n",
    5a14:	01c10513          	addi	a0,sp,28
    5a18:	a01fe0ef          	jal	4418 <slen>
    5a1c:	00050593          	mv	a1,a0
                   (FB_WIDTH - OSD_RIGHT_PX) - slen(worst) * OSD_GLYPH_W, miss);
    5a20:	07000713          	li	a4,112
    5a24:	40a70733          	sub	a4,a4,a0
        bsp_printf("selfcheck osd: len=%d px=%d limit=%d gap=%d missing_glyph=%d\r\n",
    5a28:	00048793          	mv	a5,s1
    5a2c:	00371713          	slli	a4,a4,0x3
    5a30:	20000693          	li	a3,512
    5a34:	00351613          	slli	a2,a0,0x3
    5a38:	00007537          	lui	a0,0x7
    5a3c:	5a850513          	addi	a0,a0,1448 # 75a8 <_data+0x35c>
    5a40:	9ddff0ef          	jal	541c <bsp_printf>
        int i, miss = 0;
    5a44:	00000913          	li	s2,0
        for (i = 0; i < BULM_N; i++)
    5a48:	00000493          	li	s1,0
    5a4c:	03c0006f          	j	5a88 <boot_selfcheck+0x328>
            { int k; for (k = 0; g_bulm_name[i][k]; k++) if (!glyph_found(g_bulm_name[i][k])) miss++; }
    5a50:	00140413          	addi	s0,s0,1
    5a54:	000097b7          	lui	a5,0x9
    5a58:	00249713          	slli	a4,s1,0x2
    5a5c:	b5478793          	addi	a5,a5,-1196 # 8b54 <g_bulm_name>
    5a60:	00e787b3          	add	a5,a5,a4
    5a64:	0007a783          	lw	a5,0(a5)
    5a68:	008787b3          	add	a5,a5,s0
    5a6c:	0007c503          	lbu	a0,0(a5)
    5a70:	00050a63          	beqz	a0,5a84 <boot_selfcheck+0x324>
    5a74:	999fc0ef          	jal	240c <glyph_found>
    5a78:	fc051ce3          	bnez	a0,5a50 <boot_selfcheck+0x2f0>
    5a7c:	00190913          	addi	s2,s2,1
    5a80:	fd1ff06f          	j	5a50 <boot_selfcheck+0x2f0>
        for (i = 0; i < BULM_N; i++)
    5a84:	00148493          	addi	s1,s1,1
    5a88:	00300793          	li	a5,3
    5a8c:	0097c663          	blt	a5,s1,5a98 <boot_selfcheck+0x338>
            { int k; for (k = 0; g_bulm_name[i][k]; k++) if (!glyph_found(g_bulm_name[i][k])) miss++; }
    5a90:	00000413          	li	s0,0
    5a94:	fc1ff06f          	j	5a54 <boot_selfcheck+0x2f4>
        bsp_printf("selfcheck bulm: cur=%s eff=%s names_glyph_missing=%d (keys f cycle, 5=FILL 6=ALPHA 7=ADD 8=KEY)\r\n",
    5a98:	000097b7          	lui	a5,0x9
    5a9c:	8381a703          	lw	a4,-1992(gp) # 8cb0 <g_bulm>
    5aa0:	00271713          	slli	a4,a4,0x2
    5aa4:	b5478793          	addi	a5,a5,-1196 # 8b54 <g_bulm_name>
    5aa8:	00e787b3          	add	a5,a5,a4
    5aac:	0007a403          	lw	s0,0(a5)
    5ab0:	e38fc0ef          	jal	20e8 <bulm_eff_name>
    5ab4:	00050613          	mv	a2,a0
    5ab8:	00090693          	mv	a3,s2
    5abc:	00040593          	mv	a1,s0
    5ac0:	00007537          	lui	a0,0x7
    5ac4:	5e850513          	addi	a0,a0,1512 # 75e8 <_data+0x39c>
    5ac8:	955ff0ef          	jal	541c <bsp_printf>
               (int)cost_capacity(DRAW_FILL,  SZ_B, 70, 0),
    5acc:	00000693          	li	a3,0
    5ad0:	04600613          	li	a2,70
    5ad4:	01000593          	li	a1,16
    5ad8:	00100513          	li	a0,1
    5adc:	a41fd0ef          	jal	351c <cost_capacity>
    5ae0:	00050413          	mv	s0,a0
               (int)cost_capacity(DRAW_ALPHA, SZ_B, 70, 0),
    5ae4:	00000693          	li	a3,0
    5ae8:	04600613          	li	a2,70
    5aec:	01000593          	li	a1,16
    5af0:	00400513          	li	a0,4
    5af4:	a29fd0ef          	jal	351c <cost_capacity>
    5af8:	00050493          	mv	s1,a0
               (int)cost_capacity(DRAW_KEY,   SZ_B, 70, 0));
    5afc:	00000693          	li	a3,0
    5b00:	04600613          	li	a2,70
    5b04:	01000593          	li	a1,16
    5b08:	00200513          	li	a0,2
    5b0c:	a11fd0ef          	jal	351c <cost_capacity>
    5b10:	00050693          	mv	a3,a0
    bsp_printf("cap model 16x16 70pct budget: FILL=%d ALPHA=%d KEY=%d (single-lane board cal)\r\n",
    5b14:	00048613          	mv	a2,s1
    5b18:	00040593          	mv	a1,s0
    5b1c:	00007537          	lui	a0,0x7
    5b20:	64c50513          	addi	a0,a0,1612 # 764c <_data+0x400>
    5b24:	8f9ff0ef          	jal	541c <bsp_printf>
               (int)cost_capacity(DRAW_FILL,  SZ_B, 70, 1),
    5b28:	00100693          	li	a3,1
    5b2c:	04600613          	li	a2,70
    5b30:	01000593          	li	a1,16
    5b34:	00100513          	li	a0,1
    5b38:	9e5fd0ef          	jal	351c <cost_capacity>
    5b3c:	00050413          	mv	s0,a0
               (int)cost_capacity(DRAW_ALPHA, SZ_B, 70, 1),
    5b40:	00100693          	li	a3,1
    5b44:	04600613          	li	a2,70
    5b48:	01000593          	li	a1,16
    5b4c:	00400513          	li	a0,4
    5b50:	9cdfd0ef          	jal	351c <cost_capacity>
    5b54:	00050493          	mv	s1,a0
               (int)cost_capacity(DRAW_KEY,   SZ_B, 70, 1));
    5b58:	00100693          	li	a3,1
    5b5c:	04600613          	li	a2,70
    5b60:	01000593          	li	a1,16
    5b64:	00200513          	li	a0,2
    5b68:	9b5fd0ef          	jal	351c <cost_capacity>
    5b6c:	00050693          	mv	a3,a0
    bsp_printf("cap model 16x16 70pct budget: ... dual-lane estimate FILL=%d ALPHA=%d KEY=%d\r\n",
    5b70:	00048613          	mv	a2,s1
    5b74:	00040593          	mv	a1,s0
    5b78:	00007537          	lui	a0,0x7
    5b7c:	69c50513          	addi	a0,a0,1692 # 769c <_data+0x450>
    5b80:	89dff0ef          	jal	541c <bsp_printf>
}
    5b84:	07c12083          	lw	ra,124(sp)
    5b88:	07812403          	lw	s0,120(sp)
    5b8c:	07412483          	lw	s1,116(sp)
    5b90:	07012903          	lw	s2,112(sp)
    5b94:	06c12983          	lw	s3,108(sp)
    5b98:	06812a03          	lw	s4,104(sp)
    5b9c:	06412a83          	lw	s5,100(sp)
    5ba0:	06012b03          	lw	s6,96(sp)
    5ba4:	08010113          	addi	sp,sp,128
    5ba8:	00008067          	ret

00005bac <serial_apply_key>:
{
    5bac:	ff010113          	addi	sp,sp,-16
    5bb0:	00112623          	sw	ra,12(sp)
    5bb4:	00812423          	sw	s0,8(sp)
    5bb8:	00912223          	sw	s1,4(sp)
    5bbc:	00050413          	mv	s0,a0
    unsigned old = g_keymask;
    5bc0:	8881a483          	lw	s1,-1912(gp) # 8d00 <g_keymask>
    g_keymask = mask;
    5bc4:	88a1a423          	sw	a0,-1912(gp) # 8d00 <g_keymask>
    g_key_t = tick32();
    5bc8:	905fc0ef          	jal	24cc <tick32>
    5bcc:	88a1a023          	sw	a0,-1920(gp) # 8cf8 <g_key_t>
    g_keys_live = 1;
    5bd0:	00100713          	li	a4,1
    5bd4:	86e1ae23          	sw	a4,-1924(gp) # 8cf4 <g_keys_live>
    if ((mask & KEY_PAUSE) && !(old & KEY_PAUSE) && g_state == GS_PLAY) {
    5bd8:	08047793          	andi	a5,s0,128
    5bdc:	00078c63          	beqz	a5,5bf4 <serial_apply_key+0x48>
    5be0:	0804f793          	andi	a5,s1,128
    5be4:	00079863          	bnez	a5,5bf4 <serial_apply_key+0x48>
    5be8:	8a81a703          	lw	a4,-1880(gp) # 8d20 <g_state>
    5bec:	00100793          	li	a5,1
    5bf0:	02f70863          	beq	a4,a5,5c20 <serial_apply_key+0x74>
    if ((mask & KEY_BOMB) && !(old & KEY_BOMB)) g_bomb_req = 1;   /* 上升沿 */
    5bf4:	04047413          	andi	s0,s0,64
    5bf8:	00040a63          	beqz	s0,5c0c <serial_apply_key+0x60>
    5bfc:	0404f793          	andi	a5,s1,64
    5c00:	00079663          	bnez	a5,5c0c <serial_apply_key+0x60>
    5c04:	00100713          	li	a4,1
    5c08:	88e1a223          	sw	a4,-1916(gp) # 8cfc <g_bomb_req>
}
    5c0c:	00c12083          	lw	ra,12(sp)
    5c10:	00812403          	lw	s0,8(sp)
    5c14:	00412483          	lw	s1,4(sp)
    5c18:	01010113          	addi	sp,sp,16
    5c1c:	00008067          	ret
        g_pause = !g_pause;
    5c20:	8a41a583          	lw	a1,-1884(gp) # 8d1c <g_pause>
    5c24:	0015b593          	seqz	a1,a1
    5c28:	8ab1a223          	sw	a1,-1884(gp) # 8d1c <g_pause>
        bsp_printf("\r\nEV pause=%d\r\n", g_pause);
    5c2c:	00007537          	lui	a0,0x7
    5c30:	6ec50513          	addi	a0,a0,1772 # 76ec <_data+0x4a0>
    5c34:	fe8ff0ef          	jal	541c <bsp_printf>
    5c38:	fbdff06f          	j	5bf4 <serial_apply_key+0x48>

00005c3c <serial_cmd>:
    switch (c) {
    5c3c:	fd550793          	addi	a5,a0,-43
    5c40:	04700713          	li	a4,71
    5c44:	4ef76663          	bltu	a4,a5,6130 <serial_cmd+0x4f4>
{
    5c48:	fd010113          	addi	sp,sp,-48
    5c4c:	02112623          	sw	ra,44(sp)
    switch (c) {
    5c50:	00279793          	slli	a5,a5,0x2
    5c54:	00008737          	lui	a4,0x8
    5c58:	72870713          	addi	a4,a4,1832 # 8728 <_data+0x14dc>
    5c5c:	00e787b3          	add	a5,a5,a4
    5c60:	0007a783          	lw	a5,0(a5)
    5c64:	00078067          	jr	a5
    case '1': g_ncap = 256;  g_auto = 0; bsp_printf("\r\nEV N=%d (preset low)\r\n", g_ncap); break;
    5c68:	10000713          	li	a4,256
    5c6c:	80e1ae23          	sw	a4,-2020(gp) # 8c94 <g_ncap>
    5c70:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
    5c74:	10000593          	li	a1,256
    5c78:	00007537          	lui	a0,0x7
    5c7c:	6fc50513          	addi	a0,a0,1788 # 76fc <_data+0x4b0>
    5c80:	f9cff0ef          	jal	541c <bsp_printf>
}
    5c84:	02c12083          	lw	ra,44(sp)
    5c88:	03010113          	addi	sp,sp,48
    5c8c:	00008067          	ret
    case '2': g_ncap = 640;  g_auto = 0; bsp_printf("\r\nEV N=%d (preset mid)\r\n", g_ncap); break;
    5c90:	28000713          	li	a4,640
    5c94:	80e1ae23          	sw	a4,-2020(gp) # 8c94 <g_ncap>
    5c98:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
    5c9c:	28000593          	li	a1,640
    5ca0:	00007537          	lui	a0,0x7
    5ca4:	71850513          	addi	a0,a0,1816 # 7718 <_data+0x4cc>
    5ca8:	f74ff0ef          	jal	541c <bsp_printf>
    5cac:	fd9ff06f          	j	5c84 <serial_cmd+0x48>
    case '3': g_ncap = 1280; g_auto = 0; bsp_printf("\r\nEV N=%d (preset high)\r\n", g_ncap); break;
    5cb0:	50000713          	li	a4,1280
    5cb4:	80e1ae23          	sw	a4,-2020(gp) # 8c94 <g_ncap>
    5cb8:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
    5cbc:	50000593          	li	a1,1280
    5cc0:	00007537          	lui	a0,0x7
    5cc4:	73450513          	addi	a0,a0,1844 # 7734 <_data+0x4e8>
    5cc8:	f54ff0ef          	jal	541c <bsp_printf>
    5ccc:	fb9ff06f          	j	5c84 <serial_cmd+0x48>
    case '4': g_ncap = 2400; g_auto = 0; bsp_printf("\r\nEV N=%d (preset max)\r\n", g_ncap); break;
    5cd0:	000015b7          	lui	a1,0x1
    5cd4:	96058593          	addi	a1,a1,-1696 # 960 <CUSTOM2+0x905>
    5cd8:	80b1ae23          	sw	a1,-2020(gp) # 8c94 <g_ncap>
    5cdc:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
    5ce0:	00007537          	lui	a0,0x7
    5ce4:	75050513          	addi	a0,a0,1872 # 7750 <_data+0x504>
    5ce8:	f34ff0ef          	jal	541c <bsp_printf>
    5cec:	f99ff06f          	j	5c84 <serial_cmd+0x48>
        g_ncap += N_STEP; if (g_ncap > N_MAX) g_ncap = N_MIN; g_auto = 0;
    5cf0:	81c1a783          	lw	a5,-2020(gp) # 8c94 <g_ncap>
    5cf4:	04078793          	addi	a5,a5,64
    5cf8:	80f1ae23          	sw	a5,-2020(gp) # 8c94 <g_ncap>
    5cfc:	00001737          	lui	a4,0x1
    5d00:	96070713          	addi	a4,a4,-1696 # 960 <CUSTOM2+0x905>
    5d04:	00f75663          	bge	a4,a5,5d10 <serial_cmd+0xd4>
    5d08:	04000713          	li	a4,64
    5d0c:	80e1ae23          	sw	a4,-2020(gp) # 8c94 <g_ncap>
    5d10:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
        bsp_printf("\r\nEV N=%d\r\n", g_ncap); break;
    5d14:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    5d18:	00007537          	lui	a0,0x7
    5d1c:	76c50513          	addi	a0,a0,1900 # 776c <_data+0x520>
    5d20:	efcff0ef          	jal	541c <bsp_printf>
    5d24:	f61ff06f          	j	5c84 <serial_cmd+0x48>
        g_ncap -= N_STEP; if (g_ncap < N_MIN) g_ncap = N_MAX; g_auto = 0;
    5d28:	81c1a783          	lw	a5,-2020(gp) # 8c94 <g_ncap>
    5d2c:	fc078793          	addi	a5,a5,-64
    5d30:	80f1ae23          	sw	a5,-2020(gp) # 8c94 <g_ncap>
    5d34:	03f00713          	li	a4,63
    5d38:	00f74863          	blt	a4,a5,5d48 <serial_cmd+0x10c>
    5d3c:	000017b7          	lui	a5,0x1
    5d40:	96078793          	addi	a5,a5,-1696 # 960 <CUSTOM2+0x905>
    5d44:	80f1ae23          	sw	a5,-2020(gp) # 8c94 <g_ncap>
    5d48:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
        bsp_printf("\r\nEV N=%d\r\n", g_ncap); break;
    5d4c:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    5d50:	00007537          	lui	a0,0x7
    5d54:	76c50513          	addi	a0,a0,1900 # 776c <_data+0x520>
    5d58:	ec4ff0ef          	jal	541c <bsp_printf>
    5d5c:	f29ff06f          	j	5c84 <serial_cmd+0x48>
        g_mode = MD_SW; g_sw_fps = 0; g_sw_frames = 0;
    5d60:	00100713          	li	a4,1
    5d64:	82e1a023          	sw	a4,-2016(gp) # 8c98 <g_mode>
    5d68:	8601a823          	sw	zero,-1936(gp) # 8ce8 <g_sw_fps>
    5d6c:	8601a223          	sw	zero,-1948(gp) # 8cdc <g_sw_frames>
        g_t_fps = tick32();     /* ★ 1Hz 窗口从头开始：否则切换那一秒会读到一个"半个窗口"的假帧率 */
    5d70:	f5cfc0ef          	jal	24cc <tick32>
    5d74:	86a1a023          	sw	a0,-1952(gp) # 8cd8 <g_t_fps>
        bsp_printf("\r\nEV path=SW pure CPU (same scene, honest per-pixel blit)\r\n"); break;
    5d78:	00007537          	lui	a0,0x7
    5d7c:	77850513          	addi	a0,a0,1912 # 7778 <_data+0x52c>
    5d80:	e9cff0ef          	jal	541c <bsp_printf>
    5d84:	f01ff06f          	j	5c84 <serial_cmd+0x48>
        g_mode = MD_HW; g_hw_fps = 0; g_hw_frames = 0;
    5d88:	00200713          	li	a4,2
    5d8c:	82e1a023          	sw	a4,-2016(gp) # 8c98 <g_mode>
    5d90:	8601aa23          	sw	zero,-1932(gp) # 8cec <g_hw_fps>
    5d94:	8601a423          	sw	zero,-1944(gp) # 8ce0 <g_hw_frames>
        g_t_fps = tick32();
    5d98:	f34fc0ef          	jal	24cc <tick32>
    5d9c:	86a1a023          	sw	a0,-1952(gp) # 8cd8 <g_t_fps>
        bsp_printf("\r\nEV path=HW accel\r\n"); break;
    5da0:	00007537          	lui	a0,0x7
    5da4:	7b450513          	addi	a0,a0,1972 # 77b4 <_data+0x568>
    5da8:	e74ff0ef          	jal	541c <bsp_printf>
    5dac:	ed9ff06f          	j	5c84 <serial_cmd+0x48>
        g_auto = !g_auto;
    5db0:	8a01a583          	lw	a1,-1888(gp) # 8d18 <g_auto>
    5db4:	0015b593          	seqz	a1,a1
    5db8:	8ab1a023          	sw	a1,-1888(gp) # 8d18 <g_auto>
        bsp_printf("\r\nEV auto=%d (ramp N while fps>=58; LIMIT line on stop)\r\n", g_auto);
    5dbc:	00007537          	lui	a0,0x7
    5dc0:	7cc50513          	addi	a0,a0,1996 # 77cc <_data+0x580>
    5dc4:	e58ff0ef          	jal	541c <bsp_printf>
        break;
    5dc8:	ebdff06f          	j	5c84 <serial_cmd+0x48>
        g_star_n = g_star_n ? 0 : STAR_MAX;
    5dcc:	8241a783          	lw	a5,-2012(gp) # 8c9c <g_star_n>
    5dd0:	00078e63          	beqz	a5,5dec <serial_cmd+0x1b0>
    5dd4:	00000593          	li	a1,0
    5dd8:	82b1a223          	sw	a1,-2012(gp) # 8c9c <g_star_n>
        bsp_printf("\r\nEV stars=%d\r\n", g_star_n); break;
    5ddc:	00008537          	lui	a0,0x8
    5de0:	80850513          	addi	a0,a0,-2040 # 7808 <_data+0x5bc>
    5de4:	e38ff0ef          	jal	541c <bsp_printf>
    5de8:	e9dff06f          	j	5c84 <serial_cmd+0x48>
        g_star_n = g_star_n ? 0 : STAR_MAX;
    5dec:	08000593          	li	a1,128
    5df0:	fe9ff06f          	j	5dd8 <serial_cmd+0x19c>
    5df4:	02812423          	sw	s0,40(sp)
    5df8:	02912223          	sw	s1,36(sp)
                 : (c - '5');
    5dfc:	06600793          	li	a5,102
    5e00:	00f50a63          	beq	a0,a5,5e14 <serial_cmd+0x1d8>
        int next = (c == 'f' || c == 'F') ? ((g_bulm + 1) % BULM_N)
    5e04:	04600793          	li	a5,70
    5e08:	00f50663          	beq	a0,a5,5e14 <serial_cmd+0x1d8>
                 : (c - '5');
    5e0c:	fcb50513          	addi	a0,a0,-53
    5e10:	0200006f          	j	5e30 <serial_cmd+0x1f4>
        int next = (c == 'f' || c == 'F') ? ((g_bulm + 1) % BULM_N)
    5e14:	8381a783          	lw	a5,-1992(gp) # 8cb0 <g_bulm>
    5e18:	00178793          	addi	a5,a5,1
                 : (c - '5');
    5e1c:	41f7d713          	srai	a4,a5,0x1f
    5e20:	01e75713          	srli	a4,a4,0x1e
    5e24:	00e78533          	add	a0,a5,a4
    5e28:	00357513          	andi	a0,a0,3
    5e2c:	40e50533          	sub	a0,a0,a4
        g_bulm = next;
    5e30:	82a1ac23          	sw	a0,-1992(gp) # 8cb0 <g_bulm>
        bsp_printf("\r\nEV bulm=%s (requested; effective=%s)\r\n",
    5e34:	000097b7          	lui	a5,0x9
    5e38:	00251513          	slli	a0,a0,0x2
    5e3c:	b5478793          	addi	a5,a5,-1196 # 8b54 <g_bulm_name>
    5e40:	00a787b3          	add	a5,a5,a0
    5e44:	0007a483          	lw	s1,0(a5)
    5e48:	aa0fc0ef          	jal	20e8 <bulm_eff_name>
    5e4c:	00050613          	mv	a2,a0
    5e50:	00048593          	mv	a1,s1
    5e54:	00008537          	lui	a0,0x8
    5e58:	81850513          	addi	a0,a0,-2024 # 7818 <_data+0x5cc>
    5e5c:	dc0ff0ef          	jal	541c <bsp_printf>
        if (g_bulm == BULM_ALPHA)
    5e60:	8381a703          	lw	a4,-1992(gp) # 8cb0 <g_bulm>
    5e64:	00100793          	li	a5,1
    5e68:	02f70263          	beq	a4,a5,5e8c <serial_cmd+0x250>
        if (g_bulm == BULM_ADD && !g_glow)
    5e6c:	8381a703          	lw	a4,-1992(gp) # 8cb0 <g_bulm>
    5e70:	00200793          	li	a5,2
    5e74:	02f70663          	beq	a4,a5,5ea0 <serial_cmd+0x264>
        if (g_bulm == BULM_FILL)
    5e78:	8381a783          	lw	a5,-1992(gp) # 8cb0 <g_bulm>
    5e7c:	02078e63          	beqz	a5,5eb8 <serial_cmd+0x27c>
    5e80:	02812403          	lw	s0,40(sp)
    5e84:	02412483          	lw	s1,36(sp)
    5e88:	dfdff06f          	j	5c84 <serial_cmd+0x48>
            bsp_printf("     ALPHA: rect sprite + alpha %d -> corners darken the bg (that is why KEY exists)\r\n",
    5e8c:	0a000593          	li	a1,160
    5e90:	00008537          	lui	a0,0x8
    5e94:	84450513          	addi	a0,a0,-1980 # 7844 <_data+0x5f8>
    5e98:	d84ff0ef          	jal	541c <bsp_printf>
    5e9c:	fd1ff06f          	j	5e6c <serial_cmd+0x230>
        if (g_bulm == BULM_ADD && !g_glow)
    5ea0:	8fc1a783          	lw	a5,-1796(gp) # 8d74 <g_glow>
    5ea4:	fc079ae3          	bnez	a5,5e78 <serial_cmd+0x23c>
            bsp_printf("     WARN: attr side-port absent -> ADD falls back to Color Key\r\n");
    5ea8:	00008537          	lui	a0,0x8
    5eac:	89c50513          	addi	a0,a0,-1892 # 789c <_data+0x650>
    5eb0:	d6cff0ef          	jal	541c <bsp_printf>
    5eb4:	fc5ff06f          	j	5e78 <serial_cmd+0x23c>
            bsp_printf("     FILL: solid %dx%d squares, no src/key/alpha -> cheapest op\r\n",
    5eb8:	01000613          	li	a2,16
    5ebc:	01000593          	li	a1,16
    5ec0:	00008537          	lui	a0,0x8
    5ec4:	8e050513          	addi	a0,a0,-1824 # 78e0 <_data+0x694>
    5ec8:	d54ff0ef          	jal	541c <bsp_printf>
    5ecc:	02812403          	lw	s0,40(sp)
    5ed0:	02412483          	lw	s1,36(sp)
    5ed4:	db1ff06f          	j	5c84 <serial_cmd+0x48>
        if (g_state == GS_PLAY) { g_pause = !g_pause; bsp_printf("\r\nEV pause=%d\r\n", g_pause); }
    5ed8:	8a81a703          	lw	a4,-1880(gp) # 8d20 <g_state>
    5edc:	00100793          	li	a5,1
    5ee0:	daf712e3          	bne	a4,a5,5c84 <serial_cmd+0x48>
    5ee4:	8a41a583          	lw	a1,-1884(gp) # 8d1c <g_pause>
    5ee8:	0015b593          	seqz	a1,a1
    5eec:	8ab1a223          	sw	a1,-1884(gp) # 8d1c <g_pause>
    5ef0:	00007537          	lui	a0,0x7
    5ef4:	6ec50513          	addi	a0,a0,1772 # 76ec <_data+0x4a0>
    5ef8:	d24ff0ef          	jal	541c <bsp_printf>
    5efc:	d89ff06f          	j	5c84 <serial_cmd+0x48>
        g_seed += 0x9E3779B9u; game_reset();
    5f00:	8281a783          	lw	a5,-2008(gp) # 8ca0 <g_seed>
    5f04:	9e378737          	lui	a4,0x9e378
    5f08:	9b970713          	addi	a4,a4,-1607 # 9e3779b9 <__freertos_irq_stack_top+0x9e35cea9>
    5f0c:	00e787b3          	add	a5,a5,a4
    5f10:	82f1a423          	sw	a5,-2008(gp) # 8ca0 <g_seed>
    5f14:	b80ff0ef          	jal	5294 <game_reset>
        bsp_printf("\r\nEV reset\r\n"); break;
    5f18:	00008537          	lui	a0,0x8
    5f1c:	92450513          	addi	a0,a0,-1756 # 7924 <_data+0x6d8>
    5f20:	cfcff0ef          	jal	541c <bsp_printf>
    5f24:	d61ff06f          	j	5c84 <serial_cmd+0x48>
    5f28:	02812423          	sw	s0,40(sp)
    5f2c:	02912223          	sw	s1,36(sp)
    5f30:	03212023          	sw	s2,32(sp)
    5f34:	01312e23          	sw	s3,28(sp)
    5f38:	01412c23          	sw	s4,24(sp)
    5f3c:	01512a23          	sw	s5,20(sp)
    5f40:	01612823          	sw	s6,16(sp)
        bsp_printf("\r\nEV diag: N=%d ON=%d HW=%d SW=%d SC=%d LV=%d HP=%d BOMB=%d\r\n",
    5f44:	8141a783          	lw	a5,-2028(gp) # 8c8c <g_bomb>
    5f48:	00f12023          	sw	a5,0(sp)
    5f4c:	8181a883          	lw	a7,-2024(gp) # 8c90 <g_hp>
    5f50:	8101a803          	lw	a6,-2032(gp) # 8c88 <g_level>
    5f54:	8941a783          	lw	a5,-1900(gp) # 8d0c <g_score>
    5f58:	8701a703          	lw	a4,-1936(gp) # 8ce8 <g_sw_fps>
    5f5c:	8741a683          	lw	a3,-1932(gp) # 8cec <g_hw_fps>
    5f60:	85c1a603          	lw	a2,-1956(gp) # 8cd4 <g_on_screen>
    5f64:	81c1a583          	lw	a1,-2020(gp) # 8c94 <g_ncap>
    5f68:	00008537          	lui	a0,0x8
    5f6c:	93450513          	addi	a0,a0,-1740 # 7934 <_data+0x6e8>
    5f70:	cacff0ef          	jal	541c <bsp_printf>
                   (unsigned)blt_stat(), (unsigned)blt_cnt(), (unsigned)blt_rd(BLT_SCAN_DBG),
    5f74:	a79fc0ef          	jal	29ec <blt_stat>
    5f78:	00050413          	mv	s0,a0
    5f7c:	a55fc0ef          	jal	29d0 <blt_cnt>
    5f80:	00050493          	mv	s1,a0
    5f84:	02000513          	li	a0,32
    5f88:	d70fc0ef          	jal	24f8 <blt_rd>
    5f8c:	00050913          	mv	s2,a0
                   (unsigned)blt_rd(BLT_FB_STAT), (unsigned)blt_rd(BLT_DRAW_SEL),
    5f90:	02800513          	li	a0,40
    5f94:	d64fc0ef          	jal	24f8 <blt_rd>
    5f98:	00050993          	mv	s3,a0
    5f9c:	04400513          	li	a0,68
    5fa0:	d58fc0ef          	jal	24f8 <blt_rd>
    5fa4:	00050a13          	mv	s4,a0
                   (unsigned)blt_rd(BLT_CLR_STAT), (unsigned)blt_rd(BLT_CLIP_CTRL),
    5fa8:	04000513          	li	a0,64
    5fac:	d4cfc0ef          	jal	24f8 <blt_rd>
    5fb0:	00050a93          	mv	s5,a0
    5fb4:	0a000513          	li	a0,160
    5fb8:	d40fc0ef          	jal	24f8 <blt_rd>
    5fbc:	00050b13          	mv	s6,a0
                   (unsigned)blt_rd(BLT_LUT_CTRL));
    5fc0:	0ac00513          	li	a0,172
    5fc4:	d34fc0ef          	jal	24f8 <blt_rd>
        bsp_printf("     STATUS=%x COUNT=%d SCAN=%x FBSTAT=%x DRAW=%x CLR=%x clip=%x lut=%x\r\n",
    5fc8:	00a12023          	sw	a0,0(sp)
    5fcc:	000b0893          	mv	a7,s6
    5fd0:	000a8813          	mv	a6,s5
    5fd4:	000a0793          	mv	a5,s4
    5fd8:	00098713          	mv	a4,s3
    5fdc:	00090693          	mv	a3,s2
    5fe0:	00048613          	mv	a2,s1
    5fe4:	00040593          	mv	a1,s0
    5fe8:	00008537          	lui	a0,0x8
    5fec:	97450513          	addi	a0,a0,-1676 # 7974 <_data+0x728>
    5ff0:	c2cff0ef          	jal	541c <bsp_printf>
        bsp_printf("     flipto=%d clr fb=%d to=%d err=%d stto=%d attr=%d glow=%d clipdrop=%d\r\n",
    5ff4:	8ac1a783          	lw	a5,-1876(gp) # 8d24 <g_clip_drop>
    5ff8:	00f12023          	sw	a5,0(sp)
    5ffc:	8fc1a883          	lw	a7,-1796(gp) # 8d74 <g_glow>
    6000:	8f01a803          	lw	a6,-1808(gp) # 8d68 <g_attr_on>
    6004:	8cc1a783          	lw	a5,-1844(gp) # 8d44 <g_stto>
    6008:	8d01a703          	lw	a4,-1840(gp) # 8d48 <g_clr_err>
    600c:	8d41a683          	lw	a3,-1836(gp) # 8d4c <g_clr_to>
    6010:	8d81a603          	lw	a2,-1832(gp) # 8d50 <g_clr_fb>
    6014:	8e41a583          	lw	a1,-1820(gp) # 8d5c <g_flip_to>
    6018:	00008537          	lui	a0,0x8
    601c:	9c050513          	addi	a0,a0,-1600 # 79c0 <_data+0x774>
    6020:	bfcff0ef          	jal	541c <bsp_printf>
        bsp_printf("     bulm=%s (req) %s (eff) alpha=%d | 16x16 70pct cap: FILL=%d ALPHA=%d KEY=%d\r\n",
    6024:	000097b7          	lui	a5,0x9
    6028:	8381a703          	lw	a4,-1992(gp) # 8cb0 <g_bulm>
    602c:	00271713          	slli	a4,a4,0x2
    6030:	b5478793          	addi	a5,a5,-1196 # 8b54 <g_bulm_name>
    6034:	00e787b3          	add	a5,a5,a4
    6038:	0007a983          	lw	s3,0(a5)
    603c:	8acfc0ef          	jal	20e8 <bulm_eff_name>
    6040:	00050413          	mv	s0,a0
                   (int)cost_capacity(DRAW_FILL,  SZ_B, 70, 0),
    6044:	00000693          	li	a3,0
    6048:	04600613          	li	a2,70
    604c:	01000593          	li	a1,16
    6050:	00100513          	li	a0,1
    6054:	cc8fd0ef          	jal	351c <cost_capacity>
    6058:	00050493          	mv	s1,a0
                   (int)cost_capacity(DRAW_ALPHA, SZ_B, 70, 0),
    605c:	00000693          	li	a3,0
    6060:	04600613          	li	a2,70
    6064:	01000593          	li	a1,16
    6068:	00400513          	li	a0,4
    606c:	cb0fd0ef          	jal	351c <cost_capacity>
    6070:	00050913          	mv	s2,a0
                   (int)cost_capacity(DRAW_KEY,   SZ_B, 70, 0));
    6074:	00000693          	li	a3,0
    6078:	04600613          	li	a2,70
    607c:	01000593          	li	a1,16
    6080:	00200513          	li	a0,2
    6084:	c98fd0ef          	jal	351c <cost_capacity>
        bsp_printf("     bulm=%s (req) %s (eff) alpha=%d | 16x16 70pct cap: FILL=%d ALPHA=%d KEY=%d\r\n",
    6088:	00050813          	mv	a6,a0
    608c:	00090793          	mv	a5,s2
    6090:	00048713          	mv	a4,s1
    6094:	0a000693          	li	a3,160
    6098:	00040613          	mv	a2,s0
    609c:	00098593          	mv	a1,s3
    60a0:	00008537          	lui	a0,0x8
    60a4:	a0c50513          	addi	a0,a0,-1524 # 7a0c <_data+0x7c0>
    60a8:	b74ff0ef          	jal	541c <bsp_printf>
                   (int)cost_capacity(DRAW_GLOW, SZ_B, 70, 0),
    60ac:	00000693          	li	a3,0
    60b0:	04600613          	li	a2,70
    60b4:	01000593          	li	a1,16
    60b8:	00300513          	li	a0,3
    60bc:	c60fd0ef          	jal	351c <cost_capacity>
    60c0:	00050413          	mv	s0,a0
                   (int)cost_capacity(DRAW_GLOW, SZ_B, 70, 1));
    60c4:	00100693          	li	a3,1
    60c8:	04600613          	li	a2,70
    60cc:	01000593          	li	a1,16
    60d0:	00300513          	li	a0,3
    60d4:	c48fd0ef          	jal	351c <cost_capacity>
    60d8:	00050613          	mv	a2,a0
        bsp_printf("     cap16 glow 70pct budget: single-lane %d, dual-lane %d sprites/frame\r\n",
    60dc:	00040593          	mv	a1,s0
    60e0:	00008537          	lui	a0,0x8
    60e4:	a6050513          	addi	a0,a0,-1440 # 7a60 <_data+0x814>
    60e8:	b34ff0ef          	jal	541c <bsp_printf>
        break;
    60ec:	02812403          	lw	s0,40(sp)
    60f0:	02412483          	lw	s1,36(sp)
    60f4:	02012903          	lw	s2,32(sp)
    60f8:	01c12983          	lw	s3,28(sp)
    60fc:	01812a03          	lw	s4,24(sp)
    6100:	01412a83          	lw	s5,20(sp)
    6104:	01012b03          	lw	s6,16(sp)
    6108:	b7dff06f          	j	5c84 <serial_cmd+0x48>
        bsp_printf("\r\ncmd: 1/2/3/4=load presets N=256/640/1280/2400\r\n"
    610c:	00001737          	lui	a4,0x1
    6110:	96070713          	addi	a4,a4,-1696 # 960 <CUSTOM2+0x905>
    6114:	04000693          	li	a3,64
    6118:	04000613          	li	a2,64
    611c:	04000593          	li	a1,64
    6120:	00008537          	lui	a0,0x8
    6124:	aac50513          	addi	a0,a0,-1364 # 7aac <_data+0x860>
    6128:	af4ff0ef          	jal	541c <bsp_printf>
}
    612c:	b59ff06f          	j	5c84 <serial_cmd+0x48>
    6130:	00008067          	ret

00006134 <serial_drain>:
{
    6134:	fe010113          	addi	sp,sp,-32
    6138:	00112e23          	sw	ra,28(sp)
    613c:	00812c23          	sw	s0,24(sp)
    6140:	00912a23          	sw	s1,20(sp)
    int guard = 64;
    6144:	04000793          	li	a5,64
    while (guard-- > 0) {
    6148:	0100006f          	j	6158 <serial_drain+0x24>
        if (kp == KP_OK) { serial_apply_key(mask); continue; }
    614c:	00c12503          	lw	a0,12(sp)
    6150:	a5dff0ef          	jal	5bac <serial_apply_key>
{
    6154:	00048793          	mv	a5,s1
    while (guard-- > 0) {
    6158:	fff78493          	addi	s1,a5,-1
    615c:	08f05a63          	blez	a5,61f0 <serial_drain+0xbc>
        int c = uart_poll_char();
    6160:	aa5fc0ef          	jal	2c04 <uart_poll_char>
    6164:	00050413          	mv	s0,a0
        int kp, nl, ncmd = 0;
    6168:	00012423          	sw	zero,8(sp)
        unsigned mask = 0u;
    616c:	00012623          	sw	zero,12(sp)
        if (!c) break;
    6170:	08050063          	beqz	a0,61f0 <serial_drain+0xbc>
        kp = kp_feed(c, &mask);
    6174:	00c10593          	addi	a1,sp,12
    6178:	b05fc0ef          	jal	2c7c <kp_feed>
        if (kp == KP_OK) { serial_apply_key(mask); continue; }
    617c:	00200793          	li	a5,2
    6180:	fcf506e3          	beq	a0,a5,614c <serial_drain+0x18>
        if (kp != KP_NONE) continue;                  /* KP_MORE / KP_ERR：本函数已消费 */
    6184:	fc0518e3          	bnez	a0,6154 <serial_drain+0x20>
        nl = nline_feed(c, &ncmd, N_MIN, N_MAX);
    6188:	000016b7          	lui	a3,0x1
    618c:	96068693          	addi	a3,a3,-1696 # 960 <CUSTOM2+0x905>
    6190:	04000613          	li	a2,64
    6194:	00810593          	addi	a1,sp,8
    6198:	00040513          	mv	a0,s0
    619c:	b99fc0ef          	jal	2d34 <nline_feed>
        if (nl == NL_OK) { g_ncap = ncmd; g_auto = 0; bsp_printf("\r\nEV N=%d\r\n", g_ncap); continue; }
    61a0:	00200793          	li	a5,2
    61a4:	02f50063          	beq	a0,a5,61c4 <serial_drain+0x90>
        if (nl == NL_ERR) { bsp_printf("\r\nEV N=ERR\r\n"); continue; }
    61a8:	fff00793          	li	a5,-1
    61ac:	02f50a63          	beq	a0,a5,61e0 <serial_drain+0xac>
        if (nl == NL_MORE) continue;
    61b0:	00100793          	li	a5,1
    61b4:	faf500e3          	beq	a0,a5,6154 <serial_drain+0x20>
        serial_cmd(c);                                /* ★ 单字符命令的唯一实现 */
    61b8:	00040513          	mv	a0,s0
    61bc:	a81ff0ef          	jal	5c3c <serial_cmd>
    61c0:	f95ff06f          	j	6154 <serial_drain+0x20>
        if (nl == NL_OK) { g_ncap = ncmd; g_auto = 0; bsp_printf("\r\nEV N=%d\r\n", g_ncap); continue; }
    61c4:	00812583          	lw	a1,8(sp)
    61c8:	80b1ae23          	sw	a1,-2020(gp) # 8c94 <g_ncap>
    61cc:	8a01a023          	sw	zero,-1888(gp) # 8d18 <g_auto>
    61d0:	00007537          	lui	a0,0x7
    61d4:	76c50513          	addi	a0,a0,1900 # 776c <_data+0x520>
    61d8:	a44ff0ef          	jal	541c <bsp_printf>
    61dc:	f79ff06f          	j	6154 <serial_drain+0x20>
        if (nl == NL_ERR) { bsp_printf("\r\nEV N=ERR\r\n"); continue; }
    61e0:	00008537          	lui	a0,0x8
    61e4:	cf450513          	addi	a0,a0,-780 # 7cf4 <_data+0xaa8>
    61e8:	a34ff0ef          	jal	541c <bsp_printf>
    61ec:	f69ff06f          	j	6154 <serial_drain+0x20>
}
    61f0:	01c12083          	lw	ra,28(sp)
    61f4:	01812403          	lw	s0,24(sp)
    61f8:	01412483          	lw	s1,20(sp)
    61fc:	02010113          	addi	sp,sp,32
    6200:	00008067          	ret

00006204 <player_step>:
{
    6204:	fe010113          	addi	sp,sp,-32
    6208:	00112e23          	sw	ra,28(sp)
    620c:	00812c23          	sw	s0,24(sp)
    6210:	00912a23          	sw	s1,20(sp)
    6214:	01212823          	sw	s2,16(sp)
    int spd = (g_keymask & KEY_FOCUS) ? PLR_SPD_F : PLR_SPD;   /* Q3/帧 */
    6218:	8881a783          	lw	a5,-1912(gp) # 8d00 <g_keymask>
    621c:	0207f713          	andi	a4,a5,32
    6220:	06070063          	beqz	a4,6280 <player_step+0x7c>
    6224:	01400713          	li	a4,20
    int nx = (int)g_px, ny = (int)g_py;
    6228:	89e19403          	lh	s0,-1890(gp) # 8d16 <g_px>
    622c:	89c19483          	lh	s1,-1892(gp) # 8d14 <g_py>
    if (g_keymask & KEY_LEFT)  nx -= spd;
    6230:	0047f693          	andi	a3,a5,4
    6234:	00068463          	beqz	a3,623c <player_step+0x38>
    6238:	40e40433          	sub	s0,s0,a4
    if (g_keymask & KEY_RIGHT) nx += spd;
    623c:	0087f693          	andi	a3,a5,8
    6240:	00068463          	beqz	a3,6248 <player_step+0x44>
    6244:	00e40433          	add	s0,s0,a4
    if (g_keymask & KEY_UP)    ny -= spd;
    6248:	0017f693          	andi	a3,a5,1
    624c:	00068463          	beqz	a3,6254 <player_step+0x50>
    6250:	40e484b3          	sub	s1,s1,a4
    if (g_keymask & KEY_DOWN)  ny += spd;
    6254:	0027f693          	andi	a3,a5,2
    6258:	00068463          	beqz	a3,6260 <player_step+0x5c>
    625c:	00e484b3          	add	s1,s1,a4
    if (nx < FP(16)) nx = FP(16);
    6260:	07f00713          	li	a4,127
    6264:	02875263          	bge	a4,s0,6288 <player_step+0x84>
    if (nx > FP(PLAY_W - 16)) nx = FP(PLAY_W - 16);
    6268:	00001737          	lui	a4,0x1
    626c:	78070713          	addi	a4,a4,1920 # 1780 <main+0x67c>
    6270:	00875e63          	bge	a4,s0,628c <player_step+0x88>
    6274:	00001437          	lui	s0,0x1
    6278:	78040413          	addi	s0,s0,1920 # 1780 <main+0x67c>
    627c:	0180006f          	j	6294 <player_step+0x90>
    int spd = (g_keymask & KEY_FOCUS) ? PLR_SPD_F : PLR_SPD;   /* Q3/帧 */
    6280:	02800713          	li	a4,40
    6284:	fa5ff06f          	j	6228 <player_step+0x24>
    if (nx < FP(16)) nx = FP(16);
    6288:	08000413          	li	s0,128
    if (nx < FP(16)) nx = FP(16);
    628c:	07f00713          	li	a4,127
    6290:	02875263          	bge	a4,s0,62b4 <player_step+0xb0>
        if (ny < FP(PLAY_Y0 + 16)) ny = FP(PLAY_Y0 + 16);
    6294:	0ff00713          	li	a4,255
    6298:	02975263          	bge	a4,s1,62bc <player_step+0xb8>
    if (ny > FP(PLAY_Y1 - 16)) ny = FP(PLAY_Y1 - 16);
    629c:	00001737          	lui	a4,0x1
    62a0:	06070713          	addi	a4,a4,96 # 1060 <init+0x58>
    62a4:	00975e63          	bge	a4,s1,62c0 <player_step+0xbc>
    62a8:	000014b7          	lui	s1,0x1
    62ac:	06048493          	addi	s1,s1,96 # 1060 <init+0x58>
    62b0:	0100006f          	j	62c0 <player_step+0xbc>
    if (nx < FP(16)) nx = FP(16);
    62b4:	08000413          	li	s0,128
    62b8:	fddff06f          	j	6294 <player_step+0x90>
        if (ny < FP(PLAY_Y0 + 16)) ny = FP(PLAY_Y0 + 16);
    62bc:	10000493          	li	s1,256
    g_px = (int16_t)nx; g_py = (int16_t)ny;
    62c0:	88819f23          	sh	s0,-1890(gp) # 8d16 <g_px>
    62c4:	88919e23          	sh	s1,-1892(gp) # 8d14 <g_py>
    if (g_state == GS_PLAY && (g_keymask & KEY_FIRE)) {
    62c8:	8a81a903          	lw	s2,-1880(gp) # 8d20 <g_state>
    62cc:	00100713          	li	a4,1
    62d0:	02e90863          	beq	s2,a4,6300 <player_step+0xfc>
    if (g_bomb_req) {
    62d4:	8841a783          	lw	a5,-1916(gp) # 8cfc <g_bomb_req>
    62d8:	00078863          	beqz	a5,62e8 <player_step+0xe4>
        g_bomb_req = 0;
    62dc:	8801a223          	sw	zero,-1916(gp) # 8cfc <g_bomb_req>
        if (g_state == GS_PLAY && g_bomb > 0) {
    62e0:	00100793          	li	a5,1
    62e4:	0ef90263          	beq	s2,a5,63c8 <player_step+0x1c4>
}
    62e8:	01c12083          	lw	ra,28(sp)
    62ec:	01812403          	lw	s0,24(sp)
    62f0:	01412483          	lw	s1,20(sp)
    62f4:	01012903          	lw	s2,16(sp)
    62f8:	02010113          	addi	sp,sp,32
    62fc:	00008067          	ret
    if (g_state == GS_PLAY && (g_keymask & KEY_FIRE)) {
    6300:	0107f793          	andi	a5,a5,16
    6304:	fc0788e3          	beqz	a5,62d4 <player_step+0xd0>
        if (--g_shot_t <= 0) {
    6308:	8901a783          	lw	a5,-1904(gp) # 8d08 <g_shot_t>
    630c:	fff78793          	addi	a5,a5,-1
    6310:	88f1a823          	sw	a5,-1904(gp) # 8d08 <g_shot_t>
    6314:	fcf040e3          	bgtz	a5,62d4 <player_step+0xd0>
    6318:	01312623          	sw	s3,12(sp)
            g_shot_t = PLR_SHOT_T;
    631c:	00070793          	mv	a5,a4
    6320:	00700713          	li	a4,7
    6324:	88e1a823          	sw	a4,-1904(gp) # 8d08 <g_shot_t>
            for (i = 0; i < 2; i++) {
    6328:	00000993          	li	s3,0
    632c:	0700006f          	j	639c <player_step+0x198>
                    b->x = (int16_t)(g_px + (i ? FP(6) : -FP(6)));
    6330:	000107b7          	lui	a5,0x10
    6334:	fd078793          	addi	a5,a5,-48 # ffd0 <__global_pointer$+0x6b58>
    6338:	00878633          	add	a2,a5,s0
    633c:	00013737          	lui	a4,0x13
    6340:	8fc70713          	addi	a4,a4,-1796 # 128fc <g_bul>
    6344:	00151693          	slli	a3,a0,0x1
    6348:	00a687b3          	add	a5,a3,a0
    634c:	00279793          	slli	a5,a5,0x2
    6350:	00f707b3          	add	a5,a4,a5
    6354:	00c79023          	sh	a2,0(a5)
                    b->y = (int16_t)(g_py - FP(20));
    6358:	f6048613          	addi	a2,s1,-160
    635c:	00c79123          	sh	a2,2(a5)
                    b->vx = 0; b->vy = (int16_t)(-56);
    6360:	00079223          	sh	zero,4(a5)
    6364:	fc800613          	li	a2,-56
    6368:	00c79323          	sh	a2,6(a5)
                    b->kind = S_SH; b->sz = SZ_B; b->r = 4; b->life = 90;
    636c:	00200613          	li	a2,2
    6370:	00c78423          	sb	a2,8(a5)
    6374:	01000613          	li	a2,16
    6378:	00c784a3          	sb	a2,9(a5)
    637c:	00400613          	li	a2,4
    6380:	00c78523          	sb	a2,10(a5)
    6384:	00a687b3          	add	a5,a3,a0
    6388:	00279793          	slli	a5,a5,0x2
    638c:	00f70733          	add	a4,a4,a5
    6390:	05a00793          	li	a5,90
    6394:	00f705a3          	sb	a5,11(a4)
            for (i = 0; i < 2; i++) {
    6398:	00198993          	addi	s3,s3,1
    639c:	00100793          	li	a5,1
    63a0:	0337c063          	blt	a5,s3,63c0 <player_step+0x1bc>
                int k = bul_alloc(0, PLR_SLOTS);
    63a4:	02000593          	li	a1,32
    63a8:	00000513          	li	a0,0
    63ac:	bcdfc0ef          	jal	2f78 <bul_alloc>
                if (k >= 0) {
    63b0:	fe0544e3          	bltz	a0,6398 <player_step+0x194>
                    b->x = (int16_t)(g_px + (i ? FP(6) : -FP(6)));
    63b4:	f6098ee3          	beqz	s3,6330 <player_step+0x12c>
    63b8:	03000793          	li	a5,48
    63bc:	f7dff06f          	j	6338 <player_step+0x134>
    63c0:	00c12983          	lw	s3,12(sp)
    63c4:	f11ff06f          	j	62d4 <player_step+0xd0>
        if (g_state == GS_PLAY && g_bomb > 0) {
    63c8:	8141a783          	lw	a5,-2028(gp) # 8c8c <g_bomb>
    63cc:	f0f05ee3          	blez	a5,62e8 <player_step+0xe4>
        int k = 0;
    63d0:	00000693          	li	a3,0
            for (i = PLR_SLOTS; i < BUL_TOTAL; i++)
    63d4:	02000413          	li	s0,32
    63d8:	04c0006f          	j	6424 <player_step+0x220>
                    if ((k++ & 3) == 0) spark_add(g_bul[i].x, g_bul[i].y);
    63dc:	000137b7          	lui	a5,0x13
    63e0:	00141713          	slli	a4,s0,0x1
    63e4:	00870733          	add	a4,a4,s0
    63e8:	00271713          	slli	a4,a4,0x2
    63ec:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    63f0:	00e787b3          	add	a5,a5,a4
    63f4:	00279583          	lh	a1,2(a5)
    63f8:	00079503          	lh	a0,0(a5)
    63fc:	f5cfd0ef          	jal	3b58 <spark_add>
                    g_bul[i].life = 0;
    6400:	000137b7          	lui	a5,0x13
    6404:	00141713          	slli	a4,s0,0x1
    6408:	00870733          	add	a4,a4,s0
    640c:	00271713          	slli	a4,a4,0x2
    6410:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6414:	00e787b3          	add	a5,a5,a4
    6418:	000785a3          	sb	zero,11(a5)
                    if ((k++ & 3) == 0) spark_add(g_bul[i].x, g_bul[i].y);
    641c:	00048693          	mv	a3,s1
            for (i = PLR_SLOTS; i < BUL_TOTAL; i++)
    6420:	00140413          	addi	s0,s0,1
    6424:	000017b7          	lui	a5,0x1
    6428:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    642c:	0287ca63          	blt	a5,s0,6460 <player_step+0x25c>
                if (g_bul[i].life) {
    6430:	000137b7          	lui	a5,0x13
    6434:	00141713          	slli	a4,s0,0x1
    6438:	00870733          	add	a4,a4,s0
    643c:	00271713          	slli	a4,a4,0x2
    6440:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6444:	00e787b3          	add	a5,a5,a4
    6448:	00b7c783          	lbu	a5,11(a5)
    644c:	fc078ae3          	beqz	a5,6420 <player_step+0x21c>
                    if ((k++ & 3) == 0) spark_add(g_bul[i].x, g_bul[i].y);
    6450:	00168493          	addi	s1,a3,1
    6454:	0036f693          	andi	a3,a3,3
    6458:	fa0694e3          	bnez	a3,6400 <player_step+0x1fc>
    645c:	f81ff06f          	j	63dc <player_step+0x1d8>
            for (i = 0; i < ENEMY_MAX; i++) if (g_en[i].t) g_en[i].hp -= 3;
    6460:	00000713          	li	a4,0
    6464:	0080006f          	j	646c <player_step+0x268>
    6468:	00170713          	addi	a4,a4,1
    646c:	01700793          	li	a5,23
    6470:	02e7cc63          	blt	a5,a4,64a8 <player_step+0x2a4>
    6474:	000127b7          	lui	a5,0x12
    6478:	00471693          	slli	a3,a4,0x4
    647c:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6480:	00d787b3          	add	a5,a5,a3
    6484:	00e79783          	lh	a5,14(a5)
    6488:	fe0780e3          	beqz	a5,6468 <player_step+0x264>
    648c:	000127b7          	lui	a5,0x12
    6490:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6494:	00d787b3          	add	a5,a5,a3
    6498:	0087d683          	lhu	a3,8(a5)
    649c:	ffd68693          	addi	a3,a3,-3
    64a0:	00d79423          	sh	a3,8(a5)
    64a4:	fc5ff06f          	j	6468 <player_step+0x264>
            g_bomb--; g_invuln = 60;
    64a8:	8141a583          	lw	a1,-2028(gp) # 8c8c <g_bomb>
    64ac:	fff58593          	addi	a1,a1,-1
    64b0:	80b1aa23          	sw	a1,-2028(gp) # 8c8c <g_bomb>
    64b4:	03c00713          	li	a4,60
    64b8:	88e1ac23          	sw	a4,-1896(gp) # 8d10 <g_invuln>
            bsp_printf("\r\nEV bomb left=%d\r\n", g_bomb);
    64bc:	00008537          	lui	a0,0x8
    64c0:	d0450513          	addi	a0,a0,-764 # 7d04 <_data+0xab8>
    64c4:	f59fe0ef          	jal	541c <bsp_printf>
}
    64c8:	e21ff06f          	j	62e8 <player_step+0xe4>

000064cc <game_tick>:
{
    64cc:	fe010113          	addi	sp,sp,-32
    64d0:	00112e23          	sw	ra,28(sp)
    if (g_state == GS_TITLE) {
    64d4:	8a81a783          	lw	a5,-1880(gp) # 8d20 <g_state>
    64d8:	02078063          	beqz	a5,64f8 <game_tick+0x2c>
    if (g_state == GS_OVER) {
    64dc:	00200713          	li	a4,2
    64e0:	0ae78263          	beq	a5,a4,6584 <game_tick+0xb8>
    64e4:	00912a23          	sw	s1,20(sp)
    if (g_pause) return;
    64e8:	8a41a483          	lw	s1,-1884(gp) # 8d1c <g_pause>
    64ec:	0c048e63          	beqz	s1,65c8 <game_tick+0xfc>
    64f0:	01412483          	lw	s1,20(sp)
    64f4:	05c0006f          	j	6550 <game_tick+0x84>
        g_px = (int16_t)FP(PLAY_W / 2 + (isin((int)(g_frames & 63)) * 120) / 256);
    64f8:	8781a503          	lw	a0,-1928(gp) # 8cf0 <g_frames>
    64fc:	03f57513          	andi	a0,a0,63
    6500:	969fc0ef          	jal	2e68 <isin>
    6504:	00451713          	slli	a4,a0,0x4
    6508:	40a70733          	sub	a4,a4,a0
    650c:	00371713          	slli	a4,a4,0x3
    6510:	41f75793          	srai	a5,a4,0x1f
    6514:	0ff7f793          	zext.b	a5,a5
    6518:	00e787b3          	add	a5,a5,a4
    651c:	4087d793          	srai	a5,a5,0x8
    6520:	18078793          	addi	a5,a5,384
    6524:	00379793          	slli	a5,a5,0x3
    6528:	88f19f23          	sh	a5,-1890(gp) # 8d16 <g_px>
        g_py = (int16_t)FP(PLAY_Y1 - 70);
    652c:	000017b7          	lui	a5,0x1
    6530:	eb078793          	addi	a5,a5,-336 # eb0 <CUSTOM2+0xe55>
    6534:	88f19e23          	sh	a5,-1892(gp) # 8d14 <g_py>
        if (g_keymask & KEY_FIRE) { g_seed += 0x9E3779B9u; game_reset(); bsp_printf("\r\nEV start\r\n"); }
    6538:	8881a783          	lw	a5,-1912(gp) # 8d00 <g_keymask>
    653c:	0107f793          	andi	a5,a5,16
    6540:	00079e63          	bnez	a5,655c <game_tick+0x90>
        g_frames++;
    6544:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    6548:	00178793          	addi	a5,a5,1
    654c:	86f1ac23          	sw	a5,-1928(gp) # 8cf0 <g_frames>
}
    6550:	01c12083          	lw	ra,28(sp)
    6554:	02010113          	addi	sp,sp,32
    6558:	00008067          	ret
        if (g_keymask & KEY_FIRE) { g_seed += 0x9E3779B9u; game_reset(); bsp_printf("\r\nEV start\r\n"); }
    655c:	8281a783          	lw	a5,-2008(gp) # 8ca0 <g_seed>
    6560:	9e378737          	lui	a4,0x9e378
    6564:	9b970713          	addi	a4,a4,-1607 # 9e3779b9 <__freertos_irq_stack_top+0x9e35cea9>
    6568:	00e787b3          	add	a5,a5,a4
    656c:	82f1a423          	sw	a5,-2008(gp) # 8ca0 <g_seed>
    6570:	d25fe0ef          	jal	5294 <game_reset>
    6574:	00008537          	lui	a0,0x8
    6578:	d1850513          	addi	a0,a0,-744 # 7d18 <_data+0xacc>
    657c:	ea1fe0ef          	jal	541c <bsp_printf>
    6580:	fc5ff06f          	j	6544 <game_tick+0x78>
        if (g_keymask & KEY_FIRE) { g_seed += 0x9E3779B9u; game_reset(); bsp_printf("\r\nEV restart\r\n"); }
    6584:	8881a783          	lw	a5,-1912(gp) # 8d00 <g_keymask>
    6588:	0107f793          	andi	a5,a5,16
    658c:	00079a63          	bnez	a5,65a0 <game_tick+0xd4>
        g_frames++;
    6590:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    6594:	00178793          	addi	a5,a5,1
    6598:	86f1ac23          	sw	a5,-1928(gp) # 8cf0 <g_frames>
        return;
    659c:	fb5ff06f          	j	6550 <game_tick+0x84>
        if (g_keymask & KEY_FIRE) { g_seed += 0x9E3779B9u; game_reset(); bsp_printf("\r\nEV restart\r\n"); }
    65a0:	8281a783          	lw	a5,-2008(gp) # 8ca0 <g_seed>
    65a4:	9e378737          	lui	a4,0x9e378
    65a8:	9b970713          	addi	a4,a4,-1607 # 9e3779b9 <__freertos_irq_stack_top+0x9e35cea9>
    65ac:	00e787b3          	add	a5,a5,a4
    65b0:	82f1a423          	sw	a5,-2008(gp) # 8ca0 <g_seed>
    65b4:	ce1fe0ef          	jal	5294 <game_reset>
    65b8:	00008537          	lui	a0,0x8
    65bc:	d2850513          	addi	a0,a0,-728 # 7d28 <_data+0xadc>
    65c0:	e5dfe0ef          	jal	541c <bsp_printf>
    65c4:	fcdff06f          	j	6590 <game_tick+0xc4>
    65c8:	00812c23          	sw	s0,24(sp)
    65cc:	01212823          	sw	s2,16(sp)
    65d0:	01312623          	sw	s3,12(sp)
    65d4:	01412423          	sw	s4,8(sp)
    65d8:	01512223          	sw	s5,4(sp)
    g_frames++;
    65dc:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    65e0:	00178793          	addi	a5,a5,1
    65e4:	86f1ac23          	sw	a5,-1928(gp) # 8cf0 <g_frames>
    player_step();
    65e8:	c1dff0ef          	jal	6204 <player_step>
    if (g_invuln > 0) g_invuln--;
    65ec:	8981a783          	lw	a5,-1896(gp) # 8d10 <g_invuln>
    65f0:	00f05663          	blez	a5,65fc <game_tick+0x130>
    65f4:	fff78793          	addi	a5,a5,-1
    65f8:	88f1ac23          	sw	a5,-1896(gp) # 8d10 <g_invuln>
    if (++g_level_t >= LEVEL_TICKS) {
    65fc:	88c1a783          	lw	a5,-1908(gp) # 8d04 <g_level_t>
    6600:	00178793          	addi	a5,a5,1
    6604:	88f1a623          	sw	a5,-1908(gp) # 8d04 <g_level_t>
    6608:	70700713          	li	a4,1799
    660c:	02f75663          	bge	a4,a5,6638 <game_tick+0x16c>
        g_level_t = 0;
    6610:	8801a623          	sw	zero,-1908(gp) # 8d04 <g_level_t>
        if (g_level < 99) g_level++;
    6614:	8101a783          	lw	a5,-2032(gp) # 8c88 <g_level>
    6618:	06200713          	li	a4,98
    661c:	00f74663          	blt	a4,a5,6628 <game_tick+0x15c>
    6620:	00178793          	addi	a5,a5,1
    6624:	80f1a823          	sw	a5,-2032(gp) # 8c88 <g_level>
        bsp_printf("\r\nEV level=%d\r\n", g_level);
    6628:	8101a583          	lw	a1,-2032(gp) # 8c88 <g_level>
    662c:	00008537          	lui	a0,0x8
    6630:	d3850513          	addi	a0,a0,-712 # 7d38 <_data+0xaec>
    6634:	de9fe0ef          	jal	541c <bsp_printf>
    if ((g_frames % (uint32_t)SCORE_TICK_DIV) == 0) g_score += SCORE_PER_TICK;
    6638:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    663c:	00a00713          	li	a4,10
    6640:	02e7f733          	remu	a4,a5,a4
    6644:	00071863          	bnez	a4,6654 <game_tick+0x188>
    6648:	8941a703          	lw	a4,-1900(gp) # 8d0c <g_score>
    664c:	00170713          	addi	a4,a4,1
    6650:	88e1aa23          	sw	a4,-1900(gp) # 8d0c <g_score>
    if (g_score > SCORE_CAP) g_score = SCORE_CAP;
    6654:	8941a683          	lw	a3,-1900(gp) # 8d0c <g_score>
    6658:	000f4737          	lui	a4,0xf4
    665c:	23f70713          	addi	a4,a4,575 # f423f <__freertos_irq_stack_top+0xd972f>
    6660:	00d75863          	bge	a4,a3,6670 <game_tick+0x1a4>
    6664:	000f4737          	lui	a4,0xf4
    6668:	23f70713          	addi	a4,a4,575 # f423f <__freertos_irq_stack_top+0xd972f>
    666c:	88e1aa23          	sw	a4,-1900(gp) # 8d0c <g_score>
    if ((g_frames % (uint32_t)ENEMY_SPAWN_T) == 0) {
    6670:	00f7f793          	andi	a5,a5,15
    6674:	2a079663          	bnez	a5,6920 <game_tick+0x454>
        int want = 2 + g_ncap / 80;
    6678:	81c1a783          	lw	a5,-2020(gp) # 8c94 <g_ncap>
    667c:	05000713          	li	a4,80
    6680:	02e7c7b3          	div	a5,a5,a4
    6684:	00278613          	addi	a2,a5,2
        if (want > ENEMY_MAX) want = ENEMY_MAX;
    6688:	01800793          	li	a5,24
    668c:	00c7d463          	bge	a5,a2,6694 <game_tick+0x1c8>
    6690:	01800613          	li	a2,24
        int alive = 0, topup;
    6694:	00048593          	mv	a1,s1
        for (i = 0; i < ENEMY_MAX; i++) if (g_en[i].t) alive++;
    6698:	00048713          	mv	a4,s1
    669c:	0080006f          	j	66a4 <game_tick+0x1d8>
    66a0:	00170713          	addi	a4,a4,1
    66a4:	01700793          	li	a5,23
    66a8:	02e7c263          	blt	a5,a4,66cc <game_tick+0x200>
    66ac:	000127b7          	lui	a5,0x12
    66b0:	00471693          	slli	a3,a4,0x4
    66b4:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    66b8:	00d787b3          	add	a5,a5,a3
    66bc:	00e79783          	lh	a5,14(a5)
    66c0:	fe0780e3          	beqz	a5,66a0 <game_tick+0x1d4>
    66c4:	00158593          	addi	a1,a1,1
    66c8:	fd9ff06f          	j	66a0 <game_tick+0x1d4>
        topup = want - alive;
    66cc:	40b607b3          	sub	a5,a2,a1
        if (topup > ENEMY_TOPUP) topup = ENEMY_TOPUP;
    66d0:	00400713          	li	a4,4
    66d4:	08f75863          	bge	a4,a5,6764 <game_tick+0x298>
    66d8:	00400793          	li	a5,4
    66dc:	0880006f          	j	6764 <game_tick+0x298>
                    e->kind  = (uint8_t)(rnd() % 3u);
    66e0:	f6cfc0ef          	jal	2e4c <rnd>
    66e4:	00300993          	li	s3,3
    66e8:	03357533          	remu	a0,a0,s3
    66ec:	000127b7          	lui	a5,0x12
    66f0:	00441413          	slli	s0,s0,0x4
    66f4:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    66f8:	00878433          	add	s0,a5,s0
    66fc:	00a40523          	sb	a0,10(s0)
                    e->x     = (int16_t)FP(60 + (int)(rnd() % (uint32_t)(PLAY_W - 120)));
    6700:	f4cfc0ef          	jal	2e4c <rnd>
    6704:	28800793          	li	a5,648
    6708:	02f577b3          	remu	a5,a0,a5
    670c:	03c78793          	addi	a5,a5,60
    6710:	00379793          	slli	a5,a5,0x3
    6714:	00f41023          	sh	a5,0(s0)
                    e->y     = (int16_t)FP(PLAY_Y0 + 40);
    6718:	1c000793          	li	a5,448
    671c:	00f41123          	sh	a5,2(s0)
                    e->vx    = 0;
    6720:	00041223          	sh	zero,4(s0)
                    e->vy    = (int16_t)(4 + (int)(rnd() % 4u));
    6724:	f28fc0ef          	jal	2e4c <rnd>
    6728:	00357793          	andi	a5,a0,3
    672c:	00478793          	addi	a5,a5,4
    6730:	00f41323          	sh	a5,6(s0)
                    e->hp    = 3;
    6734:	01341423          	sh	s3,8(s0)
                    e->t     = ENEMY_LIFE;
    6738:	25800793          	li	a5,600
    673c:	00f41723          	sh	a5,14(s0)
                    e->fire  = (uint8_t)(20 + (int)(rnd() % 30u));
    6740:	f0cfc0ef          	jal	2e4c <rnd>
    6744:	01e00793          	li	a5,30
    6748:	02f577b3          	remu	a5,a0,a5
    674c:	01478793          	addi	a5,a5,20
    6750:	00f405a3          	sb	a5,11(s0)
                    e->phase = (uint8_t)(rnd() & 63u);
    6754:	ef8fc0ef          	jal	2e4c <rnd>
    6758:	03f57513          	andi	a0,a0,63
    675c:	00a40623          	sb	a0,12(s0)
        if (topup > ENEMY_TOPUP) topup = ENEMY_TOPUP;
    6760:	00090793          	mv	a5,s2
        while (topup-- > 0) {
    6764:	fff78913          	addi	s2,a5,-1
    6768:	1af05c63          	blez	a5,6920 <game_tick+0x454>
            for (i = 0; i < ENEMY_MAX; i++) {
    676c:	00048413          	mv	s0,s1
    6770:	01700793          	li	a5,23
    6774:	fe87c6e3          	blt	a5,s0,6760 <game_tick+0x294>
                if (g_en[i].t == 0) {
    6778:	000127b7          	lui	a5,0x12
    677c:	00441713          	slli	a4,s0,0x4
    6780:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6784:	00e787b3          	add	a5,a5,a4
    6788:	00e79783          	lh	a5,14(a5)
    678c:	f4078ae3          	beqz	a5,66e0 <game_tick+0x214>
            for (i = 0; i < ENEMY_MAX; i++) {
    6790:	00140413          	addi	s0,s0,1
    6794:	fddff06f          	j	6770 <game_tick+0x2a4>
        if (e->fire == 0) { enemy_fire(e, g_level); e->fire = ENEMY_FIRE_T; }
    6798:	8101a583          	lw	a1,-2032(gp) # 8c88 <g_level>
    679c:	00098513          	mv	a0,s3
    67a0:	bcdfc0ef          	jal	336c <enemy_fire>
    67a4:	000127b7          	lui	a5,0x12
    67a8:	00441713          	slli	a4,s0,0x4
    67ac:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    67b0:	00e787b3          	add	a5,a5,a4
    67b4:	02e00713          	li	a4,46
    67b8:	00e785a3          	sb	a4,11(a5)
    67bc:	12c0006f          	j	68e8 <game_tick+0x41c>
    for (i = 0; i < ENEMY_MAX; i++) {
    67c0:	00140413          	addi	s0,s0,1
    67c4:	01700793          	li	a5,23
    67c8:	1687c063          	blt	a5,s0,6928 <game_tick+0x45c>
        enemy_t *e = &g_en[i];
    67cc:	00441993          	slli	s3,s0,0x4
    67d0:	000127b7          	lui	a5,0x12
    67d4:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    67d8:	00f989b3          	add	s3,s3,a5
        if (!e->t) continue;
    67dc:	00e99783          	lh	a5,14(s3)
    67e0:	fe0780e3          	beqz	a5,67c0 <game_tick+0x2f4>
        e->t--;
    67e4:	fff78793          	addi	a5,a5,-1
    67e8:	00f99723          	sh	a5,14(s3)
        e->y = (int16_t)(e->y + e->vy);
    67ec:	0029da03          	lhu	s4,2(s3)
    67f0:	0069d783          	lhu	a5,6(s3)
    67f4:	00fa0a33          	add	s4,s4,a5
    67f8:	010a1a13          	slli	s4,s4,0x10
    67fc:	410a5a13          	srai	s4,s4,0x10
    6800:	01499123          	sh	s4,2(s3)
        e->x = (int16_t)(e->x + (isin((int)((g_frames + (uint32_t)i * 8u) & 63u)) * 2));
    6804:	0009da83          	lhu	s5,0(s3)
    6808:	00341513          	slli	a0,s0,0x3
    680c:	8781a783          	lw	a5,-1928(gp) # 8cf0 <g_frames>
    6810:	00f50533          	add	a0,a0,a5
    6814:	03f57513          	andi	a0,a0,63
    6818:	e50fc0ef          	jal	2e68 <isin>
    681c:	00151513          	slli	a0,a0,0x1
    6820:	00aa87b3          	add	a5,s5,a0
    6824:	01079793          	slli	a5,a5,0x10
    6828:	4107d793          	srai	a5,a5,0x10
    682c:	00f99023          	sh	a5,0(s3)
        if (PX(e->x) < 40) e->x = (int16_t)FP(40);
    6830:	4037d793          	srai	a5,a5,0x3
    6834:	02700713          	li	a4,39
    6838:	00f74663          	blt	a4,a5,6844 <game_tick+0x378>
    683c:	14000713          	li	a4,320
    6840:	00e99023          	sh	a4,0(s3)
        if (PX(e->x) > PLAY_W - 40) e->x = (int16_t)FP(PLAY_W - 40);
    6844:	000127b7          	lui	a5,0x12
    6848:	00441713          	slli	a4,s0,0x4
    684c:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6850:	00e787b3          	add	a5,a5,a4
    6854:	00079783          	lh	a5,0(a5)
    6858:	4037d793          	srai	a5,a5,0x3
    685c:	2d800713          	li	a4,728
    6860:	02f75063          	bge	a4,a5,6880 <game_tick+0x3b4>
    6864:	000127b7          	lui	a5,0x12
    6868:	00441713          	slli	a4,s0,0x4
    686c:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6870:	00e787b3          	add	a5,a5,a4
    6874:	00001737          	lui	a4,0x1
    6878:	6c070713          	addi	a4,a4,1728 # 16c0 <main+0x5bc>
    687c:	00e79023          	sh	a4,0(a5)
        if (PX(e->y) > PLAY_Y0 + 220) e->vy = 0;
    6880:	403a5a13          	srai	s4,s4,0x3
    6884:	0ec00793          	li	a5,236
    6888:	0147dc63          	bge	a5,s4,68a0 <game_tick+0x3d4>
    688c:	000127b7          	lui	a5,0x12
    6890:	00441713          	slli	a4,s0,0x4
    6894:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6898:	00e787b3          	add	a5,a5,a4
    689c:	00079323          	sh	zero,6(a5)
        if (e->fire > 0) e->fire--;
    68a0:	000127b7          	lui	a5,0x12
    68a4:	00441713          	slli	a4,s0,0x4
    68a8:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    68ac:	00e787b3          	add	a5,a5,a4
    68b0:	00b7c783          	lbu	a5,11(a5)
    68b4:	00078e63          	beqz	a5,68d0 <game_tick+0x404>
    68b8:	00012737          	lui	a4,0x12
    68bc:	00441693          	slli	a3,s0,0x4
    68c0:	2fc70713          	addi	a4,a4,764 # 122fc <g_en>
    68c4:	00d70733          	add	a4,a4,a3
    68c8:	fff78793          	addi	a5,a5,-1
    68cc:	00f705a3          	sb	a5,11(a4)
        if (e->fire == 0) { enemy_fire(e, g_level); e->fire = ENEMY_FIRE_T; }
    68d0:	000127b7          	lui	a5,0x12
    68d4:	00441713          	slli	a4,s0,0x4
    68d8:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    68dc:	00e787b3          	add	a5,a5,a4
    68e0:	00b7c783          	lbu	a5,11(a5)
    68e4:	ea078ae3          	beqz	a5,6798 <game_tick+0x2cc>
        if (e->y > FP(PLAY_Y1 + 60)) e->t = 0;
    68e8:	000127b7          	lui	a5,0x12
    68ec:	00441713          	slli	a4,s0,0x4
    68f0:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    68f4:	00e787b3          	add	a5,a5,a4
    68f8:	00279703          	lh	a4,2(a5)
    68fc:	000017b7          	lui	a5,0x1
    6900:	2c078793          	addi	a5,a5,704 # 12c0 <main+0x1bc>
    6904:	eae7dee3          	bge	a5,a4,67c0 <game_tick+0x2f4>
    6908:	000127b7          	lui	a5,0x12
    690c:	00441713          	slli	a4,s0,0x4
    6910:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    6914:	00e787b3          	add	a5,a5,a4
    6918:	00079723          	sh	zero,14(a5)
    691c:	ea5ff06f          	j	67c0 <game_tick+0x2f4>
        if (topup > ENEMY_TOPUP) topup = ENEMY_TOPUP;
    6920:	00048413          	mv	s0,s1
    6924:	ea1ff06f          	j	67c4 <game_tick+0x2f8>
    for (i = 0; i < BUL_TOTAL; i++) {
    6928:	00048413          	mv	s0,s1
    692c:	1180006f          	j	6a44 <game_tick+0x578>
                        e->t = 0;
    6930:	00071723          	sh	zero,14(a4)
                        spark_add(e->x, e->y);
    6934:	000b0593          	mv	a1,s6
    6938:	00098513          	mv	a0,s3
    693c:	a1cfd0ef          	jal	3b58 <spark_add>
                        g_score += SCORE_PER_ENEMY * g_level;
    6940:	8101a703          	lw	a4,-2032(gp) # 8c88 <g_level>
    6944:	06400793          	li	a5,100
    6948:	02e787b3          	mul	a5,a5,a4
    694c:	8941a683          	lw	a3,-1900(gp) # 8d0c <g_score>
    6950:	00d787b3          	add	a5,a5,a3
    6954:	88f1aa23          	sw	a5,-1900(gp) # 8d0c <g_score>
                        if (g_score > SCORE_CAP) g_score = SCORE_CAP;
    6958:	000f4737          	lui	a4,0xf4
    695c:	23f70713          	addi	a4,a4,575 # f423f <__freertos_irq_stack_top+0xd972f>
    6960:	28f75c63          	bge	a4,a5,6bf8 <game_tick+0x72c>
    6964:	00070793          	mv	a5,a4
    6968:	88f1aa23          	sw	a5,-1900(gp) # 8d0c <g_score>
    696c:	00012b03          	lw	s6,0(sp)
    6970:	0d00006f          	j	6a40 <game_tick+0x574>
            for (k = 0; k < ENEMY_MAX; k++) {
    6974:	00190913          	addi	s2,s2,1
    6978:	01700793          	li	a5,23
    697c:	0d27c063          	blt	a5,s2,6a3c <game_tick+0x570>
                if (!e->t) continue;
    6980:	000127b7          	lui	a5,0x12
    6984:	00491713          	slli	a4,s2,0x4
    6988:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    698c:	00e787b3          	add	a5,a5,a4
    6990:	00e79783          	lh	a5,14(a5)
    6994:	fe0780e3          	beqz	a5,6974 <game_tick+0x4a8>
                if (hit_cc(bx, by, (int)b->r, PX(e->x), PX(e->y), 15)) {
    6998:	00013637          	lui	a2,0x13
    699c:	00141793          	slli	a5,s0,0x1
    69a0:	008787b3          	add	a5,a5,s0
    69a4:	00279793          	slli	a5,a5,0x2
    69a8:	8fc60613          	addi	a2,a2,-1796 # 128fc <g_bul>
    69ac:	00f60633          	add	a2,a2,a5
    69b0:	000127b7          	lui	a5,0x12
    69b4:	2fc78793          	addi	a5,a5,764 # 122fc <g_en>
    69b8:	00e787b3          	add	a5,a5,a4
    69bc:	00079983          	lh	s3,0(a5)
    69c0:	00279b03          	lh	s6,2(a5)
    69c4:	00f00793          	li	a5,15
    69c8:	403b5713          	srai	a4,s6,0x3
    69cc:	4039d693          	srai	a3,s3,0x3
    69d0:	00a64603          	lbu	a2,10(a2)
    69d4:	000a8593          	mv	a1,s5
    69d8:	000a0513          	mv	a0,s4
    69dc:	969fc0ef          	jal	3344 <hit_cc>
    69e0:	f8050ae3          	beqz	a0,6974 <game_tick+0x4a8>
                    b->life = 0;
    69e4:	000137b7          	lui	a5,0x13
    69e8:	00141713          	slli	a4,s0,0x1
    69ec:	00870733          	add	a4,a4,s0
    69f0:	00271713          	slli	a4,a4,0x2
    69f4:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    69f8:	00e787b3          	add	a5,a5,a4
    69fc:	000785a3          	sb	zero,11(a5)
                    if (--e->hp <= 0) {
    6a00:	00012737          	lui	a4,0x12
    6a04:	00491793          	slli	a5,s2,0x4
    6a08:	2fc70713          	addi	a4,a4,764 # 122fc <g_en>
    6a0c:	00f70733          	add	a4,a4,a5
    6a10:	00871783          	lh	a5,8(a4)
    6a14:	fff78793          	addi	a5,a5,-1
    6a18:	01079793          	slli	a5,a5,0x10
    6a1c:	4107d793          	srai	a5,a5,0x10
    6a20:	00f71423          	sh	a5,8(a4)
    6a24:	f0f056e3          	blez	a5,6930 <game_tick+0x464>
    6a28:	00012b03          	lw	s6,0(sp)
    6a2c:	0140006f          	j	6a40 <game_tick+0x574>
    6a30:	01612023          	sw	s6,0(sp)
            for (k = 0; k < ENEMY_MAX; k++) {
    6a34:	00048913          	mv	s2,s1
    6a38:	f41ff06f          	j	6978 <game_tick+0x4ac>
    6a3c:	00012b03          	lw	s6,0(sp)
    for (i = 0; i < BUL_TOTAL; i++) {
    6a40:	00140413          	addi	s0,s0,1
    6a44:	000017b7          	lui	a5,0x1
    6a48:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    6a4c:	1a87ca63          	blt	a5,s0,6c00 <game_tick+0x734>
        ent_t *b = &g_bul[i];
    6a50:	00141513          	slli	a0,s0,0x1
    6a54:	00850533          	add	a0,a0,s0
    6a58:	00251513          	slli	a0,a0,0x2
    6a5c:	000137b7          	lui	a5,0x13
    6a60:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6a64:	00f50533          	add	a0,a0,a5
        if (!b->life) continue;
    6a68:	00b54783          	lbu	a5,11(a0)
    6a6c:	fc078ae3          	beqz	a5,6a40 <game_tick+0x574>
        if (!ent_step(b, 0)) continue;
    6a70:	00000593          	li	a1,0
    6a74:	831fc0ef          	jal	32a4 <ent_step>
    6a78:	fc0504e3          	beqz	a0,6a40 <game_tick+0x574>
        bx = PX(b->x); by = PX(b->y);
    6a7c:	000137b7          	lui	a5,0x13
    6a80:	00141713          	slli	a4,s0,0x1
    6a84:	00870733          	add	a4,a4,s0
    6a88:	00271713          	slli	a4,a4,0x2
    6a8c:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6a90:	00e787b3          	add	a5,a5,a4
    6a94:	00079903          	lh	s2,0(a5)
    6a98:	40395a13          	srai	s4,s2,0x3
    6a9c:	00279983          	lh	s3,2(a5)
    6aa0:	4039da93          	srai	s5,s3,0x3
        if (i < PLR_SLOTS) {                         /* 自机弹 → 打敌机 */
    6aa4:	01f00793          	li	a5,31
    6aa8:	f887d4e3          	bge	a5,s0,6a30 <game_tick+0x564>
            if (g_invuln == 0 && g_state == GS_PLAY &&
    6aac:	8981a783          	lw	a5,-1896(gp) # 8d10 <g_invuln>
    6ab0:	f80798e3          	bnez	a5,6a40 <game_tick+0x574>
    6ab4:	8a81a703          	lw	a4,-1880(gp) # 8d20 <g_state>
    6ab8:	00100793          	li	a5,1
    6abc:	f8f712e3          	bne	a4,a5,6a40 <game_tick+0x574>
                hit_cc(bx, by, (int)b->r, PX(g_px), PX(g_py), PLR_HIT_R)) {
    6ac0:	00013637          	lui	a2,0x13
    6ac4:	00141793          	slli	a5,s0,0x1
    6ac8:	008787b3          	add	a5,a5,s0
    6acc:	00279793          	slli	a5,a5,0x2
    6ad0:	8fc60613          	addi	a2,a2,-1796 # 128fc <g_bul>
    6ad4:	00f60633          	add	a2,a2,a5
    6ad8:	89c19703          	lh	a4,-1892(gp) # 8d14 <g_py>
    6adc:	89e19683          	lh	a3,-1890(gp) # 8d16 <g_px>
    6ae0:	00400793          	li	a5,4
    6ae4:	40375713          	srai	a4,a4,0x3
    6ae8:	4036d693          	srai	a3,a3,0x3
    6aec:	00a64603          	lbu	a2,10(a2)
    6af0:	000a8593          	mv	a1,s5
    6af4:	000a0513          	mv	a0,s4
    6af8:	84dfc0ef          	jal	3344 <hit_cc>
            if (g_invuln == 0 && g_state == GS_PLAY &&
    6afc:	f40502e3          	beqz	a0,6a40 <game_tick+0x574>
                b->life = 0;
    6b00:	000137b7          	lui	a5,0x13
    6b04:	00141713          	slli	a4,s0,0x1
    6b08:	00870733          	add	a4,a4,s0
    6b0c:	00271713          	slli	a4,a4,0x2
    6b10:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6b14:	00e787b3          	add	a5,a5,a4
    6b18:	000785a3          	sb	zero,11(a5)
                spark_add(b->x, b->y);
    6b1c:	00098593          	mv	a1,s3
    6b20:	00090513          	mv	a0,s2
    6b24:	834fd0ef          	jal	3b58 <spark_add>
                g_hp--;
    6b28:	8181a583          	lw	a1,-2024(gp) # 8c90 <g_hp>
    6b2c:	fff58593          	addi	a1,a1,-1
    6b30:	80b1ac23          	sw	a1,-2024(gp) # 8c90 <g_hp>
                g_invuln = INVULN_T;
    6b34:	06400713          	li	a4,100
    6b38:	88e1ac23          	sw	a4,-1896(gp) # 8d10 <g_invuln>
                bsp_printf("\r\nEV hit hp=%d\r\n", g_hp);
    6b3c:	00008537          	lui	a0,0x8
    6b40:	d4850513          	addi	a0,a0,-696 # 7d48 <_data+0xafc>
    6b44:	8d9fe0ef          	jal	541c <bsp_printf>
                if (g_hp <= 0) {
    6b48:	8181a783          	lw	a5,-2024(gp) # 8c90 <g_hp>
    6b4c:	eef04ae3          	bgtz	a5,6a40 <game_tick+0x574>
                    for (q = PLR_SLOTS; q < BUL_TOTAL; q++)
    6b50:	02000413          	li	s0,32
    6b54:	0080006f          	j	6b5c <game_tick+0x690>
    6b58:	00140413          	addi	s0,s0,1
    6b5c:	000017b7          	lui	a5,0x1
    6b60:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    6b64:	0487ca63          	blt	a5,s0,6bb8 <game_tick+0x6ec>
                        if (g_bul[q].life && (q & 7) == 0) spark_add(g_bul[q].x, g_bul[q].y);
    6b68:	000137b7          	lui	a5,0x13
    6b6c:	00141713          	slli	a4,s0,0x1
    6b70:	00870733          	add	a4,a4,s0
    6b74:	00271713          	slli	a4,a4,0x2
    6b78:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6b7c:	00e787b3          	add	a5,a5,a4
    6b80:	00b7c783          	lbu	a5,11(a5)
    6b84:	fc078ae3          	beqz	a5,6b58 <game_tick+0x68c>
    6b88:	00747793          	andi	a5,s0,7
    6b8c:	fc0796e3          	bnez	a5,6b58 <game_tick+0x68c>
    6b90:	000137b7          	lui	a5,0x13
    6b94:	00141713          	slli	a4,s0,0x1
    6b98:	00870733          	add	a4,a4,s0
    6b9c:	00271713          	slli	a4,a4,0x2
    6ba0:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6ba4:	00e787b3          	add	a5,a5,a4
    6ba8:	00279583          	lh	a1,2(a5)
    6bac:	00079503          	lh	a0,0(a5)
    6bb0:	fa9fc0ef          	jal	3b58 <spark_add>
    6bb4:	fa5ff06f          	j	6b58 <game_tick+0x68c>
                    g_state = GS_OVER;
    6bb8:	00200713          	li	a4,2
    6bbc:	8ae1a423          	sw	a4,-1880(gp) # 8d20 <g_state>
                    bsp_printf("\r\nEV gameover score=%d level=%d on=%d n=%d\r\n",
    6bc0:	81c1a703          	lw	a4,-2020(gp) # 8c94 <g_ncap>
    6bc4:	85c1a683          	lw	a3,-1956(gp) # 8cd4 <g_on_screen>
    6bc8:	8101a603          	lw	a2,-2032(gp) # 8c88 <g_level>
    6bcc:	8941a583          	lw	a1,-1900(gp) # 8d0c <g_score>
    6bd0:	00008537          	lui	a0,0x8
    6bd4:	d5c50513          	addi	a0,a0,-676 # 7d5c <_data+0xb10>
    6bd8:	845fe0ef          	jal	541c <bsp_printf>
                    return;
    6bdc:	01812403          	lw	s0,24(sp)
    6be0:	01412483          	lw	s1,20(sp)
    6be4:	01012903          	lw	s2,16(sp)
    6be8:	00c12983          	lw	s3,12(sp)
    6bec:	00812a03          	lw	s4,8(sp)
    6bf0:	00412a83          	lw	s5,4(sp)
    6bf4:	95dff06f          	j	6550 <game_tick+0x84>
    6bf8:	00012b03          	lw	s6,0(sp)
    6bfc:	e45ff06f          	j	6a40 <game_tick+0x574>
    for (i = 0; i < SPARK_MAX; i++) if (g_spk[i].life) g_spk[i].life--;
    6c00:	00048793          	mv	a5,s1
    6c04:	0080006f          	j	6c0c <game_tick+0x740>
    6c08:	00178793          	addi	a5,a5,1
    6c0c:	05f00713          	li	a4,95
    6c10:	04f74463          	blt	a4,a5,6c58 <game_tick+0x78c>
    6c14:	00012737          	lui	a4,0x12
    6c18:	00179693          	slli	a3,a5,0x1
    6c1c:	00f686b3          	add	a3,a3,a5
    6c20:	00269693          	slli	a3,a3,0x2
    6c24:	47c70713          	addi	a4,a4,1148 # 1247c <g_spk>
    6c28:	00d70733          	add	a4,a4,a3
    6c2c:	00b74703          	lbu	a4,11(a4)
    6c30:	fc070ce3          	beqz	a4,6c08 <game_tick+0x73c>
    6c34:	000126b7          	lui	a3,0x12
    6c38:	00179613          	slli	a2,a5,0x1
    6c3c:	00f60633          	add	a2,a2,a5
    6c40:	00261613          	slli	a2,a2,0x2
    6c44:	47c68693          	addi	a3,a3,1148 # 1247c <g_spk>
    6c48:	00c686b3          	add	a3,a3,a2
    6c4c:	fff70713          	addi	a4,a4,-1
    6c50:	00e685a3          	sb	a4,11(a3)
    6c54:	fb5ff06f          	j	6c08 <game_tick+0x73c>
        int live = 0;
    6c58:	00048613          	mv	a2,s1
        for (i = PLR_SLOTS; i < BUL_TOTAL; i++) if (g_bul[i].life) live++;
    6c5c:	02000693          	li	a3,32
    6c60:	0080006f          	j	6c68 <game_tick+0x79c>
    6c64:	00168693          	addi	a3,a3,1
    6c68:	000017b7          	lui	a5,0x1
    6c6c:	97f78793          	addi	a5,a5,-1665 # 97f <CUSTOM2+0x924>
    6c70:	02d7c663          	blt	a5,a3,6c9c <game_tick+0x7d0>
    6c74:	000137b7          	lui	a5,0x13
    6c78:	00169713          	slli	a4,a3,0x1
    6c7c:	00d70733          	add	a4,a4,a3
    6c80:	00271713          	slli	a4,a4,0x2
    6c84:	8fc78793          	addi	a5,a5,-1796 # 128fc <g_bul>
    6c88:	00e787b3          	add	a5,a5,a4
    6c8c:	00b7c783          	lbu	a5,11(a5)
    6c90:	fc078ae3          	beqz	a5,6c64 <game_tick+0x798>
    6c94:	00160613          	addi	a2,a2,1
    6c98:	fcdff06f          	j	6c64 <game_tick+0x798>
        g_bul_live = live;
    6c9c:	84c1aa23          	sw	a2,-1964(gp) # 8ccc <g_bul_live>
    for (i = 0; i < g_star_n; i++) {
    6ca0:	0080006f          	j	6ca8 <game_tick+0x7dc>
    6ca4:	00148493          	addi	s1,s1,1
    6ca8:	8241a783          	lw	a5,-2012(gp) # 8c9c <g_star_n>
    6cac:	06f4d063          	bge	s1,a5,6d0c <game_tick+0x840>
        g_star[i].y = (int16_t)(g_star[i].y + (int)g_star[i].spd);
    6cb0:	000097b7          	lui	a5,0x9
    6cb4:	00349713          	slli	a4,s1,0x3
    6cb8:	dbc78793          	addi	a5,a5,-580 # 8dbc <g_star>
    6cbc:	00e787b3          	add	a5,a5,a4
    6cc0:	0027d703          	lhu	a4,2(a5)
    6cc4:	0067c683          	lbu	a3,6(a5)
    6cc8:	00d70733          	add	a4,a4,a3
    6ccc:	01071713          	slli	a4,a4,0x10
    6cd0:	41075713          	srai	a4,a4,0x10
    6cd4:	00e79123          	sh	a4,2(a5)
        if (g_star[i].y > PLAY_Y1) {
    6cd8:	21c00793          	li	a5,540
    6cdc:	fce7d4e3          	bge	a5,a4,6ca4 <game_tick+0x7d8>
            g_star[i].y = (int16_t)PLAY_Y0;
    6ce0:	00009437          	lui	s0,0x9
    6ce4:	00349793          	slli	a5,s1,0x3
    6ce8:	dbc40413          	addi	s0,s0,-580 # 8dbc <g_star>
    6cec:	00f40433          	add	s0,s0,a5
    6cf0:	01000793          	li	a5,16
    6cf4:	00f41123          	sh	a5,2(s0)
            g_star[i].x = (int16_t)(rnd() % PLAY_W);
    6cf8:	954fc0ef          	jal	2e4c <rnd>
    6cfc:	30000793          	li	a5,768
    6d00:	02f57533          	remu	a0,a0,a5
    6d04:	00a41023          	sh	a0,0(s0)
    6d08:	f9dff06f          	j	6ca4 <game_tick+0x7d8>
    6d0c:	01812403          	lw	s0,24(sp)
    6d10:	01412483          	lw	s1,20(sp)
    6d14:	01012903          	lw	s2,16(sp)
    6d18:	00c12983          	lw	s3,12(sp)
    6d1c:	00812a03          	lw	s4,8(sp)
    6d20:	00412a83          	lw	s5,4(sp)
    6d24:	82dff06f          	j	6550 <game_tick+0x84>

00006d28 <blt_recover>:
{
    6d28:	ff010113          	addi	sp,sp,-16
    6d2c:	00112623          	sw	ra,12(sp)
    6d30:	00812423          	sw	s0,8(sp)
    6d34:	00912223          	sw	s1,4(sp)
    6d38:	00050413          	mv	s0,a0
    g_stto++;
    6d3c:	8cc1a783          	lw	a5,-1844(gp) # 8d44 <g_stto>
    6d40:	00178793          	addi	a5,a5,1
    6d44:	8cf1a623          	sw	a5,-1844(gp) # 8d44 <g_stto>
               why, (unsigned)blt_stat(), (unsigned)blt_cnt());
    6d48:	ca5fb0ef          	jal	29ec <blt_stat>
    6d4c:	00050493          	mv	s1,a0
    6d50:	c81fb0ef          	jal	29d0 <blt_cnt>
    6d54:	00050693          	mv	a3,a0
    bsp_printf("\r\nEV recover (%s) STATUS=%x COUNT=%d\r\n",
    6d58:	00048613          	mv	a2,s1
    6d5c:	00040593          	mv	a1,s0
    6d60:	00008537          	lui	a0,0x8
    6d64:	d8c50513          	addi	a0,a0,-628 # 7d8c <_data+0xb40>
    6d68:	eb4fe0ef          	jal	541c <bsp_printf>
    blt_init();
    6d6c:	cddfb0ef          	jal	2a48 <blt_init>
    g_clr_need = 1;
    6d70:	00100713          	li	a4,1
    6d74:	8ee1a023          	sw	a4,-1824(gp) # 8d58 <g_clr_need>
    g_dl_i = 0;
    6d78:	8a01a823          	sw	zero,-1872(gp) # 8d28 <g_dl_i>
    g_clr_fb++;
    6d7c:	8d81a783          	lw	a5,-1832(gp) # 8d50 <g_clr_fb>
    6d80:	00178793          	addi	a5,a5,1
    6d84:	8cf1ac23          	sw	a5,-1832(gp) # 8d50 <g_clr_fb>
}
    6d88:	00c12083          	lw	ra,12(sp)
    6d8c:	00812403          	lw	s0,8(sp)
    6d90:	00412483          	lw	s1,4(sp)
    6d94:	01010113          	addi	sp,sp,16
    6d98:	00008067          	ret

00006d9c <__udivdi3>:
    6d9c:	00060813          	mv	a6,a2
    6da0:	00050893          	mv	a7,a0
    6da4:	00058713          	mv	a4,a1
    6da8:	0e069063          	bnez	a3,6e88 <__udivdi3+0xec>
    6dac:	12c5fe63          	bgeu	a1,a2,6ee8 <__udivdi3+0x14c>
    6db0:	000107b7          	lui	a5,0x10
    6db4:	1ef66e63          	bltu	a2,a5,6fb0 <__udivdi3+0x214>
    6db8:	010007b7          	lui	a5,0x1000
    6dbc:	01800693          	li	a3,24
    6dc0:	00f67463          	bgeu	a2,a5,6dc8 <__udivdi3+0x2c>
    6dc4:	01000693          	li	a3,16
    6dc8:	00d65333          	srl	t1,a2,a3
    6dcc:	00002797          	auipc	a5,0x2
    6dd0:	db878793          	addi	a5,a5,-584 # 8b84 <__clz_tab>
    6dd4:	006787b3          	add	a5,a5,t1
    6dd8:	0007c783          	lbu	a5,0(a5)
    6ddc:	02000313          	li	t1,32
    6de0:	00d787b3          	add	a5,a5,a3
    6de4:	40f306b3          	sub	a3,t1,a5
    6de8:	00f30c63          	beq	t1,a5,6e00 <__udivdi3+0x64>
    6dec:	00d59733          	sll	a4,a1,a3
    6df0:	00f557b3          	srl	a5,a0,a5
    6df4:	00d61833          	sll	a6,a2,a3
    6df8:	00e7e733          	or	a4,a5,a4
    6dfc:	00d518b3          	sll	a7,a0,a3
    6e00:	01085613          	srli	a2,a6,0x10
    6e04:	02c75533          	divu	a0,a4,a2
    6e08:	01081693          	slli	a3,a6,0x10
    6e0c:	0106d693          	srli	a3,a3,0x10
    6e10:	0108d793          	srli	a5,a7,0x10
    6e14:	02c77733          	remu	a4,a4,a2
    6e18:	02a685b3          	mul	a1,a3,a0
    6e1c:	01071713          	slli	a4,a4,0x10
    6e20:	00e7e7b3          	or	a5,a5,a4
    6e24:	00b7fc63          	bgeu	a5,a1,6e3c <__udivdi3+0xa0>
    6e28:	00f807b3          	add	a5,a6,a5
    6e2c:	fff50713          	addi	a4,a0,-1
    6e30:	0107e463          	bltu	a5,a6,6e38 <__udivdi3+0x9c>
    6e34:	40b7e063          	bltu	a5,a1,7234 <__udivdi3+0x498>
    6e38:	00070513          	mv	a0,a4
    6e3c:	40b787b3          	sub	a5,a5,a1
    6e40:	02c7d733          	divu	a4,a5,a2
    6e44:	01089893          	slli	a7,a7,0x10
    6e48:	0108d893          	srli	a7,a7,0x10
    6e4c:	02c7f7b3          	remu	a5,a5,a2
    6e50:	02e686b3          	mul	a3,a3,a4
    6e54:	01079793          	slli	a5,a5,0x10
    6e58:	00f8e8b3          	or	a7,a7,a5
    6e5c:	00d8fe63          	bgeu	a7,a3,6e78 <__udivdi3+0xdc>
    6e60:	011808b3          	add	a7,a6,a7
    6e64:	fff70793          	addi	a5,a4,-1
    6e68:	0108e663          	bltu	a7,a6,6e74 <__udivdi3+0xd8>
    6e6c:	ffe70713          	addi	a4,a4,-2
    6e70:	00d8e463          	bltu	a7,a3,6e78 <__udivdi3+0xdc>
    6e74:	00078713          	mv	a4,a5
    6e78:	01051513          	slli	a0,a0,0x10
    6e7c:	00e56533          	or	a0,a0,a4
    6e80:	00000593          	li	a1,0
    6e84:	00008067          	ret
    6e88:	00d5f863          	bgeu	a1,a3,6e98 <__udivdi3+0xfc>
    6e8c:	00000593          	li	a1,0
    6e90:	00000513          	li	a0,0
    6e94:	00008067          	ret
    6e98:	000107b7          	lui	a5,0x10
    6e9c:	1ef6e863          	bltu	a3,a5,708c <__udivdi3+0x2f0>
    6ea0:	01000737          	lui	a4,0x1000
    6ea4:	01800793          	li	a5,24
    6ea8:	00e6f463          	bgeu	a3,a4,6eb0 <__udivdi3+0x114>
    6eac:	01000793          	li	a5,16
    6eb0:	00f6d833          	srl	a6,a3,a5
    6eb4:	00002717          	auipc	a4,0x2
    6eb8:	cd070713          	addi	a4,a4,-816 # 8b84 <__clz_tab>
    6ebc:	01070733          	add	a4,a4,a6
    6ec0:	00074703          	lbu	a4,0(a4)
    6ec4:	02000893          	li	a7,32
    6ec8:	00f70733          	add	a4,a4,a5
    6ecc:	40e88833          	sub	a6,a7,a4
    6ed0:	1ee89663          	bne	a7,a4,70bc <__udivdi3+0x320>
    6ed4:	32b6e463          	bltu	a3,a1,71fc <__udivdi3+0x460>
    6ed8:	00c53533          	sltu	a0,a0,a2
    6edc:	00153513          	seqz	a0,a0
    6ee0:	00000593          	li	a1,0
    6ee4:	00008067          	ret
    6ee8:	0c060c63          	beqz	a2,6fc0 <__udivdi3+0x224>
    6eec:	000107b7          	lui	a5,0x10
    6ef0:	2ef67c63          	bgeu	a2,a5,71e8 <__udivdi3+0x44c>
    6ef4:	10063713          	sltiu	a4,a2,256
    6ef8:	00173713          	seqz	a4,a4
    6efc:	00371713          	slli	a4,a4,0x3
    6f00:	00e656b3          	srl	a3,a2,a4
    6f04:	00002797          	auipc	a5,0x2
    6f08:	c8078793          	addi	a5,a5,-896 # 8b84 <__clz_tab>
    6f0c:	00d787b3          	add	a5,a5,a3
    6f10:	0007c783          	lbu	a5,0(a5)
    6f14:	02000693          	li	a3,32
    6f18:	00e787b3          	add	a5,a5,a4
    6f1c:	40f68eb3          	sub	t4,a3,a5
    6f20:	0cf69463          	bne	a3,a5,6fe8 <__udivdi3+0x24c>
    6f24:	40c587b3          	sub	a5,a1,a2
    6f28:	01065693          	srli	a3,a2,0x10
    6f2c:	01061613          	slli	a2,a2,0x10
    6f30:	01065613          	srli	a2,a2,0x10
    6f34:	00100593          	li	a1,1
    6f38:	02d7d533          	divu	a0,a5,a3
    6f3c:	0108d713          	srli	a4,a7,0x10
    6f40:	02d7f7b3          	remu	a5,a5,a3
    6f44:	02c50333          	mul	t1,a0,a2
    6f48:	01079793          	slli	a5,a5,0x10
    6f4c:	00f767b3          	or	a5,a4,a5
    6f50:	0067fc63          	bgeu	a5,t1,6f68 <__udivdi3+0x1cc>
    6f54:	00f807b3          	add	a5,a6,a5
    6f58:	fff50713          	addi	a4,a0,-1
    6f5c:	0107e463          	bltu	a5,a6,6f64 <__udivdi3+0x1c8>
    6f60:	2c67e463          	bltu	a5,t1,7228 <__udivdi3+0x48c>
    6f64:	00070513          	mv	a0,a4
    6f68:	406787b3          	sub	a5,a5,t1
    6f6c:	02d7d733          	divu	a4,a5,a3
    6f70:	01089893          	slli	a7,a7,0x10
    6f74:	0108d893          	srli	a7,a7,0x10
    6f78:	02d7f7b3          	remu	a5,a5,a3
    6f7c:	02c70633          	mul	a2,a4,a2
    6f80:	01079793          	slli	a5,a5,0x10
    6f84:	00f8e8b3          	or	a7,a7,a5
    6f88:	00c8fe63          	bgeu	a7,a2,6fa4 <__udivdi3+0x208>
    6f8c:	011808b3          	add	a7,a6,a7
    6f90:	fff70793          	addi	a5,a4,-1
    6f94:	0108e663          	bltu	a7,a6,6fa0 <__udivdi3+0x204>
    6f98:	ffe70713          	addi	a4,a4,-2
    6f9c:	00c8e463          	bltu	a7,a2,6fa4 <__udivdi3+0x208>
    6fa0:	00078713          	mv	a4,a5
    6fa4:	01051513          	slli	a0,a0,0x10
    6fa8:	00e56533          	or	a0,a0,a4
    6fac:	00008067          	ret
    6fb0:	10063693          	sltiu	a3,a2,256
    6fb4:	0016b693          	seqz	a3,a3
    6fb8:	00369693          	slli	a3,a3,0x3
    6fbc:	e0dff06f          	j	6dc8 <__udivdi3+0x2c>
    6fc0:	00000693          	li	a3,0
    6fc4:	00002797          	auipc	a5,0x2
    6fc8:	bc078793          	addi	a5,a5,-1088 # 8b84 <__clz_tab>
    6fcc:	00d787b3          	add	a5,a5,a3
    6fd0:	0007c783          	lbu	a5,0(a5)
    6fd4:	00000713          	li	a4,0
    6fd8:	02000693          	li	a3,32
    6fdc:	00e787b3          	add	a5,a5,a4
    6fe0:	40f68eb3          	sub	t4,a3,a5
    6fe4:	f4f680e3          	beq	a3,a5,6f24 <__udivdi3+0x188>
    6fe8:	01d61833          	sll	a6,a2,t4
    6fec:	00f5d333          	srl	t1,a1,a5
    6ff0:	01085693          	srli	a3,a6,0x10
    6ff4:	02d35e33          	divu	t3,t1,a3
    6ff8:	01081613          	slli	a2,a6,0x10
    6ffc:	01d595b3          	sll	a1,a1,t4
    7000:	01065613          	srli	a2,a2,0x10
    7004:	00f557b3          	srl	a5,a0,a5
    7008:	00b7e7b3          	or	a5,a5,a1
    700c:	0107d713          	srli	a4,a5,0x10
    7010:	01d518b3          	sll	a7,a0,t4
    7014:	02d37333          	remu	t1,t1,a3
    7018:	03c605b3          	mul	a1,a2,t3
    701c:	01031313          	slli	t1,t1,0x10
    7020:	00676733          	or	a4,a4,t1
    7024:	00b77e63          	bgeu	a4,a1,7040 <__udivdi3+0x2a4>
    7028:	00e80733          	add	a4,a6,a4
    702c:	fffe0513          	addi	a0,t3,-1
    7030:	1f076463          	bltu	a4,a6,7218 <__udivdi3+0x47c>
    7034:	1eb77263          	bgeu	a4,a1,7218 <__udivdi3+0x47c>
    7038:	ffee0e13          	addi	t3,t3,-2
    703c:	01070733          	add	a4,a4,a6
    7040:	40b70733          	sub	a4,a4,a1
    7044:	02d75533          	divu	a0,a4,a3
    7048:	01079793          	slli	a5,a5,0x10
    704c:	0107d793          	srli	a5,a5,0x10
    7050:	02d77733          	remu	a4,a4,a3
    7054:	02a60333          	mul	t1,a2,a0
    7058:	01071713          	slli	a4,a4,0x10
    705c:	00e7e7b3          	or	a5,a5,a4
    7060:	0067fe63          	bgeu	a5,t1,707c <__udivdi3+0x2e0>
    7064:	00f807b3          	add	a5,a6,a5
    7068:	fff50713          	addi	a4,a0,-1
    706c:	1907ee63          	bltu	a5,a6,7208 <__udivdi3+0x46c>
    7070:	1867fc63          	bgeu	a5,t1,7208 <__udivdi3+0x46c>
    7074:	ffe50513          	addi	a0,a0,-2
    7078:	010787b3          	add	a5,a5,a6
    707c:	010e1593          	slli	a1,t3,0x10
    7080:	406787b3          	sub	a5,a5,t1
    7084:	00a5e5b3          	or	a1,a1,a0
    7088:	eb1ff06f          	j	6f38 <__udivdi3+0x19c>
    708c:	1006b793          	sltiu	a5,a3,256
    7090:	0017b793          	seqz	a5,a5
    7094:	00379793          	slli	a5,a5,0x3
    7098:	00f6d833          	srl	a6,a3,a5
    709c:	00002717          	auipc	a4,0x2
    70a0:	ae870713          	addi	a4,a4,-1304 # 8b84 <__clz_tab>
    70a4:	01070733          	add	a4,a4,a6
    70a8:	00074703          	lbu	a4,0(a4)
    70ac:	02000893          	li	a7,32
    70b0:	00f70733          	add	a4,a4,a5
    70b4:	40e88833          	sub	a6,a7,a4
    70b8:	e0e88ee3          	beq	a7,a4,6ed4 <__udivdi3+0x138>
    70bc:	00e65e33          	srl	t3,a2,a4
    70c0:	010696b3          	sll	a3,a3,a6
    70c4:	00de6e33          	or	t3,t3,a3
    70c8:	00e5d8b3          	srl	a7,a1,a4
    70cc:	010e5e93          	srli	t4,t3,0x10
    70d0:	03d8d7b3          	divu	a5,a7,t4
    70d4:	010e1313          	slli	t1,t3,0x10
    70d8:	010595b3          	sll	a1,a1,a6
    70dc:	01035313          	srli	t1,t1,0x10
    70e0:	00e55733          	srl	a4,a0,a4
    70e4:	00b76733          	or	a4,a4,a1
    70e8:	01075693          	srli	a3,a4,0x10
    70ec:	01061633          	sll	a2,a2,a6
    70f0:	03d8f8b3          	remu	a7,a7,t4
    70f4:	02f305b3          	mul	a1,t1,a5
    70f8:	01089893          	slli	a7,a7,0x10
    70fc:	0116e6b3          	or	a3,a3,a7
    7100:	00b6fe63          	bgeu	a3,a1,711c <__udivdi3+0x380>
    7104:	00de06b3          	add	a3,t3,a3
    7108:	fff78893          	addi	a7,a5,-1
    710c:	11c6ea63          	bltu	a3,t3,7220 <__udivdi3+0x484>
    7110:	10b6f863          	bgeu	a3,a1,7220 <__udivdi3+0x484>
    7114:	ffe78793          	addi	a5,a5,-2
    7118:	01c686b3          	add	a3,a3,t3
    711c:	40b686b3          	sub	a3,a3,a1
    7120:	03d6d5b3          	divu	a1,a3,t4
    7124:	01071713          	slli	a4,a4,0x10
    7128:	01075713          	srli	a4,a4,0x10
    712c:	03d6f6b3          	remu	a3,a3,t4
    7130:	02b308b3          	mul	a7,t1,a1
    7134:	01069693          	slli	a3,a3,0x10
    7138:	00d76733          	or	a4,a4,a3
    713c:	01177e63          	bgeu	a4,a7,7158 <__udivdi3+0x3bc>
    7140:	00ee0733          	add	a4,t3,a4
    7144:	fff58693          	addi	a3,a1,-1
    7148:	0dc76463          	bltu	a4,t3,7210 <__udivdi3+0x474>
    714c:	0d177263          	bgeu	a4,a7,7210 <__udivdi3+0x474>
    7150:	ffe58593          	addi	a1,a1,-2
    7154:	01c70733          	add	a4,a4,t3
    7158:	01079793          	slli	a5,a5,0x10
    715c:	00010eb7          	lui	t4,0x10
    7160:	00b7e7b3          	or	a5,a5,a1
    7164:	fffe8693          	addi	a3,t4,-1 # ffff <__global_pointer$+0x6b87>
    7168:	00d7f5b3          	and	a1,a5,a3
    716c:	0107d313          	srli	t1,a5,0x10
    7170:	00d676b3          	and	a3,a2,a3
    7174:	01065613          	srli	a2,a2,0x10
    7178:	02d58e33          	mul	t3,a1,a3
    717c:	41170733          	sub	a4,a4,a7
    7180:	02d306b3          	mul	a3,t1,a3
    7184:	010e5893          	srli	a7,t3,0x10
    7188:	02c585b3          	mul	a1,a1,a2
    718c:	00d585b3          	add	a1,a1,a3
    7190:	00b885b3          	add	a1,a7,a1
    7194:	02c30333          	mul	t1,t1,a2
    7198:	00d5f463          	bgeu	a1,a3,71a0 <__udivdi3+0x404>
    719c:	01d30333          	add	t1,t1,t4
    71a0:	0105d693          	srli	a3,a1,0x10
    71a4:	006686b3          	add	a3,a3,t1
    71a8:	02d76a63          	bltu	a4,a3,71dc <__udivdi3+0x440>
    71ac:	00d70863          	beq	a4,a3,71bc <__udivdi3+0x420>
    71b0:	00078513          	mv	a0,a5
    71b4:	00000593          	li	a1,0
    71b8:	00008067          	ret
    71bc:	000106b7          	lui	a3,0x10
    71c0:	fff68693          	addi	a3,a3,-1 # ffff <__global_pointer$+0x6b87>
    71c4:	00d5f733          	and	a4,a1,a3
    71c8:	01071713          	slli	a4,a4,0x10
    71cc:	00de7e33          	and	t3,t3,a3
    71d0:	01051533          	sll	a0,a0,a6
    71d4:	01c70733          	add	a4,a4,t3
    71d8:	fce57ce3          	bgeu	a0,a4,71b0 <__udivdi3+0x414>
    71dc:	fff78513          	addi	a0,a5,-1
    71e0:	00000593          	li	a1,0
    71e4:	00008067          	ret
    71e8:	010007b7          	lui	a5,0x1000
    71ec:	04f67a63          	bgeu	a2,a5,7240 <__udivdi3+0x4a4>
    71f0:	01065693          	srli	a3,a2,0x10
    71f4:	01000713          	li	a4,16
    71f8:	d0dff06f          	j	6f04 <__udivdi3+0x168>
    71fc:	00000593          	li	a1,0
    7200:	00100513          	li	a0,1
    7204:	00008067          	ret
    7208:	00070513          	mv	a0,a4
    720c:	e71ff06f          	j	707c <__udivdi3+0x2e0>
    7210:	00068593          	mv	a1,a3
    7214:	f45ff06f          	j	7158 <__udivdi3+0x3bc>
    7218:	00050e13          	mv	t3,a0
    721c:	e25ff06f          	j	7040 <__udivdi3+0x2a4>
    7220:	00088793          	mv	a5,a7
    7224:	ef9ff06f          	j	711c <__udivdi3+0x380>
    7228:	ffe50513          	addi	a0,a0,-2
    722c:	010787b3          	add	a5,a5,a6
    7230:	d39ff06f          	j	6f68 <__udivdi3+0x1cc>
    7234:	ffe50513          	addi	a0,a0,-2
    7238:	010787b3          	add	a5,a5,a6
    723c:	c01ff06f          	j	6e3c <__udivdi3+0xa0>
    7240:	01865693          	srli	a3,a2,0x18
    7244:	01800713          	li	a4,24
    7248:	cbdff06f          	j	6f04 <__udivdi3+0x168>
