Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1238A439120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJYI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:27:02 -0400
Received: from mail-dm6nam08on2051.outbound.protection.outlook.com ([40.107.102.51]:56091
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232093AbhJYI0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th/boPkkHvrjLU0qaJIqUDXLa2X77RBJxDyP9y0gAJUN7RDdXUF7+mUwlN2+v1jd/bjAPxogUrazGLAdlMlatYX3xSAdo9udMDz6qwu00T6Y6RkvD1C6f2vmdzb+cE4NlNikfxB6+2ZoN4vsTr8AbSsShg4pMtUzcQFQYsKi/Z8ejRCJdpn4xP/i7GimGQMH6+HfbTw3x6prWIwFyJnK/iBSAR4kTZ/Uihc6zzkokvoFTWY5yDBs0hukiOw52Kq07/BLS/WbKV5UVjb4iodaIZzi6fN2SkpHNpBHI7g9moYU1yMUfbDfRWwQuV9k0dz//plL2PHhkESWufRIErsUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnkOKf8hsBMX61WrQq4DkGdqC/cZzEx9c5yxRkS9ZQg=;
 b=glZoWakPxSWtU4+x2lLrhDRBDT4HEbt7i9tGfkpkl6HVY/ADBZI0yZOnpUJELEhlKaOYrP0uNyHfmC54/vMisd9Do7kYneQQXdu+xJYy+Zo/UE7OiAsMyZ+9KAJYHG5eSZ44BsIC4NJYWRtaphxHV6yNYJ67aWr0Njid5bzhHvkuHPA277Ac0eGbdehIS0y0aK5ErGs4Q4EjnjWDVOn75kcj2rRTToLCi2drMq20L9toWJs33tBcxMrPT6hQCOAaGadPBjA8z51wvvoyWM0u7LU8ZpDvose4p3tUrAaWIBSGt8An2QcggY4ou5MYUaeZYYNX+TkyJkYQt5L1bV29WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnkOKf8hsBMX61WrQq4DkGdqC/cZzEx9c5yxRkS9ZQg=;
 b=TQv/Ooaonbz4TFp/pRAyyrZE8IO+cLPpCCHfD8HpNrO//ZEq5dhtwJ9X9UGRakIEypv12v5IEcoptKpzkaxoGaA+V6DWwq0ozzBezrsV1V82ttGcyzMi8ncJYPWJJj0PLwl0uuZkVpml+qNtX8pOjfQa524la6UP1H73hZifbkA=
Received: from SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32)
 by BL0PR02MB4611.namprd02.prod.outlook.com (2603:10b6:208:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:24:28 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::33) by SA9P221CA0027.outlook.office365.com
 (2603:10b6:806:25::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:28 +0000
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
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:27 +0000
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
        id 1mevGz-0003vt-Lu; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 3/6] firmware: xilinx: export the feature check of zynqmp firmware
Date:   Mon, 25 Oct 2021 01:23:47 -0700
Message-ID: <20211025082350.10881-4-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce0ed3a4-8cfd-420f-cd4c-08d99790dc5f
X-MS-TrafficTypeDiagnostic: BL0PR02MB4611:
X-Microsoft-Antispam-PRVS: <BL0PR02MB461198A10942E48F6332DF97A1839@BL0PR02MB4611.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PQastSADCfB63N+QBrkX2yzsgZw1TPKKNmxWQcYuD3cZYliK5PCSMmz6QLTHKXwnSgzpXT29nIBwFr4svxQ9BNpOEwoBAW/Ig5SB6hBvZczFfZ1UWSC4bHt2vashg/NiVmxBkcHBqJAmsdgLUjUIZc5RW+hx9hF7w5KSpAzw/LH+W29fKDzCDU9MKy1BuTxtiNrwHPP7xR4Vla1niRXcAEsKITeLnTO0BaxbhGzJ4bcIeAzVD1OvANJ4kKoYh5eAX7+lpGKz2yUvE6UbG6P2Yf6XXkRyVj+wD47+zhfEI0ggeIjHxSeNu7Ao3QN1THD/Piwdz/dRkx/Ws4MOVTTSSCnG10l3xl1hPXMSSeAu3Xri8o7mQdOQCs8JZoxdJyOcyt2uMa6ytezyLpju3eLfevb+/7Q+PKJ4RYqVrz3sUrxDHtG+ayhyMDKNsxBWWZppQbM74GOOteHpht9sOVFgZ3PLF5Xfb9vpE7Z4Ep4GzIB4IXKAcPio8jyvEYwvBqgv4cu/1BEdPmWSFykGSVZDgZVjkRNMjQE8erFhMLnilsh+SBvr3Sq/Yz1HFOlTsNyTjU7cVJkaeTCoFrK6CoYoQowd8uNGySM8TUgRKi04Dclq9iK6CCgvDQPXlvX2ODlAUm7p9+DrY5+x5yMSQmIzmxsDeuXF1NQ+WhKZYajCrAIAYgXSVAFdaB7hwhDz/KzLw7G12u0js6CMi96PIY0GH7O8tKNR1hzj9/VAG81AOQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(356005)(7636003)(70206006)(7696005)(4326008)(36906005)(36756003)(47076005)(9786002)(336012)(426003)(508600001)(8936002)(2616005)(82310400003)(36860700001)(1076003)(8676002)(83380400001)(26005)(5660300002)(186003)(70586007)(6666004)(6916009)(316002)(44832011)(54906003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:27.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0ed3a4-8cfd-420f-cd4c-08d99790dc5f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4611
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the zynqmp_pm_feature(), so it can be use by other as to get API
version available in firmware.

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
 drivers/firmware/xilinx/zynqmp.c     | 3 ++-
 include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 6e653e9cea2d..e2c55f48b93d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -153,7 +153,7 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_feature(u32 api_id)
+int zynqmp_pm_feature(const u32 api_id)
 {
 	int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
@@ -190,6 +190,7 @@ static int zynqmp_pm_feature(u32 api_id)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
 
 /**
  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bfd87ae35b2c..591bdbb4290e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -433,6 +433,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable);
+int zynqmp_pm_feature(const u32 api_id);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -655,6 +656,11 @@ static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_feature(const u32 api_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.32.0.93.g670b81a

