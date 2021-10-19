Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A63434269
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJTAA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:00:57 -0400
Received: from mx.socionext.com ([202.248.49.38]:37520 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhJTAAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:00:47 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Oct 2021 08:58:32 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B4A75206E701;
        Wed, 20 Oct 2021 08:58:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 20 Oct 2021 08:58:32 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5ACE3B62AC;
        Wed, 20 Oct 2021 08:58:32 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 6/8] phy: uniphier-pcie: Add dual-phy support for NX1 SoC
Date:   Wed, 20 Oct 2021 08:58:06 +0900
Message-Id: <1634687888-23900-7-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NX1 SoC supports 2 lanes and has dual-phy. Should set appropriate
configuration values to both PHY registers.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 48 ++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index 2bd8df619712..ebca296ef123 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -27,6 +27,7 @@
 #define TESTI_DAT_MASK		GENMASK(13, 6)
 #define TESTI_ADR_MASK		GENMASK(5, 1)
 #define TESTI_WR_EN		BIT(0)
+#define TESTIO_PHY_SHIFT	16
 
 #define PCL_PHY_TEST_O		0x2004
 #define TESTO_DAT_MASK		GENMASK(7, 0)
@@ -65,43 +66,57 @@ struct uniphier_pciephy_priv {
 
 struct uniphier_pciephy_soc_data {
 	bool is_legacy;
+	bool is_dual_phy;
 	void (*set_phymode)(struct regmap *regmap);
 };
 
 static void uniphier_pciephy_testio_write(struct uniphier_pciephy_priv *priv,
-					  u32 data)
+					  int id, u32 data)
 {
+	if (id)
+		data <<= TESTIO_PHY_SHIFT;
+
 	/* need to read TESTO twice after accessing TESTI */
 	writel(data, priv->base + PCL_PHY_TEST_I);
 	readl(priv->base + PCL_PHY_TEST_O);
 	readl(priv->base + PCL_PHY_TEST_O);
 }
 
+static u32 uniphier_pciephy_testio_read(struct uniphier_pciephy_priv *priv, int id)
+{
+	u32 val = readl(priv->base + PCL_PHY_TEST_O);
+
+	if (id)
+		val >>= TESTIO_PHY_SHIFT;
+
+	return val & TESTO_DAT_MASK;
+}
+
 static void uniphier_pciephy_set_param(struct uniphier_pciephy_priv *priv,
-				       u32 reg, u32 mask, u32 param)
+				       int id, u32 reg, u32 mask, u32 param)
 {
 	u32 val;
 
 	/* read previous data */
 	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
 	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
-	uniphier_pciephy_testio_write(priv, val);
-	val = readl(priv->base + PCL_PHY_TEST_O) & TESTO_DAT_MASK;
+	uniphier_pciephy_testio_write(priv, id, val);
+	val = uniphier_pciephy_testio_read(priv, id);
 
 	/* update value */
 	val &= ~mask;
 	val |= mask & param;
 	val = FIELD_PREP(TESTI_DAT_MASK, val);
 	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
-	uniphier_pciephy_testio_write(priv, val);
-	uniphier_pciephy_testio_write(priv, val | TESTI_WR_EN);
-	uniphier_pciephy_testio_write(priv, val);
+	uniphier_pciephy_testio_write(priv, id, val);
+	uniphier_pciephy_testio_write(priv, id, val | TESTI_WR_EN);
+	uniphier_pciephy_testio_write(priv, id, val);
 
 	/* read current data as dummy */
 	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
 	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
-	uniphier_pciephy_testio_write(priv, val);
-	readl(priv->base + PCL_PHY_TEST_O);
+	uniphier_pciephy_testio_write(priv, id, val);
+	uniphier_pciephy_testio_read(priv, id);
 }
 
 static void uniphier_pciephy_assert(struct uniphier_pciephy_priv *priv)
@@ -127,7 +142,7 @@ static int uniphier_pciephy_init(struct phy *phy)
 {
 	struct uniphier_pciephy_priv *priv = phy_get_drvdata(phy);
 	u32 val;
-	int ret;
+	int ret, id;
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
@@ -155,14 +170,16 @@ static int uniphier_pciephy_init(struct phy *phy)
 	if (priv->data->is_legacy)
 		return 0;
 
-	uniphier_pciephy_set_param(priv, PCL_PHY_R00,
+	for (id = 0; id < (priv->data->is_dual_phy ? 2 : 1); id++) {
+		uniphier_pciephy_set_param(priv, id, PCL_PHY_R00,
 				   RX_EQ_ADJ_EN, RX_EQ_ADJ_EN);
-	uniphier_pciephy_set_param(priv, PCL_PHY_R06, RX_EQ_ADJ,
+		uniphier_pciephy_set_param(priv, id, PCL_PHY_R06, RX_EQ_ADJ,
 				   FIELD_PREP(RX_EQ_ADJ, RX_EQ_ADJ_VAL));
-	uniphier_pciephy_set_param(priv, PCL_PHY_R26, VCO_CTRL,
+		uniphier_pciephy_set_param(priv, id, PCL_PHY_R26, VCO_CTRL,
 				   FIELD_PREP(VCO_CTRL, VCO_CTRL_INIT_VAL));
-	uniphier_pciephy_set_param(priv, PCL_PHY_R28, VCOPLL_CLMP,
+		uniphier_pciephy_set_param(priv, id, PCL_PHY_R28, VCOPLL_CLMP,
 				   FIELD_PREP(VCOPLL_CLMP, VCOPLL_CLMP_VAL));
+	}
 	usleep_range(1, 10);
 
 	uniphier_pciephy_deassert(priv);
@@ -282,15 +299,18 @@ static const struct uniphier_pciephy_soc_data uniphier_pro5_data = {
 
 static const struct uniphier_pciephy_soc_data uniphier_ld20_data = {
 	.is_legacy = false,
+	.is_dual_phy = false,
 	.set_phymode = uniphier_pciephy_ld20_setmode,
 };
 
 static const struct uniphier_pciephy_soc_data uniphier_pxs3_data = {
 	.is_legacy = false,
+	.is_dual_phy = false,
 };
 
 static const struct uniphier_pciephy_soc_data uniphier_nx1_data = {
 	.is_legacy = false,
+	.is_dual_phy = true,
 	.set_phymode = uniphier_pciephy_nx1_setmode,
 };
 
-- 
2.7.4

