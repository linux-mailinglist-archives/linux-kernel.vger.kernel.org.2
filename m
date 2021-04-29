Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5650E36E549
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhD2HAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:25 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:50880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237427AbhD2HAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLXIJ05KmzAmcuM6ioK5tL8vA4M8Imt5z3t26a65po1a/jKpQ2dfWdyRWM105nScmMzx6VqfpYmvX127IiEY/8nS532+ZQqEit/ev586ktKIRpR/SGRgAlefc6UFJvVYNEXYZOejCgThW3k37Fif+d9tUoye7OzO7DXrXsRWX6EOZL8n5uCDGaprb5TTebAuv4NSwUbTULZ7DsyEIMY6yvEGMbw2ZQ56xJawpgfUdQ+tkPKHIFOm9xNnCWCwPVxlWAf6d531ATRvGEuP6QpxvyGMFOn7BB6q+V+JG+m1r616UOJ8ZEif32W7PIwoDl3ecJVLVGQVgmWjjsGzeUpYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duAT+h6+K34OrS2YoobRV3NiUsMl6gpVVhRrTmffbUQ=;
 b=ID6OxoOU1rAVG6HMpDhi1MtOEGyf1MYETK3JmeBXD+SFHM1TWT/viY1ipY75j5ExutXLC+O0YhfMO7/snWTjR0ErSKhHbHlOjAEKTA6w8u++1dDTK1JGYpIlrWTPP/n73t8Bt0GsWlzueHdyVkUrgOAsdLaPuqgHP+eRFb+nm8xKt4IU0CocRV5qe1QUJhTYxwiHiPl8UHPsadFG8tEPZc7hWORReHawYB/HbP3/DA7b/uFK2/LgrYOU/Eg5EUC1vJJHDI8VFOuCuSDwMBACU5RQ47mWZegRHHrHZZ8nE8L1djBeCmWDyQI864SRF93GvUu160c2IqcyERIqp0iYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duAT+h6+K34OrS2YoobRV3NiUsMl6gpVVhRrTmffbUQ=;
 b=TYjjJa2d7mlWFEnWnYLzw9aT7jZVDU8Z8EwZZuWBKuddQiBj+yIfK0lb9YlDXQtAN4qv5retbYTOuw3oorxeapuWl3NZGayHbQ8u1gYmbQOx55F6OIbv2Q7C2UvFwFhwoc9HzCMvpXPZv5ohPSPsTWZ72bDiMdD9S84t2Bow5NU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 04/16] soc: imx: gpcv2: split power up and power down sequence control
