Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868343A1410
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhFIMSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhFIMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:18:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 05:16:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id i34so12858879pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+YuMGvQ8I4aHNaQaeBXk0HeHBqQjOIoX3TXzPNfO+k=;
        b=rL5Z4RdfL1hryYc92LT7ZOR91SgRzhlx45ro+1T6E8QEmsllYV0EFMl2OINfumlxOV
         Ctuye8C/sAuQ0hal6i+orsubT9l2gQh84yqBrP526QckR5YY9FrMEkrkJPehc9baKddo
         gFvxxkxMh2ZvDIKj6zIdgwCkF8gEgexto5kh2FyN6PGAZ7TsRivgCDNdV/Ap1+8VB/MP
         1e+LNba5nHgRn8gvn+t5HRzTvbB5H/Wne7oO7OjcAd/BNBkWXEoQV6hB0ozGwxY1sUm3
         G3RJfll8AKFnrA6ZEhsbSZX9AGtpi2+HsKfhIPqR2hT0YIR3ju82sGF7B7umFPrTg4EP
         JRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+YuMGvQ8I4aHNaQaeBXk0HeHBqQjOIoX3TXzPNfO+k=;
        b=Z8tIwcLA9e5AQ1xdUwTL/RDaGoC9h72jOpg2/+yZgPQAeDMdvLwqo/vD94wS+CXVAZ
         jFwKZh11CTiKbkdG8tRyI0/hnTFdLulCS0sJhcEzDraoWk7WOUkDqzda++/b3zpwtILE
         56fAZ05MYXhmyomf5qHMkUrqse2TYKEBvxfvj9EAorADhSQhG67Q6946tusGKxiaGGHn
         V3L+LvOTjhFlRtPm8TuwHZhlWMYxQ1uP+Uq+5yR7aNFBJYrk18vqPycQLWWx9Fg/E32x
         9oJjUfnYDLVmTLvDYZ0ilLR35bf0CHke9rF0sV7vArjrlcJA4w8c8Zft6bPuJ14GPIW8
         y1eQ==
X-Gm-Message-State: AOAM530m+s389mRQJ+LbupeMSyuf352C/fNQ5nL7CVRxAGP2c9tv5zGz
        csU4uNCWFGy863uAKIgk7hW9sA==
X-Google-Smtp-Source: ABdhPJxKU3CaWzedSOu29IBrceGRxurTCuv80BSN3kIYScZbcRjIkmko/im28NGvJPIQvcfAHTGVkA==
X-Received: by 2002:a05:6a00:844:b029:2f4:829f:e186 with SMTP id q4-20020a056a000844b02902f4829fe186mr828648pfk.31.1623240982829;
        Wed, 09 Jun 2021 05:16:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h16sm13689224pfk.119.2021.06.09.05.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:16:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/5] mm: sparsemem: split the huge PMD mapping of vmemmap pages
Date:   Wed,  9 Jun 2021 20:13:08 +0800
Message-Id: <20210609121310.62229-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210609121310.62229-1-songmuchun@bytedance.com>
References: <20210609121310.62229-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the vmemmap is huge PMD mapped, we should split the huge PMD firstly
and then we can change the PTE page table entry. In this patch, we add
the ability of splitting the huge PMD mapping of vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  2 +-
 mm/hugetlb.c         | 42 ++++++++++++++++++++++++++++++++++--
 mm/hugetlb_vmemmap.c |  3 ++-
 mm/sparse-vmemmap.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cadc8cc2c715..b97e1486c5c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3056,7 +3056,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 void vmemmap_remap_free(unsigned long start, unsigned long end,
-			unsigned long reuse);
+			unsigned long reuse, struct list_head *pgtables);
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 			unsigned long reuse, gfp_t gfp_mask);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3b2a8a494d6..3137c72d9cc7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1609,6 +1609,13 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 static void __prep_new_huge_page(struct hstate *h, struct page *page)
 {
 	free_huge_page_vmemmap(h, page);
+	/*
+	 * Because we store preallocated pages on @page->lru,
+	 * vmemmap_pgtable_free() must be called before the
+	 * initialization of @page->lru in INIT_LIST_HEAD().
+	 */
+	vmemmap_pgtable_free(&page->lru);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
@@ -1775,14 +1782,29 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
+	LIST_HEAD(pgtables);
+
+	if (vmemmap_pgtable_prealloc(h, &pgtables))
+		return NULL;
 
 	if (hstate_is_gigantic(h))
 		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
 	else
 		page = alloc_buddy_huge_page(h, gfp_mask,
 				nid, nmask, node_alloc_noretry);
-	if (!page)
+	if (!page) {
+		vmemmap_pgtable_free(&pgtables);
 		return NULL;
+	}
+
+	/*
+	 * Use the huge page lru list to temporarily store the preallocated
+	 * pages. The preallocated pages are used and the list is emptied
+	 * before the huge page is put into use. When the huge page is put
+	 * into use by __prep_new_huge_page() the list will be reinitialized.
+	 */
+	INIT_LIST_HEAD(&page->lru);
+	list_splice(&pgtables, &page->lru);
 
 	if (hstate_is_gigantic(h))
 		prep_compound_gigantic_page(page, huge_page_order(h));
@@ -2417,6 +2439,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	int nid = page_to_nid(old_page);
 	struct page *new_page;
 	int ret = 0;
+	LIST_HEAD(pgtables);
+
+	if (vmemmap_pgtable_prealloc(h, &pgtables))
+		return -ENOMEM;
 
 	/*
 	 * Before dissolving the page, we need to allocate a new one for the
@@ -2426,8 +2452,15 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * under the lock.
 	 */
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
-	if (!new_page)
+	if (!new_page) {
+		vmemmap_pgtable_free(&pgtables);
 		return -ENOMEM;
+	}
+
+	/* See the comments in alloc_fresh_huge_page(). */
+	INIT_LIST_HEAD(&new_page->lru);
+	list_splice(&pgtables, &new_page->lru);
+
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2711,6 +2744,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, huge_page_order(h));
 		WARN_ON(PageReserved(page));
