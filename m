Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB733F061
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCQMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:31:01 -0400
Received: from casper.infradead.org ([90.155.50.34]:33930 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCQMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RYxyai88D7qk6ylcehCkd/JqkF1JTgM0w0Wj0hMnu3k=; b=FX4fLss+k/0ohPZfbd+J/iskBT
        evSLbsAncZPK+Nz+Otanjr97MFhjL4G/41cnENvJdlrB7NOzMTeWsSw+wsZuODV/yWdIopUsnE6CN
        VFdeasFQign9Q8X3vYDv0cvYj4no3BF6s5BIisRGlX4+WzDEUMYVftIFk5UIV4aT2J4gH6BBSJPLP
        fXuHr/6mL0g4t9Ttsx/aNXPlbIi95JEGLvqiPzT3jXa2CJyl3XspSmkcUIDfHFR4XtCcPWBeNuBoL
        O+cR7GUFmyOXe376Nss+cX225qCY/1E5Ugif4brmMO8jTQtr3A63kKYI4AZOaDteHlirFPqyHZaDs
        iwS1H4Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMVJV-001T5w-9w; Wed, 17 Mar 2021 12:30:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: Move page_mapping_file to pagemap.h
Date:   Wed, 17 Mar 2021 12:30:11 +0000
Message-Id: <20210317123011.350118-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_mapping_file() is only used by some architectures, and then it
is usually only used in one place.  Make it a static inline function
so other architectures don't have to carry this dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2: Ensure pagemap.h is included in all the files which use page_mapping_file
 arch/arm/mm/copypage-v4mc.c   |  1 +
 arch/arm/mm/copypage-v6.c     |  1 +
 arch/arm/mm/copypage-xscale.c |  1 +
 arch/csky/abiv1/cacheflush.c  |  1 +
 arch/mips/mm/cache.c          |  1 +
 arch/nios2/mm/cacheflush.c    |  1 +
 arch/sh/mm/cache-sh4.c        |  1 +
 arch/sh/mm/cache-sh7705.c     |  1 +
 arch/sparc/mm/tlb.c           |  1 +
 include/linux/mm.h            |  1 -
 include/linux/pagemap.h       | 10 ++++++++++
 mm/util.c                     | 10 ----------
 12 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 44f7292ec27b..f1da3b439b96 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 6a769a6c314e..d8a115de5507 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/shmparam.h>
 #include <asm/tlbflush.h>
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index eb5d338657d1..bcb485620a05 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index 9f1fe80cc847..07ff17ea33de 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/spinlock.h>
 #include <asm/page.h>
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 7719d632df8d..a7bf0c80371c 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -15,6 +15,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/processor.h>
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 65de1bd6a760..6aa9257c3ede 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpuinfo.h>
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index ddfa9685f1ef..72c2e1b46c08 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/mmu_context.h>
 #include <asm/cache_insns.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
index 4c67b3d88775..9b63a53a5e46 100644
--- a/arch/sh/mm/cache-sh7705.c
+++ b/arch/sh/mm/cache-sh7705.c
@@ -13,6 +13,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/threads.h>
 #include <asm/addrspace.h>
 #include <asm/page.h>
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 20ee14739333..9a725547578e 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/preempt.h>
+#include <linux/pagemap.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fbe0843daa90..f69a72f63e44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1645,7 +1645,6 @@ static inline pgoff_t page_index(struct page *page)
 
 bool page_mapped(struct page *page);
 struct address_space *page_mapping(struct page *page);
-struct address_space *page_mapping_file(struct page *page);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 08fa117f405c..f68fe61c1dec 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -162,6 +162,16 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 
 void release_pages(struct page **pages, int nr);
 
+/*
+ * For file cache pages, return the address_space, otherwise return NULL
+ */
+static inline struct address_space *page_mapping_file(struct page *page)
+{
+	if (unlikely(PageSwapCache(page)))
+		return NULL;
+	return page_mapping(page);
+}
+
 /*
  * speculatively take a reference to a page.
  * If the page is free (_refcount == 0), then _refcount is untouched, and 0
diff --git a/mm/util.c b/mm/util.c
index 143c627fb3e8..972e7a0cda5e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -711,16 +711,6 @@ struct address_space *page_mapping(struct page *page)
 }
 EXPORT_SYMBOL(page_mapping);
 
-/*
- * For file cache pages, return the address_space, otherwise return NULL
- */
-struct address_space *page_mapping_file(struct page *page)
-{
-	if (unlikely(PageSwapCache(page)))
-		return NULL;
-	return page_mapping(page);
-}
-
 /* Slow path of page_mapcount() for compound pages */
 int __page_mapcount(struct page *page)
 {
-- 
2.30.1

