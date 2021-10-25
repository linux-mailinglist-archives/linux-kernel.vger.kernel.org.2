Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87E43A80C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhJYXSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJYXSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:18:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9AEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:16:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so157315pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=/bKrmeIchLWd2UwSF/qUuONddfUmW97o7hXpLTBF4jA=;
        b=XDb8wea8TT9IXEqxNxrm+O7D4EEBiO38CiHzTeqMegRj+XFxSWCGNx/nDZoHlhgu7W
         ZeDWHXrMjcydLfD7r/uij4fpb20MqCzYElEaM8Xl6GWRNbd5tcK0vmRFdsqNOW71EXB5
         Va483TTEW/ER29LCnMcm9rMJUvgnw6xP+qAhMxXY6/tbBROIthV8lPHcp50gmkWjkESZ
         uBeLBWn1y7vBbs2NYGhhxpQYSes86oJSYt4pedBo1XvGXxjuU/lL9P4xXBRB+4XfPy6X
         8yBykxy6lTSahjvHX/g53f7S5QAaZeCoIBlH5I0Td6pXLaoWRzDmOKI/oapdvO3yqYAo
         69Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=/bKrmeIchLWd2UwSF/qUuONddfUmW97o7hXpLTBF4jA=;
        b=juBsn35G02484EvZlC3pJVVSvxtGxatiDMJyDq5FYUaVli6Eqy/2khMRHTIN7UDEcS
         2hQX0DpbR8tZEerZOVuOgBNj4CGD5NhSOVaDc+UOi1agnsDi48E9IlM5zyoB6qwDLyiS
         HW6cuqOSj89S2TX+hZDyHA1B3izjAFcra7dhFC9D9cUUYLhvhcUzgbHbYiU5tR784+22
         v5SR9EMbTUn76AaPgEGCBZnLJ7l172nhvfH0GZ6youdf0j9FN5DxqwfqDA6mnmXywl1E
         3sbAxZ/KeWD/SusJhLfgFeNxX6e7mYH1WwfVXBINHjEokXev4N+26kAuDGLh1zw+7tKW
         IBoQ==
X-Gm-Message-State: AOAM533xDGFOD45HaVNR4XGkou6XHwI2k1mCi/cdxHpoz1r4zT5eEWVq
        5fgldBxwgZP1pkaObAnUYw==
X-Google-Smtp-Source: ABdhPJzRMlpAXV8LLTGGWR9u86qn4lewfa5UEy1w+YcnMmMTZXj6r/lUs7pjikWTR0chAovLk7o48A==
X-Received: by 2002:a17:90a:4283:: with SMTP id p3mr18813750pjg.23.1635203782587;
        Mon, 25 Oct 2021 16:16:22 -0700 (PDT)
Received: from u2004 ([2407:c800:3f11:740:8ea1:3c5:6c2d:e5c9])
        by smtp.gmail.com with ESMTPSA id gq15sm8069524pjb.42.2021.10.25.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:16:22 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Date:   Tue, 26 Oct 2021 08:16:18 +0900
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mm/hwpoison: fix unpoison_memory()
Message-ID: <20211025231618.GA2651507@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
X-Mutt-References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
X-Mutt-Fcc: =Sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

After recent soft-offline rework, error pages can be taken off from
buddy allocator, but the existing unpoison_memory() does not properly
undo the operation.  Moreover, due to the recent change on
__get_hwpoison_page(), get_page_unless_zero() is hardly called for
hwpoisoned pages.  So __get_hwpoison_page() highly likely returns zero
(meaning to fail to grab page refcount) and unpoison just clears
PG_hwpoison without releasing a refcount.  That does not lead to a
critical issue like kernel panic, but unpoisoned pages never get back to
buddy (leaked permanently), which is not good.

To (partially) fix this, we need to identify "taken off" pages from
other types of hwpoisoned pages.  We can't use refcount or page flags
for this purpose, so a pseudo flag is defined by hacking ->private
field.  Someone might think that put_page() is enough to cancel
taken-off pages, but the normal free path contains some operations not
suitable for the current purpose, and can fire VM_BUG_ON().

