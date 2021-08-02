Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDDC3DD08F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhHBGbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:40 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:39282 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232306AbhHBGbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:38 -0400
X-QQ-mid: bizesmtp41t1627885363tarqym8s
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:42 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: rqiGw5nOlbqS9WWmGx7IlP4daTMW21/M49Dn1NoBQC9uEtGJF6Z14UHsGGnXb
        w6k/GECuYp9TN4RSW6Q6+IY51J7HC7/Ti5jWXL12OddgTlfHZjfxmdYWKBEt4KA3+KOHPl9
        DcUMeb1JmaEgFOe/ngLDbdUbzYCk5O+gyyPbD9Nno5Yac/A8RxksTt6pXp1aD57leclQlcr
        /H25LqdkvvYekVSIxIgIsJWAPdchP5ZHYgz05/dBkEgpHYRlPUlgQ/HOVuBEjPWeVAJY09Z
        ZbWk4AV5pFXiaggDMb5Hc3aq++wC4Y9EOf0cCR7cTZt/RdMOvDwjoc7fdyhJd2GUpW33pRW
        ovetlvPmN7ODr/pA0E=
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
Subject: [PATCH 07/17] pinctrl: sunxi: add support for R329 CPUX pin controller
Date:   Mon,  2 Aug 2021 14:22:02 +0800
Message-Id: <20210802062212.73220-8-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 SoC has two pin controllers similar to ones on previous
SoCs, one in CPUX power domain and another in CPUS.

This patch adds support for the CPUX domain pin controller.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/pinctrl/sunxi/Kconfig               |   5 +
 drivers/pinctrl/sunxi/Makefile              |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c | 410 ++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 33751a6a0757..c662e8b1b351 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -129,4 +129,9 @@ config PINCTRL_SUN50I_H616_R
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329
+	bool "Support for the Allwinner R329 PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index d3440c42b9d6..e33f7c5f1ff9 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
new file mode 100644
index 000000000000..742f437ec0b6
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner R329 SoC pinctrl driver.
+ *
+ * Copyright (C) 2021 Sipeed
+ * based on the H616 pinctrl driver
+ *   Copyright (C) 2020 Arm Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin r329_pins[] = {
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PB_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* MCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PB_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* LRCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PB_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PB_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout0"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din1"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PB_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout1"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din0"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PB_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM6 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT2 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PB_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM7 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT3 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PB_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir_tx"),
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM8 */
+		  SUNXI_FUNCTION(0x4, "ir_rx"),
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PB_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* WP */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* HOLD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
+		  SUNXI_FUNCTION(0x3, "mmc0")),		/* RST */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x5, "boot_sel")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ7 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPEN */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ6 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPPP */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ5 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* PWREN */
+		  SUNXI_FUNCTION(0x4, "uart"),		/* TX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ4 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQS */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DATA */
+		  SUNXI_FUNCTION(0x4, "uart"),		/* RX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ2 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* RST */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DET */
+		  SUNXI_FUNCTION(0x4, "spdif_in"),
+		  SUNXI_FUNCTION(0x5, "spdif_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_clk"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d2"),
+		  /* 0x4 is also mmc1_d2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x4, "mmc1_clk"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d0"),
+		  SUNXI_FUNCTION(0x3, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x4, "mmc1_d3"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x3, "mmc1_clk"),
+		  /* 0x4 is also mmc1_d1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d2"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d0"),
+		  /* 0x4 is also mmc1_d0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x4, "mmc1_cmd"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout0"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din1"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout1"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din0"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "spi1_cs"),	/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x4, "spi1_hold"),	/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "spi1_clk"),	/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x4, "spi1_wp"),	/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI/SPI-DBO */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x4, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x4, "spdif"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
+};
+static const unsigned int r329_irq_bank_map[] = { 1, 5, 6, 7 };
+
+static const struct sunxi_pinctrl_desc r329_pinctrl_data = {
+	.pins = r329_pins,
+	.npins = ARRAY_SIZE(r329_pins),
+	.irq_banks = ARRAY_SIZE(r329_irq_bank_map),
+	.irq_bank_map = r329_irq_bank_map,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int r329_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev, &r329_pinctrl_data);
+}
+
+static const struct of_device_id r329_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-pinctrl", },
+	{}
+};
+
+static struct platform_driver r329_pinctrl_driver = {
+	.probe	= r329_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-pinctrl",
+		.of_match_table	= r329_pinctrl_match,
+	},
+};
+builtin_platform_driver(r329_pinctrl_driver);
-- 
2.30.2

