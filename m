Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EFA333C46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhCJMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:09:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhCJMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:09:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AC94cW112695;
        Wed, 10 Mar 2021 06:09:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615378145;
        bh=MWUAINRXvdbzGyhyxSuQVF5VDT+7Z7R5TCuAFSFXGpU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=giag1YddeAslXuZhFVXydr+O9V4aMGZWCVQ23JJyDQH5EPYa4QFLiXYKp85u7dcc1
         Qft8ieUNbXv4CQTGVRqvzXlEx4K794u0ptPfsf0oMVbkHmbRwSCyf6C1bd96bqat8C
         tcKnEn2FTgs5AEIDera5wvqj/rX2Ixwzx89Sga9o=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AC944v072806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 06:09:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 06:09:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 06:09:04 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8ghh017368;
        Wed, 10 Mar 2021 06:09:02 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 6/6] phy: cadence-torrent: Add support to drive refclk out
Date:   Wed, 10 Mar 2021 17:38:40 +0530
Message-ID: <20210310120840.16447-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310120840.16447-1-kishon@ti.com>
References: <20210310120840.16447-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmn_refclk_<p/m> lines in Torrent SERDES is used for connecting external
reference clock. cmn_refclk_<p/m> can also be configured to output the
reference clock. Model this derived reference clock as a "clock" so that
platforms like AM642 EVM can enable it.

This is used by PCIe to use the same refclk both in local SERDES
and remote device. Add support here to drive refclk out.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/Kconfig               |   1 +
 drivers/phy/cadence/phy-cadence-torrent.c | 188 +++++++++++++++++++++-
 2 files changed, 186 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 432832bdbd16..27e9d6c377e5 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -7,6 +7,7 @@ config PHY_CADENCE_TORRENT
 	tristate "Cadence Torrent PHY driver"
 	depends on OF
 	depends on HAS_IOMEM
+	depends on COMMON_CLK
 	select GENERIC_PHY
 	help
 	  Support for Cadence Torrent PHY.
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 591a15834b48..c6fee7f75f57 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -7,7 +7,9 @@
  */
 
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence-torrent.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -84,6 +86,8 @@
 #define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
 #define CMN_CDIAG_CDB_PWRI_OVRD		0x0041U
 #define CMN_CDIAG_XCVRC_PWRI_OVRD	0x0047U
+#define CMN_CDIAG_REFCLK_OVRD		0x004CU
+#define CMN_CDIAG_REFCLK_DRV0_CTRL	0x0050U
 #define CMN_BGCAL_INIT_TMR		0x0064U
 #define CMN_BGCAL_ITER_TMR		0x0065U
 #define CMN_IBCAL_INIT_TMR		0x0074U
@@ -206,6 +210,7 @@
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
+#define PHY_PIPE_CMN_CTRL1		0x0000U
 #define PHY_PLL_CFG			0x000EU
 #define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
@@ -216,6 +221,10 @@
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
+static const char * const clk_names[] = {
+	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
+};
+
 static const struct reg_field phy_pll_cfg =
 				REG_FIELD(PHY_PLL_CFG, 0, 1);
 
@@ -231,6 +240,26 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
+
+#define REFCLK_OUT_NUM_CMN_CONFIG	5
+
+enum cdns_torrent_refclk_out_cmn {
+	CMN_CDIAG_REFCLK_OVRD_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
+};
+
+static const struct reg_field refclk_out_cmn_cfg[] = {
+	[CMN_CDIAG_REFCLK_OVRD_4]	= REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
+};
+
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
 	TYPE_DP,
@@ -279,6 +308,8 @@ struct cdns_torrent_phy {
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
+	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
+	struct clk_onecell_data clk_data;
 };
 
 enum phy_powerstate {
@@ -288,6 +319,16 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+struct cdns_torrent_derived_refclk {
+	struct clk_hw		hw;
+	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
+	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_torrent_derived_refclk(_hw)	\
+			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
+
 static int cdns_torrent_phy_init(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
@@ -1604,6 +1645,108 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 	return ret;
 }
 
+static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
+	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
+	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 1);
+
+	return 0;
+}
+
+static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 0);
+}
+
+static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
+	int val;
+
+	regmap_field_read(derived_refclk->phy_pipe_cmn_ctrl1_0, &val);
+
+	return !!val;
+}
+
+static const struct clk_ops cdns_torrent_derived_refclk_ops = {
+	.enable = cdns_torrent_derived_refclk_enable,
+	.disable = cdns_torrent_derived_refclk_disable,
+	.is_enabled = cdns_torrent_derived_refclk_is_enabled,
+};
+
+static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct cdns_torrent_derived_refclk *derived_refclk;
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	const char *parent_name;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk *clk;
+	int i;
+
+	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
+	if (!derived_refclk)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
+
+	clk = devm_clk_get_optional(dev, "phy_en_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "No parent clock for derived_refclk\n");
+		return PTR_ERR(clk);
+	}
+
+	init = &derived_refclk->clk_data;
+
+	if (clk) {
+		parent_name = __clk_get_name(clk);
+		init->parent_names = &parent_name;
+		init->num_parents = 1;
+	}
+	init->ops = &cdns_torrent_derived_refclk_ops;
+	init->flags = 0;
+	init->name = clk_name;
+
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pipe_cmn_ctrl1_0);
+	if (IS_ERR(field)) {
+		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	derived_refclk->phy_pipe_cmn_ctrl1_0 = field;
+
+	regmap = cdns_phy->regmap_common_cdb;
+	for (i = 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
+		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
+		if (IS_ERR(field)) {
+			dev_err(dev, "CMN reg field init failed\n");
+			return PTR_ERR(field);
+		}
+		derived_refclk->cmn_fields[i] = field;
+	}
+
+	derived_refclk->hw.init = init;
+
+	clk = devm_clk_register(dev, &derived_refclk->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	cdns_phy->clks[CDNS_TORRENT_REFCLK_DRIVER] = clk;
+
+	return 0;
+}
+
 static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
@@ -2071,6 +2214,37 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
+static void cdns_torrent_clk_cleanup(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+
+	of_clk_del_provider(dev->of_node);
+}
+
+static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+	struct device_node *node = dev->of_node;
+	int ret;
+
+	ret = cdns_torrent_derived_refclk_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register derived refclk\n");
+		return ret;
+	}
+
+	cdns_phy->clk_data.clks = cdns_phy->clks;
+	cdns_phy->clk_data.clk_num = CDNS_TORRENT_REFCLK_DRIVER + 1;
+
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &cdns_phy->clk_data);
+	if (ret) {
+		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_torrent_phy *cdns_phy;
@@ -2134,17 +2308,21 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = cdns_torrent_clk_register(cdns_phy);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(cdns_phy->clk);
 	if (ret) {
 		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
-		return ret;
+		goto clk_cleanup;
 	}
 
 	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
 	if (!(cdns_phy->ref_clk_rate)) {
 		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto clk_disable;
 	}
 
 	/* Enable APB */
@@ -2323,7 +2501,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
+clk_disable:
 	clk_disable_unprepare(cdns_phy->clk);
+clk_cleanup:
+	cdns_torrent_clk_cleanup(cdns_phy);
 	return ret;
 }
 
@@ -2340,6 +2521,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(cdns_phy->clk);
+	cdns_torrent_clk_cleanup(cdns_phy);
 
 	return 0;
 }
-- 
2.17.1

