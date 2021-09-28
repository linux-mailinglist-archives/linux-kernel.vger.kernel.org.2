Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DB41AF38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhI1Mon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbhI1Moh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AAC06176D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x191so14126260pgd.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wK0MhX8vpp0T/mw8HHAEfioHFHFMlRk2c9RglR60FJs=;
        b=M23Lv5fb1X2l4CxdYZpTbYkfhNPAffOH/xrH5iBB+Yx+BppUk9Lri6blZ8UzFC2o3J
         EvcniD4mISkS8X24TMHnHV/EdJ4UxkXcyqt2w8iIClhkLfVzmUhFoQg42iqnZ8eYoGv/
         A3/AT9xwU+KLD4iQM0FqqyFwGgxAzGGES45DgM2pbpziTN7a8JRjoIKy1uhUA+/Aaedp
         FcqFpfkP71bHwQfV1raEx6Ytefn8pKigP9F+f7y3FKN44V9EIsslCXlfYJuX6VCxZ6lh
         HNnFmmFYFcVrUCfop1tUKwFTppVDpM+v+0rOfupgkLDV+kAlvn4hBYxOIWnWlGhwmLMw
         aS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wK0MhX8vpp0T/mw8HHAEfioHFHFMlRk2c9RglR60FJs=;
        b=h78kB3CoK+E26gAlSGxaI+ufjqnMgaO7P0nJiDKfAnhk+CBE0bqZxDcNZkx4r7RO0U
         q0ukiQZhna7ZFCbUS0AWBXCYbcu3d7ii3iC1bX79HKhJ/AWcUL0H75KtmLHpKKbc/y87
         i0wDljPPh48a4XLAPgkDZgHZnkkXbFE1rhH3kxxp8o+axfeJKB1LUFqvs4xl3yYm68yT
         MPz85VDYpBO6hu4QA9y7dO1OypzQstGeQ2zkU4WgwLqaqId8N7cXrEMIy6T8p7RzgkC+
         pDpMLAhwKQcO3lsdMFe10bpSApzdNcbLwHEswy5a0QF5IqQR3yzLGShUo8UtKCLYH6Xy
         hbKQ==
X-Gm-Message-State: AOAM531k0TzgGqOrnGC6jQ7XLCl3AP+/0pX1TdTflvZMcdPaDq8sqbgN
        usasbRFc9HuslC9g4NZ77Og17A==
X-Google-Smtp-Source: ABdhPJxgT+shfDCsqxI+vxDGgSEM+zm6oiWu27bWIVxt0VHtmW2VTcHBWxv2dNc8p4iQ52ddFfWHZQ==
X-Received: by 2002:a63:4622:: with SMTP id t34mr4413126pga.293.1632832976807;
        Tue, 28 Sep 2021 05:42:56 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.42.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:42:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 3/5] mm: sparsemem: use page table lock to protect kernel pmd operations
Date:   Tue, 28 Sep 2021 20:41:50 +0800
Message-Id: <20210928124152.33634-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210928124152.33634-1-songmuchun@bytedance.com>
References: <20210928124152.33634-1-songmuchun@bytedance.com>
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

Now the kernel page table walker does not hold the page_table_lock when
walking pmd entries. There may be consistency issue of a pmd entry,
because pmd entry might change from a huge pmd entry to a PTE page table.
There is only one user of kernel page table walker, namely ptdump. The
ptdump already considers the consistency, which use a local variable to
cache the value of pmd entry. But we also need to update ->action to
ACTION_CONTINUE to make sure the walker does not walk every pte entry
again when concurrent thread has split the huge pmd.

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
index e881f5db7091..ba76d8765211 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -53,8 +53,8 @@ struct vmemmap_remap_walk {
 	struct list_head *vmemmap_pages;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
-				  struct vmemmap_remap_walk *walk)
+static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				    struct vmemmap_remap_walk *walk)
 {
 	pmd_t __pmd;
 	int i;
@@ -76,15 +76,37 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in pmd_install(). */
-	smp_wmb();
-	pmd_populate_kernel(&init_mm, pmd, pgtable);
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_leaf(*pmd))) {
+		/* Make pte visible before pmd. See comment in pmd_install(). */
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
@@ -121,13 +143,12 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 
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

