Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE38F3EB0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhHMG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:57:58 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41236 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239060AbhHMG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:57:56 -0400
X-UUID: 710e9d7bdf484ed5bd2daa8959c41652-20210813
X-UUID: 710e9d7bdf484ed5bd2daa8959c41652-20210813
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1997915322; Fri, 13 Aug 2021 14:57:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:57:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:57:25 +0800
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
Subject: [PATCH v2 27/29] iommu/mediatek: Initialise/Remove for multi bank dev
Date:   Fri, 13 Aug 2021 14:53:22 +0800
Message-ID: <20210813065324.29220-28-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers for each bank of the IOMMU base are in order, delta is
0x1000. Initialise the base for each bank.

For all the previous SoC, we only have bank0. thus use "do {} while()"
to allow bank0 always go.

When removing the device, Not always all the banks are initialised, it
depend on if there is masters for some banks. thus, use a register to
confirm this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ce83569eec21..142ee8f3a560 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -113,6 +113,7 @@
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
 #define MTK_PROTECT_PA_ALIGN			256
+#define MTK_IOMMU_BANK_SZ			0x1000
 
 #define PERICFG_IOMMU_1				0x714
 
@@ -945,11 +946,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
@@ -991,20 +992,31 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
-	bank->id = 0;
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
+		bank->id = i;
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
@@ -1089,7 +1101,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	struct mtk_iommu_bank_data *bank;
+	bool bank_hwinit;
+	int i;
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1101,7 +1115,18 @@ static int mtk_iommu_remove(struct platform_device *pdev)
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
-- 
2.18.0

