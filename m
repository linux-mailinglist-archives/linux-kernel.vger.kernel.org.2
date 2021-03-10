Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92204333BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhCJLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:49:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:21323 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhCJLtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:49:20 -0500
IronPort-SDR: O8G2jLWaRy5KgcYxMX5QuXvnPJT6bdf6jmb51nRAfR7aiEcr8YWN3r4cUr61iLgC4H1RziQf/X
 662AO8Y2Mh+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175553693"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="175553693"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 03:49:19 -0800
IronPort-SDR: U9rgF9K7qXapMdDxZuv6kGfPi26I0ayRc+zblwqAWHyy2VX1SExU1JAqr1SmGd9O5leJ6z8/TX
 UP3QDofCmE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="376936658"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2021 03:49:15 -0800
Date:   Wed, 10 Mar 2021 19:49:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
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
Message-ID: <20210310114915.GA71505@shbuild999.sh.intel.com>
References: <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
 <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
 <d07f8675-939b-daea-c128-30ceecfac8a0@intel.com>
 <20210310051947.GA33036@shbuild999.sh.intel.com>
 <YEiU6/5BXM7v4AOu@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEiU6/5BXM7v4AOu@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:44:11AM +0100, Michal Hocko wrote:
> On Wed 10-03-21 13:19:47, Feng Tang wrote:
> [...]
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d66c1c0..00b19f7 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2205,9 +2205,13 @@ static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
> >  	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
> >  	 * +-------------------------------+---------------+------------+
> >  	 */
> > -	if (pol->mode == MPOL_PREFERRED_MANY)
> > +	if (pol->mode == MPOL_PREFERRED_MANY) {
> >  		gfp_mask |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> >  
> > +		/* Skip direct reclaim, as there will be a second try */
> > +		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
> 
> __GFP_RETRY_MAYFAIL is a reclaim modifier which doesn't make any sense
> without __GFP_DIRECT_RECLAIM. Also I think it would be better to have a
> proper allocation flags in the initial patch which implements the
> fallback.

Ok, will remove the __GFP_RETRY_MAYFAIL setting and folder this with
previous patch(8/14).

Thanks,
Feng

> > +	}
> > +
> >  	page = __alloc_pages_nodemask(gfp_mask, order,
> >  				      policy_node(gfp, pol, preferred_nid),
> >  				      policy_nodemask(gfp, pol));
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
