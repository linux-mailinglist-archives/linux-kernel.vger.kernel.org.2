Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9839371E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhE0UZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236753AbhE0UZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CB/ZZ041zggBCCBv7NLw8xpkW7+qlOpR2v+yvM7l654=;
        b=EaGoBINvM/QqWlJC0q+C70hQY27uk1V8qBVZ1VeWfKGbHmfuC1L8YxmL+GygA7PVF8IQjH
        EZkFMPtOcfeb1Vihpiq41GXPKcWjdRQDpWEv8dZrTSLK1GSwJDOYL7SLlOqsXLZrkmm9NH
        vbc1O9ttqjQQWUfGoQIehubkDj5AdME=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ULT4cgEUPQGVpHYrJtGblg-1; Thu, 27 May 2021 16:23:42 -0400
X-MC-Unique: ULT4cgEUPQGVpHYrJtGblg-1
Received: by mail-qv1-f69.google.com with SMTP id r11-20020a0cb28b0000b02901c87a178503so983025qve.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB/ZZ041zggBCCBv7NLw8xpkW7+qlOpR2v+yvM7l654=;
        b=iN8QGvC2vLUIZTYmZqhI2aqNz06Kced+nhodRv5b0JlmTteb2NgJJ1ybjE6Cf3BYwA
         aZpEhXzcfedABKZ+c/uCImUokj/iYGViGYqKjmI1QF9R2+42P1h/qFzS2tz8FKx+nzMD
         M2wR9vJlkgfc9XjjUWBivUXCVBaPVY1Fjxh7XW3djJnUeBsPCe1xjeMoolmaXgWce8Kq
         C7QX3JFDCKbWqFPlg5jAgFaK49Sbnu6xGKN1gGzwEeS5jEuctoi36jdP8I+JtTzWNjgF
         trrx+VgRyUuxe519nV7/6p5Qn/OPVA7ct2jdlNfu7Dlem3aCyFziPLa5uf1I+cuV1uDi
         3ZHg==
X-Gm-Message-State: AOAM532+A0Y7XlJqcOiLqRPGCLPoN5u+g3BJFslCWhqEArOgpZ5v3HvP
        3kCLGr6mE6VSeMHnS/qRYohTsH7WOxB0rbun4W+NITQmMvJmdqo99LDBIQn35uhzeSUUYVoxaFw
        g6KX0bZaO6HcvgNbJnCr4wnC+GZzl90RH2+czy4a5/gC9Q6hIcWMFzgwJifABZRrQ6Bw+R5kflA
        ==
X-Received: by 2002:ac8:5a8f:: with SMTP id c15mr354835qtc.162.1622147020738;
        Thu, 27 May 2021 13:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPUX4VOylyMwlokkX/25yMH5dG/jiMR6d/tM2BGaCOW3lGyhn9A9qZLMyhTc0YE/SXfOxZLQ==
X-Received: by 2002:ac8:5a8f:: with SMTP id c15mr354789qtc.162.1622147020352;
        Thu, 27 May 2021 13:23:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id j1sm1973305qtn.83.2021.05.27.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:39 -0700 (PDT)
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
Subject: [PATCH v3 24/27] hugetlb/userfaultfd: Only drop uffd-wp special pte if required
Date:   Thu, 27 May 2021 16:23:37 -0400
Message-Id: <20210527202337.32256-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with shmem uffd-wp special ptes, only drop the uffd-wp special swap pte if
unmapping an entire vma or synchronized such that faults can not race with the
unmap operation.  This requires passing zap_flags all the way to the lowest
level hugetlb unmap routine: __unmap_hugepage_range.

In general, unmap calls originated in hugetlbfs code will pass the
ZAP_FLAG_DROP_FILE_UFFD_WP flag as synchronization is in place to prevent
faults.  The exception is hole punch which will first unmap without any
synchronization.  Later when hole punch actually removes the page from the
file, it will check to see if there was a subsequent fault and if so take the
hugetlb fault mutex while unmapping again.  This second unmap will pass in
ZAP_FLAG_DROP_FILE_UFFD_WP.

