Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADCD3CADC0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbhGOUUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbhGOUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsJLJz+YHuEwxqnZUthHegn8xy7O5gj126CaP/wYQGk=;
        b=cUiiyBuomGckfKZjT7yClqHdE0IYvMA6PxGs533OqhZnGl1q+PizsEtpsRtj1+Mote03gF
        SrfPbuXQ3gN0rsQriBwQ34bnG55GVTLMTnn5Q2YySw0tnFfh2z6V0a4toKxAgC76+M+B5j
        2o6b0G7lYfSdcKNW3hjLAq2oboZ1y3Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-NfjPu4u1OcuJmDaKJ9P1tw-1; Thu, 15 Jul 2021 16:16:52 -0400
X-MC-Unique: NfjPu4u1OcuJmDaKJ9P1tw-1
Received: by mail-qv1-f72.google.com with SMTP id r13-20020a0cf60d0000b02902f3a4c41d77so5007403qvm.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsJLJz+YHuEwxqnZUthHegn8xy7O5gj126CaP/wYQGk=;
        b=QkQhgrJ4WM4XTfa8FwfNzbSFXMvLGQxvMFgPGxQVHFAIL9bmRl3q1J2vltsQKPQ4AP
         akemdyBImrdhfXatWdUwhpSjwT4DhgnyDZVddTQBmLisJjdyr2CCIMp6VifyzjrI7Jrl
         e+OkGmq6A29n4yZ1puPeq27oUsPDElRbiQYjdupTlw3DaBo7AKN3yeUDQwkAEKmpKWSh
         OR3KTE069+OjTjP2jg1fkubzcb7iv4JVu/J41VzKShEsJu8/hcIsOSf7eKtkqTSrxLbO
         9EhHNrI0lNJkENswpAatRNXjNnU1wdAEsLbvF5rRkzCU2X7tZfaS5nEXFGucTlzfI/fO
         2emQ==
X-Gm-Message-State: AOAM531E/fJ9D0/bNXr15DVyndqn5W14L38WvS0e2GpMSeBVjaAa0Wwy
        ya4xGPy/ixHPWodIMY3QFqCWizjOURRIjExoi8GGjiQQ2ecIkdS231BvdOsx9QUGVVrZLcDaNSN
        9X/nYLQe90ME8rITuuLrmEMlntFBwct+g5fTL4yDz3QvDDaaXeOr/5FH0r1HipYZZssATZ/tDbw
        ==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr5709405qkf.270.1626380211218;
        Thu, 15 Jul 2021 13:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdSjbXdIaii0S2lUOP9E1/zEptfZ7/ywDe7s88X47A9WVFfFGcAJDN/IaFqMlp9TAfIGa+8w==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr5709368qkf.270.1626380210922;
        Thu, 15 Jul 2021 13:16:50 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id w2sm2903986qkm.65.2021.07.15.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:50 -0700 (PDT)
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
Subject: [PATCH v5 23/26] hugetlb/userfaultfd: Only drop uffd-wp special pte if required
Date:   Thu, 15 Jul 2021 16:16:47 -0400
Message-Id: <20210715201647.212083-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index 926eeb9bf4eb..fdbb972b781b 100644
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
index e19ca363803d..809bb63ecf9e 100644
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
@@ -381,7 +382,8 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 875adf3b000c..5e18a20c1999 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4353,7 +4353,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
-				   struct page *ref_page)
+				   struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -4405,6 +4405,19 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
@@ -4456,9 +4469,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 
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
@@ -4474,12 +4488,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
 
@@ -4534,7 +4549,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index af91bee934c7..c4a80f45e48f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1626,8 +1626,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
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

