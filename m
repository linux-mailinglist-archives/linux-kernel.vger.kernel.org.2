Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF632DE30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhCEABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:01:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:37619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233362AbhCEABC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:01:02 -0500
IronPort-SDR: I86UCh+998t/izhd8yHztuf2hJqo+AdCL/4l5ptao2Tp9a70I+8kvkmozS5D0vJsF0Nc55aoxX
 ljUM6LlmEcaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251569479"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251569479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 16:01:02 -0800
IronPort-SDR: nq7xLGNZ2pm3sGJ9MDl/08M9HnyT+UMnxoC6i8yb6RxZuJdJYJxYOGGLxrhheWRWrtLVU8G4s4
 6zSyjkG5W0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="408039901"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2021 16:01:02 -0800
Subject: [PATCH 10/10] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 04 Mar 2021 16:00:09 -0800
References: <20210304235949.7922C1C3@viggo.jf.intel.com>
In-Reply-To: <20210304235949.7922C1C3@viggo.jf.intel.com>
Message-Id: <20210305000009.EDF902E9@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Some method is obviously needed to enable reclaim-based migration.

Just like traditional autonuma, there will be some workloads that
will benefit like workloads with more "static" configurations where
hot pages stay hot and cold pages stay cold.  If pages come and go
from the hot and cold sets, the benefits of this approach will be
more limited.

The benefits are truly workload-based and *not* hardware-based.
We do not believe that there is a viable threshold where certain
hardware configurations should have this mechanism enabled while
others do not.

To be conservative, earlier work defaulted to disable reclaim-
based migration and did not include a mechanism to enable it.
This proposes extending the existing "zone_reclaim_mode" (now
now really node_reclaim_mode) as a method to enable it.

We are open to any alternative that allows end users to enable
this mechanism or disable it it workload harm is detected (just
like traditional autonuma).

Once this is enabled page demotion may move data to a NUMA node
that does not fall into the cpuset of the allocating process.
This could be construed to violate the guarantees of cpusets.
However, since this is an opt-in mechanism, the assumption is
that anyone enabling it is content to relax the guarantees.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

changes since 20200122:
 * Changelog material about relaxing cpuset constraints
---

 b/Documentation/admin-guide/sysctl/vm.rst |    9 +++++++++
 b/include/linux/swap.h                    |    3 ++-
 b/include/uapi/linux/mempolicy.h          |    1 +
 b/mm/vmscan.c                             |    6 ++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE	2021-03-04 15:36:26.078806355 -0800
+++ b/Documentation/admin-guide/sysctl/vm.rst	2021-03-04 15:36:26.093806355 -0800
@@ -976,6 +976,7 @@ This is value OR'ed together of
 1	Zone reclaim on
 2	Zone reclaim writes dirty pages out
 4	Zone reclaim swaps pages
+8	Zone reclaim migrates pages
 =	===================================
 
 zone_reclaim_mode is disabled by default.  For file servers or workloads
@@ -1000,3 +1001,11 @@ of other processes running on other node
 Allowing regular swap effectively restricts allocations to the local
 node unless explicitly overridden by memory policies or cpuset
 configurations.
+
+Page migration during reclaim is intended for systems with tiered memory
+configurations.  These systems have multiple types of memory with varied
+performance characteristics instead of plain NUMA systems where the same
+kind of memory is found at varied distances.  Allowing page migration
+during reclaim enables these systems to migrate pages from fast tiers to
+slow tiers when the fast tier is under pressure.  This migration is
+performed before swap.
diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
--- a/include/linux/swap.h~RECLAIM_MIGRATE	2021-03-04 15:36:26.082806355 -0800
+++ b/include/linux/swap.h	2021-03-04 15:36:26.093806355 -0800
@@ -382,7 +382,8 @@ extern int sysctl_min_slab_ratio;
 static inline bool node_reclaim_enabled(void)
 {
 	/* Is any node_reclaim_mode bit set? */
-	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+	return node_reclaim_mode & (RECLAIM_ZONE |RECLAIM_WRITE|
+				    RECLAIM_UNMAP|RECLAIM_MIGRATE);
 }
 
 extern void check_move_unevictable_pages(struct pagevec *pvec);
diff -puN include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE include/uapi/linux/mempolicy.h
--- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE	2021-03-04 15:36:26.084806355 -0800
+++ b/include/uapi/linux/mempolicy.h	2021-03-04 15:36:26.094806355 -0800
@@ -69,5 +69,6 @@ enum {
 #define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
+#define RECLAIM_MIGRATE	(1<<3)	/* Migrate to other nodes during reclaim */
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
--- a/mm/vmscan.c~RECLAIM_MIGRATE	2021-03-04 15:36:26.087806355 -0800
+++ b/mm/vmscan.c	2021-03-04 15:36:26.096806355 -0800
@@ -1073,6 +1073,9 @@ static bool migrate_demote_page_ok(struc
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!(node_reclaim_mode & RECLAIM_MIGRATE))
+		return false;
+
 	/* It is pointless to do demotion in memcg reclaim */
 	if (cgroup_reclaim(sc))
 		return false;
@@ -1082,8 +1085,7 @@ static bool migrate_demote_page_ok(struc
 	if (PageTransHuge(page) && !thp_migration_supported())
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 /* Check if a page is dirty or under writeback */
_
