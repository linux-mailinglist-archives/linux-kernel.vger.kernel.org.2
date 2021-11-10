Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C545B44BD29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhKJIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhKJIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:44:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B9C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:42:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h24so971970pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raVLPH1/MWxE4zs2FkbLjPSd/7tvVQ5+mBIXosP/gF0=;
        b=1rDJFDXpLh6rSmlfNKFmUYnJcwGRZ/tGj/0e2O9RSPT7ShFjnTF4E3U9P9TvQYsnHd
         OVunD8eQWZR57PQHWUnOO/VUHSTWpicDzeIx/WOvtP0fMojKPRwaTuyQqnr6bH92f5lx
         aRQxIFjof2Tj1itD9USI+JwaD7oZhYirQBHOyhH0ZiQv/U7PhU9EDeKJELK0ftt4a0BU
         Rmm828cvwKy1G0pjqFfchPh/6yXnE2oKqjxPaBBok2qT/n6GiibR9e46gCapYbmr6YBG
         eLoiTJrBZE+LnrgXxMFGjkFQQe2ur/+A0ECQgzti5oECuw/1hwZcdJG76oZAFVSY9hjL
         cZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raVLPH1/MWxE4zs2FkbLjPSd/7tvVQ5+mBIXosP/gF0=;
        b=JjD+IzTV3H2cLsKqwI6C0xKAKCyiBRPKW+EfJ8s64Ysv9ig+JvN58t3BNoM2RCNyM6
         42cP6B0gqyFO74Wj3qPpxx2TLbGmeGY0CPNdVW5B9GfNFzJqUKJ69e2KV+x1Dsp+wNwg
         pFLRXJ3BqcWyxEGoudk0w83/OzigSOqepRPTOjl6lXjh0LjTzWc7ovIqtt18AivJTfcE
         +fVpoS+PCCtEg5N5YYxnq0SCGiLovsDl4wp/DFaSwsbp9WacFMxv43RQ0dHCMhjLs3Rd
         to8stvkbHPyQ0/D+ttX876ocMbnzeI6AuAX9+5SoAYuwL9DJ/ecmKPNjMdLDjIAD3MX3
         +xmg==
X-Gm-Message-State: AOAM5331Sap0idJM6y86+uhLIjE4xWfAjXMq4gQPeNB7KrMKdgKBhQLz
        hmOe6+9Q8likpYVQicG9LVWgJw==
X-Google-Smtp-Source: ABdhPJwaauMvRloE2G2hZLmRcyFOYHFu5sjrScnEyzdsRrn+Qh+8FxVQY5T1HBJLSfs2V04ez92ZVw==
X-Received: by 2002:a17:90b:1644:: with SMTP id il4mr14758177pjb.39.1636533724441;
        Wed, 10 Nov 2021 00:42:04 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5485368pgl.38.2021.11.10.00.41.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:42:04 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 06/15] mm: introduce refcount for user PTE page table page
Date:   Wed, 10 Nov 2021 16:40:48 +0800
Message-Id: <20211110084057.27676-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Preface
==========

Now in order to pursue high performance, applications mostly use some
high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
physical memory for the following reasons::

 First of all, we should hold as few write locks of mmap_lock as possible,
 since the mmap_lock semaphore has long been a contention point in the
 memory management subsystem. The mmap()/munmap() hold the write lock, and
 the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
 madvise() instead of munmap() to released physical memory can reduce the
 competition of the mmap_lock.

 Secondly, after using madvise() to release physical memory, there is no
 need to build vma and allocate page tables again when accessing the same
 virtual address again, which can also save some time.

The following is the largest user PTE page table memory that can be
allocated by a single user process in a 32-bit and a 64-bit system.

+---------------------------+--------+---------+
|                           | 32-bit | 64-bit  |
+===========================+========+=========+
| user PTE page table pages | 3 MiB  | 512 GiB |
+---------------------------+--------+---------+
| user PMD page table pages | 3 KiB  | 1 GiB   |
+---------------------------+--------+---------+

