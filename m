Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604EB3DD06F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhHBGXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:23:17 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:30952 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhHBGXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:23:14 -0400
X-QQ-mid: bizesmtp41t1627885373tao3kngl
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:51 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: uPKj8ga2w7E20dMsD3+/96w4c/h3ZOqSYyJmU+T7WrYuyJcdQRfYQwjVaUSPx
        Gdl3aykWwGUnC/1nigLruO7ZAtvsSj17fsoNkOki40QNtlUu/2Kt+beq7skwurxhR3TA3YU
        ff9qnvTi3rRzqKaanx4fYfEKe4XE4N4Z7E3d/6LBiBN6ew6cq7FDU1jax/DzcK0Q1Dvdh+f
        WIMMrxZhHk4QnjvCKJDsbLR2xc3Se4z5AmvrPogprvtmSZXapswCpN8/SjTkurgqDoWnpvs
        1p1BNyhaDeCWy4OEhBWHRn/OaXbcfSw/wo+IeuobMO1Li4ZpGNTErJQdADei0FA3RrMELrJ
        ZIxR6kETUSEl9FWDxg=
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 10/17] clk: sunxi=ng: add support for R329 R-CCU
Date:   Mon,  2 Aug 2021 14:22:05 +0800
Message-Id: <20210802062212.73220-11-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 has clock controls in PRCM, like other new Allwinner
SoCs.

Add support for them.

This driver is added before the main CCU because PLLs are controlled by
R-CCU on R329.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c      | 374 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h      |  33 ++
 include/dt-bindings/clock/sun50i-r329-r-ccu.h |  33 ++
 include/dt-bindings/reset/sun50i-r329-r-ccu.h |  24 ++
 6 files changed, 470 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
 create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index cd46d8853876..e49b2c2fa5b7 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -42,6 +42,11 @@ config SUN50I_H6_R_CCU
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
+config SUN50I_R329_R_CCU
+	bool "Support for the Allwinner R329 PRCM CCU"
+	default ARM64 && ARCH_SUNXI
+	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+
 config SUN4I_A10_CCU
 	bool "Support for the Allwinner A10/A20 CCU"
 	default MACH_SUN4I
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 96c324306d97..db338a2188fd 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+= ccu-sun50i-a100-r.o
 obj-$(CONFIG_SUN50I_H6_CCU)	+= ccu-sun50i-h6.o
 obj-$(CONFIG_SUN50I_H616_CCU)	+= ccu-sun50i-h616.o
 obj-$(CONFIG_SUN50I_H6_R_CCU)	+= ccu-sun50i-h6-r.o
+obj-$(CONFIG_SUN50I_R329_R_CCU)	+= ccu-sun50i-r329-r.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= ccu-sun4i-a10.o
 obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