Date:   Thu, 29 Apr 2021 15:30:38 +0800
Message-Id: <20210429073050.21039-5-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd82a56-2980-4646-906a-08d90adc5498
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB546899CDB405D52B020ECF29C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pu01Q47KtAVGm3nqUyMeXo2ObgnYnQkKBnXwkBsPGvkQnYLG/g5Q8vAokRcJ9LRb/3Bze3i69Pdd/8bG+zOLK7C5hPAqy+TcmEYDFANKalJdm/QTZGBrzhvGrLCuEQg/2Q/JmU83D55H86Ja/9bKh5Fbqr1jho5/sSsCqNlCnYA8Nabqxs+rotDmwaUqqGnXpHHmq/xZjbSEdzph1QZR73WuveeBLTEhqLe62WbZo9hHzsiB8DiAs+0OCIjwWCoIBgA/yyu6y7n3qUN+IotJuIxBzOGPIuHExKfgs2JF0W7lwDV2J1hbwlilCZDyvIG9ZAQznRt0IWVG6OJwKd8iiGeWNgNgKamkGinXzAVr+dSnRfRAaYa2RUpiG1T2RzAzpUmnwuSTiO6G53+4YPQps7alQJDaDVDHGICc1xueL83Is4i+gu5sMAp/JL67Dt3HOu0hZcgZUQbTupw8F0DsTTZIvXQ7FaziQ/5MizWia6P3Hm0BqgqgBXuKjwVJ/OTfRNb6YgswNg49Vsfl0Q29x2eNqOa/5RqjZF/4LxLpsHTOwTcu5SkOpge9CG58rsTI4tVZbS08XsSQuC9i1H6e/IYyFp/Eqzd+rmP9VO1jdx1aYakm+IdQoEMPaMjhkcpLkKqnzbqrCKMUJYbqXmKSAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yQG8+CFzICYsLEvB7pv8RgHj4jSn8LvsYXE8vTZJm1q3boMWTr6VVz8+l8em?=
 =?us-ascii?Q?iDwkRiQxUWto1VojOIeiEZzt/AB0nqwWsMDQKZIHAv1E4b+IC/EY1OtLRW0Y?=
 =?us-ascii?Q?HrT9prymGeIjbLUTB/Z8m7+WPyk+8bPM5SpMzHezWUtUEDSEegZlJ/HnSVau?=
 =?us-ascii?Q?GxT9svzT2N9kjYjMTSzerEI+Z0Uk7GalFGCEZG1oDmhpUOqQ2n5p1KpWf7Ue?=
 =?us-ascii?Q?Y2mzyRBH1jCxgNy9T8h7q5HbxZ81brSQybxQa5YosmU33H9tR134+0yfFjbM?=
 =?us-ascii?Q?25t5nVjiPOz8z77Ehe7YzXwurz66YFoYWgnRFlOz25PFuegdLbTcRBjNK1w/?=
 =?us-ascii?Q?z8yOzkKnOpAqEeBlxKs2opsyVTSC9+4+oLG7dFyz88RmrHsVBrFBMYbe5MZm?=
 =?us-ascii?Q?scuJojqMjhnHgwrWquykr9ncLL3WVBV3xJ+xYCn11zabvtnPNS52O/gO1qyE?=
 =?us-ascii?Q?h169RwwIF3b/elHUMohF7kRJZA313t10ivanz5GqWvPkrEe2x+aeKhrpFOIV?=
 =?us-ascii?Q?4Z9f8fkVzFuJqUNJg5JdBU/c1KLu1VZODtO6Y4Ko32AjCSthOxsRRKO43yKw?=
 =?us-ascii?Q?wwB6wHzEhxs2NKNMmWlPcnmua0lapHSnURLrnI5LBa2Gezr7WRxR1CPTVS+M?=
 =?us-ascii?Q?aShMSszZWQrsMO1qfjLBzDOqPG1STLIscEdp+L74OrMfciPnVVSeto0Pa+Ji?=
 =?us-ascii?Q?nSZ4v1MhTCaef7XCZhAnJejxHjd5lrd0naDJVzEqkXISvQpaUh59Gnjqzr7G?=
 =?us-ascii?Q?IumCVW7MFa/LHVWaJo49Twx/ASJtA4BI6iGgfxeHnRk1ecHVdJOKnn1ql0We?=
 =?us-ascii?Q?rnEKRCNdxafkcFXIInW1GCcJ9QjUojQETorwpKiuDzjKjY5jKTwlSM/4QqaA?=
 =?us-ascii?Q?JPaAugKSUPeLVzccerpOFdqVlYLGiecy2Jt3fB9f9ZuiL4oKdzHhkmt2uPTC?=
 =?us-ascii?Q?G1G4j5Bgf+urwIoCJGeUjLxP5fFhTg3fjsEOZ3PXO5sEBAbXKtxBOVlgLuYD?=
 =?us-ascii?Q?C5tIfx2yYRjqHzjPQl+hjssKWSCyRPYRJasz/1J1u3fQ+rwdDa7KdJvxSaPS?=
 =?us-ascii?Q?XeeNKpXMI5kH+EqIpNLPQnfCBqCYZyPMq3qROWYwsVZE+Zjx8pWvYOvYr5/t?=
 =?us-ascii?Q?rLBLqj2KiHq5fI7ihJP2HGGFJehjBJ6Y1YETFhFH3rFe+3T/75SXyvKRocIN?=
 =?us-ascii?Q?VTxtHiczjJaPIBIi3YAO8/xKVh4tqfTHX+m1vktFn4nbWevZ9xFjap+n+wCp?=
 =?us-ascii?Q?b8ntrq+eNl4xkftyRyhDTIfSHIYPEOtOn59/GwlZSwwXQhklqNIklUvg6udN?=
 =?us-ascii?Q?Dr8YUGU5s1HUxLLu0zWADVUx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd82a56-2980-4646-906a-08d90adc5498
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:28.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBVs9k4WoG6uWWCoPKGk+JbGoQueM0cqKPXuKHFLxAyldfxtpMiMQ9KdIJJT21qH9aF0Z3aer1xGZtP3QlGrhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
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
---
 drivers/soc/imx/gpcv2.c | 141 ++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 1d90c7802972..7356e48ebdad 100644
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
@@ -147,72 +146,104 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	}
 
 	/* Enable reset clocks for all devices in the domain */
-	clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
 	if (ret) {
 		dev_err(domain->dev, "failed to enable reset clocks\n");
+		goto out_regulator_disable;
+	}
+
+	/* request the domain to power up */
+	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+			   domain->bits.pxx, domain->bits.pxx);
+	/*
+	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+	 * for PUP_REQ/PDN_REQ bit to be cleared
+	 */
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				       reg_val, !(reg_val & domain->bits.pxx),
+				       0, USEC_PER_MSEC);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		goto out_clk_disable;
+	}
+
+	/* disable power control */
+	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+			   GPC_PGC_CTRL_PCR, 0);
+
+	/* request the ADB400 to power up */
+	if (domain->bits.hsk)
+		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   domain->bits.hsk, domain->bits.hsk);
+
+	/* Disable reset clocks for all devices in the domain */
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+
+out_clk_disable:
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+out_regulator_disable:
+	if (!IS_ERR(domain->regulator))
 		regulator_disable(domain->regulator);
+
+	return ret;
+}
+
+static int imx_pgc_power_down(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+	u32 reg_val;
+	int ret;
+
+	/* Enable reset clocks for all devices in the domain */
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable reset clocks\n");
 		return ret;
 	}
 
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
-
+	/* request the ADB400 to power down */
 	if (domain->bits.hsk)
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, on ? domain->bits.hsk : 0);
+				   domain->bits.hsk, 0);
 
-	regmap_update_bits(domain->regmap, offset,
-			   domain->bits.pxx, domain->bits.pxx);
+	/* enable power control */
+	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
 
+	/* request the domain to power down */
+	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+			   domain->bits.pxx, domain->bits.pxx);
 	/*
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 	 * for PUP_REQ/PDN_REQ bit to be cleared
 	 */
-	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
-				       !(pxx_req & domain->bits.pxx),
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
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
-
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
-	if (has_regulator && !on) {
-		int err;
-
-		err = regulator_disable(domain->regulator);
-		if (err)
-			dev_err(domain->dev,
-				"failed to disable regulator: %d\n", err);
-		/* Preserve earlier error code */
-		ret = ret ?: err;
+	if (!IS_ERR(domain->regulator)) {
+		ret = regulator_disable(domain->regulator);
+		if (ret) {
+			dev_err(domain->dev, "failed to disable regulator\n");
+			return ret;
+		}
 	}
 
-	return ret;
-}
+	return 0;
 
-static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
-{
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
-}
+out_clk_disable:
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
-static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
-{
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
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

