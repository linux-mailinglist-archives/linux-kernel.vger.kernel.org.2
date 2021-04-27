Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5736C956
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhD0QY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236510AbhD0QQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpSgxtKNEYae4dyjeVp8AL4d3+foNARnUP4SjfgN4GM=;
        b=Cp/od+9BNtDfiXHyx6R+QB7K4wleOs5xyDqNDXrhnxqFYXiF+Zp92N8ecRwZ/Z/G+DjGsS
        1+xTcJDSY732JKLgn9wuG+7fNPGssarmcjOkDmV6/j5BgeOt2tw9eWccC9AgWhKwyKfb0U
        WHUGCazOG6jNSJlKBTMO4sW5h8Dv5dc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Nc0nRk6xMGKBUB2C7lC8BQ-1; Tue, 27 Apr 2021 12:13:56 -0400
X-MC-Unique: Nc0nRk6xMGKBUB2C7lC8BQ-1
Received: by mail-qt1-f198.google.com with SMTP id p8-20020a05622a0488b02901bab8dfa0c5so3721893qtx.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpSgxtKNEYae4dyjeVp8AL4d3+foNARnUP4SjfgN4GM=;
        b=l6CiSV6nTRFEtpNX3IjfG4yG0ta7iv1EG8mG21sa3/l/NBbMpFo0k5jp5a1f12xctL
         PSIoEmKZv9pfAH/ulmKPo16O52qWMWtr5yFFWhub6O1D+LNglcbJxw5avldIRRVp70Ul
         BhotognLMHYp4TKswn+/LXoSS9PHEDY7lgLu1GyofaNKQHVHOiSL3gbceqlaXgtGbAp+
         fDW5HcOpZKEKL3POzmp9TbBJrZoyxbcVOw2254s9JEWglNF8FMyXJE5jas1DIoXh5eD0
         vReiwQwRJGMmZSLpe6DBCOpB+159LLqoAqD+6MMPJGIryjWQ/G8CWK4YXFyYfR0/0o8p
         6X2Q==
X-Gm-Message-State: AOAM530Wl6op+IHysuIPSOHGvH2X8E+hSxz8CFabLe2K2EoleCJ0KV8G
        o9nSDvWYZsSF0ee2N+nv94RJW5VrWTjjidDQP8BHLvpS/9+SLB2Ajm0ZQPiV6kvtR1hONlcxOEN
        +wazm/TMueK+p1hWvC3BgNKiY
X-Received: by 2002:ac8:5a07:: with SMTP id n7mr1426871qta.86.1619540035433;
        Tue, 27 Apr 2021 09:13:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNFw9TlAPK5bR57wS+0NWmiHML0S2PBkzuVSnA+dUH2gMYuiWAD3BFtJ4U0QVvjjqXwtJ2nA==
X-Received: by 2002:ac8:5a07:: with SMTP id n7mr1426842qta.86.1619540035151;
        Tue, 27 Apr 2021 09:13:55 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 20/24] hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
Date:   Tue, 27 Apr 2021 12:13:13 -0400
Message-Id: <20210427161317.50682-21-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index b34486a88b5f3..a41e0631af512 100644
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
index 071a8429ea190..d9ff7db14175d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4529,7 +4529,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4653,7 +4654,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -4663,6 +4664,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -4778,8 +4785,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 
@@ -4913,7 +4925,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	struct hstate *h = hstate_vma(dst_vma);
-	pte_t _dst_pte;
+	pte_t _dst_pte, cur_pte;
 	spinlock_t *ptl;
 	int ret;
 	struct page *page;
@@ -4991,8 +5003,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index ceb77ea24497e..2cd6ad5c3d8f8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -274,6 +274,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
+		pte_t pteval;
+
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
@@ -296,8 +298,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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
2.26.2

