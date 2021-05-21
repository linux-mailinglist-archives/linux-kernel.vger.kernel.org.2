Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB438C4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhEUKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:31:28 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:30180
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233633AbhEUK3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxeiJeA0k4E/jibtH6eZGdB9f7Mdbkzj+/cMmWlmadxKJEt9v9N1YG0C83XUe6+mSag2yKcVudQiXH2eQzGmUUt8B+ij/HJKTBRkoGWkEqsV7+Q62/AdAUehUwHPdGD4nzbTmT0DfjMSV1/x00I7Nj66zBwsrsv4AGY2iRpep5HqRczgGo1uP4Uws2zvnIDRfbBmxYm49hZJ38M/3XjM6PAFjUD7gbdfDJY/wWCh3uPh0HvnU+HjlUAmbQayJQTeDFHsFta4XE9wN4+Jn6eMl1oCVt7ELtIZpA6b4sQPQi2u80XQjXm9E1i3/sq7RCiQdK8zPQk58Ehv49dgra7Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=hZpThiAf/liPhN3z2vJKzfFnJ5ginfh362v43piTc+AjVdZW2ih+CWZuusGGDzWUeYKLaOx43pZRkCcTM3edSR6InV1qpcdvcP/Y0ddPs0HDf5yIXPhgDNdwsio/1cVOJHlHIEoP76SR6IR9si4McDtdNSsEKJFFy5SAWmT6Bx/QHPJpR714Mg0684KHpztm48A0hZJwKRF2XFbkS6hf4oA/vYp2d0xfZAToME2Ap3UXgjW9ZxPfpKLmzNVTRn2A5LTOheAooqaaIx4gsTRp3nmsTqjfNXTdtyiAFEwFs6SeUm8D+mafrdLTUoBxSOv+u6aNmUhjIgDwFVzHiQQsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8D7o9Zkhoyic+N9lE/S6Kr9IT/0CYNpO5BdIwHQps=;
 b=edd3u8EkU5pPzeUVYWz9MaNK5Rkd4QX45hZTvbYjEDvDE1/nzl7IF2U7ttJk988SDYrCYuRy6X+i9EWco5+Ioh59/SwSKvzN7ZdM/p5AdONzNaPd0z+xOWwpEced5KrbMfXCkvGsA7gKpNNKa9m5mSWqCvyIYzC+E0MDTsuAkuE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 21 May
 2021 10:27:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 10:27:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Fri, 21 May 2021 18:59:19 +0800
