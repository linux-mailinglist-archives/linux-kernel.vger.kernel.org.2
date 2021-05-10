Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA7C377A83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhEJDaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:23 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:2222
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230312AbhEJDaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSphag6TMof2N9IdCDzDRqdsUwiSpyH++exl2vb8INM9JcnkJKzDHGtC2RGIhT5TEcbnkzplp4ldcTNefx9DLDd5w+bOekd1OAMqR4sWcXU/T2yXAgdYNo+N07A2R4ZM7gwzSbMno2Jfr35ga6PRwvJV4n20GLznxbp1pQAN1m5VbWXB8w6wSd/h9vZlnlxiLWQgABuMKBqbqcy5mO9ggyLViNz4q/A7jhCujOyyPQXXu6ZKCNnOc3w5EWzasK7XUxeDBKuWxOSvhGbpM1cR3pjO3E5MegX6O3UwtPEyvaln3HgcDbQX7bKGsTD/UB1ikmUpCTBq8NRk61v42dh7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/6UZkZw+NFTrcNzoryPOEUoazojZwuqYnxPoEC9zIA=;
 b=aVDIXAE9meRIFUdYpSdPrZ+5HKdzTLPGjhrloASfGrYV+JAZ3myXsXyO+ldN0ty69vyoUek8dDWRTQqWJA7jssPSrfAQvNkS3j2FTXLMeuDdPdxl2TQji9ZGp0xoU2zKQuQRTB8nxcysqtzqc+6AuyRc0PxT7TfNhXUO3f3SHpNPy3lPEsc+Fas3uyFbQuIeDXArz5kFn1f0uNfBE3UPVxzl7IR6bKDfPn0q1LEqH9ghXUDo9cRp5fyK6B2j+FXavwDS4C79LCKO7+tGOOyM4jrpC76jj+qbLm/mAbhqb1m8ko5VsHgIvdYOm/uaUpBqpBy0z6bURvNyWu2nkXWamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/6UZkZw+NFTrcNzoryPOEUoazojZwuqYnxPoEC9zIA=;
 b=BGUQEa/zrBLAO2muQIvQAXPVSQ2GFKRifrH+S+RFWWKj6F4PvyeUqYJaWtc/oN0RQe6VCiy6KGpNX6beg0XeDogJBLECkifEqZOIz6UH+VwdJabiX7xJ5yvTjnsFNKMpGFDB4W+2jSscpZmaX9wbS8c8n/QZXbhHNKUmiOGav6U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:15 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 03/13] soc: imx: gpcv2: switch to clk_bulk_* API
