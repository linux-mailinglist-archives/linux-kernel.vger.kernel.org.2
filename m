Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7731E137
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhBQVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:20:09 -0500
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:10526
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233171AbhBQVTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVFX0bqHLeqXZ4VsrGnnlXR4Cz9Z2k0f1kI+Dj+4O/vEECv4sqdFN/xRE6U09wqCpXoNPrd4+X4mzDjjpiNHIWXZ3C4rUyd9rRhFLOfzNKQ8Qgg249bvMNV4lt+SORRqkmvwd+58iu+wZfF5NFR02IEZAxuveSlnpYhDvrDo67tYOsnBw2IAA13SGw9ugiNx4l5RLIZj1p+yPhZfXQ+O6xxYnHhKn9S2sbKwWYCSv9JgH/OJyzYdgLuqiavXExRfKqj0StIBeVd2XcaRY4FIns4gW8Q2Xsak3z54LRvwPk1Xb8C9z2ri8CbqqKAOah1LZZuMfLY+kmUC9Mzi7UcT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgsHrchjGVk7Ze3KVVMsru3Mt0s7xlwCJsTedi/ISMw=;
 b=RlEZSNeeXOKjx3vjd7bT4txGFBzDz/8JA/iNaiTfZU1g4Dx/PIb0XrDDnyB5YszLQzdMoM2yxhjFjxJogIcJ3fSW8uos/RHU1eV+uI+jtmfMUpZDE4VwVng+motnQkvFUAdKmz5NRAENw/EBm6jWMxL/pZbdlSO/b6gLdGyr4ZU/yIYrc3b8bUwhbXn396RBTXQOFGhPOLCpKfFzych4RV80UxwMZxosmYmScuJv4knfhjzHgps8sk2vFmGkFkkFZV1Az9r0MmBiOAX+I1IZSRb8LYGCApXEXhkc4SJVRk5+HkfujnJJP8UMkmLKoyB0G5V1Kmx6PnDV4owBLSiR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgsHrchjGVk7Ze3KVVMsru3Mt0s7xlwCJsTedi/ISMw=;
 b=ETywvuNL2grdwpgoUFsCM12P20gvdHqeqlOTlLDG+0R9tOEkDK7ntgmnLO3mKdJHfdNv1Izk6xjZGAwJq7PTrq3t9nuQ5gKga46U3ujzM+y6kjbD0sXmjUzD/hz3b+82h1x7DZyyFaxvcDjRPu4pmx6tFQhrJis5QJ8PSXkIQWw=
