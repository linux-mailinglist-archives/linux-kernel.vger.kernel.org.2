Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2879A36E54B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhD2HA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:28 -0400
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:58281
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237447AbhD2HAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGtNL3G4nGuofF5/rHSu94hUUOQbupds5zPFPvKkFA9Jum6OnVxuf3e5AH9hZCsBx2CahfyGF50O8Df1UQCHf/GM9WyViHXg5qVcfUivbLR5J7ML8Lop/xovO97BLfTXgRLk0LKRc17O+CLhGN20/RuZoxIOvvpGfYNlxVMwgfsyivBhaE3Gwk5idWk5KCFxGFRlpat60rjkFmopM9M3Qa0OA8yqdGfStlGFkKZSJ/dcZiVYzobKhIh1BIknXo8MaS3thZg2stBkLfdE0IniCqKWKH8Y8IVt0PB1lBS+QgZrb6JLsL1l6RHER92kWGD0FVCRcNq5gOmTSR3+mDT5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7rtVkFB7wUfYs+ZWvaLo2LeTqG+DCQSG+P15B/lTd8=;
 b=k+XP5V9s6FpYCJ/Bd0lkAlFm7N5ZCGhvn6pQ0KspR0xpTu7LMiQLYOPfuKYdb8pAb6PfSO+5bt8PlhfiKzOY+XFQ7jzCxifnN3K2XAGnw4IoWf9sJMGrq9GM+bTRPlxVdj01Mw7KbHf5KzXTmxfgVfTGIfLweNwwBl6HaQB7z+7rcHZYy+MyuEEbPaKmV9WjXgSFe56ZR1psp+K0/+KOJT2uHaRBFV5MRDt8+MIwYDrURKiSofa4nkuSjN5VOaAURPMEZody0jYftiD7P6oWjEtk3W/3xsbgNamWPFTUpvkXJWSZYkgt2gObT7xz6rdABwne0SD8CP8OLxvU8te1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7rtVkFB7wUfYs+ZWvaLo2LeTqG+DCQSG+P15B/lTd8=;
 b=UPrTJyqSmwO/ZWrZEmLXQzoiLNJVLeayI/e8Eduar3OhkxRLMNMo83wFWLyRWpnMFswANVh6SjnpOANo+ysrzjpHKZpJ+m67C+JL+ryD04/+tF24KmWFFBehrJYMEJwYaq6d+S3FrV41ytQtGhRTg+5Y7t8nK19Refuri/fjCl8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 05/16] soc: imx: gpcv2: wait for ADB400 handshake
