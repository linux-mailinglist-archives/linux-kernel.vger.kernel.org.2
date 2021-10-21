Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502A0436351
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhJUNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:16 -0400
Received: from mail-bn1nam07on2042.outbound.protection.outlook.com ([40.107.212.42]:57060
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbhJUNtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9nZq0g8Pgg6e6+TUR4NhCsmN+QAYQfvnLazks7aM7ImYHXlbOBdrlQBST0wwNY9Ej9OgoUZReoWqrY6cyOjSVuCx19rPOY8IsF9UvB+ooxyh+L/revDl+WHqkSVKU66gqwJ3vzL8/5eNLIKOrcjI5yzJYXJdwYZEao3JoGT3/WYK/wg3ZOu6079msCJsye6MIjY3l7cNJelZhIcXbjWx0KEsEmspHqWHfrVEK/YkNZ+jwQbMw+pJwWpGjbqCLuj6Or9r85WX5Hqmzov44S6UWMJvzLWnJbJRJI24uEQ2E2ArS1CAhD70ojL13mncT1StUpDaE1Qkjbk+Z8Yx/MNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzzQjEOlmW24aVsu0m68oh6DCOfn4gYDcwjD87BQxqo=;
 b=LXLVAFMCH3T2Ru2tGEO23LHnv/xS5j/NjWv+K7P5mWF+VfgzUVWr7oNGovTo1FGZgXFcPRnSPbuPdUzg3bR/e/zvksdwTAnh0vOHVkG4iCfs09s/d0Me3/Z86sYIRq6O6SOQtRh9aD5JhykOfhfVL//t8Tr3u5nTE4k2e6SaKU5QI85gdd2ePDN6PNRUYFH20e2Duei0W+VSYdQAA8aRDENigUANKJ3ic+3VfJXeKYtR4vxoLqwNO8sYrFYyPZzwjThWYM1kid1U1JKJegR45q8QdtBlwVGAeBOGxHKM5b2RGNYKLlNQQKGrvOqtglBTlvwVfgqyQ3UHYyUFUwqwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzzQjEOlmW24aVsu0m68oh6DCOfn4gYDcwjD87BQxqo=;
 b=FyOQ9/x+iQHhqf/N0JENs2j6I2DJn+nl4Se3AM7wJSvt3UplQVBymaOclOtu6kZ43J2tuyn716NmDbxzs/yIf2L037kPAR6sGKNQvMrtqbReH9tw4h85DFNYlPp8NN5QxRDl+9WQD28XoafNp14Hrf3oGUhhFrGs/EIeBVZWoLA=
Received: from DM5PR12CA0066.namprd12.prod.outlook.com (2603:10b6:3:103::28)
 by SN4PR0201MB3616.namprd02.prod.outlook.com (2603:10b6:803:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 13:46:56 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::4a) by DM5PR12CA0066.outlook.office365.com
 (2603:10b6:3:103::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 13:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:46:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1mdYPF-0006R3-VZ; Thu, 21 Oct 2021 06:46:53 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/6] firmware: xilinx: export the feature check of zynqmp firmware
Date:   Thu, 21 Oct 2021 06:46:41 -0700
Message-ID: <20211021134644.14407-4-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2321389-bf91-4890-7f4a-08d994993ef0
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3616:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB36169EABC82F9BCAE7160093A1BF9@SN4PR0201MB3616.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZhX9zfhHvFlcGuE1qfFFKz2CuUJHkx47DnjrDBnqPczjySArPHtepB5c6O2Oy4FOeWrAylBJ0wSXhH+D6bS6b2lwrLnoPQVo/awm13ajvO2n0gWlQx9LoZCbrVOWW4hQ1Wt7Q/mm4pVzqeCB1eSqVDvn3cF75FoiL05MKI9/2/qLb6NR7n27KGzo0yocR7k61TwZSJsnCQb/OBIxoWoeknbv/uPjOv9BCyfiIPW0zkfOcegMiCwRN5Bq9AkPLOGOskV3IIO+UiOQKvCTFtOtmPsmVU+A50H/gEuz2XTl2kYlQAllnSm3T/5lhkYs0E3lctd7/zGgUNshV95RhBzZiuDlFIA6QzWHITVTv44+oheq1K4u4Yhy0Lmv/lEEYF28Kp3h4qopT+MSbIdRZRSK8FB1sxJM2K8DiKguTri4cdFs1a/8+XNbQMfcAgFfufDx3W0FnA0wKLS1I25gpnOCywLiThUqSp5L67yRpf2wVinvVqVBOznvoBiiJOKYs9VJ5rdbCkHxjWdp4F3tb+VY1nbRvPn9Jkx4rLg7CCkb7MorXdvwacZXaz7Gg2upT7wz4KstmJ2xhAA8aOp3iIlYFeKWJ4lXx5AGEyCncXdMaLgPJxdQ/+zwV1T/KrEHuP1wgq7A/YzOIfevrpFWgVte1R9F0O8fghHrbcBl+5PT5tWIVcwvlOeK2g6Ac8uiz1yDZZKtSpvC0mX/oZtt5PpybVAx/lv1//1SziFvju+0YY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(7696005)(8936002)(5660300002)(6666004)(6916009)(4326008)(2616005)(70206006)(54906003)(508600001)(2906002)(70586007)(8676002)(426003)(26005)(9786002)(186003)(36756003)(44832011)(336012)(36906005)(316002)(47076005)(356005)(1076003)(83380400001)(82310400003)(36860700001)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:46:55.5581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2321389-bf91-4890-7f4a-08d994993ef0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the zynqmp_pm_feature(), so it can be use by other as to get API
version available in firmware.

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
index aa9c6574eb66..02ff2f73ba51 100644
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
@@ -651,6 +652,11 @@ static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
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

