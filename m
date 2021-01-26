Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D83055EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316935AbhAZXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbhAZEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:54:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w18so9799025pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aFsNeXQ/i7Fj8qIza5kcen5kjFa9Ve5fg30RPhukTw=;
        b=ce4C/3fTVP7qFzH8XJIen9MuOjrG+JistpkikOqziLr8j1goHHT7iog9ZX6Ywg3Fep
         qUwOuyPf9UHl0XAc6Wrb0XGXbvqegp2qrW5NZa9gGoSpSAp8sjpJ5v2PYo1jm+ZiPL3Z
         9HQ4o/xILrIyBPuWEyFYVJH1upZQ7ql7e2aLwPTbTbCeLHryvt4ttbn7FCwUjoujIsc1
         frFJuYVJ8garJRRYPBzuMUwQKEFzwey/krTWoZE/ZNQbAciCwBQj8sp4fgKlz5agzYye
         zdAAQWKCY/T+keNL3sdWNS85Wi8bLa4kizHTLicdgkOFzf+oOrPYCeyXwWTL6NV1Hji5
         dwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aFsNeXQ/i7Fj8qIza5kcen5kjFa9Ve5fg30RPhukTw=;
        b=kU5CukNT3Mozj2+2NVdUmLEIYFokyBLvibB3kIIPi1dnQKy4oazrdNr0mmV9AegXrN
         RF0fhrNNduUFWj6wBvoH3J1f0Efxi3Coy49V/0C9A9JIYraleOBQ9//olR55YAEYBnHy
         nuKxmbq+x0uoKkzhDo8gNwGX+TWesobGU3ZBxz2/GcVeSClYeWDJUVYy1Vm2W1PJA/pC
         EBxSuG7etEiE71y0jkquGOF0VZtcpXx7BJn6WN6CWbWN7+KVZQ851Z+maWz5fUqbcIcL
         FA50BvMhvMXBZfjVrhRqCeGVDlJYNXhkW7huxh2OAqdMMBHl/4w30t5hUTqcaTWyX9Kg
         0b2g==
X-Gm-Message-State: AOAM532gK3wY7ype4OlwpLoDQCVIOzaRVZWAa1hp+M78WfI/vE5llf5t
        6CBX4tSmpdHrGeiGwqnL3gg=
X-Google-Smtp-Source: ABdhPJwOY9GEbO+VwkQYL9vvVzoFRPj/2nPjkKBGDhJyj1Mw9kSKI3/aZ5hBVh8cQNQQB9Qxh1zpYA==
X-Received: by 2002:a63:e442:: with SMTP id i2mr3859050pgk.12.1611636855014;
        Mon, 25 Jan 2021 20:54:15 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:14 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] mm/vmalloc: remove map_kernel_range
Date:   Tue, 26 Jan 2021 14:54:00 +1000
Message-Id: <20210126045404.2492588-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126045404.2492588-1-npiggin@gmail.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a shim around vmap_pages_range, get rid of it.

Move the main API comment from the _noflush variant to the normal
variant, and make _noflush internal to mm/.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/core-api/cachetlb.rst |  2 +-
 include/linux/vmalloc.h             | 11 -----
 mm/internal.h                       |  6 +++
 mm/percpu-vm.c                      |  5 ++-
 mm/vmalloc.c                        | 65 +++++++++++++----------------
 5 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index a1582cc79f0f..756f7bcf8191 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -213,7 +213,7 @@ Here are the routines, one by one:
 	there will be no entries in the cache for the kernel address
 	space for virtual addresses in the range 'start' to 'end-1'.
 
-	The first of these two routines is invoked after map_kernel_range()
+	The first of these two routines is invoked after vmap_range()
 	has installed the page table entries.  The second is invoked
 	before unmap_kernel_range() deletes the page table entries.
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 93270adf5db5..913c9d4f5e03 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -217,10 +217,6 @@ static inline bool is_vm_area_hugepages(const void *addr)
 int vmap_range(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift);
-extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
-				    pgprot_t prot, struct page **pages);
-int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
-		struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
 static inline void set_vm_flush_reset_perms(void *addr)
@@ -232,13 +228,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
 }
 
 #else
