Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA780377AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhEJDgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:36:19 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:7904
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhEJDgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+M8ph+JILsJTbx0CHCi1ma6JPQwQHnvoPwMAlqN9bZFk8CnWwp673vNWN+R5Djp1AVTnA7tczwwQjiPKmpA6kO3kW0KmZQGjP5BX0+My37eZWfHChXgst051h3USywZf5Ic/+VOq7AgnYa237t/HepcCy7Ibqidwjbr6F0S9SKLEg53/Ev7mKawbVqHz2NXlsL808aIpBGa2Sg33OGxMPIeqnyPs/Ib3Ur9Nk/FJbp9dG3IUxO450pgx3ZedaCoC9KB09uyRwN0trjljD3wX7w7YNcOPna8zynTFLaQM9weuwCdufstE2lzWBsF/7ElonMweMGpQ+foUiUd7po9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6mRPa3Q7VO6IRU2Wz71+h5m56e+vaXBAfslpxuN8p0=;
 b=lBmY16lt9EryTh8vDerRgOjVurcV/KaI7SZce84C+372BQgKpLJhdTeMSsDqL5YN3f6rfuypPmmfPNnAngS3AbNVROuTU6EzQD+VQX8UgzI07sRXNuQuhF4cqN6YUMuaL2Jcqj1vhme+1KLfVqrzGZK2oXbEkpf9iSOwecYT9YdGIIiX8zPfWO21P3etpQwQMqDqSBGj638m1vkAf3+oaxHKR4eYqmoSfpK1vTM+sCoKPPOTH1sV9tcyzqo7wUL3aKMm1AHSrigyw2zlz5CrbHoB/UeDRFepJopKIw1VTHK4r2GNDVRI+r8jOUFJA7xlz2VExIcnsjftsnq/3MmcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6mRPa3Q7VO6IRU2Wz71+h5m56e+vaXBAfslpxuN8p0=;
 b=l2KR68T+Utt29YmAc59v4jAy/tK0Z1d5/NRaw2gobFCEbGLzzooskD/a8tjvUL7lnwJRsK24B+COo3OyYRAxeJbNGGF+rsdDBnH3KJlaSi0rmK6oRi3DqgyzX11C1HYDzaSpFFgAV6DhGnxmJ7wo0AmmFjzxXWCSeg435P6C8R8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 03:35:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:35:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Mon, 10 May 2021 12:07:04 +0800
