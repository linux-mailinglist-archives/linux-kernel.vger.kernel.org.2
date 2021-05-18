Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66070387207
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhERGko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhERGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:40:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCABBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Z/wp0uuEBZ5pBJbL1P/8hRseeBn7NikpNqY1hOW9avo=; b=muHtX6h8KvRL95tMl2PESZK583
        nGraPU0BB9d7t39rLg69xs41+9d3Pb/zH4iRfttwzTC2mAPCignttz9aiiz+nSqb5UkQC7to8Qj/j
        FcL1/M9elULHrF4a3PwTo/h4R+U/R3Hasn3unEy0xEwI5dnd4SDshO6cKjW7BFb1QSlePdf4M6Oxx
        Lk2INTgHY94A+oUGtkbD0EA49ngHIMivwB2ND5LU6x+xzohhX2lQng9xH6NwZdMDU6J+3E5gmI7tG
        F6+YOGCizi8iQqu/fZ8njfRL1pJHvp20OGHHf0trIG3NKvTdE92fKoohBhIokjdAvQzbvotgoI1u/
        EmVfLoCg==;
Received: from [2001:4bb8:180:5add:a5f0:caac:a977:c523] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1litO0-00EMHe-7v; Tue, 18 May 2021 06:39:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove devm_request_free_mem_region
Date:   Tue, 18 May 2021 08:39:22 +0200
Message-Id: <20210518063922.2910123-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused devm_request_free_mem_region, massage the kerneldoc
comment for devm_request_free_mem_region into one documenting the
actual used request_free_mem_region function and fold
__request_free_mem_region into request_free_mem_region now that no
other caller is left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/vm/hmm.rst |  5 ++--
 include/linux/ioport.h   |  2 --
 kernel/resource.c        | 60 +++++++++-------------------------------
 3 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 09e28507f5b2..311e783c921f 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -299,9 +299,8 @@ These can be allocated and freed with::
     memunmap_pages(&pagemap);
     release_mem_region(pagemap.range.start, range_len(&pagemap.range));
 
-There are also devm_request_free_mem_region(), devm_memremap_pages(),
-devm_memunmap_pages(), and devm_release_mem_region() when the resources can
-be tied to a ``struct device``.
+There are also devm_memremap_pages() and devm_memunmap_pages() when the
+resources can be tied to a ``struct device``.
 
 The overall migration steps are similar to migrating NUMA pages within system
 memory (see :ref:`Page migration <page_migration>`) but the steps are split
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..4726bab0208b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -323,8 +323,6 @@ extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
-struct resource *devm_request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size);
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..9d8cbec6dc17 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1775,12 +1775,22 @@ void resource_list_free(struct list_head *head)
 EXPORT_SYMBOL(resource_list_free);
 
 #ifdef CONFIG_DEVICE_PRIVATE
-static struct resource *__request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size, const char *name)
+/**
+ * request_free_mem_region - find free region for device private memory
+ *
+ * @base: resource tree to look in
+ * @size: size in bytes of the device memory to add
+ * @name: name that describes the region
+ *
+ * This function tries to find an empty range of physical address big enough to
+ * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
+ * memory, which in turn allocates struct pages.
+ */
+struct resource *request_free_mem_region(struct resource *base,
+		unsigned long size, const char *name)
 {
 	resource_size_t end, addr;
 	struct resource *res;
-	struct region_devres *dr = NULL;
 
 	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
 	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
@@ -1790,15 +1800,6 @@ static struct resource *__request_free_mem_region(struct device *dev,
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	if (dev) {
-		dr = devres_alloc(devm_region_release,
-				sizeof(struct region_devres), GFP_KERNEL);
-		if (!dr) {
-			free_resource(res);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	write_lock(&resource_lock);
 	for (; addr > size && addr >= base->start; addr -= size) {
 		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
@@ -1809,13 +1810,6 @@ static struct resource *__request_free_mem_region(struct device *dev,
 						name, 0))
 			break;
 
-		if (dev) {
-			dr->parent = &iomem_resource;
-			dr->start = addr;
-			dr->n = size;
-			devres_add(dev, dr);
-		}
-
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
 		write_unlock(&resource_lock);
 
@@ -1828,37 +1822,9 @@ static struct resource *__request_free_mem_region(struct device *dev,
 	write_unlock(&resource_lock);
 
 	free_resource(res);
-	if (dr)
-		devres_free(dr);
-
 	return ERR_PTR(-ERANGE);
 }
-
-/**
- * devm_request_free_mem_region - find free region for device private memory
- *
- * @dev: device struct to bind the resource to
- * @size: size in bytes of the device memory to add
- * @base: resource tree to look in
- *
- * This function tries to find an empty range of physical address big enough to
- * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
- * memory, which in turn allocates struct pages.
- */
-struct resource *devm_request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size)
-{
-	return __request_free_mem_region(dev, base, size, dev_name(dev));
-}
-EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
-
-struct resource *request_free_mem_region(struct resource *base,
-		unsigned long size, const char *name)
-{
-	return __request_free_mem_region(NULL, base, size, name);
-}
 EXPORT_SYMBOL_GPL(request_free_mem_region);
-
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 static int __init strict_iomem(char *str)
-- 
2.30.2

