Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC93323CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCILSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:18:25 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:1947
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhCILR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:17:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwQOl4xt4Ybip65s4Mkbp2imVR8vcdt5b1ewStwWT6ZhMfw953Ye43o7OWuUkyIxuw+wBdSzWoS+FdXa0w2kXfbSknb9rOWC/NZvlwGf+VIaWAoVCaaPnNVmI6CutVLQODDmZxGP5ilYlkfzRod/bGySgKxyHXkSdJVvy7hRs52Zy0e6WbHBmCH/rv4QUaY02DqtxPTracKeVncktii8S2lSGmKd4UKYIAxlM5cIRfGuXe9klUCBZzR3umlbir38KTVEImieEeMR/NHLd5YIPPXF7x8ySVBewKZCEez9eDO/seWEoZpvh7BF0Xv3IRkvxSqP2O0N9UWI9lXRg3yQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PNGhMtAUalJLxybAODlEvFyHlK1/VrK0xGyrNmqgtU=;
 b=KWYMxd88hKrOzlAx+V7Sq379gPXWUcYo6QvmWV9jjztNFZfyYS9Y0WcPDgfd4+AjyX6fQ58bLPImu1nRMsLsDohY99FUpA9pS+Ngiqp3CZilBIwto/9RPryEFirVtjjxVgMIoCEeypUh8JoT1+tbuuTx9ERW02jjxSShzd4cJIrkc8Tn747F9icccmrdmtwk1ksU0WGbS2UmPjD2ANWsh6Vv+QKHnhYn3cTAd1c5YHjSRSYGGlLou4kWE+3mjBp3xTPLOuklLfhaOd8NkXoDkUztssHxmkAyIafnF3XiI7UwFM1X+ZRRh3Tfhqp11h2EG5ZZBezNNmKKWvlYq6K3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PNGhMtAUalJLxybAODlEvFyHlK1/VrK0xGyrNmqgtU=;
 b=Qd/yOMpzSyGraTWstxs2Bwak80RlGakAJk6UkghshgS/ZFmkww/n6oMAuSlx9H6O7Eicq2V1GxnwzmyR99zS4frR1klgOOKWGfPVrLK/UvbKztqzLP6UNl4QjheuP/yobrwJtEhwtCG8vQOD5Yi2F/2GTqDEIzENcO/JmffLrcg=
