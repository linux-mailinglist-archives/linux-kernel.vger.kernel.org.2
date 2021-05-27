Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBE393719
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhE0UZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236328AbhE0UZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBNk7u3ivtT+37hOCTF6A87HkSdxXSKsCgL3KlLLZ5E=;
        b=XYRzO5Qr1Jcz6yLUabsCqDWHbomSFCW+bIhLtmKOwAf8upB//GurYSuVDduy6F551cMpLq
        YgqPEi3iEEXo1bEArGc5tV+vQWZXWK6ou198BIVlXIzyOfhcYBNSZU2n3FuOiM+7mwnlCd
        YVnr0h25CeKZbW62Y2zT7vTFqzWOwtA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-S84uhHkyO-SQkHZCdywMnw-1; Thu, 27 May 2021 16:23:33 -0400
X-MC-Unique: S84uhHkyO-SQkHZCdywMnw-1
Received: by mail-qv1-f70.google.com with SMTP id 6-20020a05621420a6b0290214b9d4b6c3so1015710qvd.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBNk7u3ivtT+37hOCTF6A87HkSdxXSKsCgL3KlLLZ5E=;
        b=WaCUI3gXQJuisAks5HDSkxX/9Upoc7PpaaF6htPUEd6jbnhLmb9FhARtpQHjhBd6bD
         dSQHBMN0KGEBNaoWSr4btJXcol4lERFbL5C7kKP3fzfS+8vSwUWuDf0nwKQ4P3vlmVYR
         SxoxMdeUS4YngrXM1yHTpnV+EVAvMLe6RIRmCLg4aDv7pBEq3jb97AEWqp+jLdaFXj/m
         Bu7t2D4mNzbTiW2v9EACZ4o4t/m6zJh9zIEAJNnehODdziq/guupUtWDY3+8Oa+jgSgo
         9lSgMCrF83tjruF7Bvjfse9lKKFqOlJIviBLwI10D59jydCbBPrh8U6Tj4S0SvpmO85u
         FP5A==
X-Gm-Message-State: AOAM532KH35bkrkp/tPqqC5UJrJubPAYOCz+fOAy3kIcAneJvDf6L/9E
        s4VrKIDiHV0nQYRy0tMkpxoeMa97iPg2WdJCXyqSD6cH6KC9iHNgY9eCZwLbve3TVPVPiQxY4Ap
        Zu7JOeEfxHplwug5hN5tdzY4OdmQ/TVxqys7uwJNSPg2iLgqRMZTmuHM/cFiQZGwvIcyf28/Uwg
        ==
X-Received: by 2002:ac8:4d19:: with SMTP id w25mr323921qtv.175.1622147012537;
        Thu, 27 May 2021 13:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzFops8/UrKEf5HfwY3iEbhr5r+2t8bpk0m5+pQMv9Qf3pzrX5D7bqd/iDokt9cv0Uh9qJDA==
X-Received: by 2002:ac8:4d19:: with SMTP id w25mr323885qtv.175.1622147012142;
        Thu, 27 May 2021 13:23:32 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id t17sm1981378qto.92.2021.05.27.13.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 22/27] hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
Date:   Thu, 27 May 2021 16:23:28 -0400
Message-Id: <20210527202328.32154-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach the hugetlb page fault code to understand uffd-wp special pte.  For
example, when seeing such a pte we need to convert any write fault into a read
one (which is fake - we'll retry the write later if so).  Meanwhile, for
handle_userfault() we'll need to make sure we must wait for the special swap
pte too just like a none pte.

Note that we also need to teach UFFDIO_COPY about this special pte across the
code path so that we can safely install a new page at this special pte as long
as we know it's a stall entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c |  5 ++++-
 mm/hugetlb.c     | 26 ++++++++++++++++++++------
 mm/userfaultfd.c |  5 ++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 15031d6f1f17..6ef7b56760bf 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -245,8 +245,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
+	 *
+	 * Regarding uffd-wp special case, please refer to comments in
+	 * userfaultfd_must_wait().
 	 */
-	if (huge_pte_none(pte))
+	if (huge_pte_none(pte) || pte_swp_uffd_wp_special(pte))
 		ret = true;
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c64dfd0a9883..a17d894312c0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4707,7 +4707,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4831,7 +4832,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -4841,6 +4842,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
+	/*
+	 * If this pte was previously wr-protected, keep it wr-protected even
+	 * if populated.
+	 */
+	if (unlikely(pte_swp_uffd_wp_special(old_pte)))
+		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -4956,8 +4963,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
-	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+	/*
+	 * uffd-wp-special should be handled merely the same as pte none
+	 * because it's basically a none pte with a special marker
+	 */
+	if (huge_pte_none(entry) || pte_swp_uffd_wp_special(entry)) {
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+				      entry, flags);
 		goto out_mutex;
 	}
 
@@ -5091,7 +5103,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
-	pte_t _dst_pte;
+	pte_t _dst_pte, cur_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
 	struct page *page;
@@ -5213,8 +5225,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (idx >= size)
 		goto out_release_unlock;
 
+	cur_pte = huge_ptep_get(dst_pte);
 	ret = -EEXIST;
-	if (!huge_pte_none(huge_ptep_get(dst_pte)))
+	/* Please refer to shmem_mfill_atomic_pte() for uffd-wp special case */
+	if (!huge_pte_none(cur_pte) && !pte_swp_uffd_wp_special(cur_pte))
 		goto out_release_unlock;
 
 	if (vm_shared) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 82c235f555b8..af79f3d3a001 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -364,6 +364,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
+		pte_t pteval;
+
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
@@ -386,8 +388,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
+		pteval = huge_ptep_get(dst_pte);
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none(pteval) && !pte_swp_uffd_wp_special(pteval)) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-- 
2.31.1

