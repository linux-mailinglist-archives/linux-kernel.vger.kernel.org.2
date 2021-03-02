Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB52132AAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839864AbhCBTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:55:12 -0500
Received: from mx.socionext.com ([202.248.49.38]:7344 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580059AbhCBRWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:22:25 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Mar 2021 02:21:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2AD5F2059035;
        Wed,  3 Mar 2021 02:21:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 3 Mar 2021 02:21:37 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C362FB1D40;
        Wed,  3 Mar 2021 02:21:36 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jianxiong Gao <jxgao@google.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] swiotlb: Fix type of max_slot
Date:   Wed,  3 Mar 2021 02:21:28 +0900
Message-Id: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the refactoring phase, the type of max_slot has changed from unsigned
long to unsigned int. The return type of the function get_max_slots() and
the 4th argument type of iommu_is_span_boundary() are different from the
type of max_slot. Finally, asserts BUG_ON in iommu_is_span_boundary().

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 369e4c3..c10e855 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-	unsigned int max_slots = get_max_slots(boundary_mask);
+	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-- 
2.7.4

