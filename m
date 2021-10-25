Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A93C438DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhJYDNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:13:43 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:57104 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhJYDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:13:24 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 19P3AlTa015741; Mon, 25 Oct 2021 12:10:47 +0900
X-Iguazu-Qid: 2wGrDIThyzSZ2mL0D7
X-Iguazu-QSIG: v=2; s=0; t=1635131446; q=2wGrDIThyzSZ2mL0D7; m=n7t5O9mvBwiqW/HjKTYYm6E4SgdPCVBaWkklcAeeYfA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 19P3AiqE037157
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 12:10:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id DB7711000CA;
        Mon, 25 Oct 2021 12:10:44 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 19P3Aihl004088;
        Mon, 25 Oct 2021 12:10:44 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v5 3/4] clk: visconti: Add support common clock driver and reset driver
Date:   Mon, 25 Oct 2021 12:10:37 +0900
X-TSB-HOP: ON
Message-Id: <20211025031038.4180686-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for common interface of the common clock and reset driver
for Toshiba Visconti5 and its SoC, TMPV7708. The PIPLLCT provides the PLL,
and the PISMU provides clock and reset functionality.
Each drivers are provided in this patch.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---

    v4 -> v5:
      - Makefile/Kconfig
        Update Kconfig with using COMPILE_TEST
      - clkc-tmpv770x.c
        Fix location of include file.
        Fix to use clk-provider.h.
        Update clock flags in pietherpll_clk_gate_tables and others.
        Use lowercase hex.
        Update to use syscon.
        Update to use platform driver instead of CLK_OF_DECLARE_DRIVER.
      - clkc.c
        Fix check of visconti_gate_clk_is_enabled.
        Drop visconti_gate_clk_is_enabled in visconti_gate_clk_enable().
        Drop unnecessary comment.
        Update to use clk_parent_data instead of parent_names.
        Update to use devm_clk_hw_register().
        Update to use struct device in visconti_clk_register_gate().
        Update to get structure size from pointer with sizeof().
      - clkc.h
        Update struct visconti_clk_gate_table to using struct clk_parent_data.
        Drop flags in struct visconti_clk_gate.
      - pll-tmpv770x.c
        Use lowercase hex.
        Update to use platform driver instead of CLK_OF_DECLARE_DRIVER.
        Update to use size_t in visconti_pll and move position.
        Update use FIELD_GET().
        Drop braces.
        Use const point in visconti_get_pll_rate_from_data().
        Update to comparison by memcmp in visconti_get_pll_rate_from_data().
        Drop unnecessary comment.
        Drop unnecessary print.
        Drop unnecessary lock and unlock.
        Drop visconti_pll_is_enabled in visconti_pll_enable().
        Drop unused flags.
        Update to use clk_hw_register().
        Drop to use kmemdup().
      - pll.h
        Drop __init.
    v3 -> v4:
       - Remove osc2 clock's code. Move to DT.
    v2 -> v3:
       - Fix return value in visconti_register_pll().
       - Remove initialization of flags used by spin_lock_irqsave().
       - - Change function name from *7708* to *770x*.
       - Fix some coding style.
    v1 -> v2:
       - Fix warning with W=1


 drivers/clk/Kconfig                  |   1 +
 drivers/clk/Makefile                 |   1 +
 drivers/clk/visconti/Kconfig         |   9 +
 drivers/clk/visconti/Makefile        |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c | 291 +++++++++++++++++++++++
 drivers/clk/visconti/clkc.c          | 206 ++++++++++++++++
 drivers/clk/visconti/clkc.h          |  76 ++++++
 drivers/clk/visconti/pll-tmpv770x.c  |  85 +++++++
 drivers/clk/visconti/pll.c           | 339 +++++++++++++++++++++++++++
 drivers/clk/visconti/pll.h           |  62 +++++
 drivers/clk/visconti/reset.c         | 107 +++++++++
 drivers/clk/visconti/reset.h         |  36 +++
 12 files changed, 1218 insertions(+)
 create mode 100644 drivers/clk/visconti/Kconfig
 create mode 100644 drivers/clk/visconti/Makefile
 create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
 create mode 100644 drivers/clk/visconti/clkc.c
 create mode 100644 drivers/clk/visconti/clkc.h
 create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
 create mode 100644 drivers/clk/visconti/pll.c
 create mode 100644 drivers/clk/visconti/pll.h
 create mode 100644 drivers/clk/visconti/reset.c
 create mode 100644 drivers/clk/visconti/reset.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c5b3dc97396a..5fb34467f404 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -417,6 +417,7 @@ source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
