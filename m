Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF25B3B5966
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhF1HEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:47 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:59907
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232329AbhF1HEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXUvksqVte3+oAd4J8RN/MVi+bJkdAd/TM0YcRmq6SWCE0oQcVe+qqRW1U7Kmzw2brWTpmN/45cBgd6CPHwwtvnr4zq6hUxZLXEYC61fsirtPFZ+ynlIThXVUG6XproBEj73YpPnvLmrFZvOeYcdaEBh/mpI5dvgrKm16EFN5vtZjkmOylmxfqFA3fTNgL3UBeM3lS7wOWyKtQoISpNp+3v3mYx5hUOXEBW4d/9j4H4jOFYKb82FAF9fDl6RitZjddppPOf8dixkYg1/zF+aaqx9gV+6vDP1MugEKFjNKNfaksHj27J6eVcobcdRtsrLyHaixXbLKfSGTlukHt28sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjYMcdwrzNI5k3hRbGPSBUTtahunbwSyaqqWYchmiwE=;
 b=BIuZXWnOS+0J2sxaYVwaj1+A2ioWQwMNSfLRJmDjMPzY8NK3sg8pNyqlssIoFR6jqNeGOHPCZyS194KB1B5DkKZTMJzu+Tldx8QE8GeRbcp01l22swEcwhebMX0e9+/gLDhGsebRrUtTlET1bqlrotgKBt20M5MRuEOCisvjeeF7JxrwFrb88HaV6heOLt0VeR+ApaTx7lEY0/lyQYEWNUXx7QruQLOEClrOoHocrF30JBCWUS3fJZiSsKMANdJL3/4RFZgYm1rGLgYtfjBVmhIGo6F/PNJQ73GT1YVC6+kOndOTgoJ4tHytrxf4GhO13ulV52sVIum98Kv3NCI+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjYMcdwrzNI5k3hRbGPSBUTtahunbwSyaqqWYchmiwE=;
 b=agmte6r7/NWJOP1mhzvKnhmTIuX3MRlrIgt2yC8lYFXnpv4KB90ivs1/OfXkAodqN3BKrewxqNrDBGyYtF0jtmeYVkvPHQBrP+hN7dyRvMIRZdruoztLAeERn6jPBewKMtN/U9RcBUYN1sdB3yBy0zXJ/ablDEiuZiI3ynLpq/Q=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by BN0PR02MB7917.namprd02.prod.outlook.com (2603:10b6:408:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 07:02:14 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::a6) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 07:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:02:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 00:02:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 28 Jun 2021 00:02:04 -0700
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
        id 1lxlHP-0000Ik-V0; Mon, 28 Jun 2021 00:02:03 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 3/4] clk: zynqmp: Use firmware specific mux clock flags
