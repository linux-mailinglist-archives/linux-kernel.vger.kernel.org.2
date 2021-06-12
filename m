Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D73A4F01
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFLNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:00:54 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:17479
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231268AbhFLNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSrG18GEg4h4Z2QxqIn6o41VjuYx7whM/xp9lqDFUyVWOK6UjLdiTLwEChfRgGfnOPFQaQ0Z3Xsrl/XvjEE5mY744k/uNce9L/RaEeSwEt0mCQqMAHi9+3SLVu760VKfRpcf5pIQ573WZHIr51dPXXVK1/iRyAv91SAn1vVkP/szkU96UoCrxV9vXf0Qfij/PptRx0U7+e5OekpqVbYO3ZFuzSLaR/dvfpPZdF+nsXBCKD8laZy1jEbga72UJYnC78zOI4M7Yb8p1MNjmE1bbzJDgZYGTHuQGRVuYIhrPMDbi4ZhK7kbiDCSQ80qxzH25MtM9eOh02mxhA/CJWdITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fd4Ex5jJ8xmP0DQwMlFmeaKqlb1tR4Td+cJZBP/gwE=;
 b=oIKVfdcvZ8PMkpxASQnDXkEYrmIILInitRoqDDMwdRbgUJ861yL5byl4m5Z6P/YQgXF/Lr50UbqRQcof+h8hgwfOSnd9IADTugnUe0Jmq8KtZEhyMA1DkNnRb9dqjB71suG4qcDKv3zl3b/SoWKDw+r0xkUKzcTNNVJk8ASCT9+ksVSu3AtJk+H6x7rZjvvzKon6GlrZ2Nm2O6QZc+2aULrr/QDIyCVrx1gmdYHboV5LOL9pdqbZxNaRpbozCNAIud/ijSMEhE5sl9v+RU/TNFoE7czG3KqtmLuC+Rs6wdj0hMc3GpVPOZPtcE0QVSJ+SN3eOu7G4UKUi9DIbDSp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fd4Ex5jJ8xmP0DQwMlFmeaKqlb1tR4Td+cJZBP/gwE=;
 b=OZ6J2zJStvRLtafm6xVpoBY6vXGq8X3MSLElJlZqow5K/htcQ0qZXO2bufP/gLm9HEBLmruNDQicp2u7+eWe0x6JOfjdO8oRo7/zv0JmtOicjD0CZnLog679u3ZQHbs0cK5NBx+RVgAKYPFZnYaFDVCy1vIBOerxXt9IvNGjHfE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:58:50 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:58:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 3/4] soc: imx: Add generic blk-ctl driver
