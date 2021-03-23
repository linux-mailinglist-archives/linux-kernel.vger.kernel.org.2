Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4F34543D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCWAvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231673AbhCWAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEgaZPIzrTaIsi5MnPxcYnngkBF3yoI3KwetqriOawQ=;
        b=Gyb1LazSPjxw/ndKEozfHKmStxvYFWG8fUhu3J7CcdKfwVFcQoIpymPkUnT3021tBT/MEK
        pvRSVVZU6VQhljSfXW7joRoy56+Sax+qz56EDJ948JHP7gMehNjkQcIFEbIrpmWP4+IctP
        BFP4uwNvN5BPJOjy6Z1CkTr9vOzeCj4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-C85is02CNkai1_Yx1vY0hg-1; Mon, 22 Mar 2021 20:50:57 -0400
X-MC-Unique: C85is02CNkai1_Yx1vY0hg-1
Received: by mail-qk1-f199.google.com with SMTP id u5so812818qkj.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEgaZPIzrTaIsi5MnPxcYnngkBF3yoI3KwetqriOawQ=;
        b=tj5l8Bol1CznoRHCoEwUHkJech68RCB1pORsumYk0kbB2osui5Z73ZL30jRHijiGaN
         dfkOcL51Bs+ysz4zwz7TRFDVXx2QtvJipfwZQBjXm8V7QiS+EXKOQkLLA+hVbEkTryk3
         QTnpUkJEfxGTG/H2CaYvABT0sqmM4PfXR3GgQkROmYJVkmwiUce/T7hmyfhxYo4LuBib
         VUTtYttXyIcM3kvkhizAvSYqX6SeAyTb8kSMvgpKZ4JN+FQDW8rX4bt5Pvs/szGoZM7s
         O71TFOQAkx1Msdx5xcRbZ+XMjPshpxR1m/8ZJNPL5QBBc06rjhq55o79v/eMRZKDaJ+f
         G1tA==
X-Gm-Message-State: AOAM530V8FFUorQ7k2NPbfHSmXiytASk21RCeo351tiILE44iV+Z1CYV
        QMSgxQHjDUaATCIpFeXGBwrrFEJ3cdB1zryjCdXJCV461eiNTjCkN1lFxAYdH5a81Z5LRAfiLrp
        51x9I0WS6Iv+cUhZkHhsrng/7
X-Received: by 2002:a37:946:: with SMTP id 67mr2838356qkj.194.1616460657217;
        Mon, 22 Mar 2021 17:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoPSRNxbgLdbNd+eWCnJrXrf5UvKBY7it33yfIre1UGnCBiLS4TmBBCxQoaDUEz5lsAjK4ew==
X-Received: by 2002:a37:946:: with SMTP id 67mr2838337qkj.194.1616460656902;
        Mon, 22 Mar 2021 17:50:56 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id y13sm9837618qto.39.2021.03.22.17.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:50:56 -0700 (PDT)
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
Subject: [PATCH 21/23] hugetlb/userfaultfd: Only drop uffd-wp special pte if required
Date:   Mon, 22 Mar 2021 20:50:54 -0400
Message-Id: <20210323005054.35973-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like what we've done with shmem uffd-wp special ptes, we shouldn't drop
uffd-wp special swap pte for hugetlb too, only if we're going to unmap the
whole vma, or we're punching a hole with safe locks held.

For example, remove_inode_hugepages() is safe to drop uffd-wp ptes, because it
has taken hugetlb fault mutex so that no concurrent page fault would trigger.
While the call to hugetlb_vmdelete_list() in hugetlbfs_punch_hole() is not
safe.  That's why the previous call will be with ZAP_FLAG_DROP_FILE_UFFD_WP,
while the latter one won't be able to.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    | 15 +++++++++------
 include/linux/hugetlb.h | 13 ++++++++-----
 mm/hugetlb.c            | 27 +++++++++++++++++++++------
 mm/memory.c             |  5 ++++-
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d81f52b87bd7..5fe19e801a2b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -399,7 +399,8 @@ static void remove_huge_page(struct page *page)
 }
 
 static void
-hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
+hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
+		      unsigned long zap_flags)
 {
 	struct vm_area_struct *vma;
 
@@ -432,7 +433,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
 		}
 
 		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
-									NULL);
+				     NULL, zap_flags);
 	}
 }
 
@@ -513,7 +514,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h));
+					(index + 1) * pages_per_huge_page(h),
+					ZAP_FLAG_DROP_FILE_UFFD_WP);
 				i_mmap_unlock_write(mapping);
 			}
 
@@ -579,7 +581,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
-		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
+		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
+				      ZAP_FLAG_DROP_FILE_UFFD_WP);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
@@ -612,8 +615,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
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
index 92710600596e..4047fa042782 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
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
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				unsigned long start, unsigned long end,
-				struct page *ref_page);
+				struct page *ref_page, unsigned long zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -361,14 +362,16 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
 
 static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d4acf9d9d087..deeae6d40dad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3936,7 +3936,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
-			    struct page *ref_page)
+			    struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -3988,6 +3988,19 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -4039,9 +4052,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
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
@@ -4057,12 +4071,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
 
@@ -4117,7 +4132,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index 766946d3eab0..4bf7f8e83733 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1515,8 +1515,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
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
2.26.2

