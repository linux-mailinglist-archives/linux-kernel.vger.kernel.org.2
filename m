Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2C43AB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhJZE2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:28:09 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:37737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232598AbhJZE2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCPALe2lbZyiCdEXwelEiFAYxh8Fp+AyGmacZggppqYU1OyXYLRVheTcod0SmtOG5+8JFUAs/h1PhZk0xndqvjhTUrqN0vAEgRBZ2O1aQ86+w+G7pRfNs5wWrHYu+pqM0zBB872YU4SsQEKGEdHqC5w7FjMIG+25DY/yKIpGQ/HCKmyiU5ACfqLgvqhkZWefQGsal0e6lWEsxUWwKlZ+mTJZ16DJUXFPYkO2oDhZx0lNR3OO7zlcZQtK1SbBWi8EaCPC/9C2pkrncHb+/7r+CLdn+MwS6B2Xytemezluc8JMUebpYYekmfugVd2UBn260mbptpZI7j4+mnt4pTCDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znZLtFbqHQm9uSOM0Af0jwbOH+AGMKs5t6/VKZOUM7o=;
 b=PXZ9un1/8xVSzXGASMq2IVyCKHl7fC89xy3Dw6tR9/sTbWGedZhtSJ9eLOVtASokobg/bxHFkafz3iA0gKFcqjrbbfiHTnyASZ72VqYRnnuZ3XUj8xkw4VQZFZLIUrOJ9ZTADM+JE6nmD12Gf5f76UKc+xmvOmRKd050AT1fSqAf32Bs9AUFFAGfuWwMSsxW6wqW8GjygdwB+Fxe8+Bg2dDB4V8oFe4jCvlrpRTuMvg/VH3k/J9/jTuwcAsk2RXKQLpfhabeQScSFUfsrvY3wJzUJTS/LeexelE3AXvVqm34x7+M2zBNCDoiYPOAAzL4suCph5ykn6zx7w2hSLsDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znZLtFbqHQm9uSOM0Af0jwbOH+AGMKs5t6/VKZOUM7o=;
 b=MjTmd2uXrBUt6E4aMFe9M8d43pes85sPdp3BOKpnN8ZzOGiWwDJ9J+RsMm6mcCh2HEs65lIm8wn7hD4ca8Z8lb2ECclBf65sjSuvbB2G8v73AfdR3q20Yz7YWZM4CKB8beV8zitcvG8naGQ9RnrxBCqDzH5pNzKyCfrYYVe3mh0=
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:25:34 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::11) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 21:25:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 21:25:31 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37440 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mfE1i-0006GH-VX; Mon, 25 Oct 2021 21:25:30 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 5/6] firmware: xilinx: instantiate xilinx event manager driver
Date:   Mon, 25 Oct 2021 21:25:24 -0700
Message-ID: <20211026042525.26612-6-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4b2cac-f96b-4861-2063-08d99838a761
X-MS-TrafficTypeDiagnostic: MN2PR02MB5904:
X-Microsoft-Antispam-PRVS: <MN2PR02MB5904E570944DA2D365450B32A1849@MN2PR02MB5904.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZb6DrkKB8SlmBlzb4KNBbNoVR7ju8RsaBf1dnE+nsCzpXMYNVSJF1EX7jIAW8YQ/ULfILVPzGMr1G4Sfp2Hwu7Yrpv/j7dPI8GG1XFlpvAo5hoZnf87YJmD1Tk6OT8cMSA5tCcsJN0lqUWX+ncKJN6mBYiD6hlflIJbMsnz9cyP+Ww9nlvSXr9uOClcyW1dbFZeNtwmKY7V7ODcsWPtPgNtmgPiywfaf1PRaVOOBAn2I5/AguXOelcSQaI3iiTMeB2LKXmd49nFVt1NUoQCUjlZXq5k6GhlSRgR3olkC3VW1VcX13d0ARbjt8QdE0I724c+38jZOVpVOfdOHIXQj0F24evNAsZSJQVVmgWuMkTYXYFxl3XPM/VCjeDioKg1RHLv4SDu64nXdCv6atWkVVlKDhbw7vVK93epC9fbeHfVdfRzSBjydhUZD8DrnB+PWT/rM/yYqRlY5QxOjxzhjONLhDhJnljgao6E0nZJR+eaSm5gZNYFAfCgzBq5Jmogr8zPgEiuMRCLJYe8wBQDb3f0wrCHoa9siUNkGG9fVc9Y5AjkOV1dexeH5aRVQR0sRnHs7jPt3QbmRqFufi4IQ/NDFFhsLq7YsWO4TIP3mc1qqkkVtjLhiDJ4c5U3iDljy2hq88NcaBEmB6DNr9nh5yA8CuSvtse0tthvzatqs1WishfqGJ6SU0VHpfpdepKcQ59DHM/U4qzrER9sQ+hOlnoKiQM9Zde+kLMO3LKH6qI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6916009)(5660300002)(186003)(36906005)(83380400001)(70586007)(26005)(54906003)(2906002)(316002)(6666004)(7696005)(356005)(36860700001)(7636003)(70206006)(1076003)(426003)(8936002)(508600001)(2616005)(82310400003)(9786002)(8676002)(336012)(44832011)(47076005)(36756003)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:34.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4b2cac-f96b-4861-2063-08d99838a761
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register simple platform device to instantiate Xilinx event
manager driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
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