-static inline int
-map_kernel_range_noflush(unsigned long start, unsigned long size,
-			pgprot_t prot, struct page **pages)
-{
-	return size >> PAGE_SHIFT;
-}
-#define map_kernel_range map_kernel_range_noflush
 static inline void
 unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439f19..3ce246945882 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -623,4 +623,10 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+/*
+ * mm/vmalloc.c
+ */
+int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+                pgprot_t prot, struct page **pages, unsigned int page_shift);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index e46f7a6917f9..88a53eb68a94 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -8,6 +8,7 @@
  * Chunks are mapped into vmalloc areas and populated page by page.
  * This is the default chunk allocator.
  */
+#include "internal.h"
 
 static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
 				    unsigned int cpu, int page_idx)
@@ -192,8 +193,8 @@ static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
 static int __pcpu_map_pages(unsigned long addr, struct page **pages,
 			    int nr_pages)
 {
-	return map_kernel_range_noflush(addr, nr_pages << PAGE_SHIFT,
-					PAGE_KERNEL, pages);
+	return vmap_pages_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT),
+					PAGE_KERNEL, pages, PAGE_SHIFT);
 }
 
 /**
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e9a28de04182..78dc3ec457ef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -523,7 +523,16 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 	return 0;
 }
 
-static int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+/*
+ * vmap_pages_range_noflush is similar to vmap_pages_range, but does not
+ * flush caches.
+ *
+ * The caller is responsible for calling flush_cache_vmap() after this
+ * function returns successfully and before the addresses are accessed.
+ *
+ * This is an internal function only. Do not use outside mm/.
+ */
+int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
@@ -549,48 +558,26 @@ static int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 	return 0;
 }
 
-static int vmap_pages_range(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int page_shift)
-{
-	int err;
-
-	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
-	flush_cache_vmap(addr, end);
-	return err;
-}
-
 /**
- * map_kernel_range_noflush - map kernel VM area with the specified pages
+ * vmap_pages_range - map pages to a kernel virtual address
  * @addr: start of the VM area to map
- * @size: size of the VM area to map
+ * @end: end of the VM area to map (non-inclusive)
  * @prot: page protection flags to use
- * @pages: pages to map
- *
- * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
- * have been allocated using get_vm_area() and its friends.
- *
- * NOTE:
- * This function does NOT do any cache flushing.  The caller is responsible for
- * calling flush_cache_vmap() on to-be-mapped areas before calling this
- * function.
+ * @pages: pages to map (always PAGE_SIZE pages)
+ * @page_shift: maximum shift that the pages may be mapped with, @pages must
+ * be aligned and contiguous up to at least this shift.
  *
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int map_kernel_range_noflush(unsigned long addr, unsigned long size,
-			     pgprot_t prot, struct page **pages)
-{
-	return vmap_pages_range_noflush(addr, addr + size, prot, pages, PAGE_SHIFT);
-}
-
-int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
-		struct page **pages)
+static int vmap_pages_range(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	int ret;
+	int err;
 
-	ret = map_kernel_range_noflush(start, size, prot, pages);
-	flush_cache_vmap(start, start + size);
-	return ret;
+	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	flush_cache_vmap(addr, end);
+	return err;
 }
 
 int is_vmalloc_or_module_addr(const void *x)
@@ -2156,10 +2143,12 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 
 	kasan_unpoison_vmalloc(mem, size);
 
-	if (map_kernel_range(addr, size, PAGE_KERNEL, pages) < 0) {
+	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
+				pages, PAGE_SHIFT) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
+
 	return mem;
 }
 EXPORT_SYMBOL(vm_map_ram);
@@ -2703,6 +2692,7 @@ void *vmap(struct page **pages, unsigned int count,
 	   unsigned long flags, pgprot_t prot)
 {
 	struct vm_struct *area;
+	unsigned long addr;
 	unsigned long size;		/* In bytes */
 
 	might_sleep();
@@ -2715,8 +2705,9 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_kernel_range((unsigned long)area->addr, size, pgprot_nx(prot),
-			pages) < 0) {
+	addr = (unsigned long)area->addr;
+	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
+				pages, PAGE_SHIFT) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
-- 
2.23.0

