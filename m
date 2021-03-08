Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95E33072D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhCHFIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhCHFIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12858E4F023642;
        Sun, 7 Mar 2021 23:08:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180094;
        bh=fTTzBtUNI6wOHn23Acadhw+lAANu22wL/U385vCODoY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eDF4bfxUnaPVKwi+WWebmePqPsUnO7rjsYK9JZNWmP/3qqYkryA6VL/8pEd/BOrtw
         Hy2/A/ZziCDnVY6E/Ci0USNuV3PjSRHR9b2jefGFWxOEURlnorI8Dbxf08ivb2ZeCw
         M8NKCu6lxl0BVJEfJen8acNGKyWtH+ox9+0KCLss=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12858E0Y040369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:14 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:13 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL7086547;
        Sun, 7 Mar 2021 23:08:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 09/13] phy: cadence: cadence-sierra: Add array of input clocks in "struct cdns_sierra_phy"
Date:   Mon, 8 Mar 2021 10:37:28 +0530
Message-ID: <20210308050732.7140-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having separate structure members for each input clock, add
an array for the input clocks within "struct cdns_sierra_phy". This is
in preparation for adding more input clocks required for supporting
additional clock combination.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 44c52a0842dc..a45278c30948 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -144,6 +144,13 @@
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
+#define CDNS_SIERRA_INPUT_CLOCKS			3
+enum cdns_sierra_clock_input {
+	PHY_CLK,
+	CMN_REFCLK_DIG_DIV,
+	CMN_REFCLK1_DIG_DIV,
+};
+
 static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
@@ -197,9 +204,7 @@ struct cdns_sierra_phy {
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
-	struct clk *clk;
-	struct clk *cmn_refclk_dig_div;
-	struct clk *cmn_refclk1_dig_div;
+	struct clk *input_clks[CDNS_SIERRA_INPUT_CLOCKS];
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
@@ -281,8 +286,8 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	if (phy->autoconf)
 		return 0;
 
-	clk_set_rate(phy->cmn_refclk_dig_div, 25000000);
-	clk_set_rate(phy->cmn_refclk1_dig_div, 25000000);
+	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
+	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
 	if (ins->phy_type == PHY_TYPE_PCIE) {
 		num_cmn_regs = phy->init_data->pcie_cmn_regs;
 		num_ln_regs = phy->init_data->pcie_ln_regs;
@@ -488,7 +493,7 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 		dev_err(dev, "failed to get clock phy_clk\n");
 		return PTR_ERR(clk);
 	}
-	sp->clk = clk;
+	sp->input_clks[PHY_CLK] = clk;
 
 	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
 	if (IS_ERR(clk)) {
@@ -496,7 +501,7 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 		ret = PTR_ERR(clk);
 		return ret;
 	}
-	sp->cmn_refclk_dig_div = clk;
+	sp->input_clks[CMN_REFCLK_DIG_DIV] = clk;
 
 	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
 	if (IS_ERR(clk)) {
@@ -504,7 +509,7 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 		ret = PTR_ERR(clk);
 		return ret;
 	}
-	sp->cmn_refclk1_dig_div = clk;
+	sp->input_clks[CMN_REFCLK1_DIG_DIV] = clk;
 
 	return 0;
 }
@@ -585,7 +590,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(sp->clk);
+	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
 	if (ret)
 		return ret;
 
@@ -662,7 +667,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		reset_control_put(sp->phys[i].lnk_rst);
 	of_node_put(child);
 clk_disable:
-	clk_disable_unprepare(sp->clk);
+	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
 	reset_control_assert(sp->apb_rst);
 	return ret;
 }
-- 
2.17.1

