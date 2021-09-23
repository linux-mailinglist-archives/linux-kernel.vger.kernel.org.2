Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07177415D75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhIWMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:02:53 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240821AbhIWMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:02:49 -0400
X-UUID: 0910dc122d474a15a1ae037b6dd89fee-20210923
X-UUID: 0910dc122d474a15a1ae037b6dd89fee-20210923
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1928541220; Thu, 23 Sep 2021 20:01:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:01:10 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:01:09 +0800
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
Subject: [PATCH v3 13/33] iommu/mediatek: Remove the power status checking in tlb flush all
Date:   Thu, 23 Sep 2021 19:58:20 +0800
Message-ID: <20210923115840.17813-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the code, Remove the power status checking in the
tlb_flush_all, remove this:
   if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

After this patch, the mtk_iommu_tlb_flush_all will be called from
a) isr
b) pm runtime resume callback
c) tlb flush range fail case
d) iommu_create_device_direct_mappings
   -> iommu_flush_iotlb_all
In first three cases, the power and clock always are enabled; d) is direct
mapping, the tlb flush is unnecessay since we already have tlb_flush_all
in the pm_runtime_resume callback. When the iommu's power status is
changed to active, the tlb always is clean.

In addition, there still are 2 reasons that don't add PM status checking
in the tlb flush all:
a) Write tlb flush all register also is ok even though the HW has no
power and clocks. Write ignore.
b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
is called frm pm_runtime_resume cb. From this point, we can not add
this code above in this tlb_flush_all.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e9e94944ed91..4a33b6c6b1db 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -204,10 +204,14 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 	return container_of(dom, struct mtk_iommu_domain, domain);
 }
 
-static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
+static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
 	unsigned long flags;
 
+	/*
+	 * No need get power status since the HW PM status nearly is active
+	 * when entering here.
+	 */
 	spin_lock_irqsave(&data->tlb_lock, flags);
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 		       data->base + data->plat_data->inv_sel_reg);
@@ -216,16 +220,6 @@ static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
 	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
-static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
-{
-	if (pm_runtime_get_if_in_use(data->dev) <= 0)
-		return;
-
-	mtk_iommu_tlb_do_flush_all(data);
-
-	pm_runtime_put(data->dev);
-}
-
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   struct mtk_iommu_data *data)
 {
@@ -263,7 +257,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		if (ret) {
 			dev_warn(data->dev,
 				 "Partial TLB flush timed out, falling back to full flush\n");
-			mtk_iommu_tlb_do_flush_all(data);
+			mtk_iommu_tlb_flush_all(data);
 		}
 
 		if (has_pm)
@@ -993,7 +987,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	 *
 	 * Thus, Make sure the tlb always is clean after each PM resume.
 	 */
-	mtk_iommu_tlb_do_flush_all(data);
+	mtk_iommu_tlb_flush_all(data);
 
 	/*
 	 * Uppon first resume, only enable the clk and return, since the values of the
-- 
2.18.0

