Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83431DD65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhBQQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233905AbhBQQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cOEu0qsFxSp6evGy5oqY57J2hfl6jR1TN+14A84sIU=;
        b=AFvU2TUZvZLXf67+KwbbnmgsIAik7ORXROfFpdDtIFRPD3qfo48RM68ksMiQAj4dOc89Eo
        S3bRCYN99A/3LRwBKz3jISEX9/xTGUKGz7YgXG1/0E3o4CTTZjgGvbByGP6480N3R6CL9U
        j/bE4ZmKd953uSs9s5PKCJgTt6uHNr8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-rAMfTQZPNti-xhQDJRW0Zw-1; Wed, 17 Feb 2021 11:31:07 -0500
X-MC-Unique: rAMfTQZPNti-xhQDJRW0Zw-1
Received: by mail-qv1-f72.google.com with SMTP id p4so10305615qvn.23
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cOEu0qsFxSp6evGy5oqY57J2hfl6jR1TN+14A84sIU=;
        b=W5ZkZU3CBvud3fmkz6rqlcWhv1/ZRtu2lcpSu/SyvrvrUe0lDHhscgzKMC5L/ZQ/Os
         q8Fe/XFQP0akeieab6fhQW2wC5sv+T8SNYWD/ot6bmRC+DCUnaCJetCY91cbliNzz2VU
         RxWRhuMgrM6SkEdHjU6nRc3VpGuSvEh01gnLVrpxRog9EvAUmvtuORx4/afv3PzvuQRv
         L0D7NtIuO63XNo++6UR3439MZ+aAVxfLJSGNVxWQIcXt/FCiU3UM531rrmKiwvVB4A2K
         PxM7q8Y/PjaF3pDtUY5cBHpHlH2YgKMAokOYwMdQ4H7mjQdPnS8TXj6yjR0znN/znc/n
         m1zg==
X-Gm-Message-State: AOAM531F/rCzvbtuVC5qgyu0FyP46TGWhKquoXiPEw8hIA3YeK2+e4Of
        CG6LJ+2xJIMpayU6p+7bbCiC8+qNagmGXhBWTyHlnhtlpUc/fAC1lpMIwMvxM1XX5j+73Guv+WV
        YIKq8aB8n8w15CbPVTFup43ZoN4r4U7wmySSI0xvhqKeNbSX6FyF9T2DCoKKrTJxPsUIyy9oK5Q
        ==
X-Received: by 2002:a37:a896:: with SMTP id r144mr11247176qke.121.1613579465776;
        Wed, 17 Feb 2021 08:31:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypxSiiT45MFdlZ+0zyD0f4Diy/BbYjxcNySZvcwNuHQwu4koTRY7lhmoAGBdHvcGKK6NXrPw==
X-Received: by 2002:a37:a896:: with SMTP id r144mr11247140qke.121.1613579465477;
        Wed, 17 Feb 2021 08:31:05 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z37sm399902qth.87.2021.02.17.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:31:04 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/4] hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()
Date:   Wed, 17 Feb 2021 11:30:59 -0500
Message-Id: <20210217163102.13436-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217163102.13436-1-peterx@redhat.com>
References: <20210217163102.13436-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a preparation work to be able to behave differently in the per
architecture huge_pte_alloc() according to different VMA attributes.

Pass it deeper into huge_pmd_share() so that we can avoid the find_vma() call.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c   |  4 ++--
 arch/ia64/mm/hugetlbpage.c    |  3 ++-
 arch/mips/mm/hugetlbpage.c    |  4 ++--
 arch/parisc/mm/hugetlbpage.c  |  2 +-
 arch/powerpc/mm/hugetlbpage.c |  3 ++-
 arch/s390/mm/hugetlbpage.c    |  2 +-
 arch/sh/mm/hugetlbpage.c      |  2 +-
 arch/sparc/mm/hugetlbpage.c   |  1 +
 include/linux/hugetlb.h       |  5 +++--
 mm/hugetlb.c                  | 15 ++++++++-------
 mm/userfaultfd.c              |  2 +-
 11 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 55ecf6de9ff7..6e3bcffe2837 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -252,7 +252,7 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, pte);
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
@@ -286,7 +286,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	} else if (sz == PMD_SIZE) {
 		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
 		    pud_none(READ_ONCE(*pudp)))
-			ptep = huge_pmd_share(mm, addr, pudp);
+			ptep = huge_pmd_share(mm, vma, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
 	} else if (sz == (CONT_PMD_SIZE)) {
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index b331f94d20ac..f993cb36c062 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -25,7 +25,8 @@ unsigned int hpage_shift = HPAGE_SHIFT_DEFAULT;
 EXPORT_SYMBOL(hpage_shift);
 
 pte_t *
-huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+	       unsigned long addr, unsigned long sz)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
diff --git a/arch/mips/mm/hugetlbpage.c b/arch/mips/mm/hugetlbpage.c
index b9f76f433617..7eaff5b07873 100644
--- a/arch/mips/mm/hugetlbpage.c
+++ b/arch/mips/mm/hugetlbpage.c
@@ -21,8 +21,8 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
-		      unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d7ba014a7fbb..e141441bfa64 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -44,7 +44,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 }
 
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8b3cc4d688e8..d57276b8791c 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -106,7 +106,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
  */
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pg;
 	p4d_t *p4;
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 3b5a4d25ca9b..da36d13ffc16 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -189,7 +189,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 220d7bc43d2b..999ab5916e69 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ad4b42f04988..97e0824fdbe7 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -280,6 +280,7 @@ unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&p
 unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5807f23caf8..a6113fa6d21d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -152,7 +152,8 @@ void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, pud_t *pud);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -161,7 +162,7 @@ extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..07bb9bdc3282 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3807,7 +3807,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-		dst_pte = huge_pte_alloc(dst, addr, sz);
+		dst_pte = huge_pte_alloc(dst, vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
@@ -4544,7 +4544,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	mapping = vma->vm_file->f_mapping;
 	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
 	if (!ptep) {
 		i_mmap_unlock_read(mapping);
 		return VM_FAULT_OOM;
@@ -5334,9 +5334,9 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
  * only required for subsequent processing.
  */
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, pud_t *pud)
 {
-	struct vm_area_struct *vma = find_vma(mm, addr);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
 			vma->vm_pgoff;
@@ -5414,7 +5414,8 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 #define want_pmd_share()	(1)
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
+		      unsigned long addr, pud_t *pud)
 {
 	return NULL;
 }
@@ -5433,7 +5434,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
@@ -5452,7 +5453,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		} else {
 			BUG_ON(sz != PMD_SIZE);
 			if (want_pmd_share() && pud_none(*pud))
-				pte = huge_pmd_share(mm, addr, pud);
+				pte = huge_pmd_share(mm, vma, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..063cbb17e8d8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -290,7 +290,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		err = -ENOMEM;
-		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
+		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-- 
2.26.2

