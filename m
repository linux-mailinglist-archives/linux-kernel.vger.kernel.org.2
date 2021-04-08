Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C032357E31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhDHIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:35:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhDHIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:35:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1442B023;
        Thu,  8 Apr 2021 08:34:49 +0000 (UTC)
Date:   Thu, 8 Apr 2021 10:26:01 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
Message-ID: <YG6+Gbs3C1MmYb7C@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183219.DC1928FA@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:32:19AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> When memory fills up on a node, memory contents can be
> automatically migrated to another node.  The biggest problems are
> knowing when to migrate and to where the migration should be
> targeted.
> 
> The most straightforward way to generate the "to where" list would
> be to follow the page allocator fallback lists.  Those lists
> already tell us if memory is full where to look next.  It would
> also be logical to move memory in that order.
> 
> But, the allocator fallback lists have a fatal flaw: most nodes
> appear in all the lists.  This would potentially lead to migration
> cycles (A->B, B->A, A->B, ...).
> 
> Instead of using the allocator fallback lists directly, keep a
> separate node migration ordering.  But, reuse the same data used
> to generate page allocator fallback in the first place:
> find_next_best_node().
> 
> This means that the firmware data used to populate node distances
> essentially dictates the ordering for now.  It should also be
> architecture-neutral since all NUMA architectures have a working
> find_next_best_node().
> 
> The protocol for node_demotion[] access and writing is not
> standard.  It has no specific locking and is intended to be read
> locklessly.  Readers must take care to avoid observing changes
> that appear incoherent.  This was done so that node_demotion[]

It might be just me being dense here, but that reads odd.

"Readers must take care to avoid observing changes that appear
incoherent" - I am not sure what is that supposed to mean.

I guess you mean readers of next_demotion_node()?
And if so, how do they have to take care? And what would apply for
"incoherent" terminology here?

> locking has no chance of becoming a bottleneck on large systems
> with lots of CPUs in direct reclaim.
> 
> This code is unused for now.  It will be called later in the
> series.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>

...

> +static void __set_migration_target_nodes(void)
> +{
> +	nodemask_t next_pass	= NODE_MASK_NONE;
> +	nodemask_t this_pass	= NODE_MASK_NONE;
> +	nodemask_t used_targets = NODE_MASK_NONE;
> +	int node;
> +
> +	/*
> +	 * Avoid any oddities like cycles that could occur
> +	 * from changes in the topology.  This will leave
> +	 * a momentary gap when migration is disabled.
> +	 */
> +	disable_all_migrate_targets();
> +
> +	/*
> +	 * Ensure that the "disable" is visible across the system.
> +	 * Readers will see either a combination of before+disable
> +	 * state or disable+after.  They will never see before and
> +	 * after state together.
> +	 *
> +	 * The before+after state together might have cycles and
> +	 * could cause readers to do things like loop until this
> +	 * function finishes.  This ensures they can only see a
> +	 * single "bad" read and would, for instance, only loop
> +	 * once.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Allocations go close to CPUs, first.  Assume that
> +	 * the migration path starts at the nodes with CPUs.
> +	 */
> +	next_pass = node_states[N_CPU];
> +again:
> +	this_pass = next_pass;
> +	next_pass = NODE_MASK_NONE;
> +	/*
> +	 * To avoid cycles in the migration "graph", ensure
> +	 * that migration sources are not future targets by
> +	 * setting them in 'used_targets'.  Do this only
> +	 * once per pass so that multiple source nodes can
> +	 * share a target node.
> +	 *
> +	 * 'used_targets' will become unavailable in future
> +	 * passes.  This limits some opportunities for
> +	 * multiple source nodes to share a destination.
> +	 */
> +	nodes_or(used_targets, used_targets, this_pass);
> +	for_each_node_mask(node, this_pass) {
> +		int target_node = establish_migrate_target(node, &used_targets);
> +
> +		if (target_node == NUMA_NO_NODE)
> +			continue;
> +
> +		/* Visit targets from this pass in the next pass: */
> +		node_set(target_node, next_pass);
> +	}
> +	/* Is another pass necessary? */
> +	if (!nodes_empty(next_pass))

When I read this I was about puzzled and it took me a while to figure
out how the passes were made.
I think this could benefit from a better explanation on how the passes
are being performed e.g: why next_pass should be empty before leaving.

Other than that looks good to me.


-- 
Oscar Salvador
SUSE L3
