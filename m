Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71CC377A95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEJDbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:31:14 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:64060
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230421AbhEJDbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:31:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtvDfkkVWWXJXdRVQIXhOqvyHMGzHFClKMd8mC5W/6G6qto/oTR9kY/+OeJ2bw2AcffX8KziEnB1IPWZsGre+3MU4n/NHfwv0dY1o0sp8ae/NOa0HbvkqSbcrgLQ/+ec4f3/zh/N3DI0XBXueJRRhP42J/4JJ/gq7OPedZmoE4YygyIETk1NB/6PC8Xibm/AA46OymsJ/UKfTVHelwi766WDnGs0Dogn/NWHWcVUQ7dHYl7a0hiUsgCwqhEEuYskCH/LWqh7Tx/qLGbcTrlYMnYQzBG1DMiBhGlIIH0P3V8MBX1FsxjtOS9WFDSiYFZcN6InxyP2i1mDyt3c5ykMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me8f/Jm7YEEwlseaDhmwT+CqGHX59R/SHEHuVQyr0Ic=;
 b=OYAFCyvXzO0FmOY+iiuOCqztXV8wanDdNRDr/pl0kES/NeKzK+0y9HITicSKgdGDX1rZqQkqbvNWDD04Uuv+w7vtnTzm44GMq56W/rb2r4NxeyfhjfhDQH0CW/vgTEhY51FC9KZ5IfTq2hqY+Mkec0y2tEVuVw8ZIejcahljg7rKTfhQS6GOdjEuZYSjRWra0mSMfNCkVNy7+w0NgR3i/O6q8gqL9dmz5uyTPV/J/uz8zU7/uLUDojRHML5+G+f5NLk6D8MtbhWoeliOQQlX0RsbA0wpn7BEls0b+116xXqUb0SfithvS1ytYMFc8/qv4VB1MibLwQRT5faIweJJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me8f/Jm7YEEwlseaDhmwT+CqGHX59R/SHEHuVQyr0Ic=;
 b=XcBW/6rsbC40I7ijCzsAPhtNsAie7e4svdMgPB8CX/5N5egIfBLIR62LQbLdYQ6r7nlVGbKVYZf03B0q2o6kPnRoMEHO0CfY+ws1wbBFpfZylt4dcK576eg/S/jwh5ZvrqrWU2Yyo+Yl6pmsFGXBSMSKU37BTGmwT5POj0p9vyU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:30:04 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:30:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 11/13] soc: imx: gpcv2: add support for i.MX8MM power domains
