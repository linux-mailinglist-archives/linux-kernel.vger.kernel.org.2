Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115573C816B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhGNJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbhGNJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:24:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D24C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w15so1729276pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHQ3UvG1NNiOhOhJEGNTO4n34RD5RRdHyAt+lnuFQLI=;
        b=WELaa2RK46XiADUxU3quNuzD9662ygUCVhhbjtda8omNkOohW/DMkiS47ZNM3yIE6T
         A89US0SlOT+pZExbPgBxQ3r9xCvLQT86D0shi460DJFcxDTR93RiltUyFLuJV5Wb1SSJ
         wGV5Qj9VhEKeTqWA8LLP/k8FcyfSsnmnt+0loUqa4TxsOq0t/1IfyGfiPxWUKCWejUUC
         AuHBKMtpCOJeMXXYzxW6hJFeag6+IjKT9ewx+PRMkJyBtszUe365+pBoWILAv5qhJVxd
         qJAybAwRjJOzBxEW5h3LxDYB0rdsAEBK1y5v+wzzAZMsS0MgRZw+WimvdFH99UTs3eHL
         fjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHQ3UvG1NNiOhOhJEGNTO4n34RD5RRdHyAt+lnuFQLI=;
        b=Rjeh/IVbK50VRaiicjtUecvX0RSVgbRCiHCS63e41V4I5nItxfRDA12+psbT1LD2RG
         AoeIlsoFAeRX4eBclXhmjHTfxSD6Wa1ytwHvYUtHhXmqPVnsOR28DeyHbIukvS0cQKHO
         O8r8i5lkDVew3zNshExBIUK6wq9L2UIAFe7+z6XhSt0kYPmOPiAFMDLinzXEArhZVUOn
         l8nLL7JYTbk7pqvZMphCJqIvGZHgfM75DeuLXBQSCFvXSHJE3z7A3DPYXMtP+Rd8C6nd
         DJZFgQ1o3yrOYN4ApefKNFpbMHG6GTGzTT7IQkDl+DhabHxpaCtkCdXVQNmtRu+KCI5j
         8V9A==
X-Gm-Message-State: AOAM533/6mkoCZkqagIsl5NoxbEvZ4jt4j2UtbKtm+eZcOuVGhoBl21x
        UKPqUmEJX8MatJeWflRHaVfwxQ==
X-Google-Smtp-Source: ABdhPJy9chGaNLVX+RdVyyubqXA+C48qkxYganCEOkLvGOWpbpJLMAFka36uZsYXg21zkcRPGahIhw==
X-Received: by 2002:a63:580a:: with SMTP id m10mr8633458pgb.254.1626254470267;
        Wed, 14 Jul 2021 02:21:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:21:09 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/5] mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page
Date:   Wed, 14 Jul 2021 17:17:58 +0800
Message-Id: <20210714091800.42645-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210714091800.42645-1-songmuchun@bytedance.com>
References: <20210714091800.42645-1-songmuchun@bytedance.com>
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
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 include/linux/page-flags.h                      | 97 ++++++++++++++++++++++++-
 include/trace/events/mmflags.h                  |  3 +-
 mm/hugetlb_vmemmap.c                            | 60 ++++++++-------
 mm/sparse-vmemmap.c                             | 21 ++++++
 5 files changed, 150 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..a154a7b3b9a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1606,7 +1606,7 @@
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 			enabled.
 			Allows heavy hugetlb users to free up some more
