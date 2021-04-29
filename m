Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6936E56E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhD2HCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:35 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:54082
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239563AbhD2HCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgRke9f3gCeslv6Ze2ss2DJAVkXco08/k9ftlRDleCIt9+TNT7o8deP5tbQ/42c73d0ofnMruLFpDNw3kjQKxRMYbrhd8LQ8MU4GGYNHccPmvm+jCEjETeD5f7nrIeR8rHtnl11LW2lSyn4jcQbv3EZxzNkZIdEPEtgiBwZuWWlTMzOmqHHJ+Ogy9LIReKQ4CBWp3Nx8yknP+HEvnJj+HigFwb8WccrHC/OecLep67mjBcNbfK6BqBQE7pOo0Y/jQthwUgtDQpkGVqzrEdrzHajzUkH9GrQvj8NQW7EMtwiFqDphpGI1zN6sHChANrsUBjShWhI8Y1J+LS43yixwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BWnfzYybWl/scTuY5FD9VOLt2LECai+WE378UnVPK0=;
 b=cvmUU2S8PBOJAiDUWrRM0N3A3VXLLNj1CSgNp7uV3OYoSI9LQfNMHtNyWYt8BHAFgBkBkyrm6Wd+9whx8cIyqcSegSPfPEOUL/ZXzFor1qD6HvnXOz7Y6jO8VsbZKsGuT8n0nFazg0o50PItKEBKuoeZFBMapOph6JTvUsSSxbIw4VOW/uZrrx3VJUhyTi0RfM7tvSJ+FUoSxdduDnmFdgi26r/BbA90KqLkNhYcelQEzB+OqjTVFNWe2wWSS28pDiZO88MP1le1tVD9lr+C5EQIms+y0+XL2kgrKqRxo/9TVvnte8L3sIQcfJ8bHD9LDXMRrHtEVF+vpVD46ZziWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BWnfzYybWl/scTuY5FD9VOLt2LECai+WE378UnVPK0=;
 b=QX7jJhP+AKsV1HWV0ZeTpuxBXpuSOiXhSAec3Kd9eAzvbw9jjan+T/1X8GImvgPejA2rD0kMUeflQ1jOMf4+O70IgGKUEkvxxI2z2xQzFDpIU3lxrOaw5F++iC1tt/qUO2XaSYvTEVG6xncNd2MDzCComiMS0MKyCmQcArTS88A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:01:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:01:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] soc: imx: Add generic blk-ctl driver
