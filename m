Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E336E55F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbhD2HB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:01:57 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237128AbhD2HBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+55lq9uMPg1pb+QKJvjzxWhUNaV+bqwxosloepZ/Vg3CqjsnUW2zPlUPQvT2FkgilgTxLqs1iVAajWE4/2Gnt28373FOhlnn3atxXALlKcsNPnhkmUhLBDg0T2XmwmnwuNVMJUk8x2BSFqbN5J8WfrUnHCEey3E4ROBQYuNBb0iS1SWW1dY3MmCrki/xdbE5wemujt5/2E0Xw3oHJLDIOwD6Jjw2CWV1/1MgyzBRq0JKWkA/CAunRG6HGdHf+2mAR/F9JweAsQrSO3P0qfdNbPNhF/GOa4Jhss+/irv+esz+C+Y4+SrCzir1boNNJvNjV0DoqPSjZ75hN1SPE93kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budKuoe6Ufv0QKJXJ+5Czx7NA1GYxskYolbO4lsYZg0=;
 b=gNMCUxyqJWATS+yGJj9pumPo2PXV/bqOpd0hmv9F1bFiSSDDsY3rpMzDEE28HnTDSSOO9wu+4+WKy32p0qRlVeWyZTIBFXdyF9fgcH3dDAnzr8O5M/cChN1oR1SlvR5G/eFlZ3z+7iqgnw9DATZKGCzi364xYXqz71TOOmeyLybF7R+KuWvt6WREJ0EFm2Tuibz5B7Um0RZchaMQ6D8JuZv7+q+umJ232mvF3C1ohnQMqLdeF9l6Q5PgiwIUCchnPMk0RvYaXF/WLK0gEQmqg22ClhjXNWEr80YTn06kqHVUG0VGlb2BqVieJe0Ena8+WHFzWTt0w6Q15lqXgWFrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budKuoe6Ufv0QKJXJ+5Czx7NA1GYxskYolbO4lsYZg0=;
 b=TfN1bmojuApVy/S2rOqHE4xKblVrWrEFkKrVoK7jnGqvEt7/Mn/eRD1qjD10n/miJfAnu+N7IiXfdSLZ9QDWyjHD5F1EIJdE6mvhHKoyHtS29KzVaBBKlibyqMhCnwtJK0poj1UQiocrOIuwTXGUcbdFzhSUKedv38+mfQVSGJE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 12/16] soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power domains
