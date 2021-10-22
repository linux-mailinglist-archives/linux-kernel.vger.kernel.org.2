Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779243793E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhJVOuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:50:07 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:40008 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233232AbhJVOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:50:02 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id E38BF500D3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 15:47:42 +0100 (IST)
Received: (qmail 30633 invoked from network); 22 Oct 2021 14:47:42 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 22 Oct 2021 14:47:42 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/8] mm/writeback: Throttle based on page writeback instead of congestion
Date:   Fri, 22 Oct 2021 15:46:47 +0100
Message-Id: <20211022144651.19914-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022144651.19914-1-mgorman@techsingularity.net>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_writepages throttles on congestion if the writepages() fails due to a
lack of memory but congestion_wait() is partially broken as the congestion
state is not updated for all BDIs.

This patch stalls waiting for a number of pages to complete writeback
that located on the local node. The main weakness is that there is no
correlation between the location of the inode's pages and locality but
that is still better than congestion_wait.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page-writeback.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4812a17b288c..f34f54fcd5b4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2366,8 +2366,15 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			ret = generic_writepages(mapping, wbc);
 		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
 			break;
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
+
+		/*
+		 * Lacking an allocation context or the locality or writeback
+		 * state of any of the inode's pages, throttle based on
+		 * writeback activity on the local node. It's as good a
+		 * guess as any.
+		 */
+		reclaim_throttle(NODE_DATA(numa_node_id()),
+			VMSCAN_THROTTLE_WRITEBACK, HZ/50);
 	}
 	/*
 	 * Usually few pages are written by now from those we've just submitted
-- 
2.31.1

