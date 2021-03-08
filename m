Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA61330731
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhCHFI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36338 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhCHFIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12858Rar077337;
        Sun, 7 Mar 2021 23:08:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180107;
        bh=+Y00hdZP+qH3GUjqo1BgTa5yanHKcZM8l+fdCNkwrBk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gA3eY+1+ymr21oGfHhAxPHO806Ci6caZG8eWEsHwXX2WusNGv0fVh5YbUhPqNtLJC
         RiJd2UYUcCD5/9umsRCObXPQHc/xPVHZxux3KCp+ix497pTWdg7B5i7FBDCTU5HbSB
         mT3JkH7W64HaSTGrHzfyx/w7INIrzkQ9krba7Ozg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12858RL2068871
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:27 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:27 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aLB086547;
        Sun, 7 Mar 2021 23:08:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 13/13] phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Mon, 8 Mar 2021 10:37:32 +0530
Message-ID: <20210308050732.7140-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get pll_cmnlc and pll_cmnlc1 optional clocks and enable them.
This will enable REFRCV/1 in case the pll_cmnlc/1 takes input
from REFRCV/1 respectively.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 40 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index b80afc11dd5c..16adc6dff04e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -768,6 +768,40 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
+	if (ret)
+		goto err_pll_cmnlc;
+
+	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
+	if (ret)
+		goto err_pll_cmnlc1;
+
+	return 0;
+
+err_pll_cmnlc:
+	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
+
+err_pll_cmnlc1:
+	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
+
+	return ret;
+}
+
+static void cdns_sierra_phy_disable_clocks(struct cdns_sierra_phy *sp)
+{
+	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
+	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
+	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
+}
+
 static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 				      struct device *dev)
 {
@@ -848,7 +882,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_clk;
 
-	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
+	ret = cdns_sierra_phy_enable_clocks(sp);
 	if (ret)
 		goto unregister_clk;
 
@@ -925,7 +959,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		reset_control_put(sp->phys[i].lnk_rst);
 	of_node_put(child);
 clk_disable:
-	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
+	cdns_sierra_phy_disable_clocks(sp);
 	reset_control_assert(sp->apb_rst);
 unregister_clk:
 	cdns_sierra_clk_unregister(sp);
@@ -941,6 +975,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	reset_control_assert(phy->apb_rst);
 	pm_runtime_disable(&pdev->dev);
 
+	cdns_sierra_phy_disable_clocks(phy);
 	/*
 	 * The device level resets will be put automatically.
 	 * Need to put the subnode resets here though.
@@ -950,7 +985,6 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 		reset_control_put(phy->phys[i].lnk_rst);
 	}
 
-	clk_disable_unprepare(phy->input_clks[PHY_CLK]);
 	cdns_sierra_clk_unregister(phy);
 
 	return 0;
-- 
2.17.1

