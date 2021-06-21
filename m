Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67323AF679
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 21:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhFUTyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFUTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:53:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 12:51:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m14so3898089edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNdxXS30C6NJqRkuRp42LOx+EAYzqSvnQsgPBsBKwLM=;
        b=LlOLnD0i+nX1b3mW3nFfcBwj2KxTsImJ2KrRJof9Uc80ee9JjCloqFbYvEDSWEoF0q
         6oMQg/lpR/4Xz47Y8lNEEZ1SqASMBAKJqh8qZgRaAWwbhR99sCAtnxEwndSwEq88SSoO
         zNHRyrpdPAXmgF2Y40dmEbl0qRPv3Nd3I7l6NLgOf8q4P+yWobW7CIakhMlrsSTXudMf
         kF8wwuFSUAzN9N66/hqN1/GotzPkrAFCuxgfL4F7wkCivricgi3BsIZVfK3Fema3cV1H
         gYMaUnF0DMbQsSTvUFX8lWZmoY7wKgmacXZoSwtzviYvpaf2Xe0Rh/e6DtzGP5FGaA3Z
         wKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNdxXS30C6NJqRkuRp42LOx+EAYzqSvnQsgPBsBKwLM=;
        b=c6vdgxqk54k6BjmM/FHAFJqFGqFTSNJaLQWZixffRn+ZfNH9uiMLs+2c3sh0G2epPn
         +/7HccjgyKuCS+mTgBZJzfNKJGUK/vvCeD1/Qha+sRvpW1ECb/H4C0/VNmw9QKvCDNKR
         IK3Wn4DsIvaGH/CUlu9dv2LAtUFPrCrY3FGKe/uq6nwgN3znX7c42o7ORlXOxfsi/iyO
         xz+yrIW1MujXvK9rP6dp+244FsBiI+FzgS7EUMi+dAB1MUISrbJIvB2uLj56VPvQSSJc
         i92cGFw7QcPyXLA4Te99fJcAOr7Rm8DEqFs0IENT1sXgPizsKwflUuN2qj0GGUi0YVJt
         7YYw==
X-Gm-Message-State: AOAM532Yh5C2Nr14fX+hI7Cmy+OgfK55eo1vf6zTJZFJcziqPTU6YlCC
        D3gVNDr+NB8XEAyWye2EnGuB2BTUy9xB+SUSHVg=
X-Google-Smtp-Source: ABdhPJxQHoiCI70OjCn8B6JWSvCz0gIgbquGWGr8IZtQ/TpYyWcp1CPsLy5WSaIm03w32ww03HtPbRx8HESH/uRSb3c=
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr87708edc.168.1624305102698;
 Mon, 21 Jun 2021 12:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210618061537.434999-1-ying.huang@intel.com> <20210618061537.434999-3-ying.huang@intel.com>
 <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com> <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 21 Jun 2021 12:51:30 -0700
