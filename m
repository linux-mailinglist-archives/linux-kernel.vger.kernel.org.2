Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B433E7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCQDlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:57774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCQDlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:41:03 -0400
IronPort-SDR: uj87DGqwH5JDDqP75B0vJ3vwarrW+I2+8DzvnOZuArmInbvMw2Pmy4LQnn5+rSluf0uaW87iwI
 JhjJlA86w71Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="274426137"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="274426137"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:41:03 -0700
IronPort-SDR: 0QhJdy7QGydoeAImcsOKM4oPxEqMCJtV7/yKuRK9ebdUYdHqIU+Xrlr22K+IVoE/z+HiATTO9U
 goKah0qb01Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602076101"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:41:00 -0700
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 13/13] mem/mempolicy: unify mpol_new_preferred() and mpol_new_preferred_many()
Date:   Wed, 17 Mar 2021 11:40:10 +0800
Message-Id: <1615952410-36895-14-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce some code duplication.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 18aa7dc..ee99ecc 100644
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

