Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFEC445F81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 06:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhKEFzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 01:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhKEFzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 01:55:23 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E825C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 22:52:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636091562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MYrgk1h8uduabtXdyG/GIrSMU16cBLsfGYWNDjMmnM=;
        b=j6t3YQz1uktOVsvVU4lrNcDiD5tJ4ZFISoVwBjbtu2JaENXBmzWUFKasdlrNBO6ixeC8qg
        fCtG9FHSIrd2Cr3T+w1OjKJuPlHI6Qz1aoSHl1mO4m1/6JzL34aIEHXNQZaAIp2c5djWq8
        tF2+SfM6OZ4MXcokSMD1tLqdr7UFhPs=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
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
Subject: [PATCH v3 1/3] mm/hwpoison: mf_mutex for soft offline and unpoison
Date:   Fri,  5 Nov 2021 14:50:56 +0900
Message-Id: <20211105055058.3152564-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Originally mf_mutex is introduced to serialize multiple MCE events, but
it is not that useful to allow unpoison to run in parallel with memory_failure()
and soft offline.  So apply mf_they to soft offline and unpoison.
The memory failure handler and soft offline handler get simpler with this.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v3:
- merge with "mm/hwpoison: remove race consideration"
- update description

ChangeLog v2:
- add mutex_unlock() in "page already poisoned" path in soft_offline_page().
  (Thanks to Ding Hui)
---
 mm/memory-failure.c | 62 +++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e8c38e27b753..d29c79de6034 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1507,14 +1507,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
-	if (!PageHWPoison(head)) {
-		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
-		num_poisoned_pages_dec();
-		unlock_page(head);
-		put_page(head);
-		return 0;
-	}
-
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1628,6 +1620,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1654,7 +1648,6 @@ int memory_failure(unsigned long pfn, int flags)
 	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
-	static DEFINE_MUTEX(mf_mutex);
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1788,16 +1781,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	page_flags = p->flags;
 
-	/*
-	 * unpoison always clear PG_hwpoison inside page lock
-	 */
-	if (!PageHWPoison(p)) {
-		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
-		num_poisoned_pages_dec();
-		unlock_page(p);
-		put_page(p);
-		goto unlock_mutex;
-	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
@@ -1978,6 +1961,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *page;
 	struct page *p;
 	int freeit = 0;
+	int ret = 0;
 	unsigned long flags = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
@@ -1988,39 +1972,30 @@ int unpoison_memory(unsigned long pfn)
 	p = pfn_to_page(pfn);
 	page = compound_head(p);
 
+	mutex_lock(&mf_mutex);
+
 	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_count(page) > 1) {
 		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_mapped(page)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (page_mapping(page)) {
 		unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
-	}
-
-	/*
-	 * unpoison_memory() can encounter thp only when the thp is being
-	 * worked by memory_failure() and the page lock is not held yet.
-	 * In such case, we yield to memory_failure() and make unpoison fail.
-	 */
-	if (!PageHuge(page) && PageTransHuge(page)) {
-		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
-				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (!get_hwpoison_page(p, flags)) {
@@ -2028,29 +2003,23 @@ int unpoison_memory(unsigned long pfn)
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
-	lock_page(page);
-	/*
-	 * This test is racy because PG_hwpoison is set outside of page lock.
-	 * That's acceptable because that won't trigger kernel panic. Instead,
-	 * the PG_hwpoison page will be caught and isolated on the entrance to
-	 * the free buddy page pool.
-	 */
 	if (TestClearPageHWPoison(page)) {
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 pfn, &unpoison_rs);
 		num_poisoned_pages_dec();
 		freeit = 1;
 	}
-	unlock_page(page);
 
 	put_page(page);
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
 		put_page(page);
 
-	return 0;
+unlock_mutex:
+	mutex_unlock(&mf_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
 
@@ -2231,9 +2200,12 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	mutex_lock(&mf_mutex);
+
 	if (PageHWPoison(page)) {
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
 		put_ref_page(ref_page);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 
@@ -2251,5 +2223,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		}
 	}
 
+	mutex_unlock(&mf_mutex);
+
 	return ret;
 }
-- 
2.25.1