Date:   Mon, 10 May 2021 12:00:35 +0800
Message-Id: <20210510040045.13225-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16373e49-45fc-4e10-b5ee-08d91363c971
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40918552316A72F6530AEFEAC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdnFB/XWuV8OOAK+q/ujr+jVRGcQGGtBnr0Jus3WlWvSxHUyo5TBPHPD2MFkdukVXdPz3X/E7SwViEsJaLNsl78xxARgUqKnZa7flMKSeklyRNbVkGlytBcAL5aqZccIaZyDZVxTatwQKa2PBXSxL3jlt4tNP0miCZSWQHAfowT18rwcI7pwAykJQ6d/rWlZT55/s7KclsHkOuejqGgmBiF3QRGKTDF+t583eE82fDwH5q57/xapKmMOUlial4+MlWMG3KAq0DrTlIyO37bdSqFXf4sWZce+IDBlTTsaHdtvXfZHUNvQ9QZZNlVtMwkC8y10XG4GjNjkWk6wVkENNjdYwGOW/oVBsKLxAzAYhYfgkQLi7ktRBUefo/VnmSPZ14McF81O0GCdxfSMGApMbTLDHA2hvpf1GQic4iMR7Tb7ZB4If0YKhWAwWUp51ZwtD3cT49RuHsV9me5xrYw3oAL2NaW9rT2l/C0kYznipC6jo7MRns3hwSzKIyyNQWDPOeOwAf1VRchiyWiCBUQ87Xz1+UpDGva47yJ23qWv9FyBLvdikKSoX8g2hzSyNC2O6poR2oXq1k+oMH/GK4zC5KV/p8cJ/1Z+TS14WRXmocWgXzwXXokIFpmh/kAVy0USA6OBbhMmKcG6+N8lk0UwdTCmfyAZ7+zQwL6uQYfUbPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fTvTCgCpxdxu8NW/8lL4peB74CYIGcoOJHGWXKZmOIGMmxuQNp4A1SB5IpGm?=
 =?us-ascii?Q?xpqIK/gyaBsTd1vi50bhpoReDgbjMQEFNiwPRAVDPVbtKTQaR0gg5nJud1e/?=
 =?us-ascii?Q?yi+XGi8e84EjiofuB6wQRPKyUgBa3MtRqgLYmFvnYtN7XRCeqZfvK3qGoNYv?=
 =?us-ascii?Q?J4KkEtx2HsVqvWUgdr/ITIomltEZmthkSQ5j6GPH+RYnzNhs6uMdNETz4S//?=
 =?us-ascii?Q?0kb68be3XukBJfmUJh7EY6av+oAaHv6hOtWk7FGRh5SAzmPqSHamfwUPEyEd?=
 =?us-ascii?Q?2abgt9fBSpS2djKsHgeXe3Hg2sJcpHjY4Zxh7OHhv7MAQAS0rXCwtw0bA6YG?=
 =?us-ascii?Q?ZNXjw/3+8tvGFcYxD6GkpC7jVac+iRzpS8PfpeqhnXdGW9/Cd01j4JvOfnOg?=
 =?us-ascii?Q?DdJcTsk4Gz0Xed8iqH3AXaJCZ1txvVQiyQ/q9cW49zLDROK7UhW6RfcTsvsR?=
 =?us-ascii?Q?1aQbFFKl9beq5KyIRTtN3VhlVfxxMXx5vNDsufGxg3zONTE3xLG4QtaYrlMS?=
 =?us-ascii?Q?kbbwuw1nu6ixInJUjZkSWoZeLdxTIZNyjPdlgDyXp87+HEVs1eqFlODbv+Ia?=
 =?us-ascii?Q?9TKn+LL9MJ5XMd5UnzBnNJHca/o1tt79Nci93zv3FsmaVTmDatVmFKZ6+7zz?=
 =?us-ascii?Q?vMB0Lh7srcJ781Wn/kLjAv0Hi7xp7/eQ+DntjJISeEv6fHq2uW/TVqh/lINC?=
 =?us-ascii?Q?UedB/Y/kE1lCV47jaoPqz15jhINqdsp8FxQ7T8ZeSk91Drmbd+FWcii3ZNsO?=
 =?us-ascii?Q?5jl3YqEpinPTDz+HmQTtBKR7W0tUBtRp/Hn/c/zd5o+4rkLbDC9CPIgsP32Z?=
 =?us-ascii?Q?oPaRj8mGwahwxePgubJpJbExvCV3TBruEcQ47cuQaX2m7+T/KScoVpIe0hj7?=
 =?us-ascii?Q?8Pk0ZX83gqTZZsIoo1edQLNK5A2ICbV1Y4y+uyLVEgZeUC+ge5GeUrAHz0kl?=
 =?us-ascii?Q?bAjVAm+/LDcvivflfHfRvb4uCUdLfKLxmD0YOJZbFZ8DuWpJdBDuDkSsUjbi?=
 =?us-ascii?Q?6rVD8xFLuYnVN8yrRmoRP/TwM8L73WTa/ZyhiKehVKZZ4brQ30Hh2bxPFm4Y?=
 =?us-ascii?Q?AkafPKM0mo5wye+qu+OwWw+n3yxBu7UcyHLhlPN+3aE3v9Ed+W+Tx5bVb1Td?=
 =?us-ascii?Q?bu++egRyMbHWnqXH6KsE33R2QfDwaBeo1lSGORGXbCSXg7k4EFh2IDCsPzFq?=
 =?us-ascii?Q?2yx7IGriyhBq9lsc80KzjbmeO9nOf/RrDpn9Kr9FoD+3DrzvxxJ2d92E8Wcu?=
 =?us-ascii?Q?Ywak8ZTM7oz1EIhZmcT2F0wQVrtk+YmoKXQK/KCTGfduyKP844CYKKLK9qWR?=
 =?us-ascii?Q?KcV4hA/8M9nLzp+uZEhvM/AK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16373e49-45fc-4e10-b5ee-08d91363c971
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:15.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1VM8QatkVG1tAhdxs169prWsrbl99v8K+0XsT7+qo24CxVcZ2s4nCt14vPBTwaQxskDVKFGTB8Rwzd5jiHiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Use clk_bulk API to simplify the code a bit. Also add some error
checking to the clk_prepare_enable calls.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 60 +++++++++--------------------------------
 1 file changed, 12 insertions(+), 48 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 552d3e6bee52..4222b6e87e7c 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -100,13 +100,11 @@
 
 #define GPC_PGC_CTRL_PCR		BIT(0)
 
