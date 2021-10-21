Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D7436353
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUNtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:24 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:8992
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229952AbhJUNtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k92kET4DPu8OLUvONUfOvPiWTeGshpylrhPcn4ITc78ZZGNCMXR18IbUAx7atp26fg1r0yW59uDe2pWN9a00Bj/A/JbtbdPeVHTRXoG1sto/6ACO1VT58tvPiVYN3uTTcJI9MnaAOepo5I/WLXuUh2wyig2jK0QJr4Kk/R1dWk9RaLy9EGslokyH6ALVUPG3HE5OVP/ITJiCIAODOaDxZsAjd2Th0TvFvzq1joOXnShEMp88+Q6zpCYz5NWDDp4P5do/G2eJ/DPguonX6XAITVMMXlQbamuX9QbDSLzchU3FDBpHY6Gjy/YyJHgd4WMZSNvSQP6nWN66acu2H5bvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKhnq04Oqx8ICrAr8pQTPB+JN88cpfnbeaw48wqySCE=;
 b=eFhbAd/B3stWQF91PwcOnSAcOxMTVj4/Wp21KfGzqLzmBsHjwC3lpJYYaWx0SCRyuhMOnGocm4Ei7oNqjEFF7BjZ5Y37P04rBIgcZsNmvj14C0GsB1USkdgPzKsGM18ZiNGADxXmPgEj4Kydq4xtJEwIMo1xpUf021aJOHrpar5SikwsFoFXDuXBaHaWx6XVlOiA+g0QEHk2/WSY3w8vIQu/eRQ9J79JToFDZBaDFmh6r/xe4Zs22EWEk7jrkjt9LbyvXIqN9EBkfw0T20/586Ru9wXWUalYg+7snW1H4yoo/xmb0nIvg3GGO+cxUWYjpFXffRVWypBjpc+KqfTsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKhnq04Oqx8ICrAr8pQTPB+JN88cpfnbeaw48wqySCE=;
 b=lnQXrGXOcNADc2qDKk/9RCKyyYdIsQGeIpeGS4cx+huAcKsvInBoqeSR0bgwQvZIcO1HMdEhK0T9A1DGURSecfWKQsPlzxupRslJYdZb6iQamyL0x0JE++vZnXwrXGVapGO7RzyULrw3QPEFSNm+FDjqTnIxtAZP3UcQ5qVcR0s=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 SJ0PR02MB7760.namprd02.prod.outlook.com (2603:10b6:a03:32f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 13:46:55 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::47) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 13:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:46:55 +0000
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
        id 1mdYPF-0006R3-Tf; Thu, 21 Oct 2021 06:46:53 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH v5 1/6] firmware: xilinx: add register notifier in zynqmp firmware
Date:   Thu, 21 Oct 2021 06:46:39 -0700
Message-ID: <20211021134644.14407-2-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055855eb-723e-440a-768e-08d994993e9d
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7760:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB77601FBDB3E8B32696BD408AA1BF9@SJ0PR02MB7760.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvII2pkapfdDKJWAURjFJ90EeG82t8vKRv0cP8hrfoKfN7BFu8RkfLKiKCmkDs7OOj8xb+WlgiqSGWFSupTMLNBG4WZcT7QauboXgLbph17B4q8UKRDuRDUsIDpbXix8FvkOI0tfVBvLhE0zXaBN4bGQr76d63qaKywzxluA0e82OpC5kcXoW5Jhh/lOxtui6Pw3dNklHCDHuaeL5q9ny4vOiO3Sf0ohfZWV7HUAp4H46rybQq9+QknxQqx68JXG5ZHji95iV21OXM0VsWpdFDwcuuTh889SY6n32fj45+lD93pV/JnaPVEmtO1Z2MJspF4rSym4/syVGhbnGY/d3Ye8TuZxYOmwmACxCvYuXOc1i5q6JsxfmOAlIf5vVzEri236ixl0cCABxeQ27ajGyvxdWV3aQSPwnBDMovicj0IIQ6chvlIdGxn6OY2bT4jTqAbKKS0a9kyIloLaeEJ8w/khoULiPwXfK+UW5cLc1wGgG0fUYAch2O9dT32Q3RTSK5KTew/EbHmFRWFVBQwi0wOCgvTk1z0mEUOHRJT2DdBtFDFFcf8btTlnY0UEPefSS9Fo4zI7TIxD/onBiCPpAWLX/P2vAEHdGiuO9DZoyZ6FSDMvYU/YgrU6cNSDo7Y0DSOcHaA3Axwl7cD2WqOaDSKevWoZpoobrVtYoe20Gt55pVUdYd5So+kOGRy+0x1WTH/3bfqFErglCQ6X/1gk05GCrrC6AQ8+9SAVFplp7lg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(26005)(5660300002)(36906005)(186003)(8936002)(47076005)(6666004)(336012)(107886003)(7696005)(2906002)(36756003)(36860700001)(316002)(2616005)(44832011)(426003)(1076003)(83380400001)(82310400003)(8676002)(356005)(6916009)(508600001)(54906003)(70206006)(70586007)(4326008)(7636003)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:46:55.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055855eb-723e-440a-768e-08d994993e9d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zynqmp-firmware, register notifier is not supported, add support of
register notifier in zynqmp-firmware.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v5:
- None

Changes in v4:
- Rebase on latest tree

Changes in v3:
- None

Changes in v2:
- Removed updated copyright year from unchanged files.
---
 drivers/firmware/xilinx/zynqmp.c     | 23 +++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 ++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a3cadbaf3cba..6e653e9cea2d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1053,6 +1053,29 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+/**
+ * zynqmp_pm_register_notifier() - PM API for register a subsystem
+ *                                to be notified about specific
+ *                                event/error.
+ * @node:	Node ID to which the event is related.
+ * @event:	Event Mask of Error events for which wants to get notified.
+ * @wake:	Wake subsystem upon capturing the event if value 1
+ * @enable:	Enable the registration for value 1, disable for value 0
+ *
+ * This function is used to register/un-register for particular node-event
+ * combination in firmware.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+
+int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+				const u32 wake, const u32 enable)
+{
+	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
+				   wake, enable, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
+
 /**
  * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
  * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 56b426fe020c..d71377063cd2 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2019 Xilinx
+ *  Copyright (C) 2014-2021 Xilinx
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -66,6 +66,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_REGISTER_NOTIFIER = 5,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
@@ -416,6 +417,8 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value);
 int zynqmp_pm_load_pdi(const u32 src, const u64 address);
+int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+				const u32 wake, const u32 enable);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -629,6 +632,8 @@ static inline int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 }
 
 static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
+static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+					      const u32 wake, const u32 enable)
 {
 	return -ENODEV;
 }
-- 
2.32.0.93.g670b81a