Message-ID: <CAHbLzkoVfj9bhDv7RE5rB_8h0O6Wgdoqe5fYJ1rUOHA=AR5uJQ@mail.gmail.com>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node migration order
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 1:19 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Zi Yan <ziy@nvidia.com> writes:
>
> > On 18 Jun 2021, at 2:15, Huang Ying wrote:
> >
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >>
> >> When memory fills up on a node, memory contents can be
> >> automatically migrated to another node.  The biggest problems are
> >> knowing when to migrate and to where the migration should be
> >> targeted.
> >>
> >> The most straightforward way to generate the "to where" list would
> >> be to follow the page allocator fallback lists.  Those lists
> >> already tell us if memory is full where to look next.  It would
> >> also be logical to move memory in that order.
> >>
> >> But, the allocator fallback lists have a fatal flaw: most nodes
> >> appear in all the lists.  This would potentially lead to migration
> >> cycles (A->B, B->A, A->B, ...).
> >>
> >> Instead of using the allocator fallback lists directly, keep a
> >> separate node migration ordering.  But, reuse the same data used
> >> to generate page allocator fallback in the first place:
> >> find_next_best_node().
> >>
> >> This means that the firmware data used to populate node distances
> >> essentially dictates the ordering for now.  It should also be
> >> architecture-neutral since all NUMA architectures have a working
> >> find_next_best_node().
> >>
> >> The protocol for node_demotion[] access and writing is not
> >> standard.  It has no specific locking and is intended to be read
> >> locklessly.  Readers must take care to avoid observing changes
> >> that appear incoherent.  This was done so that node_demotion[]
> >> locking has no chance of becoming a bottleneck on large systems
> >> with lots of CPUs in direct reclaim.
> >>
> >> This code is unused for now.  It will be called later in the
> >> series.
> >>
> >> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Wei Xu <weixugc@google.com>
> >> Cc: David Rientjes <rientjes@google.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: osalvador <osalvador@suse.de>
> >>
> >> --
> >>
> >> Changes from 20200122:
> >>  * Add big node_demotion[] comment
> >> Changes from 20210302:
> >>  * Fix typo in node_demotion[] comment
> >> ---
> >>  mm/internal.h   |   5 ++
> >>  mm/migrate.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++-
> >>  mm/page_alloc.c |   2 +-
> >>  3 files changed, 180 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 2f1182948aa6..0344cd78e170 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -522,12 +522,17 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
> >>
> >>  #ifdef CONFIG_NUMA
> >>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
> >> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
> >>  #else
> >>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
> >>                              unsigned int order)
> >>  {
> >>      return NODE_RECLAIM_NOSCAN;
> >>  }
> >> +static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
> >> +{
> >> +    return NUMA_NO_NODE;
> >> +}
> >>  #endif
> >>
> >>  extern int hwpoison_filter(struct page *p);
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 6cab668132f9..111f8565f75d 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1136,6 +1136,44 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>      return rc;
> >>  }
> >>
> >> +
> >> +/*
> >> + * node_demotion[] example:
> >> + *
> >> + * Consider a system with two sockets.  Each socket has
> >> + * three classes of memory attached: fast, medium and slow.
> >> + * Each memory class is placed in its own NUMA node.  The
> >> + * CPUs are placed in the node with the "fast" memory.  The
> >> + * 6 NUMA nodes (0-5) might be split among the sockets like
> >> + * this:
> >> + *
> >> + *  Socket A: 0, 1, 2
> >> + *  Socket B: 3, 4, 5
> >> + *
> >> + * When Node 0 fills up, its memory should be migrated to
> >> + * Node 1.  When Node 1 fills up, it should be migrated to
> >> + * Node 2.  The migration path start on the nodes with the
> >> + * processors (since allocations default to this node) and
> >> + * fast memory, progress through medium and end with the
> >> + * slow memory:
> >> + *
> >> + *  0 -> 1 -> 2 -> stop
> >> + *  3 -> 4 -> 5 -> stop
> >> + *
> >> + * This is represented in the node_demotion[] like this:
> >> + *
> >> + *  {  1, // Node 0 migrates to 1
> >> + *     2, // Node 1 migrates to 2
> >> + *    -1, // Node 2 does not migrate
> >> + *     4, // Node 3 migrates to 4
> >> + *     5, // Node 4 migrates to 5
> >> + *    -1} // Node 5 does not migrate
> >> + */
> >> +
> >> +/*
> >> + * Writes to this array occur without locking.  READ_ONCE()
> >> + * is recommended for readers to ensure consistent reads.
> >> + */
> >>  static int node_demotion[MAX_NUMNODES] __read_mostly =
> >>      {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
> >>
> >> @@ -1150,7 +1188,13 @@ static int node_demotion[MAX_NUMNODES] __read_mostly =
> >>   */
> >>  int next_demotion_node(int node)
> >>  {
> >> -    return node_demotion[node];
> >> +    /*
> >> +     * node_demotion[] is updated without excluding
> >> +     * this function from running.  READ_ONCE() avoids
> >> +     * reading multiple, inconsistent 'node' values
> >> +     * during an update.
> >> +     */
> >> +    return READ_ONCE(node_demotion[node]);
> >>  }
> >
> > Is it necessary to have two separate patches to add node_demotion and
> > next_demotion_node() then modify it immediately? Maybe merge Patch 1 into 2?
> >
> > Hmm, I just checked Patch 3 and it changes node_demotion again and uses RCU.
> > I guess it might be much simpler to just introduce node_demotion with RCU
> > in this patch and Patch 3 only takes care of hotplug events.
>
> Hi, Dave,
>
> What do you think about this?

Squashing patch #1 and #2 had been mentioned in the previous review
and it seems Dave agreed.
https://lore.kernel.org/linux-mm/4573cb9a-31ca-3b3d-96bc-5d94876b9709@intel.com/

>
> >>
> >>  /*
> >> @@ -3144,3 +3188,132 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
> >>  }
> >>  EXPORT_SYMBOL(migrate_vma_finalize);
> >>  #endif /* CONFIG_DEVICE_PRIVATE */
> >> +
> >> +/* Disable reclaim-based migration. */
> >> +static void disable_all_migrate_targets(void)
> >> +{
> >> +    int node;
> >> +
> >> +    for_each_online_node(node)
> >> +            node_demotion[node] = NUMA_NO_NODE;
> >> +}
> >> +
> >> +/*
> >> + * Find an automatic demotion target for 'node'.
> >> + * Failing here is OK.  It might just indicate
> >> + * being at the end of a chain.
> >> + */
> >> +static int establish_migrate_target(int node, nodemask_t *used)
> >> +{
> >> +    int migration_target;
> >> +
> >> +    /*
> >> +     * Can not set a migration target on a
> >> +     * node with it already set.
> >> +     *
> >> +     * No need for READ_ONCE() here since this
> >> +     * in the write path for node_demotion[].
> >> +     * This should be the only thread writing.
> >> +     */
> >> +    if (node_demotion[node] != NUMA_NO_NODE)
> >> +            return NUMA_NO_NODE;
> >> +
> >> +    migration_target = find_next_best_node(node, used);
> >> +    if (migration_target == NUMA_NO_NODE)
> >> +            return NUMA_NO_NODE;
> >> +
> >> +    node_demotion[node] = migration_target;
> >> +
> >> +    return migration_target;
> >> +}
> >> +
> >> +/*
> >> + * When memory fills up on a node, memory contents can be
> >> + * automatically migrated to another node instead of
> >> + * discarded at reclaim.
> >> + *
> >> + * Establish a "migration path" which will start at nodes
> >> + * with CPUs and will follow the priorities used to build the
> >> + * page allocator zonelists.
> >> + *
> >> + * The difference here is that cycles must be avoided.  If
> >> + * node0 migrates to node1, then neither node1, nor anything
> >> + * node1 migrates to can migrate to node0.
> >> + *
> >> + * This function can run simultaneously with readers of
> >> + * node_demotion[].  However, it can not run simultaneously
> >> + * with itself.  Exclusion is provided by memory hotplug events
> >> + * being single-threaded.
> >> + */
> >> +static void __set_migration_target_nodes(void)
> >> +{
> >> +    nodemask_t next_pass    = NODE_MASK_NONE;
> >> +    nodemask_t this_pass    = NODE_MASK_NONE;
> >> +    nodemask_t used_targets = NODE_MASK_NONE;
> >> +    int node;
> >> +
> >> +    /*
> >> +     * Avoid any oddities like cycles that could occur
> >> +     * from changes in the topology.  This will leave
> >> +     * a momentary gap when migration is disabled.
> >> +     */
> >> +    disable_all_migrate_targets();
> >> +
> >> +    /*
> >> +     * Ensure that the "disable" is visible across the system.
> >> +     * Readers will see either a combination of before+disable
> >> +     * state or disable+after.  They will never see before and
> >> +     * after state together.
> >> +     *
> >> +     * The before+after state together might have cycles and
> >> +     * could cause readers to do things like loop until this
> >> +     * function finishes.  This ensures they can only see a
> >> +     * single "bad" read and would, for instance, only loop
> >> +     * once.
> >> +     */
> >> +    smp_wmb();
> >> +
> >> +    /*
> >> +     * Allocations go close to CPUs, first.  Assume that
> >> +     * the migration path starts at the nodes with CPUs.
> >> +     */
> >> +    next_pass = node_states[N_CPU];
> >
> > Is there a plan of allowing user to change where the migration
> > path starts? Or maybe one step further providing an interface
> > to allow user to specify the demotion path. Something like
> > /sys/devices/system/node/node*/node_demotion.
>
> I don't think that's necessary at least for now.  Do you know any real
> world use case for this?
>
> Best Regards,
> Huang, Ying
>
> [snip]