The core justification of "whether to apply ZAP_FLAG_DROP_FILE_UFFD_WP flag
when unmap a hugetlb range" is (IMHO): we should never reach a state when a
page fault could errornously fault in a page-cache page that was wr-protected
to be writable, even in an extremely short period.  That could happen if
e.g. we pass ZAP_FLAG_DROP_FILE_UFFD_WP in hugetlbfs_punch_hole() when calling
hugetlb_vmdelete_list(), because if a page fault triggers after that call and
before the remove_inode_hugepages() right after it, the page cache can be
mapped writable again in the small window, which can cause data corruption.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    | 15 +++++++++------
 include/linux/hugetlb.h |  8 +++++---
 mm/hugetlb.c            | 27 +++++++++++++++++++++------
 mm/memory.c             |  5 ++++-
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 55efd3dd04f6..b917fb4c670e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -404,7 +404,8 @@ static void remove_huge_page(struct page *page)
 }
 
 static void
-hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
+hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
+		      unsigned long zap_flags)
 {
 	struct vm_area_struct *vma;
 
@@ -437,7 +438,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
 		}
 
 		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
-									NULL);
+				     NULL, zap_flags);
 	}
 }
 
@@ -515,7 +516,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h));
+					(index + 1) * pages_per_huge_page(h),
+					ZAP_FLAG_DROP_FILE_UFFD_WP);
 				i_mmap_unlock_write(mapping);
 			}
 
@@ -581,7 +583,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
-		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
+		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
+				      ZAP_FLAG_DROP_FILE_UFFD_WP);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
@@ -614,8 +617,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		i_mmap_lock_write(mapping);
 		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 			hugetlb_vmdelete_list(&mapping->i_mmap,
-						hole_start >> PAGE_SHIFT,
-						hole_end  >> PAGE_SHIFT);
+					      hole_start >> PAGE_SHIFT,
+					      hole_end >> PAGE_SHIFT, 0);
 		i_mmap_unlock_write(mapping);
 		remove_inode_hugepages(inode, hole_start, hole_end);
 		inode_unlock(inode);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3e4c5c64d867..d3e8b3b38ded 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -138,11 +138,12 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 unsigned long *, unsigned long *, long, unsigned int,
 			 int *);
 void unmap_hugepage_range(struct vm_area_struct *,
-			  unsigned long, unsigned long, struct page *);
+			  unsigned long, unsigned long, struct page *,
+			  unsigned long);
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
-			  struct page *ref_page);
+			  struct page *ref_page, unsigned long zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -377,7 +378,8 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c4dd0c531bb5..78675158911c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4274,7 +4274,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
-			    struct page *ref_page)
+			    struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -4326,6 +4326,19 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 		}
 
+		if (unlikely(is_swap_special_pte(pte))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+			/*
+			 * Only drop the special swap uffd-wp pte if
+			 * e.g. unmapping a vma or punching a hole (with proper
+			 * lock held so that concurrent page fault won't happen).
+			 */
+			if (zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP)
+				huge_pte_clear(mm, address, ptep, sz);
+			spin_unlock(ptl);
+			continue;
+		}
+
 		/*
 		 * Migrating hugepage or HWPoisoned hugepage is already
 		 * unmapped and its refcount is dropped, so just clear pte here.
@@ -4377,9 +4390,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page)
+			  unsigned long end, struct page *ref_page,
+			  unsigned long zap_flags)
 {
-	__unmap_hugepage_range(tlb, vma, start, end, ref_page);
+	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
 
 	/*
 	 * Clear this flag so that x86's huge_pmd_share page_table_shareable
@@ -4395,12 +4409,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page)
+			  unsigned long end, struct page *ref_page,
+			  unsigned long zap_flags)
 {
 	struct mmu_gather tlb;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
-	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
+	__unmap_hugepage_range(&tlb, vma, start, end, ref_page, zap_flags);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -4455,7 +4470,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index 8372b212993a..4427f48e446d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1607,8 +1607,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			 * safe to do nothing in this case.
 			 */
 			if (vma->vm_file) {
+				unsigned long zap_flags = details ?
+				    details->zap_flags : 0;
 				i_mmap_lock_write(vma->vm_file->f_mapping);
-				__unmap_hugepage_range_final(tlb, vma, start, end, NULL);
+				__unmap_hugepage_range_final(tlb, vma, start, end,
+							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
 			}
 		} else
-- 
2.31.1

