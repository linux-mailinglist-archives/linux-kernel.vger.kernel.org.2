Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074FE396F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhFAIqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:46:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhFAIqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:46:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622537080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw3tVST1fAJ8CKCXcRmhBeLdhca4454ZmSsP+4SzR/c=;
        b=Y7VvU0jGVR0m9j8Q6IkIhX+VUBCUXusvT1RPc9i+5kTiLTmpyWi+dszsl89SpeSerOtt3+
        MizcP4PfOA8ztpNvrKwia0b550sQpc+doH5WRuq0oEp2Y1aqlQ8tBn/rl3yKTH7XIPu6Rk
        eeUTLfaW5THvYgppIhtMrdSGahs7iEY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 709D7ADE7;
        Tue,  1 Jun 2021 08:44:40 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:44:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <YLXzd95duZ3va7Te@dhcp22.suse.cz>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <1622469956-82897-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622469956-82897-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 22:05:55, Feng Tang wrote:
> MPOL_LOCAL policy has been setup as a real policy, but it is still
> handled like a faked POL_PREFERRED policy with one internal
> MPOL_F_LOCAL flag bit set, and there are many places having to
> judge the real 'prefer' or the 'local' policy, which are quite
> confusing.
> 
> In current code, there are 4 cases that MPOL_LOCAL are used:
> 1. user specifies 'local' policy
> 2. user specifies 'prefer' policy, but with empty nodemask
> 3. system 'default' policy is used
> 4. 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
>    flag set, and when it is 'rebind' to a nodemask which doesn't
>    contains the 'preferred' node, it will perform as 'local' policy
> 
> So make 'local' a real policy instead of a fake 'prefer' one, and
> kill MPOL_F_LOCAL bit, which can greatly reduce the confusion for
> code reading.
> 
> For case 4, the logic of mpol_rebind_preferred() is confusing, as
> Michal Hocko pointed out:
> 
>  "
>  I do believe that rebinding preferred policy is just bogus and
>  it should be dropped altogether on the ground that a preference
>  is a mere hint from userspace where to start the allocation.
>  Unless I am missing something cpusets will be always authoritative
>  for the final placement. The preferred node just acts as a starting
>  point and it should be really preserved when cpusets changes.
>  Otherwise we have a very subtle behavior corner cases.
>  "
> So dump all the tricky transformation between 'prefer' and 'local',
> and just record the new nodemask of rebinding.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

I like this very much! It simplifies a tricky code and also a very
dubious behavior. I would like to hear from others whether there might
be some userspace depending on this obscure behavior though. One never
knows...

Some more notes/questions below

[...]
> @@ -239,25 +240,19 @@ static int mpol_set_nodemask(struct mempolicy *pol,
>  		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
>  
>  	VM_BUG_ON(!nodes);
> -	if (pol->mode == MPOL_PREFERRED && nodes_empty(*nodes))
> -		nodes = NULL;	/* explicit local allocation */
> -	else {
> -		if (pol->flags & MPOL_F_RELATIVE_NODES)
> -			mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
> -		else
> -			nodes_and(nsc->mask2, *nodes, nsc->mask1);
>  
> -		if (mpol_store_user_nodemask(pol))
> -			pol->w.user_nodemask = *nodes;
> -		else
> -			pol->w.cpuset_mems_allowed =
> -						cpuset_current_mems_allowed;
> -	}
> +	if (pol->flags & MPOL_F_RELATIVE_NODES)
> +		mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
> +	else
> +		nodes_and(nsc->mask2, *nodes, nsc->mask1);

Maybe I've just got lost here but why don't you need to check for the
local policy anymore? mpol_new will take care of the MPOL_PREFERRED &&
nodes_empty special but why do we want/need all this for a local policy
at all?

>  
> -	if (nodes)
> -		ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
> +	if (mpol_store_user_nodemask(pol))
> +		pol->w.user_nodemask = *nodes;
>  	else
> -		ret = mpol_ops[pol->mode].create(pol, NULL);
> +		pol->w.cpuset_mems_allowed =
> +					cpuset_current_mems_allowed;

please use a single line. This is just harder to read. You will cross
the line limit but readability should be preferred here.

[...]

I haven't spotted anything else.
-- 
Michal Hocko
SUSE Labs