Date:   Mon, 10 May 2021 12:00:43 +0800
Message-Id: <20210510040045.13225-12-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb4bfd5-9834-4f3b-413e-08d91363e656
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB409168C446D7ABE99072FB74C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUhUt8mUZ9u6ZXpbBpXt4j0F+vRkSlF33BuiiNUjJQ2O+ftNCmW0bLwlYQ6OuWr+rLDY7z1Z02ed5L3bCM4dhMldWh8xtiXaAIYrx0GrgR34Q6YUUs0oR79U3Chkeup5/EcP/z3I33nmXg7NBo/1EjODB2v7oLqjCxJ75XRBEnsv1SMVifsWlaOKd7lzn25U+SBrykG7+0gy705DFGvMMhuffW1RRX4vkL8hAygIZof2fHQBYu4M/zsvMivtC5yS98co6hgxyjbvZwuE7sNXt91gCOLOKcjm4yvlG7shg9dFjQDnUi7euNN80Hn5ed+B7K4+3377FWdXork/DResnvducZmg8KCq8TtShqmVcEvjyG2TLE4Nx/svRbR58e+qiuhC+zJFxjlM2/bjvxY4dhZMblPD3zZ+uOsIrgTTOPcDxJ8ompptKfjcZSGuQ2OSWMQOn0RIXjb6D3NIzVKFtUciI4Clc+yzK7Y50QzLnSzH0hm4XCBW1kpfgtyV9I3DirqDH8Us1SmcAdi61tqiiJtSgWMcbnTdft04FzFffuTk7WT72RUY8lHq2KKlmXlsAYZuQB1tfH0tOYV3ULSvYe3B62NGiK9bVo+ASy1YnYQZk6r9faE74LdOgNjlhsJ1gtp1ltbqRRmWiDW73r0IuWtmeka+6OJ+XYhOJ7gaEhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?klFs4lCfUC/UxQQcn9itPwWfI8yrr+Exq+2D8M2LYgtaqoGnba9yP7nrVLpq?=
 =?us-ascii?Q?G2BXtEPI6c6jx3VchirDQyLXsDBM7Pi/T0+OtANPzQNHdOu5lz0cRfjd9PRF?=
 =?us-ascii?Q?VX9LFykeKHcp3HW4E5nc+qNwG5AseGM6FmYOBZVN+8i3HMj/m4X9jPoOmsHB?=
 =?us-ascii?Q?WqCWvdMjYX73rtoAMKBJtIzKazv2H1oSG2DKZKbpBp+uhkez9NwR5d+V6SIU?=
 =?us-ascii?Q?792i3UkX3778IQizoqNiKNlqRJugnuZW6gip8BywmJdYq7g05xfq+o+YR/5G?=
 =?us-ascii?Q?3VmC09aszKN8cnuO6+fgTeP/U/0AMepuuSDkxGw2Fgq608ozitJOhXPghkdR?=
 =?us-ascii?Q?5T3p90Ru9Y1JhYbJc72YDlZkcr95F80v9O6cy8nf4IkLnKIsvAVC0N4QGRR0?=
 =?us-ascii?Q?TNjLuaE+qhVopB4wkaN+smlGG7+Ez5ha+lPN3OBcihyp85L+A7o7oIICvoW5?=
 =?us-ascii?Q?xA2P1f6A7m3F8qZiSjZdoklW0s4+3ceKITmeh9oiKO0VhVPurgpD3Tuk0beI?=
 =?us-ascii?Q?WbmiEmq/3kQpFypLXqGhpW70cmLLXJU8/WVn7GVixa7qoOCeFF4xM7SOfcwz?=
 =?us-ascii?Q?VLB9J3E6gtYIMwm+qOYa7mQxUy7wEQi5ohK6yTSJ/UWPkHZOkM9XMKuLupPO?=
 =?us-ascii?Q?gqSX6GKMtGXJ7/RChPxwJMFLBWbGkkhP5l8V3ofGGi1cxWos7r9dRQ5jHnDi?=
 =?us-ascii?Q?f8nBsPvkBtQl2eNO9Zapfdpevd2QzVL14elqU+PHWHbysi9JIySfz4UrV5wx?=
 =?us-ascii?Q?xpoflNDyre5Lz9p3piyqXiBGemTi8HVEL9NyI2G2xi6vrVr+6s26OCFTM2kc?=
 =?us-ascii?Q?NdqhCh/wVVqIfHdGLXVmZDwY9PhHbv+h+qkJU+huyREVPfFEkVKUiPQChv9c?=
 =?us-ascii?Q?BR2UO4RxkI5X9/+JCXlUzXXR6/CDvF8Ou0wiK7t2RslKWQ+FkNyW6XJFh8aB?=
 =?us-ascii?Q?c2dLpIJmIaW6y7eImtrfzWQ/htCOPHiBAZA7cFcm0jGwczmL0LxKCqKXw4Qj?=
 =?us-ascii?Q?RryYbOhElK5u4m2TorV5oikWzKe0ranLQSAvv91F3sClyhUSW0Wnn5bHn+v7?=
 =?us-ascii?Q?2qLGlmYSCmSsqqU/jC9M8bVJ6tMaUli1YWBpf6UaSBoznvG1LhtcLcDyyyW7?=
 =?us-ascii?Q?db49xZddACbfy12ET5jHbLLx13dzzVEKuBOb2otq9OgQgdqWm2VxB0saKYRC?=
 =?us-ascii?Q?fTBjZ/DP5do3atXWITamJ1ZV1JYBD29CgIEzz27+U04zf8fRFFFIK86qTGdp?=
 =?us-ascii?Q?FpO1XB1Zlz8MKryGECOxNrZdQQLVXUyW/cYTPqyKz4d7Qc1l2lJ6u87IRIpJ?=
 =?us-ascii?Q?gIOM5FM+jj9VZzgOPe9RpuhR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb4bfd5-9834-4f3b-413e-08d91363e656
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:30:03.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTlcQwoeCvOl/Z6i1ewLzGI91JSz63XkcOoXfdkKicPJaDIpIT6mQSYo0C+9YRetoar/JnfOWKv4A0jNmgOc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds support for the power domains found on i.MX8MM. The 2D and 3D
GPU domains are abstracted as a single domain in the driver, as they can't
be powered up/down individually due to a shared reset.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 168 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 04ce64326c19..d676e65e8c16 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -19,6 +19,7 @@
 #include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8mm-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -44,6 +45,19 @@
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MM_VPUH1_A53_DOMAIN			BIT(15)
+#define IMX8MM_VPUG2_A53_DOMAIN			BIT(14)
+#define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
+#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
+#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
+#define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -67,6 +81,19 @@
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MM_VPUH1_SW_Pxx_REQ			BIT(13)
+#define IMX8MM_VPUG2_SW_Pxx_REQ			BIT(12)
+#define IMX8MM_VPUG1_SW_Pxx_REQ			BIT(11)
+#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
+#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MM_GPU_SW_Pxx_REQ			(BIT(6) | BIT(9))
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
+#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
+#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -78,6 +105,17 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
+
+#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
+#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
+#define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
+#define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
+#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
+#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
+#define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
+#define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -100,6 +138,20 @@
 #define IMX8M_PGC_MIPI_CSI2		28
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_MIPI			16
+#define IMX8MM_PGC_PCIE			17
+#define IMX8MM_PGC_OTG1			18
+#define IMX8MM_PGC_OTG2			19
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU2D		22
+#define IMX8MM_PGC_GPUMIX		23
+#define IMX8MM_PGC_VPUMIX		24
+#define IMX8MM_PGC_GPU3D		25
+#define IMX8MM_PGC_DISPMIX		26
+#define IMX8MM_PGC_VPUG1		27
+#define IMX8MM_PGC_VPUG2		28
+#define IMX8MM_PGC_VPUH1		29
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -527,6 +579,121 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
+	[IMX8MM_POWER_DOMAIN_HSIOMIX] = {
+		.genpd = {
+			.name = "hsiomix",
+		},
+		.bits  = {
+			.pxx = 0, /* no power sequence control */
+			.map = 0, /* no power sequence control */
+			.hskreq = IMX8MM_HSIO_HSK_PWRDNREQN,
+			.hskack = IMX8MM_HSIO_HSK_PWRDNACKN,
+		},
+	},
+
+	[IMX8MM_POWER_DOMAIN_PCIE] = {
+		.genpd = {
+			.name = "pcie",
+		},
+		.bits  = {
+			.pxx = IMX8MM_PCIE_SW_Pxx_REQ,
+			.map = IMX8MM_PCIE_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_PCIE,
+	},
+
+	[IMX8MM_POWER_DOMAIN_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
+			.map = IMX8MM_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_OTG2] = {
+		.genpd = {
+			.name = "usb-otg2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG2_SW_Pxx_REQ,
+			.map = IMX8MM_OTG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG2,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
+		.genpd = {
+			.name = "gpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_GPUMIX,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU] = {
+		.genpd = {
+			.name = "gpu",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
+			.map = IMX8MM_GPU_A53_DOMAIN,
+			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MM_PGC_GPU2D,
+	},
+};
+
+static const struct regmap_range imx8mm_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_PU_PWRHSK),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_MIPI),
+				 GPC_PGC_SR(IMX8MM_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_PCIE),
+				 GPC_PGC_SR(IMX8MM_PGC_PCIE)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DDR1),
+				 GPC_PGC_SR(IMX8MM_PGC_DDR1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU2D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU2D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_GPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU3D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU3D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DISPMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_DISPMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG2),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUH1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUH1)),
+};
+
+static const struct regmap_access_table imx8mm_access_table = {
+	.yes_ranges	= imx8mm_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mm_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
+	.domains = imx8mm_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mm_pgc_domains),
+	.reg_access_table = &imx8mm_access_table,
+};
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -710,6 +877,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
-- 
2.30.0

