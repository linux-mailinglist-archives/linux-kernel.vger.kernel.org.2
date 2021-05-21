Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410FA38C4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEUKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:31:19 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:9483
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233926AbhEUK3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UASZg2NBGnBA++3TagMwmVquqhYfjitj1xUtxhHcivvpjNu3RaQlWANoN9BDZ19u8+/mdzuQ3MuXXlSJiey+DvNk5Cnoefe/v8yUmOhzP+R3ebU4i6HhdCoN7Z6LB1m4TPq+OivBqsCL8PCT3tOZIscE7OUr8ETIj6dXcMtDcK3dKuzW5jJpWbRSw9aev5z3PSN83ijYNv/D1HMwGrmajnaoapHcX94vrM30To6emsmf2i1KCelarYhiF9T9qTgyJAkFl+h1YtJLuJIdDUOxXFe0l3SDnSRSzRFfNC1k+wW6bXpZi4hqLYv2P7ZfOTeCt0hnybQsr48OQcdgOKmmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZsWnY3TezvfbLH4aC9Y4cb+Zf1RCoEJxJEx8A03Lhg=;
 b=eD01xROMuG55W4HatusWe6ahF2Se58ZIiAa1TowF3FqGd7Hu4DdoIFGpOJyvtPK6OXL8EiFZ8eOo1bWPUU5qr6aLopoYSj6kE/yFVsC8RrK2kA3JLwwdkXbunVgwDSLZIA7Tk2H+f2dG/iAbX3Dp9kDNTblwSBIf4L0+3iZaMgm9PPNoMi+9oFcwQAG2qKJHf+64j0RkiSQ2Da6X24wfX80pbEZh/K0y3uK/G+vEbrAkt3cYygm5H48/0su4p1QKxMS4dTu+88b04psD5ONkkQThb1uK3DCGs2dT4iiAFn8cv5czL9++DNBJVIoy3vJGkhPem3xs94cBcmHWufHOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZsWnY3TezvfbLH4aC9Y4cb+Zf1RCoEJxJEx8A03Lhg=;
 b=TBhzF4OmQIbRLlZW14x+RzE2RFoMplDQMryVJaq4QHP/5Kgr/Ob8bXSFb4pVxuh92MKY4qTSc6FN6urV2HBSegZCSmmYaSl2MnUBMdxczrPxpJW0V2j+GnGAs0c7ipaNzs5r7Zzx/mPiJv0AYks0csPmosSnFigtA7hgHYUSiF4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 21 May
 2021 10:27:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 10:27:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/4] soc: imx: Add generic blk-ctl driver
