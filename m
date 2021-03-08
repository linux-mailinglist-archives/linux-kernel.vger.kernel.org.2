Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494A1331696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCHSty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:49:54 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:40370
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhCHStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:49:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9hWxUar68/qZt8s5oaTC1Ax9jdV4HLzaLumv1FdaYYog0NxkpwwLrcneIaQ9H2dRgoh14byfs36E80DWLx1sKePgwJJ0fQ+tJ7rr09gZzE8iVmUkum+M7X0aOGSME1EjoFqnrTf9FjC4gDIqXRfbnp1eO5HCaBAPcbSSLB2z11U/DMCVVGYQGGyLZaQ+Urh5QWfk5escn4hCe7UFtEj2uszNN9nqef9C5MFlhkrPs3/ZIhyC6XFl4IsTAPGbtg5TbdX3Sq2lFv/BLkHbEj1a2efFf54WOuC5gNJ2ZHxtdf8EAe9Ime8ndSsCjSVUMYaY679oZxikXpcLCHzKUgqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCDe61bF2ecApvXPrh/CKj2Xmjj4phZWX3h1qbTRxRo=;
 b=jQ92d3ft+BlHfXrpdROIoGcnCg9TvCpNINw/TsVci0vJhvLCjh0z0hyR4zUTc5cEtZ7HA3BOY+RI+Qqjo1I5d/KitF3V4QsjVSAEXz8tuHMNI+cJ39w8UjtxwOpIRkMe/Q/8s+v1qGOQrSAvkSaL8tpVB5aTZzuDfZrL0zeVi74yt4gdRhJ2Px48DFCO7m2arvd46R4F0OYZjXszj/e1Mm5PyvcRDJjqKcDt6Y88IOk0ArOIFDUEYBo1gJLI2zsqnr4bEQJgsfK0NKTAvy1KLGMici6P8H2rW61RZJDRNfYS/49Dh+ZKOjSPwPROn+OjAbBEsGWPg3XQUCqCf9G7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCDe61bF2ecApvXPrh/CKj2Xmjj4phZWX3h1qbTRxRo=;
 b=B8cF9UHT8T6SI79m49Zz1mIGwW79QHF+CtJBk5eas2bFE0UvdknJqD1i60wDbGXJV/EHWQAShhln/fTlaNGjdZZon4Oa1WRupzq8GB8xZt1Jjxk9YJuqTvH7hb29MJjcT1VC/mM6owc4Oz9zwPK3UxcShf0a4oAd0qt2cyboC00=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by MN2PR02MB6237.namprd02.prod.outlook.com (2603:10b6:208:181::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 8 Mar
 2021 18:49:21 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::9c) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 18:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Mon, 8 Mar 2021 18:49:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 10:49:20 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 8 Mar 2021 10:49:20 -0800
Envelope-to: laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 kishon@ti.com,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=56591 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lJKwR-000121-I6; Mon, 08 Mar 2021 10:49:19 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C40C7121261; Tue,  9 Mar 2021 00:19:18 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <anurag.kumar.vulisha@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] phy: zynqmp: Handle the clock enable/disable properly
Date:   Tue, 9 Mar 2021 00:19:16 +0530
Message-ID: <1615229356-26237-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c49713-55ff-4684-44d9-08d8e262e2bd
X-MS-TrafficTypeDiagnostic: MN2PR02MB6237:
X-Microsoft-Antispam-PRVS: <MN2PR02MB62377C2B294621B0D4BD8A81C1939@MN2PR02MB6237.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bnbnzvd+T30oc65BQWR8b2oggatqUCBfHZP3w+0VuuN+nj98SUN0fFkwIQfWBikqBYrwBZJQJVWO+6Qd4GlvnOXYvwv3zY896FVVYKyamQclgPv1JJUE4sskj3pi2HMyvNTuWAvyokRRk8erHxv3bInCemRRUWpHXKPkPUIuw9FPES6EVrft4YN67M+/WIrWsj4nh1l9M67oc6/ErtiSidC1BYkdvzvw3fpDLIwJIBRXESnkq7V0Us0MepIhjBl845NVrrxKxzz5GmVAkHpDfXU0QuMfE8J6ocMofYboop8XA2v1sTvKBOXMzF9bykLmkVnqPf1kr5Scyh0s4b9uha4W3W0vqjuU/TCXF836TvbTncK3cE6jcUJQo2Nx2EMZNgkP3I8tUB9X+/8FrPg7wEHy9NeXdCYclaF0SjKLVuA61AgPd/T66/U1P7ShvhxW/kBr+4xGiVKn5Y7PX34t/lNHdKZmCk1+iKP4bXuQwWxUIsOdHFcK7EI74HZwoDvZ7cldhAgXqfwhnom51AzsBWs2QyZkvG/UIUqKAa/p3Z6QiTm+fchCqANUaZFcCtni8pJgXWrCHauDaf7OR/oePPCKw+0ameY/0U9cJWRG8COOdFzUf1dNrmmGKYteN1Hj34D17j8ECtk7wEz6RuwydrNmAYPbuMdZDfAR09ShtCEaBbdc8P1/mMkBMwZfUuRV
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(82310400003)(2616005)(82740400003)(336012)(478600001)(426003)(8936002)(44832011)(7636003)(8676002)(110136005)(356005)(4326008)(42186006)(36906005)(186003)(316002)(70586007)(70206006)(54906003)(47076005)(26005)(36756003)(107886003)(5660300002)(6266002)(2906002)(6636002)(36860700001)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 18:49:21.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c49713-55ff-4684-44d9-08d8e262e2bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6237
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver is not handling the clock enable/disable operations
properly. The clocks need to be handled correctly by enabling or
disabling at appropriate places. This patch adds code to handle the
same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 2b65f84..0ec534e 100644
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
+	int i;
 
 	/* Save the snapshot ICM_CFG registers. */
 	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
+	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
+		clk_disable(gtr_dev->clk[i]);
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
+		err = clk_enable(gtr_dev->clk[i]);
+		if (err)
+			return err;
+	}
 
 	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
@@ -865,6 +877,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
 static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 {
 	unsigned int refclk;
+	int ret;
 
 	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
 		unsigned long rate;
@@ -882,6 +895,12 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 		if (!clk)
 			continue;
 
+		gtr_dev->clk[refclk] = clk;
+
+		ret = clk_prepare_enable(gtr_dev->clk[refclk]);
+		if (ret)
+			return ret;
+
 		/*
 		 * Get the spread spectrum (SSC) settings for the reference
 		 * clock rate.
@@ -899,11 +918,17 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 			dev_err(gtr_dev->dev,
 				"Invalid rate %lu for reference clock %u\n",
 				rate, refclk);
-			return -EINVAL;
+			goto err_clk_put;
 		}
 	}
 
 	return 0;
+
+err_clk_put:
+	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->clk); refclk++)
+		clk_disable_unprepare(gtr_dev->clk[refclk]);
+
+	return -EINVAL;
 }
 
 static int xpsgtr_probe(struct platform_device *pdev)
@@ -913,6 +938,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	unsigned int port;
 	int ret;
+	int i;
 
 	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
 	if (!gtr_dev)
@@ -951,7 +977,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			return PTR_ERR(phy);
+			ret = PTR_ERR(phy);
+			goto err_clk_put;
 		}
 
 		gtr_phy->phy = phy;
@@ -962,9 +989,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
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

