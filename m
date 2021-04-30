Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A808636F53C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhD3E5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:57:08 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:36610
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229977AbhD3E4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWREmLJUz2edw3mNpklKpe95dlMFf5r+GxZi1EGR3eo0ASwtDqVh0M/TUA1yIJ/q79eqLIKngaQFJmRjKleiKI1PQ7hIICVLLkt4EiQ7hfbFppO6NtfzHtWNc7cQbEhfLWcSkLSqRHX9kTj/Lc36oMQsDLmNtN6WdGo2LUtStREO55eR5cEfETokfrghti4IlwfWmCqsZjjmUcyg684ndQ8n2LAOVAoaluG+a6/3Cuu3/UbDRtIsilvDfV+dhFWTuln+KB0sqH2rWzMC7V10Y8z8YWZ6/Hgy5zB2R7T5jLHQ8wdtEM8kUihwaBYvXiqZkYbHbY8L6SjT79yTUOyolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h15TxzHnPEFPnun3tKl5O+7Y9A7E+k+i03nQ5iN1Pdk=;
 b=i0t05nlJZHH2NHrATpColsWiNn5fb7sY3ew4aBH+NmR7NX1bo7qckCkh9xibzlg8jm4z0Z92txfJ5S5X+yr5E3xyQLs36XUdlzByD4MBFdANjMmMqZ82pL0V5OaW/acSTEb0EbiKV4Q2uEv6uIlQgH3A+VoK7DnM8uIWnWst8B0Fc5iT4RgyZ9Ec2LfzbXYRa4zKZYaJOkLWF4HPh0bCQIyLVEVj3ew3M/L2X0pgdpxtjqikjf+Q+ss5sSi/Fry24j9iAcowxnfgtXKIUtYyre720wCGE7zJ95jmYgp+Aod+n+lrgsDOvCqqB0GIb1aM0yhKaMJUJn3VSU8w34ThOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h15TxzHnPEFPnun3tKl5O+7Y9A7E+k+i03nQ5iN1Pdk=;
 b=aKhSct2S0gzmQ3VE/rNdVhz20lo0VqIFIAdTXITQIxOcQ0+VB30A+J/QyfxeBuB/DS/5kH/R5Ah+ycCfHeY2AzS9S5XWoD5EsPw24hAxkQgXt9kNPvPTqAuGVCCVhJY5o4YJFYR8LY6GewyU+lL7hfwVcbXdzvJ3c6LRE9yyoJU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:56:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:56:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Fri, 30 Apr 2021 13:27:46 +0800
