Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2B3FCB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbhHaQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhHaQTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:19:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:18:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l24so15112597qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jUjZnzjHu9GsMs6wMwVvYSFPL5+G8RVZ2+4T5OE5Dqo=;
        b=Q3uA4sgZs3IF8PBhXxHoeuB5YC9886TGhXSqYAEjUq9hzx1s2LApIrOF/AgLA7VFU2
         uNMZ6njXDDp4HyA5q/3Ugf2CaOGuxMNi3bRr4KS+9J1LN2CsfYImYT6AEyIaMIa8371K
         i2DdLR5Nx8yt3pU/lomxT6adLiQUCdukjPXnj1sASIGATazsTEaXPXctsVkKT7h+OYzb
         jRbQzCBdk7OrDta4hASDWjwSb0+rNXsg51uWDruM9Y0Whn9glayFudDZoameoqjKZ5LN
         Haei/tGSFkqQbBJuYPsbnjE+UBOZo7gnAv3W4FhAI2VRnhfDpEtNAGgnh8M6NhWsiuLk
         cQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jUjZnzjHu9GsMs6wMwVvYSFPL5+G8RVZ2+4T5OE5Dqo=;
        b=nT21t+wihkV7J6UKFZm941zho9R1OMsj4Y7tdlRU+39nrFGO2CGVV9jA78hOqjuxfL
         BXk+TU8xV5wOkRB2WFOCqJVz8++5u1RpcZ2KY4JkEkr6IB4/uRU90GReQyzl8MXvM4gz
         Hy7rEyTFT/iBZFUGmY2hmaUBdm2cDh5e4B6mx5HUPXCgftlAUYbRZFMzgHcbC855kgPZ
         UZtaateexoBnZoaIaVaUcJz6YFCBBOKm+PSM7xS/L7ErufowKrFMmbqXSUIGyaFfbyb5
         drikGHQgohRwxUFJElB7A/CkfhMiXpsxEa7aPNl6/hfwZVkImpx0kbXZUtP7bcxWxnyp
         lXQw==
X-Gm-Message-State: AOAM5317Vy1PXO2+PiieXRpoGW9a6LpJblX9j3f3gXAI+BgUCDDGvfzZ
        wOg+B9tt8/gW8LeJA2x/4sY=
X-Google-Smtp-Source: ABdhPJw7lvM9s0fHCMfhwf8/Db17OOeOYGga9AY98ZZ9bOYo58GNmbg+ulePnad50idt5Ywysp54Xw==
X-Received: by 2002:ac8:7d0d:: with SMTP id g13mr3463954qtb.367.1630426724005;
        Tue, 31 Aug 2021 09:18:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id n14sm10757112qti.47.2021.08.31.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:18:43 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2] mm/damon/vaddr: Safely walk page table
Date:   Tue, 31 Aug 2021 16:18:00 +0000
Message-Id: <20210831161800.29419-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit d7f647622761 ("mm/damon: implement primitives for the virtual
memory address spaces") of linux-mm[1] tries to find PTE or PMD for
arbitrary virtual address using 'follow_invalidate_pte()' without proper
locking[2].  This commit fixes the issue by using another page table
walk function for more general use case ('walk_page_range()') under
proper locking (holding mmap read lock).

[1] https://github.com/hnaz/linux-mm/commit/d7f647622761
[2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com

Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
Changes from v1 (https://lore.kernel.org/linux-mm/20210827150400.6305-1-sj38.park@gmail.com/)
- Hold only mmap read lock (David Hildenbrand)
- Access the PTE/PMD from the walk_page_range() callbacks (David Hildenbrand)

 mm/damon/vaddr.c | 136 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 97 insertions(+), 39 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 230db7413278..58c1fb2aafa9 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -8,10 +8,12 @@
 #define pr_fmt(fmt) "damon-va: " fmt
 
 #include <linux/damon.h>
+#include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mmu_notifier.h>
 #include <linux/highmem.h>
 #include <linux/page_idle.h>
+#include <linux/pagewalk.h>
 #include <linux/random.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
@@ -446,22 +448,42 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
 {
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
+	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
-		return;
-
-	if (pte) {
-		damon_ptep_mkold(pte, mm, addr);
-		pte_unmap_unlock(pte, ptl);
-	} else {
-		damon_pmdp_mkold(pmd, mm, addr);
+	if (pmd_huge(*pmd)) {
+		ptl = pmd_lock(walk->mm, pmd);
+		if (pmd_huge(*pmd)) {
+			damon_pmdp_mkold(pmd, walk->mm, addr);
+			spin_unlock(ptl);
+			return 0;
+		}
 		spin_unlock(ptl);
 	}
+
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return 0;
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte_present(*pte))
+		goto out;
+	damon_ptep_mkold(pte, walk->mm, addr);
+out:
+	pte_unmap_unlock(pte, ptl);
+	return 0;
+}
+
+static struct mm_walk_ops damon_mkold_ops = {
+	.pmd_entry = damon_mkold_pmd_entry,
+};
+
+static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_read_lock(mm);
+	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	mmap_read_unlock(mm);
 }
 
 /*
@@ -492,43 +514,79 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-			unsigned long *page_sz)
+struct damon_young_walk_private {
+	unsigned long *page_sz;
+	bool young;
+};
+
+static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
 {
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
+	pte_t *pte;
 	spinlock_t *ptl;
 	struct page *page;
-	bool young = false;
-
-	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
-		return false;
-
-	*page_sz = PAGE_SIZE;
-	if (pte) {
-		page = damon_get_page(pte_pfn(*pte));
-		if (page && (pte_young(*pte) || !page_is_idle(page) ||
-					mmu_notifier_test_young(mm, addr)))
-			young = true;
-		if (page)
-			put_page(page);
-		pte_unmap_unlock(pte, ptl);
-		return young;
-	}
+	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page = damon_get_page(pmd_pfn(*pmd));
-	if (page && (pmd_young(*pmd) || !page_is_idle(page) ||
-			mmu_notifier_test_young(mm, addr)))
-		young = true;
-	if (page)
+	if (pmd_huge(*pmd)) {
+		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_huge(*pmd)) {
+			spin_unlock(ptl);
+			goto regular_page;
+		}
+		page = damon_get_page(pmd_pfn(*pmd));
+		if (!page)
+			goto huge_out;
+		if (pmd_young(*pmd) || !page_is_idle(page) ||
+					mmu_notifier_test_young(walk->mm,
+						addr)) {
+			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+			priv->young = true;
+		}
 		put_page(page);
+huge_out:
+		spin_unlock(ptl);
+		return 0;
+	}
 
-	spin_unlock(ptl);
-	*page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+regular_page:
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	return young;
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return -EINVAL;
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte_present(*pte))
+		goto out;
+	page = damon_get_page(pte_pfn(*pte));
+	if (!page)
+		goto out;
+	if (pte_young(*pte) || !page_is_idle(page) ||
+			mmu_notifier_test_young(walk->mm, addr)) {
+		*priv->page_sz = PAGE_SIZE;
+		priv->young = true;
+	}
+	put_page(page);
+out:
+	pte_unmap_unlock(pte, ptl);
+	return 0;
+}
+
+static struct mm_walk_ops damon_young_ops = {
+	.pmd_entry = damon_young_pmd_entry,
+};
+
+static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
+		unsigned long *page_sz)
+{
+	struct damon_young_walk_private arg = {
+		.page_sz = page_sz,
+		.young = false,
+	};
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
+	mmap_read_unlock(mm);
+	return arg.young;
 }
 
 /*
-- 
2.17.1

