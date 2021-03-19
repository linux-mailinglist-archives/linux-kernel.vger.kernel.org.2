Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1CB341D41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCSMpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:45:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46332 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCSMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:44:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCgLJm108086;
        Fri, 19 Mar 2021 07:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157741;
        bh=RtQqczVf3xO+BfFwvayFn2o9BOZNrvZ7FYjTi7+UBlU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oWLEMdVcoU/Hvx9+86CI18KIF9lhF2OqpOxaDnkr4uiLdJ+d2iX02R6Hf4kaUKqn7
         qLrw8EqdNNU4Fzw1x2hjrC19eW5UWIFkpll3rBBK4MfUQFQw2K8wdNWOBJUhKpHZ6R
         K6X51FXdopZOj2zoWAD1n0koxjU8XEQMubAJfw7U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCgLbT086664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:42:21 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:42:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:42:21 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTfD011913;
        Fri, 19 Mar 2021 07:42:17 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 12/13] phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Date:   Fri, 19 Mar 2021 18:11:27 +0530
Message-ID: <20210319124128.13308-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra has two PLLs, PLL_CMNLC and PLL_CMNLC1 and each of these PLLs has
two inputs, plllc_refclk (input from pll0_refclk) and refrcv (input from
pll1_refclk). Model PLL_CMNLC and PLL_CMNLC1 as clocks so that it's
possible to select one of these two inputs from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/Kconfig              |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c | 267 ++++++++++++++++++++++-
 2 files changed, 265 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 27e9d6c377e5..a62910ff5591 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -25,6 +25,7 @@ config PHY_CADENCE_DPHY
 config PHY_CADENCE_SIERRA
 	tristate "Cadence Sierra PHY Driver"
 	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	depends on COMMON_CLK
 	select GENERIC_PHY
 	help
 	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index ac32b7b0289f..039ca10db59d 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -7,6 +7,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -20,10 +21,12 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
 
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
+#define SIERRA_CMN_PLLLC_GEN_PREG			0x42
 #define SIERRA_CMN_PLLLC_MODE_PREG			0x48
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
@@ -31,6 +34,9 @@
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
+#define SIERRA_CMN_REFRCV_PREG				0x98
+#define SIERRA_CMN_REFRCV1_PREG				0xB8
+#define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -144,13 +150,19 @@
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
-#define CDNS_SIERRA_INPUT_CLOCKS			3
+#define CDNS_SIERRA_OUTPUT_CLOCKS			2
+#define CDNS_SIERRA_INPUT_CLOCKS			5
 enum cdns_sierra_clock_input {
 	PHY_CLK,
 	CMN_REFCLK_DIG_DIV,
 	CMN_REFCLK1_DIG_DIV,
+	PLL0_REFCLK,
+	PLL1_REFCLK,
 };
 
+#define SIERRA_NUM_CMN_PLLC				2
+#define SIERRA_NUM_CMN_PLLC_PARENTS			2
+
 static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
