Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C856F3E4429
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhHIKrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:47:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:48956 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234814AbhHIKrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=9YHMSCcvf9S1i8/cpiMhGW46gXxYh7k5FxFkcCgAo6E=; b=TZGF07Ye995jmwdzogI
        Dc9u3AYK4ndcJV2wQnVwlG5LE4WKIlXs7qHa23YQFs6fNMtrcoaF7pdRcChLThEFbgCPX9i/hroLm
        LZs+a3iW5tTYxjLyOy/obbQ/NCNZ8iG9vtsWMTn+ZpUaS/HY/iBJXYHgYCMuNFoO7h5XTVjvCdc=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mD2nx-006q1A-Ji; Mon, 09 Aug 2021 13:46:49 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] mm: use in_task in mm/page_alloc.c
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Message-ID: <877caa99-1994-5545-92d2-d0bb2e394182@virtuozzo.com>
Date:   Mon, 9 Aug 2021 13:46:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obsoleted in_intrrupt() include task context with disabled BH,
it's better to use in_task() instead.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4291639..a385194 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4212,7 +4212,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 		if (tsk_is_oom_victim(current) ||
 		    (current->flags & (PF_MEMALLOC | PF_EXITING)))
 			filter &= ~SHOW_MEM_FILTER_NODES;
-	if (in_interrupt() || !(gfp_mask & __GFP_DIRECT_RECLAIM))
+	if (!in_task() || !(gfp_mask & __GFP_DIRECT_RECLAIM))
 		filter &= ~SHOW_MEM_FILTER_NODES;
 
 	show_mem(filter, nodemask);
@@ -4698,7 +4698,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 		 * comment for __cpuset_node_allowed().
 		 */
 		alloc_flags &= ~ALLOC_CPUSET;
-	} else if (unlikely(rt_task(current)) && !in_interrupt())
+	} else if (unlikely(rt_task(current)) && in_task())
 		alloc_flags |= ALLOC_HARDER;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
@@ -5158,7 +5158,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		 * When we are in the interrupt context, it is irrelevant
 		 * to the current task context. It means that any node ok.
 		 */
-		if (!in_interrupt() && !ac->nodemask)
+		if (in_task() && !ac->nodemask)
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
-- 
1.8.3.1

