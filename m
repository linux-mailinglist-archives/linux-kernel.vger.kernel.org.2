Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFD36E546
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhD2HAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:20 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:30079
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230176AbhD2HAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrxCHZBWD2YvHnpIiaX/V9krcRgtt1ulZX8m+mJHRJHnCtBgQ1n/srR8g3dR+CoE3To44GJeQDpo6kvGCKqedppx6Zr75wOEpbX8qdlbBQZJZWYJItk5/uaET57R3Zs/hu+5s14W8UbikfNH0d2Q040XSqhXqJ4JNSOhXtpSzjYovvAory9rHo1wbGtsQvba62ufQG2773p228C7PYqDvxdTSwLtvUDrTWzo8/0JVnorBuO33wBjyzfqf3HIQ32AakYU/wQl0x2gpu3SIGsE0nrUWLwHJs7YfT+FrKi6it6xFeM3CTG4g/GPRSl8ITWoqnxo0R9DvJZfXcC1TARhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXRynR0ZkCJS3uf+R1SbVjZzRK5OghHX49NejId9ItU=;
 b=Xj4bOkrnlPKX9FwTWkotmhXYmZK0dJ9bnDs+qi8N9ZS4P8FUEdeoPXbjiEg6PVI6YJBTD7uNt/XQUttMX+0de2YL/9/UwWxGjm0F7bKQFRrKhKMRY8VVVOj+tS1OssrasS11uEqKvxHvEgufciwQEqDjA5nWrHtMEv9V/czd1f0Tf7ucM4T63qWIS0+qvttkDS9oGtts4Punu85qjt31w2bF7PYZLO/iGHMlRLAAn26ikwfNVqoPpQOcm9Kw4mRAFHgvssi95VfPg0hHXQu46Dbj76tXgw7DJGuidbxauBxQkG+QFl54+xzft0KGcp2o9qBSqceKep/ThqeaxCaK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXRynR0ZkCJS3uf+R1SbVjZzRK5OghHX49NejId9ItU=;
 b=Ge74s5JH1xn1Z+nZVv8NJrkOa8gdJP7LlGWUQfKAfIs2p9jpIkmDPAMZlHGY8qrRWwdgpc4XryWRj33yVBXQarEeG+LAc37npfxJlW5Yrgu8D0FfkdDoKNWbKLGJ4OO8ZtMmUv8z+MFYhokye/aGeuLBW0KgNy/WZ2CQ+DhmqJ0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:22 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 03/16] soc: imx: gpcv2: switch to clk_bulk_* API
