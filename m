Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BB43911B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhJYI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:26:45 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:20803
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231959AbhJYI0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYYCRMobKmxXmikJZZXzeIODuq6+46LT090eUzfStUT02J5VirGLFuGRMwXyaHVoTXBwix3hGedr1GNksPmWBkEqkyP3vdI58vHlfxEuLDOoSovdG7ZztaBWPzhQsdyj0wP3GM+zYKGBIymLrP3OfcQyk41QkZfxVHZV0schQIryuQwiYS3+H4X5qHgzXvrRqZac/BtT/0rzBf88qtatfBu3tYu1Hqe42u9emzi8S8661Plz/xNRcK9j2H/F/L9fV6XI8qbPxuCAviMVyUYci5FmDc9CyaOnl5ywyXH0d44pdvYyIDQv58lNdelfKNJUDBk17EWYE8RPIonu300Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXr7MBlef96wSbs7/CeJMH/h9JL72sRfrYbRMfuxWYg=;
 b=Te3yV045IeM3UqcROTAIEiIhejdOB38B11GBbyPw5CmK6h4ypyFwDV/GthJWMtYu9U5Tv0wxrX26YV9ZO+9H/b/jTvbk9YqqLdVId+dS2qp819y6XNs4uBR79GODaHUAdG+fPu0kOzTnqepMOzNvx5AumrEB1twyQxAcGzinc7tYXFTQy3JKvTx8ElB4XrTGTfNwQzis30ZdpcOgWB2e+JFHC1qxjzmcHFiwhcd54liwXdArEbv/P3XC016S0SEjJHD5iSkkgUM1H3WA5qdBMEORx91Pft1C+EYFj3zuZjgZvikby1a56IUhXvVhnnVofW9pTbe1UlD6g+H02TA0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXr7MBlef96wSbs7/CeJMH/h9JL72sRfrYbRMfuxWYg=;
 b=dQbA2cEi/2r4TB9bg2BEDnONCCLBLJery1MKhcIzXuSW9lKZvH61QKOdghsHuw/UQVea3Q5nYDUjRBc6q/thQ74WZq2PuMDdbtHuavcw8lQeRWry+pELLV2GAczriY2S4FNIwAn8lD40MF+FgWc+HAPuGYxtM9oB8wTckzFj5K4=
Received: from SN7PR04CA0176.namprd04.prod.outlook.com (2603:10b6:806:125::31)
 by CH2PR02MB6837.namprd02.prod.outlook.com (2603:10b6:610:ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 08:24:12 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::4c) by SN7PR04CA0176.outlook.office365.com
 (2603:10b6:806:125::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:24:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:24:01 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37006 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mevGz-0003vt-Kt; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 2/6] firmware: xilinx: add macros of node ids for error event
Date:   Mon, 25 Oct 2021 01:23:46 -0700
Message-ID: <20211025082350.10881-3-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b973f6e-b4b6-44fc-3788-08d99790d2cd
X-MS-TrafficTypeDiagnostic: CH2PR02MB6837:
X-Microsoft-Antispam-PRVS: <CH2PR02MB68376031D84F9E09695A2ED0A1839@CH2PR02MB6837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: af/Z98ozOnk2bXN9ZcrJ5dQQeCqCMnYnEgFKfsoeUxPvPn7JQxtq7IpO9iuD5b7cOkFSd/TQEFNdDadMtUYqGs0ccQOTp5+YGldy/xkMpXaUyo/FK12XYqV9LnKHLgWDY5PySydKYv9ExUDsaH3MJpA3shREc0PVNF7SZFbMUF+xoaCQ8mp+/zjnBxHQ6q4ASKLAHdy8Z21/slkXyICkxOOlgP11AFpUfibhP6emDFKQKhtYNweNPjXVsy4ms359DZWGjmyP3/2LNO+Qm+lAM68oZ/x+rAYgvNYyO/dRrrUN7f+sdbQwlZbIDZ9fWK9Gm7lcIsBmVbse7+rsizBVvOG/ko+KXzn3XcUm5q57QoT1EWzmyutPHg8QlVsXLyFt/GYuTXeimOVRjE8yQqh1SIk8s8croI4zQjnGgOJEt9eMm0zkOOXhSSumyWkQGcp3lOj21/JsAyQcP/RkjXXrLN2mPac54QI4bBbObRSSwyXaekvEjaAfz5A2tAg4n2etXe5FKMVMLjDcrHzicmPp3Ilqrxt3pofA7OgEVV64ORdzNXxsy/m/pTqHNy/L++rSuV6Jg7Ewgwptu3dX2OZLL7wHAisnO3uOx1ZWrEApofqjVw8WTw1Ii76oE700L8+ofhG5yTCS87LnWxUah41d8Ydv8Rb3C9ye+GtghqUk30c8m+JQPaBMBxUgWA2iEDFCZumjhl2VbmXp8ALI2lMnlSQ5WJev+Eff5NEob0tGOLE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(8936002)(1076003)(5660300002)(36756003)(4326008)(2906002)(336012)(44832011)(8676002)(6666004)(82310400003)(508600001)(2616005)(356005)(26005)(186003)(6916009)(7696005)(83380400001)(7636003)(426003)(316002)(36906005)(70586007)(47076005)(54906003)(70206006)(9786002)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:11.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b973f6e-b4b6-44fc-3788-08d99790d2cd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros for the Node-Id of Error events.

Move supported api callback ids from zynqmp-power to zynqmp-firmware.

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