+		gigantic_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -2763,6 +2797,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			break;
 		cond_resched();
 	}
+
+	if (hstate_is_gigantic(h))
+		i -= gigantic_vmemmap_pgtable_prealloc();
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6f3a47b4ebd3..01f3652fa359 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -375,7 +375,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
+	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse,
+			   &head->lru);
 
 	SetHPageVmemmapOptimized(head);
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 693de0aec7a8..fedb3f56110c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -42,6 +42,8 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @pgtables:		the list of page tables which is used for splitting huge
+ *			PMD page tables.
  */
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -49,8 +51,49 @@ struct vmemmap_remap_walk {
 	struct page *reuse_page;
 	unsigned long reuse_addr;
 	struct list_head *vmemmap_pages;
+	struct list_head *pgtables;
 };
 
+#define VMEMMAP_HPMD_ORDER		(PMD_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPMD_NR			(1 << VMEMMAP_HPMD_ORDER)
+
+static inline pte_t *pte_withdraw(struct vmemmap_remap_walk *walk)
+{
+	pgtable_t pgtable;
+
+	pgtable = list_first_entry(walk->pgtables, struct page, lru);
+	list_del(&pgtable->lru);
+
+	return page_to_virt(pgtable);
+}
+
+static void split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				   struct vmemmap_remap_walk *walk)
+{
+	int i;
+	pmd_t tmp;
+	pte_t *new = pte_withdraw(walk);
+	struct page *page = pmd_page(*pmd);
+	unsigned long addr = start;
+
+	pmd_populate_kernel(&init_mm, &tmp, new);
+
+	for (i = 0; i < VMEMMAP_HPMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t entry, *pte;
+		pgprot_t pgprot = PAGE_KERNEL;
+
+		entry = mk_pte(page + i, pgprot);
+		pte = pte_offset_kernel(&tmp, addr);
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+
+	/* Make pte visible before pmd. See comment in __pte_alloc(). */
+	smp_wmb();
+	pmd_populate_kernel(&init_mm, pmd, new);
+
+	flush_tlb_kernel_range(start, start + PMD_SIZE);
+}
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -84,8 +127,8 @@ static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		BUG_ON(pmd_leaf(*pmd));
-
+		if (pmd_leaf(*pmd))
+			split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
 		next = pmd_addr_end(addr, end);
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
@@ -192,18 +235,17 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
- *
- * Note: This function depends on vmemmap being base page mapped. Please make
- * sure that we disable PMD mapping of vmemmap pages when calling this function.
+ * @pgtables:	the list of page tables used for splitting huge PMD.
  */
 void vmemmap_remap_free(unsigned long start, unsigned long end,
-			unsigned long reuse)
+			unsigned long reuse, struct list_head *pgtables)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.pgtables	= pgtables,
 	};
 
 	/*
@@ -221,7 +263,10 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
+	mmap_write_lock(&init_mm);
 	vmemmap_remap_range(reuse, end, &walk);
+	mmap_write_unlock(&init_mm);
+
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -287,12 +332,12 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 	/* See the comment in the vmemmap_remap_free(). */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
-
 	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
 		return -ENOMEM;
 
+	mmap_read_lock(&init_mm);
 	vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
 
 	return 0;
 }
-- 
2.11.0

