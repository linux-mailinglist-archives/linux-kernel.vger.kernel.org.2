Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0838C0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhEUHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhEUHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:46:01 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:44:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id s11-20020ac8758b0000b029020e731296abso4005557qtq.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=lP5la/LgHRfJCa2dtRcYDqy9eGV1F3X/UaEucDOtQFc=;
        b=GMrWWk4RTD7u+aW+ekEeE7FTq8wO6w2eZuJgfpYowaLRhNXYD5K+vL97W0fa8N3R7I
         +iIN0h2gFEf0TirGW4HKTX+ONmTDIJ0SBj/mU+92EnFWj4LrGGyMAHduvxXoq0pbsQsP
         t+foKTCgq8qS+NDKfT0snnxTR4LPvzSUVSvnkzgKLNxaAW6XMyYZ3aDq8k7/WldkxBVG
         7o76EL+cItj8NyglhrZCAixB9jIk8dB4tVLyneq/NX1sqVKpQRooiUwOcOa26KSGoVqw
         377633VFQHHs2rZgS8oKACiFUMtWaf2JXkiu0AVwwTwsZZoOK+XrRR5kT5cFOsBhokWO
         y49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=lP5la/LgHRfJCa2dtRcYDqy9eGV1F3X/UaEucDOtQFc=;
        b=TyfiAaJfjlXaMggM3C3zJg73Qdohs4mLJQQ6EG/uDe9eC+mIx+XLCEwr0NWQs0UD3U
         ib7YNx75AGRD7L1ly8rX9y9bDgUWO8uBzG3LNy5IDtg8DV3jdnmJ/cvfeaNwJJ1RjEnA
         5Y3L1Wl8tuquBTh7ZDS9LvfBiExv/J0KbQ/onVhOug81HqcokTnC7jX5/jk6JnZe5XMF
         W675HBDHiLtEuQl2Pe+8kGt+i41BBeLRo+Lo2BoewvR/QmSzQrquCRlwXB7grC/5t6D1
         qAtY5wseRty/3OHqZVv30nKIfw88zRagVC6uYoP+aub5Gw3ocDJFiEPHd8CqxJXXa87T
         qVJA==
X-Gm-Message-State: AOAM531MN1pGcBliuw/Gv8iN5U4hR3oHNdLerUnY7vBphsplszLSLgkW
        NdoawIJWoaLtbrVM15DoKZ+5TXAcVvs3l7D3Bg==
X-Google-Smtp-Source: ABdhPJxtOF1b5CW5lvRNV2ebg6deZI74Or1G55/UUcPeCuV9l855p9+7HVEue6vff1jUgZAonnr5ag4iTfNMWodgLQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:234d:700a:7e48:613e])
 (user=almasrymina job=sendgmr) by 2002:a05:6214:21ce:: with SMTP id
 d14mr10874416qvh.47.1621583077485; Fri, 21 May 2021 00:44:37 -0700 (PDT)
Date:   Fri, 21 May 2021 00:44:33 -0700
Message-Id: <20210521074433.931380-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userfaultfd hugetlb tests detect a resv_huge_pages underflow. This
happens when hugetlb_mcopy_atomic_pte() is called with !is_continue on
an index for which we already have a page in the cache. When this
happens, we allocate a second page, double consuming the reservation,
and then fail to insert the page into the cache and return -EEXIST.

To fix this, we first if there exists a page in the cache which already
consumed the reservation, and return -EEXIST immediately if so.

Secondly, if we fail to copy the page contents while holding the
hugetlb_fault_mutex, we will drop the mutex and return to the caller
after allocating a page that consumed a reservation. In this case there
may be a fault that double consumes the reservation. To handle this, we
free the allocated page, fix the reservations, and allocate a temporary
hugetlb page and return that to the caller. When the caller does the
copy outside of the lock, we again check the cache, and allocate a page
consuming the reservation, and copy over the contents.

Test:
Hacked the code locally such that resv_huge_pages underflows produce
a warning and the copy_huge_page_from_user() always fails, then:

./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
./tools/testing/selftests/vm/userfaultfd hugetlb 10
	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success

Both tests succeed and produce no warnings. After the test runs
number of free/resv hugepages is correct.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
 include/linux/hugetlb.h |   4 ++
 mm/hugetlb.c            | 103 ++++++++++++++++++++++++++++++++++++----
 mm/migrate.c            |  39 +++------------
 3 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef58..427974510965 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -194,6 +194,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);

+void hugetlb_copy_page(struct page *dst, struct page *src);
+
 #else /* !CONFIG_HUGETLB_PAGE */

 static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
@@ -379,6 +381,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,

 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }

+static inline void hugetlb_copy_page(struct page *dst, struct page *src);
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 629aa4c2259c..cb041c97a558 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -81,6 +81,45 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);

