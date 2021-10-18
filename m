Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B3430DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbhJRBjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:39:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:46356 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243040AbhJRBjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:39:42 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:37:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id F39A72059034;
        Mon, 18 Oct 2021 10:37:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:37:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9D32DB62B7;
        Mon, 18 Oct 2021 10:37:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 8/8] phy: uniphier-ahci: Add support for Pro4 SoC
Date:   Mon, 18 Oct 2021 10:37:13 +0900
Message-Id: <1634521033-17003-9-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PHY interface built into ahci controller implemented
in UniPhier Pro4 SoC.

Pro4 SoC distinguishes it from other SoCs as "legacy" SoC, which has GIO
clock line. And Pro4 AHCI-PHY needs to control additional reset lines
(pm", "tx", and "rx").

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/Kconfig             |   2 +-
 drivers/phy/socionext/phy-uniphier-ahci.c | 201 +++++++++++++++++++++++++++++-
 2 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
index a3970e0f89da..8ae644756352 100644
--- a/drivers/phy/socionext/Kconfig
+++ b/drivers/phy/socionext/Kconfig
@@ -43,4 +43,4 @@ config PHY_UNIPHIER_AHCI
 	select GENERIC_PHY
 	help
 	  Enable this to support PHY implemented in AHCI controller
-	  on UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.
+	  on UniPhier SoCs. This driver supports Pro4, PXs2 and PXs3 SoCs.
diff --git a/drivers/phy/socionext/phy-uniphier-ahci.c b/drivers/phy/socionext/phy-uniphier-ahci.c
index 7427c40bf4ae..28cf3efe0695 100644
--- a/drivers/phy/socionext/phy-uniphier-ahci.c
+++ b/drivers/phy/socionext/phy-uniphier-ahci.c
@@ -19,8 +19,9 @@
 struct uniphier_ahciphy_priv {
 	struct device *dev;
 	void __iomem  *base;
-	struct clk *clk, *clk_parent;
-	struct reset_control *rst, *rst_parent;
+	struct clk *clk, *clk_parent, *clk_parent_gio;
+	struct reset_control *rst, *rst_parent, *rst_parent_gio;
+	struct reset_control *rst_pm, *rst_tx, *rst_rx;
 	const struct uniphier_ahciphy_soc_data *data;
 };
 
@@ -28,10 +29,30 @@ struct uniphier_ahciphy_soc_data {
 	int (*init)(struct uniphier_ahciphy_priv *priv);
 	int (*power_on)(struct uniphier_ahciphy_priv *priv);
 	int (*power_off)(struct uniphier_ahciphy_priv *priv);
+	bool is_legacy;
 	bool is_ready_high;
 	bool is_phy_clk;
 };
 
+/* for Pro4 */
+#define CKCTRL0				0x0
+#define CKCTRL0_CK_OFF			BIT(9)
+#define CKCTRL0_NCY_MASK		GENMASK(8, 4)
+#define CKCTRL0_NCY5_MASK		GENMASK(3, 2)
+#define CKCTRL0_PRESCALE_MASK		GENMASK(1, 0)
+#define CKCTRL1				0x4
+#define CKCTRL1_LOS_LVL_MASK		GENMASK(20, 16)
+#define CKCTRL1_TX_LVL_MASK		GENMASK(12, 8)
+#define RXTXCTRL			0x8
+#define RXTXCTRL_RX_EQ_VALL_MASK	GENMASK(31, 29)
+#define RXTXCTRL_RX_DPLL_MODE_MASK	GENMASK(28, 26)
+#define RXTXCTRL_TX_ATTEN_MASK		GENMASK(14, 12)
+#define RXTXCTRL_TX_BOOST_MASK		GENMASK(11, 8)
+#define RXTXCTRL_TX_EDGERATE_MASK	GENMASK(3, 2)
+#define RXTXCTRL_TX_CKO_EN		BIT(0)
+#define RSTPWR				0x30
+#define RSTPWR_RX_EN_VAL		BIT(18)
+
 /* for PXs2/PXs3 */
 #define CKCTRL				0x0
 #define CKCTRL_P0_READY			BIT(15)
@@ -50,6 +71,128 @@ struct uniphier_ahciphy_soc_data {
 #define RXCTRL_LOS_BIAS_MASK		GENMASK(10, 8)
 #define RXCTRL_RX_EQ_MASK		GENMASK(2, 0)
 
+static int uniphier_ahciphy_pro4_init(struct uniphier_ahciphy_priv *priv)
+{
+	u32 val;
+
+	/* set phy MPLL parameters */
+	val = readl(priv->base + CKCTRL0);
+	val &= ~CKCTRL0_NCY_MASK;
+	val |= FIELD_PREP(CKCTRL0_NCY_MASK, 0x6);
+	val &= ~CKCTRL0_NCY5_MASK;
+	val |= FIELD_PREP(CKCTRL0_NCY5_MASK, 0x2);
+	val &= ~CKCTRL0_PRESCALE_MASK;
+	val |= FIELD_PREP(CKCTRL0_PRESCALE_MASK, 0x1);
+	writel(val, priv->base + CKCTRL0);
+
+	/* setup phy control parameters */
+	val = readl(priv->base + CKCTRL1);
+	val &= ~CKCTRL1_LOS_LVL_MASK;
+	val |= FIELD_PREP(CKCTRL1_LOS_LVL_MASK, 0x10);
+	val &= ~CKCTRL1_TX_LVL_MASK;
+	val |= FIELD_PREP(CKCTRL1_TX_LVL_MASK, 0x06);
+	writel(val, priv->base + CKCTRL1);
+
+	val = readl(priv->base + RXTXCTRL);
+	val &= ~RXTXCTRL_RX_EQ_VALL_MASK;
+	val |= FIELD_PREP(RXTXCTRL_RX_EQ_VALL_MASK, 0x6);
+	val &= ~RXTXCTRL_RX_DPLL_MODE_MASK;
+	val |= FIELD_PREP(RXTXCTRL_RX_DPLL_MODE_MASK, 0x3);
+	val &= ~RXTXCTRL_TX_ATTEN_MASK;
+	val |= FIELD_PREP(RXTXCTRL_TX_ATTEN_MASK, 0x3);
+	val &= ~RXTXCTRL_TX_BOOST_MASK;
+	val |= FIELD_PREP(RXTXCTRL_TX_BOOST_MASK, 0x5);
+	val &= ~RXTXCTRL_TX_EDGERATE_MASK;
+	val |= FIELD_PREP(RXTXCTRL_TX_EDGERATE_MASK, 0x0);
+	writel(val, priv->base + RXTXCTRL);
+
+	return 0;
+}
+
+static int uniphier_ahciphy_pro4_power_on(struct uniphier_ahciphy_priv *priv)
+{
+	u32 val;
+	int ret;
+
+	/* enable reference clock for phy */
+	val = readl(priv->base + CKCTRL0);
+	val &= ~CKCTRL0_CK_OFF;
+	writel(val, priv->base + CKCTRL0);
+
+	/* enable TX clock */
+	val = readl(priv->base + RXTXCTRL);
+	val |= RXTXCTRL_TX_CKO_EN;
+	writel(val, priv->base + RXTXCTRL);
+
+	/* wait until RX is ready */
+	ret = readl_poll_timeout(priv->base + RSTPWR, val,
+				 !(val & RSTPWR_RX_EN_VAL), 200, 2000);
+	if (ret) {
+		dev_err(priv->dev, "Failed to check whether Rx is ready\n");
+		goto out_disable_clock;
+	}
+
+	/* release all reset */
+	ret = reset_control_deassert(priv->rst_pm);
+	if (ret) {
+		dev_err(priv->dev, "Failed to release PM reset\n");
+		goto out_disable_clock;
+	}
+
+	ret = reset_control_deassert(priv->rst_tx);
+	if (ret) {
+		dev_err(priv->dev, "Failed to release Tx reset\n");
+		goto out_reset_pm_assert;
+	}
+
+	ret = reset_control_deassert(priv->rst_rx);
+	if (ret) {
+		dev_err(priv->dev, "Failed to release Rx reset\n");
+		goto out_reset_tx_assert;
+	}
+
+	return 0;
+
+out_reset_tx_assert:
+	reset_control_assert(priv->rst_tx);
+out_reset_pm_assert:
+	reset_control_assert(priv->rst_pm);
+
+out_disable_clock:
+	/* disable TX clock */
+	val = readl(priv->base + RXTXCTRL);
+	val &= ~RXTXCTRL_TX_CKO_EN;
+	writel(val, priv->base + RXTXCTRL);
+
+	/* disable reference clock for phy */
+	val = readl(priv->base + CKCTRL0);
+	val |= CKCTRL0_CK_OFF;
+	writel(val, priv->base + CKCTRL0);
+
+	return ret;
+}
+
+static int uniphier_ahciphy_pro4_power_off(struct uniphier_ahciphy_priv *priv)
+{
+	u32 val;
+
+	reset_control_assert(priv->rst_rx);
+	reset_control_assert(priv->rst_tx);
+	reset_control_assert(priv->rst_pm);
+
+	/* disable TX clock */
+	val = readl(priv->base + RXTXCTRL);
+	val &= ~RXTXCTRL_TX_CKO_EN;
+	writel(val, priv->base + RXTXCTRL);
+
+	/* disable reference clock for phy */
+	val = readl(priv->base + CKCTRL0);
+	val |= CKCTRL0_CK_OFF;
+	writel(val, priv->base + CKCTRL0);
+
+	return 0;
+}
+
 static void uniphier_ahciphy_pxs2_enable(struct uniphier_ahciphy_priv *priv,
 					 bool enable)
 {
@@ -142,14 +285,22 @@ static int uniphier_ahciphy_init(struct phy *phy)
 	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
-	ret = clk_prepare_enable(priv->clk_parent);
+	ret = clk_prepare_enable(priv->clk_parent_gio);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(priv->rst_parent);
+	ret = clk_prepare_enable(priv->clk_parent);
+	if (ret)
+		goto out_clk_gio_disable;
+
+	ret = reset_control_deassert(priv->rst_parent_gio);
 	if (ret)
 		goto out_clk_disable;
 
+	ret = reset_control_deassert(priv->rst_parent);
+	if (ret)
+		goto out_rst_gio_assert;
+
 	if (priv->data->init) {
 		ret = priv->data->init(priv);
 		if (ret)
@@ -160,8 +311,12 @@ static int uniphier_ahciphy_init(struct phy *phy)
 
 out_rst_assert:
 	reset_control_assert(priv->rst_parent);
+out_rst_gio_assert:
+	reset_control_assert(priv->rst_parent_gio);
 out_clk_disable:
 	clk_disable_unprepare(priv->clk_parent);
+out_clk_gio_disable:
+	clk_disable_unprepare(priv->clk_parent_gio);
 
 	return ret;
 }
@@ -171,7 +326,9 @@ static int uniphier_ahciphy_exit(struct phy *phy)
 	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
 
 	reset_control_assert(priv->rst_parent);
+	reset_control_assert(priv->rst_parent_gio);
 	clk_disable_unprepare(priv->clk_parent);
+	clk_disable_unprepare(priv->clk_parent_gio);
 
 	return 0;
 }
@@ -265,6 +422,28 @@ static int uniphier_ahciphy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
+	if (priv->data->is_legacy) {
+		priv->clk_parent_gio = devm_clk_get(dev, "gio");
+		if (IS_ERR(priv->clk_parent_gio))
+			return PTR_ERR(priv->clk_parent_gio);
+		priv->rst_parent_gio =
+			devm_reset_control_get_shared(dev, "gio");
+		if (IS_ERR(priv->rst_parent_gio))
+			return PTR_ERR(priv->rst_parent_gio);
+
+		priv->rst_pm = devm_reset_control_get_shared(dev, "pm");
+		if (IS_ERR(priv->rst_pm))
+			return PTR_ERR(priv->rst_pm);
+
+		priv->rst_tx = devm_reset_control_get_shared(dev, "tx");
+		if (IS_ERR(priv->rst_tx))
+			return PTR_ERR(priv->rst_tx);
+
+		priv->rst_rx = devm_reset_control_get_shared(dev, "rx");
+		if (IS_ERR(priv->rst_rx))
+			return PTR_ERR(priv->rst_rx);
+	}
+
 	phy = devm_phy_create(dev, dev->of_node, &uniphier_ahciphy_ops);
 	if (IS_ERR(phy)) {
 		dev_err(dev, "failed to create phy\n");
@@ -279,9 +458,18 @@ static int uniphier_ahciphy_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct uniphier_ahciphy_soc_data uniphier_pro4_data = {
+	.init = uniphier_ahciphy_pro4_init,
+	.power_on  = uniphier_ahciphy_pro4_power_on,
+	.power_off = uniphier_ahciphy_pro4_power_off,
+	.is_legacy = true,
+	.is_phy_clk = false,
+};
+
 static const struct uniphier_ahciphy_soc_data uniphier_pxs2_data = {
 	.power_on  = uniphier_ahciphy_pxs2_power_on,
 	.power_off = uniphier_ahciphy_pxs2_power_off,
+	.is_legacy = false,
 	.is_ready_high = false,
 	.is_phy_clk = false,
 };
@@ -290,12 +478,17 @@ static const struct uniphier_ahciphy_soc_data uniphier_pxs3_data = {
 	.init      = uniphier_ahciphy_pxs3_init,
 	.power_on  = uniphier_ahciphy_pxs2_power_on,
 	.power_off = uniphier_ahciphy_pxs2_power_off,
+	.is_legacy = false,
 	.is_ready_high = true,
 	.is_phy_clk = true,
 };
 
 static const struct of_device_id uniphier_ahciphy_match[] = {
 	{
+		.compatible = "socionext,uniphier-pro4-ahci-phy",
+		.data = &uniphier_pro4_data,
+	},
+	{
 		.compatible = "socionext,uniphier-pxs2-ahci-phy",
 		.data = &uniphier_pxs2_data,
 	},
-- 
2.7.4

