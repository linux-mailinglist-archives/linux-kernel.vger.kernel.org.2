Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADB351F05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhDASv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:62290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237955AbhDASg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:36:29 -0400
IronPort-SDR: W3uH6gIrD5aKbYdCQCCesuz/PJLuYPYEuUfabTdzgLiO922GHWrP6YYa+kxTkjiGe66wR2pDv7
 xorKR7GiB4Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191788507"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="191788507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:34:59 -0700
IronPort-SDR: JioM0Sj4VyscMKESqMCXUZ967wamiVnr5qKHzeazQa098ewbw65ZWDvck0Ud2p9YnZwZE1uz2l
 KP6i84s581TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="379420456"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2021 11:34:59 -0700
Subject: [PATCH 01/10] mm/numa: node demotion data structure and lookup
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:18 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183218.E7C9CE24@viggo.jf.intel.com>
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
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
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

 b/mm/migrate.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff -puN mm/migrate.c~0006-node-Define-and-export-memory-migration-path mm/migrate.c
--- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path	2021-03-31 15:17:10.734000264 -0700
+++ b/mm/migrate.c	2021-03-31 15:17:10.742000264 -0700
@@ -1163,6 +1163,23 @@ out:
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
_
