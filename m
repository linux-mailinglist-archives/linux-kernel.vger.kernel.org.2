Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD14374E07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEFDpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:45:00 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:1473
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232084AbhEFDo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyKCHYVeKYAaEYDclaG8d+GyI+jUNLf7EzpRplPhIQS4MFppf9qqG9PZzKWmrCeCKUOpQfoBJzVMSElnE4Az0cV45vqXOLpGi5cC+/+f4lYM0UI0q2uFTfkmy8tZK2wcFZQ6cddw8AAxmHzlkv6RqqNNqBhXEc0HWFpCm1j4xlyDdudILIQE+/X5KqogS8vt6yiHwUy8/3H2LjgG+XO6MHbM8s2p9/rtIuFDo/lZdZd8yu6jayqdBhsXjgXegglmOyyItbPya3V7Bu2b/Zowt4EGMZyTDBQyqX65XXYfyCTTQtIBwI/kNKlEnVpz70lOX9J4New5AMf1pxYDmoVNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZCVMPYE8oIWzbSvqgWJQVakweFQccwNwDNRWjXXZ6M=;
 b=kY8anmHLdNY0k6Ig6Yl6wL5ENGy4kRi6gT+c6oOgWadRS51qk3cu3Ik8sJUwXXm9S9EESaxt4L3OUDdZghKuf2BSYxZzdbhS1QejU3/5QXyNTQc9q+3FVHiUe2cQxdkKLK9BdbF/MQic+qWOC1l5jLR0DM7dunO/rXs2AMfqSkeRNpTI96rb6SZ8pIoQjfLsUW0pliT+Du96lGKXTypu6TBgd0SEbvGNXcfSwJr0P/eUGawSdF/iKSajXYJ+oc2cDwdeNppWpigEikJjVDt0Qcyu6kfJWWKt8w3roSlPRA0ekwYn6X6tKcj9zG1J2LarDiiAcgi/JVCcjAwkDj1wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZCVMPYE8oIWzbSvqgWJQVakweFQccwNwDNRWjXXZ6M=;
 b=UPsp3i4sDGruASY+8jcjTt0EqaKepKXaCQglVcPiEZ+j3Zvfl8qPItDW0Tq/bDqAhFxGnYRnlxiZg1EqhagNaaHj2gS5XqDv7tx9uQIr8vDE3NgYtxoDrrMDMk37QCxatCz+IP0HsWRxHv680d16xIq3lgq5QQzIO+UdnfrlHhY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (20.182.191.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Thu, 6 May 2021 03:43:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 03:43:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] soc: imx: Add generic blk-ctl driver
