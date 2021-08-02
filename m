Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5133DD095
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhHBGbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:49 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:46628 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232384AbhHBGbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:42 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 02:31:41 EDT
X-QQ-mid: bizesmtp41t1627885366t0yr1y3x
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:45 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: uPKj8ga2w7HTqPXGTB3Ci+Aoa2Wx2Hk1y1FgOP2WgSJCoqJCJewJwZxC1C9lu
        AMTGZKXlSyi51lx23oUVVyyrldiOZevQEE67ZN0sMTzQw4OkylR+uBPqxMNzBpYOOreOy8U
        RknZfzXWZljSjIuQIGtV9QknS6fRXmlE6swmyemrs+2RfHp4L1EBtdchG7zOC3pkMyBoVLr
        Ef4pW42bvmIP6cKadogkwaYwZna/cF6gjYN5fbkemk82nb1dZl1KHMh0djb/cCcP3Wo4Ptf
        LPGvoJsqLXVsbXySxlrBJnnENv5uCP/SRsgZNGFjqOT1s6HSI2v19Oxxexmru5Wco8pa3+Z
        CBG+xTwixdpc0VRLCOLxFPiW+NAew==
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
Subject: [PATCH 08/17] pinctrl: sunxi: add support for R329 R-PIO pin controller
Date:   Mon,  2 Aug 2021 14:22:03 +0800
Message-Id: <20210802062212.73220-9-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R320 SoC has a pin controller in the CPUS power domain.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 292 ++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index c662e8b1b351..abd60ff8daec 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -134,4 +134,9 @@ config PINCTRL_SUN50I_R329
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329_R
+	bool "Support for the Allwinner R329 R-PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index e33f7c5f1ff9..245840a7959e 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329_R)	+= pinctrl-sun50i-r329-r.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
new file mode 100644
index 000000000000..dc4792c685ba
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner H616 R_PIO pin controller driver
+ *
+ * Copyright (C) 2020 Arm Ltd.
+ * Based on former work, which is:
+ *   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun50i_r329_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA3 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA2 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PL_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s_dout0"),
+		  SUNXI_FUNCTION(0x3, "s_i2s_din1"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA1 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PL_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s_dout1"),
+		  SUNXI_FUNCTION(0x3, "s_i2s_din0"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA0 */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PL_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* CLK */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PL_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PL_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PL_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PL_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PL_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PL_EINT10 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PM_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* CK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PM_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DO */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PM_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PM_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PM_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DI */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PM_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nmi"),
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PM_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),	/* PM_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),	/* PM_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PN_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDC */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PN_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDIO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PN_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PN_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PN_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PN_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PN_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PN_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXERR */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PN_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCTL/TXEN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PN_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PN_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PN_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCTL/CRS_DV */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PN_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PN_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PN_EINT14 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PN_EINT15 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* EPHY-25M */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PN_EINT16 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* CLKIN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PN_EINT17 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PN_EINT18 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PN_EINT19 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PN_EINT20 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PN_EINT21 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 22),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PN_EINT22 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 23),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PN_EINT23 */
+};
+
+static const struct sunxi_pinctrl_desc sun50i_r329_r_pinctrl_data = {
+	.pins = sun50i_r329_r_pins,
+	.npins = ARRAY_SIZE(sun50i_r329_r_pins),
+	.pin_base = PL_BASE,
+	.irq_banks = 3,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int sun50i_r329_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &sun50i_r329_r_pinctrl_data);
+}
+
+static const struct of_device_id sun50i_r329_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-r-pinctrl", },
+	{}
+};
+
+static struct platform_driver sun50i_r329_r_pinctrl_driver = {
+	.probe	= sun50i_r329_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-r-pinctrl",
+		.of_match_table	= sun50i_r329_r_pinctrl_match,
+	},
+};
+builtin_platform_driver(sun50i_r329_r_pinctrl_driver);
-- 
2.30.2