+/*
+ * Gigantic pages are so large that we do not guarantee that page++ pointer
+ * arithmetic will work across the entire page.  We need something more
+ * specialized.
+ */
+static void __copy_gigantic_page(struct page *dst, struct page *src,
+				 int nr_pages)
+{
+	int i;
+	struct page *dst_base = dst;
+	struct page *src_base = src;
+
+	for (i = 0; i < nr_pages;) {
+		cond_resched();
+		copy_highpage(dst, src);
+
+		i++;
+		dst = mem_map_next(dst, dst_base, i);
+		src = mem_map_next(src, src_base, i);
+	}
+}
+
+void hugetlb_copy_page(struct page *dst, struct page *src)
+{
+	int i;
+	struct hstate *h = page_hstate(src);
+	int nr_pages = pages_per_huge_page(h);
+
+	if (unlikely(nr_pages > MAX_ORDER_NR_PAGES)) {
+		__copy_gigantic_page(dst, src, nr_pages);
+		return;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		cond_resched();
+		copy_highpage(dst + i, src + i);
+	}
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -4868,19 +4907,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct page **pagep)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
-	struct address_space *mapping;
-	pgoff_t idx;
+	struct hstate *h = hstate_vma(dst_vma);
+	struct address_space *mapping = dst_vma->vm_file->f_mapping;
+	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
-	struct hstate *h = hstate_vma(dst_vma);
 	pte_t _dst_pte;
 	spinlock_t *ptl;
-	int ret;
+	int ret = -ENOMEM;
 	struct page *page;
 	int writable;
-
-	mapping = dst_vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	gfp_t gfp_mask = htlb_alloc_mask(h);
+	int node = huge_node(dst_vma, dst_addr, gfp_mask, &mpol, &nodemask);

 	if (is_continue) {
 		ret = -EFAULT;
@@ -4888,7 +4928,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		if (!page)
 			goto out;
 	} else if (!*pagep) {
-		ret = -ENOMEM;
+		/* If a page already exists, then it's UFFDIO_COPY for
+		 * a non-missing case. Return -EEXIST.
+		 */
+		if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+			ret = -EEXIST;
+			goto out;
+		}
+
 		page = alloc_huge_page(dst_vma, dst_addr, 0);
 		if (IS_ERR(page))
 			goto out;
@@ -4900,12 +4947,48 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
+			/* Free the allocated page which may have
+			 * consumed a reservation.
+			 */
+			restore_reserve_on_error(h, dst_vma, dst_addr, page);
+			if (!HPageRestoreReserve(page)) {
+				if (unlikely(hugetlb_unreserve_pages(
+					    mapping->host, idx, idx + 1, 1)))
+					hugetlb_fix_reserve_counts(
+						mapping->host);
+			}
+			put_page(page);
+
+			/* Allocate a temporary page to hold the copied
+			 * contents.
+			 */
+			page = alloc_migrate_huge_page(h, gfp_mask, node,
+						       nodemask);
+			if (IS_ERR(page)) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			*pagep = page;
-			/* don't free the page */
+			/* Set the outparam pagep and return to the caller to
+			 * copy the contents outside the lock. Don't free the
+			 * page.
+			 */
 			goto out;
 		}
 	} else {
-		page = *pagep;
+		if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+			put_page(*pagep);
+			ret = -EEXIST;
+			goto out;
+		}
+
+		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		if (IS_ERR(page)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		__copy_gigantic_page(page, *pagep, pages_per_huge_page(h));
+		put_page(*pagep);
 		*pagep = NULL;
 	}

diff --git a/mm/migrate.c b/mm/migrate.c
index 6b37d00890ca..d3437f9a608d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -528,28 +528,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return MIGRATEPAGE_SUCCESS;
 }

-/*
- * Gigantic pages are so large that we do not guarantee that page++ pointer
- * arithmetic will work across the entire page.  We need something more
- * specialized.
- */
-static void __copy_gigantic_page(struct page *dst, struct page *src,
-				int nr_pages)
-{
-	int i;
-	struct page *dst_base = dst;
-	struct page *src_base = src;
-
-	for (i = 0; i < nr_pages; ) {
-		cond_resched();
-		copy_highpage(dst, src);
-
-		i++;
-		dst = mem_map_next(dst, dst_base, i);
-		src = mem_map_next(src, src_base, i);
-	}
-}
-
 static void copy_huge_page(struct page *dst, struct page *src)
 {
 	int i;
@@ -557,19 +535,14 @@ static void copy_huge_page(struct page *dst, struct page *src)

 	if (PageHuge(src)) {
 		/* hugetlbfs page */
-		struct hstate *h = page_hstate(src);
-		nr_pages = pages_per_huge_page(h);
-
-		if (unlikely(nr_pages > MAX_ORDER_NR_PAGES)) {
-			__copy_gigantic_page(dst, src, nr_pages);
-			return;
-		}
-	} else {
-		/* thp page */
-		BUG_ON(!PageTransHuge(src));
-		nr_pages = thp_nr_pages(src);
+		hugetlb_copy_page(dst, src);
+		return;
 	}

+	/* thp page */
+	BUG_ON(!PageTransHuge(src));
+	nr_pages = thp_nr_pages(src);
+
 	for (i = 0; i < nr_pages; i++) {
 		cond_resched();
 		copy_highpage(dst + i, src + i);
--
2.31.1.818.g46aad6cb9e-goog
