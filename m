Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21EC3436D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 03:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCVCwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCVCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:51:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E61C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:51:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l18so9296882edc.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IbnVfVjvai8WWdijFhIX6UW2gSw8Iz6xJ2spxlutEnk=;
        b=N83PQet/yiNP4WU03kxu7Nb/MytLj72u8MjiC+HZ6Usys+024sKBLks/rTACq+b0rT
         hfW5hRiGPca+QGNbZKkM2kR1crLXjdUc8s7HAEr5ddzWVD+f5W+TsDozCCyI5ti6Ck2b
         3TRPsceXlmy6Q8Af3GPcKnf738zjkkzi90Nw2zee10lZzTsd9Cni9ZQZ4KEXKxXiO9GN
         FYTvuHow6c6CykUglkMHB/ZIR8sawO/3kI4A5i50LgK5+zDUeZ57gc96nqpVYSGd7cfp
         E7ahkBa7A1EoONVRAirPTqsDf2hVuKVDLTz5Umbz4sDIJq0nV33KZhWt+ZhMYkBxW50w
         TT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=IbnVfVjvai8WWdijFhIX6UW2gSw8Iz6xJ2spxlutEnk=;
        b=Srcjy+HaZCSfwx5ScVl9bOtWxwTmNstrO6LyOP1kHqmrml1DHDVP3ka2mBmx4VcL5s
         cD5f9lgRq1Cz7AjogxJZ/4KozRMWxqoc0POjJkJ19O6A67tRJ+JnWmuJUEHO5zgdapwI
         SKXxQ6svRONzjqU1qvOYqwd2zGdZHvY4ZDJ5UtGIvMbw5c99ok37QQrLfWlVwQEuC5A3
         qbQ5sZ/SZKG2FlzveNjRdiRR/+9g6xYtBnOiPBykFwYIcLHU+fuX8SJe0ISw/sO6vGHu
         CmpMeauXswkQVkGDTMzxnZ1rnM6xGoYvpA7yoB8wzeOGyxOnxQyPUYWPUjq70WOMvb/k
         X0Cg==
X-Gm-Message-State: AOAM5337QpTvxZ3jFFtdV3ccRKkTQbPpNdpF1XFMs9dqNBSZL8Lz2/M9
        1xt+TQXo87LGmxPlCMqS4iQ=
X-Google-Smtp-Source: ABdhPJya+wPGgxsQM0ZHmS3IzsIrtpRchQkrNnTsdnZnC1vsk/Ds1ULgeuTBeKgMIcKT5PZwLbt99A==
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr22949780edy.59.1616381515489;
        Sun, 21 Mar 2021 19:51:55 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d15sm9984027edx.62.2021.03.21.19.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:51:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 22 Mar 2021 03:51:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH] mm: Fix typos in comments
Message-ID: <20210322025152.GA1922846@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix ~93 single-word typos in locking code comments, plus a few very 
obvious grammar mistakes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mm.h      |  2 +-
 include/linux/vmalloc.h |  4 ++--
 mm/balloon_compaction.c |  4 ++--
 mm/compaction.c         |  2 +-
 mm/filemap.c            |  2 +-
 mm/gup.c                |  2 +-
 mm/highmem.c            |  2 +-
 mm/huge_memory.c        |  4 ++--
 mm/hugetlb.c            |  4 ++--
 mm/internal.h           |  2 +-
 mm/kasan/kasan.h        |  8 ++++----
 mm/kasan/quarantine.c   |  4 ++--
 mm/kasan/shadow.c       |  4 ++--
 mm/kfence/report.c      |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/kmemleak.c           |  2 +-
 mm/ksm.c                |  4 ++--
 mm/madvise.c            |  4 ++--
 mm/memcontrol.c         | 18 +++++++++---------
 mm/memory-failure.c     |  2 +-
 mm/memory.c             | 12 ++++++------
 mm/mempolicy.c          |  4 ++--
 mm/migrate.c            |  8 ++++----
 mm/mmap.c               |  4 ++--
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 mm/oom_kill.c           |  2 +-
 mm/page-writeback.c     |  4 ++--
 mm/page_alloc.c         | 14 +++++++-------
 mm/page_owner.c         |  2 +-
 mm/page_reporting.c     |  2 +-
 mm/percpu-internal.h    |  2 +-
 mm/percpu.c             |  2 +-
 mm/pgalloc-track.h      |  6 +++---
 mm/slab.c               |  8 ++++----
 mm/slub.c               | 10 +++++-----
 mm/swap_slots.c         |  2 +-
 mm/swap_state.c         |  2 +-
 mm/swapfile.c           |  4 ++--
 mm/util.c               |  2 +-
 mm/vmalloc.c            |  8 ++++----
 mm/vmstat.c             |  2 +-
 mm/zpool.c              |  2 +-
 mm/zsmalloc.c           |  2 +-
 44 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..4a2cf5f75889 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -106,7 +106,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
  * embedding these tags into addresses that point to these memory regions, and
  * checking that the memory and the pointer tags match on memory accesses)
  * redefine this macro to strip tags from pointers.
