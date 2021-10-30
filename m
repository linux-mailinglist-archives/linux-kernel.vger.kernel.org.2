Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746E440957
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhJ3OFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:05:41 -0400
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:8112
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230005AbhJ3OFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuIXHtXhmGzNueNLYMJ2Yxa5VjtuYmSPHWTyC+V9HCjdHrBizUI3vqIwcyzq1pglr8ae0RKXyUgQKPK0AdK/ImGMA3b/dFAq2jdxVtxLs7rhrIINTuE+MZ3Ur/DAVMjJ+OZryL34PGl4OJNrRDd56O4beDk85qwS3UnV3JEFi7mauzelMTKmbIPtcwR+cS9oAwpkgK3ja8MK3nw5lQTREgJ5zKYe3fHWtOiBk0JJjUErZq0CaXGR3gpaXvFmhXqHgNtm8sVpdHUQtUSySWycn9CkrKs/+DputZy1wnc/NzcquBUKHadVMyQgSrUpy1rsbmTfEikknuiiepbpozu2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CadjfW6DWFjTi3GY+o0+G4RZ4q49jweBJPf7GjfF/sw=;
 b=TROx3JdpiDIHA1d5MV/cu7LmTaIOe+DCM2y1o/CnK/gIc/8W0qkW966OafOLKbj9YL0fT/r8A0ZzqIMTnU8bMsasbRs8+vWsh9En8j5Kzi5nhtZ9y9hpZsi8fN1vn09voGYR6y1bezME1uX9f0lR1Snw5r4pETGGqxmX8ano+rocErbJnD+x0NXrPs36ZPvEt3tAsZH8ctY+cOw3YeOeqr/0TD7fDwg++nffdPWjonpKDA8jAZ3QTG9mu0ourUUjARuBqvM7FNOMr/3s9btoL0sknYquzPi+B3i0UNGfN+t1jF+DTWsY+oESra+oTR+58gtnE3VT4iBCE8yWFN58kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CadjfW6DWFjTi3GY+o0+G4RZ4q49jweBJPf7GjfF/sw=;
 b=zj0M7ypfcfVOvNjJ0VQGbOdT3mA/JRlsSzkYmq+l6qef8Qn6r+Xk5t5iNtVL+BmNzmsOmumVjso3X2Ko6ukkDVVkSaxXJG9jht02kxzHXl1BkMV7Bh2sdGwjj3LZ2uOcfKVkxZ9aEtPX5vfyOjo6tzuq4WxYc4Dc/gcdaFqs4mc=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Sat, 30 Oct 2021 14:03:05 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.018; Sat, 30 Oct 2021
 14:03:05 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] clk/mediatek: fix missing null-check for mt8135
