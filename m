Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA63148D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBIG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBIGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:23:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A0C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:22:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x136so4685896pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zqci56JWIAAF0wW2XoOW1nlucKE1HdU8HbBcVGEoj4=;
        b=iQ8wBJSEVZzeAe0ffh2h2GM8F5kehjcPxtVFeT4gPFJg8QooaH8d0bbR3DBFmEjh7/
         +t81Z22ZQ3jfYQJEtw6EEDXPAwtTfgWAGJvdqJ64cWu+Z/90HeG76Xdlz9LMQYcjebg6
         t1DpKPM5Kv3tzEnaDX3egDRfxshz/CzrFwO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zqci56JWIAAF0wW2XoOW1nlucKE1HdU8HbBcVGEoj4=;
        b=QroCZR3SbuqwF2RhG7zctmbDC6PhywCgnkcTApC613PfQH3qEctfpDjq73zFmBxzXJ
         eU0f+JX+MAsXG9PUXcXM9SmJaqqPcsByn3PQ2YnKfh++W5ml8ccig+F84d1h/Yb5VC5O
         G3+VGelUw21EcBUdWy/Fad4c+gpqsFrCzvmvZwQggGVf4Foj07eLuvmDw+TlTZGH1lhM
         6xaJ+JV56DJ0whBN8Et0jVgWoXGU+AMti3pdlGH3Hoo63+8hr6ezinrnvyE29+4oBUZI
         /0pJXNg6mTBEbX90naa8KQmSdCdpL97fPVB2uTX5ezVAN9iZK1Cu4K9fiA/yD9vlNvvn
         TQSQ==
X-Gm-Message-State: AOAM532FnG87RsLvwljLjcw7joAnZqRK14KKccfCgBJfLzcofBmOfhOt
        3Kn92vnDXZEP32BC/hYvcuaSDQ==
X-Google-Smtp-Source: ABdhPJy1CzOC+GQys63fdcsVT9unv4NpcqE4/TesqmaSSFAML/xnfw6XY2m3UHOllfAZ0J4Itqp2AA==
X-Received: by 2002:aa7:80cc:0:b029:1da:689d:2762 with SMTP id a12-20020aa780cc0000b02901da689d2762mr14012849pfn.3.1612851768274;
        Mon, 08 Feb 2021 22:22:48 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id n1sm6296866pgn.94.2021.02.08.22.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:22:47 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v4 09/14] swiotlb: Refactor swiotlb_tbl_{map,unmap}_single
Date:   Tue,  9 Feb 2021 14:21:26 +0800
Message-Id: <20210209062131.2300005-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor swiotlb_tbl_{map,unmap}_single to make the code reusable for
dev_swiotlb_{alloc,free}.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 116 ++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6fdebde8fb1f..f64cbe6e84cc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -509,14 +509,12 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
-		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
+static int swiotlb_tbl_find_free_region(struct device *hwdev,
+					dma_addr_t tbl_dma_addr,
+					size_t alloc_size, unsigned long attrs)
 {
 	struct swiotlb *swiotlb = get_swiotlb(hwdev);
-	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, swiotlb->start);
 	unsigned long flags;
-	phys_addr_t tlb_addr;
 	unsigned int nslots, stride, index, wrap;
 	int i;
 	unsigned long mask;
@@ -531,15 +529,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 #endif
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (mem_encrypt_active())
-		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
-
-	if (mapping_size > alloc_size) {
-		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
-
 	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
@@ -601,7 +590,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 				swiotlb->list[i] = 0;
 			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && swiotlb->list[i]; i--)
 				swiotlb->list[i] = ++count;
-			tlb_addr = swiotlb->start + (index << IO_TLB_SHIFT);
 
 			/*
 			 * Update the indices to avoid searching in the next
@@ -624,45 +612,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 			 alloc_size, swiotlb->nslabs, tmp_io_tlb_used);
-	return (phys_addr_t)DMA_MAPPING_ERROR;
+	return -ENOMEM;
+
 found:
 	swiotlb->used += nslots;
 	spin_unlock_irqrestore(&swiotlb->lock, flags);
 
-	/*
-	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
-	 */
-	for (i = 0; i < nslots; i++)
-		swiotlb->orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-
-	return tlb_addr;
+	return index;
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t mapping_size, size_t alloc_size,
-			      enum dma_data_direction dir, unsigned long attrs)
+static void swiotlb_tbl_release_region(struct device *hwdev, int index, size_t size)
 {
 	struct swiotlb *swiotlb = get_swiotlb(hwdev);
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = swiotlb->orig_addr[index];
-
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (orig_addr != INVALID_PHYS_ADDR &&
-	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -694,6 +657,69 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	spin_unlock_irqrestore(&swiotlb->lock, flags);
 }
 
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
+				   size_t mapping_size, size_t alloc_size,
+				   enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
+	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, swiotlb->start);
+	phys_addr_t tlb_addr;
+	unsigned int nslots, index;
+	int i;
+
+	if (mem_encrypt_active())
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	index = swiotlb_tbl_find_free_region(hwdev, tbl_dma_addr, alloc_size, attrs);
+	if (index < 0)
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	tlb_addr = swiotlb->start + (index << IO_TLB_SHIFT);
+
+	/*
+	 * Save away the mapping from the original address to the DMA address.
+	 * This is needed when we sync the memory.  Then we sync the buffer if
+	 * needed.
+	 */
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	for (i = 0; i < nslots; i++)
+		swiotlb->orig_addr[index + i] = orig_addr + (i << IO_TLB_SHIFT);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
+
+	return tlb_addr;
+}
+
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
+			      size_t mapping_size, size_t alloc_size,
+			      enum dma_data_direction dir, unsigned long attrs)
+{
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
+	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = swiotlb->orig_addr[index];
+
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (orig_addr != INVALID_PHYS_ADDR &&
+	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+
+	swiotlb_tbl_release_region(hwdev, index, alloc_size);
+}
+
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
-- 
2.30.0.478.g8a0d178c01-goog

