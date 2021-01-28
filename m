Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317B73068C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhA1Alj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhA1Ajb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:39:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94075C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 8so2666444pgn.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
        b=qJxdZcF/2iL7L7BpzsbCYhi4F1nBavg4WlPlFpgXDOY5JnypjMuB5Jl8F1glrX+A4C
         n5cFVsxGI6pfe/w0G7OBYdhPN9oZnZgnLpywUZwj5ri8PaSP2OWVp0agQOBxmWy3mIvz
         KSFd69aDCb0KQBfTmnJ62PQ3um4VDyswVGzu5SPQyhwapIATIv82EijymGjd/0268xT2
         wv/zpLEU0J95cFOqUQnbGni/pwRmqfy6nQ96Wx3eJcvOVyYCLU49ayvU8D/1YZcpSmEQ
         cQVhVPIIf6skPQ09HLkASCP/JwRrVQzdGPjF5JYdynrGeqJ4Xp2kxKWvkcG5Zs6dpAi0
         huSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=qnjnlmt/aDtctSbauuE/youvqobwVlPzhUiWyRCjmfE=;
        b=r/bDYhF19T7rzxSGXfM1qcUq6ikNe+so7k2i9cRhUxAs+7UsQ+cj0q8F2hDypRYYfh
         7mTYN4MDQRbazW3HLA3Mdhl6fRYqIbA+LvzKJ9mMXndOnHa7UjzKHv+kLD9NJhpL0oDp
         eBBx+z8AxTj1yeV6eHBWb5cKAggK5sHga5LPYXPwnJ7JNd3Bz4uZioMxVhsbt4D2s1rt
         bMHMZWuU2y/34AgjnHjNIkqbu0KQ41JfL6arx+t0jLD2vjCCUjSBMhOkEOSMCeyoj6u4
         R2d0OYCFx1/vbfFWk8KCCcLi8prD5siJJYBQRt2we99ivxbWWv6pIcBtoX7Q1XUnr2XJ
         HypA==
X-Gm-Message-State: AOAM530YgNuG46AifaN91rj/887EMDr+5U5nc6SxJ2hmZX/7BO6A5cBZ
        FIOulfoxF0EnF169BzHHM4a4TA6mRQ==
X-Google-Smtp-Source: ABdhPJxItXQ1+mD1tytZkMFhh6fWETP78nnpd+zRsRgJzoZEVagoHzp8VktIvxmKZTm1x9AHDy922qsZ4Q==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d181:: with SMTP id
 fu1mr8266312pjb.188.1611794325104; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:38:28 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
From:   Jianxiong Gao <jxgao@google.com>
To:     jxgao@google.com, erdemaktas@google.com, marcorr@google.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices that need to preserve address offset on mapping through
swiotlb, this patch adds offset preserving based on page_offset_mask
and keeps the offset if the mask is non zero. This is needed for
device drivers like NVMe.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 kernel/dma/swiotlb.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..4cab35f2c9bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, page_offset_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	page_offset_mask = dma_get_page_offset_mask(hwdev);
+	page_offset = orig_addr & page_offset_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (page_offset_mask > (1 << IO_TLB_SHIFT)))
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
 		stride = 1;
@@ -583,6 +587,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += page_offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -598,7 +607,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs, page_offset_mask = dma_get_page_offset_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + tlb_addr & page_offset_mask, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +621,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_page_offset_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs =  (tlb_addr & page_offset_mask) / (1 << IO_TLB_SHIFT);
+	index -= num_page_offset_slabs;
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
-- 
2.27.0

