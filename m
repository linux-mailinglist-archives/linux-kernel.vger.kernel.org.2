Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F30402518
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhIGI1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:27:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:37767 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242634AbhIGI1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:27:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="207359755"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207359755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 01:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="537831722"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2021 01:25:51 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and bail out early
Date:   Tue,  7 Sep 2021 16:25:50 +0800
Message-Id: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was report that starting an Ubuntu in docker while using cpuset
to bind it to movlabe nodes (a node only has movable zone, like a node
for hotplug or a Persistent Memory  node in normal usage) will fail
due to memory allocation failure, and then OOM is involved and many
other innocent processes got killed. It can be reproduced with command:
$docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
"grep Mems_allowed /proc/self/status" (node 4 is a movable node)

The reason is, in the case, the target cpuset nodes only have movable
zone, while the creation of an OS in docker sometimes needs to allocate
memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
the cpuset limit forbids the allocation, then out-of-memory killing is
involved even when normal nodes and movable nodes both have many free
memory.

The failure is reasonable, but still there is one problem, that when
the usage fails as it's an mission impossible due to the cpuset limit,
the allocation should just not trigger reclaim/compaction, and more
importantly, not get any innocent process oom-killed.

So add detection for cases like this in the slowpath of allocation,
and bail out early returning NULL for the allocation.

We've run some cases of malloc/mmap/page_fault/lru-shm/swap from
will-it-scale and vm-scalability, and didn't see obvious performance
change (all inside +/- 1%), test boxes are 2 socket Cascade Lake and
Icelake servers.

[thanks to Micho Hocko and David Rientjes for suggesting not handle
 it inside OOM code]

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---

Changelog:

  since RFC
  * move the handling from oom code to page allocation path (Michal/David)

 mm/page_alloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f95e1d2386a1..d6657f68d1fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4929,6 +4929,19 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
+	/*
+	 * Check for insane configurations where the cpuset doesn't contain
+	 * any suitable zone to satisfy the request - e.g. non-movable
+	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
+	 */
+	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
+		struct zoneref *z = first_zones_zonelist(ac->zonelist,
+					ac->highest_zoneidx,
+					&cpuset_current_mems_allowed);
+		if (!z->zone)
+			goto nopage;
+	}
+
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
 
-- 
2.14.1

