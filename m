Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F593CC78F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhGREeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhGREeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:34:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69DC061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v18-20020a17090ac912b0290173b9578f1cso9758746pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LanASHtxxLZXQ/XX1RaBWQWbOugxdwuvke0KrwLP0M=;
        b=fIgevCQgNB+1RE9E3hMr8S8cNZAIhReapcb/AgKNWCE6ZSRBXPdqp9NliSK80TfKf/
         Q4RUY59JxMACFr2EvOTNVNdO8I+sS36uykLQJKMq8D+c0fo6rIFaoevumqk7GGB7DMP9
         O2T0/T4FDVqWWEurJ7TnlAEECzQ3SQgSojnNwK3LEAq//MNIzPj17aAMVyh9ATYavGGe
         kIUgYJvTVeCbqepKIHVUfNhg42fdE27gnmPI0+ijlz3QB5KjBopjrOCOFvOT03+0Y4nY
         7Z+UmapuNc3qiSBGxp99Z2WuC0Q+Zbo3rXhBZe6aTFmTi87qjF3Q8+RTi+NCT7Q+Azov
         68EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LanASHtxxLZXQ/XX1RaBWQWbOugxdwuvke0KrwLP0M=;
        b=K25jKpVSJyw/vbuVBYKKVeQ34zFQ+jIQDQG3QI70DFXn6NvodQbaytFPIK4a1icRaV
         ncqr50g5MZmrnOCfNq0+oPn6wKPo/ftCSw1rBp4fqGbcPMYeVLx/Gb2o/cNmWi2BKspJ
         +totNbGKHd/2E4zztIxhOw/zZboNfZ2ysRL/8wW801wpoy5Upe8FqbhbVOh10P0usNPx
         68ymukb6dfE+1/yNCnXXzu19d9SzPc28wFgllsutQsv5XLOhrOlR7bBOPbQqK+g4oc75
         85Ye9UdBs4DZyGpLndqjdlc3O8YKudNwVPevNISFgSNkPa873nvBIHzB9wSEnoMYArD5
         S/mA==
X-Gm-Message-State: AOAM531mPC2X33RXwQqLphWgNMK5sdKunp5FRDpFD6flXr5IKjpxdfAz
        a48vY8FC0rLnPyIy4lm2XFNRMg==
X-Google-Smtp-Source: ABdhPJyzYTHvmdjf80kbKmWdOfej37Won3uUh4cYBsEpECNfBgSWXEYtbyHPqWkJGsjoKntK1a/1RA==
X-Received: by 2002:a17:902:8c83:b029:11b:3f49:f88c with SMTP id t3-20020a1709028c83b029011b3f49f88cmr13897726plo.63.1626582672023;
        Sat, 17 Jul 2021 21:31:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.31.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:31:11 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 5/7] mm: free user PTE page table pages
Date:   Sun, 18 Jul 2021 12:30:31 +0800
Message-Id: <20210718043034.76431-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some malloc libraries(e.g. jemalloc or tcmalloc) usually
allocate the amount of VAs by mmap() and do not unmap
those VAs. They will use madvise(MADV_DONTNEED) to free
physical memory if they want. But the page tables do not
be freed by madvise(), so it can produce many page tables
when the process touches an enormous virtual address space.

The following figures are a memory usage snapshot of one
process which actually happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

As we can see, the PTE page tables size is 110g, while the
RES is 590g. In theory, the process only need 1.2g PTE page
tables to map those physical memory. The reason why PTE page
tables occupy a lot of memory is that madvise(MADV_DONTNEED)
only empty the PTE and free physical memory but doesn't free
the PTE page table pages. So we can free those empty PTE page
tables to save memory. In the above cases, we can save memory
about 108g(best case). And the larger the difference between
the size of VIRT and RES, the more memory we save.

In this patch series, we add a pte_refcount field to the
struct page of page table to track how many users of PTE page
table. Similar to the mechanism of page refcount, the user of
PTE page table should hold a refcount to it before accessing.
The PTE page table page will be freed when the last refcount
is dropped.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/vm/split_page_table_lock.rst |   2 +-
 arch/arm/mm/pgd.c                          |   2 +-
 arch/arm64/mm/hugetlbpage.c                |   4 +-
 arch/ia64/mm/hugetlbpage.c                 |   2 +-
 arch/parisc/mm/hugetlbpage.c               |   2 +-
 arch/powerpc/mm/hugetlbpage.c              |   2 +-
 arch/s390/mm/gmap.c                        |   8 +-
 arch/s390/mm/pgtable.c                     |   6 +-
 arch/sh/mm/hugetlbpage.c                   |   2 +-
 arch/sparc/mm/hugetlbpage.c                |   2 +-
 arch/x86/kernel/tboot.c                    |   2 +-
 fs/proc/task_mmu.c                         |  23 ++-
 fs/userfaultfd.c                           |   2 +
 include/linux/mm.h                         |  13 +-
 include/linux/mm_types.h                   |   8 +-
 include/linux/pgtable.h                    |   3 +-
 include/linux/pte_ref.h                    | 217 +++++++++++++++++++++++
 include/linux/rmap.h                       |   3 +
 kernel/events/uprobes.c                    |   3 +
 mm/Kconfig                                 |   4 +
 mm/Makefile                                |   3 +-
 mm/debug_vm_pgtable.c                      |   3 +-
 mm/filemap.c                               |  45 ++---
 mm/gup.c                                   |  10 +-
 mm/hmm.c                                   |   4 +
 mm/internal.h                              |   2 +
 mm/khugepaged.c                            |  10 ++
 mm/ksm.c                                   |   4 +
 mm/madvise.c                               |  20 ++-
 mm/memcontrol.c                            |  11 +-
 mm/memory.c                                | 271 +++++++++++++++++++----------
 mm/mempolicy.c                             |   5 +-
 mm/migrate.c                               |  21 ++-
 mm/mincore.c                               |   6 +-
 mm/mlock.c                                 |   1 +
 mm/mprotect.c                              |  10 +-
 mm/mremap.c                                |  12 +-
 mm/page_vma_mapped.c                       |   4 +
 mm/pagewalk.c                              |  19 +-
 mm/pgtable-generic.c                       |   2 +
 mm/pte_ref.c                               | 132 ++++++++++++++
 mm/rmap.c                                  |  13 +-
 mm/swapfile.c                              |   6 +-
 mm/userfaultfd.c                           |  15 +-
 44 files changed, 758 insertions(+), 181 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

diff --git a/Documentation/vm/split_page_table_lock.rst b/Documentation/vm/split_page_table_lock.rst
index c08919662704..98eb7ba0d2ab 100644
--- a/Documentation/vm/split_page_table_lock.rst
+++ b/Documentation/vm/split_page_table_lock.rst
@@ -20,7 +20,7 @@ There are helpers to lock/unlock a table and other accessor functions:
 	lock;
  - pte_unmap_unlock()
 	unlocks and unmaps PTE table;
