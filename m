Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B66393A82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhE1AwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhE1AwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:52:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:50:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k128-20020a25c6860000b029052fd5ee8a17so2434467ybf.15
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=IxmGmY7n5KWBKt5FosIwPuRpVYTAXeIP+zmHpHVCHdk=;
        b=DohjESoP/dFt/2ZPtV2i7cUhEPE6LzZ381mXb86OWnZImSWL9ctrRVgf3qcYJvZjGf
         h8P+MmBanZuPLs7WQNs8wFZJKe8qBhkFgPFiYinMYp3SA63A4357FHeEyAqlhh3pxVSD
         tDVmbkOLTaPdQRsHHXYb4fcvxbXysIC2JSgEd5KkfUalQ+Pq4sgBjI4gJqJXQiZPUsmF
         6Oh9NyHvjiOMIop3+kJUKjc6iX6qdE+iDnWCcZVuQfIk5ndSOwc9Jf1rtEACh6oKNfxD
         BoDGr2tiDPQmhy0ctLm/QF0Wmow4P5WhotB6PWaRv8h6DNZzwWpc2oP8C8N9N27SXBDx
         gHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=IxmGmY7n5KWBKt5FosIwPuRpVYTAXeIP+zmHpHVCHdk=;
        b=HdvZ6lq41ionaSgcKYLMYLnDtwmA7ET0tL48h0TfuIngA9BSfUkGp3Q7UCgE28HF/C
         ZKXpKg2tgU7QdC2d/5hS69kfJ+S9ezVhfENCu+3HoYsQ2US+f8weU3XqUWS5gQ7nRvvm
         hb2eFB/ZrO9nx0vMd2Mdacoi0gjcCM8K1xXBPIxqIyWi8XcaR7+gCxGMgHtUjOo0Eexf
         Sfuhw+FY4lCgaZXZjJrNPj4ywMzWXJo46yBZGMr0ZjVhFM7zxnEnZmWUiaOhX21jus7O
         UHhJtTqmpAWTbllJ9zNPPb3AXZ+4ANO82Zr03aStlF8qjymbqEnC14sXnMSW32KHbS/O
         /XQg==
X-Gm-Message-State: AOAM531ZLbszg9k8kwqgrID1f3CjJp1jLDP3J5jwNn4fP2S/6Gm4Jbiz
        8I2fCZPKqpMw+O4NsZy6pdqwcUCA6M25Lazf2w==
X-Google-Smtp-Source: ABdhPJxSNpWMjGmtXQc7/7c+BN5g4mcCDdtgX5Qdjko26lrpUplmm0xvqZ2DgvAtTbdJNyCZKm1luVIrrJv7nuraSg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:b35:38bd:7e0f:3b1d])
 (user=almasrymina job=sendgmr) by 2002:a25:80d4:: with SMTP id
 c20mr8667284ybm.345.1622163031545; Thu, 27 May 2021 17:50:31 -0700 (PDT)
Date:   Thu, 27 May 2021 17:50:29 -0700
Message-Id: <20210528005029.88088-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY
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

On UFFDIO_COPY, if we fail to copy the page contents while holding the
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

Both tests succeed and produce no warnings. After the
test runs number of free/resv hugepages is correct.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/migrate.h |  4 ++++
 mm/hugetlb.c            | 48 +++++++++++++++++++++++++++++++++--------
 mm/migrate.c            |  4 ++--
 mm/userfaultfd.c        | 48 +----------------------------------------
 4 files changed, 46 insertions(+), 58 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4bb4e519e3f5..4164c9ddd86e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,6 +51,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+extern void migrate_copy_huge_page(struct page *dst, struct page *src);
 #else

 static inline void putback_movable_pages(struct list_head *l) {}
@@ -77,6 +78,9 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return -ENOSYS;
 }

+static inline void migrate_copy_huge_page(struct page *dst, struct page *src)
+{
+}
 #endif /* CONFIG_MIGRATION */

 #ifdef CONFIG_COMPACTION
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 76e2a6efc165..6072c9f82794 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -30,6 +30,7 @@
 #include <linux/numa.h>
 #include <linux/llist.h>
 #include <linux/cma.h>
