Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE434543B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhCWAva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231560AbhCWAuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3Lr+m1986ntzk3VRxe9tylxZnwbRgl8IMuaiRrVnNc=;
        b=E0g5L6raKYj+oAZh6YPDsVvmJqAm/EtBHDR4/Ko3C9p0y22nrSfFkd3kfkcxl3KiulrvXG
        aP7aW5Ra3+EWPKiOmWph01gXZ4+RnxkPGRdlFKzm74QuMidVWVka/8JiYYg9Vb/kc2YfDw
        Th/NzgkL4FdxNvpE6Ng9KqxyBhy3u1Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-ilZIYPJDMyaW0Q7QoLfszQ-1; Mon, 22 Mar 2021 20:50:53 -0400
X-MC-Unique: ilZIYPJDMyaW0Q7QoLfszQ-1
Received: by mail-qv1-f72.google.com with SMTP id k4so564081qvf.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3Lr+m1986ntzk3VRxe9tylxZnwbRgl8IMuaiRrVnNc=;
        b=sY7cOPJ+R4KF9WCI8QVmEZWVDPb085k3KejspeGijmErUZP154id8Qoq9lpPNOcJMA
         dCm3GJZ2l1Z6k2ipy10aDDrLKFTTJsca0jBmZRtvsSXfRCJV4jNe+LOe5h2QPzu9ZuLv
         X6ORU4RByBpA61ze6vAjGefKNHqgNwGSjNfRm9cf9QpVy/z+IQH0NB5Rjzb/9XhgdGfG
         NbspY7Ppruqm24+21hMVVtBzL5NnDq+sBxAkJD9yI+Qmht/DIvnCNUUQixUqwIvy8n2C
         e3evutB5V+g3ujXu8/mcjBKD8YGBOYWafPdzftfqdm/nhJUsvkuvLmyepBzavhmiueOU
         21eA==
X-Gm-Message-State: AOAM530PIuHXrVUlrRujNulxkrRZoa2sh12Ip192Eil4UdZhweRnZcN2
        eWLw6BLZK+iLZPW7h0M/hfpOhNfV5IfmYVTX6/SS6zI0Yq7FxsVrg+ppmKfl61E+PgJU52FDg8c
        c8ldVokw/lP5AZZ1tqrZ+1lJN
X-Received: by 2002:a05:620a:134a:: with SMTP id c10mr2863456qkl.481.1616460652119;
        Mon, 22 Mar 2021 17:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAMuoGRIZxa7jOL9xQ+AW4kyHPVmNjfDrANEOxAGw3VtXU98u3x8ooHTpIEev85y+Gs3ynOw==
X-Received: by 2002:a05:620a:134a:: with SMTP id c10mr2863435qkl.481.1616460651856;
        Mon, 22 Mar 2021 17:50:51 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id y6sm2228726qkd.106.2021.03.22.17.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:50:51 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 19/23] hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
Date:   Mon, 22 Mar 2021 20:50:49 -0400
Message-Id: <20210323005049.35862-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
 mm/hugetlb.c     | 34 +++++++++++++++++++++++++++-------
 mm/userfaultfd.c |  5 ++++-
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 72956f9cc892..f6fa34f58c37 100644
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
index 64e424b03774..448ef745d5ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4369,7 +4369,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4493,7 +4494,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -4503,6 +4504,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
+	if (unlikely(flags & FAULT_FLAG_UFFD_WP)) {
+		WARN_ON_ONCE(flags & FAULT_FLAG_WRITE);
+		/* We should have the write bit cleared already, but be safe */
+		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
+	}
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -4584,9 +4590,16 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+		} else if (unlikely(is_swap_special_pte(entry))) {
+			/* Must be a uffd-wp special swap pte */
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(entry));
+			flags |= FAULT_FLAG_UFFD_WP;
+			/* Emulate a read fault */
+			flags &= ~FAULT_FLAG_WRITE;
+		}
 	}
 
 	/*
@@ -4618,8 +4631,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
-	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+	/*
+	 * FAULT_FLAG_UFFD_WP should be handled merely the same as pte none
+	 * because it's basically a none pte with a special marker
+	 */
+	if (huge_pte_none(entry) || pte_swp_uffd_wp_special(entry)) {
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+				      entry, flags);
 		goto out_mutex;
 	}
 
@@ -4753,7 +4771,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	struct hstate *h = hstate_vma(dst_vma);
-	pte_t _dst_pte;
+	pte_t _dst_pte, cur_pte;
 	spinlock_t *ptl;
 	int ret;
 	struct page *page;
@@ -4831,8 +4849,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 01170197a3d7..a2b0dcc80a19 100644
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

