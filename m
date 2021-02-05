Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2E311183
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhBESIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233157AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwxcdMSyfJ8S06/346B51A7/s/B5gXuJmv9CWCzGamY=;
        b=YBaSpmyKrpmqbE2s8O8WjnJZVsiSrQ4dIBjtnXbHWwILLL5YYdb8n8qyr9r7ACnPak2zqU
        4K2D8H5JYSSla/wBGiZ8+3XrCuqjaIzcaLcUsh0+0Ibry5QFOriPNE/H1Gr4l5iewV6Mp9
        ySWO93Mak7R/rkVdsDIL48rp/aBQreU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-C0OEZtvIPI6HOiGmcGQXPw-1; Fri, 05 Feb 2021 11:53:36 -0500
X-MC-Unique: C0OEZtvIPI6HOiGmcGQXPw-1
Received: by mail-qt1-f200.google.com with SMTP id t5so5701470qti.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwxcdMSyfJ8S06/346B51A7/s/B5gXuJmv9CWCzGamY=;
        b=ZEpTsaXsotG/5L4+HTIQnhQv5L6V3mlsK6JK/cK8Ugz4enFEv0LSr0K5VGnxvk/F3i
         fjc2lYCdABp7RtdsgWlvo7JZ9ZSyDI0N90vcm9aq224bBcv7EHU+mRMUJgqzg02xStRA
         L4CE+ReFs0p0y4S4eS0IRxF33KDGUgzY639PL+S9erc4ZDRlo5kaqWnBq2vtb4T+JzEi
         KOKBWLpGLTK+LaAOIyC77w4biCkkC5vOUYkIUxvauSFK9ymwv+CYBVzHc4XlLILbie+K
         2ZAVG7dg4a3upEwC+VD1Cdxyv71Uyok9nhZCWNw4XagUoXu4lE4U1E2mv6M2dVsY/NmE
         /tRg==
X-Gm-Message-State: AOAM532fGY7qS46zy69QX5mF9pkBSudrBelolR8SMKA26HPGPuW+tuJa
        KF1Wr0X1oSEsJG/TASOqCIaox8hCfs+b5//ZS5zo2YHFCA41xnB1KIjAtMUByVS0qzljgNBX7Zo
        l/Vv0l7W6LJ/VP5bLcRqmZjbQ
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr4945675qtu.323.1612544016322;
        Fri, 05 Feb 2021 08:53:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVjBeNTfdHJRDZsNfbVbE79qOyKTx11cyhQle8vLNZybbu3lrutJz+pRVO0m7DKhLfr4sYKg==
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr4945654qtu.323.1612544016071;
        Fri, 05 Feb 2021 08:53:36 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/5] mm: Introduce page_needs_cow_for_dma() for deciding whether cow
Date:   Fri,  5 Feb 2021 11:54:04 -0500
Message-Id: <20210205165406.4655-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205165406.4655-1-peterx@redhat.com>
References: <20210205165406.4655-1-peterx@redhat.com>
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
index 9d68a2340589..cd28871be559 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -812,9 +812,6 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct page *new_page;
 
-	if (!is_cow_mapping(src_vma->vm_flags))
-		return 1;
-
 	/*
 	 * What we want to do is to check whether this page may
 	 * have been pinned by the parent process.  If so,
@@ -828,9 +825,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
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

