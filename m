Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A173C98EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhGOGva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:51:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39288 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231527AbhGOGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:51:26 -0400
X-UUID: 9220052c425b40509788b52740f6511d-20210715
X-UUID: 9220052c425b40509788b52740f6511d-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2078355908; Thu, 15 Jul 2021 14:48:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 14:48:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 14:48:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v3 2/3] phy: phy-mtk-tphy: support new hardware version
Date:   Thu, 15 Jul 2021 14:48:21 +0800
Message-ID: <1626331702-27825-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626331702-27825-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626331702-27825-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHYA arch is updated, and doesn't support slew rate calibrate
anymore on 7nm or advanced process, add a new version number to
support it.
Note: the FreqMeter bank is not used but reserved.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 40 +++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 731c483a04de..42a1174da6cc 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -27,7 +27,8 @@
 #define SSUSB_SIFSLV_V1_U3PHYD		0x000
 #define SSUSB_SIFSLV_V1_U3PHYA		0x200
 
-/* version V2 sub-banks offset base address */
+/* version V2/V3 sub-banks offset base address */
+/* V3: U2FREQ is not used anymore, but reserved */
 /* u2 phy banks */
 #define SSUSB_SIFSLV_V2_MISC		0x000
 #define SSUSB_SIFSLV_V2_U2FREQ		0x100
@@ -270,6 +271,7 @@
 enum mtk_phy_version {
 	MTK_PHY_V1 = 1,
 	MTK_PHY_V2,
+	MTK_PHY_V3,
 };
 
 struct mtk_phy_pdata {
@@ -330,6 +332,10 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	int fm_out;
 	u32 tmp;
 
+	/* HW V3 doesn't support slew rate cal anymore */
+	if (tphy->pdata->version == MTK_PHY_V3)
+		return;
+
 	/* use force value */
 	if (instance->eye_src)
 		return;
@@ -878,7 +884,7 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 		writel(tmp, com + U3P_U2PHYBC12C);
 	}
 
-	if (instance->eye_src) {
+	if (tphy->pdata->version < MTK_PHY_V3 && instance->eye_src) {
 		tmp = readl(com + U3P_USBPHYACR5);
 		tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
 		tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(instance->eye_src);
@@ -1042,11 +1048,15 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (tphy->pdata->version == MTK_PHY_V1) {
+	switch (tphy->pdata->version) {
+	case MTK_PHY_V1:
 		phy_v1_banks_init(tphy, instance);
-	} else if (tphy->pdata->version == MTK_PHY_V2) {
+		break;
+	case MTK_PHY_V2:
+	case MTK_PHY_V3:
 		phy_v2_banks_init(tphy, instance);
-	} else {
+		break;
+	default:
 		dev_err(dev, "phy version is not supported\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -1075,6 +1085,10 @@ static const struct mtk_phy_pdata tphy_v2_pdata = {
 	.version = MTK_PHY_V2,
 };
 
+static const struct mtk_phy_pdata tphy_v3_pdata = {
+	.version = MTK_PHY_V3,
+};
+
 static const struct mtk_phy_pdata mt8173_pdata = {
 	.avoid_rx_sen_degradation = true,
 	.version = MTK_PHY_V1,
@@ -1086,6 +1100,7 @@ static const struct of_device_id mtk_tphy_id_table[] = {
 	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
 	{ .compatible = "mediatek,generic-tphy-v1", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,generic-tphy-v2", .data = &tphy_v2_pdata },
+	{ .compatible = "mediatek,generic-tphy-v3", .data = &tphy_v3_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_tphy_id_table);
@@ -1129,12 +1144,15 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		}
 	}
 
-	tphy->src_ref_clk = U3P_REF_CLK;
-	tphy->src_coef = U3P_SLEW_RATE_COEF;
-	/* update parameters of slew rate calibrate if exist */
-	device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
-		&tphy->src_ref_clk);
-	device_property_read_u32(dev, "mediatek,src-coef", &tphy->src_coef);
+	if (tphy->pdata->version < MTK_PHY_V3) {
+		tphy->src_ref_clk = U3P_REF_CLK;
+		tphy->src_coef = U3P_SLEW_RATE_COEF;
+		/* update parameters of slew rate calibrate if exist */
+		device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
+					 &tphy->src_ref_clk);
+		device_property_read_u32(dev, "mediatek,src-coef",
+					 &tphy->src_coef);
+	}
 
 	port = 0;
 	for_each_child_of_node(np, child_np) {
-- 
2.18.0

