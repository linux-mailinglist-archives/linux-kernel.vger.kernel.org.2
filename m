Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6244BF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhKJK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKJK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:06 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7B6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m14so2307077pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98uC4cgov5u0+cSk5mxDVBWjtzB+qrevfuyFblbNyWw=;
        b=cva+aOBEkaQYYDYZAF5rDi1Tfp9MZNosTs0NPG0+glqltDBrZb9wxohXGVtHPC2AIr
         ZFQ+xqwm1q7FxXMytBl9Wc1TRo2GN7P36QBn3aIgARZzLR+xZjfgK/DFHSIJWwCfYbGe
         TGG6YW2ZvHrIqxcQVlzqb4Ivi+z+W5ehuhWR8pqV7qn7szeJLvNYAzyCKXFF+i1ef2+i
         V1/qfqX6Yi/1sWo4PA/u19/7eu/A6D3GMW1FHo4tIL406VlVeu12EID8kVWuMZrPskPU
         zQRNZy+XCSSn9ScZgOFY8kLZpfqPvEuPqKuzhatRkuCmKIKu3xHy6KutgHrqU+r72cms
         8S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98uC4cgov5u0+cSk5mxDVBWjtzB+qrevfuyFblbNyWw=;
        b=7mzkEatCnTugNJdgjrTZ41Zlg0omRp1HWorNCELDmL1Ihs049e8mMAgfFxmERKGjv5
         urq/RiWTk4bJwnG6NM5STRJh1IBA32IZGfD2ZwMH1SOwpSNnxhsK90PkGTXZrIX81+rl
         kF74nOYsQscHIO63pnuEyvZFxGgLJGXw4qBPacnJEyoVFIfqTC2ieG9s0vyn1UZwZByl
         waq2hQq6zVt45cZfbQJpRmCwGr3GLQ0f7QaFQ+wkeG4/1bGWorjqdJ+6sdwrkmB01H7N
         NnZ1zeIFGNryChZw3L+IPG3imvryjxxFuckuKdOc2jm3xPO+fbIsy1Yc9nFCDT/NScBs
         RIvA==
X-Gm-Message-State: AOAM531WZdWnN38nzlB4CXhKGDC7gjnGTw3wOOA9jQEF5xiQwnGt7T4b
        ueQR0xn39sIYImJY4wupKSx+yA==
X-Google-Smtp-Source: ABdhPJxJ891Je08HKBpyxaVnluFJ2Tkn+ncUllLSe1oyHEEXHaMg7i4b2la/BjCym1+nnoYCwNn+5Q==
X-Received: by 2002:a62:e908:0:b0:49f:c633:51ec with SMTP id j8-20020a62e908000000b0049fc63351ecmr27603629pfh.1.1636541718220;
        Wed, 10 Nov 2021 02:55:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:17 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 07/15] mm/pte_ref: add support for user PTE page table page allocation
Date:   Wed, 10 Nov 2021 18:54:20 +0800
Message-Id: <20211110105428.32458-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the PTE page table page is allocated and installed into the
pmd entry, it needs to take an initial reference count to prevent
the release of PTE page table page by other threads, and the caller
of pte_alloc()(or other friends) needs to reduce this reference count.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h    |  7 +++++--
 mm/debug_vm_pgtable.c |  1 +
 mm/filemap.c          |  8 ++++++--
 mm/gup.c              | 10 +++++++---
 mm/memory.c           | 51 +++++++++++++++++++++++++++++++++++++++++----------
 mm/migrate.c          |  9 ++++++---
 mm/mlock.c            |  1 +
 mm/mremap.c           |  1 +
 mm/userfaultfd.c      | 16 +++++++++++++++-
 9 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52f36fde2f11..753a9435e0d0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/page-flags.h>
 #include <linux/page_ref.h>
+#include <linux/pte_ref.h>
 #include <linux/memremap.h>
 #include <linux/overflow.h>
 #include <linux/sizes.h>
