Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7CE308EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhA2UtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhA2Ur3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:47:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A1C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:46:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id n6so12065797edt.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0u/SrW/ayXXMayejHeDskpnMWtid3p2YEcmD4tncPvE=;
        b=EAF9RO7KqcSoomD4vFgYqUcAZnypKz7YNj6H28ryadwzS2HNdmpNsiYzy5aGwmC6ks
         0qMFoq+29QcJoCyic7z4sL9pU8WEnKm5kPRMSIU6xBW0CsaNTZ8uwNGlzLrjG4lGS2mb
         rkDKOUJPWbw8mYTO4WUSUxZRgclU1DputL0x4umkO3OcfUsGT07NZb6Y79JRrG9zLzii
         zp9Hro9c8fnzsMlbbEGGMlctQbWaHye3qCK8y3cMKr3JXbl/Ib5R+5xNbNn7lCTWAN8K
         MhqvFu+4nxp/BGRmRbfCVh8TdHnXSZUgcinIAcJpVUvG/AszEy/KoU1MxKcopAjeE9F+
         CO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0u/SrW/ayXXMayejHeDskpnMWtid3p2YEcmD4tncPvE=;
        b=s0/akVGNJYxcthIVOXiVzYZG2QgfNqNBpSkVoccgiJAMrrmZwtymIdx0FwOmElegYO
         nQyiOdAg1KqEZBJJvueuaN+pU4gMWGCPa2WSLW2Q5mwA1heIR7/7uirQQqZh7bo+lVzG
         RAy7F6/ygSLLV6iEG0IZjVdXloNZlksQBVAa2FE7wNgVUGZ1bSa21PHm4MqFup9Lm6bD
         ++QSHmc0HPcUMvXDNsCK3hfvR4PZoSkBiuJHjWEtA2w/5JWsjbico79xjgSx6Y852LPs
         rIQbBrcjXtH7a3QqngTHGns+z79dsIK22YuSg079i1q4PaT+nq5CZGYkIUkakKFKYNwa
         5TvQ==
X-Gm-Message-State: AOAM530t88VW+IbcWUl/Nn11uxF7yp802BIaF0bN8SIsBgfF32S7gqBy
        86fY/hna3gnCJ24sVrIHQbdKGq+D/EO97ryGR9E1PlpZ08E=
X-Google-Smtp-Source: ABdhPJy+9IgT4LWH6dgrcWboPQSMX0J+kwBdGsfBIzjz6HAtvFG2yH/K63MaJtOA2IZpGdd7mf0FDhluQkDKrYyj1uM=
X-Received: by 2002:a05:6402:1bde:: with SMTP id ch30mr7292820edb.151.1611953207600;
 Fri, 29 Jan 2021 12:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003421.45897BF4@viggo.jf.intel.com>
