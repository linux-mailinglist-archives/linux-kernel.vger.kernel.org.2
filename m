Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB233E7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhCQDkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:40:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhCQDkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:18 -0400
IronPort-SDR: PZSOib/skiKUSwZivqr63tqirww46ztIiopLYWt6NogEtY3ECTTmU4DWRhXpgkCBD5yTRIfyJd
 h2BwqpOhDHPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021842"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021842"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:18 -0700
IronPort-SDR: FUGKoGaMedIKFszJHjI6qOR6Gp0cigBVXQvCIhQf3vMtwv/jmZWuIRvWG4fzg34tTfJMhwpIm4
 lk17drMTYXDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075782"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:14 -0700
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
Subject: [PATCH v4 01/13] mm/mempolicy: Add comment for missing LOCAL
Date:   Wed, 17 Mar 2021 11:39:58 +0800
Message-Id: <1615952410-36895-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

MPOL_LOCAL is a bit weird because it is simply a different name for an
existing behavior (preferred policy with no node mask). It has been this
way since it was added here:
commit 479e2802d09f ("mm: mempolicy: Make MPOL_LOCAL a real policy")

It is so similar to MPOL_PREFERRED in fact that when the policy is
created in mpol_new, the mode is set as PREFERRED, and an internal state
representing LOCAL doesn't exist.

To prevent future explorers from scratching their head as to why
MPOL_LOCAL isn't defined in the mpol_ops table, add a small comment
explaining the situations.

v2:
Change comment to refer to mpol_new (Michal)

Link: https://lore.kernel.org/r/20200630212517.308045-2-ben.widawsky@intel.com
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ab51132..4193566 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -427,6 +427,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	/* [MPOL_LOCAL] - see mpol_new() */
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
-- 
2.7.4

