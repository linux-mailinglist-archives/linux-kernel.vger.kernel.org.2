Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231941AF33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbhI1MoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbhI1MoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC4C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k17so18826430pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHFkdXM8iGaiQF9JxET7MKJdg04YM15kcEjvmREQc6s=;
        b=6eAyRd7LXfrFDBAKrO3bgcS3SvLfDYkzaQERR4P+vGH1df8N7M2P1D+r2Wvtq3fDTz
         vP2apbNPxoVk6HrDq71HgpUCSIQIznOuUhcTggZaDM7u0BasF4Vvn0HzwvgnyKNhhCKk
         LLMoFD0a0P3RDQggC/sXwqyX3sMWSuME3k8TeV84xJaZc15OUaxcNzmyzMrj4YxBoOZC
         tHAcoO5AF6TNZ+nuK64Z6DB08Ahzm1Pk3o4MEL/K4qTHOP47BkWHguwkJCSsb0OnOAnC
         P6N3T5ydJUMoccMukYQQvv7KDhgFwni8V0ENOl8+dai/uerCl1gA895ra4GOzNWdffBF
         OK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHFkdXM8iGaiQF9JxET7MKJdg04YM15kcEjvmREQc6s=;
        b=0gcJaoyFvzw0ABDxpCnzYM0CeiyNj9lhaAbPyirQ7msggKBdCg2XXFlr476kYWRjHD
         T1HWURjL1T+PQtnmSN2HvSnp4qXS6GRjlaiznrBI6xAhqGy3MG/dzzafIqgJdVPkZyy7
         TYAplA3D2MgmLTrvoTR9LybNUITpXiJ1fvqaw50Cf8OiGm31fv3Adllq+tjBWbaaQQVs
         Z9jmOwRziQgyyk23+mYpLaDEulm51HPmJfhOm+ByMym9n+YneZH9xa8z/wfGBTKUzzmS
         /xS8Cu4DOb0RWdxFi/SSxcfyCTOcMAfTV4XZen9HjLYimqeg7yqbrISCQIIXevgesoxq
         H5bw==
X-Gm-Message-State: AOAM533Ww2qjEEgVc1AnTrI82zRjSIA4AmITJ8+5RRCacc3HCDAiO9Ez
        zPbqrIpPyIwgZHKeNFi9cwTyfw==
X-Google-Smtp-Source: ABdhPJwWdf1fEnYZV0mAaQ0wzXOdkShsMeGWnRSmz7e+EXYVOeePnLzDzsSark1KYoaNGZrNfHtNmw==
X-Received: by 2002:a63:f356:: with SMTP id t22mr1291241pgj.18.1632832960447;
        Tue, 28 Sep 2021 05:42:40 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:42:40 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 1/5] mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page
Date:   Tue, 28 Sep 2021 20:41:48 +0800
Message-Id: <20210928124152.33634-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210928124152.33634-1-songmuchun@bytedance.com>
References: <20210928124152.33634-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we only free 6 vmemmap pages associated with a 2MB HugeTLB
page. However, we can remap all tail vmemmap pages to the page frame
mapped to with the head vmemmap page. Finally, we can free 7 vmemmap
pages for a 2MB HugeTLB page. It is a fine gain (e.g. we can save
extra 2GB memory when there is 1TB HugeTLB pages in the system
compared with the current implementation).

But the head vmemmap page is not freed to the buddy allocator and all
tail vmemmap pages are mapped to the head vmemmap page frame. So we
can see more than one struct page struct with PG_head (e.g. 8 per 2 MB
HugeTLB page) associated with each HugeTLB page. We should adjust
compound_head() to make it returns the real head struct page when the
parameter is the tail struct page but with PG_head flag.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 include/linux/page-flags.h                      | 78 +++++++++++++++++++++++--
 mm/hugetlb_vmemmap.c                            | 60 ++++++++++---------
 mm/sparse-vmemmap.c                             | 21 +++++++
 4 files changed, 129 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..5aaf2f271980 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1617,7 +1617,7 @@
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 			enabled.
 			Allows heavy hugetlb users to free up some more
