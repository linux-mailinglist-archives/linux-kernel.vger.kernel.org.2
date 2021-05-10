Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE7377A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEJDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:47 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:38371
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230356AbhEJDap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz3EtwVOsyXhInV8/H4Ym7kGSUMhNeTBWorTkTiDEa/8tfkFkjvsretL48uiU+9/IjH+6I4+ZLql1i3jf5bqrZwtWCMM6uPoOY4AVg6/JZAlOx0cNn7SfWH5QwHq3P0HkwDh8188EhXOX+iR3HrmxXUBqdZnfQ6Kniw2QgfMyqiFe6B5gLzLeKw/unvQnS2S3wzGKot0SL8JrUKlHuVTkLNJlSCPgArsdOVh7sAEGtqBWDG8ZZFb8/Dg48jgASq4l2Xfbo1pmfOjlQJrGZ7g/DDGktjot6BWBbKGLRJTzUMs0/uhs5Cp75wAZ0XGMKa2KqTh8RbeeI1O3UIqPPHFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZOmLsY6WJNG2s5oD+u9itH2/YPJ0aEHqCR2x9gj644=;
 b=DpDaNqZ/2mb6cPsH6+PInnz+b3tbsrXshTu2GTt2wGrsclQYTDCj+gSFa7021lvHRycffr97N2W0u+LfL/10tUD9QbMTgJurz6fpKklvPAsnHQvk1BvgttPlLlxpbSyFlmvb2+6z7j94sYzhRvsE+ERq8mCpwRQ1EOGQJvu4fZ+g3/RJG6QrZbJsEx/YAaAGEIhpt++85XTQ7mtQOfFgB272MzFagZyNrEIsbSlyTbMa+SU4e/sfJr6QR2sjzM5EIb+p3YSKZrYYh1s0yjupnPOuE5jxo7CymOynLdYUdhK8bFve6qYFF/+m23H3ppwFzop5FCXL8+UJzfFkxawpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZOmLsY6WJNG2s5oD+u9itH2/YPJ0aEHqCR2x9gj644=;
 b=VP2KQt+7TfeKrjTZiEeV++9ZsXLOEQvGVzQ/vNCMVQVUXjrXRIMt+54dxuSjObYXa3avdvarBkHVULERUALaK8X5lY5oq4fPgKBBQ6Z0vxJGWIGMGi41+qSfPJQKNve9az057ZG4yVeEdNRq0FVBmX1dIIaKcyggvspwe/jaNrc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 07/13] soc: imx: gpcv2: allow domains without power-sequence control
