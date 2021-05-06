Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2F374C60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEFAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:45 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:8576
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230033AbhEFAdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEPPGOli8yVX4SxOc7Luw1uXvCLyVg9cJNOwYQ7BW8LhVZi9v19qqR1lCEt250XO1Cd5oZYvb6sTv9E2PX2EQAIWULnzNSmFsgdnehElkOtapXFSKRQzsI43sO4LUC4sI5z3X9ZuZry5EkUfpjtpTOWfjG5hMNJN+Eb4E4POhQC5oqHZP31tAkZFM++KUDEYZYdywZXK0nWMbL3IzP11+f5MI7XTSqsuUZlh+dJkvTwRr51VgMlZ7Xuz4DSh6ylXfDQcBRo0k0+0r6xSww4H2hKkFYE/95CmOL1tb6TnEmu5qSjS60PzsO45aHutEs0s6ZAjUuYd/bRmIjqGKsfHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apTgxsDDu7MmEcc1j3aB7YJcbDuiEFS3xchs7nSKczA=;
 b=RloQX0x8+P7ZKIERieEikpJhgQUW/zplub5Q5UGlyxTym6ji4j+9VR+WC94TKb59xjFQy28DG9cEOW4aQzl+zsOPgNzh+kn+5INTGhNa1IhWUFnPCRR0M7FrpYkb6moWUAtT7T1Y+g7ebd4NQywOx72DdHj/soLuRIM4a4oD4dQHqiS1j7w8tohjpD/4MrsoWWCaOH3ripieRiu/xJy7xWEfR1XOw7WTPgc98qVWKFL+SFnUC/zi4QRjchMxdZnr3OYU99o7j7aBedgWG3aHV/aHQM9d/nxQQ21d2cn1y+gSqB2aehESBlHzcbljRSa5jfOhfwXPQ7vg4PYs/zIh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apTgxsDDu7MmEcc1j3aB7YJcbDuiEFS3xchs7nSKczA=;
 b=hmh1i0ilG1J56Usi/FeyAOCm6Nb7+icxXZnR7OQXYCiLqgZiIVC7k0CKVW22ilEUeC77C04YoBeLziTbCS0RlYjRF4Sw5kFlrYA4mK/N68zoddgFDg5K4j8jJqx5UuYvrA8yMZq9M3f+CBAojDTph7oToRAj1QioJv5UCIbdcyE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:43 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 03/13] soc: imx: gpcv2: switch to clk_bulk_* API
