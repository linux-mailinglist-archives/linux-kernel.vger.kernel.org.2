Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A920439121
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhJYI1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:27:07 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:13089
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232106AbhJYI0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkJIB+AljU8FGcDtCrchYynee1vJQ6zaRFfeN2VYssfoqZjlpQJ/88b1t8Te8in7+qLFH8Xj1SQeJL92fKiNYhnk9kx4F6JHt7NfKE/Tx3xYpf07gx68ZZWAU+h8M0NfIaL9ghyKAtOc23uKkotv7Gfa6nikJKd64NZUDPKVTpZIO4paK5dMICFO/Y5nXzOiR6MfxG28/YeHKX738Rem5O1Aff2Ufg0bRxAcDfAXZ0F0IybX/5nXzw/9qrwGI9vljmLlqf5nTjnAxSLKfZQGCJ622S+ipQBsMGkab4k10m8E7ftWf5ijbyIx8coPZRua//fvtelVkhGcLlGKtExvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7pL7vuoMsp2eOHRIqG38HLJzIBtaXdOiw4BWfb+bZ0=;
 b=aXKqq4IAkTA/TlNJSlFD/uY4szeR2/s7HDqxSrw0thi8/ODDEs3pw0jPEaq3epPc5UgIWwhYf2XxtQN2wIVyoxAfziWLrDUinFK7m9SJnbl55tKN+LBcncG3m0yXD1ZaP/paQDVC0gi0vBZJFA23x089FY/VIBpWJKhMIH3M+vJkmpVawQF+AGeHgeWMs8L+QWphMvUs1csRjwEKQQ7fLNcCgb620NKZPC3cSiBnSL2L2ycuwo8GPgd7qTDKZ15EksWPXuHmwX3tG4K5rsBEd5l0qfRe3JzQcQPhHLb/Ei2DWwGI9e0JDBf0ohiw6KptxTKw81HZDigpTidfkRuMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7pL7vuoMsp2eOHRIqG38HLJzIBtaXdOiw4BWfb+bZ0=;
 b=VU0pcByvZqSXZBcW/icekOD/dPBEE/SZ/qbNSzW/Dvnb0asNbLJ0q1AodZaSMpCZXhtfkPfO0ggqlr9xUXPADrOxOWCd9wvnzay6DYKVB/GoyMa3OSe2mCQrdtO1+y7kaU9FgnnnWJ2ybKhohDxESQ0kUaTb5KibhakgWkK9yUo=
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by DM6PR02MB6986.namprd02.prod.outlook.com (2603:10b6:5:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:24:29 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::58) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:24:05 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:24:05 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37006 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mevGz-0003vt-Qm; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 6/6] driver: soc: xilinx: register for power events in zynqmp power driver
Date:   Mon, 25 Oct 2021 01:23:50 -0700
Message-ID: <20211025082350.10881-7-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c00394-43ac-4401-90c2-08d99790dd58
X-MS-TrafficTypeDiagnostic: DM6PR02MB6986:
X-Microsoft-Antispam-PRVS: <DM6PR02MB698677BAC2D60CA6BE001D72A1839@DM6PR02MB6986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9ZVBz+3b7RePcRXyeOPj2g0zCjLaQ2AN5MJGnSXbHqeVlkmX3Dv8QjesFhjeVBtDEhCSnQ73Z/J5E4j6PV+UPme8a9ZJDzjPcG1jrebOWLZq6/wY0oe3Qh1Ot4X83WHLyjwuqZtIZ6EkDrFvy2q16O6qmHiWDWdsSyBhX+oap2mLdul0ezr2MWXLmLAOiLoJoj/eFpKsbkSgtkhWhGenihWedVlg9ruBbaHnJylbehT3iN8yiH7rIW0KXv41R3n4Xj67XV0L1BInhZktJnHDI2ekhKGb/xOJpee+jc4ny46Ez1CNufEgoJoRKZ9Nf7Njk/wMOzuyOvy8XhWwrMAY5dxCqHHYgmMj1C6umiVuOn+CODgsniySOxTgxT6GSDFqiTWSk0n8EfaHBC/0w5DLlOxt8Vgv2NqwENO/Zj0VseVJPuZ9qOOnG1APfdGoYdscdiiMi6dg2aHytdyl0BkeKMlO6cYC65Zd4cYVyfUqtkQySaAFZBFFp+Liq/JMBUDg4p6e19SWABzak56GqZIniPZa7RfsU5DV2pHatdjw+qXmTOe5L00bz3bs70F7FQRlR9rtrWf6LZFgWMkRj5TyYXtMQUYAAC2wIzArFmUsXk4L3g5BQwTOT7jgmAvHfZ5Cudc9viOuZ+l7rmOt45ezJ2DAjvgJ4Z2ziHFf1vG2tSIZ4k3Rev1iZiGstC6qD/0QC8FR+j4+sfMofkiUc1i+mZ4Ty/yV4BBK8VhmVBa464=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(508600001)(36756003)(6916009)(9786002)(83380400001)(6666004)(70586007)(26005)(1076003)(4326008)(8936002)(336012)(44832011)(356005)(82310400003)(36906005)(8676002)(7696005)(5660300002)(186003)(47076005)(70206006)(2616005)(7636003)(36860700001)(426003)(316002)(2906002)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:29.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c00394-43ac-4401-90c2-08d99790dd58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6986
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

