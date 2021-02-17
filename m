Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC35D31E138
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhBQVU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:20:26 -0500
Received: from mail-eopbgr120112.outbound.protection.outlook.com ([40.107.12.112]:11072
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233092AbhBQVTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRbkLkW/KkIRYYqmFCyLfUCTc+dSmnC0D0ImZNqR5DfE3zkwtmJPA5vSKlIzV55tjmC5oz0sp8I+pclBbhsNAptRWYj0sEnUnp2AkfdygZzRZPGKm34XN1H06dvpLCnSo4M2sW9xpZW26hgMVcBM5638qLk21HsZ7uzFX+vNXrZJZCc4Vahy+2M54b2hQROFDyGtJ8siz4VKMJmg2s/jwip9xusDedforwP71m+v1Ux/P0YT82S5pZxrDieswU6CqDoS/31OT6rm/5hbRDNmuYsQA4U+QzjqtJy7eeZd7nI82g/JrEAeMAg6qAShvFTSRjems5Zu4GtOBqotOHDjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxAfcAgnk1bqo3Q4wvBZu/rd0JUSYgolyLn5d182qIY=;
 b=LQ9tZFzzjxjrssVESsigo10gXf3uaSZES7eZE92KI6AnbeeVirZ9p7wH7cuL74yo73e417rzvuocoh9lynERdpos9s0QSBDueKNZNVfn1XHLf2QSyU4lgloPtkMEyFd6TMhXuUB9dPdSRS1TFtxUeOyUgZQvEl0/HxhuYPni80ZAKvI2O9OBk5rg7fDFXc4QCK5PvtrXWAzxt1ZhRxtG474ycJ79L7DpMySUwuel45F6yPizrJxuIrzevtZMUdZDgiCYS+PECEifj2YN0WhYt8mTAdKr+Vb7DkDyqmcQ5t+Fc+6CRCf/dH2/G0r5AFQUiARjdoDkhL/LNbx43fNAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxAfcAgnk1bqo3Q4wvBZu/rd0JUSYgolyLn5d182qIY=;
 b=bK/RO8f2/SihWkn37jlTImoshM9t8v96TcJruDQ8z8GAwrpUyokmmKVysGjAVgHE2O7JXsPm4o1uqDnSvUKfAQ7yyPrlIGlDHqdW/QZ3aQmt2fAKk7jVQVI4J5QYXuEd4hXc5n+1RGjJg25f35gpUchbnYmxE1X6HPVs1CphyM8=
Received: from MR2P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::28)
 by PR1PR07MB4858.eurprd07.prod.outlook.com (2603:10a6:102:a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Wed, 17 Feb
 2021 21:18:53 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:33:cafe::6d) by MR2P264CA0112.outlook.office365.com
 (2603:10a6:500:33::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend
 Transport; Wed, 17 Feb 2021 21:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 21:18:53 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 11HLIoTb020561;
        Wed, 17 Feb 2021 21:18:50 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mtd@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: char: Drop mtd_mutex usage from mtdchar_open()
Date:   Wed, 17 Feb 2021 22:18:44 +0100
Message-Id: <20210217211845.43364-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ce135b1-b4a7-458a-fcb9-08d8d389a097
X-MS-TrafficTypeDiagnostic: PR1PR07MB4858:
X-Microsoft-Antispam-PRVS: <PR1PR07MB4858E0FBC85C437BFACB10CF88869@PR1PR07MB4858.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8lakeWOsAB8tUADgvIquPKUrg3eBXQHnEV6t3yNDJtI+q0KUnEGPjuM8kzn+Z4zplKAkDFEOadteyB0jzYX/mCqqQ1zztQnHdLJ7v4M86rMHIPgTc+6QMSylcrAXUeW1V/so+8vmmYTgAWbxSRsExjswpWBnpks3Db5iqEWA5IjxkTLRQDEHF9ETdDrCdOTrhaJ5mDnT9UZOyDRWxFk8WulkmHYy8B5c1triGQJ4MCUxOOJdAF2cRTtI4b/be0HxWGWAshhmdPqG2Uz4T3EYZCSJmquN2uUk6jxVtWVPY/Dh1Aj3wGDcOQ7UolNP/wpyFkN8BLn/cnP0A4KbivgI2moS8gK2duDQrg/hVj0BxSpQExh8bj0V27EG7XsqNlhhWdhr5hISXrYYxKE5mJt0bc3T295Lu3S0hjuEcVvL5vWZ38ZurLBGXrw2P7x5+V+Jf68cwxU0KZ3ebvq7s9QcsklnqLJ+GFFBQovlFPB+kkJURVHhNMJGAm+v+iUzErh/1KaswovHPCx5OLTK48VGgPJSX8eDWnqG9itF3BDiLBEuX8w+eGxJIek37T2ljBRoUiDjIs2oKJeSl/jmwSRFMHUv1C7eQKVUw7mMRQPcQeSyQbQ7BQSuwNFeV5ySumfftNyEETysNwfOuc8fV53x3kjxeeH0NV5V1p2VLvSc7b+T3CQKuuk8N4qCR5KoUs9
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(82310400003)(6916009)(8936002)(8676002)(26005)(2616005)(36860700001)(86362001)(336012)(70586007)(81166007)(478600001)(36756003)(54906003)(82740400003)(186003)(1076003)(83380400001)(2906002)(47076005)(4326008)(70206006)(356005)(6666004)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 21:18:53.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce135b1-b4a7-458a-fcb9-08d8d389a097
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR07MB4858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

It looks unnecessary in the function, remove it from the function
having in mind to remove it completely.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/mtdchar.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 323035d..f31390d 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -58,13 +58,10 @@ static int mtdchar_open(struct inode *inode, struct file *file)
 	if ((file->f_mode & FMODE_WRITE) && (minor & 1))
 		return -EACCES;
 
-	mutex_lock(&mtd_mutex);
 	mtd = get_mtd_device(NULL, devnum);
 
-	if (IS_ERR(mtd)) {
-		ret = PTR_ERR(mtd);
-		goto out;
-	}
+	if (IS_ERR(mtd))
+		return PTR_ERR(mtd);
 
 	if (mtd->type == MTD_ABSENT) {
 		ret = -ENODEV;
@@ -84,13 +81,10 @@ static int mtdchar_open(struct inode *inode, struct file *file)
 	}
 	mfi->mtd = mtd;
 	file->private_data = mfi;
-	mutex_unlock(&mtd_mutex);
 	return 0;
 
 out1:
 	put_mtd_device(mtd);
-out:
-	mutex_unlock(&mtd_mutex);
 	return ret;
 } /* mtdchar_open */
 
-- 
2.10.2

