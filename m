Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B53D33E7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCQDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:40:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhCQDkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:33 -0400
IronPort-SDR: FvQyFpx9gnSRIa/hBDIttpaUNzs7GrH6EF6N8MX9rhw4hGQe5fI862rV55eeafPqaiM8c7FADi
 7aUDL66zZJ2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021879"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021879"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:33 -0700
IronPort-SDR: zP/HjD10FnwmMD+ndEPUAOg91e0ixxYOw9OEEe8d5HvLhAsnygyWEZHYTC93zes0HGDimZrWzy
 b8z/MMIL4UwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075874"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:29 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 05/13] mm/mempolicy: refactor rebind code for PREFERRED_MANY
Date:   Wed, 17 Mar 2021 11:40:02 +0800
Message-Id: <1615952410-36895-6-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Again, this extracts the "only one node must be set" behavior of
MPOL_PREFERRED.  It retains virtually all of the existing code so it can
be used by MPOL_PREFERRED_MANY as well.

v2:
Fixed typos in commit message. (Ben)
Merged bits from other patches. (Ben)
annotate mpol_rebind_preferred_many as unused (Ben)

Link: https://lore.kernel.org/r/20200630212517.308045-6-ben.widawsky@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6fb2cab..fbfa3ce 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -363,14 +363,11 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	pol->v.nodes = tmp;
 }
 
-static void mpol_rebind_preferred(struct mempolicy *pol,
-						const nodemask_t *nodes)
+static void mpol_rebind_preferred_common(struct mempolicy *pol,
+					 const nodemask_t *preferred_nodes,
+					 const nodemask_t *nodes)
 {
 	nodemask_t tmp;
-	nodemask_t preferred_node;
-
-	/* MPOL_PREFERRED uses only the first node in the mask */
-	preferred_node = nodemask_of_node(first_node(*nodes));
 
 	if (pol->flags & MPOL_F_STATIC_NODES) {
 		int node = first_node(pol->w.user_nodemask);
@@ -385,12 +382,30 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 		pol->v.preferred_nodes = tmp;
 	} else if (!(pol->flags & MPOL_F_LOCAL)) {
 		nodes_remap(tmp, pol->v.preferred_nodes,
-			    pol->w.cpuset_mems_allowed, preferred_node);
+			    pol->w.cpuset_mems_allowed, *preferred_nodes);
 		pol->v.preferred_nodes = tmp;
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 }
 
+/* MPOL_PREFERRED_MANY allows multiple nodes to be set in 'nodes' */
+static void __maybe_unused mpol_rebind_preferred_many(struct mempolicy *pol,
+						      const nodemask_t *nodes)
+{
+	mpol_rebind_preferred_common(pol, nodes, nodes);
+}
+
+static void mpol_rebind_preferred(struct mempolicy *pol,
+				  const nodemask_t *nodes)
+{
+	nodemask_t preferred_node;
+
+	/* MPOL_PREFERRED uses only the first node in 'nodes' */
+	preferred_node = nodemask_of_node(first_node(*nodes));
+
+	mpol_rebind_preferred_common(pol, &preferred_node, nodes);
+}
+
 /*
  * mpol_rebind_policy - Migrate a policy to a different set of nodes
  *
-- 
2.7.4