Date:   Thu,  6 May 2021 09:04:30 +0800
Message-Id: <20210506010440.7016-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319fef44-8fcd-4f5e-8586-08d9102676a8
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6714D56AFBAADE752AEB281BC9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qfVRVEx5RTJjucKIRwFcryt64gm46Ur0J2oDFmyAwOeFolBAw6utaAVrMiNbKqszOP7JXrnSyMBl5SGK5gYYON8IHua1ye8I6jnjNfHqHTQf240+JHHzotvwnH/V9/FPs2OsrO03XpVaiJEkpRMkdsnahzZXHZ8UBs8S/5E0kj2EqltEQrMe07VUoGhcmAirzEXY2c8esbyNmC/a73hfiBR52bm/0K2Iks2si09mBRutpEyhrrJUNP3fRc+Q2cqMJkZ1FrDTLkmwRWVupMwnDKzaTm07Plvq6HjloJdUoBIINH+nZ943q24tJesm2DcGOGoBJ01MEGOW/HmQjqhQWqKuue2C1a5OOiaWtGjaOUQQEzN3uSp+NHwmMwJASwg+xaPFTyuxsTDbv34z9gxC9uChlZgA9Vh7ENbqXtdqXM44XHSG2miuNWWJBdK9JEmoIgvfIemNlbedymiCCEMVLcq/N/9HADZRBLxhNlhTluEePkO4jdkI7NVe2lIDvf+6NKax3JqCGa12wtRCHuHRwn1Zrr589f1+a/KeYzed9wQmhBwsE1zlkl01qaEyyiYv0rn/Tyy2DKaJwYuvPEIgrcO+BjDVAYj20t6AUta+xd1ZFkCrlz8tLn8AfCxXuWeZfYW5BvYHJS548oGn2/e8BOy3klM0bdmP1DmWXWu5k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?khQvWkyiFUE1bGK1YOOy7zGeMZpt9XOBpcN/15aIdUImJHiONlmrePxfhmPz?=
 =?us-ascii?Q?yiTL7ICD6bXNUSL7QExqFaExGMr6CBk7PN2JyveA00vzdaprpaiB+dOhKwBI?=
 =?us-ascii?Q?+w+WVQZM548IittYhi7lMAQeV4PctsU0l4AdjCXtJpBwRHyqc3hhdOKAaPfC?=
 =?us-ascii?Q?jVLNy3J8jBNazSYTVcmwjiv341XNAPbHXVAlySf5YBw5hgMeRpBXogmqtiZ0?=
 =?us-ascii?Q?9ox8YURld6mGRWL7XxXaKPtpxCLaHF9boFa8By+gNe6il8T6EbvObGWqyOIe?=
 =?us-ascii?Q?UOnRwIUjQY9DHSjbkJV8iRQtqWQoqr4JZByEmlikxhBdZdzMTXUr7O6W1Zm9?=
 =?us-ascii?Q?xBJvfnbxPZFrrwgbnCbEFoeqMDoSrqQtVkNgFnzsZz5IvYPV54kEp2GIxKrN?=
 =?us-ascii?Q?51hPqfOR5umqE6lA+mA9W1UN7jA79pbKUDsLR9y0jTAwLCDkSdHLAshwnNjL?=
 =?us-ascii?Q?jfYQpwElxVpqs3dnUssO2T6nC+CAkVqzMowv0U/6M/eTTCXsDAdvBGRarxKj?=
 =?us-ascii?Q?WWURuCl22/Di//8miNfthB9BkQEbJXGnFG0y9jvyZY7gz5kykuQwrlMyTNVh?=
 =?us-ascii?Q?H3b/lV3b0sx7PTG070oo+Okrgz7jrLB7ksnJkk71u5qoZycRMmsRp/Dj6DMk?=
 =?us-ascii?Q?c38C4l4u+0cmfluMBnOMX6G7TifQ0dkcvCj1NYK11Y/ykyjvxDqiRVHzriHE?=
 =?us-ascii?Q?zQXst3cZju4DRg213g2SYfH10leahxAFbIR5pwhUWpaABgA74odl/jy0mrWm?=
 =?us-ascii?Q?e1RpkAtuayT2G0zoyZjHFiZj4B5GTL785f360pApx8H2vKjgvOdZoAZ5qKqY?=
 =?us-ascii?Q?I8kjXcqNpACjUXPI3LdvAw0O/s4fOj3iaTNbyT82uxoli6wSGMr1AWOBzzHr?=
 =?us-ascii?Q?dBn9un0tBhaFUX0c5YtvtmNmYVTxWrIpPpGwnqjmMbWteCBBJCe4MmkHxcAV?=
 =?us-ascii?Q?1jPmVcF0CBmC+pWh9OgcF+ch1TciMYrwIK3V65Wpd6nHnakp8xcc+QMBNkRh?=
 =?us-ascii?Q?veX5X1DegW2AcMCc5xeTxcKaNolR7RpHRSSrOYnsr9FFx2OMY//mzLn/V+Iy?=
 =?us-ascii?Q?vdmX/VcG2prWx9/N4KMNr2/5wLYHm6ucGB7byU6XY/PAIzS5W4fALvaORthZ?=
 =?us-ascii?Q?8pv3qtsvvEiE+WIah1GgY9eMHIaM7i4TYLm96mIjOUIB1T8SFSl3BzxHFaCr?=
 =?us-ascii?Q?rJCEjK1SEeS1zsYbdFMHcMseX7K2rB2OeWrRMedSJzOHCDHBBI9/J5+DJ4s9?=
 =?us-ascii?Q?ijgrzs9CRbJ7wF80YLMaQy/7XTzS/ncbPE0PPd1RjXBb/i0aztxsuH49G/9x?=
 =?us-ascii?Q?a8Q1ctYaZRGcYcZK67EOu4In?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319fef44-8fcd-4f5e-8586-08d9102676a8
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:43.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt7XZJr5QR16dyunlHdbcARM0CtGKt8mxoNqYCHzgold+iJFT1up/9vcMV4xB4lpR2I3SVyY9G66bGJLgy/JZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Use clk_bulk API to simplify the code a bit. Also add some error
checking to the clk_prepare_enable calls.

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