-			memory (6 * PAGE_SIZE for each 2MB hugetlb page).
+			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
 			Format: { on | off (default) }
 
 			on:  enable the feature
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 70bf0ec29ee3..7cd386538d0c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -184,13 +184,69 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+extern bool hugetlb_free_vmemmap_enabled;
+
+/*
+ * If the feature of freeing some vmemmap pages associated with each HugeTLB
+ * page is enabled, the head vmemmap page frame is reused and all of the tail
+ * vmemmap addresses map to the head vmemmap page frame (furture details can
+ * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
+ * words, there are more than one page struct with PG_head associated with each
+ * HugeTLB page.  We __know__ that there is only one head page struct, the tail
+ * page structs with PG_head are fake head page structs.  We need an approach
+ * to distinguish between those two different types of page structs so that
+ * compound_head() can return the real head page struct when the parameter is
+ * the tail page struct but with PG_head.
+ *
+ * The page_fixed_fake_head() returns the real head page struct if the @page is
+ * fake page head, otherwise, returns @page which can either be a true page
+ * head or tail.
+ */
+static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
+{
+	if (!hugetlb_free_vmemmap_enabled)
+		return page;
+
+	/*
+	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
+	 * struct page. The alignment check aims to avoid access the fields (
+	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
+	 * cold cacheline in some cases.
+	 */
+	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
+	    test_bit(PG_head, &page->flags)) {
+		/*
+		 * We can safely access the field of the @page[1] with PG_head
+		 * because the @page is a compound page composed with at least
+		 * two contiguous pages.
+		 */
+		unsigned long head = READ_ONCE(page[1].compound_head);
+
+		if (likely(head & 1))
+			return (const struct page *)(head - 1);
+	}
+	return page;
+}
+#else
+static inline const struct page *page_fixed_fake_head(const struct page *page)
+{
+	return page;
+}
+#endif
+
+static __always_inline int page_is_fake_head(struct page *page)
+{
+	return page_fixed_fake_head(page) != page;
+}
+
 static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
 	if (unlikely(head & 1))
 		return head - 1;
-	return (unsigned long)page;
+	return (unsigned long)page_fixed_fake_head(page);
 }
 
 #define compound_head(page)	((typeof(page))_compound_head(page))
@@ -225,12 +281,13 @@ static inline unsigned long _compound_head(const struct page *page)
 
 static __always_inline int PageTail(struct page *page)
 {
-	return READ_ONCE(page->compound_head) & 1;
+	return READ_ONCE(page->compound_head) & 1 || page_is_fake_head(page);
 }
 
 static __always_inline int PageCompound(struct page *page)
 {
-	return test_bit(PG_head, &page->flags) || PageTail(page);
+	return test_bit(PG_head, &page->flags) ||
+	       READ_ONCE(page->compound_head) & 1;
 }
 
 #define	PAGE_POISON_PATTERN	-1l
@@ -675,7 +732,20 @@ static inline bool test_set_page_writeback(struct page *page)
 	return set_page_writeback(page);
 }
 
-__PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
+static __always_inline bool folio_test_head(struct folio *folio)
+{
+	return test_bit(PG_head, folio_flags(folio, FOLIO_PF_ANY));
+}
+
+static __always_inline int PageHead(struct page *page)
+{
+	PF_POISONED_CHECK(page);
+	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
+}
+
+__SETPAGEFLAG(Head, head, PF_ANY)
+__CLEARPAGEFLAG(Head, head, PF_ANY)
+CLEARPAGEFLAG(Head, head, PF_ANY)
 
 /* Whether there are one or multiple pages in a folio */
 static inline bool folio_test_single(struct folio *folio)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c540c21e26f5..f4a8fca691ee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -124,9 +124,9 @@
  * page of page structs (page 0) associated with the HugeTLB page contains the 4
  * page structs necessary to describe the HugeTLB. The only use of the remaining
  * pages of page structs (page 1 to page 7) is to point to page->compound_head.
- * Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
+ * Therefore, we can remap pages 1 to 7 to page 0. Only 1 page of page structs
  * will be used for each HugeTLB page. This will allow us to free the remaining
- * 6 pages to the buddy allocator.
+ * 7 pages to the buddy allocator.
  *
  * Here is how things look after remapping.
  *
@@ -134,30 +134,30 @@
  * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  * |           |                     |     0     | -------------> |     0     |
  * |           |                     +-----------+                +-----------+
