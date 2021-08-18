Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7043EFF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhHRIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:44:19 -0400
Received: from mail-dm6nam08on2075.outbound.protection.outlook.com ([40.107.102.75]:10908
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239745AbhHRIoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDuJ1m4RSIV1EdfRPJYTFCM7dtsdSkDooGPzRaFTxrfUCq0E+exOVZHVPwCgdeug+Hizuri12e0fAMfhCux51424DLQKAyXsDplFgJE1bdDAS10a7bfCLJ2Z63m9RauQ7P6IDm+cg3/ZAZueAwYhtlYWc/OKQHbaosYOV7KZ5htfwODwn2a0xbJTLcn5s1DP1Vasp7MfKvD9Ds2HXTJukmWJqHn0HFQ+xS2SQPuK10E+aJL0Fx+Do8qkBxHWOTCZHlBpu21qRc9R9OZCSjoVVOJBnwGUae16mEB6tpctQoqFqKrGXWVeX3OZ5jUGmfuWEsGCP4V6NG/kb6PbEC1akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rqpoCVu7vTEVVyKTmDOXpEkAhsZHB96jwiimFKe/Ns=;
 b=LpX7RR7cawADWVpMZX/SbLk8dZNVgQAAjknueokIjR189MOkbfLcQaGGAN2ZUTsSYTqYYG20N1Ru4BU+WGRWTk1j6Y208UUzAtq3mqh5/AhJueEnUmEk2H44OsqtpHbtqjVro9q5pTFXkNL3PXeYWgedS18V2RHuwrJQ3ZSKHRQRfCxB7bxICLWvXh2bklPkqSTLgFT2J153gFlXspMeVs7HWaM9VRQQcNSIHQHj9NTG8VuKSdeNu5mykhnPgBc6esYoYTH6IRFKZ5GPzscjstaD4fWwffQi3yOWeDwzbZu92seeQBu5tO3XvbSa81pb+7qgimTeI0mHAYc59Ex6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rqpoCVu7vTEVVyKTmDOXpEkAhsZHB96jwiimFKe/Ns=;
 b=rGB5R379nnk7m42EuH9jWCByWpc2MzfvVfvV/JT/CnsUgc5eVxzEbS3NBCRiqNaLhK2Yc3bi+nr0ga/5fTZgNdQQRKmN+nFO7auB7r1qOUcbvEE6/ZFfdopO/t9fkQugFlZbTbd7YTGMKioDmCHmXI5TgcHMD6gawNZgb3IbAXk=
Received: from SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::31)
 by DM6PR02MB4873.namprd02.prod.outlook.com (2603:10b6:5:fb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 08:43:35 +0000
Received: from SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::55) by SA9P221CA0026.outlook.office365.com
 (2603:10b6:806:25::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 08:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0035.mail.protection.outlook.com (10.97.4.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 08:43:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 Aug 2021 01:43:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 Aug 2021 01:43:31 -0700
Envelope-to: git@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 kishon@ti.com,
 vkoul@kernel.org,
 linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.35] (port=57526 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mGHAX-0006Sn-Cs; Wed, 18 Aug 2021 01:43:29 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>,
        <linux-phy@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] phy: xilinx: zynqmp: skip PHY initialization and PLL lock for USB
Date:   Wed, 18 Aug 2021 14:13:11 +0530
Message-ID: <20210818084311.2643986-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73be2b6f-6071-424d-8313-08d9622442f2
X-MS-TrafficTypeDiagnostic: DM6PR02MB4873:
X-Microsoft-Antispam-PRVS: <DM6PR02MB48733FB998CE18F18097F634D4FF9@DM6PR02MB4873.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/gof0wvTC67L4wcYliyh1j4LwlfhnEJtt0PZlU7OS8vwQLCzwke/WZyy1CvNhnQvY+mBnme9BiAMllvf/iX1gNxmS+MR/Ba1fRh/AAgeU8VWAlmr168un8NNqTIJM2I3PBzdTsr16F012z2iblnainh6fSCx3HhU7O1x2msiaCSkvk9wOsfBSkcIWKYS+7RQX9OdS6EzYM/AK/fYuiyxekv5ya72VsqqGsfMp9XREtDuXYR/WuWJ6mghk4xl41+oXR3eBVs5WKocSdgiL1rU0oXeKgTDAcNeNzf6f1sRL2qVMK47SK2ThUyYIpfwgxOpeZXu3iuN7edpG28OqtnCwkq6iaxeZA2Ey6/F7D2B80oFUCnM4bEPukabf2ubaaUrSHA7udwEVkmJIP2zoriwn+EGhBg8qlp8gJm0fM1863JknvYU9o1/264SmsYpD+m4FycS/bijlufZpqaZ1dSkh2ztz433P0FJDMPxJtVTbRb6sr+fbEiEMhi6TbhmZf0CxMB7Se6XaPyIayJxaze1MMT9RTRGqsFOsT0mJsh2XQKVrJW8SzRkot7hv+GsJQdlNz/rY99q3rq4upjfUrEcCbWwOPQ3PKPYiS7aAXccjUEu+QhkhVUkqIw22+kiLzUcy1Q01YengcA6qnaXsJqZ+5wDDZufzuSCLrm9vrnY4fEoBb5SLf/Cj3ACg4LkJAfsy4MdKCko9J84JX980wgOgO4XKaUMxQR8iMAvHC7Glw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(82310400003)(44832011)(83380400001)(82740400003)(110136005)(356005)(9786002)(2616005)(70206006)(1076003)(2906002)(6666004)(8936002)(4744005)(5660300002)(7636003)(70586007)(8676002)(478600001)(426003)(107886003)(4326008)(336012)(316002)(26005)(36756003)(36906005)(186003)(54906003)(7696005)(47076005)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 08:43:33.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73be2b6f-6071-424d-8313-08d9622442f2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY initialization for USB is required on linux boot or when
gt lane is changed from the current one and it is applicable
on PLL lock too.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 35652152ce5d..f478d8a17115 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -626,6 +626,9 @@ static int xpsgtr_phy_power_on(struct phy *phy)
 	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
 	int ret = 0;
 
+	/* Skip initialization if not required. */
+	if (!xpsgtr_phy_init_required(gtr_phy))
+		return ret;
 	/*
 	 * Wait for the PLL to lock. For DP, only wait on DP0 to avoid
 	 * cumulating waits for both lanes. The user is expected to initialize
-- 
2.25.1

