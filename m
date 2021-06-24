Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5293B2EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFXMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:19:56 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:7649
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhFXMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsz96T9unmjBDTW+WYAuis5iQ/Q7NLrtBXlWAcZOutFzfuOW+wtmWUCgHgkrU8acSCLIQC1bnsWXzWTgF2YJb4ksDyPx8jD1+NJP2B7jT2Hjw3lTKX6HjioAXxaZ/Og+zyYKDW+c4YncoKtWeFvAGtjtzQI+hoWH2LzeFywLzmpXRkyQeXYnL2ht25OvALtN7QozlXYbxPtbgg55HnuOmPFbVtgJ6iy3zA6lf+3wIvPQK5r76fZ+VBkgElavqhix7hhvh0t/g6KRml+3495343jIRjRRzDQIrwebbmPHAbch8TmrGOpwP0RwT7hxk+XJjZG1tok3MikdqwNX+6Djqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYin9031DqaUGi246OrOMY8D4pD0kuTFj7LpWLD6lgc=;
 b=h09rRVIPGpCuAhnyz+LOxXOcyPP8dV3UMJabOKt5BoDdwd2TbY0+wjJpj8uK/nswurc5li8zDDFDiXzZUGKYENGoCW7idVWSmYvzizPaSg39rkIC/gMvovBDMBX5CpkiqJE4uwgHZvWzxf8PFsvu3Y5pEXp24k7Lc8HDRQXH5s/hJ+EBpJiyVpTsk547+SjNgxss7TpKIFSv3Px7FSZ6sok9j8rZx4NKJdCfBxxcKMFyVfoSpfuGwTdFF1N8sAI6QjK2qMYp9MikSfoBjsGjC6QE+9nct3BQTD2WrGNTZy9gU5i2eXER9I01R/vPV7vPDrOUXjyltSRK3n69D/q5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYin9031DqaUGi246OrOMY8D4pD0kuTFj7LpWLD6lgc=;
 b=ha7QS7XybennVNoWObMFO6eybPCE5zqk7wYLgfw6CPfpOv2izUZHpIHibBi/Cuq9c0D8oKByQb1L6996cnKjh7LYquSBoLOq03htNT+DnsHDHkqCou3K1JXLlptwBvqEsp2aGt8kGv55W6X5uJeGHW6uH5lG1hv5GbpcD3ovd/0=
Received: from DM5PR08CA0049.namprd08.prod.outlook.com (2603:10b6:4:60::38) by
 PH0PR02MB7832.namprd02.prod.outlook.com (2603:10b6:510:57::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Thu, 24 Jun 2021 12:17:32 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::e3) by DM5PR08CA0049.outlook.office365.com
 (2603:10b6:4:60::38) with Microsoft SMTP Server (version=TLS1_2,
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
        id 1lwOIV-0003F7-Gr; Thu, 24 Jun 2021 05:17:31 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 2/4] clk: zynqmp: Use firmware specific divider clock flags
