Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8509F35F353
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbhDNMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:36616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhDNMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:17:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618402624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAtrD1tNAWI9BzuevlzoirkMUubcdEDcF7Ti8gTJYRo=;
        b=ekbeNKYyjkEa+HbaK28aaBu0fheOw/hei/9DUicHIhmp/aDf4RB0ON8YJy/1hESYGUzd+7
        xxrGHnpYO/Lj19pye0OvbSHVrkWOBuEU8q7JRtkYs5eqAILrE2GXDDQgwU6AYX0v6idKEt
        m6FCZT+eZssyjWmPS1xSsjWDmsDOS2Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 512CBB013;
        Wed, 14 Apr 2021 12:17:04 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:17:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 02/13] mm/mempolicy: convert single preferred_node to
 full nodemask
Message-ID: <YHbdPkhPp5x2o2ob@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:39:59, Feng Tang wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The NUMA APIs currently allow passing in a "preferred node" as a
> single bit set in a nodemask.  If more than one bit it set, bits
> after the first are ignored.  Internally, this is implemented as
> a single integer: mempolicy->preferred_node.
> 
> This single node is generally OK for location-based NUMA where
> memory being allocated will eventually be operated on by a single
> CPU.  However, in systems with multiple memory types, folks want
> to target a *type* of memory instead of a location.  For instance,
> someone might want some high-bandwidth memory but do not care about
> the CPU next to which it is allocated.  Or, they want a cheap,
> high capacity allocation and want to target all NUMA nodes which
> have persistent memory in volatile mode.  In both of these cases,
> the application wants to target a *set* of nodes, but does not
> want strict MPOL_BIND behavior as that could lead to OOM killer or
> SIGSEGV.
> 
> To get that behavior, a MPOL_PREFERRED mode is desirable, but one
> that honors multiple nodes to be set in the nodemask.
> 
> The first step in that direction is to be able to internally store
> multiple preferred nodes, which is implemented in this patch.
> 
> This should not have any function changes and just switches the
> internal representation of mempolicy->preferred_node from an
> integer to a nodemask called 'mempolicy->preferred_nodes'.
> 
> This is not a pie-in-the-sky dream for an API.  This was a response to a
> specific ask of more than one group at Intel.  Specifically:
> 
> 1. There are existing libraries that target memory types such as
>    https://github.com/memkind/memkind.  These are known to suffer
>    from SIGSEGV's when memory is low on targeted memory "kinds" that
>    span more than one node.  The MCDRAM on a Xeon Phi in "Cluster on
>    Die" mode is an example of this.
> 2. Volatile-use persistent memory users want to have a memory policy
>    which is targeted at either "cheap and slow" (PMEM) or "expensive and
>    fast" (DRAM).  However, they do not want to experience allocation
>    failures when the targeted type is unavailable.
> 3. Allocate-then-run.  Generally, we let the process scheduler decide
>    on which physical CPU to run a task.  That location provides a
>    default allocation policy, and memory availability is not generally
>    considered when placing tasks.  For situations where memory is
>    valuable and constrained, some users want to allocate memory first,
>    *then* allocate close compute resources to the allocation.  This is
>    the reverse of the normal (CPU) model.  Accelerators such as GPUs
>    that operate on core-mm-managed memory are interested in this model.

This is a very useful background for the feature. The changelog for the
specific patch is rather modest and it would help to add more details
about the change. The mempolicy code is a maze and it is quite easy to
get lost there. I hope we are not going to miss something just by hunting
preferred_node usage...
 
[...]
> @@ -345,22 +345,26 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
>  						const nodemask_t *nodes)
>  {
>  	nodemask_t tmp;
> +	nodemask_t preferred_node;

This is rather harsh. Some distribution kernels use high NODES_SHIFT
(SLES has 10 for x86) so this will consume additional 1K on the stack.
Unless I am missing something this shouldn't be called in deep call
chains but still.

> +
> +	/* MPOL_PREFERRED uses only the first node in the mask */
> +	preferred_node = nodemask_of_node(first_node(*nodes));
>  
>  	if (pol->flags & MPOL_F_STATIC_NODES) {
>  		int node = first_node(pol->w.user_nodemask);
>  
>  		if (node_isset(node, *nodes)) {
> -			pol->v.preferred_node = node;
> +			pol->v.preferred_nodes = nodemask_of_node(node);
>  			pol->flags &= ~MPOL_F_LOCAL;
>  		} else
>  			pol->flags |= MPOL_F_LOCAL;
>  	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
>  		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
> -		pol->v.preferred_node = first_node(tmp);
> +		pol->v.preferred_nodes = tmp;
>  	} else if (!(pol->flags & MPOL_F_LOCAL)) {
> -		pol->v.preferred_node = node_remap(pol->v.preferred_node,
> -						   pol->w.cpuset_mems_allowed,
> -						   *nodes);
> +		nodes_remap(tmp, pol->v.preferred_nodes,
> +			    pol->w.cpuset_mems_allowed, preferred_node);
> +		pol->v.preferred_nodes = tmp;
>  		pol->w.cpuset_mems_allowed = *nodes;
>  	}

I have to say that I really disliked the original code (becasuse it
fiddles with user provided input behind the back) I got lost here
completely. What the heck is going on?
a) why do we even care remaping a hint which is overriden by the cpuset
at the page allocator level and b) why do we need to allocate _two_
potentially large temporary bitmaps for that here?

I haven't spotted anything unexpected in the rest.
-- 
Michal Hocko
SUSE Labs
