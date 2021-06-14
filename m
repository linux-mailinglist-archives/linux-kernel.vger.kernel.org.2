Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE43A5B86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhFNCPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:15:55 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35402 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhFNCPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:15:53 -0400
Received: by mail-pl1-f182.google.com with SMTP id x19so5749075pln.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrhZvM3Zxn4NDLb/x2HzFv6RdjLYg2a3k6nkC/VHHoU=;
        b=FB6EvOE47KvKGS/eQwyikx8cKwYB8vvHOycaPK/IEurOyKzougUrGpf006LE8yekvk
         ZBi6gfzkzGImxrNgmmhy3K9RNXcqm68RTNlQYn6RvB40Tv1I6DWBPtFJfVhZm4YfXlcI
         7lAR/FfsYvFl/SYZnHoByQw7VRuyydaJiV04KvvIoe5mVNvDLHkvcZpcEgsnF2AFNcKV
         VHO2IA8LjfsJVT1GMXkeFY01hOXgLsvBuuFOAYJQhDQwhQPxGD3/yeDDpM1lILiJLY0K
         gs+vJPA63rMzmsHTrhetuxnX433zw3yL79gqha1IXukUcLLW/0VX3du3wE9kc/dnwD3n
         9Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrhZvM3Zxn4NDLb/x2HzFv6RdjLYg2a3k6nkC/VHHoU=;
        b=NWCN9NNAq5QfVgHyixDExSsxIl+ReD80uBze6mysCyq4LIfFCeA+EO+wE/prHH/UBm
         WIZiXRhf4TM+Dszq9GMPT3DCZVKaTIBJ8rhxOyJy45kIw4BRTjaqoPO7qHAhD8j4enAw
         Sg/4u1xkbmozHfeWelT0cbXVk10dGyZgyD1QQ0e17zZHZi0ynMoXfB+RWp97EkVP72f2
         CJpwhsazluFy32vq/oQeZ9xMp+jW8fC6TR6S0eid64Fw/PCZZzMXRKCjveKH70024gnO
         05l0KUvUcxoC7jKstz9De1R5sf+l/JNCvnGMX7h0r1KvarWerTzOibnOl5wU722SLL4s
         s4QA==
X-Gm-Message-State: AOAM531GDQlXHPqn31ZwiMkyO0u99PNcGigbSLsaUR0sLWj3JyTq6zek
        fYL5ij3bgi8+wXsbfN0S0A==
X-Google-Smtp-Source: ABdhPJzORIxMD2qAA7ztYofQzs2tEKCNw11G+uyCPsBVMLYOKhLKBn2Z0A0CjJAliCmOqWZAF5B7tg==
X-Received: by 2002:a17:90a:bb11:: with SMTP id u17mr20583831pjr.57.1623636762125;
        Sun, 13 Jun 2021 19:12:42 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:41 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] mm/hwpoison: fix unpoison_memory()
Date:   Mon, 14 Jun 2021 11:12:12 +0900
Message-Id: <20210614021212.223326-7-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

After recent soft-offline rework, error pages can be taken off from
buddy allocator, but the existing unpoison_memory() does not properly
undo the operation.  Moreover, due to the recent change on
__get_hwpoison_page(), get_page_unless_zero() is hardly called for
hwpoisoned pages.  So __get_hwpoison_page() mostly returns zero (meaning
to fail to grab page refcount) and unpoison just clears PG_hwpoison
without releasing a refcount.  That does not lead to a critical issue
like kernel panic, but unpoisoned pages never get back to buddy (leaked
permanently), which is not good.

To fix this, we need to identify "taken off" pages from other types of
hwpoisoned pages.  We can't use refcount or page flags for this purpose,
so a pseudo flag is defined by hacking ->private field.

Sometimes hwpoisoned pages can be still in-use, where the refcount should
be more than 1, so we can't unpoison them immediately and need to wait
until the all users release their refcount.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h         |  1 +
 include/linux/page-flags.h |  4 ++
 mm/memory-failure.c        | 84 ++++++++++++++++++++++++++++----------
 mm/page_alloc.c            | 19 +++++++++
 4 files changed, 86 insertions(+), 22 deletions(-)

