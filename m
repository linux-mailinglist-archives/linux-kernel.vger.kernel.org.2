Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C533B5965
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhF1HEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:46 -0400
Received: from mail-mw2nam08on2080.outbound.protection.outlook.com ([40.107.101.80]:45088
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231935AbhF1HEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoHqtSAnM9NwZVcPkFiHzZ2dXKeRx0/xN8K/1gZUD5dBHCyD7sb1ADUy8/x7FYBDeOWKPGKqaVOQl6Gm8ivjSt7aEkhE3FmIDzxQYBJG5zA6DQKW8xlweFtwdVsruT4vomeHoyWNBHucWQRu7XRxroE6h0/YRNO9QNfALy3+le82LWWf51Yzmi9PxPzK7pQ5GuCfl026RdzNbQiVmi2grwiuaD8JlTrV/9fRSqOq6640rxQQMV4n4ayDdHIkR3ZzudO5WF4SALhMflKIeV49w8I4YdEZ4hnH7x1I+NjhHPvTJTlrD7caqduUzQaH2h8M/7yxVMpr8KCSgsrCIgxCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhlVUi4lv652qpQujF/BDsTHYG250X1r6wcmnzUHoAM=;
 b=HjB95FlQ6c4WTDLXxl1VxWns3yxdX9x9cpMlCaWnGXtMvFUVqyCwPZBDk87Cg4IIi66orRrl57Z2k5XUJANACwvtRt6pDtFdJIhFTv1ljtvtyuwysQ5RmdGW9NRbLed34ipfteRdClKYQ0lTX/A5VnsCiULD8EKksOOr4Kzq9ImmfA8tzY0QHeaY5bWg0tZmGuPPG2XJI1anS5Z5C9aJvNsgisiTWIpH9sBg5JLwmXLTSffGAgv6OidnrG2rnphI02sawv/Cvo/pnofv8U0bJXGHUlLqWdpqt84V/Aom5m/bmxzbN0Ts1H1mztUSEUSY28TFP6zdKjljIgX+kzJJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhlVUi4lv652qpQujF/BDsTHYG250X1r6wcmnzUHoAM=;
 b=P5rPZKlA0Mew8VN2TLUDOKZ6lJov88wlTVugqZXNiP6FGO8Q4/buQKpUxZ7k1IvkyosdD4kgrU7b5S8caoO4EcSLUgblpwp2UwZpTSKE16RNqXTR+x/V5dTi9bfRYynfV29UAUnsGooXhp2UQML3xGyeWYH0wwKzFJT3JqJ2RI4=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by SN1PR02MB3885.namprd02.prod.outlook.com (2603:10b6:802:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 07:02:14 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::a2) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
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
        id 1lxlHP-0000Ik-Tr; Mon, 28 Jun 2021 00:02:03 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 2/4] clk: zynqmp: Use firmware specific divider clock flags
Date:   Mon, 28 Jun 2021 00:01:20 -0700
Message-ID: <20210628070122.26217-3-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210628070122.26217-1-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c29697-c106-41a9-e602-08d93a02a888
X-MS-TrafficTypeDiagnostic: SN1PR02MB3885:
X-Microsoft-Antispam-PRVS: <SN1PR02MB388540B4CB043C6E0F7547ADB7039@SN1PR02MB3885.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsoxO0z/KKO8Lz9CsscZxXFz802AIno693fplZ0MLa02tbGppF0qj8aYoH9cSnwgTUiEk9rwYwVbHMGjqqJwmDfbro1yElwLIM2jj5bz4aXGaxrjhgo+sknKOFPZtNpfH5YTBNVgB1gCPQzlFk6njs+ueen58Pl/S3vnqU538OXj3F0UMeQzHh6OuNpZ/q142fjFt4JlCgayOMMAjEZ/vdFGo+pWxB075e7AT+dEh9ZojTegWqjpC/G8YMJ/tgsrGcY6kKg6k3aDpsN4Grt3cFKJ969MAAcuA57/PMtVRgExxPhKbzxwM4NmSgfXkJ6HmtDtIA+t/mx5iRALCVvOfPcUrbxo7Z5jvdoq83DRAs7WlaJV1U8BVTvYKpsRHh7DZdin8snpYj5Qzv/NebOo91pi/PnkuOTXiN46xleVqQyWMGk38nKJ9aboYizj5ncZ2+oQLsd/ZnkSPwZAzpvB5OUXtsKcwJnBFwUXGrQbG51cXjVwtFdrfA8dEeY92C/ixtbYqewRgK8rWrAS7yGdLL7iTniA3apJ57S/hnl990Lco4PTZ6UJVlARHJK+J9G0otHlca8fLAc05wLAD5s/SHxfppw92E/V13u3M38Rm9aJVeghbrVHvn5SxSPTKv5q6f1bJnooYAojsAql05hmTa0mYzS+ULbGbeASlfbYXfKs6f6yLc70P5G1JGZ5PeRNSf9foaDckk8lhUqzMKY8gEcNgjn2gLnwYZiYv+aPubw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39850400004)(376002)(36840700001)(46966006)(70586007)(9786002)(110136005)(426003)(2616005)(44832011)(186003)(7696005)(4326008)(8676002)(107886003)(356005)(6666004)(8936002)(36860700001)(82310400003)(54906003)(82740400003)(1076003)(47076005)(5660300002)(7636003)(2906002)(336012)(36756003)(70206006)(316002)(83380400001)(36906005)(478600001)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:02:14.0625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c29697-c106-41a9-e602-08d93a02a888
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3885
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
index aa013a59c7cc..925a727eb383 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -24,6 +24,15 @@
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

