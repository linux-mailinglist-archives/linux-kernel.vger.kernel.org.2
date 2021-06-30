Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8343B7BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhF3Cj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:39:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34656 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233314AbhF3Cj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:39:27 -0400
X-UUID: 2aecd9030323478bbba8906fa855105d-20210630
X-UUID: 2aecd9030323478bbba8906fa855105d-20210630
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 495518006; Wed, 30 Jun 2021 10:36:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:36:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:36:54 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH 12/24] iommu/mediatek: Add IOMMU_TYPE flag
Date:   Wed, 30 Jun 2021 10:34:52 +0800
Message-ID: <20210630023504.18177-13-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has no functional change, It only adds MM IOMMU_TYPE for
the previous SoC. All the current supported HW are for MM(multimedia)
engines.

In the mt8195, we have another IOMMU_TYPE: infra iommu, and there is
another APU_IOMMU, thus, use 2bits for the IOMMU_TYPE.

For the other IOMMU TYPEs, it doesn't have the "larb""port". thus, I use
the MM flag contain the MM_IOMMU special code, Also, it moves a big
chunk code about parsing the mediatek,larbs into a function, it only
needed for MM IOMMU.

this is preparing for supporting INFRA_IOMMU, and APU_IOMMU later.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 202 ++++++++++++++++++++++----------------
 1 file changed, 117 insertions(+), 85 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b770cb5893b2..365732309486 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -128,9 +128,17 @@
 #define SHARE_PGTABLE			BIT(10) /* 2 HW share pgtable */
 #define DCM_DISABLE			BIT(11)
 #define NOT_STD_AXI_MODE		BIT(12)
+/* 2 bits: iommu type */
+#define MTK_IOMMU_TYPE_MM		(0x0 << 13)
+#define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
+#define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
 
-#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
-		((((pdata)->flags) & (_x)) == (_x))
+#define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
+
+#define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
+				((((pdata)->flags) & (mask)) == (_x))
+#define MTK_IOMMU_IS_TYPE(pdata, _x)	MTK_IOMMU_HAS_FLAG_MASK(pdata, _x,\
+							MTK_IOMMU_TYPE_MASK)
 
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
@@ -270,7 +278,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
 	struct mtk_iommu_data *data = dev_id;
 	struct mtk_iommu_domain *dom = data->m4u_dom;
-	unsigned int fault_larb, fault_port, sub_comm = 0;
+	unsigned int fault_larb = 0, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
@@ -296,17 +304,19 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	pa34_32 = FIELD_GET(F_MMU_INVAL_PA_34_32_MASK, fault_iova);
 	fault_pa |= (u64)pa34_32 << 32;
 
-	fault_port = F_MMU_INT_ID_PORT_ID(regval);
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
-		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
-		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
-	} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
-		fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
-		sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
-	} else {
-		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
+			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
+			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+		} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
+			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
+			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
+		} else {
+			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+		}
+		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
-	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
@@ -370,19 +380,21 @@ static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
 
-		larb_mmu = &data->larb_imu[larbid];
+		if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+			larb_mmu = &data->larb_imu[larbid];
 
-		region = data->plat_data->iova_region + domid;
-		larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
+			region = data->plat_data->iova_region + domid;
+			larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
 
-		dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
-			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
-			portid, domid, larb_mmu->bank[portid]);
+			dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
+				enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+				portid, domid, larb_mmu->bank[portid]);
 
-		if (enable)
-			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
-		else
-			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+			if (enable)
+				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
+			else
+				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		}
 	}
 }
 
@@ -783,19 +795,75 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 	.unbind		= mtk_iommu_unbind,
 };
 
