Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2843911D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhJYI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:26:59 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:64210
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232051AbhJYI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akkziMRPqJtEntYDX0b/dn4J7D438iK9cPSDkBW9mmcnFEP1rQ/SmjzqaMdNCtkQMwiu8vHGsNrB/njRlZltNcUynkyeF8QYdPlgbQqxLITHDa+lJPF0grxkgPpMTX90nIoCLOgXn+sZWSbgcAI6k0lmEOn7Q2t8oEluGykCVAXDpUEpJmgSuwgy2yhJwqH+yN3/WiFpzTdWdcC9Hr1XzARkIBaD70buuSYXC/mmqP7k2JIT7K9fR+lqs7xTj7grQzkNRHspImJtmPzKeEP4AAlXNDR05jodIie5lRcsgrGI24o07OYJ2JzIWwePnKLUK8P9oV5L3nVecId+hCahAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM9emv0lTyFOrIqaDjft5PsTbF5ugxOuiYrM6PXVbwE=;
 b=VzFkhPD1V7zgmtu1v7NdheKO7s9PgLWbFjKMlFRIpMQ+kZ+yxUdMs5F2PJPbtU54p/E3T8eDLthVj553u0La0ZaXSr6rFUlugXQ0oGCrm9m/5Hm8mI7HYSCBn4BZbfG1CfOvY1qdDuf5JAIPNXCawOJMjPmXfIOn+dCTNtS2atrXmXrjiB4eQyPcQ6591m1UJtYLngKthRGixG+m8CjonK5aZ4UAVY4pa6eyKkWCZY+NuO/TEWfjJ4nmdSpSG30nRjIjqyPfNejrvWmS58DaHP6+Zl7qpyso2DKtA6ldw5NnBDrflh6/ELygCIE0ds1swUT6saECCdBbkBQ6GPnB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM9emv0lTyFOrIqaDjft5PsTbF5ugxOuiYrM6PXVbwE=;
 b=BYQuQP4aKhQy0tfl4+G3b6MJe3zvGD3rbwgzhKjmugF/AO+4CBN+PTRSeFbJRNy/LX+PZZTB1f1Ws6yaSib3mX/n0PvXsd/hODH3C6xlsCF+bEGzG+6HFGdSwJAVeIINACQjhTqW6TTl46tCquj9u7lyJwFBLpjfPGk4XnQE+6g=
Received: from SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::19)
 by SN6PR02MB5055.namprd02.prod.outlook.com (2603:10b6:805:67::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:24:26 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::2a) by SA9P221CA0014.outlook.office365.com
 (2603:10b6:806:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:26 +0000
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
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:25 +0000
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
        id 1mevGz-0003vt-Jn; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp firmware
Date:   Mon, 25 Oct 2021 01:23:45 -0700
Message-ID: <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d9792a3-6b91-4b0c-1e35-08d99790db0e
X-MS-TrafficTypeDiagnostic: SN6PR02MB5055:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5055DD5E983F03B17FC6D22FA1839@SN6PR02MB5055.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6x0vL0NSVYknE1UJWsLUzlQYI/r+GBUhlh+ApWNp1ZTuazaqQNSxN4XsRK384Ch+Ul3zhakr9wwkIivZRp/pEnJBMSqPdVJKAE7MislCeuX/ytBJmFVkjfOycHfeiRhQmyai5rgy00P37W0SLoRhdkeqYUUJBTe1VmgvpvXPtYGfD7j7ym4uW14dGTvdHkuoiZhqcxKZkxvqQYNz3/qTF9VqBwFLm9zN1A6lQpKORIZR8rVun7KJwGn+XNPis9qCLl7ip7gr5FRp82a2gc1MASm8cP1lqUFHtg98G0B6WL2+3502SZ8wMm3c5XLb9rCWjnEQeIqWTHstrrfVA6aZ01ue5S7gOMpuA/OMW6TvpPaGwUVyUWS0bJ4KBx4zbXBgpmYcUAe9Ivco+BOPYc9nv6ay4lX2F8o7XSrpZiRCIE3b98LcTVTWxkKi3BEojuMl6NQlguiZjL9IqeJJGbNosIIrWvYTVpZTGBviKu4P60/UfeTpr4+F68XWsmwgtwmYxW63KynTk50UYIDcJQZ1IHP7WxdBf9/AxV5vBfHLQYFNo79NmDIrQjpscgfZ94WksujCUbCi1JYVbNBEiRZCWEbP+PYVV/axA1AiJqpYr4x7auYBbbK/U6y8Yc16inyXTv2ogPSiXIHha5Byj69h4dGrcJ91hgWmeNAH1Z+2qVdqaLDElzYMmeF3GvOChLSs6lQxue4uAgZuU/VecjkOEn4sGihR2RApUnNWSkF9xw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(47076005)(356005)(7636003)(186003)(82310400003)(508600001)(26005)(336012)(426003)(2616005)(70206006)(70586007)(4326008)(5660300002)(36860700001)(9786002)(7696005)(6916009)(83380400001)(54906003)(1076003)(36756003)(107886003)(6666004)(8936002)(2906002)(8676002)(316002)(36906005)(44832011)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:25.5046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9792a3-6b91-4b0c-1e35-08d99790db0e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zynqmp-firmware, register notifier is not supported, add support of
register notifier in zynqmp-firmware.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v6:
- Minor fix

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