Date:   Thu,  6 May 2021 12:15:54 +0800
Message-Id: <20210506041555.10719-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506041555.10719-1-peng.fan@oss.nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 03:43:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7a18a3-f897-42e1-7b58-08d910412e79
X-MS-TrafficTypeDiagnostic: DBBPR04MB7979:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7979BAFD5E53D95A49C48E35C9589@DBBPR04MB7979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aI7YN/HPEbg9HY53UR6nfwdZH7njgOvyazN+0jpylwycSE2ySEhDHrIa6k6Y4rvZ0J9hbGjg0YSiFGnNWanDO1d03XGkXvHbXZsTZibIDPPSQ4UTw0SN6XhPzNYuKgJlRKWYIE+7uTD84T9l4PnuP8UZVhdGK6AgMJQZF4X3DjEx6+5sEo/34exxiSzPWoDESkHt9+ek6KJNyT/upQsNThfh8klXvil13aGR3rldDEO5MU6eF0UK+dxes/Dvp89y/3sJ3vCTD/y1qksjFiV5G+U+fIFzDePOsxOTakzLfw6IEZLuvmXn1r08/8CM+A2CzCoBD6Gj34xpVSJm8LJD083XYAo5wknF0suS1SIGn05M2OaNh+3/VuRBmioxLQ33qONrVnk+arMjuQ7ubUYemU3sWv9MRxBy9DY7BGtBeiXT4xZFnm+XFKPyAf1tFIhfEmLLX18vXdyeALFn8z/OIyM1iU0ns4KJVUGjqa9OaKzA/dJcSkvlySCqeD19yfYRi38szmNbwhd9fvkVdbo/T9AadeqKPW3E0xeArDuJY6g4WHacRwOhy+ziOEgEv7VGekouK/3lYrLuiWTC74WMIA24daSaDBxCyyaiw0aHpzNpNJ6Y0o6kiSuJA3HIo3hV4O7H14ZuS3cfABbcf2z5+72ywZO71um5RGttGexEOMAzaAG8Cb++Bz1GTDObHmFD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(4326008)(2906002)(316002)(8676002)(6512007)(956004)(2616005)(5660300002)(6506007)(66946007)(8936002)(66476007)(66556008)(83380400001)(52116002)(7416002)(478600001)(26005)(186003)(30864003)(16526019)(1076003)(6486002)(86362001)(38100700002)(38350700002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EbDfpAegSQz/lHBlmsUKTTKNdqADqzQLrMIGuIX9CQdGF9ZgtUcZEzab9GK2?=
 =?us-ascii?Q?7yH0tFx8Z2x9lNaO0povktNNtDg+CfQTapWf5dgsg5rjgEZfrMpzUSAt6a9Y?=
 =?us-ascii?Q?xJjfAxb3LdryzSWvoeC/lHzdzF9KFFa8C0Hyr8NvcCY8IJ2+j4OaO4l3yozw?=
 =?us-ascii?Q?OL3tdI+OZKKfN1MIwjZn2GP2XC017Yujj7ffUhl+3lQEUqDzhTDxLc3euF/k?=
 =?us-ascii?Q?rfrTD09WyGuMTgsdUFGG/7FgCcjc3vUqpKcHT3UdwbJR1aHYZu1YHWvDmEY7?=
 =?us-ascii?Q?DbqKVxZ6LlWzyKbII1wW0hrQyF3akvY/e8H3loNsaBf4vYb7TejRfeHNnkQm?=
 =?us-ascii?Q?gbANBeZoeyaJBUU7Y3EfP/kg+Vw5c6pnlkLjK+EOWWgMu/TSZM0ZMxVDm29+?=
 =?us-ascii?Q?b3U79ZfjBMgrOr6HuqDp45rldG5XibaJtQ3kYltJuMxMTcjBapwAqNWBkfEn?=
 =?us-ascii?Q?3+XvZJqGlZMECpPS4tRnKLuH8QP/dxXcsx5tJQB/Q6gLZJbrOQiG+aSxVX/U?=
 =?us-ascii?Q?LmRU//8yay8qo6gWsM1bRFAQY5JFIaKQI5bbCD2x0wYzaYhoCCBHuwD2/O30?=
 =?us-ascii?Q?boDGrxrQ9UeGmSua2ZnIgfSoeNQUwVPriX95cLe4upd+Vops46hhLVLVvH8p?=
 =?us-ascii?Q?L/C+QIk5fq3HrjiIwn34ZI0Dy2g6d7zaxJXJ9lX22EmQy5LEOepRfsruuoCq?=
 =?us-ascii?Q?7dd0Ujrwu4DAMMFEc2MImmFJw2OgcmzpklSI4oZdm0T7loil/epydufOhY9e?=
 =?us-ascii?Q?pGy3aERyWdxgCmZYHoofFFi6JBFT+5no/h0C2jYJxQ9USX9lrZchk+BYQngI?=
 =?us-ascii?Q?lv8jwivE2TS8NJNptSY5ZEBT65UYZIq7plwlIoshONFaZzFJnIo8Cw7DSuWc?=
 =?us-ascii?Q?3SVSPW64khDbOxYgvxkb+ErkbET2cw4Xc4v8AHhC3oTOogNigFz65Pe/vf6c?=
 =?us-ascii?Q?Z2KQLFSxG5ZK4CcLzJFx5EmbU3CcZKZpsvBF9kDbDL6SCE4SLNCCjP3BpzVg?=
 =?us-ascii?Q?Yw17xN1vnEER+UlVnwqUc7eRKpb4X7WxvsnvUXry/mZLH8sQFdk3zLWsA9fy?=
 =?us-ascii?Q?9DZvfpkqwsVomhMNKI88lCp+i6/dX39pCci2rH0dU+nBiQNSMeQbNqqi9IHW?=
 =?us-ascii?Q?mGeo8OmADUx4l2IGn+kTSEGPRYKdywCZwZg8w63yFC3aLjelLVP7x8w3BPuB?=
 =?us-ascii?Q?Ct9Mge0HIuSJxjFw0LKIqwGKnHhQZfWnaZPHHPzdZJIhhry0z1UQ0wpqMZPT?=
 =?us-ascii?Q?Y2N33UG7GqEvUyuv3tArNZlvHuyvLZrkeTcjBT3vx63khFkfD8SCCLebnMFQ?=
 =?us-ascii?Q?oufz31wTDjXPASlFS6koNZ+L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7a18a3-f897-42e1-7b58-08d910412e79
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:43:59.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXARAUAr+gIYfooQAkLR1Vh/JMJnysYx1lzLXJ5uGxt5OGKjqWsC3Rm69hxziEP9NSdbYMLCAKTV/eVpAFfaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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
index 000000000000..e184d862b26b
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
+			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");
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

