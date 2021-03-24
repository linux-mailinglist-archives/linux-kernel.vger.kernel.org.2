Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FC347831
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhCXMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:19:25 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:35969
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhCXMTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnvDcDTUX8qfrd3HhUXHdz0FxpXka1XZsVPDUo9EFMG80zaKX+i9ByuaF9/vvXacZmdhSR+PwqXbs0971MThJM5tgCoPy5ESRy2yFssxQ4OAiwwZQ8nP3HRjWYW2hA0etuNkTjpP8AWpoitvhzI24ldumhey9JPrJ3LR4B9toULfW5qg1pekES7ngXUEaH9p+8j5N/xBLuH3IhfezEQdAOqTP4ol2Qj70gaqj69ht5tgnS2XT6cyQgB8jTR1tcKCDMTDQrkTjRatqYrPw8udWIUDvmtdklrzoVR4LM+5pmadeEOvPSM1S2bsuKtv9smUw7lju8cl1HC4OORn2GKclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zP2L2ZNbMGspSuO1GATowwp3EaElesJ/tTDwbliNZw=;
 b=HcDGBaugvQIeFQjpX6dm0riDvNe9xVqUhLTjeTuhUi37SwGL0+iuNJRcx/d5hOwnfdsQIDRH0yJhYOE51l+O33/y5xylUwJk1FBrer5qm0hc/YBqlAA48zHIHR/t/32imu7ENcojoxpkQw/Dc1OI0JgGUMCMG/so/v49mmr4mb5+RiKtIMuiXZIrhYbB5fJdDZCL/6BefAUSTK5UedFvWS8FKIw8L/MCapt/43ftWaNKAQLXcEQURdnQ34pYVvcTKmLBTBIqZg3IV0G/oe2yl6xIe1Mt2lp4lSvOc8AoX0HLDpHU/Ik3Ys9ZxXiROJyo5XAFnf74kUMg6PI+ZbTqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zP2L2ZNbMGspSuO1GATowwp3EaElesJ/tTDwbliNZw=;
 b=mehZTlBsty38D1N56KM7EP34tMlxXgsTY9ZRZcIlcojaespiM6NblSHBHAASBBpj75cO4Asosy6FKSoY3Gepwl3+ugT7f4q65MoIOtWg5CJbA9ZepYD9Aolgsvph7VlEGLs0a81G3/ang+9+P0vBu5FnZRA3mrTwWeECjSWllHs=
