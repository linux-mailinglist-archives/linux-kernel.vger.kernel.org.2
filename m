Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67233B5962
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhF1HEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:42 -0400
Received: from mail-bn1nam07on2044.outbound.protection.outlook.com ([40.107.212.44]:42917
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232252AbhF1HEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBqIBsciAjKu9ohdKehK1wfRUZAZcoBx3vDlGkLZvahad+P/BzwJtiJ0M0xaPgOOn8u8epnV+K/m7pJ565jYog+2sbduMt4qaOYl+AUNZsoIWPMYOcaETkVm2SCWMUfEGMM3nEO73VKBMWrlKGU83S6BdqetQIhXow1iGrTSg00cw44Ui7mUD5ZkYgCXSKk04TN+nEb2tpXnKcQrTGMo7fBGx7jwdvHFPg47I77qHcITNS1N1tVzVSkkFHLYo5Cy7RoKZB3xk+EgBboQqJe7wesBMh19uDyXChcc3q8wrJfu9ASfj/lhEPNZ1nEi4fxlHWRfL27eAyjZpeErJEZnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOMKaj8YIocOlF1Sui/2a6EWB9RxSJ7E6RkjX/Ik9q0=;
 b=P64IIpgOFxTGMiRqDhe9P4pxwBfQUQhK6oqZu8s5U8u4Vrx6F7i7/d//tXEqwNB2onLriZpUpIdwZ5Bputbo4y2rwfY0ffQYlca4j7PkA3TwlHicLoBpVlXMHpH6M8PvD6gRKBArxc4g2VqjRkhdS/eqXIXvD3trgBtWllR1tlFEobgG1wdcNZJO832tmkB6YXEInrQ7mb0kDH2cuek28wmqCEqnO6GYn6cJPVmdyu0kT1Ae0y+oRNlRuGWjQg1BWZT19el5TlCJf7RMmqAWJPrLSUg5/57RD/Dc5t3gfG4XVIdjr1kH0eUwpOlxSdbP01b9pXklh5cKkHziLGjwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOMKaj8YIocOlF1Sui/2a6EWB9RxSJ7E6RkjX/Ik9q0=;
 b=H1EVzBdbyA+WGfNyI/zGOczwLGc1TID5lyHSzcrJylvp43qhxqhURVcKjgjKJVcIO/ZFVd599WwjclRvg4XUsvbsKPLDeni9Zy61cR31OOelehPix0NB6zvoA1dWu0WvV5pLlxjlGGEmSBOMug+Wr+a86HS0Sigi1eWJiu85UTA=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 PH0PR02MB7752.namprd02.prod.outlook.com (2603:10b6:510:59::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Mon, 28 Jun 2021 07:02:06 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::e0) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 07:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:02:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 00:02:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 28 Jun 2021 00:02:03 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 lee.jones@linaro.org,
 kristo@kernel.org,
 quanyang.wang@windriver.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=42476 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1lxlHP-0000Ik-Jx; Mon, 28 Jun 2021 00:02:03 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 1/4] clk: zynqmp: Use firmware specific common clock flags
Date:   Mon, 28 Jun 2021 00:01:19 -0700
Message-ID: <20210628070122.26217-2-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210628070122.26217-1-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5be53b-e048-4aa4-133f-08d93a02a3de
X-MS-TrafficTypeDiagnostic: PH0PR02MB7752:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7752B83556C3752A9E56CA5DB7039@PH0PR02MB7752.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt7PCRSrI8FGf90yKW9Kxj7OXxO94U4IbPCH3mD8QBhARdvhVdSIs7w1KdEIiF4JKkozjj4tVtqMGbgH5u7e8CUsvRjpuE1l81+GRnnR//kleNFC6liE+b081gpu9cOLWz7e4LO2BHh+lgv0rp1q5Nvw2sCc5pyQaxwjt5DdiPaT4YZR7U6PvKGCblisNtUip85vAY31B2ASEBzcKh40hxSsvVuJeuVCj0Ye0DII1r+13gyT/GJhBVLD1V7qukP2N4DYCVmypEUDOquBunSVTb4f+jJReXIZHXGX0vaX6R1fPUy40FHylhgY6XG7DtcWsTI3nlb/6oWqwC96Sb+mUoxSYtcdDbzYcapciKl0r9xzh/nyIm7YpRsWVyZPNpBFKRFJoMaqjGHgGDJ0TMpQRC+sMu1UNOpzrfkGRu7THaMP/JCn4QhVpbheSlu3CB/P/quoZBUWzHNQFECOPgRp+SkQeqPJ3z0m1T7OCk4+7Pw3ai1xNKVm73t4HRpBgEuPVOKSn6mFTnipy95HTGTdGawmflTDqoGAvLt6+XhOBH//1FR/Fg/V+1/eGRTl08Rg2BlO1Pw8vqJQOMvoF917gp8y92vJY2CDVigx0vhG1EIseAk7JndTMyAS5dP2YjV54FRk5P7jblzVk+Afu//UZyOXtWH4b0wd9/pqU8TO2F6lGY5rIFePXzXTn2TuUVYaxFe3zqkyTixRpx5RgJGCJTpxXGlDCejlUpbxIAZDNKY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(396003)(376002)(46966006)(36840700001)(47076005)(70586007)(2906002)(1076003)(70206006)(36756003)(478600001)(426003)(8676002)(2616005)(5660300002)(44832011)(6666004)(36906005)(54906003)(336012)(7696005)(82740400003)(82310400003)(8936002)(9786002)(316002)(4326008)(83380400001)(186003)(356005)(7636003)(26005)(107886003)(36860700001)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:02:06.2302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5be53b-e048-4aa4-133f-08d93a02a3de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7752
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
 drivers/clk/zynqmp/clk-zynqmp.h      | 16 ++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 25 ++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         |  5 +++--
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 52 insertions(+), 6 deletions(-)

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
index 5beeb41b29fa..aa013a59c7cc 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -10,6 +10,20 @@
 
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
+/* don't re-parent on rate change */
+#define ZYNQMP_CLK_SET_RATE_NO_REPARENT	BIT(7)
+/* do not gate, ever */
+#define ZYNQMP_CLK_IS_CRITICAL		BIT(11)
+
 enum topology_type {
 	TYPE_INVALID,
 	TYPE_MUX,
@@ -33,6 +47,8 @@ struct clock_topology {
 	u8 custom_type_flag;
 };
 
+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag);
+
 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 				       const char * const *parents,
 				       u8 num_parents,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index db8d0d7161ce..871184e406e1 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -271,6 +271,26 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index,
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
+	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT)
+		ccf_flag |= CLK_SET_RATE_NO_REPARENT;
+	if (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL)
+		ccf_flag |= CLK_IS_CRITICAL;
+
+	return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
  *					clock framework
@@ -292,6 +312,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 	struct zynqmp_pm_query_data qdata = {0};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
+	unsigned long flag;
 
 	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
 	qdata.arg1 = clk_id;
@@ -303,9 +324,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
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