Date:   Thu, 29 Apr 2021 15:30:46 +0800
Message-Id: <20210429073050.21039-13-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 122d1fd7-4bad-463e-684d-08d90adc6fd7
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB54682D2D8DA31E11562FDC88C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE/FMBq5eqPcXnamE0Q0wzOtqVfBt23Tlwfuuo6MoV8RbUL5SOhIJmbYVoxpnRhDiwX4XhUFvQofvCha8sGvI1XZnWaCT9mfCDhI91I5QmWenoSRgNGyx20bN9JZo+o3HmdD+nUVpWGIaqQSz7Hvkv7wrsxmw+DNoA3YeuHU8/cAD3PXff0AnrjIoTd60UyqEqdof0uMjg4YvO9PGHWl8K+XYd0Bt43M3d+4LpHg52RGP1yjypYH5FhTeHSSSEAGnM+EB5+PcolnSolLU3j6Kcr0l/OzmD0eBzX4MSR96+qjcVDQOaRMO2vRxiyLfAqKQT25SRsJsoIevX80/fNKW5o/wSo7UGZKoSDaYj3Qp7vMo52NuE0emlLyagtj0krN9/zvOK7i7OvSW0Vm6nu5YH2gEtr3uz5ZwroeTwiM2IwuLfRdVLN/Jtejxas8r+rDo03hkMmMKB/l2K2svSKnEdSCMfavQ0o3HRTxwggCnAvFDTEX0HAOT92HvWWQcQ8YhUTKT8vnU19f1lcG09YFGac5Df/PWZP4iaxwABcCgxjECve84ebvZyDuu+loybCZTM7wZqNrVTa6pxPywhe6Mu0TUctB7vwdpbSW47wW0Ofin8NbrzZmep0r6nEEg6DwEDJ7Ky68Ozg2aMfRM/QY2rB2LYAjidJ1JRNB8qPWOFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/kAUDZPuL5OZYTzi83o0YLM7dSzyXpH3yupSfEzdy/V5UAeRn2Lr7iJi3fL9?=
 =?us-ascii?Q?IcjvDTvZ8S6BQE8eptlCqrKuSV0jrNXrReXDMb5rBQLQ1zq78lwY9KB+7fz2?=
 =?us-ascii?Q?v6slG50ft0J5Av8Cw9p0M/D3Y7GLTd/qjpaGf9o2jtzyGX1Oqadh2P9wVsld?=
 =?us-ascii?Q?/vukkf16MkWs2mX6keH0XEwdmevAIdXhwOQj9/j2A/KKRn8Q/c+rt2AQqX/r?=
 =?us-ascii?Q?sPi7M1DUCasMlwrfZF1JLa2UVTXOcCF2LkQ6d9YOLngeO+/m2YNegbuPXad7?=
 =?us-ascii?Q?wRaNA2FdlYMSyRxih5YP93+oCk0+jQMU3L7vxOvBTNJwQDqNiMRpvVsbGMcB?=
 =?us-ascii?Q?Iiv7spbiSRwyb6VouyE6W2QvltItg4wMEk7mI0U9gsw5LnX2VrRromvlJ2yK?=
 =?us-ascii?Q?PNrYdmAFWvvj38mnBfkMr6kMWmQcydKZcYyWKnsYXTXrr4cAwQ5qd/b7Xegz?=
 =?us-ascii?Q?WsbYnGABQ4LPNo6LTmx1S1S32338fnAjnuHuu9EWT4Ri67/FaaTD0JDWxa0w?=
 =?us-ascii?Q?TY4EA303OaKgt0EdPbJMxkiqyp1fIBixOqmIy6H9YZeHyeQQkrus10cgFLzm?=
 =?us-ascii?Q?mGMWh148CUGkO3SgcZYLNL3byrWlANt0ZxEt6C6Fm/SXJYpuyK6nBNcBvZeN?=
 =?us-ascii?Q?hHlzwM/SGPMzxA9srSMbm790qefd41M1/yWQ58R6jViR4rPqT9DQ+xjm9cBx?=
 =?us-ascii?Q?ZjhUtZWeT8cOSqJotCzL275ePLo4cdBkPiRiauS2ShYRDhqa73d5YyaEG6ew?=
 =?us-ascii?Q?iYSV8JitzMVDXfupbsMTqrROT1RDmunKW6roewFDsIbESskKnujwqyo5Zn7f?=
 =?us-ascii?Q?79Buadsy3bn/cdjLO0zqDhFLPo6lTBIFQAd1T6eyib7bCeGI0WTVsgFdpIka?=
 =?us-ascii?Q?h1f21Vg/Ne8pDTVLqs1vFT8K/3NVxRNxfPC/z8hUg7XpiX+bxoUU3dl9uan7?=
 =?us-ascii?Q?JZbAEG31O/yxHy1qBXvBCKbB7BmDLM0ZC2HYX0xFBWEIWt5uk7HlAZHmo4qj?=
 =?us-ascii?Q?qhuyyE86J+niyuD3AvDj6boe4Pj8vBZxxhgqGQ++kB4wlpa/cq3EVNvNhklq?=
 =?us-ascii?Q?QBYOw7naLxynZvFgEYeWwspo1x4ucWkXCh86kuTr/LRu6WSQXT46y8Tonqv/?=
 =?us-ascii?Q?z22D/hYzn+WO7ojFApKHEx8CWG35lxaD9KCDYUih2P+j5Q3g/aomChglSXnO?=
 =?us-ascii?Q?A7cEVpZkFv20ti4WlUcqhNJjV8O6ImSkDYoDKxL+rcozzcFafQfA778nvO3H?=
 =?us-ascii?Q?q+nTHoKMQ7nZRHfZLhrXyEVAL2QMRiq1OBoTVU4ztsrpRmOSUCxP4Cf/DAVG?=
 =?us-ascii?Q?FFUyhG+LkXVtf2KB7m8B2aIB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122d1fd7-4bad-463e-684d-08d90adc6fd7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:13.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09Equqc8t+4hFKlRVG4GMYbKUSdzbKzAigsDvPwTZtTPHLp77kJZF2wh/ad7nxidCuT3kwaVXxzp3B937W4Jbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

With the BLK-CTL driver now in place, let's add the missing domains.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/soc/imx/gpcv2.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 5642dd236c10..42b9be05e1f2 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -646,6 +646,76 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = IMX8MM_PGC_GPU2D,
 	},
+
+	[IMX8MM_POWER_DOMAIN_VPUMIX] = {
+		.genpd = {
+			.name = "vpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_VPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_VPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_VPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_VPUMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG1] = {
+		.genpd = {
+			.name = "vpu-g1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUG1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG2] = {
+		.genpd = {
+			.name = "vpu-g2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUG2_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUG2,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUH1] = {
+		.genpd = {
+			.name = "vpu-h1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPUH1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUH1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_VPUH1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DISPMIX] = {
+		.genpd = {
+			.name = "dispmix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MM_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_DISPMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name = "mipi",
+		},
+		.bits  = {
+			.pxx = IMX8MM_MIPI_SW_Pxx_REQ,
+			.map = IMX8MM_MIPI_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_MIPI,
+	},
 };
 
 static const struct regmap_range imx8mm_yes_ranges[] = {
-- 
2.30.0

