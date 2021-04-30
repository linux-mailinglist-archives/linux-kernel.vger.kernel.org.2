Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76336F53B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhD3E47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:56:59 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:36610
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230263AbhD3E4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O60/GXJv3qB6wFgZUruVhuM6PYaPLYZ+b9RW8Uk0d+SpxVXpInPT70IU+dGYthoYHhRuguOWY4VtwlCo3xPX5+BmuGa48gY+4nceogIJcsntBuJu/wZIpkR6/rhoz4XHD+NeC5urpMFkoneDGl0onTx5HnBHbNky7MFEyFo4WKjbVPjAv0map8Rbp08NidWOXx/7ZKWOyoP5K5qMxrYAvkHSuILszbN5Ii25PvMwTIn+EmJ/DNOwO0zCgnE2S8DNGRB+xrtBdleXnsiAGGVOwh518m353s1+5iiG19mZSb5lavG+BVb4cnvpOw0npbDRg+7CP1QVLSU60GMV8bKYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BWnfzYybWl/scTuY5FD9VOLt2LECai+WE378UnVPK0=;
 b=f3xVMKPORuucII5WkbCdwVV5YhxETzx4Ke6YSQuBRGvU4cirQomVJ+T9udFdzX3JxKnb8I8qk/EvUWkLRIy42xLIUjr4NQB9EBM0G3C/kXdQh/cjI6DfKGZ98qqz31gishOSZq12bGJJIDujUHNbJ/bLqjst3tFNGzWrxp8mQAWzCBjVvoNK0D5rqZe/uPE31QH5kUJXulgPEkM7uIw6DldwwF+j+jAPEwngtoLTAU2fQ6o3vCRulDVUOmxE3/nqd7MX9EWRVvEpf6yAhBxqUKQAEj9TNsxaAtAQEd9ztSkzeZM6iPDp20qA9AHxrK2DhvkB5H5E2VTv7YkNEmJJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BWnfzYybWl/scTuY5FD9VOLt2LECai+WE378UnVPK0=;
 b=bFWHLIuQMAKQQ1hHwu6nCDZ2ndxfSpX/3z45WTB/BC853GJRo2rHO08icS5sl8VEcUwmwxynxdBHvrzfXXvtD2zvIA0/GwS7Jzwgos9de1MENI7svYOTtb6UMMl1lUEEgJtwhHfrtRSYp4yk3y/2dt0d5kDsr5pcA2vO8z2uoGM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:55:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:55:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