Date:   Thu, 29 Apr 2021 15:33:30 +0800
Message-Id: <20210429073331.21204-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 07:01:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b4f3a3-39ff-4b6a-6189-08d90adca6bb
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930DB970836FC41F9DC17CBC95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JYeDeugnG1J6HwsLY5r8aeqK9heLohq2Rv/l+qmEF0pIhViQfcvvayBiGwllt5P3HhEylknC24cVZbVUwbFLlLiwLmiJDVIF3fyowW+jJTe1haVj9uXTVbuEzp58B/6o6RfganY9d437bgyXsA6t93BWlhTWDakvrsloiBf00w9MjbFqb+7IqVb2kpfQsr5q54UIUObWJM3SjQg/NbKXzvL/WjaPiFPAZgKBq0hw+4PqYa3kMbWGqXgS8tTPos6/Yk5XwvT6lZtn6yz/NYqrJrpHqP9BJZJ3dBvrpRZcm09qqKt/P1VDajOJmbGcJbf2R69VJ5wmUjbOHGZqr7+1boZO3Z2v3ZVVQtVQxAB42EUrTkD3h9IRRE44dSQkhMomWuDVxmItoN19Tiq45pZN9dVDbObK9FoOqs6OwW6e/fp24GZXnJ4jfxTwWpC/Msz3KcMKgoZWCNYvGUzT0alXjr66ceKg9czDj//hnwJg4u690IlaVB6Y6brlXuoKxaCXp62KYOtI6XImMghigwPzYP20wx2eHef3F6iX0h81bSZZm+KPzOk+1XtPudzxc7eUb4Jp2aq+W2cMwPk2PO5Y0YuZwb8hjniNNSCKC2OzusWmgsYfGHhM+JJ1mMCY3w0Y9pdQBxHVL41Ia8V9gsqngLyrUYGwRclvtCbQnOnqig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(83380400001)(86362001)(4326008)(956004)(66946007)(6512007)(30864003)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yGSmQt3rcTfHmLAkE3FRWRtvcUJt4ydsdmzH/J4UtouicG8mq590d6fnzteJ?=
 =?us-ascii?Q?RjAUyl56KEfVk3+WOwOe5w6uMlosOs89NmCClAbdwNoNPaJg+kjZVff8D5li?=
 =?us-ascii?Q?2NNzvTcrEUbSFr/Vr+LmbYb8XPN39nmCFd58vscvkuAYc1iXy7SzqFYt9Cmc?=
 =?us-ascii?Q?Wz3Pg7YK9I93MXQ6CzRXFeVForlz/vAQBFV0SNa4kwpXMs1CSdCOxpDmSbvy?=
 =?us-ascii?Q?QhSDWJW5uRB0vRtutcRaZZlYhhgV3b5NdKdHBgiswfspMjXxtM1luB6pcTjx?=
 =?us-ascii?Q?msqdX1PuoG2O9RxPIoT2xmFvVYYls04V5jMjdHWMXEKYpxPx3T0bj+yrjlXJ?=
 =?us-ascii?Q?Tf/y+/VYbyaq0lDSZiBR8uNXrLjsbui/3QJlcdWP5xWssHu1/XwaLDRBdrT4?=
 =?us-ascii?Q?mT0ZZEq1mCn3vEgO/cC+tx7DlHUMEr0Daqho9xSxZOkd2+/2bE4893U1cceq?=
 =?us-ascii?Q?wUzxqEStfjlApS9go6k4tYSz64b+MZXIvHhXQ02aErHJkYQH3oNCh5cPZmC1?=
 =?us-ascii?Q?a2abcl/uN7kzi1G8zqRLmuSQvhn0VltBaYm3BuoNeYXsaIedgM1Q0I5e70wR?=
 =?us-ascii?Q?grdlFkl20NVX6KBv7LcKrraewEFdfDygDDX4+p6NNlIojJln43i4NBUjhT+O?=
 =?us-ascii?Q?XWPHrr/t8r+MNob1RHIMQaNdyZ2QL8a3GNiVPujzOgAIfZvxhSbKJCrpWhq2?=
 =?us-ascii?Q?L1A711gwxtyTkZNfa7z9z6LFOA1zDWlf/NjnGo7nrfTfC6NSffSHQwo9VBQU?=
 =?us-ascii?Q?SepcJA2tQiRzA0tbTiAZN2a0/FB21vqVo2+dqPSZKO4wmidVK6Dwx/Jhlyum?=
 =?us-ascii?Q?HRvbJDFJnclpYsKlosN6J17fR1y9dE6jO+HxIxW+SwXU0ZSQddsUkv22vLMO?=
 =?us-ascii?Q?3t4Nc6kmJaUvbs/en89GNi3t8nPScqX08DIFQ/xPXaSEBWDR/gg9e3Wo4o/Q?=
 =?us-ascii?Q?1oDsOg2CnW+uPXrpIAdkAv+Cr27uhWWvepk81UIuQ0nReqIfmM6iloycHQqM?=
 =?us-ascii?Q?a4f5MboX1Giodx7nSb3FZmmDocsaZ70NtCoKX9xuVR8YX7UEdp8ad+VarPWX?=
 =?us-ascii?Q?In9Z7pXy+ubLrcm/D/rW61h5XDxVUdiIA9+lrlZ5sZAV4n062n98nckjqLcx?=
 =?us-ascii?Q?a8fu0adLbsGkN68UU/OjrzHD55offePWiXunfY2OVMnf4ZJZSuvCEM3ptqhk?=
 =?us-ascii?Q?WvtRBLRgmAeKwnSAHTKAB+y7sCx978nPbfqaBhpwHoF5TZlcpsAnSD7Lqenf?=
 =?us-ascii?Q?76OWWzJoHc0zbpdpsqN1WDJNSNr0KKdjZzgyXttM/gUwQK5afbHyX+m0X59Z?=
 =?us-ascii?Q?tJgiad00t/01bpqyfX7O1CW/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b4f3a3-39ff-4b6a-6189-08d90adca6bb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:01:45.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfd2/cS/MxOhG3KRxeFXTFyW2kNdXikLzdbQ3ozrA3SmsA6DGbJTrRms+z02YytqXU1YuSHHFkT0JJaUw1d9Ug==
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

