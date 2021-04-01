Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71FE351F36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhDAS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:56:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:21439 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238899AbhDASyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:54:03 -0400
IronPort-SDR: LBLQzkSo5oFsq2DGrvobQf9q13chIlmL/nbLkSyAoYtG/3ai1hv32pO5ViVmG9dAAIotfvjXlS
 Wr3tyLh9XPgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172340694"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="172340694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:16 -0700
IronPort-SDR: Ze76oqoemOCT4kk5Rzz6z40X23wyaKRBrRmdkJMv3ff52Uff0tB4+63LvOV4n5hEYINiKkQWpg
 3W2S0BrDnNsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="528297716"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 11:35:16 -0700
Subject: [PATCH 10/10] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, weixugc@google.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:35 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183235.BCC49E8B@viggo.jf.intel.com>
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
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

Changes since 20200122:
 * Changelog material about relaxing cpuset constraints

Changes since 20210304:
 * Add Documentation/ material about relaxing cpuset constraints
---

 b/Documentation/admin-guide/sysctl/vm.rst |   12 ++++++++++++
 b/include/linux/swap.h                    |    3 ++-
 b/include/uapi/linux/mempolicy.h          |    1 +
 b/mm/vmscan.c                             |    6 ++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE	2021-03-31 15:17:40.324000190 -0700
+++ b/Documentation/admin-guide/sysctl/vm.rst	2021-03-31 15:17:40.349000190 -0700
@@ -976,6 +976,7 @@ This is value OR'ed together of
 1	Zone reclaim on
 2	Zone reclaim writes dirty pages out
 4	Zone reclaim swaps pages
+8	Zone reclaim migrates pages
 =	===================================
 
 zone_reclaim_mode is disabled by default.  For file servers or workloads
@@ -1000,3 +1001,14 @@ of other processes running on other node
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
+performed before swap.  It may move data to a NUMA node that does not
+fall into the cpuset of the allocating process which might be construed
+to violate the guarantees of cpusets.  This should not be enabled on
+systems which need strict cpuset location guarantees.
diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
--- a/include/linux/swap.h~RECLAIM_MIGRATE	2021-03-31 15:17:40.331000190 -0700
+++ b/include/linux/swap.h	2021-03-31 15:17:40.351000190 -0700
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
--- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE	2021-03-31 15:17:40.337000190 -0700
+++ b/include/uapi/linux/mempolicy.h	2021-03-31 15:17:40.352000190 -0700
@@ -71,5 +71,6 @@ enum {
 #define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
+#define RECLAIM_MIGRATE	(1<<3)	/* Migrate to other nodes during reclaim */
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
--- a/mm/vmscan.c~RECLAIM_MIGRATE	2021-03-31 15:17:40.339000190 -0700
+++ b/mm/vmscan.c	2021-03-31 15:17:40.357000190 -0700
@@ -1074,6 +1074,9 @@ static bool migrate_demote_page_ok(struc
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!(node_reclaim_mode & RECLAIM_MIGRATE))
+		return false;
+
 	/* It is pointless to do demotion in memcg reclaim */
 	if (cgroup_reclaim(sc))
 		return false;
@@ -1083,8 +1086,7 @@ static bool migrate_demote_page_ok(struc
 	if (PageTransHuge(page) && !thp_migration_supported())
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 /* Check if a page is dirty or under writeback */
_