Date:   Mon, 10 May 2021 12:00:39 +0800
Message-Id: <20210510040045.13225-8-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73106864-699a-4e07-1b98-08d91363d7bb
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091E388E0EA8151813C9B7EC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrM9j12UgKSok3G8tnWhXlow4UW48buG20lwaiqq118aY3oeoFpN3ni327NS3PnujJHcKE2G+jebYMghHKn5+iPtY0cEXIk0amdEif/SOgMG8x8taDCm+vmri97RCd34VGc2FmyzoPSKBLPDuJMHBj8xI3s8kdu6O5x3jg7Y7sHct61dqcYTcPRQJ9yhWVOW+3eekl28Wny7NzvG7/Vce1/3GynXGo5eScbcQKllDf5DXp7nK+y9dnN7FiHRkyqYpA54xjL3EALwpIwKF8Wux6nMtUBLcl/pgctPpETMGQPK/e+h7QS17mCLHLVtfwb6VibNPQPjr9+s0ZkZfbW9L64repgtrf2p8rsIuhaHUuqW4/6OG50TCLIMRagx4H2kVAmtbFxdjtgTP5meUflsAvfRBFOGqnFyRwy20dI14RHzz7AUCkZFQcIG2X+1Tx2a1U2XxKCUscdKbNpf+UTF5LGQ2R9o0PL5l0SGBg0vceuMHvKFLFt5hTnmDDK8GcOWvcl6n4oZsV3ZFOchj1VrPu5lOn8ViJk16gbTyHrNkVUqoiQtMvCmYtOK8wCdwn+Pu/uR6EfVEpllh2UlrS/UNhI3L89BFqLka9PXyZ9wme4Ae12DSO8/qM45mq6o4g6cmoYVtiaL3tHeJyxZdbB4S/+Hj5fIeTXnRKM0w14x+IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NT8EQ3kLM0eeriUaPI+BcMy3CP3unBO8/Y5GNUGediHd3NkuNzXgwdAT9DdB?=
 =?us-ascii?Q?6zs2/z8Qrghs5uk7d/lGvxEMM0RqTMRYUQfOsK33HLxtLsU5um4nHXOxDOVB?=
 =?us-ascii?Q?RBhvxw/eSynzuz55Er3cENktfyFEpooYBlxCUJNtMRfMKssYqHTdLLq/aZiQ?=
 =?us-ascii?Q?SLIBPu2JD67D1vIIDCxdNESgWprMhQRZaZYPyUAlHE2t7Br8Cd+dW2vPfopO?=
 =?us-ascii?Q?zCzn/COLgfG58eXXKNt2SusBFY0E6zUIZCX0x6KLkIk+LIN/aSiPzzpfSqZD?=
 =?us-ascii?Q?ftNILdkDRyHgYAadJnbu6Amt/FgBvbOnfc9ukDVk3mqj0J7kwalsUuAnQQNZ?=
 =?us-ascii?Q?PTOQEhid1BCWHkrjM+bjpsz6kMkK7vTIcErLwS1X+EMonQIllzKOMGZVBvub?=
 =?us-ascii?Q?ic5KXEOXv6jBSG3zugYYZmBPb1PHFGmJnrWkH7o/dFRxXwFX1jwqyqdoQZ8V?=
 =?us-ascii?Q?u0sSLESJ0L/zxCurUX45MCTLY0leXWARLCLHRB5ZPnbdjK/Zg6id1NW7yzek?=
 =?us-ascii?Q?w5h2rxyljcUjgMwm7gvhWNhsQfrIX9Fel+vbiV3Cl/2Xckz7FZWUAEjLUx00?=
 =?us-ascii?Q?NZn47hszUHFJu9lNoquinEqz2Gx0Jov9STgjeG39N2qQ0YR0Rcai5EveDft9?=
 =?us-ascii?Q?zRl8YL8QifRMVnJ3ANzP9kUD8ZjOq9TL1vth+yXP9H4O0+66rTUsQi1n8fhY?=
 =?us-ascii?Q?NzUznmnUcUomYDwTUACIaFt/0PWl6IlpN0YkRL5QDqZ0vOv3wSfYJYnpT9vi?=
 =?us-ascii?Q?ZBnlUGrvjix52TJZMLOGjuEunTkcmjYVVaSDKfchdxDnruHewaoZ8IdSzWyi?=
 =?us-ascii?Q?F0w7vy5cpwy1DZvRUObYn2OnJJB77ptmzNEsk2tqR22WC4mMDgvqZDd9d2ft?=
 =?us-ascii?Q?RYDdPnEA8Sqp44OPxKM81PIfdxtoaFcrTAwVlXsg3WHPKfOccLmz4MSqwd7F?=
 =?us-ascii?Q?0WHc+Zd5VALQxx9PMFR+SEmYIwlY/lb+ajDOyFkRUcdxnc/mXVHddbRpn3eP?=
 =?us-ascii?Q?WDHXRzG+/psI4fKi8dceCjXmq3bjv+Kg8FX5zWksnf7sTi7tSMXMUj4RsVjl?=
 =?us-ascii?Q?VX74rXsGBXfn1eKxAISg2zdV2pYZDmdnfBmz3h66kDvciXk/mtbjPlUTWg4l?=
 =?us-ascii?Q?EIktnAczjgOCWOIXWkI9PEHCqnJ6FvAVMW93Zxu9UL4NMXd1areQtPDei6dL?=
 =?us-ascii?Q?TzlFOrEOEnXoxNb+/1yNeqZpVOuFMy4zC/nUcZc2wRAmaKBhT5bJY/d9Crut?=
 =?us-ascii?Q?CvobBR31n5yZzvOixNFMrxLjTvFyjgN1uJ2Gq+fvUXAo7aHYlNMYjYsCjxcP?=
 =?us-ascii?Q?uDNfNHI9m2U+Y8s72cqpKCD7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73106864-699a-4e07-1b98-08d91363d7bb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:39.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mepFt0GvAkD3WWnxb5m5YRNrbOCsox2DEIqT3/QjERSBJYSBu+KfA2OyGW/1k8UF92+0w4Pr/G12CJvIPaakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Some of the PGC domains only control the handshake with the ADB400
and don't have any power sequence controls. Make such domains work
by allowing the pxx and map bits to be empty and skip all actions
using those controls.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 800287abdbea..fdf759a7c865 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -163,24 +163,27 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
-	/* request the domain to power up */
-	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-			   domain->bits.pxx, domain->bits.pxx);
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-				       reg_val, !(reg_val & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto out_clk_disable;
-	}
+	if (domain->bits.pxx) {
+		/* request the domain to power up */
+		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				   domain->bits.pxx, domain->bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       GPC_PU_PGC_SW_PUP_REQ, reg_val,
+					       !(reg_val & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto out_clk_disable;
+		}
 
-	/* disable power control */
-	regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-			  GPC_PGC_CTRL_PCR);
+		/* disable power control */
+		regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				  GPC_PGC_CTRL_PCR);
+	}
 
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
@@ -245,23 +248,26 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
-	/* enable power control */
-	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
-
-	/* request the domain to power down */
-	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-			   domain->bits.pxx, domain->bits.pxx);
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-				       reg_val, !(reg_val & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto out_clk_disable;
+	if (domain->bits.pxx) {
+		/* enable power control */
+		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+
+		/* request the domain to power down */
+		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+				   domain->bits.pxx, domain->bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       GPC_PU_PGC_SW_PDN_REQ, reg_val,
+					       !(reg_val & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto out_clk_disable;
+		}
 	}
 
 	/* Disable reset clocks for all devices in the domain */
@@ -536,8 +542,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(domain->dev);
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, domain->bits.map);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, domain->bits.map);
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
@@ -557,8 +564,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 out_genpd_remove:
 	pm_genpd_remove(&domain->genpd);
 out_domain_unmap:
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 	pm_runtime_disable(domain->dev);
 
 	return ret;
@@ -571,8 +579,9 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 
 	pm_runtime_disable(domain->dev);
 
-- 
2.30.0