- - pte_alloc_map_lock()
+ - pte_alloc_get_map_lock()
 	allocates PTE table if needed and take the lock, returns pointer
 	to taken lock or NULL if allocation failed;
  - pte_lockptr()
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index f8e9bc58a84f..b2408ad9dcf5 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -100,7 +100,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		if (!new_pmd)
 			goto no_pmd;
 
-		new_pte = pte_alloc_map(mm, new_pmd, 0);
+		new_pte = pte_alloc_get_map(mm, new_pmd, 0);
 		if (!new_pte)
 			goto no_pte;
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 23505fc35324..54f6beb3eb6b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -280,9 +280,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * 32-bit arm platform then it will cause trouble in
 		 * the case where CONFIG_HIGHPTE is set, since there
 		 * will be no pte_unmap() to correspond with this
-		 * pte_alloc_map().
+		 * pte_alloc_get_map().
 		 */
-		ptep = pte_alloc_map(mm, pmdp, addr);
+		ptep = pte_alloc_get_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
 		if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, vma, addr, pudp);
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..cb230005e7dd 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -41,7 +41,7 @@ huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, taddr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, taddr);
+			pte = pte_alloc_get_map(mm, pmd, taddr);
 	}
 	return pte;
 }
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d1d3990b83f6..ff16db9a44a5 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -66,7 +66,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, addr);
+			pte = pte_alloc_get_map(mm, pmd, addr);
 	}
 	return pte;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9a75ba078e1b..20af2db18d08 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -182,7 +182,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_map(mm, (pmd_t *)hpdp, addr);
+		return pte_alloc_get_map(mm, (pmd_t *)hpdp, addr);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9bb2c7512cd5..b243b276d9b6 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -856,7 +856,7 @@ static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
 	table = gmap_table_walk(gmap, gaddr, 1); /* get segment pointer */
 	if (!table || *table & _SEGMENT_ENTRY_INVALID)
 		return NULL;
-	return pte_alloc_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
+	return pte_alloc_get_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
 }
 
 /**
@@ -925,7 +925,7 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
 		return NULL;
 	}
 
-	/* 4k page table entries are locked via the pte (pte_alloc_map_lock). */
+	/* 4k page table entries are locked via the pte (pte_alloc_get_map_lock). */
 	if (!pmd_large(*pmdp))
 		spin_unlock(&gmap->guest_table_lock);
 	return pmdp;
@@ -1012,7 +1012,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return -EAGAIN;
 
-	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+	ptep = pte_alloc_get_map_lock(gmap->mm, pmdp, gaddr, &ptl);
 	if (!ptep)
 		return -ENOMEM;
 
@@ -2473,7 +2473,7 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 			bitmap_fill(bitmap, _PAGE_ENTRIES);
 	} else {
 		for (i = 0; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
-			ptep = pte_alloc_map_lock(gmap->mm, pmdp, vmaddr, &ptl);
+			ptep = pte_alloc_get_map_lock(gmap->mm, pmdp, vmaddr, &ptl);
 			if (!ptep)
 				continue;
 			if (ptep_test_and_clear_uc(gmap->mm, vmaddr, ptep))
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index eec3a9d7176e..82217a753751 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -801,7 +801,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_alloc_get_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
@@ -900,7 +900,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_alloc_get_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
@@ -956,7 +956,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_alloc_get_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 999ab5916e69..ea7fa277952b 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -38,7 +38,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (pud) {
 				pmd = pmd_alloc(mm, pud, addr);
 				if (pmd)
-					pte = pte_alloc_map(mm, pmd, addr);
+					pte = pte_alloc_get_map(mm, pmd, addr);
 			}
 		}
 	}
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 0f49fada2093..599c04b54205 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -297,7 +297,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 	if (sz >= PMD_SIZE)
 		return (pte_t *)pmd;
-	return pte_alloc_map(mm, pmd, addr);
+	return pte_alloc_get_map(mm, pmd, addr);
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..f2210bf3d357 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -131,7 +131,7 @@ static int map_tboot_page(unsigned long vaddr, unsigned long pfn,
 	pmd = pmd_alloc(&tboot_mm, pud, vaddr);
 	if (!pmd)
 		return -1;
-	pte = pte_alloc_map(&tboot_mm, pmd, vaddr);
+	pte = pte_alloc_get_map(&tboot_mm, pmd, vaddr);
 	if (!pte)
 		return -1;
 	set_pte_at(&tboot_mm, vaddr, pte, pfn_pte(pfn, prot));
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..b3cf4b8a91d6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -574,6 +574,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -582,7 +583,8 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
+	    !pte_try_get(vma->vm_mm, pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
@@ -593,6 +595,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 out:
 	cond_resched();
 	return 0;
@@ -1121,6 +1124,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -1143,7 +1147,8 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
+	    !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -1168,6 +1173,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ClearPageReferenced(page);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 	return 0;
 }
@@ -1407,6 +1413,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
@@ -1471,10 +1478,13 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		return err;
 	}
 
-	if (pmd_trans_unstable(pmdp))
+	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmdp))
 		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+	if (!pte_try_get(walk->mm, pmdp))
+		return 0;
+
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
 	 * goes beyond vma->vm_end.
@@ -1489,6 +1499,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			break;
 	}
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmdp, start);
 
 	cond_resched();
 
@@ -1795,6 +1806,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte;
 	pte_t *pte;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -1809,9 +1821,11 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (!pte_try_get(walk->mm, pmd))
+		return 0;
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
@@ -1821,6 +1835,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 	return 0;
 }
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f6e0f0c0d0e5..4fc6c3bafd70 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,6 +28,7 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
+#include <linux/pte_ref.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -508,6 +509,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
 						       vmf->address,
 						       vmf->flags, reason);
+	pte_put_vmf(vmf);
 	mmap_read_unlock(mm);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5efd63a20d72..befe823b4918 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -447,6 +447,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PTE_GET: Indicates that pte has been get.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -478,6 +479,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_PTE_GET =		1 << 10,
 };
 
 /*
@@ -2148,7 +2150,6 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
@@ -2274,15 +2275,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	pte_unmap(pte);					\
 } while (0)
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
-
-#define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
-
-#define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	(pte_alloc(mm, pmd) ?			\
-		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
-
 #define pte_alloc_kernel(pmd, address)			\
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
@@ -2374,7 +2366,6 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
-extern void pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f37abb2d222e..eed4a5db59ea 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -153,11 +153,17 @@ struct page {
 		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			union {
+				pgtable_t pmd_huge_pte; /* protected by page->ptl */
+				pmd_t *pmd;             /* PTE page only */
+			};
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+#ifdef CONFIG_FREE_USER_PTE
+				atomic_t pte_refcount;  /* PTE page only */
+#endif
 			};
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d147480cdefc..172bb63b7ed9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -331,7 +331,6 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 }
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
@@ -342,6 +341,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return pmd;
 }
 #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