- * It's defined as noop for arcitectures that don't support memory tagging.
+ * It's defined as noop for architectures that don't support memory tagging.
  */
 #ifndef untagged_addr
 #define untagged_addr(addr) (addr)
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index df92211cf771..936a15636b3d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -32,7 +32,7 @@ struct notifier_block;		/* in notifier.h */
  *
  * If IS_ENABLED(CONFIG_KASAN_VMALLOC), VM_KASAN is set on a vm_struct after
  * shadow memory has been mapped. It's used to handle allocation errors so that
- * we don't try to poision shadow on free if it was never allocated.
+ * we don't try to poison shadow on free if it was never allocated.
  *
  * Otherwise, VM_KASAN is set for kasan_module_alloc() allocations and used to
  * determine which allocations need the module shadow freed.
@@ -42,7 +42,7 @@ struct notifier_block;		/* in notifier.h */
 
 /*
  * Maximum alignment for ioremap() regions.
- * Can be overriden by arch-specific value.
+ * Can be overridden by arch-specific value.
  */
 #ifndef IOREMAP_MAX_ORDER
 #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..907fefde2572 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 /**
  * balloon_page_list_dequeue() - removes pages from balloon's page list and
  *				 returns a list of the pages.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  * @pages: pointer to the list of pages that would be returned to the caller.
  * @n_req_pages: number of requested pages.
  *
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  *
  * Driver must call this function to properly dequeue a previously enqueued page
  * before definitively releasing it back to the guest system.
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f4476e68e..048686fba230 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1977,7 +1977,7 @@ static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
 	unsigned int wmark_low;
 
 	/*
-	 * Cap the low watermak to avoid excessive compaction
+	 * Cap the low watermark to avoid excessive compaction
 	 * activity in case a user sets the proactivess tunable
 	 * close to 100 (maximum).
 	 */
diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..ab2403e94d0c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2663,7 +2663,7 @@ unsigned int seek_page_size(struct xa_state *xas, struct page *page)
  * entirely memory-based such as tmpfs, and filesystems which support
  * unwritten extents.
  *
- * Return: The requested offset on successs, or -ENXIO if @whence specifies
+ * Return: The requested offset on success, or -ENXIO if @whence specifies
  * SEEK_DATA and there is no data after @start.  There is an implicit hole
  * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
  * and @end contain data.
diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..50847c6ec2b8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1517,7 +1517,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
  * Returns NULL on any kind of failure - a hole must then be inserted into
  * the corefile, to preserve alignment with its headers; and also returns
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
- * allowing a hole to be left in the corefile to save diskspace.
+ * allowing a hole to be left in the corefile to save disk space.
  *
  * Called without mmap_lock (takes and releases the mmap_lock by itself).
  */
diff --git a/mm/highmem.c b/mm/highmem.c
index 86f2b9495f9c..bb92f0ab3b27 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -519,7 +519,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 
 	/*
 	 * Disable migration so resulting virtual address is stable
-	 * accross preemption.
+	 * across preemption.
 	 */
 	migrate_disable();
 	preempt_disable();
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae907a9c2050..d75186ae4d87 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1794,7 +1794,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 /*
  * Returns
  *  - 0 if PMD could not be locked
- *  - 1 if PMD was locked but protections unchange and TLB flush unnecessary
+ *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
  *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
@@ -2477,7 +2477,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
-	/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
 	lruvec = lock_page_lruvec(head);
 
 	for (i = nr - 1; i >= 1; i--) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b1ab1f427c5..e0d31fc17a11 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -442,7 +442,7 @@ static int allocate_file_region_entries(struct resv_map *resv,
 			      resv->region_cache_count;
 
 		/* At this point, we should have enough entries in the cache
-		 * for all the existings adds_in_progress. We should only be
+		 * for all the existing adds_in_progress. We should only be
 		 * needing to allocate for regions_needed.
 		 */
 		VM_BUG_ON(resv->region_cache_count < resv->adds_in_progress);
@@ -5306,7 +5306,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 
 	/*
 	 * vma need span at least one aligned PUD size and the start,end range
-	 * must at least partialy within it.
+	 * must at least partially within it.
 	 */
 	if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
 		(*end <= v_start) || (*start >= v_end))
diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..50fa5ca12336 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -309,7 +309,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 }
 
 /*
- * Stack area - atomatically grows in one direction
+ * Stack area - automatically grows in one direction
  *
  * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
  * do_mmap() forbids all other combinations.
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8c55634d6edd..d8d4163c15fe 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -38,9 +38,9 @@ extern bool kasan_flag_panic __ro_after_init;
 #define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define KASAN_TAG_MIN		0xF0 /* mimimum value for random tags */
+#define KASAN_TAG_MIN		0xF0 /* minimum value for random tags */
 #else
-#define KASAN_TAG_MIN		0x00 /* mimimum value for random tags */
+#define KASAN_TAG_MIN		0x00 /* minimum value for random tags */
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
@@ -375,7 +375,7 @@ static inline bool kasan_byte_accessible(const void *addr)
 #else /* CONFIG_KASAN_HW_TAGS */
 
 /**
- * kasan_poison - mark the memory range as unaccessible
+ * kasan_poison - mark the memory range as inaccessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
  * @size - range size, must be aligned to KASAN_GRANULE_SIZE
  * @value - value that's written to metadata for the range
@@ -404,7 +404,7 @@ bool kasan_byte_accessible(const void *addr);
 
 /**
  * kasan_poison_last_granule - mark the last granule of the memory range as
- * unaccessible
+ * inaccessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
  * @size - range size
  *
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 728fb24c5683..d8ccff4c1275 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -27,7 +27,7 @@
 /* Data structure and operations for quarantine queues. */
 
 /*
- * Each queue is a signle-linked list, which also stores the total size of
+ * Each queue is a single-linked list, which also stores the total size of
  * objects inside of it.
  */
 struct qlist_head {
@@ -138,7 +138,7 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 		local_irq_save(flags);
 
 	/*
-	 * As the object now gets freed from the quaratine, assume that its
+	 * As the object now gets freed from the quarantine, assume that its
 	 * free track is no longer valid.
 	 */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 63f43443f5d7..8dfe1e0c5006 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -316,7 +316,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	 * // rest of vmalloc process		<data dependency>
 	 * STORE p, a				LOAD shadow(x+99)
 	 *
-	 * If there is no barrier between the end of unpoisioning the shadow
+	 * If there is no barrier between the end of unpoisoning the shadow
 	 * and the store of the result to p, the stores could be committed
 	 * in a different order by CPU#0, and CPU#1 could erroneously observe
 	 * poison in the shadow.
@@ -384,7 +384,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  * How does this work?
  * -------------------
  *
- * We have a region that is page aligned, labelled as A.
+ * We have a region that is page aligned, labeled as A.
  * That might not map onto the shadow in a way that is page-aligned:
  *
  *                    start                     end
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index e3f71451ad9e..2a319c21c939 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -263,6 +263,6 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 	if (panic_on_warn)
 		panic("panic_on_warn set ...\n");
 
-	/* We encountered a memory unsafety error, taint the kernel! */
+	/* We encountered a memory safety error, taint the kernel! */
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..e4a7b3c2e11d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -667,7 +667,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 *
 		 * The page table that maps the page has been already unlinked
 		 * from the page table tree and this process cannot get
-		 * an additinal pin on the page.
+		 * an additional pin on the page.
 		 *
 		 * New pins can come later if the page is shared across fork,
 		 * but not from this process. The other process cannot write to
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c0014d3b91c1..f09f1a9402a9 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1202,7 +1202,7 @@ static void update_refs(struct kmemleak_object *object)
 }
 
 /*
- * Memory scanning is a long process and it needs to be interruptable. This
+ * Memory scanning is a long process and it needs to be interruptible. This
  * function checks whether such interrupt condition occurred.
  */
 static int scan_should_stop(void)
diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..f5a49c914ead 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1068,7 +1068,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		/*
 		 * Ok this is tricky, when get_user_pages_fast() run it doesn't
 		 * take any lock, therefore the check that we are going to make
-		 * with the pagecount against the mapcount is racey and
+		 * with the pagecount against the mapcount is racy and
 		 * O_DIRECT can happen right after the check.
 		 * So we clear the pte and flush the tlb before the check
 		 * this assure us that no O_DIRECT can happen after the check
@@ -1438,7 +1438,7 @@ static struct page *stable_node_dup(struct stable_node **_stable_node_dup,
 			 */
 			*_stable_node = found;
 			/*
-			 * Just for robustneess as stable_node is
+			 * Just for robustness, as stable_node is
 			 * otherwise left as a stable pointer, the
 			 * compiler shall optimize it away at build
 			 * time.
diff --git a/mm/madvise.c b/mm/madvise.c
index 01fef79ac761..63e489e5bfdb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -799,7 +799,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		if (end > vma->vm_end) {
 			/*
 			 * Don't fail if end > vma->vm_end. If the old
-			 * vma was splitted while the mmap_lock was
+			 * vma was split while the mmap_lock was
 			 * released the effect of the concurrent
 			 * operation may not cause madvise() to
 			 * have an undefined result. There may be an
@@ -1039,7 +1039,7 @@ process_madvise_behavior_valid(int behavior)
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
  *  MADV_COLD - the application is not expected to use this memory soon,
  *		deactivate pages in this range so that they can be reclaimed
- *		easily if memory pressure hanppens.
+ *		easily if memory pressure happens.
  *  MADV_PAGEOUT - the application is not expected to use this memory soon,
  *		page out the pages in this range immediately.
  *
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d850a..2234955344f7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -215,7 +215,7 @@ enum res_type {
 #define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
 #define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
-/* Used for OOM nofiier */
+/* Used for OOM notifier */
 #define OOM_CONTROL		(0)
 
 /*
@@ -898,7 +898,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
  * __count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
  * @idx: the event item
- * @count: the number of events that occured
+ * @count: the number of events that occurred
  */
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
@@ -1030,7 +1030,7 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	rcu_read_lock();
 	do {
 		/*
-		 * Page cache insertions can happen withou an
+		 * Page cache insertions can happen without an
 		 * actual mm context, e.g. during disk probing
 		 * on boot, loopback IO, acct() writes etc.
 		 */
@@ -1865,7 +1865,7 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
 	struct mem_cgroup *iter;
 
 	/*
-	 * Be careful about under_oom underflows becase a child memcg
+	 * Be careful about under_oom underflows because a child memcg
 	 * could have been added after mem_cgroup_mark_under_oom.
 	 */
 	spin_lock(&memcg_oom_lock);
@@ -2037,7 +2037,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
 		/*
 		 * There is no guarantee that an OOM-lock contender
 		 * sees the wakeups triggered by the OOM kill
-		 * uncharges.  Wake any sleepers explicitely.
+		 * uncharges.  Wake any sleepers explicitly.
 		 */
 		memcg_oom_recover(memcg);
 	}
@@ -4588,7 +4588,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * Foreign dirty flushing
  *
  * There's an inherent mismatch between memcg and writeback.  The former
- * trackes ownership per-page while the latter per-inode.  This was a
+ * tracks ownership per-page while the latter per-inode.  This was a
  * deliberate design decision because honoring per-page ownership in the
  * writeback path is complicated, may lead to higher CPU and IO overheads
  * and deemed unnecessary given that write-sharing an inode across
@@ -4603,9 +4603,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * triggering background writeback.  A will be slowed down without a way to
  * make writeback of the dirty pages happen.
  *
- * Conditions like the above can lead to a cgroup getting repatedly and
+ * Conditions like the above can lead to a cgroup getting repeatedly and
  * severely throttled after making some progress after each
- * dirty_expire_interval while the underyling IO device is almost
+ * dirty_expire_interval while the underlying IO device is almost
  * completely idle.
  *
  * Solving this problem completely requires matching the ownership tracking
@@ -5945,7 +5945,7 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 		return 0;
 
 	/*
-	 * We are now commited to this value whatever it is. Changes in this
+	 * We are now committed to this value whatever it is. Changes in this
 	 * tunable will only affect upcoming migrations, not the current one.
 	 * So we need to save it, and keep it going.
 	 */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..f7ed9559d494 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -75,7 +75,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
 			/*
 			 * We could fail to take off the target page from buddy
-			 * for example due to racy page allocaiton, but that's
+			 * for example due to racy page allocation, but that's
 			 * acceptable because soft-offlined page is not broken
 			 * and if someone really want to use it, they should
 			 * take it.
diff --git a/mm/memory.c b/mm/memory.c
index 5efa07fb6cdc..a0d4fedd5e9b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3686,7 +3686,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		return ret;
 
 	/*
-	 * Archs like ppc64 need additonal space to store information
+	 * Archs like ppc64 need additional space to store information
 	 * related to pte entry. Use the preallocated table for that.
 	 */
 	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
