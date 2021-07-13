Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682CA3C7311
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhGMPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:23:56 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:56330 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236986AbhGMPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:23:52 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 816B1BEC92
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:21:01 +0100 (IST)
Received: (qmail 14885 invoked from network); 13 Jul 2021 15:21:01 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 13 Jul 2021 15:21:01 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] mm/page_alloc: Further fix __alloc_pages_bulk() return value
Date:   Tue, 13 Jul 2021 16:20:59 +0100
Message-Id: <20210713152100.10381-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713152100.10381-1-mgorman@techsingularity.net>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The author of commit b3b64ebd3822 ("mm/page_alloc: do bulk array
bounds check after checking populated elements") was possibly
confused by the mixture of return values throughout the function.

The API contract is clear that the function "Returns the number of
pages on the list or array." It does not list zero as a unique
return value with a special meaning. Therefore zero is a plausible
return value only if @nr_pages is zero or less.

Clean up the return logic to make it clear that the returned value
is always the total number of pages in the array/list, not the
number of pages that were allocated during this call.

The only change in behavior with this patch is the value returned
if prepare_alloc_pages() fails. To match the API contract, the
number of pages currently in the array/list is returned in this
case.

The call site in __page_pool_alloc_pages_slow() also seems to be
confused on this matter. It should be attended to by someone who
is familiar with that code.

[mel@techsingularity.net: Return nr_populated if 0 pages are requested]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 803414ce9264..c66f1e6204c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5221,9 +5221,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	int nr_populated = 0, nr_account = 0;
 
-	if (unlikely(nr_pages <= 0))
-		return 0;
-
 	/*
 	 * Skip populated array elements to determine if any pages need
 	 * to be allocated before disabling IRQs.
@@ -5231,9 +5228,13 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
 		nr_populated++;
 
+	/* No pages requested? */
+	if (unlikely(nr_pages <= 0))
+		goto out;
+
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return nr_populated;
+		goto out;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
@@ -5255,7 +5256,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
-		return nr_populated;
+		goto out;
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
@@ -5323,6 +5324,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
+out:
 	return nr_populated;
 
 failed_irq:
@@ -5338,7 +5340,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	return nr_populated;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(__alloc_pages_bulk);
 
-- 
2.26.2

