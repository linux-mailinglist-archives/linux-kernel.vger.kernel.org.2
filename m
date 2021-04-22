Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB3367C43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhDVIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhDVIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:17:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A5C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:16:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h20so23140780plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkwA0MhFMUu0PR/fEN042I8GYXA93G+HHJQKQB3SQ/4=;
        b=n24zPnvuNl2SXMT6Lwyk4tHWvipaN24pDTC4bKN1c4QYL0U2nK0+5N3vBaxPFaX5jf
         jVJT7R6TR9puuY7CsVnNk7gaY8P2a9BoR7/+2GKzdYiqobiUj21G70dmzDdpYhUlxZJw
         jvg8gdJ0MycI55fZwqnmwlqq6E/R7NUO9utzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkwA0MhFMUu0PR/fEN042I8GYXA93G+HHJQKQB3SQ/4=;
        b=qfmH/OV54lLlvEuYGDzuDXBul1sVFun7VDRWNcAyHMEa4qM6KU9pLHk+ZNk4v0uSZ7
         EqfU95JZgdIWueCtxqD8nkLokGdbkTFTnU+6U+kSCvRcXazpVYLI5nM8QQ1SKSLbXcRb
         f2BnQPS1d0bLO3XDyTwnU+wzBsx7A3Sj3O0zzkDt1OCT6AW70xCPf/9q0CNPlwVq4ItZ
         HRLUdShOcKdhrOej/JQ8WxM3mmlKvS50zkBMKG2ILrrhT+eo8uxuBM0N/TdiUCQmOhWh
         Se0pNtyj5gGY6yoZk2ehn4q7Fv7Y9uRy6rdm6sztofQkj9J+uZ3/ssd4jPuv6lY0EQrX
         KXrQ==
X-Gm-Message-State: AOAM531VMeW5iL9OfHjbEstSbphZXN8FA5tLoIwOhlclIru8bBwiC+tl
        XWNlqhchyOXKFEiwXH0UFruTXw==
X-Google-Smtp-Source: ABdhPJzVJLpBCYw0WSyr4j5165U0UOHdyEL1ymXrvCVvRWjQBHVXQWAEaEzYKj1TvEvauEG2merRVg==
X-Received: by 2002:a17:902:ac89:b029:e6:d199:29ac with SMTP id h9-20020a170902ac89b02900e6d19929acmr2225078plr.46.1619079413150;
        Thu, 22 Apr 2021 01:16:53 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:1a8e:1bde:f79e:c302])
        by smtp.gmail.com with UTF8SMTPSA id 137sm1375933pfx.172.2021.04.22.01.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:16:52 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v5 11/16] swiotlb: Refactor swiotlb_tbl_unmap_single
Date:   Thu, 22 Apr 2021 16:15:03 +0800
Message-Id: <20210422081508.3942748-12-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
References: <20210422081508.3942748-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function, release_slots, to make the code reusable for supporting
different bounce buffer pools, e.g. restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b7d634d7a7eb..af0feb8eaead 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -547,27 +547,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t mapping_size, enum dma_data_direction dir,
-			      unsigned long attrs)
+static void release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(hwdev);
+	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
 	unsigned long flags;
-	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
+	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
 	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
 	int count, i;
 
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(hwdev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
-
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
@@ -602,6 +590,23 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	spin_unlock_irqrestore(&mem->lock, flags);
 }
 
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
+			      size_t mapping_size, enum dma_data_direction dir,
+			      unsigned long attrs)
+{
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+
+	release_slots(dev, tlb_addr);
+}
+
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir)
 {
-- 
2.31.1.368.gbe11c130af-goog

