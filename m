Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7DF436356
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhJUNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:47 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:24608
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231643AbhJUNtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOYnrkBCiQ4vm92AJ4DKXZwJLMSC4Dit3tl7W+y8k4xQFcKltWIJ71EAaQqq00nZnwq1SIkCkbM2TrO45K1FGjk5+kK92XdufGwyMdIs7XsdPHHHXMocGOE8l7DGS8uONKNb2wyQwxqN0+Rv306D76KnkOQyiJl3+6iYnhVHzsaATMbaJy+roMUbW94QekKK4+lcVAiFIZ1DWBQ0cq+fejBgPWPaL2qvwB1DEkDFiDpvfr2WtrFg3pSX9Nj+96LVHUMdwg3aJxkIFJbXpxD6V9dRXpI8W79XbCfBvT7RzaRzkmB33/x0DvmoPEvSQTIIjEYhSYdCapQtYQ+F9GyWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gExJ/OdNCFORBJjdX4ppP+9kBna8rHw3/CafI3X/waA=;
 b=giZx6HbDZYh3SkpGX8NcRr+Q+eLJ5F1Ob3UuG3UYs4l6IO4GCdbBnoXtf/ng0yhnhthAmrolnQK9nquZC+zUnzrguUr1jx3xVwVOE8/oj75MPav8pIFCTqClvRDfyuAwQZl12nVLTJUhqXas+MYuPXG8MHriDxx7j9PPMHxYusHho2ImiTPtJU57f0G/cvba6Pm0n9bT7keeVCIYG1TQrnoE7IzBE+p4ncu16d+NSkF/qq6cPeog3uzvV7dTqn3+3qYnH5y30IWuWd8/ZdwQ248zQOLdr25RXMru3I3TOW6PxGzHyhnco9c+Cgc7xQ/kS+sLV/pSL8SG+JUeN15ZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gExJ/OdNCFORBJjdX4ppP+9kBna8rHw3/CafI3X/waA=;
 b=ivowt1IdgZvarjP8izhtr/fVmveF6bRwr+v2rj+44mKqDju/9g68RhLcJ+YyLyfbYbS0boOMMYcEd/CZ93tXuaWZrwLzECguWAFZmZb78YcGnYpPL48zbUsZdbcz3ni3G/7PkELUfBWLl4y4TPSn5iFEpmD0uqv4gfGqh84T6hA=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by DM8PR02MB8213.namprd02.prod.outlook.com (2603:10b6:8:3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Thu, 21 Oct 2021 13:47:19 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::88) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 13:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:47:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Oct 2021 06:46:54 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 21 Oct 2021 06:46:54 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=56784 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mdYPG-0006R3-2A; Thu, 21 Oct 2021 06:46:54 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 5/6] firmware: xilinx: instantiate xilinx event manager driver
Date:   Thu, 21 Oct 2021 06:46:43 -0700
Message-ID: <20211021134644.14407-6-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ccfdff9-bd6a-47cc-ed37-08d994994d57
X-MS-TrafficTypeDiagnostic: DM8PR02MB8213:
X-Microsoft-Antispam-PRVS: <DM8PR02MB8213828DDAF38116AFD2C1DBA1BF9@DM8PR02MB8213.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORmVVWG1UO+CIpDiFmk61Pq9MpRuh/XyDP0v72vRLghDKSqLXtdpSWWYu1SLln0ouhUjiOwTeGk5Kxo7Xzk4aKxUu1oGwEP8Fo9WKMS7AlDqP0V/+Lrsw+/nLavN/iD5THq6NGzmtr3vijSrkyTuiogqx4/matkyHgrD8L9hBalVZLZcI2gBOsk5lb9utIgzLgcwNsQWJ5AIJ8V2vfNypx1V3X6LC9phhvchNgl1JfbHF9EFFnDK0/+v1tQwjPKcUnj+GWvBn+7u5DPHKRhsLLbAo6ZJ+TaE5OnU6bKJj+Ke3afOyg5KLfqt8heSoGh/k1lKtFADwesGtKtDshGk3jd1gtONwPIa0AAo6dT5fdtXMFWkfjVKn2ZzNaiHQos9t3J3/MV5Z5YfuPiX6sxSv4nzqcaJuUO8D2SJ3UlTo8p2KfhX3tJBrB4C6KLLbBoUVgL+D+h4KBnWj30+Mygh50/tRuYw7KCp2M/dDQCazocjrXZ6YpCNClciIbcZ59ZoZXa7TccdJ5HGPJo/Fgf9BHWlDIH2NQgcfjJTvXrdZyr9v00Gi/3JV+CZms3eVWTv/+HBlyVp9XYOtmszV9HkUb1rx7hLpJWld0b/DckYOKMusN09oCCTDNtav0aVqfY99kijwzNtd2FTq+tt27PYpGgA1Hlf1gn1TvfznJGrwGrxY6rqBZ3JwnYlZzSflJVVsk0TtMjbNEfl3heicY80jrkaTyrU7t17XirVnqc0slo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(26005)(7636003)(36756003)(186003)(8676002)(508600001)(426003)(2906002)(336012)(82310400003)(316002)(36860700001)(83380400001)(36906005)(47076005)(2616005)(1076003)(44832011)(70586007)(70206006)(7696005)(356005)(9786002)(6666004)(6916009)(8936002)(5660300002)(54906003)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:47:19.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccfdff9-bd6a-47cc-ed37-08d994994d57
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8213
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register simple platform device to instantiate Xilinx event
manager driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v5:
- None

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- Use em_dev instead of pdev in PTR_ERR.
---
 drivers/firmware/xilinx/zynqmp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index e2c55f48b93d..f3cf4535463b 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -23,6 +23,7 @@
 #include <linux/hashtable.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/xlnx-event-manager.h>
 #include "zynqmp-debug.h"
 
 /* Max HashMap Order for PM API feature check (1<<7 = 128) */
@@ -31,6 +32,8 @@
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 
+static struct platform_device *em_dev;
+
 /**
  * struct pm_api_feature_data - PM API Feature data
  * @pm_api_id:		PM API Id, used as key to index into hashmap
@@ -1429,6 +1432,15 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
+	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
+	if (np) {
+		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
+						       -1, NULL, 0);
+		if (IS_ERR(em_dev))
+			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
+	}
+	of_node_put(np);
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
@@ -1446,6 +1458,8 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
 		kfree(feature_data);
 	}
 
+	platform_device_unregister(em_dev);
+
 	return 0;
 }
 
-- 
2.32.0.93.g670b81a

