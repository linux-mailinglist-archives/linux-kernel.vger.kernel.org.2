Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B83A4E10
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhFLJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:49:20 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44582 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhFLJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:49:12 -0400
Received: by mail-pj1-f54.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so7360055pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Un9OGrfbYYOOduOdmv+QQ9zUCVXg5KgaTJKOHZY1pLE=;
        b=Ls4kGmR2Uqf3cWDx+KcF3sAqPEOin+nodqRpP0W0qywtkFaJ+/iCI7rCUBz1oVXoa+
         k6Ur39cqmLQvNvotcH4+Q7CGbKeZ+fGooAf4P7JSC/NMksAlJ44wlK3kagAqMi95wSJk
         Hu/ayp693r6Gp0ky7La01r22hRLIUGUPINVUFO6zz8loXVgKCTCZzZK0G9c3hpmP+czp
         JVHxf5F0hFQAg6Vf/udr8/gXlekpbJ0igO54vgBB4fopx0PKuu1AhwXSxhsZsFQNxmbw
         izDI/Y/lWcAtbhcU09w60XfKZcEw0Nmi+zPe2tNifSiFV2fsDioW5/QMCwdzAKdK/qt2
         exaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Un9OGrfbYYOOduOdmv+QQ9zUCVXg5KgaTJKOHZY1pLE=;
        b=pe0IbuQVqlEeyX/Ks5iaHr9G7p2KXzShsaNqgoFai5nTDTmmX9jSba31FBMFapTVOi
         01eHp/8uwMjmXW5MJ6YoLMSWDueZ8YyXDyBZ7J0S8/MkrwpjFqVMcn4p+Mvu4JhhaQA7
         WXzWz818sJT+z3cj2zyNsSdd7MjMYyz4q6KEqOqtzr0oQb5edqY/F+i/qwHOU4b7thzQ
         HuqYiRqGzmL/T+W6Kzi5e/9kxNI+bhFlkSkmURP8jZ73aCdr7H+Xr9LfaqNDky0x/kVd
         1AtIX2L73KtcgGpdI3kgux4WHUBC9MLdrkB93aa+fzUKKHeCbu6ngNAoAXy6VjORz8aS
         +oDA==
X-Gm-Message-State: AOAM531ZIFyRkLlyI9Zxifd2HiPYCCN1/oxD7L4TDZnrn+9mZ/QBevEp
        pVuI46U2KCOHAhv1viIpJSaAaA==
X-Google-Smtp-Source: ABdhPJz5QQVgV01ntip77zgYCTfnUIdmUJT8IdqfSP3wRqf4wN12CDMhe/0lFlsj4YKjHMtwfOHrfQ==
X-Received: by 2002:a17:902:7085:b029:114:eb3f:fe29 with SMTP id z5-20020a1709027085b0290114eb3ffe29mr7937121plk.40.1623491172734;
        Sat, 12 Jun 2021 02:46:12 -0700 (PDT)
Received: from localhost.tiktokd.org ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id t39sm6929557pfg.147.2021.06.12.02.46.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:46:12 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/3] mm: sparsemem: split the huge PMD mapping of vmemmap pages
Date:   Sat, 12 Jun 2021 17:45:53 +0800
Message-Id: <20210612094555.71344-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210612094555.71344-1-songmuchun@bytedance.com>
References: <20210612094555.71344-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we disable huge PMD mapping of vmemmap pages when that feature
of "Free some vmemmap pages of HugeTLB pages" is enabled. If the vmemmap
is huge PMD mapped when we walk the vmemmap page tables, we split the
huge PMD firstly and then we move to PTE mappings. When HugeTLB pages are
freed from the pool we do not attempt coalasce and move back to a PMD
mapping because it is much more complex.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |   4 +-
 mm/hugetlb_vmemmap.c |   5 +-
 mm/sparse-vmemmap.c  | 157 ++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 123 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cadc8cc2c715..8284e8ed30c9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3055,8 +3055,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
-void vmemmap_remap_free(unsigned long start, unsigned long end,
-			unsigned long reuse);
+int vmemmap_remap_free(unsigned long start, unsigned long end,
+		       unsigned long reuse);
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 			unsigned long reuse, gfp_t gfp_mask);
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f9f9bb212319..06802056f296 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -258,9 +258,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
-
-	SetHPageVmemmapOptimized(head);
+	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+		SetHPageVmemmapOptimized(head);
 }
 
 void __init hugetlb_vmemmap_init(struct hstate *h)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 693de0aec7a8..7f73c37f742d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -38,6 +38,7 @@
  * vmemmap_remap_walk - walk vmemmap page table
  *
  * @remap_pte:		called for each lowest-level entry (PTE).
+ * @walked_pte:		the number of walked pte.
  * @reuse_page:		the page which is reused for the tail vmemmap pages.
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
@@ -46,11 +47,44 @@
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
 			  struct vmemmap_remap_walk *walk);
+	unsigned long walked_pte;
 	struct page *reuse_page;
 	unsigned long reuse_addr;
 	struct list_head *vmemmap_pages;
 };
 
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				  struct vmemmap_remap_walk *walk)
+{
+	pmd_t __pmd;
+	int i;
+	unsigned long addr = start;
+	struct page *page = pmd_page(*pmd);
+	pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
+
+	if (!pgtable)
+		return -ENOMEM;
+
+	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
+
+	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
+		pte_t entry, *pte;
+		pgprot_t pgprot = PAGE_KERNEL;
+
+		entry = mk_pte(page + i, pgprot);
+		pte = pte_offset_kernel(&__pmd, addr);
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+
+	/* Make pte visible before pmd. See comment in __pte_alloc(). */
+	smp_wmb();
+	pmd_populate_kernel(&init_mm, pmd, pgtable);
+
+	flush_tlb_kernel_range(start, start + PMD_SIZE);
+
+	return 0;
+}
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -68,59 +102,81 @@ static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 		 * walking, skip the reuse address range.
 		 */
 		addr += PAGE_SIZE;