@@ -2313,9 +2314,11 @@ enum pmd_installed_type {
 
 static inline int pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 {
-	if (unlikely(pmd_none(*(pmd))))
+	enum pte_tryget_type ret = pte_try_get(pmd);
+
+	if (ret == TRYGET_FAILED_NONE || ret == TRYGET_FAILED_ZERO)
 		return __pte_alloc(mm, pmd);
-	if (unlikely(is_huge_pmd(*pmd)))
+	else if (ret == TRYGET_FAILED_HUGE_PMD)
 		return INSTALLED_HUGE_PMD;
 
 	return INSTALLED_PTE;
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index b8322c55e65d..52f006654664 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1048,6 +1048,7 @@ static void __init destroy_args(struct pgtable_debug_args *args)
 
 	/* Free page table entries */
 	if (args->start_ptep) {
+		pte_put(args->mm, args->start_pmdp, args->vaddr);
 		pte_free(args->mm, args->start_ptep);
 		mm_dec_nr_ptes(args->mm);
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index 23363f8ddbbe..1e7e9e4fd759 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3217,6 +3217,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		}
 	}
 
+retry:
 	if (pmd_none(*vmf->pmd)) {
 		int ret = pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
@@ -3225,6 +3226,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
 		/* See comment in handle_pte_fault() */
 		goto out;
+	} else if (pte_try_get(vmf->pmd) == TRYGET_FAILED_ZERO) {
+		goto retry;
 	}
 
 	return false;
@@ -3301,7 +3304,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
-	unsigned long addr;
+	unsigned long addr, start;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
@@ -3317,7 +3320,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	start = addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
 		page = find_subpage(head, xas.xa_index);
@@ -3348,6 +3351,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		put_page(head);
 	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_put(vma->vm_mm, vmf->pmd, start);
 out:
 	rcu_read_unlock();
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
diff --git a/mm/gup.c b/mm/gup.c
index 2def775232a3..e084111103f0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -694,7 +694,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			spin_unlock(ptl);
 			ret = 0;
 			split_huge_pmd(vma, pmd, address);
-			if (pmd_trans_unstable(pmd))
+			if (pte_try_get(pmd) == TRYGET_FAILED_HUGE_PMD)
 				ret = -EBUSY;
 		} else {
 			spin_unlock(ptl);
@@ -702,8 +702,12 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			ret = pte_alloc(mm, pmd) < 0 ? -ENOMEM : 0;
 		}
 
-		return ret ? ERR_PTR(ret) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		if (ret)
+			return ERR_PTR(ret);
+
+		page = follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		pte_put(mm, pmd, address);
+		return page;
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 8a39c0e58324..0b9af38cfa11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -441,10 +441,13 @@ enum pmd_installed_type pmd_install(struct mm_struct *mm, pmd_t *pmd,
 				    pgtable_t *pte)
 {
 	int ret = INSTALLED_PTE;
-	spinlock_t *ptl = pmd_lock(mm, pmd);
+	spinlock_t *ptl;
 
+retry:
+	ptl = pmd_lock(mm, pmd);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
 		mm_inc_nr_ptes(mm);
+		pte_ref_init(*pte, pmd, 1);
 		/*
 		 * Ensure all pte setup (eg. pte page lock and page clearing) are
 		 * visible before the pte is made visible to other CPUs by being
@@ -464,6 +467,9 @@ enum pmd_installed_type pmd_install(struct mm_struct *mm, pmd_t *pmd,
 	} else if (is_huge_pmd(*pmd)) {
 		/* See comment in handle_pte_fault() */
 		ret = INSTALLED_HUGE_PMD;
+	} else if (!pte_get_unless_zero(pmd)) {
+		spin_unlock(ptl);
+		goto retry;
 	}
 	spin_unlock(ptl);
 
@@ -1028,6 +1034,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
 	struct page *prealloc = NULL;
+	unsigned long start = addr;
 
 again:
 	progress = 0;
@@ -1108,6 +1115,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	pte_unmap(orig_src_pte);
 	add_mm_rss_vec(dst_mm, rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
+	pte_put(dst_mm, dst_pmd, start);
 	cond_resched();
 
 	if (ret == -EIO) {
@@ -1778,6 +1786,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 		goto out;
 	retval = insert_page_into_pte_locked(mm, pte, addr, page, prot);
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 out:
 	return retval;
 }
@@ -1810,6 +1819,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long remaining_pages_total = *num;
 	unsigned long pages_to_write_in_pmd;
 	int ret;
+	unsigned long start = addr;
 more:
 	ret = -EFAULT;
 	pmd = walk_to_pmd(mm, addr);
@@ -1836,7 +1846,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 				pte_unmap_unlock(start_pte, pte_lock);
 				ret = err;
 				remaining_pages_total -= pte_idx;
-				goto out;
+				goto put;
 			}
 			addr += PAGE_SIZE;
 			++curr_page_idx;
@@ -1845,9 +1855,13 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 		pages_to_write_in_pmd -= batch_size;
 		remaining_pages_total -= batch_size;
 	}
-	if (remaining_pages_total)
+	if (remaining_pages_total) {
+		pte_put(mm, pmd, start);
 		goto more;
+	}
 	ret = 0;
+put:
+	pte_put(mm, pmd, start);
 out:
 	*num = remaining_pages_total;
 	return ret;
@@ -2075,6 +2089,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 
 out_unlock:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 	return VM_FAULT_NOPAGE;
 }
 
@@ -2275,6 +2290,7 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
+	unsigned long start = addr;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
@@ -2294,6 +2310,7 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(mm, pmd, start);
 	return err;
 }
 
