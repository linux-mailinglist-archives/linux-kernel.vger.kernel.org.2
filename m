Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15A3B7BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhF3Ck4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:40:56 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35500 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233644AbhF3Ckq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:40:46 -0400
X-UUID: 498bb3bb3b404ae8b658ed20d6647802-20210630
X-UUID: 498bb3bb3b404ae8b658ed20d6647802-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1818565443; Wed, 30 Jun 2021 10:38:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:38:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:38:13 +0800
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
Subject: [PATCH 23/24] iommu/mediatek: Add multi bank support
Date:   Wed, 30 Jun 2021 10:35:03 +0800
Message-ID: <20210630023504.18177-24-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers for each bank of the IOMMU base are in order, delta is
0x1000. Initialise the base for each bank.

Meanwhile, Each bank has some independent registers. thus,
backup/restore them for each a bank.

For all the previous SoC, we only have bank0. thus use "do {} while()"
to allow bank0 always go.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 78 +++++++++++++++++++++++++++++----------
 drivers/iommu/mtk_iommu.h |  6 +--
 2 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e297a50adced..3aaf425d5a18 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -114,6 +114,7 @@
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
 #define MTK_PROTECT_PA_ALIGN			256
+#define MTK_IOMMU_BANK_SZ			0x1000
 
 #define PERICFG_IOMMU_1				0x714
 
@@ -925,11 +926,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
 	struct resource         *res;
-	resource_size_t		ioaddr;
+	resource_size_t		ioaddr, size;
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     ret;
+	int                     ret, i = 0;
 	u32			val;
 	char                    *p;
 	struct mtk_iommu_bank_data *bank;
@@ -971,19 +972,30 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	size = resource_size(res);
+	if (size < data->plat_data->bank_nr * MTK_IOMMU_BANK_SZ) {
+		dev_err(dev, "banknr %d. res %pR is not enough.\n",
+			data->plat_data->bank_nr, res);
+		return -EINVAL;
+	}
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	ioaddr = res->start;
 
-	bank = &data->bank[0];
-	bank->base = base;
-	bank->irq = platform_get_irq(pdev, 0);
-	if (bank->irq < 0)
-		return bank->irq;
-	bank->pdev = dev;
-	bank->pdata = data;
-	spin_lock_init(&bank->tlb_lock);
+	do {
+		if (!data->plat_data->bank_enable[i])
+			continue;
+		bank = &data->bank[i];
+		bank->base = base + i * MTK_IOMMU_BANK_SZ;
+
+		bank->irq = platform_get_irq(pdev, i);
+		if (bank->irq < 0)
+			return bank->irq;
+		bank->pdev = dev;
+		bank->pdata = data;
+		spin_lock_init(&bank->tlb_lock);
+	} while (++i < data->plat_data->bank_nr);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
@@ -1068,7 +1080,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	struct mtk_iommu_bank_data *bank;
+	bool bank_hwinit;
+	int i;
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1080,7 +1094,18 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	devm_free_irq(&pdev->dev, bank->irq, bank);
+	for (i = 0; i < data->plat_data->bank_nr; i++) {
+		bank = &data->bank[i];
+		/*
+		 * Use a register value to confirm if this bank HW is initialised.
+		 * If the bank has no consumer, the bank HW still won't be
+		 * initialised even though bank_enable is true.
+		 */
+		bank_hwinit = !!readl_relaxed(bank->base + REG_MMU_PT_BASE_ADDR);
+		if (!bank_hwinit)
+			continue;
+		devm_free_irq(&pdev->dev, bank->irq, bank);
+	}
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
 }
@@ -1090,15 +1115,21 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->bank[0].base;
+	int i = 0;
 
 	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
 	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
-	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
-	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
-	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
 	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
+	do {
+		if (!data->plat_data->bank_enable[i])
+			continue;
+		base = data->bank[i].base;
+		reg->int_control0[i] = readl_relaxed(base + REG_MMU_INT_CONTROL0);
+		reg->int_main_control[i] = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
+		reg->ivrp_paddr[i] = readl_relaxed(base + REG_MMU_IVRP_PADDR);
+	} while (++i < data->plat_data->bank_nr);
 	clk_disable_unprepare(data->bclk);
 	return 0;
 }
@@ -1109,7 +1140,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
 	void __iomem *base = data->bank[0].base;
-	int ret;
+	int ret, i = 0;
 
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
@@ -1128,11 +1159,18 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
-	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
-	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
-	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
+	do {
+		if (!data->plat_data->bank_enable[i])
+			continue;
+		base = data->bank[i].base;
+		m4u_dom = data->bank[i].m4u_dom;
+		writel_relaxed(reg->int_control0[i], base + REG_MMU_INT_CONTROL0);
+		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
+		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
+		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
+		       base + REG_MMU_PT_BASE_ADDR);
+	} while (++i < data->plat_data->bank_nr);
 	return 0;
 }
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 8235957f1592..813e60de89d6 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -33,11 +33,11 @@ struct mtk_iommu_suspend_reg {
 	};
 	u32				dcm_dis;
 	u32				ctrl_reg;
-	u32				int_control0;
-	u32				int_main_control;
-	u32				ivrp_paddr;
 	u32				vld_pa_rng;
 	u32				wr_len_ctrl;
+	u32				int_control0[MTK_IOMMU_BANK_MAX];
+	u32				int_main_control[MTK_IOMMU_BANK_MAX];
+	u32				ivrp_paddr[MTK_IOMMU_BANK_MAX];
 };
 
 enum mtk_iommu_plat {
-- 
2.18.0