Date:   Sat, 12 Jun 2021 21:31:33 +0800
Message-Id: <20210612133134.2738-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 12:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e6b865-6128-4948-37f2-08d92da1d2f3
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB728593BFDA23C387A43A3E65C9339@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nss2GOi9Qn4njyhc29LbP8z/nUbxQxfGL6p7aC80naX958uwASbAnHQNKz35GM4XmfnA05jSqrMfJXwFDZwEGsXkkXIxW+eme3smGEPQyPn0cS8/X/oB1YRma3nMCteK/SVuNB2aF7Uq8Rv4rGpjeEN2OEGLJPyD0KELRzZiadtsG3I3RDlRozLUhRO+bM8VxZHL5rlf5MjX2xcIA/2R+OXdZf3HSAJH3sKfyNeelpJ5+FQZRZAoLfPas11vt88YY0j3z5Ey1WjIdYM3SS4/RBWhennENFV6tXa/rRaxBcP9pdYUn6VimwnNs5xQElYoBIGqKzb2VOck9IZf2z2xOPfDgngQNfd4a13SyPYkVe7/kVXK+neyFns1I5yhbo/zrOQk2E5wqqZ3K4+Jr5sETxyQSkPuraKp5bCnidwJxZoABsHuu2LDMh+0FUZ2KeNH2tjXYMospbH+KXQ0Xur+noqMlcGDCUTjZRXIVNgGI6qGDMVI5oC8dOoucy9CeLL6jKzuL6OGJHd2LnpZpjopHJpA9AMc30/COBLkiHYwAWagaEYj72B4VMr7OnkT2wZwuUg8pa+lJRYtYu7qIcBqSqd+PU+FMWzCU9S/mnbWjxi7sWhOu9gsKoRQSCgIEOVv+CyM9TX6VUl9TS2ywqvHgGQMOZet7/OcorFGgXt5gyRpMt8YzG6BnWmmRx5/vtrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(6486002)(6666004)(8676002)(52116002)(2906002)(186003)(1076003)(16526019)(8936002)(26005)(4326008)(6506007)(66556008)(66476007)(66946007)(30864003)(6512007)(316002)(38350700002)(38100700002)(478600001)(2616005)(956004)(83380400001)(7416002)(5660300002)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgR+O3bpL5t0deZc5saAIXXI4e9boFIPrn38/jIBRqjIJ4JlHk35/Gocti1c?=
 =?us-ascii?Q?Km2eMPTAEm+ie1tLt3U+m/A1WUN0QrkYdXuToKACC/QY95/bC9VhLLFBghkJ?=
 =?us-ascii?Q?XmO0KHWMrLfau+s0AJFnp1tKyBcq/OfZIxFBxjK4Fq7FIdPbTu2VmHwKpTZ7?=
 =?us-ascii?Q?Ewo/etSa5Cm9z99P7II8P6EGpsHlcULlMPdxMSM2Jf2El1QL+9mzry9laemc?=
 =?us-ascii?Q?42lkRd2Xbw7FByfeK4PO6pcv29Ij8+I4npyEadR2VFQ4CjZSnt3p9+qZMUs4?=
 =?us-ascii?Q?IvadTvzwwd4xdH2r3bCJum1dmVsjo/QryESFJdkmLssOPFD+lpi4k+S8W9Z0?=
 =?us-ascii?Q?InYXN0VQEyTpYH8IRE1bVBTJKE4tdQ29Wy9PSa1+OVVQ6LuPs4d8z5oKjeSu?=
 =?us-ascii?Q?9Gz+hl1Wqhs061rdBKTNYUL4/jBti8V2rnVYPOhrB0xhpe+czOmzpZEBr6tD?=
 =?us-ascii?Q?UsDA729A5qWo4a+4kXApyDT19sTPTsVm/3kdOY1jFD96GebgB97BGj44CuS+?=
 =?us-ascii?Q?r/zZpKJw6ekaJSzjFTIJGcu2C+VUb7idb+OpzMAvQctRZdUgecFJizfnlwgE?=
 =?us-ascii?Q?wgUfo2cZIVxmE2ruQglecnQQmM5wYMex6JHn6JK4wXTkjrwb44Y2Tf/8CTqv?=
 =?us-ascii?Q?zuqC0yKdUaFhOz9PSsN8ZfyMn2smNNkaRy2c/O3pEkGxVu5ByEZY0YW/wKJr?=
 =?us-ascii?Q?l6sXvnmJfdNbjp6LgIBYjNkLSIznA+7uqHBZ4/nQM7WXa3nK9amV9JfKJMD7?=
 =?us-ascii?Q?QvZC4NJRvEkooMLn4g1FDwIQVyvGfIqzo3kgwM5OidXBsq9bfbM4XmV70IlR?=
 =?us-ascii?Q?+E5lgJujai5bF5lV/+JVAFoaiCagQgr1K41wVDy+8I4XqTLyUu+tBnlaweNO?=
 =?us-ascii?Q?ZAn6g4MzGL4rMwIGA/lR5/ONqs1osKqkqONNcJvdlbCP/YrbmABDU2yvbN6N?=
 =?us-ascii?Q?KZxIDEN7BgUWkXV02Srld3g2OjV67Nd0sTi/5KTg5ZQKo5wpVTRLvq83I+T2?=
 =?us-ascii?Q?TW/aWbSdikL5gTmrLtN/J7gDwmOa7OTjdp0gj2WgW+svubEyyuu/qxoOu7Ea?=
 =?us-ascii?Q?zWdVsqLEHppmUp5p1Wxd+WwJfBZQ0kcIQllQCL/YF6uBt/IOMcRQqcP3rBqI?=
 =?us-ascii?Q?mcrcwhuoe/RgFOc6NrxTWbNdPKnIW75GBpcYcfcIjmHHH2Er4S6xd3ms8WOJ?=
 =?us-ascii?Q?PT/PiSmoZ12yQ8RMYVVqscrfDqIICEJClCdcmb7i/CNpv68ugVsWqPUIyF+l?=
 =?us-ascii?Q?MrnuvmvT5RT/i6PYXjdvZu74cYZqjGCew+IalS5j6cwzGy903bJgL8s958QK?=
 =?us-ascii?Q?86dCfCsQYEvTPpMDmpGk5CtQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e6b865-6128-4948-37f2-08d92da1d2f3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 12:58:50.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LI+cPsoRaAybbWJNQEpRRLotxv8/akflCQY+y46RIvIHCp1qYiGH6paEGTbmas3Bv5MYN3xTHN/vneDbz0GtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
