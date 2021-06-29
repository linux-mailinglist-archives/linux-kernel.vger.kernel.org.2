Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9383B6E73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhF2G7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:59:20 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:11571
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232195AbhF2G7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzIz958RV2G0htFELCA4Z6ZGQ/xbxyz6eb1UJ9MTy6iUuh2UQoL/KdfluGeb1ls1wewLw00XB0GkdiDlfvTMuyd9/5sbUct52DWG1TypY5UbyCCdUGnrF0b6JiKyeJIHUWcmHu3egdR3MgoFOEnLRkX7ciwwwIDE9QVlUntwT4M3+K8xvsMcqW1z5dG81HDC9jjDFZ1EFWDHNCVmTtvXapOBpWStuZSldrDCbRemLwSk0QyFUFQnVhayxk/F99JSOs/ELU5SWXE4XSt4JdAS2t8Y5+1wf5hzch4EaVoMn/hwD6AXuqAEJ2MTmVuTZyshQo5Z6B7QNEau6ZMMtVFhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K27AjtmOr+jOc7RycKBTA5RxRhe3BPs3doQIUd14R+4=;
 b=RkNcCs8qAubLCmruWxUX/TCSy1bf6I+2pJfMM/Zx8f11kuVqaAGK9qBeMyLUEIDWOe6tnzX0tQ9NoSk/gIv1DWGUq0AV9hUcp65ZMf3V/M5MeMb3OIyGvzdPYKlkvds1g6FFocXdblY4UFAyNQdmbeHhnTjg4M1QOFput//kg1Gvega0bgSJ60jzCK3NEqXwDsHXReqGQesDPtVU7mfdIAn9YOvosCrlOvPHepAuGll339l39LxaZ7cuiNB/oXcJNhSUjputMZJZLYACVdBa0pTlqCWOOCJ9ry8AYWm141M2vFQ6FpcdUbi0LhWDqw1NNTOVyyVxoIo5FJz7gCKN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K27AjtmOr+jOc7RycKBTA5RxRhe3BPs3doQIUd14R+4=;
 b=ZeoknmIOwgMfeSaRLxoMQgB2vDvSQrpiZVgOSaAW+YDnpnKj0mae854yg5eJZIgHiNf0PJebDtJVS41bi+kdTMTSG9GlSi8rljdFZN7KkevA09HPVrC1g3rhAn5WLHsN3fGtI3pjKMhhhYsiHNComUF919zvsC/va4eP2O7T7T0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 06:56:48 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:56:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 3/4] soc: imx: Add generic blk-ctl driver
