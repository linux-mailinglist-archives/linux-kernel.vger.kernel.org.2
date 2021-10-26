Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125C43AB47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhJZE2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:28:01 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:43840
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231963AbhJZE14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6Y7vuWesYdbiQJaP+U7OTJQrqHmzyXxH65qPoen2UNn5v4v+s6irh/au4053RJexsbEafETNM10vERkknjpY7bCx47BAaA6GrJCs4L0RNsnlV8aPbew9EdFISdvEzB9OC/MDTnuM5Ch48bE0rLSLHpVM3APat7URh6NY5ruw4mvCU9e90vgfLo2IuQqcnDJlgeNfJd2vZyDMy1Hh4ubBpf68DhPNCw5nGUMYsBncNPYDFlw7aAWey7Mev3UgZ0g+EvkqbjE3MDijR6MfU31GwBpfWLYoum2lNm/zJGO0xEyPNjcKthSRZZKuqp6y9MZh1CumAGsxVH2DTxHVQ358w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUU7bqRqMbkaq6QA/SMMFc0rQkuINkmGELqkhSan2P0=;
 b=Pits0VFpkpnGtnoPdKkgfzb/YYDmPR8WjelPfWVlJtTIX2WO4HEGcr5B+ol7lQZaTBRK7dRCv3do5tWt4WaZsNugj505k1ou9bWzAwTLkkf0oaRSPmkeJaWgmFkc2tnKWGdma6E3PZqI7vqFxMFJNJ80hytW3IPzTTxZuxxN/0kz2x1FIofeaja2L2jMLN0k7CUwvnoBaWQW9D7iGNL+pS2alO74K6nLntbaZIF2IW//D2UZR6DwnhsYOktWs6PN3caHHrSOWsnlWpEqc0dGGoys6QLECWT+0LLSBEQl5WSSbpAgsqfJvC+1mY8tDnxps6EXw1sI41nadjfRzVbHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUU7bqRqMbkaq6QA/SMMFc0rQkuINkmGELqkhSan2P0=;
 b=C+1vXQ+2UVxS91SFwXU11+Ani/lOFiU+ta3O4BtzOB12GZq3OkrJ1zwQOp6fWSch0cRfSFuz+bSyE055BTDbRnmqwpKKe23FHwKzEn4d50K9l04r1ewzNgFtVdJtNkxMeAVCNBDhQRw6KZRdYQKbOF+qHfnsDjiJ9+fWZn5SnOU=
Received: from DM5PR18CA0060.namprd18.prod.outlook.com (2603:10b6:3:22::22) by
 BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 04:25:31 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::fe) by DM5PR18CA0060.outlook.office365.com
 (2603:10b6:3:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
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
        id 1mfE1i-0006GH-Qg; Mon, 25 Oct 2021 21:25:30 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH v7 1/6] firmware: xilinx: add register notifier in zynqmp firmware
Date:   Mon, 25 Oct 2021 21:25:20 -0700
Message-ID: <20211026042525.26612-2-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b38a0e4-bc44-4475-951a-08d99838a5aa
X-MS-TrafficTypeDiagnostic: BL3PR02MB7986:
X-Microsoft-Antispam-PRVS: <BL3PR02MB798688DBC5EAEB98A222DD5EA1849@BL3PR02MB7986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXafSzrQ0AX9IvRATWCZ0Qv7Q1An1GKQv/3rz2csewT4pkEI1zxZknWbOtbogUnx8dwDoRn7DfNqVCCUIcAhX3qR7DTre7O2AlWVXuMY53nS06jjuwbMKuEQztR3itwN2eoavGRBvaCIUq4Lfme7fmsdluNuH61Ud0nhHOeWLEM/mXVhZDmlxDAhx630/sUfyvRMZGekleF/0vzLCK1zU24AH6AxcMK8PfOaUvIH33AxpqaUu1U/RcBTxKzTJd86kJRe0VdUMTasKAVbqIizt7sqgnQwCYZgGwEy2PzTRgs+XVUHL8w06hQ8lb2PWn4Uxlc7/ncFqyObSnw0HYT92fGVSSvVmrmyvfCfUREnU9+aNQKUqidwro1CYnhwJxB4wVLrvAh8kQJunx+jJ1bRAErOESv+yG1pIPqSD8scA+o25ru5SNeDiObMGlwQtAEOKB23Sg15bzJzYpnHfi2xekxcLpX97LIgONSmwTSgXKb9tnyAoNwGPduGa4IDXkBgx+I+rmL6gWguaDLxeWZWq3vSFuXiV7hI9+OevBi5LR2g1RKRBAzj/zfJGWkpkH1mLCgcEM23xh3lVFnXbwKQNyu4bL5GZBx2bBIvFatNfQwaCxsHAJrbIxLDKkUOq16tCbbVcidYtSJ/70Piz9QrqEBmraOGq3UX4wjdHuV874BoDfTKF1AJI+Dwge+k0XE/w7vk9s3fxhJ19h6GXVVE0DXMX1PsrF9PfZpVOPqSJKo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(336012)(26005)(5660300002)(8936002)(54906003)(2906002)(9786002)(8676002)(426003)(186003)(7696005)(2616005)(82310400003)(47076005)(316002)(1076003)(44832011)(7636003)(70206006)(6666004)(70586007)(36756003)(83380400001)(4326008)(36860700001)(107886003)(356005)(508600001)(6916009)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:31.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b38a0e4-bc44-4475-951a-08d99838a5aa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zynqmp-firmware, register notifier is not supported, add support of
register notifier in zynqmp-firmware.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v7:
- Update the version history.

Changes in v6:
- The body of the zynqmp_pm_load_pdi was missing in v5 due to force merge
  during rebase and getting compilation failure when Xilinx Event management
  driver is disabled. So, add/correct the line of code missing.

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
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 56b426fe020c..96aaadc44c3f 100644
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
@@ -632,6 +635,12 @@ static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
+					      const u32 wake, const u32 enable)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.32.0.93.g670b81a

