Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DDA44BD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKJIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhKJIpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:45:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1403C06120A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:42:23 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g28so1661359pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjaHrKt+DJP4IEAgkVBlHHfdXPa5cKGowXjGMRJo0SA=;
        b=C4UYEqJbuSDRf/HMtynmIRwNESH9O6jxXXNUQZQOsEYqic/M0wQ/xU6YvMmiqPK1rY
         vL/xA3bmK/+sple9TJdFkNoLuJiBZpMVcWRIfnhKuoB/91V+YZpSt1ggPZZQUNaYTsh3
         QUkdJ+eHNBFjtd+oOaAmpIWXA921bTXBs12U12pHdg9KppTWdY7V6uiYx3bVreTvbMv4
         DdIhFNmqy8fsyKC6fjn28QKRFGjWf0egir1Lt4+AryHP8RrZOSAngVQOuIDBlggIjdIL
         Kd+VD6KxzosgM1rZGuqUyHUT4c20f6wjwxci47mA8HsAP2onT9Av0gL/wXywgluc1cOO
         mL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjaHrKt+DJP4IEAgkVBlHHfdXPa5cKGowXjGMRJo0SA=;
        b=dCbVnTbE4e5cwEJ51bjr3gjWSYMUfsdVb64xp4uO8QPdlN8nraLrC5+EetEVzmD5++
         Us+AJnOCpDIU3fKG17lm8eko7Al6XIwHkz2Dhqj15/FcZ7SM0pMbwNM4wqmUh/NXOVFF
         /0f0dk2QnIg4H0DBLAdF93cPhsNqIAPqfn87PWIKKlTkdx1SeaySlM4BgyjA6ZfyG/NV
         pvgYuUS6uEZcfZPvXJRBkf1NjEqRWwBXTZwiDkVc94yGdBwcYFa9qAS5pLpWbfCTc97N
         TYbKcMQaHkO2XKIn7XbdQgtRA4fs4qmRnkTEyGvvxyr2JYSlvJey9aijBfA+tkk8dHRQ
         L7fQ==
X-Gm-Message-State: AOAM530Zf5zsy12ALGKxCzQxIDiFDaS3hUq1Wb/xaegmOGHB/nzI6sc3
        gvDSJkBJcVFeMxdP5hoOTUc8Qg==
X-Google-Smtp-Source: ABdhPJzsmr+/bJqQnaZuF7I8RXRlcGDbF/wlFEYwQbI5RWmYoIdcsvMqexe1DizmGtZg638OSigtQA==
X-Received: by 2002:a05:6a00:238d:b0:47c:2232:80d8 with SMTP id f13-20020a056a00238d00b0047c223280d8mr14913499pfc.12.1636533743444;
        Wed, 10 Nov 2021 00:42:23 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5485368pgl.38.2021.11.10.00.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:42:23 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 09/15] mm/pte_ref: add support for the map/unmap of user PTE page table page
Date:   Wed, 10 Nov 2021 16:40:51 +0800
Message-Id: <20211110084057.27676-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The !pte_none() entry will take a reference on the user PTE page
table page, such as regular page table entry that map physical
pages, or swap entry, or migrate entry, etc.

So a pte_none() entry is mapped, it needs to increase the refcount
of the PTE page table page. When a !pte_none() entry becomes none,
the refcount of the PTE page table page needs to be decreased.

For swap or migrate cases, which only change the content of
the PTE entry, we keep the refcount unchanged.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/events/uprobes.c |  2 ++
 mm/filemap.c            |  3 +++
 mm/madvise.c            |  5 +++++
 mm/memory.c             | 42 +++++++++++++++++++++++++++++++++++-------
 mm/migrate.c            |  1 +
 mm/mremap.c             |  7 +++++++
 mm/rmap.c               | 10 ++++++++++
 mm/userfaultfd.c        |  2 ++
 8 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..96dd2959e1ac 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -200,6 +200,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	if (new_page)
 		set_pte_at_notify(mm, addr, pvmw.pte,
 				  mk_pte(new_page, vma->vm_page_prot));
+	else
+		pte_put(mm, pte_to_pmd(pvmw.pte), addr);
 
 	page_remove_rmap(old_page, false);
 	if (!page_mapped(old_page))
diff --git a/mm/filemap.c b/mm/filemap.c
index 1e7e9e4fd759..aa47ee11a3d8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3309,6 +3309,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	unsigned int nr_get = 0;
 
 	rcu_read_lock();
 	head = first_map_page(mapping, &xas, end_pgoff);
@@ -3342,6 +3343,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			ret = VM_FAULT_NOPAGE;
 
 		do_set_pte(vmf, page, addr);
+		nr_get++;
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, addr, vmf->pte);
 		unlock_page(head);
@@ -3351,6 +3353,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		put_page(head);
 	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_get_many(vmf->pmd, nr_get);
 	pte_put(vma->vm_mm, vmf->pmd, start);
 out:
 	rcu_read_unlock();
diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..82fc40b6dcbf 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -580,6 +580,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	int nr_swap = 0;
 	unsigned long next;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
@@ -612,6 +614,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			nr_swap--;
 			free_swap_and_cache(entry);
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			continue;
 		}
 
