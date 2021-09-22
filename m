Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30075414626
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhIVK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhIVK2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:28:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D10C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so4121195pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dXtWvh0hz8AcEkJtaCmZCNKq+swCjTc/s3IW/xzmY0=;
        b=iY1pxp/2LjuDMZjmTZVAm7zcKIrGCkGDzB8F60/vWyJhBG5OcZHTnCVHmQ3RK7R2Bt
         FFLnNjzE9DjpjGDHrYEMi59CeaVszgVi/h+w79XXPo51qdU/iWCogjk/3z0yHWmiW+84
         uPemc83b+vwRqo1cGqWQbgzc4CamH74Cq5foB+wUHiTeS48b10l4tzL4nHUMZ5Q/QHJH
         9XFvlg96N6gmgQXCaZTsPganY668ZQvB5F+R3tif8zFXelLPKbHfkYebnNXrFVMTjAGn
         XiWwgmCpsoIeKXqf17NPnrIEloRe90Aarlv0+8gKhzjnzgyNgmU6dBk30xxHujB9m1zo
         l90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dXtWvh0hz8AcEkJtaCmZCNKq+swCjTc/s3IW/xzmY0=;
        b=vUpTJfYFpBEaQMT8S+zU2uOgNsRY1t2rbIM1KoPxQ1eqKyBEYi5ylL2fQ7zdIBP8nV
         lsJnapMtkClpijimwb/UPSlZf0sUHTeTpogWa4J3c+zKy4vCxUbwB6rumsxBTvYA4F4V
         nQUdXnrkwd3eh/an6FUV8e5iSzEd85qcwuPef+r72GU7B+Tq/k/KvxJb/LjiEfVBDLJg
         jXjeKQNIqgrK2uZ082EY3fAmvmUpcFrHYYLj4/DmuVidgFUtFZe/vxnq1iKdNlPHnzK7
         fN8kRVjj6f6S4mAOYlwa144UzncyXzCbBevX62ODcZgkIYXOCt9J745VP+4NerPI+oYM
         5qOw==
X-Gm-Message-State: AOAM533PVTQp1KZg3V0F2ajaEQ5tLbb9HQSjXQ0E1cJHAlbeTvMK5WXX
        iz8zAmJLAsdCH6wtbnX18Oa/LA==
X-Google-Smtp-Source: ABdhPJxC+8sPcMCYb0LCoNN2Yblp/Tq/ZoiWIgS7Vo0HeqiB0K1B/lTrvFsHWyH/3dUXCrgzLLFZfg==
X-Received: by 2002:a17:90b:4b4b:: with SMTP id mi11mr10255208pjb.41.1632306440284;
        Wed, 22 Sep 2021 03:27:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s89sm1821929pjj.43.2021.09.22.03.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:27:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/4] mm: sparsemem: use page table lock to protect kernel pmd operations
Date:   Wed, 22 Sep 2021 18:24:10 +0800
Message-Id: <20210922102411.34494-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210922102411.34494-1-songmuchun@bytedance.com>
References: <20210922102411.34494-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_mm.page_table_lock is used to protect kernel page tables, we
can use it to serialize splitting vmemmap PMD mappings instead of mmap
write lock, which can increase the concurrency of vmemmap_remap_free().

Actually, It increase the concurrency between allocations of HugeTLB
pages. But it is not the only benefit. There are a lot of users of
mmap read lock of init_mm. The mmap write lock is holding through
vmemmap_remap_free(), removing mmap write lock usage to make it does
not affect other users of mmap read lock. It is not making anything
worse and always a win to move.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/ptdump.c         | 16 ++++++++++++----
 mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index da751448d0e4..eea3d28d173c 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -40,8 +40,10 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
-	if (pgd_leaf(val))
+	if (pgd_leaf(val)) {
 		st->note_page(st, addr, 0, pgd_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -61,8 +63,10 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
-	if (p4d_leaf(val))
+	if (p4d_leaf(val)) {
 		st->note_page(st, addr, 1, p4d_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -82,8 +86,10 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
-	if (pud_leaf(val))
+	if (pud_leaf(val)) {
 		st->note_page(st, addr, 2, pud_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -101,8 +107,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
-	if (pmd_leaf(val))
+	if (pmd_leaf(val)) {
 		st->note_page(st, addr, 3, pmd_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 62e3d20648ce..e636943ccfc4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -64,8 +64,8 @@ struct vmemmap_remap_walk {
  */
 #define NR_RESET_STRUCT_PAGE		3
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
-				  struct vmemmap_remap_walk *walk)
+static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				    struct vmemmap_remap_walk *walk)
 {
 	pmd_t __pmd;
 	int i;
@@ -87,15 +87,37 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in __pte_alloc(). */
-	smp_wmb();
-	pmd_populate_kernel(&init_mm, pmd, pgtable);
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_leaf(*pmd))) {
+		/* Make pte visible before pmd. See comment in __pte_alloc(). */
+		smp_wmb();
+		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		spin_unlock(&init_mm.page_table_lock);
 
-	flush_tlb_kernel_range(start, start + PMD_SIZE);
+		return 0;
+	}
+	spin_unlock(&init_mm.page_table_lock);
+	pte_free_kernel(&init_mm, pgtable);
 
 	return 0;
 }
 
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				  struct vmemmap_remap_walk *walk)
+{
+	int ret;
+
+	spin_lock(&init_mm.page_table_lock);
+	ret = pmd_leaf(*pmd);
+	spin_unlock(&init_mm.page_table_lock);
+
+	if (ret)
+		ret = __split_vmemmap_huge_pmd(pmd, start, walk);
+
+	return ret;
+}
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -132,13 +154,12 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		if (pmd_leaf(*pmd)) {
-			int ret;
+		int ret;
+
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
+		if (ret)
+			return ret;
 
-			ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
-			if (ret)
-				return ret;
-		}
 		next = pmd_addr_end(addr, end);
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
@@ -321,10 +342,8 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	mmap_write_lock(&init_mm);
+	mmap_read_lock(&init_mm);
 	ret = vmemmap_remap_range(reuse, end, &walk);
-	mmap_write_downgrade(&init_mm);
-
 	if (ret && walk.nr_walked) {
 		end = reuse + walk.nr_walked * PAGE_SIZE;
 		/*
-- 
2.11.0

