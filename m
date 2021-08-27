Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2C3F9B69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbhH0PFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhH0PFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:05:01 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:04:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ew6so4145547qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=op2QVF7ofZpANc1CMzE9ciWUBXUVrosnUhzGCjoQSlU=;
        b=vbYlZelwKh8Sl1ByA94JNKLxNAbvyVPJNZYQdKIORBxqH8DA5iOQnbkBUbib2yX5dC
         if2PnA3BlvTyGKDHPo/hVZtsdhdbZpAzdkOEZmF16y6KCPcveFOhPXQkCfZ5olWQUpPi
         mDUdFgUsxacDJ5vjp3hK0dCIK8QrrbuXaTmVwxayQ5egHtd2MumLwiGVVMT2ilCv9yUH
         3hG2OsSrPZjubhWYhoCJ83ORNj8YpjvJk2bg3OmkmKukqlpeHylQWSFpLyH9FOR5NmCT
         sW9XQvRBFLaPACgbS2bF514h9ZMdbtIvp9ERE3BVsQ3n0qLoqs29Xw85UrICj0NXNGXQ
         ITOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=op2QVF7ofZpANc1CMzE9ciWUBXUVrosnUhzGCjoQSlU=;
        b=A0qyvlMiN1RB7wk64jWOpwkwm0Rcsfqwt7QyCzHCgqQIf1EtxWrPGGvmCpEAFs/Uni
         88ZgZoQ1eidrGL6H0Ve/9ofDa0ihgKf6N5LYoJaB7IM4cPTFTFPGA0Li04Khg0PhHLx9
         GDTWtXzNUMwgRMnUVWYQOBboW+SC3oV0IlI0YEiTfewb2OdsQpZmYMq7XaU5pAvqolIo
         X1TgFKc9MALodm1LnnRlWoOX/OqGZtIripRpp+YPbJYDwEat5chwbCHFZVviZd/zMErV
         edFt23PIQPixiC1Re8hkNLZKMUp/0bQiKWLR4mEkd8aJqUH98xGfKu7My/csLWKxR8HS
         J/qg==
X-Gm-Message-State: AOAM530/r936Q7O/LqxnjIg1fWEJ0/cBVWjKEkoenGSbqmGq5Jz+j1VZ
        Z1q18TYzPysWFGW+qvaOD4k=
X-Google-Smtp-Source: ABdhPJxLp0R/ieXX1YdB/sEdguqUzsVUVLdaa9tGsB4/JIL2IVGh0T3SCkZ4VyqCP7KJihUiiTheqQ==
X-Received: by 2002:a05:6214:194b:: with SMTP id q11mr9954664qvk.33.1630076651299;
        Fri, 27 Aug 2021 08:04:11 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id m187sm4796385qkd.131.2021.08.27.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:04:10 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] mm/damon/vaddr: Safely walk page table
Date:   Fri, 27 Aug 2021 15:04:00 +0000
Message-Id: <20210827150400.6305-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit d7f647622761 ("mm/damon: implement primitives for the virtual
memory address spaces") of linux-mm[1] tries to find PTE or PMD for
arbitrary virtual address using 'follow_invalidate_pte()' without proper
locking[2].  This commit fixes the issue by using another page table
walk function for more general use case under proper locking.

[1] https://github.com/hnaz/linux-mm/commit/d7f647622761
[2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com

Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/vaddr.c | 81 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 230db7413278..b3677f2ef54b 100644
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
@@ -446,14 +448,69 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
+struct damon_walk_private {
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+};
+
+static int damon_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+		struct mm_walk *walk)
+{
+	struct damon_walk_private *priv = walk->private;
+
+	if (pmd_huge(*pmd)) {
+		priv->ptl = pmd_lock(walk->mm, pmd);
+		if (pmd_huge(*pmd)) {
+			priv->pmd = pmd;
+			return 0;
+		}
+		spin_unlock(priv->ptl);
+	}
+
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return -EINVAL;
+	priv->pte = pte_offset_map_lock(walk->mm, pmd, addr, &priv->ptl);
+	if (!pte_present(*priv->pte)) {
+		pte_unmap_unlock(priv->pte, priv->ptl);
+		priv->pte = NULL;
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct mm_walk_ops damon_walk_ops = {
+	.pmd_entry = damon_pmd_entry,
+};
+
+int damon_follow_pte_pmd(struct mm_struct *mm, unsigned long addr,
+		struct damon_walk_private *private)
+{
+	int rc;
+
+	private->pte = NULL;
+	private->pmd = NULL;
+	rc = walk_page_range(mm, addr, addr + 1, &damon_walk_ops, private);
+	if (!rc && !private->pte && !private->pmd)
+		return -EINVAL;
+	return rc;
+}
+
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
+	struct damon_walk_private walk_result;
+	pte_t *pte;
+	pmd_t *pmd;
 	spinlock_t *ptl;
 
-	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
+	mmap_write_lock(mm);
+	if (damon_follow_pte_pmd(mm, addr, &walk_result)) {
+		mmap_write_unlock(mm);
 		return;
+	}
+	pte = walk_result.pte;
+	pmd = walk_result.pmd;
+	ptl = walk_result.ptl;
 
 	if (pte) {
 		damon_ptep_mkold(pte, mm, addr);
@@ -462,6 +519,7 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
 		damon_pmdp_mkold(pmd, mm, addr);
 		spin_unlock(ptl);
 	}
+	mmap_write_unlock(mm);
 }
 
 /*
@@ -495,14 +553,21 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 			unsigned long *page_sz)
 {
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
+	struct damon_walk_private walk_result;
+	pte_t *pte;
+	pmd_t *pmd;
 	spinlock_t *ptl;
 	struct page *page;
 	bool young = false;
 
-	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
+	mmap_write_lock(mm);
+	if (damon_follow_pte_pmd(mm, addr, &walk_result)) {
+		mmap_write_unlock(mm);
 		return false;
+	}
+	pte = walk_result.pte;
+	pmd = walk_result.pmd;
+	ptl = walk_result.ptl;
 
 	*page_sz = PAGE_SIZE;
 	if (pte) {
@@ -513,7 +578,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 		if (page)
 			put_page(page);
 		pte_unmap_unlock(pte, ptl);
-		return young;
+		goto out;
 	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -528,6 +593,8 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 	*page_sz = ((1UL) << HPAGE_PMD_SHIFT);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
+out:
+	mmap_write_unlock(mm);
 	return young;
 }
 
-- 
2.17.1

