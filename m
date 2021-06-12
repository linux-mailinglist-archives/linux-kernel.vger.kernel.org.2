Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84973A4CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFLEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:34:33 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34640 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:34:28 -0400
Received: by mail-qt1-f170.google.com with SMTP id u20so4280915qtx.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=9rUn5z6J1oCf/hH7go9J9pBuFJfFwvGBOLnsQiWyXHM=;
        b=brXn7LLXuCAf1V+/rlD8RQj33kCogvu/48KwLJsYVPKgbkEU6Jl5yuHyQdKWLGwsT5
         64loB1QJetvvFVt6BAkM84sgL0XM2poqfd6vS96/UD0H+MUO3xeT36Vg1X9R3kIN1RJh
         sYKe9lCFgw9cYV+eaRJa9pbyTBXQjyWn2wrP/HS4teG6IcOGIBxGm3cBRLKyUY2IvUDb
         ajhlC/L91JWeGsjYmj0VrQml1DJQRgY7dk61BK+JFhPKjSh12ftYp0ihhsKJxVTrXLgz
         G2mHWwfMgyejnys03ESHJ/vFs+UCfwLJYOsHXdYVpeD1sdioIrij8ddcoVSMqbcH5rbv
         T9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=9rUn5z6J1oCf/hH7go9J9pBuFJfFwvGBOLnsQiWyXHM=;
        b=e92B/N5BBwKU22vMIwCt1YxOD+no8zdSN+hbgM31F5J/So75Go7PGdIg28MDI3wYP2
         V6FSsQE6rGzOQ+9O3AFETTakCcosr8Hnq2Py902gEtinVbHXTe+P7gm1h0QWsS+/va94
         F/HOHuYBmeeNxAUkQRGwgw2HRMnN4AS/BL7XDBB6GnmJBYZPba1NTaZs7sbgjxufIuMy
         sKDct9KE8yDkadobaxZeq8n2Rn1AalvQdyA/PBfkUArd3FO6A6grU8b1YH+cn1UHeW0+
         Ptje9QbsBAsZqXdjo8MW0AVVc+VVTcY3CM1RjVamuvaIHNjqOR2jdrUI2BeKItc9nzRR
         qXlA==
X-Gm-Message-State: AOAM532bGhFrUhY0s47JqVITmAYukjhWRPfAmCcfzmoDvH0qtOaaoTGl
        WZhWHYmiWsRgSiWFyCyHUlgFbw==
X-Google-Smtp-Source: ABdhPJzEcHIJiqN09yuESLHWZGpbiaiD+oHi5hCzMhr2sIJSSwCv9LdUFiRO8T032wOfRpBcdrWjGQ==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr6922294qto.315.1623472288778;
        Fri, 11 Jun 2021 21:31:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j14sm3781764qtq.56.2021.06.11.21.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:31:28 -0700 (PDT)
Date:   Fri, 11 Jun 2021 21:31:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm, futex: Fix shared futex pgoff on shmem huge page
Message-ID: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If more than one futex is placed on a shmem huge page, it can happen that
waking the second wakes the first instead, and leaves the second waiting:
the key's shared.pgoff is wrong.

When 3.11 commit 13d60f4b6ab5 ("futex: Take hugepages into account when
generating futex_key"), the only shared huge pages came from hugetlbfs,
and the code added to deal with its exceptional page->index was put into
hugetlb source.  Then that was missed when 4.8 added shmem huge pages.

page_to_pgoff() is what others use for this nowadays: except that, as
currently written, it gives the right answer on hugetlbfs head, but
nonsense on hugetlbfs tails.  Fix that by calling hugetlbfs-specific
hugetlb_basepage_index() on PageHuge tails as well as on head.

Yes, it's unconventional to declare hugetlb_basepage_index() there in
pagemap.h, rather than in hugetlb.h; but I do not expect anything but
page_to_pgoff() ever to need it.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Reported-by: Neel Natu <neelnatu@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---

 include/linux/hugetlb.h |   16 ----------------
 include/linux/pagemap.h |   13 ++++++-------
 kernel/futex.c          |    3 +--
 mm/hugetlb.c            |    5 +----
 4 files changed, 8 insertions(+), 29 deletions(-)

--- 5.13-rc5/include/linux/hugetlb.h	2021-05-09 17:25:09.278703159 -0700
+++ linux/include/linux/hugetlb.h	2021-06-11 17:30:28.726720252 -0700
@@ -733,17 +733,6 @@ static inline int hstate_index(struct hs
 	return h - hstates;
 }
 
-pgoff_t __basepage_index(struct page *page);
-
-/* Return page->index in PAGE_SIZE units */
-static inline pgoff_t basepage_index(struct page *page)
-{
-	if (!PageCompound(page))
-		return page->index;
-
-	return __basepage_index(page);
-}
-
 extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
@@ -980,11 +969,6 @@ static inline int hstate_index(struct hs
 	return 0;
 }
 
-static inline pgoff_t basepage_index(struct page *page)
-{
-	return page->index;
-}
-
 static inline int dissolve_free_huge_page(struct page *page)
 {
 	return 0;
--- 5.13-rc5/include/linux/pagemap.h	2021-05-16 22:49:30.036176843 -0700
+++ linux/include/linux/pagemap.h	2021-06-11 17:30:28.726720252 -0700
@@ -516,8 +516,7 @@ static inline struct page *read_mapping_
 }
 
 /*
- * Get index of the page with in radix-tree
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get index of the page within radix-tree (but not for hugetlb pages).
  */
 static inline pgoff_t page_to_index(struct page *page)
 {
@@ -536,14 +535,14 @@ static inline pgoff_t page_to_index(stru
 }
 
 /*
- * Get the offset in PAGE_SIZE.
- * (TODO: hugepage should have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
 static inline pgoff_t page_to_pgoff(struct page *page)
 {
-	if (unlikely(PageHeadHuge(page)))
-		return page->index << compound_order(page);
-
+	if (unlikely(PageHuge(page))) {
+		extern pgoff_t hugetlb_basepage_index(struct page *page);
+		return hugetlb_basepage_index(page);
+	}
 	return page_to_index(page);
 }
 
--- 5.13-rc5/kernel/futex.c	2021-05-09 17:25:09.670705811 -0700
+++ linux/kernel/futex.c	2021-06-11 17:30:28.726720252 -0700
@@ -35,7 +35,6 @@
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
-#include <linux/hugetlb.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
@@ -650,7 +649,7 @@ again:
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
 		key->shared.i_seq = get_inode_sequence_number(inode);
-		key->shared.pgoff = basepage_index(tail);
+		key->shared.pgoff = page_to_pgoff(tail);
 		rcu_read_unlock();
 	}
 
--- 5.13-rc5/mm/hugetlb.c	2021-06-06 16:57:26.263006733 -0700
+++ linux/mm/hugetlb.c	2021-06-11 17:30:28.730720276 -0700
@@ -1588,15 +1588,12 @@ struct address_space *hugetlb_page_mappi
 	return NULL;
 }
 
-pgoff_t __basepage_index(struct page *page)
+pgoff_t hugetlb_basepage_index(struct page *page)
 {
 	struct page *page_head = compound_head(page);
 	pgoff_t index = page_index(page_head);
 	unsigned long compound_idx;
 
-	if (!PageHuge(page_head))
-		return page_index(page);
-
 	if (compound_order(page_head) >= MAX_ORDER)
 		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
 	else
