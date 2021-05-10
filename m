Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4B377A91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEJDa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:59 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:3041
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhEJDa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLb4XWhmFHmYAe5/ppIjpmpuQoxKgQ9D2V8XbbVXYj/qgSABcRbiEgwK9CK+IsMIv2h9t0hOuQJIEKbATaaopLMaTYEDfu4oCnsaG4ZmqjwFz7ZpFF2jbxxPvkd/Sa5nfTBhXC+PQCCNUq1mhmrgJ913pd0LT4NULbDgYdFE0BtjSsefRTFYNPREn0FrFsxAI1ao42TWYmGaeiIePZ1rMiReshoIyeEkKOt2+bfgndF5wuuBGCJnUGdYqHo7orAVaFX1GNwWGrrQu63t3isK29Hoa7z+YefyeakbZI3AcOyt2EWSjP5mQDWMOz4ouR0aStjXCJH1+HdXtrSAzXevnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp95uhgHswPJobcTTddxxg2ESZwXqhvhUAhAT+7D6Ac=;
 b=ZRuR1Sx2/xILBVzqSXq/JG9lPVggMVwWPwvd86/KeEAV4BwEODmnSj/aDIGHTKfy9W4652DqFhp12gETJQ6IDwzzyU/Snpq703ptRFxaU+mSivR8EN2h94mgXJ66R8IDdnCm6rWnq6e89preCL9xCjlEuw9r1U1cDmIa0U8iV4hQpRmgHYNDz5WCmFAVFNXBVqznd65bQlrZKTW8zO2mwSs6IgcRn8f/BDqm30bCn14T7Y2ifjIlFZYy3+6QU8SeMEX5kdk+z37zYnuWp2y4e80q/dKScMolK5FEOlr9SqFRn+Pr9Vn4doSnbtYDhzVxXKScCB0KOhkYfBKrY+7JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp95uhgHswPJobcTTddxxg2ESZwXqhvhUAhAT+7D6Ac=;
 b=D76MV02IkesfA0RocP9syheEM8MiiuLMlRFASqw1ErxMdavgiLvwKlLUocm4tP7OcPioppxzKmxnz9Rjw/3CYsPEvREmHZ/FmyqdnjvwnY+t+YZNCv5Ga4pODw0P2rIlXoacvn6povIaK+UOx+Tco1E/ViYEg5oM3n7geBOWxHI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 09/13] soc: imx: gpcv2: add support for optional resets
