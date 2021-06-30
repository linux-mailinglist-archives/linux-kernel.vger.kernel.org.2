Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7253E3B7BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhF3Ci6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:38:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34332 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233014AbhF3Ci5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:38:57 -0400
X-UUID: da1d11cc0dd543538bfc0cd9d22b515d-20210630
X-UUID: da1d11cc0dd543538bfc0cd9d22b515d-20210630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 405164280; Wed, 30 Jun 2021 10:36:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:36:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:36:23 +0800
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
Subject: [PATCH 08/24] iommu/mediatek: Remove for_each_m4u in tlb_sync_all
Date:   Wed, 30 Jun 2021 10:34:48 +0800
Message-ID: <20210630023504.18177-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tlb_sync_all only is called in
a) flush_iotlb_all: it will called for each iommu HW.
b) tlb_flush_range_sync: it already has for_each_m4u.
c) in irq: it has already fail. no need for_each_m4u to flush

thus, No need for_each_m4u in this tlb_sync_all.
This patch remove it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7fe9ebd879fe..ed3455b5cef0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -208,19 +208,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	struct list_head *head = data->hw_list;
-
-	for_each_m4u(data, head) {
-		if (pm_runtime_get_if_in_use(data->dev) <= 0)
-			continue;
+	if (pm_runtime_get_if_in_use(data->dev) <= 0)
+		return;
 
-		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
-			       data->base + data->plat_data->inv_sel_reg);
-		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
-		wmb(); /* Make sure the tlb flush all done */
+	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+		       data->base + data->plat_data->inv_sel_reg);
+	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
+	wmb(); /* Make sure the tlb flush all done */
 
-		pm_runtime_put(data->dev);
-	}
+	pm_runtime_put(data->dev);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-- 
2.18.0

