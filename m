Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76A736E551
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhD2HAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:37 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:23809
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238925AbhD2HAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRe3RF/TgtVeah6yqR0x03hDHVkEOx/bdgtW0EABDhchc09fE0E84R9j5Js+8GwI6m8wtGOQx3QLXv5+gUKZpMXSO9fAB2OCGjV7Pjlr3mJMpq+KSq9wS0N9sc4QtsznDXvXcaEZ1gXvrptv9lbtf1PnR0nMzG6jTrCtgHJmypkAyUsFsGVzQmvF6suLPPwTRJy/X/DtYt2v+MtGonhEG0s2KRaAn8I1HVb0UTaW6BvpmsMXGDeTEVcs9ZcJ0spw6Ezf20MukCmbeWJlpilFqnWBe7H2BS1Aic7tCc4Hj1UcLhDV4rzifZnhxRvpmVmr1dEdemVTaTNDNxoyqMSnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0v8WtcsH4tJtAfSzv4uH4MYuURGDfvKhWs1KvqIGxM=;
 b=EuMVWix9OiL9u1BI71lXDjxrWNZ/Pd9Y3bgpFTy26gSTlwm3/How2dmLAhmUwt+ZoMyQUcU0J8gSMelMOrV9T0siHBYl4xraSfwI2KLCh3JLnDoz14YD9gfKA28uxjI4BbmA2pGyA0TVIKKp8INdGiJSUbSiH4bMHFREpj4lKLKDHsmMvAhSJkp2odB5PmGlBPEAuz3IZM6hiWLZ5mZFfxaO3fyLj3tdMHP+PhmiXU19PwNN48AiXabdwYe/l/1WgbCu2zvSX88roEb/IL+0LWnbljkHxhm0fl6wGVYUyF0uAgk+HZPcAYnz57uVZ9QpygOgeltZLOb+mF6p39KZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0v8WtcsH4tJtAfSzv4uH4MYuURGDfvKhWs1KvqIGxM=;
 b=UutrzkhD+xPnEWtVZFt2VBVAwj139+GbbT9YjzdAnxX/rvNCuw7nzcftNBYyb4XtZOm2J3icGkYJPtQgOEFAOE0ks0ffjlUaJwKHp282mj+kAygHk3R2VZsI+KQcKbbiX0EjvRdWZvleaT6vps8ICHDxZT2W79QbXWt5gz/VxyE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 07/16] soc: imx: gpcv2: allow domains without power-sequence control
