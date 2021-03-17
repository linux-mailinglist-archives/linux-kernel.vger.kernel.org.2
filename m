Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB51233E7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCQDlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhCQDkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:47 -0400
IronPort-SDR: uazbN431MJ7bh0bm7N4JtC7QDOhW4IBQqh5G3rOOsc35P6QqGzHTR+VR7r6AdJ+wtPmlgMq1LZ
 VOQUSqPWfrvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021897"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021897"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:46 -0700
IronPort-SDR: N0mWVmdNP6PLiKMb/zxRwfM4pv66INHYF1GGnDSe31OfPH58fv9fmUHhvXjVCo29K5qJ7nUfNb
 nXCDwaZCMCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075961"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:43 -0700
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
Subject: [PATCH v4 09/13] mm/mempolicy: Thread allocation for many preferred
Date:   Wed, 17 Mar 2021 11:40:06 +0800
Message-Id: <1615952410-36895-10-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In order to support MPOL_PREFERRED_MANY as the mode used by
set_mempolicy(2), alloc_pages_current() needs to support it. This patch
does that by using the new helper function to allocate properly based on
policy.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Link: https://lore.kernel.org/r/20200630212517.308045-10-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d21105b..a92efe7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2357,7 +2357,7 @@ EXPORT_SYMBOL(alloc_pages_vma);
 struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
-	struct page *page;
+	int nid = NUMA_NO_NODE;
 
 	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
 		pol = get_task_policy(current);
@@ -2367,14 +2367,9 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_pages_policy(pol, gfp, order,
-					  interleave_nodes(pol));
-	else
-		page = __alloc_pages_nodemask(gfp, order,
-				policy_node(gfp, pol, numa_node_id()),
-				policy_nodemask(gfp, pol));
+		nid = interleave_nodes(pol);
 
-	return page;
+	return alloc_pages_policy(pol, gfp, order, nid);
 }
 EXPORT_SYMBOL(alloc_pages_current);
 
-- 
2.7.4

