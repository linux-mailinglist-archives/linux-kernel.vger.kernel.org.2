Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76C5377AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEJDgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:36:08 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:43461
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhEJDgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7HpX6dA+NMjWTYVFMyUicKiSNuP7fVsZ8Ho4J5bsXuBkTFamES+9Ovl/wFUoIaeU5cU8LQvadL6gbgLh/ymUqCKZ6gEgKoQ9WbPtFUZeKLXkhby08ZYqupZox1iwOQbHOCB1iE75rOwsoA6TiOOxl3mfZTvXugYoND+K95XjU49+m0oQcACwQtbud0tXziYTS6YZ1kGL0kp5gPKrA2lC8Dbp+leG0cIuATXzE7cvQVme8TDTKdEHxkdMpmQ/kw98mT9U+U4O5uq7DSkZLbHIVhoHNlwPpdGR1kLMdldunEkpTQ1+MPVPPN4AhLsI8TGkqwqnOPE+4f7MVfVxDpQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/irro7zteb13m3qbNQgrsSrPth+BvpyO49l2di226LI=;
 b=gZo3/e5ruYZ1279kq369DIeaZOmuIuWnJ2LtFHRjo94SsBN9ruQjHCk9gg45EGFJZ9v9Y+FkLK3wj5Q6whPi8awqQuKJ/92Y1OVlRVBoc6Y1aiG0YaBTE1mgZPSqaL7suDkDjJArXpdapy1NnVgyftana8gIonRm+3WQnr9lzvx6e+y55sSqzoSZsE8HV2cLkQ9ZXmak7G9qmYILjWHbGc7mbMBM2wIqC0KU8rbIxGkqWpLC/4gL0k01gwGAViM4LHjyiTi0fHydu8H3yavmBcipvfWmLlXkybNuIV1sqgYfSXsXArrdP9XcH9TMvLNHxeQXeTYmVcRaQ+8Qt/T9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/irro7zteb13m3qbNQgrsSrPth+BvpyO49l2di226LI=;
 b=gIG8U7wIjsTDQaRTYNMWIOuoAXaPUU7rKRC9al6RLXK4WYBbEQgsaH4fZLDSOuC8WYL+seHHsC0bslKYCw+sBjKE/OAGPFQVDP/a2OOb4n/ajKlRaolhAJq4XtlU/EDNQR6NV7efQVsUmdAsxyryzNrI2O/OMhDDQAc8DvX22zY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 03:34:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:34:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/4] soc: imx: Add generic blk-ctl driver
