Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CB3A561F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 05:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhFMDTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 23:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhFMDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 23:19:16 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 20:17:04 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id n17-20020a4ae1d10000b029024a49ea822bso1782664oot.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NQEk3B/D9DQqdbqI2jqXdPIDfvBL0SmgQfWxdc0tj48=;
        b=J3T0NdWAGgeAJ2pSB1pbIn1dBxJe2lBUZoYhkqV735mwHyxeul41xMoGX/MX0uaCWr
         SuMBu2Gp1ryVQOe/LAdjZmeTJN9iNiQwVGA8h8TpEQwPTwa/Kp24uebk4qRgjDMiApxi
         yS7baEthtnZLGygqQErWmmzlCnMNF31x5Opz95L1Ml7vW54Lk6upzjzC0/EMrEitfxUm
         XlLHgd0P7pgqqQ+IGpQuQOBjneWh6eDoeOJ8d1g2Ena4Fn3xqIOziNXf2kycAaIjcnO7
         G5K/+QNzQTRUUxaMT5w2wvKYgAJbpF667K5LQIB3imResymR1E8wvIEEWmcwFGb/OiWB
         cAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NQEk3B/D9DQqdbqI2jqXdPIDfvBL0SmgQfWxdc0tj48=;
        b=Br+q8MOQKtB15KNxmwiG5RvuZ4Rmo4sE4QVh+NLPxu785Eln8j81IsPvBm6J/EhwiO
         Xnigzo1gwGIyjnYXnZi2rUSUbdE0RHOrra1QLZ08Pj+NzQVZjkVL/YJSR5vvxkz84gIj
         mzR9yS/QTFKw5RHDMbcc/ktl5bgVJ5PjCknFrU8QcyevSy6B3xWZMsCVhXVZav3TPHzS
         9HnOAZOUPgs9puqL0PzAeFFniz2MXj+wO9vAkDJ3XD7qf55uQpBx1iRxRaBuAlQhS8IZ
         Q1fMTJz51eVZ+d2yHDyKLcNr2nJVQu4AWf4mHPuKfRHVW9+VY8BH+IIZpHslcOrx+yXI
         b2lg==
X-Gm-Message-State: AOAM532wTncDoZTI/CCLiwgxbl+3rj+biC49htV0mO+US+PNPBY5AtHC
        vdP3A+eSvGEUzX2NIHNDx5T4Sw==
X-Google-Smtp-Source: ABdhPJwpuOaHt86XVL/vsr2gc5S0e7/tSsfFr5jAwgEk7ve6yi4Xn+CgsuUogZTf5spoyyGSxCB6Og==
X-Received: by 2002:a4a:a802:: with SMTP id o2mr8721061oom.91.1623554221876;
        Sat, 12 Jun 2021 20:17:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p203sm1120452oib.40.2021.06.12.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 20:17:01 -0700 (PDT)
Date:   Sat, 12 Jun 2021 20:16:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm, futex: Fix shared futex pgoff on shmem huge page
In-Reply-To: <YMTdtRZG+7q8OtkK@casper.infradead.org>
Message-ID: <b17d946b-d09-326e-b42a-52884c36df32@google.com>
References: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com> <YMTdtRZG+7q8OtkK@casper.infradead.org>
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
v2: restored TODO comments, per Matthew; make "hugetlb pages" explicit.

 include/linux/hugetlb.h |   16 ----------------
 include/linux/pagemap.h |   13 +++++++------
 kernel/futex.c          |    3 +--
 mm/hugetlb.c            |    5 +----
 4 files changed, 9 insertions(+), 28 deletions(-)

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
+++ linux/include/linux/pagemap.h	2021-06-12 19:29:23.364387191 -0700
@@ -516,7 +516,7 @@ static inline struct page *read_mapping_
 }
 
 /*
- * Get index of the page with in radix-tree
+ * Get index of the page within radix-tree (but not for hugetlb pages).
  * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
  */
 static inline pgoff_t page_to_index(struct page *page)
@@ -536,14 +536,15 @@ static inline pgoff_t page_to_index(stru
 }
 
 /*
- * Get the offset in PAGE_SIZE.
- * (TODO: hugepage should have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
+ * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
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
