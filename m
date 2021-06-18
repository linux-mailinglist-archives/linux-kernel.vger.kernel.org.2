Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F053AC3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhFRGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:21:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:4821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233248AbhFRGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:17 -0400
IronPort-SDR: Nvc0DxFyxZqRGnYDgBusvi5Fu8pOT3ydMyv2XCiZ5UOR58IR9R0TTgRExl2yTFBBh+36FwRZn9
 W9piwVatPTbw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815224"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815224"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:08 -0700
IronPort-SDR: Wm87a+T08xvVTQgJz0yUN5lkLiTwxvhuhdXgeok2Deb8tMmMCtRC1SBRlP1aoKKw2xZCMZsQqR
 ekPtJv+UTXiw==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573605"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:05 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 01/10] mm/numa: node demotion data structure and lookup
Date:   Fri, 18 Jun 2021 14:15:28 +0800
Message-Id: <20210618061537.434999-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare for the kernel to auto-migrate pages to other memory nodes
with a user defined node migration table. This allows creating single
migration target for each NUMA node to enable the kernel to do NUMA
page migrations instead of simply reclaiming colder pages. A node
with no target is a "terminal node", so reclaim acts normally there.
The migration target does not fundamentally _need_ to be a single node,
but this implementation starts there to limit complexity.

If you consider the migration path as a graph, cycles (loops) in the
graph are disallowed.  This avoids wasting resources by constantly
migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
never be allowed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

changes since 20200122:
 * Make node_demotion[] __read_mostly

changes in July 2020:
 - Remove loop from next_demotion_node() and get_online_mems().
   This means that the node returned by next_demotion_node()
   might now be offline, but the worst case is that the
   allocation fails.  That's fine since it is transient.
---
 mm/migrate.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..6cab668132f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1136,6 +1136,23 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	return rc;
 }
 
+static int node_demotion[MAX_NUMNODES] __read_mostly =
+	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
+
+/**
+ * next_demotion_node() - Get the next node in the demotion path
+ * @node: The starting node to lookup the next node
+ *
+ * @returns: node id for next memory node in the demotion path hierarchy
+ * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
+ * @node online or guarantee that it *continues* to be the next demotion
+ * target.
+ */
+int next_demotion_node(int node)
+{
+	return node_demotion[node];
+}
+
 /*
  * Obtain the lock on page, remove all ptes and migrate the page
  * to the newly allocated page in newpage.
-- 
2.30.2

