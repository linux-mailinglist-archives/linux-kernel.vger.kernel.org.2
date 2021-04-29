Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3636E555
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhD2HBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:01:08 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239316AbhD2HAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRQgBrBE0zP64ZzJ4ZGDkvUAOcQrYbtxzazUoDgCqKCPwQFpAwO/ml/hFMZxSx427iTjidCU5ygHI3g+8Y5HKqQQFzOVa0bgF8FSYoQWJKiDJX8MHvxNtBhv0y0V70NGCByFs3HyG66vrz2DJFzjd5D7gy7BqqT/+lvSgNvJ7GMTwZ7m5YkkYMv1rAGNzPuMWRJ9EG5766L4qYOPIUgnX2GQl4zcUvsGX6ox/cSkcY3h3Ed7VowCaZPMbU/5URmTZp7t/o2UNCN16ukBcTidNRkDT81jVig+hKaKSgrChFaJ4YYCEkahdgw0cCflVfZr2aoYW5tTviGlCRP0B/oCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHsV2o7FPAwFDwz7mNIvKCoXLrdDQsZbcM6bqE5AUXk=;
 b=LOZcrh2v12DzR2fV9iONnEO7yB88D/FIEO7PiP8GrfDzEaygO4cmhrAkKaC7seiE/sRa5ZTO0cAN6/A0IxrkDJihf79bfwWLsJrWkGb1UfiHmiMjqf4/dCK2Iy+XLFNOMaro5eEcq5Jzaj6HDn/xhYBRQAzx1XJK1L8Hyg/Wo0U/Cr2HpkSHqVtROfUhlcV/qMlJAOqgGYYPOZJsFlXkFOEbLNAb010/HWFD5mbULa4CTKMkyQhoL4BRR0KJjHmJPwO2/Tr6wjCJq9n6gnJA/GSfnfKpIFygfolqnTbQgQYPnWytgZkhyktTTLBq57zrBMZqK5h61PYm8hxSV00rsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHsV2o7FPAwFDwz7mNIvKCoXLrdDQsZbcM6bqE5AUXk=;
 b=OM6vXwHQRU3rOkKoS8XN8FAtQRmDsf33TgGHT/GdGrtEt89dev3m6rBRIpY2x7Xn8cVY16AQmcuaxDvivDuebNLD4wDcIAYlKE690pmT2QE3nKItrqFHbf0aImuRul4iGO/3vh10HYtKunZeHnn4+RNxZ+82ZdFzfChWjE3ztQ0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 09/16] soc: imx: gpcv2: add support for optional resets
