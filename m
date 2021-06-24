Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625ED3B2EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFXMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:19:55 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:36801
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229573AbhFXMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbzG8UozHPAQNdKP0OijGXPQ5zP44rgy6+xzVG4G5nCkBsC9Uj8Uo2xLSayln07VOHiQ+Bke1F8YsQaca2k//GNZXp+eYJE3Us6W/lI+ugvy3gofIr9eUwsDMHFsCyYclqc3r4fqTMtzf1sp1mxdfpEaxXaZGt4gxdy4F3WsbphiFxyAofU80dai9NMK1PZ5fM+7yazgnwBcYIbHxIP4kNdC66PqTkrffj8WUdCBBabADMw+MOrdQ9RndhJGFBHhxU5irYkSI5a0cJTu3O4jVG3X6So3n7NiIvIRCL8804QRweRlIRcbqGdyzgtdKHXdrwDOWHLulrCPTS5uSR9x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnr+uP9io2VeekA/OLhk2mattUSZBs0wXtdIGPW22rA=;
 b=dVfyAhFiBk84ni+12ErdQMhSvbcyHcA2GNesGDt5/4l0d4/Vq/39gmspRqyySCizajpAFsmZf7QKRZ7Jd4mkFfT4eG2Ue+CpxvOedLxnfrGmibhLiEZdK6ip0bVV6W4lOGSfM7T5+4MXgfeku7SjBkoAFHF+Hd6CZBfsoteDTAGYmBLKPdJPK5t5Mq7IrTtBo5QcWCIgtHQttouK/0l46S9QNd8LyjVEj67++ZBjDU+86op6gbZGXAi++MIG1U2wnbse3eInaosNGX0IOqT/ZKiJCp92deRz+zHZ3xgBe6Lq2D1ofISL5dZ/ds+r2De5OezYS3yxTixRyJHN92KtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnr+uP9io2VeekA/OLhk2mattUSZBs0wXtdIGPW22rA=;
 b=gcK+TXRNZ0RerKHSewMWzqRjMVsDwtKgKQLzxHu2ix/9mszxG8Fl/58+X/rToFOR3ztangnDKvmiKgzTF4VHL8qgvNAlkIozIhoY8olz07/jarle6PuG6DcR7bmF+q/in9ZZiGYbCW6kTkGKcHaF7w12FZHbkdVqKEYQt3eYfhY=
Received: from DM5PR08CA0055.namprd08.prod.outlook.com (2603:10b6:4:60::44) by
 SN6PR02MB4864.namprd02.prod.outlook.com (2603:10b6:805:98::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Thu, 24 Jun 2021 12:17:32 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f4) by DM5PR08CA0055.outlook.office365.com
 (2603:10b6:4:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 12:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 12:17:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 05:17:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 05:17:31 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 lee.jones@linaro.org,
 kristo@kernel.org,
 quanyang.wang@windriver.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=51016 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1lwOIV-0003F7-G1; Thu, 24 Jun 2021 05:17:31 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 1/4] clk: zynqmp: Use firmware specific common clock flags
Date:   Thu, 24 Jun 2021 05:16:30 -0700
Message-ID: <20210624121633.22179-2-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210624121633.22179-1-rajan.vaja@xilinx.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbd7aa6-3217-4955-d1fe-08d9370a0ae9
X-MS-TrafficTypeDiagnostic: SN6PR02MB4864:
X-Microsoft-Antispam-PRVS: <SN6PR02MB48640CEA21905641219B791EB7079@SN6PR02MB4864.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSYYVEsVRoYG2tFIw8Q3qXsuQoZRm9Y7kt5UsTeT8QGdlzu+TxBhxtIgfISuXFRYqBrhSoYPrHpwVgxmexvbhxbaO/kCfHlwQnZinQwY8kglnXIXAes9lQ9t4Cq35pAK+ue4RNrOYX/U/lF7TufXck0CQSm0zlD6vsAVQRTXkcdb1Tegpl8S7aOc3RLYaTZjK3gKQPuvpt/pMo7FZCD3J5F6q8AoyhWkfdBCl5k7udYR5A7pzX+J/KmSWzDphaBNGGyvKoejZtDvLNnsuUqXh5ij2S/cWSPGhLRB84EJv+43YC3fwuQWwgZT9tb5Gk9jyZrMGnAUMTbGMiDNpDl70UN1lRZph11iWUtb+wIS4iSn/YfsRfmmsYdga7tmsM2bNWcmJVFVmYSEylFc4jNsJvzOf3fXKFIwezyfvUlDTM3zhYcqEtO+P/NrFl6TclGn9DVjNsqHoPEeJyFs9QVYi/Le/dknPM+q7Tf/hLCxFsa4ixk5lwTsQtuzW5oiaq60nKhkyTBMVCE4YkM3UAhJvLoI1bnJzpWjcTZX6WTVSo5T1AICBHCpv7SxWxx6iBjAWO8psI8beuehQbe/TvuJU9qcQVH2345Xaz+XlklZzRsNmbnfifXaLIGXDMm02ieVKHyOIahMQzMaarI6DJxJAGetHqnsY92Nj1/r/wi3e9sDHljv7weeFOpIndnEcGkV1DDHpkZkENxY8b2VkBmO4oo7OxdHAQ2DVSnmm9TAsBA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(36906005)(316002)(2906002)(8936002)(4326008)(426003)(336012)(1076003)(9786002)(54906003)(478600001)(5660300002)(2616005)(44832011)(8676002)(107886003)(7696005)(110136005)(36860700001)(82740400003)(83380400001)(82310400003)(7636003)(47076005)(26005)(70206006)(36756003)(356005)(70586007)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:17:32.1022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd7aa6-3217-4955-d1fe-08d9370a0ae9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently firmware passes CCF specific flags to ZynqMP clock driver.
So firmware needs to be updated if CCF flags are changed. The firmware
should have its own 'flag number space' that is distinct from the
common clk framework's 'flag number space'. So define and use ZynqMP
specific common clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  |  4 +++-
 drivers/clk/zynqmp/clk-zynqmp.h      | 24 ++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 33 +++++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         |  5 +++--
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 10c9b889324f..695feaa82da5 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -121,7 +121,9 @@ struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
 
 	init.name = name;
 	init.ops = &zynqmp_clk_gate_ops;
