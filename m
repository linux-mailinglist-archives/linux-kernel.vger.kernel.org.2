Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5603FC81B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhHaNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhHaNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:22:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF8C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:21:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x4so16704373pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBv4DIzKRcOu69g1wqCeY57nVaNCSDRinCugPrU4tQ4=;
        b=Br7vpBZuYB1KrRcH3aKb7TMzr+uOaRmUFrH3fj/WmfhYU79w3x5hfLOQLdYXzEluyi
         qG6kfJdrSnRDysJ3mx5rqJSFGrb8GQ9huouLqjh71elt8wDLUoivxP/y6KeNmpfL2ArN
         Catlao+CgXWLXb0HaiHJcPptCx4UHRytvDGzWi9XVPcsPRk5aIbJBv7VZmwD2Bhz6Dzm
         UmA1mvHNW8gBrQyN2a2Wb2CVsSguzQGeLd61qiLWlC7Jx8x8afme3bckRf3xz4HMea5t
         pVrPLSUZOK7V0Tcb8DdKtd6SlS1NKFOUQFzCF9Dq3A5sqns7HDFWN2EYf8kvkV8gF9Gm
         rItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBv4DIzKRcOu69g1wqCeY57nVaNCSDRinCugPrU4tQ4=;
        b=k/CRzeTmPXCeocpUQGLK2Ar7MwJdAMoANa1sukPG1eF/wq1lUWRXMsUVzPiiCWVOfT
         5ClECt7QB8r+ktdL9QqGrL7+2xpSySmJ4zpNQIIyM3YiuWrV7Ew83IY7bo5/mTlmrqlh
         1TtDLbjtvaH2gZJw6RbFVJvxysWCiKU/TOKSnNTNg7AsdYWVDaY1PiyUVjDSYBmQ1ZBn
         0ooJcnxSGDmw7JJS1y3SleYM5eoiITRcJ4Z5hqJyfflp98XfM2QTEnZsAMkQmwxj6q1b
         +oUiEJAnyyDlFmyivdSW1C3CuHZ8MCzE9AqpFiiCrtPBhop4DHr6lQ4AJ3v2rNeuyKzY
         lzbg==
X-Gm-Message-State: AOAM5338hPHnRsE4PCaGW2J6twPMrNF7U69Plsf5KheyivVNzRgzFIH9
        SMOg8sHDMBpVFKvVV0SGnOEsrQ==
X-Google-Smtp-Source: ABdhPJwQBi8vJ/iQd/BGDlY9g6T4MsHzHwWv2+qPpqkNnzGGbU5YKSYjZBBxI+8Rqp+HGFPKuZantQ==
X-Received: by 2002:a63:fc1d:: with SMTP id j29mr26405642pgi.54.1630416086289;
        Tue, 31 Aug 2021 06:21:26 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id k190sm9548352pgc.11.2021.08.31.06.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 06:21:25 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, vbabka@suse.cz
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/2] mm: introduce pmd_install() helper
Date:   Tue, 31 Aug 2021 21:21:10 +0800
Message-Id: <20210831132111.85437-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210831132111.85437-1-zhengqi.arch@bytedance.com>
References: <20210831132111.85437-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have three times the same few lines repeated in the
code. Deduplicate them by newly introduced pmd_install() helper.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/filemap.c       | 11 ++---------
 mm/memory.c        | 34 ++++++++++++++++------------------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3cc83d64564..0af420a7e382 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2463,6 +2463,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/mm/filemap.c b/mm/filemap.c
index c90b6e4984c9..923cbba1bf37 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3209,15 +3209,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	    }
 	}
 
-	if (pmd_none(*vmf->pmd)) {
-		vmf->ptl = pmd_lock(mm, vmf->pmd);
-		if (likely(pmd_none(*vmf->pmd))) {
-			mm_inc_nr_ptes(mm);
-			pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
-			vmf->prealloc_pte = NULL;
-		}
-		spin_unlock(vmf->ptl);
-	}
+	if (pmd_none(*vmf->pmd))
+		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	/* See comment in handle_pte_fault() */
 	if (pmd_devmap_trans_unstable(vmf->pmd)) {
diff --git a/mm/memory.c b/mm/memory.c
index 39e7a1495c3c..ef7b1762e996 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -433,9 +433,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	spinlock_t *ptl = pmd_lock(mm, pmd);
+
+	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		mm_inc_nr_ptes(mm);
+		pmd_populate(mm, pmd, *pte);
+		*pte = NULL;
+	}
+	spin_unlock(ptl);
+}
+
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 {
-	spinlock_t *ptl;
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
@@ -455,13 +466,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 	 */
 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 
-	ptl = pmd_lock(mm, pmd);
-	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		mm_inc_nr_ptes(mm);
-		pmd_populate(mm, pmd, new);
-		new = NULL;
-	}
-	spin_unlock(ptl);
+	pmd_install(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
 	return 0;
@@ -4027,17 +4032,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte) {
-			vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-			if (likely(pmd_none(*vmf->pmd))) {
-				mm_inc_nr_ptes(vma->vm_mm);
-				pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
-				vmf->prealloc_pte = NULL;
-			}
-			spin_unlock(vmf->ptl);
-		} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
+		if (vmf->prealloc_pte)
+			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
 			return VM_FAULT_OOM;
-		}
 	}
 
 	/* See comment in handle_pte_fault() */
-- 
2.11.0

