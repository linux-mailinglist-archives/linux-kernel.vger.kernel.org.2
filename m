Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D13F5ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhHXJRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhHXJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:17:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE08C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6zolBoOP5T9T037rbery01Tu/sHMVMHoRpN0E1MW6ew=; b=J+l1B3gDQK7kcJZWKvooklQOOV
        LUUwyB+0dYSyx0wY/9Kv6ibzNFJqqynvjPHa03BO8WwF3ZlGwCldU5/FkSfnPYjvAOdttJxD2VL1Q
        AlFgw/8oWnf41yodDVZuklKa9hZ5SjfOqmw6vnKH6hkILeOAL/6vA5eMYfPCEEoqefaMA7X2ZbphZ
        SIXvQIhxZh7nf4noo04LBTTczzHNmSocMRtQnH6D4M58xkGB28Rikub1Bmc7CLXr0B4p935hLRXu+
        Lwqtsj9yI5AGEXuj6Lnum7t2+adi7DzCaAxm0Arneq82e/fR8FgfVNZc/0LYZ2gGA25h71zV6QUI7
        /Y9vW5rw==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISVm-00ApxP-RK; Tue, 24 Aug 2021 09:14:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: move ioremap_page_range to vmalloc.c
Date:   Tue, 24 Aug 2021 11:12:58 +0200
Message-Id: <20210824091259.1324527-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824091259.1324527-1-hch@lst.de>
References: <20210824091259.1324527-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps it together with the implementation, and to remove the
vmap_range wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h |  3 ---
 mm/Makefile             |  3 ++-
 mm/ioremap.c            | 25 -------------------------
 mm/vmalloc.c            | 22 +++++++++++++++++-----
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2644425b6dce..671d402c3778 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -225,9 +225,6 @@ static inline bool is_vm_area_hugepages(const void *addr)
 }
 
 #ifdef CONFIG_MMU
-int vmap_range(unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift);
 void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
diff --git a/mm/Makefile b/mm/Makefile
index e3436741d539..0e0a5a6fe127 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -38,7 +38,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
+			   pgtable-generic.o rmap.o vmalloc.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
@@ -128,3 +128,4 @@ obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
+obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8ee0136f8cb0..5fe598ecd9b7 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -8,33 +8,9 @@
  */
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/io.h>
 #include <linux/export.h>
-#include <asm/cacheflush.h>
 
-#include "pgalloc-track.h"
-
-#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static unsigned int __ro_after_init iomap_max_page_shift = BITS_PER_LONG - 1;
-
-static int __init set_nohugeiomap(char *str)
-{
-	iomap_max_page_shift = PAGE_SHIFT;
-	return 0;
-}
-early_param("nohugeiomap", set_nohugeiomap);
-#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
-static const unsigned int iomap_max_page_shift = PAGE_SHIFT;
-#endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
-
-int ioremap_page_range(unsigned long addr,
-		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
-{
-	return vmap_range(addr, end, phys_addr, prot, iomap_max_page_shift);
-}
-
-#ifdef CONFIG_GENERIC_IOREMAP
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 {
 	unsigned long offset, vaddr;
@@ -71,4 +47,3 @@ void iounmap(volatile void __iomem *addr)
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 EXPORT_SYMBOL(iounmap);
-#endif /* CONFIG_GENERIC_IOREMAP */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5cd52805149..e44983fb2d15 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -44,6 +44,19 @@
 #include "internal.h"
 #include "pgalloc-track.h"
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+static unsigned int __ro_after_init ioremap_max_page_shift = BITS_PER_LONG - 1;
+
+static int __init set_nohugeiomap(char *str)
+{
+	ioremap_max_page_shift = PAGE_SHIFT;
+	return 0;
+}
+early_param("nohugeiomap", set_nohugeiomap);
+#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
+static const unsigned int ioremap_max_page_shift = PAGE_SHIFT;
+#endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
 static bool __ro_after_init vmap_allow_huge = true;
 
@@ -298,15 +311,14 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 	return err;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+int ioremap_page_range(unsigned long addr, unsigned long end,
+		phys_addr_t phys_addr, pgprot_t prot)
 {
 	int err;
 
-	err = vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
+	err = vmap_range_noflush(addr, end, phys_addr, prot,
+				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
-
 	return err;
 }
 
-- 
2.30.2