new file mode 100644
index 000000000000..695fbe8b991b
--- /dev/null
+++ b/include/linux/pte_ref.h
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free user PTE page table pages
+ *
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+#ifndef _LINUX_PTE_REF_H
+#define _LINUX_PTE_REF_H
+
+#include <linux/mm.h>
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd);
+int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd);
+
+#ifdef CONFIG_FREE_USER_PTE
+void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
+
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
+	pte->pmd = pmd;
+	atomic_set(&pte->pte_refcount, count);
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return virt_to_page(pte)->pmd;
+}
+
+static inline void pte_migrate_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+	pmd_pgtable(old_pmd)->pmd = new_pmd;
+}
+
+/*
+ * Get the reference to the PTE page table to prevent it from being
+ * release.
+ *
+ * The caller should already hold a reference to PTE page table by
+ * calling pte_try_get(), and then this function is safe to use under
+ * mmap_lock or anon_lock or i_mmap_lock or when parallel threads are
+ * excluded by other means which can make @pmdp entry stable.
+ */
+static inline void pte_get_many(pmd_t *pmdp, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
+
+	VM_BUG_ON(pte->pmd != pmdp);
+	atomic_add(nr, &pte->pte_refcount);
+}
+
+static inline void pte_get(pmd_t *pmdp)
+{
+	pte_get_many(pmdp, 1);
+}
+
+static inline bool pte_get_unless_zero(pmd_t *pmdp)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
+
+	VM_BUG_ON(!PageTable(pte));
+	return atomic_inc_not_zero(&pte->pte_refcount);
+}
+
+/*
+ * Try to get a reference to the PTE page table to prevent it from
+ * being release.
+ *
+ * This function is safe to use under mmap_lock or anon_lock or
+ * i_mmap_lock or when parallel threads are excluded by other means
+ * which can make @pmdp entry stable.
+ */
+static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	bool retval = true;
+	spinlock_t *ptl;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (pmd_leaf(*pmdp) || !pmd_present(*pmdp) ||
+	    !pte_get_unless_zero(pmdp))
+		retval = false;
+	spin_unlock(ptl);
+
+	return retval;
+}
+
+/*
+ * Put the reference to the PTE page table, and then the PTE page
+ * will be released when the reference is decreased to 0.
+ *
+ * This function is safe to use under mmap_lock or anon_lock or
+ * i_mmap_lock or when parallel threads are excluded by other means
+ * which can make @pmdp entry stable.
+ */
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
+				unsigned long addr, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
+
+	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(pmd_devmap_trans_unstable(pmdp));
+	VM_BUG_ON(pte->pmd != pmdp);
+	if (atomic_sub_and_test(nr, &pte->pte_refcount))
+		free_pte_table(mm, pmdp, addr & PMD_MASK);
+}
+
+static inline void pte_put(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+	pte_put_many(mm, pmdp, addr, 1);
+}
+
+/*
+ * The mmap_lock maybe unlocked in advance in some cases in
+ * handle_pte_fault(), so we should ensure the pte_put() is performed
+ * in the critical section of the mmap_lock.
+ */
+static inline void pte_put_vmf(struct vm_fault *vmf)
+{
+	if (!(vmf->flags & FAULT_FLAG_PTE_GET))
+		return;
+	vmf->flags &= ~FAULT_FLAG_PTE_GET;
+
+	pte_put(vmf->vma->vm_mm, vmf->pmd, vmf->address);
+}
+
+static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (!pte_try_get(mm, pmdp))
+		return __pte_alloc_try_get(mm, pmdp);
+	return 1;
+}
+
+static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	spinlock_t *ptl;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (pmd_none(*pmdp) || !pte_get_unless_zero(pmdp)) {
+		spin_unlock(ptl);
+		return __pte_alloc_get(mm, pmdp);
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return NULL;
+}
+
+static inline void pte_migrate_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+}
+
+static inline void pte_get_many(pmd_t *pmdp, unsigned int nr)
+{
+}
+
+static inline void pte_get(pmd_t *pmdp)
+{
+}
+
+static inline bool pte_get_unless_zero(pmd_t *pmdp)
+{
+	return true;
+}
+
+static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	return true;
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
+				unsigned long addr, unsigned int value)
+{
+}
+
+static inline void pte_put(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+}
+
+static inline void pte_put_vmf(struct vm_fault *vmf)
+{
+}
+
+static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (unlikely(pmd_none(*pmdp)))
+		return __pte_alloc_try_get(mm, pmdp);
+	if (unlikely(pmd_devmap_trans_unstable(pmdp)))
+		return 0;
+	return 1;
+}
+
+static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (unlikely(pmd_none(*pmdp)))
+		return __pte_alloc_get(mm, pmdp);
+	return 0;
+}
+#endif /* CONFIG_FREE_USER_PTE */
+
+#define pte_alloc_get_map(mm, pmd, address)		\
+	(pte_alloc_get(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+
+#define pte_alloc_get_map_lock(mm, pmd, address, ptlp)	\
+	(pte_alloc_get(mm, pmd) ?			\
+		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
+#endif
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 83fb86133fe1..886411eccb55 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -11,6 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/memcontrol.h>
 #include <linux/highmem.h>
+#include <linux/pte_ref.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -220,6 +221,8 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	if (pvmw->pte && !PageHuge(pvmw->page))
+		pte_put(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbe..2791190e1a01 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -205,6 +205,9 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
 
+	if (!new_page)
+		pte_put(mm, pte_to_pmd(pvmw.pte), addr);
+
 	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
 		munlock_vma_page(old_page);
 	put_page(old_page);
diff --git a/mm/Kconfig b/mm/Kconfig
index 5dc28e9205e0..745f6cdc5e9b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -889,4 +889,8 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config FREE_USER_PTE
+	def_bool y
+	depends on X86_64
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index e3436741d539..1ab513342d54 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -38,7 +38,8 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
+			   pgtable-generic.o rmap.o vmalloc.o ioremap.o \
+			   pte_ref.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1c922691aa61..8cae3b3329dc 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <linux/pte_ref.h>
 
 /*
  * Please refer Documentation/vm/arch_pgtable_helpers.rst for the semantics
@@ -1018,7 +1019,7 @@ static int __init debug_vm_pgtable(void)
 	/*
 	 * Allocate pgtable_t
 	 */
-	if (pte_alloc(mm, pmdp)) {
+	if (pte_alloc_try_get(mm, pmdp) < 0) {
 		pr_err("pgtable allocation failed\n");
 		return 1;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index db0184884890..024ca645c3a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1699,6 +1699,7 @@ int __lock_page_or_retry(struct page *page, struct vm_fault *vmf)
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			return 0;
 
+		pte_put_vmf(vmf);
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			wait_on_page_locked_killable(page);
@@ -1711,6 +1712,7 @@ int __lock_page_or_retry(struct page *page, struct vm_fault *vmf)
 
 		ret = __lock_page_killable(page);
 		if (ret) {
+			pte_put_vmf(vmf);
 			mmap_read_unlock(mm);
 			return 0;
 		}
@@ -3160,32 +3162,30 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	struct mm_struct *mm = vmf->vma->vm_mm;
 
 	/* Huge page is mapped? No need to proceed. */
-	if (pmd_trans_huge(*vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
-	}
+	if (pmd_trans_huge(*vmf->pmd))
+		goto out;
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
-	if (pmd_none(*vmf->pmd))
-		pte_install(mm, vmf->pmd, &vmf->prealloc_pte);
-
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
+	if (IS_ENABLED(CONFIG_FREE_USER_PTE) || pmd_none(*vmf->pmd)) {
+		if (!pte_install_try_get(mm, vmf->pmd, &vmf->prealloc_pte))
+			goto out;
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) { /* See comment in handle_pte_fault() */
+		goto out;
 	}
 
 	return false;
+out:
+	unlock_page(page);
+	put_page(page);
+	return true;
 }
 
 static struct page *next_uptodate_page(struct page *page,
@@ -3259,6 +3259,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	unsigned int nr_get = 0;
 
 	rcu_read_lock();
 	head = first_map_page(mapping, &xas, end_pgoff);
@@ -3267,7 +3268,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 	if (filemap_map_pmd(vmf, head)) {
 		ret = VM_FAULT_NOPAGE;
-		goto out;
+		goto put;
 	}
 
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
@@ -3292,6 +3293,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			ret = VM_FAULT_NOPAGE;
 
 		do_set_pte(vmf, page, addr);
+		nr_get++;
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, addr, vmf->pte);
 		unlock_page(head);
@@ -3301,6 +3303,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		put_page(head);
 	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_get_many(vmf->pmd, nr_get);
+put:
+	pte_put(vma->vm_mm, vmf->pmd, addr);
 out:
 	rcu_read_unlock();
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
diff --git a/mm/gup.c b/mm/gup.c
index 42b8b1fa6521..3e2a153cb18e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -498,10 +498,14 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
+
 retry:
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
+	if (!pte_try_get(mm, pmd))
+		return no_page_table(vma, flags);
+
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
 	if (!pte_present(pte)) {
@@ -519,6 +523,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		if (!is_migration_entry(entry))
 			goto no_page;
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		migration_entry_wait(mm, pmd, address);
 		goto retry;
 	}
@@ -526,6 +531,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto no_page;
 	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		return NULL;
 	}
 
@@ -614,9 +620,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 out:
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmd, address);
 	return page;
 no_page:
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmd, address);
 	if (!pte_none(pte))
 		return NULL;
 	return no_page_table(vma, flags);
@@ -713,7 +721,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		} else {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmd, address);
-			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
+			ret = pte_alloc_get(mm, pmd) ? -ENOMEM : 0;
 		}
 
 		return ret ? ERR_PTR(ret) :
diff --git a/mm/hmm.c b/mm/hmm.c
index fad6be2bf072..29bb379510cc 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -380,6 +380,9 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
+	if (!pte_try_get(walk->mm, pmdp))
+		goto again;
+
 	ptep = pte_offset_map(pmdp, addr);
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
 		int r;
@@ -391,6 +394,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		}
 	}
 	pte_unmap(ptep - 1);
