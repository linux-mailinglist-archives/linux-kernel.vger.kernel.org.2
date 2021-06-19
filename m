Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA8F3AD6D6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 04:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhFSCtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 22:49:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36561 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235352AbhFSCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:49:44 -0400
X-UUID: 0c3d96e552664a86bfff7dcbde44ba1c-20210619
X-UUID: 0c3d96e552664a86bfff7dcbde44ba1c-20210619
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1244997946; Sat, 19 Jun 2021 10:47:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 19 Jun 2021 10:47:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Jun 2021 10:47:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] phy: phy-mtk-tphy: add support mt8195
Date:   Sat, 19 Jun 2021 10:47:19 +0800
Message-ID: <1624070839-1233-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624070839-1233-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1624070839-1233-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ACA2FB4F085DCCDB76C1F1FC25FA2468B7B205E48685623BF1E08837096E4F872000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller is designed to use use PLL integer mode, but
in fact used fractional mode for some ones on mt8195, this
causes signal degradation (e.g. eye diagram test fail), fix
it by switching PLL to 26Mhz from default 48Mhz to improve
signal quality.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: noc changes
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 42a1174da6cc..c3dc1763a7eb 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -41,6 +41,8 @@
 
 #define U3P_USBPHYACR0		0x000
 #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
+#define PA0_USB20_PLL_PREDIV		GENMASK(7, 6)
+#define PA0_USB20_PLL_PREDIV_VAL(x)	((0x3 & (x)) << 6)
 #define PA0_RG_USB20_INTR_EN		BIT(5)
 
 #define U3P_USBPHYACR1		0x004
@@ -52,6 +54,8 @@
 #define PA1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
 
 #define U3P_USBPHYACR2		0x008
+#define PA2_RG_U2PLL_BW			GENMASK(21, 19)
+#define PA2_RG_U2PLL_BW_VAL(x)		((0x7 & (x)) << 19)
 #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
 
 #define U3P_USBPHYACR5		0x014
@@ -73,6 +77,14 @@
 #define P2C_USB20_GPIO_MODE		BIT(8)
 #define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
 
+#define U3P_U2PHYA_RESV		0x030
+#define P2R_RG_U2PLL_FBDIV_26M		0x1bb13b
+#define P2R_RG_U2PLL_FBDIV_48M		0x3c0000
+
+#define U3P_U2PHYA_RESV1	0x044
+#define P2R_RG_U2PLL_REFCLK_SEL	BIT(5)
+#define P2R_RG_U2PLL_FRA_EN		BIT(3)
+
 #define U3D_U2PHYDCR0		0x060
 #define P2C_RG_SIF_U2PLL_FORCE_ON	BIT(24)
 
@@ -277,6 +289,12 @@ enum mtk_phy_version {
 struct mtk_phy_pdata {
 	/* avoid RX sensitivity level degradation only for mt8173 */
 	bool avoid_rx_sen_degradation;
+	/*
+	 * u2phy should use integer mode instead of fractional mode of
+	 * 48M PLL, fix it by switching PLL to 26M from default 48M
+	 * for mt8195
+	 */
+	bool sw_pll_48m_to_26m;
 	enum mtk_phy_version version;
 };
 
@@ -456,6 +474,33 @@ static void u3_phy_instance_init(struct mtk_tphy *tphy,
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
 
+static void u2_phy_pll_26m_set(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	void __iomem *com = u2_banks->com;
+	u32 tmp;
+
+	if (!tphy->pdata->sw_pll_48m_to_26m)
+		return;
+
+	tmp = readl(com + U3P_USBPHYACR0);
+	tmp &= ~PA0_USB20_PLL_PREDIV;
+	tmp |= PA0_USB20_PLL_PREDIV_VAL(0);
+	writel(tmp, com + U3P_USBPHYACR0);
+
+	tmp = readl(com + U3P_USBPHYACR2);
+	tmp &= ~PA2_RG_U2PLL_BW;
+	tmp |= PA2_RG_U2PLL_BW_VAL(3);
+	writel(tmp, com + U3P_USBPHYACR2);
+
+	writel(P2R_RG_U2PLL_FBDIV_26M, com + U3P_U2PHYA_RESV);
+
+	tmp = readl(com + U3P_U2PHYA_RESV1);
+	tmp |= P2R_RG_U2PLL_FRA_EN | P2R_RG_U2PLL_REFCLK_SEL;
+	writel(tmp, com + U3P_U2PHYA_RESV1);
+}
+
 static void u2_phy_instance_init(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
@@ -941,6 +986,7 @@ static int mtk_phy_init(struct phy *phy)
 
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
+		u2_phy_pll_26m_set(tphy, instance);
 		u2_phy_instance_init(tphy, instance);
 		u2_phy_props_set(tphy, instance);
 		break;
@@ -1094,10 +1140,16 @@ static const struct mtk_phy_pdata mt8173_pdata = {
 	.version = MTK_PHY_V1,
 };
 
+static const struct mtk_phy_pdata mt8195_pdata = {
+	.sw_pll_48m_to_26m = true,
+	.version = MTK_PHY_V3,
+};
+
 static const struct of_device_id mtk_tphy_id_table[] = {
 	{ .compatible = "mediatek,mt2701-u3phy", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,mt2712-u3phy", .data = &tphy_v2_pdata },
 	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
+	{ .compatible = "mediatek,mt8195-tphy", .data = &mt8195_pdata },
 	{ .compatible = "mediatek,generic-tphy-v1", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,generic-tphy-v2", .data = &tphy_v2_pdata },
 	{ .compatible = "mediatek,generic-tphy-v3", .data = &tphy_v3_pdata },
-- 
2.18.0

