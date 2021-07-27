Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122103D73B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhG0Ku6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:50:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38916 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236293AbhG0Kuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:54 -0400
X-UUID: fdf335c8de2c4246992e5df515095125-20210727
X-UUID: fdf335c8de2c4246992e5df515095125-20210727
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1336659006; Tue, 27 Jul 2021 18:50:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 18:50:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 18:50:45 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     <linux-phy@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] phy: mediatek: phy-mtk-tphy: support USB2UART switch
Date:   Tue, 27 Jul 2021 18:50:13 +0800
Message-ID: <1627383013-4535-2-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1627383013-4535-1-git-send-email-macpaul.lin@mediatek.com>
References: <1627383013-4535-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some embedded platform shared PINs between USB and UART.
For example, some phone will use special cable detection in boot loader
to switch USB port function into UART mode.

This patch support USB2UART switch function in phy-mtk-tphy.
1. Implement USB2UART switch API support in phy-mtk-tphy.
2. Use PHY_MODE_UART support according to new mode in phy.h.
3. Use mtk_phy_get_mode_ext() to query the current MODE from hardware.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c |  114 +++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index cdbcc49..a7dfeec 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -68,6 +68,7 @@
 #define PA6_RG_U2_SQTH_VAL(x)	(0xf & (x))
 
 #define U3P_U2PHYACR4		0x020
+#define P2C_RG_USB20_DM_100K_EN		BIT(17)
 #define P2C_RG_USB20_GPIO_CTL		BIT(9)
 #define P2C_USB20_GPIO_MODE		BIT(8)
 #define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
@@ -76,6 +77,12 @@
 #define P2C_RG_SIF_U2PLL_FORCE_ON	BIT(24)
 
 #define U3P_U2PHYDTM0		0x068
+#define P2C_RG_UART_MODE		GENMASK(31, 30)
+#define P2C_RG_UART_MODE_VAL(x)		((0x3 & (x)) << 30)
+#define P2C_RG_UART_MODE_OFET		(30)
+#define P2C_FORCE_UART_I		BIT(29)
+#define P2C_FORCE_UART_BIAS_EN		BIT(28)
+#define P2C_FORCE_UART_TX_OE		BIT(27)
 #define P2C_FORCE_UART_EN		BIT(26)
 #define P2C_FORCE_DATAIN		BIT(23)
 #define P2C_FORCE_DM_PULLDOWN		BIT(21)
@@ -98,6 +105,8 @@
 		P2C_RG_DPPULLDOWN | P2C_RG_TERMSEL)
 
 #define U3P_U2PHYDTM1		0x06C
+#define P2C_RG_UART_BIAS_EN		BIT(18)
+#define P2C_RG_UART_TX_OE		BIT(17)
 #define P2C_RG_UART_EN			BIT(16)
 #define P2C_FORCE_IDDIG		BIT(9)
 #define P2C_RG_VBUSVALID		BIT(5)
@@ -600,6 +609,90 @@ static void u2_phy_instance_exit(struct mtk_tphy *tphy,
 	}
 }
 
+static void u2_phy_instance_set_mode_2uart(struct u2phy_banks *u2_banks)
+{
+	u32 tmp;
+
+	/* Clear PA6_RG_U2_BC11_SW_EN */
+	tmp = readl(u2_banks->com + U3P_USBPHYACR6);
+	tmp &= ~(PA6_RG_U2_BC11_SW_EN);
+	writel(tmp, u2_banks->com + U3P_USBPHYACR6);
+
+	/* Set P2C_RG_SUSPENDM */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_RG_SUSPENDM;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_FORCE_SUSPENDM */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_FORCE_SUSPENDM;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Clear and Set P2C_RG_UART_MODE to 2'b01 */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp &= ~(P2C_RG_UART_MODE);
+	tmp |= P2C_RG_UART_MODE_VAL(0x1);
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Clear P2C_FORCE_UART_I */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp &= ~(P2C_FORCE_UART_I);
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_FORCE_UART_BIAS_EN */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_FORCE_UART_BIAS_EN;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_FORCE_UART_TX_OE */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_FORCE_UART_TX_OE;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_FORCE_UART_EN */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_FORCE_UART_EN;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_RG_UART_BIAS_EN */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_RG_UART_BIAS_EN;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_RG_UART_TX_OE */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_RG_UART_TX_OE;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_RG_UART_EN */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp |= P2C_RG_UART_EN;
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+
+	/* Set P2C_RG_USB20_DM_100K_EN */
+	tmp = readl(u2_banks->com + U3P_U2PHYACR4);
+	tmp |= P2C_RG_USB20_DM_100K_EN;
+	writel(tmp, u2_banks->com + U3P_U2PHYACR4);
+
+	/* Clear P2C_RG_DMPULLDOWN, P2C_RG_DPPULLDOWN */
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+	tmp &= ~(P2C_RG_DPPULLDOWN | P2C_RG_DMPULLDOWN);
+	writel(tmp, u2_banks->com + U3P_U2PHYDTM0);
+}
+
+static int u2_phy_instance_get_mode_ext(struct mtk_tphy *tphy, struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	u32 tmp;
+
+	tmp = readl(u2_banks->com + U3P_U2PHYDTM0);
+
+	if ((tmp & P2C_RG_UART_MODE) >> P2C_RG_UART_MODE_OFET)
+		return PHY_MODE_UART;
+	else
+		return PHY_MODE_USB_OTG;
+}
+
 static void u2_phy_instance_set_mode(struct mtk_tphy *tphy,
 				     struct mtk_phy_instance *instance,
 				     enum phy_mode mode)
@@ -609,6 +702,9 @@ static void u2_phy_instance_set_mode(struct mtk_tphy *tphy,
 
 	tmp = readl(u2_banks->com + U3P_U2PHYDTM1);
 	switch (mode) {
+	case PHY_MODE_UART:
+		u2_phy_instance_set_mode_2uart(u2_banks);
+		return;
 	case PHY_MODE_USB_DEVICE:
 		tmp |= P2C_FORCE_IDDIG | P2C_RG_IDDIG;
 		break;
@@ -933,6 +1029,10 @@ static int mtk_phy_init(struct phy *phy)
 		return ret;
 	}
 
+	ret = u2_phy_instance_get_mode_ext(tphy, instance);
+	if (ret == PHY_MODE_UART)
+		return 0;
+
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
 		u2_phy_instance_init(tphy, instance);
@@ -996,6 +1096,19 @@ static int mtk_phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int mtk_phy_get_mode_ext(struct phy *phy)
+{
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
+	int ret;
+
+	ret = 0;
+	if (instance->type == PHY_TYPE_USB2)
+		ret = u2_phy_instance_get_mode_ext(tphy, instance);
+
+	return ret;
+}
+
 static int mtk_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
@@ -1060,6 +1173,7 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 	.power_on	= mtk_phy_power_on,
 	.power_off	= mtk_phy_power_off,
 	.set_mode	= mtk_phy_set_mode,
+	.get_mode_ext	= mtk_phy_get_mode_ext,
 	.owner		= THIS_MODULE,
 };
 
-- 
1.7.9.5

