Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4517D357FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhDHJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhDHJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:53:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2692BB02C;
        Thu,  8 Apr 2021 09:52:56 +0000 (UTC)
Date:   Thu, 8 Apr 2021 11:52:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
Message-ID: <YG7Sc3i54IV6KyPn@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183221.977831DE@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:32:21AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
> 
> The implementation is conceptually simple and entirely unoptimized.
> On any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
> 
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out the hotplug event would have some
> *actual* effect on the demotion order.  But, given the expected
> paucity of hotplug events, this should be fine.
> 
> === What does RCU provide? ===
> 
> Imaginge a simple loop which walks down the demotion path looking
> for the last node:
> 
>         terminal_node = start_node;
>         while (node_demotion[terminal_node] != NUMA_NO_NODE) {
>                 terminal_node = node_demotion[terminal_node];
>         }
> 
> The initial values are:
> 
>         node_demotion[0] = 1;
>         node_demotion[1] = NUMA_NO_NODE;
> 
> and are updated to:
> 
>         node_demotion[0] = NUMA_NO_NODE;
>         node_demotion[1] = 0;
> 
> What guarantees that the loop did not observe:
> 
>         node_demotion[0] = 1;
>         node_demotion[1] = 0;
> 
> and would loop forever?
> 
> With RCU, a rcu_read_lock/unlock() can be placed around the
> loop.  Since the write side does a synchronize_rcu(), the loop
> that observed the old contents is known to be complete after the
> synchronize_rcu() has completed.
> 
> RCU, combined with disable_all_migrate_targets(), ensures that
> the old migration state is not visible by the time
> __set_migration_target_nodes() is called.
> 
> === What does READ_ONCE() provide? ===
> 
> READ_ONCE() forbids the compiler from merging or reordering
> successive reads of node_demotion[].  This ensures that any
> updates are *eventually* observed.
> 
> Consider the above loop again.  The compiler could theoretically
> read the entirety of node_demotion[] into local storage
> (registers) and never go back to memory, and *permanently*
> observe bad values for node_demotion[].
> 
> Note: RCU does not provide any universal compiler-ordering
> guarantees:
> 
> 	https://lore.kernel.org/lkml/20150921204327.GH4029@linux.vnet.ibm.com/
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> 

...
  
> +#if defined(CONFIG_MEMORY_HOTPLUG)

I am not really into PMEM, and I ignore whether we need
CONFIG_MEMORY_HOTPLUG in order to have such memory on the system.
If so, the following can be partly ignored.

I think that you either want to check CONFIG_MEMORY_HOTPLUG +
CONFIG_CPU_HOTPLUG, or just do not put it under any conf dependency.

The thing is that migrate_on_reclaim_init() will only be called if
we have CONFIG_MEMORY_HOTPLUG, and when we do not have that (but we do have
CONFIG_CPU_HOTPLUG) the calls to set_migration_target_nodes() wont't be
made when the system brings up the CPUs during the boot phase,
which means node_demotion[] list won't be initialized.

But this brings me to the next point.

From a conceptual point of view, I think you want to build the
node_demotion[] list, being orthogonal to it whether we support CPU Or
MEMORY hotplug.

Now, in case we support CPU or MEMORY hotplug, we do want to be able to re-build
the list for .e.g: in case NUMA nodes become cpu-less or memory-less.

On x86_64, CPU_HOTPLUG is enabled by default if SMP, the same for
MEMORY_HOTPLUG, but I am not sure about other archs.
Can we have !CPU_HOTPLUG && MEMORY_HOTPLUG, !MEMORY_HOTPLUG &&
CPU_HOTPLUG? I do now really know, but I think you should be careful
about that.

If this was my call, I would:

- Do not place the burden to initialize node_demotion[] list in CPU
  hotplug boot phase (or if so, be carefull because if I disable
  MEMORY_HOTPLUG, I end up with no demotion_list[])
- Diferentiate between migration_{online,offline}_cpu and
  migrate_on_reclaim_callback() and place them under their respective
  configs-dependency.

But I might be missing some details so I might be off somewhere.

Another thing that caught my eye is that we are calling
set_migration_target_nodes() for every CPU the system brings up at boot
phase. I know systems with *lots* of CPUs.
I am not sure whether we have a mechanism to delay that until all CPUs
that are meant to be online are online? (after boot?)
That's probably happening in wonderland, but was just speaking out loud.

(Of course the same happen with memory_hotplug acpi operations.
All it takes is some qemu-handling)

-- 
Oscar Salvador
SUSE L3
