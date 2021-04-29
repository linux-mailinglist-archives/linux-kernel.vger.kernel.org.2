Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D259136E570
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhD2HCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:47 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:32660
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230174AbhD2HCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCUt6qO8o7TLe9KRjHH4GxjO4a0MtSFgzHfq5jD5moVQ4ixD3GlCjtNRiP1m+qThTUYtitJz/201e4cCnck2m8m2b3p1ZJo9FE5dRdHWvEX0Fl2p62/gKuOTLDmXVIjlyb5ceK53fk8yX7npAYAhmv9CfS7kh3bXGA2MuBfTTnNlUVRDde3j7QF9+mjtdT0iAg+NRjoKeqRre/91OB7IlKH+OY2C6sIz1ke4f2GXn4BHMs51NfPWDh8IK/kUzKYiR5JacUTVFJfcJpDtLk/HmdR1dH5VPsbMufTj6/tLMt+uymcz7dLHhjc8HTluXxKa/jauUxpsZ2NQlD/3emmxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h15TxzHnPEFPnun3tKl5O+7Y9A7E+k+i03nQ5iN1Pdk=;
 b=YhQlhXwn46kRFccDadIb5AG87Ap6l/PsESuoFdb6kCVbidFdmgYI06BVp/DtT+9gA/D3ZLwzcSL+fOcKhbPHw0sr1aXG/6EfTdYB3cFrJ0ricT6oozXTOlhjNVqVBDilA2iDPnPQNhvUrgjTrFDQMombqG19z2ZYod1hZpi0X+sD2/XSl9TOPtZY7bshoAEwmcJzkyqjr68hPCJ1aylDodXdng6Qo3mameG5Zb8SaIaO0HOU2kWQ3Fr+myrKhsuOYmEiz1ZQkxm5EgJXFtFqvArXqGiAO7iCNRcILvFPSiABtlSAsf2VI9cbmAe/cHu8Wajgfz3gzgUkUBKOjz5BkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h15TxzHnPEFPnun3tKl5O+7Y9A7E+k+i03nQ5iN1Pdk=;
 b=JS2pYwwMee63+IqYc9abcE/KPAmKSgxlc76o5DgDhIxbHovQMHeYjOTkE9Wdhe0iUalieRPw2S7ADAjoRxDwOXKIFNDiEFamAoAYIr9pt1roQXFE6SEo2wqL97aK5Rh+/LavbDmjP5axDRW7MSIKUDn0ifuUEV/qRTQbNsyZuB0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:01:52 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:01:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Date:   Thu, 29 Apr 2021 15:33:31 +0800
