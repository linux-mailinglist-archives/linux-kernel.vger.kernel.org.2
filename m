Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB2374C64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEFAd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:57 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:18516
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbhEFAdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLu3TTq2O+xZ6+KrWmK6BirYUvlg+dld1G2tEID737V7KV3NlqRz+d0cb90ngzL+/kGoD13brJkSnEGY7j4MO1j2pC3CuwqwUFHy7jkQdMRzzHMbdQXqiSaYBEciLyOyey7rBE8/TRFU3I/7p3A/U8Zp57u+pOsnvoBX+wT9H+WOcR4A4369w2pIdFXWrt+6d757NNlzpR1WCVDEgEwAmNCzE35T7QKian9Ai2RbjNs6vWrkp4958/4ZSsaT2EISLs4g/IOgSXD+2whPHGGuk2nYA7n4q5YxmjW9mcrBD1vhKMsRHBRzIxBNGu4EK4vx1rIE0kzD8waRMAge2Klq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/CcXJHisbeEwQiC/2wjiV7K18Cl5ppySJigRd1zH7w=;
 b=Z3MX7OWkJ/roFUAa6vbuM3lmvv56aofhNyLb8xqpj0ReG3Tbj6N83b9kSq+FFYyVBAOc9PBVBLEC1y510fS6FUuwTaba9WRZBYCFVA0RIvaWpYXs8FHi7l2FkD5bGtcxKfqnqgvIHwbu5aPGOJMQJQUTnetY8mjhaFZAoSzxQLBmujPxeWVPLNbmxHaZBTFFJ0FNSpFarUTUNwoY78Xq5c+3zWASxe1tgBN4nGEQdP3t3L8KNv+da//DwFp54Qnu0uZmEssHuPTdr0ERt7sMEG8nvVNJT9ZAi0W3c8X+ztQMXnYLJSuaQfsOVVoujz5p9UIiql2v3JwUruxCI93MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/CcXJHisbeEwQiC/2wjiV7K18Cl5ppySJigRd1zH7w=;
 b=lONkOHviDhDV7gh9x99u5e/KIR85sKeMPHsuGUKYy5KFPCRbsEYsKjmyvy8Dg1kumzw5LuY9aM5z7f11TtNTDv/jZYK5/nmNdZPWCrgThtYARjlKvRzQDClcVK4ckt7mPcx6ejOjURmR0el3121o6Q4Am0uki3X/eO/VF9oHs/c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH V2 05/13] soc: imx: gpcv2: wait for ADB400 handshake
