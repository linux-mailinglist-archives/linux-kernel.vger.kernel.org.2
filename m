Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D3330721
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhCHFIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36296 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhCHFIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128580qb077226;
        Sun, 7 Mar 2021 23:08:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180080;
        bh=1m1jaw1QKhWt1my5TiZgSyHmcvod41lJIai7xVZR3M8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wDAlGoIYg3vBTytrL7JEhHSMGMnNntta11ENmdsXjwVubCZBuOH485rSYMA/+naKw
         upGoOUu0F0EzlMGuIIGMST8aV9gKcqez9jFBUm2XZyyl2Y7vgOEv19PLqzzmd0kp8i
         +VmhudGV737w2NDaiE7JoxW3nPkA0ivD8Mw9BVJ8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128580XA116621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:00 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL3086547;
        Sun, 7 Mar 2021 23:07:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 05/13] phy: cadence: cadence-sierra: Move all clk_get_*() to a separate function
Date:   Mon, 8 Mar 2021 10:37:24 +0530
Message-ID: <20210308050732.7140-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Group all devm_clk_get_optional() to a
separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 57 +++++++++++++++---------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index f7ba0ed416bc..7bf1b4c7774a 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -477,6 +477,38 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
+				      struct device *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get_optional(dev, "phy_clk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(clk);
+	}
+	sp->clk = clk;
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk_dig_div = clk;
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk1_dig_div = clk;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -487,7 +519,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	unsigned int id_value;
 	int i, ret, node = 0;
 	void __iomem *base;
-	struct clk *clk;
 	struct device_node *dn = dev->of_node, *child;
 
 	if (of_get_child_count(dn) == 0)
@@ -524,11 +555,9 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sp);
 
-	sp->clk = devm_clk_get_optional(dev, "phy_clk");
-	if (IS_ERR(sp->clk)) {
-		dev_err(dev, "failed to get clock phy_clk\n");
-		return PTR_ERR(sp->clk);
-	}
+	ret = cdns_sierra_phy_get_clocks(sp, dev);
+	if (ret)
+		return ret;
 
 	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
 	if (IS_ERR(sp->phy_rst)) {
@@ -542,22 +571,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(sp->apb_rst);
 	}
 
-	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
-		ret = PTR_ERR(clk);
-		return ret;
-	}
-	sp->cmn_refclk_dig_div = clk;
-
-	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
-		ret = PTR_ERR(clk);
-		return ret;
-	}
-	sp->cmn_refclk1_dig_div = clk;
-
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		return ret;
-- 
2.17.1

