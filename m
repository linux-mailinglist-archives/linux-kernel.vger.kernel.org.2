Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E29341D24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCSMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:42:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCSMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:42:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCgPhb108096;
        Fri, 19 Mar 2021 07:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157745;
        bh=ZlSYtd0nqPwe7TNyJ6IcMcUJFPtyk5lb4lEvWwGfaXs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ED3HQLZEXJRIr79yepKasmnbWZLAfgtvXALUVymeiCW95TAuIu7zv0e6AGcGqTkvG
         iUbpY5Q6P9/WsL4NXo626ZmB3yDamSfB8CDLXEbtA/bjj4k4LG1U61XGilceE6gqqE
         xGpWJA6JFUyHYeoHFms7nLC5UeK6HCBS8TBjQsfA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCgOMS048864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:42:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:42:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:42:24 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTfE011913;
        Fri, 19 Mar 2021 07:42:21 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 13/13] phy: cadence: Sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
Date:   Fri, 19 Mar 2021 18:11:28 +0530
Message-ID: <20210319124128.13308-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
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
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 40 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 039ca10db59d..5c68e31c5939 100644
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
+err_pll_cmnlc1:
+	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
+
+err_pll_cmnlc:
+	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
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