+#include <linux/migrate.h>

 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -4905,20 +4906,17 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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

-	mapping = dst_vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
-
 	if (is_continue) {
 		ret = -EFAULT;
 		page = find_lock_page(mapping, idx);
@@ -4947,12 +4945,44 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
+			/* Free the allocated page which may have
+			 * consumed a reservation.
+			 */
+			restore_reserve_on_error(h, dst_vma, dst_addr, page);
+			put_page(page);
+
+			/* Allocate a temporary page to hold the copied
+			 * contents.
+			 */
+			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
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
+		if (vm_shared &&
+		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+			put_page(*pagep);
+			ret = -EEXIST;
+			*pagep = NULL;
+			goto out;
+		}
+
+		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		if (IS_ERR(page)) {
+			ret = -ENOMEM;
+			*pagep = NULL;
+			goto out;
+		}
+		migrate_copy_huge_page(page, *pagep);
+		put_page(*pagep);
 		*pagep = NULL;
 	}

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..3bfe1f7d127d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -550,7 +550,7 @@ static void __copy_gigantic_page(struct page *dst, struct page *src,
 	}
 }

-static void copy_huge_page(struct page *dst, struct page *src)
+void migrate_copy_huge_page(struct page *dst, struct page *src)
 {
 	int i;
 	int nr_pages;
@@ -652,7 +652,7 @@ EXPORT_SYMBOL(migrate_page_states);
 void migrate_page_copy(struct page *newpage, struct page *page)
 {
 	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
+		migrate_copy_huge_page(newpage, page);
 	else
 		copy_highpage(newpage, page);

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2d6a3a36f6ce..e13a0492b7ba 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -346,54 +346,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 out_unlock:
 	mmap_read_unlock(dst_mm);
 out:
-	if (page) {
-		/*
-		 * We encountered an error and are about to free a newly
-		 * allocated huge page.
-		 *
-		 * Reservation handling is very subtle, and is different for
-		 * private and shared mappings.  See the routine
-		 * restore_reserve_on_error for details.  Unfortunately, we
-		 * can not call restore_reserve_on_error now as it would
-		 * require holding mmap_lock.
-		 *
-		 * If a reservation for the page existed in the reservation
-		 * map of a private mapping, the map was modified to indicate
-		 * the reservation was consumed when the page was allocated.
-		 * We clear the HPageRestoreRsvCnt flag now so that the global
-		 * reserve count will not be incremented in free_huge_page.
-		 * The reservation map will still indicate the reservation
-		 * was consumed and possibly prevent later page allocation.
-		 * This is better than leaking a global reservation.  If no
-		 * reservation existed, it is still safe to clear
-		 * HPageRestoreRsvCnt as no adjustments to reservation counts
-		 * were made during allocation.
-		 *
-		 * The reservation map for shared mappings indicates which
-		 * pages have reservations.  When a huge page is allocated
-		 * for an address with a reservation, no change is made to
-		 * the reserve map.  In this case HPageRestoreRsvCnt will be
-		 * set to indicate that the global reservation count should be
-		 * incremented when the page is freed.  This is the desired
-		 * behavior.  However, when a huge page is allocated for an
-		 * address without a reservation a reservation entry is added
-		 * to the reservation map, and HPageRestoreRsvCnt will not be
-		 * set. When the page is freed, the global reserve count will
-		 * NOT be incremented and it will appear as though we have
-		 * leaked reserved page.  In this case, set HPageRestoreRsvCnt
-		 * so that the global reserve count will be incremented to
-		 * match the reservation map entry which was created.
-		 *
-		 * Note that vm_alloc_shared is based on the flags of the vma
-		 * for which the page was originally allocated.  dst_vma could
-		 * be different or NULL on error.
-		 */
-		if (vm_alloc_shared)
-			SetHPageRestoreRsvCnt(page);
-		else
-			ClearHPageRestoreRsvCnt(page);
+	if (page)
 		put_page(page);
-	}
 	BUG_ON(copied < 0);
 	BUG_ON(err > 0);
 	BUG_ON(!copied && !err);
--
2.32.0.rc0.204.g9fa02ecfa5-goog
