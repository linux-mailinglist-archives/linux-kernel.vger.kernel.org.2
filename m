Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9937A436352
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhJUNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:19 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:17440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230484AbhJUNtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpYJcSiQK4TU4IGLo0ADx8n4m0PvhcipyFy1uVIu7OWRoFrptYBp4LYW3I10j4VLYqLrbDfEWC5B+rrquLkubb4NKnTOIp0zGu89+R6XkhvAE7x4MDNZI+iJ6LF7czMfJEIQ+5TUn9sjl9O9UR++ad1xjOnpvWEylglTeZ/6kGJbg+JBnbi0RfuNOfpIOK3gRK5vSve7DHpOkHivj3ggAkT88m6SPtCZ8CdLd6tsh5FiGv1A4FhfkjG/shU52haNr8RWbyoBQ/Yb8CGH6hnlAFi/WHSEYBvfsxOYkH8ZjCTtndfRdvCBhG8+OvlXG4HWLc9zo7919uOJESa8WDqU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=539tsPPOK8fA0dr0lNHHYQGjZ1E+m/ibmzFl3NJnpk4=;
 b=CdpO5jHcekxW3zgu/aqEQGBIhimvvmlreQUbctErV7K0IrTZvU++5dvfNzeMFkLgiE/V5FB9nn2M3qF8A0wV/58ArPxDX4ScUZxQq+hGwM875QDmOEkmMxmnze0fCoL4jXqQUbDjQA3aevV+ydeIOwGLTbTyiyVuKYCSNnJwUQg4NPWv982Ut1erAHK36QPPFZxjpke6BTdUuOJla2GwmHKAQzxkUsjMAxUi4uI/KYBgi50D6FTo40A84RmYgqIl0b47pkeYq2eC/I9sjXxtI4PNDJoHNs7dEUoJS8KVWRNx2RDJFsu5SK0sAJoutxCI33ooFKTud5OXaL0gdPsggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=539tsPPOK8fA0dr0lNHHYQGjZ1E+m/ibmzFl3NJnpk4=;
 b=SDNrhFEo6fplykgZATV6cbkWuI5jmVHchzvYBFRhxx237F7CtAJgilRhel3NhUH+Ss7jpSV78n2CwFRsk/tsBtJ+nXNcfRLQdkdE53jfsqF6hGbcTSHHmwLFFTHT3dJ6dfg3QCxcWn2SKNkuglyJUKc1NrMXkVGXcmaQBos0t7g=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 MWHPR02MB2750.namprd02.prod.outlook.com (2603:10b6:300:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 13:46:56 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::87) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 13:46:56 +0000
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
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:46:56 +0000
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
        id 1mdYPF-0006R3-Uc; Thu, 21 Oct 2021 06:46:53 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/6] firmware: xilinx: add macros of node ids for error event
Date:   Thu, 21 Oct 2021 06:46:40 -0700
Message-ID: <20211021134644.14407-3-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39ab396a-8e8b-404f-26c7-08d994993f3d
X-MS-TrafficTypeDiagnostic: MWHPR02MB2750:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2750238ACF8B7BBF09C7DCEEA1BF9@MWHPR02MB2750.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYah5TWugNUsSfLlXQddYmiX3/AwB4cJIyEV6dAVp/koMk/XM7NalTzYwKKrhQc545fB9jkDotaKWg+KLEsZxYWf7BrT1ZFXwO5ylCbCVu2wEfnQ7EhPzRtrQH8oON/UoYlTNKWnaM/aIsEh8VN7L6YgbqTip/v0/QnDGrNXuKOY4AnDkHqTOfPyy0Yz2TlVMmv3HaoegjU/hHquA0sYOZAysg5F91okUJd01qLLRhB3xxMtTWllKAYFV/6w6CehdWfIyYuayoaqhNOuOubyEa80LeYagp1HIGIcwlG49GV5EE2SCxEXvqyi2C87Oee8eywJyiyHV+d7rPz/zoJPVThF1KRCYZsKgkQnkeI5v4JJAHxxL3w+AXp4p5viiVZQEedxMsrI1o+tiILZ1DC8bp+zDdeE2+hMIpQVru4BNb/0Rq4O7gogkE2Vk2g4aCBFdTMuhdoKLkKoXvTkKmbysnST/edpfTaFGwz5Tnka+orfjZu3+98T7qSYseUfRclXJLjKtHoIbAdvGhFG/SBXokkpGJG+eb40sfJ3p1ATLT97SrXQT9R05q7bivJUw8vNDfq5ZuqnBPA/U/WGjUpRd7Uth4sohgPMChA9WjQhiHRFqkYJksQwKZzJu5Iz2C9H4R8VpGrQZpDisG8wqIW42KwX4dIGxBxzwWy3RXKW2H9IloOn4vD2ASoLoGiqH5ufY05h+FuC9GukbLcs9UYmQNd8oLkRrRd0H0DxEOsAXtc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(8936002)(8676002)(36906005)(54906003)(316002)(70206006)(70586007)(508600001)(6666004)(9786002)(36756003)(36860700001)(2906002)(4326008)(5660300002)(426003)(7696005)(1076003)(26005)(186003)(83380400001)(2616005)(336012)(82310400003)(44832011)(6916009)(356005)(7636003)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:46:56.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ab396a-8e8b-404f-26c7-08d994993f3d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros for the Node-Id of Error events.

Move supported api callback ids from zynqmp-power to zynqmp-firmware.

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
index d71377063cd2..aa9c6574eb66 100644
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

