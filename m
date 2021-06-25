Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6B3B3D76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFYHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:36:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:11583 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFYHgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:36:06 -0400
IronPort-SDR: Z2six7c9UN5NbCytLyIoGvggbOnM8rKb3+LCQ4iz14IVUVBjL6+jf2kyV7YthQcOvOA0xvlXxs
 a9j9HQZ6j/tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268757362"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="268757362"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:36 -0700
IronPort-SDR: NSFMj7XbFgLvOw8gMekN598DkwnQ1ypoaHNK5Xy+mbVxzSW2VZ3hShm9BCQqml9e6qyBWA0p0K
 zXIueUO91tKA==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085915"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:28 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V9 8/9] mm/vmscan: never demote for memcg reclaim
Date:   Fri, 25 Jun 2021 15:32:03 +0800
Message-Id: <20210625073204.1005986-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625073204.1005986-1-ying.huang@intel.com>
References: <20210625073204.1005986-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on
a given node or set of nodes.  Migrating pages to another
node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the
total memory consumption of the entire memcg, across all
nodes.  Migration does not assist memcg reclaim because
it just moves page contents between nodes rather than
actually reducing memory consumption.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

--
changes from 20210618:
 * Avoid to scan anon lists for demotion for cgroup reclaim.
---
 mm/vmscan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fce43c7970d7..e3cc356369fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -540,8 +540,9 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 	 * The page can not be swapped.
 	 *
 	 * Can it be reclaimed from this node via demotion?
+	 * But it's pointless to do demotion in memcg reclaim.
 	 */
-	if ((!sc || !sc->no_demotion) &&
+	if ((!sc || (!sc->no_demotion && !cgroup_reclaim(sc))) &&
 	    next_demotion_node(node_id) != NUMA_NO_NODE)
 		return true;
 
@@ -1276,6 +1277,9 @@ static bool migrate_demote_page_ok(struct page *page,
 
 	if (sc->no_demotion)
 		return false;
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return false;
 	next_nid = next_demotion_node(page_to_nid(page));
 	if (next_nid == NUMA_NO_NODE)
 		return false;
@@ -2759,7 +2763,7 @@ static bool anon_can_be_aged(struct pglist_data *pgdat,
 		return true;
 
 	/* Also valuable if anon pages can be demoted: */
-	if (!sc->no_demotion &&
+	if (!sc->no_demotion && !cgroup_reclaim(sc) &&
 	    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE)
 		return true;
 
-- 
2.30.2

