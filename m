Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A726338D5F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhEVNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:12:00 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:41441
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231175AbhEVNL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQRNnCT5GbR7wvoudEj6RpXUlxlzC0T0uHNxgR7/qW/LSLDO4saR9HR82FR7lc7u1ayH1ZmG9o2bTd6BYiDhgj4FsyH6xHxgJX2/e5OyCdwQqeocaI3FWDovxiAwDs4Po6pXpnTNxz9XoNhnQh0olCR1KYY1BXOwQvm287Apf3fGdFySs8RjOkz2QOlUFk4IqkeRB85H647CBkM6HxbOAJ1yCqd9yN2pHEE/eqvJ9M+NY17huQO8xxVLC/v852Ah1VTgnYw9ADbDXVOJ8dFO247EUCH9VHQ+r5Rg6+xlOJh8/UsLBu6esnEUVzL330BylU80grUgjyyg1hHdVHBmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qwaDupzmhqcQqkEIrmxTz/W4DsI6Ku2iN63KCcphUI=;
 b=eWivciaWh/WMKEjtkMjqAh0SEwOGn2al4/qBYZ+YRuBCP5FnJH6vz2s2zF7ZiKqba6M/VsmGmY6KOjPPy6j14WCxiIWaG1EV4wyeAT1YWiANYdIFFXbnNxfOGpq3cjADqoXVTn0RU0c8ldi62cskUlGsolq4RjBoVBZRvxAiyZ7zgU3iBr9psfSaIphnhY2h3qfHE1A9MJyo2BSaPCS13PrkGlcfNUbcnbsJuPBqc9bKHHVp4SGWHBM59i/q6vWIj56meY4BADeZHPbKgPNq8PQ7MeRpCHVGpC4wTplMwRaOCXl4qsDKvUdXM9CX2AXvTlQpqhcwqdSCtbZ58AHKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qwaDupzmhqcQqkEIrmxTz/W4DsI6Ku2iN63KCcphUI=;
 b=UB9BgjZ5XMbYSAXo4ZD8UcBGW8fSZgrB6N0GNC6KO5XEYQ/GynoiiMcODckYUKq0ptC8JpWSrLFCJi1FNT9Yvwbvt7y3tgjLPqDND/0tYG5TjOyh233tIoYw76wU1/3KxPDl0lpyDe2/MUnIEJgNHO7fsBUAhPsjw2N7Xz10zz0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Sat, 22 May
 2021 13:10:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 13:10:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/4] soc: imx: Add generic blk-ctl driver
