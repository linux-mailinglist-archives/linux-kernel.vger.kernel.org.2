Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2F38A032
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhETIwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:52:02 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:49795 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhETIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:52:01 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 0A5471C3C04
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:50:39 +0100 (IST)
Received: (qmail 11234 invoked from network); 20 May 2021 08:50:38 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:50:38 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 13/14] mm/page_alloc: Move prototype for find_suitable_fallback
Date:   Thu, 20 May 2021 09:48:08 +0100
Message-Id: <20210520084809.8576-14-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning in mmap_lock.c for allnoconfig

  mm/page_alloc.c:2670:5: warning: no previous prototype for ‘find_suitable_fallback’ [-Wmissing-prototypes]
   int find_suitable_fallback(struct free_area *area, unsigned int order,
       ^~~~~~~~~~~~~~~~~~~~~~

find_suitable_fallback is only shared outside of page_alloc.c for
CONFIG_COMPACTION but to suppress the warning, move the protype
outside of CONFIG_COMPACTION. It is not worth the effort at
this time to find a clever way of allowing compaction.c to share
the code or avoid the use entirely as the function is called
on relatively slow paths.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 54bd0dc2c23c..bc9890948712 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -289,11 +289,10 @@ isolate_freepages_range(struct compact_control *cc,
 int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
+#endif
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
 
-#endif
-
 /*
  * This function returns the order of a free page in the buddy system. In
  * general, page_zone(page)->lock must be held by the caller to prevent the
-- 
2.26.2