+source "drivers/clk/visconti/Kconfig"
 source "drivers/clk/x86/Kconfig"
 source "drivers/clk/xilinx/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e42312121e51..4271fffc87a2 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -116,6 +116,7 @@ obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-y					+= versatile/
+obj-$(CONFIG_COMMON_CLK_VISCONTI)	+= visconti/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_X86)			+= x86/
 endif
diff --git a/drivers/clk/visconti/Kconfig b/drivers/clk/visconti/Kconfig
new file mode 100644
index 000000000000..1661097b0d92
--- /dev/null
+++ b/drivers/clk/visconti/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMMON_CLK_VISCONTI
+	bool "Support for Toshiba Visconti5 ARM SoC clock controllers"
+	depends on ARCH_VISCONTI || COMPILE_TEST
+	default ARCH_VISCONTI
+	help
+	  Support for the Toshiba Visconti5 ARM SoC clock controller.
+	  Say Y if you want to include clock support.
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
index 000000000000..c2b2f41a85a4
--- /dev/null
+++ b/drivers/clk/visconti/clkc-tmpv770x.c
@@ -0,0 +1,291 @@
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
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/toshiba,tmpv770x.h>
+#include <dt-bindings/reset/toshiba,tmpv770x.h>
+
+#include "clkc.h"
+#include "reset.h"
+
+static DEFINE_SPINLOCK(tmpv770x_clk_lock);
+static DEFINE_SPINLOCK(tmpv770x_rst_lock);
+
+static const struct clk_parent_data clks_parent_data[] = {
+	{ .fw_name = "pipll1", .name = "pipll1", },
+};
+
+static const struct clk_parent_data pietherplls_parent_data[] = {
+	{ .fw_name = "pietherpll", .name = "pietherpll", },
+};
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
+	{ TMPV770X_CLK_PIREFCLK, "pirefclk", "osc2-clk", 0, 1, 1, },
+	{ TMPV770X_CLK_WDTCLK, "wdtclk", "osc2-clk", 0, 1, 1, },
+};
+
+static const struct visconti_clk_gate_table pietherpll_clk_gate_tables[] = {
+	/* pietherpll */
+	{ TMPV770X_CLK_PIETHER_2P5M, "piether_2p5m",
+		pietherplls_parent_data, ARRAY_SIZE(pietherplls_parent_data),
+		CLK_SET_RATE_PARENT, 0x34, 0x134, 4, 200,
+		TMPV770X_RESET_PIETHER_2P5M, },
+	{ TMPV770X_CLK_PIETHER_25M, "piether_25m",
+		pietherplls_parent_data, ARRAY_SIZE(pietherplls_parent_data),
+		CLK_SET_RATE_PARENT, 0x34, 0x134, 5, 20,
+		TMPV770X_RESET_PIETHER_25M, },
+	{ TMPV770X_CLK_PIETHER_50M, "piether_50m",
+		pietherplls_parent_data, ARRAY_SIZE(pietherplls_parent_data),
+		CLK_SET_RATE_PARENT, 0x34, 0x134, 6, 10,
+		TMPV770X_RESET_PIETHER_50M, },
+	{ TMPV770X_CLK_PIETHER_125M, "piether_125m",
+		pietherplls_parent_data, ARRAY_SIZE(pietherplls_parent_data),
+		CLK_SET_RATE_PARENT, 0x34, 0x134, 7, 4,
+		TMPV770X_RESET_PIETHER_125M, },
+};
+
+static const struct visconti_clk_gate_table clk_gate_tables[] = {
+	{ TMPV770X_CLK_HOX, "hox",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x4c, 0x14c, 0, 1,
+		TMPV770X_RESET_HOX, },
+	{ TMPV770X_CLK_PCIE_MSTR, "pcie_mstr",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 0, 1,
+		TMPV770X_RESET_PCIE_MSTR, },
+	{ TMPV770X_CLK_PCIE_AUX, "pcie_aux",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 1, 24,
+		TMPV770X_RESET_PCIE_AUX, },
+	{ TMPV770X_CLK_PIINTC, "piintc",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		CLK_IGNORE_UNUSED, 0x8, 0x108, 0, 2, //FIX!!
+		TMPV770X_RESET_PIINTC,},
+	{ TMPV770X_CLK_PIETHER_BUS, "piether_bus",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x34, 0x134, 0, 2,
+		TMPV770X_RESET_PIETHER_BUS, }, /* BUS_CLK */
+	{ TMPV770X_CLK_PISPI0, "pispi0",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 0, 2,
+		TMPV770X_RESET_PISPI0, },
+	{ TMPV770X_CLK_PISPI1, "pispi1",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 1, 2,
+		TMPV770X_RESET_PISPI1, },
+	{ TMPV770X_CLK_PISPI2, "pispi2",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 2, 2,
+		TMPV770X_RESET_PISPI2, },
+	{ TMPV770X_CLK_PISPI3, "pispi3",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 3, 2,
+		TMPV770X_RESET_PISPI3,},
+	{ TMPV770X_CLK_PISPI4, "pispi4",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 4, 2,
+		TMPV770X_RESET_PISPI4, },
+	{ TMPV770X_CLK_PISPI5, "pispi5",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 5, 2,
+		TMPV770X_RESET_PISPI5},
+	{ TMPV770X_CLK_PISPI6, "pispi6",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x28, 0x128, 6, 2,
+		TMPV770X_RESET_PISPI6,},
+	{ TMPV770X_CLK_PIUART0, "piuart0",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		//CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2c, 0x12c, 0, 4,
+		0, 0x2c, 0x12c, 0, 4,
+		TMPV770X_RESET_PIUART0,},
+	{ TMPV770X_CLK_PIUART1, "piuart1",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		//CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2c, 0x12c, 1, 4,
+		0, 0x2c, 0x12c, 1, 4,
+		TMPV770X_RESET_PIUART1, },
+	{ TMPV770X_CLK_PIUART2, "piuart2",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x2c, 0x12c, 2, 4,
+		TMPV770X_RESET_PIUART2, },
+	{ TMPV770X_CLK_PIUART3, "piuart3",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x2c, 0x12c, 3, 4,
+		TMPV770X_RESET_PIUART3, },
+	{ TMPV770X_CLK_PII2C0, "pii2c0",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 0, 4,
+		TMPV770X_RESET_PII2C0, },
+	{ TMPV770X_CLK_PII2C1, "pii2c1",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 1, 4,
+		TMPV770X_RESET_PII2C1, },
+	{ TMPV770X_CLK_PII2C2, "pii2c2",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 2, 4,
+		TMPV770X_RESET_PII2C2, },
+	{ TMPV770X_CLK_PII2C3, "pii2c3",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 3, 4,
+		TMPV770X_RESET_PII2C3,},
+	{ TMPV770X_CLK_PII2C4, "pii2c4",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 4, 4,
+		TMPV770X_RESET_PII2C4, },
+	{ TMPV770X_CLK_PII2C5, "pii2c5",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 5, 4,
+		TMPV770X_RESET_PII2C5, },
+	{ TMPV770X_CLK_PII2C6, "pii2c6",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 6, 4,
+		TMPV770X_RESET_PII2C6, },
+	{ TMPV770X_CLK_PII2C7, "pii2c7",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 7, 4,
+		TMPV770X_RESET_PII2C7, },
+	{ TMPV770X_CLK_PII2C8, "pii2c8",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x30, 0x130, 8, 4,
+		TMPV770X_RESET_PII2C8, },
+	/* PIPCMIF */
+	{ TMPV770X_CLK_PIPCMIF, "pipcmif",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x64, 0x164, 0, 4,
+		TMPV770X_RESET_PIPCMIF, },
+	/* PISYSTEM */
+	{ TMPV770X_CLK_WRCK, "wrck",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x68, 0x168, 9, 32,
+		-1, }, /* No reset */
+	{ TMPV770X_CLK_PICKMON, "pickmon",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x10, 0x110, 8, 4,
+		TMPV770X_RESET_PICKMON, },
+	{ TMPV770X_CLK_SBUSCLK, "sbusclk",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x14, 0x114, 0, 4,
+		TMPV770X_RESET_SBUSCLK, },
+};
+
+static const struct visconti_reset_data clk_reset_data[] = {
+	[TMPV770X_RESET_PIETHER_2P5M]	= { 0x434, 0x534, 4, },
+	[TMPV770X_RESET_PIETHER_25M]	= { 0x434, 0x534, 5, },
+	[TMPV770X_RESET_PIETHER_50M]	= { 0x434, 0x534, 6, },
+	[TMPV770X_RESET_PIETHER_125M]	= { 0x434, 0x534, 7, },
+	[TMPV770X_RESET_HOX]		= { 0x44c, 0x54c, 0, },
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
+	[TMPV770X_RESET_PIUART0]	= { 0x42c, 0x52c, 0, },
+	[TMPV770X_RESET_PIUART1]	= { 0x42c, 0x52c, 1, },
+	[TMPV770X_RESET_PIUART2]	= { 0x42c, 0x52c, 2, },
+	[TMPV770X_RESET_PIUART3]	= { 0x42c, 0x52c, 3, },
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
+static int visconti_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct visconti_clk_provider *ctx;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret, i;
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ctx = visconti_init_clk(dev, regmap, TMPV770X_NR_CLK);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = visconti_register_reset_controller(dev, regmap, clk_reset_data,
+						 TMPV770X_NR_RESET,
+						 &visconti_reset_ops,
+						 &tmpv770x_rst_lock);
+	if (ret) {
+		dev_err(dev, "Failed to register reset controller: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < (ARRAY_SIZE(fixed_clk_tables)); i++)
+		ctx->clk_data.hws[fixed_clk_tables[i].id] =
+			clk_hw_register_fixed_factor(NULL,
+						     fixed_clk_tables[i].name,
+						     fixed_clk_tables[i].parent,
+						     fixed_clk_tables[i].flag,
+						     fixed_clk_tables[i].mult,
+						     fixed_clk_tables[i].div);
+
+	ret = visconti_clk_register_gates(ctx, clk_gate_tables,
+				    ARRAY_SIZE(clk_gate_tables), clk_reset_data,
+				    &tmpv770x_clk_lock);
+	if (ret) {
+		dev_err(dev, "Failed to register main clock gate: %d\n", ret);
+		return ret;
+	}
+
+	ret = visconti_clk_register_gates(ctx, pietherpll_clk_gate_tables,
+				    ARRAY_SIZE(pietherpll_clk_gate_tables),
+				    clk_reset_data, &tmpv770x_clk_lock);
+	if (ret) {
+		dev_err(dev, "Failed to register pietherpll clock gate: %d\n", ret);
+		return ret;
+	}
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &ctx->clk_data);
+}
+
+static const struct of_device_id visconti_clk_ids[] = {
+	{ .compatible = "toshiba,tmpv7708-pismu", },
+	{ }
+};
+
+static struct platform_driver visconti_clk_driver = {
+	.probe  = visconti_clk_probe,
+	.driver = {
+		.name   = "visconti-clk",
+		.of_match_table = visconti_clk_ids,
+	},
+};
+
+builtin_platform_driver(visconti_clk_driver);
diff --git a/drivers/clk/visconti/clkc.c b/drivers/clk/visconti/clkc.c
new file mode 100644
index 000000000000..56a8a4ffebca
--- /dev/null
+++ b/drivers/clk/visconti/clkc.c
@@ -0,0 +1,206 @@
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
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
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
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (!visconti_gate_clk_is_enabled(hw)) {
+		spin_unlock_irqrestore(gate->lock, flags);
+		return;
+	}
+
+	regmap_update_bits(gate->regmap, gate->ckoff_offset, clk, clk);
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int visconti_gate_clk_enable(struct clk_hw *hw)
+{
+	struct visconti_clk_gate *gate = to_visconti_clk_gate(hw);
+	u32 clk = BIT(gate->ck_idx);
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+	regmap_update_bits(gate->regmap, gate->ckon_offset, clk, clk);
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
+	struct clk_parent_data *pdata;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->name = pdata->fw_name = parent_name;
+
+	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &visconti_clk_gate_ops;
+	init.flags = clks->flags;
+	init.parent_data = pdata;
+	init.num_parents = 1;
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
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		hw = ERR_PTR(ret);
+
+	return hw;
+}
+
+int visconti_clk_register_gates(struct visconti_clk_provider *ctx,
+				const struct visconti_clk_gate_table *clks,
+				int num_gate,
+				const struct visconti_reset_data *reset,
+				spinlock_t *lock)
+{
+	struct device *dev = ctx->dev;
+	int i;
+
+	for (i = 0; i < num_gate; i++) {
+		const char *parent_div_name = clks[i].parent_data[0].name;
+		struct clk_parent_data *pdata;
+		u32 rson_offset, rsoff_offset;
+		struct clk_hw *gate_clk;
+		struct clk_hw *div_clk;
+		char *dev_name;
+		u8 rs_idx;
+
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s_div", clks[i].name);
+		if (!dev_name)
+			return -ENOMEM;
+
+		if (clks[i].rs_id >= 0) {
+			rson_offset = reset[clks[i].rs_id].rson_offset;
+			rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
+			rs_idx = reset[clks[i].rs_id].rs_idx;
+		} else {
+			rson_offset = rsoff_offset = rs_idx = -1;
+		}
+
+		div_clk = devm_clk_hw_register_fixed_factor(dev,
+							    dev_name,
+							    parent_div_name,
+							    0, 1,
+							    clks[i].div);
+		if (IS_ERR(div_clk))
+			return PTR_ERR(div_clk);
+
+		gate_clk = visconti_clk_register_gate(dev,
+						      clks[i].name,
+						      dev_name,
+						      ctx->regmap,
+						      &clks[i],
+						      rson_offset,
+						      rsoff_offset,
+						      rs_idx,
+						      lock);
+		if (IS_ERR(gate_clk)) {
+			dev_err(dev, "%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			return PTR_ERR(gate_clk);
+		}
+
+		ctx->clk_data.hws[clks[i].id] = gate_clk;
+	}
+
+	return 0;
+}
+
+struct visconti_clk_provider *visconti_init_clk(struct device *dev,
+						struct regmap *regmap,
+						unsigned long nr_clks)
+{
+	struct visconti_clk_provider *ctx;
+	int i;
+
+	ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_clks; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+	ctx->clk_data.num = nr_clks;
+
+	ctx->dev = dev;
+	ctx->regmap = regmap;
+
+	return ctx;
+}
diff --git a/drivers/clk/visconti/clkc.h b/drivers/clk/visconti/clkc.h
new file mode 100644
index 000000000000..09ed82ff64e4
--- /dev/null
+++ b/drivers/clk/visconti/clkc.h
@@ -0,0 +1,76 @@
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
+#ifndef _VISCONTI_CLKC_H_
+#define _VISCONTI_CLKC_H_
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
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct clk_hw_onecell_data clk_data;
+};
+
+struct visconti_clk_gate_table {
+	unsigned int	id;
+	const char	*name;
+	const struct clk_parent_data *parent_data;
+	u8		num_parents;
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
+struct visconti_clk_provider *visconti_init_clk(struct device *dev,
+						struct regmap *regmap,
+						unsigned long nr_clks);
+int visconti_clk_register_gates(struct visconti_clk_provider *data,
+				 const struct visconti_clk_gate_table *clks,
+				 int num_gate,
+				 const struct visconti_reset_data *reset,
+				 spinlock_t *lock);
+#endif /* _VISCONTI_CLKC_H_ */
diff --git a/drivers/clk/visconti/pll-tmpv770x.c b/drivers/clk/visconti/pll-tmpv770x.c
new file mode 100644
index 000000000000..8360ccf88867
--- /dev/null
+++ b/drivers/clk/visconti/pll-tmpv770x.c
@@ -0,0 +1,85 @@
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
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/toshiba,tmpv770x.h>
+
+#include "pll.h"
+
+static DEFINE_SPINLOCK(tmpv770x_pll_lock);
+
+static const struct visconti_pll_rate_table pipll0_rates[] __initconst = {
+	VISCONTI_PLL_RATE(840000000, 0x1, 0x0, 0x1, 0x54, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4e, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(600000000, 0x1, 0x0, 0x1, 0x3c, 0x000000, 0x2, 0x1),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_rate_table piddrcpll_rates[] __initconst = {
+	VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4e, 0x000000, 0x2, 0x1),
+	VISCONTI_PLL_RATE(760000000, 0x1, 0x0, 0x1, 0x4c, 0x000000, 0x2, 0x1),
+	{ /* sentinel */ },
+};
+
+static const struct visconti_pll_rate_table pivoifpll_rates[] __initconst = {
+	VISCONTI_PLL_RATE(165000000, 0x1, 0x0, 0x1, 0x42, 0x000000, 0x4, 0x2),
+	VISCONTI_PLL_RATE(148500000, 0x1, 0x1, 0x1, 0x3b, 0x666666, 0x4, 0x2),
+	VISCONTI_PLL_RATE(96000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x2),
+	VISCONTI_PLL_RATE(74250000, 0x1, 0x1, 0x1, 0x3b, 0x666666, 0x4, 0x4),
+	VISCONTI_PLL_RATE(54000000, 0x1, 0x0, 0x1, 0x36, 0x000000, 0x5, 0x4),
+	VISCONTI_PLL_RATE(48000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0x4),
+	VISCONTI_PLL_RATE(35750000, 0x1, 0x1, 0x1, 0x32, 0x0ccccc, 0x7, 0x4),
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
+	{ TMPV770X_PLL_PIPLL0, "pipll0", "osc2-clk", 0x0, pipll0_rates },
+	{ TMPV770X_PLL_PIDDRCPLL, "piddrcpll", "osc2-clk", 0x500, piddrcpll_rates },
+	{ TMPV770X_PLL_PIVOIFPLL, "pivoifpll", "osc2-clk", 0x600, pivoifpll_rates },
+	{ TMPV770X_PLL_PIIMGERPLL, "piimgerpll", "osc2-clk", 0x700, piimgerpll_rates },
+};
+
+static void __init tmpv770x_setup_plls(struct device_node *np)
+{
+	struct visconti_pll_provider *ctx;
+	void __iomem *reg_base;
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
+	ctx->clk_data.hws[TMPV770X_PLL_PIPLL1] =
+		clk_hw_register_fixed_rate(NULL, "pipll1", NULL, 0, 600000000);
+	ctx->clk_data.hws[TMPV770X_PLL_PIDNNPLL] =
+		clk_hw_register_fixed_rate(NULL, "pidnnpll", NULL, 0, 500000000);
+	ctx->clk_data.hws[TMPV770X_PLL_PIETHERPLL] =
+		clk_hw_register_fixed_rate(NULL, "pietherpll", NULL, 0, 500000000);
+
+	visconti_register_plls(ctx, pll_info, ARRAY_SIZE(pll_info), &tmpv770x_pll_lock);
+}
+
+CLK_OF_DECLARE(tmpv770x_plls, "toshiba,tmpv7708-pipllct", tmpv770x_setup_plls);
diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
new file mode 100644
index 000000000000..5b5c6bd003bc
--- /dev/null
+++ b/drivers/clk/visconti/pll.c
@@ -0,0 +1,339 @@
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
+	unsigned long flags;
+	const struct visconti_pll_rate_table *rate_table;
+	size_t rate_count;
+	struct visconti_pll_provider *ctx;
+};
+
+#define PLL_CONF_REG		0x0000
+#define PLL_CTRL_REG		0x0004
+#define PLL_FRACMODE_REG	0x0010
+#define PLL_INTIN_REG		0x0014
+#define PLL_FRACIN_REG		0x0018
+#define PLL_REFDIV_REG		0x001c
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
+#define PLL0_FRACMODE_DACEN	BIT(4)
+#define PLL0_FRACMODE_DSMEN	BIT(0)
+
+#define PLL_CREATE_FRACMODE(table) (table->dacen << 4 | table->dsmen)
+#define PLL_CREATE_OSTDIV(table) (table->postdiv2 << 4 | table->postdiv1)
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
+
+	rate_table->dacen = FIELD_GET(PLL0_FRACMODE_DACEN, val);
+	rate_table->dsmen = FIELD_GET(PLL0_FRACMODE_DSMEN, val);
+
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
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+
+	return NULL;
+}
+
+static unsigned long visconti_get_pll_rate_from_data(struct visconti_pll *pll,
+						     const struct visconti_pll_rate_table *rate)
+{
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++)
+		if (memcmp(&rate_table[i].dacen, &rate->dacen,
+			sizeof(*rate) - sizeof(unsigned long)) == 0)
+			return rate_table[i].rate;
+
+	/* set default */
+	return rate_table[0].rate;
+}
+
+static long visconti_pll_round_rate(struct clk_hw *hw,
+				    unsigned long rate, unsigned long *prate)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate >= rate_table[i].rate)
+			return rate_table[i].rate;
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
+				   const struct visconti_pll_rate_table *rate_table)
+{
+	writel(PLL_CREATE_FRACMODE(rate_table), pll->pll_base + PLL_FRACMODE_REG);
+	writel(PLL_CREATE_OSTDIV(rate_table), pll->pll_base + PLL_POSTDIV_REG);
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
+	rate_table = visconti_get_pll_settings(pll, rate);
+	if (!rate_table)
+		return -EINVAL;
+
+	return visconti_pll_set_params(pll, rate_table);
+}
+
+static int visconti_pll_is_enabled(struct clk_hw *hw)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	u32 reg;
+
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+
+	return (reg & PLL_PLLEN);
+}
+
+static int visconti_pll_enable(struct clk_hw *hw)
+{
+	struct visconti_pll *pll = to_visconti_pll(hw);
+	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
+	unsigned long flags;
+	u32 reg;
+
+	if (visconti_pll_is_enabled(hw))
+		return 0;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
+
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_BYPASS;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	visconti_pll_set_params(pll, &rate_table[0]);
+
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg &= ~PLL_PLLEN;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	udelay(1);
+
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_PLLEN;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
+	udelay(40);
+
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
+	unsigned long flags;
+	u32 reg;
+
+	if (!visconti_pll_is_enabled(hw))
+		return;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
+
+	reg = readl(pll->pll_base + PLL_CTRL_REG);
+	reg |= PLL_BYPASS;
+	writel(reg, pll->pll_base + PLL_CTRL_REG);
+
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
+static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,
+					    const char *name,
+					    const char *parent_name,
+					    int offset,
+					    const struct visconti_pll_rate_table *rate_table,
+					    spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct visconti_pll *pll;
+	struct clk *pll_clk;
+	struct clk_hw *pll_hw_clk;
+	size_t len;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
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
+	pll->lock = lock;
+	pll->ctx = ctx;
+
+	pll_hw_clk = &pll->hw;
+	ret = clk_hw_register(NULL, &pll->hw);
+	if (ret) {
+		pr_err("failed to register pll clock %s : %ld\n", name, PTR_ERR(pll_clk));
+		kfree(pll);
+		pll_hw_clk = ERR_PTR(ret);
+	}
+
+	return pll_hw_clk;
+}
+
+static void visconti_pll_add_lookup(struct visconti_pll_provider *ctx,
+				    struct clk_hw *hw_clk,
+				    unsigned int id)
+{
+	if (ctx->clk_data.hws && id)
+		ctx->clk_data.hws[id] = hw_clk;
+}
+
+void __init visconti_register_plls(struct visconti_pll_provider *ctx,
+				   const struct visconti_pll_info *list,
+				   unsigned int nr_plls,
+				   spinlock_t *lock)
+{
+	int idx;
+
+	for (idx = 0; idx < nr_plls; idx++, list++) {
+		struct clk_hw *clk;
+
+		clk = visconti_register_pll(ctx,
+					    list->name,
+					    list->parent,
+					    list->base_reg,
+					    list->rate_table,
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
+	int i;
+
+	ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_plls), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_plls; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	ctx->node = np;
+	ctx->reg_base = base;
+	ctx->clk_data.num = nr_plls;
+
+	return ctx;
+}
diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
new file mode 100644
index 000000000000..16dae35ab370
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
+	struct clk_hw_onecell_data clk_data;
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
+	unsigned long base_reg;
+	const struct visconti_pll_rate_table *rate_table;
+};
+
+struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
+							void __iomem *base,
+							unsigned long nr_plls);
+void visconti_register_plls(struct visconti_pll_provider *ctx,
+			    const struct visconti_pll_info *list,
+			    unsigned int nr_plls, spinlock_t *lock);
+
+#endif /* _VISCONTI_PLL_H_ */
diff --git a/drivers/clk/visconti/reset.c b/drivers/clk/visconti/reset.c
new file mode 100644
index 000000000000..e3c3d7804612
--- /dev/null
+++ b/drivers/clk/visconti/reset.c
@@ -0,0 +1,107 @@
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
+#include <linux/device.h>
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
+	u32 rst = BIT(data->rs_idx);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(reset->lock, flags);
+	ret = regmap_update_bits(reset->regmap, data->rson_offset, rst, rst);
+	spin_unlock_irqrestore(reset->lock, flags);
+
+	return ret;
+}
+
+static int visconti_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct visconti_reset *reset = to_visconti_reset(rcdev);
+	const struct visconti_reset_data *data = &reset->resets[id];
+	u32 rst = BIT(data->rs_idx);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(reset->lock, flags);
+	ret = regmap_update_bits(reset->regmap, data->rsoff_offset, rst, rst);
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
+int visconti_register_reset_controller(struct device *dev,
+				       struct regmap *regmap,
+				       const struct visconti_reset_data *resets,
+				       unsigned int num_resets,
+				       const struct reset_control_ops *reset_ops,
+				       spinlock_t *lock)
+{
+	struct visconti_reset *reset;
+
+	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->regmap = regmap;
+	reset->resets = resets;
+	reset->rcdev.ops = reset_ops;
+	reset->rcdev.nr_resets = num_resets;
+	reset->rcdev.of_node = dev->of_node;
+	reset->lock = lock;
+
+	return devm_reset_controller_register(dev, &reset->rcdev);
+}
diff --git a/drivers/clk/visconti/reset.h b/drivers/clk/visconti/reset.h
new file mode 100644
index 000000000000..229dffcbdc98
--- /dev/null
+++ b/drivers/clk/visconti/reset.h
@@ -0,0 +1,36 @@
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
+int visconti_register_reset_controller(struct device *dev,
+				       struct regmap *regmap,
+				       const struct visconti_reset_data *resets,
+				       unsigned int num_resets,
+				       const struct reset_control_ops *reset_ops,
+				       spinlock_t *lock);
+#endif /* _VISCONTI_RESET_H_ */
-- 
2.33.0