new file mode 100644
index 000000000000..5413a701cb57
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Sipeed
+ * Based on the H616 CCU driver, which is:
+ *   Copyright (c) 2020 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun50i-r329-r.h"
+
+/*
+ * The M factor is present in the register's description, but not in the
+ * frequency formula, and it's documented as "The bit is only for
+ * testing", so it's not modelled and then force to 0.
+ */
+#define SUN50I_R329_PLL_CPUX_REG	0x1000
+static struct ccu_mult pll_cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.mult		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.common		= {
+		.reg		= 0x1000,
+		.hw.init	= CLK_HW_INIT("pll-cpux", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+#define SUN50I_R329_PLL_PERIPH_REG	0x1010
+static struct ccu_nm pll_periph_base_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x1010,
+		.hw.init	= CLK_HW_INIT("pll-periph-base", "osc24M",
+					      &ccu_nm_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static SUNXI_CCU_M(pll_periph_2x_clk, "pll-periph-2x", "pll-periph-base",
+		   0x1010, 16, 3, 0);
+static SUNXI_CCU_M(pll_periph_800m_clk, "pll-periph-800m", "pll-periph-base",
+		   0x1010, 20, 3, 0);
+static CLK_FIXED_FACTOR_HW(pll_periph_clk, "pll-periph",
+			   &pll_periph_2x_clk.common.hw, 2, 1, 0);
+
+#define SUN50I_R329_PLL_AUDIO0_REG	0x1020
+static struct ccu_sdm_setting pll_audio0_sdm_table[] = {
+	{ .rate = 1548288000, .pattern = 0xc0070624, .m = 1, .n = 64 },
+};
+
+static struct ccu_nm pll_audio0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1),
+	.sdm		= _SUNXI_CCU_SDM(pll_audio0_sdm_table,
+					 BIT(24), 0x1120, BIT(31)),
+	.common		= {
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.reg		= 0x1020,
+		.hw.init	= CLK_HW_INIT("pll-audio0", "osc24M",
+					      &ccu_nm_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static SUNXI_CCU_M(pll_audio0_div2_clk, "pll-audio0-div2", "pll-audio0",
+		   0x1020, 16, 3, 0);
+static SUNXI_CCU_M(pll_audio0_div5_clk, "pll-audio0-div5", "pll-audio0",
+		   0x1020, 20, 3, 0);
+
+/*
+ * PLL-AUDIO1 has 3 dividers defined in the datasheet, however the
+ * BSP driver always has M0 = 1 and M1 = 2 (this is also the
+ * reset value in the register).
+ *
+ * Here just module it as NM clock, and force M0 = 1 and M1 = 2.
+ */
+#define SUN50I_R329_PLL_AUDIO1_REG	0x1030
+static struct ccu_sdm_setting pll_audio1_4x_sdm_table[] = {
+	{ .rate = 22579200, .pattern = 0xc001288d, .m = 12, .n = 22 },
+	{ .rate = 24576000, .pattern = 0xc00126e9, .m = 12, .n = 24 },
+	{ .rate = 90316800, .pattern = 0xc001288d, .m = 3, .n = 22 },
+	{ .rate = 98304000, .pattern = 0xc00126e9, .m = 3, .n = 24 },
+};
+static struct ccu_nm pll_audio1_4x_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(16, 6),
+	.fixed_post_div	= 2,
+	.sdm		= _SUNXI_CCU_SDM(pll_audio1_4x_sdm_table,
+					 BIT(24), 0x1130, BIT(31)),
+	.common		= {
+		.features	= CCU_FEATURE_FIXED_POSTDIV |
+				  CCU_FEATURE_SIGMA_DELTA_MOD,
+		.reg		= 0x1030,
+		.hw.init	= CLK_HW_INIT("pll-audio1-4x", "osc24M",
+					      &ccu_nm_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static CLK_FIXED_FACTOR_HW(pll_audio1_2x_clk, "pll-audio1-2x",
+			   &pll_audio1_4x_clk.common.hw, 2, 1,
+			   CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HW(pll_audio1_clk, "pll-audio1",
+			   &pll_audio1_4x_clk.common.hw, 4, 1,
+			   CLK_SET_RATE_PARENT);
+
+static const char * const r_bus_parents[] = { "osc24M", "osc32k", "iosc",
+					      "pll-periph-2x",
+					      "pll-audio0-div2" };
+static SUNXI_CCU_MP_WITH_MUX(r_ahb_clk, "r-ahb", r_bus_parents, 0x000,
+			     0, 5,	/* M */
+			     8, 2,	/* P */
+			     24, 3,	/* mux */
+			     0);
+
+static SUNXI_CCU_MP_WITH_MUX(r_apb1_clk, "r-apb1", r_bus_parents, 0x00c,
+			     0, 5,	/* M */
+			     8, 2,	/* P */
+			     24, 3,	/* mux */
+			     0);
+
+static SUNXI_CCU_MP_WITH_MUX(r_apb2_clk, "r-apb2", r_bus_parents, 0x010,
+			     0, 5,	/* M */
+			     8, 2,	/* P */
+			     24, 3,	/* mux */
+			     0);
+
+static SUNXI_CCU_GATE(r_bus_gpadc_clk, "r-bus-gpadc", "r-apb1",
+		      0x0ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_ths_clk, "r-bus-ths", "r-apb1", 0x0fc, BIT(0), 0);
+
+static SUNXI_CCU_GATE(r_bus_dma_clk, "r-bus-dma", "r-apb1", 0x10c, BIT(0), 0);
+
+static const char * const r_pwm_parents[] = { "osc24M", "osc32k", "iosc" };
+static SUNXI_CCU_MUX_WITH_GATE(r_pwm_clk, "r-pwm", r_pwm_parents, 0x130,
+			       24, 3,	/* mux */
+			       BIT(31),	/* gate */
+			       0);
+
+static SUNXI_CCU_GATE(r_bus_pwm_clk, "r-bus-pwm", "r-apb1", 0x13c, BIT(0), 0);
+
+static const char * const r_audio_parents[] = { "pll-audio0-div5", "pll-audio0-div2",
+						"pll-audio1-1x", "pll-audio1-4x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_codec_adc_clk, "r-codec-adc", r_audio_parents, 0x140,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_codec_dac_clk, "r-codec-dac", r_audio_parents, 0x144,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_codec_clk, "r-bus-codec", "r-apb1",
+		      0x14c, BIT(0), 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_dmic_clk, "r-dmic", r_audio_parents, 0x150,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_dmic_clk, "r-bus-dmic", "r-apb1", 0x15c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_lradc_clk, "r-bus-lradc", "r-apb1",
+		      0x16c, BIT(0), 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_i2s_clk, "r-i2s", r_audio_parents, 0x170,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_i2s_asrc_clk, "r-i2s-asrc",
+				  r_audio_parents, 0x174,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_GATE(r_bus_i2s_clk, "r-bus-i2s", "r-apb1", 0x17c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_uart_clk, "r-bus-uart", "r-apb2", 0x18c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_i2c_clk, "r-bus-i2c", "r-apb2", 0x19c, BIT(0), 0);
+
+static const char * const r_ir_parents[] = { "osc32k", "osc24M" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_ir_clk, "r-ir", r_ir_parents, 0x1c0,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_ir_clk, "r-bus-ir", "r-apb1", 0x1cc, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_msgbox_clk, "r-bus-msgbox", "r-apb1",
+		      0x1dc, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_spinlock_clk, "r-bus-spinlock", "r-apb1",
+		      0x1ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_rtc_clk, "r-bus-rtc", "r-ahb",
+		      0x20c, BIT(0), CLK_IS_CRITICAL);
+
+static struct ccu_common *sun50i_r329_r_ccu_clks[] = {
+	&pll_cpux_clk.common,
+	&pll_periph_base_clk.common,
+	&pll_periph_2x_clk.common,
+	&pll_periph_800m_clk.common,
+	&pll_audio0_clk.common,
+	&pll_audio0_div2_clk.common,
+	&pll_audio0_div5_clk.common,
+	&pll_audio1_4x_clk.common,
+	&r_ahb_clk.common,
+	&r_apb1_clk.common,
+	&r_apb2_clk.common,
+	&r_bus_gpadc_clk.common,
+	&r_bus_ths_clk.common,
+	&r_bus_dma_clk.common,
+	&r_pwm_clk.common,
+	&r_bus_pwm_clk.common,
+	&r_codec_adc_clk.common,
+	&r_codec_dac_clk.common,
+	&r_bus_codec_clk.common,
+	&r_dmic_clk.common,
+	&r_bus_dmic_clk.common,
+	&r_bus_lradc_clk.common,
+	&r_i2s_clk.common,
+	&r_i2s_asrc_clk.common,
+	&r_bus_i2s_clk.common,
+	&r_bus_uart_clk.common,
+	&r_bus_i2c_clk.common,
+	&r_ir_clk.common,
+	&r_bus_ir_clk.common,
+	&r_bus_msgbox_clk.common,
+	&r_bus_spinlock_clk.common,
+	&r_bus_rtc_clk.common,
+};
+
+static struct clk_hw_onecell_data sun50i_r329_r_hw_clks = {
+	.hws	= {
+		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
+		[CLK_PLL_PERIPH_BASE]	= &pll_periph_base_clk.common.hw,
+		[CLK_PLL_PERIPH_2X]	= &pll_periph_2x_clk.common.hw,
+		[CLK_PLL_PERIPH_800M]	= &pll_periph_800m_clk.common.hw,
+		[CLK_PLL_PERIPH]	= &pll_periph_clk.hw,
+		[CLK_PLL_AUDIO0]	= &pll_audio0_clk.common.hw,
+		[CLK_PLL_AUDIO0_DIV2]	= &pll_audio0_div2_clk.common.hw,
+		[CLK_PLL_AUDIO0_DIV5]	= &pll_audio0_div5_clk.common.hw,
+		[CLK_PLL_AUDIO1_4X]	= &pll_audio1_4x_clk.common.hw,
+		[CLK_PLL_AUDIO1_2X]	= &pll_audio1_2x_clk.hw,
+		[CLK_PLL_AUDIO1]	= &pll_audio1_clk.hw,
+		[CLK_R_AHB]		= &r_ahb_clk.common.hw,
+		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
+		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
+		[CLK_R_BUS_GPADC]	= &r_bus_gpadc_clk.common.hw,
+		[CLK_R_BUS_THS]		= &r_bus_ths_clk.common.hw,
+		[CLK_R_BUS_DMA]		= &r_bus_dma_clk.common.hw,
+		[CLK_R_PWM]		= &r_pwm_clk.common.hw,
+		[CLK_R_BUS_PWM]		= &r_bus_pwm_clk.common.hw,
+		[CLK_R_CODEC_ADC]	= &r_codec_adc_clk.common.hw,
+		[CLK_R_CODEC_DAC]	= &r_codec_dac_clk.common.hw,
+		[CLK_R_BUS_CODEC]	= &r_bus_codec_clk.common.hw,
+		[CLK_R_DMIC]		= &r_dmic_clk.common.hw,
+		[CLK_R_BUS_DMIC]	= &r_bus_dmic_clk.common.hw,
+		[CLK_R_BUS_LRADC]	= &r_bus_lradc_clk.common.hw,
+		[CLK_R_I2S]		= &r_i2s_clk.common.hw,
+		[CLK_R_I2S_ASRC]	= &r_i2s_asrc_clk.common.hw,
+		[CLK_R_BUS_I2S]		= &r_bus_i2s_clk.common.hw,
+		[CLK_R_BUS_UART]	= &r_bus_uart_clk.common.hw,
+		[CLK_R_BUS_I2C]		= &r_bus_i2c_clk.common.hw,
+		[CLK_R_IR]		= &r_ir_clk.common.hw,
+		[CLK_R_BUS_IR]		= &r_bus_ir_clk.common.hw,
+		[CLK_R_BUS_MSGBOX]	= &r_bus_msgbox_clk.common.hw,
+		[CLK_R_BUS_SPINLOCK]	= &r_bus_spinlock_clk.common.hw,
+		[CLK_R_BUS_RTC]		= &r_bus_rtc_clk.common.hw,
+	},
+	.num = CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun50i_r329_r_ccu_resets[] = {
+	[RST_R_BUS_GPADC]	= { 0x0ec, BIT(16) },
+	[RST_R_BUS_THS]		= { 0x0fc, BIT(16) },
+	[RST_R_BUS_DMA]		= { 0x10c, BIT(16) },
+	[RST_R_BUS_PWM]		= { 0x13c, BIT(16) },
+	[RST_R_BUS_CODEC]	= { 0x14c, BIT(16) },
+	[RST_R_BUS_DMIC]	= { 0x15c, BIT(16) },
+	[RST_R_BUS_LRADC]	= { 0x16c, BIT(16) },
+	[RST_R_BUS_I2S]		= { 0x17c, BIT(16) },
+	[RST_R_BUS_UART]	= { 0x18c, BIT(16) },
+	[RST_R_BUS_I2C]		= { 0x19c, BIT(16) },
+	[RST_R_BUS_IR]		= { 0x1cc, BIT(16) },
+	[RST_R_BUS_MSGBOX]	= { 0x1dc, BIT(16) },
+	[RST_R_BUS_SPINLOCK]	= { 0x1ec, BIT(16) },
+	[RST_R_BUS_RTC]		= { 0x20c, BIT(16) },
+};
+
+static const struct sunxi_ccu_desc sun50i_r329_r_ccu_desc = {
+	.ccu_clks	= sun50i_r329_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_r329_r_ccu_clks),
+
+	.hw_clks	= &sun50i_r329_r_hw_clks,
+
+	.resets		= sun50i_r329_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_r329_r_ccu_resets),
+};
+
+static const u32 pll_regs[] = {
+	SUN50I_R329_PLL_CPUX_REG,
+	SUN50I_R329_PLL_PERIPH_REG,
+	SUN50I_R329_PLL_AUDIO0_REG,
+	SUN50I_R329_PLL_AUDIO1_REG,
+};
+
+static void __init sun50i_r329_r_ccu_setup(struct device_node *node)
+{
+	void __iomem *reg;
+	u32 val;
+	int i;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg)) {
+		pr_err("%pOF: Could not map clock registers\n", node);
+		return;
+	}
+
+	/* Enable the lock bits and the output enable bits on all PLLs */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(29) | BIT(27);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/*
+	 * Force the I/O dividers of PLL-AUDIO1 to reset default value
+	 *
+	 * See the comment before pll-audio1 definition for the reason.
+	 */
+
+	val = readl(reg + SUN50I_R329_PLL_AUDIO1_REG);
+	val &= ~BIT(1);
+	val |= BIT(0);
+	writel(val, reg + SUN50I_R329_PLL_AUDIO1_REG);
+
+	i = sunxi_ccu_probe(node, reg, &sun50i_r329_r_ccu_desc);
+	if (i)
+		pr_err("%pOF: probing clocks fails: %d\n", node, i);
+}
+
+CLK_OF_DECLARE(sun50i_r329_r_ccu, "allwinner,sun50i-r329-r-ccu",
+	       sun50i_r329_r_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
new file mode 100644
index 000000000000..62cf65322116
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _CCU_SUN50I_R329_R_H
+#define _CCU_SUN50I_R329_R_H
+
+#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
+
+#define CLK_PLL_CPUX		0
+#define CLK_PLL_PERIPH_BASE	1
+#define CLK_PLL_PERIPH_2X	2
+#define CLK_PLL_PERIPH_800M	3
+#define CLK_PLL_PERIPH		4
+#define CLK_PLL_AUDIO0		5
+#define CLK_PLL_AUDIO0_DIV2	6
+#define CLK_PLL_AUDIO0_DIV5	7
+#define CLK_PLL_AUDIO1_4X	8
+#define CLK_PLL_AUDIO1_2X	9
+#define CLK_PLL_AUDIO1		10
+#define CLK_R_AHB		11
+
+/* R_APB1 exported for PIO */
+
+#define CLK_R_APB2		13
+
+/* All module / bus gate clocks exported */
+
+#define CLK_NUMBER	(CLK_R_BUS_RTC + 1)
+
+#endif /* _CCU_SUN50I_R329_R_H */
diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
new file mode 100644
index 000000000000..df9bc58de5c4
--- /dev/null
+++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
+
+#define CLK_R_APB1		12
+
+#define CLK_R_BUS_GPADC		14
+#define CLK_R_BUS_THS		15
+#define CLK_R_BUS_DMA		16
+#define CLK_R_PWM		17
+#define CLK_R_BUS_PWM		18
+#define CLK_R_CODEC_ADC		19
+#define CLK_R_CODEC_DAC		20
+#define CLK_R_BUS_CODEC		21
+#define CLK_R_DMIC		22
+#define CLK_R_BUS_DMIC		23
+#define CLK_R_BUS_LRADC		24
+#define CLK_R_I2S		25
+#define CLK_R_I2S_ASRC		26
+#define CLK_R_BUS_I2S		27
+#define CLK_R_BUS_UART		28
+#define CLK_R_BUS_I2C		29
+#define CLK_R_IR		30
+#define CLK_R_BUS_IR		31
+#define CLK_R_BUS_MSGBOX	32
+#define CLK_R_BUS_SPINLOCK	33
+#define CLK_R_BUS_RTC		34
+
+#endif /* _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
new file mode 100644
index 000000000000..40644f2f21c6
--- /dev/null
+++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
+
+#define RST_R_BUS_GPADC		0
+#define RST_R_BUS_THS		1
+#define RST_R_BUS_DMA		2
+#define RST_R_BUS_PWM		3
+#define RST_R_BUS_CODEC		4
+#define RST_R_BUS_DMIC		5
+#define RST_R_BUS_LRADC		6
+#define RST_R_BUS_I2S		7
+#define RST_R_BUS_UART		8
+#define RST_R_BUS_I2C		9
+#define RST_R_BUS_IR		10
+#define RST_R_BUS_MSGBOX	11
+#define RST_R_BUS_SPINLOCK	12
+#define RST_R_BUS_RTC		13
+
+#endif /* _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_ */
-- 
2.30.2

