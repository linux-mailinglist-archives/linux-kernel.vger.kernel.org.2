Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2E32BD66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbhCCP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:58:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:21415 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhCCLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:03:33 -0500
IronPort-SDR: 42q22MsbbUnAH3AFIoMOYnf4YMFlwRVRx1bRDRwCutdFgJRrfBMFHro+CxobgoJ2RV+cyg4Nkn
 armttXqRPP6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802740"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:50 -0800
IronPort-SDR: mJG94OlRdkB4bOUsyIwA11SZcy0cODpfW1CyOe98JK90aoacB/QL/yLrvQCmsUDfhKn3QBNid9
 /4O9MP8Cdmlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200397"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:47 -0800
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 13/14] mem/mempolicy: unify mpol_new_preferred() and mpol_new_preferred_many()
Date:   Wed,  3 Mar 2021 18:20:57 +0800
Message-Id: <1614766858-90344-14-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce some code duplication.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1438d58..d66c1c0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -201,32 +201,21 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
-static int mpol_new_preferred_many(struct mempolicy *pol,
+/* cover both MPOL_PREFERRED and MPOL_PREFERRED_MANY */
+static int mpol_new_preferred(struct mempolicy *pol,
 				   const nodemask_t *nodes)
 {
 	if (!nodes)
 		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
-	else
-		pol->nodes = *nodes;
-	return 0;
-}
-
-static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
-{
-	if (nodes) {
+	else {
 		/* MPOL_PREFERRED can only take a single node: */
-		nodemask_t tmp;
+		nodemask_t tmp = nodemask_of_node(first_node(*nodes));
 
-		if (nodes_empty(*nodes))
-			return -EINVAL;
-
-		tmp = nodemask_of_node(first_node(*nodes));
-		return mpol_new_preferred_many(pol, &tmp);
+		pol->nodes = (pol->mode == MPOL_PREFERRED) ? tmp : *nodes;
 	}
-
-	return mpol_new_preferred_many(pol, NULL);
+	return 0;
 }
 
 static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
@@ -468,7 +457,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	},
 	/* [MPOL_LOCAL] - see mpol_new() */
 	[MPOL_PREFERRED_MANY] = {
-		.create = mpol_new_preferred_many,
+		.create = mpol_new_preferred,
 		.rebind = mpol_rebind_preferred_many,
 	},
 };
-- 
2.7.4