Date:   Thu,  6 May 2021 09:04:32 +0800
Message-Id: <20210506010440.7016-6-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88484de8-c52a-4572-d2af-08d910267d87
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB671474B6E057352FA90184AEC9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSdaWgE6s1d/n0Dduakx6YJbLcgvG8HJMdvv+laVL3cJiwx+HOc01dxvkszrzoXmICMogrMeo9ARxEUF2lntGmOb+1jN07dRseLSi+88gfliDEwJiqnIlh6eyrVkIxh1orvIVtnvrMmupV/vQapQsmJuhsnoQOBET5FKRLUoLFa/WAjpQSJBgPMqEiehpc9ZqytGUkNQZ/IqcL9fjA0wmWpEm4Hys9WN3/Ojvr8Ca3dkU4tGLac1HzIqkwd7ONlxPmhHiQxc2XL5DP0lMcDuBPm3LCvPtnGulK/5dLTTW9wPAKfvCar9eTDuzCUGadgToA82AU+UseyMpbhCGqf5a3PWCpMmEBolWJmihGcUJL+X4T5p7/oLMsIlDviaGKSDV0sBT+g+9ZKq8M0DaQB42+Ag6Y5Qh8KOxnG4PzXSVDzI3JAZKaVKwftMttrgAp7Rp7JLnjXlEX0QERmBqN1pFukWN0uTg/dqlRtQVfFYDyarAVRH4HlJQRJgzvSXuJDbdn825yh1qJnbM9RascL4brl+oC3+x0Jm5Xut1YWh828on4W9JKyuDFEt/878a9ok+J66uc0c9p65Da9CSxb2Uzflpld0TMU/mrC4KJvCwbCiERbeA4sWZTpyt+Gqlj1/qhsQzYMuvuVMFlQx1PaUUlB/b65fVvZP9DKPK8rjoR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2A+hf/bt3UeHua9nYYAtsOlEoGzStDfMkGC70O6sjO/4tiVfEzhdO7qlN507?=
 =?us-ascii?Q?fZ+yNd8GVsIgTPOqLHlPW7Dq5fkV0hATVRJor95j8HpJG+Mmdf6aiYtrZ8ro?=
 =?us-ascii?Q?qsxVt/7G50Czhephll6n34FNb0aT2TbBOzaECoOSYWWEOqsBbu2DeQbS0HC+?=
 =?us-ascii?Q?o6GDb97rAO5UM74lj0wNZrgcuq+qSxkXvFkOWRQlqkEjAm0VyqX4BrCUEpgC?=
 =?us-ascii?Q?yENPJ+QgkvHXOtdjt6cvoXQyHTiMZsLS4aQr6xtD6Ncpxkfgr1cQqpk3t02G?=
 =?us-ascii?Q?eOf5ASd9NmcYU5Svse3Fnyyq0ffXW676xvVDG2f9FLdV3iSiAxNMmY9uZvQE?=
 =?us-ascii?Q?Q5aK/xHPkCIYQlR86h2Ut+YY5eDnDeUox8H3mM/6mvzygftqNhn6FXU5neXr?=
 =?us-ascii?Q?tztVb/41xNBhtGUSEyB9v6ntFuUNxhPTNmLPRxSq0ag4nFWKe/aQG5yVRVsH?=
 =?us-ascii?Q?ekbARdTFAEvLJAfC5uoJkK7gzD2g3TS82kFig3K47eG2vAHeuvWhwop3RNME?=
 =?us-ascii?Q?MJFwGTEb+ccmEGM8aZV4YpVk1Mv43b2slJWKP/D26ZDYjCdpJSIBndnGByMS?=
 =?us-ascii?Q?FEWgs1noi2eyTysZBVq1TqUQfLFllC5p4C6JTcOdLl3JRA5TTAciX2U1h+u3?=
 =?us-ascii?Q?515cW876w4K6FWGUtVvHZIWzq8HuqCvr8QR5qXhRhyXRV95gw4CW83Xjmw0U?=
 =?us-ascii?Q?rvFQejXtxFpVj6OepL0MK4Y6TFyklS72PkVhEv1SgYm6j9fVRZn9lD8hRJU0?=
 =?us-ascii?Q?+En3TO0KYksfWNl6wmQS4At3Cauf2Pq9QDqpGJtxQYa3qmiNHOlwPimdqY4F?=
 =?us-ascii?Q?avQwyA/1pcEHsZHhn3x0iZEydfn1L4fFcnJZeRVOAO7gQGGrJtPccgp9DC4L?=
 =?us-ascii?Q?SpeM0bpi0ioYx0KP85w+oNH8WryEKGjLCZtuMmMKrx4Fc8KnMyT5XiJuyJ4p?=
 =?us-ascii?Q?7dTsFQMxLxHkOcVlOF+G03qlwTvqzHFDygKH6kZ9bHb9aLfX1sl59WxAFcC3?=
 =?us-ascii?Q?0qs/1PKCPxyNTv8oibMEN/oWqrawTpdfXbat2ymxVWJmG9Jkp19bdWMQui1M?=
 =?us-ascii?Q?ciorSwsoIrOTwsCIxpkpx8ozQiVuzdiOhJ6pTnRgEHcxSubJ7mbjx0mLPH6h?=
 =?us-ascii?Q?0MqnavClKnmkM3dq8VrAvp1S25ih+o3g4v083pd6MGOTqUgeS/O9k+7ILMI3?=
 =?us-ascii?Q?ivEtFVvJXhhYvTQS1mQ1j1M1+HbM0FOb/7y9wRn+OR5Q8m/0IVG9IaRJD7yx?=
 =?us-ascii?Q?fCYmsGXDH7+zIfftndEAV/oVT+Ic1x0ePPVIBrjfL7BsOy6Kt641Y2/eIsUO?=
 =?us-ascii?Q?Zxi07yUMrsNI5gs0Lym+enB1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88484de8-c52a-4572-d2af-08d910267d87
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:55.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEeaSbagTpYBw8xuQEvf+5OqP4RXAmAobvc9U/BoXWy1KzXGw9cOCMdfWQyoHZ7qtjautiumuBeCe0i0cnqmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

