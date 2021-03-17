Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23A933E7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCQDkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:40:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhCQDk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:29 -0400
IronPort-SDR: wAxdAh91Ld+r8WMaCvihhpquDFAQwD73oIL02V+fOY+0Kn5e/zEAfvChjIg0L8FQO1gKnE68yu
 8WfVJww3BKdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021874"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021874"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:29 -0700
IronPort-SDR: FWYdN3v3llNgOFFVw6CiHQ3538glVa3UZQYIZag70dAV0FJQEAlnlBXxGGAd/CC6cPwEokQcoX
 cB/E5ylJvIgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075847"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:25 -0700
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
Subject: [PATCH v4 04/13] mm/mempolicy: allow preferred code to take a nodemask
Date:   Wed, 17 Mar 2021 11:40:01 +0800
Message-Id: <1615952410-36895-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
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
index 1228d8e..6fb2cab 100644
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

