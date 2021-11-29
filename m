Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5E460F29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhK2HHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:07:52 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:61792
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232058AbhK2HFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:05:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of2qFWhKyund7F0NGa7p0tWApZ7xSgvpR5pDLd/3UngDayvYdkUNcykst+FL1psDBfNhnYGT/UDT9ywfjOvDLSr4EQn1WLW+mPA+NWOjmJb4p0++7CNzp6MbRygc7F9rhGm9ZiGP3/RfY2tLkkYnV8BnnNf/jWuxky4galKVWPIRtSEi/p+1pIItv7yBP5CsCQqdIQdOT+cCTmA5IB45jCoaI2Vs5cQ73smwqTQf/Imx+83xvnlBbcFaZ1FKzpfqqAiwAT/EUhEO5w3DA4ahGB9w6X7UQ5RzNvr4xzYL0f6GH/5RqdkCFwUOoyQ2Oh8hz/D8WC9qqCi3Wj/d4HlJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkBBYXPRWAXjsmLmkUzLcvBP5Ki+6B6WGv4yY51kodE=;
 b=mzV03+1qg1etn5G6QCr+iz1jJZZGezkcIITIFi3aMiruLCSIIMSCzgqEGju0s3X35nEuRsQCgVealIq+YMSEUnkw2e+RJQSkTmDoWx+X4RjlyJD0T9kvscDdbUZm3dKFVv3LzJQzLpyCav6YYKS8ChYABIapf2PEWEtJWKVxjvo+kdm5SJaiU6d4jl8l5kUBgK8J8Kyi4CRLLmlKVCgXL1lfSaKKvKNNPUCKYEkE1ZOMADAY6gAe6UXAnvf1SUYnAWPAaRUcDr//qnB2MbjSgiOnu3T+zJdZeUQmpIesaujHc7wT5sCwp3bFs//K2+S7ddEVIYM7MW0UdmiQVqI0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkBBYXPRWAXjsmLmkUzLcvBP5Ki+6B6WGv4yY51kodE=;
 b=bjLXeu1YsA6Tz2yBHXpJE2TsDKwJ8UdV/YYRcEG4epnN4RNus/VBV2udmJFOAQV/P1y2k//7bHUC/ADd9MHOu/6AYtKreJKm47JTmgnQIAiG4soY3P01Tbq5ovv/SrJNyH4sgT0M2GcWEVaTZNaiRcyopMXGy0soPDe9gGgqdqY=
Received: from BN9PR03CA0616.namprd03.prod.outlook.com (2603:10b6:408:106::21)
 by CY4PR02MB2453.namprd02.prod.outlook.com (2603:10b6:903:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 07:02:30 +0000
Received: from BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::24) by BN9PR03CA0616.outlook.office365.com
 (2603:10b6:408:106::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Mon, 29 Nov 2021 07:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT003.mail.protection.outlook.com (10.13.2.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 07:02:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 28 Nov 2021 23:02:29 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 28 Nov 2021 23:02:29 -0800
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=33638 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mragH-000GZ4-S2; Sun, 28 Nov 2021 23:02:29 -0800
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <jliang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 2/3] firmware: xilinx: instantiate xilinx event manager driver
Date:   Sun, 28 Nov 2021 23:02:15 -0800
Message-ID: <20211129070216.30253-3-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <YZUcAch7lVZ32/+t@kroah.com>
References: <YZUcAch7lVZ32/+t@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81824ced-f8fe-4279-0f81-08d9b30635ca
X-MS-TrafficTypeDiagnostic: CY4PR02MB2453:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2453470FD8E6B765F7866758A1669@CY4PR02MB2453.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twwd6kdaJtY9UvD7RlmaB2e/4FJmfpptlxC8r4cYnqyRqdj8+12CGP1VCKiFczyPtbUSY0uAK0zjTDNbnW8h+rxtEoIl+rJDtdM5lFD+eAz/pog4oR9TjxdtKj3KUBsCw9r4H63I/gLOZiyayj9ISTt63nDzbGzh0xUXzE4XcNVk3WHoErWfhshEPEAgANYXAgJZqMt68SM5oRS9g53EPXgeUSA7dmfE1KBpmUgXOPNhCIyGcLo5/JvwQT6kDXDjAwlQE6gqstIZ4UqAgOBJ9i0qAFYHCcedy3hBavBfHBV4HG34q3jRbnBPRI9lifLQ5h7VIefIZ0DKzNzq/XijDfkO7pZG+BirPke4Igf0e4rr7+O589MUgmcgi/0wvsUH0aIpm73+xXsbxgSn3trROYOYmS77wluOHZvtb3zXDx5UiBtHkpxBEz4R/fbYhorne8+e2a+ZPYSDD/rxbM5uHnZwUCQr0fCH/xMtfdmO/B4V+IWdIaXdXI9NvPC8iHnotMAGUoL8YDiKTEIP4HOOE3WuZCzgPMZ5+D+f1QU24dTFtUFt4ob1ogfyRokzlkP+UKZlaItUeNo8MhMxNix8lRQZVtKbCkZ+NEnzQNvHa5VdO05H2JRw7IQ32m87v3ZXLV6xgNNI0IcokwdTqYdsFSrNi1TaG0Vfmy/8f+GzHPL84XTn5+kbnKDW0kRQV9qC3LKxTStaK+4E4u8/xfB7A94J4MZLoWVkmaMLo6d4UFU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(83380400001)(36860700001)(44832011)(70586007)(186003)(82310400004)(9786002)(6916009)(4326008)(2616005)(1076003)(7636003)(2906002)(356005)(47076005)(426003)(8936002)(316002)(54906003)(8676002)(336012)(26005)(5660300002)(70206006)(508600001)(6666004)(7696005)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 07:02:30.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81824ced-f8fe-4279-0f81-08d9b30635ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2453
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register simple platform device to instantiate Xilinx event
manager driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- None

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
index c2828ee6d4cf..bfa5ec7a808c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -23,6 +23,7 @@
 #include <linux/hashtable.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/xlnx-event-manager.h>
 #include "zynqmp-debug.h"
 
 /* Max HashMap Order for PM API feature check (1<<7 = 128) */
@@ -38,6 +39,8 @@
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 
+static struct platform_device *em_dev;
+
 /**
  * struct pm_api_feature_data - PM API Feature data
  * @pm_api_id:		PM API Id, used as key to index into hashmap
@@ -1492,6 +1495,15 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
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
 
@@ -1509,6 +1521,8 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
 		kfree(feature_data);
 	}
 
+	platform_device_unregister(em_dev);
+
 	return 0;
 }
 
-- 
2.32.0.93.g670b81a

