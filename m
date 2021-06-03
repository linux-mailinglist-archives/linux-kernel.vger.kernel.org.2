Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9982399D00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFCIsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:48:33 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:35673 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhFCIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:48:27 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 391DEFA9A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 09:46:42 +0100 (IST)
Received: (qmail 7969 invoked from network); 3 Jun 2021 08:46:41 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 3 Jun 2021 08:46:41 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] mm/page_alloc: Move free_the_page
Date:   Thu,  3 Jun 2021 09:46:20 +0100
Message-Id: <20210603084621.24109-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210603084621.24109-1-mgorman@techsingularity.net>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next page, free_compount_page is going to use the common helper
free_the_page. This patch moves the definition to ease review. No
functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c468aa596aa..99ddac0ffece 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -687,6 +687,14 @@ static void bad_page(struct page *page, const char *reason)
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
+static inline void free_the_page(struct page *page, unsigned int order)
+{
+	if (order == 0)		/* Via pcp? */
+		free_unref_page(page);
+	else
+		__free_pages_ok(page, order, FPI_NONE);
+}
+
 /*
  * Higher-order pages are called "compound pages".  They are structured thusly:
  *
@@ -5345,14 +5353,6 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(get_zeroed_page);
 
-static inline void free_the_page(struct page *page, unsigned int order)
-{
-	if (order == 0)		/* Via pcp? */
-		free_unref_page(page);
-	else
-		__free_pages_ok(page, order, FPI_NONE);
-}
-
 /**
  * __free_pages - Free pages allocated with alloc_pages().
  * @page: The page pointer returned from alloc_pages().
-- 
2.26.2

