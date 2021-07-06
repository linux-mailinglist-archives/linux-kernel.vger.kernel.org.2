Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446F93BC7BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhGFIVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:21:46 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:58691 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230257AbhGFIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:21:45 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 541521C3F97
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 09:19:06 +0100 (IST)
Received: (qmail 21240 invoked from network); 6 Jul 2021 08:19:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jul 2021 08:19:06 -0000
Date:   Tue, 6 Jul 2021 09:19:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     qiang.zhang@windriver.com
Cc:     akpm@linux-foundation.org, alobakin@pm.me,
        songmuchun@bytedance.com, wangqing@vivo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Fix sleeping function called in case of
 irqsdisable.
Message-ID: <20210706081904.GP3840@techsingularity.net>
References: <20210706032907.1276-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210706032907.1276-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:29:07AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> .....
> __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
>  alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
>  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>  save_stack+0x15e/0x1e0 mm/page_owner.c:120
>  __set_page_owner+0x50/0x290 mm/page_owner.c:181
>  prep_new_page mm/page_alloc.c:2445 [inline]
>  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>  __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>  __vmalloc_node mm/vmalloc.c:2996 [inline]
>  vzalloc+0x67/0x80 mm/vmalloc.c:3066
> 
> If the PAGE_OWNER is enabled, in __set_page_owner(), the pages will be
> allocated to save calltrace info, due to the allocated action is executed
> under irq disable(pagesets.lock be held), if the gfp variable contains
> the flag that causes sleep, will trigger above information. the
> prep_new_page() is not need to disable irq for protection, fix it through
> enable irq before call prep_new_page().
> 
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> Reported-by: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

This will hurt the performance of the bulk allocator a lot because it'll
no longer batch the IRQ disable/enabling and be similar to simply using
the single page allocator. It also impacts the performance even if page
owner tracking is off or disabled in kconfig

Given that this is related to page owner tracking, a more straight
forward basic fix is the following untested patch

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..4f96081727f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5224,6 +5224,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(nr_pages <= 0))
 		return 0;
 
+#ifdef CONFIG_PAGE_OWNER
+	/*
+	 * If page owner tracking is enabled then prep_new_page may need to
+	 * allocate space and then sleep with the pagesets.lock lock held.
+	 * Releasing/reacquiring the lock on each page would offset much
+	 * of the benefit of bulk page allocation so simply return 1 page
+	 * when tracking page owners.
+	 */
+	if (static_branch_unlikely(&page_owner_inited))
+		goto failed;
+#endif
+
 	/*
 	 * Skip populated array elements to determine if any pages need
 	 * to be allocated before disabling IRQs.

There are other ways it could be done. Given it's struct page pointers,
the least significant bit could be used to track pages that need to be
prepped and then iterate through the list/array to prep newly allocated
pages. It's not clear it's worth the complexity though unless there are
really interesting use cases where page owner is enabled in production.

-- 
Mel Gorman
SUSE Labs
