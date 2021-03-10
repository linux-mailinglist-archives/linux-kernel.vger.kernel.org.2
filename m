Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B133334CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhCJFUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:20:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:49151 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCJFTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:19:52 -0500
IronPort-SDR: Mb9+xzPQOL3zsB4gpVM2HbpN9n1oc0y6QLnjaa5wbWakeSGpEI3sv7fZkjr/Y9pjJtiQDQRXEB
 IZqBoW4CVfzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188488458"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="188488458"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 21:19:52 -0800
IronPort-SDR: HjArI0DCgVD1LJhN/PbGPVNatw7uUI68n1NDXXKii5FoaVBJ4SDJRMYrxONeg2K27tGisNucgA
 se1DJbjn6tEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="431068445"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2021 21:19:48 -0800
Date:   Wed, 10 Mar 2021 13:19:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <20210310051947.GA33036@shbuild999.sh.intel.com>
References: <1614766858-90344-15-git-send-email-feng.tang@intel.com>
 <YD91jTMssJUCupJm@dhcp22.suse.cz>
 <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
 <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
 <d07f8675-939b-daea-c128-30ceecfac8a0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07f8675-939b-daea-c128-30ceecfac8a0@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:48:58AM -0800, Dave Hansen wrote:
> On 3/3/21 8:31 AM, Ben Widawsky wrote:
> >> I haven't got to the whole series yet. The real question is whether the
> >> first attempt to enforce the preferred mask is a general win. I would
> >> argue that it resembles the existing single node preferred memory policy
> >> because that one doesn't push heavily on the preferred node either. So
> >> dropping just the direct reclaim mode makes some sense to me.
> >>
> >> IIRC this is something I was recommending in an early proposal of the
> >> feature.
> > My assumption [FWIW] is that the usecases we've outlined for multi-preferred
> > would want more heavy pushing on the preference mask. However, maybe the uapi
> > could dictate how hard to try/not try.
> 
> There are two things that I think are important:
> 
> 1. MPOL_PREFERRED_MANY fallback away from the preferred nodes should be
>    *temporary*, even in the face of the preferred set being full.  That
>    means that _some_ reclaim needs to be done.  Kicking off kswapd is
>    fine for this.
> 2. MPOL_PREFERRED_MANY behavior should resemble MPOL_PREFERRED as
>    closely as possible.  We're just going to confuse users if they set a
>    single node in a MPOL_PREFERRED_MANY mask and get different behavior
>    from MPOL_PREFERRED.
> 
> While it would be nice, short-term, to steer MPOL_PREFERRED_MANY
> behavior toward how we expect it to get used first, I think it's a
> mistake if we do it at the cost of long-term divergence from MPOL_PREFERRED.

Hi All,

Based on the discussion, I update the patch as below, please review, thanks


From ea9e32fa8b6eff4a64d790b856e044adb30f04b5 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Wed, 10 Mar 2021 12:31:24 +0800
Subject: [PATCH] mm/mempolicy: speedup page alloc for MPOL_PREFERRED_MANY

When doing broader test, we noticed allocation slowness in one test
case that malloc memory with size which is slightly bigger than free
memory of targeted nodes, but much less then the total free memory
of system.

The reason is the code enters the slowpath of __alloc_pages_nodemask(),
which takes quite some time.

Since alloc_pages_policy() will give it a 2nd try with NULL nodemask,
we tried solution which creates a new gfp_mask bit __GFP_NO_SLOWPATH
for explicitely skipping entering slowpath in the first try, which is
brutal and costs one precious gfp mask bit.

Based on discussion with Michal/Ben/Dave [1], only skip entering direct
reclaim while still allowing it to wakeup kswapd, which can fix the
slowness and make MPOL_PREFERRED_MANY more close to the semantic of
MPOL_PREFERRED, while avoid creating a new gfp bit.

[1]. https://lore.kernel.org/lkml/1614766858-90344-15-git-send-email-feng.tang@intel.com/
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d66c1c0..00b19f7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2205,9 +2205,13 @@ static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
 	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
 	 * +-------------------------------+---------------+------------+
 	 */
-	if (pol->mode == MPOL_PREFERRED_MANY)
+	if (pol->mode == MPOL_PREFERRED_MANY) {
 		gfp_mask |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
+		/* Skip direct reclaim, as there will be a second try */
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+	}
+
 	page = __alloc_pages_nodemask(gfp_mask, order,
 				      policy_node(gfp, pol, preferred_nid),
 				      policy_nodemask(gfp, pol));
-- 
2.7.4


