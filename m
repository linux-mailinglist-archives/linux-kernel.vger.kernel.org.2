Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2425A377A86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhEJDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:30 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:25351
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230314AbhEJDa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpRDtPS0HeWnQ8RuSIW+U6lwvaNu7rIUKxE9aqvfr9I2Jy+89P+Ef0ZQz6TMrbCU8WgR+ge0ubMx+R2b1el+2VtSqXKe0kz5Iqfh9qC0vqyXzwyFkIsS9rqiebSN+2nZ1iYKvQwHc/giOMAIy31j9SBOnq93HXRT50yxS7/6xgB4E0qPPK0wnYphjRDn89evKH/2DVzy57w8awi+f/tj8Rdb4Ra9wIlZYlTNKmeNAOJmBSiqFfnHA+rmY7zLacCrFVEDyDtoy8ERDjiJ5wURfUPbRfR43HLv/EqaCMVZwNf20+is4UE+BIpUQqqff/CG/Ne50hAEDHpnxRaNR8rekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF6MauPmT4g0ZYZibgloyB+h6HZUfn7M6Sivd5kwauk=;
 b=bJ8mc8REv041PvC9cJxMQWvoUpGZxWxvd/ygmMI+FVFTQG6RqwW9q3o9y2YWT1vVeoWj38SwLTMH9piYckb6MVRZIWMipOwl5ZXmFWKG4aOP8fSrKB8MjzidE85c6SLAUcZLU2B/8QX+10IYN1QjEcvwACMt5YqeEt1/kJvkePWDUMBPBRbAx+F/Obd9tdg2X49aHR8ueYzidl4kv85sFoPoE/ArCvQU9XOqKagwK+CScfqDcxf63IOlrCVOkOCoXpzDvGZfYL+Swfu3PWYwpfsu1d3TkJBZhdnuIMbwnfVjLiJ7FOdzczqKkwrPfTpkcp2CRJj25pTmaHd1LahOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF6MauPmT4g0ZYZibgloyB+h6HZUfn7M6Sivd5kwauk=;
 b=bOMaaDF/LjTbbkGWcAucTovtIiK1i/yqm167n7zASP1/gmb/ScSr0HNw8wwVRSkSykkJbz3Tk/mGkF/QdyfCOHpOi8WElupYZK/Ot4zBoVMfZ7DjCVjJBAZwmefA3RNy/p3GmMX4PZgcI71WdxYrSwU2D0DW1dd01PlHU6mQpps=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:21 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 04/13] soc: imx: gpcv2: split power up and power down sequence control