Received: from AM6P193CA0117.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::22)
 by AS8PR07MB7430.eurprd07.prod.outlook.com (2603:10a6:20b:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Wed, 17 Feb
 2021 21:18:53 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::10) by AM6P193CA0117.outlook.office365.com
 (2603:10a6:209:85::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 17 Feb 2021 21:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 21:18:53 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 11HLIoTc020561;
        Wed, 17 Feb 2021 21:18:51 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mtd@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: char: Get rid of Big MTD Lock
Date:   Wed, 17 Feb 2021 22:18:45 +0100
Message-Id: <20210217211845.43364-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210217211845.43364-1-alexander.sverdlin@nokia.com>
References: <20210217211845.43364-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e665b0a-8223-4e2d-1ad2-08d8d389a0b3
X-MS-TrafficTypeDiagnostic: AS8PR07MB7430:
X-Microsoft-Antispam-PRVS: <AS8PR07MB743063D0ECA4E29EBE150F8788869@AS8PR07MB7430.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qa6SS+BSeQborYbTxH+Q5VY1KX8p9n4LelfoQ5zGZdTtoKcn1BEVFLnWX/8QA/xH8VVHwM0VNSiNdOn3pEt5YJEqUFtPC6qac5AlgiI6D+p9N0sCOrM4L9Z9stlqO8Vy71TdKi5OACOQ2lLE3l2LfqQCsx3b7AXa1/pUDlbHq6K9C6sViShBJDnUp7vpfhw80lAIs67vAzMOVZMJ4mXCwRIu92IvUyyTj3QlwZ/Z0W0bSuGx0hPBXoXLLN0i6242/GWYD6RyqBMPKbOc3CAhuV6hcHEaEJeB50xff1rwrpw/kG2rU0zvUpFi6e1A6/2/9AxFlXrJ0nPTbR6vJ+U5TjOnCIikACom8s64NxscZ3d2yG+NUOUvSVOzjRiTuR9SOvF6HKBRnjNr/lLZ51YzFtCv/LaWHw5BIcNRH1r5s4/pnmj5IyXLNsPrXGyhYJTb9xsF9ZCfgbl9Viw/Zx6svFwIJTyutUNXG9pA8A0wYfcYUFipvqNdWqpDwEaptCtoHjDWfRlqbaL1oyjzGbw502/gtUlUq+SgBSxOPchPp5uvBYve1GC1/2sOAaVbRpT7TAmaG4BMfD0C5LW0B0tabQMbbMoKErRLE2hVG70BvXCpCN6vLUS8hlJCR4a5JOS5ysuNeleO3pp3xKdiiAXzECqQipKtzEdoMpJxHmTpiyEYFAviC4vH25OWV7BT70tbHH7+GRZCwMUjACVEF6UmDQ==
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(4326008)(83380400001)(1076003)(36860700001)(86362001)(2616005)(47076005)(54906003)(356005)(81166007)(82310400003)(82740400003)(186003)(70586007)(26005)(5660300002)(8676002)(316002)(70206006)(6666004)(478600001)(8936002)(336012)(6916009)(2906002)(36756003)(26583001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 21:18:53.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e665b0a-8223-4e2d-1ad2-08d8d389a0b3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7430
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Get rid of central chrdev MTD lock, which prevents simultaneous operations
on completely independent physical MTD chips. Replace it with newly
introduced per-master mutex.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/mtdchar.c   | 14 ++++++++------
 drivers/mtd/mtdcore.c   |  1 +
 include/linux/mtd/mtd.h |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index f31390d..57c4a2f 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -27,8 +27,6 @@
 
 #include "mtdcore.h"
 
-static DEFINE_MUTEX(mtd_mutex);
-
 /*
  * Data structure to hold the pointer to the mtd device as well
  * as mode information of various use cases.
@@ -1020,11 +1018,14 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 
 static long mtdchar_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
 {
+	struct mtd_file_info *mfi = file->private_data;
+	struct mtd_info *mtd = mfi->mtd;
+	struct mtd_info *master = mtd_get_master(mtd);
 	int ret;
 
-	mutex_lock(&mtd_mutex);
+	mutex_lock(&master->master.chrdev_lock);
 	ret = mtdchar_ioctl(file, cmd, arg);
-	mutex_unlock(&mtd_mutex);
+	mutex_unlock(&master->master.chrdev_lock);
 
 	return ret;
 }
@@ -1045,10 +1046,11 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
 {
 	struct mtd_file_info *mfi = file->private_data;
 	struct mtd_info *mtd = mfi->mtd;
+	struct mtd_info *master = mtd_get_master(mtd);
 	void __user *argp = compat_ptr(arg);
 	int ret = 0;
 
-	mutex_lock(&mtd_mutex);
+	mutex_lock(&master->master.chrdev_lock);
 
 	switch (cmd) {
 	case MEMWRITEOOB32:
@@ -1111,7 +1113,7 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
 		ret = mtdchar_ioctl(file, cmd, (unsigned long)argp);
 	}
 
-	mutex_unlock(&mtd_mutex);
+	mutex_unlock(&master->master.chrdev_lock);
 
 	return ret;
 }
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d..0b09597 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -773,6 +773,7 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
 
 	INIT_LIST_HEAD(&mtd->partitions);
 	mutex_init(&mtd->master.partitions_lock);
+	mutex_init(&mtd->master.chrdev_lock);
 }
 
 /**
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 157357e..ceabc2c 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -229,6 +229,7 @@ struct mtd_part {
  */
 struct mtd_master {
 	struct mutex partitions_lock;
+	struct mutex chrdev_lock;
 	unsigned int suspended : 1;
 };
 
-- 
2.10.2