@@ -4118,8 +4118,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 
 	/*
-	 * Make it present again, Depending on how arch implementes non
-	 * accessible ptes, some can allow access by kernel mode.
+	 * Make it present again, depending on how arch implements
+	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
 	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
@@ -4454,7 +4454,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 }
 
 /**
- * mm_account_fault - Do page fault accountings
+ * mm_account_fault - Do page fault accounting
  *
  * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
  *        of perf event counters, but we'll still do the per-task accounting to
@@ -4463,7 +4463,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
  * @flags: the fault flags.
  * @ret: the fault retcode.
  *
- * This will take care of most of the page fault accountings.  Meanwhile, it
+ * This will take care of most of the page fault accounting.  Meanwhile, it
  * will also include the PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN] perf counter
  * updates.  However note that the handling of PERF_COUNT_SW_PAGE_FAULTS should
  * still be in per-arch page fault handlers at the entry of page fault.
@@ -4799,7 +4799,7 @@ int follow_phys(struct vm_area_struct *vma,
 /**
  * generic_access_phys - generic implementation for iomem mmap access
  * @vma: the vma to access
- * @addr: userspace addres, not relative offset within @vma
+ * @addr: userspace address, not relative offset within @vma
  * @buf: buffer to read/write
  * @len: length of transfer
  * @write: set to FOLL_WRITE when writing, otherwise reading
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ab51132547b8..75eb13aea0d0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1863,7 +1863,7 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	 * we apply policy when gfp_zone(gfp) = ZONE_MOVABLE only.
 	 *
 	 * policy->v.nodes is intersect with node_states[N_MEMORY].
-	 * so if the following test faile, it implies
+	 * so if the following test fails, it implies
 	 * policy->v.nodes has movable memory only.
 	 */
 	if (!nodes_intersects(policy->v.nodes, node_states[N_HIGH_MEMORY]))
@@ -2094,7 +2094,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
  *
  * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
  * policy.  Otherwise, check for intersection between mask and the policy
- * nodemask for 'bind' or 'interleave' policy.  For 'perferred' or 'local'
+ * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
  * policy, always return true since it may allocate elsewhere on fallback.
  *
  * Takes task_lock(tsk) to prevent freeing of its mempolicy.
diff --git a/mm/migrate.c b/mm/migrate.c
index 62b81d5257aa..7e5c6912eda3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2823,11 +2823,11 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
  *
  * For empty entries inside CPU page table (pte_none() or pmd_none() is true) we
  * do set MIGRATE_PFN_MIGRATE flag inside the corresponding source array thus
- * allowing the caller to allocate device memory for those unback virtual
- * address.  For this the caller simply has to allocate device memory and
+ * allowing the caller to allocate device memory for those unbacked virtual
+ * addresses.  For this the caller simply has to allocate device memory and
  * properly set the destination entry like for regular migration.  Note that
- * this can still fails and thus inside the device driver must check if the
- * migration was successful for those entries after calling migrate_vma_pages()
+ * this can still fail, and thus inside the device driver you must check if the
+ * migration was successful for those entries after calling migrate_vma_pages(),
  * just like for regular migration.
  *
  * After that, the callers must call migrate_vma_pages() to go over each entry
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..7d0e6f1de86e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -606,7 +606,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 	unsigned long nr_pages = 0;
 	struct vm_area_struct *vma;
 
-	/* Find first overlaping mapping */
+	/* Find first overlapping mapping */
 	vma = find_vma_intersection(mm, addr, end);
 	if (!vma)
 		return 0;
@@ -2869,7 +2869,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
-		 * will remain splitted, but userland will get a
+		 * will remain split, but userland will get a
 		 * highly unexpected error anyway. This is no
 		 * different than the case where the first of the two
 		 * __split_vma fails, but we don't undo the first
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 94188df1ee55..e7a443157988 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -699,7 +699,7 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 	mmap_write_unlock(current->mm);
 
 	/*
-	 * We could provie warnings or errors if any VMA still
+	 * We could provide warnings or errors if any VMA still
 	 * has the pkey set here.
 	 */
 	return ret;
diff --git a/mm/mremap.c b/mm/mremap.c
index ec8f840399ed..32d11e958814 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -730,7 +730,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	 * So, to avoid such scenario we can pre-compute if the whole
 	 * operation has high chances to success map-wise.
 	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmaping it.
