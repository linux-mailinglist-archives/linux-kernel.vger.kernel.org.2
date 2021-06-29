Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBC3B6E75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhF2G73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:59:29 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64485
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232254AbhF2G7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk7HAXrcgZym8+u8HAJTriGny6/CV16kYVfS0y92EOkMWYhwjcxK2HhRYZzsz6SFYnAcvnjBehh/TYIgzs5vvg6Ugp3Ax7GedBfiyQb+mO85NcwtD6HeJCbeKkFxM7pkONkzmDtszP/SuHhdXINPVFHNPwVQ4c1NNSzk0JVzdlgJa+KicLzH5PRJoPjiPC8C1utyb557p6doYMngc6rBn8/fI6Koait84ZOxz5BmrgKsbM6oOiYI0YUUDvTJh8bjX+jElC+cppjaIQ4ZhzV+metJRutvUua9Dn/q2ZgF/iJg2jhItD2Lve5PS9RcWZk8M1DWK4wHfIhT0B5Kr/abOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=gcYtsGbv3GIZlRyYCuH8txQHaBPISVYhkxCT04ISHAVSr0QfXGtrD8wWWSi5i3dmJJ3Y5FGe+xU4WRYuXZDLitpzlJVTB7i6ZWBqGuBWFAPrw9W5G8Mc3M+QLQa+WQiYmM7ToSnAtgx2I6+xX/0NGQlnPhdFLczPEqe+AWWEEAFr4q6o3a/5socZRfd9wAgyJRBvZPmRDW+pzUP7KkjSPupJ+s5SGWazIeG+Ru9veAcKXwLn/jt8a+LwrhaHt6WdYf0cjbiyLBkcGcQQCbcGj0KeX04eXm7h4W1WoXSpMKjsVCAYhxW0O0SSzQeqIfAgf6eibghP4LGyKfdFUMZrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=BCQ/5Xirc/uip5b99qlFn7ox0uEiGG3t5lBNYDwykSPCUT2/FN8ICf14iP3vqS+H8qFdsTt8VKIr0TbZcbvmGqqC0CzOTuYUZl62J0roknIi24MlziMNUrKujVPeQPqgVoud1GUBJAz3I59DqblMGjLF5XFZViIQzJQopOPpI64=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 06:56:54 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:56:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Tue, 29 Jun 2021 15:29:41 +0800
Message-Id: <20210629072941.7980-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210629072941.7980-1-peng.fan@oss.nxp.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 06:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a958435-e9fd-46a3-184d-08d93acb1407
X-MS-TrafficTypeDiagnostic: DB7PR04MB4762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4762441992140185C9B2FE6EC9029@DB7PR04MB4762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4bRwS9x28Ijh6D7k5jzHm3Kml4+2EjpajBkrh2amNrziIli1fAZHfmgsVPSu9tvA2olzMaJvSRlPSoUFQRQM7Awpqd2+a/SHHcV8jr0VaYecgXIxbnZyGuxBi97prnild4Xux/zB+5pgM59JRnU8iysbF6MBQshkjLwEpiaEDxrh6pQHK6BEegpseP5Ij2/M2aGNGz9ph0RoQ9qGqGZvgLKLO3ienNWXO+eejzbMz5GD3NKnz9qN7Ng+SFiX2zMOGpi+2KOgWEjDMI6NKeQqSLeKVB86cpVFUPKW0H/+Vx4vxAipVYU8uz/V+sTkbikHmbkoS8tiFjAXtjNbVa7m7Ru7ofuHrrbduUwRP1XIMqu441A2LHn/M3BTUEQoMr9ALTwXBNhexi5MuBEu7eH3IIMKF3MoF9rL61eiVO8/x+9jmWlYuh0BjsUSWJaeiCjvGb4w9MqfDKvuZ/BfgjebVpler48E/lX4Kq9Z76B0+utUh9heljimQGfWiU9SiS2TsLrkOMU+fZfrmq4Y98LCtvq+o4H5hflNIEnXN3exBAFTIFBnHSoZkN0p3q6yeZUCFAws5LDE25fchWoICmOlgZm6nMoKcnBJ+4Q0sNx6bLgNytAxskmUStQ52+1T13AkNCC6bp3z2OBscuz8h2YCJzURPlUkP51r/bMT9B2cM1q/9DjAqQ8wbrXRyR8lawvqMFAB6P+lWf96xNNpi2mzMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(956004)(38100700002)(1076003)(478600001)(316002)(6666004)(2616005)(5660300002)(66946007)(38350700002)(6506007)(66556008)(6486002)(66476007)(83380400001)(8936002)(52116002)(8676002)(7416002)(86362001)(16526019)(26005)(186003)(2906002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWmQS3k5Exmds7XkAs9BSXyImN0Ih02llzvB1Q+Hty3PVkowjmcolg07gc6A?=
 =?us-ascii?Q?hULeHLGQ8FToKtNhWyC/j68pUK/BprVrD4+yAGsUu269VCOMrsFkHL1Gi1pR?=
 =?us-ascii?Q?dE3Mjky6EVCouSphExbvILFmnKpW6F6wJ7uQbuWG7ZUe7ipdkKrv7NSqbm7h?=
 =?us-ascii?Q?eUVTmBqGvBA8UT/lTJMSnSCMSCE6egV3P+GW+Yyt15596mgEpMm6Ek4EI4Sw?=
 =?us-ascii?Q?PGlw9BBmHF2j0cLZ1FPDLToHxoRhs+3ukDDzgigFI/KjSfYWmCW0WbxQVIPX?=
 =?us-ascii?Q?PUQ43Khdg8COgssR5GgJrCbLpQnZOosHC2A3frvJKbbtTSzEPHIwmFw9XI1A?=
 =?us-ascii?Q?447sNvCVjdidW4l0kdIGAlyTm2zeiYNkz00y/iBx3jeX1SgdRKPeP547j9/V?=
 =?us-ascii?Q?kvquARy2Q3vQcuGlpEgckZ7EInEhgjiF4tnDeqcgAjP+Dge//wErueDy8IYv?=
 =?us-ascii?Q?Qeb+5weX71elsNm7yMm8CYJsCQziTh4lTjQG0YNa8yAD2N0vn9SePX/YlkRs?=
 =?us-ascii?Q?HqXJbuxv78NeYnR/twxJGHboFMOnZVjFJudKy1xoOR+dDkxy0fxJK0X3p/Kz?=
 =?us-ascii?Q?moxOPqW7UYKqpjTygdDITP4NS0Od5bCavRGU/pII/7IPvqpNi18QGxJZPr07?=
 =?us-ascii?Q?SQW7Iu4dZH5WoT6seWcrMpyECny+LlbdHeI/AR/Bk3lyGeReOgwlVbzF6zSt?=
 =?us-ascii?Q?owN2uFHhvm0ZliDIy/Byyd8fxK8tlA9lPpU79ES4dfHIyfAn9Snz/FdlkF6D?=
 =?us-ascii?Q?+FgARF+gDMi8KJyeG7inuQVEOWi+kgX93KLYB8LZ4zRqjgqvf5Wb1A/EeLgj?=
 =?us-ascii?Q?XAhOTknFTuWs9QkMhBqScey4acxKZi9UMmcWbfY2fZ0EgWslHV/L8NN2w5kO?=
 =?us-ascii?Q?x6y/lcaHI0VUB1UFJY8BR7kz9y4qvNh87LPRPkAuOtiW1DWfcmJa+elpGAQ9?=
 =?us-ascii?Q?CiKpcFQqiQO889VM7rRAs4RM2ivlc44Se1+NBcGlDPwvgSiiyOCtuqEIZpX1?=
 =?us-ascii?Q?+41+dRmtzKt5y5uiJWk0I8Z7dhZufXdo6sZVsmaOWFJ9v6A+lBLVxAFyJ0j1?=
 =?us-ascii?Q?2dXNu/pmDfR+Sz8DyXLDLjJO9prQkvIRPvLTE74Vptr/Da3iHN6gmNpbmrFB?=
 =?us-ascii?Q?YCfv+woyqTFaE7EuHRe/daPKcTrqb5pWqefb7vYxLJ5m1qmJ+SxFlka/RL/4?=
 =?us-ascii?Q?7JsCyUSILfk7GXpx4IQPTKPFbSfUyouAaU3iGMzzFobAyzAb4fb8lMkvxjlo?=
 =?us-ascii?Q?Q/345LLFSCndd0TOuy4lK0w4R2sXXAy/nfMdK5WFel24OkHMcHxcqmCP6w78?=
 =?us-ascii?Q?Yc54VEUkjR/DjX4B3YXNDLp6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a958435-e9fd-46a3-184d-08d93acb1407
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 06:56:54.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aajHpR9Ugfql1e0h9ts87uXxJH8UDgfJR/PpopY0iaqKPGyMnDGG7CTgWmy1axQI79FH4uqaNytqMnJ/yLV0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
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

