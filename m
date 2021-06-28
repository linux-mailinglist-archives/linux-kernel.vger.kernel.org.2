Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D318C3B5960
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhF1HEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:35 -0400
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:20448
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhF1HEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UukmovKUZHBZzihN1XDVa1ZCN6XtbGJmV/w7vho1YtQnejV1mNlcMlpPDnwq4hvxfQ9iOqf2C39+rXn9izIslAYDQQulNq+At8FGFfXgK5SqxsaxzJeQjvDKtK3OBaog7B0igvBUxlMg4vN9InGIBDfwvre93vPAAju0xmYCFUUbQlq9wHXS2vseuQ1EUls1Z0rEwDVtN2Bz2O+JBrRU7jDKsE8GvtP4cnqlKGyMicQ9zzY3qBzV0JlaEA63Yq+AaaY5VKiHScysWr5+4oFT96m/dBVa63tCFmbHUtelkhe0rigB2RKri0Y2AXhe2TEVGeKvvBMIo/I691/1z+Df7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUxnbZnjlx5+Up8acUATpYz5cHAbBdRpSaf1Ew1Gj/4=;
 b=U36FwV3GYOJO/GoTCFUKFJSouVHw09TdOlU2x9PdBDL42xa+SjoapNPbBG846MeegpZqhKduSYorTikblo2bjyoo7M7N0O1anjtJQuGIhIZFQjLjfiw7ulQNZOaCvUMomwejjI53k97LxvFqqmFEnLzjAI9oHnrYwv3LcfjdR0tICA9AanuGSVUnjfPScnf6azsJpblCrXI4Pje0E6iAnSSbwhlye5+3QcPzBLfZ0AkXDhAb5u+1ViTTiFPWykYoWvFVUXTozAheYW+vaKbCM1kXeuz1sZD78Mqg/JX5dj4vjP//IWdUEl3vxD7dx/6FQlSiE+10LuRRhjSIVDS1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUxnbZnjlx5+Up8acUATpYz5cHAbBdRpSaf1Ew1Gj/4=;
 b=YjCEP6ErY2KDOGXJTUqLsYLqBt/g1Mo7SxAYLbEH4Mva2kQtsH8DZtr0rtGHTdeRKJBL6KW5ASPDi9xzckAoWRZEtIhrBvArx/bMLqdYBzpelUrBfgjfznBQrZtbluBzNGIj7CaC4jUvb+aHPpIaNy5akslHJxuCFZOvMmekjnY=
Received: from SN4PR0601CA0018.namprd06.prod.outlook.com
 (2603:10b6:803:2f::28) by CH2PR02MB6056.namprd02.prod.outlook.com
 (2603:10b6:610:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 28 Jun
 2021 07:02:05 +0000
Received: from SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::53) by SN4PR0601CA0018.outlook.office365.com
 (2603:10b6:803:2f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 07:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0013.mail.protection.outlook.com (10.97.4.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:02:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1lxlHP-0000Ik-Vx; Mon, 28 Jun 2021 00:02:04 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 4/4] clk: zynqmp: Handle divider specific read only flag
Date:   Mon, 28 Jun 2021 00:01:22 -0700
Message-ID: <20210628070122.26217-5-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210628070122.26217-1-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ab5f23-bc3e-4b0c-9d61-08d93a02a335
X-MS-TrafficTypeDiagnostic: CH2PR02MB6056:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6056C1A9D944AF661CC4D7A5B7039@CH2PR02MB6056.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkOL61zdJrfLcjJVrkGAobLjkqF4adrtaLApoF01768NuYwfDnXq3LqMb1fmWIh/Q544QdBhe1gfNTxF7XUMC9MkPWi7mS/qdnW7S27osUSUxVBkaBC0Yk+wtJEqGBTVr31dzoLJH9/PFL18fjsCnC9tFJ+vyst8lE0y47lPtTCd8hz0yIhHWeHaJHOO0DDYnBjAPNuhAa6vcbWRGUZ7H1nu7Ch7Nthx2+RlSazlggGJJYlSm0rCAvu3PdWsN1JjIMcRaUltiT9jgiK2Wt2YQSFYNwROSY7lx8CiSh0wF1ioKYXLhGg8ghvnAxVClqefMfcszrhj1deWETssj4qdWKfVHPSuWKvubePYDIYCY4y087j1ApvVdvW8m7njaEzCpNLePscHCiKzGTRGjUxCAiQwntKfQOJIDS/qjFDd+HRhY1PtuyJZoFf/CHo9MobCoMa0H69MVjxDjsMDvo1tx9y+E9wuGKrRx/XYcPMxs2bScjCCZqz+35x/wLVNsuxr0r2CUhHphpqxrVBd6pBtnhDPE7hrcRevcvBP1xDtUUdciQ4wN5ZTuIOVv4hP/FCS4h3+sIQPCzrLStzyNje0PGIPbkD6s0CKJnkDzzaxzFi+iRx5iJQvKiksnOordiQbCF5gQcDfDJmHYRHpLfIvuaIDUbPPN8Cc8ciuwGUiXOUyPsgvmSHpemaVcBGP6dHF
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(36840700001)(46966006)(36756003)(82740400003)(4326008)(36906005)(44832011)(110136005)(336012)(83380400001)(9786002)(316002)(7636003)(8936002)(426003)(107886003)(82310400003)(1076003)(2616005)(8676002)(7696005)(70586007)(2906002)(5660300002)(47076005)(26005)(186003)(6666004)(54906003)(70206006)(478600001)(36860700001)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:02:05.1381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab5f23-bc3e-4b0c-9d61-08d93a02a335
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for divider specific read only CCF flag
(CLK_DIVIDER_READ_ONLY).

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index c07423e03bc8..cb49281f9cf9 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -256,6 +256,11 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
 	.set_rate = zynqmp_clk_divider_set_rate,
 };
 
+static const struct clk_ops zynqmp_clk_divider_ro_ops = {
+	.recalc_rate = zynqmp_clk_divider_recalc_rate,
+	.round_rate = zynqmp_clk_divider_round_rate,
+};
+
 /**
  * zynqmp_clk_get_max_divisor() - Get maximum supported divisor from firmware.
  * @clk_id:		Id of clock
@@ -334,7 +339,10 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &zynqmp_clk_divider_ops;
+	if (nodes->type_flag & CLK_DIVIDER_READ_ONLY)
+		init.ops = &zynqmp_clk_divider_ro_ops;
+	else
+		init.ops = &zynqmp_clk_divider_ops;
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-- 
2.32.0.93.g670b81a