In-Reply-To: <20210126003421.45897BF4@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 12:46:35 -0800
Message-ID: <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/13] mm/numa: automatically generate node migration order
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:41 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> When memory fills up on a node, memory contents can be
> automatically migrated to another node.  The biggest problems are
> knowing when to migrate and to where the migration should be
> targeted.
>
> The most straightforward way to generate the "to where" list
> would be to follow the page allocator fallback lists.  Those
> lists already tell us if memory is full where to look next.  It
> would also be logical to move memory in that order.
>
> But, the allocator fallback lists have a fatal flaw: most nodes
> appear in all the lists.  This would potentially lead to
> migration cycles (A->B, B->A, A->B, ...).
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
> locking has no chance of becoming a bottleneck on large systems
> with lots of CPUs in direct reclaim.
>
> This code is unused for now.  It will be called later in the
> series.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/mm/internal.h   |    5 +
>  b/mm/migrate.c    |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  b/mm/page_alloc.c |    2
>  3 files changed, 142 insertions(+), 2 deletions(-)
>
> diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
> --- a/mm/internal.h~auto-setup-default-migration-path-from-firmware     2021-01-25 16:23:10.607866706 -0800
> +++ b/mm/internal.h     2021-01-25 16:23:10.616866706 -0800
> @@ -515,12 +515,17 @@ static inline void mminit_validate_memmo
>
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>  #else
>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>                                 unsigned int order)
>  {
>         return NODE_RECLAIM_NOSCAN;
>  }
> +static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
> +{
> +       return NUMA_NO_NODE;
> +}
>  #endif
>
>  extern int hwpoison_filter(struct page *p);
> diff -puN mm/migrate.c~auto-setup-default-migration-path-from-firmware mm/migrate.c
> --- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware      2021-01-25 16:23:10.609866706 -0800
> +++ b/mm/migrate.c      2021-01-25 16:23:10.617866706 -0800
> @@ -1161,6 +1161,10 @@ out:
>         return rc;
>  }
>
> +/*
> + * Writes to this array occur without locking.  READ_ONCE()
> + * is recommended for readers to ensure consistent reads.
> + */
>  static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>
>  /**
> @@ -1174,7 +1178,13 @@ static int node_demotion[MAX_NUMNODES] =
>   */
>  int next_demotion_node(int node)
>  {
> -       return node_demotion[node];
> +       /*
> +        * node_demotion[] is updated without excluding
> +        * this function from running.  READ_ONCE() avoids
> +        * reading multiple, inconsistent 'node' values
> +        * during an update.
> +        */

Don't we need a smp_rmb() here? The single write barrier might be not
enough in migration target set. Typically a write barrier should be
used in pairs with a read barrier.

> +       return READ_ONCE(node_demotion[node]);

Why not consolidate the patch #4 in this patch? The patch #4 just add
the definition of node_demotion and the function, then the function is
changed in this patch, and the function is not used by anyone between
the adding and changing.

>  }
>
>  /*
> @@ -3124,3 +3134,128 @@ void migrate_vma_finalize(struct migrate
>  }
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
> +
> +/* Disable reclaim-based migration. */
> +static void disable_all_migrate_targets(void)
> +{
> +       int node;
> +
> +       for_each_online_node(node)
> +               node_demotion[node] = NUMA_NO_NODE;
> +}
> +
> +/*
> + * Find an automatic demotion target for 'node'.
> + * Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static int establish_migrate_target(int node, nodemask_t *used)
> +{
> +       int migration_target;
> +
> +       /*
> +        * Can not set a migration target on a
> +        * node with it already set.
> +        *
> +        * No need for READ_ONCE() here since this
> +        * in the write path for node_demotion[].
> +        * This should be the only thread writing.
> +        */
> +       if (node_demotion[node] != NUMA_NO_NODE)
> +               return NUMA_NO_NODE;
> +
> +       migration_target = find_next_best_node(node, used);
> +       if (migration_target == NUMA_NO_NODE)
> +               return NUMA_NO_NODE;
> +
> +       node_demotion[node] = migration_target;
> +
> +       return migration_target;
> +}
> +
> +/*
> + * When memory fills up on a node, memory contents can be
> + * automatically migrated to another node instead of
> + * discarded at reclaim.
> + *
> + * Establish a "migration path" which will start at nodes
> + * with CPUs and will follow the priorities used to build the
> + * page allocator zonelists.
> + *
> + * The difference here is that cycles must be avoided.  If
> + * node0 migrates to node1, then neither node1, nor anything
> + * node1 migrates to can migrate to node0.
> + *
> + * This function can run simultaneously with readers of
> + * node_demotion[].  However, it can not run simultaneously
> + * with itself.  Exclusion is provided by memory hotplug events
> + * being single-threaded.

Maybe an example diagram for the physical topology and how the
migration target is generated in the comment seems helpful to
understand the code.

> + */
> +void __set_migration_target_nodes(void)
> +{
> +       nodemask_t next_pass    = NODE_MASK_NONE;
> +       nodemask_t this_pass    = NODE_MASK_NONE;
> +       nodemask_t used_targets = NODE_MASK_NONE;
> +       int node;
> +
> +       /*
> +        * Avoid any oddities like cycles that could occur
> +        * from changes in the topology.  This will leave
> +        * a momentary gap when migration is disabled.
> +        */
> +       disable_all_migrate_targets();
> +
> +       /*
> +        * Ensure that the "disable" is visible across the system.
> +        * Readers will see either a combination of before+disable
> +        * state or disable+after.  They will never see before and
> +        * after state together.
> +        *
> +        * The before+after state together might have cycles and
> +        * could cause readers to do things like loop until this
> +        * function finishes.  This ensures they can only see a
> +        * single "bad" read and would, for instance, only loop
> +        * once.
> +        */
> +       smp_wmb();
> +
> +       /*
> +        * Allocations go close to CPUs, first.  Assume that
> +        * the migration path starts at the nodes with CPUs.
> +        */
> +       next_pass = node_states[N_CPU];
> +again:
> +       this_pass = next_pass;
> +       next_pass = NODE_MASK_NONE;
> +       /*
> +        * To avoid cycles in the migration "graph", ensure
> +        * that migration sources are not future targets by
> +        * setting them in 'used_targets'.  Do this only
> +        * once per pass so that multiple source nodes can
> +        * share a target node.
> +        *
> +        * 'used_targets' will become unavailable in future
> +        * passes.  This limits some opportunities for
> +        * multiple source nodes to share a desintation.

s/desination/destination

> +        */
> +       nodes_or(used_targets, used_targets, this_pass);
> +       for_each_node_mask(node, this_pass) {
> +               int target_node = establish_migrate_target(node, &used_targets);
> +
> +               if (target_node == NUMA_NO_NODE)
> +                       continue;
> +
> +               /* Visit targets from this pass in the next pass: */
> +               node_set(target_node, next_pass);
> +       }
> +       /* Is another pass necessary? */
> +       if (!nodes_empty(next_pass))
> +               goto again;
> +}
> +
> +void set_migration_target_nodes(void)

It seems this function is not called outside migrate.c, so it should be static.

> +{
> +       get_online_mems();
> +       __set_migration_target_nodes();
> +       put_online_mems();
> +}
> diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
> --- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware   2021-01-25 16:23:10.612866706 -0800
> +++ b/mm/page_alloc.c   2021-01-25 16:23:10.619866706 -0800
> @@ -5704,7 +5704,7 @@ static int node_load[MAX_NUMNODES];
>   *
>   * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
>   */
> -static int find_next_best_node(int node, nodemask_t *used_node_mask)
> +int find_next_best_node(int node, nodemask_t *used_node_mask)
>  {
>         int n, val;
>         int min_val = INT_MAX;
> _
>
