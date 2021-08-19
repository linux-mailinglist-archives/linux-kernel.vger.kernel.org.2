Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E63A3F0F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhHSAUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhHSAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:20:45 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD530C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 17:20:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629332407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wOqtJLtSuCJGPYEHTKUmHAquuWnKsqoTe4kq+wPqgI8=;
        b=Z6svOnQF0irOZQA1XtKmwirbHjPffyRPQdMw1Rxk/fd9zYvkzQ8kPiULA/hvUYv56x08pO
        e8Blto2pMD80wlBfEPXXXUjmBJfAZ5/02UntbE6hi5j2bhaYWy8Mzgxapi+/TMbgMv6XfG
        r/KeK/snT3J1DcIn0EclzXoUdWsDc+g=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/hwpoison: Retry with shake_page() for unhandlable pages
Date:   Thu, 19 Aug 2021 09:19:58 +0900
Message-Id: <20210819001958.2365157-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

HWPoisonHandlable() sometimes returns false for typical user pages
due to races with average memory events like transfers over LRU lists.
This causes failures in hwpoison handling.

There's retry code for such a case but does not work because the retry
loop reaches the retry limit too quickly before the page settles down to
handlable state. Let get_any_page() call shake_page() to fix it.

Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: stable@vger.kernel.org # 5.13
---
ChangeLog v2:
- get_any_page() return -EIO when retry limit reached (by Yang Shi)
---
 mm/memory-failure.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git v5.14-rc6/mm/memory-failure.c v5.14-rc6_patched/mm/memory-failure.c
index eefd823deb67..470400cc7513 100644
--- v5.14-rc6/mm/memory-failure.c
+++ v5.14-rc6_patched/mm/memory-failure.c
@@ -1146,7 +1146,7 @@ static int __get_hwpoison_page(struct page *page)
 	 * unexpected races caused by taking a page refcount.
 	 */
 	if (!HWPoisonHandlable(head))
-		return 0;
+		return -EBUSY;
 
 	if (PageTransHuge(head)) {
 		/*
@@ -1199,9 +1199,15 @@ static int get_any_page(struct page *p, unsigned long flags)
 			}
 			goto out;
 		} else if (ret == -EBUSY) {
-			/* We raced with freeing huge page to buddy, retry. */
-			if (pass++ < 3)
+			/*
+			 * We raced with (possibly temporary) unhandlable
+			 * page, retry.
+			 */
+			if (pass++ < 3) {
+				shake_page(p, 1);
 				goto try_again;
+			}
+			ret = -EIO;
 			goto out;
 		}
 	}
-- 
2.25.1

