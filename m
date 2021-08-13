Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217B3EB0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhHMGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:55:48 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37212 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238879AbhHMGzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:55:43 -0400
X-UUID: 5c2eadb220b04228b6cc6d47d06b030c-20210813
X-UUID: 5c2eadb220b04228b6cc6d47d06b030c-20210813
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1822091167; Fri, 13 Aug 2021 14:55:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:55:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:55:10 +0800
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
Subject: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb flush
Date:   Fri, 13 Aug 2021 14:53:06 +0800
Message-ID: <20210813065324.29220-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for 2 HWs that sharing pgtable in different power-domains.

The previous SoC don't have PM. Only mt8192 has power-domain,
and it is display's power-domain which nearly always is enabled.

When there are 2 M4U HWs, it may has problem.
In this function, we get the pm_status via the m4u dev, but it don't
reflect the real power-domain status of the HW since there may be other
HW also use that power-domain.

Currently we could not get the real power-domain status, thus always
pm_runtime_get here.

Prepare for mt8195, thus, no need fix tags here.

This patch may drop the performance, we expect the user could
pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index add23a36a5e2..abc721a1da21 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -238,8 +238,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 	for_each_m4u(data, head) {
 		if (has_pm) {
-			if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			ret = pm_runtime_resume_and_get(data->dev);
+			if (ret < 0) {
+				dev_err(data->dev, "tlb flush: pm get fail %d.\n", ret);
 				continue;
+			}
 		}
 
 		spin_lock_irqsave(&data->tlb_lock, flags);
-- 
2.18.0