Message-Id: <20210510040704.14997-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040704.14997-1-peng.fan@oss.nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0159.apcprd03.prod.outlook.com
 (2603:1096:4:c9::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 03:35:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f64dbc-c70f-4c97-556b-08d913649a21
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930D0F41221282A8B145512C9549@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4R1ZM1ztVWl1I/z9t1Zr6Z0rVdcXzTHOBQAZqXpaByJglp8l/aA4napvtdnQWr1AfH6EgiQ7J+s7tOYS+Idz7Ilqy/jb1VSJPJX7IKcWSdbrMlojbq6AQVEs9RcKaT6KyOGZ4f7QLmE0uFodSSbMObXZVpUnC0TAsArboioaoaWVo3iHdnZtrNfvCEKS82HrxnM8Sd8z9vLZQgMb0OhWtMXOSlU98SOZCuABWhuwrAN4x8pu07dwR6kOSNNFyWiMwEkeuPeqy4Udepw9cvBaQ6ZU6Hg1MkUsLOJCm12sD/Pp58IjFULKui8QH1P4hD3gyj6rWo6gh9eSu/5I6n0F0F0TFrS9w9UgaBrSGuEyVjH5VY62tlMuMg9d8ik8XHgUJP8/l80poW4nD/LqJi6D1ij2NaUhHNpzz0uUAH/xkU5NCHc0GsuV3jhUXP0cTSgb5/0Y8VPzmUfUC2MReT8CRikZ/E6WADhZmIe7Z8FE05r41D+tO/7qZYu1lZtiq1eEbpmhrPQd9hj0Y2fQvW4hFEiGoci/CJYGntFmQriqm4mvVQUJk8xHoSnpHOwER+iVjY2lnEoT9j8xbVGFxd5vppsyMWEKVLHOaYN9O3JqJRzmM8WdSKUiCtWeHF6pFo3/elcCmtRtMdQhqHUv7H3uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(38350700002)(38100700002)(956004)(2906002)(6486002)(66476007)(4326008)(316002)(66556008)(66946007)(8676002)(2616005)(7416002)(86362001)(52116002)(186003)(83380400001)(1076003)(5660300002)(16526019)(8936002)(6506007)(26005)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CYEaC+KOJku5Lz6NrEG2e5uV9UNvLnprZoBkojfRDj0yvIAWI1LyPMXbasK9?=
 =?us-ascii?Q?Y6+PIb+YFBksHpBM3uC3hhgPoZo0CxEpVwbNivHHVQzHRqZMGSANiQCSbZx4?=
 =?us-ascii?Q?AaprMz0jnrDO+Q3zcfW/IUhhCY868GxJDGgBk1SB8aGYTNJMXpvpoCakgWi2?=
 =?us-ascii?Q?9IyBgnl7ynaBTrNf7wmxsuto38aVlF14l0roWYCxKS3666DSXpbTnq8iSsWn?=
 =?us-ascii?Q?2AkdW/i9qdNAyRYTg0IozLRcAN3rI3a+6XoigvRpWoAOLXDlXBatp8+E+oB/?=
 =?us-ascii?Q?/MepyotW77nNGPbhIhr/ECRZGDGsbCQmHp2efNBhgfdq0PX6T8KaYOfb8Akf?=
 =?us-ascii?Q?YRN5gxQE9TvlbkKcm3RBMoPIsJ7+jNLM2VUqB0RpYdamOa6JPOnNkZccBrce?=
 =?us-ascii?Q?l8Nz7RmqqzlczKHwNuHv3mAsJq17nw/M30pmfahT2Tn1ggW28WK8+b1/xIyM?=
 =?us-ascii?Q?ahMUEYDlFsh0nDb+fFGHBFXeWDkboonfzckh04033dBNJp4rVdebOYy4a/DM?=
 =?us-ascii?Q?BhLth5U4SpbjIE/FQbsXKSQCyeS9IaS0mqvULzDVgmHUNXWNuB0VUDISP94t?=
 =?us-ascii?Q?KSCLOvrZUM+wlzns1+jdEV+i6FKdJU6Po+MIXH8J48lEcDOZ3HloYSLP8GRY?=
 =?us-ascii?Q?2X7xt+EMSbSmRDU38mcwUy3KP5AXx7l2ip7WUY4AUF34GtEC8wTrc2zYMFqL?=
 =?us-ascii?Q?mP7+5Mjr5vLqZQh5k0qjo2nRMTFaR/gzPlRO1vXlvMQH7M5Pz8WDTfirmMlr?=
 =?us-ascii?Q?+NxC8uJ80egkw/JEEppI2wR40ht7xu4oJAHJ6GE1QhC9UhJjxp1I7/KFWfaS?=
 =?us-ascii?Q?tpGd3FuMZsdFLnZNNL84DRTTI7n0nQntXW+fpPoutanCXLvb87rErrMvACMq?=
 =?us-ascii?Q?Y8ZzRpoQSRN5d2DtcglGla33wx+DAJfrlbrleJ21bbiBEOMfYNInrKUa7Y2h?=
 =?us-ascii?Q?TSwNKUV/qZFirdSlKQrBCDzeqvFh36CjS7iW3CkTwwa6tdWmpPM7WYA4pdhC?=
 =?us-ascii?Q?ZJVIS/Zx2KUNsabq3AAk3+pG0saQmLiTL3xSzu+jOeUf6asPnGPbuOs4/ZKF?=
 =?us-ascii?Q?dqsW/0R4enauLpsE3SZe9FkV4evZxgpupefoX05e12cbG0TO3TPSmFj2KZ1N?=
 =?us-ascii?Q?CAK5Uc4j//XbYm5/aHs3vW1RAN3asT2Iu/vWkt8/f5O8L2wfnSRRJdmu5A/h?=
 =?us-ascii?Q?ah8BYK+J/iye/g+q3JBRtSMxHKH8Mo6DTJEVKwJqRjbU+21tnDD8dAeVy7NF?=
 =?us-ascii?Q?MUB9rxZbHRMFrRe7XVcLBE1vMIEi7d2g3ZE6RWCZvKtJAEBWYib8/z2dwbQk?=
 =?us-ascii?Q?o/1eip0YDiZi3GIkfBkhCvis?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f64dbc-c70f-4c97-556b-08d913649a21
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:35:05.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwOOchAurFm2jFXOF2PYGWDbb157mpGX9+ZSS7xuKlkmA4mxSX89mNYtN6G1HzzL44u1yuDNs5dYJjmp8rTsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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
index 000000000000..5ca8d6c52917
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
+	IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
+		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("LCDIF", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
+		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
+	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
+		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
+		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
+		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
+		       IMX_BLK_CTL_PD_RESET)
+};
+
+static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
+		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
+		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
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
+	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, IMX8MM_BLK_CTL_PD_VPU_H1, 0x4, BIT(2), 0, BIT(2),
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