+	 * split in 3 before unmapping it.
 	 * That means 2 more maps (1 for each) to the ones we already hold.
 	 * Check whether current map count plus 2 still leads us to 4 maps below
 	 * the threshold, otherwise return -ENOMEM here to be more safe.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9efaf430cfd3..8248163321af 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -74,7 +74,7 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 
 #ifdef CONFIG_NUMA
 /**
- * oom_cpuset_eligible() - check task eligiblity for kill
+ * oom_cpuset_eligible() - check task eligibility for kill
  * @start: task struct of which task to consider
  * @oc: pointer to struct oom_control
  *
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..0d8e2340a235 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1806,7 +1806,7 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 			break;
 
 		/*
-		 * In the case of an unresponding NFS server and the NFS dirty
+		 * In the case of an unresponsive NFS server and the NFS dirty
 		 * pages exceeds dirty_thresh, give the other good wb's a pipe
 		 * to go through, so that tasks on them still remain responsive.
 		 *
@@ -2216,7 +2216,7 @@ int write_cache_pages(struct address_space *mapping,
 			 * Page truncated or invalidated. We can freely skip it
 			 * then, even for data integrity operations: the page
 			 * has disappeared concurrently, so there could be no
-			 * real expectation of this data interity operation
+			 * real expectation of this data integrity operation
 			 * even if there is now a new, dirty page at the same
 			 * pagecache address.
 			 */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..91ad3a335bf1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -867,7 +867,7 @@ compaction_capture(struct capture_control *capc, struct page *page,
 		return false;
 
 	/*
-	 * Do not let lower order allocations polluate a movable pageblock.
+	 * Do not let lower order allocations pollute a movable pageblock.
 	 * This might let an unmovable request use a reclaimable pageblock
 	 * and vice-versa but no more than normal fallback logic which can
 	 * have trouble finding a high-order free page.
@@ -2731,7 +2731,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			/*
 			 * In page freeing path, migratetype change is racy so
 			 * we can counter several free pages in a pageblock
-			 * in this loop althoug we changed the pageblock type
+			 * in this loop although we changed the pageblock type
 			 * from highatomic to ac->migratetype. So we should
 			 * adjust the count once.
 			 */
@@ -3035,7 +3035,7 @@ static void drain_local_pages_wq(struct work_struct *work)
 	 * drain_all_pages doesn't use proper cpu hotplug protection so
 	 * we can race with cpu offline when the WQ can move this from
 	 * a cpu pinned worker to an unbound one. We can operate on a different
-	 * cpu which is allright but we also have to make sure to not move to
+	 * cpu which is alright but we also have to make sure to not move to
 	 * a different one.
 	 */
 	preempt_disable();
@@ -5736,7 +5736,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
 static int __parse_numa_zonelist_order(char *s)
 {
 	/*
-	 * We used to support different zonlists modes but they turned
+	 * We used to support different zonelists modes but they turned
 	 * out to be just not useful. Let's keep the warning in place
 	 * if somebody still use the cmd line parameter so that we do
 	 * not fail it silently
@@ -7477,7 +7477,7 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
 }
 
 /*
- * Some architecturs, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
+ * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
  * such cases we allow max_zone_pfn sorted in the descending order
  */
 bool __weak arch_has_descending_max_zone_pfns(void)
@@ -8503,7 +8503,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
- * @migratetype:	migratetype of the underlaying pageblocks (either
+ * @migratetype:	migratetype of the underlying pageblocks (either
  *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
  *			in range must have the same migratetype and it must
  *			be either of the two.
@@ -8773,7 +8773,7 @@ EXPORT_SYMBOL(free_contig_range);
 
 /*
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
- * page high values need to be recalulated.
+ * page high values need to be recalculated.
  */
 void __meminit zone_pcp_update(struct zone *zone)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d15c7c4994f5..72efb6547648 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -247,7 +247,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	/*
 	 * We don't clear the bit on the oldpage as it's going to be freed
 	 * after migration. Until then, the info can be useful in case of
-	 * a bug, and the overal stats will be off a bit only temporarily.
+	 * a bug, and the overall stats will be off a bit only temporarily.
 	 * Also, migrate_misplaced_transhuge_page() can still fail the
 	 * migration and then we want the oldpage to retain the info. But
 	 * in that case we also don't need to explicitly clear the info from
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index c50d93ffa252..8b9197074632 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -86,7 +86,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 			continue;
 
 		/*
-		 * If page was not comingled with another page we can
+		 * If page was not commingled with another page we can
 		 * consider the result to be "reported" since the page
 		 * hasn't been modified, otherwise we will need to
 		 * report on the new larger page when we make our way
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 18b768ac7dca..d99a56e4fc17 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -170,7 +170,7 @@ struct percpu_stats {
 	u64 nr_max_alloc;	/* max # of live allocations */
 	u32 nr_chunks;		/* current # of live chunks */
 	u32 nr_max_chunks;	/* max # of live chunks */
-	size_t min_alloc_size;	/* min allocaiton size */
+	size_t min_alloc_size;	/* min allocation size */
 	size_t max_alloc_size;	/* max allocation size */
 };
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 6596a0a4286e..9b556761e6b0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1862,7 +1862,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 			pr_info("limit reached, disable warning\n");
 	}
 	if (is_atomic) {
-		/* see the flag handling in pcpu_blance_workfn() */
+		/* see the flag handling in pcpu_balance_workfn() */
 		pcpu_atomic_alloc_failed = true;
 		pcpu_schedule_balance_work();
 	} else {
diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
index 1dcc865029a2..e9e879de8649 100644
--- a/mm/pgalloc-track.h
+++ b/mm/pgalloc-track.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PGALLLC_TRACK_H
-#define _LINUX_PGALLLC_TRACK_H
+#ifndef _LINUX_PGALLOC_TRACK_H
+#define _LINUX_PGALLOC_TRACK_H
 
 #if defined(CONFIG_MMU)
 static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
@@ -48,4 +48,4 @@ static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
 	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
 		NULL: pte_offset_kernel(pmd, address))
 
-#endif /* _LINUX_PGALLLC_TRACK_H */
+#endif /* _LINUX_PGALLOC_TRACK_H */
diff --git a/mm/slab.c b/mm/slab.c
index ae651bf540b7..126d347ccd6d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -259,7 +259,7 @@ static void kmem_cache_node_init(struct kmem_cache_node *parent)
 
 #define BATCHREFILL_LIMIT	16
 /*
- * Optimization question: fewer reaps means less probability for unnessary
+ * Optimization question: fewer reaps means less probability for unnecessary
  * cpucache drain/refill cycles.
  *
  * OTOH the cpuarrays can contain lots of objects,
@@ -2284,7 +2284,7 @@ void __kmem_cache_release(struct kmem_cache *cachep)
  * Because if it is the case, that means we defer the creation of
  * the kmalloc_{dma,}_cache of size sizeof(slab descriptor) to this point.
  * And we eventually call down to __kmem_cache_create(), which
- * in turn looks up in the kmalloc_{dma,}_caches for the disired-size one.
+ * in turn looks up in the kmalloc_{dma,}_caches for the desired-size one.
  * This is a "chicken-and-egg" problem.
  *
  * So the off-slab slab descriptor shall come from the kmalloc_{dma,}_caches,
@@ -2381,8 +2381,8 @@ union freelist_init_state {
 };
 
 /*
- * Initialize the state based on the randomization methode available.
- * return true if the pre-computed list is available, false otherwize.
+ * Initialize the state based on the randomization method available.
+ * return true if the pre-computed list is available, false otherwise.
  */
 static bool freelist_state_initialize(union freelist_init_state *state,
 				struct kmem_cache *cachep,
diff --git a/mm/slub.c b/mm/slub.c
index 3021ce9bf1b3..a48892cc8359 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3,7 +3,7 @@
  * SLUB: A slab allocator that limits cache line use instead of queuing
  * objects in per cpu and per node lists.
  *
- * The allocator synchronizes using per slab locks or atomic operatios
+ * The allocator synchronizes using per slab locks or atomic operations
  * and only uses a centralized lock to manage a pool of partial slabs.
  *
  * (C) 2007 SGI, Christoph Lameter
@@ -160,7 +160,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #undef SLUB_DEBUG_CMPXCHG
 
 /*
- * Mininum number of partial slabs. These will be left on the partial
+ * Minimum number of partial slabs. These will be left on the partial
  * lists even if they are empty. kmem_cache_shrink may reclaim them.
  */
 #define MIN_PARTIAL 5
@@ -832,7 +832,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
  *
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
- * 	C. Padding to reach required alignment boundary or at mininum
+ * 	C. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -3390,7 +3390,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  */
 
 /*
- * Mininum / Maximum order of slab pages. This influences locking overhead
+ * Minimum / Maximum order of slab pages. This influences locking overhead
  * and slab fragmentation. A higher order reduces the number of partial slabs
  * and increases the number of allocations possible without having to
  * take the list_lock.
@@ -3421,7 +3421,7 @@ static unsigned int slub_min_objects;
  *
  * Higher order allocations also allow the placement of more objects in a
  * slab and thereby reduce object handling overhead. If the user has
- * requested a higher mininum order then we start with that one instead of
+ * requested a higher minimum order then we start with that one instead of
  * the smallest order which will fit the object.
  */
 static inline unsigned int slab_order(unsigned int size,
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index be9de6d5b516..0158aa9c3e55 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -16,7 +16,7 @@
  * to local caches without needing to acquire swap_info
  * lock.  We do not reuse the returned slots directly but
  * move them back to the global pool in a batch.  This
- * allows the slots to coaellesce and reduce fragmentation.
+ * allows the slots to coalescence and reduce fragmentation.
  *
  * The swap entry allocated is marked with SWAP_HAS_CACHE
  * flag in map_count that prevents it from being allocated
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3cdee7b11da9..5d1fafffee4e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -797,7 +797,7 @@ static void swap_ra_info(struct vm_fault *vmf,
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
- * Primitive swap readahead code. We simply read in a few pages whoes
+ * Primitive swap readahead code. We simply read in a few pages whose
  * virtual addresses are around the fault address in the same vma.
  *
  * Caller must hold read mmap_lock if vmf->vma is not NULL.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 084a5b9a18e5..5b052435eb6a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -164,7 +164,7 @@ static inline struct swap_extent *next_se(struct swap_extent *se)
 
 /*
  * swapon tell device that all the old swap contents can be discarded,
- * to allow the swap device to optimize its wear-levelling.
+ * to allow the swap device to optimize its wear-leveling.
  */
 static int discard_swap(struct swap_info_struct *si)
 {
@@ -234,7 +234,7 @@ sector_t swap_page_sector(struct page *page)
 
 /*
  * swap allocation tell device that a cluster of swap can now be discarded,
- * to allow the swap device to optimize its wear-levelling.
+ * to allow the swap device to optimize its wear-leveling.
  */
 static void discard_swap_cluster(struct swap_info_struct *si,
 				 pgoff_t start_page, pgoff_t nr_pages)
diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..f85da35b50eb 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -775,7 +775,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 	 * The deviation of sync_overcommit_as could be big with loose policy
 	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
 	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
-	 * with the strict "NEVER", and to avoid possible race condtion (even
+	 * with the strict "NEVER", and to avoid possible race condition (even
 	 * though user usually won't too frequently do the switching to policy
 	 * OVERCOMMIT_NEVER), the switch is done in the following order:
 	 *	1. changing the batch
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c907897..20e6392b5f19 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1312,7 +1312,7 @@ static unsigned long lazy_max_pages(void)
 static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
 
 /*
- * Serialize vmap purging.  There is no actual criticial section protected
+ * Serialize vmap purging.  There is no actual critical section protected
  * by this look, but we want to avoid concurrent calls for performance
  * reasons and to make the pcpu_get_vm_areas more deterministic.
  */
@@ -2348,7 +2348,7 @@ static void __vfree(const void *addr)
  * May sleep if called *not* from interrupt context.
  * Must not be called in NMI context (strictly speaking, it could be
  * if we have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, but making the calling
- * conventions for vfree() arch-depenedent would be a really bad idea).
+ * conventions for vfree() arch-dependent would be a really bad idea).
  */
 void vfree(const void *addr)
 {
@@ -2797,7 +2797,7 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 		/*
 		 * To do safe access to this _mapped_ area, we need
 		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calles for this _debug_
+		 * overhead of vmalloc()/vfree() calls for this _debug_
 		 * interface, rarely used. Instead of that, we'll use
 		 * kmap() and get small overhead in this access function.
 		 */
@@ -2836,7 +2836,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
 		/*
 		 * To do safe access to this _mapped_ area, we need
 		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calles for this _debug_
+		 * overhead of vmalloc()/vfree() calls for this _debug_
 		 * interface, rarely used. Instead of that, we'll use
 		 * kmap() and get small overhead in this access function.
 		 */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 74b2c374b86c..d88ebe2be336 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -934,7 +934,7 @@ void cpu_vm_stats_fold(int cpu)
 
 /*
  * this is only called if !populated_zone(zone), which implies no other users of
- * pset->vm_stat_diff[] exsist.
+ * pset->vm_stat_diff[] exist.
  */
 void drain_zonestat(struct zone *zone, struct per_cpu_pageset *pset)
 {
diff --git a/mm/zpool.c b/mm/zpool.c
index 5ed71207ced7..6d9ed48141e5 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -336,7 +336,7 @@ int zpool_shrink(struct zpool *zpool, unsigned int pages,
  * This may hold locks, disable interrupts, and/or preemption,
  * and the zpool_unmap_handle() must be called to undo those
  * actions.  The code that uses the mapped handle should complete
- * its operatons on the mapped handle memory quickly and unmap
+ * its operations on the mapped handle memory quickly and unmap
  * as soon as possible.  As the implementation may use per-cpu
  * data, multiple handles should not be mapped concurrently on
  * any cpu.
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 30c358b72025..c209339ac6eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1227,7 +1227,7 @@ EXPORT_SYMBOL_GPL(zs_get_total_pages);
  * zs_map_object - get address of allocated object from handle.
  * @pool: pool from which the object was allocated
  * @handle: handle returned from zs_malloc
- * @mm: maping mode to use
+ * @mm: mapping mode to use
  *
  * Before using an object allocated from zs_malloc, it must be mapped using
  * this function. When done with the object, it must be unmapped using
