Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87BD436355
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhJUNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:45 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:52353
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231659AbhJUNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRfWvmKPwEkod/QUsgxMFdiqP47wYV5EAqsOH+ujEXyqwMzYfeTglCIVUoSZUeWrlpKY+AoRHrDSqLSmp25tXg94ZeBPd0LUwjw7MoaonkS2HVISQkS6OAw3QVWH+0pL4+FLExNCsY9gwfnxvBw5sQGSzoyebCLh3NIYSgtd8sWr1irHbz+YQj0PVxsrCH+QQYHs8ikFFHAxseEvPoI74qC/tlUaRwyCRqA3NDqt+Q52ZU8NEB+kMVJuS894Kji6fNrdjQTAq95Uk5v5Bmbi8cbUYx4AuhlCMylmjxCFH05PLM37hjndplJvUKbW07GKnjKYCzGjj0clbeuGv5hupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k/YXtOecnc8ahX4uYpUzoLvfbzO0MQNE8Bv8L5I8J8=;
 b=f2V5zPA/pKnREYxU7ptOLFPxOL3PndtRWqrBg/jM7/kbemX2kEoaVfG3Vk4EDWGsNMPt7h+IS6EpbJ0aYx8yRl3m5qW10I+lul39RoYvSLoQdlVKCcNLZgPnZHQLRi0mktJSbW0P+XC2ntVkD6A0Js15k+ymMpfmK2tGOR3+wp6ML0uBEFvlOOFrl9/hsOqTC2xxHuHQOH9XMETgoHcOKzRCLnPSM/EFEMu8PhfQjhlPyNJC6OGWLc649gazl/OJDWkG6+ag7POwnAHNwwnl0CzqskzpdNn7HQezdircEBSINTEadWc83LX6HhkeqWb0hZTlO9wiibWpCotvd3mAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k/YXtOecnc8ahX4uYpUzoLvfbzO0MQNE8Bv8L5I8J8=;
 b=lCK1pm+UWun9moT5zBbuxe3H1cNTAzcBzPrWRjmxOHfvtgCeukJ3RTgBkULYRWzxFXdaZn6a5e5UeXAILc/cf+SkYdoNTb8zvx970QicZ0owTk0XTWpQaEnU+p5/UIgCq6ytbQOitLusZYasVpMotPnyKULB9DZX7PTzp6r3gsY=
