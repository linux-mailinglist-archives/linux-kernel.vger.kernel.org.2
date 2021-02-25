Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6E325781
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhBYUWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhBYUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:22:15 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BEC061756;
        Thu, 25 Feb 2021 12:21:18 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 883423F60E;
        Thu, 25 Feb 2021 21:21:13 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: Add MSM8976/56 Global Clock Controller (GCC) driver
Date:   Thu, 25 Feb 2021 21:18:43 +0100
Message-Id: <20210225201845.109670-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210225201845.109670-1-konrad.dybcio@somainline.org>
References: <20210225201845.109670-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add support for the global clock controller found on MSM8956
and MSM8976 SoCs.
Since the multimedia clocks are actually in the GCC on these
SoCs, this will allow drivers to probe and control basically
all the required clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/Kconfig                     |    8 +
 drivers/clk/qcom/Makefile                    |    1 +
 drivers/clk/qcom/gcc-msm8976.c               | 4181 ++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8976.h |  243 +
 4 files changed, 4433 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-msm8976.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d32bb12cd8d0..3c7c15d65559 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -233,6 +233,14 @@ config MSM_MMCC_8974
 	  Say Y if you want to support multimedia devices such as display,
 	  graphics, video encode/decode, camera, etc.
 
+config MSM_GCC_8976
+	tristate "MSM8956/76 Global Clock Controller"
+	select QCOM_GDSC
+	help
+	  Support for the global clock controller on msm8956/76 devices.
+	  Say Y if you want to use peripheral devices such as UART, SPI,
+	  i2c, USB, SD/eMMC, SATA, PCIe, etc.
+
 config MSM_GCC_8994
 	tristate "MSM8994 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 9e5e0e3cb7b4..3860c1b6b9c3 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MSM_GCC_8916) += gcc-msm8916.o
 obj-$(CONFIG_MSM_GCC_8939) += gcc-msm8939.o
 obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
 obj-$(CONFIG_MSM_GCC_8974) += gcc-msm8974.o
+obj-$(CONFIG_MSM_GCC_8976) += gcc-msm8976.o
 obj-$(CONFIG_MSM_GCC_8994) += gcc-msm8994.o
 obj-$(CONFIG_MSM_GCC_8996) += gcc-msm8996.o
 obj-$(CONFIG_MSM_LCC_8960) += lcc-msm8960.o
diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
new file mode 100644
index 000000000000..5478612cd1b3
--- /dev/null
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -0,0 +1,4181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm Global Clock Controller driver for MSM8956/76
+ *
+ * Copyright (c) 2016-2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ *
+ * Driver cleanup and modernization
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,gcc-msm8976.h>
+
+#include "clk-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+enum {
+	P_GPLL0_OUT_MAIN,
+	P_GPLL0_AUX,
+	P_GPLL0_AUX_ESC,
+	P_GPLL0_OUT,
+	P_GPLL0_OUT_M,
+	P_GPLL0_OUT_MDP,
+	P_GPLL2_OUT_MAIN,
+	P_GPLL2_AUX,
+	P_GPLL2_OUT,
+	P_GPLL3_OUT_MAIN,
+	P_GPLL4_OUT_MAIN,
+	P_GPLL4_AUX,
+	P_GPLL4_OUT,
+	P_GPLL4_GFX3D,
+	P_GPLL6_OUT_MAIN,
+	P_GPLL6_AUX,
+	P_GPLL6_OUT,
+	P_GPLL6_GFX3D,
+	P_DSI0PLL,
+	P_DSI1PLL,
+	P_DSI0PLL_BYTE,
+	P_DSI1PLL_BYTE,
+	P_DSI0PLL_BYTE_MUX,
+	P_DSI1PLL_BYTE_MUX,
+	P_BIMC,
+	P_SLEEP_CLK,
+	P_XO_A,
+	P_XO,
+};
+
+static struct clk_pll gpll0 = {
+	.l_reg = 0x21004,
+	.m_reg = 0x21008,
+	.n_reg = 0x2100c,
+	.config_reg = 0x21014,
+	.mode_reg = 0x21000,
+	.status_reg = 0x2101c,
+	.status_bit = 17,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll0",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "xo",
+			.name = "xo_board",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll0_vote = {
+	.enable_reg = 0x45000,
+	.enable_mask = BIT(0),
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll0_vote",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
+static struct clk_pll gpll2 = {
+	.l_reg = 0x4a004,
+	.m_reg = 0x4a008,
+	.n_reg = 0x4a00c,
+	.config_reg = 0x4a014,
+	.mode_reg = 0x4a000,
+	.status_reg = 0x4a01c,
+	.status_bit = 17,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll2",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "xo",
+			.name = "xo_board",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll2_vote = {
+	.enable_reg = 0x45000,
+	.enable_mask = BIT(2),
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll2_vote",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
+#define F_GPLL(f, l, m, n) { (f), (l), (m), (n), 0 }
+
+static struct pll_freq_tbl gpll3_freq_tbl[] = {
+	F_GPLL(1100000000, 57, 7, 24),
+};
+
+static struct clk_pll gpll3 = {
+	.l_reg = 0x22004,
+	.m_reg = 0x22008,
+	.n_reg = 0x2200c,
+	.config_reg	= 0x22010,
+	.mode_reg	= 0x22000,
+	.status_reg	= 0x22024,
+	.status_bit	= 17,
+	.freq_tbl	= gpll3_freq_tbl,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "gpll3",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "xo",
+			.name = "xo_board",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll3_vote = {
+	.enable_reg = 0x45000,
+	.enable_mask = BIT(4),
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll3_vote",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll3.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
+/* GPLL3 at 1100MHz, main output enabled. */
+static struct pll_config gpll3_config = {
+	.l = 57,
+	.m = 7,
+	.n = 24,
+	.vco_val = 0x0,
+	.vco_mask = 0x3 << 20,
+	.pre_div_val = 0x0,
+	.pre_div_mask = 0x7 << 12,
+	.post_div_val = 0x0,
+	.post_div_mask = 0x3 << 8,
+	.mn_ena_mask = BIT(24),
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+};
+
+static struct clk_pll gpll4 = {
+	.l_reg = 0x24004,
+	.m_reg = 0x24008,
+	.n_reg = 0x2400c,
+	.config_reg = 0x24018,
+	.mode_reg = 0x24000,
+	.status_reg = 0x24024,
+	.status_bit = 17,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll4",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "xo",
+			.name = "xo_board",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll4_vote = {
+	.enable_reg = 0x45000,
+	.enable_mask = BIT(5),
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll4_vote",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll4.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
+static struct clk_pll gpll6 = {
+	.mode_reg = 0x37000,
+	.l_reg = 0x37004,
+	.m_reg = 0x37008,
+	.n_reg = 0x3700c,
+	.config_reg = 0x37014,
+	.status_reg = 0x3701c,
+	.status_bit = 17,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll6",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "xo",
+			.name = "xo_board",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll6_vote = {
+	.enable_reg = 0x45000,
+	.enable_mask = BIT(7),
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll6_vote",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll6.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
+static const struct parent_map gcc_parent_map_1[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_OUT, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_1[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll4_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_v1_1[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL2_OUT, 4 },
+};
+
+static const struct clk_parent_data gcc_parent_data_v1_1[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll2_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_2[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL2_AUX, 3 },
+	{ P_GPLL4_OUT, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_2[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll2_vote.hw },
+	{ .hw = &gpll4_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL2_AUX, 3 },
+	{ P_GPLL6_AUX, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll2_vote.hw },
+	{ .hw = &gpll6_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_4[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+};
+
+static const struct parent_map gcc_parent_map_4_fs[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT, 2 },
+};
+
+static const struct parent_map gcc_parent_map_5[] = {
+	{ P_XO, 0 },
+	{ P_GPLL4_OUT, 2 },
+	{ P_GPLL6_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_5[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll4_vote.hw },
+	{ .hw = &gpll6_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_6[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_6[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll4_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_7_mdp[] = {
+	{ P_XO, 0 },
+	{ P_GPLL6_OUT, 3 },
+	{ P_GPLL0_OUT_MDP, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_7_mdp[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll6_vote.hw },
+	{ .hw = &gpll0_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_7[] = {
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL6_OUT, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_7[] = {
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll6_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_8[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_4_8[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_8_a[] = {
+	{ P_XO_A, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_8_a[] = {
+	{ .fw_name = "xo_a", .name = "xo_a" },
+	{ .hw = &gpll0_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_8_gp[] = {
+	{ P_GPLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_8_gp[] = {
+	{ .hw = &gpll0_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_9[] = {
+	{ P_XO, 0 },
+	{ P_GPLL6_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_9[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll6_vote.hw },
+};
+
+static const struct parent_map gcc_parent_map_10[] = {
+	{ P_XO, 0 },
+};
+
+static const struct clk_parent_data gcc_parent_data_10[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+};
+
+static const struct parent_map gcc_parent_map_sdcc_ice[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_M, 3 },
+};
+
+static const struct parent_map gcc_parent_map_cci[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_AUX, 2 },
+};
+
+static const struct parent_map gcc_parent_map_cpp[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_AUX, 3 },
+};
+
+static const struct parent_map gcc_parent_map_mdss_pix0[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_mdss_pix0[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .fw_name = "dsi0pll", .name = "dsi0pll" },
+};
+
+static const struct parent_map gcc_parent_map_mdss_pix1[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL, 3 },
+	{ P_DSI1PLL, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_mdss_pix1[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .fw_name = "dsi0pll", .name = "dsi0pll" },
+	{ .fw_name = "dsi1pll", .name = "dsi1pll" },
+};
+
+static const struct parent_map gcc_parent_map_mdss_byte0[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL_BYTE, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_mdss_byte0[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .fw_name = "dsi0pllbyte", .name = "dsi0pllbyte" },
+};
+
+static const struct parent_map gcc_parent_map_mdss_byte1[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL_BYTE, 3 },
+	{ P_DSI1PLL_BYTE, 1 },
+};
+
+static const struct clk_parent_data gcc_parent_data_mdss_byte1[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .fw_name = "dsi0pllbyte", .name = "dsi0pllbyte" },
+	{ .fw_name = "dsi1pllbyte", .name = "dsi1pllbyte" },
+};
+
+static const struct parent_map gcc_parent_map_gfx3d[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_GFX3D, 5 },
+	{ P_GPLL6_GFX3D, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_gfx3d[] = {
+	{ .fw_name = "xo", .name = "xo_board" },
+	{ .hw = &gpll0_vote.hw },
+	{ .hw = &gpll4_vote.hw },
+	{ .hw = &gpll6_vote.hw },
+};
+
+static const struct freq_tbl ftbl_aps_0_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(300000000, P_GPLL4_OUT, 4, 0, 0),
+	F(540000000, P_GPLL6_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 aps_0_clk_src = {
+	.cmd_rcgr = 0x78008,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_aps_0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "aps_0_clk_src",
+		.parent_data = gcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_aps_1_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(300000000, P_GPLL4_OUT, 4, 0, 0),
+	F(540000000, P_GPLL6_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 aps_1_clk_src = {
+	.cmd_rcgr = 0x79008,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_aps_1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "aps_1_clk_src",
+		.parent_data = gcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_apss_ahb_clk_src[] = {
+	F(19200000, P_XO_A, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(88890000, P_GPLL0_OUT_MAIN, 9, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 apss_ahb_clk_src = {
+	.cmd_rcgr = 0x46000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_a,
+	.freq_tbl = ftbl_apss_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "apss_ahb_clk_src",
+		.parent_data = gcc_parent_data_8_a,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8_a),
+		.ops = &clk_rcg2_ops,
+		/*
+		 * This clock allows the CPUs to communicate with
+		 * the rest of the SoC. Without it, the brain will
+		 * operate without the rest of the body.
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp_i2c_apps_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x200c,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup1_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp_spi_apps_clk_src[] = {
+	F(960000, P_XO, 10, 1, 2),
+	F(4800000, P_XO, 4, 0, 0),
+	F(9600000, P_XO, 2, 0, 0),
+	F(16000000, P_GPLL0_OUT_MAIN, 10, 1, 5),
+	F(19200000, P_XO, 1, 0, 0),
+	F(25000000, P_GPLL0_OUT_MAIN, 16, 1, 2),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
+	.cmd_rcgr = 0x2024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup1_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x3000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup2_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
+	.cmd_rcgr = 0x3014,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup2_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x4000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup3_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
+	.cmd_rcgr = 0x4024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup3_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x5000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup4_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
+	.cmd_rcgr = 0x5024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup4_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp_uart_apps_clk_src[] = {
+	F(3686400, P_GPLL0_OUT_MAIN, 1, 72, 15625),
+	F(7372800, P_GPLL0_OUT_MAIN, 1, 144, 15625),
+	F(14745600, P_GPLL0_OUT_MAIN, 1, 288, 15625),
+	F(16000000, P_GPLL0_OUT_MAIN, 10, 1, 5),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_GPLL0_OUT_MAIN, 1, 3, 100),
+	F(25000000, P_GPLL0_OUT_MAIN, 16, 1, 2),
+	F(32000000, P_GPLL0_OUT_MAIN, 1, 1, 25),
+	F(40000000, P_GPLL0_OUT_MAIN, 1, 1, 20),
+	F(46400000, P_GPLL0_OUT_MAIN, 1, 29, 500),
+	F(48000000, P_GPLL0_OUT_MAIN, 1, 3, 50),
+	F(51200000, P_GPLL0_OUT_MAIN, 1, 8, 125),
+	F(56000000, P_GPLL0_OUT_MAIN, 1, 7, 100),
+	F(58982400, P_GPLL0_OUT_MAIN, 1, 1152, 15625),
+	F(60000000, P_GPLL0_OUT_MAIN, 1, 3, 40),
+	F(64000000, P_GPLL0_OUT_MAIN, 1, 2, 25),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
+	.cmd_rcgr = 0x2044,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_uart_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_uart1_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
+	.cmd_rcgr = 0x3034,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_uart_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_uart2_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src = {
+	.cmd_rcgr = 0xc00c,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup1_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src = {
+	.cmd_rcgr = 0xc024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup1_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src = {
+	.cmd_rcgr = 0xd000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup2_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src = {
+	.cmd_rcgr = 0xd014,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup2_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src = {
+	.cmd_rcgr = 0xf000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup3_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src = {
+	.cmd_rcgr = 0xf024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup3_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x18000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup4_i2c_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src = {
+	.cmd_rcgr = 0x18024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup4_spi_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_uart1_apps_clk_src = {
+	.cmd_rcgr = 0xc044,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_uart_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_uart1_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_uart2_apps_clk_src = {
+	.cmd_rcgr = 0xd034,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_blsp_uart_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_uart2_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cci_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(37500000, P_GPLL0_AUX, 1, 3, 64),
+	{ }
+};
+
+static struct clk_rcg2 cci_clk_src = {
+	.cmd_rcgr = 0x51000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_cci,
+	.freq_tbl = ftbl_cci_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cci_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cpp_clk_src[] = {
+	F(160000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	F(240000000, P_GPLL4_AUX, 5, 0, 0),
+	F(320000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	F(400000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(480000000, P_GPLL4_AUX, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cpp_clk_src = {
+	.cmd_rcgr = 0x58018,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_cpp,
+	.freq_tbl = ftbl_cpp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cpp_clk_src",
+		.parent_data = gcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi0_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0_clk_src = {
+	.cmd_rcgr = 0x4e020,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_csi0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi1_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi1_clk_src = {
+	.cmd_rcgr = 0x4f020,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_csi1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi2_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi2_clk_src = {
+	.cmd_rcgr = 0x3c020,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_csi2_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camss_gp0_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camss_gp0_clk_src = {
+	.cmd_rcgr = 0x54000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_gp,
+	.freq_tbl = ftbl_camss_gp0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camss_gp0_clk_src",
+		.parent_data = gcc_parent_data_8_gp,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8_gp),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camss_gp1_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camss_gp1_clk_src = {
+	.cmd_rcgr = 0x55000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_gp,
+	.freq_tbl = ftbl_camss_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camss_gp1_clk_src",
+		.parent_data = gcc_parent_data_8_gp,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8_gp),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_jpeg0_clk_src[] = {
+	F(133330000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266666667, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(320000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 jpeg0_clk_src = {
+	.cmd_rcgr = 0x57000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_6,
+	.freq_tbl = ftbl_jpeg0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "jpeg0_clk_src",
+		.parent_data = gcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mclk_clk_src[] = {
+	F(8000000, P_GPLL0_OUT_MAIN, 1, 1, 100),
+	F(24000000, P_GPLL6_OUT, 1, 1, 45),
+	F(66670000, P_GPLL0_OUT_MAIN, 12, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 mclk0_clk_src = {
+	.cmd_rcgr = 0x52000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_7,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk0_clk_src",
+		.parent_data = gcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk1_clk_src = {
+	.cmd_rcgr = 0x53000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_7,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk1_clk_src",
+		.parent_data = gcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk2_clk_src = {
+	.cmd_rcgr = 0x5c000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_7,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk2_clk_src",
+		.parent_data = gcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi0phytimer_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x4e000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0phytimer_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi1phytimer_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266670000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x4f000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_csi1phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1phytimer_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camss_top_ahb_clk_src[] = {
+	F(40000000, P_GPLL0_OUT_MAIN, 10, 1, 2),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camss_top_ahb_clk_src = {
+	.cmd_rcgr = 0x5a000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_camss_top_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camss_top_ahb_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vfe0_clk_src[] = {
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(160000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	F(177777778, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266666667, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GPLL4_OUT, 4, 0, 0),
+	F(320000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	F(466000000, P_GPLL2_AUX, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vfe0_clk_src = {
+	.cmd_rcgr = 0x58000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_vfe0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe0_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vfe1_clk_src[] = {
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(160000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	F(177777778, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(266666667, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GPLL4_OUT, 4, 0, 0),
+	F(320000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	F(466000000, P_GPLL2_AUX, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vfe1_clk_src = {
+	.cmd_rcgr = 0x58054,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_vfe1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe1_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_crypto_clk_src[] = {
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(160000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 crypto_clk_src = {
+	.cmd_rcgr = 0x16004,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_crypto_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "crypto_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gp1_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gp1_clk_src = {
+	.cmd_rcgr = 0x8004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_gp,
+	.freq_tbl = ftbl_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp1_clk_src",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0_vote.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gp2_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gp2_clk_src = {
+	.cmd_rcgr = 0x9004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_gp,
+	.freq_tbl = ftbl_gp2_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp2_clk_src",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0_vote.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gp3_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gp3_clk_src = {
+	.cmd_rcgr = 0xa004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8_gp,
+	.freq_tbl = ftbl_gp3_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp3_clk_src",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0_vote.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 byte0_clk_src = {
+	.cmd_rcgr = 0x4d044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_mdss_byte0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte0_clk_src",
+		.parent_data = gcc_parent_data_mdss_byte0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_byte0),
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_rcg2 byte1_clk_src = {
+	.cmd_rcgr = 0x4d0b0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_mdss_byte1,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte1_clk_src",
+		.parent_data = gcc_parent_data_mdss_byte1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_byte1),
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static const struct freq_tbl ftbl_esc0_1_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 esc0_clk_src = {
+	.cmd_rcgr = 0x4d05c,
+	.hid_width = 5,
+	.freq_tbl = ftbl_esc0_1_clk_src,
+	.parent_map = gcc_parent_map_mdss_byte0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc0_clk_src",
+		.parent_data = gcc_parent_data_mdss_byte0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_byte0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 esc1_clk_src = {
+	.cmd_rcgr = 0x4d0a8,
+	.hid_width = 5,
+	.freq_tbl = ftbl_esc0_1_clk_src,
+	.parent_map = gcc_parent_map_mdss_byte1,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc1_clk_src",
+		.parent_data = gcc_parent_data_mdss_byte1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_byte1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mdp_clk_src[] = {
+	F(50000000, P_GPLL0_OUT_MDP, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MDP, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MDP, 8, 0, 0),
+	F(145454545, P_GPLL0_OUT_MDP, 5.5, 0, 0),
+	F(160000000, P_GPLL0_OUT_MDP, 5, 0, 0),
+	F(177777778, P_GPLL0_OUT_MDP, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MDP, 4, 0, 0),
+	F(270000000, P_GPLL6_OUT, 4, 0, 0),
+	F(320000000, P_GPLL0_OUT_MDP, 2.5, 0, 0),
+	F(360000000, P_GPLL6_OUT, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 mdp_clk_src = {
+	.cmd_rcgr = 0x4d014,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_7_mdp,
+	.freq_tbl = ftbl_mdp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mdp_clk_src",
+		.parent_data = gcc_parent_data_7_mdp,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_7_mdp),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 pclk0_clk_src = {
+	.cmd_rcgr = 0x4d000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_mdss_pix0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk0_clk_src",
+		.parent_data = gcc_parent_data_mdss_pix0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_pix0),
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_rcg2 pclk1_clk_src = {
+	.cmd_rcgr = 0x4d0b8,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_mdss_pix1,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk1_clk_src",
+		.parent_data = gcc_parent_data_mdss_pix1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_mdss_pix1),
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static const struct freq_tbl ftbl_vsync_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vsync_clk_src = {
+	.cmd_rcgr = 0x4d02c,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_10,
+	.freq_tbl = ftbl_vsync_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vsync_clk_src",
+		.parent_data = gcc_parent_data_10,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_10),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gfx3d_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(160000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(228571429, P_GPLL0_OUT_MAIN, 3.5, 0, 0),
+	F(240000000, P_GPLL6_GFX3D, 4.5, 0, 0),
+	F(266666667, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GPLL4_GFX3D, 4, 0, 0),
+	F(360000000, P_GPLL6_GFX3D, 3, 0, 0),
+	F(400000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(432000000, P_GPLL6_GFX3D, 2.5, 0, 0),
+	F(480000000, P_GPLL4_GFX3D, 2.5, 0, 0),
+	F(540000000, P_GPLL6_GFX3D, 2, 0, 0),
+	F(600000000, P_GPLL4_GFX3D, 2, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gfx3d_clk_params = {
+	.name = "gfx3d_clk_src",
+	.parent_data = gcc_parent_data_gfx3d,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_gfx3d),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gfx3d_clk_src = {
+	.cmd_rcgr = 0x59000,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_gfx3d,
+	.freq_tbl = ftbl_gfx3d_clk_src,
+	.clkr.hw.init = &gfx3d_clk_params,
+};
+
+static const struct freq_tbl ftbl_pdm2_clk_src[] = {
+	F(64000000, P_GPLL0_OUT_MAIN, 12.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 pdm2_clk_src = {
+	.cmd_rcgr = 0x44010,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_pdm2_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pdm2_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_rbcpr_gfx_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 rbcpr_gfx_clk_src = {
+	.cmd_rcgr = 0x3a00c,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_rbcpr_gfx_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "rbcpr_gfx_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
+	F(144000, P_XO, 16, 3, 25),
+	F(400000, P_XO, 12, 1, 4),
+	F(20000000, P_GPLL0_OUT_MAIN, 10, 1, 4),
+	F(25000000, P_GPLL0_OUT_MAIN, 16, 1, 2),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(177777778, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(342850000, P_GPLL4_OUT, 3.5, 0, 0),
+	F(400000000, P_GPLL4_OUT, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_sdcc1_8976_v1_1_apps_clk_src[] = {
+	F(144000, P_XO, 16, 3, 25),
+	F(400000, P_XO, 12, 1, 4),
+	F(20000000, P_GPLL0_OUT_MAIN, 10, 1, 4),
+	F(25000000, P_GPLL0_OUT_MAIN, 16, 1, 2),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(177777778, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(186400000, P_GPLL2_OUT, 5, 0, 0),
+	F(372800000, P_GPLL2_OUT, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_init_data sdcc1_apps_clk_src_8976v1_1_init = {
+	.name = "sdcc1_apps_clk_src",
+	.parent_data = gcc_parent_data_v1_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_v1_1),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 sdcc1_apps_clk_src = {
+	.cmd_rcgr = 0x42004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_sdcc1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc1_apps_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc1_ice_core_clk_src[] = {
+	F(100000000, P_GPLL0_OUT_M, 8, 0, 0),
+	F(200000000, P_GPLL0_OUT_M, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 sdcc1_ice_core_clk_src = {
+	.cmd_rcgr = 0x5d000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_sdcc_ice,
+	.freq_tbl = ftbl_sdcc1_ice_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc1_ice_core_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc2_4_apps_clk_src[] = {
+	F(144000, P_XO, 16, 3, 25),
+	F(400000, P_XO, 12, 1, 4),
+	F(20000000, P_GPLL0_OUT_MAIN, 10, 1, 4),
+	F(25000000, P_GPLL0_OUT_MAIN, 16, 1, 2),
+	F(40000000, P_GPLL0_OUT_MAIN, 10, 1, 2),
+	F(50000000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(177777778, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 sdcc2_apps_clk_src = {
+	.cmd_rcgr = 0x43004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_sdcc2_4_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc2_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 sdcc3_apps_clk_src = {
+	.cmd_rcgr = 0x39004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_sdcc2_4_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc3_apps_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb_fs_ic_clk_src[] = {
+	F(60000000, P_GPLL6_OUT_MAIN, 6, 1, 3),
+	{ }
+};
+
+static struct clk_rcg2 usb_fs_ic_clk_src = {
+	.cmd_rcgr = 0x3f034,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_9,
+	.freq_tbl = ftbl_usb_fs_ic_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb_fs_ic_clk_src",
+		.parent_data = gcc_parent_data_9,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb_fs_system_clk_src[] = {
+	F(64000000, P_GPLL0_OUT, 12.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb_fs_system_clk_src = {
+	.cmd_rcgr = 0x3f010,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4_fs,
+	.freq_tbl = ftbl_usb_fs_system_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb_fs_system_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb_hs_system_clk_src[] = {
+	F(57140000, P_GPLL0_OUT_MAIN, 14, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(177780000, P_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb_hs_system_clk_src = {
+	.cmd_rcgr = 0x41010,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_usb_hs_system_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb_hs_system_clk_src",
+		.parent_data = gcc_parent_data_4_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vcodec0_clk_src[] = {
+	F(72727200, P_GPLL0_OUT_MAIN, 11, 0, 0),
+	F(80000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(228570000, P_GPLL0_OUT_MAIN, 3.5, 0, 0),
+	F(310667000, P_GPLL2_AUX, 3, 0, 0),
+	F(360000000, P_GPLL6_AUX, 3, 0, 0),
+	F(400000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(466000000, P_GPLL2_AUX, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vcodec0_clk_src = {
+	.cmd_rcgr = 0x4c000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_vcodec0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vcodec0_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gcc_aps_0_clk = {
+	.halt_reg = 0x78004,
+	.clkr = {
+		.enable_reg = 0x78004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_aps_0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&aps_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aps_1_clk = {
+	.halt_reg = 0x79004,
+	.clkr = {
+		.enable_reg = 0x79004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_aps_1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&aps_1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
+	.halt_reg = 0x2008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup1_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup1_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
+	.halt_reg = 0x2004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup1_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup1_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
+	.halt_reg = 0x3010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup2_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup2_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
+	.halt_reg = 0x300c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x300c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup2_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup2_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
+	.halt_reg = 0x4020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup3_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup3_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
+	.halt_reg = 0x401c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x401c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup3_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup3_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
+	.halt_reg = 0x5020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup4_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup4_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
+	.halt_reg = 0x501c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x501c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_qup4_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_qup4_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_uart1_apps_clk = {
+	.halt_reg = 0x203c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x203c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_uart1_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_uart1_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_uart2_apps_clk = {
+	.halt_reg = 0x302c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x302c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp1_uart2_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp1_uart2_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup1_i2c_apps_clk = {
+	.halt_reg = 0xc008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup1_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup1_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup1_spi_apps_clk = {
+	.halt_reg = 0xc004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup1_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup1_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup2_i2c_apps_clk = {
+	.halt_reg = 0xd010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup2_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup2_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup2_spi_apps_clk = {
+	.halt_reg = 0xd00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup2_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup2_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup3_i2c_apps_clk = {
+	.halt_reg = 0xf020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup3_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup3_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup3_spi_apps_clk = {
+	.halt_reg = 0xf01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup3_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup3_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup4_i2c_apps_clk = {
+	.halt_reg = 0x18020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x18020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup4_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup4_i2c_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup4_spi_apps_clk = {
+	.halt_reg = 0x1801c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1801c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_qup4_spi_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_qup4_spi_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_uart1_apps_clk = {
+	.halt_reg = 0xc03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_uart1_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_uart1_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_uart2_apps_clk = {
+	.halt_reg = 0xd02c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd02c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_blsp2_uart2_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&blsp2_uart2_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_cci_ahb_clk = {
+	.halt_reg = 0x5101c,
+	.clkr = {
+		.enable_reg = 0x5101c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_cci_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_cci_clk = {
+	.halt_reg = 0x51018,
+	.clkr = {
+		.enable_reg = 0x51018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_cci_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&cci_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_cpp_ahb_clk = {
+	.halt_reg = 0x58040,
+	.clkr = {
+		.enable_reg = 0x58040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_cpp_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_cpp_axi_clk = {
+	.halt_reg = 0x58064,
+	.clkr = {
+		.enable_reg = 0x58064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_cpp_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_cpp_clk = {
+	.halt_reg = 0x5803c,
+	.clkr = {
+		.enable_reg = 0x5803c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_cpp_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&cpp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0_ahb_clk = {
+	.halt_reg = 0x4e040,
+	.clkr = {
+		.enable_reg = 0x4e040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0_clk = {
+	.halt_reg = 0x4e03c,
+	.clkr = {
+		.enable_reg = 0x4e03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0phy_clk = {
+	.halt_reg = 0x4e048,
+	.clkr = {
+		.enable_reg = 0x4e048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0phy_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0pix_clk = {
+	.halt_reg = 0x4e058,
+	.clkr = {
+		.enable_reg = 0x4e058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0pix_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0rdi_clk = {
+	.halt_reg = 0x4e050,
+	.clkr = {
+		.enable_reg = 0x4e050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0rdi_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1_ahb_clk = {
+	.halt_reg = 0x4f040,
+	.clkr = {
+		.enable_reg = 0x4f040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1_clk = {
+	.halt_reg = 0x4f03c,
+	.clkr = {
+		.enable_reg = 0x4f03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1phy_clk = {
+	.halt_reg = 0x4f048,
+	.clkr = {
+		.enable_reg = 0x4f048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1phy_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1pix_clk = {
+	.halt_reg = 0x4f058,
+	.clkr = {
+		.enable_reg = 0x4f058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1pix_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1rdi_clk = {
+	.halt_reg = 0x4f050,
+	.clkr = {
+		.enable_reg = 0x4f050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1rdi_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2_ahb_clk = {
+	.halt_reg = 0x3c040,
+	.clkr = {
+		.enable_reg = 0x3c040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi2_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2_clk = {
+	.halt_reg = 0x3c03c,
+	.clkr = {
+		.enable_reg = 0x3c03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi2_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2phy_clk = {
+	.halt_reg = 0x3c048,
+	.clkr = {
+		.enable_reg = 0x3c048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi2phy_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2pix_clk = {
+	.halt_reg = 0x3c058,
+	.clkr = {
+		.enable_reg = 0x3c058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi2pix_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2rdi_clk = {
+	.halt_reg = 0x3c050,
+	.clkr = {
+		.enable_reg = 0x3c050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi2rdi_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi_vfe0_clk = {
+	.halt_reg = 0x58050,
+	.clkr = {
+		.enable_reg = 0x58050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi_vfe0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vfe0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi_vfe1_clk = {
+	.halt_reg = 0x58074,
+	.clkr = {
+		.enable_reg = 0x58074,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi_vfe1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vfe1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_gp0_clk = {
+	.halt_reg = 0x54018,
+	.clkr = {
+		.enable_reg = 0x54018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_gp0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_gp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_gp1_clk = {
+	.halt_reg = 0x55018,
+	.clkr = {
+		.enable_reg = 0x55018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_gp1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_gp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_ispif_ahb_clk = {
+	.halt_reg = 0x50004,
+	.clkr = {
+		.enable_reg = 0x50004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_ispif_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_jpeg0_clk = {
+	.halt_reg = 0x57020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x57020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_jpeg0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&jpeg0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_jpeg_ahb_clk = {
+	.halt_reg = 0x57024,
+	.clkr = {
+		.enable_reg = 0x57024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_jpeg_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_jpeg_axi_clk = {
+	.halt_reg = 0x57028,
+	.clkr = {
+		.enable_reg = 0x57028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_jpeg_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
+static struct clk_branch gcc_camss_mclk0_clk = {
+	.halt_reg = 0x52018,
+	.clkr = {
+		.enable_reg = 0x52018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_mclk0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&mclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_mclk1_clk = {
+	.halt_reg = 0x53018,
+	.clkr = {
+		.enable_reg = 0x53018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_mclk1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&mclk1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_mclk2_clk = {
+	.halt_reg = 0x5c018,
+	.clkr = {
+		.enable_reg = 0x5c018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_mclk2_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&mclk2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_micro_ahb_clk = {
+	.halt_reg = 0x5600c,
+	.clkr = {
+		.enable_reg = 0x5600c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_micro_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi0phytimer_clk = {
+	.halt_reg = 0x4e01c,
+	.clkr = {
+		.enable_reg = 0x4e01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi0phytimer_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi0phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi1phytimer_clk = {
+	.halt_reg = 0x4f01c,
+	.clkr = {
+		.enable_reg = 0x4f01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_csi1phytimer_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&csi1phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_ahb_clk = {
+	.halt_reg = 0x56004,
+	.clkr = {
+		.enable_reg = 0x56004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_top_ahb_clk = {
+	.halt_reg = 0x5a014,
+	.clkr = {
+		.enable_reg = 0x5a014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_top_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_vfe0_clk = {
+	.halt_reg = 0x58038,
+	.clkr = {
+		.enable_reg = 0x58038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vfe0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_vfe_ahb_clk = {
+	.halt_reg = 0x58044,
+	.clkr = {
+		.enable_reg = 0x58044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_vfe_axi_clk = {
+	.halt_reg = 0x58048,
+	.clkr = {
+		.enable_reg = 0x58048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
+static struct clk_branch gcc_camss_vfe1_ahb_clk = {
+	.halt_reg = 0x58060,
+	.clkr = {
+		.enable_reg = 0x58060,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe1_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&camss_top_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_vfe1_axi_clk = {
+	.halt_reg = 0x58068,
+	.clkr = {
+		.enable_reg = 0x58068,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe1_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_vfe1_clk = {
+	.halt_reg = 0x5805c,
+	.clkr = {
+		.enable_reg = 0x5805c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_camss_vfe1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vfe1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_dcc_clk = {
+	.halt_reg = 0x77004,
+	.clkr = {
+		.enable_reg = 0x77004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_dcc_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_oxili_gmem_clk = {
+	.halt_reg = 0x59024,
+	.clkr = {
+		.enable_reg = 0x59024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_oxili_gmem_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp1_clk = {
+	.halt_reg = 0x8000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_gp1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp2_clk = {
+	.halt_reg = 0x9000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_gp2_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gp2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp3_clk = {
+	.halt_reg = 0xa000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_gp3_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gp3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_ahb_clk = {
+	.halt_reg = 0x4d07c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d07c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_axi_clk = {
+	.halt_reg = 0x4d080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d080,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_byte0_clk = {
+	.halt_reg = 0x4d094,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d094,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_byte0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&byte0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_byte1_clk = {
+	.halt_reg = 0x4d0a0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d0a0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_byte1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&byte1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_esc0_clk = {
+	.halt_reg = 0x4d098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_esc0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&esc0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_esc1_clk = {
+	.halt_reg = 0x4d09c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d09c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_esc1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&esc1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_mdp_clk = {
+	.halt_reg = 0x4d088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d088,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_mdp_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&mdp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_pclk0_clk = {
+	.halt_reg = 0x4d084,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d084,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_pclk0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_pclk1_clk = {
+	.halt_reg = 0x4d0a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d0a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_pclk1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pclk1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdss_vsync_clk = {
+	.halt_reg = 0x4d090,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d090,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mdss_vsync_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vsync_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_cfg_ahb_clk = {
+	.halt_reg = 0x49000,
+	.clkr = {
+		.enable_reg = 0x49000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mss_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
+	.halt_reg = 0x49004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_mss_q6_bimc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_bimc_gfx_clk = {
+	.halt_reg = 0x59048,
+	.clkr = {
+		.enable_reg = 0x59048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_bimc_gfx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_oxili_ahb_clk = {
+	.halt_reg = 0x59028,
+	.clkr = {
+		.enable_reg = 0x59028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_oxili_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_oxili_aon_clk = {
+	.halt_reg = 0x59044,
+	.clkr = {
+		.enable_reg = 0x59044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_oxili_aon_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_oxili_gfx3d_clk = {
+	.halt_reg = 0x59020,
+	.clkr = {
+		.enable_reg = 0x59020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_oxili_gfx3d_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gfx3d_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_oxili_timer_clk = {
+	.halt_reg = 0x59040,
+	.clkr = {
+		.enable_reg = 0x59040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_oxili_timer_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo_board",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm2_clk = {
+	.halt_reg = 0x4400c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4400c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_pdm2_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pdm2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x44004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x44004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
+static struct clk_branch gcc_rbcpr_gfx_ahb_clk = {
+	.halt_reg = 0x3a008,
+	.clkr = {
+		.enable_reg = 0x3a008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_rbcpr_gfx_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rbcpr_gfx_clk = {
+	.halt_reg = 0x3a004,
+	.clkr = {
+		.enable_reg = 0x3a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_rbcpr_gfx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&rbcpr_gfx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x4201c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4201c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc1_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_apps_clk = {
+	.halt_reg = 0x42018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x42018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc1_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&sdcc1_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_ice_core_clk = {
+	.halt_reg = 0x5d014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5d014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc1_ice_core_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&sdcc1_ice_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_ahb_clk = {
+	.halt_reg = 0x4301c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4301c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_apps_clk = {
+	.halt_reg = 0x43018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x43018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc2_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&sdcc2_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc3_ahb_clk = {
+	.halt_reg = 0x3901c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3901c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc3_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc3_apps_clk = {
+	.halt_reg = 0x39018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_sdcc3_apps_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&sdcc3_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb2a_phy_sleep_clk = {
+	.halt_reg = 0x4102c,
+	.clkr = {
+		.enable_reg = 0x4102c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb2a_phy_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_hs_phy_cfg_ahb_clk = {
+	.halt_reg = 0x41030,
+	.clkr = {
+		.enable_reg = 0x41030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_hs_phy_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_fs_ahb_clk = {
+	.halt_reg = 0x3f008,
+	.clkr = {
+		.enable_reg = 0x3f008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_fs_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_fs_ic_clk = {
+	.halt_reg = 0x3f030,
+	.clkr = {
+		.enable_reg = 0x3f030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_fs_ic_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&usb_fs_ic_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_fs_system_clk = {
+	.halt_reg = 0x3f004,
+	.clkr = {
+		.enable_reg = 0x3f004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_fs_system_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&usb_fs_system_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_hs_ahb_clk = {
+	.halt_reg = 0x41008,
+	.clkr = {
+		.enable_reg = 0x41008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_hs_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_hs_system_clk = {
+	.halt_reg = 0x41004,
+	.clkr = {
+		.enable_reg = 0x41004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_usb_hs_system_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&usb_hs_system_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus0_ahb_clk = {
+	.halt_reg = 0x4c020,
+	.clkr = {
+		.enable_reg = 0x4c020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_venus0_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus0_axi_clk = {
+	.halt_reg = 0x4c024,
+	.clkr = {
+		.enable_reg = 0x4c024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_venus0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus0_core0_vcodec0_clk = {
+	.halt_reg = 0x4c02c,
+	.clkr = {
+		.enable_reg = 0x4c02c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_venus0_core0_vcodec0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vcodec0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus0_core1_vcodec0_clk = {
+	.halt_reg = 0x4c034,
+	.clkr = {
+		.enable_reg = 0x4c034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_venus0_core1_vcodec0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vcodec0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
+static struct clk_branch gcc_venus0_vcodec0_clk = {
+	.halt_reg = 0x4c01c,
+	.clkr = {
+		.enable_reg = 0x4c01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_venus0_vcodec0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&vcodec0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* Vote clocks */
+static struct clk_branch gcc_apss_ahb_clk = {
+	.halt_reg = 0x4601c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_apss_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_apss_axi_clk = {
+	.halt_reg = 0x46020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_apss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_ahb_clk = {
+	.halt_reg = 0x1008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(10),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
+static struct clk_branch gcc_blsp2_ahb_clk = {
+	.halt_reg = 0xb008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(20),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_prng_ahb_clk = {
+	.halt_reg = 0x13004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(8),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_prng_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x1300c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(7),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_boot_rom_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_crypto_ahb_clk = {
+	.halt_reg = 0x16024,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_crypto_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_crypto_axi_clk = {
+	.halt_reg = 0x16020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_crypto_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_crypto_clk = {
+	.halt_reg = 0x1601c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x45004,
+		.enable_mask = BIT(2),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_crypto_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&crypto_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cpp_tbu_clk = {
+	.halt_reg = 0x12040,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(14),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cpp_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gfx_1_tbu_clk = {
+	.halt_reg = 0x12098,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(19),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gfx_1_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gfx_tbu_clk = {
+	.halt_reg = 0x12010,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(3),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gfx_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gfx_tcu_clk = {
+	.halt_reg = 0x12020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(2),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gfx_tcu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_apss_tcu_clk = {
+	.halt_reg = 0x12018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_apss_tcu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gtcu_ahb_clk = {
+	.halt_reg = 0x12044,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(13),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gtcu_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_jpeg_tbu_clk = {
+	.halt_reg = 0x12034,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(10),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_jpeg_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdp_rt_tbu_clk = {
+	.halt_reg = 0x1204c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(15),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mdp_rt_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mdp_tbu_clk = {
+	.halt_reg = 0x1201c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mdp_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_smmu_cfg_clk = {
+	.halt_reg = 0x12038,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(12),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_smmu_cfg_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus_1_tbu_clk = {
+	.halt_reg = 0x1209c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(20),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_venus_1_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_venus_tbu_clk = {
+	.halt_reg = 0x12014,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(5),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_venus_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_vfe1_tbu_clk = {
+	.halt_reg = 0x12090,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(17),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_vfe1_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_vfe_tbu_clk = {
+	.halt_reg = 0x1203c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4500c,
+		.enable_mask = BIT(9),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_vfe_tbu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc venus_gdsc = {
+	.gdscr = 0x4c018,
+	.cxcs = (unsigned int []){ 0x4c024, 0x4c01c },
+	.cxc_count = 2,
+	.pd = {
+		.name = "venus_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc venus_core0_gdsc = {
+	.gdscr = 0x4c028,
+	.cxcs = (unsigned int []){ 0x4c02c },
+	.cxc_count = 1,
+	.pd = {
+		.name = "venus_core0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc venus_core1_gdsc = {
+	.gdscr = 0x4c030,
+	.pd = {
+		.name = "venus_core1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x4d078,
+	.cxcs = (unsigned int []){ 0x4d080, 0x4d088 },
+	.cxc_count = 2,
+	.pd = {
+		.name = "mdss_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc jpeg_gdsc = {
+	.gdscr = 0x5701c,
+	.cxcs = (unsigned int []){ 0x57020, 0x57028 },
+	.cxc_count = 2,
+	.pd = {
+		.name = "jpeg_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc vfe0_gdsc = {
+	.gdscr = 0x58034,
+	.cxcs = (unsigned int []){ 0x58038, 0x58048, 0x5600c, 0x58050 },
+	.cxc_count = 4,
+	.pd = {
+		.name = "vfe0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc vfe1_gdsc = {
+	.gdscr = 0x5806c,
+	.cxcs = (unsigned int []){ 0x5805c, 0x58068, 0x5600c, 0x58074 },
+	.cxc_count = 4,
+	.pd = {
+		.name = "vfe1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc cpp_gdsc = {
+	.gdscr = 0x58078,
+	.cxcs = (unsigned int []){ 0x5803c, 0x58064 },
+	.cxc_count = 2,
+	.pd = {
+		.name = "cpp_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc oxili_cx_gdsc = {
+	.gdscr = 0x5904c,
+	.cxcs = (unsigned int []){ 0x59020 },
+	.cxc_count = 1,
+	.pd = {
+		.name = "oxili_cx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc oxili_gx_gdsc = {
+	.gdscr = 0x5901c,
+	.clamp_io_ctrl = 0x5b00c,
+	.cxcs = (unsigned int []){ 0x59000, 0x59024 },
+	.cxc_count = 2,
+	.pd = {
+		.name = "oxili_gx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.supply = "vdd_gfx",
+	.flags = CLAMP_IO,
+};
+
+static struct clk_regmap *gcc_msm8976_clocks[] = {
+	[GPLL0] = &gpll0.clkr,
+	[GPLL2] = &gpll2.clkr,
+	[GPLL3] = &gpll3.clkr,
+	[GPLL4] = &gpll4.clkr,
+	[GPLL6] = &gpll6.clkr,
+	[GPLL0_CLK_SRC] = &gpll0_vote,
+	[GPLL2_CLK_SRC] = &gpll2_vote,
+	[GPLL3_CLK_SRC] = &gpll3_vote,
+	[GPLL4_CLK_SRC] = &gpll4_vote,
+	[GPLL6_CLK_SRC] = &gpll6_vote,
+	[GCC_BLSP1_QUP1_SPI_APPS_CLK] = &gcc_blsp1_qup1_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP1_I2C_APPS_CLK] = &gcc_blsp1_qup1_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP2_I2C_APPS_CLK] = &gcc_blsp1_qup2_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP2_SPI_APPS_CLK] = &gcc_blsp1_qup2_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP3_I2C_APPS_CLK] = &gcc_blsp1_qup3_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP3_SPI_APPS_CLK] = &gcc_blsp1_qup3_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP4_I2C_APPS_CLK] = &gcc_blsp1_qup4_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
+	[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
+	[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
+	[GCC_BLSP2_QUP1_I2C_APPS_CLK] = &gcc_blsp2_qup1_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP1_SPI_APPS_CLK] = &gcc_blsp2_qup1_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP2_I2C_APPS_CLK] = &gcc_blsp2_qup2_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP2_SPI_APPS_CLK] = &gcc_blsp2_qup2_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP3_I2C_APPS_CLK] = &gcc_blsp2_qup3_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP3_SPI_APPS_CLK] = &gcc_blsp2_qup3_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP4_I2C_APPS_CLK] = &gcc_blsp2_qup4_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP4_SPI_APPS_CLK] = &gcc_blsp2_qup4_spi_apps_clk.clkr,
+	[GCC_BLSP2_UART1_APPS_CLK] = &gcc_blsp2_uart1_apps_clk.clkr,
+	[GCC_BLSP2_UART2_APPS_CLK] = &gcc_blsp2_uart2_apps_clk.clkr,
+	[GCC_CAMSS_CCI_AHB_CLK] = &gcc_camss_cci_ahb_clk.clkr,
+	[GCC_CAMSS_CCI_CLK] = &gcc_camss_cci_clk.clkr,
+	[GCC_CAMSS_CPP_AHB_CLK] = &gcc_camss_cpp_ahb_clk.clkr,
+	[GCC_CAMSS_CPP_AXI_CLK] = &gcc_camss_cpp_axi_clk.clkr,
+	[GCC_CAMSS_CPP_CLK] = &gcc_camss_cpp_clk.clkr,
+	[GCC_CAMSS_CSI0_AHB_CLK] = &gcc_camss_csi0_ahb_clk.clkr,
+	[GCC_CAMSS_CSI0_CLK] = &gcc_camss_csi0_clk.clkr,
+	[GCC_CAMSS_CSI0PHY_CLK] = &gcc_camss_csi0phy_clk.clkr,
+	[GCC_CAMSS_CSI0PIX_CLK] = &gcc_camss_csi0pix_clk.clkr,
+	[GCC_CAMSS_CSI0RDI_CLK] = &gcc_camss_csi0rdi_clk.clkr,
+	[GCC_CAMSS_CSI1_AHB_CLK] = &gcc_camss_csi1_ahb_clk.clkr,
+	[GCC_CAMSS_CSI1_CLK] = &gcc_camss_csi1_clk.clkr,
+	[GCC_CAMSS_CSI1PHY_CLK] = &gcc_camss_csi1phy_clk.clkr,
+	[GCC_CAMSS_CSI1PIX_CLK] = &gcc_camss_csi1pix_clk.clkr,
+	[GCC_CAMSS_CSI1RDI_CLK] = &gcc_camss_csi1rdi_clk.clkr,
+	[GCC_CAMSS_CSI2_AHB_CLK] = &gcc_camss_csi2_ahb_clk.clkr,
+	[GCC_CAMSS_CSI2_CLK] = &gcc_camss_csi2_clk.clkr,
+	[GCC_CAMSS_CSI2PHY_CLK] = &gcc_camss_csi2phy_clk.clkr,
+	[GCC_CAMSS_CSI2PIX_CLK] = &gcc_camss_csi2pix_clk.clkr,
+	[GCC_CAMSS_CSI2RDI_CLK] = &gcc_camss_csi2rdi_clk.clkr,
+	[GCC_CAMSS_CSI_VFE0_CLK] = &gcc_camss_csi_vfe0_clk.clkr,
+	[GCC_CAMSS_CSI_VFE1_CLK] = &gcc_camss_csi_vfe1_clk.clkr,
+	[GCC_CAMSS_GP0_CLK] = &gcc_camss_gp0_clk.clkr,
+	[GCC_CAMSS_GP1_CLK] = &gcc_camss_gp1_clk.clkr,
+	[GCC_CAMSS_ISPIF_AHB_CLK] = &gcc_camss_ispif_ahb_clk.clkr,
+	[GCC_CAMSS_JPEG0_CLK] = &gcc_camss_jpeg0_clk.clkr,
+	[GCC_CAMSS_JPEG_AHB_CLK] = &gcc_camss_jpeg_ahb_clk.clkr,
+	[GCC_CAMSS_JPEG_AXI_CLK] = &gcc_camss_jpeg_axi_clk.clkr,
+	[GCC_CAMSS_MCLK0_CLK] = &gcc_camss_mclk0_clk.clkr,
+	[GCC_CAMSS_MCLK1_CLK] = &gcc_camss_mclk1_clk.clkr,
+	[GCC_CAMSS_MCLK2_CLK] = &gcc_camss_mclk2_clk.clkr,
+	[GCC_CAMSS_MICRO_AHB_CLK] = &gcc_camss_micro_ahb_clk.clkr,
+	[GCC_CAMSS_CSI0PHYTIMER_CLK] = &gcc_camss_csi0phytimer_clk.clkr,
+	[GCC_CAMSS_CSI1PHYTIMER_CLK] = &gcc_camss_csi1phytimer_clk.clkr,
+	[GCC_CAMSS_AHB_CLK] = &gcc_camss_ahb_clk.clkr,
+	[GCC_CAMSS_TOP_AHB_CLK] = &gcc_camss_top_ahb_clk.clkr,
+	[GCC_CAMSS_VFE0_CLK] = &gcc_camss_vfe0_clk.clkr,
+	[GCC_CAMSS_VFE_AHB_CLK] = &gcc_camss_vfe_ahb_clk.clkr,
+	[GCC_CAMSS_VFE_AXI_CLK] = &gcc_camss_vfe_axi_clk.clkr,
+	[GCC_CAMSS_VFE1_AHB_CLK] = &gcc_camss_vfe1_ahb_clk.clkr,
+	[GCC_CAMSS_VFE1_AXI_CLK] = &gcc_camss_vfe1_axi_clk.clkr,
+	[GCC_CAMSS_VFE1_CLK] = &gcc_camss_vfe1_clk.clkr,
+	[GCC_DCC_CLK] = &gcc_dcc_clk.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_MDSS_AHB_CLK] = &gcc_mdss_ahb_clk.clkr,
+	[GCC_MDSS_AXI_CLK] = &gcc_mdss_axi_clk.clkr,
+	[GCC_MDSS_ESC0_CLK] = &gcc_mdss_esc0_clk.clkr,
+	[GCC_MDSS_ESC1_CLK] = &gcc_mdss_esc1_clk.clkr,
+	[GCC_MDSS_MDP_CLK] = &gcc_mdss_mdp_clk.clkr,
+	[GCC_MDSS_VSYNC_CLK] = &gcc_mdss_vsync_clk.clkr,
+	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
+	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_RBCPR_GFX_AHB_CLK] = &gcc_rbcpr_gfx_ahb_clk.clkr,
+	[GCC_RBCPR_GFX_CLK] = &gcc_rbcpr_gfx_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
+	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
+	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
+	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
+	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
+	[GCC_SDCC3_AHB_CLK] = &gcc_sdcc3_ahb_clk.clkr,
+	[GCC_SDCC3_APPS_CLK] = &gcc_sdcc3_apps_clk.clkr,
+	[GCC_USB2A_PHY_SLEEP_CLK] = &gcc_usb2a_phy_sleep_clk.clkr,
+	[GCC_USB_HS_PHY_CFG_AHB_CLK] = &gcc_usb_hs_phy_cfg_ahb_clk.clkr,
+	[GCC_USB_FS_AHB_CLK] = &gcc_usb_fs_ahb_clk.clkr,
+	[GCC_USB_FS_IC_CLK] = &gcc_usb_fs_ic_clk.clkr,
+	[GCC_USB_FS_SYSTEM_CLK] = &gcc_usb_fs_system_clk.clkr,
+	[GCC_USB_HS_AHB_CLK] = &gcc_usb_hs_ahb_clk.clkr,
+	[GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
+	[GCC_VENUS0_AHB_CLK] = &gcc_venus0_ahb_clk.clkr,
+	[GCC_VENUS0_AXI_CLK] = &gcc_venus0_axi_clk.clkr,
+	[GCC_VENUS0_CORE0_VCODEC0_CLK] = &gcc_venus0_core0_vcodec0_clk.clkr,
+	[GCC_VENUS0_CORE1_VCODEC0_CLK] = &gcc_venus0_core1_vcodec0_clk.clkr,
+	[GCC_VENUS0_VCODEC0_CLK] = &gcc_venus0_vcodec0_clk.clkr,
+	[GCC_APSS_AHB_CLK] = &gcc_apss_ahb_clk.clkr,
+	[GCC_APSS_AXI_CLK] = &gcc_apss_axi_clk.clkr,
+	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
+	[GCC_BLSP2_AHB_CLK] = &gcc_blsp2_ahb_clk.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
+	[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
+	[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
+	[GCC_CPP_TBU_CLK] = &gcc_cpp_tbu_clk.clkr,
+	[GCC_APSS_TCU_CLK] = &gcc_apss_tcu_clk.clkr,
+	[GCC_JPEG_TBU_CLK] = &gcc_jpeg_tbu_clk.clkr,
+	[GCC_MDP_RT_TBU_CLK] = &gcc_mdp_rt_tbu_clk.clkr,
+	[GCC_MDP_TBU_CLK] = &gcc_mdp_tbu_clk.clkr,
+	[GCC_SMMU_CFG_CLK] = &gcc_smmu_cfg_clk.clkr,
+	[GCC_VENUS_1_TBU_CLK] = &gcc_venus_1_tbu_clk.clkr,
+	[GCC_VENUS_TBU_CLK] = &gcc_venus_tbu_clk.clkr,
+	[GCC_VFE1_TBU_CLK] = &gcc_vfe1_tbu_clk.clkr,
+	[GCC_VFE_TBU_CLK] = &gcc_vfe_tbu_clk.clkr,
+	[GCC_APS_0_CLK] = &gcc_aps_0_clk.clkr,
+	[GCC_APS_1_CLK] = &gcc_aps_1_clk.clkr,
+	[APS_0_CLK_SRC] = &aps_0_clk_src.clkr,
+	[APS_1_CLK_SRC] = &aps_1_clk_src.clkr,
+	[APSS_AHB_CLK_SRC] = &apss_ahb_clk_src.clkr,
+	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP1_SPI_APPS_CLK_SRC] = &blsp1_qup1_spi_apps_clk_src.clkr,
+	[BLSP1_QUP2_I2C_APPS_CLK_SRC] = &blsp1_qup2_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP2_SPI_APPS_CLK_SRC] = &blsp1_qup2_spi_apps_clk_src.clkr,
+	[BLSP1_QUP3_I2C_APPS_CLK_SRC] = &blsp1_qup3_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP3_SPI_APPS_CLK_SRC] = &blsp1_qup3_spi_apps_clk_src.clkr,
+	[BLSP1_QUP4_I2C_APPS_CLK_SRC] = &blsp1_qup4_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP4_SPI_APPS_CLK_SRC] = &blsp1_qup4_spi_apps_clk_src.clkr,
+	[BLSP1_UART1_APPS_CLK_SRC] = &blsp1_uart1_apps_clk_src.clkr,
+	[BLSP1_UART2_APPS_CLK_SRC] = &blsp1_uart2_apps_clk_src.clkr,
+	[BLSP2_QUP1_I2C_APPS_CLK_SRC] = &blsp2_qup1_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP1_SPI_APPS_CLK_SRC] = &blsp2_qup1_spi_apps_clk_src.clkr,
+	[BLSP2_QUP2_I2C_APPS_CLK_SRC] = &blsp2_qup2_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP2_SPI_APPS_CLK_SRC] = &blsp2_qup2_spi_apps_clk_src.clkr,
+	[BLSP2_QUP3_I2C_APPS_CLK_SRC] = &blsp2_qup3_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP3_SPI_APPS_CLK_SRC] = &blsp2_qup3_spi_apps_clk_src.clkr,
+	[BLSP2_QUP4_I2C_APPS_CLK_SRC] = &blsp2_qup4_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP4_SPI_APPS_CLK_SRC] = &blsp2_qup4_spi_apps_clk_src.clkr,
+	[BLSP2_UART1_APPS_CLK_SRC] = &blsp2_uart1_apps_clk_src.clkr,
+	[BLSP2_UART2_APPS_CLK_SRC] = &blsp2_uart2_apps_clk_src.clkr,
+	[CCI_CLK_SRC] = &cci_clk_src.clkr,
+	[CPP_CLK_SRC] = &cpp_clk_src.clkr,
+	[CSI0_CLK_SRC] = &csi0_clk_src.clkr,
+	[CSI1_CLK_SRC] = &csi1_clk_src.clkr,
+	[CSI2_CLK_SRC] = &csi2_clk_src.clkr,
+	[CAMSS_GP0_CLK_SRC] = &camss_gp0_clk_src.clkr,
+	[CAMSS_GP1_CLK_SRC] = &camss_gp1_clk_src.clkr,
+	[JPEG0_CLK_SRC] = &jpeg0_clk_src.clkr,
+	[MCLK0_CLK_SRC] = &mclk0_clk_src.clkr,
+	[MCLK1_CLK_SRC] = &mclk1_clk_src.clkr,
+	[MCLK2_CLK_SRC] = &mclk2_clk_src.clkr,
+	[CSI0PHYTIMER_CLK_SRC] = &csi0phytimer_clk_src.clkr,
+	[CSI1PHYTIMER_CLK_SRC] = &csi1phytimer_clk_src.clkr,
+	[CAMSS_TOP_AHB_CLK_SRC] = &camss_top_ahb_clk_src.clkr,
+	[VFE0_CLK_SRC] = &vfe0_clk_src.clkr,
+	[VFE1_CLK_SRC] = &vfe1_clk_src.clkr,
+	[CRYPTO_CLK_SRC] = &crypto_clk_src.clkr,
+	[GP1_CLK_SRC] = &gp1_clk_src.clkr,
+	[GP2_CLK_SRC] = &gp2_clk_src.clkr,
+	[GP3_CLK_SRC] = &gp3_clk_src.clkr,
+	[ESC0_CLK_SRC] = &esc0_clk_src.clkr,
+	[ESC1_CLK_SRC] = &esc1_clk_src.clkr,
+	[MDP_CLK_SRC] = &mdp_clk_src.clkr,
+	[VSYNC_CLK_SRC] = &vsync_clk_src.clkr,
+	[PDM2_CLK_SRC] = &pdm2_clk_src.clkr,
+	[RBCPR_GFX_CLK_SRC] = &rbcpr_gfx_clk_src.clkr,
+	[SDCC1_APPS_CLK_SRC] = &sdcc1_apps_clk_src.clkr,
+	[SDCC1_ICE_CORE_CLK_SRC] = &sdcc1_ice_core_clk_src.clkr,
+	[SDCC2_APPS_CLK_SRC] = &sdcc2_apps_clk_src.clkr,
+	[SDCC3_APPS_CLK_SRC] = &sdcc3_apps_clk_src.clkr,
+	[USB_FS_IC_CLK_SRC] = &usb_fs_ic_clk_src.clkr,
+	[USB_FS_SYSTEM_CLK_SRC] = &usb_fs_system_clk_src.clkr,
+	[USB_HS_SYSTEM_CLK_SRC] = &usb_hs_system_clk_src.clkr,
+	[VCODEC0_CLK_SRC] = &vcodec0_clk_src.clkr,
+	[GCC_MDSS_BYTE0_CLK_SRC] = &byte0_clk_src.clkr,
+	[GCC_MDSS_BYTE1_CLK_SRC] = &byte1_clk_src.clkr,
+	[GCC_MDSS_BYTE0_CLK] = &gcc_mdss_byte0_clk.clkr,
+	[GCC_MDSS_BYTE1_CLK] = &gcc_mdss_byte1_clk.clkr,
+	[GCC_MDSS_PCLK0_CLK_SRC] = &pclk0_clk_src.clkr,
+	[GCC_MDSS_PCLK1_CLK_SRC] = &pclk1_clk_src.clkr,
+	[GCC_MDSS_PCLK0_CLK] = &gcc_mdss_pclk0_clk.clkr,
+	[GCC_MDSS_PCLK1_CLK] = &gcc_mdss_pclk1_clk.clkr,
+	[GCC_GFX3D_CLK_SRC] = &gfx3d_clk_src.clkr,
+	[GCC_GFX3D_OXILI_CLK] = &gcc_oxili_gfx3d_clk.clkr,
+	[GCC_GFX3D_BIMC_CLK] = &gcc_bimc_gfx_clk.clkr,
+	[GCC_GFX3D_OXILI_AHB_CLK] = &gcc_oxili_ahb_clk.clkr,
+	[GCC_GFX3D_OXILI_AON_CLK] = &gcc_oxili_aon_clk.clkr,
+	[GCC_GFX3D_OXILI_GMEM_CLK] = &gcc_oxili_gmem_clk.clkr,
+	[GCC_GFX3D_OXILI_TIMER_CLK] = &gcc_oxili_timer_clk.clkr,
+	[GCC_GFX3D_TBU0_CLK] = &gcc_gfx_tbu_clk.clkr,
+	[GCC_GFX3D_TBU1_CLK] = &gcc_gfx_1_tbu_clk.clkr,
+	[GCC_GFX3D_TCU_CLK] = &gcc_gfx_tcu_clk.clkr,
+	[GCC_GFX3D_GTCU_AHB_CLK] = &gcc_gtcu_ahb_clk.clkr,
+};
+
+static const struct qcom_reset_map gcc_msm8976_resets[] = {
+	[RST_CAMSS_MICRO_BCR]	= { 0x56008 },
+	[RST_USB_HS_BCR]	= { 0x41000 },
+	[RST_QUSB2_PHY_BCR]	= { 0x4103c },
+	[RST_USB2_HS_PHY_ONLY_BCR]	= { 0x41034 },
+	[RST_USB_HS_PHY_CFG_AHB_BCR]	= { 0x41038 },
+	[RST_USB_FS_BCR]	= { 0x3f000 },
+	[RST_CAMSS_CSI1PIX_BCR]	= { 0x4f054 },
+	[RST_CAMSS_CSI_VFE1_BCR]	= { 0x58070 },
+	[RST_CAMSS_VFE1_BCR]	= { 0x5807c },
+	[RST_CAMSS_CPP_BCR]	= { 0x58080 },
+};
+
+static struct gdsc *gcc_msm8976_gdscs[] = {
+	[VENUS_GDSC] = &venus_gdsc,
+	[VENUS_CORE0_GDSC] = &venus_core0_gdsc,
+	[VENUS_CORE1_GDSC] = &venus_core1_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[JPEG_GDSC] = &jpeg_gdsc,
+	[VFE0_GDSC] = &vfe0_gdsc,
+	[VFE1_GDSC] = &vfe1_gdsc,
+	[CPP_GDSC] = &cpp_gdsc,
+	[OXILI_GX_GDSC] = &oxili_gx_gdsc,
+	[OXILI_CX_GDSC] = &oxili_cx_gdsc,
+};
+
+static const struct regmap_config gcc_msm8976_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x7fffc,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc gcc_msm8976_desc = {
+	.config		= &gcc_msm8976_regmap_config,
+	.clks		= gcc_msm8976_clocks,
+	.num_clks	= ARRAY_SIZE(gcc_msm8976_clocks),
+	.resets		= gcc_msm8976_resets,
+	.num_resets	= ARRAY_SIZE(gcc_msm8976_resets),
+	.gdscs		= gcc_msm8976_gdscs,
+	.num_gdscs	= ARRAY_SIZE(gcc_msm8976_gdscs),
+};
+
+static const struct of_device_id gcc_msm8976_match_table[] = {
+	{ .compatible = "qcom,gcc-msm8976" }, /* Also valid for 8x56 */
+	{ .compatible = "qcom,gcc-msm8976-v1.1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gcc_msm8976_match_table);
+
+static int gcc_msm8976_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	bool is_msm8976v1_1;
+	int ret;
+	u32 val;
+
+	is_msm8976v1_1 = of_device_is_compatible(pdev->dev.of_node, "qcom,gcc-msm8976-v1.1");
+
+	if(is_msm8976v1_1) {
+		sdcc1_apps_clk_src.parent_map = gcc_parent_map_v1_1;
+		sdcc1_apps_clk_src.freq_tbl = ftbl_sdcc1_8976_v1_1_apps_clk_src;
+		sdcc1_apps_clk_src.clkr.hw.init = &sdcc1_apps_clk_src_8976v1_1_init;
+	}
+
+	regmap = qcom_cc_map(pdev, &gcc_msm8976_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = qcom_cc_really_probe(pdev, &gcc_msm8976_desc, regmap);
+	if (ret)
+		return ret;
+
+	/* Configure Sleep and Wakeup cycles for GMEM clock */
+	regmap_read(regmap, 0x59024, &val);
+	val ^= 0xFF0;
+	val |= (0 << 8);
+	val |= (0 << 4);
+	regmap_write(regmap, 0x59024, val);
+
+	clk_pll_configure_sr_hpm_lp(&gpll3, regmap, &gpll3_config, true);
+
+	/* Enable AUX2 clock for APSS */
+	regmap_update_bits(regmap, 0x60000, BIT(2), BIT(2));
+
+	/* Configure Sleep and Wakeup cycles for OXILI clock */
+	val = regmap_read(regmap, 0x59020, &val);
+	val &= ~0xF0;
+	val |= (0 << 4);
+	regmap_write(regmap, 0x59020, val);
+
+	return 0;
+}
+
+static struct platform_driver gcc_msm8976_driver = {
+	.probe = gcc_msm8976_probe,
+	.driver = {
+		.name = "qcom,gcc-msm8976",
+		.of_match_table = gcc_msm8976_match_table,
+	},
+};
+
+static int __init gcc_msm8976_init(void)
+{
+	return platform_driver_register(&gcc_msm8976_driver);
+}
+core_initcall_sync(gcc_msm8976_init);
+
+static void __exit gcc_msm8976_exit(void)
+{
+	platform_driver_unregister(&gcc_msm8976_driver);
+}
+module_exit(gcc_msm8976_exit);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8976.h b/include/dt-bindings/clock/qcom,gcc-msm8976.h
new file mode 100644
index 000000000000..70ef3af6dd48
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-msm8976.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2016-2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ *
+ * Author: AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_GCC_8976_H
+#define _DT_BINDINGS_CLK_MSM_GCC_8976_H
+
+#define GPLL0					0
+#define GPLL2					1
+#define GPLL3					2
+#define GPLL4					3
+#define GPLL6					4
+#define GPLL0_CLK_SRC				5
+#define GPLL2_CLK_SRC				6
+#define GPLL3_CLK_SRC				7
+#define GPLL4_CLK_SRC				8
+#define GPLL6_CLK_SRC				9
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK		10
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK		11
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK		12
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK		13
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK		14
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK		15
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK		16
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK		17
+#define GCC_BLSP1_UART1_APPS_CLK		18
+#define GCC_BLSP1_UART2_APPS_CLK		19
+#define GCC_BLSP2_QUP1_I2C_APPS_CLK		20
+#define GCC_BLSP2_QUP1_SPI_APPS_CLK		21
+#define GCC_BLSP2_QUP2_I2C_APPS_CLK		22
+#define GCC_BLSP2_QUP2_SPI_APPS_CLK		23
+#define GCC_BLSP2_QUP3_I2C_APPS_CLK		24
+#define GCC_BLSP2_QUP3_SPI_APPS_CLK		25
+#define GCC_BLSP2_QUP4_I2C_APPS_CLK		26
+#define GCC_BLSP2_QUP4_SPI_APPS_CLK		27
+#define GCC_BLSP2_UART1_APPS_CLK		28
+#define GCC_BLSP2_UART2_APPS_CLK		29
+#define GCC_CAMSS_CCI_AHB_CLK			30
+#define GCC_CAMSS_CCI_CLK				31
+#define GCC_CAMSS_CPP_AHB_CLK			32
+#define GCC_CAMSS_CPP_AXI_CLK			33
+#define GCC_CAMSS_CPP_CLK				34
+#define GCC_CAMSS_CSI0_AHB_CLK			35
+#define GCC_CAMSS_CSI0_CLK				36
+#define GCC_CAMSS_CSI0PHY_CLK			37
+#define GCC_CAMSS_CSI0PIX_CLK			38
+#define GCC_CAMSS_CSI0RDI_CLK			39
+#define GCC_CAMSS_CSI1_AHB_CLK			40
+#define GCC_CAMSS_CSI1_CLK				41
+#define GCC_CAMSS_CSI1PHY_CLK			42
+#define GCC_CAMSS_CSI1PIX_CLK			43
+#define GCC_CAMSS_CSI1RDI_CLK			44
+#define GCC_CAMSS_CSI2_AHB_CLK			45
+#define GCC_CAMSS_CSI2_CLK				46
+#define GCC_CAMSS_CSI2PHY_CLK			47
+#define GCC_CAMSS_CSI2PIX_CLK			48
+#define GCC_CAMSS_CSI2RDI_CLK			49
+#define GCC_CAMSS_CSI_VFE0_CLK			50
+#define GCC_CAMSS_CSI_VFE1_CLK			51
+#define GCC_CAMSS_GP0_CLK				52
+#define GCC_CAMSS_GP1_CLK				53
+#define GCC_CAMSS_ISPIF_AHB_CLK			54
+#define GCC_CAMSS_JPEG0_CLK				55
+#define GCC_CAMSS_JPEG_AHB_CLK			56
+#define GCC_CAMSS_JPEG_AXI_CLK			57
+#define GCC_CAMSS_MCLK0_CLK				58
+#define GCC_CAMSS_MCLK1_CLK				59
+#define GCC_CAMSS_MCLK2_CLK				60
+#define GCC_CAMSS_MICRO_AHB_CLK			61
+#define GCC_CAMSS_CSI0PHYTIMER_CLK		62
+#define GCC_CAMSS_CSI1PHYTIMER_CLK		63
+#define GCC_CAMSS_AHB_CLK				64
+#define GCC_CAMSS_TOP_AHB_CLK			65
+#define GCC_CAMSS_VFE0_CLK				66
+#define GCC_CAMSS_VFE_AHB_CLK			67
+#define GCC_CAMSS_VFE_AXI_CLK			68
+#define GCC_CAMSS_VFE1_AHB_CLK			69
+#define GCC_CAMSS_VFE1_AXI_CLK			70
+#define GCC_CAMSS_VFE1_CLK				71
+#define GCC_DCC_CLK						72
+#define GCC_GP1_CLK						73
+#define GCC_GP2_CLK						74
+#define GCC_GP3_CLK						75
+#define GCC_MDSS_AHB_CLK				76
+#define GCC_MDSS_AXI_CLK				77
+#define GCC_MDSS_ESC0_CLK				78
+#define GCC_MDSS_ESC1_CLK				79
+#define GCC_MDSS_MDP_CLK				80
+#define GCC_MDSS_VSYNC_CLK				81
+#define GCC_MSS_CFG_AHB_CLK				82
+#define GCC_MSS_Q6_BIMC_AXI_CLK			83
+#define GCC_PDM2_CLK					84
+#define GCC_PRNG_AHB_CLK				85
+#define GCC_PDM_AHB_CLK					86
+#define GCC_RBCPR_GFX_AHB_CLK			87
+#define GCC_RBCPR_GFX_CLK				88
+#define GCC_SDCC1_AHB_CLK				89
+#define GCC_SDCC1_APPS_CLK				90
+#define GCC_SDCC1_ICE_CORE_CLK			91
+#define GCC_SDCC2_AHB_CLK				92
+#define GCC_SDCC2_APPS_CLK				93
+#define GCC_SDCC3_AHB_CLK				94
+#define GCC_SDCC3_APPS_CLK				95
+#define GCC_USB2A_PHY_SLEEP_CLK			96
+#define GCC_USB_HS_PHY_CFG_AHB_CLK		97
+#define GCC_USB_FS_AHB_CLK				98
+#define GCC_USB_FS_IC_CLK				99
+#define GCC_USB_FS_SYSTEM_CLK			100
+#define GCC_USB_HS_AHB_CLK				101
+#define GCC_USB_HS_SYSTEM_CLK			102
+#define GCC_VENUS0_AHB_CLK				103
+#define GCC_VENUS0_AXI_CLK				104
+#define GCC_VENUS0_CORE0_VCODEC0_CLK	105
+#define GCC_VENUS0_CORE1_VCODEC0_CLK	106
+#define GCC_VENUS0_VCODEC0_CLK			107
+#define GCC_APSS_AHB_CLK				108
+#define GCC_APSS_AXI_CLK				109
+#define GCC_BLSP1_AHB_CLK				110
+#define GCC_BLSP2_AHB_CLK				111
+#define GCC_BOOT_ROM_AHB_CLK			112
+#define GCC_CRYPTO_AHB_CLK				113
+#define GCC_CRYPTO_AXI_CLK				114
+#define GCC_CRYPTO_CLK					115
+#define GCC_CPP_TBU_CLK					116
+#define GCC_APSS_TCU_CLK				117
+#define GCC_JPEG_TBU_CLK				118
+#define GCC_MDP_RT_TBU_CLK				119
+#define GCC_MDP_TBU_CLK					120
+#define GCC_SMMU_CFG_CLK				121
+#define GCC_VENUS_1_TBU_CLK				122
+#define GCC_VENUS_TBU_CLK				123
+#define GCC_VFE1_TBU_CLK				124
+#define GCC_VFE_TBU_CLK					125
+#define GCC_APS_0_CLK					126
+#define GCC_APS_1_CLK					127
+#define APS_0_CLK_SRC					128
+#define APS_1_CLK_SRC					129
+#define APSS_AHB_CLK_SRC				130
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC		131
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC		132
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC		133
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC		134
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC		135
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC		136
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC		137
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC		138
+#define BLSP1_UART1_APPS_CLK_SRC		139
+#define BLSP1_UART2_APPS_CLK_SRC		140
+#define BLSP2_QUP1_I2C_APPS_CLK_SRC		141
+#define BLSP2_QUP1_SPI_APPS_CLK_SRC		142
+#define BLSP2_QUP2_I2C_APPS_CLK_SRC		143
+#define BLSP2_QUP2_SPI_APPS_CLK_SRC		144
+#define BLSP2_QUP3_I2C_APPS_CLK_SRC		145
+#define BLSP2_QUP3_SPI_APPS_CLK_SRC		146
+#define BLSP2_QUP4_I2C_APPS_CLK_SRC		147
+#define BLSP2_QUP4_SPI_APPS_CLK_SRC		148
+#define BLSP2_UART1_APPS_CLK_SRC		149
+#define BLSP2_UART2_APPS_CLK_SRC		150
+#define CCI_CLK_SRC						151
+#define CPP_CLK_SRC						152
+#define CSI0_CLK_SRC					153
+#define CSI1_CLK_SRC					154
+#define CSI2_CLK_SRC					155
+#define CAMSS_GP0_CLK_SRC				156
+#define CAMSS_GP1_CLK_SRC				157
+#define JPEG0_CLK_SRC					158
+#define MCLK0_CLK_SRC					159
+#define MCLK1_CLK_SRC					160
+#define MCLK2_CLK_SRC					161
+#define CSI0PHYTIMER_CLK_SRC			162
+#define CSI1PHYTIMER_CLK_SRC			163
+#define CAMSS_TOP_AHB_CLK_SRC			164
+#define VFE0_CLK_SRC					165
+#define VFE1_CLK_SRC					166
+#define CRYPTO_CLK_SRC					167
+#define GP1_CLK_SRC						168
+#define GP2_CLK_SRC						169
+#define GP3_CLK_SRC						170
+#define ESC0_CLK_SRC					171
+#define ESC1_CLK_SRC					172
+#define MDP_CLK_SRC						173
+#define VSYNC_CLK_SRC					174
+#define PDM2_CLK_SRC					175
+#define RBCPR_GFX_CLK_SRC				176
+#define SDCC1_APPS_CLK_SRC				177
+#define SDCC1_ICE_CORE_CLK_SRC			178
+#define SDCC2_APPS_CLK_SRC				179
+#define SDCC3_APPS_CLK_SRC				180
+#define USB_FS_IC_CLK_SRC				181
+#define USB_FS_SYSTEM_CLK_SRC			182
+#define USB_HS_SYSTEM_CLK_SRC			183
+#define VCODEC0_CLK_SRC					184
+#define GCC_MDSS_BYTE0_CLK_SRC			185
+#define GCC_MDSS_BYTE1_CLK_SRC			186
+#define GCC_MDSS_BYTE0_CLK				187
+#define GCC_MDSS_BYTE1_CLK				188
+#define GCC_MDSS_PCLK0_CLK_SRC			189
+#define GCC_MDSS_PCLK1_CLK_SRC			190
+#define GCC_MDSS_PCLK0_CLK				191
+#define GCC_MDSS_PCLK1_CLK				192
+#define GCC_GFX3D_CLK_SRC				193
+#define GCC_GFX3D_OXILI_CLK				194
+#define GCC_GFX3D_BIMC_CLK				195
+#define GCC_GFX3D_OXILI_AHB_CLK			196
+#define GCC_GFX3D_OXILI_AON_CLK			197
+#define GCC_GFX3D_OXILI_GMEM_CLK		198
+#define GCC_GFX3D_OXILI_TIMER_CLK		199
+#define GCC_GFX3D_TBU0_CLK				200
+#define GCC_GFX3D_TBU1_CLK				201
+#define GCC_GFX3D_TCU_CLK				202
+#define GCC_GFX3D_GTCU_AHB_CLK			203
+
+/* GCC block resets */
+#define RST_CAMSS_MICRO_BCR			0
+#define RST_USB_HS_BCR				1
+#define RST_QUSB2_PHY_BCR			2
+#define RST_USB2_HS_PHY_ONLY_BCR		3
+#define RST_USB_HS_PHY_CFG_AHB_BCR		4
+#define RST_USB_FS_BCR				5
+#define RST_CAMSS_CSI1PIX_BCR			6
+#define RST_CAMSS_CSI_VFE1_BCR			7
+#define RST_CAMSS_VFE1_BCR			8
+#define RST_CAMSS_CPP_BCR			9
+
+/* GDSCs */
+#define VENUS_GDSC				0
+#define VENUS_CORE0_GDSC			1
+#define VENUS_CORE1_GDSC			2
+#define MDSS_GDSC				3
+#define JPEG_GDSC				4
+#define VFE0_GDSC				5
+#define VFE1_GDSC				6
+#define CPP_GDSC				7
+#define OXILI_GX_GDSC				8
+#define OXILI_CX_GDSC				9
+
+#endif /* _DT_BINDINGS_CLK_MSM_GCC_8976_H */
-- 
2.30.1

