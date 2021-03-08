Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74D331B35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhCIAAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCHX7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:59:54 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:59:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p7so12512757eju.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNvsfKjrGHPvBA7Usji3iBuG0BWPUzNjKszDD0Y16Dw=;
        b=L+fcis0fotbKgTcXw6qhudVFNwO2M+uI03ENlcTAr4A70wzeJhbfXA2wffMayiQXtv
         tLXQy8zsWozgEKftk9Of6Z9EYwLFZaq52pH65MB8C8Q0U2OzcPbwJwCyf3j94OFtprC7
         TvwU2lg0XyMIREAUUy7twstZW4kvDdsQ/TWnNe+s4gUzj+V5WvOhEI8P6qKLJWaS4F3j
         mC/6KU4syh50fRbizo3HPqeNAp2srKizV32dKKBqrh36VY8FF3kxx8rKhMCLWHhYJpyS
         aBjgfFyewmoEvtzzOgx+Cpzg9IybNS3xRHRQqFNt2L8wOu+dAT6l03OUD8Mzsx5j+JcU
         qOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNvsfKjrGHPvBA7Usji3iBuG0BWPUzNjKszDD0Y16Dw=;
        b=Pwe9ew+9uFOXQS01E9TEnRL5OXq5LWW2v2cBLhbdZIqkWEGF9U1SMO4e61l90i25l5
         cKKvcGpUBZbNuJNctSoLqLH/YVvbVjRc2OcI70BG1kM+0wzGd7wBg5+JLZBvwGYrkfd4
         g5aNnpEFlDCtkMEZBbL9wbOutJ2Pv+Y1bCgjVHMXAczoPNSRmgbBFh63KXWVjnaXZs7r
         Qp5tKzDT3v7ftlV2nQIrmkcUnPaQlPGZMTH3ZFeLj8R9EISKPvjxAcnbkGPLeacxHV12
         D7I/Z98gYeLWak8gKuaKbkzRP2D2CVhZWIJjXqZvqxt75Uyj85539VX+QNfdibhhQqUq
         2fwQ==
X-Gm-Message-State: AOAM532zFNjREJGdHV7kASrWXLohubHBAqNWPqux9H9RsorNg8Bhuc1r
        /ZFCWw4d+4NzpjAO8yizG6NQIYXrhk/b6mI+JsM=
X-Google-Smtp-Source: ABdhPJyBD3mApp1a/jp+NcyCV67/HL1GaHQDJiqUFtI71100B5rwVnStJZY1AsfbisYzvTKqrlEJrt90mCE7bw6ZolU=
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr17156549ejv.499.1615247993195;
 Mon, 08 Mar 2021 15:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210304235952.15D0CD27@viggo.jf.intel.com>
In-Reply-To: <20210304235952.15D0CD27@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 15:59:41 -0800
Message-ID: <CAHbLzkpaTxFeOuj+JU=sjJ628pQJNg7YEO865Lh0AwCK7Na9qg@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration order
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

On Thu, Mar 4, 2021 at 4:00 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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
>
> --
>
> changes from 20200122:
>  * Add big node_demotion[] comment

Thanks for adding the comment. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  b/mm/internal.h   |    5 +
>  b/mm/migrate.c    |  174 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  b/mm/page_alloc.c |    4 -
>  3 files changed, 180 insertions(+), 3 deletions(-)
>
> diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
> --- a/mm/internal.h~auto-setup-default-migration-path-from-firmware     2021-03-04 15:35:52.407806439 -0800
> +++ b/mm/internal.h     2021-03-04 15:35:52.426806439 -0800
> @@ -520,12 +520,17 @@ static inline void mminit_validate_memmo
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
> --- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware      2021-03-04 15:35:52.409806439 -0800
> +++ b/mm/migrate.c      2021-03-04 15:35:52.427806439 -0800
> @@ -1157,6 +1157,44 @@ out:
>         return rc;
>  }
>
> +
> +/*
> + * node_demotion[] example:
> + *
> + * Consider a system with two sockets.  Each socket has
> + * three classes of memory attached: fast, medium and slow.
> + * Each memory class is placed in its own NUMA node.  The
> + * CPUs are placed in the node with the "fast" memory.  The
> + * 6 NUMA nodes (0-5) might be split among the sockets like
> + * this:
> + *
> + *     Socket A: 0, 1, 2
> + *     Socket B: 3, 4, 5
> + *
> + * When Node 0 fills up, its memory should be migrated to
> + * Node 1.  When Node 1 fills up, it should be migrated to
> + * Node 2.  The migration path start on the nodes with the
> + * processors (since allocations default to this node) and
> + * fast memory, progress through medium and end with the
> + * slow memory:
> + *
> + *     0 -> 1 -> 2 -> stop
> + *     3 -> 4 -> 5 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *
> + *     {  1, // Node 0 migrates to 1
> + *        2, // Node 1 migrates to 2
> + *       -1, // Node 2 does not migrate
> + *        4, // Node 3 migrates to 1
> + *        5, // Node 4 migrates to 2
> + *       -1} // Node 5 does not migrate
> + */
> +
> +/*
> + * Writes to this array occur without locking.  READ_ONCE()
> + * is recommended for readers to ensure consistent reads.
> + */
>  static int node_demotion[MAX_NUMNODES] __read_mostly =
>         {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>
> @@ -1171,7 +1209,13 @@ static int node_demotion[MAX_NUMNODES] _
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
> +       return READ_ONCE(node_demotion[node]);
>  }
>
>  /*
> @@ -3175,3 +3219,131 @@ void migrate_vma_finalize(struct migrate
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
> + */
> +static void __set_migration_target_nodes(void)
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
> +        * multiple source nodes to share a destination.
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
> +/*
> + * For callers that do not hold get_online_mems() already.
> + */
> +static void set_migration_target_nodes(void)
> +{
> +       get_online_mems();
> +       __set_migration_target_nodes();
> +       put_online_mems();
> +}
> diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
> --- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware   2021-03-04 15:35:52.422806439 -0800
> +++ b/mm/page_alloc.c   2021-03-04 15:35:52.429806439 -0800
> @@ -3916,7 +3916,7 @@ retry:
>                         if (alloc_flags & ALLOC_NO_WATERMARKS)
>                                 goto try_this_zone;
>
> -                       if (!node_reclaim_enabled() ||
> +                       if (node_reclaim_mode == 0 ||
>                             !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
>                                 continue;
>
> @@ -5773,7 +5773,7 @@ static int node_load[MAX_NUMNODES];
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