Message-Id: <20210429073331.21204-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073331.21204-1-peng.fan@oss.nxp.com>
References: <20210429073331.21204-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 07:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a8b33d-6164-4a7a-8fe8-08d90adcaa68
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB79300B9A1EE6A9D944A0C14DC95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIGYx/YOzCgwkDOkHdPLeOxVoNcUaWLX+m4yga7jsc9WETbM6h502vmSm2iR/iRaE6tX1OBTCJPdGFJ9zLQrSmhF39wKMzA7llX7nHYBeBi9t1oALL1BzVYIXpJQob9LPLgZ1KvbM+FX9oGmfx7xIck+ME835zdDlmQfmr7oy0r8dG1WnBAbS/07ntMdqIOX+3kMACrhjpRXlJaWTVJjK89C1996TbT/XDhQd5Vg1IRCf2615jJoI/zbbW1BfEYTvVKMpI43asXefhjxgsyjnl4kkWOom1Xlfj7jb5D48auejNneyB7yCpIJLwY/3tNCw80wP+4a+Q+qw7Ml5q2UN/NwwRjQ8HI+ZLZdG02sUSKTPMTXu237G6ywrSe6CU66vnmQAkunqOSMCbUddIxDhLIj7RBVWZfNbYueSZxMK7EXy6DFuXl7yFM17N4nsVc6osYycSgkbavoOkoBYW/O0nn60FA8KZWGMi/cF0qMZ8DiPPAyPZ3QIN1exIMcBEnmaZchP9b3FQcDI1/YnT7jjHM5tyJcpJzW6pLY5oQ6uLggz2XvzMwhQsVBLBZ4tvYdrnoRwmzG4zb82H+rzWJcmbQV2LV1G6/d0LVkNsGBo0Ot9VYf8BrCsvE6jcyxiA5pGntCzxQZdKQgGisvjTUiuqjwNXHVoQl5/amUAjycs4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(83380400001)(86362001)(4326008)(956004)(66946007)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kyKknwp/9GtWZcQlSkWFpuE9EiNK8HeNx49hURQi/QSrA2gNuV3E8asmcDWo?=
 =?us-ascii?Q?dumeWC2jaSpZQlWNtLtZWsSF45QmXDHHhEI+IYaLr/Og+v4/0yQQd2oDDZXi?=
 =?us-ascii?Q?MrzQGmbKmO7YcbtmIH6J0cmZPSkwXW5I0HZ9eMkjb5g7y2pUyOBcrXApVOSu?=
 =?us-ascii?Q?85T6zP9XqXQgkXOeQVixwZioFdO5ZKLC/WWE3mE1tUg34iFiN1qEYDNaH4sz?=
 =?us-ascii?Q?DKYozdzk4+NtFLw9rzFud/JpPFrRYd/1raQTdc/G7cld6/i5rkhzMuQJPoQd?=
 =?us-ascii?Q?wzx/zG95ynuMjU16nUqnXhF7HWoNhOSp8dPXkdlXk9flsQ5nLfQ8G0BaS3uK?=
 =?us-ascii?Q?mmhmjGI1vrHhEDwf8Hg7hFr/z0awjEqKcpK2yxI28/h/tJ8/KF69WpvIOLHt?=
 =?us-ascii?Q?ZXWxATkGbBJGUIw3tX1NaT2PClm8u6jvkCYNHF0VQc77lDR7zsVEYSUlxZJH?=
 =?us-ascii?Q?0FWsc4aOjgl4HZgFW+2r532avK+gzUPbBM1v/aUsOtlo5pYsQziGwQfXR1Xp?=
 =?us-ascii?Q?9PVaMblnK6KYdlWQD3F9a89nRXH/Lt4Ych5xFtygatQyna730Pr5ZGWLj7OG?=
 =?us-ascii?Q?39YbJcJGOKi6Cwzxg3CirwF7M+2oS97GyoTwHI0Ga3wwyIh5ke8L7x8MFONh?=
 =?us-ascii?Q?IV7lsput2NbIp6iP//qNf0rvn39yraEZTKCycBw2z6uoNIWtY0q4bCYbYdwm?=
 =?us-ascii?Q?FGTGA+36K5ZsWeJVcQOsBcbdIp+tVJ8Ez8+ly1yBr/hsoJb6UUeqAi4E5dyE?=
 =?us-ascii?Q?TB9YHCPaPv4OB0f9nWcPp9eFDkKUkiTjDHvzYeS0yxEzyW5xo6VaEo6S5J44?=
 =?us-ascii?Q?bseRgl7Ync64Gmv1N68xG/ykp9eiyq5XZ3ahA+sZbbIji/wJ1KHQZqErHVS5?=
 =?us-ascii?Q?3+MOprfNxODX53rE1xWJjZ0ZI7mm03TkLhlP0QkGaaOUshO/DhaLvRfyC2B0?=
 =?us-ascii?Q?2SUXh276hmhlGMHNVrHxmNhycYUUeypYKaby0iv++Xo0ZU9ywMagwARen3Xr?=
 =?us-ascii?Q?GokuuaOCMV3YOWINyZi7neVTid7wrJILv3CkxmIKMzVZPvM8J6wjhUKy92ST?=
 =?us-ascii?Q?hT+ZH8k2vmvhmFoLgpAeU2lfvinjVrZJKyaq7zPhgUlF8Mz4PU0QM1JBEnIg?=
 =?us-ascii?Q?GA589QYWitnzUxU/9KkUOCnVS3FA1AA5VgR7TFvP42dYY1b8ixKJGffQmhcX?=
 =?us-ascii?Q?CT8klomGgWbgvLCqwL5WGBP92Mn8iICbEVpnqpZ8K92QNUrogqAYyMkG2/gz?=
 =?us-ascii?Q?CcdNomMYyv7JpPzHtXnUbjMtuJwEuALwRR8q3SMfYLnwUNfYiBZkNVv8RQni?=
 =?us-ascii?Q?GZ84Wfzfuj1ph+ip7n1qZcpV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a8b33d-6164-4a7a-8fe8-08d90adcaa68
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:01:51.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28o/qFODxeCfW2wkUJpBYSt1BPTfSThNXXdbm2nUAaIyf1A9C6jEggcxl5lq+WLY2ET81LkTifOTLRCDSX5yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

