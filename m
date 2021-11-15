Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389444FFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhKOIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237360AbhKOIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHxegeFAQpAm7QNoFX5FWZJCYVnUR8APDp1wCGQBN2s=;
        b=JOd2/ozamFEcIEJvd7UUm0JLSR6iLX7gNMLX9nKyCtVQpGuEv36/pzpmY8tck/yet6mrkZ
        hkeKl8aWxRGmIegckeQP3CGxMqih1HHdXHtXQlKM+wglQ+VRuoPSzPKlEYDuQgH4FM4vf/
        DjGRkL/lN+55ZhNCpJn3Nd7VROdwp08=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-M4kXeCTtOc6iUCFic7Puug-1; Mon, 15 Nov 2021 03:02:57 -0500
X-MC-Unique: M4kXeCTtOc6iUCFic7Puug-1
Received: by mail-pf1-f199.google.com with SMTP id c21-20020a62e815000000b004a29ebf0aa7so2630571pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHxegeFAQpAm7QNoFX5FWZJCYVnUR8APDp1wCGQBN2s=;
        b=AYwglgjpkuhFVMxUdhn32CisccG4V3wtR5nEAvG7zWiKe9o0rSZgK91V+zYH73HBMz
         2PZ2RJg8JDlTu1FPiBTn3Rb6bg+HkPsJctjuHZdDBAtLisSopL5xkqDK0Fk4+4gjmZbY
         frDaJ756AjhrpdoEDIAQcnTkqjneH81krfAcymOIUzVV/P0Bdqh+hiK4WtIkhi6xr7cj
         koJl4/8B2elXLOekXt5sWX805DPvumjgzOrRQGZqUqBNC6iXWSGx7cxkfBBB1NhKsjGG
         6HVsKOEYJXLnLV3oH2LTcPLt5DwKotyj+wex+GfCPpMcUR/zOy7KkeKKYeO/U9JTXZmk
         8C8g==
X-Gm-Message-State: AOAM531qAbX1sxAkwXBHLvDEhuHUVKuHMFtuF56Y42oqlrK7Izt+c8f2
        V7V5xwpjOmRQvRMyKO3rnJUdaZ+g3ehKxyWUFFeKVjshYx/1Bbg/b/e0vwwTFVo/e574M34iZT2
        NhgCRirT95QQmrtJGyzeLsqHl
X-Received: by 2002:a17:902:be06:b0:142:5a21:9e8a with SMTP id r6-20020a170902be0600b001425a219e8amr33100048pls.17.1636963376148;
        Mon, 15 Nov 2021 00:02:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi3mzgc10Ws3LtJnt+vKzwU+NxNytHynLNU3P3cefT6vAfJ+/+/0CGsrQ9Zf5D1jVuVMeZpQ==
X-Received: by 2002:a17:902:be06:b0:142:5a21:9e8a with SMTP id r6-20020a170902be0600b001425a219e8amr33100014pls.17.1636963375845;
        Mon, 15 Nov 2021 00:02:55 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id d2sm15074317pfj.42.2021.11.15.00.02.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:02:55 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 17/23] mm/hugetlb: Only drop uffd-wp special pte if required
Date:   Mon, 15 Nov 2021 16:02:43 +0800
Message-Id: <20211115080243.75040-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
ZAP_FLAG_DROP_MARKER flag as synchronization is in place to prevent faults.
The exception is hole punch which will first unmap without any synchronization.
Later when hole punch actually removes the page from the file, it will check to
see if there was a subsequent fault and if so take the hugetlb fault mutex
while unmapping again.  This second unmap will pass in ZAP_FLAG_DROP_MARKER.

The justification of "whether to apply ZAP_FLAG_DROP_MARKER flag when unmap a
hugetlb range" is (IMHO): we should never reach a state when a page fault could
errornously fault in a page-cache page that was wr-protected to be writable,
even in an extremely short period.  That could happen if e.g. we pass
ZAP_FLAG_DROP_MARKER when hugetlbfs_punch_hole() calls hugetlb_vmdelete_list(),
because if a page faults after that call and before remove_inode_hugepages() is
executed, the page cache can be mapped writable again in the small racy window,
that can cause unexpected data overwritten.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    | 15 +++++++++------
 include/linux/hugetlb.h |  8 +++++---
 mm/hugetlb.c            | 33 +++++++++++++++++++++++++--------
 mm/memory.c             |  5 ++++-
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 49d2e686be74..92c8d1a47404 100644
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
+					ZAP_FLAG_DROP_MARKER);
 				i_mmap_unlock_write(mapping);
 			}
 
@@ -581,7 +583,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
-		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
+		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
+				      ZAP_FLAG_DROP_MARKER);
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
index a46011510e49..4c3ea7ee8ce8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -143,11 +143,12 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
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
@@ -400,7 +401,8 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bba2ede5f6dc..16fb9cd8d9c5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4926,7 +4926,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
-				   struct page *ref_page)
+				   struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -4983,7 +4983,18 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
-			huge_pte_clear(mm, address, ptep, sz);
+			/*
+			 * If the pte was wr-protected by uffd-wp in any of the
+			 * swap forms, meanwhile the caller does not want to
+			 * drop the uffd-wp bit in this zap, then replace the
+			 * pte with a marker.
+			 */
+			if (pte_swp_uffd_wp_any(pte) &&
+			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP));
+			else
+				huge_pte_clear(mm, address, ptep, sz);
 			spin_unlock(ptl);
 			continue;
 		}
@@ -5011,7 +5022,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
-
+		/* Leave a uffd-wp pte marker if needed */
+		if (huge_pte_uffd_wp(pte) &&
+		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
+			set_huge_pte_at(mm, address, ptep,
+					make_pte_marker(PTE_MARKER_UFFD_WP));
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, true);
 
@@ -5029,9 +5044,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 
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
@@ -5047,12 +5063,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
 
@@ -5107,7 +5124,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index cc625c616645..69a73d47513b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1631,8 +1631,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
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
2.32.0