diff --git v5.13-rc5/include/linux/mm.h v5.13-rc5_patched/include/linux/mm.h
index f1e3b82e1a93..0baf3fc97415 100644
--- v5.13-rc5/include/linux/mm.h
+++ v5.13-rc5_patched/include/linux/mm.h
@@ -3077,6 +3077,7 @@ enum mf_flags {
 	MF_ACTION_REQUIRED = 1 << 1,
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
+	MF_UNPOISON = 1 << 4,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git v5.13-rc5/include/linux/page-flags.h v5.13-rc5_patched/include/linux/page-flags.h
index 04a34c08e0a6..00bddb3a058d 100644
--- v5.13-rc5/include/linux/page-flags.h
+++ v5.13-rc5_patched/include/linux/page-flags.h
@@ -430,7 +430,11 @@ PAGEFLAG_FALSE(Uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
+#define MAGIC_HWPOISON	0x4857504f49534f4e
+extern void SetPageHWPoisonTakenOff(struct page *page);
+extern void ClearPageHWPoisonTakenOff(struct page *page);
 extern bool take_page_off_buddy(struct page *page);
+extern void take_page_back_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
 #define __PG_HWPOISON 0
diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index 0d51067f0129..41b0ef96e2aa 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -1105,6 +1105,22 @@ static int page_action(struct page_state *ps, struct page *p,
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 
+static inline bool PageHWPoisonTakenOff(struct page *page)
+{
+	return PageHWPoison(page) && page_private(page) == MAGIC_HWPOISON;
+}
+
+void SetPageHWPoisonTakenOff(struct page *page)
+{
+	set_page_private(page, MAGIC_HWPOISON);
+}
+
+void ClearPageHWPoisonTakenOff(struct page *page)
+{
+	if (PageHWPoison(page))
+		set_page_private(page, 0);
+}
+
 /*
  * Return true if a page type of a given page is supported by hwpoison
  * mechanism (while handling could fail), otherwise false.  This function
@@ -1117,7 +1133,7 @@ static inline bool HWPoisonHandlable(struct page *page)
 		PageSlab(page) || PageTable(page) || PageReserved(page);
 }
 
-static int __get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
 	struct page *head = compound_head(page);
 	int ret = 0;
@@ -1127,12 +1143,19 @@ static int __get_hwpoison_page(struct page *page)
 	if (hugetlb)
 		return ret;
 
+	/*
+	 * Finding taken-off pages, so it could be true only when called
+	 * from unpoison_memory().
+	 */
+	if (PageHWPoisonTakenOff(head))
+		return -EHWPOISON;
+
 	/*
 	 * This check prevents from calling get_hwpoison_unless_zero()
 	 * for any unsupported type of page in order to reduce the risk of
 	 * unexpected races caused by taking a page refcount.
 	 */
-	if (!HWPoisonHandlable(head))
+	if (!(flags & MF_UNPOISON) && !HWPoisonHandlable(head))
 		return 0;
 
 	if (PageTransHuge(head)) {
@@ -1171,7 +1194,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 try_again:
 	if (!count_increased) {
-		ret = __get_hwpoison_page(p);
+		ret = __get_hwpoison_page(p, flags);
 		if (!ret) {
 			if (page_count(p)) {
 				/* We raced with an allocation, retry. */
@@ -1190,6 +1213,8 @@ static int get_any_page(struct page *p, unsigned long flags)
 			if (pass++ < 3)
 				goto try_again;
 			goto out;
+		} else if (ret == -EHWPOISON) {
+			goto out;
 		}
 	}
 
@@ -1233,14 +1258,18 @@ static int get_any_page(struct page *p, unsigned long flags)
  *         1 on success for in-use pages in a well-defined state,
  *         -EIO for pages on which we can not handle memory errors,
  *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
- *         operations like allocation and free.
+ *         operations like allocation and free,
+ *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
  */
 static int get_hwpoison_page(struct page *p, unsigned long flags)
 {
 	int ret;
 
 	zone_pcp_disable(page_zone(p));
-	ret = get_any_page(p, flags);
+	if (flags & MF_UNPOISON)
+		ret = __get_hwpoison_page(p, flags);
+	else
+		ret = get_any_page(p, flags);
 	zone_pcp_enable(page_zone(p));
 
 	return ret;
@@ -1895,6 +1924,17 @@ core_initcall(memory_failure_init);
 		pr_info(fmt, pfn);			\
 })
 
+static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
+{
+	if (TestClearPageHWPoison(p)) {
+		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
+				 page_to_pfn(p), rs);
+		num_poisoned_pages_dec();
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * unpoison_memory - Unpoison a previously poisoned page
  * @pfn: Page number of the to be unpoisoned page
@@ -1911,9 +1951,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct page *page;
 	struct page *p;
-	int freeit = 0;
 	int ret = 0;
-	unsigned long flags = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -1949,24 +1987,26 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!get_hwpoison_page(p, flags)) {
-		if (TestClearPageHWPoison(p))
-			num_poisoned_pages_dec();
-		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
-				 pfn, &unpoison_rs);
+	ret = get_hwpoison_page(p, MF_UNPOISON);
+	if (!ret) {
+		clear_page_hwpoison(&unpoison_rs, p);
 		goto unlock_mutex;
-	}
-
-	if (TestClearPageHWPoison(page)) {
-		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-				 pfn, &unpoison_rs);
-		num_poisoned_pages_dec();
-		freeit = 1;
-	}
+	} else if (ret < 0) {
+		if (ret == -EHWPOISON) {
+			clear_page_hwpoison(&unpoison_rs, p);
+			take_page_back_buddy(p);
+			ret = 0;
+		} else
+			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
+					 pfn, &unpoison_rs);
+		goto unlock_mutex;
+	} else {
+		int freeit = clear_page_hwpoison(&unpoison_rs, p);
 
-	put_page(page);
-	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
 		put_page(page);
+		if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
+			put_page(page);
+	}
 
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
diff --git v5.13-rc5/mm/page_alloc.c v5.13-rc5_patched/mm/page_alloc.c
index d1f5de1c1283..325e91d92b7e 100644
--- v5.13-rc5/mm/page_alloc.c
+++ v5.13-rc5_patched/mm/page_alloc.c
@@ -9158,6 +9158,7 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
+			SetPageHWPoisonTakenOff(page);
 			if (!is_migrate_isolate(migratetype))
 				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
@@ -9169,4 +9170,22 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
+
+/*
+ * Cancel takeoff done by take_page_off_buddy().
+ */
+void take_page_back_buddy(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	int migratetype = get_pfnblock_migratetype(page, pfn);
+
+	spin_lock_irqsave(&zone->lock, flags);
+	if (put_page_testzero(page)) {
+		ClearPageHWPoisonTakenOff(page);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
 #endif
-- 
2.25.1

