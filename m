Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F267339B33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhCMCVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:21:38 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:33233 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhCMCUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:20:53 -0500
Received: from localhost.localdomain (abac242.neoplus.adsl.tpnet.pl [83.6.166.242])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C94CF1F9EA;
        Sat, 13 Mar 2021 03:20:50 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
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
Subject: [PATCH 5/9] clk: qcom: gcc-msm8994: Add missing clocks
Date:   Sat, 13 Mar 2021 03:19:14 +0100
Message-Id: <20210313021919.435332-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210313021919.435332-1-konrad.dybcio@somainline.org>
References: <20210313021919.435332-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be the last "add missing clocks" commit, as to
my knowledge there are no more clocks registered within gcc.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/gcc-msm8994.c               | 134 +++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8994.h |   9 ++
 2 files changed, 143 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index f661e28ac14a..962107b5f1af 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -2327,6 +2327,19 @@ static struct clk_branch gcc_usb3_phy_aux_clk = {
 	},
 };
 
+static struct clk_branch gcc_usb3_phy_pipe_clk = {
+	.halt_reg = 0x140c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x140c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_phy_pipe_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb_hs_ahb_clk = {
 	.halt_reg = 0x0488,
 	.clkr = {
@@ -2368,6 +2381,118 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 	},
 };
 
+static struct clk_branch gpll0_out_mmsscc = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1484,
+		.enable_mask = BIT(26),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll0_out_mmsscc",
+			.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpll0_out_msscc = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1484,
+		.enable_mask = BIT(27),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll0_out_msscc",
+			.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch pcie_0_phy_ldo = {
+	.halt_reg = 0x1e00,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1E00,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "pcie_0_phy_ldo",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch pcie_1_phy_ldo = {
+	.halt_reg = 0x1e04,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1E04,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "pcie_1_phy_ldo",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ufs_phy_ldo = {
+	.halt_reg = 0x1e0c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1E0C,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "ufs_phy_ldo",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch usb_ss_phy_ldo = {
+	.halt_reg = 0x1e08,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1E08,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "usb_ss_phy_ldo",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x0e04,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x0e04,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x1484,
+		.enable_mask = BIT(10),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_boot_rom_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_prng_ahb_clk = {
+	.halt_reg = 0x0d04,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x1484,
+		.enable_mask = BIT(13),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_prng_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_gdsc = {
 		.gdscr = 0x1e18,
 		.pd = {
@@ -2550,9 +2675,18 @@ static struct clk_regmap *gcc_msm8994_clocks[] = {
 	[GCC_USB30_MOCK_UTMI_CLK] = &gcc_usb30_mock_utmi_clk.clkr,
 	[GCC_USB30_SLEEP_CLK] = &gcc_usb30_sleep_clk.clkr,
 	[GCC_USB3_PHY_AUX_CLK] = &gcc_usb3_phy_aux_clk.clkr,
+	[GCC_USB3_PHY_PIPE_CLK] = &gcc_usb3_phy_pipe_clk.clkr,
 	[GCC_USB_HS_AHB_CLK] = &gcc_usb_hs_ahb_clk.clkr,
 	[GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
 	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
+	[GPLL0_OUT_MMSSCC] = &gpll0_out_mmsscc.clkr,
+	[GPLL0_OUT_MSSCC] = &gpll0_out_msscc.clkr,
+	[PCIE_0_PHY_LDO] = &pcie_0_phy_ldo.clkr,
+	[PCIE_1_PHY_LDO] = &pcie_1_phy_ldo.clkr,
+	[UFS_PHY_LDO] = &ufs_phy_ldo.clkr,
+	[USB_SS_PHY_LDO] = &usb_ss_phy_ldo.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8994_gdscs[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
index 219d5441c0fa..dcb49817dcec 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
@@ -151,6 +151,15 @@
 #define CONFIG_NOC_CLK_SRC			141
 #define PERIPH_NOC_CLK_SRC			142
 #define SYSTEM_NOC_CLK_SRC			143
+#define GPLL0_OUT_MMSSCC			144
+#define GPLL0_OUT_MSSCC				145
+#define PCIE_0_PHY_LDO				146
+#define PCIE_1_PHY_LDO				147
+#define UFS_PHY_LDO					148
+#define USB_SS_PHY_LDO				149
+#define GCC_BOOT_ROM_AHB_CLK		150
+#define GCC_PRNG_AHB_CLK			151
+#define GCC_USB3_PHY_PIPE_CLK		152
 
 /* GDSCs */
 #define PCIE_GDSC			0
-- 
2.30.2

