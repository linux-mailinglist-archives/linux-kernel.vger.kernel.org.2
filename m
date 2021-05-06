Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB93374E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhEFDpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:45:08 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:59780
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232222AbhEFDpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpmrmEhme7adTCFuyUS2Kt5CQMkJd0QS7SFnvazzhFJZl3WFfwhFFpEMqh/+VoisCpgg2EsrKT7w5Wc+SU7EC0lhJDbMHR7LEQPp64nj2N2MWaKvGdtaXAPI8xC9fogdiP6ovEkOy4MAtHLtE08X/NdyZJ0kBNTnDO/E9V/3cz6I7DRzee2YAofHUf7Ta1YuEzBhfpmMsfWolzipKerN9iEmhEfw3xRanIM+MsRC4rRumCc4l5pelFoI/mkwGI2DhV727aJeW//ECnt6iLXfQ2h055E7LVMdLZxgFGYolPgidmyZ9qsexQFxCLq7i4uRbmVvi/lYYVstBfe3i/fRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCQ5Sd1nv5vZmeSxuRnTU57SaJ+TwJlP459KmG6vmBI=;
 b=aW66mhqFM8k5dQFDO5KV8KCzTE6N6hSEpQXhv9k/B1LvRAHuGJ7lmIecTlz+ZCLFD5vVtOsCioOU82PVvXgtyrFoUxQIh7gzee4U8m84xX+20M3goKFwVSSLDhHVMVG3sv0rC9G+HsI1oSq7K6ya1z+1RzhdghUc2v5bT1EmtwZA8k/VXAYIwOvhv+ILYOH9usuT/3J6Ni+cDRl547EbInX0ewo9bb/GDfAjbQ1KjJICTQzFIJ7Hnh2ZeM0nu6hDdularL6h2hQwM2+UoAZnGb0aIyq728r6jnizgSVr+QB4962B+hfjX515E1WHQvXipR0YgCYY/4qpoliWmBhdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCQ5Sd1nv5vZmeSxuRnTU57SaJ+TwJlP459KmG6vmBI=;
 b=I7kp2AN30TzD7r9K94Ft520VYecoliCugvJWHCkPM4CSuPB1zTAbB6nL0QDrZNHYwW8gFLyFh5w7GzZ4gfG3cqWEcE/AMUN5fPQ8IGquABINQ3tXboq0D+bNwi8lqY2oRqceP9de8n76lN/o4pFJ4zowxhKEd9vp7rGymbs1A5Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (20.182.191.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Thu, 6 May 2021 03:44:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 03:44:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Thu,  6 May 2021 12:15:55 +0800
Message-Id: <20210506041555.10719-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506041555.10719-1-peng.fan@oss.nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 03:43:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 975784d1-1188-49d4-79e6-08d9104131ff
X-MS-TrafficTypeDiagnostic: DBBPR04MB7979:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7979F32898C45E50A8775DF0C9589@DBBPR04MB7979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM7Eo8tcNBRIxDn0EVoAx/9OTc8mcKdgDI8xT9DkkrhAYDl8AuGeipdOnu5Id+dTbFiMLFKpDkKoOZM2SOL51Wk1YHZddAXei4+UYNOEEIf6IgCW8rK9ABI44RxfykHziv2WjdVjqkDAIiDijXV8TV/kO2PbtEYHWy/75wwimlxKiiESPYW4CL+HPD0VVhmqDl85dxHx6yfI1KxBn4s3M2CSb47x0ThO8w/a0tG66m657+iXsg4oWfIrdX6rKsEWl2npK2jM3PeoiG6EdW9ZI3smG9t65opIk5bVTf2EeBM5CSTpYHihWSl2ElDwQP0sMf9rmMtJ9a0svlCq8b1Rw0umeDQZfFC88gFVWa9jideHnWGaeL6bHQuJ6sf758EA3xWstyMMxj9BNYOvHBbsx/Ncet3tjswuqTxrLSQDkyWo+lHDvInJ50H8ZlBfkdK6oaTzdf6Cn9RFBA88pcwNufu71lu98uj+Ws/NAHmMeVdypHblK95uFKEaO1q13mjyPgT24O81SbDGHjjmZOQvVnt2FCiir3SetanAYVgaBDxAojr3xQob+Yvpkm4Xyb2xFZhqeMNQwz319eIggQ9+6z21UrcZhYa7e9WIVti/TQJVMH4z936jytwL5DcZur3KYcz/mbIUo5Qtb+1ulQPFDc/wHqMUrcEEifJU0xSP4uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(4326008)(2906002)(316002)(8676002)(6512007)(956004)(2616005)(5660300002)(6506007)(6666004)(66946007)(8936002)(66476007)(66556008)(83380400001)(52116002)(7416002)(478600001)(26005)(186003)(16526019)(1076003)(6486002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O7nEcqDhAT8OvYi+Co1cZwHR1jL5W5k3mJHljLeGUj+b4Tq7gxvLnrrVEpkJ?=
 =?us-ascii?Q?cDg+XMvVWuUlqejSoNFVMdQc+cYIgvP2O1Fbw9z27Cw7jCf8UOucilVoWNvs?=
 =?us-ascii?Q?UUPHlut2Bx2v8tytA53ENxwwg/D3vgIOsDL5CILRqri8bKoVg6ETEQkRe4OP?=
 =?us-ascii?Q?ODM8utQl737/8ZZRk7IxrX+vJJodr4ux8GoN/L5hXrOuhnLeieE/zLKX5GSZ?=
 =?us-ascii?Q?/o9Wq3IHPKCSspkHtEIDtI6y2ChV0GQVSsXEn7mfx7kV6Hxg+Qy+751gxbyA?=
 =?us-ascii?Q?ZqqrSZlCxvihH6Iv28vcdOZTmkkkwA6uXpmGWwzAmAq5igMjfKLOaxIp0PKP?=
 =?us-ascii?Q?UA5cAaegWektCnx5bc9WC2ZWn1SBI/wJv7IoRftytyZ2RboYMYeRz/uLozis?=
 =?us-ascii?Q?fOJ3xbm0JexySBj3CJroBtJNfCwcxCX3PYFcQyHek+/G+UpUCUIzZMZ3RoDF?=
 =?us-ascii?Q?fxG1HoxkAl7HayplQi619ZUaZTO8EERYfQd8pS8SQG0wNc7Kq1vqRvVNuwx0?=
 =?us-ascii?Q?5h8j2XPOaWuRm4GpkGLYzGzjPky+vU9od20TPN9mMLwtMsoKrYRJ1Df2xfQX?=
 =?us-ascii?Q?CpYkeNyCuLKfzgKzJQMnXgmdIUxk8lReOkcXxBrxVbOd+ku0YephJrFpDeR4?=
 =?us-ascii?Q?f9HtCOCifduYLTozjHX3rMFl/DQ4KQpptYewyX5Ufa9gLZCtBT73Thv7AXR9?=
 =?us-ascii?Q?xBE8lCpBUK/FEeh8nyFTLjemGcmCivB0r/TG0nbrQCyP9zlzav4ZjTtxV6aR?=
 =?us-ascii?Q?7DsFTnbgGJ/8mqw4k4hfU8FfkHc8CdnP4JVbC9w4x6Cri1saTYOeuXzYrlW4?=
 =?us-ascii?Q?0qKDBlCzpvAgwmKa9XhQWBf2amGCflH5+Ql8bhubwAyjgBA0do9s81ennx4m?=
 =?us-ascii?Q?ATcek5XA0XTI+pDM0+6xztDUbIyXB9Yt2O8V1sgNeDFrT2L+lRiIWBqHcKwC?=
 =?us-ascii?Q?36Bc/fkYi8wJ/NJ2Ha//g/SDC2TZ8N/zJLcJ8rXs0nZIJvhedntxBu2zgpZy?=
 =?us-ascii?Q?EzmbbIshrM2cSh+2H5OoRvZvmQdILDh5YxkrwMx3sjJOpMxi0KVOMLv+YxDp?=
 =?us-ascii?Q?MQWd6SgE46chHwjbLo0xbU+UEx2GXZMJOj4KmmBRll3MIceg1lM9Df2i1R/1?=
 =?us-ascii?Q?voKXsSVeQQBEDM1Pb1hMeDhUX4QZFNoCUhtGeeYBPwvyDj4L/6bUnVejKysV?=
 =?us-ascii?Q?OnTE6gbslziLMY+2D0pK9rXex/s0Lrsk0e5oi8JghqWgBYUpYrBiyeP175tS?=
 =?us-ascii?Q?SwzfZJnLnXfdos5z9Hl5EEBQXSWIC9qOm+V6ItaNhErMXFddc7db2k1tD6lL?=
 =?us-ascii?Q?VQUwhayF8gdv+UWEAyfRJH0l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975784d1-1188-49d4-79e6-08d9104131ff
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:44:04.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH7j6Tila/BS5mhup61wh00+K6wiHArAz2HbJ1SixJEwuxlRlEWSQM7UHcFeuwrxPe1lltnZ4rh4NqFkjNgOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
that support in this driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile         |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c | 138 +++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index d3d2b49a386c..c260b962f495 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
-obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
+obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
new file mode 100644
index 000000000000..cc6e6705f755
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl-imx8mm.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8mm-power.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+
+#include "blk-ctl.h"
+
+#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN			BIT(6)
+#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN			BIT(5)
+#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN			BIT(4)
+#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN			BIT(3)
+#define MEDIA_BLK_CSI_BRIDGE_SFT_EN				GENMASK(2, 0)
+
+#define MEDIA_BLK_BUS_PD_MASK					BIT(12)
+#define MEDIA_BLK_MIPI_CSI_PD_MASK				GENMASK(11, 10)
+#define MEDIA_BLK_MIPI_DSI_PD_MASK				GENMASK(9, 8)
+#define MEDIA_BLK_LCDIF_PD_MASK					GENMASK(7, 6)
+#define MEDIA_BLK_CSI_BRIDGE_PD_MASK				GENMASK(5, 0)
+
+static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
+	IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix", IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE, 0x4,
+		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("LCDIF", "dispmix", IMX8MM_BLK_CTL_DISPMIX_LCDIF, 0x4,
+		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
+	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI, 0x4,
+		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI, 0x4,
+		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
+		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET)
+};
+
+static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_G2_PD, 0x4,
+		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_G1_PD, 0x4,
+		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_H1_PD, 0x4,
+		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
+};
+
+static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x30,
+	.fast_io		= true,
+};
+
+static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
+	.pds = imx8mm_vpumix_blk_ctl_pds,
+	.pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
+	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, IMX8MM_BLK_CTL_H1_PD, 0x4, BIT(2), 0, BIT(2),
+				 IMX_BLK_CTL_PD_HANDSHAKE),
+	.config = imx8mm_blk_ctl_regmap_config,
+	.active_pd_names = (char*[]){"vpumix", "g1", "g2", "h1"},
+	.num_active_pd = 4,
+};
+
+static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
+	.pds = imx8mm_dispmix_blk_ctl_pds,
+	.pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
+	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, -1, 0x4, MEDIA_BLK_BUS_PD_MASK, 0,
+				 MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
+				 IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
+	.config = imx8mm_blk_ctl_regmap_config,
+	.active_pd_names = (char*[]){"dispmix", "mipi"},
+	.num_active_pd = 2,
+};
+
+static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
+	struct regmap *regmap;
+	struct imx_blk_ctl *ctl;
+	void __iomem *base;
+
+	ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ctl->regmap = regmap;
+	ctl->dev = dev;
+	ctl->power_count = 0;
+	mutex_init(&ctl->lock);
+
+	ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
+	if (ctl->num_clks < 0)
+		return ctl->num_clks;
+
+	dev_set_drvdata(dev, ctl);
+	ctl->dev_data = dev_data;
+
+	return imx_blk_ctl_register(dev);
+}
+
+static const struct of_device_id imx_blk_ctl_of_match[] = {
+	{ .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
+	{ .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
+
+static struct platform_driver imx_blk_ctl_driver = {
+	.probe = imx8mm_blk_ctl_probe,
+	.driver = {
+		.name = "imx8mm-blk-ctl",
+		.of_match_table = of_match_ptr(imx_blk_ctl_of_match),
+		.pm = &imx_blk_ctl_pm_ops,
+	},
+};
+module_platform_driver(imx_blk_ctl_driver);
-- 
2.30.0

