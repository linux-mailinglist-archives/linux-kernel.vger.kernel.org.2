Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A3343433
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCUSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:52:41 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:30139 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCUSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:52:32 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 14:52:32 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 60C4042376;
        Sun, 21 Mar 2021 19:46:11 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PQ83JxXd;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DYYkbKdnSTuh; Sun, 21 Mar 2021 19:46:09 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 11C0141474;
        Sun, 21 Mar 2021 19:46:09 +0100 (CET)
Received: from localhost.localdomain (2.70.38.73.mobile.tre.se [2.70.38.73])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 33797361E5A;
        Sun, 21 Mar 2021 19:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616352368; bh=eIp5oHPDAcmaQRleCtZI+6MjuyOrnVz5ZEJhMg48fNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQ83JxXd/yVYagz6sx67TBDGljF2mEwjfTIVFv928dIHgfA4GwaNO+MXLPeRFMWdo
         hdLKCdJ9AwSB8a8T8cfCBNouOq8LIVNboC9LIv6jdRK4YaCKCXNl13mJBfxiF1SLUA
         5fIvG6eW8tTml8wQJbPkv3RRBJ6QpCwV6RCQwnk8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Date:   Sun, 21 Mar 2021 19:45:28 +0100
Message-Id: <20210321184529.59006-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210321184529.59006-1-thomas_os@shipmail.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTM sets up huge page-table-entries both to system- and device memory,
and we don't want gup to assume there are always valid backing struct
pages for these. For PTEs this is handled by setting the pte_special bit,
but for the huge PUDs and PMDs, we have neither pmd_special nor
pud_special. Normally, huge TTM entries are identified by looking at
vma_is_special_huge(), but fast gup can't do that, so as an alternative
define _devmap entries for which there are no backing dev_pagemap as
special, update documentation and make huge TTM entries _devmap, after
verifying that there is no backing dev_pagemap.

One other alternative would be to block TTM huge page-table-entries
completely, and while currently only vmwgfx use them, they would be
beneficial to other graphis drivers moving forward as well.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 17 ++++++++++++++++-
 mm/gup.c                        | 21 +++++++++++----------
 mm/memremap.c                   |  5 +++++
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 6dc96cf66744..1c34983480e5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -195,6 +195,7 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
 	pfn_t pfnt;
 	struct ttm_tt *ttm = bo->ttm;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	struct dev_pagemap *pagemap;
 
 	/* Fault should not cross bo boundary. */
 	page_offset &= ~(fault_page_size - 1);
@@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
 	if ((pfn & (fault_page_size - 1)) != 0)
 		goto out_fallback;
 
+	/*
+	 * Huge entries must be special, that is marking them as devmap
+	 * with no backing device map range. If there is a backing
+	 * range, Don't insert a huge entry.
+	 * If this check turns out to be too much of a performance hit,
+	 * we can instead have drivers indicate whether they may have
+	 * backing device map ranges and if not, skip this lookup.
+	 */
+	pagemap = get_dev_pagemap(pfn, NULL);
+	if (pagemap) {
+		put_dev_pagemap(pagemap);
+		goto out_fallback;
+	}
+
 	/* Check that memory is contiguous. */
 	if (!bo->mem.bus.is_iomem) {
 		for (i = 1; i < fault_page_size; ++i) {
@@ -223,7 +238,7 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
 		}
 	}
 
-	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
+	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV | PFN_MAP);
 	if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
 		ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..1b6a127f0bdd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1993,6 +1993,17 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 }
 
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+/*
+ * If we can't determine whether or not a pte is special, then fail immediately
+ * for ptes. Note, we can still pin HugeTLB as it is guaranteed not to be
+ * special. For THP, special huge entries are indicated by xxx_devmap()
+ * returning true, but a corresponding call to get_dev_pagemap() will
+ * return NULL.
+ *
+ * For a futex to be placed on a THP tail page, get_futex_key requires a
+ * get_user_pages_fast_only implementation that can pin pages. Thus it's still
+ * useful to have gup_huge_pmd even if we can't operate on ptes.
+ */
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
@@ -2069,16 +2080,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	return ret;
 }
 #else
-
-/*
- * If we can't determine whether or not a pte is special, then fail immediately
- * for ptes. Note, we can still pin HugeTLB and THP as these are guaranteed not
- * to be special.
- *
- * For a futex to be placed on a THP tail page, get_futex_key requires a
- * get_user_pages_fast_only implementation that can pin pages. Thus it's still
- * useful to have gup_huge_pmd even if we can't operate on ptes.
- */
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
diff --git a/mm/memremap.c b/mm/memremap.c
index 7aa7d6e80ee5..757551cd2a4d 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -471,6 +471,11 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
  *
  * If @pgmap is non-NULL and covers @pfn it will be returned as-is.  If @pgmap
  * is non-NULL but does not cover @pfn the reference to it will be released.
+ *
+ * Return: A referenced pointer to a struct dev_pagemap containing @pfn,
+ * or NULL if there was no such pagemap registered. For interpretion
+ * of NULL returns for pfns extracted from valid huge page table entries,
+ * please see gup_pte_range().
  */
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap)
-- 
2.30.2