@@ -696,6 +699,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 0b9af38cfa11..ea4d651ac8c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -878,6 +878,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_swp_clear_uffd_wp(pte);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -946,6 +947,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		/* Uffd-wp needs to be delivered to dest pte as well */
 		pte = pte_wrprotect(pte_mkuffd_wp(pte));
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -998,6 +1000,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_clear_uffd_wp(pte);
 
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -1335,6 +1338,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1359,6 +1364,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			nr_put++;
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
@@ -1392,6 +1398,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			rss[mm_counter(page)]--;
 
 			if (is_device_private_entry(entry))
@@ -1416,6 +1423,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		nr_put++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1442,6 +1450,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
+
 	return addr;
 }
 
@@ -1759,6 +1770,7 @@ static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
 	inc_mm_counter_fast(mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_get(pte_to_pmd(pte));
 	return 0;
 }
 
@@ -2085,6 +2097,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	set_pte_at(mm, addr, pte, entry);
+	pte_get(pte_to_pmd(pte));
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
 out_unlock:
@@ -2291,6 +2304,7 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long pfn, pgprot_t prot)
 {
 	unsigned long start = addr;
+	unsigned int nr_get = 0;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
@@ -2306,10 +2320,12 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			break;
 		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
+		nr_get++;
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_get_many(pmd, nr_get);
 	pte_put(mm, pmd, start);
 	return err;
 }
@@ -2524,6 +2540,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte, *mapped_pte;
 	int err = 0;
 	spinlock_t *ptl;
+	unsigned int nr_put = 0, nr_get = 0;
 
 	if (create) {
 		mapped_pte = pte = (mm == &init_mm) ?
@@ -2531,6 +2548,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			pte_alloc_map_lock(mm, pmd, addr, &ptl);
 		if (!pte)
 			return -ENOMEM;
+		nr_put++;
 	} else {
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_offset_kernel(pmd, addr) :
@@ -2543,11 +2561,17 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	if (fn) {
 		do {
-			if (create || !pte_none(*pte)) {
+			if (create) {
 				err = fn(pte++, addr, data);
-				if (err)
-					break;
+				if (mm != &init_mm && !pte_none(*(pte-1)))
+					nr_get++;
+			} else if (!pte_none(*pte)) {
+				err = fn(pte++, addr, data);
+				if (mm != &init_mm && pte_none(*(pte-1)))
+					nr_put++;
 			}
+			if (err)
+				break;
 		} while (addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
@@ -2556,8 +2580,9 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	if (mm != &init_mm) {
 		pte_unmap_unlock(mapped_pte, ptl);
-		if (create)
-			pte_put(mm, pmd, start);
+		pte_get_many(pmd, nr_get);
+		if (nr_put)
+			pte_put_many(mm, pmd, start, nr_put);
 	}
 	return err;
 }
@@ -3835,6 +3860,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	pte_get(vmf->pmd);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
@@ -4086,10 +4112,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_none(*vmf->pte))) {
 		do_set_pte(vmf, page, vmf->address);
-	else
+		pte_get(vmf->pmd);
+	} else {
 		ret = VM_FAULT_NOPAGE;
+	}
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 26f16a4836d8..c03ac25f42a9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2807,6 +2807,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	} else {
 		/* No need to invalidate - it was non-present before */
 		set_pte_at(mm, addr, ptep, entry);
+		pte_get(pmdp);
 		update_mmu_cache(vma, addr, ptep);
 	}
 
diff --git a/mm/mremap.c b/mm/mremap.c
index f80c628db25d..088a7a75cb4b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -141,6 +141,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	unsigned int nr_put = 0, nr_get = 0;
+	unsigned long old_start = old_addr;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -181,6 +183,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 			continue;
 
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
+		nr_put++;
 		/*
 		 * If we are remapping a valid PTE, make sure
 		 * to flush TLB before we drop the PTL for the
@@ -197,6 +200,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
+		nr_get++;
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -206,6 +210,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
+	pte_get_many(new_pmd, nr_get);
+	if (nr_put)
+		pte_put_many(mm, old_pmd, old_start, nr_put);
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 2908d637bcad..630ce8a036b5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1404,6 +1404,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned int nr_put = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1551,6 +1552,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
+			nr_put++;
 		} else if (PageAnon(page)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
@@ -1564,6 +1566,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				/* We have to invalidate as we cleared the pte */
 				mmu_notifier_invalidate_range(mm, address,
 							address + PAGE_SIZE);
+				pte_put(mm, pvmw.pmd, address);
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
@@ -1575,6 +1578,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
 					dec_mm_counter(mm, MM_ANONPAGES);
+					nr_put++;
 					goto discard;
 				}
 
@@ -1630,6 +1634,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 * See Documentation/vm/mmu_notifier.rst
 			 */
 			dec_mm_counter(mm, mm_counter_file(page));
+			nr_put++;
 		}
 discard:
 		/*
@@ -1641,6 +1646,10 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 */
 		page_remove_rmap(subpage, PageHuge(page));
 		put_page(page);
+		if (nr_put) {
+			pte_put_many(mm, pvmw.pmd, address, nr_put);
+			nr_put = 0;
+		}
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
@@ -1871,6 +1880,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
+			pte_put(mm, pvmw.pmd, address);
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 37df899a1b9d..b87c61b94065 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -110,6 +110,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
@@ -204,6 +205,7 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
-- 
2.11.0

