Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686A432CB88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhCDEnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:43:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36742 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhCDEnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:43:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244gFEZ101969;
        Wed, 3 Mar 2021 22:42:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614832935;
        bh=87e0WVkV56dpTXvqg1zPNJEnEHXGvFYDyxgC5z4r/uQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bi6UkkIYux8SYYf9jyHoOxjLkC2zYgdxiR5fat7Prm/KFC6mMGOOLn0WdlVvj0+wU
         otwDIVBUUy1N14OLk7ZME6DgnHOyslvOtUThPRMkMUoK2y7qknAv0iRcX1GhIxEz6O
         zak5/wRymiPmsJcT3MvTwak/0B7wWayTQrSfBTDk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244gFsU056749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:42:15 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:42:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:42:15 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244fQfu042911;
        Wed, 3 Mar 2021 22:42:12 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 13/13] phy: cadence: phy-cadence-sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Thu, 4 Mar 2021 10:11:22 +0530
Message-ID: <20210304044122.15166-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304044122.15166-1-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
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
index be2c91be4205..68d81f953f4f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -768,6 +768,40 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sp->input_clks[PLL0_REFCLK]);
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
+	return 0;
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
 	cdns_sierra_clk_register(sp);
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

