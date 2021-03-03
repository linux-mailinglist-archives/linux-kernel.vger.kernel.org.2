Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0632BD5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452629AbhCCPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:52:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:21500 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232434AbhCCLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:05:57 -0500
IronPort-SDR: vw5wi3OD3tZ1AwJYBsOOgX7JUtdM6t3Wd5w0FF2K0hkNppZN7nu3hKolqCH65qNCqVwoOGPzID
 Jxcu+9jds4Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802750"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802750"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:54 -0800
IronPort-SDR: wq82e/lOEyykZxs9PW7u5fkZ50pf6gS06CUPn93kDOM5AOVzmbNuwLtWO4w8kTqTiRzCt2CZ29
 sgrE/QkcAxlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200421"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:50 -0800
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
Subject: [PATCH v3 RFC 14/14] mm: speedup page alloc for MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Date:   Wed,  3 Mar 2021 18:20:58 +0800
Message-Id: <1614766858-90344-15-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing broader test, we noticed allocation slowness in one test
case that malloc memory with size which is slightly bigger than free
memory of targeted nodes, but much less then the total free memory
of system.

The reason is the code enters the slowpath of __alloc_pages_nodemask(),
which takes quite some time. As alloc_pages_policy() will give it a 2nd
try with NULL nodemask, so there is no need to enter the slowpath for
the first try. Add a new gfp bit to skip the slowpath, so that user cases
like this can leverage.

With it, the malloc in such case is much accelerated as it never enters
the slowpath.

Adding a new gfp_mask bit is generally not liked, and another idea is to
add another nodemask to struct 'alloc_context', so it has 2: 'preferred-nmask'
and 'fallback-nmask', and they will be tried in turn if not NULL, with
it we can call __alloc_pages_nodemask() only once.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/gfp.h | 9 +++++++--
 mm/mempolicy.c      | 2 +-
 mm/page_alloc.c     | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6e479e9..81bacbe 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_NO_SLOWPATH	0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x800000u
+#define ___GFP_NOLOCKDEP	0x1000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -220,11 +221,15 @@ struct vm_area_struct;
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 
+/* Do not go into the slowpath */
+#define __GFP_NO_SLOWPATH	((__force gfp_t)___GFP_NO_SLOWPATH)
+
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
+
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d66c1c0..e84b56d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2206,7 +2206,7 @@ static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
 	 * +-------------------------------+---------------+------------+
 	 */
 	if (pol->mode == MPOL_PREFERRED_MANY)
-		gfp_mask |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+		gfp_mask |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_NO_SLOWPATH;
 
 	page = __alloc_pages_nodemask(gfp_mask, order,
 				      policy_node(gfp, pol, preferred_nid),
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d..969e3a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4993,7 +4993,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
-	if (likely(page))
+	if (likely(page) || (gfp_mask & __GFP_NO_SLOWPATH))
 		goto out;
 
 	/*
-- 
2.7.4

