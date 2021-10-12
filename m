Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7063242A0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhJLJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:08:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58676 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235658AbhJLJIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:08:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86C762025D0;
        Tue, 12 Oct 2021 11:06:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D0D12025C7;
        Tue, 12 Oct 2021 11:06:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7CD24183AD14;
        Tue, 12 Oct 2021 17:06:14 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, tharvey@gateworks.com, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
Date:   Tue, 12 Oct 2021 16:41:18 +0800
Message-Id: <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM PCIe works mostly like the i.MX8MQ one, but has a different PHY
and allows to output the internal PHY reference clock via the refclk pad.
Add the i.MX8MM PCIe support based on the standalone PHY driver.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 63 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26f49f797b0f..73022e37b1c5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -49,6 +50,7 @@ enum imx6_pcie_variants {
 	IMX6QP,
 	IMX7D,
 	IMX8MQ,
+	IMX8MM,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -80,6 +82,7 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
+	u32			refclk_pad_mode;
 	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
@@ -88,6 +91,7 @@ struct imx6_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	struct phy		*phy;
 	const struct imx6_pcie_drvdata *drvdata;
 };
 
@@ -372,6 +376,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
+		fallthrough;
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
@@ -407,7 +413,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MM);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -447,6 +454,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -522,6 +530,14 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		if (phy_power_on(imx6_pcie->phy))
+			pr_info("unable to enable pcie phy clock\n");
+		break;
+	default:
+		break;
+	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
@@ -538,6 +554,10 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
+	case IMX8MM:
+		if (phy_init(imx6_pcie->phy) != 0)
+			dev_err(dev, "Waiting for PHY ready timeout!\n");
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -614,6 +634,8 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		break;
 	case IMX8MQ:
 		/*
 		 * TODO: Currently this code assumes external
@@ -753,6 +775,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -871,6 +894,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
 	case IMX7D:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	default:
@@ -930,6 +954,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -985,6 +1010,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct imx6_pcie *imx6_pcie;
 	struct device_node *np;
 	struct resource *dbi_base;
+	struct device_node *phy_node;
 	struct device_node *node = dev->of_node;
 	int ret;
 	u16 val;
@@ -1019,6 +1045,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->phy_base);
 	}
 
+	imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(imx6_pcie->phy)) {
+		if (PTR_ERR(imx6_pcie->phy) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		/* Set NULL if there is no pcie-phy */
+		imx6_pcie->phy = NULL;
+	}
+
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
@@ -1090,6 +1124,18 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
 		break;
+	case IMX8MM:
+		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
+		if (IS_ERR(imx6_pcie->pcie_aux))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
+					     "pcie_aux clock source missing or invalid\n");
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
+									 "apps");
+		if (IS_ERR(imx6_pcie->apps_reset)) {
+			dev_err(dev, "Failed to get PCIE APPS reset control\n");
+			return PTR_ERR(imx6_pcie->apps_reset);
+		}
+		break;
 	default:
 		break;
 	}
@@ -1130,6 +1176,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 				 &imx6_pcie->tx_swing_low))
 		imx6_pcie->tx_swing_low = 127;
 
+	/* get PHY refclk pad mode if there is PHY node */
+	phy_node = of_parse_phandle(node, "phys", 0);
+	if (phy_node) {
+		of_property_read_u32(phy_node, "fsl,refclk-pad-mode",
+				     &imx6_pcie->refclk_pad_mode);
+		of_node_put(phy_node);
+	}
+
 	/* Limit link speed */
 	pci->link_gen = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
@@ -1202,6 +1256,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 	},
+	[IMX8MM] = {
+		.variant = IMX8MM,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1209,7 +1267,8 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
-	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
+	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
+	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{},
 };
 
-- 
2.25.1

