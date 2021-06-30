Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2653B7BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhF3Cjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:39:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232714AbhF3Cjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:39:46 -0400
X-UUID: e2e00aae97f94ee98b64e34473523dea-20210630
X-UUID: e2e00aae97f94ee98b64e34473523dea-20210630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1404309989; Wed, 30 Jun 2021 10:37:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:37:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:37:11 +0800
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
Subject: [PATCH 14/24] iommu/mediatek: Add PCIe support
Date:   Wed, 30 Jun 2021 10:34:54 +0800
Message-ID: <20210630023504.18177-15-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
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

it can only support only one id output. BUT our PCIe HW has two ID(one is
for writing, the other is for reading). I'm not sure if we should change
of_map_id to support output MAX_PHANDLE_ARGS.

In this patch I add the solution in ourselve drivers. If it's pcie case,
enable one more bit.

Not all infra iommu support PCIe, thus I add a PCIe support flag here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1b62896c6666..33303243771b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -134,6 +135,7 @@
 #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
 #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
 #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
+#define IFA_IOMMU_PCIe_SUPPORT		BIT(15)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
 
@@ -399,8 +401,12 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
 		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
 			peri_mmuen_msk = BIT(portid);
-			peri_mmuen = enable ? peri_mmuen_msk : 0;
 
+			/* PCIdev has only one output id, enable the next writing bit for PCIe */
+			if (dev_is_pci(dev))
+				peri_mmuen_msk |= BIT(portid + 1);
+
+			peri_mmuen = enable ? peri_mmuen_msk : 0;
 			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
 						 peri_mmuen_msk, peri_mmuen);
 			if (ret)
@@ -980,6 +986,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
 
-- 
2.18.0