Date:   Sat, 22 May 2021 21:42:48 +0800
Message-Id: <20210522134249.15322-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210522134249.15322-1-peng.fan@oss.nxp.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8657a16d-e049-48c7-ede4-08d91d22f987
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56587828A2651BB108248FA4C9289@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAismw68TwvayAhWDK4vh3sKZNZ1Mtd3W7SPjkzmbl8oRxm72kyEJjSKF+/UxJnP+xHhhkWzNU81NMqj3ZZ7tmAH8AlDsEEoQm2vbGT4gx7eGk9DHLOnXz2nfTL06oh2dasiwSCFIDitN4RPoOSkhijKr3L0AMiu8CyoUMyBJ35DT2e8Nb/9eszwkRsVfLKszWbs+DYaOqTgBM6+uS5/IuMFPEzG9tsYahm59AmfObyO75ZNzN/hf1yqq0+PipzqRpoT6rUGAqiqo2AVzfPnfOjITH9b8dAXpdEfm3MzBHtwve6xEsarZ+wDMB/HsIOBwu06CdfYemMlMZNE5VdDEKJLHaKYR5BQW7f1BJUMc2oPRqskGy9vs2QwGUCotkEybxRI3a3kxQwID6B9atfb798zwPSIJ2Z9ZcdMPK9zvMCRTR2TOSCHtZgQMZp4OjepUkhZTstMNJHU1a9r+OT7FIEHISg4JCNJnb1gk7YPU6KLqUzZzjePjNcXSPqRumHgdsLnBT52sokzpf1Hq4TNdr+Okw5JpM7RS+NLQzCIOP+KvIRrTUk4y0fwPMavglFFdPqPkK0j82PwSDR8zDlDvWS2awXU19MtLCMD75KaKdbJ8Epshj2bs2AED3BwZKcGHZvB9kbbAN+052tsTiAVXzwNuwWou01oUbURgAhsIqtRz61UI0jQQcjSEO1/hjCX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6506007)(66946007)(16526019)(66476007)(66556008)(186003)(4326008)(8936002)(26005)(52116002)(30864003)(6512007)(38350700002)(38100700002)(83380400001)(5660300002)(478600001)(1076003)(8676002)(956004)(2616005)(316002)(86362001)(2906002)(6486002)(6666004)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7DJGqU1+tmNdHlGzzYDxXTvHFlh6hyUZq/NOKnmkTngERZ4FnCM+ySvNBDQA?=
 =?us-ascii?Q?kiqIVFMFJTwx2bbGwDEc2jTeH7/QgbCzL4r2Fynp7B/ouz3wAjLSZLOerCng?=
 =?us-ascii?Q?vRDvtzE5QDjrZ5S92Kfk6BYSE72sr9E48E1r4AZftunZhFKU1PyhtwnVb/8E?=
 =?us-ascii?Q?yO+0nQLK7AOCVskUkdcsUwsiYUTT8qIU+LrggREXsbuKd32ZzjED825xC84H?=
 =?us-ascii?Q?ZzGhlbI46qUKv6Dr9efV4LBnsKOxNVLYJI4vXzymZ7lVnCFG+mvnqMqjT2iH?=
 =?us-ascii?Q?otbldjzdjzFCP19yXTtREgTQyngqyykQO9zPMajG6jElI1ge4ivPFpzyGpF1?=
 =?us-ascii?Q?P4HE/CRpX8igHQCMQjH6STA+i6KCyiVNIpKOKPi84q7ELCrHAeS3cCtCrEpD?=
 =?us-ascii?Q?1mcjeKNXBmXIqWuFELPXWtO2wY3CvV4l/6IcLmYFyiDWQBPJZvMR6e27/KZd?=
 =?us-ascii?Q?nkQ/Tx7cPr/qixWm5jXe8dcGXaaStIfFYRLeeIu3V48Ubx5hPy0hIIlTU7w1?=
 =?us-ascii?Q?KCokAi2Kn9UiOFxkSspq6Bvrj/XHtC1RLH14N02fTBuQEwyAtJxsJtgK4eX1?=
 =?us-ascii?Q?qV4xmbfOTY2kvnrdtlI5Uv3puMWHusuZpW0DRz8ku2WFEP8A6KTww8y/mcgq?=
 =?us-ascii?Q?4nxEgEL5oERvhZPzpEUEPEpl4TFDW0Kwbi0aH+7z7zEGATwh18lqdn78KBE4?=
 =?us-ascii?Q?7QAKOMgaP5mbynm/kEt9Gxkq3TavobV5Q4VEOsCyf7UOvpupKl0aW27A3Cv3?=
 =?us-ascii?Q?hbNlotPm9ek93/a/44X9AWjhdkfvZBqCoLz5yb31uv1QpD7+witA/YcPUspF?=
 =?us-ascii?Q?wfwxzuBAV0TLCQIbhiMhoxZMf6Lz5SfNPGDG415dNkdHFHhK8DuRH/rzrem3?=
 =?us-ascii?Q?RE/PeJSM0AfBmkgu9Jw+/FTC4G/D9h1/fn59QBmEykU/DTdqWAwF/ClSKXRY?=
 =?us-ascii?Q?yFyoq4VSue8cneJaNmr/So8NwWPyS2Wb2ewC+KZFgxoLmw6QXw8G/+7T227K?=
 =?us-ascii?Q?1EAyEwEDyllnpwH+FxWXniQ23xENxY3B4UJXUhS6KZGWTuz6nRYOfXBCH3cO?=
 =?us-ascii?Q?qJArhyAI/FkAwYQaQ9TB+yK2gwWGfEnsvgEQV+/lPGy/GC85HbSYEMoDI6+S?=
 =?us-ascii?Q?SBiELo/5jRnjWnSB2QELqqWL9DeqUStdmewpRG0IMyFwWTGJwaRa+vXQpqnt?=
 =?us-ascii?Q?zboos5ojpOuc/ltMHkDWjpXH/4m38qJN0pYxyb7k7/B/HYfa+xCo3VNPAdnS?=
 =?us-ascii?Q?VaoGoJNtZCxH1+iKP5964S0EF7aueAHzQqqdiGfcb+TRJ29LSJo046Z4iLcR?=
 =?us-ascii?Q?fpDeln098YyusYZl1oFSv7Hn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8657a16d-e049-48c7-ede4-08d91d22f987
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:10:30.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTH4zo4W47BlsTBdIP8KqTmvEX/LAQOvNNvbfZDRrB5oDSyy16E9CLi7p67fV1zkIFvhD7PuZkHV9K5asLLskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
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
 drivers/soc/imx/blk-ctl.c | 334 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  85 ++++++++++
 3 files changed, 420 insertions(+), 1 deletion(-)
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
index 000000000000..8e286b8ef1b3
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,334 @@
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
+	pdev->dev.of_node = blk_ctl->dev->of_node;
+	if (domain->hw->active_pd_name) {
+		active_pd = dev_pm_domain_attach_by_name(dev, domain->hw->active_pd_name);
+		if (IS_ERR_OR_NULL(active_pd)) {
+			ret = PTR_ERR(active_pd) ? : -ENODATA;
+			pdev->dev.of_node = NULL;
+			return ret;
+		}
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
+	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
+	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
+	struct generic_pm_domain *parent_genpd;
+	struct device *active_pd;
+
+	pdev->dev.of_node = blk_ctl->dev->of_node;
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