Date:   Mon, 10 May 2021 12:00:41 +0800
Message-Id: <20210510040045.13225-10-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68312f10-f2f7-4fee-e721-08d91363df00
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091251A213AA89EF8B32BEBC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxzxsc0qwhlSxKa1B9qnxpcEUJdpZ4yINRSfjCJewdMAVcRbfyxdKgAxEcDaV4y0Lwnmob/Su4sqsxl9vE6aJdBozRoQH4lEkk5EWoXEp+rK5TUaX52Eyk9b9LlIKOxZiVMvtuMYUdc0Rn5DSbZPi1sKgLnZEncKKTCU5hxht8dCu5MBgoUcvu1Dy32z7gM1qBy/VCfPgwyg6SbBmg7jD4VTS0iLTR04qoQZSxrD1ZqrAogEyJ0nDGRN6qEF1iZa5frGFhij+4p0+hV8NtHLoKcxcyF/EZcMNvxiJ92+fEb6n7L1K5K23KSafjbVhGalNJH909bJQdEiAR261rbz+5cXuK6iGWraOgH7qD4MVT5dHgFKJx9jocXu4ZHtufDgsil9eqyIO+5zhUBAaq4Kci3Xzwb2AyPFNxngdR3HYplEkgOCNQb9zdlbSlkQSOvqxGKVvB8RnwU/sxN1MT3OPqdFscc5isIVWG61OT6ynAVO5PYBp5hNcA7lvtoWJJLiE0qWdsRXjBGc2lvGdTP0wFkJRKh5vdapRQiAb4CWNYzbAjVcHNj3+5Fde70+fTkwJcGiVY5C3XZQG891bb1bnZmLYJg+v3yPuWm+EOkAbu9syB1CpaozFtkJB4UT+vPFSGK8Q2wphMCMPSDJDBdwgKIYOmiWRgHZYrABIbiu8Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yxMVAyNjHdS6R6D9q+GiFFTHNn6olcAOHZkIVKTlIHffvat7gKzXeaVwaIkT?=
 =?us-ascii?Q?tnB/qwq8DitrlF23bDprVkUkjmr03PW1C5vMDkDtM/VgqiD1fx737VNaUgoP?=
 =?us-ascii?Q?KGCI14bezbtUHVedinDUBMioxSAVIiKnNVKdAoeAobiImrHMXa7PTqigevPq?=
 =?us-ascii?Q?BCHP1IzvHGYh8D2N37V99eanqIBFEwslrwBZep4Hlxx0Cc6N9MDtL0LDjqry?=
 =?us-ascii?Q?yb3hFRtj55N9agsAef7GSV7J4ZWyEB43Fay6KyghD8VppFWx6Ei0QRfWeAYO?=
 =?us-ascii?Q?sNmOWWHEhwmc85wlp9pebrUr6hK5UkYDvucKwkdg1obzrstbPFtu3Waii9by?=
 =?us-ascii?Q?AqwlEpS70mjcxEOTgbVkY/vRkqy+TbUFX0WhuRN4fWJ6eeIOuRYxA8T2AHBJ?=
 =?us-ascii?Q?1cobL4QB3Otnkwwr6hIPpKQhQ+e/WKOdOSsKg35Ulb1fve11aqYlM+TALpFP?=
 =?us-ascii?Q?o9A/dFCBjL00jfTBZWwFRWBO9qMBmjkQtCOcFbdg9yibWuv58rzaUW7HnDrT?=
 =?us-ascii?Q?9TPNns22s4ejhAy1itMA3kvYCVO1c+itZhzXfUKGzLvyPjTjGflFxCQhDIh4?=
 =?us-ascii?Q?moYD5fQcSpnhjNJ5OpW+c69FfIasYwVhDd18cbHCM7xMroMPtHZiRAqlycAl?=
 =?us-ascii?Q?GV1uRIJ/iIo2I8w0pHJ6NjCzgCzmQ0ix5B1324y97NOoCd2/WrO2aFHcpFR+?=
 =?us-ascii?Q?cGJO6QSX8eNZn6U4DlRynGj+ZepabkWTcDKEAsdpuPF0b0j4rn601bwy0uSF?=
 =?us-ascii?Q?VzzoKfpTwyDPRfChDtKtbo//OVQadVzluylD8OxhMNqEPyl6AHrEA1G6UVKp?=
 =?us-ascii?Q?1qUFfPYcAi4sz6k8c5fHUkVDTzUPK6t/RwzvbLHN5jdXXF7tAv3lpB5MJISO?=
 =?us-ascii?Q?m6BNoVRYR7RRmNgk3ViWpEeNisVjMH1AzJLydfDEOdtAzvXaO0Enp3anb9Pr?=
 =?us-ascii?Q?dXJjwYmAASeF6rZwbZXN1rFdU+FadI8EsWA7mriSYtJh7omqIxzTrVIPZoau?=
 =?us-ascii?Q?l5ENHBMWrkG1qKRZKDz1e4pKcMSEa+dURI7ShraOUo+vqva8MYsym7b5PSiE?=
 =?us-ascii?Q?n6/YdRm7oD6JcYW9CG06808JVcFRgqbMraaCfD54BxMOhDmYcSH9cC8t43Od?=
 =?us-ascii?Q?DIytxO2ntTZPcHkaaHfWGNkQUkvjl+QnJ+IH3ic49WNvgdpsJRe8xna8pW5U?=
 =?us-ascii?Q?LxjVwW+JXXDsUjfKYC6a9gmpccKqR2kw14Eqk/BEKG/AnWhWUxHBvUhnhh/K?=
 =?us-ascii?Q?CK5Qs5HM7xqjHwx89uSGZ2H+CHDkgVkTsR/avgSMtiirI7jpnq8eMM6QsE8m?=
 =?us-ascii?Q?E28Yow0xVRHzh8VyeyCKeSn5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68312f10-f2f7-4fee-e721-08d91363df00
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:51.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v95UfO/5xky2JcrlbYJUhYgTFIeNwyis63pXONbe6uTCNF4AL6ILW1oE6eLr6mH+If0YqrA8FcU6+c0JI0NbEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Normally the reset for the devices inside the power domain is
triggered automatically from the PGC in the power-up sequencing,
however on i.MX8MM this doesn't work for the GPU power domains.

Add support for triggering the reset explicitly during the power
up sequencing.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index fdf759a7c865..04ce64326c19 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
@@ -108,6 +109,7 @@ struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
+	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int num_clks;
 
@@ -163,6 +165,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
+	reset_control_assert(domain->reset);
+
 	if (domain->bits.pxx) {
 		/* request the domain to power up */
 		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
@@ -185,6 +189,11 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 				  GPC_PGC_CTRL_PCR);
 	}
 
+	/* delay for reset to propagate */
+	udelay(5);
+
+	reset_control_deassert(domain->reset);
+
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
@@ -540,6 +549,11 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		return dev_err_probe(domain->dev, domain->num_clks,
 				     "Failed to get domain's clocks\n");
 
+	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
+	if (IS_ERR(domain->reset))
+		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
+				     "Failed to get domain's resets\n");
+
 	pm_runtime_enable(domain->dev);
 
 	if (domain->bits.map)
-- 
2.30.0