+		walk->walked_pte++;
 		pte++;
 	}
 
-	for (; addr != end; addr += PAGE_SIZE, pte++)
+	for (; addr != end; addr += PAGE_SIZE, pte++) {
 		walk->remap_pte(pte, addr, walk);
+		walk->walked_pte++;
+	}
 }
 
-static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
-			      unsigned long end,
-			      struct vmemmap_remap_walk *walk)
+static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
 {
 	pmd_t *pmd;
 	unsigned long next;
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		BUG_ON(pmd_leaf(*pmd));
+		if (pmd_leaf(*pmd)) {
+			int ret;
 
+			ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
+			if (ret)
+				return ret;
+		}
 		next = pmd_addr_end(addr, end);
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
+
+	return 0;
 }
 
-static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
-			      unsigned long end,
-			      struct vmemmap_remap_walk *walk)
+static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
 {
 	pud_t *pud;
 	unsigned long next;
 
 	pud = pud_offset(p4d, addr);
 	do {
+		int ret;
+
 		next = pud_addr_end(addr, end);
-		vmemmap_pmd_range(pud, addr, next, walk);
+		ret = vmemmap_pmd_range(pud, addr, next, walk);
+		if (ret)
+			return ret;
 	} while (pud++, addr = next, addr != end);
+
+	return 0;
 }
 
-static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
-			      unsigned long end,
-			      struct vmemmap_remap_walk *walk)
+static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
 {
 	p4d_t *p4d;
 	unsigned long next;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
+		int ret;
+
 		next = p4d_addr_end(addr, end);
-		vmemmap_pud_range(p4d, addr, next, walk);
+		ret = vmemmap_pud_range(p4d, addr, next, walk);
+		if (ret)
+			return ret;
 	} while (p4d++, addr = next, addr != end);
+
+	return 0;
 }
 
-static void vmemmap_remap_range(unsigned long start, unsigned long end,
-				struct vmemmap_remap_walk *walk)
+static int vmemmap_remap_range(unsigned long start, unsigned long end,
+			       struct vmemmap_remap_walk *walk)
 {
 	unsigned long addr = start;
 	unsigned long next;
@@ -131,8 +187,12 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	pgd = pgd_offset_k(addr);
 	do {
+		int ret;
+
 		next = pgd_addr_end(addr, end);
-		vmemmap_p4d_range(pgd, addr, next, walk);
+		ret = vmemmap_p4d_range(pgd, addr, next, walk);
+		if (ret)
+			return ret;
 	} while (pgd++, addr = next, addr != end);
 
 	/*
@@ -141,6 +201,8 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
 	 * belongs to the range.
 	 */
 	flush_tlb_kernel_range(start + PAGE_SIZE, end);
+
+	return 0;
 }
 
 /*
@@ -179,10 +241,27 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	pte_t entry = mk_pte(walk->reuse_page, pgprot);
 	struct page *page = pte_page(*pte);
 
-	list_add(&page->lru, walk->vmemmap_pages);
+	list_add_tail(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
+static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
+				struct vmemmap_remap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	BUG_ON(pte_page(*pte) != walk->reuse_page);
+
+	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&page->lru);
+	to = page_to_virt(page);
+	copy_page(to, (void *)walk->reuse_addr);
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -193,12 +272,12 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
  *		remap.
  * @reuse:	reuse address.
  *
- * Note: This function depends on vmemmap being base page mapped. Please make
- * sure that we disable PMD mapping of vmemmap pages when calling this function.
+ * Return: %0 on success, negative error code otherwise.
  */
-void vmemmap_remap_free(unsigned long start, unsigned long end,
-			unsigned long reuse)
+int vmemmap_remap_free(unsigned long start, unsigned long end,
+		       unsigned long reuse)
 {
+	int ret;
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
@@ -221,25 +300,25 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	vmemmap_remap_range(reuse, end, &walk);
-	free_vmemmap_page_list(&vmemmap_pages);
-}
+	mmap_write_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_write_downgrade(&init_mm);
 
-static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
-				struct vmemmap_remap_walk *walk)
-{
-	pgprot_t pgprot = PAGE_KERNEL;
-	struct page *page;
-	void *to;
+	if (ret && walk.walked_pte) {
+		end = reuse + walk.walked_pte * PAGE_SIZE;
+		walk = (struct vmemmap_remap_walk) {
+			.remap_pte	= vmemmap_restore_pte,
+			.reuse_addr	= reuse,
+			.vmemmap_pages	= &vmemmap_pages,
+		};
 
-	BUG_ON(pte_page(*pte) != walk->reuse_page);
+		vmemmap_remap_range(reuse, end, &walk);
+	}
+	mmap_read_unlock(&init_mm);
 
-	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
-	list_del(&page->lru);
-	to = page_to_virt(page);
-	copy_page(to, (void *)walk->reuse_addr);
+	free_vmemmap_page_list(&vmemmap_pages);
 
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+	return ret;
 }
 
 static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
@@ -273,6 +352,8 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  *		remap.
  * @reuse:	reuse address.
  * @gpf_mask:	GFP flag for allocating vmemmap pages.
+ *
+ * Return: %0 on success, negative error code otherwise.
  */
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 			unsigned long reuse, gfp_t gfp_mask)
@@ -287,12 +368,12 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
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