+	pte_put(walk->mm, pmdp, start);
 	return 0;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 31ff935b2547..642a7e0af740 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/pte_ref.h>
 
 /*
  * The set of flags that only affect watermark checking and reclaim
@@ -441,6 +442,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	if (fault_flag_allow_retry_first(flags) &&
 	    !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
 		fpin = get_file(vmf->vma->vm_file);
+		pte_put_vmf(vmf);
 		mmap_read_unlock(vmf->vma->vm_mm);
 	}
 	return fpin;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..e6c4d1b7a12a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -741,6 +741,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 {
 	struct page *src_page, *tmp;
 	pte_t *_pte;
+
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 				_pte++, page++, address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
@@ -1239,6 +1240,10 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		goto out;
 	}
 
+	if (!pte_try_get(mm, pmd)) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
@@ -1361,6 +1366,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pmd, address);
 	if (ret) {
 		node = khugepaged_find_target_node();
 		/* collapse_huge_page will return with the mmap_lock released */
@@ -1463,6 +1469,8 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		goto drop_hpage;
 
+	if (!pte_try_get(mm, pmd))
+		goto drop_hpage;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 
 	/* step 1: check all mapped PTEs are to the right huge page */
@@ -1501,6 +1509,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
@@ -1522,6 +1531,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 	goto drop_hpage;
 }
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..2e106f58dad0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1133,6 +1133,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
+	if (!pte_try_get(mm, pmd))
+		goto out;
+
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1182,6 +1185,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	err = 0;
 out_mn:
 	mmu_notifier_invalidate_range_end(&range);
+	pte_put(mm, pmd, addr);
 out:
 	return err;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 012129fbfaf8..4c4b35292212 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -191,7 +191,9 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 
-	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+	    pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
+	    !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -215,6 +217,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		if (page)
 			put_page(page);
 	}
+	pte_put(vma->vm_mm, pmd, start);
 
 	return 0;
 }
@@ -318,6 +321,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct page *page = NULL;
 	LIST_HEAD(page_list);
+	unsigned long start = addr;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -389,9 +393,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 regular_page:
-	if (pmd_trans_unstable(pmd))
+	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (!pte_try_get(vma->vm_mm, pmd))
+		return 0;
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -471,6 +477,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -580,14 +587,18 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	int nr_swap = 0;
 	unsigned long next;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+	     pmd_trans_unstable(pmd)) || !pte_try_get(mm, pmd))
 		return 0;
+	nr_put++;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -612,6 +623,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			nr_swap--;
 			free_swap_and_cache(entry);
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			continue;
 		}
 
@@ -696,6 +708,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..4f19e5f2cd18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5819,6 +5819,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -5833,13 +5834,15 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
+	    !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	return 0;
@@ -6019,6 +6022,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -6051,9 +6055,11 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 retry:
+	if (!pte_try_get(vma->vm_mm, pmd))
+		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
@@ -6104,6 +6110,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	if (addr != end) {
diff --git a/mm/memory.c b/mm/memory.c
index 3bf2636413ee..242ed135bde4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -219,6 +219,17 @@ static void check_sync_rss_stat(struct task_struct *task)
 
 #endif /* SPLIT_RSS_COUNTING */
 
+#ifdef CONFIG_FREE_USER_PTE
+static inline void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				  unsigned long addr)
+{
+	/*
+	 * We should never reach here since the PTE page tables are
+	 * dynamically freed.
+	 */
+	BUG();
+}
+#else
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
@@ -231,6 +242,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 	pte_free_tlb(tlb, token, addr);
 	mm_dec_nr_ptes(tlb->mm);
 }
