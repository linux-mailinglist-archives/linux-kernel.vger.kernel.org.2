Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F5429D62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhJLF4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:56:43 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:40127 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232752AbhJLF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:56:42 -0400
Received: from MTA-12-3.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 09777800DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:54:40 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 6585A18000A7;
        Tue, 12 Oct 2021 01:54:38 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.235])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 68C5B18000A0;
        Tue, 12 Oct 2021 01:54:37 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] dma-debug: teach add_dma_entry() about DMA_ATTR_SKIP_CPU_SYNC
Date:   Tue, 12 Oct 2021 01:54:03 -0400
Message-Id: <20211012055404.88571-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping something twice should be possible as long as,
DMA_ATTR_SKIP_CPU_SYNC is passed to the strictly speaking second relevant
mapping operation (that attempts to map the same thing). So, don't issue a
warning if the specified condition is met in add_dma_entry().

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 kernel/dma/debug.c   | 24 ++++++++++++++----------
 kernel/dma/debug.h   | 24 ++++++++++++++++--------
 kernel/dma/mapping.c | 12 ++++++------
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 95445bd6eb72..c4128df3de41 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -552,7 +552,7 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
  * Wrapper function for adding an entry to the hash.
  * This function takes care of locking itself.
  */
-static void add_dma_entry(struct dma_debug_entry *entry)
+static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 {
 	struct hash_bucket *bucket;
 	unsigned long flags;
@@ -566,7 +566,7 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	if (rc == -ENOMEM) {
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST) {
+	} else if ((rc == -EEXIST) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
@@ -1191,7 +1191,8 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 EXPORT_SYMBOL(debug_dma_map_single);
 
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
-			size_t size, int direction, dma_addr_t dma_addr)
+			size_t size, int direction, dma_addr_t dma_addr,
+			unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1222,7 +1223,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 		check_for_illegal_area(dev, addr, size);
 	}
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -1280,7 +1281,8 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 
 void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		      int nents, int mapped_ents, int direction)
+		      int nents, int mapped_ents, int direction,
+		      unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 	struct scatterlist *s;
@@ -1312,7 +1314,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		check_sg_segment(dev, s);
 
-		add_dma_entry(entry);
+		add_dma_entry(entry, attrs);
 	}
 }
 
@@ -1368,7 +1370,8 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 }
 
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
-			      dma_addr_t dma_addr, void *virt)
+			      dma_addr_t dma_addr, void *virt,
+			      unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1398,7 +1401,7 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	else
 		entry->pfn = page_to_pfn(virt_to_page(virt));
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_free_coherent(struct device *dev, size_t size,
@@ -1429,7 +1432,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 }
 
 void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
-			    int direction, dma_addr_t dma_addr)
+			    int direction, dma_addr_t dma_addr,
+			    unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1449,7 +1453,7 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 	entry->direction	= direction;
 	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index 83643b3010b2..f525197d3cae 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -11,26 +11,30 @@
 #ifdef CONFIG_DMA_API_DEBUG
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
-			       int direction, dma_addr_t dma_addr);
+			       int direction, dma_addr_t dma_addr,
+			       unsigned long attrs);
 
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction);
 
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, int mapped_ents, int direction);
+			     int nents, int mapped_ents, int direction,
+			     unsigned long attrs);
 
 extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			       int nelems, int dir);
 
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
-				     dma_addr_t dma_addr, void *virt);
+				     dma_addr_t dma_addr, void *virt,
+				     unsigned long attrs);
 
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
 
 extern void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
 				   size_t size, int direction,
-				   dma_addr_t dma_addr);
+				   dma_addr_t dma_addr,
+				   unsigned long attrs);
 
 extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
 				     size_t size, int direction);
@@ -53,7 +57,8 @@ extern void debug_dma_sync_sg_for_device(struct device *dev,
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
-				      int direction, dma_addr_t dma_addr)
+				      int direction, dma_addr_t dma_addr,
+				      unsigned long attrs)
 {
 }
 
@@ -63,7 +68,8 @@ static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 
 static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-				    int nents, int mapped_ents, int direction)
+				    int nents, int mapped_ents, int direction,
+				    unsigned long attrs)
 {
 }
 
@@ -74,7 +80,8 @@ static inline void debug_dma_unmap_sg(struct device *dev,
 }
 
 static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
-					    dma_addr_t dma_addr, void *virt)
+					    dma_addr_t dma_addr, void *virt,
+					    unsigned long attrs)
 {
 }
 
@@ -85,7 +92,8 @@ static inline void debug_dma_free_coherent(struct device *dev, size_t size,
 
 static inline void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
 					  size_t size, int direction,
-					  dma_addr_t dma_addr)
+					  dma_addr_t dma_addr,
+					  unsigned long attrs)
 {
 }
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 06fec5547e7c..17c6d217f8fb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -156,7 +156,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr);
+	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
 }
@@ -195,7 +195,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 
 	if (ents > 0)
-		debug_dma_map_sg(dev, sg, nents, ents, dir);
+		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 			      ents != -EIO))
 		return -EIO;
@@ -305,7 +305,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
-	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
+	debug_dma_map_resource(dev, phys_addr, size, dir, addr, attrs);
 	return addr;
 }
 EXPORT_SYMBOL(dma_map_resource);
@@ -510,7 +510,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	else
 		return NULL;
 
-	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_alloc_attrs);
@@ -566,7 +566,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
 	if (page)
-		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
+		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_pages);
@@ -644,7 +644,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
-		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir);
+		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	}
 	return sgt;
 }
-- 
2.33.0

