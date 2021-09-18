Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2026241026F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhIRA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:56:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:34520 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhIRA4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:56:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="221019978"
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="221019978"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 17:55:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="546728159"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 17:55:06 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>,
        <mhocko@suse.com>, <weixugc@google.com>, <osalvador@suse.de>,
        <rientjes@google.com>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <gthelen@google.com>,
        <yang.shi@linux.alibaba.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
        <20210917223505.F817CB6B@davehans-spike.ostc.intel.com>
Date:   Sat, 18 Sep 2021 08:55:04 +0800
In-Reply-To: <20210917223505.F817CB6B@davehans-spike.ostc.intel.com> (Dave
        Hansen's message of "Fri, 17 Sep 2021 15:35:05 -0700")
Message-ID: <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> From: Dave Hansen <dave.hansen@linux.intel.com>
> == tl;dr ==
>
> Automatic demotion opted for a simple, lazy approach to handling
> hotplug events.  This noticeably slows down memory hotplug[1].
> Optimize away updates to the demotion order when CPU and memory
> hotplug events should have no effect.
>
> == Background ==
>
> Automatic demotion is a memory migration strategy to ensure that
> new allocations have room in faster memory tiers on tiered memory
> systems.  The kernel maintains an array (node_demotion[]) to
> drive these migrations.
>
> The node_demotion[] path is calculated by starting at nodes with
> CPUs and then "walking" to nodes with memory.  Only hotplug
> events which online or offline a node with memory (N_ONLINE) or
> CPUs (N_CPU) will actually affect the migration order.
>
> == Problem ==
>
> However, the current code is lazy.  It completely regenerates the
> migration order on *any* CPU or memory hotplug event.  The logic
> was that these events are extremely rare and that the overhead
> from indiscriminate order regeneration is minimal.
>
> Part of the update logic involves a synchronize_rcu(), which is a
> pretty big hammer.  Its overhead was large enough to be detected
> by some 0day tests that watch memory hotplug performance[1].
>
> == Solution ==
>
> Add a new helper (node_demotion_topo_changed()) which can
> differentiate between superfluous and impactful hotplug events.
> Skip the expensive update operation for superfluous events.
>
> == Aside: Locking ==
>
> It took me a few moments to declare the locking to be safe enough
> for node_demotion_topo_changed() to work.  It all hinges on the
> memory hotplug lock:
>
> During memory hotplug events, 'mem_hotplug_lock' is held for
> write.  This ensures that two memory hotplug events can not be
> called simultaneously.
>
> CPU hotplug has a similar lock (cpuhp_state_mutex) which also
> provides mutual exclusion between CPU hotplug events.  In
> addition, the demotion code acquire and hold the mem_hotplug_lock
> for read during its CPU hotplug handlers.  This provides mutual
> exclusion between the demotion memory hotplug callbacks and the
> CPU hotplug callbacks.
>
> This effectively allows treating the migration target generation
> code to act as if it is single-threaded.
>
> 1. https://lore.kernel.org/all/20210905135932.GE15026@xsang-OptiPlex-9020/
>
> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  b/mm/migrate.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff -puN mm/migrate.c~faster-node-order mm/migrate.c
> --- a/mm/migrate.c~faster-node-order	2021-09-14 11:05:04.998951737 -0700
> +++ b/mm/migrate.c	2021-09-14 11:05:05.002951737 -0700
> @@ -3122,6 +3122,36 @@ static int establish_migrate_target(int
>  }
>  
>  /*
> + * The node_demotion[] path is calculated by starting at
> + * nodes with CPUs and then "walking" to nodes with memory.
> + * Only hotplug events which online or offline a node with
> + * memory (N_ONLINE) or CPUs (N_CPU) will actually affect
> + * the migration order.
> + *
> + * Differentiate between hotplug events which are impactful
> + * or superfluous to node_demotion[].
> + *
> + * Must only be called once per hotplug event.  Callers
> + * must not make concurrent calls.
> + */
> +static bool node_demotion_topo_changed(void)
> +{
> +	static int prev_topo_cpus = -1;
> +	static int prev_topo_mems = -1;
> +	int now_topo_cpus = num_node_state(N_CPU);
> +	int now_topo_mems = num_node_state(N_ONLINE);
> +
> +	if ((now_topo_cpus == prev_topo_cpus) &&
> +	    (now_topo_mems == prev_topo_mems))
> +	   return false;
> +
> +	prev_topo_cpus = now_topo_cpus;
> +	prev_topo_mems = now_topo_mems;
> +
> +	return true;
> +}
> +
> +/*
>   * When memory fills up on a node, memory contents can be
>   * automatically migrated to another node instead of
>   * discarded at reclaim.
> @@ -3147,6 +3177,16 @@ static void __set_migration_target_nodes
>  	int node;
>  
>  	/*
> +	 * The "migration path" array is heavily optimized
> +	 * for reads.  This is the write side which incurs a
> +	 * very heavy synchronize_rcu().  Avoid this overhead
> +	 * when nothing of consequence has changed since the
> +	 * last write.
> +	 */
> +	if (!node_demotion_topo_changed())
> +		return;
> +
> +	/*
>  	 * Avoid any oddities like cycles that could occur
>  	 * from changes in the topology.  This will leave
>  	 * a momentary gap when migration is disabled.

Now synchronize_rcu() is called in disable_all_migrate_targets(), which
is called for MEM_GOING_OFFLINE.  Can we remove the synchronize_rcu()
from disable_all_migrate_targets() and call it in
__set_migration_target_nodes() before we update the node_demotion[]?

Best Regards,
Huang, Ying
