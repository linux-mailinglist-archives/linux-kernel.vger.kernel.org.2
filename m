Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928E038FD21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhEYIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:48:54 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:47570 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhEYIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:48:51 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 14P8l6gx000603; Tue, 25 May 2021 17:47:06 +0900
X-Iguazu-Qid: 34tMSNRmZceJpRLBIL
X-Iguazu-QSIG: v=2; s=0; t=1621932426; q=34tMSNRmZceJpRLBIL; m=XNjqV6Oxh0rhBL3M8CJHuSR32FfICf/xUcIPUMYH9zw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 14P8l5Sp025038
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 17:47:06 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 47AC61000D0;
        Tue, 25 May 2021 17:47:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 14P8l4dT017992;
        Tue, 25 May 2021 17:47:04 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 1/4] clk: visconti: Add support common clock driver and reset driver
Date:   Tue, 25 May 2021 17:46:52 +0900
X-TSB-HOP: ON
Message-Id: <20210525084655.138465-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525084655.138465-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210525084655.138465-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for common interface of the common clock and reset
driver for Toshiba Visconti5 and its SoC, TMPV7708.
The pipllct provides the PLL, pismu provides clock and reset functionality
and each driver is provided in this patch.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/clk/Makefile                         |   1 +
 drivers/clk/visconti/Makefile                |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c         | 230 ++++++++++++
 drivers/clk/visconti/clkc.c                  | 215 +++++++++++
 drivers/clk/visconti/clkc.h                  |  75 ++++
 drivers/clk/visconti/pll-tmpv770x.c          |  94 +++++
 drivers/clk/visconti/pll.c                   | 373 +++++++++++++++++++
 drivers/clk/visconti/pll.h                   |  62 +++
 drivers/clk/visconti/reset.c                 | 111 ++++++
 drivers/clk/visconti/reset.h                 |  35 ++
 include/dt-bindings/clock/toshiba,tmpv770x.h | 181 +++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h |  41 ++
 12 files changed, 1423 insertions(+)
 create mode 100644 drivers/clk/visconti/Makefile
 create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
 create mode 100644 drivers/clk/visconti/clkc.c
 create mode 100644 drivers/clk/visconti/clkc.h
 create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
 create mode 100644 drivers/clk/visconti/pll.c
 create mode 100644 drivers/clk/visconti/pll.h
 create mode 100644 drivers/clk/visconti/reset.c
 create mode 100644 drivers/clk/visconti/reset.h
 create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
 create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f06879d7fe9..dbf70fdecfc8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -116,6 +116,7 @@ obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-y					+= versatile/
+obj-$(CONFIG_ARCH_VISCONTI)		+= visconti/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_X86)			+= x86/
 endif
