Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657FB3B7B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhF3CiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:38:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33855 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232699AbhF3CiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:38:14 -0400
X-UUID: 09c797874b1040d0acd9164099f03e60-20210630
X-UUID: 09c797874b1040d0acd9164099f03e60-20210630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1464235330; Wed, 30 Jun 2021 10:35:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:35:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:35:41 +0800
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
Subject: [PATCH 03/24] iommu/mediatek: Fix 2 HW sharing pgtable issue
Date:   Wed, 30 Jun 2021 10:34:43 +0800
Message-ID: <20210630023504.18177-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the this commit 4f956c97d26b ("iommu/mediatek: Move domain_finalise
into attach_device"), I overlooked the sharing pgtable case.
After that commit, the "data" in the mtk_iommu_domain_finalise always is
the data of the current IOMMU HW, If it's sharing pgtable case, here is
not right. This patch fix this. In sharing pgable case, we will loop the
list to find if there already is the exist domain.

this only affect mt2712 which is the only SoC that sharing pgtable.

Fixes: 4f956c97d26b ("iommu/mediatek: Move domain_finalise into attach_device")
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..013dbcc87d49 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -390,12 +390,19 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 				     unsigned int domid)
 {
 	const struct mtk_iommu_iova_region *region;
+	struct mtk_iommu_data *tmpdata;
 
-	/* Use the exist domain as there is only one pgtable here. */
-	if (data->m4u_dom) {
-		dom->iop = data->m4u_dom->iop;
-		dom->cfg = data->m4u_dom->cfg;
-		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+	/*
+	 * Loop to find if there is already the exist domain.
+	 * Use it when 2 iommu HWs share the pgtable.
+	 */
+	for_each_m4u(tmpdata) {
+		if (!tmpdata->m4u_dom)
+			continue;
+
+		dom->iop = tmpdata->m4u_dom->iop;
+		dom->cfg = tmpdata->m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = tmpdata->m4u_dom->cfg.pgsize_bitmap;
 		goto update_iova_region;
 	}
 
-- 
2.18.0

