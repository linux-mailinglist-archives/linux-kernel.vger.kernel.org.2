Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966C30FCF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhBDTcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236883AbhBDOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Re19mNdJTnr2eyYv/JALCHR5raIIkk7skM0STXXGd4k=;
        b=CnqFfZlQmGiPFHVHWe8VlwkP/nSAVvelPgrI9H9wk7HaTxvAD8t0WdiMyaQs7Eh8e0iEbM
        6YfFyEManIp/Kz0+0JPvrWjwzPVdAJU6PvAPiHk3jtnE0TNBQH1IFsahq7P2n1RuJhpSsL
        4l8xRXnc01cEKwNaRSpRM7ZGoC4Zm0s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-Q9qcUUGjNvyeDhT2nsj_1g-1; Thu, 04 Feb 2021 09:50:41 -0500
X-MC-Unique: Q9qcUUGjNvyeDhT2nsj_1g-1
Received: by mail-qk1-f200.google.com with SMTP id y79so2802762qka.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Re19mNdJTnr2eyYv/JALCHR5raIIkk7skM0STXXGd4k=;
        b=Wk8G1UsQ24ob6NHfHY1g6L93jDMpHOpNFxnhagSJfc0KR3u0kOSak0lOzk9tbf5iU8
         iu4jls3fcbWyJFiMnm0hA91CIVVqDJ/tiB0SWMPSvK/Ril/mPwAdWofKdefVHacnhA+R
         PggUoPjNCIfvQYmGISIUjyDUzFxx5qTJs9TQKXhmv7HmNaO2GNhHZHy/sOHFIH3XMOYU
         VREL9HFw9FXPZQ6YguEFjWq4iR+KlfO++BpzokNmTN5w+qnlqWAsOWvm5DTwkmp1dlNV
         ddtrTZXSJUTVmUnwTtFEdE6v0GHbu7V8GedAuT6OQFqZL9rOqBiM/QWD5EHSxj5vvw1u
         MYaQ==
X-Gm-Message-State: AOAM5311dKpKWv6OmLqAm0x2ehR5oihBeuy98o5/mx/GsQge0EZ0bah6
        UMgyzT0QdbULru+nJVw0Yd1ysvjhmTW9KfWI8CukkxjeTq5Qo0xtnu3hn/49Nkq1QCsyjs8LyAr
        3WXPdUgo1aRcJUXe44YmUDueD
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr7907020qkl.495.1612450241175;
        Thu, 04 Feb 2021 06:50:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxamB5FIYlcmCuyZ5FNYhQLAdqB1vVcgA8Ln8HyoBPTizJOqj6aW9ViJwY3wZQogZA8YxY8ag==
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr7907001qkl.495.1612450240944;
        Thu, 04 Feb 2021 06:50:40 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e14sm4697589qte.18.2021.02.04.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:50:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/4] mm: Introduce page_needs_cow_for_dma() for deciding whether cow
Date:   Thu,  4 Feb 2021 09:50:32 -0500
Message-Id: <20210204145033.136755-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204145033.136755-1-peterx@redhat.com>
References: <20210204145033.136755-1-peterx@redhat.com>
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
 mm/memory.c        |  7 +------
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..6ea20721d349 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1291,6 +1291,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
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
index 9237976abe72..dbff6c7eda67 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1095,9 +1095,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
@@ -1209,9 +1207,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
index 25d2b2439f19..24eec93d0dac 100644
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
index feff48e1465a..b2849e1d4aab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -800,9 +800,6 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct page *new_page;
 
-	if (!is_cow_mapping(src_vma->vm_flags))
-		return 1;
-
 	/*
 	 * What we want to do is to check whether this page may
 	 * have been pinned by the parent process.  If so,
@@ -816,9 +813,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
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

