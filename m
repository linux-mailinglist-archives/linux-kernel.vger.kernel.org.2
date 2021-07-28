Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C53D893E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhG1H7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:59:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42910 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234825AbhG1H7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:59:11 -0400
X-UUID: 1ca566b1202e42e8956119e4c0a9a4f6-20210728
X-UUID: 1ca566b1202e42e8956119e4c0a9a4f6-20210728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 139955483; Wed, 28 Jul 2021 15:59:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 15:59:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 15:59:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 2/9] phy: phy-mtk-tphy: use clock bulk to get clocks
Date:   Wed, 28 Jul 2021 15:58:24 +0800
Message-ID: <1627459111-2907-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clock bulk helpers to get/enable/disable clocks

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 43 +++++++++--------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 33000b38fd1b..3259210f08a1 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -280,6 +280,8 @@
 #define RG_CDR_BIRLTD0_GEN3_MSK		GENMASK(4, 0)
 #define RG_CDR_BIRLTD0_GEN3_VAL(x)	(0x1f & (x))
 
+#define TPHY_CLKS_CNT	2
+
 enum mtk_phy_version {
 	MTK_PHY_V1 = 1,
 	MTK_PHY_V2,
@@ -318,8 +320,7 @@ struct mtk_phy_instance {
 		struct u2phy_banks u2_banks;
 		struct u3phy_banks u3_banks;
 	};
-	struct clk *ref_clk;	/* reference clock of (digital) phy */
-	struct clk *da_ref_clk;	/* reference clock of analog phy */
+	struct clk_bulk_data clks[TPHY_CLKS_CNT];
 	u32 index;
 	u8 type;
 	int eye_src;
@@ -974,18 +975,9 @@ static int mtk_phy_init(struct phy *phy)
 	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
-	ret = clk_prepare_enable(instance->ref_clk);
-	if (ret) {
-		dev_err(tphy->dev, "failed to enable ref_clk\n");
+	ret = clk_bulk_prepare_enable(TPHY_CLKS_CNT, instance->clks);
+	if (ret)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(instance->da_ref_clk);
-	if (ret) {
-		dev_err(tphy->dev, "failed to enable da_ref\n");
-		clk_disable_unprepare(instance->ref_clk);
-		return ret;
-	}
 
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
@@ -1003,8 +995,7 @@ static int mtk_phy_init(struct phy *phy)
 		break;
 	default:
 		dev_err(tphy->dev, "incompatible PHY type\n");
-		clk_disable_unprepare(instance->ref_clk);
-		clk_disable_unprepare(instance->da_ref_clk);
+		clk_bulk_disable_unprepare(TPHY_CLKS_CNT, instance->clks);
 		return -EINVAL;
 	}
 
@@ -1047,8 +1038,7 @@ static int mtk_phy_exit(struct phy *phy)
 	if (instance->type == PHY_TYPE_USB2)
 		u2_phy_instance_exit(tphy, instance);
 
-	clk_disable_unprepare(instance->ref_clk);
-	clk_disable_unprepare(instance->da_ref_clk);
+	clk_bulk_disable_unprepare(TPHY_CLKS_CNT, instance->clks);
 	return 0;
 }
 
@@ -1211,6 +1201,7 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	port = 0;
 	for_each_child_of_node(np, child_np) {
 		struct mtk_phy_instance *instance;
+		struct clk_bulk_data *clks;
 		struct phy *phy;
 
 		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
@@ -1247,20 +1238,12 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, instance);
 		port++;
 
-		instance->ref_clk = devm_clk_get_optional(&phy->dev, "ref");
-		if (IS_ERR(instance->ref_clk)) {
-			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
-			retval = PTR_ERR(instance->ref_clk);
+		clks = instance->clks;
+		clks[0].id = "ref";     /* digital (& analog) clock */
+		clks[1].id = "da_ref";  /* analog clock */
+		retval = devm_clk_bulk_get_optional(&phy->dev, TPHY_CLKS_CNT, clks);
+		if (retval)
 			goto put_child;
-		}
-
-		instance->da_ref_clk =
-			devm_clk_get_optional(&phy->dev, "da_ref");
-		if (IS_ERR(instance->da_ref_clk)) {
-			dev_err(dev, "failed to get da_ref_clk(id-%d)\n", port);
-			retval = PTR_ERR(instance->da_ref_clk);
-			goto put_child;
-		}
 	}
 
 	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
-- 
2.18.0

