Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8491832BD4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449215AbhCCPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:43:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:57467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442181AbhCCKvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:51:03 -0500
IronPort-SDR: lKCoyIS5/Gvh5R0w77SuiBReOgIpDlLbH18+Hw6SrSwY9ur+vPRohK5d8eNQRTGjZr16OXgK8d
 dykEYjUSITKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802644"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:22 -0800
IronPort-SDR: ranA4Q4AMEgxq+bNn2jWDrlh0NnmkGJDvLlHIB9I6l4d4tCBBrVLJd2UUkgU8gtMHPQ1UhD9Jm
 S9gCS0nBVrAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200192"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:18 -0800
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
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 05/14] mm/mempolicy: refactor rebind code for PREFERRED_MANY
Date:   Wed,  3 Mar 2021 18:20:49 +0800
Message-Id: <1614766858-90344-6-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
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
index 19ec954..0103c20 100644
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