Date:   Fri, 30 Apr 2021 13:27:45 +0800
Message-Id: <20210430052746.10815-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58ba903-0fd3-48bf-dc40-08d90b943cf2
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39163065AFEBBEB1AA9277FDC95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMu3v4qY9hRsXyVhXA6S24pqu06Ni+TxYoIPbBx3IQyjSM+bkKodQHnRQfp2yyEypK6+kKgqfi3KYoUr1QEWSRQSyxLS1AM8TE+QUcGXVx+VSyOVZ0SOeWdPuXdURHVSjls1Lnksq14iViGFVKCqnY/9Db29gp/YmqdYoQ0NeFTMX3Rh1bJwVaNBMbKvaA9G6izItoUjefPgbAcn4N4JX2z5qHMyq8f6MqfO2rX8mvm9rQsvqqRSwFEAsdJRlFa9lZ22fuluDJbFBWfIVYgbrmnNjJPX3O+0rx4kjhqUJeSU9Xx5u9IpXXo4Bt3s/oFWuPCx7xUrluyu846gIqi9QJvDQg4LihNVzOUAFx/SGz2PxcIhg7X40P5Vff6ameH0upop6EVQgC2lV3bddbReN0BIcTmKoqUF58D/Wb26J+Da0gTIrpDtQTbgrCq+I/ikgBvxlXKxTT2tL2DXb90m1d9/FvfIk6NGGy1VPutkgT78lysUtYVn9mX3ljkHL7V3JIdMy+ufit3N0GYxEnPbJZh0JD4x9WKDCTLSMfGTrNCP9drJTliMnm1/Jtui8TSSH4kChTzCTt2T+7HNvgyg0hin4K4aHElSgzc37UYKggMksoXwsD8W4K+gBpr1XFtRfmMmSw/fU29zfPcwRN7dscEVrPbVq6k928SkofLQCApPAYVwsZ6DCvaiRA4ChnBy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(83380400001)(66476007)(66946007)(7416002)(66556008)(4326008)(6512007)(6486002)(6666004)(16526019)(956004)(186003)(86362001)(2616005)(6506007)(1076003)(2906002)(38100700002)(38350700002)(8676002)(478600001)(52116002)(26005)(30864003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OE3gEpDZT372i1eh5G7TKbEBd7C7cwqdxeLT6nyAZTvQq4k1nl8teVERWg8R?=
 =?us-ascii?Q?81KPKzMJqE3vay6r0JiMo+uMH9Fu2jd91R/Gcc8EWpbCXy+K0JNbAYJc8E9C?=
 =?us-ascii?Q?LeMmImwEqJeUiPFQ1+AwVLPvoSn8wFHLXpoaoPs7p6B5AvmqBf6jG7drzHNn?=
 =?us-ascii?Q?ixg/VMYKiYVST4TJsVS/1oBRmDcattBUBtWgFQxSTne6GjBSeGWj45b8xbDt?=
 =?us-ascii?Q?2o1I45mCCGHwOl4SBDkjSyLsP5vXyW+Ha1Zyy3ZM10VvxF6zkRv0mB1gghLA?=
 =?us-ascii?Q?PUW8TtT6B8GXK98++L2W2czgF6YdWxXdofUHCIJ3wXCPBZl0J70M2DeIAZ9X?=
 =?us-ascii?Q?zsmeSnWCEyJLmIeuMR61yL55Q5LeWXzbX2kvnAZEZITv66eRPvYqUO1jiVIJ?=
 =?us-ascii?Q?siWCy/ZBwMQSd92BMrFpxIq1FVEBFAW7SN2yZxzyUwjqv8wTU0FEoi+3KsPF?=
 =?us-ascii?Q?E93PxnD95yMRjtZT+O6t4mwbMCD6wuRVlP37fZLn5ikkUoWnS+2EKBaysa0f?=
 =?us-ascii?Q?b06VnHEiB/Uy1AQSWyjV8gTq0PznFBVFSt+jDCj8xV1vs9jXViYu2QsEaJGe?=
 =?us-ascii?Q?T06Luy+5/xrXIb5b9r7tACMz6MFlsPcLa3Uexy4/VRo3wpIxuGZ+pOd+rYt8?=
 =?us-ascii?Q?t0zefcAtrlVG3AczhoZOAksvWB1nN1/Cy4zmtSG9FO3jzJuQ0Pic6GEY3AQh?=
 =?us-ascii?Q?un5HhSg59on87PaTripiKddoXyWGcNkIHIOHtrNJCNiKFz3gK6WHeIMT1mGn?=
 =?us-ascii?Q?fwhelJPdmqxnATZB2tq90NK9mrhfWZwlNYTXb1bEuFvYPV3MNRJLbnI12930?=
 =?us-ascii?Q?3lJwaBnKyP/jRSAAxh4W4tzEV7CsxzvGfMjxg1VSth9AAaQicPvjoU8mf7pG?=
 =?us-ascii?Q?9+VGpKTGkigZnOEMoXJmhpfRjnjt7300mDL+fDdXcZITBf27IwCYMlONIQBa?=
 =?us-ascii?Q?hFD9hKyCnr/WZr7KUthuTPjeN+76/g/JgdeR015hnGrRvA2xCTIXSTyG5eNk?=
 =?us-ascii?Q?w0eF/GE4gw6hkNEP0JM7yISBVJXa0g9ec3c0xK2Zbh+pw9QGZ0s2wBKq7mjA?=
 =?us-ascii?Q?GhahGLxj924KQaK9E5ybdnUS9jYZIqLAMHBGDXhhrTec+HKwLE6WqPNiGbfh?=
 =?us-ascii?Q?9D+XvwujxyQiyX5IgUkpyrrpFWrH0oa+OSLpD/KYfkTnG1ZMj2HVuIc6J0Fj?=
 =?us-ascii?Q?kfYG4uXXvko4I0Tr+3ARMSCWk2/cu6SwyRJ9LXlgC1S/Fdd11qFxjXcWjPhv?=
 =?us-ascii?Q?6bbdLzp321O4EKTUUgmwuWDMHeCHpbYQa2NRRWPxTxQPlRwjxG7+bEgEIJ8U?=
 =?us-ascii?Q?87Qx4FQDmZAa0j70LrPulojt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ba903-0fd3-48bf-dc40-08d90b943cf2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:55:55.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPGTroPYaCMd8tGTLJQSJD5B6KgDi41qdAM0g9/NZonugLrhwl5bOBabbGCCj9C3ifVUUPWLrEGcZC4BH4yvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
 drivers/soc/imx/blk-ctl.c | 303 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  76 ++++++++++
 3 files changed, 380 insertions(+), 1 deletion(-)
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
index 000000000000..1f764dfd308d
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
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
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET)
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
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
+	struct imx_blk_ctl_domain *pd;
+	struct imx_blk_ctl *blk_ctl;
+	const struct imx_blk_ctl_hw *hw;
+	struct regmap *regmap;
+	int ret;
+
+	pd = to_imx_blk_ctl_pd(domain);
+	blk_ctl = pd->blk_ctl;
+	regmap = blk_ctl->regmap;
+	hw = &blk_ctl->dev_data->pds[pd->id];
+
+	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, hw->offset, hw->mask, 0);
+	if (ret)
+		goto hsk_fail;
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET)
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
+
+	if (atomic_dec_and_test(&blk_ctl->power_count)) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret) {
+			dev_err(blk_ctl->dev, "Hankshake fail\n");
+			goto hsk_fail;
+		}
+	}
+
+hsk_fail:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
+
+	return ret;
+}
+
+int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
+{
+	struct imx_blk_ctl_domain *pd;
+	struct regmap *regmap;
+	const struct imx_blk_ctl_hw *hw;
+	int ret;
+	struct imx_blk_ctl *blk_ctl;
+
+	pd = to_imx_blk_ctl_pd(domain);
+	blk_ctl = pd->blk_ctl;
+	regmap = blk_ctl->regmap;
+	hw = &blk_ctl->dev_data->pds[pd->id];
+
+	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
+	if (ret)
+		return ret;
+
+	if ((atomic_read(&blk_ctl->power_count) == 0)) {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret) {
+			dev_err(blk_ctl->dev, "Hankshake fail\n");
+			goto disable_clk;
+		}
+	}
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET)
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
+
+	/* Wait for reset propagate */
+	udelay(5);
+
+	if (hw->flags & IMX_BLK_CTL_PD_RESET)
+		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
+
+	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
+	if (ret)
+		goto disable_clk;
+
+	atomic_inc(&blk_ctl->power_count);
+
+disable_clk:
+	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
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
+		return 0;
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
+			return ret;
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
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_err(dev, "Failed to attach active pd: %d\n", ret);
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
+			pr_warn("failed to add subdomain:\n");
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
+
+static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+const struct dev_pm_ops imx_blk_ctl_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
+			   imx_blk_ctl_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			   pm_runtime_force_resume)
+};
+EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
new file mode 100644
index 000000000000..e736369406a1
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.h
@@ -0,0 +1,76 @@
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
+	atomic_t power_count;
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