+#endif /* CONFIG_FREE_USER_PTE */
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
@@ -433,44 +445,6 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
-void pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
-{
-	spinlock_t *ptl = pmd_lock(mm, pmd);
-
-	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		mm_inc_nr_ptes(mm);
-		/*
-		 * Ensure all pte setup (eg. pte page lock and page clearing) are
-		 * visible before the pte is made visible to other CPUs by being
-		 * put into page tables.
-		 *
-		 * The other side of the story is the pointer chasing in the page
-		 * table walking code (when walking the page table without locking;
-		 * ie. most of the time). Fortunately, these data accesses consist
-		 * of a chain of data-dependent loads, meaning most CPUs (alpha
-		 * being the notable exception) will already guarantee loads are
-		 * seen in-order. See the alpha page table accessors for the
-		 * smp_rmb() barriers in page table walking code.
-		 */
-		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, *pte);
-		*pte = NULL;
-	}
-	spin_unlock(ptl);
-}
-
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
-{
-	pgtable_t new = pte_alloc_one(mm);
-	if (!new)
-		return -ENOMEM;
-
-	pte_install(mm, pmd, &new);
-	if (new)
-		pte_free(mm, new);
-	return 0;
-}
-
 int __pte_alloc_kernel(pmd_t *pmd)
 {
 	pte_t *new = pte_alloc_one_kernel(&init_mm);
@@ -479,7 +453,7 @@ int __pte_alloc_kernel(pmd_t *pmd)
 
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		smp_wmb(); /* See comment in pte_install() */
+		smp_wmb(); /* See comment in __pte_install() */
 		pmd_populate_kernel(&init_mm, pmd, new);
 		new = NULL;
 	}
@@ -860,6 +834,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_swp_clear_uffd_wp(pte);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -928,6 +903,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		/* Uffd-wp needs to be delivered to dest pte as well */
 		pte = pte_wrprotect(pte_mkuffd_wp(pte));
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -980,6 +956,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_clear_uffd_wp(pte);
 
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -1021,7 +998,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	progress = 0;
 	init_rss_vec(rss);
 
-	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
+	dst_pte = pte_alloc_get_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
 		ret = -ENOMEM;
 		goto out;
@@ -1109,8 +1086,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		goto out;
 	} else if (ret ==  -EAGAIN) {
 		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
-		if (!prealloc)
-			return -ENOMEM;
+		if (!prealloc) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	} else if (ret) {
 		VM_WARN_ON_ONCE(1);
 	}
@@ -1118,11 +1097,14 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	/* We've captured and resolved the error. Reset, try again. */
 	ret = 0;
 
-	if (addr != end)
+	if (addr != end) {
+		pte_put(dst_mm, dst_pmd, addr);
 		goto again;
+	}
 out:
 	if (unlikely(prealloc))
 		put_page(prealloc);
+	pte_put(dst_mm, dst_pmd, addr);
 	return ret;
 }
 
@@ -1141,9 +1123,13 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		return -ENOMEM;
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
+		pmd_t pmdval;
+
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+retry:
+		pmdval = READ_ONCE(*src_pmd);
+		if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval)
+			|| pmd_devmap(pmdval)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1156,9 +1142,15 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
+
+		if (!pte_try_get(src_mm, src_pmd))
+			goto retry;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-				   addr, next))
+				   addr, next)) {
+			pte_put(src_mm, src_pmd, addr);
 			return -ENOMEM;
+		}
+		pte_put(src_mm, src_pmd, addr);
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1316,6 +1308,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1348,6 +1342,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			nr_put++;
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
@@ -1390,6 +1385,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			rss[mm_counter(page)]--;
 
 			if (is_device_private_entry(entry))
@@ -1414,6 +1410,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		nr_put++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1440,6 +1437,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
+
 	return addr;
 }
 
@@ -1479,9 +1479,13 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 * because MADV_DONTNEED holds the mmap_lock in read
 		 * mode.
 		 */
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+		if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+		     pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
+		     !pte_try_get(tlb->mm, pmd))
 			goto next;
+
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
+		pte_put(tlb->mm, pmd, addr);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -1736,7 +1740,7 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 	if (!pmd)
 		return NULL;
-	return pte_alloc_map_lock(mm, pmd, addr, ptl);
+	return pte_alloc_get_map_lock(mm, pmd, addr, ptl);
 }
 
 static int validate_page_before_insert(struct page *page)
@@ -1757,6 +1761,7 @@ static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
 	inc_mm_counter_fast(mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_get(pte_to_pmd(pte));
 	return 0;
 }
 
@@ -1784,6 +1789,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 		goto out;
 	retval = insert_page_into_pte_locked(mm, pte, addr, page, prot);
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 out:
 	return retval;
 }
@@ -1827,7 +1833,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	/* Allocate the PTE if necessary; takes PMD lock once only. */
 	ret = -ENOMEM;
-	if (pte_alloc(mm, pmd))
+	if (pte_alloc_try_get(mm, pmd) < 0)
 		goto out;
 
 	while (pages_to_write_in_pmd) {
@@ -1854,6 +1860,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	if (remaining_pages_total)
 		goto more;
 	ret = 0;
+	pte_put(mm, pmd, addr);
 out:
 	*num = remaining_pages_total;
 	return ret;
@@ -2077,10 +2084,12 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	set_pte_at(mm, addr, pte, entry);
+	pte_get(pte_to_pmd(pte));
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
 out_unlock:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 	return VM_FAULT_NOPAGE;
 }
 
@@ -2284,8 +2293,10 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
+	unsigned int nr_get = 0;
+	unsigned long start_addr = addr;
 
-	mapped_pte = pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_alloc_get_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 	arch_enter_lazy_mmu_mode();
@@ -2296,10 +2307,13 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			break;
 		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
+		nr_get++;
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_get_many(pmd, nr_get);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(mm, pmd, start_addr);
 	return err;
 }
 
@@ -2512,13 +2526,17 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte, *mapped_pte;
 	int err = 0;
 	spinlock_t *ptl;
