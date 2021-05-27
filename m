Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1B392EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhE0NCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhE0NB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:01:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E5C061763
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:00:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so2302075pjt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCZEoBF15DvIVGSc+3j8Uk27721eHnYQC5cQOW6yZk4=;
        b=FaFXCFWJLCD/gigBOGfY4F270yO0Alvb7EMZVKQJ9L8utcEPvn3XtnKI3BEMvmJtEK
         gYgjai80HZHDiRLWnq4ZnWFUPWMggGA/Wo+QuTb4wDh5MX+6KsOXKwWCEnZzHAaiuA3T
         2/Aqi7L4LhIRGkedSPRMYz9qyuKketwP3p78k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCZEoBF15DvIVGSc+3j8Uk27721eHnYQC5cQOW6yZk4=;
        b=Dm8nrx0i4tdRltGuH5UZDUJa55Lvz/vi5ouCTnbKYqzZDjrSs6u8ubaRMjGao5DHiz
         BOEKkbGJeJtbeMPwlDCDL9x7Bfbji9Yh5XO7LEZSu7s++NPM1ZJDGCrN+Wp3z2I/BCM6
         kdvGYtRKu9fAl0TayWV/l+WP9+44k+NxZNvD7PgVAgcSKsftrOHl7qhsH2HaungpdpN6
         nQ3Jf550hBEhVnYUV89a9MVec1HNTup42YZYeRupJU2lq5c7Enu1Jm14siY5iRuM8POd
         gBzgK6jbvjvHeyDjNk4wTdg+QRX/+/W8vNbU9Yc+wfo3BFh35Ew1zrRosVMRbVl5tZSO
         FLTw==
X-Gm-Message-State: AOAM533KiDR9ndq/cznOjCU5vpBi2LEYXAzP9sKyYzJMV25BIwhR8u0M
        cLOVG4ZZiSew9X5IMAw5bzYmiA==
X-Google-Smtp-Source: ABdhPJyRdfD5aP84oP+O3UZ9D5kP+7R8Jjf69TCVtMPqoqtl6dZXUjZXcnaxnn4OXnc5bmDzFDOgsA==
X-Received: by 2002:a17:90a:74f:: with SMTP id s15mr4091622pje.90.1622120423164;
        Thu, 27 May 2021 06:00:23 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id 66sm2009117pgj.9.2021.05.27.06.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:00:22 -0700 (PDT)
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
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v8 10/15] swiotlb: Refactor swiotlb_tbl_unmap_single
Date:   Thu, 27 May 2021 20:58:40 +0800
Message-Id: <20210527125845.1852284-11-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527125845.1852284-1-tientzu@chromium.org>
References: <20210527125845.1852284-1-tientzu@chromium.org>
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
index 88b3471ac6a8..c4fc2e444e7a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -550,27 +550,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
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
@@ -605,6 +593,23 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
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
2.31.1.818.g46aad6cb9e-goog

