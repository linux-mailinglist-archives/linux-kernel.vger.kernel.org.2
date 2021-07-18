Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5943CC78A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhGREeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhGREd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:33:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF38C061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso11885002pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVYHNGkdyKlwK6dCMYmTnE+nHwe/J3b2KXRbX3JogJw=;
        b=iY1kKz6c3O1gPTZ6AOqOAbaK+8u3kSYhTOHF1miiIia8vJzWFeh/GkV9PMte6SOl+X
         ppZvpuFVRcR1nNaqgK+VK/CnwkHuycqIGfZEV2dKNJEK0g1NO+XqE6QmTGyxsqKPzrYg
         5lkaeyCkCqcEUzfM+jFOftFYb5Q86+hyrPWYYH7oOn/8LmDsC1Ok+PJ4oTZsC3FWKIOY
         Ds0t2nGwMluEv/2oI8kqwwVsfvIzyBoi2Gc3RG/cM0XtwI16hKZoiu6JKSfddekZJUZS
         53lzS/j0MF5kUG6DAgXSlUzkZgO4WWe4Kbusea98bwMIb7j3+xCXq3/2CtHAyIFBGfGP
         lG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVYHNGkdyKlwK6dCMYmTnE+nHwe/J3b2KXRbX3JogJw=;
        b=d8ahOu2NSxCmgAvzdpkUMCqiSG7Vsvdg/P289+D95uX4PKT4SGCU5Wb7N1YPbRaov3
         m/IY4rkrE2tqmbUoD/Cjay4vjvo7Zk9QJtFTlagnt9eLH/n6B7577YPcBM+epcr32pdr
         aywfOG4ANCpLYaa2I6HsGL/Cy+THHKghkkNBMkihHX6p6Z4ap0zNt+xt6gcvTz/tjqE6
         tmANj8NpiWOMspksonEvf1Da/CRVOctsipA9aTNe3wRmhpHkyZzmWV7aFC7Nop3R6Eht
         gtYmgUOogdugjyyPB222pqMWzVrJKglnw3hJFeAb2byRhTgN7n2Lq2Rj+G0N7zfIoZ3N
         O76Q==
X-Gm-Message-State: AOAM532L7IxIjsf1xjuWQkrUsUURF1TJwfZef3n0LsexU7lycsrnNHcg
        dKnSXftTisGX4blfijeaiKhJHTU9rggvgVWF
X-Google-Smtp-Source: ABdhPJxr3cbtH+NDceI9FJvUiPTYg/qzlCUaJB88Ak0L8TiKUDaCOmdVLqiJMRp7XqnNQ4NiJ7yiGA==
X-Received: by 2002:a17:902:9a04:b029:129:7769:2b01 with SMTP id v4-20020a1709029a04b029012977692b01mr14041091plp.76.1626582659427;
        Sat, 17 Jul 2021 21:30:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:30:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/7] mm: introduce pte_install() helper
Date:   Sun, 18 Jul 2021 12:30:28 +0800
Message-Id: <20210718043034.76431-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have three times the same few lines repeated in the
code. Deduplicate them by newly introduced pte_install() helper.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/filemap.c       | 11 ++---------
 mm/memory.c        | 34 ++++++++++++++++------------------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57453dba41b9..5efd63a20d72 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2374,6 +2374,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+extern void pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b365fdef7a5..4955641f2cf0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3173,15 +3173,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
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
+		pte_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	/* See comment in handle_pte_fault() */
 	if (pmd_devmap_trans_unstable(vmf->pmd)) {
diff --git a/mm/memory.c b/mm/memory.c
index 94a17a9a48ab..a0ac4b33e07a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -433,9 +433,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
+void pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
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
+	pte_install(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
 	return 0;
@@ -4026,17 +4031,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
+			pte_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
 			return VM_FAULT_OOM;
-		}
 	}
 
 	/* See comment in handle_pte_fault() */
-- 
2.11.0

