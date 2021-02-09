Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0070D3146D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBIDKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhBIDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHImIlBSKN1nSIl0TDY6RA8xaD02NZcbelnnRmoiTro=;
        b=A5W1AO2VKGU+a9LuNoLFcorp0gptdVyUGVH4jwE/uZa+z4rRUkF2AbpvyOW0viIpYzJOLf
        yBxFCQuHtEw0JkWiej0kjwM4n/coA0LSmUICloTPwrXjDE5UB17umaxfySCEW57qA2+PxT
        R7mP3Nn5ZX0bFnmJs11W8PF0lJYrQXw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-E8J-zfUXOT2tAjXWZo_j_g-1; Mon, 08 Feb 2021 22:02:38 -0500
X-MC-Unique: E8J-zfUXOT2tAjXWZo_j_g-1
Received: by mail-qt1-f200.google.com with SMTP id f7so11198016qtd.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHImIlBSKN1nSIl0TDY6RA8xaD02NZcbelnnRmoiTro=;
        b=Zy/WtmAe9ACdmJIi7r5SbeeBszBCgBjC+lgg3X+ohPd4wJLl7auZtdel4YblN1aNYh
         t9pLxvEOYd1CFNBey2Ak4iL/mWvGE/qg75pZD8H9ZBYCeLGrFbT2sTFvJcjQ2TUfSgFw
         M90v5yIxqF07eJx68VNzEj27HjKcRjfd3mZZK01NQo+fUbrHzfbuoGJiUbMfh2Ckl2GL
         30MsQo/OmwdQZc5FihY08lG0m8NRDrQVemQEx4XDGMxJPS2ypAasy3X5KEIlSYGrcOTo
         bJ2B77gagcLqdMXGnEDhE+Zl3he6Bh8QsvzIbA7eqlNmD6neI8ojeUyMMjoAeKlXPydO
         lbsQ==
X-Gm-Message-State: AOAM531kGEEg6/yAk0Nld42QB4ur3xx8x0BjSusyCg7kYsAa7haHnPu5
        /E8r5syNXInep+MpvV3/bRZ2RV8fnnpStQS66h3zr0BQUc0R48SUpg7xExTq1vWeSHaP6QYorw0
        PXpruAGuKl6dEqxYgBJNuHMsh
X-Received: by 2002:aed:33c4:: with SMTP id v62mr16790068qtd.377.1612839758004;
        Mon, 08 Feb 2021 19:02:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxni6VP6PqQbjOPxHYa0azVKnNKN6eiP3K3PbRfnHpW8VhUYbjJ54KUIJwwcOlJNl9Vcexj1Q==
X-Received: by 2002:aed:33c4:: with SMTP id v62mr16790043qtd.377.1612839757771;
        Mon, 08 Feb 2021 19:02:37 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 3/5] mm: Introduce page_needs_cow_for_dma() for deciding whether cow
Date:   Mon,  8 Feb 2021 22:02:27 -0500
Message-Id: <20210209030229.84991-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209030229.84991-1-peterx@redhat.com>
References: <20210209030229.84991-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got quite a few places (pte, pmd, pud) that explicitly checked against
whether we should break the cow right now during fork().  It's easier to
provide a helper, especially before we work the same thing on hugetlbfs.

Since we'll reference is_cow_mapping() in mm.h, move it there too.  Actually it
suites mm.h more since internal.h is mm/ only, but mm.h is exported to the
whole kernel.  With that we should expect another patch to use is_cow_mapping()
whenever we can across the kernel since we do use it quite a lot but it's
always done with raw code against VM_* flags.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 21 +++++++++++++++++++++
 mm/huge_memory.c   |  8 ++------
 mm/internal.h      |  5 -----
 mm/memory.c        |  8 +-------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 904e2517cd45..2e555d57631f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1314,6 +1314,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
 		GUP_PIN_COUNTING_BIAS;
 }
 
+static inline bool is_cow_mapping(vm_flags_t flags)
+{
+	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+}
+
+/*
+ * This should most likely only be called during fork() to see whether we
+ * should break the cow immediately for a page on the src mm.
+ */
+static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
+					  struct page *page)
+{
+	if (!is_cow_mapping(vma->vm_flags))
+		return false;
+
+	if (!atomic_read(&vma->vm_mm->has_pinned))
+		return false;
+
+	return page_maybe_dma_pinned(page);
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 987cf5e4cf90..57f5c7d3a328 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1097,9 +1097,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * best effort that the pinned pages won't be replaced by another
 	 * random page during the coming copy-on-write.
 	 */
-	if (unlikely(is_cow_mapping(vma->vm_flags) &&
-		     atomic_read(&src_mm->has_pinned) &&
-		     page_maybe_dma_pinned(src_page))) {
+	if (unlikely(page_needs_cow_for_dma(vma, src_page))) {
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
@@ -1211,9 +1209,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/* Please refer to comments in copy_huge_pmd() */
-	if (unlikely(is_cow_mapping(vma->vm_flags) &&
-		     atomic_read(&src_mm->has_pinned) &&
-		     page_maybe_dma_pinned(pud_page(pud)))) {
+	if (unlikely(page_needs_cow_for_dma(vma, pud_page(pud)))) {
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 		__split_huge_pud(vma, src_pud, addr);
diff --git a/mm/internal.h b/mm/internal.h
index 8e9c660f33ca..a24847e48081 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct page *page)
  */
 #define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
 
-static inline bool is_cow_mapping(vm_flags_t flags)
-{
-	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
-}
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
diff --git a/mm/memory.c b/mm/memory.c
index 9d68a2340589..a935262bfd3d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -809,12 +809,8 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
 		  struct page **prealloc, pte_t pte, struct page *page)
 {
-	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct page *new_page;
 
-	if (!is_cow_mapping(src_vma->vm_flags))
-		return 1;
-
 	/*
 	 * What we want to do is to check whether this page may
 	 * have been pinned by the parent process.  If so,
@@ -828,9 +824,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * the page count. That might give false positives for
 	 * for pinning, but it will work correctly.
 	 */
-	if (likely(!atomic_read(&src_mm->has_pinned)))
-		return 1;
-	if (likely(!page_maybe_dma_pinned(page)))
+	if (likely(!page_needs_cow_for_dma(src_vma, page)))
 		return 1;
 
 	new_page = *prealloc;
-- 
2.26.2

