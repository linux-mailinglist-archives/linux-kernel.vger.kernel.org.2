Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07D43AB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhJZE2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:28:13 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:56513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232378AbhJZE2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S156rxt/yNdp9GIpCP6Oh+sUK8pAZhQpNgvdIsw6m2ILIWYdp8Wd7oly23o5bDC1pRO9wsz34cHdhqohlCSeLLWze7YF9miJyUILvk0lnb+Ij85LDIViQQAeEcn5qRlsRxriA0vkB97QXNCaayPS1fyRmEIwA5om4beLsNrLkURZRh9ISn1OhoWzRCyKCSPmbw0XRRBWgAapqzhzLb4WnMnH5dI277DwEmWGQCtrypHXUVb6nBDkk2YZYL6qkpnmLDyv3Oc7XqmSQS1xLYE15Dut+EK6sPBg5lc5JqwJW/erJAMHsWcF4FJ/7VNAcUHZuLs73mzGBRxLUkWX+JTFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN5QNGjjUNQE+e8N/J+XYAwZl9fdEpRbjv2T+NqgML0=;
 b=B3u/vS3WeedR7QTJGWr6XVmXn1fbOMCF1/WRIRhHHtZB10jhe9t6YgOVXhLlyaz5kCtkgRSfeu6aT5gMTLCvO7QAOqZ7tqq02Ehw0wASgAzPRwSABilJoB642xbdiG7RofBesaOYRHrQJYtFMebTjz2Bqnu1ci9YMoEWPHCX8eCWtJYJvKieO485yJvbuz5GkGX9T88TnTNZDYD0tu9+9DR4n0bW0oHk3fANbiw+/rqRUyGpbYrPfvjITMfERGgvjOaGdrIDMTeaE/dAe7P0DCYIfhtGzdhvORC9l2c93e1KTSwDnPpMz7lj89por2oFUhVyWGrTgFKGKyMbeATejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN5QNGjjUNQE+e8N/J+XYAwZl9fdEpRbjv2T+NqgML0=;
 b=CtqDbPyhXnovbQfKZlST+Dgvgr1FKrwiZFeV7RCe0kKKCMbJnC4sOOGtQ75QFoI2gorSWLKx38A03QLayk85hbxbG+hdFc8/rCrBasC6TOorcpmayblGJ6TwivLyGZsJ1w+rEzrQzTFw85HJBx/CFT48740B15ONGDYP6D9rOuA=
Received: from DM5PR08CA0026.namprd08.prod.outlook.com (2603:10b6:4:60::15) by
 SN4PR0201MB8837.namprd02.prod.outlook.com (2603:10b6:806:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 04:25:36 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f) by DM5PR08CA0026.outlook.office365.com
 (2603:10b6:4:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:36 +0000
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
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:35 +0000
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
        id 1mfE1j-0006GH-0N; Mon, 25 Oct 2021 21:25:31 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 6/6] driver: soc: xilinx: register for power events in zynqmp power driver
Date:   Mon, 25 Oct 2021 21:25:25 -0700
Message-ID: <20211026042525.26612-7-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a54a7a-dd5c-4dde-5ba7-08d99838a858
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8837:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB88375584A74B4B0DD1419C19A1849@SN4PR0201MB8837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmUYhNfVSVsyeTFggO+FCN3oElruuFS5WFqfE6R5K8HmP6h/6WOFamp4+C3qjYXzPoXhhaeRJtNXENDzLIWVMkwd5p7Iy+8gl+j0TK7gjHK/86+90ojCQefd70N+lGQ4yZF4Kp57xXl3XT39W6ocKQU0754638Qu6+hjfL+nvFXmSzaPkrrKvP9As0oIOyXGZ+w7c2Z2yAEWDUHYY0Cz5cpCXNwwawF31iWgs3C8TYYzPfYDZwjbT7He0QLXFdLeAy5cPfcYvbAv9o0kPydfv+ootZJbSpEwfq+95Am7WReuAVgna60/nNzBe/JsJozNVTauBdWSfIz5ZgY+cL1uOwBYi9gJjDee0l2oAvni2c1577B05PPjNIgLKLr+eQmO4NOGSZQS2pkcy7mVmYDM6pRQ1TkYZITMNWYM3r4mKeoCHjHNcNCWf9wwEII7CrNEmb7SmacbcPEKRvKyniC0Cnt3pxasg/Aml5YJPxJ5VwLVW089XHDYmSlIbtPgort0V+9JlbZVKIaFvRAKxym59p0WUDXaDJMRfXlveeiAyGItxy9+BU9G+wyekfguR7ljPmlRRX8upJsrkgg6yImu1KPLZvOUZuG+lb57T1xb6QR5e69+YxxyF9fl8kyccxCqf4CQ18ntBwXCa40GKOTXwIMdqyk7flPRIjCAlZx2Loc413cZbyH45Qo8slgezVLyYbLb0aqXsIN8wXFAajnayHxN4dLJ242SM860Zdk5C9c=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(7696005)(8676002)(9786002)(44832011)(54906003)(186003)(36860700001)(82310400003)(5660300002)(426003)(26005)(336012)(8936002)(70586007)(6916009)(6666004)(70206006)(83380400001)(47076005)(2616005)(2906002)(36756003)(356005)(508600001)(1076003)(7636003)(316002)(36906005)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:35.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a54a7a-dd5c-4dde-5ba7-08d99838a858
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8837
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