+static int mtk_iommu_mm_dts_parse(struct device *dev,
+				  struct component_match **match,
+				  struct mtk_iommu_data *data)
+{
+	struct platform_device	*plarbdev;
+	struct device_link	*link;
+	struct device_node *larbnode, *smicomm_node;
+	int i, larb_nr, ret;
+
+	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
+	if (larb_nr < 0)
+		return larb_nr;
+
+	for (i = 0; i < larb_nr; i++) {
+		u32 id;
+
+		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
+		if (!larbnode)
+			return -EINVAL;
+
+		if (!of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
+			continue;
+		}
+
+		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
+		if (ret)/* The id is consecutive if there is no this property */
+			id = i;
+
+		plarbdev = of_find_device_by_node(larbnode);
+		if (!plarbdev) {
+			of_node_put(larbnode);
+			return -EPROBE_DEFER;
+		}
+		data->larb_imu[id].dev = &plarbdev->dev;
+
+		component_match_add_release(dev, match, release_of,
+					    compare_of, larbnode);
+	}
+
+	/* Get smi-common dev from the last larb. */
+	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+	if (!smicomm_node)
+		return -EINVAL;
+
+	plarbdev = of_find_device_by_node(smicomm_node);
+	of_node_put(smicomm_node);
+	data->smicomm_dev = &plarbdev->dev;
+
+	link = device_link_add(data->smicomm_dev, dev,
+			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+
+	if (!link) {
+		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
+		return PTR_ERR(link);
+	}
+	return 0;
+}
+
 static int mtk_iommu_probe(struct platform_device *pdev)
 {
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
-	struct device_node	*larbnode, *smicomm_node;
-	struct platform_device	*plarbdev;
-	struct device_link	*link;
 	struct resource         *res;
 	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     i, larb_nr, ret;
+	int                     ret;
 	u32			val;
 	char                    *p;
 
@@ -850,55 +918,12 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			return PTR_ERR(data->bclk);
 	}
 
-	larb_nr = of_count_phandle_with_args(dev->of_node,
-					     "mediatek,larbs", NULL);
-	if (larb_nr < 0)
-		return larb_nr;
-
-	for (i = 0; i < larb_nr; i++) {
-		u32 id;
-
-		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
-		if (!larbnode)
-			return -EINVAL;
-
-		if (!of_device_is_available(larbnode)) {
-			of_node_put(larbnode);
-			continue;
-		}
-
-		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
-		if (ret)/* The id is consecutive if there is no this property */
-			id = i;
-
-		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev) {
-			of_node_put(larbnode);
-			return -EPROBE_DEFER;
-		}
-		data->larb_imu[id].dev = &plarbdev->dev;
-
-		component_match_add_release(dev, &match, release_of,
-					    compare_of, larbnode);
-	}
-
-	/* Get smi-common dev from the last larb. */
-	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smicomm_node)
-		return -EINVAL;
-
-	plarbdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
-	data->smicomm_dev = &plarbdev->dev;
-
 	pm_runtime_enable(dev);
 
-	link = device_link_add(data->smicomm_dev, dev,
-			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
-	if (!link) {
-		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		ret = -EINVAL;
-		goto out_runtime_disable;
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
+		if (ret)
+			goto out_runtime_disable;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -929,9 +954,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_list_del;
 	}
 
-	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
-	if (ret)
-		goto out_bus_set_null;
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+		if (ret)
+			goto out_bus_set_null;
+	}
 	return ret;
 
 out_bus_set_null:
@@ -942,7 +969,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
-	device_link_remove(data->smicomm_dev, dev);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -959,7 +987,8 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 		bus_set_iommu(&platform_bus_type, NULL);
 
 	clk_disable_unprepare(data->bclk);
-	device_link_remove(data->smicomm_dev, &pdev->dev);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+		device_link_remove(data->smicomm_dev, &pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
@@ -1026,7 +1055,7 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE |
-			NOT_STD_AXI_MODE,
+			NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
@@ -1037,7 +1066,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
 	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
-			 NOT_STD_AXI_MODE,
+			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1046,7 +1075,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 
 static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
-	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
+	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
+			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1056,7 +1086,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
-			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
+			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
+			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1065,7 +1096,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
-	.flags        = RESET_AXI,
+	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1075,7 +1106,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
-			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE,
+			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
+			  MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
-- 
2.18.0

