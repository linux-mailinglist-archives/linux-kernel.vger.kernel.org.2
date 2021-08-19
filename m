Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F713F1176
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHSDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbhHSDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:20:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE4C06129D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so4522338pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLBiU6MTw+RMNLYbw/f1Gi4xCI37RzrwZeQgQIQle/g=;
        b=XqdFgyo+NtN349zfGYCa7cBgIZDm2l/eIEB/M86PrR9dgzA+xETAUX9oYTDkKvQA1F
         0qehKpAkLPYBlJIAP6Xrz8HE7dRYShnJxktZ/Uw/wYiNxVIA6oBnTA4YtE0fNwoW1lxD
         nSm9kNolLpczR16LRUJ5cB44sbYe3ER8OWT+9N0tSJxFwd2JF2hnQP8F1NM1b5YLAAK9
         q07VQA3AntKVRAEuUVzRXqqtDiojVVFohLqn0WBli3jvoFMH0Kzkk2/X70yXR9gKSEun
         sm3mLXIXkEZCaa0VPskwyV5FGxJr3U1Y75hJ7A3T99SSfKhy/4DW696FPJJtUyxFw5xY
         QY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLBiU6MTw+RMNLYbw/f1Gi4xCI37RzrwZeQgQIQle/g=;
        b=WaXSaN0wbID92JhXiMWwVBr4gHVK49AR1X48uSY8nVbtPbbt69HbiDqfycVViJ5h9j
         13dUg7QwjEoUT/nam7gLWrvCXKKzwVTt1BBLKThHD+veJI2xdpHyRlSbmYFZj1MfNbaz
         dL9CjYyhlW9FEwH9dHKOdwPe9NUiWuIYtHoSJEtSR0ie0YMIhBahimo4VHV5Gk+ObjkQ
         yluQTRtm6j6t3kQplJpr0fiB1xn9zRfBvOSNKZHq+I6aZhOQ+5AlUzqFBpcvY/bnZ3M1
         E9cI1+9b1uCdAT6m2OLwZ+NPZVt9Bzu0DTmNHRCITiwV8z5GCNwHjao2rVVGfz8gz6vM
         WqpA==
X-Gm-Message-State: AOAM532dmxtbrybbL5y05PZ3tZC7xqZiwelcMGB0VsrX0YFhGO+E4/Gj
        oiHUuDYIwlDX94DlMfneI4wxXA==
X-Google-Smtp-Source: ABdhPJxVzLvmCukKmupQAAw8OO3gBB9vWLzU81PVRCYfqTszXe9EYVmmMJe0oC/0SIL4wcHwRlnk5Q==
X-Received: by 2002:a65:641a:: with SMTP id a26mr12050636pgv.340.1629343212265;
        Wed, 18 Aug 2021 20:20:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:11 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/9] mm: move pte_alloc{,_map,_map_lock}() to a separate file
Date:   Thu, 19 Aug 2021 11:18:53 +0800
Message-Id: <20210819031858.98043-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will modify pte_alloc{,_map,_map_lock}(),
which are the allocate function related to user PTE page
table pages, so move those to a separate file in advance.

This patch contains no functional changes, only some
preparatory work.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/mm/pgd.c             |  1 +
 arch/arm64/mm/hugetlbpage.c   |  1 +
 arch/ia64/mm/hugetlbpage.c    |  1 +
 arch/parisc/mm/hugetlbpage.c  |  1 +
 arch/powerpc/mm/hugetlbpage.c |  1 +
 arch/s390/mm/gmap.c           |  1 +
 arch/s390/mm/pgtable.c        |  1 +
 arch/sh/mm/hugetlbpage.c      |  1 +
 arch/sparc/mm/hugetlbpage.c   |  1 +
 include/linux/mm.h            | 11 ----------
 include/linux/pte_ref.h       | 29 ++++++++++++++++++++++++++
 mm/Makefile                   |  3 ++-
 mm/internal.h                 |  1 +
 mm/memory.c                   | 38 ----------------------------------
 mm/pte_ref.c                  | 48 +++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 89 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index f8e9bc58a84f..dcac1124e8bd 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -8,6 +8,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
+#include <linux/pte_ref.h>
 
 #include <asm/cp15.h>
 #include <asm/pgalloc.h>
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 23505fc35324..6c8177647053 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
+#include <linux/pte_ref.h>
 #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..d343639db1ad 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/log2.h>
+#include <linux/pte_ref.h>
 #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d1d3990b83f6..4f6044d6b4bd 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -13,6 +13,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/sysctl.h>
+#include <linux/pte_ref.h>
 
 #include <asm/mman.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9a75ba078e1b..1afb8f552bcf 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