(for 32-bit, take 3G user address space, 4K page size as an example;
 for 64-bit, take 48-bit address width, 4K page size as an example.)

After using madvise(), everything looks good, but as can be seen from the
above table, a single process can create a large number of PTE page tables
on a 64-bit system, since both of the MADV_DONTNEED and MADV_FREE will not
release page table memory. And before the process exits or calls munmap(),
the kernel cannot reclaim these pages even if these PTE page tables do not
map anything.

Therefore, we decided to introduce reference count to manage the PTE page
table life cycle, so that some free PTE page table memory in the system
can be dynamically released.

2. The reference count of user PTE page table pages
===================================================

We introduce two members for the struct page of the user PTE page table
page::

 union {
	pgtable_t pmd_huge_pte; /* protected by page->ptl */
	pmd_t *pmd;             /* PTE page only */
 };
 union {
	struct mm_struct *pt_mm; /* x86 pgds only */
	atomic_t pt_frag_refcount; /* powerpc */
	atomic_t pte_refcount;  /* PTE page only */
 };

The pmd member record the pmd entry that maps the user PTE page table page,
the pte_refcount member keep track of how many references to the user PTE
page table page.

The following people will hold a reference on the user PTE page table
page::

 The !pte_none() entry, such as regular page table entry that map physical
 pages, or swap entry, or migrate entry, etc.

 Visitor to the PTE page table entries, such as page table walker.

Any ``!pte_none()`` entry and visitor can be regarded as the user of its
PTE page table page. When the ``pte_refcount`` is reduced to 0, it means
that no one is using the PTE page table page, then this free PTE page
table page can be released back to the system at this time.

3. Helpers
==========

+---------------------+-------------------------------------------------+
| pte_ref_init        | Initialize the pte_refcount and pmd             |
+---------------------+-------------------------------------------------+
| pte_to_pmd          | Get the corresponding pmd                       |
+---------------------+-------------------------------------------------+
| pte_update_pmd      | Update the corresponding pmd                    |
+---------------------+-------------------------------------------------+
| pte_get             | Increment a pte_refcount                        |
+---------------------+-------------------------------------------------+
| pte_get_many        | Add a value to a pte_refcount                   |
+---------------------+-------------------------------------------------+
| pte_get_unless_zero | Increment a pte_refcount unless it is 0         |
+---------------------+-------------------------------------------------+
| pte_try_get         | Try to increment a pte_refcount                 |
+---------------------+-------------------------------------------------+
| pte_tryget_map      | Try to increment a pte_refcount before          |
|                     | pte_offset_map()                                |
+---------------------+-------------------------------------------------+
| pte_tryget_map_lock | Try to increment a pte_refcount before          |
|                     | pte_offset_map_lock()                           |
+---------------------+-------------------------------------------------+
| pte_put             | Decrement a pte_refcount                        |
+---------------------+-------------------------------------------------+
| pte_put_many        | Sub a value to a pte_refcount                   |
+---------------------+-------------------------------------------------+
| pte_put_vmf         | Decrement a pte_refcount in the page fault path |
+---------------------+-------------------------------------------------+

