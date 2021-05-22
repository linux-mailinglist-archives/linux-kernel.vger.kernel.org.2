Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA19D38D5F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhEVNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:12:06 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:12256
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhEVNMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC0PMzRkT+UnMhnyTxIUbu7S3/kbIbl/nuQ4B6kptm2XDiB05D5mW1QXAAxVb5+1loYxt8qx/y2JLHkDXQtBiNFijJK6UflpEb1tkbHkQ8h3xQnj7KV2NauL1aR1VQEMfc1iTk0Wq8kNblPa8yBxtV2sf7oMxBg2OFMGxcUokjdbflYzpCDdB8BdhaqXD/+uJckUvuKy2FKzb7DqY+D/3auhIHkM1yEbQQXrfd14YDgkiHS/4jXjxUGKR6x8g/nTy6PW72mSAwQ9Sp7OMC2meyWC0Je3adb2kwzYf0XDZjkNEf4kRNE/vrFvy7tzspiL2zB6ztg2dA89HAhpHj/Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=mUW5tnNDKUF9YgFkie68nmaUJC/mqFrQmmFeEIDl97siCrpyg2SkUOyI+lRxzTQfw65qBcCiFFbave+W+l0z5o0wy3YJnUB4OUB01/6Dhh/NuAcF+pLQLSrCFMxIxtKUpmlrVMBPfIwqNkkCpX6J5SEMwfe2iP0CxikMo2LNNBieaIu/KRSxtsRUYmbsN/BQ8N/ZO/FtZxgsj9zthh+D+VPFZgSwDav4xA5F45caapYTBVx5hdsluF6eRutu8JjQApTkx4+unelRaeawXs20sibH6Phsum7laxnp62Bp4v8rGNXylsUvcwFTW07zLZk7XH7Bpl+UsWlUkbRGcdjaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=HLWB9d3FtoX2AkMtVT9+TNNQ42VvWF8z30r8+ohqqOb/3MYPYAwn0DP15hYXkiPPzMMOz8xhFRZS4yjTbdlcNpA9vhPgRhqUgiqTQVKjONcErvpGVRGtpgMxh2ckeG8TyoY13S3L6999kou3EemWpUYxNhgdgjSP+1Kg8TVStro=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Sat, 22 May
 2021 13:10:36 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 13:10:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Sat, 22 May 2021 21:42:49 +0800
