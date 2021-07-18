Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6423CC78C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhGREeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhGREeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:34:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7EC061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a6so7859658pgw.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYMnkjS1xZoQBS89qvpm0EOHsV8B6mqDjyXGqzMuxfM=;
        b=jKGqp82dbRaxD9Sj0p5HbotHfQAZ4Ko+3pP0im1kErny7+lT9nz2tJ4ms5o59LO7mi
         sslJD+klXBX5OzAlBSlfq/RouenTHZNAWbImHJc92+MAcCTaBve2Et3w0f/KdGf9LYOT
         La7BQj1JTc4e+Ymd3kV0nRc6Qx6NpIAJqo6zBsEkWC9fqD+DVUAoZiU7Q75j7FAZwMBU
         yYh3ANIOywl0kmKKozUl3559wt1Zc/E/gluTUCuncD9Jg1QVO++YcfN1aIq9sv9d7VYM
         XGdR/bhnZRFIsWMDUmUX0e4CCs9MICV905IifbpmNUnuZdNOor10SS5CDqnsnNcv4DkE
         LjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYMnkjS1xZoQBS89qvpm0EOHsV8B6mqDjyXGqzMuxfM=;
        b=XDLCqX4kGx/WPt+GbzMAk2SdZvnusx0PncyDLxp01w+sn+NK1xleC0KZhlKQndiNJT
         8jpks9lgbPk1mSx+2cNRe/bQCpJTj45Fctia/o8Gp8W8KMDA+qiTPxQHh/u4s043Hyxy
         OzMJlKclYAgyP7KIbIrIK6/woP/dFUSy2FY3AW2Ma1AeHNiDDZCHTrkMeIrSkM7Vpg4L
         C1/BxO6NzCF9jnkbVryKwvTz1xDwWZ23XSrWIxFp9Nhqu587JqdCSzOGJw7yut/GbAYJ
         xR527ZKPWg1L1HIg8WY1167q+JK2iRJm5lV6zruyqZvwjAIb9xwjrZEfMxUgSub96bOe
         NOWA==
X-Gm-Message-State: AOAM530h16rvyvY6jbVxSKGRlwHJyPNy19qn6h3yG3m8XvQXx+srmXHy
        xK2wIlkxSc73MeW78RxHzgiA+w==
X-Google-Smtp-Source: ABdhPJzvFis8A52Dgv2JLQkhlzuNhj54OELul89Kik3BwjEQi1wDQBq+Su8EsQeQqwef+14FFdTd/w==
X-Received: by 2002:a05:6a00:1895:b029:32c:b091:ebc with SMTP id x21-20020a056a001895b029032cb0910ebcmr19256329pfh.4.1626582663382;
        Sat, 17 Jul 2021 21:31:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.30.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:31:03 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/7] mm: remove redundant smp_wmb()
Date:   Sun, 18 Jul 2021 12:30:29 +0800
Message-Id: <20210718043034.76431-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_wmb() which is in the __pte_alloc() is used to
ensure all ptes setup is visible before the pte is made
visible to other CPUs by being put into page tables. We
only need this when the pte is actually populated, so
move it to pte_install(). __pte_alloc_kernel(),
__p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
to this case.

We can also defer smp_wmb() to the place where the pmd entry
is really populated by preallocated pte. There are two kinds
of user of preallocated pte, one is filemap & finish_fault(),
another is THP. The former does not need another smp_wmb()
because the smp_wmb() has been done by pte_install().
Fortunately, the latter also does not need another smp_wmb()
because there is already a smp_wmb() before populating the
new pte when the THP use preallocated pte to split huge pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c         | 47 ++++++++++++++++++++---------------------------
 mm/sparse-vmemmap.c |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a0ac4b33e07a..540f0c9d0970 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -439,6 +439,20 @@ void pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 
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
 	pte_install(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
@@ -478,10 +477,9 @@ int __pte_alloc_kernel(pmd_t *pmd)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		smp_wmb(); /* See comment in pte_install() */
 		pmd_populate_kernel(&init_mm, pmd, new);
 		new = NULL;
 	}
@@ -3856,7 +3854,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	ret = vma->vm_ops->fault(vmf);
@@ -3918,7 +3915,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -4143,7 +4139,6 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
@@ -4817,13 +4812,13 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&mm->page_table_lock);
 	if (pgd_present(*pgd))		/* Another has populated it */
 		p4d_free(mm, new);
-	else
+	else {
+		smp_wmb(); /* See comment in pte_install() */
 		pgd_populate(mm, pgd, new);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
@@ -4840,11 +4835,10 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	spin_lock(&mm->page_table_lock);
 	if (!p4d_present(*p4d)) {
 		mm_inc_nr_puds(mm);
+		smp_wmb(); /* See comment in pte_install() */
 		p4d_populate(mm, p4d, new);
 	} else	/* Another has populated it */
 		pud_free(mm, new);
@@ -4865,11 +4859,10 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	if (!new)
 		return -ENOMEM;
 
-	smp_wmb(); /* See comment in __pte_alloc */
-
 	ptl = pud_lock(mm, pud);
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
+		smp_wmb(); /* See comment in pte_install() */
 		pud_populate(mm, pud, new);
 	} else	/* Another has populated it */
 		pmd_free(mm, new);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bdce883f9286..15075d8875be 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -76,7 +76,7 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in __pte_alloc(). */
+	/* Make pte visible before pmd. See comment in pte_install(). */
 	smp_wmb();
 	pmd_populate_kernel(&init_mm, pmd, pgtable);
 
-- 
2.11.0