Date:   Thu, 29 Apr 2021 15:30:43 +0800
Message-Id: <20210429073050.21039-10-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac44cda-22f1-4326-96a6-08d90adc65a4
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468CC706C59E6A1400F739BC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1gu+PNPuXYUmGe837eXwDtdZlmqeRLdpVQkrNeinfSyt9Ob6hi6W+vZK4xElDHswYKRvthouHSBMmj7Br5Dpo9p5RO7hQ2w8AVZPbGP8ddMdplYZKlFVGW3vQbV21CDMV3YJrR2dxcXHVHzIZRmveij3xxlmnMpFMlWWP5F7Rn3oE0wZkmX/OaZNWXOA1ZBzloF6ekdTt2yX7Rt7umspgGYEIpLp9rIqfIPhGVtkZ1bG7pveZ6TNWS8wvX0VWRei1EB9M/xf9cbejWGGnzPMDiMp9XAgGea7lskS023143g0qbxLwL6Hlbv6Ykqyd7O+y+C6CZHewF+Kfl5tCNu/2V+eH5bt1Sc3EDu+FUnHeGWziYUTtyUuUhaXqht+cbd6zgAGPPUYpo1rqzZ7SNb5kRgUfe+Mh1YRs6ZUT3JifOeFPNk59xUPzlbpbgj+SRFj+IYuvpKlHFcpALbwG7llbFx7SnUdewcryx4qeutuQ54PXCMyjFqGaHED2vBE4QDBSBNZSk1IhG6zqOukTsxdsBekVh4qWEVWI4uuTLB/lSEETIa/cqxIzSJJJLJ213CDGaaaj7EdpMtgqAIP0Pucdl+5rs/81RScIIyhaHChCUZN8BfA4Ht/LBw9hCvgbDXn/CR29WlY+abci21GaRnng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1lFOAeEYjMi3QK0puG0gSEYlFeFzlfUn3BGz3+ZPKnjq3Ch+pK9LwsRNp0+q?=
 =?us-ascii?Q?qfV/s08XGOFUXiB5tp36Pv3xRf8PaMVPLDE0X5bSIyz0zmTP77CgDp8fUG1R?=
 =?us-ascii?Q?JYm4K2VKimcfx+PTGjKanp7WPhkCUVt/hsaxtWd4loO1T+3TD6EmdS/RnQDP?=
 =?us-ascii?Q?Pcl4p2nNO0u2QPRdKt526mQkEpbJngXNYuqYpli+mA1l2Zr3fL8vkiGS70Qa?=
 =?us-ascii?Q?fhe2YKMstvB0+Gkau0Ch1vjSoUctSKsrv01buEQvU17XDHzFB3X7JpUpufES?=
 =?us-ascii?Q?iBtdWDqYE/To0GZD83nCf0Nss0+L77aO6WYvrK2yDFZ4nveWKELsc4jn0eR/?=
 =?us-ascii?Q?e9Jw0maHWUPtlx5S3JM8ms1GtIn8iRQrCOhAZ7c8U1Q5ZmMmJQABI6V85/Gr?=
 =?us-ascii?Q?z6Ur6+fPvhAJuzJHi0OHnrQQAs3rvJRMBMLmSOq/L2sgtrwms2YrNmW4srz9?=
 =?us-ascii?Q?94rN9TBiEp/aP+dZh39t+pZeC8zHVSBvk+9n7I53bx3I01p+4i01blt1J0SO?=
 =?us-ascii?Q?EnINYFPyahIQw/flQnShR01LNI1VN9kGiw/nuTXVQOqy6UGGS+aq6+XXeb8I?=
 =?us-ascii?Q?C1sB4w5Pjf9ioiFtiThCOPYOMW0BSc/ORbhmoa4iyob+BeAdZ89FljtmFIPV?=
 =?us-ascii?Q?35iehNY+h8YuEpzveZSvmTy9VrpHmC8z4DLZ/VNFM3bHyifuVpNaz0ZhjqWY?=
 =?us-ascii?Q?8j2sfk3WOIhoLwWE5dVPkP9n7Y8SNdVDtKi5fJDG0rI1kFFDdRE0rrl3w+p8?=
 =?us-ascii?Q?KjYrmnJMOZtLoX0dQ7syLzqXEm69hoG807VjrkWBKjB4VDjQdwsiV9DDtnq1?=
 =?us-ascii?Q?0cWcfYbbtPQabUk74cl+4az8o2cBJ/B+FG2Mzo+3zBWNg2B9d5VBObAdimY6?=
 =?us-ascii?Q?bPKlkNRCkKf1a3qaKtNRn0hb8AzHbhA9NHNjsciYVl+XL5kBnHdWBNY6Bn/U?=
 =?us-ascii?Q?QgAiG7D0/Fv61OgDUTtQ2wjWRZD7pccKXP0Zv1pAxDDBPOKvlL89JMXpd0JY?=
 =?us-ascii?Q?65Sx2jBfXEeqM2bOp3ZoAtiLv7XthpNzq+Sk1JThTENox875d8REU+CWxVDL?=
 =?us-ascii?Q?/Blt+BgCcC4XIc6nyhcbgGNBMi0quvwihWMreoPErAwIPZ052WT0VicAMrf0?=
 =?us-ascii?Q?Mn/pKPfn+ndElrZTrReGEu6cBxFVuRp3uSSgplky+xh7EZq40uNER+W5Y1Du?=
 =?us-ascii?Q?ozeUuMRQC5/8IdmXrfuLvbCHyR6Uqf0iZK96gdiZtcj4AAFl/+r5IUcWfpfO?=
 =?us-ascii?Q?SuXi1R+XLLPlEaVZdE+H0lhXHba4LV50K3R8hFsKqRTnnRmXcQr4+Swywj47?=
 =?us-ascii?Q?5yPDvoBSRCzylCcCO23Wh9Mh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac44cda-22f1-4326-96a6-08d90adc65a4
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:56.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs6O3yCp1H3F58waPt806delvUWyfjzAH08Ifb7HPC8UcwZZowRwtCPEVcraIcg6+fnfiOebTVIM7Caisg6yyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Normally the reset for the devices inside the power domain is
triggered automatically from the PGC in the power-up sequencing,
however on i.MX8MM this doesn't work for the GPU power domains.

Add support for triggering the reset explicitly during the power
up sequencing.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 640f4165cfba..4a2c2a255d1a 100644
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
 				   GPC_PGC_CTRL_PCR, 0);
 	}
 
+	/* delay for reset to propagate */
+	udelay(5);
+
+	reset_control_deassert(domain->reset);
+
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
@@ -531,11 +540,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 				      domain->voltage, domain->voltage);
 	}
 
+
 	domain->num_clks = devm_clk_bulk_get_all(domain->dev, &domain->clks);
 	if (domain->num_clks < 0)
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

