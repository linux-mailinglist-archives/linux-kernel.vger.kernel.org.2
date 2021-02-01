Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F255A30AF72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhBASdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhBASbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:31:06 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F9C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:30:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 139so12070000pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
        b=XldHocSXWNUmvdcXbIrpvBTLb8nXbBn2Zduuok2rj8hE3W3V31QvgZdnPupEQPoZYP
         ETcbawsrzB76ohyeg2EXVwurYZEhXJ/VZgHEXTMjIpxXKEksDxYo6OVzRXSgYOttSMez
         fpHSpVUOfiiyl97UtYRwutY0a8N+NzpRYjiVoQnubo8dMHCinvMkqw9DLbx60CPQaKu5
         aAmM3CSeUECVn0FaX9Rvc3tsejqbDZGEniUKipSNYQ8lldAM3RhDm5KJKUols8brZ5bO
         oqQq1Ii8r1vO+vj8I+iVgBnRx/30desHgf9YzFbiYY4AtFRcgWAoeraREgbHciFMwXa2
         /f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=y6NSNhQIEZdVx/Woig+GF08BnyECPQsRFpv07tNfeBE=;
        b=R2qUXSt4SI/cEpHq6fXtl+pGkKk0y5CY1FrEGEKjMH7y9C7cIVkd9sI3rP8pWfx8TH
         Z7XDrxkQp0z//JUtK07CPAtSlxoELdcYVJH1joHYA4F/GITF66QWDZo+widp70ilKUc1
         aLW2QIw8NIu8gBbgdIcC/679jTfbPY29l+0s1QGpa0oxb/P5tXrmsByzt1KsJm4i3aWb
         MI1loO5yMF5I55cvtRP4zK2LEW+hyOwRChmIMpp6i1SnVnVCyp0Cbil/nJayK7KrWVeJ
         Wk/7gw+1571G/27ZtEAoafsOjftDL2UPE3oV/vn0HzluFYdONpSLpNIKxesq/TsBZAtS
         lcwQ==
X-Gm-Message-State: AOAM531EYsIdD2AmQugupTXtdXditroN00rOyqh4X8BesN1idMjnGfld
        GCSgdU27AdypMoaz4SSI61q/EsHG9w==
X-Google-Smtp-Source: ABdhPJyEh8WHTSX3KID/KGB0QXG7CYFZ82eK6gqBoiX6SQN2IPJo3M4LuIvQvOzXGRBAfT0DQgR6FOjGCw==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a63:5223:: with SMTP id g35mr18277246pgb.255.1612204225231;
 Mon, 01 Feb 2021 10:30:25 -0800 (PST)
Date:   Mon,  1 Feb 2021 10:30:16 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-3-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 2/3] Add swiotlb offset preserving mapping when
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
 kernel/dma/swiotlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..eeb640df35f3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
+	unsigned int nslots, stride, index, wrap, min_align_mask, page_offset;
 	int i;
 	unsigned long mask;
 	unsigned long offset_slots;
@@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
 
+	min_align_mask = dma_get_min_align_mask(hwdev);
+	page_offset = orig_addr & min_align_mask;
+	alloc_size += page_offset;
+
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
 	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (alloc_size >= PAGE_SIZE)
+	if ((alloc_size >= PAGE_SIZE) || (min_align_mask > (1 << IO_TLB_SHIFT)))
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
@@ -598,7 +607,11 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	unsigned int num_page_offset_slabs;
+	unsigned int min_align_mask = dma_get_min_align_mask(hwdev);
+	int i, count;
+	int nslots = ALIGN(alloc_size + (tlb_addr & min_align_mask),
+			1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -610,6 +623,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
+	/*
+	 * When dma_get_min_align_mask is used, we may have padded more slabs
+	 * when padding exceeds one slab. We need to move index back to the
+	 * beginning of the padding.
+	 */
+	num_page_offset_slabs = (tlb_addr & min_align_mask) / (1 << IO_TLB_SHIFT);
+	index -= num_page_offset_slabs;
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
-- 
2.27.0

