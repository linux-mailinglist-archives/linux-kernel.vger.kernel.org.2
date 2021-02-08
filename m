Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D47312AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBHGfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:35:25 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:52641
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229978AbhBHGcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:32:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0MeycSjEcihybovgr9lFXx4d7uu3svIiywKCg4DnGsSNVMMkfFTEVGUgk4UXNn2FH/h6Yqft0HAUymyeFp2wiCU0VaxpnNaGOdHwt9QqBOmKMiAai6WBm9qL7Q6sTs7+QOKnKBZS+g+9L6Y9NLzcwCk2g/ZWYM+k7ZqW0aSZrrAohbqiJ9r8Z6cLR6/tey43irgjCC9jtS4rpMkfoDOwxzHig2wV+2tKuzAqejfab5t5smjcFeBx+2ZF2KkarjRgKKwzAjyC71COZJlGeeqbOLnh2EMKllNvR92XiUcSw2G5GRUPzcTuDF7W8y5Wr+gRbE6I+x0k7lCuUXYTzWHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asuG7+yF/wcSpX10jX9mP1QK8+4OEu2dGcLGBaqOWpg=;
 b=Y0+Jqe0EkLZscTSIdRt1ChgpPkkTwn7ewEHExQz12KPMijBLUaDZSjcZ7KjEYnMJAfmh68hhZOPBhnCVk3ut5/3+QUjerhc7aMhklrz03pf13elsUrcrzXqFAVeYGUmKuoMbSz6pXHmutEtmvX2N613Yf6AG2nZ4r5gI8iOFsECvik9lLScDr15o+6xG3mUyPwgh0mCwbEy41anLlMlafT/AccOWkpdz4I/auKh8IWBK5kXS9B7esVltDmJGucWCJ4WL0aqZhypyR03FTWgLl2n/gGVgBrqTGMr2Q2VTCdIPt36DiSfkIF8+CeQQg3ewkDu3Yv0cvhvL9QZlhj4wWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asuG7+yF/wcSpX10jX9mP1QK8+4OEu2dGcLGBaqOWpg=;
 b=jjcZX6UEeLGb8A46W0DRJJn8ioi1+KsJVcNNvTTuNbJA3sgM+/X3vuT7e9lx/MNVOMIlQLCgmeycHQbiGc3QSXWop6qMPOQ39XS8zOPIFIy9bFxffrGKdpfjhFIcSHmlrNo/19A7vhevk7UsXZ3ijWy1q+KqmE60XWeLOfAq4RQ=
Received: from CY4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:903:33::19)
 by BN6PR02MB2420.namprd02.prod.outlook.com (2603:10b6:404:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 06:31:53 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:33:cafe::29) by CY4PR03CA0009.outlook.office365.com
 (2603:10b6:903:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Mon, 8 Feb 2021 06:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 06:31:53 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 7 Feb 2021 22:31:52 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 7 Feb 2021 22:31:52 -0800
Envelope-to: amit.sunil.dhamne@xilinx.com,
 michal.simek@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=33868 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1l905Q-0004xt-Jd; Sun, 07 Feb 2021 22:31:52 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <amit.sunil.dhamne@xilinx.com>, <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] drivers: firmware: xilinx: Fix dereferencing freed memory
Date:   Sun, 7 Feb 2021 22:31:23 -0800
Message-ID: <1612765883-22018-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b1cfd5f-1b94-4c2c-97e4-08d8cbfb3960
X-MS-TrafficTypeDiagnostic: BN6PR02MB2420:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24206A3BF92B62CC58A9769FB78F9@BN6PR02MB2420.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9zAZiAVLNMyCGumoUzYbbRFyUlKVTzl63+B0FTlapwqleZI4sbn8reX5+HoqxtGUSA31K4u1dX6mtBW/zWVrCkFiPpIuvWTVXcjx3VBJ01IA2jQgx9WPq5qPTfFk2dc2L2kwccxI+UnB/ANZaxkrw9OA9xJTlgN5GNLWcPeZfKRaEdO3Z67d9MFVtcuB664IZSQ52g36JKRCrUysIBxM5Bi/svu14SPEwy6qrOXT77+qTMOk4fnOGzASWQzVQbAcWxIvBmFq9qX6D2t2g/3DZMQ5ePRPtr1eqkial/j66mZbVQ8grTdznEjyh3GVGul24XZo6idf1kTM4yruZ6YyqT4wEPZhpNAwaodxCQnqFWAIk5Y7fgGmFzJJJJT5g/jPacNhZFdPunxPTmYbaTSY4k70MGUdsLaDoOSuLh1XPDWAbajxnkIIQZFBTxsUGSqSRs4/148Ox+8rTVDj4DN/uA+HnTmCsqpXorxmyKY3L70Ht0qxvpOzWtREoZ2yAT3k5KL9Bw3NXA+LmqdNKnlx9ko3MbIg0B8xA9oDBcjSUKvEMtoJsyHwzuJxbUmOuiUZem56EnJZuOU0GT7by2jF3hXt+tgumyfsG3XTkDPCiTPc2BdJX4cfyL+PJiIXh1Y1HTQGlV6DZFL7AMFbXMybmd5/D1kCJ4KecltgGARR/D7zhlDTuLWWts/pWddWqnN
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(396003)(136003)(36840700001)(46966006)(82740400003)(186003)(8936002)(107886003)(6636002)(47076005)(7636003)(26005)(356005)(9786002)(478600001)(6666004)(5660300002)(82310400003)(4326008)(36756003)(54906003)(2906002)(8676002)(110136005)(70206006)(36860700001)(70586007)(316002)(7696005)(2616005)(44832011)(36906005)(83380400001)(336012)(426003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 06:31:53.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1cfd5f-1b94-4c2c-97e4-08d8cbfb3960
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Fix smatch warning:
drivers/firmware/xilinx/zynqmp.c:1288 zynqmp_firmware_remove()
error: dereferencing freed memory 'feature_data'

Use hash_for_each_safe for safe removal of hash entry.

Fixes: acfdd18591ea ("firmware: xilinx: Use hash-table for api feature check")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7eb9958..83082e2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2020 Xilinx, Inc.
+ *  Copyright (C) 2014-2021 Xilinx, Inc.
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -1280,12 +1280,13 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
 	struct pm_api_feature_data *feature_data;
+	struct hlist_node *tmp;
 	int i;
 
 	mfd_remove_devices(&pdev->dev);
 	zynqmp_pm_api_debugfs_exit();
 
-	hash_for_each(pm_api_features_map, i, feature_data, hentry) {
+	hash_for_each_safe(pm_api_features_map, i, tmp, feature_data, hentry) {
 		hash_del(&feature_data->hentry);
 		kfree(feature_data);
 	}
-- 
2.7.4