Message-Id: <20210522134249.15322-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210522134249.15322-1-peng.fan@oss.nxp.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:10:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22182090-b4a6-4148-b23f-08d91d22fd30
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56589EFC00EABE2381065760C9289@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsPx6XkFdd8QH+B8fJ1nm3GW51R4iyarGeOt3ImkGJIxdlHb3RoA/U9Uzy4sAo8k2bne99NeJqGJWIurF+k37N3fKCL+qaCHJ897M74kR9h8Cy5sDsOnpXszT7a4V6NKiIKILKuWW/RwQoB+2g9x/KANHy7dXkOAOjvNUDSv8ouRwK1my/xv/bIR4sJ8cmkoA+5HBUzN4Bx6ZzRaEOMuO42ijcGpTB1+8PsIyGK8GdSXcEHnPLzqZJhPNxr3xUvCZOfC5dW/HtilK3gsUrSKJ4Z9O37UZEHxSTFKQvjoTWII0bxqWKXB9mSPBLWbyC/5S14nTgJUcu01YbfcD+nwg6gM/jKg5ku9ADSjqWL3EUqeTgbCYqOBjm2tItWe8qycKPJiY73Y4eAwQWLAL+B532CrGIiNSiHaslsOziqxg4w6dBrDJW0AkomZtXnp5BVht6QgmL3qs40PsbpYezTxL9yUtqtHYULykDQ17P0f8FweeBdVFEAIjwjrOwqQNeZ7hFEN3rRjidSm/BLmRyCeQK25CwCiBfb6qYZl9KPfgHeNsHdAiR1uhn01qcSF9+rvE9Bq8Bz68OBi/gby7duZK3lYDBUhgcBsK9O9W91YYfoZOz1kw79zofpM2iQfjW3HS/UZnH4UTnsLOV8bCAGntmbl27R9bWYLjgSh4nHXYjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6506007)(66946007)(16526019)(66476007)(66556008)(186003)(4326008)(8936002)(26005)(52116002)(6512007)(38350700002)(38100700002)(83380400001)(5660300002)(478600001)(1076003)(8676002)(956004)(2616005)(316002)(86362001)(2906002)(6486002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UhwCWWYqMFrF71MwN63++wOvG7e91WvmAUVaDfKX0EfbsvhmitavXcegxzae?=
 =?us-ascii?Q?jl4VipdcMCpxURudFyTB8e4K8JSb64PUwjQkQbv5aGiJ1pwuA3WdwtcfH5Y9?=
 =?us-ascii?Q?hd+eycTsKWtLMsR0YZomXAgPmOEj15rKia9LzKJlm5EtjYZZtT5LEe40fQJZ?=
 =?us-ascii?Q?F/3e+Mw8i8//buCVDHohGxNAw8uZYiTTtQ2fVWHLCvKc9QiPdOU4afcS/u5k?=
 =?us-ascii?Q?CTEOmVacU4E50bK6bjM4oR4L2qPVKoZhIHaXQVRhvjQ90g9e6ZFvI+3rZiC6?=
 =?us-ascii?Q?ajOIFVNkIJFcgKobn81B9Xl2ARfHu8SC/4uIuaZTtNAwv5N5BgJJSpM/kRrh?=
 =?us-ascii?Q?tSUctlbPgKmx83pj7QXwWc+aR9zdXTrotJQjGHwXJQRoe/31Xo8qU2MxultB?=
 =?us-ascii?Q?e8eN/tYFApS4PyvT8Du86ClLsIlvpQSBGOaJRkPn7hoHIC2mltvl1iMp+nmz?=
 =?us-ascii?Q?n7LffN239mQoA+NaIcddJxZz8OdM7TThWhUFuHFNM6L+wiJfTEGqmt7S5Teh?=
 =?us-ascii?Q?L6hhCO+Z3bbRhC8hXyYwwpfiq2c8/ZZVBF1ORGZDEyAkgCtTDRHwkTegxzXV?=
 =?us-ascii?Q?6CIWfoqBWmMoCIywPE67Lw5zhNYgMpB7tzwjf4omtzO8OJk7hhlCK8akzRZQ?=
 =?us-ascii?Q?KrYMEezovNFMPX6MDaArtyNky67RTLeXTUjVwZhp03s/iY5yC0C9zzpMZ0yl?=
 =?us-ascii?Q?PmrpxlMjV2jQ27rTTTQTHDdyiR8w2VCcetiZ25I2VLdMsO+RMLGr6EzUvZaf?=
 =?us-ascii?Q?bYwpbHXcXqwzOwFz9EBIMjLrhen8qIlZh7QHg0nxNsxCfcFYboqBZZWXQI9u?=
 =?us-ascii?Q?r0VyOa4Spc3HXhjsxNSCVrJPSWi81m3xjfBgVeOUKLQ40iRQJfSDCzzv66eH?=
 =?us-ascii?Q?fXiCh02a4hN63vzIEYq/IfHhrzxXxJFTCk2uId81toRYpkusHqnc128uyosK?=
 =?us-ascii?Q?cvM6nBCEFheUPfAo+1Z6Es/Y/wNV75RJcBcP3Cg/hfarMDVJYXETMy5Jk9Ms?=
 =?us-ascii?Q?V5ZA43obhaelLJklpFBsdNvyQxmvg+F1xnowwnnEgWe3FYYRz7KYjSLU9VJ0?=
 =?us-ascii?Q?hM56Q1E731LOAniJxIrOo5v4bN1n0AIqP1+HOqOUeYF5Xe60fhOB2y8UoFWm?=
 =?us-ascii?Q?VliqltBWmlqpRHq0QzLLe9sYMKWTLUfJlaRiKS9jQXfLun/FgZN4U43ezUb8?=
 =?us-ascii?Q?K16sJY8tFFdf3DSD88VhcGlrwkiO3Sr04NU0rJi7g/amFlG+U5KXIJoDZa3u?=
 =?us-ascii?Q?rIK6/VD6HJO71uJQfiqEZDymeRqfLUbvKIj9ltsvEYTvlMmYSWoUVXsMNtZW?=
 =?us-ascii?Q?thhEMudV/38tBLV+cDrN5YCX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22182090-b4a6-4148-b23f-08d91d22fd30
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:10:36.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwpluOGRDMageS+HF7nshHgF36XcBESM2LI8Zu3l4G/mUPDWJttDf4xtk0MO3KC6vL04NsKoYHA+qHC9EYk74Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
that support in this driver.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile         |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c | 139 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)
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
index 000000000000..59443588f892
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl-imx8mm.c
@@ -0,0 +1,139 @@
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
+	IMX_BLK_CTL_PD("CSI_BRIDGE", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
+		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("LCDIF", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
+		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
+	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
+		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
+		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
+		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
+		       MEDIA_BLK_BUS_PD_MASK, 0, MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
+		       IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
+};
+
+static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
+		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
+		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
+		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix", IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
+		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
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
+	.max_num = IMX8MM_BLK_CTL_PD_VPU_MAX,
+	.hw_hsk = &imx8mm_vpumix_blk_ctl_pds[3],
+	.config = imx8mm_blk_ctl_regmap_config,
+	.name = "imx-vpumix-blk-ctl",
+};
+
+static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
+	.pds = imx8mm_dispmix_blk_ctl_pds,
+	.pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
+	.max_num = IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
+	.hw_hsk = &imx8mm_dispmix_blk_ctl_pds[4],
+	.config = imx8mm_blk_ctl_regmap_config,
+	.name = "imx-dispmix-blk-ctl",
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

