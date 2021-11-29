Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13872460F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhK2HJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:09:05 -0500
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:25440
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233486AbhK2HG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:06:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDL8qawBGE0HUL9n9GmDJ4oRT1YQfrIPvCmbvVu6y2E9Q0o4j/NEqJvy9wNqxWGzuwMCMLI8/KsXw5ym2I36a+2pxmOHFCm65FfRJjAvfgwyEp+4tV04pqKVBL4VtLm0aW/B1ELmM9hSdiOLW2DBux1KrTmu5D+VlYE55xSSh8pzuxb8lt0ub8k4Sb9x13Co2urOTbt8M6EGLX3L+qbO5m03Q6IB3j9aFt83r5FqdmY6ZWHXhuN7xniwIhKwxQfYO8mjBv44XzZ+tqRGYZkbK8pKZtqWx0at4eRu4x0ki4tVm1Wf+Ql0iPNKATLi/2kgefAW4Rzf69sm6Lrx+1WAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofGhjhz8V3aXYelZQ+yP+eVy6oek+h5hnehPKBuVovg=;
 b=lrZohQx4THZ4ZNsJA7uz6Dg7AM5CPJThRkYngdpcMMMalJflDFfWBGT4EQeIeU5m4cF+J249NxnoBL/ZTJUB7Ayy1qTzkfBLac36+FeCeheqSLqQVplhNJMjVXwn2h7Y/eLPLbruFGDNd3xuLDoPPHiERXpgmLAtkych591aZYt3eEbjIOQqaG9vDjLUrnQjPWSimJg/G8qdVhxETvyyzNLb44k9vYjNfgXu6elA71B2vb4k6YpYA7xiDzSDmZrwcj3Nyk0iYn53aFqG6KUQxGD+N5BvX1aQcujLPJ85vFD0hQA5S8ADCqXoXZSMhtPDvue5vgim3yr+ot75iRpP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofGhjhz8V3aXYelZQ+yP+eVy6oek+h5hnehPKBuVovg=;
 b=CQni1xwHbgnWs7PzXuKCOox86/AYhRHJjoXnmFi7z627NkhzT2QiD0XM9AB2gaJIz7QiGY8cHkdCMMiOPG6iGcXjL9zdEHykRyic5Trlz/qq3jsFAQYx88WEUKPVcnlgammBVrruBpUZtsy3D5iQO8SEKWI95prZq2n/oj7CxIM=
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by MWHPR02MB3373.namprd02.prod.outlook.com (2603:10b6:301:6a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 07:03:35 +0000
Received: from SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::8a) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 07:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0036.mail.protection.outlook.com (10.97.4.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 07:03:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 28 Nov 2021 23:02:33 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 28 Nov 2021 23:02:33 -0800
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=33638 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mragL-000GZ4-9e; Sun, 28 Nov 2021 23:02:33 -0800
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <jliang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 3/3] driver: soc: xilinx: register for power events in zynqmp power driver
Date:   Sun, 28 Nov 2021 23:02:16 -0800
Message-ID: <20211129070216.30253-4-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <YZUcAch7lVZ32/+t@kroah.com>
References: <YZUcAch7lVZ32/+t@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869c732e-b602-4ab7-f50f-08d9b3065c7e
X-MS-TrafficTypeDiagnostic: MWHPR02MB3373:
X-Microsoft-Antispam-PRVS: <MWHPR02MB33733D9F04908C40A3B9D892A1669@MWHPR02MB3373.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDfDmni+6/BIzrASv+lFiMiSeChtTwUxVb8BmlpydPQ8gJYslTQo6eL+csZNSQyrZfWfnkCtZgUNSYeZT/VdTM8w7S8ua1NXHFInKPQzN18vKeqL48ADNyWW3b3dVFzXn1x4p7T80mJaiRUY4is2PPWLMd9UwxIaY7Vq37cbAGkFiPhBV7Fkn4CaKH1LUmgYHR/51FI8PCHXP7y63xGYhzod0hqSWjSJrn78TcgTj34vjP3dbqnTn3cHzDamGfhJOE6jEXzZE/TumvqynkRZrkhPUM23BYnIterLPtyULTDjzTjZrArT3tDXYzpbdq5trHlFdBKSaS70W+vlgTql0PCG8rEGBjPxxMktp38hQB+S9iMtItAAP5JLCXtRxlsHVcHb04/Ls6P0/PupkRgr9xFzqgKzPZzwbjFWlaUTe5T1Gyo4+hxw6a16d1KsBogozFh35c1rBEMhrHyc0imthctp6fKyfS17/ofVIjEKymV2sj1lR1nbC5NrwbZ2Tb2qDoOWu089gwo5TjDR1OSNcedqYQyzOtRhISqHdI1b0kY5PsENFrvO8PCrWokccLBjIRYuvZsyaNqYut1jl70q7k1zHj//iTvcVBerMtVn2rjlE1/8wBeFbuPynRDPPdknHeYnNwgUfbE55pzPwQytfi47c104yc7h+hqlWpMvjP5neI6fYUGNioGdi/VQHj6CaBH/77NLFiVNr622s16/YKb7NNMGfQzzARNm5gNzdII=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(9786002)(336012)(186003)(6916009)(8936002)(2906002)(508600001)(47076005)(83380400001)(7696005)(26005)(426003)(4326008)(6666004)(8676002)(316002)(82310400004)(7636003)(36860700001)(70586007)(70206006)(44832011)(54906003)(356005)(36756003)(2616005)(5660300002)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 07:03:35.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c732e-b602-4ab7-f50f-08d9b3065c7e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3373
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

