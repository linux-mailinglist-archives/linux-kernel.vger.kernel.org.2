Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0655F43AB48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhJZE2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:28:03 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:40640
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231964AbhJZE14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYuuYUOX5T3Q/OWBROXrCdVBNRfI1ZDrKVgT6VYDSzfH7T+u6743LbsCsCytUhrgNXH5eXeas7GAORSz8MX8zgtrffsZxcEOZ0h8j+wsYvP+pI4bkQ4p1XBo65+V3Icne+fM6Pd4NOE71RiJwswR42woZ5bW/TK96GXad3MeEeCKMGmf9VnfE/IaDKkpDTr+BS4AxJKzvAFIHqvweVgrAcqqD6YOZtz9qG8OOd3Pd+g9FAQWdB6BHmz7G1z+tt/A/uP0vL+vAFJAQkWCwNfSht+5UwRXVhTqzU2wl7EI8brAnmWyH9MjSx7Sd+VMobMeOqf7Oq2hZS0KkFUbrkcXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0+R01gxV5QCEyJD+P9u8HNiawBb/t5oQALHcgchXKI=;
 b=G6v3u+UiVvfFyChVj2lE3ilLSnYnyVwgRs0reo1fc8pEt2hzAsOU8W5PgwCaJ63Zn+XS9+TaY3gnqkrzlk+IgKhJ/lvY+1tQC2D0rYSoUyCE5Mmm2E9giru/C211x73N1ITMed2a4lr9FHFPrNQd8+R8wMkzKDEM6XEgcXNotbJyCIajJiaeDsSUmyWOGiX+yTK3L3c8CTsMohPx3Yw0z9NcXXEC4tyYkx7Ec+YLzOV2tmRhBYYI/CgU1TgbE6CeS5Oh3XvUFFhI8s7+hl37PYyXRhQMgHxUiUefjE5fp6BJezdyu7lNidMeeAh9Tu9XQGo57BSmxzfLmADj6byr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0+R01gxV5QCEyJD+P9u8HNiawBb/t5oQALHcgchXKI=;
 b=SjoeaI/ZnhjEyIjjMp9qLdSB4cUEb6MbRR02kSix/7BOXN7yPCdKqSSy0/L1CYthslfyc0IBA7NYb0Z7/N+Jtb8UmkkuffjQs7gBsDVBk5H8g/1J440KSJhRBlGT5X1SlmvzPkF126enCvAFSgiuqWoviOLprMXWmeGLm9P7DyQ=
Received: from DM5PR08CA0042.namprd08.prod.outlook.com (2603:10b6:4:60::31) by
 BL0PR02MB5507.namprd02.prod.outlook.com (2603:10b6:208:88::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 04:25:32 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::3) by DM5PR08CA0042.outlook.office365.com
 (2603:10b6:4:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:32 +0000
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
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 21:25:30 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 21:25:30 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37440 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mfE1i-0006GH-Ri; Mon, 25 Oct 2021 21:25:30 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 2/6] firmware: xilinx: add macros of node ids for error event
Date:   Mon, 25 Oct 2021 21:25:21 -0700
Message-ID: <20211026042525.26612-3-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93e697d-10ad-4155-a3ef-08d99838a602
X-MS-TrafficTypeDiagnostic: BL0PR02MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR02MB55072DBF79DAF22C692B7FDDA1849@BL0PR02MB5507.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZqWTPz5CtJS5Xoi0MrBe4IDOVWlTaCQcrmKNM3DEIzEemYJJJtNuNMbHiddr0dmtp+AVMXsRJNZNgIPQ+TBLVuk6M1V1q5tYg59wU8YX+4D5Gb5D57jVrlFlxiZtZ0h+1fvUz5BhO3a2usq7nDO4Wa71hrEs9EdfSVs8fz0ArKbM8dRi7fcLH/FJKoXBt/JnCKY/N+G+HLgXFSuEXdRLAWNfjZk1lyQaVsNAEjXLgKaF5Vz+/NHEidA9MCeRuI/OZj6TofNuw2qSmLdWqhFk/gxTmLBP4JtSnOCbiyxCUhYxZkv9sYmtcaWhWACMj9FdxiUI5U6VOdGrjuxXs39lz1H5koWGfwpbasTsAmsFTLww/H9SNzZURbYWx0DL+cXo4xKWaFJ0Sl9e3zzBcfPL357IHABfeNtJIq6d2Sg/R5w1LgERIYtcKwzbWtK2Z8ufRx2CKWj40NqdQMRt4d+bCP29nQtg9MoyFiirr2ziqBv5DXQyNtl4CiikS2IOzdH8JU8BfTV8Y3FPgHxgzJoYy6n/k+uiQOGHlTiBkBBwBmIdMw1P+9M3pxNxfpzQNh+ISW1bASnEH3JhQDlZOTh/gFkaCtjBzYCtnzomlhBQw+1F6TT3QM2lS5SU/ZbupHvHv8Uhb96EyIdij2Ep6v0BOvLUHV6QMgfBa5Hvd4qaIHFcFPKukj8HxUqMGhcSHUuELPYokIE1p6GYBWF8GksyPZtMxiTHwZYo7AMruEGmKM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(316002)(5660300002)(8676002)(83380400001)(54906003)(36906005)(82310400003)(70206006)(7636003)(7696005)(44832011)(8936002)(70586007)(1076003)(36860700001)(426003)(36756003)(2616005)(47076005)(6666004)(26005)(9786002)(508600001)(6916009)(356005)(186003)(4326008)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:31.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93e697d-10ad-4155-a3ef-08d99838a602
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros for the Node-Id of Error events.

Move supported api callback ids from zynqmp-power to zynqmp-firmware.

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
- As per review comment add PM_ACKNOWLEDGE_CB in pm_api_cb_id
---
 drivers/soc/xilinx/zynqmp_power.c    |  6 ------
 include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c556623dae02..76478fe2301f 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -46,12 +46,6 @@ static const char *const suspend_modes[] = {
 
 static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
 
-enum pm_api_cb_id {
-	PM_INIT_SUSPEND_CB = 30,
-	PM_ACKNOWLEDGE_CB,
-	PM_NOTIFY_CB,
-};
-
 static void zynqmp_pm_get_callback_data(u32 *buf)
 {
 	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 96aaadc44c3f..bfd87ae35b2c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -64,6 +64,20 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/*
+ * Node IDs for the Error Events.
+ */
+#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
+#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB = 31,
+	PM_NOTIFY_CB = 32,
+};
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
-- 
2.32.0.93.g670b81a