@@ -158,6 +170,53 @@ static const struct reg_field phy_pll_cfg_1 =
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
+static const char * const clk_names[] = {
+	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
+	[CDNS_SIERRA_PLL_CMNLC1] = "pll_cmnlc1",
+};
+
+enum cdns_sierra_cmn_plllc {
+	CMN_PLLLC,
+	CMN_PLLLC1,
+};
+
+struct cdns_sierra_pll_mux_reg_fields {
+	struct reg_field	pfdclk_sel_preg;
+	struct reg_field	plllc1en_field;
+	struct reg_field	termen_field;
+};
+
+static const struct cdns_sierra_pll_mux_reg_fields cmn_plllc_pfdclk1_sel_preg[] = {
+	[CMN_PLLLC] = {
+		.pfdclk_sel_preg = REG_FIELD(SIERRA_CMN_PLLLC_GEN_PREG, 1, 1),
+		.plllc1en_field = REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 8, 8),
+		.termen_field = REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 0, 0),
+	},
+	[CMN_PLLLC1] = {
+		.pfdclk_sel_preg = REG_FIELD(SIERRA_CMN_PLLLC1_GEN_PREG, 1, 1),
+		.plllc1en_field = REG_FIELD(SIERRA_CMN_REFRCV_PREG, 8, 8),
+		.termen_field = REG_FIELD(SIERRA_CMN_REFRCV_PREG, 0, 0),
+	},
+};
+
+struct cdns_sierra_pll_mux {
+	struct clk_hw		hw;
+	struct regmap_field	*pfdclk_sel_preg;
+	struct regmap_field	*plllc1en_field;
+	struct regmap_field	*termen_field;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_sierra_pll_mux(_hw)	\
+			container_of(_hw, struct cdns_sierra_pll_mux, hw)
+
+static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
+	[CMN_PLLLC] = { PLL0_REFCLK, PLL1_REFCLK },
+	[CMN_PLLLC1] = { PLL1_REFCLK, PLL0_REFCLK },
+};
+
+static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
+
 struct cdns_sierra_inst {
 	struct phy *phy;
 	u32 phy_type;
@@ -204,10 +263,15 @@ struct cdns_sierra_phy {
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
+	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
+	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
+	struct regmap_field *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
 	struct clk *input_clks[CDNS_SIERRA_INPUT_CLOCKS];
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
+	struct clk_onecell_data clk_data;
+	struct clk *output_clks[CDNS_SIERRA_OUTPUT_CLOCKS];
 };
 
 static int cdns_regmap_write(void *context, unsigned int reg, unsigned int val)
@@ -369,6 +433,153 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
+{
+	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *field = mux->pfdclk_sel_preg;
+	unsigned int val;
+
+	regmap_field_read(field, &val);
+	return clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table, 0, val);
+}
+
+static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *plllc1en_field = mux->plllc1en_field;
+	struct regmap_field *termen_field = mux->termen_field;
+	struct regmap_field *field = mux->pfdclk_sel_preg;
+	int val, ret;
+
+	ret = regmap_field_write(plllc1en_field, 0);
+	ret |= regmap_field_write(termen_field, 0);
+	if (index == 1) {
+		ret |= regmap_field_write(plllc1en_field, 1);
+		ret |= regmap_field_write(termen_field, 1);
+	}
+
+	val = cdns_sierra_pll_mux_table[index];
+	ret |= regmap_field_write(field, val);
+
+	return ret;
+}
+
+static const struct clk_ops cdns_sierra_pll_mux_ops = {
+	.set_parent = cdns_sierra_pll_mux_set_parent,
+	.get_parent = cdns_sierra_pll_mux_get_parent,
+};
+
+static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
+					struct regmap_field *pfdclk1_sel_field,
+					struct regmap_field *plllc1en_field,
+					struct regmap_field *termen_field,
+					int clk_index)
+{
+	struct cdns_sierra_pll_mux *mux;
+	struct device *dev = sp->dev;
+	struct clk_init_data *init;
+	const char **parent_names;
+	unsigned int num_parents;
+	char clk_name[100];
+	struct clk *clk;
+	int i;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	num_parents = SIERRA_NUM_CMN_PLLC_PARENTS;
+	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	for (i = 0; i < num_parents; i++) {
+		clk = sp->input_clks[pll_mux_parent_index[clk_index][i]];
+		if (IS_ERR_OR_NULL(clk)) {
+			dev_err(dev, "No parent clock for derived_refclk\n");
+			return PTR_ERR(clk);
+		}
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev), clk_names[clk_index]);
+
+	init = &mux->clk_data;
+
+	init->ops = &cdns_sierra_pll_mux_ops;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+	init->name = clk_name;
+
+	mux->pfdclk_sel_preg = pfdclk1_sel_field;
+	mux->plllc1en_field = plllc1en_field;
+	mux->termen_field = termen_field;
+	mux->hw.init = init;
+
+	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	sp->output_clks[clk_index] = clk;
+
+	return 0;
+}
+
+static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp)
+{
+	struct regmap_field *pfdclk1_sel_field;
+	struct regmap_field *plllc1en_field;
+	struct regmap_field *termen_field;
+	struct device *dev = sp->dev;
+	int ret = 0, i, clk_index;
+
+	clk_index = CDNS_SIERRA_PLL_CMNLC;
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++, clk_index++) {
+		pfdclk1_sel_field = sp->cmn_plllc_pfdclk1_sel_preg[i];
+		plllc1en_field = sp->cmn_refrcv_refclk_plllc1en_preg[i];
+		termen_field = sp->cmn_refrcv_refclk_termen_preg[i];
+
+		ret = cdns_sierra_pll_mux_register(sp, pfdclk1_sel_field, plllc1en_field,
+						   termen_field, clk_index);
+		if (ret) {
+			dev_err(dev, "Fail to register cmn plllc mux\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void cdns_sierra_clk_unregister(struct cdns_sierra_phy *sp)
+{
+	struct device *dev = sp->dev;
+	struct device_node *node = dev->of_node;
+
+	of_clk_del_provider(node);
+}
+
+static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
+{
+	struct device *dev = sp->dev;
+	struct device_node *node = dev->of_node;
+	int ret;
+
+	ret = cdns_sierra_phy_register_pll_mux(sp);
+	if (ret) {
+		dev_err(dev, "Failed to pll mux clocks\n");
+		return ret;
+	}
+
+	sp->clk_data.clks = sp->output_clks;
+	sp->clk_data.clk_num = CDNS_SIERRA_OUTPUT_CLOCKS;
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &sp->clk_data);
+	if (ret)
+		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
+
+	return ret;
+}
+
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
@@ -407,6 +618,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
+	struct reg_field reg_field;
 	struct regmap *regmap;
 	int i;
 
@@ -418,6 +630,32 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->macro_id_type = field;
 
+	for (i = 0; i < SIERRA_NUM_CMN_PLLC; i++) {
+		reg_field = cmn_plllc_pfdclk1_sel_preg[i].pfdclk_sel_preg;
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PLLLC%d_PFDCLK1_SEL failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_plllc_pfdclk1_sel_preg[i] = field;
+
+		reg_field = cmn_plllc_pfdclk1_sel_preg[i].plllc1en_field;
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "REFRCV%d_REFCLK_PLLLC1EN failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_refrcv_refclk_plllc1en_preg[i] = field;
+
+		reg_field = cmn_plllc_pfdclk1_sel_preg[i].termen_field;
+		field = devm_regmap_field_alloc(dev, regmap, reg_field);
+		if (IS_ERR(field)) {
+			dev_err(dev, "REFRCV%d_REFCLK_TERMEN failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->cmn_refrcv_refclk_termen_preg[i] = field;
+	}
+
 	regmap = sp->regmap_phy_config_ctrl;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
 	if (IS_ERR(field)) {
@@ -511,6 +749,22 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	}
 	sp->input_clks[CMN_REFCLK1_DIG_DIV] = clk;
 
+	clk = devm_clk_get_optional(dev, "pll0_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "pll0_refclk clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->input_clks[PLL0_REFCLK] = clk;
+
+	clk = devm_clk_get_optional(dev, "pll1_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "pll1_refclk clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->input_clks[PLL1_REFCLK] = clk;
+
 	return 0;
 }
 
@@ -586,13 +840,17 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = cdns_sierra_phy_get_resets(sp, dev);
+	ret = cdns_sierra_clk_register(sp);
 	if (ret)
 		return ret;
 
+	ret = cdns_sierra_phy_get_resets(sp, dev);
+	if (ret)
+		goto unregister_clk;
+
 	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
 	if (ret)
-		return ret;
+		goto unregister_clk;
 
 	/* Enable APB */
 	reset_control_deassert(sp->apb_rst);
@@ -669,6 +927,8 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 clk_disable:
 	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
 	reset_control_assert(sp->apb_rst);
+unregister_clk:
+	cdns_sierra_clk_unregister(sp);
 	return ret;
 }
 
@@ -691,6 +951,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(phy->input_clks[PHY_CLK]);
+	cdns_sierra_clk_unregister(phy);
 
 	return 0;
 }
-- 
2.17.1