Received: from DM5PR07CA0160.namprd07.prod.outlook.com (2603:10b6:3:ee::26) by
 MW2PR02MB3881.namprd02.prod.outlook.com (2603:10b6:907:11::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 11:17:56 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::46) by DM5PR07CA0160.outlook.office365.com
 (2603:10b6:3:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 11:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Tue, 9 Mar 2021 11:17:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 03:17:53 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Mar 2021 03:17:53 -0800
Envelope-to: git@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 kishon@ti.com,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=43683 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lJaN5-0004f9-V3; Tue, 09 Mar 2021 03:17:52 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2DD991211EF; Tue,  9 Mar 2021 16:47:51 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2] phy: zynqmp: Handle the clock enable/disable properly
Date:   Tue, 9 Mar 2021 16:47:44 +0530
Message-ID: <1615288664-45034-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7155654d-79dd-48c7-8cac-08d8e2ecfc93
X-MS-TrafficTypeDiagnostic: MW2PR02MB3881:
X-Microsoft-Antispam-PRVS: <MW2PR02MB3881DA0FD3D43F8F3EBFAAFEC1929@MW2PR02MB3881.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0dbSmdIViXLuFACTdQYBQcJ/GIgwouEjVmSNT34rZhvqjBsHpMV7CZBwE+qC+55UQhhnhj4tvS4616M2bUXG9peVUqV5/3DsN75091D5T+3sMeaVPIFdy0S22itz+NE9hloKU5PwZ91IfRQHjsog+6MsJG3iPUdPxhvpekgxbWyCJA1AMCc/LGP1LIXHD9ZS2bwUOr57GAe9CqKQZGokYB2bM99SPrOVLYDR94zvWleMiYtsU/Z/nE2gewmO9uWXk34C2WMtnfrElKflBg/7Q/6iszMJ4CpW24QLnSucfQTkT2kr8KIaKpXS0tiaBz3I6sgqmJDRSFv2RibmGGogkFrJXwsyu2JAtXtZhJteDvJ7ux5mt1LapU1ltIPlbzH2eXYuZBYDrElnu4duwa8v02Lnbt1F0VfQ9NW7Zi7rBuvlKn2lg+/MZO5XdYKWfuBkrkVYOgPM6mHtx7f3v3h+iSXyOOO1K+JdmhLOx7b11lrcyeQJPPS9zelFC/1aGQzmgAEnC77GN3b3gFXcZFnA/agiiAvKisU1hpjHa94YE0ib9zNwn6oTRQeSBwyfh+25pFnUyX8Ge2FEOp8CS0poCR/tIRWqKZNKBlKuPJzaM26i10OHwxp87hgT5jBx4yuhyevQVkzs5vMKr7Ym9MnS3TpkjBBtvmxt6tnSvXSrgEA790PGPhhp2nyOiMptvPU
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(70586007)(107886003)(5660300002)(7636003)(2906002)(336012)(47076005)(36756003)(26005)(316002)(36906005)(110136005)(36860700001)(8936002)(6666004)(8676002)(54906003)(42186006)(186003)(82740400003)(83380400001)(44832011)(6266002)(4326008)(478600001)(82310400003)(2616005)(6636002)(70206006)(426003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 11:17:54.9988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7155654d-79dd-48c7-8cac-08d8e2ecfc93
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3881
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver is not handling the clock enable/disable operations
properly. The clocks need to be handled correctly by enabling or
disabling at appropriate places. This patch adds code to handle the
same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 57 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 2b65f84..37fcecf 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -219,6 +219,7 @@ struct xpsgtr_dev {
 	struct mutex gtr_mutex; /* mutex for locking */
 	struct xpsgtr_phy phys[NUM_LANES];
 	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
+	struct clk *clk[NUM_LANES];
 	bool tx_term_fix;
 	unsigned int saved_icm_cfg0;
 	unsigned int saved_icm_cfg1;
@@ -818,11 +819,15 @@ static struct phy *xpsgtr_xlate(struct device *dev,
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
 
@@ -832,6 +837,13 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
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
@@ -852,6 +864,12 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
 
 	return 0;
+
+err_clk_put:
+	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
+		clk_disable_unprepare(gtr_dev->clk[i]);
+
+	return err;
 }
 
 static const struct dev_pm_ops xpsgtr_pm_ops = {
@@ -865,6 +883,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
 static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 {
 	unsigned int refclk;
+	int ret;
 
 	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
 		unsigned long rate;
@@ -874,14 +893,22 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 
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
 
+		gtr_dev->clk[refclk] = clk;
+
+		ret = clk_prepare_enable(gtr_dev->clk[refclk]);
+		if (ret)
+			goto err_clk_put;
+
 		/*
 		 * Get the spread spectrum (SSC) settings for the reference
 		 * clock rate.
@@ -899,11 +926,18 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
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
+	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->clk); refclk++)
+		clk_disable_unprepare(gtr_dev->clk[refclk]);
+
+	return ret;
 }
 
 static int xpsgtr_probe(struct platform_device *pdev)
@@ -912,6 +946,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	struct xpsgtr_dev *gtr_dev;
 	struct phy_provider *provider;
 	unsigned int port;
+	unsigned int i;
 	int ret;
 
 	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
@@ -951,7 +986,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			return PTR_ERR(phy);
+			ret = PTR_ERR(phy);
+			goto err_clk_put;
 		}
 
 		gtr_phy->phy = phy;
@@ -962,9 +998,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
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