Date:   Tue, 29 Jun 2021 15:29:40 +0800
Message-Id: <20210629072941.7980-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 06:56:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6200227-1fb7-4cf3-cd9b-08d93acb104a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB47624F45A618D0B91D9D3D66C9029@DB7PR04MB4762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGzgKyBRSEyR7ncVWEEtOKexMj5mzAlbjrboNZ9n6/MgiCEjTt3IZlp4Z8pfz32V4yoGcitRvHRpXWdcvDiTcuwkPGOsi1uo1q6mxJ0tMSZ/zCGmrZBxF/dntP9CNr3+J0JJ3i4UXigeL1PXZhhbkHljnxGybnfSoPxsmivr2GkRiQS0zPE0oISKx7SP3kVBtcnBYeysxHlLtmcucXvrrhf286UKRA7Eb6GOpYTmbFye1FsPUd2tYaQl2pqdL5YKalbB3GGVvrcWDleMWEsMINiYu9hgqYT0DpfnzN4vzsaYf1n8eMuuUC4kaf5yAvlfl01pyxnr4z5dN577BsUvcQOco22g+OXI7btqm89wgFYRjJaxEB22/N1a7rFoQ+wgxjvRFRG6OvtxIvR8kvvmHPHkIAJO7c9CRfDD7DyBR8I4rce6S9DunxlDhXf1f/ALUviRSGi24PPW1KW25BmiGDJIU/3h97TswbjvBQBwQjKfnhymGt3j4+4RRu2M1sgA3IVaUfn0b4QqrjgBfxUrE8oj9swRRFtkjUM4R2dngKMtHTJnIht8JIXIxVTkjQNBfZ/P4shO3IqHlNetmJtgF1o5wWIKo7Kb0DcMyIEfmZjuVwC5i1xqEEPzFgXC72xo+2yR1kNFLjk7vZv+5bIFJ6Osai2drPf/4JBhJ1qHebjezTcW58dfyoJMEzpXMIiyejY5f4ekzhGL92qvLj719v+sYayCorshkaZwc9AQ9d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(956004)(38100700002)(1076003)(478600001)(316002)(2616005)(5660300002)(66946007)(38350700002)(6506007)(66556008)(6486002)(66476007)(83380400001)(8936002)(52116002)(8676002)(7416002)(86362001)(16526019)(30864003)(26005)(186003)(2906002)(6512007)(4326008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkM4+xCEkXuh2c5enOtnd29KwuR+dfOk5jYnke9nSWnAVAH9f1AW1oC2aONv?=
 =?us-ascii?Q?mqxKIPPZb8Iirs3xnuAmsNn0EV/Y9hCHErZdpuUHmeqQLvwl/m5oaR4FrvrF?=
 =?us-ascii?Q?vr/9OGeF0tgv4Rq8GWNLOFnNuhxDo5I48bUmZ4Gumz2TwNLVWxQxc0qlE62S?=
 =?us-ascii?Q?F9adwp/B9IfXHdanQ55rn+khUegqu7ms3iTqggZtckhRU6GdMd0u3lD/R1VQ?=
 =?us-ascii?Q?IPNX5dYAQylGm5JoN/jxiKS/GUf6JDrCcw7HebYI5p4WvRj/eEnRSzKaaXn0?=
 =?us-ascii?Q?cuJAlbHlM5lko82nEOyjctMfCxr4UCgQL+LgeKro2TNQpZDFqKNxoXRiGyPu?=
 =?us-ascii?Q?LTEKp/2B7I0Nyk5VJesxelPVaj3D04HL7nEjq4Q2MUkYO3L8sme2YNaRPAKT?=
 =?us-ascii?Q?JsiZKlRm54SgudnGRY2tQbqngFg0uW3+5i4KReRnL0IC5G7UuwZpoDWUm9ZP?=
 =?us-ascii?Q?YoF/y07se2uzyeyhZZGyw//nvWiRn8WbEDnczCx2gV8YaW6VSRQBMMY5/17W?=
 =?us-ascii?Q?llyOAZQs4rJuFPlxwem8iuOfHwBWTQNDDn0V4OyVrJiumAG62KuFNJl+AhUX?=
 =?us-ascii?Q?dgftISis8b+Z9aq595xRXXfl/6KQ3sIbAzA6dsgy7XtknDziz0R4CAszwnvP?=
 =?us-ascii?Q?wO9P8ewXirGGdCJXzmq38OVZ5/SnafZxff9lGVTRln070xaVzudlDcUiJCj5?=
 =?us-ascii?Q?+urfptqtSLJTGMMUFPIOfi2uPoi0q3T3DBDD/cNjTFhWfkhDe1vKvk/ZUgj0?=
 =?us-ascii?Q?kEFX4QEFMenEe4MKiRn1/rohcnn2bZUo1WagqAzmCGfOsBBXuX5aCI0dB1L6?=
 =?us-ascii?Q?Ru1n6MZxrcDcWTLgcWnYD+AuRpq6uc4WNRif7FjqP971ZjASzRWdh4TVZAAe?=
 =?us-ascii?Q?bDcDx9vBzVDKq6GtVMgCI2svSuI018TdhD4MgjtI24dVsCfa8ipc/2iBi7oh?=
 =?us-ascii?Q?T9fRZEu3+r4T5gSxL9SaPqWjCdAQ378gpeh5zgxR9oaZCB7vcBkTQsxDlsu+?=
 =?us-ascii?Q?BmmgG7SuSWJzduzN66QP5Ob9rDtKP4tSXbpdvHHUCuQK3V6KUKrXFtXq0avb?=
 =?us-ascii?Q?E3YGX9lTHEcxfgKcclWEPgK7T4XdzXO1f/JcJx2KANTpW1MKSMrnodSL8OJQ?=
 =?us-ascii?Q?uE095bU/ryzotc5QANs0N46i7EnBh0aNHfph6WYRsFTXrC+NoouDTcyVaa11?=
 =?us-ascii?Q?ymuPo5D6Xs3hnIcpmPlIaM2YWr8Gng5UIGWNbcsbpR7VkkL/79ol1YFx9MIf?=
 =?us-ascii?Q?XEBsK5h6nAFCJGaZFdOZMmKbNluFT2VhbgvxmAnBWDnltuIe9YhrMfoGZ6/E?=
 =?us-ascii?Q?VL3na3ZfBaJDEzSJQwcZYzKK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6200227-1fb7-4cf3-cd9b-08d93acb104a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 06:56:47.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m35QKK06oCR4COHOXlF/fnPDJ+rpCcmYqvN+SjRmuE8LbX71hqSc3QDvKmY3szJ+D8DKuhsdPSN77mPSLvFRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
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
 drivers/soc/imx/blk-ctl.c | 324 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/blk-ctl.h |  85 ++++++++++
 3 files changed, 410 insertions(+), 1 deletion(-)
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
index 000000000000..cec1884202e0
--- /dev/null
+++ b/drivers/soc/imx/blk-ctl.c
@@ -0,0 +1,324 @@
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
+		if (ret)
+			dev_err(blk_ctl->dev, "Handshake failed when power on\n");
+
+		/* Expected, handshake already handle reset*/
+		goto disable_clk;
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
+	int ret = 0;
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
+	} else {
+		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
+		if (ret)
+			dev_err(blk_ctl->dev, "Handshake failed when power off\n");
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

