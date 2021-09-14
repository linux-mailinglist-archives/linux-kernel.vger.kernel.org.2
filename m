Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6240AC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhINLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:39:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33854 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232288AbhINLjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:39:48 -0400
X-UUID: 5defdafebb5a45a5b90608dfd5dd7e56-20210914
X-UUID: 5defdafebb5a45a5b90608dfd5dd7e56-20210914
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1890404416; Tue, 14 Sep 2021 19:38:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:38:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:38:24 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v4 07/13] memory: mtk-smi: Add device link for smi-sub-common
Date:   Tue, 14 Sep 2021 19:36:57 +0800
Message-ID: <20210914113703.31466-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt8195, there are some larbs connect with the smi-sub-common, then
connect with smi-common.

Before we create device link between smi-larb with smi-common. If we have
sub-common, we should use device link the smi-larb and smi-sub-common,
then use device link between the smi-sub-common with smi-common. This is
for enabling clock/power automatically.

Move the device link code to a new interface for reusing.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 75 +++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b362d528944e..5c2bd5795cfd 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -61,7 +61,8 @@
 
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
-	MTK_SMI_GEN2
+	MTK_SMI_GEN2,		/* gen2 smi common */
+	MTK_SMI_GEN2_SUB_COMM,	/* gen2 smi sub common */
 };
 
 #define MTK_SMI_CLK_NR_MAX			4
@@ -99,13 +100,14 @@ struct mtk_smi {
 		void __iomem		*smi_ao_base; /* only for gen1 */
 		void __iomem		*base;	      /* only for gen2 */
 	};
+	struct device			*smi_common_dev; /* for sub common */
 	const struct mtk_smi_common_plat *plat;
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
 	struct mtk_smi			smi;
 	void __iomem			*base;
-	struct device			*smi_common_dev;
+	struct device			*smi_common_dev; /* common or sub-common dev */
 	const struct mtk_smi_larb_gen	*larb_gen;
 	int				larbid;
 	u32				*mmu;
@@ -268,6 +270,38 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
+{
+	struct platform_device *smi_com_pdev;
+	struct device_node *smi_com_node;
+	struct device *smi_com_dev;
+	struct device_link *link;
+
+	smi_com_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
+	if (!smi_com_node)
+		return -EINVAL;
+
+	smi_com_pdev = of_find_device_by_node(smi_com_node);
+	of_node_put(smi_com_node);
+	if (smi_com_pdev) {
+		/* smi common is the supplier, Make sure it is ready before */
+		if (!platform_get_drvdata(smi_com_pdev))
+			return -EPROBE_DEFER;
+		smi_com_dev = &smi_com_pdev->dev;
+		link = device_link_add(dev, smi_com_dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+		if (!link) {
+			dev_err(dev, "Unable to link smi-common dev\n");
+			return -ENODEV;
+		}
+		*com_dev = smi_com_dev;
+	} else {
+		dev_err(dev, "Failed to get the smi_common device\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 				const char * const clks[],
 				unsigned int clk_nr_required,
@@ -294,9 +328,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct mtk_smi_larb *larb;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct device_node *smi_node;
-	struct platform_device *smi_pdev;
-	struct device_link *link;
 	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
@@ -315,26 +346,10 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return ret;
 
 	larb->smi.dev = dev;
-	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
-	if (!smi_node)
-		return -EINVAL;
 
-	smi_pdev = of_find_device_by_node(smi_node);
-	of_node_put(smi_node);
-	if (smi_pdev) {
-		if (!platform_get_drvdata(smi_pdev))
-			return -EPROBE_DEFER;
-		larb->smi_common_dev = &smi_pdev->dev;
-		link = device_link_add(dev, larb->smi_common_dev,
-				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
-		if (!link) {
-			dev_err(dev, "Unable to link smi-common dev\n");
-			return -ENODEV;
-		}
-	} else {
-		dev_err(dev, "Failed to get the smi_common device\n");
-		return -EINVAL;
-	}
+	ret = mtk_smi_device_link_common(dev, &larb->smi_common_dev);
+	if (ret < 0)
+		return ret;
 
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, larb);
@@ -483,6 +498,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 	}
+
+	/* link its smi-common if this is smi-sub-common */
+	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
+		ret = mtk_smi_device_link_common(dev, &common->smi_common_dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
 	return 0;
@@ -490,6 +513,10 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 
 static int mtk_smi_common_remove(struct platform_device *pdev)
 {
+	struct mtk_smi *common = dev_get_drvdata(&pdev->dev);
+
+	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
+		device_link_remove(&pdev->dev, common->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
2.18.0

