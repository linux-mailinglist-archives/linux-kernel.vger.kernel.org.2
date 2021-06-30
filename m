Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA063B7BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhF3Ck2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:40:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35421 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233523AbhF3CkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:40:25 -0400
X-UUID: 4727b3d5ef924559995186802ca6e1e4-20210630
X-UUID: 4727b3d5ef924559995186802ca6e1e4-20210630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2113740949; Wed, 30 Jun 2021 10:37:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:37:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:37:52 +0800
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
Subject: [PATCH 19/24] iommu/mediatek: Initialise bank HW for each a bank
Date:   Wed, 30 Jun 2021 10:34:59 +0800
Message-ID: <20210630023504.18177-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt8195 IOMMU HW max support 5 banks, and regarding the banks'
registers, it looks like:

 ----------------------------------------
 |bank0  | bank1 | bank2 | bank3 | bank4|
 ----------------------------------------
 |global |
 |control|         null
 |regs   |
 -----------------------------------------
 |bank   |bank   |bank   |bank   |bank   |
 |regs   |regs   |regs   |regs   |regs   |
 |       |       |       |       |       |
 -----------------------------------------

Each bank has some special bank registers and it share bank0's global
control registers. this patch initialise the bank hw with the bankid.

In the hw_init, we always initialise bank0's control register since
we don't know if the bank0 is initialised.

Additionally, About each bank's register base, always delta 0x1000.
like bank[x + 1] = bank[x] + 0x1000.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 78c458bb8cc8..ed3cf75850ce 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -154,7 +154,7 @@ struct mtk_iommu_domain {
 
 static const struct iommu_ops mtk_iommu_ops;
 
-static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
+static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
 
 #define MTK_IOMMU_TLB_ADDR(iova) ({					\
 	dma_addr_t _addr = iova;					\
@@ -523,12 +523,12 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		dom->bank = bank;
 	}
 
-	if (!bank->m4u_dom) { /* Initialize the M4U HW */
+	if (!bank->m4u_dom) { /* Initialize the M4U HW for each a BANK */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
 			return ret;
 
-		ret = mtk_iommu_hw_init(data);
+		ret = mtk_iommu_hw_init(data, bankid);
 		if (ret) {
 			pm_runtime_put(m4udev);
 			return ret;
@@ -737,11 +737,16 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
+static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid)
 {
+	const struct mtk_iommu_bank_data *bankx = &data->bank[bankid];
 	const struct mtk_iommu_bank_data *bank0 = &data->bank[0];
 	u32 regval;
 
+	/*
+	 * global control setting is in bank0. May re-init these global registers
+	 * since no sure if there is bank0 consumers.
+	 */
 	if (data->plat_data->m4u_plat == M4U_MT8173) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
@@ -784,13 +789,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, bank0->base + REG_MMU_MISC_CTRL);
 
+	/* independent setting for each bank */
 	regval = F_L2_MULIT_HIT_EN |
 		F_TABLE_WALK_FAULT_INT_EN |
 		F_PREETCH_FIFO_OVERFLOW_INT_EN |
 		F_MISS_FIFO_OVERFLOW_INT_EN |
 		F_PREFETCH_FIFO_ERR_INT_EN |
 		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, bank0->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, bankx->base + REG_MMU_INT_CONTROL0);
 
 	regval = F_INT_TRANSLATION_FAULT |
 		F_INT_MAIN_MULTI_HIT_FAULT |
@@ -799,19 +805,19 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_TLB_MISS_FAULT |
 		F_INT_MISS_TRANSACTION_FIFO_FAULT |
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, bank0->base + REG_MMU_INT_MAIN_CONTROL);
+	writel_relaxed(regval, bankx->base + REG_MMU_INT_MAIN_CONTROL);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, bank0->base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(regval, bankx->base + REG_MMU_IVRP_PADDR);
 
-	if (devm_request_irq(bank0->pdev, bank0->irq, mtk_iommu_isr, 0,
-			     dev_name(bank0->pdev), (void *)bank0)) {
-		writel_relaxed(0, bank0->base + REG_MMU_PT_BASE_ADDR);
-		dev_err(bank0->pdev, "Failed @ IRQ-%d Request\n", bank0->irq);
+	if (devm_request_irq(bankx->pdev, bankx->irq, mtk_iommu_isr, 0,
+			     dev_name(bankx->pdev), (void *)bankx)) {
+		writel_relaxed(0, bankx->base + REG_MMU_PT_BASE_ADDR);
+		dev_err(bankx->pdev, "Failed @ IRQ-%d Request\n", bankx->irq);
 		return -ENODEV;
 	}
 
-- 
2.18.0