some GPRs.

The GPRs has some clock bits and reset bits, but here we take it
as virtual PDs, because of the clock and power domain A/B lock issue
when taking it as a clock controller.

For some bits, it might be good to also make it as a reset controller,
but to i.MX8MM, we not add that support for now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile  |   2 +-
 drivers/soc/imx/blk-ctl.c | 325 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  85 ++++++++++
 3 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 078dc918f4f3..d3d2b49a386c 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
-obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
+obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
new file mode 100644
index 000000000000..3464e4cf7fe6
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "blk-ctl.h"
+
+static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct imx_blk_ctl_domain, genpd);
+}
+
+static int imx_blk_ctl_enable_hsk(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_hw *hw = blk_ctl->dev_data->hw_hsk;
+	struct regmap *regmap = blk_ctl->regmap;
+	int ret;
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
+
+	/* Wait for handshake */
+	udelay(5);
+
+	return ret;
+}
+
+static int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
+{
+	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
+	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
+	struct regmap *regmap = blk_ctl->regmap;
+	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
+	int ret;
+
+	mutex_lock(&blk_ctl->lock);
+
+	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
+	if (ret) {
+		mutex_unlock(&blk_ctl->lock);
+		return ret;
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret) {
+			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");
+			goto disable_clk;
+		}
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
+		if (ret)
+			goto disable_clk;
+
+		/* Wait for reset propagate */
+		udelay(5);
+
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
+		if (ret)
+			goto disable_clk;
+	}
+
+	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
+
+disable_clk:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	mutex_unlock(&blk_ctl->lock);
+
+	return ret;
+}
+
+static int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
+{
+	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
+	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
+	struct regmap *regmap = blk_ctl->regmap;
+	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
+	int ret;
+
+	mutex_lock(&blk_ctl->lock);
+
+	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
+	if (ret) {
+		mutex_unlock(&blk_ctl->lock);
+		return ret;
+	}
+
+	if (!(hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)) {
+		ret = regmap_clear_bits(regmap, hw->offset, hw->mask);
+		if (ret)
+			goto disable_clk;
+
+		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+			ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
+			if (ret)
+				goto disable_clk;
+		}
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret)
+			dev_err(blk_ctl->dev, "Hankshake failed when power off\n");
+	}
+
+disable_clk:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	mutex_unlock(&blk_ctl->lock);
+
+	return ret;
+}
+
+static int imx_blk_ctl_probe(struct platform_device *pdev)
+{
+	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
+	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
+	struct generic_pm_domain *parent_genpd;
+	struct device *dev = &pdev->dev;
+	struct device *active_pd;
+	int ret;
+
+	pdev->dev.of_node = blk_ctl->dev->of_node;
+
+	if (domain->hw->active_pd_name) {
+		active_pd = dev_pm_domain_attach_by_name(dev, domain->hw->active_pd_name);
+		if (IS_ERR_OR_NULL(active_pd)) {
+			ret = PTR_ERR(active_pd) ? : -ENODATA;
+			pdev->dev.of_node = NULL;
+			return ret;
+		}
+
+		domain->active_pd = active_pd;
+	} else {
+		if (!blk_ctl->bus_domain) {
+			pdev->dev.of_node = NULL;
+			return -EPROBE_DEFER;
+		}
+	}
+
+	if (domain->hw->active_pd_name)
+		parent_genpd = pd_to_genpd(active_pd->pm_domain);
+	else
+		parent_genpd = blk_ctl->bus_domain;
+
+	if (pm_genpd_add_subdomain(parent_genpd, &domain->genpd)) {
+		dev_warn(dev, "failed to add subdomain: %s\n", domain->genpd.name);
+	} else {
+		mutex_lock(&blk_ctl->lock);
+		domain->hooked = true;
+		mutex_unlock(&blk_ctl->lock);
+	}
+
+	return 0;
+}
+
+static int imx_blk_ctl_remove(struct platform_device *pdev)
+{
+	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
+	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
+	struct generic_pm_domain *parent_genpd;
+	struct device *active_pd;
+
+	if (domain->hw->active_pd_name)
+		parent_genpd = pd_to_genpd(active_pd->pm_domain);
+	else
+		parent_genpd = blk_ctl->bus_domain;
+
+	pm_genpd_remove_subdomain(parent_genpd, &domain->genpd);
+
+	mutex_lock(&blk_ctl->lock);
+	domain->hooked = false;
+	mutex_unlock(&blk_ctl->lock);
+
+	if (domain->hw->active_pd_name)
+		dev_pm_domain_detach(domain->active_pd, false);
+
+	return 0;
+}
+
+static const struct platform_device_id imx_blk_ctl_id[] = {
+	{ "imx-vpumix-blk-ctl", },
+	{ "imx-dispmix-blk-ctl", },
+	{ },
+};
+
+static struct platform_driver imx_blk_ctl_driver = {
+	.driver = {
+		.name = "imx-blk-ctl",
+	},
+	.probe    = imx_blk_ctl_probe,
+	.remove   = imx_blk_ctl_remove,
+	.id_table = imx_blk_ctl_id,
+};
+builtin_platform_driver(imx_blk_ctl_driver)
+
+static struct generic_pm_domain *imx_blk_ctl_genpd_xlate(struct of_phandle_args *genpdspec,
+							 void *data)
+{
+	struct genpd_onecell_data *genpd_data = data;
+	unsigned int idx = genpdspec->args[0];
+	struct imx_blk_ctl_domain *domain;
+	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
+
+	if (genpdspec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (idx >= genpd_data->num_domains)
+		return ERR_PTR(-EINVAL);
+
+	if (!genpd_data->domains[idx])
+		return ERR_PTR(-ENOENT);
+
+	domain = to_imx_blk_ctl_pd(genpd_data->domains[idx]);
+
+	mutex_lock(&domain->blk_ctl->lock);
+	if (domain->hooked)
+		genpd = genpd_data->domains[idx];
+	mutex_unlock(&domain->blk_ctl->lock);
+
+	return genpd;
+}
+
+int imx_blk_ctl_register(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
+	int num = dev_data->pds_num;
+	struct imx_blk_ctl_domain *domain;
+	struct generic_pm_domain *genpd;
+	struct platform_device *pd_pdev;
+	int domain_index;
+	int i, ret;
+
+	blk_ctl->onecell_data.num_domains = num;
+	blk_ctl->onecell_data.xlate = imx_blk_ctl_genpd_xlate;
+	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num, sizeof(struct generic_pm_domain *),
+						     GFP_KERNEL);
+	if (!blk_ctl->onecell_data.domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		domain_index = dev_data->pds[i].id;
+		if (domain_index >= num) {
+			dev_warn(dev, "Domain index %d is out of bounds\n", domain_index);
+			continue;
+		}
+
+		domain = devm_kzalloc(dev, sizeof(struct imx_blk_ctl_domain), GFP_KERNEL);
+		if (!domain)
+			goto error;
+
+		pd_pdev = platform_device_alloc(dev_data->name, domain_index);
+		if (!pd_pdev) {
+			dev_err(dev, "Failed to allocate platform device\n");
+			goto error;
+		}
+
+		pd_pdev->dev.platform_data = domain;
+
+		domain->blk_ctl = blk_ctl;
+		domain->hw = &dev_data->pds[i];
+		domain->id = domain_index;
+		domain->genpd.name = dev_data->pds[i].name;
+		domain->genpd.power_off = imx_blk_ctl_power_off;
+		domain->genpd.power_on = imx_blk_ctl_power_on;
+		domain->dev = &pd_pdev->dev;
+		domain->hooked = false;
+
+		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		pd_pdev->dev.parent = dev;
+
+		if (domain->hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)
+			blk_ctl->bus_domain = &domain->genpd;
+
+		ret = platform_device_add(pd_pdev);
+		if (ret) {
+			platform_device_put(pd_pdev);
+			goto error;
+		}
+		blk_ctl->onecell_data.domains[i] = &domain->genpd;
+	}
+
+	return of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
+
+error:
+	for (; i >= 0; i--) {
+		genpd = blk_ctl->onecell_data.domains[i];
+		if (!genpd)
+			continue;
+		domain = to_imx_blk_ctl_pd(genpd);
+		if (domain->dev)
+			platform_device_put(to_platform_device(domain->dev));
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
+
+const struct dev_pm_ops imx_blk_ctl_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
new file mode 100644
index 000000000000..6780d00ec8c5
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_IMX_BLK_CTL_H
+#define __SOC_IMX_BLK_CTL_H
+
+enum imx_blk_ctl_pd_type {
+	BLK_CTL_PD,
+};
+
+struct imx_blk_ctl_hw {
+	int type;
+	char *name;
+	char *active_pd_name;
+	u32 offset;
+	u32 mask;
+	u32 flags;
+	u32 id;
+	u32 rst_offset;
+	u32 rst_mask;
+	u32 errata;
+};
+
+struct imx_blk_ctl_domain {
+	struct generic_pm_domain genpd;
+	struct device *active_pd;
+	struct imx_blk_ctl *blk_ctl;
+	struct imx_blk_ctl_hw *hw;
+	struct device *dev;
+	bool hooked;
+	u32 id;
+};
+
+struct imx_blk_ctl_dev_data {
+	struct regmap_config config;
+	struct imx_blk_ctl_hw *pds;
+	struct imx_blk_ctl_hw *hw_hsk;
+	u32 pds_num;
+	u32 max_num;
+	char *name;
+};
+
+struct imx_blk_ctl {
+	struct device *dev;
+	struct regmap *regmap;
+	struct genpd_onecell_data onecell_data;
+	const struct imx_blk_ctl_dev_data *dev_data;
+	struct clk_bulk_data *clks;
+	u32 num_clks;
+	struct generic_pm_domain *bus_domain;
+
+	struct mutex lock;
+};
+
+#define IMX_BLK_CTL(_type, _name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask,	\
+		    _flags, _errata)								\
+	{											\
+		.type = _type,									\
+		.name = _name,									\
+		.active_pd_name = _active_pd,							\
+		.id = _id,									\
+		.offset = _offset,								\
+		.mask = _mask,									\
+		.flags = _flags,								\
+		.rst_offset = _rst_offset,							\
+		.rst_mask = _rst_mask,								\
+		.errata = _errata,								\
+	}
+
+#define IMX_BLK_CTL_PD(_name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask, _flags)	\
+	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask, _rst_offset,		\
+		    _rst_mask, _flags, 0)
+
+#define IMX_BLK_CTL_PD_ERRATA(_name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask,	\
+			      _flags, _errata)							\
+	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask, _rst_offset,		\
+		    _rst_mask, _flags, _errata)
+
+int imx_blk_ctl_register(struct device *dev);
+
+#define IMX_BLK_CTL_PD_HANDSHAKE	BIT(0)
+#define IMX_BLK_CTL_PD_RESET		BIT(1)
+#define IMX_BLK_CTL_PD_BUS		BIT(2)
+
+const extern struct dev_pm_ops imx_blk_ctl_pm_ops;
+
+#endif
-- 
2.30.0

