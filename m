Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403A93AD895
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhFSIVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 04:21:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:35341 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhFSIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 04:21:11 -0400
IronPort-SDR: C38Ty2J+cMGN62B7E/7gopM5VC81Ct4ef84OYzpgplWBRXijEDzhuGiDEXQ+6vqU9ctKkG/XGM
 tKDiYPqgEXQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="204832180"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="204832180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 01:19:00 -0700
IronPort-SDR: EAFkQIV0YQb4ShX7KQYDb+rFptt4GpEgfPVo6iofXOuyzYQDYWeQWNOGMlBClYnQMtCBhw84g3
 g8feEGNBVrkA==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="485943493"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 01:18:57 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node
 migration order
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-3-ying.huang@intel.com>
        <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
Date:   Sat, 19 Jun 2021 16:18:55 +0800
In-Reply-To: <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com> (Zi Yan's
        message of "Fri, 18 Jun 2021 11:14:16 -0400")
Message-ID: <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 18 Jun 2021, at 2:15, Huang Ying wrote:
>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> When memory fills up on a node, memory contents can be
>> automatically migrated to another node.  The biggest problems are
>> knowing when to migrate and to where the migration should be
>> targeted.
>>
>> The most straightforward way to generate the "to where" list would
>> be to follow the page allocator fallback lists.  Those lists
>> already tell us if memory is full where to look next.  It would
>> also be logical to move memory in that order.
>>
>> But, the allocator fallback lists have a fatal flaw: most nodes
>> appear in all the lists.  This would potentially lead to migration
>> cycles (A->B, B->A, A->B, ...).
>>
>> Instead of using the allocator fallback lists directly, keep a
>> separate node migration ordering.  But, reuse the same data used
>> to generate page allocator fallback in the first place:
>> find_next_best_node().
>>
>> This means that the firmware data used to populate node distances
>> essentially dictates the ordering for now.  It should also be
>> architecture-neutral since all NUMA architectures have a working
>> find_next_best_node().
>>
>> The protocol for node_demotion[] access and writing is not
>> standard.  It has no specific locking and is intended to be read
>> locklessly.  Readers must take care to avoid observing changes
>> that appear incoherent.  This was done so that node_demotion[]
>> locking has no chance of becoming a bottleneck on large systems
>> with lots of CPUs in direct reclaim.
>>
>> This code is unused for now.  It will be called later in the
>> series.
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: osalvador <osalvador@suse.de>
>>
>> --
>>
>> Changes from 20200122:
>>  * Add big node_demotion[] comment
>> Changes from 20210302:
>>  * Fix typo in node_demotion[] comment
>> ---
>>  mm/internal.h   |   5 ++
>>  mm/migrate.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  mm/page_alloc.c |   2 +-
>>  3 files changed, 180 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 2f1182948aa6..0344cd78e170 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -522,12 +522,17 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
>>
>>  #ifdef CONFIG_NUMA
>>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
>> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>>  #else
>>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>>  				unsigned int order)
>>  {
>>  	return NODE_RECLAIM_NOSCAN;
>>  }
>> +static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
>> +{
>> +	return NUMA_NO_NODE;
>> +}
>>  #endif
>>
>>  extern int hwpoison_filter(struct page *p);
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 6cab668132f9..111f8565f75d 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1136,6 +1136,44 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>  	return rc;
>>  }
>>
>> +
>> +/*
>> + * node_demotion[] example:
>> + *
>> + * Consider a system with two sockets.  Each socket has
>> + * three classes of memory attached: fast, medium and slow.
>> + * Each memory class is placed in its own NUMA node.  The
>> + * CPUs are placed in the node with the "fast" memory.  The
>> + * 6 NUMA nodes (0-5) might be split among the sockets like
>> + * this:
>> + *
>> + *	Socket A: 0, 1, 2
>> + *	Socket B: 3, 4, 5
>> + *
>> + * When Node 0 fills up, its memory should be migrated to
>> + * Node 1.  When Node 1 fills up, it should be migrated to
>> + * Node 2.  The migration path start on the nodes with the
>> + * processors (since allocations default to this node) and
>> + * fast memory, progress through medium and end with the
>> + * slow memory:
>> + *
>> + *	0 -> 1 -> 2 -> stop
>> + *	3 -> 4 -> 5 -> stop
>> + *
>> + * This is represented in the node_demotion[] like this:
>> + *
>> + *	{  1, // Node 0 migrates to 1
>> + *	   2, // Node 1 migrates to 2
>> + *	  -1, // Node 2 does not migrate
>> + *	   4, // Node 3 migrates to 4
>> + *	   5, // Node 4 migrates to 5
>> + *	  -1} // Node 5 does not migrate
>> + */
>> +
>> +/*
>> + * Writes to this array occur without locking.  READ_ONCE()
>> + * is recommended for readers to ensure consistent reads.
>> + */
>>  static int node_demotion[MAX_NUMNODES] __read_mostly =
>>  	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>>
>> @@ -1150,7 +1188,13 @@ static int node_demotion[MAX_NUMNODES] __read_mostly =
>>   */
>>  int next_demotion_node(int node)
>>  {
>> -	return node_demotion[node];
>> +	/*
>> +	 * node_demotion[] is updated without excluding
>> +	 * this function from running.  READ_ONCE() avoids
>> +	 * reading multiple, inconsistent 'node' values
>> +	 * during an update.
>> +	 */
>> +	return READ_ONCE(node_demotion[node]);
>>  }
>
> Is it necessary to have two separate patches to add node_demotion and
> next_demotion_node() then modify it immediately? Maybe merge Patch 1 into 2?
>
> Hmm, I just checked Patch 3 and it changes node_demotion again and uses RCU.
> I guess it might be much simpler to just introduce node_demotion with RCU
> in this patch and Patch 3 only takes care of hotplug events.

