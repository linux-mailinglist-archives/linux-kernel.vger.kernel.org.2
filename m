Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4309374C62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhEFAdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:52 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:34702
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbhEFAdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN3KD0jnvWfypqQxnZLlIx7cNq98SW3Zq7hETIXzZzWkv5lqwViaqJPp1teawOXBvD11Cztf6OIXOGSy14m44l9tMlJY6QkUdGt1DikNNdXFxVSx3seipBU1QCSIOu55mRdG6ezjZxOMmT/2zzFJWBgZSdbiAhnJxzvmYKpA7xOMefbxeo/CeJL49njjUGKLxW9FzjupzNzeI1cJRqVVzj2+HtmLtERdkgBm+M8zbIf7KIHX2XGuAwFM0XyNFTy7iqr9Mu6q3W7ExHTn7HfUPAU+0A9uykWu8a9YrLUWbi7IwbU25fI37bi3l64Rw2Dx4UfUDX4n4sDLyO9q3AGEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mZ6vcOiimt4RdacuwvqYWbCLBRHliQj+5FIXt7LMJQ=;
 b=bVb9HwCLRhDjChB7uzAswUghJw9BgXTHPwMumezpWFEVt0E2MviVEaMQdMcWLn/P+9FmKSCJJqbd8IAEneakxf/VM4MH4Mw4HrDB9RjSayZkJ2MOyVfVTUD2h6CxPW+Obco7dQbG5mDcccYOexg0eH8g9uGR5KZFRzMh4dNs6xJymxEtojhttuRbQUsPwlIu3iZfUsz/OVS6Gh0NWXwk9+oCtJoASCeuFvZX6j0pc1klkM2LN+fvgwKhctqnjY0UpwXbyxacrO2pQXEWUkbPHyEHs2XumMnoQJPaQVzc5s1aAcRorq/6nLjE3DI4h+ihVO1CeaZRCYAh/9w8+MFyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mZ6vcOiimt4RdacuwvqYWbCLBRHliQj+5FIXt7LMJQ=;
 b=K6h5fGUo+TFtYzvea+/uhQBgoQy7O66YA19CsJV/4pv/Qgqc3F/RhxbaGf5rPX/cnzYNu9AR6ZyhvsxPtfvrEo9/lF0nXqt6rPTCNJe7JgMckrNjS3zCOwm8qnuxoRdfJwDLrGIC8A6Mq4blz27bT2VJh8aZIuQ711BVuL7eDr0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 04/13] soc: imx: gpcv2: split power up and power down sequence control
