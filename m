Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA77E3AFA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFVA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:57:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:2221 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhFVA5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:57:38 -0400
IronPort-SDR: +Q5U9qzgDuzdN1pEUnOzi64vnugbB2vgh8uKTnH4EmG6XW3cfw2mV0Tj9FDaMzdGvh6+pjmHDi
 lYzSZ/NnrEnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="207000739"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="207000739"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:55:23 -0700
IronPort-SDR: mUggc9ePv/v55XF4K8RrJjPDx7y/v5/71SjTI2s55xRsFIw6mpTUN8xGGB60P9hX/wB4ZpDN3W
 fwxo5/yZc+DA==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="454075302"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:55:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node
 migration order
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-3-ying.huang@intel.com>
        <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
        <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHbLzkoVfj9bhDv7RE5rB_8h0O6Wgdoqe5fYJ1rUOHA=AR5uJQ@mail.gmail.com>
Date:   Tue, 22 Jun 2021 08:55:18 +0800
In-Reply-To: <CAHbLzkoVfj9bhDv7RE5rB_8h0O6Wgdoqe5fYJ1rUOHA=AR5uJQ@mail.gmail.com>
        (Yang Shi's message of "Mon, 21 Jun 2021 12:51:30 -0700")
Message-ID: <87wnqmn2fd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Sat, Jun 19, 2021 at 1:19 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>> > On 18 Jun 2021, at 2:15, Huang Ying wrote:
>> >
>> >> From: Dave Hansen <dave.hansen@linux.intel.com>
>> >>
>> >> When memory fills up on a node, memory contents can be
>> >> automatically migrated to another node.  The biggest problems are
>> >> knowing when to migrate and to where the migration should be
>> >> targeted.
>> >>
>> >> The most straightforward way to generate the "to where" list would
>> >> be to follow the page allocator fallback lists.  Those lists
>> >> already tell us if memory is full where to look next.  It would
>> >> also be logical to move memory in that order.
>> >>
>> >> But, the allocator fallback lists have a fatal flaw: most nodes
>> >> appear in all the lists.  This would potentially lead to migration
>> >> cycles (A->B, B->A, A->B, ...).
>> >>
>> >> Instead of using the allocator fallback lists directly, keep a
>> >> separate node migration ordering.  But, reuse the same data used
>> >> to generate page allocator fallback in the first place:
>> >> find_next_best_node().
>> >>
>> >> This means that the firmware data used to populate node distances
>> >> essentially dictates the ordering for now.  It should also be
>> >> architecture-neutral since all NUMA architectures have a working
>> >> find_next_best_node().
>> >>
>> >> The protocol for node_demotion[] access and writing is not
>> >> standard.  It has no specific locking and is intended to be read
>> >> locklessly.  Readers must take care to avoid observing changes
>> >> that appear incoherent.  This was done so that node_demotion[]
>> >> locking has no chance of becoming a bottleneck on large systems
>> >> with lots of CPUs in direct reclaim.
>> >>
>> >> This code is unused for now.  It will be called later in the
>> >> series.
>> >>
>> >> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> >> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> >> Cc: Michal Hocko <mhocko@suse.com>
>> >> Cc: Wei Xu <weixugc@google.com>
>> >> Cc: David Rientjes <rientjes@google.com>
>> >> Cc: Dan Williams <dan.j.williams@intel.com>
>> >> Cc: David Hildenbrand <david@redhat.com>
>> >> Cc: osalvador <osalvador@suse.de>
>> >>
>> >> --
>> >>
>> >> Changes from 20200122:
>> >>  * Add big node_demotion[] comment
>> >> Changes from 20210302:
>> >>  * Fix typo in node_demotion[] comment
>> >> ---
>> >>  mm/internal.h   |   5 ++
>> >>  mm/migrate.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++-
>> >>  mm/page_alloc.c |   2 +-
>> >>  3 files changed, 180 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/mm/internal.h b/mm/internal.h
>> >> index 2f1182948aa6..0344cd78e170 100644
>> >> --- a/mm/internal.h
>> >> +++ b/mm/internal.h
>> >> @@ -522,12 +522,17 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
>> >>
>> >>  #ifdef CONFIG_NUMA
>> >>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
>> >> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>> >>  #else
>> >>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>> >>                              unsigned int order)
>> >>  {
>> >>      return NODE_RECLAIM_NOSCAN;
>> >>  }
>> >> +static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
>> >> +{
>> >> +    return NUMA_NO_NODE;
>> >> +}
>> >>  #endif
>> >>
>> >>  extern int hwpoison_filter(struct page *p);
>> >> diff --git a/mm/migrate.c b/mm/migrate.c
>> >> index 6cab668132f9..111f8565f75d 100644
>> >> --- a/mm/migrate.c
>> >> +++ b/mm/migrate.c
>> >> @@ -1136,6 +1136,44 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>> >>      return rc;
>> >>  }
>> >>
>> >> +
>> >> +/*
>> >> + * node_demotion[] example:
>> >> + *
>> >> + * Consider a system with two sockets.  Each socket has
>> >> + * three classes of memory attached: fast, medium and slow.
>> >> + * Each memory class is placed in its own NUMA node.  The
>> >> + * CPUs are placed in the node with the "fast" memory.  The
>> >> + * 6 NUMA nodes (0-5) might be split among the sockets like
>> >> + * this:
>> >> + *
>> >> + *  Socket A: 0, 1, 2
>> >> + *  Socket B: 3, 4, 5
>> >> + *
>> >> + * When Node 0 fills up, its memory should be migrated to
>> >> + * Node 1.  When Node 1 fills up, it should be migrated to
>> >> + * Node 2.  The migration path start on the nodes with the
>> >> + * processors (since allocations default to this node) and
>> >> + * fast memory, progress through medium and end with the
>> >> + * slow memory:
>> >> + *
>> >> + *  0 -> 1 -> 2 -> stop
>> >> + *  3 -> 4 -> 5 -> stop
>> >> + *
>> >> + * This is represented in the node_demotion[] like this:
>> >> + *
>> >> + *  {  1, // Node 0 migrates to 1
>> >> + *     2, // Node 1 migrates to 2
>> >> + *    -1, // Node 2 does not migrate
>> >> + *     4, // Node 3 migrates to 4
>> >> + *     5, // Node 4 migrates to 5
>> >> + *    -1} // Node 5 does not migrate
>> >> + */
>> >> +
>> >> +/*
>> >> + * Writes to this array occur without locking.  READ_ONCE()
>> >> + * is recommended for readers to ensure consistent reads.
>> >> + */
>> >>  static int node_demotion[MAX_NUMNODES] __read_mostly =
>> >>      {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>> >>
>> >> @@ -1150,7 +1188,13 @@ static int node_demotion[MAX_NUMNODES] __read_mostly =
>> >>   */
>> >>  int next_demotion_node(int node)
>> >>  {
>> >> -    return node_demotion[node];
>> >> +    /*
>> >> +     * node_demotion[] is updated without excluding
>> >> +     * this function from running.  READ_ONCE() avoids
>> >> +     * reading multiple, inconsistent 'node' values
>> >> +     * during an update.
>> >> +     */
>> >> +    return READ_ONCE(node_demotion[node]);
>> >>  }
>> >
>> > Is it necessary to have two separate patches to add node_demotion and
>> > next_demotion_node() then modify it immediately? Maybe merge Patch 1 into 2?
>> >
>> > Hmm, I just checked Patch 3 and it changes node_demotion again and uses RCU.
>> > I guess it might be much simpler to just introduce node_demotion with RCU
>> > in this patch and Patch 3 only takes care of hotplug events.
>>
>> Hi, Dave,
>>
>> What do you think about this?
>
> Squashing patch #1 and #2 had been mentioned in the previous review
> and it seems Dave agreed.
> https://lore.kernel.org/linux-mm/4573cb9a-31ca-3b3d-96bc-5d94876b9709@intel.com/

Thanks a lot for your information!

Best Regards,
Huang, Ying

[snip]
