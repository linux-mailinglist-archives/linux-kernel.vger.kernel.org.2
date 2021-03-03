Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41F32BE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbhCCRbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:54407 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444912AbhCCNre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:34 -0500
IronPort-SDR: MfAHWZZe+dpzNKSrbtfq86fVtR+qDajcqc2oZnhdoJ1WGt6Bp3oPlZPNiXvRyuUvdFdCWeMOf0
 hu8yoOG+b4OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167092222"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="167092222"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 05:46:49 -0800
IronPort-SDR: DQzN5Uw4VmMcA5u3ynfKDPQDTbOf6GWMs3uEdI/3uIe+6nX54cNLSG/3lO5LmhxOeChBUok4Fe
 AYVcx7EHeiJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="399721837"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2021 05:46:45 -0800
Date:   Wed, 3 Mar 2021 21:46:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        Andi leen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <20210303134644.GC78458@shbuild999.sh.intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-15-git-send-email-feng.tang@intel.com>
 <YD91jTMssJUCupJm@dhcp22.suse.cz>
 <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303131832.GB78458@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:18:32PM +0800, Tang, Feng wrote:
> On Wed, Mar 03, 2021 at 01:32:11PM +0100, Michal Hocko wrote:
> > On Wed 03-03-21 20:18:33, Feng Tang wrote:
> > > On Wed, Mar 03, 2021 at 08:07:17PM +0800, Tang, Feng wrote:
> > > > Hi Michal,
> > > > 
> > > > On Wed, Mar 03, 2021 at 12:39:57PM +0100, Michal Hocko wrote:
> > > > > On Wed 03-03-21 18:20:58, Feng Tang wrote:
> > > > > > When doing broader test, we noticed allocation slowness in one test
> > > > > > case that malloc memory with size which is slightly bigger than free
> > > > > > memory of targeted nodes, but much less then the total free memory
> > > > > > of system.
> > > > > > 
> > > > > > The reason is the code enters the slowpath of __alloc_pages_nodemask(),
> > > > > > which takes quite some time. As alloc_pages_policy() will give it a 2nd
> > > > > > try with NULL nodemask, so there is no need to enter the slowpath for
> > > > > > the first try. Add a new gfp bit to skip the slowpath, so that user cases
> > > > > > like this can leverage.
> > > > > > 
> > > > > > With it, the malloc in such case is much accelerated as it never enters
> > > > > > the slowpath.
> > > > > > 
> > > > > > Adding a new gfp_mask bit is generally not liked, and another idea is to
> > > > > > add another nodemask to struct 'alloc_context', so it has 2: 'preferred-nmask'
> > > > > > and 'fallback-nmask', and they will be tried in turn if not NULL, with
> > > > > > it we can call __alloc_pages_nodemask() only once.
> > > > > 
> > > > > Yes, it is very much disliked. Is there any reason why you cannot use
> > > > > GFP_NOWAIT for that purpose?
> > > > 
> > > > I did try that at the first place, but it didn't obviously change the slowness.
> > > > I assumed the direct claim was still involved as GFP_NOWAIT only impact kswapd
> > > > reclaim.
> > 
> > I assume you haven't really created gfp mask correctly. What was the
> > exact gfp mask you have used?
> 
> The testcase is a malloc with multi-preferred-node policy, IIRC, the gfp
> mask is HIGHUSER_MOVABLE originally, and code here ORs (__GFP_RETRY_MAYFAIL | __GFP_NOWARN).
> 
> As GFP_WAIT == __GFP_KSWAPD_RECLAIM, in this test case, the bit is already set.
> 
> > > 
> > > One thing I tried which can fix the slowness is:
> > > 
> > > +	gfp_mask &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
> > > 
> > > which explicitly clears the 2 kinds of reclaim. And I thought it's too
> > > hacky and didn't mention it in the commit log.
> > 
> > Clearing __GFP_DIRECT_RECLAIM would be the right way to achieve
> > GFP_NOWAIT semantic. Why would you want to exclude kswapd as well? 
> 
> When I tried gfp_mask &= ~__GFP_DIRECT_RECLAIM, the slowness couldn't
> be fixed.

I just double checked by rerun the test, 'gfp_mask &= ~__GFP_DIRECT_RECLAIM'
can also accelerate the allocation much! though is still a little slower than
this patch. Seems I've messed some of the tries, and sorry for the confusion!

Could this be used as the solution? or the adding another fallback_nodemask way?
but the latter will change the current API quite a bit.

Thanks,
Feng

