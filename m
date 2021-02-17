Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F731E316
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhBQXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232793AbhBQXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STpfyN8Z1UaurR27BXEZzooPdTPi/top9+Ws5AZcNHA=;
        b=ISMbI23n/jCL4E5v28SR9z3WjWQp0Ki2jCjW9DxB80xuXQVfjcOFbJsee7MNvEBPfMsIol
        unUQ0u/zVr7bGNRMJ5L1aPrBaWP1D+KGD0pL73JH6u7fKO4HvltxTGWrw1e2dU8aOXI0A+
        6oxteXO6PgIQHyAwHAcrA0NPrFo0y7M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-rPYhA2FQOKWa6Xe4s_BKjA-1; Wed, 17 Feb 2021 18:35:55 -0500
X-MC-Unique: rPYhA2FQOKWa6Xe4s_BKjA-1
Received: by mail-qv1-f71.google.com with SMTP id v1so84850qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STpfyN8Z1UaurR27BXEZzooPdTPi/top9+Ws5AZcNHA=;
        b=loErMMZkpBuQj51OleJc0VNbsBYTRi7phijXKaS/hlNpwVr+gZky+GiK4nKYQrDk7W
         wAVqvkKteRmZKze/3EVG6a7NDBIguxWksvw74kGC+b/jATTEvtfuK/fYIgX1N5lNT3qx
         sTwWrU00Gp5k9Q2Um2SEnGosPxtbzxFsVmmQ5mANedqnK2bFaUFsEgzwSkV7fI0Z9mJv
         zPyFl5bOIYjLaB1CEZe0kIPEhoPp57xVSr68qHYXtGvQI0mpaoHvlq3fbPH2uxgWF6oQ
         jqgI58AWeHw6DohYpfQkGwfXg8AukuXR87xurSnDWQCgr0zAq8C+Bwju6BLogzoTEP8c
         Ms+A==
X-Gm-Message-State: AOAM531kz35IA7BVNNJ+emGF7X06bsQ97oOIuZ8hOuvzCyWbi7d2iigg
        dFvzD26XFF2Z1p6VQv6cjo1MLJakc848vB7aykRZ8K6DsgbQOALvwWugDqm4HOl06qfR+hojuHf
        7CgTxqqhfdd8jEQ13tZzLKlvq
X-Received: by 2002:a05:622a:552:: with SMTP id m18mr1773663qtx.207.1613604954994;
        Wed, 17 Feb 2021 15:35:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTtocSTEfx7O+Eln2AHspJzthhrkUPbsyEtDyDs4UT9lHpY1HhZ6bjOJIXvvJ8W0XO0w+dOw==
X-Received: by 2002:a05:622a:552:: with SMTP id m18mr1773637qtx.207.1613604954782;
        Wed, 17 Feb 2021 15:35:54 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 3/5] mm: Introduce page_needs_cow_for_dma() for deciding whether cow
Date:   Wed, 17 Feb 2021 18:35:45 -0500
Message-Id: <20210217233547.93892-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
References: <20210217233547.93892-1-peterx@redhat.com>
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

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 21 +++++++++++++++++++++
 mm/huge_memory.c   |  8 ++------
 mm/internal.h      |  5 -----
 mm/memory.c        |  8 +-------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..64a71bf20536 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1300,6 +1300,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
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
index 395c75111d33..da1d63a41aec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1100,9 +1100,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
@@ -1214,9 +1212,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
index 9902648f2206..1432feec62df 100644
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
index eac765e1c6b9..e50e488b8ea3 100644
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