Message-Id: <20210430052746.10815-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210430052746.10815-1-peng.fan@oss.nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b324583-d69f-4bae-9e01-08d90b944079
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB391604471EE1E33D328F1317C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M95TjDZWdHiekFxGsDN8P8EjXnfBmlqc1xC5FnXxZsNgf8Yr+XfP4twD1gGRsuismYii/JZYNrdLLLAT+oIWOHDUMXmey8IeqlkZaYbMHOTgGXt8RimuR0Tv9ZTNDLGVJ8l40LggUa3idH2onR7UFYm4UVxbnl7LYWzJO9GoiOBQlDfsOL+fBKROIwTW1xHsZtJvbgnJiZmtXdK/nmQb2RqvExe1nkl0hJQw3VoQb/qZM53uZiKuvqHaLZQZv7/swofizz/w+Nd/7/sPuwOtAUBnvc1Jlvn6UTT5Q/AhwY/TqvY9Hi5MahxgeEDknhq1dZkAk+F1OFGIJzDP5JSirVewkencUxg30ABPmDLgax+Jfly08G97Frs2vRcDKNHfek0Z0teeYmUcciAR/JXY93u+I3jBUROZA3XJbgb4BnPQZiRfryEJcjerkVZ2huiIN1rR+uW+n3UNoDOdpCPSJWSSkYzkNPHTBlhCilZ0+9Zq5C7FF4F3kNXKPzfI7TsNIN3sKqf5pu2zzan7Ce5mNin4hj8WsiAH/qWEvUV5EkhaKpAsPxdlS9ZSFi8p3bjm8PcYMx+ouajmF/nly26lqakPptjkUctQWPap9NkRE0kiUtuLWpyACl34JVZ8fb0HHXPJNitFoR5D3T2qivAp6+fbRSzYgpZiiOpB4Fw/3IY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(83380400001)(66476007)(66946007)(7416002)(66556008)(4326008)(6512007)(6486002)(6666004)(16526019)(956004)(186003)(86362001)(2616005)(6506007)(1076003)(2906002)(38100700002)(38350700002)(8676002)(478600001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?omQPMzQ0U2btW0btSIi3eOH7O/40p5baIFTF9cgBe2IArQhXGEKAUakaKbHI?=
 =?us-ascii?Q?A8x7feUDH2HNUlwrtgCBfz31vzv9IfBfQLVigMZhpBw5C2htt91oFSYEEOrq?=
 =?us-ascii?Q?e3crIpyiMvAF7DQ9oDMMpVIcaluYeDAp8D/35iGkbnnYFfJbZDPCKCx5iFWx?=
 =?us-ascii?Q?o5KB0r4VsKM//0S/rJHDYb/bUgH7LbI+iV0U/lwCpk/EnR0PJhzFBLAuUcIi?=
 =?us-ascii?Q?6o3ZjDgG+3kc3khOBQoMwLoRhUpWvW5VaDYGYyoKXCywZHwGfFQEMMzH47Py?=
 =?us-ascii?Q?/aEPIkKJZbuFaGqCjCWOB/wNB/tG7tkXthTwR2FosPcOSQRAjgrzkgDAg7eP?=
 =?us-ascii?Q?2/XuM00fcCZ+Yu9TBn3f0cEhLqbc3x/N3/Vuk60GLVAaEnWyVFkDkWfjv9BI?=
 =?us-ascii?Q?+aCaBwymz5/27rAJIpD1+se5DeSlG5GgLpylwoyYZz7yWs6wYsNmj744STCf?=
 =?us-ascii?Q?YiJ7uRg+uNNUmheNM3UELvoeFg7kHwH762jXXTGkx5GpqOW2+vDc0wm8smFf?=
 =?us-ascii?Q?WfEL2Sor1cMRButm3c0hDMcsu2BAuUnlwo16h2njCdHIvK1g6HD9ZD8lBm/B?=
 =?us-ascii?Q?DOySuSRuB9F+U8GDk58een7cdrre5ynU0w6N3I3KAu6q9prTqpAXtyWGIpbX?=
 =?us-ascii?Q?pf7BqBOaVDdrGu0RLA10rqnGNtTLZKMV0BkP2SFvyf1jHHIDmbQA3UDED/k3?=
 =?us-ascii?Q?33KGNNabz2Y6yELPmGtQvPpozwyefvC/+5NZwo4naCsed6NORBkBeGzQR6yp?=
 =?us-ascii?Q?rL6adtX+WH4w96tVwkr2VEuXiiP5AZ6KnG+H8ZwGv/z1DVIiCQyZJx90Mtvu?=
 =?us-ascii?Q?r4dQy6LSy6H55E03miqpvOqREd1GLMA+mYh2e9vI9oam4PqQ5ATLg36OUlDF?=
 =?us-ascii?Q?RdMlHF6UGnC3CMPd9ySEz66u+pIVc0H6XSdSibF6Lq5+cEIpolProMIQSvUw?=
 =?us-ascii?Q?j4ZKqB3A2u3xdEIfNXbQiq/rmlhuTspHfHjI24rxcLwTAcOwQn6ljPULRjkk?=
 =?us-ascii?Q?vLjv+fuAUc3a8PHw3GNJ2xkQhvXpVFHuzbnbpVtpivX2c07XVsXeFCWPKO6c?=
 =?us-ascii?Q?Qd0yXesJUAeUq83TkA5ONhEuPR3Vemz2Wo9ay3gt2vO3Op8RIYqM7iNew422?=
 =?us-ascii?Q?pqMX0XAfpj54IXCxvsE/MQKzzvPhRfF3K5EgUuEUS1K8A18Ylj7ObQJdX7+z?=
 =?us-ascii?Q?JMthVKov1va5cshMO+Wgqf1SbOM1S7XF9bZColQ/sGAhhIFCKZvDYR7Ah4ty?=
 =?us-ascii?Q?oEyGb6ZcVk48ItNoHp/jCOhJo8HXai+FozQwgiNfpjqXjOW8q/mBIE0gm0eB?=
 =?us-ascii?Q?dXCcbGP3LwYfLM7d90rJ6CNs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b324583-d69f-4bae-9e01-08d90b944079
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:56:01.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHihwNfHurlsZp/2/AJ87OcCpiepK251O5pyvdVKK6XT+bQJh7PSC7phW45uPs2ek3p8Ii58LXzXkYF4TP4pNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
index 000000000000..77e0a5d3fdac
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
+	struct resource *res;
+	struct imx_blk_ctl *ctl;
+	void __iomem *base;
+
+	ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ctl->regmap = regmap;
+	ctl->dev = dev;
+	atomic_set(&ctl->power_count, 0);
+
+	ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
+	if (ctl->num_clks < 0)
+		return ctl->num_clks;
+
+	dev_set_drvdata(dev, ctl);
+	ctl->dev_data = of_device_get_match_data(dev);
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