-#define GPC_CLK_MAX		6
-
 struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
-	struct clk *clk[GPC_CLK_MAX];
+	struct clk_bulk_data *clks;
 	int num_clks;
 
 	unsigned int pgc;
@@ -149,8 +147,12 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	}
 
 	/* Enable reset clocks for all devices in the domain */
-	for (i = 0; i < domain->num_clks; i++)
-		clk_prepare_enable(domain->clk[i]);
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable reset clocks\n");
+		regulator_disable(domain->regulator);
+		return ret;
+	}
 
 	if (enable_power_control)
 		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
@@ -187,8 +189,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 				   GPC_PGC_CTRL_PCR, 0);
 
 	/* Disable reset clocks for all devices in the domain */
-	for (i = 0; i < domain->num_clks; i++)
-		clk_disable_unprepare(domain->clk[i]);
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
 	if (has_regulator && !on) {
 		int err;
@@ -438,41 +439,6 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
-static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
-{
-	int i, ret;
-
-	for (i = 0; ; i++) {
-		struct clk *clk = of_clk_get(domain->dev->of_node, i);
-		if (IS_ERR(clk))
-			break;
-		if (i >= GPC_CLK_MAX) {
-			dev_err(domain->dev, "more than %d clocks\n",
-				GPC_CLK_MAX);
-			ret = -EINVAL;
-			goto clk_err;
-		}
-		domain->clk[i] = clk;
-	}
-	domain->num_clks = i;
-
-	return 0;
-
-clk_err:
-	while (i--)
-		clk_put(domain->clk[i]);
-
-	return ret;
-}
-
-static void imx_pgc_put_clocks(struct imx_pgc_domain *domain)
-{
-	int i;
-
-	for (i = domain->num_clks - 1; i >= 0; i--)
-		clk_put(domain->clk[i]);
-}
-
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -490,9 +456,10 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 				      domain->voltage, domain->voltage);
 	}
 
-	ret = imx_pgc_get_clocks(domain);
-	if (ret)
-		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
+	domain->num_clks = devm_clk_bulk_get_all(domain->dev, &domain->clks);
+	if (domain->num_clks < 0)
+		return dev_err_probe(domain->dev, domain->num_clks,
+				     "Failed to get domain's clocks\n");
 
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
@@ -517,7 +484,6 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 out_domain_unmap:
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
-	imx_pgc_put_clocks(domain);
 
 	return ret;
 }
@@ -532,8 +498,6 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
 
-	imx_pgc_put_clocks(domain);
-
 	return 0;
 }
 
-- 
2.30.0

