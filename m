Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB239725B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhFALbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:31:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:39056 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhFALbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:31:06 -0400
IronPort-SDR: 2Umm7eWkLcfe/4qeRH/0JwjBJ716cawpZ+PCjMX1pZQQkYN+zQFRcGRalFwNeFLpmmBp18xwvV
 mGR5kjvDP4rQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190640960"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="190640960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 04:29:24 -0700
IronPort-SDR: LCr6PBFbfXLyRnlYGo22DaUt3W583aCmAc5Xg6BimLd/avK9YTqir8+Bgx027AUorMEdwvf3CF
 Pth/dFGeAyiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="479244076"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2021 04:29:21 -0700
Date:   Tue, 1 Jun 2021 19:29:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [v3 PATCH 2/3] mm/mempolicy: don't handle MPOL_LOCAL like a fake
 MPOL_PREFERRED policy
Message-ID: <20210601112920.GB80730@shbuild999.sh.intel.com>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <1622469956-82897-3-git-send-email-feng.tang@intel.com>
 <YLXzd95duZ3va7Te@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLXzd95duZ3va7Te@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:44:39AM +0200, Michal Hocko wrote:
> On Mon 31-05-21 22:05:55, Feng Tang wrote:
> > MPOL_LOCAL policy has been setup as a real policy, but it is still
> > handled like a faked POL_PREFERRED policy with one internal
> > MPOL_F_LOCAL flag bit set, and there are many places having to
> > judge the real 'prefer' or the 'local' policy, which are quite
> > confusing.
> > 
> > In current code, there are 4 cases that MPOL_LOCAL are used:
> > 1. user specifies 'local' policy
> > 2. user specifies 'prefer' policy, but with empty nodemask
> > 3. system 'default' policy is used
> > 4. 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
> >    flag set, and when it is 'rebind' to a nodemask which doesn't
> >    contains the 'preferred' node, it will perform as 'local' policy
> > 
> > So make 'local' a real policy instead of a fake 'prefer' one, and
> > kill MPOL_F_LOCAL bit, which can greatly reduce the confusion for
> > code reading.
> > 
> > For case 4, the logic of mpol_rebind_preferred() is confusing, as
> > Michal Hocko pointed out:
> > 
> >  "
> >  I do believe that rebinding preferred policy is just bogus and
> >  it should be dropped altogether on the ground that a preference
> >  is a mere hint from userspace where to start the allocation.
> >  Unless I am missing something cpusets will be always authoritative
> >  for the final placement. The preferred node just acts as a starting
> >  point and it should be really preserved when cpusets changes.
> >  Otherwise we have a very subtle behavior corner cases.
> >  "
> > So dump all the tricky transformation between 'prefer' and 'local',
> > and just record the new nodemask of rebinding.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> I like this very much! It simplifies a tricky code and also a very
> dubious behavior. I would like to hear from others whether there might
> be some userspace depending on this obscure behavior though. One never
> knows...
> 
> Some more notes/questions below
> 
> [...]
> > @@ -239,25 +240,19 @@ static int mpol_set_nodemask(struct mempolicy *pol,
> >  		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
> >  
> >  	VM_BUG_ON(!nodes);
> > -	if (pol->mode == MPOL_PREFERRED && nodes_empty(*nodes))
> > -		nodes = NULL;	/* explicit local allocation */
> > -	else {
> > -		if (pol->flags & MPOL_F_RELATIVE_NODES)
> > -			mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
> > -		else
> > -			nodes_and(nsc->mask2, *nodes, nsc->mask1);
> >  
> > -		if (mpol_store_user_nodemask(pol))
> > -			pol->w.user_nodemask = *nodes;
> > -		else
> > -			pol->w.cpuset_mems_allowed =
> > -						cpuset_current_mems_allowed;
> > -	}
> > +	if (pol->flags & MPOL_F_RELATIVE_NODES)
> > +		mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
> > +	else
> > +		nodes_and(nsc->mask2, *nodes, nsc->mask1);
> 
> Maybe I've just got lost here but why don't you need to check for the
> local policy anymore? mpol_new will take care of the MPOL_PREFERRED &&
> nodes_empty special but why do we want/need all this for a local policy
> at all?
 
You are right that 'local' policy doesn't need this, it should just
return in the early port of this function, like 'default' policy, which
can remove the useless nop mpol_new_local().

> >  
> > -	if (nodes)
> > -		ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
> > +	if (mpol_store_user_nodemask(pol))
> > +		pol->w.user_nodemask = *nodes;
> >  	else
> > -		ret = mpol_ops[pol->mode].create(pol, NULL);
> > +		pol->w.cpuset_mems_allowed =
> > +					cpuset_current_mems_allowed;
> 
> please use a single line. This is just harder to read. You will cross
> the line limit but readability should be preferred here.
 
Will change.

Thanks,
Feng

> [...]
> 
> I haven't spotted anything else.
> -- 
> Michal Hocko
> SUSE Labs
