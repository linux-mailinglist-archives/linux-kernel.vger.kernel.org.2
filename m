Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC744096B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJ3OMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:12:38 -0400
Received: from mail-eopbgr1400104.outbound.protection.outlook.com ([40.107.140.104]:6893
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhJ3OMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/ZFoCnFCFjMc7c7CpNHEjuL5nRmUAbs6KErPfR65G1UxGatuLRO++712dg07olLGrsMmhp5gcmB2n10QfN6S8iQx6ZhAf2wph2nuyvtaomyh3mXApcsJS6K4zVogQ5LIs2tCQ7weBTXW1rRxVD3DH3Ndx2zqlZC2osjdqQqC0PysvjL+k09homgH3DhtlnKyxB7ORRgMp4/uuij4zwRh77Xdv+ElQ+QfGrajG2xavZkmyEUEAp2XfsNlip/OvtpuYGwCP1cczteaR0ZCfRM0ZA56sL3SUmKWkRr2ZiiGJy4V5vcCIUZJKZyQb6tOIN5nKdpEdYHFQ1eWpyF5NicMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFV7Y9SgwBqBOB/PpEYqKo8BBsPPFuOc3U72orNQXw8=;
 b=EG2y3BwXLmAAv+yZzO28AdvMwQy8sps5uStBge78iAzYsOEq8EgnrAVMYUrGWsR8CSB3yqdVTBoIiVIw1WuiFjiCwM9R+p4kw9ljz9uNBx+LgsFm8GZVVUtMK23xk4k1Ng0tOl53nhDAhbUyZ2nE1BmLTdo11Bw3GM9qrKeHNnTuNU2StnxQTn5Ynt+v7IhLixBqSaBXt1PvD1oloey+AXgH3huyGWQXJ+fizp0/p3VTt2a8fVJqUJh7dUK+UCwvteSqGQM3s9rGpJxMj38hGGGgMy/lumTVHkpCFzHjVrTBvqv7GI7I4vuY927FgFSoy/XMesE4MhW4xrcufLw6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFV7Y9SgwBqBOB/PpEYqKo8BBsPPFuOc3U72orNQXw8=;
 b=q6gnj4JtvdYsTfgvYgIGP36Le2rsEP21iOHxKXkm+8tDDC3WIhw8JvG36op8iVmi4ATynWA+HhRnwCplVGMGBSyDQ/TMJkd/lSTcBY/Njty9yztdaD0E2+OMnVAScoHxy5KNdLe6UyfG7rA/DDR2pn4IgsvLlNRBKRPcbjT/CUY=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Sat, 30 Oct 2021 14:10:06 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.018; Sat, 30 Oct 2021
 14:10:06 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] clk/mediatek: fix missing null-check for mt7629
