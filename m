Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2121132BAB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351883AbhCCLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:50:34 -0500
Received: from mx.socionext.com ([202.248.49.38]:13676 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578259AbhCCEjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 23:39:53 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Mar 2021 13:33:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 2A3F62059025;
        Wed,  3 Mar 2021 13:33:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 3 Mar 2021 13:33:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id A14AEB1D40;
        Wed,  3 Mar 2021 13:33:28 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7A78112053F;
        Wed,  3 Mar 2021 13:33:28 +0900 (JST)
Date:   Wed, 03 Mar 2021 13:33:28 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Fix type of max_slot
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jianxiong Gao <jxgao@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <436bf276-5b16-62af-6a32-70f91fce7557@oracle.com>
References: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com> <436bf276-5b16-62af-6a32-70f91fce7557@oracle.com>
Message-Id: <20210303133328.4D12.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 15:20:08 -0500
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On 3/2/21 12:21 PM, Kunihiko Hayashi wrote:
> > After the refactoring phase, the type of max_slot has changed from unsigned
> > long to unsigned int. The return type of the function get_max_slots() and
> > the 4th argument type of iommu_is_span_boundary() are different from the
> > type of max_slot. Finally, asserts BUG_ON in iommu_is_span_boundary().
> > > Cc: Christoph Hellwig <hch@lst.de>
> > Fixes: 567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> I think this is all good. Looking at Linus's master I see:
> 
> 
> 537         unsigned long max_slots = get_max_slots(boundary_mask);
> 
> ?

Thanks for the information, and sorry for that.

I found it in next-20210226:
567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")

And it has already fixed in next-20210301:
26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")

$ git diff 567d877f9a7d..26a7e094783d
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 381c24e..6962cb4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -496,7 +496,7 @@ static int find_slots(struct device *dev, size_t alloc_size)
        unsigned long boundary_mask = dma_get_seg_boundary(dev);
        dma_addr_t tbl_dma_addr =
                phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-       unsigned int max_slots = get_max_slots(boundary_mask);
+       unsigned long max_slots = get_max_slots(boundary_mask);
        unsigned int nslots = nr_slots(alloc_size), stride = 1;
        unsigned int index, wrap, count = 0, i;
        unsigned long flags;

Thank you,

---
Best Regards,
Kunihiko Hayashi