Date:   Thu, 29 Apr 2021 15:30:41 +0800
Message-Id: <20210429073050.21039-8-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52b9b2b-aac7-44bc-dc04-08d90adc5ec0
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB546850590C752E29F9D23C4DC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvBA7aqvQuduiUtjeDNhmpUvIJ7F4czEsFpDYXTtInEx1Mq/LcTfxYpBhVgCxb79aN0HyNA8jIFBoPdTIlff8cF22pj7XlgoMu5FOW+0I2Y+XygMfGEMROs4Q31MMCg0eY4OB8dpiR6YAD53qhPSsKizwOIisrWblo1RiLbERE4aJLcY9y76581XeG6hWtMA5GhIegelKSrkdd6ECewNkLtHV2sSX59/8sp/KHzsIZz3ATWeXxppd+39rtnxM9O+HHRKyW6G8I0i/IGsCasb/YbJRELsOLqYaubODnFzWK9pPmmBQjqIgNa9ZmTNeHHSHo/faM0Wbf2j9g/KPW9+9Tv080rReUF1pWz+MLQBCSfkDJLVayrOvQTM7Juf+x1AuU+m5ubXn9VdL2ZWLyUD5Jy/Pyfk40ruWrA07UPsLI+nDW9aap+QxjgWxnRHd1fBILLSAzH2VORqgevqwYQczsePyT/aAXuw4JeNq2nAjj238XrpLVzD1CTktTdNiZMk7tBEa/zv9yqEjhhfW7yVqEVw/XcZ39ggDacSUP58wlkI5HOI4ZNYdW3nN3rfwup7wdvXSP6ydYDN06tb6dF7l4ISI+rnfC8lkQ9ju2Hk+9CEtcAHe342xCZVM1N9RX1ot1TDLsYFl9X947qAEOknm0QiK5+IInhpN2v6barXPPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EhrrDWqyTRw9lzPh7OFdgsM7HesHz1+BFndkyTtDxKVR3TRvbb7s1sgC+GuK?=
 =?us-ascii?Q?jAkP4FTWkKCba0xG7xuAX7ri5bF8Cmw2Xw9cVuGBP3XGA/HXPizBlCG9NCn/?=
 =?us-ascii?Q?5slK6SlX90fF6lRqaCzukr35O1N1XtifLZkheHWGnLINrHGcShBdAjJi+l5P?=
 =?us-ascii?Q?FOH3JezR6ms42l0NmULuuGMgma3Zdq/iA6Y0HWFYJTIjuMziiMXJSdIUAmIy?=
 =?us-ascii?Q?8TiE33MzhnVwYc7H8NqO9TAWLhHOx8yO7jruuTGmS7MLH6fD/0TGqUI6U8r9?=
 =?us-ascii?Q?awItWhSOJ3Quy0KGGqrLMdAiFj6ui8KbT3rnUyOS3+KVx1WgnYMH5epIFotF?=
 =?us-ascii?Q?qC14aeLlkEN7gS7qHZRpR17lacOYRQKir7R3OtA+yhQSv49SDzUG+VzpVUNj?=
 =?us-ascii?Q?ULHC4tKAuQz7zVCKvrAD1TR5Ygulw5t+l4DatyO6wsm0P1jQ1IviCtuCAL/r?=
 =?us-ascii?Q?h2vQsn34ZKbCR/ajNnM/lB7i7WQ37fFuA9jVvBXcQgI9KaHnWcYcsjSg049E?=
 =?us-ascii?Q?3ZoGvQ/JoxQPeQhzRolgYt0RgXMtHm3tGA9wY0NKl3WG56Tc7zgQVFoGzvun?=
 =?us-ascii?Q?aHezxmcF/ZGCAl0dgMHA7IrvYGjj+MO0Pbe/n0CJqfUkZr9GU+rR0EO965jq?=
 =?us-ascii?Q?n9IwJhtmuNO/wjztWyMiUNVmYpVPB8P0cAMsiqI6dOgTtO+7e0Y0yRPwt7Q7?=
 =?us-ascii?Q?p5zfyTd2gG6yE4bm3TtlROWm5baHPpZiDC/IQ/4M7Qc87qZM373eV0tkp6Ui?=
 =?us-ascii?Q?DZPTBrZVG7b8M0DwQilj0tkWuJckig7ueyc7+Vkxxu6MOc8PQhc4xQ4y09cH?=
 =?us-ascii?Q?M3m9TjuJer9bZ6PbD2XEWcaUOW8h0yoURqiUkhewUKSb7QC9ieDovRHn4yEn?=
 =?us-ascii?Q?81Mjzfq+dKulhkqVnS9MOVJIKvn3cMtfuGY6WoWnymxmr7bGwLEJcOIVlzlS?=
 =?us-ascii?Q?HzFH7vwmDSQBnK7wlInwfjcv3bWyW+FM/PHClYm8T/YvsMvgyffxZ6VEi0za?=
 =?us-ascii?Q?uVoqI+iRX82MhdayPmwyj/wo2HqwfF/M/wMeknTstFbSY2IL5iII/FMZAvzP?=
 =?us-ascii?Q?4zxd+s7SDa71Vqhjlor/FOMVpZRjVSdGg+eudePZyrMiRcC+icGLmFQ8WOr+?=
 =?us-ascii?Q?tgTClh1A8ltvMqgz5NAHQfT0eVEn/q7otRJM7NQ1CXg6ksk6LSuB4Qg4eOQQ?=
 =?us-ascii?Q?RJyJz5exq1NmH7vaWHkG0v32ENTCY0qdORhj0ZefW4qFM4qyqkrZudZiavun?=
 =?us-ascii?Q?uvjipFIxnIIn3rXaBo3GautM84l3RGBYZ/atv4J/VCHR+5MmJr+YYY9JkkBs?=
 =?us-ascii?Q?yw1Ww0s3Y5I+7A9fQ+LGkyvv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52b9b2b-aac7-44bc-dc04-08d90adc5ec0
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:45.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lz9bUdaOKbdmJdQRLO/2YH3HvY4wNU+37HLJiqBqeT3Qky674hFczZZwxg2u/XEMVwx7LmfdnBfrU6u1YvLPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Some of the PGC domains only control the handshake with the ADB400
and don't have any power sequence controls. Make such domains work
by allowing the pxx and map bits to be empty and skip all actions
using those controls.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 87165619a689..640f4165cfba 100644
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
-	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-			   GPC_PGC_CTRL_PCR, 0);
+		/* disable power control */
+		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				   GPC_PGC_CTRL_PCR, 0);
+	}
 
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
@@ -241,23 +244,26 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
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
@@ -532,8 +538,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(domain->dev);
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, domain->bits.map);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, domain->bits.map);
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
@@ -553,8 +560,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
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
@@ -567,8 +575,9 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
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