-			memory (6 * PAGE_SIZE for each 2MB hugetlb page).
+			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
 			Format: { on | off (default) }
 
 			on:  enable the feature
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 358d3f6fa976..d29c16f7b176 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -182,25 +182,102 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+extern bool hugetlb_free_vmemmap_enabled;
+
+/*
+ * If the feature of freeing some vmemmap pages associated with each HugeTLB
+ * page is enabled, the head vmemmap page frame is reused and all of the tail
+ * vmemmap addresses map to the head vmemmap page frame (furture details can
+ * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
+ * word, there are more than one page struct with PG_head associated with each
+ * HugeTLB page.  We __know__ that there is only one head page struct, the tail
+ * page structs with PG_head are fake head page structs.  We need an approach
+ * to distinguish between those two different types of page structs so that
+ * compound_head() can return the real head page struct when the parameter is
+ * the tail page struct but with PG_head. This is what page_head_if_fake()
+ * does.
+ *
+ * The page_head_if_fake() returns the real head page struct iff the @page may
+ * be fake, otherwise, returns NULL if the @page cannot be a fake page struct.
+ * The following figure describes how to distinguish between real and fake head
+ * page struct.
+ *
+ *	if (test_bit(PG_head, &page->flags)) {
+ *		unsigned long head = READ_ONCE(page[1].compound_head);
+ *
+ *		if (head & 1) {
+ *			if (head == (unsigned long)page + 1)
+ *				==> head page struct
+ *			else
+ *				==> tail page struct
+ *		} else
+ *			==> head page struct
+ *	} else
+ *		==> cannot be fake head page struct
+ *
+ * We can safely access the field of the @page[1] with PG_head because it means
+ * that the @page is a compound page composed with at least two contiguous
+ * pages.
+ */
+static __always_inline struct page *page_head_if_fake(const struct page *page)
+{
+	if (!hugetlb_free_vmemmap_enabled)
+		return NULL;
+
+	/*
+	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
+	 * struct page. The alignment check aims to avoid access the fields (
+	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
+	 * cold cacheline in some cases.
+	 */
+	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
+	    test_bit(PG_head, &page->flags)) {
+		unsigned long head = READ_ONCE(page[1].compound_head);
+
+		if (likely(head & 1))
+			return (struct page *)(head - 1);
+	}
+
+	return NULL;
+}
+#else
+static __always_inline struct page *page_head_if_fake(const struct page *page)
+{
+	return NULL;
+}
+#endif
+
 static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
 	if (unlikely(head & 1))
 		return head - 1;
-	return (unsigned long)page;
+
+	head = (unsigned long)page_head_if_fake(page);
+
+	return head ? : (unsigned long)page;
 }
 
 #define compound_head(page)	((typeof(page))_compound_head(page))
 
 static __always_inline int PageTail(struct page *page)
 {
-	return READ_ONCE(page->compound_head) & 1;
+	struct page *head;
+
+	if (READ_ONCE(page->compound_head) & 1)
+		return 1;
+
+	head = page_head_if_fake(page);
+
+	return head ? head != page : 0;
 }
 
 static __always_inline int PageCompound(struct page *page)
 {
-	return test_bit(PG_head, &page->flags) || PageTail(page);
+	return test_bit(PG_head, &page->flags) ||
+	       READ_ONCE(page->compound_head) & 1;
 }
 
 #define	PAGE_POISON_PATTERN	-1l
@@ -578,7 +655,19 @@ static inline void set_page_writeback_keepwrite(struct page *page)
 	test_set_page_writeback_keepwrite(page);
 }
 
-__PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
+static __always_inline int PageHead(struct page *page)
+{
+	struct page *head;
+
+	PF_POISONED_CHECK(page);
+	head = page_head_if_fake(page);
+
+	return head ? head == page : test_bit(PG_head, &page->flags);
+}
+
+__SETPAGEFLAG(Head, head, PF_ANY)
+__CLEARPAGEFLAG(Head, head, PF_ANY)
+CLEARPAGEFLAG(Head, head, PF_ANY)
 
 static __always_inline void set_compound_head(struct page *page, struct page *head)
 {
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 69cb84b1257e..a0f0fd82e3e0 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -122,7 +122,8 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)		\
 IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 
 #define save_page_flags(page)						\
-	(((page)->flags & ~PAGEFLAGS_MASK))
+	(PageHead(page) ? ((page)->flags & ~PAGEFLAGS_MASK) :		\
+	 ((page)->flags & ~(PAGEFLAGS_MASK | PG_head_mask)))
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c540c21e26f5..527bcaa44a48 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -124,9 +124,9 @@
  * page of page structs (page 0) associated with the HugeTLB page contains the 4
  * page structs necessary to describe the HugeTLB. The only use of the remaining
  * pages of page structs (page 1 to page 7) is to point to page->compound_head.
- * Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
+ * Therefore, we can remap pages 1 to 7 to page 0. Only 1 pages of page structs
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
+ * size of the struct page structs is greater than 1 pages.
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
index bdce883f9286..62e3d20648ce 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -53,6 +53,17 @@ struct vmemmap_remap_walk {
 	struct list_head *vmemmap_pages;
 };
 
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
 static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 				  struct vmemmap_remap_walk *walk)
 {
@@ -245,6 +256,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
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

