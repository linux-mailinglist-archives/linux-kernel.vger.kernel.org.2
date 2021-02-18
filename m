Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E731F1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBRV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhBRV4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613685281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxZ7naSjdLcWw4VhAiMvDw9KgZSLU2f7bqFnNZWBKu4=;
        b=ilXNcbtbuh/bO1ies4Bs66wedE7ELT7NmGgCnEakWY4n7Y0hZ/xFVfioI3YBV5mWXYr1+h
        RtS2uhBNdMjC8g0TBPQHBlMYi91Yf95BSQH+tzZ9YMGV51OOsya6ikEgL0HJTyzskSisZ8
        BZpWnL+wvS4o4y16FWYH2q+Enb0GqMI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-2_ChIrIcP9eJrrPie4o6Yg-1; Thu, 18 Feb 2021 16:54:39 -0500
X-MC-Unique: 2_ChIrIcP9eJrrPie4o6Yg-1
Received: by mail-qt1-f200.google.com with SMTP id v22so2049480qto.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxZ7naSjdLcWw4VhAiMvDw9KgZSLU2f7bqFnNZWBKu4=;
        b=jiPiJZUFalnBOubvdBIMb3J67+y398RdTFJxV/hARN5UJoK0DC5hzPDM8pSTiZT3Kw
         o17w2LqRacta5qctyEDKEPG53UIUoREYqzV0bS26L+fuDMVKO0lMiZILFgGvOAPdQkra
         hfkZFAmYHaRz2zcDOWksC0wYMC+xzdlFX99YYRB1ZmvdqiNw6iOVHz55lEEDzo0OSOtc
         w3OCPr0h66WNi1RpO3bXogRH8mczA8XJQInJ/W4fmQEHAPew3Dr5XVGDWG0qWrv+Hf+h
         pNvD11gXSB0Q6U8qAiBPm3gr+fCewtgY99Zf0yIncYAxB3aCtaM386BxOuiKTOw//F6O
         hkZg==
X-Gm-Message-State: AOAM530OcbxMd+3TwTXYfZOyRiy7UeQ83W+r9gGpnw0Fdy5U2YmfN/1f
        2Dlte08hQM6c4TJh8LXzCZRDhCnp155SUU8rCM3gAPuqZRfUrR6z67E5wThdKm8CNhfHU6mbNgz
        DDaZMLiAagIVWat7+V9CHu7bgcVdZPoYYdYPYQMtROiUw5ON8Kh0IvItWcUssCUhtTeBz7bgDug
        ==
X-Received: by 2002:ac8:782:: with SMTP id l2mr6339651qth.127.1613685278227;
        Thu, 18 Feb 2021 13:54:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm/5cI0aSiCCzZ0s31bO0wGCb4vnsbxeU5g3vbJ//GN9uluxCGOaH4rcHYL/KTRa+ej0iLiA==
X-Received: by 2002:ac8:782:: with SMTP id l2mr6339631qth.127.1613685277972;
        Thu, 18 Feb 2021 13:54:37 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id r80sm4964260qke.97.2021.02.18.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:54:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 1/4] hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()
Date:   Thu, 18 Feb 2021 16:54:31 -0500
Message-Id: <20210218215434.10203-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218215434.10203-1-peterx@redhat.com>
References: <20210218215434.10203-1-peterx@redhat.com>
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
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
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

