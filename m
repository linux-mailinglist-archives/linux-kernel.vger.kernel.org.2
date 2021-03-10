Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287F9333C40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhCJMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:09:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48282 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhCJMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:09:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8xgP112668;
        Wed, 10 Mar 2021 06:08:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615378139;
        bh=OJlIz+AWFMmzXGgsTjG9uyhtO88Ig4YJBS7ThBMgmDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CRMmhubzWGxWA08hXB7+ezPfX2erP0KenIjNHqv6nsYitPmW3IyLd7MTOe80YLJfm
         Y4aLxTb18rDcCAnMOCH/Q7nPV9M7UzCNqZD3K0XpPtYwySBssQrfVxjtBVbUzYkSJj
         B2ycTsC4nJnYHNcJ3st0+68vQJoA3OLungNa6XQA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AC8xno072328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 06:08:59 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 06:08:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 06:08:58 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8ghf017368;
        Wed, 10 Mar 2021 06:08:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 4/6] phy: ti: j721e-wiz: Model the internal clocks without device tree input
Date:   Wed, 10 Mar 2021 17:38:38 +0530
Message-ID: <20210310120840.16447-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310120840.16447-1-kishon@ti.com>
References: <20210310120840.16447-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module
present in TI J721E SoC") modeled the internal clocks depending on the
subnodes that are populated in device tree. However recent discussions
in the mailing list [1] suggested to just add #clock cells in the parent
DT node and model the clocks within the driver.

Model the mux clocks without device tree input for AM64x SoC. Don't
remove the earlier design since DT nodes for J7200 and J721e are already
upstreamed.

[1] -> http://lore.kernel.org/r/20210108025943.GA1790601@robh.at.kernel.org

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 144 +++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 2706e7be0c28..f9299dcdbdb7 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/gpio.h>
@@ -27,6 +28,10 @@
 #define WIZ_SERDES_TYPEC	0x410
 #define WIZ_LANECTL(n)		(0x480 + (0x40 * (n)))
 
+#define WIZ_MAX_INPUT_CLOCKS	4
+/* To include mux clocks, divider clocks and gate clocks */
+#define WIZ_MAX_OUTPUT_CLOCKS	32
+
 #define WIZ_MAX_LANES		4
 #define WIZ_MUX_NUM_CLOCKS	3
 #define WIZ_DIV_NUM_CLOCKS_16G	2
@@ -52,6 +57,13 @@ enum wiz_refclk_div_sel {
 	CMN_REFCLK1_DIG_DIV,
 };
 
+enum wiz_clock_input {
+	WIZ_CORE_REFCLK,
+	WIZ_EXT_REFCLK,
+	WIZ_CORE_REFCLK1,
+	WIZ_EXT_REFCLK1,
+};
+
 static const struct reg_field por_en = REG_FIELD(WIZ_SERDES_CTRL, 31, 31);
 static const struct reg_field phy_reset_n = REG_FIELD(WIZ_SERDES_RST, 31, 31);
 static const struct reg_field pll1_refclk_mux_sel =
@@ -70,6 +82,11 @@ static const struct reg_field pma_cmn_refclk_dig_div =
 					REG_FIELD(WIZ_SERDES_TOP_CTRL, 26, 27);
 static const struct reg_field pma_cmn_refclk1_dig_div =
 					REG_FIELD(WIZ_SERDES_TOP_CTRL, 24, 25);
+static const char * const output_clk_names[] = {
+	[TI_WIZ_PLL0_REFCLK] = "pll0-refclk",
+	[TI_WIZ_PLL1_REFCLK] = "pll1-refclk",
+	[TI_WIZ_REFCLK_DIG] = "refclk-dig",
+};
 
 static const struct reg_field p_enable[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(0), 30, 31),