+	unsigned int nr_put = 0;
+	unsigned int nr_get = 0;
+	unsigned long start = addr;
 
 	if (create) {
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_alloc_kernel_track(pmd, addr, mask) :
-			pte_alloc_map_lock(mm, pmd, addr, &ptl);
+			pte_alloc_get_map_lock(mm, pmd, addr, &ptl);
 		if (!pte)
 			return -ENOMEM;
+		nr_put++;
 	} else {
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_offset_kernel(pmd, addr) :
@@ -2531,19 +2549,32 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	if (fn) {
 		do {
-			if (create || !pte_none(*pte)) {
+			if (create) {
 				err = fn(pte++, addr, data);
-				if (err)
-					break;
+				if (IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+					mm != &init_mm && !pte_none(*(pte-1)))
+					nr_get++;
+			} else if (!pte_none(*pte)) {
+				err = fn(pte++, addr, data);
+				if (IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+					mm != &init_mm && pte_none(*(pte-1)))
+					nr_put++;
 			}
+			if (err)
+				break;
 		} while (addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
 	arch_leave_lazy_mmu_mode();
 
-	if (mm != &init_mm)
+	if (mm != &init_mm) {
 		pte_unmap_unlock(mapped_pte, ptl);
+		pte_get_many(pmd, nr_get);
+		if (nr_put)
+			pte_put_many(mm, pmd, start, nr_put);
+	}
+
 	return err;
 }
 
@@ -2567,6 +2598,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	}
 	do {
 		next = pmd_addr_end(addr, end);
+retry:
 		if (pmd_none(*pmd) && !create)
 			continue;
 		if (WARN_ON_ONCE(pmd_leaf(*pmd)))
@@ -2576,8 +2608,12 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 				continue;
 			pmd_clear_bad(pmd);
 		}
+		if (!create && !pte_try_get(mm, pmd))
+			goto retry;
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
+		if (!create)
+			pte_put(mm, pmd, addr);
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
@@ -3726,21 +3762,19 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_try_get() instead of pte_alloc_get_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
+	 * pte_alloc_get_map() is safe to use under mmap_write_lock(mm) or when
 	 * parallel threads are excluded by other means.
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
-		return VM_FAULT_OOM;
-
-	/* See comment in handle_pte_fault() */
-	if (unlikely(pmd_trans_unstable(vmf->pmd)))
-		return 0;
+	ret = pte_alloc_try_get(vma->vm_mm, vmf->pmd);
+	if (ret <= 0)
+		return ret < 0 ? VM_FAULT_OOM : 0;
+	ret = 0;
 
 	/* Use the zero-page for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
@@ -3759,7 +3793,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		/* Deliver the page fault to userland, check inside PT lock */
 		if (userfaultfd_missing(vma)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
+			ret = handle_userfault(vmf, VM_UFFD_MISSING);
+			goto put;
 		}
 		goto setpte;
 	}
@@ -3802,7 +3837,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		put_page(page);
-		return handle_userfault(vmf, VM_UFFD_MISSING);
+		ret = handle_userfault(vmf, VM_UFFD_MISSING);
+		goto put;
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3810,19 +3846,23 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	pte_get(vmf->pmd);
 
 	/* No need to invalidate - it was non-present before */
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
@@ -3850,7 +3890,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				unlock_page(B)
 	 *				# flush A, B to clear the writeback
 	 */
-	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
+	if (!vmf->prealloc_pte) {
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
@@ -4020,6 +4060,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+retry:
 	if (pmd_none(*vmf->pmd)) {
 		if (PageTransCompound(page)) {
 			ret = do_set_pmd(vmf, page);
@@ -4027,27 +4068,33 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pte_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
-	}
-
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
+		if (vmf->prealloc_pte) {
+			if (!pte_install_try_get(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte))
+				return 0;
+		} else {
+			ret = pte_alloc_try_get(vma->vm_mm, vmf->pmd);
+			if (ret <= 0)
+				return ret < 0 ? VM_FAULT_OOM : 0;
+		}
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) { /* See comment in handle_pte_fault() */
 		return 0;
+	} else if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+		goto retry;
+	}
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_none(*vmf->pte))) {
 		do_set_pte(vmf, page, vmf->address);
-	else
+		pte_get(vmf->pmd);
+	} else
 		ret = VM_FAULT_NOPAGE;
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_put(vma->vm_mm, vmf->pmd, vmf->address);
 	return ret;
 }
 
@@ -4268,9 +4315,14 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		 * If we find a migration pmd entry or a none pmd entry, which
 		 * should never happen, return SIGBUS
 		 */
-		if (unlikely(!pmd_present(*vmf->pmd)))
+		if (unlikely(!pmd_present(*vmf->pmd))) {
 			ret = VM_FAULT_SIGBUS;
-		else {
+			goto out;
+		} else {
+			if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+				ret = VM_FAULT_SIGBUS;
+				goto out;
+			}
 			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
 						       vmf->pmd,
 						       vmf->address,
@@ -4288,6 +4340,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 				ret = VM_FAULT_NOPAGE;
 
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			pte_put(vma->vm_mm, vmf->pmd, vmf->address);
 		}
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
@@ -4301,6 +4354,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		pte_free(vm_mm, vmf->prealloc_pte);
 		vmf->prealloc_pte = NULL;
 	}
+out:
 	return ret;
 }
 
@@ -4496,11 +4550,13 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
+	vm_fault_t ret;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
+retry:
+	if (unlikely(pmd_none(READ_ONCE(*vmf->pmd)))) {
 		/*
-		 * Leave __pte_alloc() until later: because vm_ops->fault may
-		 * want to allocate huge page, and if we expose page table
+		 * Leave __pte_alloc_try_get() until later: because vm_ops->fault
+		 * may want to allocate huge page, and if we expose page table
 		 * for an instant, it will be difficult to retract from
 		 * concurrent faults and from rmap lookups.
 		 */
@@ -4517,9 +4573,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * that it is a regular pmd that we can walk with
 		 * pte_offset_map() and we can do that through an atomic read
 		 * in C, which is what pmd_trans_unstable() provides.
+		 *
+		 * Note: we do this in pte_try_get() when CONFIG_FREE_USER_PTE
 		 */
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
+
+		if (!pte_try_get(vmf->vma->vm_mm, vmf->pmd))
+			goto retry;
+
+		if (IS_ENABLED(CONFIG_FREE_USER_PTE))
+			vmf->flags |= FAULT_FLAG_PTE_GET;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd from under us anymore at this point because we hold the
@@ -4541,6 +4606,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		if (pte_none(vmf->orig_pte)) {
 			pte_unmap(vmf->pte);
 			vmf->pte = NULL;
+			pte_put_vmf(vmf);
 		}
 	}
 
