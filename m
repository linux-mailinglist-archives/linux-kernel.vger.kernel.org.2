Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1533F116C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHSDUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhHSDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:20:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD1C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:19:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so3066875plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZKZTZOtvlnbM7sr1/sGaSyg3CoVrbhapZj97svXJc4=;
        b=lM2aQf09sZst/3IUuwtoZ4ifaTLps8ik+qJ445iHcaPnQd7m0zuI2P8FkdK1NxGpvz
         kTTXotWV3FAoaqE+5dC65iH+O9cEkw3uWcYq+CcQ0ozGE8uT7+2j4j5DeIc67FooHXMo
         GQy9rI8uBPfjjdcpye6luwdS439+JZsEfoghxPK/MLyyof0R1IzUxJG5VSiVZAUq8FiZ
         2PiV5muPG5cidLnOoqyyF5j4k/QN+y2yDF7b1jEbg/G6OkLAr0uM2hK0eJa3VU0/W7kT
         60RAMPlS9BoP6/lMw6fy/475/LdHvWZVT25l0YIGIcK9ZOC/MGeLaPe1EfabLlBcU81G
         3EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZKZTZOtvlnbM7sr1/sGaSyg3CoVrbhapZj97svXJc4=;
        b=gJk0BD0MUj2d9oGmQimpw96yPxqdxu8a+OuU3WbIKGy/y114Pkw/0hZfXKhL0ASeit
         sMR8TYLj2chvF1oecTmMbnnbUFbXjaZcpm3re5jMsB7o6wGorLp4QcvsST19IJtV9kV5
         kCVM801HYypd6l2vILSKNOupTwau6dj36HVsqZa0LQu7AKUdFx5ZDlQn4qgofMlKd8Bb
         81jS0AJS3lOAw53HNGRQEqaXt9NIRez3fSOkimbxgMfbOclbhktQpCGUBnl8xy797OQm
         J8I2cVnemvzka/8FXbIFJeeherw41VXdQYAoe3AUXmH4hEMZJ69ybvdzys+FO4BHOzhh
         UqjQ==
X-Gm-Message-State: AOAM530GufK55QzMMVi6B+kUUNmoNnRjmWGRe1V0qoXkrvEHG39eFJ/V
        0bnrB3xvZ4vXsya5r//OI3oO6g==
X-Google-Smtp-Source: ABdhPJzUL5x86pUbmIHy8gKMPuLqku6RHNT4f6EBLJUOkilcixbi6aCYteS4aghe0ljtC6qZbFuuNw==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr3304740pjb.70.1629343198552;
        Wed, 18 Aug 2021 20:19:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:19:58 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/9] mm: introduce pmd_install() helper
Date:   Thu, 19 Aug 2021 11:18:50 +0800
Message-Id: <20210819031858.98043-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have three times the same few lines repeated in the
code. Deduplicate them by newly introduced pmd_install() helper.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/filemap.c       | 11 ++---------
 mm/memory.c        | 34 ++++++++++++++++------------------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..57e48217bd71 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2471,6 +2471,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/mm/filemap.c b/mm/filemap.c
index 53913fced7ae..9f773059c6dc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3210,15 +3210,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
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