Date:   Mon, 28 Jun 2021 00:01:21 -0700
Message-ID: <20210628070122.26217-4-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210628070122.26217-1-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f358bf-c73b-4399-7585-08d93a02a8e7
X-MS-TrafficTypeDiagnostic: BN0PR02MB7917:
X-Microsoft-Antispam-PRVS: <BN0PR02MB7917585B3C60D9002E22F827B7039@BN0PR02MB7917.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+NutCgaOXxFzp0S9yy77WnfzHqDznOygeqjwebuM3IbQFFFq8f+eKZRb30G8rVGp1DDCs2OhRbLA9K+tl+7PHyLZzJgBu6JvsOOX17sgWqe8NXtSNJHDmBL4kd+x89h7INcdRm+X/yEQ6uUJs68LB10sIQSemItGruj+KcNs3LQP0LAy0apjy5fi/OhTNqRUfcZKW3/6L6XEpGudTOMID9QByJaTXAziCMbYKB5dFgdX0+f5GxOrnituQDe3xWJHUjDk8GXFaRdvxgvo1s8ob6AY7rAdc/9aNsMyWhYxr2nSBiIpe/q+H3UBtYeOtlal6SeCGQLkZeB1BV4Wj0tGBb3qBRZ+tsBMuu6qr4VuFXm+m5buFQk7qacVto4oeS3OX3/746uLGaqRMrvEIC2aUZ6GpIn4qj+CjlwrduOOfCXi57Nx5Fv4sueBP0LcaN+8JuYYZjTuU6MClp7kObcRDz2mCmcV6aUYuPrk+SinZ7QRVh1l/SGN6+AKZ1PRXLWD22BvD8DltXgajeuSoexoa7jvYTVXyfR2t+XJDQGB+g8k1M/CfBF9JsA41QzEXcSST8n1h4qGoER38UXnWMUDB1ToM29aaigfQg/RCSaCsQZmOaPI9FM0e9MD83DuBZQrdCKLHFhqE0A8UrWFOve6tV90QEao+WPhsgnrZ/8UUczV7tNeREYSJ6KAq49yT6V
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(36840700001)(46966006)(6666004)(1076003)(8676002)(70206006)(8936002)(70586007)(7636003)(47076005)(82310400003)(82740400003)(2906002)(9786002)(83380400001)(356005)(5660300002)(36756003)(478600001)(426003)(54906003)(44832011)(2616005)(336012)(36860700001)(26005)(7696005)(36906005)(316002)(4326008)(186003)(107886003)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:02:14.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f358bf-c73b-4399-7585-08d93a02a8e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ZynqMP specific mux clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 23 ++++++++++++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index a49b1c586d5e..4c28b4d8d122 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -90,6 +90,27 @@ static const struct clk_ops zynqmp_clk_mux_ro_ops = {
 	.get_parent = zynqmp_clk_mux_get_parent,
 };
 
+static inline unsigned long zynqmp_clk_map_mux_ccf_flags(
+				       const u32 zynqmp_type_flag)
+{
+	unsigned long ccf_flag = 0;
+
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_ONE)
+		ccf_flag |= CLK_MUX_INDEX_ONE;
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_BIT)
+		ccf_flag |= CLK_MUX_INDEX_BIT;
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_HIWORD_MASK)
+		ccf_flag |= CLK_MUX_HIWORD_MASK;
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_READ_ONLY)
+		ccf_flag |= CLK_MUX_READ_ONLY;
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_ROUND_CLOSEST)
+		ccf_flag |= CLK_MUX_ROUND_CLOSEST;
+	if (zynqmp_type_flag & ZYNQMP_CLK_MUX_BIG_ENDIAN)
+		ccf_flag |= CLK_MUX_BIG_ENDIAN;
+
+	return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_mux() - Register a mux table with the clock
  *			       framework
@@ -125,7 +146,7 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
 
 	init.parent_names = parents;
 	init.num_parents = num_parents;
-	mux->flags = nodes->type_flag;
+	mux->flags = zynqmp_clk_map_mux_ccf_flags(nodes->type_flag);
 	mux->hw.init = &init;
 	mux->clk_id = clk_id;
 
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 925a727eb383..84fa80a969a9 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -33,6 +33,14 @@
 #define ZYNQMP_CLK_DIVIDER_READ_ONLY		BIT(5)
 #define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
 
+/* Type Flags for mux clock */
+#define ZYNQMP_CLK_MUX_INDEX_ONE		BIT(0)
+#define ZYNQMP_CLK_MUX_INDEX_BIT		BIT(1)
+#define ZYNQMP_CLK_MUX_HIWORD_MASK		BIT(2)
+#define ZYNQMP_CLK_MUX_READ_ONLY		BIT(3)
+#define ZYNQMP_CLK_MUX_ROUND_CLOSEST		BIT(4)
+#define ZYNQMP_CLK_MUX_BIG_ENDIAN		BIT(5)
+
 enum topology_type {
 	TYPE_INVALID,
 	TYPE_MUX,
-- 
2.32.0.93.g670b81a