Message-Id: <20210521105919.20167-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210521105919.20167-1-peng.fan@oss.nxp.com>
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 10:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49bb9e4c-dac8-4dc7-0675-08d91c430b90
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4636ED85524EDCD489F9AC23C9299@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjqTzB1H+lIJI1zgenDFN7o56nX+ysW0gNHcrdE65vRsii3Yto/hbl9C7zG852WVhfj3IeBKFcSopAX/keZOQz5o1Ih5PtuxRqVarMhys8XskSPBMLvrT18dC73ULnXWBqhrUFlTTSAI2h1geo7udx1a5JqjPRraZLdE5vspFgYL8va8D4imhGpbx2ucyCJSxviic6auvx9q17FQDCRMkVViNc8nGcWp6kRiHHMKUBDPhkLG2S31f5ZkJ96Wi3d0Ukl0BOnUe6uXuU4Uxw5Rm+BKLpE9SBkh88cUlmoV+7vzVyZm9luwfBpAfuHpCwBqH1Z6+xjqSWYRYtxMmQhZGOLyJto0ewvf5QnuMMGNjsauvma759U6fJURHYBlQ76f2of1wdZMgBOcAuCQAoKy8lZrtcevvhmN/nl1VqBzO2uiGXoTbJ2Sklo3hnlUjfmhqVyUIDivueG/CyznvUQV/5G2oqn71MrBK3kduFw1/STFgbKOUE7fQ5XHsy6eeE3hapiuRMAKbxmQVQa/p546QEjH1Z/HE0TvJKlQt7jqVnUHUY0urdGtfcVmL1M8xS7OhXlCkarsRqy4xly6yNlgVc0HUY0OGTngWP2dAQrRz1F+UIGE/k7KO/P5EehNg7KBOyTv1eploUMf3Y4xMol/KdP1rUpPEV6V64fTIsu8PLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(1076003)(6486002)(4326008)(956004)(6506007)(478600001)(186003)(6512007)(5660300002)(2616005)(52116002)(8676002)(8936002)(86362001)(7416002)(66556008)(26005)(38100700002)(66476007)(83380400001)(6666004)(2906002)(316002)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2LwoahQ7cI8pTOnqNPg1qQkbjhKMBgH85AP1XJiRPmad6Gi47cA731tXSuqO?=
 =?us-ascii?Q?NvqpjIR7/4UsLH3ABj6kUFktPiWG1OdQ+0y6yZnoepI4eRcTfUX5rTvgs7a8?=
 =?us-ascii?Q?t8806MoU3k2xgmBwym2bGnwDKSqGQ+f2bFsxX3a37rpYlJ42a0ZgAmkUZD4/?=
 =?us-ascii?Q?6hz+ohX36gB2FpRmQ82yMusOpJzmxnDuMQAobmouc31W0vQikdsVO1qiVRYj?=
 =?us-ascii?Q?6GFOhzBjsDIj/D6DlDRj+OaudkET6YTHLIHRw7RQ8h06a0mgw0pMmsMAhako?=
 =?us-ascii?Q?MHFpjgtXogTq/uBT7Gox/AMAQcnErsRMYeFM+Szcd1b75XLhgWQY18z14US2?=
 =?us-ascii?Q?C3s0T6aOW3dEGvYl7YFhMvMrSLXc/bPDl3mAM7Djo2TfyfI+CcZJHOoBLDd/?=
 =?us-ascii?Q?80aF9R4I+o4CMjnkXKghjyVdWZG9UTJy9oKz2UkzNy4XsFJWX0FMOfuZHkLL?=
 =?us-ascii?Q?kWglfapHH41bpWbfhP0I3U5xLqfK3scxqTZUtwFDE1vASdwdlt0au5yLEoAH?=
 =?us-ascii?Q?oQ389cW+PdvPi9BxwOfRoUnd0ZKKD0Q+shyNNMzxD3tJ1D685PunqhweX9Rw?=
 =?us-ascii?Q?5Mvwd8B33jAwNScE4Von2NrF0VSKeKkgDl2RgDsfilE9soWP6Vj+KZKRsJQK?=
 =?us-ascii?Q?0jTbtZUHlPlcswFzlIZvhJPflDuHEfIzbrOXCgu0JDOuYn+otUGEwbaB8Dei?=
 =?us-ascii?Q?DLkt5yr/570iQGcnaYTlxUvIONwhEg9wHafK+hWMAkQL5iWcFh7ajnDiUwjV?=
 =?us-ascii?Q?Jeyv6Nan8YH5oq5BZKGerPUOWz9i1T63y2pVbPKLqpG65wwoE9s0CJtftULu?=
 =?us-ascii?Q?ZHhg3ZV9WueXjldwFSnO47d+90Zopwd+MFB/oDc4RIy+FlnX8TjnWIcmo19D?=
 =?us-ascii?Q?23s8Q2GfQ0KIH2CqcgcBJfsIdzwqLEdRNiKuN7Uiqlfzrf9CClrq9qHccrEq?=
 =?us-ascii?Q?ZyanXFHgyvCRFBPa30t/tZU7ibAJQZPH2v0ZpJgv48T5UHklzC5oN5Ush+H8?=
 =?us-ascii?Q?FrdHD8r8HW1f9aybF7ZfT0NkHvGLT+TKJMwaIAdG9EYfnY3EF9Sh/DJLmcD5?=
 =?us-ascii?Q?bU7mnrA1iuF5rEHQV/F6qitNkKX49DBi6zH1VFLjJt2oLSQNUiQJ62Kl2dPN?=
 =?us-ascii?Q?euDAyLTq+3mpYg2Q1U0aVfhyeeQwROAZZ5bJfIhSC+N3Vmob0x30ZIxH/6EF?=
 =?us-ascii?Q?FcPizhd6f3AE6IyhwZeHanzX1rpkvbI4v42Qvmn1c3VsMhdB03xYXoOGXq9E?=
 =?us-ascii?Q?h3tievsiOvN8eAUkjsaQQxXAyHiw3KCTTu1zZBchc6HH7ZWQ1E2mhTYRFJ3G?=
 =?us-ascii?Q?jzBCpyAasnXMhgm08W6/vxL9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bb9e4c-dac8-4dc7-0675-08d91c430b90
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 10:27:33.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdgbS2qW+ty2i6ftqJCWlpqWzk3zec1E30lVjoJ7+LVzXsREgKl3qsALJ3AB8HpdWfYb8rrdQ5vdWo1jZf1wnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
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

