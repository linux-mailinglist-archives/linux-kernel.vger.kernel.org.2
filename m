Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C673653E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhDTIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:21:21 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:41984
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230346AbhDTIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHchUXSJ7WD0x+Ao1tmqCfH/ZVkez2QQ7kqs3g+nll6ftTwBdVnjhV6+t1olkygEdlDFMoUvu1x+S5jKzHLp9gt+ZrQIcauxNCyiwUALXYKcD4qlXCBYwkst3+2vMbYBm0m9rYc58bqx2uiG37VqTPDnUk6BvcayIm8nzKj+Sbky4U46fGlqRUPvnujM0WxwpEc1sphsnx0P/YcDrs6qG+G7zu0Ec40Owfx7RsRJ0QZCuoM3y5Ns/mqBSx3b0ZuVWFFhha6q8TTzrnNxATfCMDKzwacp1ks0SSNSiR4WMEY1BkjtyGgWFTQy/eXA/+0VJ+WhH4G4tDUOj0D5PZmq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hm0NPCoAtTftE/7p1334yhVr8XDM9CngPs3fX5/ufU=;
 b=Agh62DD/WJhcntxxx29NKerRxiCGB0oZybVkxDAkoNlRbWRc7lkfa9DKuVBXLXk8l0gWBIJcBEfojmTvuCcGFYfuLPZ/j3U/heFWBJ0Ct5stFsjHlKG4lo3AdCtEIDS2SlRtTKB89CqjTfqJXQQTq9mO4ZKtpnlsAjXeuiDAeq2VSCpi45Ego0QhazESEK7SqcwETkbKOOYcT/kSm6bhVtXVCQE3acp9+Qb6T5I3AJ05jgCV+TofyAXJK05cMoEKRzvwC3IeEfHKtb0/N0GQryQthh1ULI62nvMsoaRdfTX6efzhuiQGE0t/s/GdtB2VSyjJvQHaRibQkYFOTDa0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hm0NPCoAtTftE/7p1334yhVr8XDM9CngPs3fX5/ufU=;
 b=Fm+O7TJZKhPVp3/croAiuHS83MWxxKmMNjqE/UEx7igoioKQkRYXlK/gpuxZSQm3/tq/bU8p3A3zU51BBvJrwgL0QyIF8i7jlchIicafZ0gBznGX0Ovwspf3DHuMKolh08kSGwm4MRHV2ORFnWaQ3D0JGafwLOuxj9zG0HoCdo4=
Received: from CY4PR18CA0058.namprd18.prod.outlook.com (2603:10b6:903:13f::20)
 by SA0PR02MB7418.namprd02.prod.outlook.com (2603:10b6:806:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 08:20:40 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::8b) by CY4PR18CA0058.outlook.office365.com
 (2603:10b6:903:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:32 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=45276 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lYlcV-0007C5-CA; Tue, 20 Apr 2021 01:20:31 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <nava.manne@xilinx.com>, <rajan.vaja@xilinx.com>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <amit.sunil.dhamne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>,
        <git@xilinx.com>
Subject: [PATCH 3/5] firmware: xilinx: Add afi ioctl support
Date:   Tue, 20 Apr 2021 13:41:51 +0530
Message-ID: <20210420081153.17020-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420081153.17020-1-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ffb443-6cb5-4664-e186-08d903d52ef5
X-MS-TrafficTypeDiagnostic: SA0PR02MB7418:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7418F59714D397779104CDE5C2489@SA0PR02MB7418.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YNGrxuVPYrty8//VXsoO0dO6Ef2cZ5rnMBZ8uGB23lITPHC5mYeTHlJdQvmJXZvEWzV6FAQa5XMB4XBlL2IhbPoIrag5G+j7XS3K6tGUg4z1wNp0WrDqZ8tW3eSpgV8OR+ejxZXO3uaYCfLAKL2IxAjdpUpNOB4oio1wyru9cL+92ekzqhf2ziWe2awcwtX7Uw3q4CfAJXcXu+jMFUuQRbbiIft9GoaLHY03znSbW/GGruknBt9pS8IyQbamapmTesme9v89TBBiUeFT8hLrQk1gFqPgGwldVTuqKcLIPcaEeoZ0z82OPIGf2AB1x45d7BEAZ9UlkFyfIlpJLL7FiIScXSh3oYRcvDa1pdnD3YmX6efxu1tx4k6GUxsXuCyJSGHQtZ9Joj6/0xja8e5tIzINThuyzuvZHZiGxQzSqwN8pTGBXspCQ/QGdh76IXatXBV6RhWWyqN3jpEhnDsrZFdwnIEQjD5DQThGQK4iBL3/pDpql2DmOZI78tvIyGRlseW1tTXsVapNqW9LSe+1TiMUo9toYKz2f4GpaEgswM3DXzZFdEZNnKHDBGJt5rKF0VRBW0lSi+Rhd/1IMhGeJRJd1C1vpjrD9imFockip82kaxOfHU20uv7mD61nr94LjHXZkv8S9jhIdp2Zu2frvU/N1Psy9czNN8FEz+pPGs9ecXJbxJRPf89N766Fx7Sy/EOKG3KaTVDXdz6QDsw43JX6ZEQgVIsIlxZ/2CuYHRdEpRcup7Z3asdmeNJYYwX
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(478600001)(8936002)(921005)(186003)(70586007)(47076005)(70206006)(8676002)(2906002)(26005)(82740400003)(9786002)(7696005)(36860700001)(7636003)(356005)(82310400003)(110136005)(5660300002)(336012)(36756003)(6666004)(36906005)(2616005)(316002)(1076003)(6636002)(426003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:39.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ffb443-6cb5-4664-e186-08d903d52ef5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds afi ioctl to support dynamic PS-PL
bus width settings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 13 +++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7eb9958662dd..ada9eb9e26e3 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -713,6 +713,19 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
+/**
+ * zynqmp_pm_afi()  - PM API for setting the PS-PL bus width
+ * @index:	Register index value
+ * @value:	value to be written into the register
+ *
+ * Return:      Returns status, either success or error+reason
+ */
+int zynqmp_pm_afi(u32 index, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_AFI, index, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_afi);
+
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
  * @value:	Status value to be written
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 71177b17eee5..792fb4f5d86f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -113,6 +113,7 @@ enum pm_ioctl_id {
 	IOCTL_READ_PGGS = 15,
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+	IOCTL_AFI = 18,
 };
 
 enum pm_query_id {
@@ -353,6 +354,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_afi(u32 index, u32 value);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -537,6 +539,11 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_afi(u32 index, u32 value)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.18.0