Date:   Thu,  6 May 2021 09:04:31 +0800
Message-Id: <20210506010440.7016-5-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e58bcc7-f08d-447b-2929-08d910267a2b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB671495A75F8069F4203AEA27C9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzUs41WO6iqCsIGvcffJ+lrSMR1VX2vWlnvtWDLLsUlEq90MJYrmMajtcBVAxrv+zVrjvIpujbDXJAhvHwJ6NK6xycpINrdLYs5uGxGuswcUcDzi0L0kiU4tYTr6sfa9fws86SwOM5J11EfBDKs+aWMksxKWl5Sldir/sJDydcCDOPDw4ZGuD9xfRQkD0508drZEerNowdjZ8Sy376lkje+81ESBvlU+LcRBsyf8zKptf6qXlelwvbWkuYUYX4md80WJZNU56qJ9Ny1yGE/JVuCBb9KD7eIo3SCj7s7srz+2diZF8dSocmt4ckQQmEPo/nIvCqfV76ODEinXwqKHEyiwTHmr0FDqBDYRA6QNzBQpa8J9liNnd8jGO3lXsjifDKbI4fGpyvKn6MIEidZQOy9o5v5WFpHdc4t5beY2laVmGEYL/JLUKHMWpoR57rI5QldrN8VQDOHph5RKJzV6WVXmvVU9ndIxWOG5e4rEn6UOvehtc4y7yG90uGgJmMYNW6tib+PCC3BDYoSkeoipEv3mcCTFfnd+Tswn9s/OglLWKIz7W/OJX31RWwC7C1L0EMJzzqjb57yo984tAIsaQtkcBTmiim6IbOnth/v2R8cyoer8GfL0bVb447V0jtKyF5sZ0yPvLcXXaeSF8zQWLHrJ42UQpGU2deaCW4ODNLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vVbE5KaEvxZluLV53FETNKlQwMbi3mlcUHzgI+R4LMnEkb5lxfyxv5E8XJ7V?=
 =?us-ascii?Q?g09QJXjEeBLiGeERPKYojVKBzdIkGrJ5wghcSvRAfyQLFpIGIxT2ee5U8rNP?=
 =?us-ascii?Q?NvdAemiFL2W7FB20mnxRH9ZmD2h8yqJ09owiVTIL6kUDA3M00AGp8CNXnU1J?=
 =?us-ascii?Q?nREjpLQeK7/zRjC6aeuWP4aLheAPEI1hBFlf541fqcC3ff+Q4oTr/97ITDKT?=
 =?us-ascii?Q?G1t5Sc7KYuN39bOe8Q7Cne1K5O64ibUodiRQG5giR4EhxmWZ5JKCT+eYO7cr?=
 =?us-ascii?Q?KEVq+Y6GqEbaUGPIXekLe4LPgBPuEfktwN24wM8NDOLia3m3EqXUYfWazoTI?=
 =?us-ascii?Q?QoKKBKCX+lcDoVkv2jlnLmH+gWMtU55VH/sSfBIW7ICB8wDgiLqLiw4seiX8?=
 =?us-ascii?Q?cDf8vEXgn0Gf2biSjLGitgy6WvxOKbpPPc5FIg1U3L6icy2BjdxTWdKZEv3J?=
 =?us-ascii?Q?h775xxZGQICK/IGtUbnGou+EKvr78UUB1pJQZ1rI6WPgCsBHWtAwbsFFFgrS?=
 =?us-ascii?Q?VV9ZMViLL6FI3w6swpUocYkyQJUO14fOISc88ZqvQNzINKi0QvI7G6Ls2sUI?=
 =?us-ascii?Q?SkwJiTPfY4ArSBHEOZKiMGwSp9FquoJ8nV+F5EHQyLWzjRda68LXm9sudmix?=
 =?us-ascii?Q?L34paay1jTWHlAeKtg8dn7oRJzygaLX3H9wpm4OanmMpC8lQzlzlvZZAwgEY?=
 =?us-ascii?Q?ldf8sAR1E4gWOX3es5/bpgtKsNKUITyzToa3FgmtugNwFjOA0+D0fq5QxD5h?=
 =?us-ascii?Q?lj/MCzpsJFlRBPVLcEm8ze2WPMk5i3tviPcuxwluo/2Ep6cJAS1eZO4im/yj?=
 =?us-ascii?Q?NGerdqG0brbYf9STbssZC3/KJ7ZRtgm2N9Ni662HtRtUYQlpROTb2dWIxrzs?=
 =?us-ascii?Q?im4L2EZ5jQ/Axnn3YK1H74CvjlAKvRWaav07cAshQfhazkJxIvvHbXG4Z9Dx?=
 =?us-ascii?Q?CdzXEVKcijQKscbCMKtK6yXYbXSggMWlzg/BIf0syK+3Gp3xYFhtIckA2q2/?=
 =?us-ascii?Q?aE8I+/pLYgpwe1oDdi2Gc5cfmyRsozDcQ1ZkU4h1vH8g0N+sDlOx0G7kbdn3?=
 =?us-ascii?Q?n93IxRphxktiq0IxbYM+YI6LYuPjAhyqQ6mouX5E4qwElisMdXIIq2gfM11n?=
 =?us-ascii?Q?HN5qOpDZN9TWmPdfwKSWOVDXWlGHuHMjCj3ruFALaPtmUadrybP2SxxwG1aR?=
 =?us-ascii?Q?F+hEc4KbvAMmkeJFLHfICahJq6b8CsMI5oa8Gey87xJ69obvYl9+xTncGhZX?=
 =?us-ascii?Q?G53pUzYHHVgRW9wTTe+hUr6Y4waZNtZdn6yHCUM+nMHSi/ErcOJ2/qwfMYBD?=
 =?us-ascii?Q?P/ud7avw9/bCt74yLAS+OGOk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e58bcc7-f08d-447b-2929-08d910267a2b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:49.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TPKqiIG8HB7ta0vUMlFdXHZW/j3dR+jN9TfmP8wz/0BvWtQraf/qIg5q8nd7M8HdQ9xfjvhF7GuGXaMucdFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The current mixed function to control both power up and power down