4. About this commit
====================
This commit just introduces some dummy helpers, the actual logic will
be implemented in future commits.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_types.h |  6 +++-
 include/linux/pte_ref.h  | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/Makefile              |  4 +--
 mm/pte_ref.c             | 55 ++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bb8c6f5f19bc..c599008d54fe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -149,11 +149,15 @@ struct page {
 		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			union {
+				pgtable_t pmd_huge_pte; /* protected by page->ptl */
+				pmd_t *pmd;             /* PTE page only */
+			};
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+				atomic_t pte_refcount;  /* PTE page only */
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
new file mode 100644
index 000000000000..b6d8335bdc59
--- /dev/null
+++ b/include/linux/pte_ref.h
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+#ifndef _LINUX_PTE_REF_H
+#define _LINUX_PTE_REF_H
+
+#include <linux/pgtable.h>
+
+enum pte_tryget_type {
+	TRYGET_SUCCESSED,
+	TRYGET_FAILED_ZERO,
+	TRYGET_FAILED_NONE,
+	TRYGET_FAILED_HUGE_PMD,
+};
+
+bool pte_get_unless_zero(pmd_t *pmd);
+enum pte_tryget_type pte_try_get(pmd_t *pmd);
+void pte_put_vmf(struct vm_fault *vmf);
+
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return NULL;
+}
+
+static inline void pte_update_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+}
+
+static inline void pte_get_many(pmd_t *pmd, unsigned int nr)
+{
+}
+
+/*
+ * pte_get - Increment refcount for the PTE page table.
+ * @pmd: a pointer to the pmd entry corresponding to the PTE page table.
+ *
+ * Similar to the mechanism of page refcount, the user of PTE page table
+ * should hold a refcount to it before accessing.
+ */
+static inline void pte_get(pmd_t *pmd)
+{
+	pte_get_many(pmd, 1);
+}
+
+static inline pte_t *pte_tryget_map(pmd_t *pmd, unsigned long address)
+{
+	if (pte_try_get(pmd))
+		return NULL;
+
+	return pte_offset_map(pmd, address);
+}
+
+static inline pte_t *pte_tryget_map_lock(struct mm_struct *mm, pmd_t *pmd,
+					 unsigned long address, spinlock_t **ptlp)
+{
+	if (pte_try_get(pmd))
+		return NULL;
+
+	return pte_offset_map_lock(mm, pmd, address, ptlp);
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned int nr)
+{
+}
+
+/*
+ * pte_put - Decrement refcount for the PTE page table.
+ * @mm: the mm_struct of the target address space.
+ * @pmd: a pointer to the pmd entry corresponding to the PTE page table.
+ * @addr: the start address of the tlb range to be flushed.
+ *
+ * The PTE page table page will be freed when the last refcount is dropped.
+ */
+static inline void pte_put(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+{
+	pte_put_many(mm, pmd, addr, 1);
+}
+
+#endif
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..ea679bf75a5f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -38,8 +38,8 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
-
+			   pgtable-generic.o rmap.o vmalloc.o \
+			   pte_ref.o
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
 mmu-$(CONFIG_MMU)	+= process_vm_access.o
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
new file mode 100644
index 000000000000..de109905bc8f
--- /dev/null
+++ b/mm/pte_ref.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+
+#include <linux/pte_ref.h>
+#include <linux/mm.h>
+
+/*
+ * pte_get_unless_zero - Increment refcount for the PTE page table
+ *			 unless it is zero.
+ * @pmd: a pointer to the pmd entry corresponding to the PTE page table.
+ */
+bool pte_get_unless_zero(pmd_t *pmd)
+{
+	return true;
+}
+
+/*
+ * pte_try_get - Try to increment refcount for the PTE page table.
+ * @pmd: a pointer to the pmd entry corresponding to the PTE page table.
+ *
+ * Return true if the increment succeeded. Otherwise return false.
+ *
+ * Before Operating the PTE page table, we need to hold a refcount
+ * to protect against the concurrent release of the PTE page table.
+ * But we will fail in the following case:
+ * 	- The content mapped in @pmd is not a PTE page
+ * 	- The refcount of the PTE page table is zero, it will be freed
+ */
+enum pte_tryget_type pte_try_get(pmd_t *pmd)
+{
+	if (unlikely(pmd_none(*pmd)))
+		return TRYGET_FAILED_NONE;
+	if (unlikely(is_huge_pmd(*pmd)))
+		return TRYGET_FAILED_HUGE_PMD;
+
+	return TRYGET_SUCCESSED;
+}
+
+/*
+ * pte_put_vmf - Decrement refcount for the PTE page table.
+ * @vmf: fault information
+ *
+ * The mmap_lock may be unlocked in advance in some cases
+ * in handle_pte_fault(), then the pmd entry will no longer
+ * be stable. For example, the corresponds of the PTE page may
+ * be replaced(e.g. mremap), so we should ensure the pte_put()
+ * is performed in the critical section of the mmap_lock.
+ */
+void pte_put_vmf(struct vm_fault *vmf)
+{
+}
-- 
2.11.0

