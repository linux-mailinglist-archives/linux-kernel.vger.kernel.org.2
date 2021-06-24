Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6123B2EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhFXMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:20:07 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:51072
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhFXMUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW8BjMhT5HW0mNWMEl2VwfCqTble94zJ6qQhYFmY4sR1KdZcOXwFtFPefbOmiGrAjAlwM9IbrYG/DuhMAQLdosXeW0Vd8aEi0uGksl148LNGAEN/AghtMs/xMkpxZvrhAVvabvqybwF3+KC8hppxrZtYCOESGh3kPZgXN3YxUveUI33jX3by2HZFu9xXWD1pTXWwH3z6Bm6YKX0K92DqR1P1SHEVm6LfOHAh60/KOII8vTj0Q/dVZlOmoHQWdn3Y8EfGx+dJm1jP2Dhyy2Y9hy51IzET4w3jkzN/Nv5chcoFsJEbIKJry0Oa4lv+e2iP3+FtF4ZLxAVWptQyXIXOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2x8My9OweVDOrh38jlgY+ub20gkMfbPHGOgEG3Nvjc=;
 b=B29SfwwMxrOjaKlOycrMt/LjpFF/Lru5oge6Q3+uj5oxAmjtUJkL1UFdlplH3B2epLyMDCSuOjCrlIaVmKr2ovB/oQ0VcWg3vyExSeUUpKArI6TH5OMFx7ztSF/ZSIM7ZWz1BNGwENDtf4yTAeelD1AokyQckJ2QjwKECUqopUe8FLlubpXZ82hEv3NjooTYC0aF5jEch2LunTud3L7PdJ/U+kCd/TLTQ8cMJQIppq3KyLNtiYRqQCWiLDgLv5Sn8nnylrIXa/OsvX4ATwnN68wHD/2cNNEAK6G9skmkRJego6WplcBwB4AKurFR2EP4+gk4aErDvDUxTARBYYkqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2x8My9OweVDOrh38jlgY+ub20gkMfbPHGOgEG3Nvjc=;
 b=eFJVHyBdNy3oVbCdImmETsYsolVW+ug+xF5uqlFVb+7ECJ0rhvuWwlmutgIWDmWK5urN2HD104CgPR088Yrn6/lUzIJcUp83gFds1itvtvLgcR7rkjG3q2HIfYICKSTDYtW3qEyU9pSr4IPwVm/oO9VygyU7JPXbJuHduwMP2vs=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 DM6PR02MB6495.namprd02.prod.outlook.com (2603:10b6:5:20b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Thu, 24 Jun 2021 12:17:42 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f6) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 12:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 12:17:42 +0000
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
        id 1lwOIV-0003F7-Hu; Thu, 24 Jun 2021 05:17:31 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 3/4] clk: zynqmp: Use firmware specific mux clock flags
Date:   Thu, 24 Jun 2021 05:16:32 -0700
Message-ID: <20210624121633.22179-4-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210624121633.22179-1-rajan.vaja@xilinx.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18348ba3-4b6f-4b55-c379-08d9370a10da
X-MS-TrafficTypeDiagnostic: DM6PR02MB6495:
X-Microsoft-Antispam-PRVS: <DM6PR02MB649580AB094F2D90DD02734AB7079@DM6PR02MB6495.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe3gatxDT9hp/MvEHM9dOtFNxHabD9gqluQVvUOVihVmwj2s8tJTb/fDZztzWTYsNbBhSKu1cUsxzcna9DPKbZOGEknIXbAc4gGpDwrTbVH5PsvfwmJEBo/UQOLHA58/MzpehxGH2mU+sgVKK8Zb6zoZhSsBYlso0eW91ZPmJfExhBqJ55ztcENesBfp4+jaBova4eJUbs4txyaj8Pcxg+aZV6awyTtDnIR5Sh2fTV8fRdgy96pVZ+tksleYCUj8yl50+A1KL3nTojkCpGBoDqIKqVK3hGJRrwVdqVnPMIURrX28HPRJ/p+biW99ST+B5tV81Nd/aEIeNichQNl33gGzwbgp0siV6+EeYj67ViZZXYoJBWJ1WL8FE72y3yT7xJEs9gOKYkKtyz2QK5HQgTlyllxvro0hGNRAljIfFg8wzrEvtQ4HorXYpQ/IXcDWyHRKwlwg5m95qwymoM0FQAr7dY2hPoyol/h7idVPNlVsJYKzk8bfzS7dqagII7qV6fOKWzh2oZoSE5YogGGNhnrGMqG8XHSxw4hRc0X4nDErsZPRtci93b45M8OjSibypidfRUVceGJyiu9efKpX1HJBxvzOc1P6GvjmCd+tz3H2C3OUKCDmhKXoCkiJkqQzze2F+o7kNyI9d2vCMN1OPmrbA8uNp9zlLhSYoDNgVPliZHXn3k9sxvWAfc4wfBZg
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(36840700001)(46966006)(7636003)(5660300002)(36756003)(4326008)(47076005)(356005)(316002)(44832011)(82310400003)(2616005)(82740400003)(36860700001)(1076003)(110136005)(26005)(2906002)(83380400001)(9786002)(8936002)(478600001)(336012)(54906003)(426003)(8676002)(36906005)(186003)(70586007)(107886003)(7696005)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:17:42.0699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18348ba3-4b6f-4b55-c379-08d9370a10da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6495
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
index 9b2ff35ee136..87a2e1298be8 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -41,6 +41,14 @@
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