Date:   Sat, 30 Oct 2021 07:09:56 -0700
Message-Id: <20211030140956.7442-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Sat, 30 Oct 2021 14:10:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf82892-58df-421d-69d8-08d99baef94a
X-MS-TrafficTypeDiagnostic: TYYP286MB0985:
X-Microsoft-Antispam-PRVS: <TYYP286MB0985BFB739CC9145F8302C7C8A889@TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1QjSt367lqk1VK80vMEr/exCXeQOLrutV0wMNcSW0GlGydyV3dQoLuKjgtbrdqon7J1mlvi5DbYZFh71Fw5kUkKFK4BuSnlExXcJisnI37TF+gnc2OoGUrPihEDppReDNSncmWzjGxC86wUA2cSuG1LvqZ8TWI/uTXl/e4JLRk6ZXd4XY5g6IuIpWqoUDm0Gl+uND2W2IyxhUwTLLytogyqhjghFhwEohTOxqgcAdn1d3Rp9760NmFqLR1RS+A589DOyvVLxPEpnE3Cge7KYl8lKepRjUQzjlQvtzVlM2hElBDgsooKTJCeFHNRxKHWOHgWzj8w+hWq0Oze8nSatP+lrqAuKvKpADIfar5KJ25qC+D8JZjCt2zIpMbSKC+BLUItfrQdKMFNwzS+Y18rgdWjWbxxhD3EGHlQKhgToOO87wBp691McO4qjjJAOajfkG44Slncwcg9KforCEdy0ci2G8lK3h5BaDIC7n62HtwxoYFO4A4G3NSQS6GSIs2/IcEwYGfjTED5c+jVQeZZVKtjL+0OnzgoO+k/jyxBtQv0Atz+LuVUwywlNt8ZiDxwh5V+x6+/aeMPzXftfi7TWnBq3hXERcnUDu6LsclbKmK0qDh8FeDzHIDSEG45Mq+ywQ9xapVsyuVFso77/1NS/f1dqTCB3VqtwCDmuxQr7rR7Bx6msNKGwqi0R7TLYeb/P0AVLZ5+nqbJ6dH7oQ0jFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(316002)(2906002)(38350700002)(956004)(66946007)(5660300002)(26005)(86362001)(2616005)(38100700002)(6486002)(66556008)(66476007)(786003)(6512007)(8676002)(6506007)(107886003)(52116002)(508600001)(8936002)(6666004)(1076003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uilCotPkF4a5ylVOu8cJ05O4hOn8WfKcMVRAWPsO8C8cknC+dIle8iMXX5iR?=
 =?us-ascii?Q?pLvuMPDxqn6gJ2XexIpDZwZFZJNmdXplB4Umi9qIld8IcizcOc3xd5YJuOnx?=
 =?us-ascii?Q?mQzvc8RS4YbIVTXa/ullK8IThSqNCEVopTkdyxswtC0313LiObU/mFVlccmW?=
 =?us-ascii?Q?Qc5lgwz6ACac3abBMoaXg3f6DS/FMsU0/EGZIh241Z/kUweUVxO57v64u0NU?=
 =?us-ascii?Q?OkR7kExpVS+mA9IViYFS8cQeBNf9rv41BjRH4BAuS2trTLqkcmbHu3FTGDPe?=
 =?us-ascii?Q?Apk7mOvH0UFF/cHGgNXTIvkjasSkqBWBkZfloRn56JEOtvrBq6jWoxIFR71s?=
 =?us-ascii?Q?azhvG7qJSmi9nln3SKpAUXC/Ui/GDSW2RwLp9Mx6FpvOFzye6klqFAvq/qlu?=
 =?us-ascii?Q?jV5gFDopafMgBNYdovng01J+apB7Y+I1FYIBRSmsUMmTo1SL8VUSfPoRkySX?=
 =?us-ascii?Q?irFdHJ05iIXpsd+vE0L32E1+be2wMqpnul/ocGNVTTCFS517Ds0zXVtOQtjb?=
 =?us-ascii?Q?2fKrTo8zRtzsQ4yGZobxKJDzga80CaM0RQ3J0AT+OoErgrVTaQOREEN1ZtqM?=
 =?us-ascii?Q?0U0yOhocbiizmzAIHniqQDtRnf+y2Ld2z/weeFUQHQinouOvll+erJKkSHkm?=
 =?us-ascii?Q?lsncAKOKXuYY1zG1kylkhyw+DggYh66qPLyVo16eKnlF9VWuVlBI/SUtkVa8?=
 =?us-ascii?Q?GNRvdWJIUJ9X7YoHhT9rhmCE3g5fMCrAMY92Jhx6tg9gv+/M8JNW65wznA+R?=
 =?us-ascii?Q?vJO3c7DNQFD+Li2jMwSkht8mwVfAs8wAUKi3jco95ikPUw2e0WZLyMkIIuhd?=
 =?us-ascii?Q?XAqHKS2mFnIYRIBi23mG/THvNZuf3dXkngScI6MonPx1VL6m1kfArZe2xVBV?=
 =?us-ascii?Q?v2UcigobpMEuJI20R/KI0z4TRR+S0fQoeklkPUaBpkovoVGKXU66mqr9ttvO?=
 =?us-ascii?Q?JN9vvr3N0haHExtsu1y5biAeUVqMrYE8qzTuD9EdB4WLpVtG8QAtx3++cUYS?=
 =?us-ascii?Q?NKNleCUfqNlazCMLopulvPU172rHULydjyfGstfioZ17TihYyAWQNcNSxJLT?=
 =?us-ascii?Q?bwMsxxWxzWixElmXWrgqJ7C4kVsRn05Wk67Z71+XAchxXwP8puaiaAHelM4H?=
 =?us-ascii?Q?E++Rg5crQxZgVUkxPk819e9bfPSIKm0G+7MXoiqWyg6I63V5H1QDd7Z5Lnp7?=
 =?us-ascii?Q?8YxqObRd5RUKeQcJBDJMcS4GAPesr4naU9SjxirsVH9DISjUpl1YPIbPAeo2?=
 =?us-ascii?Q?mh3n5qP8SfL5nE+7i8AMsi2//AjWDw8hKPzjy+eNvs+HY6fq+oVNUOm5Dl9N?=
 =?us-ascii?Q?mU1LsFJdPskcj66PyFklCF6raRQ7GxcAU3njzoajZ96Uwu82BtMRKIu31gdC?=
 =?us-ascii?Q?fFgdGYazQ26uKiUJvKw3BE1xb7bWyop3d67Vyc40RPJsRNUgBnikby+/rLqa?=
 =?us-ascii?Q?gSs5XT5oECErBcBTqYu8ASIisNhmyBnrDMeOHXg6WpEzXXo5J85gLwR3CGdn?=
 =?us-ascii?Q?G+fqm8f/8WOMHQfO2dAzvfKrdeiuwU+vO+9j1wV0dcQJHlG6uns92zNH8vNO?=
 =?us-ascii?Q?1tavjScqoBPe95iSI7/eide8puo2zx3UhQPV+HnJZzir4dNM/4Tmyd+VTFaF?=
 =?us-ascii?Q?7ntJW+Ep37LJAXy/DtqI66g=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf82892-58df-421d-69d8-08d99baef94a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2021 14:10:05.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/lg78tyndzDxYDhFPqAsoSrylbdv4KGfS27OVIKAsyym1RNq14IHWgWfI3f8BSUqpu+nLNb89WZNmGuckz3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return pointer of mtk_alloc_clk_data could
be null, adding null check for all the call sites.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/clk/mediatek/clk-mt7629.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index a0ee079670c7..f791e53b812a 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -580,6 +580,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
@@ -603,6 +605,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
@@ -626,6 +630,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
-- 
2.17.1