diff --git a/drivers/clk/visconti/Makefile b/drivers/clk/visconti/Makefile
new file mode 100644
index 000000000000..c1254fd52b31
--- /dev/null
+++ b/drivers/clk/visconti/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for Toshiba Visconti clock
+
+obj-y	+= clkc.o pll.o reset.o
+obj-y	+= pll-tmpv770x.o clkc-tmpv770x.o
diff --git a/drivers/clk/visconti/clkc-tmpv770x.c b/drivers/clk/visconti/clkc-tmpv770x.c
new file mode 100644
index 000000000000..e1d3e3a04f73
--- /dev/null
+++ b/drivers/clk/visconti/clkc-tmpv770x.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti clock controller
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#include <dt-bindings/clock/toshiba,tmpv770x.h>
+#include <dt-bindings/reset/toshiba,tmpv770x.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include "clkc.h"
+#include "reset.h"
+
+static DEFINE_SPINLOCK(tmpv7708_clk_lock);
+static DEFINE_SPINLOCK(tmpv7708_rst_lock);
+
+static const struct visconti_fixed_clk fixed_clk_tables[] = {
+	/* PLL1 */
+	/* PICMPT0/1, PITSC, PIUWDT, PISWDT, PISBUS, PIPMU, PIGPMU, PITMU */
+	/* PIEMM, PIMISC, PIGCOMM, PIDCOMM, PIMBUS, PIGPIO, PIPGM */
+	{ TMPV770X_CLK_PIPLL1_DIV4, "pipll1_div4", "pipll1", 0, 1, 4, },
+	/* PISBUS */
+	{ TMPV770X_CLK_PIPLL1_DIV2, "pipll1_div2", "pipll1", 0, 1, 2, },
+	/* PICOBUS_CLK */
+	{ TMPV770X_CLK_PIPLL1_DIV1, "pipll1_div1", "pipll1", 0, 1, 1, },
+	/* PIDNNPLL */
+	/* CONN_CLK, PIMBUS, PICRC0/1 */
+	{ TMPV770X_CLK_PIDNNPLL_DIV1, "pidnnpll_div1", "pidnnpll", 0, 1, 1, },
+	{ TMPV770X_CLK_PIREFCLK, "pirefclk", "osc2_clk", 0, 1, 1, },
+	{ TMPV770X_CLK_WDTCLK, "wdtclk", "osc2_clk", 0, 1, 1, },
+};
+
+static const struct visconti_clk_gate_table pietherpll_clk_gate_tables[] = {
+	/* pietherpll */
+	{ TMPV770X_CLK_PIETHER_2P5M, "piether_2p5m", "pietherpll",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 4, 200,
+		TMPV770X_RESET_PIETHER_2P5M, },
+	{ TMPV770X_CLK_PIETHER_25M, "piether_25m", "pietherpll",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 5, 20,
+		TMPV770X_RESET_PIETHER_25M, },
+	{ TMPV770X_CLK_PIETHER_50M, "piether_50m", "pietherpll",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 6, 10,
+		TMPV770X_RESET_PIETHER_50M, },
+	{ TMPV770X_CLK_PIETHER_125M, "piether_125m", "pietherpll",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 7, 4,
+		TMPV770X_RESET_PIETHER_125M, },
+};
+
+static const struct visconti_clk_gate_table clk_gate_tables[] = {
+	{ TMPV770X_CLK_HOX, "hox", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x4C, 0x14C, 0, 1,
+		TMPV770X_RESET_HOX, },
+	{ TMPV770X_CLK_PCIE_MSTR, "pcie_mstr", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 0, 1,
+		TMPV770X_RESET_PCIE_MSTR, },
+	{ TMPV770X_CLK_PCIE_AUX, "pcie_aux", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 1, 24,
+		TMPV770X_RESET_PCIE_AUX, },
+	{ TMPV770X_CLK_PIINTC, "piintc", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x8, 0x108, 0, 2,
+		TMPV770X_RESET_PIINTC,},
+	{ TMPV770X_CLK_PIETHER_BUS, "piether_bus", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 0, 2,
+		TMPV770X_RESET_PIETHER_BUS, }, /* BUS_CLK */
+	{ TMPV770X_CLK_PISPI0, "pispi0", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 0, 2,
+		TMPV770X_RESET_PISPI0, },
+	{ TMPV770X_CLK_PISPI1, "pispi1", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 1, 2,
+		TMPV770X_RESET_PISPI1, },
+	{ TMPV770X_CLK_PISPI2, "pispi2", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 2, 2,
+		TMPV770X_RESET_PISPI2, },
+	{ TMPV770X_CLK_PISPI3, "pispi3", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 3, 2,
+		TMPV770X_RESET_PISPI3,},
+	{ TMPV770X_CLK_PISPI4, "pispi4", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 4, 2,
+		TMPV770X_RESET_PISPI4, },
+	{ TMPV770X_CLK_PISPI5, "pispi5", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 5, 2,
+		TMPV770X_RESET_PISPI5},
+	{ TMPV770X_CLK_PISPI6, "pispi6", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 6, 2,
+		TMPV770X_RESET_PISPI6,},
+	{ TMPV770X_CLK_PIUART0, "piuart0", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 0, 4,
+		TMPV770X_RESET_PIUART0,},
+	{ TMPV770X_CLK_PIUART1, "piuart1", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 1, 4,
+		TMPV770X_RESET_PIUART1, },
+	{ TMPV770X_CLK_PIUART2, "piuart2", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 2, 4,
+		TMPV770X_RESET_PIUART2, },
+	{ TMPV770X_CLK_PIUART3, "piuart3", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 3, 4,
+		TMPV770X_RESET_PIUART3, },
+	{ TMPV770X_CLK_PII2C0, "pii2c0", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 0, 4,
+		TMPV770X_RESET_PII2C0, },
+	{ TMPV770X_CLK_PII2C1, "pii2c1", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 1, 4,
+		TMPV770X_RESET_PII2C1, },
+	{ TMPV770X_CLK_PII2C2, "pii2c2", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 2, 4,
+		TMPV770X_RESET_PII2C2, },
+	{ TMPV770X_CLK_PII2C3, "pii2c3", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 3, 4,
+		TMPV770X_RESET_PII2C3,},
+	{ TMPV770X_CLK_PII2C4, "pii2c4", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 4, 4,
+		TMPV770X_RESET_PII2C4, },
+	{ TMPV770X_CLK_PII2C5, "pii2c5", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 5, 4,
+		TMPV770X_RESET_PII2C5, },
+	{ TMPV770X_CLK_PII2C6, "pii2c6", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 6, 4,
+		TMPV770X_RESET_PII2C6, },
+	{ TMPV770X_CLK_PII2C7, "pii2c7", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 7, 4,
+		TMPV770X_RESET_PII2C7, },
+	{ TMPV770X_CLK_PII2C8, "pii2c8", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 8, 4,
+		TMPV770X_RESET_PII2C8, },
+	/* PIPCMIF */
+	{ TMPV770X_CLK_PIPCMIF, "pipcmif", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x64, 0x164, 0, 4,
+		TMPV770X_RESET_PIPCMIF, },
+	/* PISYSTEM */
+	{ TMPV770X_CLK_WRCK, "wrck", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x68, 0x168, 9, 32,
+		-1, }, /* No reset */
+	{ TMPV770X_CLK_PICKMON, "pickmon", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x10, 0x110, 8, 4,
+		TMPV770X_RESET_PICKMON, },
+	{ TMPV770X_CLK_SBUSCLK, "sbusclk", "pipll1",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x14, 0x114, 0, 4,
+		TMPV770X_RESET_SBUSCLK, },
+};
+
+static const struct visconti_reset_data clk_reset_data[] = {
+	[TMPV770X_RESET_PIETHER_2P5M]	= { 0x434, 0x534, 4, },
+	[TMPV770X_RESET_PIETHER_25M]	= { 0x434, 0x534, 5, },
+	[TMPV770X_RESET_PIETHER_50M]	= { 0x434, 0x534, 6, },
+	[TMPV770X_RESET_PIETHER_125M]	= { 0x434, 0x534, 7, },
+	[TMPV770X_RESET_HOX]		= { 0x44C, 0x54C, 0, },
+	[TMPV770X_RESET_PCIE_MSTR]	= { 0x438, 0x538, 0, },
+	[TMPV770X_RESET_PCIE_AUX]	= { 0x438, 0x538, 1, },
+	[TMPV770X_RESET_PIINTC]		= { 0x408, 0x508, 0, },
+	[TMPV770X_RESET_PIETHER_BUS]	= { 0x434, 0x534, 0, },
+	[TMPV770X_RESET_PISPI0]		= { 0x428, 0x528, 0, },
+	[TMPV770X_RESET_PISPI1]		= { 0x428, 0x528, 1, },
+	[TMPV770X_RESET_PISPI2]		= { 0x428, 0x528, 2, },
+	[TMPV770X_RESET_PISPI3]		= { 0x428, 0x528, 3, },
+	[TMPV770X_RESET_PISPI4]		= { 0x428, 0x528, 4, },
+	[TMPV770X_RESET_PISPI5]		= { 0x428, 0x528, 5, },
+	[TMPV770X_RESET_PISPI6]		= { 0x428, 0x528, 6, },
+	[TMPV770X_RESET_PIUART0]	= { 0x42C, 0x52C, 0, },
+	[TMPV770X_RESET_PIUART1]	= { 0x42C, 0x52C, 1, },
+	[TMPV770X_RESET_PIUART2]	= { 0x42C, 0x52C, 2, },
+	[TMPV770X_RESET_PIUART3]	= { 0x42C, 0x52C, 3, },
+	[TMPV770X_RESET_PII2C0]		= { 0x430, 0x530, 0, },
+	[TMPV770X_RESET_PII2C1]		= { 0x430, 0x530, 1, },
+	[TMPV770X_RESET_PII2C2]		= { 0x430, 0x530, 2, },
+	[TMPV770X_RESET_PII2C3]		= { 0x430, 0x530, 3, },
+	[TMPV770X_RESET_PII2C4]		= { 0x430, 0x530, 4, },
+	[TMPV770X_RESET_PII2C5]		= { 0x430, 0x530, 5, },
+	[TMPV770X_RESET_PII2C6]		= { 0x430, 0x530, 6, },
+	[TMPV770X_RESET_PII2C7]		= { 0x430, 0x530, 7, },
+	[TMPV770X_RESET_PII2C8]		= { 0x430, 0x530, 8, },
+	[TMPV770X_RESET_PIPCMIF]	= { 0x464, 0x564, 0, },
+	[TMPV770X_RESET_PICKMON]	= { 0x410, 0x510, 8, },
+	[TMPV770X_RESET_SBUSCLK]	= { 0x414, 0x514, 0, },
+};
+
+static void __init tmpv7708_clkc_setup_clks(struct device_node *np)
+{
+	struct visconti_clk_provider *ctx;
+	struct regmap *regmap;
+	struct clk *clk;
+	int ret, i;
+	u32 tmp;
+
+	regmap = device_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		return;
+
+	ctx = visconti_init_clk(np, regmap, TMPV770X_NR_CLK);
+	if (IS_ERR(ctx))
+		return;
+
+	ret = visconti_register_reset_controller(np, regmap, clk_reset_data,
+						 TMPV770X_NR_RESET,
+						 &visconti_reset_ops,
+						 &tmpv7708_rst_lock);
+	if (ret)
+		return;
+
+	/* OSC3 clock */
+	ret = of_property_read_u32(np, "osc3-clk-frequency", &tmp);
+	if (ret) {
+		pr_warn("osc3 clk frequency not specified, using 24.576 MHz.\n");
+		tmp = 24576000;
+	}
+	clk = clk_register_fixed_rate(NULL, "osc3_clk", NULL, 0, tmp);
+
+	for (i = 0; i < (ARRAY_SIZE(fixed_clk_tables)); i++)
+		ctx->clk_data.clks[fixed_clk_tables[i].id] =
+			clk_register_fixed_factor(NULL,
+						fixed_clk_tables[i].name,
+						fixed_clk_tables[i].parent,
+						fixed_clk_tables[i].flag,
+						fixed_clk_tables[i].mult,
+						fixed_clk_tables[i].div);
+
+	visconti_clk_register_gates(ctx, clk_gate_tables,
+				    ARRAY_SIZE(clk_gate_tables), clk_reset_data,
+				    &tmpv7708_clk_lock);
+	visconti_clk_register_gates(ctx, pietherpll_clk_gate_tables,
+				    ARRAY_SIZE(pietherpll_clk_gate_tables),
+				    clk_reset_data, &tmpv7708_clk_lock);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &ctx->clk_data);
+}
+
+CLK_OF_DECLARE_DRIVER(tmpv7708_clkc, "toshiba,tmpv7708-pismu", tmpv7708_clkc_setup_clks);
diff --git a/drivers/clk/visconti/clkc.c b/drivers/clk/visconti/clkc.c
new file mode 100644
index 000000000000..31ff68f329c2
--- /dev/null
+++ b/drivers/clk/visconti/clkc.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti clock controller
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "clkc.h"
+
+static inline struct visconti_clk_gate *to_visconti_clk_gate(struct clk_hw *hw)
+{
+	return container_of(hw, struct visconti_clk_gate, hw);
+}
+
+static int visconti_gate_clk_is_enabled(struct clk_hw *hw)
+{
+	struct visconti_clk_gate *gate = to_visconti_clk_gate(hw);
+	u32 clk = BIT(gate->ck_idx);
+	u32 val;
+
+	regmap_read(gate->regmap, gate->ckon_offset, &val);
+	return (val & clk) ? 1 : 0;
+}
+
+static void visconti_gate_clk_disable(struct clk_hw *hw)
+{
+	struct visconti_clk_gate *gate = to_visconti_clk_gate(hw);
+	u32 clk = BIT(gate->ck_idx);
+	u32 rst = BIT(gate->rs_idx);
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (visconti_gate_clk_is_enabled(hw)) {
+		spin_unlock_irqrestore(gate->lock, flags);
+		return;
+	}
+
+	/* Reset release */
+	regmap_update_bits(gate->regmap, gate->rson_offset, rst, 1);
+
+	udelay(100);
+
+	/* Disable clock */
+	regmap_update_bits(gate->regmap, gate->ckoff_offset, clk, 1);
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int visconti_gate_clk_enable(struct clk_hw *hw)
+{
+	struct visconti_clk_gate *gate = to_visconti_clk_gate(hw);
+	u32 clk = BIT(gate->ck_idx);
+	u32 rst = BIT(gate->rs_idx);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (visconti_gate_clk_is_enabled(hw)) {
+		spin_unlock_irqrestore(gate->lock, flags);
+		return 0;
+	}
+
+	regmap_update_bits(gate->regmap, gate->ckon_offset, clk, 1);
+	/* Need read back */
+	regmap_read(gate->regmap, gate->ckon_offset, &val);
+
+	udelay(100);
+	/* Reset release */
+	regmap_update_bits(gate->regmap, gate->rsoff_offset, rst, 1);
+	/* Need read back */
+	regmap_read(gate->regmap, gate->ckoff_offset, &val);
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops visconti_clk_gate_ops = {
+	.enable = visconti_gate_clk_enable,
+	.disable = visconti_gate_clk_disable,
+	.is_enabled = visconti_gate_clk_is_enabled,
+};
+
+static struct clk_hw *visconti_clk_register_gate(struct device *dev,
+						 const char *name,
+						 const char *parent_name,
+						 struct regmap *regmap,
+						 const struct visconti_clk_gate_table *clks,
+						 u32	rson_offset,
+						 u32	rsoff_offset,
+						 u8	rs_idx,
+						 spinlock_t *lock)
+{
+	struct visconti_clk_gate *gate;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &visconti_clk_gate_ops;
+	init.flags = clks->flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->regmap = regmap;
+	gate->ckon_offset = clks->ckon_offset;
+	gate->ckoff_offset = clks->ckoff_offset;
+	gate->ck_idx = clks->ck_idx;
+	gate->rson_offset = rson_offset;
+	gate->rsoff_offset = rsoff_offset;
+	gate->rs_idx = rs_idx;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+void visconti_clk_register_gates(struct visconti_clk_provider *data,
+				 const struct visconti_clk_gate_table *clks,
+				 int num_gate, const struct visconti_reset_data *reset,
+				 spinlock_t *lock)
+{
+	u32 rson_offset, rsoff_offset;
+	struct clk_hw *hw_clk;
+	struct clk *clk;
+	char *div_name;
+	u8 rs_idx;
+	int i;
+
+	for (i = 0; i < num_gate; i++) {
+		div_name = kasprintf(GFP_KERNEL, "%s_div", clks[i].name);
+		if (!div_name)
+			continue;
+
+		if (clks[i].rs_id >= 0) {
+			rson_offset = reset[clks[i].rs_id].rson_offset;
+			rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
+			rs_idx = reset[clks[i].rs_id].rs_idx;
+		} else {
+			rson_offset = rsoff_offset = rs_idx = -1;
+		}
+
+		clk = clk_register_fixed_factor(NULL, div_name, clks[i].parent,
+						0, 1, clks[i].div);
+
+		hw_clk = visconti_clk_register_gate(NULL,
+						clks[i].name,
+						div_name,
+						data->regmap,
+						&clks[i],
+						rson_offset,
+						rsoff_offset,
+						rs_idx,
+						lock);
+		kfree(div_name);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		data->clk_data.clks[clks[i].id] = hw_clk->clk;
+	}
+}
+
+struct visconti_clk_provider *visconti_init_clk(struct device_node *np,
+						struct regmap *regmap,
+						unsigned long nr_clks)
+{
+	struct visconti_clk_provider *ctx;
+	struct clk **clk_table;
+	int i;
+
+	ctx = kzalloc(sizeof(struct visconti_clk_provider), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_table)
+		goto err;
+
+	for (i = 0; i < nr_clks; ++i)
+		clk_table[i] = ERR_PTR(-ENOENT);
+	ctx->node = np;
+	ctx->regmap = regmap;
+	ctx->clk_data.clks = clk_table;
+	ctx->clk_data.clk_num = nr_clks;
+
+	return ctx;
+err:
+	kfree(ctx);
+	return ERR_PTR(-ENOMEM);
+}
diff --git a/drivers/clk/visconti/clkc.h b/drivers/clk/visconti/clkc.h
new file mode 100644
index 000000000000..fbc646a96f55
--- /dev/null
+++ b/drivers/clk/visconti/clkc.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Toshiba Visconti clock controller
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#ifndef _VISCONTI_GATE_H_
+#define _VISCONTI_GATE_H_
+
+#include <linux/mfd/syscon.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#include "reset.h"
+
+struct visconti_clk_provider {
+	struct device_node	*node;
+	struct regmap		*regmap;
+	struct clk_onecell_data clk_data;
+};
+
+struct visconti_clk_gate_table {
+	unsigned int	id;
+	const char	*name;
+	const char	*parent;
+	u8		flags;
+	u32		ckon_offset;
+	u32		ckoff_offset;
+	u8		ck_idx;
+	unsigned int	div;
+	u8		rs_id;
+};
+
+struct visconti_fixed_clk {
+	unsigned int	id;
+	const char	*name;
+	const char	*parent;
+	unsigned long	flag;
+	unsigned int	mult;
+	unsigned int	div;
+};
+
+struct visconti_clk_gate {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	u32		ckon_offset;
+	u32		ckoff_offset;
+	u8		ck_idx;
+	u8		flags;
+	u32		rson_offset;
+	u32		rsoff_offset;
+	u8		rs_idx;
+	spinlock_t	*lock;
+};
+
+struct visconti_clk_provider *visconti_init_clk(struct device_node *np,
+						struct regmap *regmap,
+						unsigned long nr_clks);
+void visconti_clk_register_gates(struct visconti_clk_provider *data,
+				 const struct visconti_clk_gate_table *clks,
+				 int num_gate,
+				 const struct visconti_reset_data *reset,
+				 spinlock_t *lock);
+#endif /* _VISCONTI_GATE_H_ */
diff --git a/drivers/clk/visconti/pll-tmpv770x.c b/drivers/clk/visconti/pll-tmpv770x.c
new file mode 100644
index 000000000000..6f008132f793
--- /dev/null
+++ b/drivers/clk/visconti/pll-tmpv770x.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti PLL controller
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#include <dt-bindings/clock/toshiba,tmpv770x.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "pll.h"
+
+static DEFINE_SPINLOCK(tmpv7708_pll_lock);
+
+static const struct visconti_pll_rate_table pipll0_rates[] __initconst = {
+	VISCONTI_PLL_RATE(840000000, 0x1, 0x0, 0x1, 0x54, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4E, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(600000000, 0x1, 0x0, 0x1, 0x3C, 0x000000, 0x2, 0x1),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_rate_table piddrcpll_rates[] __initconst = {
+	VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4E, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(760000000, 0x1, 0x0, 0x1, 0x4C, 0x000000, 0x2, 0x1),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_rate_table pivoifpll_rates[] __initconst = {
+	VISCONTI_PLL_RATE(165000000, 0x1, 0x0, 0x1, 0x42, 0x000000, 0x4, 0x2),
+	VISCONTI_PLL_RATE(148500000, 0x1, 0x1, 0x1, 0x3B, 0x666666, 0x4, 0x2),
+	VISCONTI_PLL_RATE(96000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x2),
+	VISCONTI_PLL_RATE(74250000, 0x1, 0x1, 0x1, 0x3B, 0x666666, 0x4, 0x4),
+	VISCONTI_PLL_RATE(54000000, 0x1, 0x0, 0x1, 0x36, 0x000000, 0x5, 0x4),
+	VISCONTI_PLL_RATE(48000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x4),
+	VISCONTI_PLL_RATE(35750000, 0x1, 0x1, 0x1, 0x32, 0x0CCCCC, 0x7, 0x4),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_rate_table piimgerpll_rates[] __initconst = {
+	VISCONTI_PLL_RATE(165000000, 0x1, 0x0, 0x1, 0x42, 0x000000, 0x4, 0x2),
+	VISCONTI_PLL_RATE(96000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x2),
+	VISCONTI_PLL_RATE(54000000, 0x1, 0x0, 0x1, 0x36, 0x000000, 0x5, 0x4),
+	VISCONTI_PLL_RATE(48000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x4),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_info pll_info[] __initconst = {
+	{ TMPV770X_PLL_PIPLL0, "pipll0", "osc2_clk", 0, 0x0, pipll0_rates },
+	{ TMPV770X_PLL_PIDDRCPLL, "piddrcpll", "osc2_clk", 0, 0x500, piddrcpll_rates },
+	{ TMPV770X_PLL_PIVOIFPLL, "pivoifpll", "osc2_clk", 0, 0x600, pivoifpll_rates },
+	{ TMPV770X_PLL_PIIMGERPLL, "piimgerpll", "osc2_clk", 0, 0x700, piimgerpll_rates },
+};
+
+static void __init tmpv7708_setup_plls(struct device_node *np)
+{
+	struct visconti_pll_provider *ctx;
+	void __iomem *reg_base;
+	struct clk *clk;
+	int ret;
+	u32 tmp;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		return;
+
+	ctx = visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);
+	if (IS_ERR(ctx)) {
+		iounmap(reg_base);
+		return;
+	}
+
+	ret = of_property_read_u32(np, "osc2-clk-frequency", &tmp);
+	if (ret) {
+		pr_warn("osc2 clk frequency not specified, using 20 MHz.\n");
+		tmp = 20000000;
+	}
+
+	clk = clk_register_fixed_rate(NULL, "osc2_clk", NULL, 0, tmp);
+	ctx->clk_data.clks[TMPV770X_PLL_PIPLL1] =
+		clk_register_fixed_rate(NULL, "pipll1", NULL, 0, 600000000);
+	ctx->clk_data.clks[TMPV770X_PLL_PIDNNPLL] =
+		clk_register_fixed_rate(NULL, "pidnnpll", NULL, 0, 500000000);
+	ctx->clk_data.clks[TMPV770X_PLL_PIETHERPLL] =
+		clk_register_fixed_rate(NULL, "pietherpll", NULL, 0, 500000000);
+
+	visconti_register_plls(ctx, pll_info, ARRAY_SIZE(pll_info), &tmpv7708_pll_lock);
+}
+
+CLK_OF_DECLARE_DRIVER(tmpv7708_plls, "toshiba,tmpv7708-pipllct", tmpv7708_setup_plls);
diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
new file mode 100644
index 000000000000..7f0fa3f2c1b2
--- /dev/null
+++ b/drivers/clk/visconti/pll.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti PLL driver
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+
+#include "pll.h"
+
+struct visconti_pll {
+	struct clk_hw	hw;
+	void __iomem	*pll_base;
+	spinlock_t	*lock;
+	int rate_count;
+	unsigned long flags;
+	const struct visconti_pll_rate_table *rate_table;
+	struct visconti_pll_provider *ctx;
+};
+
+#define PLL_CONF_REG		0x0000
+#define PLL_CTRL_REG		0x0004
+#define PLL_FRACMODE_REG	0x0010
+#define PLL_INTIN_REG		0x0014
+#define PLL_FRACIN_REG		0x0018
+#define PLL_REFDIV_REG		0x001C
+#define PLL_POSTDIV_REG		0x0020
+
+#define PLL_CONFIG_SEL		BIT(0)
+#define PLL_PLLEN		BIT(4)
+#define PLL_BYPASS		BIT(16)
+#define PLL_INTIN_MASK		GENMASK(11, 0)
+#define PLL_FRACIN_MASK		GENMASK(23, 0)
+#define PLL_REFDIV_MASK		GENMASK(5, 0)
+#define PLL_POSTDIV_MASK	GENMASK(2, 0)
+
+static inline struct visconti_pll *to_visconti_pll(struct clk_hw *hw)
+{
+	return container_of(hw, struct visconti_pll, hw);
+}
+
+static void visconti_pll_get_params(struct visconti_pll *pll,
+				    struct visconti_pll_rate_table *rate_table)
+{
+	u32 postdiv, val;
+
+	val = readl(pll->pll_base + PLL_FRACMODE_REG);
+	rate_table->dacen = (val >> 4) & 0x1;
+	rate_table->dsmen = val & 0x1;
+	rate_table->fracin = readl(pll->pll_base + PLL_FRACIN_REG) & PLL_FRACIN_MASK;
+	rate_table->intin = readl(pll->pll_base + PLL_INTIN_REG) & PLL_INTIN_MASK;
+	rate_table->refdiv = readl(pll->pll_base + PLL_REFDIV_REG) & PLL_REFDIV_MASK;
+
+	postdiv = readl(pll->pll_base + PLL_POSTDIV_REG);
+	rate_table->postdiv1 = postdiv & PLL_POSTDIV_MASK;
+	rate_table->postdiv2 = (postdiv >> 4) & PLL_POSTDIV_MASK;
+}
+
+static const struct visconti_pll_rate_table *visconti_get_pll_settings(struct visconti_pll *pll,
+								       unsigned long rate)
+{
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+	}
+
+	return NULL;
+}
+
+static unsigned long visconti_get_pll_rate_from_data(struct visconti_pll *pll,
+						     struct visconti_pll_rate_table *rate)
+{
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate_table[i].dacen == rate->dacen &&
+			rate_table[i].dsmen == rate->dsmen &&
+			rate_table[i].fracin == rate->fracin &&
+			rate_table[i].intin == rate->intin &&
+			rate_table[i].refdiv == rate->refdiv &&
+			rate_table[i].postdiv1 == rate->postdiv1 &&
+			rate_table[i].postdiv2 == rate->postdiv2)
+			return rate_table[i].rate;
+	}
+
+	/* set default */
+	return rate_table[0].rate;
+}
+
+static long visconti_pll_round_rate(struct clk_hw *hw,
+			    unsigned long rate, unsigned long *prate)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate >= rate_table[i].rate)
+			return rate_table[i].rate;
+	}
+
+	/* return minimum supported value */
+	return rate_table[i - 1].rate;
+}
+
+static unsigned long visconti_pll_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	struct visconti_pll_rate_table rate_table;
+
+	memset(&rate_table, 0, sizeof(rate_table));
+	visconti_pll_get_params(pll, &rate_table);
+
+	return visconti_get_pll_rate_from_data(pll, &rate_table);
+}
+
+static int visconti_pll_set_params(struct visconti_pll *pll,
+				const struct visconti_pll_rate_table *rate_table)
+{
+	/* update pll values */
+	writel(((rate_table->dacen << 4) | rate_table->dsmen),
+			pll->pll_base + PLL_FRACMODE_REG);
+	writel(((rate_table->postdiv2 << 4) | rate_table->postdiv1),
+			pll->pll_base + PLL_POSTDIV_REG);
+	writel(rate_table->intin, pll->pll_base + PLL_INTIN_REG);
+	writel(rate_table->fracin, pll->pll_base + PLL_FRACIN_REG);
+	writel(rate_table->refdiv, pll->pll_base + PLL_REFDIV_REG);
+
+	return 0;
+}
+
+static int visconti_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	const struct visconti_pll_rate_table *rate_table;
+
+	/* Get required rate settings from table */
+	rate_table = visconti_get_pll_settings(pll, rate);
+	if (!rate_table) {
+		pr_err("Invalid rate : %lu for pll clk %s\n",
+			parent_rate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	return visconti_pll_set_params(pll, rate_table);
+}
+
+static int visconti_pll_is_enabled(struct clk_hw *hw)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(pll->lock, flags);
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	return (reg & PLL_PLLEN);
+}
+
+static int visconti_pll_enable(struct clk_hw *hw)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (visconti_pll_is_enabled(hw))
+		return 0;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	/* Change to access via register */
+	writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
+
+	/* Change to BYPASS mode */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_BYPASS;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	/* Set DIV register .....*/
+	visconti_pll_set_params(pll, &rate_table[0]);
+
+	/* Disable  PLL register */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg &= ~PLL_PLLEN;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	/* Wait 1us */
+	udelay(1);
+
+	/* Enable PLL register */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_PLLEN;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	/* Wait 40us */
+	udelay(40);
+
+	/* Change to PLL mode */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg &= ~PLL_BYPASS;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	return 0;
+}
+
+static void visconti_pll_disable(struct clk_hw *hw)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (!visconti_pll_is_enabled(hw))
+		return;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	/* Change to access via register */
+	writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
+
+	/* Change to BYPASS mode */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_BYPASS;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	/* PLL disable */
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg &= ~PLL_PLLEN;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	spin_unlock_irqrestore(pll->lock, flags);
+}
+
+static const struct clk_ops visconti_pll_ops = {
+	.enable = visconti_pll_enable,
+	.disable = visconti_pll_disable,
+	.is_enabled = visconti_pll_is_enabled,
+	.round_rate = visconti_pll_round_rate,
+	.recalc_rate = visconti_pll_recalc_rate,
+	.set_rate = visconti_pll_set_rate,
+};
+
+struct clk *visconti_register_pll(struct visconti_pll_provider *ctx,
+				  const char *name,
+				  const char *parent_name,
+				  int offset,
+				  const struct visconti_pll_rate_table *rate_table,
+				  u8 clk_pll_flags,
+				  spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct visconti_pll *pll;
+	struct clk *pll_clk;
+	int len;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	/* Create the actual pll */
+	init.name = name;
+	init.flags = CLK_IGNORE_UNUSED;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	for (len = 0; rate_table[len].rate != 0; )
+		len++;
+	pll->rate_count = len;
+	pll->rate_table = kmemdup(rate_table,
+				  pll->rate_count * sizeof(struct visconti_pll_rate_table),
+				  GFP_KERNEL);
+	WARN(!pll->rate_table, "%s: could not allocate rate table for %s\n", __func__, name);
+
+	init.ops = &visconti_pll_ops;
+	pll->hw.init = &init;
+	pll->pll_base = ctx->reg_base + offset;
+	pll->flags = clk_pll_flags;
+	pll->lock = lock;
+	pll->ctx = ctx;
+
+	pll_clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(pll_clk)) {
+		pr_err("failed to register pll clock %s : %ld\n", name, PTR_ERR(pll_clk));
+		goto err;
+	}
+
+	return pll_clk;
+
+err:
+	kfree(pll);
+	return pll_clk;
+}
+
+static void visconti_pll_add_lookup(struct visconti_pll_provider *ctx, struct clk *clk,
+				    unsigned int id)
+{
+	if (ctx->clk_data.clks && id)
+		ctx->clk_data.clks[id] = clk;
+}
+
+void __init visconti_register_plls(struct visconti_pll_provider *ctx,
+				   const struct visconti_pll_info *list,
+				   unsigned int nr_plls,
+				   spinlock_t *lock)
+{
+	struct clk *clk;
+	int idx;
+
+	for (idx = 0; idx < nr_plls; idx++, list++) {
+		clk = visconti_register_pll(ctx,
+					    list->name,
+					    list->parent,
+					    list->base_reg,
+					    list->rate_table,
+					    list->flags,
+					    lock);
+		if (IS_ERR(clk)) {
+			pr_err("failed to register clock %s\n", list->name);
+			continue;
+		}
+
+		visconti_pll_add_lookup(ctx, clk, list->id);
+	}
+}
+
+struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
+							void __iomem *base,
+							unsigned long nr_plls)
+{
+	struct visconti_pll_provider *ctx;
+	struct clk **clk_table;
+	int i;
+
+	ctx = kzalloc(sizeof(struct visconti_pll_provider), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	clk_table = kcalloc(nr_plls, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_table)
+		goto err;
+
+	for (i = 0; i < nr_plls; ++i)
+		clk_table[i] = ERR_PTR(-ENOENT);
+
+	ctx->node = np;
+	ctx->reg_base = base;
+	ctx->clk_data.clks = clk_table;
+	ctx->clk_data.clk_num = nr_plls;
+	//spin_lock_init(&ctx->lock);
+
+	return ctx;
+
+err:
+	kfree(ctx);
+	return ERR_PTR(-ENOMEM);
+}
diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
new file mode 100644
index 000000000000..794ce5a0093e
--- /dev/null
+++ b/drivers/clk/visconti/pll.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#ifndef _VISCONTI_PLL_H_
+#define _VISCONTI_PLL_H_
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+struct visconti_pll_provider {
+	void __iomem *reg_base;
+	struct regmap *regmap;
+	struct clk_onecell_data clk_data;
+	struct device_node *node;
+};
+
+#define VISCONTI_PLL_RATE(_rate, _dacen, _dsmen, \
+	_refdiv, _intin, _fracin, _postdiv1, _postdiv2) \
+{				\
+	.rate = _rate,		\
+	.dacen = _dacen,	\
+	.dsmen = _dsmen,	\
+	.refdiv = _refdiv,	\
+	.intin = _intin,	\
+	.fracin = _fracin,	\
+	.postdiv1 = _postdiv1,	\
+	.postdiv2 = _postdiv2	\
+}
+
+struct visconti_pll_rate_table {
+	unsigned long rate;
+	unsigned int dacen;
+	unsigned int dsmen;
+	unsigned int refdiv;
+	unsigned long intin;
+	unsigned long fracin;
+	unsigned int postdiv1;
+	unsigned int postdiv2;
+};
+
+struct visconti_pll_info {
+	unsigned int id;
+	const char *name;
+	const char *parent;
+	u8 flags;
+	unsigned long base_reg;
+	const struct visconti_pll_rate_table *rate_table;
+};
+
+struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np, void __iomem *base,
+							unsigned long nr_plls);
+void __init visconti_register_plls(struct visconti_pll_provider *ctx,
+				   const struct visconti_pll_info *list,
+				   unsigned int nr_plls, spinlock_t *lock);
+
+#endif /* _VISCONTI_PLL_H_ */
diff --git a/drivers/clk/visconti/reset.c b/drivers/clk/visconti/reset.c
new file mode 100644
index 000000000000..b7d59a471a85
--- /dev/null
+++ b/drivers/clk/visconti/reset.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti ARM SoC reset controller
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "reset.h"
+
+static inline struct visconti_reset *to_visconti_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct visconti_reset, rcdev);
+}
+
+static int visconti_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct visconti_reset *reset = to_visconti_reset(rcdev);
+	const struct visconti_reset_data *data = &reset->resets[id];
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(reset->lock, flags);
+	ret = regmap_update_bits(reset->regmap, data->rson_offset, data->rs_idx, 1);
+	spin_unlock_irqrestore(reset->lock, flags);
+
+	return ret;
+}
+
+static int visconti_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct visconti_reset *reset = to_visconti_reset(rcdev);
+	const struct visconti_reset_data *data = &reset->resets[id];
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(reset->lock, flags);
+	ret = regmap_update_bits(reset->regmap, data->rsoff_offset, data->rs_idx, 1);
+	spin_unlock_irqrestore(reset->lock, flags);
+
+	return ret;
+}
+
+static int visconti_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	visconti_reset_assert(rcdev, id);
+	udelay(1);
+	visconti_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
+static int visconti_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct visconti_reset *reset = to_visconti_reset(rcdev);
+	const struct visconti_reset_data *data = &reset->resets[id];
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(reset->lock, flags);
+	ret = regmap_read(reset->regmap, data->rson_offset, &reg);
+	spin_unlock_irqrestore(reset->lock, flags);
+	if (ret)
+		return ret;
+
+	return !(reg & data->rs_idx);
+}
+
+const struct reset_control_ops visconti_reset_ops = {
+	.assert		= visconti_reset_assert,
+	.deassert	= visconti_reset_deassert,
+	.reset		= visconti_reset_reset,
+	.status		= visconti_reset_status,
+};
+
+int visconti_register_reset_controller(struct device_node *np, struct regmap *regmap,
+				       const struct visconti_reset_data *resets,
+				       unsigned int num_resets,
+				       const struct reset_control_ops *reset_ops,
+				       spinlock_t *lock)
+{
+	int ret;
+	struct visconti_reset *reset;
+
+	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->regmap = regmap;
+	reset->resets = resets;
+	reset->rcdev.ops = reset_ops;
+	reset->rcdev.nr_resets = num_resets;
+	reset->rcdev.of_node = np;
+	reset->lock = lock;
+
+	ret = reset_controller_register(&reset->rcdev);
+	if (ret) {
+		pr_err("could not register reset controller: %d\n", ret);
+		kfree(reset);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/visconti/reset.h b/drivers/clk/visconti/reset.h
new file mode 100644
index 000000000000..521305caa6fa
--- /dev/null
+++ b/drivers/clk/visconti/reset.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Toshiba ARM SoC reset controller driver
+ *
+ * Copyright (c) 2021 TOSHIBA CORPORATION
+ *
+ * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+#ifndef _VISCONTI_RESET_H_
+#define _VISCONTI_RESET_H_
+
+#include <linux/reset-controller.h>
+
+struct visconti_reset_data {
+	u32	rson_offset;
+	u32	rsoff_offset;
+	u8	rs_idx;
+};
+
+struct visconti_reset {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+	const struct visconti_reset_data *resets;
+	spinlock_t *lock;
+};
+
+extern const struct reset_control_ops visconti_reset_ops;
+
+int visconti_register_reset_controller(struct device_node *np, struct regmap *regmap,
+				       const struct visconti_reset_data *resets,
+				       unsigned int num_resets,
+				       const struct reset_control_ops *reset_ops,
+				       spinlock_t *lock);
+#endif /* _VISCONTI_RESET_H_ */
diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
new file mode 100644
index 000000000000..923b47a11730
--- /dev/null
+++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
+#define _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
+
+/* PLL */
+#define TMPV770X_PLL_PIPLL0		0
+#define TMPV770X_PLL_PIPLL1		1
+#define TMPV770X_PLL_PIDNNPLL		2
+#define TMPV770X_PLL_PIETHERPLL		3
+#define TMPV770X_PLL_PIDDRCPLL		4
+#define TMPV770X_PLL_PIVOIFPLL		5
+#define TMPV770X_PLL_PIIMGERPLL		6
+#define TMPV770X_NR_PLL		7
+
+/* Clocks */
+#define TMPV770X_CLK_PIPLL1_DIV1	0
+#define TMPV770X_CLK_PIPLL1_DIV2	1
+#define TMPV770X_CLK_PIPLL1_DIV4	2
+#define TMPV770X_CLK_PIDNNPLL_DIV1	3
+#define TMPV770X_CLK_DDRC_PHY_PLL0	4
+#define TMPV770X_CLK_DDRC_PHY_PLL1	5
+#define TMPV770X_CLK_D_PHYPLL		6
+#define TMPV770X_CLK_PHY_PCIEPLL	7
+#define TMPV770X_CLK_CA53CL0		8
+#define TMPV770X_CLK_CA53CL1		9
+#define TMPV770X_CLK_PISDMAC		10
+#define TMPV770X_CLK_PIPDMAC0		11
+#define TMPV770X_CLK_PIPDMAC1		12
+#define TMPV770X_CLK_PIWRAM		13
+#define TMPV770X_CLK_DDRC0		14
+#define TMPV770X_CLK_DDRC0_SCLK		15
+#define TMPV770X_CLK_DDRC0_NCLK		16
+#define TMPV770X_CLK_DDRC0_MCLK		17
+#define TMPV770X_CLK_DDRC0_APBCLK	18
+#define TMPV770X_CLK_DDRC1		19
+#define TMPV770X_CLK_DDRC1_SCLK		20
+#define TMPV770X_CLK_DDRC1_NCLK		21
+#define TMPV770X_CLK_DDRC1_MCLK		22
+#define TMPV770X_CLK_DDRC1_APBCLK	23
+#define TMPV770X_CLK_HOX		24
+#define TMPV770X_CLK_PCIE_MSTR		25
+#define TMPV770X_CLK_PCIE_AUX		26
+#define TMPV770X_CLK_PIINTC		27
+#define TMPV770X_CLK_PIETHER_BUS	28
+#define TMPV770X_CLK_PISPI0		29
+#define TMPV770X_CLK_PISPI1		30
+#define TMPV770X_CLK_PISPI2		31
+#define TMPV770X_CLK_PISPI3		32
+#define TMPV770X_CLK_PISPI4		33
+#define TMPV770X_CLK_PISPI5		34
+#define TMPV770X_CLK_PISPI6		35
+#define TMPV770X_CLK_PIUART0		36
+#define TMPV770X_CLK_PIUART1		37
+#define TMPV770X_CLK_PIUART2		38
+#define TMPV770X_CLK_PIUART3		39
+#define TMPV770X_CLK_PII2C0		40
+#define TMPV770X_CLK_PII2C1		41
+#define TMPV770X_CLK_PII2C2		42
+#define TMPV770X_CLK_PII2C3		43
+#define TMPV770X_CLK_PII2C4		44
+#define TMPV770X_CLK_PII2C5		45
+#define TMPV770X_CLK_PII2C6		46
+#define TMPV770X_CLK_PII2C7		47
+#define TMPV770X_CLK_PII2C8		48
+#define TMPV770X_CLK_PIGPIO		49
+#define TMPV770X_CLK_PIPGM		50
+#define TMPV770X_CLK_PIPCMIF		51
+#define TMPV770X_CLK_PIPCMIF_AUDIO_O	52
+#define TMPV770X_CLK_PIPCMIF_AUDIO_I	53
+#define TMPV770X_CLK_PICMPT0		54
+#define TMPV770X_CLK_PICMPT1		55
+#define TMPV770X_CLK_PITSC		56
+#define TMPV770X_CLK_PIUWDT		57
+#define TMPV770X_CLK_PISWDT		58
+#define TMPV770X_CLK_WDTCLK		59
+#define TMPV770X_CLK_PISUBUS_150M	60
+#define TMPV770X_CLK_PISUBUS_300M	61
+#define TMPV770X_CLK_PIPMU		62
+#define TMPV770X_CLK_PIGPMU		63
+#define TMPV770X_CLK_PITMU		64
+#define TMPV770X_CLK_WRCK		65
+#define TMPV770X_CLK_PIEMM		66
+#define TMPV770X_CLK_PIMISC		67
+#define TMPV770X_CLK_PIGCOMM		68
+#define TMPV770X_CLK_PIDCOMM		69
+#define TMPV770X_CLK_PICKMON		70
+#define TMPV770X_CLK_PIMBUS		71
+#define TMPV770X_CLK_SBUSCLK		72
+#define TMPV770X_CLK_DDR0_APBCLKCLK	73
+#define TMPV770X_CLK_DDR1_APBCLKCLK	74
+#define TMPV770X_CLK_DSP0_PBCLK		75
+#define TMPV770X_CLK_DSP1_PBCLK		76
+#define TMPV770X_CLK_DSP2_PBCLK		77
+#define TMPV770X_CLK_DSP3_PBCLK		78
+#define TMPV770X_CLK_DSVIIF0_APBCLK	79
+#define TMPV770X_CLK_VIIF0_APBCLK	80
+#define TMPV770X_CLK_VIIF0_CFGCLK	81
+#define TMPV770X_CLK_VIIF1_APBCLK	82
+#define TMPV770X_CLK_VIIF1_CFGCLK	83
+#define TMPV770X_CLK_VIIF2_APBCLK	84
+#define TMPV770X_CLK_VIIF2_CFGCLK	85
+#define TMPV770X_CLK_VIIF3_APBCLK	86
+#define TMPV770X_CLK_VIIF3_CFGCLK	87
+#define TMPV770X_CLK_VIIF4_APBCLK	88
+#define TMPV770X_CLK_VIIF4_CFGCLK	89
+#define TMPV770X_CLK_VIIF5_APBCLK	90
+#define TMPV770X_CLK_VIIF5_CFGCLK	91
+#define TMPV770X_CLK_VOIF_SBUSCLK	92
+#define TMPV770X_CLK_VOIF_PROCCLK	93
+#define TMPV770X_CLK_VOIF_DPHYCFGCLK	94
+#define TMPV770X_CLK_DNN0		95
+#define TMPV770X_CLK_STMAT		96
+#define TMPV770X_CLK_HWA0		97
+#define TMPV770X_CLK_AFFINE0		98
+#define TMPV770X_CLK_HAMAT		99
+#define TMPV770X_CLK_SMLDB		100
+#define TMPV770X_CLK_HWA0_ASYNC		101
+#define TMPV770X_CLK_HWA2		102
+#define TMPV770X_CLK_FLMAT		103
+#define TMPV770X_CLK_PYRAMID		104
+#define TMPV770X_CLK_HWA2_ASYNC		105
+#define TMPV770X_CLK_DSP0		106
+#define TMPV770X_CLK_VIIFBS0		107
+#define TMPV770X_CLK_VIIFBS0_L2ISP	108
+#define TMPV770X_CLK_VIIFBS0_L1ISP	109
+#define TMPV770X_CLK_VIIFBS0_PROC	110
+#define TMPV770X_CLK_VIIFBS1		111
+#define TMPV770X_CLK_VIIFBS2		112
+#define TMPV770X_CLK_VIIFOP_MBUS	113
+#define TMPV770X_CLK_VIIFOP0_PROC	114
+#define TMPV770X_CLK_PIETHER_2P5M	115
+#define TMPV770X_CLK_PIETHER_25M	116
+#define TMPV770X_CLK_PIETHER_50M	117
+#define TMPV770X_CLK_PIETHER_125M	118
+#define TMPV770X_CLK_VOIF0_DPHYCFG	119
+#define TMPV770X_CLK_VOIF0_PROC		120
+#define TMPV770X_CLK_VOIF0_SBUS		121
+#define TMPV770X_CLK_VOIF0_DSIREF	122
+#define TMPV770X_CLK_VOIF0_PIXEL	123
+#define TMPV770X_CLK_PIREFCLK		124
+#define TMPV770X_CLK_SBUS		125
+#define TMPV770X_CLK_BUSLCK		126
+#define TMPV770X_NR_CLK			127
+
+/* Reset */
+#define TMPV770X_RESET_PIETHER_2P5M	0
+#define TMPV770X_RESET_PIETHER_25M	1
+#define TMPV770X_RESET_PIETHER_50M	2
+#define TMPV770X_RESET_PIETHER_125M	3
+#define TMPV770X_RESET_HOX		4
+#define TMPV770X_RESET_PCIE_MSTR	5
+#define TMPV770X_RESET_PCIE_AUX		6
+#define TMPV770X_RESET_PIINTC		7
+#define TMPV770X_RESET_PIETHER_BUS	8
+#define TMPV770X_RESET_PISPI0		9
+#define TMPV770X_RESET_PISPI1		10
+#define TMPV770X_RESET_PISPI2		11
+#define TMPV770X_RESET_PISPI3		12
+#define TMPV770X_RESET_PISPI4		13
+#define TMPV770X_RESET_PISPI5		14
+#define TMPV770X_RESET_PISPI6		15
+#define TMPV770X_RESET_PIUART0		16
+#define TMPV770X_RESET_PIUART1		17
+#define TMPV770X_RESET_PIUART2		18
+#define TMPV770X_RESET_PIUART3		19
+#define TMPV770X_RESET_PII2C0		20
+#define TMPV770X_RESET_PII2C1		21
+#define TMPV770X_RESET_PII2C2		22
+#define TMPV770X_RESET_PII2C3		23
+#define TMPV770X_RESET_PII2C4		24
+#define TMPV770X_RESET_PII2C5		25
+#define TMPV770X_RESET_PII2C6		26
+#define TMPV770X_RESET_PII2C7		27
+#define TMPV770X_RESET_PII2C8		28
+#define TMPV770X_RESET_PIPCMIF		29
+#define TMPV770X_RESET_PICKMON		30
+#define TMPV770X_RESET_SBUSCLK		31
+#define TMPV770X_NR_RESET		32
+
+#endif /*_DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_ */
diff --git a/include/dt-bindings/reset/toshiba,tmpv770x.h b/include/dt-bindings/reset/toshiba,tmpv770x.h
new file mode 100644
index 000000000000..080de7e69e68
--- /dev/null
+++ b/include/dt-bindings/reset/toshiba,tmpv770x.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
+#define _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
+
+/* Reset */
+#define TMPV770X_RESET_PIETHER_2P5M	0
+#define TMPV770X_RESET_PIETHER_25M	1
+#define TMPV770X_RESET_PIETHER_50M	2
+#define TMPV770X_RESET_PIETHER_125M	3
+#define TMPV770X_RESET_HOX		4
+#define TMPV770X_RESET_PCIE_MSTR	5
+#define TMPV770X_RESET_PCIE_AUX		6
+#define TMPV770X_RESET_PIINTC		7
+#define TMPV770X_RESET_PIETHER_BUS	8
+#define TMPV770X_RESET_PISPI0		9
+#define TMPV770X_RESET_PISPI1		10
+#define TMPV770X_RESET_PISPI2		11
+#define TMPV770X_RESET_PISPI3		12
+#define TMPV770X_RESET_PISPI4		13
+#define TMPV770X_RESET_PISPI5		14
+#define TMPV770X_RESET_PISPI6		15
+#define TMPV770X_RESET_PIUART0		16
+#define TMPV770X_RESET_PIUART1		17
+#define TMPV770X_RESET_PIUART2		18
+#define TMPV770X_RESET_PIUART3		19
+#define TMPV770X_RESET_PII2C0		20
+#define TMPV770X_RESET_PII2C1		21
+#define TMPV770X_RESET_PII2C2		22
+#define TMPV770X_RESET_PII2C3		23
+#define TMPV770X_RESET_PII2C4		24
+#define TMPV770X_RESET_PII2C5		25
+#define TMPV770X_RESET_PII2C6		26
+#define TMPV770X_RESET_PII2C7		27
+#define TMPV770X_RESET_PII2C8		28
+#define TMPV770X_RESET_PIPCMIF		29
+#define TMPV770X_RESET_PICKMON		30
+#define TMPV770X_RESET_SBUSCLK		31
+#define TMPV770X_NR_RESET		32
+
+#endif /*_DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_ */
-- 
2.31.1