Date:   Mon, 10 May 2021 12:07:03 +0800
Message-Id: <20210510040704.14997-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 03:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae48098-e073-4e23-3e64-08d913649671
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB793005C315915694581BFFFEC9549@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM6EbonLLTu9TvCxt+pq584OUQ4b4e2oouyFCyTjM4uCUSkPJlyilEydJCxcjvsNQ8DchNvlYStcuUYZ2DH/YwUKh50F57z1u1A66/kwADEds4XYUmKg4vgkEHVlkBV9CtZ4JhvHSRIWvLjWvty+ucHJ8NlYigT4zbXgiXDITTPo1O8b27s5LhG4mBAKjGLDRsnEq3VfGxED6t51YpKMsf9asR6/48xStpi4DNrtfmiyUy3U0KZb2TRpc9EjWBl83GqZr22OGg8qYcMEyvyFip8Z0N6yS2SSO6AmbXo6rrxfWPQ/HiKrb9uA7PRtKXLA/056DYnPLCiMIFu5AQzWJCeG0m6eYlCcmGo9+QMaKlt9nxcDB4v178HU+aRFdVS/b/eqgRZBxdSf2MYzkszR2unIlHtwkvJA4hNkD3prfZrtnTqXNvEUroE+ac1J96B5xNEhmE8aXnfwUfD85VbVoPx0rUmWlnKMU8IMgiUQOalpTfMLAJwPs5/OEvHJTjvurrvKQNLNz/VbJyGe6UdeviJwUm/fCjnLsAJiFfaOnBuemizJbkTIXj9Qz4husmbuI3wm6wKQLqHVQ3Tut9dY075P/eEBiOxJIlWG0oPC2WtL9B5FQ5GncL25A0THpFg6y7emDR9zRJ85B8E9ZDFS1nuSNi68bUZ5mQ4fUJJYNv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(38350700002)(38100700002)(956004)(2906002)(6486002)(66476007)(4326008)(316002)(66556008)(66946007)(8676002)(2616005)(7416002)(86362001)(52116002)(186003)(83380400001)(1076003)(5660300002)(16526019)(8936002)(6506007)(6666004)(26005)(6512007)(30864003)(478600001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gXS/XPNN0kt66ccNDpSUYDa1/MjGFX81bP4i0chpSAXhxCOzF7lCJ0nLn7rr?=
 =?us-ascii?Q?WGnoxFLuAlRhSQ3NAE+k76/SN/WBwPtZsbepnqed7JPWicNqDjdL1tZFJN4P?=
 =?us-ascii?Q?GHKFB3dBN7ha3egXV0dubIzZH5Vud8P6pnNDYZzSldHhtnVKz8kNbULbnld8?=
 =?us-ascii?Q?uiJvnHsUwswQ2Z8xpM7jCn4eGllPolL7UxxI1DpEgco/ENNRVnkIPwXHYpEo?=
 =?us-ascii?Q?GcK4Q+BVkkvHBrhm3NMHYZ4LcTg5BGbALOTQ1olg0gvIANkwuKorrPx6ydJc?=
 =?us-ascii?Q?IBPJaEVecdfNOkSaO1QNrq9Z+9vIaBzx+vUDQ/tAEAYNhrDoDp3Y+H+Pmj8Q?=
 =?us-ascii?Q?avja3HWFr2uWVjy9ECqpq8En7raQAaZtzO3lZNYU5HwDflFlAxefrwiOBrIs?=
 =?us-ascii?Q?6zaBicaSLDIGcoSeb9P4gZGhkV9Q8UboaguI+jHBXczPpaH78pYR3fqMSk2t?=
 =?us-ascii?Q?YKt6zQRqArgMoh2Ci3faaecgpJgyGMmvT0kJPLr+n2a5L4wBvSbXEqLRQm9O?=
 =?us-ascii?Q?3xzOCw145C6n9AcEzLpoJEaNGMqc5cuKw9IXCDYFZWAiRPpoBDqmGUs8VHaw?=
 =?us-ascii?Q?j3EjeeBK4LEkw43GKiaTnkG28icldBQi/nD6XqkY7rj9GYeLorT7K/H0LJL6?=
 =?us-ascii?Q?9HwUpJgftr8vpjPHCUnUKicUSiFMKgiXZdfPQSV1F6PwEzhvHd1YmNh9U+E6?=
 =?us-ascii?Q?KsZVFP9IPHDyc2nSJwmZFeNsdPtzuhsOG6V4jUHwqGeATN6kR6HqWyJ2gU1c?=
 =?us-ascii?Q?pE9/YsL30NkZL2Nl51gw8h4F3P/rwSc5ej7HF+0k5BVUhu+hkJAEJVOyEJre?=
 =?us-ascii?Q?feqPg8ViOMkTWULmkX5PjwQ8ecAHUxcm9b8zZgQIGP/nlbsYnDSPl6AFLH4s?=
 =?us-ascii?Q?934wfGvbUGDASUQuLKj4umrW/tP4ttKTlko1cMA7Za2vw1nIg8/ZKGy9ytXO?=
 =?us-ascii?Q?CYJK0/VluRZeTdVbg5Z4YTPDYzObqj4Nc0YQqHc+Q7kHgETJKUta41bvyd41?=
 =?us-ascii?Q?atZBajqjivopnpEVPWo4Evx75o0u7VIx83I9TztsLinf0By3bfJI6fnCDl6P?=
 =?us-ascii?Q?Ew9yRNNJswn9Oymo/xHfKdkfcaiTFWpRqolmY0aLL6/mvSBragF2TzR8lUcU?=
 =?us-ascii?Q?isNYz2bRyJ7lVh3f3o+R19tYdbI5tbTfVu1awCMNW1FjL6opbEiyDKF3ymmW?=
 =?us-ascii?Q?vGpdX8YitOu8gIypg1X7jEqjFtIgx/gsTTKk6WWb28+haizR2L5zRjvZe8th?=
 =?us-ascii?Q?lqxFPc5m2PagJiKbg9ESRbg2tzNmiO2Qg/DWJKXUTtcpHRq2aSRJQkE8brQb?=
 =?us-ascii?Q?JsLeOgJ3EgG+LgOg1nHsx7aR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae48098-e073-4e23-3e64-08d913649671
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:34:59.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh0t2WAQ+VuGTk7LxrookBgUfHktLSQu8dTv6B0+O1OB4rqtO+YbjRtiUyLcKaVDKHqhYLLfniugGmy8/XdwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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
 drivers/soc/imx/blk-ctl.c | 307 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  77 ++++++++++
 3 files changed, 385 insertions(+), 1 deletion(-)
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
index 000000000000..36556e8015bb
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,307 @@
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
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/pm_domain.h>
+#include <linux/reset-controller.h>
+
+#include "blk-ctl.h"
+
+static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct imx_blk_ctl_domain, pd);
+}
+
+static int imx_blk_ctl_enable_hsk(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->hw_hsk;
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
+int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
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
+	ret = regmap_clear_bits(regmap, hw->offset, hw->mask);
+	if (ret)
+		goto hsk_fail;
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
+		if (ret)
+			goto hsk_fail;
+	}
+
+	blk_ctl->power_count--;
+
+	if (!blk_ctl->power_count) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret)
+			dev_err(blk_ctl->dev, "Handshake failed when power off\n");
+	}
+
+hsk_fail:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	mutex_unlock(&blk_ctl->lock);
+
+	return ret;
+}
+
+int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
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
+	if (!blk_ctl->power_count) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret) {
+			dev_err(blk_ctl->dev, "Handshake failed when power on\n");
+			goto disable_clk;
+		}
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
+		if (ret)
+			goto disable_clk;
+	}
+
+	/* Wait for reset propagate */
+	udelay(5);
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
+		if (ret)
+			goto disable_clk;
+	}
+
+	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
+	if (ret)
+		goto disable_clk;
+
+	blk_ctl->power_count++;
+
+disable_clk:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	mutex_unlock(&blk_ctl->lock);
+
+	return ret;
+}
+
+static int imx_blk_ctl_attach_pd(struct device *dev, struct device **devs, char **pd_names,
+				 u32 num_pds)
+{
+	int i, ret;
+
+	if (!pd_names)
+		return -EINVAL;
+
+	if (dev->pm_domain) {
+		devs[0] = dev;
+		pm_runtime_enable(dev);
+		return 0;
+	}
+
+	for (i = 0; i < num_pds; i++) {
+		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
+		if (IS_ERR_OR_NULL(devs[i])) {
+			ret = PTR_ERR(devs[i]) ? : -ENODATA;
+			goto detach_pm;
+		}
+	}
+
+	return 0;
+
+detach_pm:
+	for (i--; i >= 0; i--)
+		dev_pm_domain_detach(devs[i], false);
+
+	return ret;
+}
+
+static int imx_blk_ctl_register_pd(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
+	int num = dev_data->pds_num;
+	struct imx_blk_ctl_domain *domain;
+	int i, ret;
+
+	blk_ctl->onecell_data.num_domains = num;
+	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num,
+						     sizeof(struct generic_pm_domain *),
+						     GFP_KERNEL);
+
+	if (!blk_ctl->onecell_data.domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
+		if (!domain) {
+			ret = -ENOMEM;
+			goto remove_genpd;
+		}
+		domain->pd.name = dev_data->pds[i].name;
+		domain->pd.power_off = imx_blk_ctl_power_off;
+		domain->pd.power_on = imx_blk_ctl_power_on;
+		domain->blk_ctl = blk_ctl;
+		domain->id = i;
+
+		ret = pm_genpd_init(&domain->pd, NULL, true);
+		if (ret)
+			goto remove_genpd;
+
+		blk_ctl->onecell_data.domains[i] = &domain->pd;
+	}
+
+	return 0;
+
+remove_genpd:
+	for (i = i - 1; i >= 0; i--)
+		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
+
+	return ret;
+}
+
+static int imx_blk_ctl_hook_pd(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
+	const struct imx_blk_ctl_hw *pds = dev_data->pds;
+	int num_active_pd = dev_data->num_active_pd;
+	int num = dev_data->pds_num;
+	struct generic_pm_domain *genpd, *child_genpd;
+	int ret;
+	int i, j;
+
+	blk_ctl->active_pds = devm_kcalloc(dev, num_active_pd, sizeof(struct device *), GFP_KERNEL);
+	if (!blk_ctl->active_pds)
+		return -ENOMEM;
+
+	ret = imx_blk_ctl_attach_pd(dev, blk_ctl->active_pds, dev_data->active_pd_names,
+				    num_active_pd);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to attach active pd: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		for (j = 0; j < num_active_pd; j++) {
+			genpd = pd_to_genpd(blk_ctl->active_pds[j]->pm_domain);
+			if (!strcmp(genpd->name, pds[i].parent_name))
+				break;
+		}
+
+		child_genpd = blk_ctl->onecell_data.domains[i];
+		if (pm_genpd_add_subdomain(genpd, child_genpd))
+			pr_warn("failed to add subdomain: %s\n", child_genpd->name);
+	}
+
+	return 0;
+}
+
+int imx_blk_ctl_register(struct device *dev)
+{
+	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
+	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
+	int num = dev_data->pds_num;
+	int i, ret;
+
+	if (!blk_ctl)
+		return -ENODEV;
+
+	ret = imx_blk_ctl_register_pd(dev);
+	if (ret)
+		return ret;
+
+	ret = imx_blk_ctl_hook_pd(dev);
+	if (ret)
+		goto unregister_pd;
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
+	if (ret)
+		goto detach_pd;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	pm_runtime_put(dev);
+
+	return 0;
+
+detach_pd:
+	for (i = blk_ctl->dev_data->num_active_pd; i >= 0; i--)
+		dev_pm_domain_detach(blk_ctl->active_pds[i], false);
+unregister_pd:
+	for (i = num - 1; i >= 0; i--)
+		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
+
+	if (dev->pm_domain)
+		pm_runtime_disable(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
+
+const struct dev_pm_ops imx_blk_ctl_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			   pm_runtime_force_resume)
+};
+EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
new file mode 100644
index 000000000000..7a950ea9fb85
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.h
@@ -0,0 +1,77 @@
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
+	char *parent_name;
+	u32 offset;
+	u32 mask;
+	u32 flags;
+	u32 id;
+	u32 rst_offset;
+	u32 rst_mask;
+};
+
+struct imx_blk_ctl_domain {
+	struct generic_pm_domain pd;
+	struct imx_blk_ctl *blk_ctl;
+	u32 id;
+};
+
+struct imx_blk_ctl_dev_data {
+	struct regmap_config config;
+	struct imx_blk_ctl_hw *pds;
+	struct imx_blk_ctl_hw hw_hsk;
+	u32 pds_num;
+	char **active_pd_names;
+	u32 num_active_pd;
+};
+
+struct imx_blk_ctl {
+	struct device *dev;
+	struct regmap *regmap;
+	struct device **active_pds;
+	u32 pds_num;
+	u32 active_pd_count;
+	struct genpd_onecell_data onecell_data;
+	const struct imx_blk_ctl_dev_data *dev_data;
+	struct clk_bulk_data *clks;
+	u32 num_clks;
+
+	struct mutex lock;
+	int power_count;
+};
+
+#define IMX_BLK_CTL(_type, _name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask,	\
+		    _flags)								\
+	{										\
+		.type = _type,								\
+		.name = _name,								\
+		.parent_name = _parent_name,						\
+		.id = _id,								\
+		.offset = _offset,							\
+		.mask = _mask,								\
+		.flags = _flags,							\
+		.rst_offset = _rst_offset,						\
+		.rst_mask = _rst_mask,							\
+	}
+
+#define IMX_BLK_CTL_PD(_name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask, _flags) \
+	IMX_BLK_CTL(BLK_CTL_PD, _name, _parent_name, _id, _offset, _mask, _rst_offset,		\
+		    _rst_mask, _flags)
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