Date:   Sat, 30 Oct 2021 07:02:55 -0700
Message-Id: <20211030140255.6410-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Sat, 30 Oct 2021 14:03:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0578a5-3b2b-4141-c1ec-08d99badfe4c
X-MS-TrafficTypeDiagnostic: TYYP286MB0985:
X-Microsoft-Antispam-PRVS: <TYYP286MB0985BFAF48F3202447EC37078A889@TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AAqK5GjqU1SmypxtlZoMyDyndqtEHVnEs/+aEnUtV9UbaFnGY8EuuZlumZQUU7taOzw1joOuiuNqLjw6K2ySEBCZfoIhLJ9anjZKx1uaHue7kNKKdTHnUr+4vKGFEWkiNlSv+8xcFgeTso/y9FGbAXc5y7YeYCRaim9y10cHjpsBl6NTBEN/CkvAxHguHnY+O26+vSEh8eBnFMxF//YdwJNGR0+93BSNsLkoB4Pd684qbI9kN/3JGrx9qhuFmo04jJLxiJjkAhUSSiEFP3PuwPi342uGTXLGwPBvnS9I8WA3ilDJPRsS04pvFJ/c2AVKJP5RjexU90O7TMIFv8mtmX7bEXAxfVNXGsB7hqTiZCjJZiJnoM5bgCq5BGXZSrqTp/F77qdFF2ICEFodSHLzc2lY3mhgZsqWpPV/fRJ2tPkh40q58nAGnWGVe8vUyeSPZ5Iuebxt5P2d9kfDYGnsmLpzeGzsW+s5Jk4jENBsRo2HB5NY6xZWhanRrR2ExDyxnZAGCtw8zAODzwyFi2Bek18dg9MxPPzWQ7MjhfST54Jr6MXdcD38/H48TIUWm+6uCYp4io8tC2SCiGVj8ryTtFDPGtGF9Qgz9DxjF0TBlfJfrtgW12qTkctXSdmogWC43g5os5DMT6ND4a32X7r+WLvVEuG6bJ8I7kl1dYduj29i5iSJ7cFmV+rnIhAhROttGKsyfot2NbmJGwxEpbjbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(316002)(2906002)(38350700002)(956004)(66946007)(5660300002)(26005)(86362001)(2616005)(38100700002)(6486002)(66556008)(66476007)(786003)(6512007)(8676002)(6506007)(107886003)(52116002)(508600001)(8936002)(6666004)(1076003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XWu+SJaebeGjH64QRGeVlMPdNTJFJYZg1lhRpNy2WSPKvFfR2SoP0OA/5yqx?=
 =?us-ascii?Q?a+Lr7pJofM9JvA7baloVhBwzyWmGpCfRnEn8KqjQ8i6jH/oLmDfkkyNRtcn8?=
 =?us-ascii?Q?CN3A51Fv3AO7Y3LWKddEHk795HvWedchTih9rN8UigxXYnhH/MrGpXMqiXNJ?=
 =?us-ascii?Q?uTvzMMsHBrJZYTAXccOntckdebIatk+CEBjZWTctC9hZJ+nC9kx5E2LLqxS3?=
 =?us-ascii?Q?cPWW2T5co4s5iEQaJat0G8lTZne3DUNQSzEXftb1QgNCDYA0pAAGkB6W3TYp?=
 =?us-ascii?Q?c4PAbXRSW5WBbJub3Xir5xvjmPZehQEzLslfgEDSJcCAB3qbQlmqULxum2Of?=
 =?us-ascii?Q?A4x+FADa2LHYwI0PzwiB5GgUpiHIVRQF3y4NK66vZvCV4rOhxsI1R0yrjD7q?=
 =?us-ascii?Q?f9yGE4uqpwewbCZe0tFV0629dgG+fG3ImdjToc6/sHWdiXUIBMKqB2fpc/RY?=
 =?us-ascii?Q?ABffe5L//N3OfTT9yNBZrmD8/uR7dSc431T32lOsJf56OKpOpvO6w0wzyx70?=
 =?us-ascii?Q?yIKibfPnR8NNSNEYWtr9bldnnWBq10QjNHcKpy5V7Iz8/Jz03O7Z9G10RlFU?=
 =?us-ascii?Q?ms77vH3av/RT/TnBVYAkLGeRNMd8LthteC6kBGjPyC8R+OFdgptOUIkvUodp?=
 =?us-ascii?Q?vdL9e0U8X0bI4f47KlPwiUiFY7FAMN0sQmZVVkgfZE6LGUFMPkx1oT44xYEK?=
 =?us-ascii?Q?HDM1Lw4XJ4YY6HQwxadWdBbxGFRD3Ueck7DfMNokPZHiwAjlD3HJ0eCeMCfk?=
 =?us-ascii?Q?CUhr978V85P+OzheeT9r4NxpGoxR/Kp4ZUz5aLJSmNCL+eDX/c4L3e10TQya?=
 =?us-ascii?Q?ka/vVWEQoSGAGywnEnKxCZ6Akzi2gVWxy7TN+WwbfYK5jc9RhgcsSP7if1ou?=
 =?us-ascii?Q?A2IVaZgKY0W+d2TMy6MarrYBMne7rOPxY9aFOuJbUJLtQT9UEbqzS44E4iet?=
 =?us-ascii?Q?/0qzgayoAP3Kw/55zDz9F5XORcrSyGDdqC8/p3es+KlmBIEOGRsPSBFDXqfJ?=
 =?us-ascii?Q?CeQUEPOpUi5LfQen2sZjOkzPho7Ucey54/8RKYpBMndXnLXm6q/wRwgiOphU?=
 =?us-ascii?Q?yjr6YW44S4eqyRNDOQbXzqHp4FSa4H5gUELm5ZWveBtS1pkSP5AQSWSkUmrp?=
 =?us-ascii?Q?nLBXtfZtwQ2VJ/afEFvjXqDnHAZ4V4JNyKVzyCVxssQbM25V8ha7JE1OivdE?=
 =?us-ascii?Q?mdw2SNkVfuP1CInWpIEorDRPKivJD7nQlYB+avWv1Hq+0ugla0eRHLd1jioW?=
 =?us-ascii?Q?Y+FipCe6k0LuPeKIpcCVHwS86Lmr7D6Jic980cx6dQTVuSz8jiTk4vFrmpjp?=
 =?us-ascii?Q?FANB6tIjzmpJpQbVX9Rxe1QXUaiCEi6hkIDBcRkKb8S2yIdbF1iG+wPaayEe?=
 =?us-ascii?Q?VmDTJik/r7v/FVxAYDqPEUIfAaWb8eCANea1HoPK21uZNaIzKZQr8vOHu2Ic?=
 =?us-ascii?Q?uLXCSq72aEaUrrHG+0gqtAK9TUcCQ9iFw/ACQfvN1tsSYvJIil+KzC9eaZBo?=
 =?us-ascii?Q?u4ILyYLlLgAFA32fH1IQYRvIpS2NkfznMaw64O8FCC8f5+omJ1bcI9kNezco?=
 =?us-ascii?Q?08sBnsqwlQk8O7fFVVee7H2ECd09rqfst/cUGQgsfofKqqRSwcWpVuGNicJV?=
 =?us-ascii?Q?O8pm9OopGMwxU7OMLfUq6D0=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0578a5-3b2b-4141-c1ec-08d99badfe4c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2021 14:03:04.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4gcyqSowNBepm4FTDjDNadMNhba/QNiM8HQ/6cMIuvXrN3EBaSIQI8iSRl8Jn49ZK16bhZ796LFxjAkESMmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return pointer of mtk_alloc_clk_data could
be null, adding null check for all the call sites.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/clk/mediatek/clk-mt8135.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 9b4b645aea99..41c0baab6240 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -526,6 +526,8 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return;
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
@@ -547,6 +549,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
@@ -575,6 +579,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return;
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 						clk_data);
-- 
2.17.1