Note that unpoison_memory() is now supposed to be cancel hwpoison events
injected only by madvise() or /sys/devices/system/memory/{hard,soft}_offline_page,
not by MCE injection, so please don't try to use unpoison when testing
with MCE injection.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v2:
- unpoison_memory() returns as commented
- explicitly avoids unpoisoning slab pages
- separates internal pinning function into __get_unpoison_page()
---
 include/linux/mm.h         |   1 +
 include/linux/page-flags.h |   4 ++
 mm/memory-failure.c        | 104 ++++++++++++++++++++++++++++++-------
 mm/page_alloc.c            |  23 ++++++++
 4 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 71d886470d71..c7ad3fdfee7c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3219,6 +3219,7 @@ enum mf_flags {
 	MF_ACTION_REQUIRED = 1 << 1,
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
+	MF_UNPOISON = 1 << 4,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b78f137acc62..8add006535f6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -522,7 +522,11 @@ PAGEFLAG_FALSE(Uncached, uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
+#define MAGIC_HWPOISON	0x4857504f49534f4e
+extern void SetPageHWPoisonTakenOff(struct page *page);
+extern void ClearPageHWPoisonTakenOff(struct page *page);
 extern bool take_page_off_buddy(struct page *page);
+extern bool take_page_back_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 09f079987928..a6f80a670012 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1160,6 +1160,22 @@ static int page_action(struct page_state *ps, struct page *p,
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
@@ -1262,6 +1278,27 @@ static int get_any_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
+static int __get_unpoison_page(struct page *page)
+{
+	struct page *head = compound_head(page);
+	int ret = 0;
+	bool hugetlb = false;
+
+	ret = get_hwpoison_huge_page(head, &hugetlb);
+	if (hugetlb)
+		return ret;
+
+	/*
+	 * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
+	 * but also isolated from buddy freelist, so need to identify the
+	 * state and have to cancel both operations to unpoison.
+	 */
+	if (PageHWPoisonTakenOff(head))
+		return -EHWPOISON;
+
+	return get_page_unless_zero(head) ? 1 : 0;
+}
+
 /**
  * get_hwpoison_page() - Get refcount for memory error handling
  * @p:		Raw error page (hit by memory error)
@@ -1278,18 +1315,26 @@ static int get_any_page(struct page *p, unsigned long flags)
  * extra care for the error page's state (as done in __get_hwpoison_page()),
  * and has some retry logic in get_any_page().
  *
+ * When called from unpoison_memory(), the caller should already ensure that
+ * the given page has PG_hwpoison. So it's never reused for other page
+ * allocations, and __get_unpoison_page() never races with them.
+ *
  * Return: 0 on failure,
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
+		ret = __get_unpoison_page(p);
+	else
+		ret = get_any_page(p, flags);
 	zone_pcp_enable(page_zone(p));
 
 	return ret;
@@ -1942,6 +1987,26 @@ core_initcall(memory_failure_init);
 		pr_info(fmt, pfn);			\
 })
 
+static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
+{
+	if (TestClearPageHWPoison(p)) {
+		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
+				 page_to_pfn(p), rs);
+		num_poisoned_pages_dec();
+		return 0;
+	}
+	return -EBUSY;
+}
+
+static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
+					  struct page *p)
+{
+	if (take_page_back_buddy(p) && !clear_page_hwpoison(rs, p))
+		return 0;
+	else
+		return -EBUSY;
+}
+
 /**
  * unpoison_memory - Unpoison a previously poisoned page
  * @pfn: Page number of the to be unpoisoned page
@@ -1958,9 +2023,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct page *page;
 	struct page *p;
-	int freeit = 0;
-	int ret = 0;
-	unsigned long flags = 0;
+	int ret = -EBUSY;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -1996,24 +2059,27 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!get_hwpoison_page(p, flags)) {
-		if (TestClearPageHWPoison(p))
-			num_poisoned_pages_dec();
-		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
-				 pfn, &unpoison_rs);
+	if (PageSlab(page))
 		goto unlock_mutex;
-	}
 
-	if (TestClearPageHWPoison(page)) {
-		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-				 pfn, &unpoison_rs);
-		num_poisoned_pages_dec();
-		freeit = 1;
-	}
+	ret = get_hwpoison_page(p, MF_UNPOISON);
+	if (!ret) {
+		ret = clear_page_hwpoison(&unpoison_rs, p);
+	} else if (ret < 0) {
+		if (ret == -EHWPOISON) {
+			ret = unpoison_taken_off_page(&unpoison_rs, p);
+		} else
+			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
+					 pfn, &unpoison_rs);
+	} else {
+		int freeit = clear_page_hwpoison(&unpoison_rs, p);
 
-	put_page(page);
-	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
 		put_page(page);
+		if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1)) {
+			put_page(page);
+			ret = 0;
+		}
+	}
 
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4ea590646f89..b6e4cbb44c54 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9466,6 +9466,7 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
+			SetPageHWPoisonTakenOff(page);
 			if (!is_migrate_isolate(migratetype))
 				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
@@ -9477,4 +9478,26 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
+
+/*
+ * Cancel takeoff done by take_page_off_buddy().
+ */
+bool take_page_back_buddy(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	int migratetype = get_pfnblock_migratetype(page, pfn);
+	bool ret = false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	if (put_page_testzero(page)) {
+		ClearPageHWPoisonTakenOff(page);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		ret = true;
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return ret;
+}
 #endif
-- 
2.25.1



On Tue, Oct 26, 2021 at 08:04:59AM +0900, Naoya Horiguchi wrote:
> Hi,
> 
> I updated unpoison fix patchset (sorry for long blank time since v1).
> 
> Main purpose of this series is to sync unpoison code to recent changes
> around how hwpoison code takes page refcount.  Unpoison should work or
> simply fail (without crash) if impossible.
> 
> The recent works of keeping hwpoison pages in shmem pagecache introduce
> a new state of hwpoisoned pages, but unpoison for such pages is not
> supported yet with this series.
> 
> It seems that soft-offline and unpoison can be used as general purpose
> page offline/online mechanism (not in the context of memory error). I
> think that we need some additional works to realize it because currently
> soft-offline and unpoison are assumed not to happen so frequently
> (print out too many messages for aggressive usecases). But anyway this
> could be another interesting next topic.
> 
> v1: https://lore.kernel.org/linux-mm/20210614021212.223326-1-nao.horiguchi@gmail.com/
> 
> Thanks,
> Naoya Horiguchi
> ---
> Summary:
> 
> Naoya Horiguchi (4):
>       mm/hwpoison: mf_mutex for soft offline and unpoison
>       mm/hwpoison: remove race consideration
>       mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
>       mm/hwpoison: fix unpoison_memory()
> 
>  include/linux/mm.h         |   3 +-
>  include/linux/page-flags.h |   4 ++
>  include/ras/ras_event.h    |   2 -
>  mm/memory-failure.c        | 166 ++++++++++++++++++++++++++++-----------------
>  mm/page_alloc.c            |  23 +++++++
>  5 files changed, 130 insertions(+), 68 deletions(-)

To: 
Cc: 
Bcc: nao.horiguchi@gmail.com
Subject: 
Reply-To: 

