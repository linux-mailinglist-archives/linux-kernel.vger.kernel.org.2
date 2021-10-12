Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7926D42AE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhJLU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhJLU7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0ECB60F3A;
        Tue, 12 Oct 2021 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072256;
        bh=nczoCJ2SZbtiqcQiLo3FQbEXBMbezXEEn5nf3DYR5kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0PRnUxJ+zkYK4V3DJlR/HW5HKFgw/lgt8kiDUKNKzcHoeHDugNhwhmFmBIdxQdxk
         ilJ+9d1j80quKFDz2qUTfuPCH6EZ6hkowvit6DYHv8damRzhkLt2eO7NAy5dDMwtYg
         iO9zp0IClwX3eTFEe1sEwZHdP6iXUOBBK8dHo7foHpt/WGMm4XINO30GTjaP1HIVpM
         IhaLElPf3+qwkiA2OTfYUFH5RyZhQd+8l8YQKRhZQa+CmEBEAha/hbpUQhbI3YYcom
         db6V2QjM9YPK2pMh+GRCysTDuiUssok/z8hvXefG764d/aYPJdbA7QssmkTgc4g4h/
         2YZcq3+Wbg0hA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm/damon/vaddr: Separate commonly usable functions
Date:   Tue, 12 Oct 2021 20:57:08 +0000
Message-Id: <20211012205711.29216-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves functions in the default virtual address spaces
monitoring primitives that commonly usable from other address spaces
like physical address space into a header file.  Those will be reused by
the physical address space monitoring primitives which will be
implemented by the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Makefile       |  2 +-
 mm/damon/prmtv-common.c | 88 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h | 17 ++++++++
 mm/damon/vaddr.c        | 87 +---------------------------------------
 4 files changed, 108 insertions(+), 86 deletions(-)
 create mode 100644 mm/damon/prmtv-common.c
 create mode 100644 mm/damon/prmtv-common.h

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index fed4be3bace3..99b1bfe01ff5 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DAMON)		:= core.o
-obj-$(CONFIG_DAMON_VADDR)	+= vaddr.o
+obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
new file mode 100644
index 000000000000..1768cbe1b9ff
--- /dev/null
+++ b/mm/damon/prmtv-common.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Primitives for Data Access Monitoring
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/highmem.h>
+#include <linux/mmu_notifier.h>
+#include <linux/page_idle.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+
+#include "prmtv-common.h"
+
+/*
+ * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
+ * NULL.
+ *
+ * The body of this function is stolen from the 'page_idle_get_page()'.  We
+ * steal rather than reuse it because the code is quite simple.
+ */
+struct page *damon_get_page(unsigned long pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+
+	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
+		return NULL;
+
+	if (unlikely(!PageLRU(page))) {
+		put_page(page);
+		page = NULL;
+	}
+	return page;
+}
+
+void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
+{
+	bool referenced = false;
+	struct page *page = damon_get_page(pte_pfn(*pte));
+
+	if (!page)
+		return;
+
+	if (pte_young(*pte)) {
+		referenced = true;
+		*pte = pte_mkold(*pte);
+	}
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+		referenced = true;
+#endif /* CONFIG_MMU_NOTIFIER */
+
+	if (referenced)
+		set_page_young(page);
+
+	set_page_idle(page);
+	put_page(page);
+}
+
+void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	bool referenced = false;
+	struct page *page = damon_get_page(pmd_pfn(*pmd));
+
+	if (!page)
+		return;
+
+	if (pmd_young(*pmd)) {
+		referenced = true;
+		*pmd = pmd_mkold(*pmd);
+	}
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (mmu_notifier_clear_young(mm, addr,
+				addr + ((1UL) << HPAGE_PMD_SHIFT)))
+		referenced = true;
+#endif /* CONFIG_MMU_NOTIFIER */
+
+	if (referenced)
+		set_page_young(page);
+
+	set_page_idle(page);
+	put_page(page);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+}
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
new file mode 100644
index 000000000000..7093d19e5d42
--- /dev/null
+++ b/mm/damon/prmtv-common.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Primitives for Data Access Monitoring
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/damon.h>
+#include <linux/random.h>
+
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
+struct page *damon_get_page(unsigned long pfn);
+
+void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
+void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 953c145b4f08..b8ba44f69db6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -8,25 +8,18 @@
 #define pr_fmt(fmt) "damon-va: " fmt
 
 #include <asm-generic/mman-common.h>
-#include <linux/damon.h>
 #include <linux/hugetlb.h>
-#include <linux/mm.h>
 #include <linux/mmu_notifier.h>
-#include <linux/highmem.h>
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
-#include <linux/random.h>
-#include <linux/sched/mm.h>
-#include <linux/slab.h>
+
+#include "prmtv-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
 #undef DAMON_MIN_REGION
 #define DAMON_MIN_REGION 1
 #endif
 
-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
-
 /*
  * 't->id' should be the pointer to the relevant 'struct pid' having reference
  * count.  Caller must put the returned task, unless it is NULL.
@@ -373,82 +366,6 @@ void damon_va_update(struct damon_ctx *ctx)
 	}
 }
 
-/*
- * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
- * NULL.
- *
- * The body of this function is stolen from the 'page_idle_get_page()'.  We
- * steal rather than reuse it because the code is quite simple.
- */
-static struct page *damon_get_page(unsigned long pfn)
-{
-	struct page *page = pfn_to_online_page(pfn);
-
-	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
-		return NULL;
-
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
-	}
-	return page;
-}
-
-static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
-			     unsigned long addr)
-{
-	bool referenced = false;
-	struct page *page = damon_get_page(pte_pfn(*pte));
-
-	if (!page)
-		return;
-
-	if (pte_young(*pte)) {
-		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
-		set_page_young(page);
-
-	set_page_idle(page);
-	put_page(page);
-}
-
-static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
-			     unsigned long addr)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool referenced = false;
-	struct page *page = damon_get_page(pmd_pfn(*pmd));
-
-	if (!page)
-		return;
-
-	if (pmd_young(*pmd)) {
-		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
-				addr + ((1UL) << HPAGE_PMD_SHIFT)))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
-		set_page_young(page);
-
-	set_page_idle(page);
-	put_page(page);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-}
-
 static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-- 
2.17.1

