Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BC395A07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhEaMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:06:22 -0400
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:35209 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231468AbhEaMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:06:13 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 5E178FADD8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:04:33 +0100 (IST)
Received: (qmail 1927 invoked from network); 31 May 2021 12:04:33 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 31 May 2021 12:04:33 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] mm/page_alloc: Move free_the_page
Date:   Mon, 31 May 2021 13:04:11 +0100
Message-Id: <20210531120412.17411-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210531120412.17411-1-mgorman@techsingularity.net>
References: <20210531120412.17411-1-mgorman@techsingularity.net>
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
index af566e97a0f8..d45d00e069f9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -676,6 +676,14 @@ static void bad_page(struct page *page, const char *reason)
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
@@ -5331,14 +5339,6 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
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

