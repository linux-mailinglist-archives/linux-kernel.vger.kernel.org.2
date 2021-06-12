Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A183A4F03
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFLNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:01:02 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:61414
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231393AbhFLNBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:01:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoJY2PghjBIkZeM3/NoSqveFeB7Qb5gy95V8nZaMyx35cLqoiJlyATeFor7OOoRl4NPsENQ2Kcinqh7eRckTpqpLzRQZLmVVfiWnMGJkY2OGYfq0G2bhmkMZApg2HSvOlruTUEHx66kF9UIUq8NAjVUcVQF7Wu5+YFrgOGKbm6G7m8Xm6dhZ7KSh70pUCj4o9sYxjhbLpOrGckC4auXVHHmj3soLgd/3lCFBjxvTsQqdev1MQw1Gonac5IqgGtpzG15Y4P+eokmkkht0WwlIQvvw5U1rE/tqMiXBTB0J5DX3i4XSy0Fs/U0XzMdSuFF/vfj3BgTkL8W0w9fpTvmxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=QBm0W+qfm457LgdzppMjNBZTUT35IYULghsrfm1puau9zentV0RDmWpZWJA9EFMxXROxdMNeTNqhlfbwf/qqrseF/jc86ECWdw4AxigwRFhIUf4u5sQZZQOKx6Gp8raHNixk13CTTsro7CNPjgiWImfobiFYxFKAzUw4bL4GWZMB4hLFHcPqxhTSBdGKbDsdIrG4VNQi54jOm3QUnixpKEVhsaporg2eW07sTXcHB015bpjY4soG9xbfj8ATg+9xPGqNybcx7nJLyEFV1fJvv6Uf9qEY6/h+VTE9yBpbhlnduMBUMGqVqWvUkW3pE9qggPbTwDNVzZsoGsKcfCvOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=E5/hwdo1rBXO6HFzR7+jydCRPlOKzUV7yN29K8cCy0KHn6aRSgBgrJbrmoNO7o2cQuVYiDA8ZTP1IrQUETPRknMIj2tJTVrEsJUdf68/SFZkNaSAg6dumg1+SUKABiv+56yNTRPtJlYB3t+xT7FeRAFezO+pMmNHevuN9QVRlbo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:58:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:58:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Sat, 12 Jun 2021 21:31:34 +0800
Message-Id: <20210612133134.2738-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210612133134.2738-1-peng.fan@oss.nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 12:58:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52fc616a-854c-44f9-27d1-08d92da1d6a3
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB728532CE31BFD96B7B22CDFEC9339@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCQxD5JmIc44DkBH39uiCcJT0PFtucPE2GQWv7EFP5Z6Rmmii0XEhdg1WWR8Aj1rBbzWRemP4qseFUNZga8/+AeRNH51GGJztuErqdIuxHrurmrNwcJkwzi1A3dI0DyvGIqIAfizwdd8sXjbWMtVpfGT80OJQXt1YRwPMHLprVr/FQ3rBLbDR+G6+GOBJtZICF7JxJMt1QVNCP3IV6ixR147Bet2H3QeHAfdjCEdqWOASSiuwuPPDDtwQvMmSE7EGkwyzCi+eH2Ev74eJJoPXG6QnBJ98XnX4Bk1dPlFt//R7MrZvHPl8Nqa05FpdqI+cKqpDvDIRNP4+pT+8V4o5E0i+jwWIfBcJ8MNdChHlhEvSkQLWvgT4eEozLN635oHaz9xefbLLhSOBa3vxPVXLBoEiiUwvCU1If4x1B/GgMZYsKDxRARTA3NTdlRQSMV7fqcEauF1smUPs4Ik8X1v5PTxnxoquk1ifT7PHTsLjpgsQPIwNavbHks/P7FR9RJv/sBnT8dK+gmFB3Pf0dL7RPXKYiFYVtkE+1Le4orlQG0dAxH9kpEx7UQ9UsDEAjl7h7aqjRBXfoQAe4HT/COfPHGc4AtRJFj/RQWj05/3qdWk3tUdl1oabDQupb0sdyU4ns7VIWn7kAfjRfAKstOPBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(6486002)(6666004)(8676002)(52116002)(2906002)(186003)(1076003)(16526019)(8936002)(26005)(4326008)(6506007)(66556008)(66476007)(66946007)(6512007)(316002)(38350700002)(38100700002)(478600001)(2616005)(956004)(83380400001)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SW4CZi1kJKknUuJSTHNi5GGG1F6JZMMFjrhs3SlIk5CNOowsx+NxGUUzLmi0?=
 =?us-ascii?Q?LrlAAb3rAZd683cRqHWYecCYRZgIANoUY9YuXLuhU78WPR+I83U8z5rZ0N4W?=
 =?us-ascii?Q?wWRBWXTgn28ITRHIoRsJ7Utl1/mTM4tTSk5k8SKdt7t/BwwSctiSwk7RDZSt?=
 =?us-ascii?Q?dlIqSMCzq2yiWDrpQs7zc2aR3sswqfwYRZTaxwnKP/0wRd5f5pkPWXPfdV5K?=
 =?us-ascii?Q?EVncVolXbxw4XcKcSyGc+/AYLFYekCyia0SNVxML0qo9d/6I45NKChsuuKgr?=
 =?us-ascii?Q?Pf2/v9Jmeyby8ErBYz38hxfv0cxmEiGUDJmTqjr7EjVTUNJaNFqDp2KajZAN?=
 =?us-ascii?Q?bFVU/9zD86tCa8J/Fhp1qOTD//upu3DRgs8PD7Q3p04oSvF6k3yf2Qx6DrFS?=
 =?us-ascii?Q?0IILEPiM2j3aI/QNrccOF/9xmHjViLrZG4sLuam38ZB9iiCA3WwNAxrJOrVe?=
 =?us-ascii?Q?snxSvoqxxeSNk6K+CFS1XMCnFZA6AqBKeKZC50n3xYPbeBKvXIl5RLNaHMuz?=
 =?us-ascii?Q?t481aI97Jq+9sZQyxPVtBHPHaOA6IALNZpTz7LhS/Kt4/cztrThqP3HwcxJi?=
 =?us-ascii?Q?0tCTx5sd+lyLOy6NbT3xSrPw1l1Xr3ky0i5tk3hnviAkP9GrzruUiQ1UR0iH?=
 =?us-ascii?Q?LjF3hVYvO+NBEQizQ6FmKJprnyuWzFpSQfF2XjLxykJrTI03LEW44TYha7xi?=
 =?us-ascii?Q?xQG39PvHI12NQNrwiCfrG8B6fGd2tVkw++G/uTUPovabrGVuJf0SaeQEvN9R?=
 =?us-ascii?Q?QKg+Py7wkeDkFJoFn53eWsE0emXBN/3HkGN+K+Ja+QdVANi7qvrwD5bgpGXF?=
 =?us-ascii?Q?XwcG7tlD5mpOF8Opmf4BILT4SSixFW2dtR9ahzqyhG5Hs9d2hotCW79dy/vT?=
 =?us-ascii?Q?qBkxqlrQqozvu+whmoZNOm5oEXWblltIRfVUmQk3DzQ5zUVFQ8hLaTFPy9Qz?=
 =?us-ascii?Q?+AxCB9hm9Y3cT4sDwkFgxznw4b+xmYm/QVRGlsMJME7bOz53EEgtkXGR7uvs?=
 =?us-ascii?Q?GOCIEx4OXAnurWgs+wcuTMjXmVdShedrN3E46Aj728IwV8YQzqLEjDtFeAhb?=
 =?us-ascii?Q?+U7iFlsHKsR69UOwOZVksndOsd174KqVFhcHMh5qYBG5BmojW/Osd0fGQgbp?=
 =?us-ascii?Q?9V1HaCgHjhEECsNogVay1FW4sgP0jCozfp/jvpUIOpWv7B3TorQTt1oJnsIL?=
 =?us-ascii?Q?U1osdpdlP2n7YLzvTba9nQsSGMHoLIyQvdKnnZtVSRYkMDkU+cPItMOdlUA0?=
 =?us-ascii?Q?b5zVO86fkPGgzbM6N/pM3PBBqommYKySGCmw/1z0BzcoPANR0ZhVPqJiCGes?=
 =?us-ascii?Q?+pycaAEqN0PXRTQhvpRlr0FJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fc616a-854c-44f9-27d1-08d92da1d6a3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 12:58:56.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bBYXcqbzytoPTnUOvBKWHTxHNiSWsY398TwvXA/4THF7bVZmqnFmLp906EkksKpTQnEsOwOKP/DHcVOgbKaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
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

