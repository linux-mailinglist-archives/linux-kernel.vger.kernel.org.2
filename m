Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1022336C959
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhD0QZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237600AbhD0QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wphNT2xD9jf++zN0kBcInFhZz8ZsCYCIVGYPc7akVQI=;
        b=Yt9sScRkqMvnA5/8MT8kpjNdW5L5Vtu8RN/PF0pgT7WtWgHoNLzyn9qaImGMgei42Ap3Kj
        LEB8kEX4Zs1Vo006YYRndDVqm78lM3vGrkAInWSA6OEmdXYNeODdT2K0wmEOiGAlgk5vcH
        XzIA3oCZ+0Ozrs4OSgFZJQVz8SHJ9bk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-iGsjJLkZN6CbT5V2CZsx-A-1; Tue, 27 Apr 2021 12:13:59 -0400
X-MC-Unique: iGsjJLkZN6CbT5V2CZsx-A-1
Received: by mail-qt1-f197.google.com with SMTP id g21-20020ac858150000b02901ba6163708bso13806913qtg.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wphNT2xD9jf++zN0kBcInFhZz8ZsCYCIVGYPc7akVQI=;
        b=j5QKh2g1552BtMf6Vfv7vutwmOAE5Qyu3ZQJg9X55SxttNXbNLXQAJ9YmiPVUxMqLk
         yf/ViaTn6WnXZxbhePiyUOeETXg9ttE/xf63cCP/8cNJjUKAjoXvtcsyik5eaOj5UPfz
         qW/pJocnazfHTA+NwnSGlAvmjBu3kKGE+23+RWAO9CzYKD5202/XGUDcxi8mleazKn9o
         D1hBVVPEYmwtVOvW83tzmqx1t9HJApTYdZoAlIJ1UT5d6YkeVV85NT42CQJ0f+1sk0Te
         8x0mylKHI62nGjAeDeoBnO8OFNYicnHPp3u2XjYd2mQ6clRcd2f2S2lLtFxcgmgBacMs
         5eow==
X-Gm-Message-State: AOAM53285QAnxAdWdca7fxDNYlVEosZH1FIRA7xI1jGJ5R1yhWcsvgUz
        DOTN2p+i5HhLea8hCMK8Nu25X5bfzzwPSL1DcnWBC5eMJtqpjvCy+Fb3AE+k7HmPwkToGW/uvu6
        w0H68nnoKdToW+OCZpwzeU/0Q
X-Received: by 2002:ac8:110f:: with SMTP id c15mr22619060qtj.251.1619540038884;
        Tue, 27 Apr 2021 09:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT4sMZbO5PuB5GIUmhLz1zl/3d5a+ZQmR9s8aJgEzvVt5VQlwUiwfZwbCp9M+hCjkWydKm3w==
X-Received: by 2002:ac8:110f:: with SMTP id c15mr22619025qtj.251.1619540038585;
        Tue, 27 Apr 2021 09:13:58 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:57 -0700 (PDT)
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
Subject: [PATCH v2 22/24] hugetlb/userfaultfd: Only drop uffd-wp special pte if required
Date:   Tue, 27 Apr 2021 12:13:15 -0400
Message-Id: <20210427161317.50682-23-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index a2a42335e8fd2..9b383c39756a5 100644
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
 
@@ -510,7 +511,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h));
+					(index + 1) * pages_per_huge_page(h),
+					ZAP_FLAG_DROP_FILE_UFFD_WP);
 				i_mmap_unlock_write(mapping);
 			}
 
@@ -576,7 +578,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
-		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
+		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
+				      ZAP_FLAG_DROP_FILE_UFFD_WP);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
@@ -609,8 +612,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
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
index 652660fd6ec8a..5fa84bbefa628 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -121,11 +121,12 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
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
@@ -358,7 +359,8 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fa9af9c893512..f73a236b5a835 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4096,7 +4096,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
-			    struct page *ref_page)
+			    struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -4148,6 +4148,19 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -4199,9 +4212,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
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
@@ -4217,12 +4231,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
 
@@ -4277,7 +4292,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index f1cdc613b5887..99741c9254c5b 100644
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

