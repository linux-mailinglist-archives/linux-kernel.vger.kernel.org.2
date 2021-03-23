Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3634615F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhCWOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:20:38 -0400
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:29761
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232249AbhCWOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkf3eC9n7C1X8McJr9Pgp3nlHXd0H6HJ9MUGmlV4eYc3TnbLc6cMJmi3qRrasrESpqt9BIFl4rw4SW6XCfe9Aeb3v04Dv/VF56LG9PdmKk1YRu6Ydgz/UiiF9IOQIc9BJZWk1xkh4i6vegeVT9aEMQ7EzXpTxrs0dGiEKshIMOgVBvDLwEV999tAZMrppG84YYLq529yW0CjTh7E0BryLoXUZHbhyzyabUHjSAE9UbSsT3g22jE1lWq1uRiOc4q5YYhxyzNTM02PMXr7SvCbvZpR5CvaVBhC4ReOm8Ame2RnQtiqOomYrguW33KRD2tgXPweqV6yuUgERUtzaf3W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR0tdgchXI5fbtJWirwdNGY6P9bzz6yWAy7vfoC+HHA=;
 b=cgo92AvekcAxMsSftrpNjZhaYHcCvCW9h75j6aOHfj8lr3MTaFB6p6n1U3RmiD7FW2rLw/uw+lxOwBkz5OxEWP0aGkZ6KFbauRVb03tB67coAxP5NvM+zpN5ImgwY4y0CEej6apOVRRq62vVrfnh1Wba+V7/9mfllia/w4vMNrISQsmcQPFy0g+WlHsBcHI83HAoRK1+fQWwZRNM06yjiANVlCprExX513IX//gnq1G8DWWjjUE2K1kNDc4qLKpFU+T6sIY+QRVOZOY2LDvdWuWIn21ucXZOxaTmanwszpERcvfBzx6uLzmOL+KRgdCbQO5OMJFy00MJBaIfH5WdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR0tdgchXI5fbtJWirwdNGY6P9bzz6yWAy7vfoC+HHA=;
 b=A+gl7IDg8F+3CiE5IbhNUwW60jkP0dFOHLmpFD0z1qGbFTSAqd9Yl2+D8obZCX5MaVH7pLmdGgP494BG39/V3Gc99gagYaDKpkPCP5BB4vXN0xcB9tv0lEz9BwmslmEqz5FAsteNuG5S4JxKfK+nJwN6TQWDuG7nRE7rcwoIF2M=
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by DM6PR02MB4459.namprd02.prod.outlook.com (2603:10b6:5:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 14:20:00 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::a8) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 23 Mar 2021 14:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 14:19:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 07:19:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 07:19:57 -0700
Envelope-to: git@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 kishon@ti.com,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=47703 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lOhsx-0005mn-Sp; Tue, 23 Mar 2021 07:19:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1EC4A12123D; Tue, 23 Mar 2021 19:49:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3] phy: zynqmp: Handle the clock enable/disable properly
Date:   Tue, 23 Mar 2021 19:49:47 +0530
Message-ID: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de4eb5c9-476b-49f7-b32f-08d8ee06bdff
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Antispam-PRVS: <DM6PR02MB44591DDD5D9526CC63987B1AC1649@DM6PR02MB4459.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Phwd9xoIuh+1QwTuqyLwSh3QGwDWwOLVBjuGvLdCvvWqSvIRVlqI/5o6iOXNvO7GN/NfvJSH7b4rDG6SsZYSQHN+PAXuSX3Ao414+Xf3vzM3cEGEMeHQz05zbPeqNVe4mXA13Z8Fk8N/sJh4rqjF6gFPwYYljCEfC3NivObPP7jEeEaUCO9AbcgmbRYAgF0FnZ1nxCPogbplD/6PVChnp4AOrULnO++mJTe/6Vr2XhQikUwcHFYUBAx78YmdyqEnwB0Hr+aD2pIdSM610IHcZlIFfIStVQzXI2sXreqq/Pi+VzRA4DriazBC8O1+rQbAMyEMtP+4XkA3zKYJjX8QojqIMhr/AOijKojILvQIzo5CJ/KvgobkGjRmNvVoOLsib1owP6ytx4iPSTKwXyyX4RmDSLHQuH/u2fFPGo9h9o0KX94xk5gkmja3UMYpD2fq5tkdbhYJT7DP8v6MUk3Yde3YbmERtlygkRELorzHqQj87qQpgvP9+3MIdxNlQJEtLkkJ7/EQbRCTojfVCpjQ0rVRFAljWgxFqsGcw9A2KBLOfSat5GHWiHzQVQXQnGhnqTVXLqRRlSdKip8+CiCQN0oDDL6BZmCz7ykWvIb6IP+k0V3D/Hq3H7j+8XnLCsEGJnyZRD8H2cRRL3UYONukLQ/2l86ZD0qEWAja7KKvwC+JUhk7IST+lxO4mfPrM1C
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(44832011)(6666004)(36756003)(36860700001)(107886003)(83380400001)(6266002)(4326008)(70586007)(70206006)(82310400003)(5660300002)(6636002)(8676002)(54906003)(26005)(478600001)(8936002)(82740400003)(356005)(426003)(47076005)(2616005)(336012)(316002)(110136005)(7636003)(36906005)(42186006)(186003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:19:59.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4eb5c9-476b-49f7-b32f-08d8ee06bdff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
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
index 2b65f84..69492a5 100644
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
+	while (i--)
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
 
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto err_clk_put;
+
+		gtr_dev->clk[refclk] = clk;
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
+	while (refclk--)
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