@@ -4551,11 +4617,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+	if (!pte_present(vmf->orig_pte)) {
+		ret = do_swap_page(vmf);
+		goto put;
+	}
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
-		return do_numa_page(vmf);
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		ret = do_numa_page(vmf);
+		goto put;
+	}
 
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
@@ -4565,8 +4635,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		goto unlock;
 	}
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		if (!pte_write(entry))
-			return do_wp_page(vmf);
+		if (!pte_write(entry)) {
+			ret = do_wp_page(vmf);
+			goto put;
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -4588,7 +4660,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return 0;
+	ret = 0;
+put:
+	pte_put_vmf(vmf);
+	return ret;
 }
 
 /*
@@ -4816,7 +4891,7 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	if (pgd_present(*pgd))		/* Another has populated it */
 		p4d_free(mm, new);
 	else {
-		smp_wmb(); /* See comment in pte_install() */
+		smp_wmb(); /* See comment in __pte_install() */
 		pgd_populate(mm, pgd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -4838,7 +4913,7 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 	spin_lock(&mm->page_table_lock);
 	if (!p4d_present(*p4d)) {
 		mm_inc_nr_puds(mm);
-		smp_wmb(); /* See comment in pte_install() */
+		smp_wmb(); /* See comment in __pte_install() */
 		p4d_populate(mm, p4d, new);
 	} else	/* Another has populated it */
 		pud_free(mm, new);
@@ -4862,7 +4937,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	ptl = pud_lock(mm, pud);
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
-		smp_wmb(); /* See comment in pte_install() */
+		smp_wmb(); /* See comment in __pte_install() */
 		pud_populate(mm, pud, new);
 	} else	/* Another has populated it */
 		pmd_free(mm, new);
@@ -4925,13 +5000,22 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 					(address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
+	if (!pte_try_get(mm, pmd))
+		goto out;
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
 	if (!pte_present(*ptep))
 		goto unlock;
+	/*
+	 * when we reach here, it means that the ->pte_refcount is at least
+	 * one and the contents of the PTE page table are stable until @ptlp is
+	 * released, so we can put pte safely.
+	 */
+	pte_put(mm, pmd, address);
 	*ptepp = ptep;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
+	pte_put(mm, pmd, address);
 	if (range)
 		mmu_notifier_invalidate_range_end(range);
 out:
@@ -5058,6 +5142,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 		return -EINVAL;
 	pte = *ptep;
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(vma->vm_mm, pte_to_pmd(ptep), addr);
 
 	prot = pgprot_val(pte_pgprot(pte));
 	phys_addr = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..cbb3640717ff 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -509,6 +509,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -518,7 +519,8 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	/* THP was split, fall through to pte walk */
 
-	if (pmd_trans_unstable(pmd))
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
+	    !pte_try_get(walk->mm, pmd))
 		return 0;
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
@@ -554,6 +556,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 
 	if (has_unmovable)
diff --git a/mm/migrate.c b/mm/migrate.c
index 23cbd9de030b..6a94e8558b2c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2265,6 +2265,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
+	if (!pte_try_get(mm, pmdp))
+		goto again;
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	arch_enter_lazy_mmu_mode();
 
@@ -2386,6 +2388,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(mm, pmdp, start);
 
 	/* Only flush the TLB if we actually modified any entries */
 	if (unmapped)
@@ -2793,26 +2796,22 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 
 	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_try_get() instead of pte_alloc_get_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
+	 * pte_alloc_get_map() is safe to use under mmap_write_lock(mm) or when
 	 * parallel threads are excluded by other means.
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc(mm, pmdp))
-		goto abort;
-
-	/* See the comment in pte_alloc_one_map() */
-	if (unlikely(pmd_trans_unstable(pmdp)))
+	if (pte_alloc_try_get(mm, pmdp) <= 0)
 		goto abort;
 
 	if (unlikely(anon_vma_prepare(vma)))
-		goto abort;
+		goto put;
 	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
-		goto abort;
+		goto put;
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
@@ -2881,15 +2880,19 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	} else {
 		/* No need to invalidate - it was non-present before */
 		set_pte_at(mm, addr, ptep, entry);
+		pte_get(pmdp);
 		update_mmu_cache(vma, addr, ptep);
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
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..e21e271a7657 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -18,6 +18,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/pte_ref.h>
 
 #include <linux/uaccess.h>
 
@@ -104,6 +105,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *ptep;
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -112,7 +114,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd)) {
+	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
+	    !pte_try_get(walk->mm, pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
@@ -148,6 +151,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		vec++;
 	}
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(walk->mm, pmd, start);
 out:
 	walk->private += nr;
 	cond_resched();
diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..ead14abb016a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -397,6 +397,7 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 			break;
 	}
 	pte_unmap_unlock(pte, ptl);