Date:   Thu, 29 Apr 2021 15:30:39 +0800
Message-Id: <20210429073050.21039-6-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca74d105-7905-4f1e-8ca4-08d90adc57fc
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468B7402734536B5E2CA594C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVgTK8v17GCXEJRtxubfq0ZrFXlHJuK5VsXuJqEkwSsE4NyAsXGxPbgkrBoXzSwzn4XyKMFXQfchv9eIQE1d6G9RUfaEElwtORgcmAb7HzC8yB28BlJGmmzf6F020OL+fpIkgJLByZcIcWihY3oMi8MqGrWdRf7/OoYKadCA62UZGuEnSHwlvgpP4ZVmrE+X5phx+cImksAQ+V5d7tmFoxuaoryzmRtGUQ/9AOQMRDUrEd9ILJK5kePPBNTz01UzSkJrKXHciHAXwHjMk+l+YBae1fD4Vw2H98kyGbgTiFLDZeall0bfhhw+EqpjkT75Wg0wfjYo9EqITn80RPZLQHE8pvvgOPvHMd81lyRKd5tlttjBJrTjIkAUttLz9OeBit468C/Yymy7d+x9Q+/KLtEzfn/PwsCjhSzHJegC4kbYX7FQRx3C2HxuvJhQfaXQh6fErbGvBRWB//RW581ScKV4pdA/B0oBNX8fhwtp5tHHAkVMkwkh3yI+Fdl/RVEundNVQfQCpWrQGI0A/bWyQar/YdEwsHURIJdAv2mkGez83gAoWpPpQwikHknRfaLMOWgyonypUJTUug/PS+RIiZDu7bdtXVESpMNP+yEJXghRS6W0UozYlp0+gzOFI0Tzs8OUUBnxrJ2q/lxr/gk+w3oe3ertMkah7prHMXXSxVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HdW4g8mtaFGm+BvLGE95lS8AzQoBIZlMTv/YJe5JFvZ7X3hihCfntL2gmV+T?=
 =?us-ascii?Q?j9qsKlpWWqLlSNYIMqntCDqDdbbbqWZHZUDFd0V1EDtX2/9a9qIDje1FTKbP?=
 =?us-ascii?Q?HLhra7qxc1SYydqsVzNbAJkMYV5qxPziZ7+O8kienLSOgdv5WGSUVsizFEIR?=
 =?us-ascii?Q?Us3msOJ6hruDFdZPhNQkX2BL1/3UbfQnnqsmhWCr7x3VpdIodkhCY9albcck?=
 =?us-ascii?Q?fFVv+JlobD6DVPdpHHsZhqfmaXAXgs65f83x3ag7wlm6B03T8unrEW+XtVGV?=
 =?us-ascii?Q?CzEDBIIs/7FKNZrdkcPFJewq59V1NTUYZOco1GI3rmpPonjPPR6r5BuM8htV?=
 =?us-ascii?Q?HHGl0iFrGlVvad972SbVdYVus0Jh4kGjzV2D9/86rp8/8p0S8GDt/okyUOjh?=
 =?us-ascii?Q?PNTrjq/ePxlXEWogUxdPnwkIhJJwuF6Bpi/i8VkAvXmUoL0QaT9rAED2VDHs?=
 =?us-ascii?Q?la3wINxQieLwP5G23ToC+FxJaFj2Neldw+GweTBLGQhdjEaywlRQmR3dMEOL?=
 =?us-ascii?Q?GqWpT0PATXuJOr53E3lTK6wwgrgi7/N8UAIqAAMyHLvELN36HTMIjxjrwLmQ?=
 =?us-ascii?Q?gCIDS3L1iFrhZ/wF2cIPbHa7XhNvcz44Rzt7guthsVPbO7DWIPYpbz8FrvCP?=
 =?us-ascii?Q?3UdOzyOz/X6T1NhH6zsTqxl2mrVAToD9yUAQsLkkeoJ9w6kptNAUntM7PbK2?=
 =?us-ascii?Q?lzDvRk0sntAvo0AGSLCHxmiw4f6cxdy3orq3xoS+O93KBrO3QVmUIdqJKm7O?=
 =?us-ascii?Q?LcIcajDECGprFxpdOIvDq1kd6ymAkABBXh/j1KNmO6fqwNJZi9tskssWPvlR?=
 =?us-ascii?Q?r/LljMk7l9cDCSmhOdfJy5569JDGHP1eAIV6yVCSV9lkY5L8523HOtrNgUPL?=
 =?us-ascii?Q?36G5AUnCmF6NZCQbjBJ2Le/76z+1KmSWPlJ6AJzy0ngf+TB0TFYjgJnPSYYV?=
 =?us-ascii?Q?kgOOZMHPMUZ1WCZVT76BznHtDF2iIHh10tTFA2G1aECQid1CVMT55YGYhcAG?=
 =?us-ascii?Q?lVn5+mRQgCkhB+tSUjhWc/fLlwjkFLDedW3VYyimmNBoz7O4OsU/AOaN1OlY?=
 =?us-ascii?Q?zt62zLCuRhmIbl5IzrhdeK/MDJnhrOGpV1GIP3RpdTY9cyTjDZuj5grcRPOC?=
 =?us-ascii?Q?3kE7AmZLbpA+XvENHIBQSpRpAhYtDYZR2lfXJeSYz1H3HdOqf1dgB4A7bj+G?=
 =?us-ascii?Q?acc0t8LnRKPI0x7xTIeRgUO/cfKsBpNxIOTjeQ90/MkAZvyDlnZkm/kCTwwG?=
 =?us-ascii?Q?qAIKeTA4mW4lEMlmcTd3M4KtlxoTMScD6yVve+M3svMBLAwAI3e8RUag5Rlv?=
 =?us-ascii?Q?30wyQFAfNkAwULbXxT5Pfl1/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca74d105-7905-4f1e-8ca4-08d90adc57fc
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:33.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwsUsy4l/H692/7QOjAqXPuWybQSeCxFqIHK7//8PfR1RmySjvGiINgbt0KtQDUrTickY/V2UnLT3qLO7ubwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

New reference manuals show that there is actually a status bit for
the ADB400 handshake. Add a poll loop to wait for the ADB400 to
acknowledge our request.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 43 +++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7356e48ebdad..d27025e37a9e 100644
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
@@ -172,9 +176,19 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 			   GPC_PGC_CTRL_PCR, 0);
 
 	/* request the ADB400 to power up */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, domain->bits.hsk);
+				   domain->bits.hskreq, domain->bits.hskreq);
+
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
+					       reg_val,
+					       (reg_val & domain->bits.hskack),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to power up ADB400\n");
+			goto out_clk_disable;
+		}
+	}
 
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
@@ -204,9 +218,19 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	}
 
 	/* request the ADB400 to power down */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, 0);
+				   domain->bits.hskreq, 0);
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
@@ -369,7 +393,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_GPU_SW_Pxx_REQ,
 			.map = IMX8M_GPU_A53_DOMAIN,
-			.hsk = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_GPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_GPU,
 	},
@@ -381,7 +406,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_VPU_SW_Pxx_REQ,
 			.map = IMX8M_VPU_A53_DOMAIN,
-			.hsk = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_VPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_VPU,
 	},
@@ -393,7 +419,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
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