Date:   Thu, 24 Jun 2021 05:16:31 -0700
Message-ID: <20210624121633.22179-3-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210624121633.22179-1-rajan.vaja@xilinx.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78cc46c-3c29-4cb7-36bc-08d9370a0b4a
X-MS-TrafficTypeDiagnostic: PH0PR02MB7832:
X-Microsoft-Antispam-PRVS: <PH0PR02MB78321BA82385ADEA0F86FE12B7079@PH0PR02MB7832.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k47InojK2YMxBdIwX52AbeB6zVeeN+pvUAhBIjYTll9XRxUhvoKv4AAAWkkfgpkj3n0Nl2PYY4TUHXtD30sD63NbBXMFJ324vHUeyvhuBqEqydMkG1NEwi1sTa1rRKASCAn+tib/UA59t00wseiE8aEEelzqbyHPRVYu7W7Wy/JcmgjQqozK/LbQkYtaSr3BUvxtBmxPefMbmiSxvB+U4BS701oanjh792HybmThP+VXwhd+eA7x2oYsqITbnU9X+sHrJU9U3ZtzGf6oychgZoFmXHfR7siKRJPWGOZ6xI8FUF9lUuUkjEdGpmz/3ub7PC4aJi8ciNmFzJEISKKXU8mtj4v/xIEpUfE0xkZdTeXLf62MWAwszqLMBglO1TxuwIuPEctxWk3SZTL+4bFvOB8KmXpbeq4Si7JiaMK40HcOBgQwR42PCF0GIu3Aii1CGRq8uNYkJCnKWHqSZJLYVzPYKK1uuBWevxUaT/U3QUmB69VfRo3cU+0BMMHdqXwMlZ0/yjqNo1CTJyO+YnJzfhUiMuP8XJysA2nZlgvWbWDklSYdlHdq3PB/BG7zUeg/Vs5HF6WJ8INXdMEMccExYyXBjtvxuTt8lsbXep3HILSBECBKo4WQI6s+sZZGiokcLom/cOUDeVPxXWwyDn5YeJWqrih7HvZFHAUCdBP60DP4nmjqFHt9a2V5ocM8vAw
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39840400004)(136003)(36840700001)(46966006)(5660300002)(426003)(82310400003)(7696005)(44832011)(2616005)(4326008)(54906003)(336012)(186003)(36906005)(2906002)(26005)(110136005)(316002)(83380400001)(36756003)(47076005)(478600001)(9786002)(7636003)(8676002)(36860700001)(8936002)(70586007)(70206006)(107886003)(1076003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:17:32.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78cc46c-3c29-4cb7-36bc-08d9370a0b4a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ZynqMP specific divider clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h |  9 +++++++++
 drivers/clk/zynqmp/divider.c    | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 974d3dae35a7..9b2ff35ee136 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -32,6 +32,15 @@
 /* do not gate, ever */
 #define ZYNQMP_CLK_IS_CRITICAL		BIT(11)
 
+/* Type Flags for divider clock */
+#define ZYNQMP_CLK_DIVIDER_ONE_BASED		BIT(0)
+#define ZYNQMP_CLK_DIVIDER_POWER_OF_TWO		BIT(1)
+#define ZYNQMP_CLK_DIVIDER_ALLOW_ZERO		BIT(2)
+#define ZYNQMP_CLK_DIVIDER_HIWORD_MASK		BIT(3)
+#define ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
+#define ZYNQMP_CLK_DIVIDER_READ_ONLY		BIT(5)
+#define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+
 enum topology_type {
 	TYPE_INVALID,
 	TYPE_MUX,
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 0becdc0a8bff..c07423e03bc8 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -284,6 +284,29 @@ static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 	return ret_payload[1];
 }
 
+static inline unsigned long zynqmp_clk_map_divider_ccf_flags(
+					       const u32 zynqmp_type_flag)
+{
+	unsigned long ccf_flag = 0;
+
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ONE_BASED)
+		ccf_flag |= CLK_DIVIDER_ONE_BASED;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO)
+		ccf_flag |= CLK_DIVIDER_POWER_OF_TWO;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ALLOW_ZERO)
+		ccf_flag |= CLK_DIVIDER_ALLOW_ZERO;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO)
+		ccf_flag |= CLK_DIVIDER_HIWORD_MASK;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST)
+		ccf_flag |= CLK_DIVIDER_ROUND_CLOSEST;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_READ_ONLY)
+		ccf_flag |= CLK_DIVIDER_READ_ONLY;
+	if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO)
+		ccf_flag |= CLK_DIVIDER_MAX_AT_ZERO;
+
+	return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_divider() - Register a divider clock
  * @name:		Name of this clock
@@ -321,7 +344,7 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	/* struct clk_divider assignments */
 	div->is_frac = !!((nodes->flag & CLK_FRAC) |
 			  (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC));
-	div->flags = nodes->type_flag;
+	div->flags = zynqmp_clk_map_divider_ccf_flags(nodes->type_flag);
 	div->hw.init = &init;
 	div->clk_id = clk_id;
 	div->div_type = nodes->type;
-- 
2.32.0.93.g670b81a

