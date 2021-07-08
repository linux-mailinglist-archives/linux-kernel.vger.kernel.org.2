Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966123BF6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGHIRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:17:19 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:43215 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhGHIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:17:18 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id E90FF1F46
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 09:14:35 +0100 (IST)
Received: (qmail 3949 invoked from network); 8 Jul 2021 08:14:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jul 2021 08:14:35 -0000
Date:   Thu, 8 Jul 2021 09:14:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Zqiang <qiang.zhang@windriver.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Subject: [PATCH] mm/page_alloc: Avoid page allocator recursion with
 pagesets.lock held
Message-ID: <20210708081434.GV3840@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot is reporting potential deadlocks due to pagesets.lock when
PAGE_OWNER is enabled. One example from Desmond Cheong Zhi Xi is
as follows

  __alloc_pages_bulk()
    local_lock_irqsave(&pagesets.lock, flags) <---- outer lock here
    prep_new_page():
      post_alloc_hook():
        set_page_owner():
          __set_page_owner():
            save_stack():
              stack_depot_save():
                alloc_pages():
                  alloc_page_interleave():
                    __alloc_pages():
                      get_page_from_freelist():
                        rm_queue():
                          rm_queue_pcplist():
                            local_lock_irqsave(&pagesets.lock, flags);
                            *** DEADLOCK ***

Zhang, Qiang also reported

  BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
  .....
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
  alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
  save_stack+0x15e/0x1e0 mm/page_owner.c:120
  __set_page_owner+0x50/0x290 mm/page_owner.c:181
  prep_new_page mm/page_alloc.c:2445 [inline]
  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
  __vmalloc_area_node mm/vmalloc.c:2845 [inline]
  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
  __vmalloc_node mm/vmalloc.c:2996 [inline]
  vzalloc+0x67/0x80 mm/vmalloc.c:3066

There are a number of ways it could be fixed. The page owner code could
be audited to strip GFP flags that allow sleeping but it'll impair the
functionality of PAGE_OWNER if allocations fail. The bulk allocator
could add a special case to release/reacquire the lock for prep_new_page
and lookup PCP after the lock is reacquired at the cost of performance.
The patches requiring prep could be tracked using the least significant
bit and looping through the array although it is more complicated for
the list interface. The options are relatively complex and the second
one still incurs a performance penalty when PAGE_OWNER is active so this
patch takes the simple approach -- disable bulk allocation of PAGE_OWNER is
active. The caller will be forced to allocate one page at a time incurring
a performance penalty but PAGE_OWNER is already a performance penalty.

Fixes: dbbee9d5cd83 ("mm/page_alloc: convert per-cpu list protection to local_lock")
Reported-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reported-by: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Reported-and-tested-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..6ef86f338151 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5239,6 +5239,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (nr_pages - nr_populated == 1)
 		goto failed;
 
+#ifdef CONFIG_PAGE_OWNER
+	/*
+	 * PAGE_OWNER may recurse into the allocator to allocate space to
+	 * save the stack with pagesets.lock held. Releasing/reacquiring
+	 * removes much of the performance benefit of bulk allocation so
+	 * force the caller to allocate one page at a time as it'll have
+	 * similar performance to added complexity to the bulk allocator.
+	 */
+	if (static_branch_unlikely(&page_owner_inited))
+		goto failed;
+#endif
+
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
