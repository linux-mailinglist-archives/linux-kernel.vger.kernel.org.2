Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8345A4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhKWOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:14:24 -0500
Received: from foss.arm.com ([217.140.110.172]:53586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhKWOOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:14:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50E8F1042;
        Tue, 23 Nov 2021 06:11:02 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36C483F66F;
        Tue, 23 Nov 2021 06:11:01 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com
Subject: [PATCH 5/9] iommu/amd: Use put_pages_list
Date:   Tue, 23 Nov 2021 14:10:40 +0000
Message-Id: <9d7302362620fce339013948b87b43c762219d94.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1637671820.git.robin.murphy@arm.com>
References: <cover.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page->freelist is for the use of slab.  We already have the ability
to free a list of pages in the core mm, but it requires the use of a
list_head and for the pages to be chained together through page->lru.
Switch the AMD IOMMU code over to using free_pages_list().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[rm: split from original patch, cosmetic tweaks]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/io_pgtable.c | 50 ++++++++++++----------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index f92ecb3e21d7..be2eba61b4d3 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -74,26 +74,14 @@ static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
  *
  ****************************************************************************/
 
-static void free_page_list(struct page *freelist)
-{
-	while (freelist != NULL) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
-static struct page *free_pt_page(u64 *pt, struct page *freelist)
+static void free_pt_page(u64 *pt, struct list_head *freelist)
 {
 	struct page *p = virt_to_page(pt);
 
-	p->freelist = freelist;
-
-	return p;
+	list_add_tail(&p->lru, freelist);
 }
 
-static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
+static void free_pt_lvl(u64 *pt, struct list_head *freelist, int lvl)
 {
 	u64 *p;
 	int i;
@@ -110,22 +98,22 @@ static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
 
 		p = IOMMU_PTE_PAGE(pt[i]);
 		if (lvl > 2)
-			freelist = free_pt_lvl(p, freelist, lvl - 1);
+			free_pt_lvl(p, freelist, lvl - 1);
 		else
-			freelist = free_pt_page(p, freelist);
+			free_pt_page(p, freelist);
 	}
 
-	return free_pt_page(pt, freelist);
+	free_pt_page(pt, freelist);
 }
 
-static struct page *free_sub_pt(u64 *root, int mode, struct page *freelist)
+static void free_sub_pt(u64 *root, int mode, struct list_head *freelist)
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
 	case PAGE_MODE_7_LEVEL:
 		break;
 	case PAGE_MODE_1_LEVEL:
-		freelist = free_pt_page(root, freelist);
+		free_pt_page(root, freelist);
 		break;
 	case PAGE_MODE_2_LEVEL:
 	case PAGE_MODE_3_LEVEL:
@@ -137,8 +125,6 @@ static struct page *free_sub_pt(u64 *root, int mode, struct page *freelist)
 	default:
 		BUG();
 	}
-
-	return freelist;
 }
 
 void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
@@ -346,7 +332,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	return pte;
 }
 
-static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
+static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *freelist)
 {
 	u64 *pt;
 	int mode;
@@ -357,12 +343,12 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 	}
 
 	if (!IOMMU_PTE_PRESENT(pteval))
-		return freelist;
+		return;
 
 	pt   = IOMMU_PTE_PAGE(pteval);
 	mode = IOMMU_PTE_MODE(pteval);
 
-	return free_sub_pt(pt, mode, freelist);
+	free_sub_pt(pt, mode, freelist);
 }
 
 /*
@@ -376,7 +362,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-	struct page *freelist = NULL;
+	LIST_HEAD(freelist);
 	bool updated = false;
 	u64 __pte, *pte;
 	int ret, i, count;
@@ -396,9 +382,9 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 		goto out;
 
 	for (i = 0; i < count; ++i)
-		freelist = free_clear_pte(&pte[i], pte[i], freelist);
+		free_clear_pte(&pte[i], pte[i], &freelist);
 
-	if (freelist != NULL)
+	if (!list_empty(&freelist))
 		updated = true;
 
 	if (count > 1) {
@@ -433,7 +419,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 	}
 
 	/* Everything flushed out, free pages now */
-	free_page_list(freelist);
+	put_pages_list(&freelist);
 
 	return ret;
 }
@@ -495,7 +481,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 {
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 	struct protection_domain *dom;
-	struct page *freelist = NULL;
+	LIST_HEAD(freelist);
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
@@ -512,9 +498,9 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
-	freelist = free_sub_pt(pgtable->root, pgtable->mode, freelist);
+	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
 
-	free_page_list(freelist);
+	put_pages_list(&freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-- 
2.28.0.dirty