Received: from DM6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:5:bc::49) by
 BYAPR02MB5317.namprd02.prod.outlook.com (2603:10b6:a03:68::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 12:19:08 +0000
Received: from DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::6d) by DM6PR13CA0036.outlook.office365.com
 (2603:10b6:5:bc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend
 Transport; Wed, 24 Mar 2021 12:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT021.mail.protection.outlook.com (10.13.4.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 12:19:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 05:18:52 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 24 Mar 2021 05:18:52 -0700
Envelope-to: git@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 kishon@ti.com,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=39641 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lP2TL-0000M6-7l; Wed, 24 Mar 2021 05:18:51 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7314C121463; Wed, 24 Mar 2021 17:48:50 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4] phy: zynqmp: Handle the clock enable/disable properly
Date:   Wed, 24 Mar 2021 17:48:45 +0530
Message-ID: <1616588325-95602-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c59abc9-74d1-4f89-dccb-08d8eebf0642
X-MS-TrafficTypeDiagnostic: BYAPR02MB5317:
X-Microsoft-Antispam-PRVS: <BYAPR02MB531770F1350E02A439570820C1639@BYAPR02MB5317.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SHON6lVfFxzPBkmajaOmVyIrCjBWpwbvAf8GmYc+dWwKHkDQ1qtD3BKzWeMVsapEu94GVib+rU3BiawWgAfhfI/ntX0RykNlhWrG38prxmF0cfxlGq/6ETV6puE7FcmWU2CWYfhrcsenwDvhN7p9+5kVgClUUw1qvmZCfRRr/lWBOZH/WnMnbJfsk5vJR00k/5KQi0/T1nCwA0luLr/VZHphl9dcw280MQN33yBnxYpCVRWium6EG/2fwF2RstSPmrNx/DxkLoXtsqTtoZ6XmSdZX25WwniBf5F8z8oIzmgpj4+2HlmBCKx63iR5MWz1hSJxlGJenwmE/AGT0qIYnRIUppfmncE6LMYztDalOykW+4tL97I9DytCHB762O4uxXmiF111VKjbzTFmp3oR9OilIBZs7Whu9p+GE7Vehf1t3c0poMOuNiLjIO+GYwfsunoGHYRArkRAdvfGrts8q1WfyFTolkezwc7Ib9ZdrRNZClAYWjaGHGdTG8/ytk+8uGpWMM5tlCoIYz4CPVi3oo2vJB9G7ba2EoX/4brJmDPKFxYzoxm1i5YqRYQWnOtFd7NhvyupmN2S9V1+RX+5J5GSCBE1tlqmz4OMhqXCkA2ymODBl7jOm3eymwnf92dagRhzRu5fYxdYUw0fvE11ej5d5BYYMc5f2Wyd6iebcdIa7sUaRhXMclbckIT8n1a
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(36860700001)(6266002)(42186006)(478600001)(8936002)(6666004)(316002)(36906005)(2906002)(7636003)(26005)(186003)(82740400003)(356005)(47076005)(6636002)(70206006)(426003)(336012)(82310400003)(8676002)(70586007)(107886003)(36756003)(2616005)(4326008)(83380400001)(5660300002)(54906003)(44832011)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:19:08.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c59abc9-74d1-4f89-dccb-08d8eebf0642
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver is not handling the clock enable/disable operations
properly. The clocks need to be handled correctly by enabling or
disabling at appropriate places. This patch adds code to handle the
same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 58 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 2b65f84..3565215 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -208,6 +208,7 @@ struct xpsgtr_phy {
  * @gtr_mutex: mutex for locking
  * @phys: PHY lanes
  * @refclk_sscs: spread spectrum settings for the reference clocks
+ * @clk: reference clocks
  * @tx_term_fix: fix for GT issue
  * @saved_icm_cfg0: stored value of ICM CFG0 register
  * @saved_icm_cfg1: stored value of ICM CFG1 register
@@ -219,6 +220,7 @@ struct xpsgtr_dev {
 	struct mutex gtr_mutex; /* mutex for locking */
 	struct xpsgtr_phy phys[NUM_LANES];
 	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
+	struct clk *clk[NUM_LANES];
 	bool tx_term_fix;
 	unsigned int saved_icm_cfg0;
 	unsigned int saved_icm_cfg1;
@@ -818,11 +820,15 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 static int __maybe_unused xpsgtr_suspend(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
+	unsigned int i;
 
 	/* Save the snapshot ICM_CFG registers. */
 	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
+	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
+		clk_disable_unprepare(gtr_dev->clk[i]);
+
 	return 0;
 }
 
@@ -832,6 +838,13 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 	unsigned int icm_cfg0, icm_cfg1;
 	unsigned int i;
 	bool skip_phy_init;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
+		err = clk_prepare_enable(gtr_dev->clk[i]);
+		if (err)
+			goto err_clk_put;
+	}
 
 	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
@@ -852,6 +865,12 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
 
 	return 0;
+
+err_clk_put:
+	while (i--)
+		clk_disable_unprepare(gtr_dev->clk[i]);
+
+	return err;
 }
 
 static const struct dev_pm_ops xpsgtr_pm_ops = {
@@ -865,6 +884,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
 static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 {
 	unsigned int refclk;
+	int ret;
 
 	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
 		unsigned long rate;
@@ -874,14 +894,22 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 
 		snprintf(name, sizeof(name), "ref%u", refclk);
 		clk = devm_clk_get_optional(gtr_dev->dev, name);
-		if (IS_ERR(clk))
-			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
-					     "Failed to get reference clock %u\n",
-					     refclk);
+		if (IS_ERR(clk)) {
+			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
+					    "Failed to get reference clock %u\n",
+					    refclk);
+			goto err_clk_put;
+		}
 
 		if (!clk)
 			continue;
 
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto err_clk_put;
+
+		gtr_dev->clk[refclk] = clk;
+
 		/*
 		 * Get the spread spectrum (SSC) settings for the reference
 		 * clock rate.
@@ -899,11 +927,18 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 			dev_err(gtr_dev->dev,
 				"Invalid rate %lu for reference clock %u\n",
 				rate, refclk);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_clk_put;
 		}
 	}
 
 	return 0;
+
+err_clk_put:
+	while (refclk--)
+		clk_disable_unprepare(gtr_dev->clk[refclk]);
+
+	return ret;
 }
 
 static int xpsgtr_probe(struct platform_device *pdev)
@@ -912,6 +947,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	struct xpsgtr_dev *gtr_dev;
 	struct phy_provider *provider;
 	unsigned int port;
+	unsigned int i;
 	int ret;
 
 	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
@@ -951,7 +987,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			return PTR_ERR(phy);
+			ret = PTR_ERR(phy);
+			goto err_clk_put;
 		}
 
 		gtr_phy->phy = phy;
@@ -962,9 +999,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
 	if (IS_ERR(provider)) {
 		dev_err(&pdev->dev, "registering provider failed\n");
-		return PTR_ERR(provider);
+		ret = PTR_ERR(provider);
+		goto err_clk_put;
 	}
 	return 0;
+
+err_clk_put:
+	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
+		clk_disable_unprepare(gtr_dev->clk[i]);
+
+	return ret;
 }
 
 static const struct of_device_id xpsgtr_of_match[] = {
-- 
2.1.1

