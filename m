Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885C3C9E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhGOMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:00:27 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:51135 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhGOMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:00:26 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id EE0EC1C4CFA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:57:32 +0100 (IST)
Received: (qmail 31738 invoked from network); 15 Jul 2021 11:57:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jul 2021 11:57:32 -0000
Date:   Thu, 15 Jul 2021 12:57:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Huan <link@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel@vivo.com,
        syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH v2] mm/page_alloc: fix alloc_pages_bulk/set_page_owner
 panic on irq disabled
Message-ID: <20210715115731.GS3809@techsingularity.net>
References: <20210712022333.1510-1-link@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210712022333.1510-1-link@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:23:32AM +0800, Yang Huan wrote:
> BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> 
> __dump_stack lib/dump_stack.c:79 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
> ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
> prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
> __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
> alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
> stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
> save_stack+0x15e/0x1e0 mm/page_owner.c:120
> __set_page_owner+0x50/0x290 mm/page_owner.c:181
> prep_new_page mm/page_alloc.c:2445 [inline]
> __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
> 
> The problem is caused by set_page_owner alloc memory to save stack with
> GFP_KERNEL in local_riq disabled.
> So, we just can't assume that alloc flags should be same with new page,
> prep_new_page should prep/trace the page gfp, but shouldn't use the same
> gfp to get memory, let's depend on caller.
> So, here is two gfp flags, alloc_gfp used to alloc memory, depend on
> caller, page_gfp_mask is page's gfp, used to trace/prep itself
> But in most situation, same is ok, in alloc_pages_bulk, use GFP_ATOMIC
> is ok.(even if set_page_owner save backtrace failed, limited impact)
> 
> v2:
> - add more description.
> 
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> Reported-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com
> Suggested-by: Wang Qing <wangqing@vivo.com>
> Signed-off-by: Yang Huan <link@vivo.com>

https://lore.kernel.org/lkml/20210713152100.10381-2-mgorman@techsingularity.net/
is now part of a series that has being sent to Linus. Hence, the Fixes
part is no longer applicable and the patch will no longer be addresing
an atomic sleep bug.  This patch should be treated as an enhancement
to allow bulk allocations when PAGE_OWNER is set. For that, it should
include a note on the performance if PAGE_OWNER is used with either NFS
or high-speed networking to justify the additional complexity.

-- 
Mel Gorman
SUSE Labs