@@ -2503,6 +2520,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 				     pte_fn_t fn, void *data, bool create,
 				     pgtbl_mod_mask *mask)
 {
+	unsigned long start = addr;
 	pte_t *pte, *mapped_pte;
 	int err = 0;
 	spinlock_t *ptl;
@@ -2536,8 +2554,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 
-	if (mm != &init_mm)
+	if (mm != &init_mm) {
 		pte_unmap_unlock(mapped_pte, ptl);
+		if (create)
+			pte_put(mm, pmd, start);
+	}
 	return err;
 }
 
@@ -3761,7 +3782,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		/* Deliver the page fault to userland, check inside PT lock */
 		if (userfaultfd_missing(vma)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
+			ret = handle_userfault(vmf, VM_UFFD_MISSING);
+			goto put;
 		}
 		goto setpte;
 	}
@@ -3804,7 +3826,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		put_page(page);
-		return handle_userfault(vmf, VM_UFFD_MISSING);
+		ret = handle_userfault(vmf, VM_UFFD_MISSING);
+		goto put;
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3817,14 +3840,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return ret;
+	goto put;
 release:
 	put_page(page);
 	goto unlock;
 oom_free_page:
 	put_page(page);
 oom:
-	return VM_FAULT_OOM;
+	ret = VM_FAULT_OOM;
+put:
+	pte_put(vma->vm_mm, vmf->pmd, vmf->address);
+	return ret;
 }
 
 /*
@@ -4031,7 +4057,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
-	if (pmd_none(*vmf->pmd)) {
+retry:
+	ret = pte_try_get(vmf->pmd);
+	if (ret == TRYGET_FAILED_NONE) {
 		int alloc_ret;
 
 		if (PageTransCompound(page)) {
@@ -4047,9 +4075,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 		if (unlikely(alloc_ret != INSTALLED_PTE))
 			return alloc_ret < 0 ? VM_FAULT_OOM : 0;
-	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
+	} else if (ret == TRYGET_FAILED_HUGE_PMD) {
 		/* See comment in handle_pte_fault() */
 		return 0;
+	} else if (ret == TRYGET_FAILED_ZERO) {
+		goto retry;
 	}
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -4063,6 +4093,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_put(vma->vm_mm, vmf->pmd, vmf->address);
 	return ret;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index bdfdfd3b50be..26f16a4836d8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2736,9 +2736,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 
 	if (unlikely(anon_vma_prepare(vma)))
-		goto abort;
+		goto put;
 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
-		goto abort;
+		goto put;
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
@@ -2764,7 +2764,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			 * device memory.
 			 */
 			pr_warn_once("Unsupported ZONE_DEVICE page type.\n");
-			goto abort;
+			goto put;
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
@@ -2811,11 +2811,14 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	}
 
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmdp, addr);
 	*src = MIGRATE_PFN_MIGRATE;
 	return;
 
 unlock_abort:
 	pte_unmap_unlock(ptep, ptl);
+put:
+	pte_put(mm, pmdp, addr);
 abort:
 	*src &= ~MIGRATE_PFN_MIGRATE;
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index e263d62ae2d0..a4ef20ba9627 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -398,6 +398,7 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 			break;
 	}
 	pte_unmap_unlock(pte, ptl);
+	pte_put(vma->vm_mm, pte_to_pmd(pte), start);
 	return start;
 }
 
diff --git a/mm/mremap.c b/mm/mremap.c
index fc5c56858883..f80c628db25d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -555,6 +555,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			break;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
+		pte_put(new_vma->vm_mm, new_pmd, new_addr);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2cea08e7f076..37df899a1b9d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -574,6 +574,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
+		enum pte_tryget_type tryget_type;
 
 		BUG_ON(dst_addr >= dst_start + len);
 
@@ -583,6 +584,14 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			break;
 		}
 
+again:
+		/*
+		 * After the management of the PTE page changes to the refcount
+		 * mode, the PTE page may be released by another thread(rcu mode),
+		 * so the rcu lock is held here to prevent the PTE page from
+		 * being released.
+		 */
+		rcu_read_lock();
 		dst_pmdval = pmd_read_atomic(dst_pmd);
 		/*
 		 * If the dst_pmd is mapped as THP don't
@@ -593,7 +602,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			break;
 		}
 
-		if (unlikely(pmd_none(dst_pmdval))) {
+		tryget_type = pte_try_get(&dst_pmdval);
+		rcu_read_unlock();
+		if (unlikely(tryget_type == TRYGET_FAILED_NONE)) {
 			int ret = __pte_alloc(dst_mm, dst_pmd);
 
 			/*
@@ -607,6 +618,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 				err = -EFAULT;
 				break;
 			}
+		} else if (unlikely(tryget_type == TRYGET_FAILED_ZERO)) {
+			goto again;
 		}
 
 		BUG_ON(pmd_none(*dst_pmd));
@@ -614,6 +627,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
+		pte_put(dst_mm, dst_pmd, dst_addr);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.11.0