-	init.flags = nodes->flag;
+
+	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
 	init.parent_names = parents;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 06194149be83..a49b1c586d5e 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -120,7 +120,9 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
 		init.ops = &zynqmp_clk_mux_ro_ops;
 	else
 		init.ops = &zynqmp_clk_mux_ops;
-	init.flags = nodes->flag;
+
+	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
 	init.parent_names = parents;
 	init.num_parents = num_parents;
 	mux->flags = nodes->type_flag;
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 5beeb41b29fa..974d3dae35a7 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -10,6 +10,28 @@
 
 #include <linux/firmware/xlnx-zynqmp.h>
 
+/* Common Flags */
+/* must be gated across rate change */
+#define ZYNQMP_CLK_SET_RATE_GATE	BIT(0)
+/* must be gated across re-parent */
+#define ZYNQMP_CLK_SET_PARENT_GATE	BIT(1)
+/* propagate rate change up one level */
+#define ZYNQMP_CLK_SET_RATE_PARENT	BIT(2)
+/* do not gate even if unused */
+#define ZYNQMP_CLK_IGNORE_UNUSED	BIT(3)
+/* do not use the cached clk rate */
+#define ZYNQMP_CLK_GET_RATE_NOCACHE	BIT(6)
+/* don't re-parent on rate change */
+#define ZYNQMP_CLK_SET_RATE_NO_REPARENT	BIT(7)
+/* do not use the cached clk accuracy */
+#define ZYNQMP_CLK_GET_ACCURACY_NOCACHE	BIT(8)
+/* recalc rates after notifications */
+#define ZYNQMP_CLK_RECALC_NEW_RATES	BIT(9)
+/* clock needs to run to set rate */
+#define ZYNQMP_CLK_SET_RATE_UNGATE	BIT(10)
+/* do not gate, ever */
+#define ZYNQMP_CLK_IS_CRITICAL		BIT(11)
+
 enum topology_type {
 	TYPE_INVALID,
 	TYPE_MUX,
@@ -33,6 +55,8 @@ struct clock_topology {
 	u8 custom_type_flag;
 };
 
+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag);
+
 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 				       const char * const *parents,
 				       u8 num_parents,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index db8d0d7161ce..af06a195ec46 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -271,6 +271,34 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index,
 	return ret;
 }
 
+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
+{
+	unsigned long ccf_flag = 0;
+
+	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE)
+		ccf_flag |= CLK_SET_RATE_GATE;
+	if (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE)
+		ccf_flag |= CLK_SET_PARENT_GATE;
+	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT)
+		ccf_flag |= CLK_SET_RATE_PARENT;
+	if (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED)
+		ccf_flag |= CLK_IGNORE_UNUSED;
+	if (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE)
+		ccf_flag |= CLK_GET_RATE_NOCACHE;
+	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT)
+		ccf_flag |= CLK_SET_RATE_NO_REPARENT;
+	if (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE)
+		ccf_flag |= CLK_GET_ACCURACY_NOCACHE;
+	if (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES)
+		ccf_flag |= CLK_RECALC_NEW_RATES;
+	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE)
+		ccf_flag |= CLK_SET_RATE_UNGATE;
+	if (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL)
+		ccf_flag |= CLK_IS_CRITICAL;
+
+	return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
  *					clock framework
@@ -292,6 +320,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 	struct zynqmp_pm_query_data qdata = {0};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
+	unsigned long flag;
 
 	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
 	qdata.arg1 = clk_id;
@@ -303,9 +332,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 	mult = ret_payload[1];
 	div = ret_payload[2];
 
+	flag = zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
 	hw = clk_hw_register_fixed_factor(NULL, name,
 					  parents[0],
-					  nodes->flag, mult,
+					  flag, mult,
 					  div);
 
 	return hw;
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index e9bf7958b821..0becdc0a8bff 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -312,8 +312,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 
 	init.name = name;
 	init.ops = &zynqmp_clk_divider_ops;
-	/* CLK_FRAC is not defined in the common clk framework */
-	init.flags = nodes->flag & ~CLK_FRAC;
+
+	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
 	init.parent_names = parents;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index abe6afbf3407..e0bceb07740f 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -312,7 +312,9 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 
 	init.name = name;
 	init.ops = &zynqmp_pll_ops;
-	init.flags = nodes->flag;
+
+	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
 	init.parent_names = parents;
 	init.num_parents = 1;
 
-- 
2.32.0.93.g670b81a

