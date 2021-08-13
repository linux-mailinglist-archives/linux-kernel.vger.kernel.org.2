Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4913EB0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhHMG4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:56:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239146AbhHMG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:56:18 -0400
X-UUID: d0d58c7e268748d19bb9c9bdade1ebde-20210813
X-UUID: d0d58c7e268748d19bb9c9bdade1ebde-20210813
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 461657805; Fri, 13 Aug 2021 14:55:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:55:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:55:47 +0800
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
Subject: [PATCH v2 17/29] iommu/mediatek: Add infra iommu support
Date:   Fri, 13 Aug 2021 14:53:12 +0800
Message-ID: <20210813065324.29220-18-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infra iommu enable bits in mt8195 is in the pericfg register segment,
use regmap to update it.

If infra iommu master translation fault, It don't have the larbid/portid,
thus print out the whole register value.

Since regmap_update_bits may fail, add return value for mtk_iommu_config.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 36 +++++++++++++++++++++++++++++-------
 drivers/iommu/mtk_iommu.h |  3 +++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a72241724adb..45b34f4e99fb 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -113,6 +113,8 @@
 
 #define MTK_PROTECT_PA_ALIGN			256
 
+#define PERICFG_IOMMU_1				0x714
+
 #define HAS_4GB_MODE			BIT(0)
 /* HW will use the EMI clock if there isn't the "bclk". */
 #define HAS_BCLK			BIT(1)
@@ -332,8 +334,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			data->dev,
-			"fault type=0x%x iova=0x%llx pa=0x%llx larb=%d port=%d layer=%d %s\n",
-			int_state, fault_iova, fault_pa, fault_larb, fault_port,
+			"fault type=0x%x iova=0x%llx pa=0x%llx master=0x%x(larb=%d port=%d) layer=%d %s\n",
+			int_state, fault_iova, fault_pa, regval, fault_larb, fault_port,
 			layer, write ? "write" : "read");
 	}
 
@@ -377,14 +379,15 @@ static int mtk_iommu_get_domain_id(struct device *dev,
 	return -EINVAL;
 }
 
-static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
-			     bool enable, unsigned int domid)
+static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
+			    bool enable, unsigned int domid)
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
-	int i;
+	u32 peri_mmuen, peri_mmuen_msk;
+	int i, ret = 0;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
@@ -404,8 +407,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
 			else
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+			peri_mmuen_msk = BIT(portid);
+			peri_mmuen = enable ? peri_mmuen_msk : 0;
+
+			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+						 peri_mmuen_msk, peri_mmuen);
+			if (ret)
+				dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
+					enable ? "enable" : "disable",
+					dev_name(data->dev), peri_mmuen_msk, ret);
 		}
 	}
+	return ret;
 }
 
 static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
@@ -518,8 +532,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		pm_runtime_put(m4udev);
 	}
 
-	mtk_iommu_config(data, dev, true, domid);
-	return 0;
+	return mtk_iommu_config(data, dev, true, domid);
 }
 
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
@@ -940,6 +953,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
 		if (ret)
 			goto out_runtime_disable;
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   data->plat_data->pericfg_comp_str) {
+		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
+		if (IS_ERR(infracfg)) {
+			ret = PTR_ERR(infracfg);
+			goto out_runtime_disable;
+		}
+
+		data->pericfg = infracfg;
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 5b32277fee99..676d306af046 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -55,6 +55,7 @@ struct mtk_iommu_plat_data {
 	u32                 flags;
 	u32                 inv_sel_reg;
 
+	char					*pericfg_comp_str;
 	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
@@ -80,6 +81,8 @@ struct mtk_iommu_data {
 	struct device			*smicomm_dev;
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
+	struct regmap			*pericfg;
+
 
 	/*
 	 * In the sharing pgtable case, list data->list to the global list like m4ulist.
-- 
2.18.0

