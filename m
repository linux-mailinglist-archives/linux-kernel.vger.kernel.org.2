Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E363FD7B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhIAK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhIAK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:28:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995ABC061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:27:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 2so1660574pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZ8ZjLftGn9k8AqH0OBryfg9QUUJnF/UOruALwKib7w=;
        b=GIVnOPXwOgYvf/cYzZIKxArL1cnSVJB3Cy7jBrH2TpzvvLFe9INKvfiZlZNbJ+WupB
         2WSE+2NLgFGNevawQCp1914wB7oeNFWcVRmObV21G4q0XWJU3VOq1wBfqa3nuEdamYPI
         iOTnIoYRZ8OnE4Cpwrd4iB6vwswF8nU6vZLF0vK003CKQuunDHGgVCy4bPBSPX4i/E1N
         yJaA02FcrVBZbqOWxcug1lYpZAXg2WupAr80k5jhS0WNs7h50OXzHTHfAGTzrJiprDrj
         DwONu7cId6FehpsePv9kyoyGEYVFkKPM0A22z+/g3SAnOnimts4dyhXLKal4dqnyyvQ6
         R5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZ8ZjLftGn9k8AqH0OBryfg9QUUJnF/UOruALwKib7w=;
        b=a0LV+10mOOPnGIOYKuQoJj8mmXvWKRReYpfMoFdUslT+rcvra7Jp7fAHmjrCLxQUiO
         Gv91OaV7ItDPRZ3tXlzHDEEirK7Kh76u2LVvBVwM5O2TAojc6Y/AFN9Kn/uEQpSXUcFl
         UJzE6WT1iU2/f3Cx4ap3CBWbMjgec2NDI+bEfgUTP8SgC+Wn4m76FALpDPKRIjUhWECX
         h8gxNwDoKXNGhZ0g2vTW+WFvTqL0modh2xNoKAK8wyYbnRFh/8YGtAu18pWUDxPIeltS
         PdG2hDRuMYx3tfDO9pCBu9yWjbKmb39Bpg58WgftSDXsXTuKNdjqiDLaYL0pALz7RTwE
         K2Hg==
X-Gm-Message-State: AOAM532zezC3J8cQTp02YLqV8M5Yr8K+MBi63V9B6mJnscR9u6UC6Aht
        ZG8uk/+Pi90FNPM7FvHYJ9SVnQ==
X-Google-Smtp-Source: ABdhPJygEKwxLYosNSBeWU4UAqvPqwhRLVOgYqIoyTWkCV+jXIyI9vrfeFOfZuyjn8bmO4iszd2O3A==
X-Received: by 2002:a63:5fd1:: with SMTP id t200mr31300828pgb.428.1630492062102;
        Wed, 01 Sep 2021 03:27:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i10sm5291497pfk.87.2021.09.01.03.27.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:27:41 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, vbabka@suse.cz
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 2/2] mm: remove redundant smp_wmb()
Date:   Wed,  1 Sep 2021 18:27:22 +0800
Message-Id: <20210901102722.47686-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210901102722.47686-1-zhengqi.arch@bytedance.com>
References: <20210901102722.47686-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_wmb() which is in the __pte_alloc() is used to
ensure all ptes setup is visible before the pte is made
visible to other CPUs by being put into page tables. We
only need this when the pte is actually populated, so
move it to pmd_install(). __pte_alloc_kernel(),
__p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
to this case.

We can also defer smp_wmb() to the place where the pmd entry
is really populated by preallocated pte. There are two kinds
of user of preallocated pte, one is filemap & finish_fault(),
another is THP. The former does not need another smp_wmb()
because the smp_wmb() has been done by pmd_install().
Fortunately, the latter also does not need another smp_wmb()
because there is already a smp_wmb() before populating the
new pte when the THP uses a preallocated pte to split a huge
pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c         | 52 +++++++++++++++++++++++-----------------------------
 mm/sparse-vmemmap.c |  2 +-
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ef7b1762e996..658d8df9c70f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -439,6 +439,20 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
 		mm_inc_nr_ptes(mm);
+		/*
+		 * Ensure all pte setup (eg. pte page lock and page clearing) are
+		 * visible before the pte is made visible to other CPUs by being
+		 * put into page tables.
+		 *
+		 * The other side of the story is the pointer chasing in the page
+		 * table walking code (when walking the page table without locking;
+		 * ie. most of the time). Fortunately, these data accesses consist
+		 * of a chain of data-dependent loads, meaning most CPUs (alpha
+		 * being the notable exception) will already guarantee loads are
+		 * seen in-order. See the alpha page table accessors for the
+		 * smp_rmb() barriers in page table walking code.
+		 */
+		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 		pmd_populate(mm, pmd, *pte);
 		*pte = NULL;
 	}
@@ -451,21 +465,6 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 	if (!new)
 		return -ENOMEM;
 
-	/*
-	 * Ensure all pte setup (eg. pte page lock and page clearing) are
-	 * visible before the pte is made visible to other CPUs by being
-	 * put into page tables.
-	 *
-	 * The other side of the story is the pointer chasing in the page
-	 * table walking code (when walking the page table without locking;
-	 * ie. most of the time). Fortunately, these data accesses consist
-	 * of a chain of data-dependent loads, meaning most CPUs (alpha
-	 * being the notable exception) will already guarantee loads are
-	 * seen in-order. See the alpha page table accessors for the
-	 * smp_rmb() barriers in page table walking code.
-	 */
-	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-
 	pmd_install(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
@@ -478,10 +477,9 @@ int __pte_alloc_kernel(pmd_t *pmd)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		smp_wmb(); /* See comment in pmd_install() */
 		pmd_populate_kernel(&init_mm, pmd, new);
 		new = NULL;
 	}
@@ -3857,7 +3855,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	ret = vma->vm_ops->fault(vmf);
@@ -3919,7 +3916,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -4144,7 +4140,6 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
@@ -4819,13 +4814,13 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&mm->page_table_lock);
-	if (pgd_present(*pgd))		/* Another has populated it */
+	if (pgd_present(*pgd)) {	/* Another has populated it */
 		p4d_free(mm, new);
-	else
+	} else {
+		smp_wmb(); /* See comment in pmd_install() */
 		pgd_populate(mm, pgd, new);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
@@ -4842,11 +4837,10 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&mm->page_table_lock);
 	if (!p4d_present(*p4d)) {
 		mm_inc_nr_puds(mm);
+		smp_wmb(); /* See comment in pmd_install() */
 		p4d_populate(mm, p4d, new);
 	} else	/* Another has populated it */
 		pud_free(mm, new);
@@ -4867,14 +4861,14 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	ptl = pud_lock(mm, pud);
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
+		smp_wmb(); /* See comment in pmd_install() */
 		pud_populate(mm, pud, new);
-	} else	/* Another has populated it */
+	} else {	/* Another has populated it */
 		pmd_free(mm, new);
+	}
 	spin_unlock(ptl);
 	return 0;
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bdce883f9286..db6df27c852a 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -76,7 +76,7 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in __pte_alloc(). */
+	/* Make pte visible before pmd. See comment in pmd_install(). */
 	smp_wmb();
 	pmd_populate_kernel(&init_mm, pmd, pgtable);
 
-- 
2.11.0