Date:   Fri, 21 May 2021 18:59:18 +0800
Message-Id: <20210521105919.20167-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 10:27:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83db2226-2631-43bc-79f8-08d91c4307df
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4636A8646C40CE1EA99CCFC8C9299@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbxsMjzSTdzLGcPjlwbLHMMv04OcMAyLpuugS+5x4ClNej04V3KUiPWg8DjqiYwxE0+jbrDE5+VzTYzdIpmOythoSGr5nfQQ+FckDVeAwHhqPl5jEhQ2aKLn4U00KERFSChmvm9OLql5f/yds/eG0q0C4pvBFC3G1qZ0JdrRJsGjS3gk+nzTCVM9RGrrtEoltlMny8h+au95Qtgjmd8yN4qAAbaD2VbE4CKfmAfwfOaqyIlOW+ZO00sqJ5s3li4Xj2PHEv7U2Q/dkQ1OI7AI5UzWMYlD6hJDdeH2edUdHBUrC600Cfk56Ydj0xPgeWV0tF4qAMxmgSmrkaCR6SzPS8XsI9yTmbd2A3nXNDF23QR5UM9TbdVYnjoRo8sIIDXHkn6KqBraNETVjqX4wxQCZNy7uTVhnGwO8pU9ap2d6A51+/tH9RL3uQnjVTXxuDuFempgVj1KbfmzpAb5tSXLpGqrvdgFVS9imZaZvbKDEzL3+/YTSeTUdFSZ9D04qHUlohPj84YGZyZtIkivUhuydpHPZXxuUfmT5fwLQqrj8R6cMiC6fnkZGt7752lZqcWn3K8AuMQnW0MQqXqUxxd8lvYhSahtBda2jyyjgvoUOc12CBw/rY3psb7GgD2vjNKHcRh8xorWWdjU2OnbuXgMIfKcdRH/ddMa7oyCwclKTfsQkmeYxZESZEY3b484hAV/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(1076003)(6486002)(4326008)(956004)(6506007)(478600001)(186003)(6512007)(30864003)(5660300002)(2616005)(52116002)(8676002)(8936002)(86362001)(7416002)(66556008)(26005)(38100700002)(66476007)(83380400001)(6666004)(2906002)(316002)(66946007)(38350700002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2dHJJDwa6xkhdBSzMvVjZgSYDue3QWs4H6Ys8iqOwepMG11ZkgeNeUwIhyFV?=
 =?us-ascii?Q?xdS6TPUl5yp6sMq9yVpF36dAfGkWd4qVVin5+ayBqO9Gjz8dEc0nK//SvkR/?=
 =?us-ascii?Q?ub9h8NpuE9J/EWKOA7ELckhiAJgytJy++qaRWq25Nr9QEB0aDW06e6Gz50yA?=
 =?us-ascii?Q?x0NK8RWPOvCmp/ruR07VGgoz+FnDO3MMD6WQURrMtE0Gy5UQPs06sWjYmCUg?=
 =?us-ascii?Q?67j4GMYvbUaCxgh16fcelvN3Ai640qrp6MGWXlA70JIUzR3UH1o2rckmNXiN?=
 =?us-ascii?Q?gp9gkn9Mn+Im7OjjXINOrspEjPq7X6V5Q8AiZj2OE8ZfP2x/CSS+duH7g9u+?=
 =?us-ascii?Q?wfpqm3RRtQDEFwCvUN5XcRc8b0VLcUzILvbx3ok5Nwc+yIfZrS+OfkZw46gk?=
 =?us-ascii?Q?QmctW/VvD1i7S+E9PKi0UEU/D74r4IxP53/CFRmsSULWd+VskF+wcbDOFk4C?=
 =?us-ascii?Q?RspQTSYjY4XTj1bR4IrcCYrkMCmFr6vBg6g979dhfCKmPf68X0+MLTOk/dM+?=
 =?us-ascii?Q?oyzWmRMardgw3NqG7ZHYRr0k/oRwvwApa7aOp35VOvV9b/kzVn4rwpwaWLKG?=
 =?us-ascii?Q?GMrpjEgRkSOnKfUebvgprcsJCAmQfLhV5LAQj4oA0B2VQXhCxtMwgc0ezdGi?=
 =?us-ascii?Q?Gv9eSUymPBCil0b2G088Q+xxpowKeMLeAiigx6+usQSliQJG0uQq/pYft42V?=
 =?us-ascii?Q?kD+AEve8hIgHw40FkNdjx8Xe/hwpU1FyJW3z4eFoeUVm0T0sRSEovRvz9FfS?=
 =?us-ascii?Q?BfrwoCIVWX5CmIlkHKvwrUZCr97VvRe2OgU2ZEmO2+JTavUBAe2C66yrkq37?=
 =?us-ascii?Q?KNcdi2kgB1RxeoeY/srlxGtLawRM9n7OW1IYXGUYfvzb7mNHkRDAC5Mi9kAE?=
 =?us-ascii?Q?qN1Q5rkSe2e1yfMZIbv+l5qtE1OeiHn6k/IdM5cN1U0TyvvZQWbLD/6S0/on?=
 =?us-ascii?Q?CZ0HqEbZ+IxXVRtjfLdjMOcaVauAO2AAghQUi5WvSTGAz/+uIOF6nBbfisBp?=
 =?us-ascii?Q?wfWA8za7iOnA2X6uqva0jfDZnAQKGu/y2BXPNGT3DR2DLjFx4M6M5qUj+u74?=
 =?us-ascii?Q?cispsGTrPI4Kq31wKAUpQoF1C2iFcEsV/NpbMPMemApTDuYvZZc0kGqPh0pc?=
 =?us-ascii?Q?r7SOhXRrV9zhqxdgCmygR8qr83OmMb9sxqKu0JRQAX1U9WnFBph+VMJtfpY1?=
 =?us-ascii?Q?ZsN48LWm4s1vIZzjyk4PA0Oju48rsl497sriHiDwDIoZHehZ3qaogXhX6lqd?=
 =?us-ascii?Q?gLupaWOnDY22g3rrWlCZGrTUVTtheA7rWd1+PSvvg3RVMAsbj9tzzQh+JAGX?=
 =?us-ascii?Q?w3m7mbqxf5osGxoxN7i+Z/BH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83db2226-2631-43bc-79f8-08d91c4307df
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 10:27:27.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e89lRrf4Og/bFLQkrPrVqRtvoR9fBh/D+uMtDutsLO/YdTZ99zNJ1jvybW8Eu5uE41r/nKJDO1BWTPQnuz/Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
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
 drivers/soc/imx/blk-ctl.c | 311 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  85 +++++++++++
 3 files changed, 397 insertions(+), 1 deletion(-)
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
index 000000000000..1025415eef42
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
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
+	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret)
+			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");
+
+		goto disable_clk;
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
+disable_clk:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	mutex_unlock(&blk_ctl->lock);
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
+	if (!(hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)) {
+		ret = regmap_clear_bits(regmap, hw->offset, hw->mask);
+		if (ret)
+			goto hsk_fail;
+
+		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
+			ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
+			if (ret)
+				goto hsk_fail;
+		}
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret)
+			dev_err(blk_ctl->dev, "Hankshake failed when power off\n");
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
+static int imx_blk_ctl_probe(struct platform_device *pdev)
+{
+	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
+	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
+	struct generic_pm_domain *parent_genpd;
+	struct device *dev = &pdev->dev;
+	struct device *active_pd;
+	int ret;
+
+	if (domain->hw->active_pd_name) {
+		active_pd = dev_pm_domain_attach_by_name(dev, domain->hw->active_pd_name);
+		if (IS_ERR_OR_NULL(active_pd)) {
+			ret = PTR_ERR(active_pd) ? : -ENODATA;
+			return ret;
+		}
+		domain->active_pd = active_pd;
+	} else {
+		if (!blk_ctl->bus_domain)
+			return -EPROBE_DEFER;
+	}
+
+	if (domain->hw->active_pd_name)
+		parent_genpd = pd_to_genpd(active_pd->pm_domain);
+	else
+		parent_genpd = blk_ctl->bus_domain;
+
+	if (pm_genpd_add_subdomain(parent_genpd, &domain->genpd)) {
+		pr_warn("failed to add subdomain: %s\n", domain->genpd.name);
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
+	struct generic_pm_domain *genpd = ERR_PTR(-EINVAL);
+
+	if (genpdspec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (idx >= genpd_data->num_domains) {
+		pr_err("%s: invalid domain index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!genpd_data->domains[idx])
+		return ERR_PTR(-ENOENT);
+
+	domain = to_imx_blk_ctl_pd(genpd_data->domains[idx]);
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
+		pd_pdev->dev.of_node = dev->of_node;
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
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			   pm_runtime_force_resume)
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

