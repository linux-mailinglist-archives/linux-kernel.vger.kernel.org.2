Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1E3FA388
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 06:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhH1EYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 00:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhH1EYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 00:24:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572DEC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 21:23:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j2so5312226pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOQhtRJ283WN5i7pZFdCAMLJddI7+kc0mDNTD4e/NnI=;
        b=uOhcmas8K2ET6mieFgVELlVqw9VnQ8PHqGHiuSLRHQcRot4aWXhghVdYKMCrq7CnfY
         +GNSvXNDB5spvFzbTwdnCK6jnS55XNMCN7po5Efk4/vYhebjKdNOZSI+8KGeFiU/bOCc
         gIiqftF6P3pS6ivslF/iekYGgCH6UDNpbjCFkZ7ocBL7eYOVZBdb4wvbDOkVSO+LFAvt
         Z/mZGT1ll2qoKlmysbwqBZuPoRBgJoWnORkNwuJyIKc6uuhbL0y20QXDR55pyFsbAm4k
         617MUknLTK/z+QKvW5TJq6JJl+KtfZ7APSTO0r+WelWrfRqDXDgBrp64eJeKzcqlWLqH
         n4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOQhtRJ283WN5i7pZFdCAMLJddI7+kc0mDNTD4e/NnI=;
        b=cOUs0Ne61kZj2LYkkz1tb1gZllv8tP/UUTvHtww8Qodi3e8oNqF1GZU7EUb3SEb6Dn
         4d5clp02kC5npxHsmOQw+89fRQ6zDjra8vykzXLhkK4zR4Eq4nhZZPseavoEJ7FRflJU
         4hBsnBd8v/yW0UN4uoO4D1P5kraYO80xZsSHGHB9ld2C8cNksDrlfE46bT1SDeCS2g7V
         IMRhtqg3aluYXn/txn7Y/uEsCiR53yDaAeIp179Fj28vocD0CNgrFORYPMLfonZWBRxG
         Cmm1Smu9L5QCw99/BUxsdxga5Xe5AYNW6++nVDLd+fLH9cA1s1ATWQ4DGMrvI3HbZlEN
         OPLw==
X-Gm-Message-State: AOAM530GcxkMPYlSE7ORyQpV6GdAmJJc8XSOV8NRVePON1SAdOYxKthm
        LwoUXTaSxZc3oKNa7N5hnYhd5Q==
X-Google-Smtp-Source: ABdhPJzrwOcapjsD5epxpp/1rc70UdjtOMNFf0EdX6dc9t5hZwCuXgxkI7KkjeyzSfsRXv/kMJ95sQ==
X-Received: by 2002:a17:90a:8b12:: with SMTP id y18mr27121724pjn.72.1630124601867;
        Fri, 27 Aug 2021 21:23:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u15sm4720383pfl.14.2021.08.27.21.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 21:23:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 1/2] mm: introduce pmd_install() helper
Date:   Sat, 28 Aug 2021 12:23:05 +0800
Message-Id: <20210828042306.42886-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210828042306.42886-1-zhengqi.arch@bytedance.com>
References: <20210828042306.42886-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have three times the same few lines repeated in the
code. Deduplicate them by newly introduced pmd_install() helper.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

