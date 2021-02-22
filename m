Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21992321517
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBVL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:27:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57336 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBVLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:25:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNrQu007159;
        Mon, 22 Feb 2021 05:23:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613993033;
        bh=yl5c3BCTyT37yEjGx+zc4U9i0HfK311WmYFX/4ra4Kc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KWKYz8IuJJDDEdIla8jdwsK0znnxkrMAWweY1pr/AsMrlLDMhxKD3nHV9lvCJJm4t
         qce++HrQaOElsFI0V84MsB5E5wCDd6L0HIijcu2Wwz93imBWVQwHTrFX/z+hYwW+Y4
         b349ScwFM2ZSXsGhVyrqQwY1F/pNwDjJantepD7w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBNqfR050378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:23:53 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:23:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:23:52 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNFDf088010;
        Mon, 22 Feb 2021 05:23:50 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v2 6/9] phy: ti: j721e-wiz: Configure full rate divider for AM64
Date:   Mon, 22 Feb 2021 16:53:11 +0530
Message-ID: <20210222112314.10772-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222112314.10772-1-kishon@ti.com>
References: <20210222112314.10772-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency of the txmclk between PCIe and SERDES has
changed to 250MHz from 500MHz. Configure full rate divider
for AM64 accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 39 +++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 1a4e09a394a8..2706e7be0c28 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -101,6 +101,13 @@ static const struct reg_field p_standard_mode[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 24, 25),
 };
 
+static const struct reg_field p0_fullrt_div[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANECTL(0), 22, 23),
+	REG_FIELD(WIZ_LANECTL(1), 22, 23),
+	REG_FIELD(WIZ_LANECTL(2), 22, 23),
+	REG_FIELD(WIZ_LANECTL(3), 22, 23),
+};
+
 static const struct reg_field typec_ln10_swap =
 					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
 
@@ -191,6 +198,7 @@ static const struct wiz_clk_div_sel clk_div_sel[] = {
 enum wiz_type {
 	J721E_WIZ_16G,
 	J721E_WIZ_10G,
+	AM64_WIZ_10G,
 };
 
 #define WIZ_TYPEC_DIR_DEBOUNCE_MIN	100	/* ms */
@@ -208,6 +216,7 @@ struct wiz {
 	struct regmap_field	*p_align[WIZ_MAX_LANES];
 	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
 	struct regmap_field	*p_standard_mode[WIZ_MAX_LANES];
+	struct regmap_field	*p0_fullrt_div[WIZ_MAX_LANES];
 	struct regmap_field	*pma_cmn_refclk_int_mode;
 	struct regmap_field	*pma_cmn_refclk_mode;
 	struct regmap_field	*pma_cmn_refclk_dig_div;
@@ -373,7 +382,7 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->mux_sel_field[PLL1_REFCLK]);
 	}
 
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		wiz->mux_sel_field[REFCLK_DIG] =
 			devm_regmap_field_alloc(dev, regmap,
 						refclk_dig_sel_10g);
@@ -417,6 +426,12 @@ static int wiz_regfield_init(struct wiz *wiz)
 				i);
 			return PTR_ERR(wiz->p_standard_mode[i]);
 		}
+
+		wiz->p0_fullrt_div[i] = devm_regmap_field_alloc(dev, regmap, p0_fullrt_div[i]);
+		if (IS_ERR(wiz->p0_fullrt_div[i])) {
+			dev_err(dev, "P%d_FULLRT_DIV reg field init failed\n", i);
+			return PTR_ERR(wiz->p0_fullrt_div[i]);
+		}
 	}
 
 	wiz->typec_ln10_swap = devm_regmap_field_alloc(dev, regmap,
@@ -718,6 +733,17 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
+static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
+{
+	if (wiz->type != AM64_WIZ_10G)
+		return 0;
+
+	if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
+		return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
+
+	return 0;
+}
+
 static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 				  unsigned long id)
 {
@@ -741,6 +767,10 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
+	ret = wiz_phy_fullrt_div(wiz, id - 1);
+	if (ret)
+		return ret;
+
 	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
 		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
 	else
@@ -768,6 +798,9 @@ static const struct of_device_id wiz_id_table[] = {
 	{
 		.compatible = "ti,j721e-wiz-10g", .data = (void *)J721E_WIZ_10G
 	},
+	{
+		.compatible = "ti,am64-wiz-10g", .data = (void *)AM64_WIZ_10G
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, wiz_id_table);
@@ -899,14 +932,14 @@ static int wiz_probe(struct platform_device *pdev)
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		wiz->clk_mux_sel = clk_mux_sel_10g;
 	else
 		wiz->clk_mux_sel = clk_mux_sel_16g;
 
 	wiz->clk_div_sel = clk_div_sel;
 
-	if (wiz->type == J721E_WIZ_10G)
+	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
 		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G;
 	else
 		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_16G;
-- 
2.17.1