+	pte_put(vma->vm_mm, pte_to_pmd(pte), start);
 	return start;
 }
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4cb240fd9936..9cbd0848c5c5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -274,9 +274,12 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	pmd = pmd_offset(pud, addr);
 	do {
 		unsigned long this_pages;
+		pmd_t pmdval;
 
 		next = pmd_addr_end(addr, end);
 
+retry:
+		pmdval = READ_ONCE(*pmd);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -285,7 +288,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * Hence, it's necessary to atomically read the PMD value
 		 * for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		if (!is_swap_pmd(pmdval) && !pmd_devmap(pmdval) &&
 		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
 			goto next;
 
@@ -297,7 +300,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
@@ -316,8 +319,11 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
+		if (!pte_try_get(vma->vm_mm, pmd))
+			goto retry;
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
 					      cp_flags);
+		pte_put(vma->vm_mm, pmd, addr);
 		pages += this_pages;
 next:
 		cond_resched();
diff --git a/mm/mremap.c b/mm/mremap.c
index 5989d3990020..776c6ea7bd06 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -141,6 +141,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	unsigned long old_start = old_addr;
+	unsigned int nr_put = 0;
+	unsigned int nr_get = 0;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -181,6 +184,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 			continue;
 
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
+		nr_put++;
 		/*
 		 * If we are remapping a valid PTE, make sure
 		 * to flush TLB before we drop the PTL for the
@@ -197,7 +201,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
+		nr_get++;
 	}
+	pte_get_many(new_pmd, nr_get);
 
 	arch_leave_lazy_mmu_mode();
 	if (force_flush)
@@ -206,6 +212,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
+	if (nr_put)
+		pte_put_many(mm, old_pmd, old_start, nr_put);
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
 }
@@ -271,6 +279,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
+	pte_migrate_pmd(pmd, new_pmd);
 	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -548,10 +557,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				continue;
 		}
 
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc_get(new_vma->vm_mm, new_pmd))
 			break;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
+		pte_put(new_vma->vm_mm, new_pmd, new_addr);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..eb84fa5825c0 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -211,6 +211,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		}
 
 		pvmw->pmd = pmd_offset(pud, pvmw->address);
+retry:
 		/*
 		 * Make sure the pmd value isn't cached in a register by the
 		 * compiler and used as a stale value after we've observed a
@@ -258,6 +259,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+		if (!pte_try_get(pvmw->vma->vm_mm, pvmw->pmd))
+			goto retry;
 		if (!map_pte(pvmw))
 			goto next_pte;
 this_pte:
@@ -275,6 +278,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					pvmw->ptl = NULL;
 				}
 				pte_unmap(pvmw->pte);
+				pte_put(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
 				pvmw->pte = NULL;
 				goto restart;
 			}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..4080a88d7852 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/pte_ref.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -108,9 +109,9 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-again:
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
+again:
+		if (pmd_none(READ_ONCE(*pmd)) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
@@ -147,10 +148,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				goto again;
 		}
 
-		if (is_hugepd(__hugepd(pmd_val(*pmd))))
+		if (is_hugepd(__hugepd(pmd_val(*pmd)))) {
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
-		else
-			err = walk_pte_range(pmd, addr, next, walk);
+		} else {
+			if (!walk->no_vma) {
+				if (!pte_try_get(walk->mm, pmd))
+					goto again;
+				err = walk_pte_range(pmd, addr, next, walk);
+				pte_put(walk->mm, pmd, addr);
+			} else {
+				err = walk_pte_range(pmd, addr, next, walk);
+			}
+		}
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4e640baf9794..f935779a0967 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
 #include <asm/tlb.h>
+#include <linux/pte_ref.h>
 
 /*
  * If a p?d_bad entry is found while walking page tables, report
@@ -186,6 +187,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 							  struct page, lru);
 	if (pmd_huge_pte(mm, pmdp))
 		list_del(&pgtable->lru);
+	pte_ref_init(pgtable, pmdp, HPAGE_PMD_NR);
 	return pgtable;
 }
 #endif
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
new file mode 100644
index 000000000000..1b8d9828d513
--- /dev/null
+++ b/mm/pte_ref.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free user PTE page table pages
+ *
+ * Copyright (c) 2021, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+
+#include <linux/pte_ref.h>
+#include <linux/hugetlb.h>
+#include <asm/tlbflush.h>
+
+#ifdef CONFIG_DEBUG_VM
+static void pte_free_debug(pmd_t pmd)
+{
+	pte_t *ptep = (pte_t *)pmd_page_vaddr(pmd);
+	int i = 0;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		BUG_ON(!pte_none(*ptep++));
+}
+#else
+static inline void pte_free_debug(pmd_t pmd)
+{
+}
+#endif
+
+void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	ptl = pmd_lock(mm, pmdp);
+	pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
+	spin_unlock(ptl);
+
+	pte_free_debug(pmd);
+	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(pmd));
+}
+
+static inline void __pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	mm_inc_nr_ptes(mm);
+	/*
+	 * Ensure all pte setup (eg. pte page lock and page clearing) are
+	 * visible before the pte is made visible to other CPUs by being
+	 * put into page tables.
+	 *
+	 * The other side of the story is the pointer chasing in the page
+	 * table walking code (when walking the page table without locking;
+	 * ie. most of the time). Fortunately, these data accesses consist
+	 * of a chain of data-dependent loads, meaning most CPUs (alpha
+	 * being the notable exception) will already guarantee loads are
+	 * seen in-order. See the alpha page table accessors for the
+	 * smp_rmb() barriers in page table walking code.
+	 */
+	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
+	pmd_populate(mm, pmd, *pte);
+	pte_ref_init(*pte, pmd, 1);
+	*pte = NULL;
+}
+
+/*
+ * returns true if the pmd has been populated with PTE page table,
+ * or false for all other cases.
+ */
+bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	spinlock_t *ptl;
+	bool retval = true;
+
+retry:
+	ptl = pmd_lock(mm, pmd);
+	if (likely(pmd_none(*pmd))) {
+		__pte_install(mm, pmd, pte);
+	} else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
+		retval = false;
+	} else if (!pte_get_unless_zero(pmd)) {
+		spin_unlock(ptl);
+		goto retry;
+	}
+	spin_unlock(ptl);
+	return retval;
+}
+
+static void pte_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	spinlock_t *ptl;
+
+retry:
+	ptl = pmd_lock(mm, pmd);
+	if (likely(pmd_none(*pmd))) {
+		__pte_install(mm, pmd, pte);
+	} else if (!pte_get_unless_zero(pmd)) {
+		spin_unlock(ptl);
+		goto retry;
+	}
+	spin_unlock(ptl);
+}
+
+/*
+ * returns -ENOMEM if memory allocation failed, or 1 if the pmd
+ * has been populated with PTE page table, or 0 for all other cases.
+ */
+int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd)
+{
+	int retval;
+	pgtable_t new = pte_alloc_one(mm);
+	if (!new)
+		return -ENOMEM;
+
+	retval = pte_install_try_get(mm, pmd, &new);
+	if (new)
+		pte_free(mm, new);
+	return retval;
+}
+
+int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd)
+{
+	pgtable_t new = pte_alloc_one(mm);
+	if (!new)
+		return -ENOMEM;
+
+	pte_install_get(mm, pmd, &new);
+	if (new)
+		pte_free(mm, new);
+	return 0;
+}
diff --git a/mm/rmap.c b/mm/rmap.c
index fed7c4df25f2..8c10dbca02d4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1402,6 +1402,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
+				nr_put++;
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
@@ -1644,7 +1649,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-
+	if (nr_put)
+		pte_put_many(mm, pvmw.pmd, address, nr_put);
 	return ret;
 }
 
@@ -1705,6 +1711,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned int nr_put = 0;
 
 	if (is_zone_device_page(page) && !is_device_private_page(page))
 		return true;
@@ -1871,6 +1878,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
+			nr_put++;
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
@@ -1919,6 +1927,9 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	if (nr_put)
+		pte_put_many(mm, pvmw.pmd, address, nr_put);
+
 	return ret;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c776f2..6153283be500 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -40,6 +40,7 @@
 #include <linux/swap_slots.h>
 #include <linux/sort.h>
 #include <linux/completion.h>
+#include <linux/pte_ref.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -2021,10 +2022,13 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+		if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+		    pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
+		    !pte_try_get(vma->vm_mm, pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
+		pte_put(vma->vm_mm, pmd, addr);
 		if (ret)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0e2132834bc7..7ebf4fb09a85 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -111,6 +111,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
@@ -205,6 +206,7 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
@@ -570,6 +572,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
+		int ret = 1;
 
 		BUG_ON(dst_addr >= dst_start + len);
 
@@ -588,13 +591,14 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			err = -EEXIST;
 			break;
 		}
-		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+
+		if ((IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+		     unlikely((ret = pte_alloc_try_get(dst_mm, dst_pmd)) < 0)) ||
+		    (unlikely(pmd_none(dst_pmdval)) &&
+		     unlikely((ret = __pte_alloc_try_get(dst_mm, dst_pmd)) < 0))) {
 			err = -ENOMEM;
 			break;
-		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		} else if (!ret || unlikely(pmd_trans_huge(*dst_pmd))) {
 			err = -EFAULT;
 			break;
 		}
@@ -604,6 +608,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
+		pte_put(dst_mm, dst_pmd, dst_addr);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.11.0