- * |           |                     |     1     | -------------> |     1     |
- * |           |                     +-----------+                +-----------+
- * |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- * |           |                     +-----------+                   | | | | |
- * |           |                     |     3     | ------------------+ | | | |
- * |           |                     +-----------+                     | | | |
- * |           |                     |     4     | --------------------+ | | |
- * |    PMD    |                     +-----------+                       | | |
- * |   level   |                     |     5     | ----------------------+ | |
- * |  mapping  |                     +-----------+                         | |
- * |           |                     |     6     | ------------------------+ |
- * |           |                     +-----------+                           |
- * |           |                     |     7     | --------------------------+
+ * |           |                     |     1     | ---------------^ ^ ^ ^ ^ ^ ^
+ * |           |                     +-----------+                  | | | | | |
+ * |           |                     |     2     | -----------------+ | | | | |
+ * |           |                     +-----------+                    | | | | |
+ * |           |                     |     3     | -------------------+ | | | |
+ * |           |                     +-----------+                      | | | |
+ * |           |                     |     4     | ---------------------+ | | |
+ * |    PMD    |                     +-----------+                        | | |
+ * |   level   |                     |     5     | -----------------------+ | |
+ * |  mapping  |                     +-----------+                          | |
+ * |           |                     |     6     | -------------------------+ |
+ * |           |                     +-----------+                            |
+ * |           |                     |     7     | ---------------------------+
  * |           |                     +-----------+
  * |           |
  * |           |
  * |           |
  * +-----------+
  *
- * When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
+ * When a HugeTLB is freed to the buddy system, we should allocate 7 pages for
  * vmemmap pages and restore the previous mapping relationship.
  *
  * For the HugeTLB page of the pud level mapping. It is similar to the former.
- * We also can use this approach to free (PAGE_SIZE - 2) vmemmap pages.
+ * We also can use this approach to free (PAGE_SIZE - 1) vmemmap pages.
  *
  * Apart from the HugeTLB page of the pmd/pud level mapping, some architectures
  * (e.g. aarch64) provides a contiguous bit in the translation table entries
@@ -166,7 +166,13 @@
  *
  * The contiguous bit is used to increase the mapping size at the pmd and pte
  * (last) level. So this type of HugeTLB page can be optimized only when its
- * size of the struct page structs is greater than 2 pages.
+ * size of the struct page structs is greater than 1 page.
+ *
+ * Notice: The head vmemmap page is not freed to the buddy allocator and all
+ * tail vmemmap pages are mapped to the head vmemmap page frame. So we can see
+ * more than one struct page struct with PG_head (e.g. 8 per 2 MB HugeTLB page)
+ * associated with each HugeTLB page. The compound_head() can handle this
+ * correctly (more details refer to the comment above compound_head()).
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
@@ -175,14 +181,16 @@
 /*
  * There are a lot of struct page structures associated with each HugeTLB page.
  * For tail pages, the value of compound_head is the same. So we can reuse first
- * page of tail page structures. We map the virtual addresses of the remaining
- * pages of tail page structures to the first tail page struct, and then free
- * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
+ * page of head page structures. We map the virtual addresses of all the pages
+ * of tail page structures to the head page struct, and then free these page
+ * frames. Therefore, we need to reserve one pages as vmemmap areas.
  */
-#define RESERVE_VMEMMAP_NR		2U
+#define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-bool hugetlb_free_vmemmap_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
+bool hugetlb_free_vmemmap_enabled __read_mostly =
+	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
+EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
@@ -236,7 +244,6 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 */
 	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
 				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
-
 	if (!ret)
 		ClearHPageVmemmapOptimized(head);
 
@@ -282,9 +289,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
-	 * The head page and the first tail page are not to be freed to buddy
-	 * allocator, the other pages will map to the first tail page, so they
-	 * can be freed.
+	 * The head page is not to be freed to buddy allocator, the other tail
+	 * pages will map to the head page, so they can be freed.
 	 *
 	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
 	 * on some architectures (e.g. aarch64). See Documentation/arm64/
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index db6df27c852a..e881f5db7091 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -245,6 +245,26 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
+/*
+ * How many struct page structs need to be reset. When we reuse the head
+ * struct page, the special metadata (e.g. page->flags or page->mapping)
+ * cannot copy to the tail struct page structs. The invalid value will be
+ * checked in the free_tail_pages_check(). In order to avoid the message
+ * of "corrupted mapping in tail page". We need to reset at least 3 (one
+ * head struct page struct and two tail struct page structs) struct page
+ * structs.
+ */
+#define NR_RESET_STRUCT_PAGE		3
+
+static inline void reset_struct_pages(struct page *start)
+{
+	int i;
+	struct page *from = start + NR_RESET_STRUCT_PAGE;
+
+	for (i = 0; i < NR_RESET_STRUCT_PAGE; i++)
+		memcpy(start + i, from, sizeof(*from));
+}
+
 static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 				struct vmemmap_remap_walk *walk)
 {
@@ -258,6 +278,7 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	list_del(&page->lru);
 	to = page_to_virt(page);
 	copy_page(to, (void *)walk->reuse_addr);
+	reset_struct_pages(to);
 
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
-- 
2.11.0

