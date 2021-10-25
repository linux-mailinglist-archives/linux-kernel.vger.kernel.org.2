Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33643A7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhJYXJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhJYXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:08:59 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C8C061243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:06:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635203194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOfu9yayDhzvLAsYLRzMlhcWXOr3HMUMOxXzk71LJi4=;
        b=JKBY3MYo8v0gSQav25vpBtSiuxqoEwKJxKTWGqMLui4F+75+cQQNtI180Ey1Qr7LdBNVS5
        p/eaMrrkla/PTz6zj2sHXRZVgy43DZoFbB5I+WYQDtkHNmjW3EGc5jaZfX8gw2QKr1LB1s
        NOZzRsppZTWxKU76PalPJRmFIZUeb7U=
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
Subject: [PATCH v2 2/4] mm/hwpoison: remove race consideration
Date:   Tue, 26 Oct 2021 08:05:01 +0900
Message-Id: <20211025230503.2650970-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now memory_failure() and unpoison_memory() are protected by mf_mutex,
so no need to explicitly check races between them.  So remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97297edfbd8e..a47b741ca04b 100644
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
@@ -1789,16 +1781,6 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -2016,17 +1998,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	/*
-	 * unpoison_memory() can encounter thp only when the thp is being
-	 * worked by memory_failure() and the page lock is not held yet.
-	 * In such case, we yield to memory_failure() and make unpoison fail.
-	 */
-	if (!PageHuge(page) && PageTransHuge(page)) {
-		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
-				 pfn, &unpoison_rs);
-		goto unlock_mutex;
-	}
-
 	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
@@ -2035,20 +2006,12 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
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
-- 
2.25.1

