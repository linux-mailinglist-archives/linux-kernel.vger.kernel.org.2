Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA42415DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbhIWME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:04:28 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240910AbhIWMEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:04:21 -0400
X-UUID: 09fc003662a94e939a962b14f57e687e-20210923
X-UUID: 09fc003662a94e939a962b14f57e687e-20210923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1668451898; Thu, 23 Sep 2021 20:02:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:02:47 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:02:46 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <yen-chang.chen@mediatek.com>
Subject: [PATCH v3 24/33] iommu/mediatek: Only adjust code about register base
Date:   Thu, 23 Sep 2021 19:58:31 +0800
Message-ID: <20210923115840.17813-25-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Use "base" instead of the data->base. This is
avoid to touch too many lines in the next patches.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 51 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index df823ee3541a..725e000eee0f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -221,6 +221,7 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
+	void __iomem *base = data->base;
 	unsigned long flags;
 
 	/*
@@ -228,9 +229,8 @@ static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 	 * when entering here.
 	 */
 	spin_lock_irqsave(&data->tlb_lock, flags);
-	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
-		       data->base + data->plat_data->inv_sel_reg);
-	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
+	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + data->plat_data->inv_sel_reg);
+	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
 	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
@@ -241,6 +241,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 	struct list_head *head = data->hw_list;
 	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
+	void __iomem *base;
 	int ret;
 	u32 tmp;
 
@@ -250,23 +251,23 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 				continue;
 		}
 
+		base = data->base;
+
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
-			       data->base + data->plat_data->inv_sel_reg);
+			       base + data->plat_data->inv_sel_reg);
 
-		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova),
-			       data->base + REG_MMU_INVLD_START_A);
+		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base + REG_MMU_INVLD_START_A);
 		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
-			       data->base + REG_MMU_INVLD_END_A);
-		writel_relaxed(F_MMU_INV_RANGE,
-			       data->base + REG_MMU_INVALIDATE);
+			       base + REG_MMU_INVLD_END_A);
+		writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
 
 		/* tlb sync */
-		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
+		ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE,
 						tmp, tmp != 0, 10, 1000);
 
 		/* Clear the CPE status */
-		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
+		writel_relaxed(0, base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
 
 		if (ret) {
@@ -286,23 +287,25 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	struct mtk_iommu_domain *dom = data->m4u_dom;
 	unsigned int fault_larb = 0, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
+	const struct mtk_iommu_plat_data *plat_data = data->plat_data;
+	void __iomem *base = data->base;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
 
 	/* Read error info from registers */
-	int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
+	int_state = readl_relaxed(base + REG_MMU_FAULT_ST1);
 	if (int_state & F_REG_MMU0_FAULT_MASK) {
-		regval = readl_relaxed(data->base + REG_MMU0_INT_ID);
-		fault_iova = readl_relaxed(data->base + REG_MMU0_FAULT_VA);
-		fault_pa = readl_relaxed(data->base + REG_MMU0_INVLD_PA);
+		regval = readl_relaxed(base + REG_MMU0_INT_ID);
+		fault_iova = readl_relaxed(base + REG_MMU0_FAULT_VA);
+		fault_pa = readl_relaxed(base + REG_MMU0_INVLD_PA);
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU1_INT_ID);
-		fault_iova = readl_relaxed(data->base + REG_MMU1_FAULT_VA);
-		fault_pa = readl_relaxed(data->base + REG_MMU1_INVLD_PA);
+		regval = readl_relaxed(base + REG_MMU1_INT_ID);
+		fault_iova = readl_relaxed(base + REG_MMU1_FAULT_VA);
+		fault_pa = readl_relaxed(base + REG_MMU1_INVLD_PA);
 	}
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, IOVA_34_EN)) {
+	if (MTK_IOMMU_HAS_FLAG(plat_data, IOVA_34_EN)) {
 		va34_32 = FIELD_GET(F_MMU_INVAL_VA_34_32_MASK, fault_iova);
 		fault_iova = fault_iova & F_MMU_INVAL_VA_31_12_MASK;
 		fault_iova |= (u64)va34_32 << 32;
@@ -310,12 +313,12 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	pa34_32 = FIELD_GET(F_MMU_INVAL_PA_34_32_MASK, fault_iova);
 	fault_pa |= (u64)pa34_32 << 32;
 
-	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
 		fault_port = F_MMU_INT_ID_PORT_ID(regval);
-		if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
+		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
-		} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
+		} else if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_3BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 		} else {
@@ -334,9 +337,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	}
 
 	/* Interrupt clear */
-	regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
+	regval = readl_relaxed(base + REG_MMU_INT_CONTROL0);
 	regval |= F_INT_CLR_BIT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, base + REG_MMU_INT_CONTROL0);
 
 	mtk_iommu_tlb_flush_all(data);
 
-- 
2.18.0

