Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0288439127
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhJYI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:27:52 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:3776
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231617AbhJYI1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4VqZrJNHLM+diRDkTRqKBtOkPH+Cmd7s8DvKOtuOQdBhNmtNQTLLnDKLYU/jRDoOXTt/j4RrPxwoi/BPM886SYEdVcFkXcJyYJyruk94J+UjQzoP6kmNoKN3i8ZqRrcIGnlY4dglW648KvANjakZer4bViZhSz8DYtcPx9IRPlimGIFfBoLzucuuphaIuKhyRc+8J+2HQ6MPIuxAXTTVJjMkKEC9sInglCq0PCEvEgIZAd6Hfecundmgd2PwC5CPmDFTYvoBKNiLB5hB4mOG2LAzu+piwVTv/HSrsfr0mxdm1OJ4X2JkqVcxW2GXMF0Sgsn6tb4I7zgl/MOTQf0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFoG+HHiBoTuu86X0HKIE40f5O6StXnVqxAges578Lw=;
 b=PZ//STfWlzClLSPOAufjlGM/9if7zaCIGeKEhYMPquBOXxm/wHuHeRECrSpVE0ynPMKM/GsZiLRk0A+4ihqjSDnd7Fv/KwNb4uyej8hQE7MchrPtetXSDcef69q5kFZfxdmbzwzIA1HjkiopEpY/Xx3HDEBlRu6BRlIyceb1yb+M1aNVrhJrryutS2+lTgai9Fr4R/Yxq3tB93D1XOyMYNs7apzXZV6DedIOrbNi6q/Ytur6aeLZqmj+bHFZCWFGULeVDw7DEE0ZZs0BTOp3ivLLo6LfaZM+KWfTqBdAjDyYzROBBa+uyQWKDzdmI7mz+7vX6BUQH7jR1p0DAhwkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFoG+HHiBoTuu86X0HKIE40f5O6StXnVqxAges578Lw=;
 b=PgcrbQD2GfoRqVcydFQHU9XikscTjfOXwyySFZcsGsJIVlt9/U0ZdlopuD7ydIkrZRM0YLbzS0w9O6ZDTleKAacy3gcAZSaJYEMi4Pgfzg8tdlOKvpY0a3K6HaLBjTZaIixOW7BhXcEuYd0Mqfa1H2mFYwtZVuV0uUDmESTIL50=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by BL0PR02MB5491.namprd02.prod.outlook.com (2603:10b6:208:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:25:17 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:21:cafe::a6) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12 via Frontend
 Transport; Mon, 25 Oct 2021 08:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:25:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:25:14 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:25:14 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37006 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mevGz-0003vt-PW; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 5/6] firmware: xilinx: instantiate xilinx event manager driver
Date:   Mon, 25 Oct 2021 01:23:49 -0700
Message-ID: <20211025082350.10881-6-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2128c48-1913-4a86-05fc-08d99790f9d4
X-MS-TrafficTypeDiagnostic: BL0PR02MB5491:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5491F4ABD793D9EDAC406AEDA1839@BL0PR02MB5491.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1Xu0ngRmvcGIqiabemJTnAtvEc7KTcz2/qm9TFybXiJuWU0FqmJ33IBkFYNz2Rhzq2AJGaQltLApUeOChNjJxAILG8nKxjEYORC3y7pXs98HZQHvRkY2tFoN77pI1dN4KFe1dlOJtEPJe0KIF+9uqY5CTTNE00htV0qvNJ06Ov38/2r3QSr106HMQhSkPN+Pn9NBnPmTQVtdYy/yeY3KGM5b9U+ouXFgWjmoJLC1eD7Yu0sQ1+463GJvC9l0/tS1B1OM+ly8zOywrnG+2LoQC868fkXR9eMbFwPakKlSydXnM3x9sTYfD1HbN7Ajzaxxctn5awVyFkKgEzMT9L222oR9r95erXcPweKadrQpGcclLvJB278fR9irCEUVGuPESJKrGJT1R1LirQghoKfk/ypGtUFnJKwDNhEoOe1eRFs8prEfF3EH6iKzFBsX0kslxYk0bW9QF7zHxbbX6yOufUAT7bT13sXDeCw0CO4UHN4Ujs++2iJmPcS1khmupjoicBZMWel+Vgk5f2NmsdQtPeEKj/MP5N3+Clxo22Qg1xkM3rW0NBTZt38nurVbmFc1XiVGjMk/hA3oxCUSQYyemiBQU3RaJbpWz/9lUenPkII6x6XCK43wDfY/N+Vx/4hTwWcFV+L1BjKZ2nraYCGizYpIodvMmaDOHk0GcXU/kwsqMpYinFPQklW3Awp9jLAodbBS3q+G0GwXirWCrslxGDBU+/hVWnOPwI8dob/tls=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(356005)(36860700001)(7636003)(36756003)(7696005)(36906005)(6916009)(83380400001)(2616005)(44832011)(8936002)(5660300002)(316002)(1076003)(4326008)(426003)(2906002)(26005)(336012)(47076005)(9786002)(186003)(70586007)(70206006)(508600001)(6666004)(8676002)(82310400003)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:25:17.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2128c48-1913-4a86-05fc-08d99790f9d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5491
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register simple platform device to instantiate Xilinx event
manager driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
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