Hi, Dave,

What do you think about this?

>>
>>  /*
>> @@ -3144,3 +3188,132 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>>  }
>>  EXPORT_SYMBOL(migrate_vma_finalize);
>>  #endif /* CONFIG_DEVICE_PRIVATE */
>> +
>> +/* Disable reclaim-based migration. */
>> +static void disable_all_migrate_targets(void)
>> +{
>> +	int node;
>> +
>> +	for_each_online_node(node)
>> +		node_demotion[node] = NUMA_NO_NODE;
>> +}
>> +
>> +/*
>> + * Find an automatic demotion target for 'node'.
>> + * Failing here is OK.  It might just indicate
>> + * being at the end of a chain.
>> + */
>> +static int establish_migrate_target(int node, nodemask_t *used)
>> +{
>> +	int migration_target;
>> +
>> +	/*
>> +	 * Can not set a migration target on a
>> +	 * node with it already set.
>> +	 *
>> +	 * No need for READ_ONCE() here since this
>> +	 * in the write path for node_demotion[].
>> +	 * This should be the only thread writing.
>> +	 */
>> +	if (node_demotion[node] != NUMA_NO_NODE)
>> +		return NUMA_NO_NODE;
>> +
>> +	migration_target = find_next_best_node(node, used);
>> +	if (migration_target == NUMA_NO_NODE)
>> +		return NUMA_NO_NODE;
>> +
>> +	node_demotion[node] = migration_target;
>> +
>> +	return migration_target;
>> +}
>> +
>> +/*
>> + * When memory fills up on a node, memory contents can be
>> + * automatically migrated to another node instead of
>> + * discarded at reclaim.
>> + *
>> + * Establish a "migration path" which will start at nodes
>> + * with CPUs and will follow the priorities used to build the
>> + * page allocator zonelists.
>> + *
>> + * The difference here is that cycles must be avoided.  If
>> + * node0 migrates to node1, then neither node1, nor anything
>> + * node1 migrates to can migrate to node0.
>> + *
>> + * This function can run simultaneously with readers of
>> + * node_demotion[].  However, it can not run simultaneously
>> + * with itself.  Exclusion is provided by memory hotplug events
>> + * being single-threaded.
>> + */
>> +static void __set_migration_target_nodes(void)
>> +{
>> +	nodemask_t next_pass	= NODE_MASK_NONE;
>> +	nodemask_t this_pass	= NODE_MASK_NONE;
>> +	nodemask_t used_targets = NODE_MASK_NONE;
>> +	int node;
>> +
>> +	/*
>> +	 * Avoid any oddities like cycles that could occur
>> +	 * from changes in the topology.  This will leave
>> +	 * a momentary gap when migration is disabled.
>> +	 */
>> +	disable_all_migrate_targets();
>> +
>> +	/*
>> +	 * Ensure that the "disable" is visible across the system.
>> +	 * Readers will see either a combination of before+disable
>> +	 * state or disable+after.  They will never see before and
>> +	 * after state together.
>> +	 *
>> +	 * The before+after state together might have cycles and
>> +	 * could cause readers to do things like loop until this
>> +	 * function finishes.  This ensures they can only see a
>> +	 * single "bad" read and would, for instance, only loop
>> +	 * once.
>> +	 */
>> +	smp_wmb();
>> +
>> +	/*
>> +	 * Allocations go close to CPUs, first.  Assume that
>> +	 * the migration path starts at the nodes with CPUs.
>> +	 */
>> +	next_pass = node_states[N_CPU];
>
> Is there a plan of allowing user to change where the migration
> path starts? Or maybe one step further providing an interface
> to allow user to specify the demotion path. Something like
> /sys/devices/system/node/node*/node_demotion.

I don't think that's necessary at least for now.  Do you know any real
world use case for this?

Best Regards,
Huang, Ying

[snip]