+#include <linux/pte_ref.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/setup.h>
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9bb2c7512cd5..c1826d74773a 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -18,6 +18,7 @@
 #include <linux/ksm.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/pte_ref.h>
 
 #include <asm/pgalloc.h>
 #include <asm/gmap.h>
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index eec3a9d7176e..594a6d6888e3 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -18,6 +18,7 @@
 #include <linux/sysctl.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
+#include <linux/pte_ref.h>
 
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 999ab5916e69..6a593ab248b7 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -15,6 +15,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/sysctl.h>
+#include <linux/pte_ref.h>
 
 #include <asm/mman.h>
 #include <asm/tlb.h>
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 0f49fada2093..4b9119825264 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/sysctl.h>
+#include <linux/pte_ref.h>
 
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57e48217bd71..369d4283de49 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2245,7 +2245,6 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
@@ -2371,15 +2370,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	pte_unmap(pte);					\
 } while (0)
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
-
-#define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
-
-#define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	(pte_alloc(mm, pmd) ?			\
-		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
-
 #define pte_alloc_kernel(pmd, address)			\
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
@@ -2471,7 +2461,6 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
-extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
new file mode 100644
index 000000000000..60b752dd7846
--- /dev/null
+++ b/include/linux/pte_ref.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free user PTE page table pages
+ *
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+#ifndef _LINUX_PTE_REF_H
+#define _LINUX_PTE_REF_H
+
+#include <linux/mm.h>
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
+
+#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
+
+#define pte_alloc_map(mm, pmd, address)			\
+	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+
+#define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
+	(pte_alloc(mm, pmd) ?				\
+		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
+
+#endif
+
diff --git a/mm/Makefile b/mm/Makefile
index 970604ea97dd..5cdbfaa2a7b5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -38,7 +38,8 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
+			   pgtable-generic.o rmap.o vmalloc.o ioremap.o \
+			   pte_ref.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/internal.h b/mm/internal.h
index b1001ebeb286..c1e23fa563a7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/pte_ref.h>
 
 /*
  * The set of flags that only affect watermark checking and reclaim
diff --git a/mm/memory.c b/mm/memory.c
index d2aaa85b840c..265b841cc7f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -433,44 +433,6 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
-{
-	spinlock_t *ptl = pmd_lock(mm, pmd);
-
-	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		mm_inc_nr_ptes(mm);
-		/*
-		 * Ensure all pte setup (eg. pte page lock and page clearing) are
-		 * visible before the pte is made visible to other CPUs by being
-		 * put into page tables.
-		 *
-		 * The other side of the story is the pointer chasing in the page
-		 * table walking code (when walking the page table without locking;
-		 * ie. most of the time). Fortunately, these data accesses consist
-		 * of a chain of data-dependent loads, meaning most CPUs (alpha
-		 * being the notable exception) will already guarantee loads are
-		 * seen in-order. See the alpha page table accessors for the
-		 * smp_rmb() barriers in page table walking code.
-		 */
-		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, *pte);
-		*pte = NULL;
-	}
-	spin_unlock(ptl);
-}
-
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
-{
-	pgtable_t new = pte_alloc_one(mm);
-	if (!new)
-		return -ENOMEM;
-
-	pmd_install(mm, pmd, &new);
-	if (new)
-		pte_free(mm, new);
-	return 0;
-}
-
 int __pte_alloc_kernel(pmd_t *pmd)
 {
 	pte_t *new = pte_alloc_one_kernel(&init_mm);
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
new file mode 100644
index 000000000000..07a73b5521cc
--- /dev/null
+++ b/mm/pte_ref.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free user PTE page table pages
+ *
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+
+#include <linux/pte_ref.h>
+
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	spinlock_t *ptl = pmd_lock(mm, pmd);
+
+	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		mm_inc_nr_ptes(mm);
+		/*
+		 * Ensure all pte setup (eg. pte page lock and page clearing) are
+		 * visible before the pte is made visible to other CPUs by being
+		 * put into page tables.
+		 *
+		 * The other side of the story is the pointer chasing in the page
+		 * table walking code (when walking the page table without locking;
+		 * ie. most of the time). Fortunately, these data accesses consist
+		 * of a chain of data-dependent loads, meaning most CPUs (alpha
+		 * being the notable exception) will already guarantee loads are
+		 * seen in-order. See the alpha page table accessors for the
+		 * smp_rmb() barriers in page table walking code.
+		 */
+		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
+		pmd_populate(mm, pmd, *pte);
+		*pte = NULL;
+	}
+	spin_unlock(ptl);
+}
+
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+{
+	pgtable_t new = pte_alloc_one(mm);
+	if (!new)
+		return -ENOMEM;
+
+	pmd_install(mm, pmd, &new);
+	if (new)
+		pte_free(mm, new);
+	return 0;
+}
-- 
2.11.0

