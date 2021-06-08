Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA039EF5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFHHUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:20:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:20:42 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzhNZ4prZzZdsh;
        Tue,  8 Jun 2021 15:15:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:18:44 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:18:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:18:29 +0800
Message-ID: <20210608071829.12740-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

find mm/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/memory-failure.c | 20 ++++++++++----------
 mm/oom_kill.c       |  2 +-
 mm/page_io.c        |  2 +-
 mm/rmap.c           |  2 +-
 mm/swap_state.c     | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 560d096a7513..46445bb2ea29 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -6,16 +6,16 @@
  * High level machine check handler. Handles pages reported by the
  * hardware as being corrupted usually due to a multi-bit ECC memory or cache
  * failure.
- * 
+ *
  * In addition there is a "soft offline" entry point that allows stop using
  * not-yet-corrupted-by-suspicious pages without killing anything.
  *
  * Handles page cache pages in various states.	The tricky part
- * here is that we can access any page asynchronously in respect to 
- * other VM users, because memory failures could happen anytime and 
- * anywhere. This could violate some of their assumptions. This is why 
- * this code has to be extremely careful. Generally it tries to use 
- * normal locking rules, as in get the standard locks, even if that means 
+ * here is that we can access any page asynchronously in respect to
+ * other VM users, because memory failures could happen anytime and
+ * anywhere. This could violate some of their assumptions. This is why
+ * this code has to be extremely careful. Generally it tries to use
+ * normal locking rules, as in get the standard locks, even if that means
  * the error handling takes potentially a long time.
  *
  * It can be very tempting to add handling for obscure cases here.
@@ -25,12 +25,12 @@
  *   https://git.kernel.org/cgit/utils/cpu/mce/mce-test.git/
  * - The case actually shows up as a frequent (top 10) page state in
  *   tools/vm/page-types when running a real workload.
- * 
+ *
  * There are several operations here with exponential complexity because
- * of unsuitable VM data structures. For example the operation to map back 
- * from RMAP chains to processes has to walk the complete process list and 
+ * of unsuitable VM data structures. For example the operation to map back
+ * from RMAP chains to processes has to walk the complete process list and
  * has non linear complexity with the number. But since memory corruptions
- * are rare we hope to get away with this. This avoids impacting the core 
+ * are rare we hope to get away with this. This avoids impacting the core
  * VM.
  */
 #include <linux/kernel.h>
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..2f8bce6c63ac 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/oom_kill.c
- * 
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf5..9e80be141a73 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *
- *  Swap reorganised 29.12.95, 
+ *  Swap reorganised 29.12.95,
  *  Asynchronous swapping added 30.12.95. Stephen Tweedie
  *  Removed race in async swapping. 14.4.1996. Bruno Haible
  *  Add swap of shared pages through the page cache. 20.2.1998. Stephen Tweedie
diff --git a/mm/rmap.c b/mm/rmap.c
index b6cfc92f5475..4ca1a212f588 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1040,7 +1040,7 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
  * __page_set_anon_rmap - set up new anonymous rmap
  * @page:	Page or Hugepage to add to rmap
  * @vma:	VM area to add page to.
- * @address:	User virtual address of the mapping	
+ * @address:	User virtual address of the mapping
  * @exclusive:	the page is exclusively owned by the current process
  */
 static void __page_set_anon_rmap(struct page *page,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 95e391f46468..460828d1c10a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -178,7 +178,7 @@ void __delete_from_swap_cache(struct page *page,
  * @page: page we want to move to swap
  *
  * Allocate swap space for the page and add the page to the
- * swap cache.  Caller needs to hold the page lock. 
+ * swap cache.  Caller needs to hold the page lock.
  */
 int add_to_swap(struct page *page)
 {
@@ -277,9 +277,9 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 	}
 }
 
-/* 
- * If we are the only user, then try to free up the swap cache. 
- * 
+/*
+ * If we are the only user, then try to free up the swap cache.
+ *
  * Its ok to check for PageSwapCache without the page lock
  * here because we are going to recheck again inside
  * try_to_free_swap() _with_ the lock.
@@ -293,7 +293,7 @@ void free_swap_cache(struct page *page)
 	}
 }
 
-/* 
+/*
  * Perform a free_page(), also freeing any swap cache associated with
  * this page if it is the last user of the page.
  */
-- 
2.25.1


