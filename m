Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2683B7BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhF3CjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:39:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34431 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232990AbhF3CjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:39:06 -0400
X-UUID: b4cb33e6b3634fb2a6ee3674bccd518a-20210630
X-UUID: b4cb33e6b3634fb2a6ee3674bccd518a-20210630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 41645959; Wed, 30 Jun 2021 10:36:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:36:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:36:31 +0800
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
Subject: [PATCH 09/24] iommu/mediatek: Always pm_runtime_get while tlb flush
Date:   Wed, 30 Jun 2021 10:34:49 +0800
Message-ID: <20210630023504.18177-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous soc, some SoC don't have PM. Only mt8192 has power-domain,
and it's display's power-domain which nearly always is enabled.

When there are 2 M4U HW, it may has problem.
In this function, we get the pm_status via the m4u dev, but it don't
reflect the real power-domain status of the HW since there may be other
HW also use that power-domain.

Currently We can not get the real power-domain status, thus I always
pm_runtime_get here.

This pach is only a preparing patch for 2 HW sharing pgtable in different
power-domains, like mt8195 case. thus, no need fix tags here.

this patch may drop the performance, we expect the user could
pm_runtime_get_sync before dma_alloc_attrs.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ed3455b5cef0..fcf70787d3d1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -231,7 +231,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 	for_each_m4u(data, head) {
 		if (has_pm) {
-			if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			if (pm_runtime_resume_and_get(data->dev) < 0)
 				continue;
 		}
 
-- 
2.18.0