Date:   Mon, 10 May 2021 12:00:36 +0800
Message-Id: <20210510040045.13225-5-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86df4415-80f3-4ee5-daba-08d91363cd12
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40918A60A3E33B9537DD13D9C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPqKYQ/5DKUs4bDDRIEYNpd1lkKCO8IoUoIi78BwCS/OQT3+cD3Tg6MtRjACOAq3Mb3t4Ll4RdddBO+PmNb66pH/0ur0bSo/XKgBSi48fkTRDp4ssKY886Ritia+AKyzcvhau7TCwkWDpEOTmThf+N859pGT0T/AZ6wgDMqIKBF06j67NchRFjVukIxPpZ7/FwTbGb1ma7nt/ezPgnIL/VOfdAAMpk1egxd2xqwokzS2UVVbarNtO+v2C661VydklLa2jdKDF2n3xS4CpZ2r1i3O1XXYBFwdUo5lWPv2GDl+glZDJ7S1coUXCGfgGQYjrw802TmiD8xVMd4N+CjSqbOkf0WrKxSNcHgDuX7OviG2heisRr81iwCF5y8iqnTStFf+AbJJqpHyZHOER7mZ4rah/TCrLVoSyOnNLmL3qpqza+kHTkypVh14R3CWEoRzTB1M4QQC5YnTu61yCGqX5flN0SMN7yV9wR1wz/qLgfmTJb3hWHry2DmBaEdPlwzMooOdZZixZ35zNaQp1e8Pelc79RTPMIWSuf9qfGItqUTVNJSA4Sdg/ayI3jg0jFsTA7kkOpXvAB7hZg8Lr+UWJpx3RTFfQXVmQoG+3P6F+yr5YVdwk4Ov7V2r4tqEAfQEcbu10useh4FCau8Qmsd/1NB1/iLDerruqp+070474tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3K0QkR7V2u1fQlyuNeVHeuzCnprKfjuN5g8qV78gf9ZRSzxoSztJ8ZO7cI9T?=
 =?us-ascii?Q?CsttpwgJLPFDh5/44eD1P+yFCcEcBOeAB5mIirRsWNNVod0yHyPRYTDAQNkJ?=
 =?us-ascii?Q?ehwDDOlm2Qmi17tAmW819v8MrQ/Wqbgs+EGbmLXrfK02wk3u+wmbPjhsv60v?=
 =?us-ascii?Q?up1zRKx3QY5tcgjIPgEUsqUZRV+XL/hOoat1CeXVRMQyzdjO6vzM7iyVYi7s?=
 =?us-ascii?Q?MJb6lepS/PX8N+H1b9hm5Pn1ficNc9uy0NozdDmJ3SUNvBr+EKCqZPnHVoJs?=
 =?us-ascii?Q?MI474OWoxhL46UjtWM9MjHGI5Q42idDvlH0ibLYu6E4hiGYnFAAbnAL6SFjW?=
 =?us-ascii?Q?6nRn1jEtFRmuAibXjWvNbJw7is55VQmCEbds3lwCP0Tp+4pbCc1S18Mc7GMB?=
 =?us-ascii?Q?tvCMYsIII5+dNgrQvmG8Po2f+a3ZQ4URcgNfVX+l5x36cA7YTID4QQbOksh5?=
 =?us-ascii?Q?dYJi54W7DRKv0KVGepMxgyyjWnSN7Klw1ap2u/9brJi2sSsoqBUuCKRQnVRx?=
 =?us-ascii?Q?69WQjpmEo/cbzg7u17bmy7uY1Dl68ggUXomdDzYBBWqCwuVVX92Azx5QbZsQ?=
 =?us-ascii?Q?4l9VsbQaOZNzYrChagN5EMAroGc5NLtL8dn651++/DdXA2s7dzvhxc8cuRke?=
 =?us-ascii?Q?/TBPI9aXO7GHXbrrtdDTh2a7O2Ak0OnQRPKg5MOlltPXxO0Bza6jjUCijEcY?=
 =?us-ascii?Q?6+VQ0Z/p8RO+WvBjxIj/R0dLs9rQdCSCHwJ4sSPUFvGKhxagkU5EKZMPuhiL?=
 =?us-ascii?Q?UuJSs+xw9kjPXzdwOGNVEAF170z+pUoVDsD6e9XTmqB7OnSLV388CvUJCqOH?=
 =?us-ascii?Q?KzFsfEjvpxNH7fqQTGX8TNaV8Vg57t/fsOCb9xiyQ3S3A7zEVjw55/+/vvsK?=
 =?us-ascii?Q?FqEZCEMV1DKZ2C4vcH91VSybQDdrR5tmlvg6x0Mm0JCHm2LGEH8WQp6ltF39?=
 =?us-ascii?Q?ShDEXU01ySq3ep+4BPVfaSmUWcG0aMfZRVLPnVKW7hQbPgRcpLm9iOLcw93z?=
 =?us-ascii?Q?s52sCU/ArKE0B+VySt6CUdPObi4gLd3LYE4gVKup143XXqTGjfl7zT1Rn10D?=
 =?us-ascii?Q?4ZYzkLw7QqYjxZHJ+nOW9C0jvz8lEnHeTlxRA0+17+hGY6x+BRFfxtECNI8a?=
 =?us-ascii?Q?FXj69QBW/hQ4bff3DTqFU0woTKsMM3e6ySC20TuQhCWjapJpMOG66wbFWrg9?=
 =?us-ascii?Q?z2wS/Ngct5RVWDn+ENO/u92ZaTy5aB/NMIOxLEJ3eO6G4aSZBKkeFFk0Da3D?=
 =?us-ascii?Q?zoC2GklhFucbnMYUEKWnuvzpE95imKEm9XtA/wdVrZH/0yMIhJeKAop3FXq/?=
 =?us-ascii?Q?zst4TkInkY2PZgCLr54y+vii?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86df4415-80f3-4ee5-daba-08d91363cd12
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:21.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkKy91GS6+uj6S0etGCl6jsvXA25jQgpezcUjuuX0UD1Wj+KTi8knpGLuadq8ZK6QkHLZPp/JvfMNnIYVCTenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The current mixed function to control both power up and power down
sequences is very hard to follow and already contains some sequence
errors like triggering the ADB400 handshake at the wrong time due to
this. Split the function into two, which results in slightly more
code, but is way easier to get right.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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

