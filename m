Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C734E6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhC3Ltf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:49:35 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:51103 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232256AbhC3Lsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:48:50 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 9D7A2FAA45
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:48:48 +0100 (IST)
Received: (qmail 28162 invoked from network); 30 Mar 2021 11:48:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Mar 2021 11:48:48 -0000
Date:   Tue, 30 Mar 2021 12:48:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] mm/page_alloc: Add a bulk page allocator -fix -fix
Message-ID: <20210330114847.GX3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King reported the following problem (slightly edited)

	Author: Mel Gorman <mgorman@techsingularity.net>
	Date:   Mon Mar 29 11:12:24 2021 +1100

	    mm/page_alloc: add a bulk page allocator

	...

	Static analysis on linux-next with Coverity has found a potential
	uninitialized variable issue in function __alloc_pages_bulk with
	the following commit:

	...

	    Uninitialized scalar variable (UNINIT)
	    15. uninit_use_in_call: Using uninitialized value alloc_flags when
	        calling prepare_alloc_pages.

	5056        if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask,
						&ac, &alloc_gfp, &alloc_flags))

The problem is that prepare_alloc_flags only updates alloc_flags
which must have a valid initial value. The appropriate initial value is
ALLOC_WMARK_LOW to avoid the bulk allocator pushing a zone below the low
watermark without waking kswapd assuming the GFP mask allows kswapd to
be woken.

This is a second fix to the mmotm patch
mm-page_alloc-add-a-bulk-page-allocator.patch . It will cause a mild conflict
with a later patch due to renaming of an adjacent variable that is trivially
resolved. I can post a full series with the fixes merged if that is preferred.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 92d55f80c289..dabef0b910c9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4990,7 +4990,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct list_head *pcp_list;
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
-	unsigned int alloc_flags;
+	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	int allocated = 0;
 
 	if (WARN_ON_ONCE(nr_pages <= 0))
