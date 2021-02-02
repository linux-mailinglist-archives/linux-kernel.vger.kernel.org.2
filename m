Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964A030BD52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBBLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:42:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhBBLmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:42:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63F46B1AE;
        Tue,  2 Feb 2021 11:42:11 +0000 (UTC)
Date:   Tue, 2 Feb 2021 12:42:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [RFC][PATCH 06/13] mm/migrate: update migration order during on
 hotplug events
Message-ID: <20210202114157.GA12139@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003423.8D2B5637@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126003423.8D2B5637@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:34:23PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
> 
> The implementation here is pretty simple and entirely unoptimized.  On
> any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
> 
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out if nodes are actually coming or going.
> But, given the expected paucity of hotplug events, this should be
> fine.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---

[...]

> +
> +/*
> + * React to hotplug events that might affect the migration targes
> + * like events that online or offline NUMA nodes.
> + *
> + * The ordering is also currently dependent on which nodes have
> + * CPUs.  That means we need CPU on/offline notification too.
> + */
> +static int migration_online_cpu(unsigned int cpu)
> +{
> +	set_migration_target_nodes();
> +	return 0;
> +}
> +
> +static int migration_offline_cpu(unsigned int cpu)
> +{
> +	set_migration_target_nodes();
> +	return 0;
> +}
> +
> +/*
> + * This leaves migrate-on-reclaim transiently disabled
> + * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
> + * This runs reclaim-based micgration is enabled or not.
> + * This ensures that the user can turn reclaim-based
> + * migration at any time without needing to recalcuate
> + * migration targets.
> + *
> + * These callbacks already hold get_online_mems().  That
> + * is why __set_migration_target_nodes() can be used as
> + * opposed to set_migration_target_nodes().
> + */
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *arg)
> +{
> +	switch (action) {
> +	case MEM_GOING_OFFLINE:
> +		/*
> +		 * Make sure there are not transient states where
> +		 * an offline node is a migration target.  This
> +		 * will leave migration disabled until the offline
> +		 * completes and the MEM_OFFLINE case below runs.
> +		 */
> +		disable_all_migrate_targets();
> +		break;
> +	case MEM_OFFLINE:
> +	case MEM_ONLINE:
> +		/*
> +		 * Recalculate the target nodes once the node
> +		 * reaches its final state (online or offline).
> +		 */
> +		__set_migration_target_nodes();
> +		break;
> +	case MEM_CANCEL_OFFLINE:
> +		/*
> +		 * MEM_GOING_OFFLINE disabled all the migration
> +		 * targets.  Reenable them.
> +		 */
> +		__set_migration_target_nodes();
> +		break;
> +	case MEM_GOING_ONLINE:
> +	case MEM_CANCEL_ONLINE:
> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
> +}

This looks good, and I kinda like it.
But in this case, all we care about is whether NUMA node does or does
not have memory, so we have to remove/added into the demotion list.
So, would make more sense to have a kinda helper in
node_states_{set,clear}_node that calls the respective functions
(disable_all_migrate_targets and __set_migration_target_nodes)?

-- 
Oscar Salvador
SUSE L3
