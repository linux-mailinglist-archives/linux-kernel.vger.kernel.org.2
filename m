Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D07415D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbhIWMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:02:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51544 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240845AbhIWMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:02:25 -0400
X-UUID: 72dd97051e024ba2836f9f1a804ad3b8-20210923
X-UUID: 72dd97051e024ba2836f9f1a804ad3b8-20210923
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1010440804; Thu, 23 Sep 2021 20:00:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:00:50 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:00:49 +0800
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
Subject: [PATCH v3 11/33] iommu/mediatek: Remove the granule in the tlb flush
Date:   Thu, 23 Sep 2021 19:58:18 +0800
Message-ID: <20210923115840.17813-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek IOMMU don't care about granule when tlb flushing.
Remove this variable.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ab484d20b441..44cf5547d084 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -227,7 +227,6 @@ static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
 	struct list_head *head = data->hw_list;
@@ -541,8 +540,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start + 1;
 
-	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
-				       dom->data);
+	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->data);
 }
 
 static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
@@ -550,7 +548,7 @@ static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_range_sync(iova, size, size, dom->data);
+	mtk_iommu_tlb_flush_range_sync(iova, size, dom->data);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.18.0

