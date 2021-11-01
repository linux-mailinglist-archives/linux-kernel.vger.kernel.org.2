Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6D944125D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhKADZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhKADY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:24:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729CC061767
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:22:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s5so3526460pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut/rsMwOCHZFvr+mAC3bHz7Yha0mg558IoAi3jATnso=;
        b=dNXhV0WUz3hYwK0ywZtEkEujrLfTb1Gd4wvbadxnPd37rszDgwv5sukYpTn4ARVTdq
         7aATfMNvbM+eZCDfCBX+PGweob3vK3RTJul+gZOO6vEeFt4yqZeTWuNHu5SpmRsq4pus
         /ODs1GpTv/aqc+rE1YNBhYf6SV0LVnavvjLX+0dYcOPgUMvWGowC4TM5DMWTtOkeLd8n
         oldbUP+ialHwIRHPXrfnpTHEO/x5qyE7dI7jHP/jmhj6TVMFY9XlTUeMFPLFOP/sd5zc
         WbjwP6xkAvyyGiZDG/1rDv5YEcAmMp04cBPFpZ56WSlB/kCtRc1toIwh/Tx964NeCfcg
         qCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut/rsMwOCHZFvr+mAC3bHz7Yha0mg558IoAi3jATnso=;
        b=hhaO356WrDHjfkATaR8mQ6pYwyGz5thI6zLJ+Lo4F5lP2kkJesd+Tem87qkrNfwbsN
         OaBqJ/0M3A/VInRH9+6BsAOsr2IzAwwr/t75TGrRz7kDGWER6NttWn5zk/ybwDEXlqve
         0bQNoVQ+hCUL23WcAMvJ4E1Uof3jZw/zFiJf6stgYn48STbVx//AE0gw9wGo+u/Nzaun
         11zr/XK0zuOFWbAxhn24fRU1oFJMM+5v+OM6BAH1U0RAY7chNy6bIZhY1QfxU7CbiZOS
         Qx/d6KV9FBKK4dvZyV0X+9wNXFIFmcIxJvdw5FSjXYUzxAgVEAIS8S4besINAt3u82+7
         ayIw==
X-Gm-Message-State: AOAM532//IbX3KACfHbWfTde2fD7+o2H3bgGrs9fAfytcuLFxhkMo9WW
        0zAefCVgKOqKehXdK/h74Hx6sg==
X-Google-Smtp-Source: ABdhPJxag0DpT0JCnQK0GzshGS3PfD/ZjRKxTwaW18LcmjuKzI+FSZb7QbSlbwOo/6DIIp3PuBEdOg==
X-Received: by 2002:a63:455f:: with SMTP id u31mr33289pgk.206.1635736944102;
        Sun, 31 Oct 2021 20:22:24 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id f8sm11860963pjq.29.2021.10.31.20.22.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 20:22:23 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 3/5] mm: sparsemem: use page table lock to protect kernel pmd operations
Date:   Mon,  1 Nov 2021 11:16:49 +0800
Message-Id: <20211101031651.75851-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101031651.75851-1-songmuchun@bytedance.com>
References: <20211101031651.75851-1-songmuchun@bytedance.com>
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
 mm/sparse-vmemmap.c | 47 +++++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 20 deletions(-)

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
index e881f5db7091..c64d1aa3c4b5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -53,8 +53,7 @@ struct vmemmap_remap_walk {
 	struct list_head *vmemmap_pages;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
-				  struct vmemmap_remap_walk *walk)
+static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 {
 	pmd_t __pmd;
 	int i;
@@ -76,15 +75,34 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in pmd_install(). */
-	smp_wmb();
-	pmd_populate_kernel(&init_mm, pmd, pgtable);
-
-	flush_tlb_kernel_range(start, start + PMD_SIZE);
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_leaf(*pmd))) {
+		/* Make pte visible before pmd. See comment in pmd_install(). */
+		smp_wmb();
+		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		flush_tlb_kernel_range(start, start + PMD_SIZE);
+	} else {
+		pte_free_kernel(&init_mm, pgtable);
+	}
+	spin_unlock(&init_mm.page_table_lock);
 
 	return 0;
 }
 
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+{
+	int leaf;
+
+	spin_lock(&init_mm.page_table_lock);
+	leaf = pmd_leaf(*pmd);
+	spin_unlock(&init_mm.page_table_lock);
+
+	if (!leaf)
+		return 0;
+
+	return __split_vmemmap_huge_pmd(pmd, start);
+}
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -121,13 +139,12 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		if (pmd_leaf(*pmd)) {
-			int ret;
+		int ret;
+
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		if (ret)
+			return ret;
 
-			ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
-			if (ret)
-				return ret;
-		}
 		next = pmd_addr_end(addr, end);
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
@@ -321,10 +338,8 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
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

