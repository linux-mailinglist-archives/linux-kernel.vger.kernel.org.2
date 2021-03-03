Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6132BD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449345AbhCCPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:43:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:57503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383194AbhCCKuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:50:46 -0500
IronPort-SDR: EaK+frzpb7NFvpW/h4EqBnMh8Uq4vsirlSwIFygFXkIfukRBMoVpmnUaqKdmy4gZG6PoZXmHYA
 9RnKKIemR4KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802629"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:18 -0800
IronPort-SDR: mPlRnNypqju1PiaghxQklHY+nzJgDdNCJ2ChUxwovJ7BW/ReSPF9GVLxJmVegudx20xYvgMKd/
 9GoT9OMEdHYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200165"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:14 -0800
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
Subject: [PATCH v3 04/14] mm/mempolicy: allow preferred code to take a nodemask
Date:   Wed,  3 Mar 2021 18:20:48 +0800
Message-Id: <1614766858-90344-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Create a helper function (mpol_new_preferred_many()) which is usable
both by the old, single-node MPOL_PREFERRED and the new
MPOL_PREFERRED_MANY.

Enforce the old single-node MPOL_PREFERRED behavior in the "new"
version of mpol_new_preferred() which calls mpol_new_preferred_many().

v3:
  * fix a stack overflow caused by emty nodemask (Feng)

Link: https://lore.kernel.org/r/20200630212517.308045-5-ben.widawsky@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79258b2..19ec954 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -203,17 +203,34 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
-static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+static int mpol_new_preferred_many(struct mempolicy *pol,
+				   const nodemask_t *nodes)
 {
 	if (!nodes)
 		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
 	else
-		pol->v.preferred_nodes = nodemask_of_node(first_node(*nodes));
+		pol->v.preferred_nodes = *nodes;
 	return 0;
 }
 
+static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	if (nodes) {
+		/* MPOL_PREFERRED can only take a single node: */
+		nodemask_t tmp;
+
+		if (nodes_empty(*nodes))
+			return -EINVAL;
+
+		tmp = nodemask_of_node(first_node(*nodes));
+		return mpol_new_preferred_many(pol, &tmp);
+	}
+
+	return mpol_new_preferred_many(pol, NULL);
+}
+
 static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
-- 
2.7.4