Received: from DM5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:3:13f::33)
 by DM6PR02MB4508.namprd02.prod.outlook.com (2603:10b6:5:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 13:47:20 +0000
Received: from DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::7b) by DM5PR17CA0071.outlook.office365.com
 (2603:10b6:3:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 13:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT048.mail.protection.outlook.com (10.13.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:47:20 +0000
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
        id 1mdYPG-0006R3-3D; Thu, 21 Oct 2021 06:46:54 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 6/6] driver: soc: xilinx: register for power events in zynqmp power driver
Date:   Thu, 21 Oct 2021 06:46:44 -0700
Message-ID: <20211021134644.14407-7-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 321904ed-53e8-48df-ada4-08d994994dc8
X-MS-TrafficTypeDiagnostic: DM6PR02MB4508:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4508FB52C747705CAE252DFBA1BF9@DM6PR02MB4508.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGyUsGCufwxO3ezhVqroxMBhQ5+yTBxkF5kayKM9/6YG5FbjGAoPNs1mAId+oUYcStm74618o1wYv6TMP6FbrEX3Rajl5SA3sYN9weYx0TfFh/X8PHMSaY9CdoFOsCBIHKYDSIZIKp4LfyqoUr+iUA3nWYom/OtSPOKBUQPFYrmbXpmqQiN0IhK9wZ0AOGUNAm1JB/d/2L6XjWJeOxNyMGOHpSkeUmu8J3Lgri1eM7GJHn2WDTNx0JhbjV/BSdMCnapK3jiJfuF+xB9bkeWJb+49gfZ/qX0aWYGdc9z8S2QokCwkzZP195/unDtwBsp9uddqoWBwppr7tnKtYDTkDFhq/75QpQCECao5olFDOxgKmUkM95QJxvf71uanMqGxUot4LhAWBI3LHJB7SSgmpFlIIwssydgpdtnfKQr+tZ4BvJ8kuT5JycgtjnKkmKG0WN2M2KUlhdzVLrqCQliQq43m4ZmKgGtM8Ar4+zNhgK5n+TfrIAQDDXazlKMpZgdeSW7oBgUCTgrvLCV9DcLQFD9SH25o6p7z4oNQUKvvpbKaYBFymd54N8RMqv2Xs0wWL+akbDFWCEBZTuJ/kXiCs5/DYTOVJyR1SN1KNo8yEzj+zhr75qJdBpL3+C5LBemT5P+AIyZAFlZx+ddfKRhoctjR9zclndLe1T5+hk1ePdFB9o3YNL3Ed16PVQOuF3NbdOFYYNvA+MJljVLKZSG++kQ8bKY6ZuQYcOoCdMRWtU4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(186003)(8936002)(26005)(36906005)(6666004)(47076005)(2906002)(5660300002)(1076003)(316002)(36756003)(2616005)(36860700001)(44832011)(336012)(426003)(7696005)(82310400003)(8676002)(83380400001)(6916009)(508600001)(356005)(4326008)(54906003)(70586007)(70206006)(9786002)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:47:20.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321904ed-53e8-48df-ada4-08d994994dc8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4508
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Xilinx Event Management driver, all types of events like power and
error gets handled from single place as part of event management driver.

So power events(SUSPEND_POWER_REQUEST and SUSPEND_SYSTEM_SHUTDOWN)
also gets handled by event management driver instead of zynqmp_power
driver.

zynqmp-power driver use event management driver and provide callback
function for Suspend and shutdown handler, which will be called by event
management driver when respective event is arrived.

If event management driver is not available than use ipi-mailbox rx channel
or IPI interrupt IRQ handler for power events (suspend/shutdown) same as
current zynqmp-power driver.

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
- None
---
 drivers/soc/xilinx/zynqmp_power.c | 48 ++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 76478fe2301f..fe7be176b226 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -16,6 +16,7 @@
 #include <linux/suspend.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/xlnx-event-manager.h>
 #include <linux/mailbox/zynqmp-ipi-message.h>
 
 /**
@@ -30,6 +31,7 @@ struct zynqmp_pm_work_struct {
 
 static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
 static struct mbox_chan *rx_chan;
+static bool event_registered;
 
 enum pm_suspend_mode {
 	PM_SUSPEND_MODE_FIRST = 0,
@@ -51,6 +53,19 @@ static void zynqmp_pm_get_callback_data(u32 *buf)
 	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
 }
 
+static void suspend_event_callback(const u32 *payload, void *data)
+{
+	/* First element is callback API ID, others are callback arguments */
+	if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+		return;
+
+	/* Copy callback arguments into work's structure */
+	memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+	       sizeof(zynqmp_pm_init_suspend_work->args));
+
+	queue_work(system_unbound_wq, &zynqmp_pm_init_suspend_work->callback_work);
+}
+
 static irqreturn_t zynqmp_pm_isr(int irq, void *data)
 {
 	u32 payload[CB_PAYLOAD_SIZE];
@@ -179,7 +194,32 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	if (pm_api_version < ZYNQMP_PM_VERSION)
 		return -ENODEV;
 
-	if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
+	/*
+	 * First try to use Xilinx Event Manager by registering suspend_event_callback
+	 * for suspend/shutdown event.
+	 * If xlnx_register_event() returns -EACCES (Xilinx Event Manager
+	 * is not available to use) or -ENODEV(Xilinx Event Manager not compiled),
+	 * then use ipi-mailbox or interrupt method.
+	 */
+	ret = xlnx_register_event(PM_INIT_SUSPEND_CB, 0, 0, false,
+				  suspend_event_callback, NULL);
+	if (!ret) {
+		zynqmp_pm_init_suspend_work = devm_kzalloc(&pdev->dev,
+							   sizeof(struct zynqmp_pm_work_struct),
+							   GFP_KERNEL);
+		if (!zynqmp_pm_init_suspend_work) {
+			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
+					      suspend_event_callback);
+			return -ENOMEM;
+		}
+		event_registered = true;
+
+		INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+			  zynqmp_pm_init_suspend_work_fn);
+	} else if (ret != -EACCES && ret != -ENODEV) {
+		dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
+		return ret;
+	} else if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
 		zynqmp_pm_init_suspend_work =
 			devm_kzalloc(&pdev->dev,
 				     sizeof(struct zynqmp_pm_work_struct),
@@ -223,6 +263,10 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 
 	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
 	if (ret) {
+		if (event_registered) {
+			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
+			event_registered = false;
+		}
 		dev_err(&pdev->dev, "unable to create sysfs interface\n");
 		return ret;
 	}
@@ -233,6 +277,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 static int zynqmp_pm_remove(struct platform_device *pdev)
 {
 	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+	if (event_registered)
+		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
 
 	if (!rx_chan)
 		mbox_free_channel(rx_chan);
-- 
2.32.0.93.g670b81a