Date:   Thu, 29 Apr 2021 15:30:37 +0800
Message-Id: <20210429073050.21039-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9f3664-64a7-419b-eb78-08d90adc5127
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468D43F168060A200FC8565C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMhBC/0K0xKjtpFKyI9RO+6VI9LIOowMTgY3f+y8+p0TERFw/1lrudiFcUlPb+vpqO8VXfyayOA2i9yqSB5P+AMsQuKC1+4N2ozK3IbHW6rajw3iQL5CgswLAWW92FcR8wAUp1FNsvhF4BIzKQq6s2LJAe4zOUQtfGIqCv63gcmI2NOeoU9oBL3w4JnGhuL7IQHQOjkT0if7tNfslp6z11imB/i1n3Lft+J/Iv7VoxDTa+Icqy5mKarM4FrrVaR6qJJuXKx743HSM/vCAeWQ/odg3a2eWBeyE9gq7Pe7SNJzMdr2CmUDjRKaXqwdj/qhm1AliWl2mSJbRNzT8Pesq/LLliWVyu3JCW3kbRStq08bRw88YCPWE0Z3gIzP9HwYH4jT3JrSyejQIccjEs4Bb6IyMZy5SDRMknjZZ+xzDvBno3kaBOoO38Nud8eWPoq3Ss0w3fu9ujtE/4tqNnqVFesI1AtqjHSWwilZZ3F2alz22Ml5df6G+b1UCPHVEfXnJdlrCnmZOBopp1m7chSw13XsV68k9kkRf1iRSjApX260jeM13QKrXauTjOfPuJ66233l0GmV5tF0IvJY7NZxpLZX8R7MwVWV2sNAG9BALZB21dUVrezMPHjZw/XMrxfsh21VQhBSo1pZo9jV9crCkZ30IxLirIGHCcbZfU9Vzo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CS20eYbjbqwD4fgF9q11VJjtaZ95tBf9651S36r2UdKV3HGIi/rIiFVNGtlC?=
 =?us-ascii?Q?c21/YHqHZpItvlrttGKRcppfJ7tEzVWn8NLFR6ordcpFQFbiIWpOVqKL2Atg?=
 =?us-ascii?Q?TJ4dOJOFZoWwx+OxQtACoEXxIy9CjH3zai0rZMn9XFBUvQVx7rZ6pZKQ3146?=
 =?us-ascii?Q?uUwFG+p7sFKrs5kKjNy1FMIklkIQf33sXcL1g9/Z0SQaY5qX9mH2UMs9zX7u?=
 =?us-ascii?Q?SzQ96JA6tzfkS/x7Vr3fl47Els0iHr4tNDbZUA2F4cZzUnuyBjWe0SOXk8Mf?=
 =?us-ascii?Q?FdvfFG3NLEOI0BHzJ6AI4O8Zn58QkzAva8eyatTAFILFBgP2jpnUEqfxZJz7?=
 =?us-ascii?Q?bSr70cnOsJfKoIluedtBtz1S3jvza2FImvNIctvmpqaXOLL6oD7b4MsFoDWH?=
 =?us-ascii?Q?waokk1yehTMCxiHv1+ehumRI7enuJxvPtRhLOxh4T3BA9H1kRu+WoU3tL1d9?=
 =?us-ascii?Q?UoksFiJpzAWxdtO9A9lHgaUJQqP399tW04uX7RjKPxbJRBW8jQLFRKuR24qY?=
 =?us-ascii?Q?In1hJLsxBx5K9Qg9xPpfc/5ZJ4FGdgbpXin2s8OaO6spimHGDkL38rlMEbeK?=
 =?us-ascii?Q?lt2YRrxuqW4QkBevMMmCSjUHCuiGDPzk0ol1KALng3Onlq9yMvuEODtGLLNq?=
 =?us-ascii?Q?4IP3nlb8yVCnCJ92EfG/zS9NCDkxrKLfja2ugKGCPuwMttd2niRWZwZCaj0u?=
 =?us-ascii?Q?iMj+DVGEYdlFU4B4e9ERqPvD+cobrn2+kIBHXqYdIA8R2IHguldcGZCN9VBh?=
 =?us-ascii?Q?4RTBxZWD3vOh4KrAjCew72MKkq0xr+lk5X9iHVU248137AHWeAKVnLpuHuTM?=
 =?us-ascii?Q?mxYoUsWiUREfJGvI4bxgt9dEhtWPB+T9GPLORwFIco2Pib3s6ttbcSmYjX3m?=
 =?us-ascii?Q?UevdREs8X96qDGd48mZrJj9ed+zMx4SIkf7FI6fsXlsNslXqEv3P8uYUWs/E?=
 =?us-ascii?Q?ePTt1/mUTAs5OHMpcJRnP+8VHWxnN1F+mQ6dTfGnRX8VFTxYT8OqfHZYQwne?=
 =?us-ascii?Q?J9VER1my7zO+d/rdkxGV+U7juqqaQD00B5Z7yqF+EON1+7YnUlHhwoV9cgHU?=
 =?us-ascii?Q?DF7qBfLxJkluQazTxs+beFrF0lhy/zRQnK7qweHdtZBCH4lrwRUdNlnwPyvs?=
 =?us-ascii?Q?MZUNPRwRN3gRCm2KSGjQxbAUV2XhTkqIaGbGdIS/TIZfZfOSdXp3iN2gSUwT?=
 =?us-ascii?Q?mbAshP0VWka3yR1XwIn/0qUGkOtSolet+Yxgu5cagX6vhaOIjbkxFPFd1/+O?=
 =?us-ascii?Q?mSBbREsX1/PTpR1SYyAlTUr1xYa1Pn4y72VyV+FbAnxYX4B+faUM/ZJs3pBi?=
 =?us-ascii?Q?brISbtrAb63oVIN9XL2eMHIl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9f3664-64a7-419b-eb78-08d90adc5127
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:22.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCbP9QzSbFUUB6HYKED957OAfG1CifW0aBfUWvaz/nCHYJ1gomTBA7P2qMUNx50ai6PUrwza1EVjxi7WTvpOwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Use clk_bulk API to simplify the code a bit. Also add some error
checking to the clk_prepare_enable calls.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 60 +++++++++--------------------------------
 1 file changed, 12 insertions(+), 48 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 552d3e6bee52..1d90c7802972 100644
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
+	clk_bulk_prepare_enable(domain->num_clks, domain->clks);
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

