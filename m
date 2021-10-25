Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6369243A7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhJYXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:09:05 -0400
Received: from out1.migadu.com ([91.121.223.63]:29448 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhJYXIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:08:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635203189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RR7imi14Z6SUKcAiAGApew2NGLLdTeu4YcmU7ch/wOs=;
        b=JSZSt4rEezuk5+bDKBhgCteVmui5+uPUamj0ljbeldA6sgTX2nqdcD3aOpqO9LxJvKTHde
        Eg0dz1OiBSx238wJ5lpjtX5FvYgLx5DYVQBv9GD7+8uFLXzpVZb8xOg+wNXGKc/td+1//i
        23tAvpVQbVcL/5PXtU4a9rGzSCFzG3I=
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
Subject: [PATCH v2 1/4] mm/hwpoison: mf_mutex for soft offline and unpoison
Date:   Tue, 26 Oct 2021 08:05:00 +0900
Message-Id: <20211025230503.2650970-2-naoya.horiguchi@linux.dev>
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

Originally mf_mutex is introduced to serialize multiple MCE events, but
it's also helpful to exclude races among  soft_offline_page() and
unpoison_memory().  So apply mf_mutex to them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v2:
- add mutex_unlock() in "page already poisoned" path in soft_offline_page().
  (Thanks to Ding Hui)
---
 mm/memory-failure.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fa9dda95a2a2..97297edfbd8e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1628,6 +1628,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1654,7 +1656,6 @@ int memory_failure(unsigned long pfn, int flags)
 	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
-	static DEFINE_MUTEX(mf_mutex);
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1978,6 +1979,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *page;
 	struct page *p;
 	int freeit = 0;
+	int ret = 0;
 	unsigned long flags = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
@@ -1988,28 +1990,30 @@ int unpoison_memory(unsigned long pfn)
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
+		goto unlock_mutex;
 	}
 
 	/*
@@ -2020,7 +2024,7 @@ int unpoison_memory(unsigned long pfn)
 	if (!PageHuge(page) && PageTransHuge(page)) {
 		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	if (!get_hwpoison_page(p, flags)) {
@@ -2028,7 +2032,7 @@ int unpoison_memory(unsigned long pfn)
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
 				 pfn, &unpoison_rs);
-		return 0;
+		goto unlock_mutex;
 	}
 
 	lock_page(page);
@@ -2050,7 +2054,9 @@ int unpoison_memory(unsigned long pfn)
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
 		put_page(page);
 
-	return 0;
+unlock_mutex:
+	mutex_unlock(&mf_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
 
@@ -2231,9 +2237,12 @@ int soft_offline_page(unsigned long pfn, int flags)
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
 
@@ -2251,5 +2260,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		}
 	}
 
+	mutex_unlock(&mf_mutex);
+
 	return ret;
 }
-- 
2.25.1