@@ -130,8 +147,10 @@ struct wiz_clk_divider {
 #define to_wiz_clk_div(_hw) container_of(_hw, struct wiz_clk_divider, hw)
 
 struct wiz_clk_mux_sel {
-	u32			table[4];
+	u32			table[WIZ_MAX_INPUT_CLOCKS];
 	const char		*node_name;
+	u32			num_parents;
+	u32			parents[WIZ_MAX_INPUT_CLOCKS];
 };
 
 struct wiz_clk_div_sel {
@@ -164,14 +183,20 @@ static const struct wiz_clk_mux_sel clk_mux_sel_10g[] = {
 		 * Mux value to be configured for each of the input clocks
 		 * in the order populated in device tree
 		 */
+		.num_parents = 2,
+		.parents = { WIZ_CORE_REFCLK, WIZ_EXT_REFCLK },
 		.table = { 1, 0 },
 		.node_name = "pll0-refclk",
 	},
 	{
+		.num_parents = 2,
+		.parents = { WIZ_CORE_REFCLK, WIZ_EXT_REFCLK },
 		.table = { 1, 0 },
 		.node_name = "pll1-refclk",
 	},
 	{
+		.num_parents = 2,
+		.parents = { WIZ_CORE_REFCLK, WIZ_EXT_REFCLK },
 		.table = { 1, 0 },
 		.node_name = "refclk-dig",
 	},
@@ -232,6 +257,9 @@ struct wiz {
 	struct gpio_desc	*gpio_typec_dir;
 	int			typec_dir_delay;
 	u32 lane_phy_type[WIZ_MAX_LANES];
+	struct clk		*input_clks[WIZ_MAX_INPUT_CLOCKS];
+	struct clk		*output_clks[WIZ_MAX_OUTPUT_CLOCKS];
+	struct clk_onecell_data	clk_data;
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -469,8 +497,69 @@ static const struct clk_ops wiz_clk_mux_ops = {
 	.get_parent = wiz_clk_mux_get_parent,
 };
 
-static int wiz_mux_clk_register(struct wiz *wiz, struct device_node *node,
-				struct regmap_field *field, const u32 *table)
+static int wiz_mux_clk_register(struct wiz *wiz, struct regmap_field *field,
+				const struct wiz_clk_mux_sel *mux_sel, int clk_index)
+{
+	struct device *dev = wiz->dev;
+	struct clk_init_data *init;
+	const char **parent_names;
+	unsigned int num_parents;
+	struct wiz_clk_mux *mux;
+	char clk_name[100];
+	struct clk *clk;
+	int ret = 0, i;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	num_parents = mux_sel->num_parents;
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	for (i = 0; i < num_parents; i++) {
+		clk = wiz->input_clks[mux_sel->parents[i]];
+		if (IS_ERR_OR_NULL(clk)) {
+			dev_err(dev, "Failed to get parent clk for %s\n",
+				output_clk_names[clk_index]);
+			ret = -EINVAL;
+			goto err;
+		}
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev), output_clk_names[clk_index]);
+
+	init = &mux->clk_data;
+
+	init->ops = &wiz_clk_mux_ops;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+	init->name = clk_name;
+
+	mux->field = field;
+	mux->table = mux_sel->table;
+	mux->hw.init = init;
+
+	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err;
+	}
+
+	wiz->output_clks[clk_index] = clk;
+
+err:
+	kfree(parent_names);
+
+	return ret;
+}
+
+static int wiz_mux_of_clk_register(struct wiz *wiz, struct device_node *node,
+				   struct regmap_field *field, const u32 *table)
 {
 	struct device *dev = wiz->dev;
 	struct clk_init_data *init;
@@ -615,9 +704,15 @@ static int wiz_div_clk_register(struct wiz *wiz, struct device_node *node,
 static void wiz_clock_cleanup(struct wiz *wiz, struct device_node *node)
 {
 	const struct wiz_clk_mux_sel *clk_mux_sel = wiz->clk_mux_sel;
+	struct device *dev = wiz->dev;
 	struct device_node *clk_node;
 	int i;
 
+	if (wiz->type == AM64_WIZ_10G) {
+		of_clk_del_provider(dev->of_node);
+		return;
+	}
+
 	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++) {
 		clk_node = of_get_child_by_name(node, clk_mux_sel[i].node_name);
 		of_clk_del_provider(clk_node);
@@ -631,6 +726,36 @@ static void wiz_clock_cleanup(struct wiz *wiz, struct device_node *node)
 	}
 }
 
+static int wiz_clock_register(struct wiz *wiz)
+{
+	const struct wiz_clk_mux_sel *clk_mux_sel = wiz->clk_mux_sel;
+	struct device *dev = wiz->dev;
+	struct device_node *node = dev->of_node;
+	int clk_index;
+	int ret;
+	int i;
+
+	if (wiz->type != AM64_WIZ_10G)
+		return 0;
+
+	clk_index = TI_WIZ_PLL0_REFCLK;
+	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++, clk_index++) {
+		ret = wiz_mux_clk_register(wiz, wiz->mux_sel_field[i], &clk_mux_sel[i], clk_index);
+		if (ret) {
+			dev_err(dev, "Failed to register clk: %s\n", output_clk_names[clk_index]);
+			return ret;
+		}
+	}
+
+	wiz->clk_data.clks = wiz->output_clks;
+	wiz->clk_data.clk_num = WIZ_MAX_OUTPUT_CLOCKS;
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &wiz->clk_data);
+	if (ret)
+		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
+
+	return ret;
+}
+
 static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 {
 	const struct wiz_clk_mux_sel *clk_mux_sel = wiz->clk_mux_sel;
@@ -648,6 +773,7 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 		ret = PTR_ERR(clk);
 		return ret;
 	}
+	wiz->input_clks[WIZ_CORE_REFCLK] = clk;
 
 	rate = clk_get_rate(clk);
 	if (rate >= 100000000)
@@ -661,6 +787,7 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 		ret = PTR_ERR(clk);
 		return ret;
 	}
+	wiz->input_clks[WIZ_EXT_REFCLK] = clk;
 
 	rate = clk_get_rate(clk);
 	if (rate >= 100000000)
@@ -668,6 +795,13 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 	else
 		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x2);
 
+	if (wiz->type == AM64_WIZ_10G) {
+		ret = wiz_clock_register(wiz);
+		if (ret)
+			dev_err(dev, "Failed to register wiz clocks\n");
+		return ret;
+	}
+
 	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++) {
 		node_name = clk_mux_sel[i].node_name;
 		clk_node = of_get_child_by_name(node, node_name);
@@ -677,8 +811,8 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 			goto err;
 		}
 
-		ret = wiz_mux_clk_register(wiz, clk_node, wiz->mux_sel_field[i],
-					   clk_mux_sel[i].table);
+		ret = wiz_mux_of_clk_register(wiz, clk_node, wiz->mux_sel_field[i],
+					      clk_mux_sel[i].table);
 		if (ret) {
 			dev_err(dev, "Failed to register %s clock\n",
 				node_name);
-- 
2.17.1

