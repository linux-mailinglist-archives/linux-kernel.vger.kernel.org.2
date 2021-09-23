Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F29415DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhIWMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:04:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53974 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240886AbhIWMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:04:06 -0400
X-UUID: 268fe6756faf4885b84abd2d1afd736f-20210923
X-UUID: 268fe6756faf4885b84abd2d1afd736f-20210923
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 157916079; Thu, 23 Sep 2021 20:02:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:02:30 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:02:30 +0800
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
Subject: [PATCH v3 22/33] iommu/mediatek: Add PCIe support
Date:   Thu, 23 Sep 2021 19:58:29 +0800
Message-ID: <20210923115840.17813-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code for of_iommu_configure_dev_id is like this:

static int of_iommu_configure_dev_id(struct device_node *master_np,
                                     struct device *dev,
                                     const u32 *id)
{
       struct of_phandle_args iommu_spec = { .args_count = 1 };

       err = of_map_id(master_np, *id, "iommu-map",
                       "iommu-map-mask", &iommu_spec.np,
                       iommu_spec.args);
...
}

It supports only one id output. BUT our PCIe HW has two ID(one is for
writing, the other is for reading). I'm not sure if we should change
of_map_id to support output MAX_PHANDLE_ARGS.

Here add the solution in ourselve drivers. If it's pcie case, enable one
more bit.

Not all infra iommu support PCIe, thus add a PCIe support flag here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 37d6dfb4feab..3f1fd8036345 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -20,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -132,6 +133,7 @@
 #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
 #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
 #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
+#define IFA_IOMMU_PCIe_SUPPORT		BIT(15)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
 
@@ -401,8 +403,11 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
 		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
 			peri_mmuen_msk = BIT(portid);
-			peri_mmuen = enable ? peri_mmuen_msk : 0;
+			/* PCIdev has only one output id, enable the next writing bit for PCIe */
+			if (dev_is_pci(dev))
+				peri_mmuen_msk |= BIT(portid + 1);
 
+			peri_mmuen = enable ? peri_mmuen_msk : 0;
 			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
 						 peri_mmuen_msk, peri_mmuen);
 			if (ret)
@@ -977,6 +982,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
 			goto out_bus_set_null;
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
+		#ifdef CONFIG_PCI
+		if (!iommu_present(&pci_bus_type)) {
+			ret = bus_set_iommu(&pci_bus_type, &mtk_iommu_ops);
+			if (ret) /* PCIe fail don't affect platform_bus. */
+				goto out_list_del;
+		}
+		#endif
 	}
 	return ret;
 
@@ -1007,6 +1021,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
+		#ifdef CONFIG_PCI
+		bus_set_iommu(&pci_bus_type, NULL);
+		#endif
 	}
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
-- 
2.18.0

