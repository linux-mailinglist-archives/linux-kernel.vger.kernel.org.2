Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C932DF93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCECVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:21:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:15710 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhCECVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:21:34 -0500
IronPort-SDR: 0SwaPSXD4v3u8I/MbhJxdduLSEhUHl1TkNQ84h0+yceLHZnTHm3qhmjyHoObd5dfsOoBQUUVwW
 24Lhl/vRidOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="167446370"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="167446370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 18:21:27 -0800
IronPort-SDR: mvh8AuzZGQ8jGtK6aR008QyOmhqP4HI5sVJHzqbx60ezQUE4aI7QPtdUXpYE2HwcyOTcR/uJzm
 cNsxrrQQ+slw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="401047505"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2021 18:21:23 -0800
Date:   Fri, 5 Mar 2021 10:21:22 +0800
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
        Andi leen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <20210305022122.GA17707@shbuild999.sh.intel.com>
References: <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
 <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
 <YD/D9hckPOA+41+D@dhcp22.suse.cz>
 <20210303172250.wbp47skyuf6r37wi@intel.com>
 <20210304081414.GC43191@shbuild999.sh.intel.com>
 <YEDZvKdurj+zCXEL@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEDZvKdurj+zCXEL@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 01:59:40PM +0100, Michal Hocko wrote:
> On Thu 04-03-21 16:14:14, Feng Tang wrote:
> > On Wed, Mar 03, 2021 at 09:22:50AM -0800, Ben Widawsky wrote:
> > > On 21-03-03 18:14:30, Michal Hocko wrote:
> > > > On Wed 03-03-21 08:31:41, Ben Widawsky wrote:
> > > > > On 21-03-03 14:59:35, Michal Hocko wrote:
> > > > > > On Wed 03-03-21 21:46:44, Feng Tang wrote:
> > > > > > > On Wed, Mar 03, 2021 at 09:18:32PM +0800, Tang, Feng wrote:
> > > > > > > > On Wed, Mar 03, 2021 at 01:32:11PM +0100, Michal Hocko wrote:
> > > > > > > > > On Wed 03-03-21 20:18:33, Feng Tang wrote:
> > > > > > [...]
> > > > > > > > > > One thing I tried which can fix the slowness is:
> > > > > > > > > > 
> > > > > > > > > > +	gfp_mask &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
> > > > > > > > > > 
> > > > > > > > > > which explicitly clears the 2 kinds of reclaim. And I thought it's too
> > > > > > > > > > hacky and didn't mention it in the commit log.
> > > > > > > > > 
> > > > > > > > > Clearing __GFP_DIRECT_RECLAIM would be the right way to achieve
> > > > > > > > > GFP_NOWAIT semantic. Why would you want to exclude kswapd as well? 
> > > > > > > > 
> > > > > > > > When I tried gfp_mask &= ~__GFP_DIRECT_RECLAIM, the slowness couldn't
> > > > > > > > be fixed.
> > > > > > > 
> > > > > > > I just double checked by rerun the test, 'gfp_mask &= ~__GFP_DIRECT_RECLAIM'
> > > > > > > can also accelerate the allocation much! though is still a little slower than
> > > > > > > this patch. Seems I've messed some of the tries, and sorry for the confusion!
> > > > > > > 
> > > > > > > Could this be used as the solution? or the adding another fallback_nodemask way?
> > > > > > > but the latter will change the current API quite a bit.
> > > > > > 
> > > > > > I haven't got to the whole series yet. The real question is whether the
> > > > > > first attempt to enforce the preferred mask is a general win. I would
> > > > > > argue that it resembles the existing single node preferred memory policy
> > > > > > because that one doesn't push heavily on the preferred node either. So
> > > > > > dropping just the direct reclaim mode makes some sense to me.
> > > > > > 
> > > > > > IIRC this is something I was recommending in an early proposal of the
> > > > > > feature.
> > > > > 
> > > > > My assumption [FWIW] is that the usecases we've outlined for multi-preferred
> > > > > would want more heavy pushing on the preference mask. However, maybe the uapi
> > > > > could dictate how hard to try/not try.
> > > > 
> > > > What does that mean and what is the expectation from the kernel to be
> > > > more or less cast in stone?
> > > > 
> > > 
> > > (I'm not positive I've understood your question, so correct me if I
> > > misunderstood)
> > > 
> > > I'm not sure there is a stone-cast way to define it nor should we. At the very
> > > least though, something in uapi that has a general mapping to GFP flags
> > > (specifically around reclaim) for the first round of allocation could make
> > > sense.
> > > 
> > > In my head there are 3 levels of request possible for multiple nodes:
> > > 1. BIND: Those nodes or die.
> > > 2. Preferred hard: Those nodes and I'm willing to wait. Fallback if impossible.
> > > 3. Preferred soft: Those nodes but I don't want to wait.
> > > 
> > > Current UAPI in the series doesn't define a distinction between 2, and 3. As I
> > > understand the change, Feng is defining the behavior to be #3, which makes #2
> > > not an option. I sort of punted on defining it entirely, in the beginning.
> > 
> > As discussed earlier in the thread, one less hacky solution is to clear
> > __GFP_DIRECT_RECLAIM bit so that it won't go into direct reclaim, but still
> > wakeup the kswapd of target nodes and retry, which sits now between 'Preferred hard'
> > and 'Preferred soft' :)
> 
> Yes that is what I've had in mind when talking about a lightweight
> attempt.
> 
> > For current MPOL_PREFERRED, its semantic is also 'Preferred hard', that it
> 
> Did you mean to say prefer soft? Because the direct reclaim is attempted
> only when node reclaim is enabled.
> 
> > will check free memory of other nodes before entering slowpath waiting.
> 
> Yes, hence "soft" semantic.

Yes, it's the #3 item: 'Preferred soft' 

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