New reference manuals show that there is actually a status bit for
the ADB400 handshake. Add a poll loop to wait for the ADB400 to
acknowledge our request.

[Peng Fan: i.MX8MM has blk ctl module, the handshake can only finish
 after setting blk ctl. The blk ctl driver will set the bus clk bit and
 the handshake will finish there. we just add a delay and suppose the
 handshake will finish after that.]

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 47 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index bcf1f338b0bf..558b8b8af9af 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -69,6 +69,9 @@
 
 #define GPC_PU_PWRHSK			0x1fc
 
+#define IMX8M_GPU_HSK_PWRDNACKN			BIT(26)
+#define IMX8M_VPU_HSK_PWRDNACKN			BIT(25)
+#define IMX8M_DISP_HSK_PWRDNACKN		BIT(24)
 #define IMX8M_GPU_HSK_PWRDNREQN			BIT(6)
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
@@ -112,7 +115,8 @@ struct imx_pgc_domain {
 	const struct {
 		u32 pxx;
 		u32 map;
-		u32 hsk;
+		u32 hskreq;
+		u32 hskack;
 	} bits;
 
 	const int voltage;
@@ -172,9 +176,23 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 			  GPC_PGC_CTRL_PCR);
 
 	/* request the ADB400 to power up */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, domain->bits.hsk);
+				   domain->bits.hskreq, domain->bits.hskreq);
+
+		/*
+		 * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
+		 *				  (reg_val & domain->bits.hskack), 0,
+		 *				  USEC_PER_MSEC);
+		 * Technically we need the commented code to wait handshake. But that needs
+		 * the BLK-CTL module BUS clk-en bit being set.
+		 *
+		 * There is a separate BLK-CTL module and we will have such a driver for it,
+		 * that driver will set the BUS clk-en bit and handshake will be triggered
+		 * automatically there. Just add a delay and suppose the handshake finish
+		 * after that.
+		 */
+	}
 
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
@@ -204,9 +222,19 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	}
 
 	/* request the ADB400 to power down */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
-				  domain->bits.hsk);
+				  domain->bits.hskreq);
+
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
+					       reg_val,
+					       !(reg_val & domain->bits.hskack),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to power down ADB400\n");
+			goto out_clk_disable;
+		}
+	}
 
 	/* enable power control */
 	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
@@ -369,7 +397,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_GPU_SW_Pxx_REQ,
 			.map = IMX8M_GPU_A53_DOMAIN,
-			.hsk = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_GPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_GPU,
 	},
@@ -381,7 +410,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_VPU_SW_Pxx_REQ,
 			.map = IMX8M_VPU_A53_DOMAIN,
-			.hsk = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_VPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_VPU,
 	},
@@ -393,7 +423,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_DISP_SW_Pxx_REQ,
 			.map = IMX8M_DISP_A53_DOMAIN,
-			.hsk = IMX8M_DISP_HSK_PWRDNREQN,
+			.hskreq = IMX8M_DISP_HSK_PWRDNREQN,
+			.hskack = IMX8M_DISP_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_DISP,
 	},
-- 
2.30.0

