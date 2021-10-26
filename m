Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EC43AB49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhJZE2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:28:05 -0400
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:48663
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232024AbhJZE16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWMMr5e9pz7Hs04aWFJTUfwjghcDnBk/6kw19fIwWTM8DhBgHaqLMWEtpm5/kPTio5lvbY0J6+Eb5AR8TtpQgojVfWNX+0SCsQiIkaQwS0B+x0D4FGy9hUeKG3dMZYuEWlJkiivvEzuHGwp07B9yWmBYoL0/tdQtsfLxxUNoM6f4qD0IXHBSE2aMkacNDiyY8xPuNo6+TPrMfMPGQLMExaHmSfyHZN+iSzhxDibJuBKaveW/Hd3CuMjjVBgGRvow7Vx0+3nZj90zTTVdHFqDWIhVV8lK1Dc4ZEdaaxs/lHBs0WKvVrCu5F1bbdp7vUfG9slMVs78GlPcQb4CpTz88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nzmn5tA8MksymBal/mYNbonYt5VCa1+mLhl2TcpLFQ=;
 b=QkXv+QLoWn5+M5rkY/4rsj50HPDga++UtUhlDShQfYE1a3ECPUo15DIoTyJgcdm1HYmBYl7HUCKcM6SeTlXcwHEMFqWe47U0HQNJvvwy25RKq8Gr+/rkJikwUAsK+LOyWEpR+PbbFZAYy9/JOK8BRKZovuOSRGIJalAsiIZryhpbkmYdoHfcYRuzHh/jkkRddpDBqy8985uWhNzIfcatBvb1bt6v+/u1MwxfHjokSN24r/29+EpNTw6C4tkrH0jnGBTz9VuUotKNNkW96VXt/vwUNKjLzpsBAd5190U4x8H+y7PCkUUbn7rVaBLy2tAQsyOJ4N5ytsQA/Q33nlfpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzmn5tA8MksymBal/mYNbonYt5VCa1+mLhl2TcpLFQ=;
 b=bci+aaITA8oE8J7vwH2B9DlkV4KEmeatQOj9osBBF1EVSDz/bKhBcS5ikEpzgfGTnU9a/eJ/9PJ4bvzfysIptGME8HkxLTOlEFmbFK+Oa+3OC0YeZ7sS0WXfu8aJ2MPNquLLMtYHBN8R7tETO6Zzn/Gb2m28Qcrx2bUJXNrE+1E=
Received: from DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) by
 DM5PR02MB2652.namprd02.prod.outlook.com (2603:10b6:3:41::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 04:25:33 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::95) by DM5PR08CA0033.outlook.office365.com
 (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:33 +0000
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
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:33 +0000
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
        id 1mfE1i-0006GH-Sg; Mon, 25 Oct 2021 21:25:30 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/6] firmware: xilinx: export the feature check of zynqmp firmware
Date:   Mon, 25 Oct 2021 21:25:22 -0700
Message-ID: <20211026042525.26612-4-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e4e3cba-1d91-46b8-1c59-08d99838a6f0
X-MS-TrafficTypeDiagnostic: DM5PR02MB2652:
X-Microsoft-Antispam-PRVS: <DM5PR02MB26524848204A3804214E3E29A1849@DM5PR02MB2652.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceGz5rPG7qxUJSDr3sk/JvS7Q9bq3dES8opxCgOj68LRFS1kGN8pjflj88DpeVgDTH83FwE6NezJde3bwhk4mckNDiuU4AqX59pspyMCT6Z1Y0/ofinRc28LvfYSgzYGEznM+vwPUqLSIfwSOSnwOP1ci2w21Tr3aFWqINaFAgzfYBeO8FkIzNYqfMy6+1skK93ksrJPQl2wkJap6FODZ9e3Y4MBaLdoAEJDblucsf9e0WzSI9SfoRYgEvLcQx/DBkQRFzpRtafdvlvPHXrFY6q7JySNLcgMKweYcR2SflYNmjLaWzjrqWba5LlHvGEfdfoSRTYoiKl9J2wSLh0v9GAaibWGELs5mdAkCBVEcu7JJxsTE35YXc2Q+TztHcY9HKK1T8s/R8BBirut1XQjEWzT2BDQAaHwax1Btj0K+V4oq+6YyqXkMT85O2oT+F5c4ivA+aUQEKUefbABkFInp1ld9jzShaHdgsLqvmDyr49CqAeci7b71HOUtox2eBmTSdh5kPRhN25Sb+aE0AdKrMyfIrO3MgAwazRovwdB+iWGkOodZY5G2T+f4+Q64cbr5B43hEHr1lDuMmZvS7A+sO+JigQl5JV6RYJKTcCLAINNK72AaUj28nUrB0FRi+U5L5AafGVdVuucw9Zl08aTS3DGUZguTCZTN16NQl+h5t9gCE+Ke95gGJePz9gnImsa4uJ6KQ78fMxwRcmGab0XzX15t0UzuVIQq0h3aDvkkdk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(508600001)(83380400001)(426003)(7696005)(36906005)(186003)(44832011)(54906003)(82310400003)(336012)(1076003)(6666004)(36860700001)(4326008)(70206006)(9786002)(70586007)(356005)(5660300002)(26005)(47076005)(2616005)(6916009)(8676002)(36756003)(7636003)(8936002)(316002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:33.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4e3cba-1d91-46b8-1c59-08d99838a6f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the zynqmp_pm_feature(), so it can be use by other as to get API
version available in firmware.

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

