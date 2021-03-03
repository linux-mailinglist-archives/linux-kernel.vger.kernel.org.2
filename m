Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D197A32BEC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575631AbhCCRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:35:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238439AbhCCOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:14:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614779635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TQ2RBE4z055fHuqnHKpsqZTckQoxi2cA1K9u68p52Q=;
        b=lvmW7MB8x0GNReTSj5AlI+rASO06gPQjinfsV5RewgY/1x/JC7XrC3n3GdheHnzfV987T0
        oKYnFcPbQXMTqF61TtWx92lbr7IwXIDShKnbZmKvKKjIrjStLXAE8qNjv2lqzEF7zJo7tS
        YAk97XZ/ah1WS7hoJKzMr3beKMPEbVk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 285F2AC24;
        Wed,  3 Mar 2021 13:53:55 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:53:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <YD+U8kA4pnP20iRA@dhcp22.suse.cz>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 21:18:32, Feng Tang wrote:
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

Yes, you have to clear the gfp flag for the direct reclaim. I can see
how that can be confusing though
 
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

OK, I thought that you wanted to prevent the direct reclaim because that
is the usual suspect for a slow down. If this is not not related to the
direct reclaim then please try to find out what the acutal bottle neck
is. Also how big of a slowdown are we talking about here?
-- 
Michal Hocko
SUSE Labs
