Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C933CADBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbhGOUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240548AbhGOUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihOJnpIA7tJilVCSArZhmkbtFgFh3Ul5HrZZdbeFb6s=;
        b=fzXArgxNZUvgalQyMeccSHJPDmElnZoLHs4+c8F94VgdcF5tRFO28jt6SnIJbu0FyL4aAQ
        hp4w/BJAP6InNaeyCVk69NZLvIjoGKiI0Tnqr4Cf64lXykded5cyeziusrzAfWtjggTzP2
        TEDbEYOUhMctqI7xC9+l37YO2Ln63HM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-gnHfhW3EPQyOA0kEi0kpww-1; Thu, 15 Jul 2021 16:16:44 -0400
X-MC-Unique: gnHfhW3EPQyOA0kEi0kpww-1
Received: by mail-qt1-f197.google.com with SMTP id h11-20020ac8138b0000b029025f8084df09so1831557qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihOJnpIA7tJilVCSArZhmkbtFgFh3Ul5HrZZdbeFb6s=;
        b=tvthUulPVU7y/zrC6z5pDflDSafEJZeTEy+GV7jXq7XerTgHm3PR4XdhntL7fQvbni
         W/WV4uYAlxxWpyUo1w8QE40vj+NlhXIPSbod4ypYDCUvpmDXkbyceqbZxC+zEa+7ALxZ
         9Vf5wH0gRH3aPK+yUx49XkqJpzPKtQzaJ4KCo4mHY/AcWpm6lGoouA6Cshc0AwfhNbks
         IQaKkcyuOkMPFF6xXDcVBw4gAe0wvmww1YOmTVWv6cciDnFT6rmQQ00FUPsN9uSIazX1
         ruGDtl/cZidZUNNtRt8AGB/km1jo6O9LviNXcM7W7u0p/bfnl8A0gSSzXck7j3L1pw77
         AXqQ==
X-Gm-Message-State: AOAM533yvnLTH75RpmwYTNyYwrd3E89gZd3jU223rvaFuOso4pZVPC6X
        bV/KV3/5mGZk+Qnhx24lVmir9+fMunJH9DiWeiWzRpGtKltomZqL0TmWVnbcDe0YsMw9BjCLd74
        +bL7IMiFekkR96NQtiMjwu8oUn54qxDgKYK2jZ4W1kQH24LbF37JgM3kbAZZF+QXvu7nLzDMiXQ
        ==
X-Received: by 2002:ad4:576b:: with SMTP id r11mr6314666qvx.28.1626380203068;
        Thu, 15 Jul 2021 13:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOSXB604dHWQlaMEauz7FiQQE99isXyx9dxDWJmEgpnRjhHs2zEP5bueP1OBxMOf2rDGqKLg==
X-Received: by 2002:ad4:576b:: with SMTP id r11mr6314621qvx.28.1626380202766;
        Thu, 15 Jul 2021 13:16:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 5sm3090802qkr.100.2021.07.15.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 21/26] hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
Date:   Thu, 15 Jul 2021 16:16:39 -0400
Message-Id: <20210715201639.211982-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index e1c1cbc7bcc8..644df737fbb2 100644
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
index 517ee30f272c..5941b5cd7ecc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4786,7 +4786,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4910,7 +4911,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -4920,6 +4921,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -5035,8 +5042,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 
@@ -5170,7 +5182,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
-	pte_t _dst_pte;
+	pte_t _dst_pte, cur_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
 	struct page *page;
@@ -5287,8 +5299,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 7ba721aca1c5..a8038903effd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -363,6 +363,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
+		pte_t pteval;
+
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
@@ -385,8 +387,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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