sequences is very hard to follow and already contains some sequence
errors like triggering the ADB400 handshake at the wrong time due to
this. Split the function into two, which results in slightly more
code, but is way easier to get right.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 141 ++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4222b6e87e7c..bcf1f338b0bf 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -125,20 +125,19 @@ struct imx_pgc_domain_data {
 	const struct regmap_access_table *reg_access_table;
 };
 
-static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
-				      bool on)
+static inline struct imx_pgc_domain *
+to_imx_pgc_domain(struct generic_pm_domain *genpd)
 {
-	struct imx_pgc_domain *domain = container_of(genpd,
-						      struct imx_pgc_domain,
-						      genpd);
-	unsigned int offset = on ?
-		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
-	const bool enable_power_control = !on;
-	const bool has_regulator = !IS_ERR(domain->regulator);
-	int i, ret = 0;
-	u32 pxx_req;
-
-	if (has_regulator && on) {
+	return container_of(genpd, struct imx_pgc_domain, genpd);
+}
+
+static int imx_pgc_power_up(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+	u32 reg_val;
+	int ret;
+
+	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
 			dev_err(domain->dev, "failed to enable regulator\n");
@@ -150,69 +149,101 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
 	if (ret) {
 		dev_err(domain->dev, "failed to enable reset clocks\n");
-		regulator_disable(domain->regulator);
-		return ret;
+		goto out_regulator_disable;
 	}
 
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
-
-	if (domain->bits.hsk)
-		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, on ? domain->bits.hsk : 0);
-
-	regmap_update_bits(domain->regmap, offset,
+	/* request the domain to power up */
+	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
 			   domain->bits.pxx, domain->bits.pxx);
-
 	/*
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 	 * for PUP_REQ/PDN_REQ bit to be cleared
 	 */
-	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
-				       !(pxx_req & domain->bits.pxx),
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				       reg_val, !(reg_val & domain->bits.pxx),
 				       0, USEC_PER_MSEC);
 	if (ret) {
 		dev_err(domain->dev, "failed to command PGC\n");
-		/*
-		 * If we were in a process of enabling a
-		 * domain and failed we might as well disable
-		 * the regulator we just enabled. And if it
-		 * was the opposite situation and we failed to
-		 * power down -- keep the regulator on
-		 */
-		on = !on;
+		goto out_clk_disable;
 	}
 
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, 0);
+	/* disable power control */
+	regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+			  GPC_PGC_CTRL_PCR);
+
+	/* request the ADB400 to power up */
+	if (domain->bits.hsk)
+		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   domain->bits.hsk, domain->bits.hsk);
 
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
-	if (has_regulator && !on) {
-		int err;
+	return 0;
 
-		err = regulator_disable(domain->regulator);
-		if (err)
-			dev_err(domain->dev,
-				"failed to disable regulator: %d\n", err);
-		/* Preserve earlier error code */
-		ret = ret ?: err;
-	}
+out_clk_disable:
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+out_regulator_disable:
+	if (!IS_ERR(domain->regulator))
+		regulator_disable(domain->regulator);
 
 	return ret;
 }
 
-static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
+static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 {
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
-}
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+	u32 reg_val;
+	int ret;
 
-static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
-{
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
+	/* Enable reset clocks for all devices in the domain */
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable reset clocks\n");
+		return ret;
+	}
+
+	/* request the ADB400 to power down */
+	if (domain->bits.hsk)
+		regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
+				  domain->bits.hsk);
+
+	/* enable power control */
+	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+
+	/* request the domain to power down */
+	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+			   domain->bits.pxx, domain->bits.pxx);
+	/*
+	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+	 * for PUP_REQ/PDN_REQ bit to be cleared
+	 */
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+				       reg_val, !(reg_val & domain->bits.pxx),
+				       0, USEC_PER_MSEC);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		goto out_clk_disable;
+	}
+
+	/* Disable reset clocks for all devices in the domain */
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	if (!IS_ERR(domain->regulator)) {
+		ret = regulator_disable(domain->regulator);
+		if (ret) {
+			dev_err(domain->dev, "failed to disable regulator\n");
+			return ret;
+		}
+	}
+
+	return 0;
+
+out_clk_disable:
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	return ret;
 }
 
 static const struct imx_pgc_domain imx7_pgc_domains[] = {
@@ -590,8 +621,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		domain = pd_pdev->dev.platform_data;
 		domain->regmap = regmap;
-		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
+		domain->genpd.power_on  = imx_pgc_power_up;
+		domain->genpd.power_off = imx_pgc_power_down;
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
-- 
2.30.0

