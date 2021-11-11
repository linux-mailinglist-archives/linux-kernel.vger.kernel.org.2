Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88644D315
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhKKIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:23:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:58449 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhKKIXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:23:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="231596668"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="231596668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:20:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602529955"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:20:22 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: migrate: Support multiple target nodes demotion
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
        <ae040cf8152f085e216c5ad862e03f7d62464c0d.1636616548.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 16:20:20 +0800
In-Reply-To: <ae040cf8152f085e216c5ad862e03f7d62464c0d.1636616548.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Thu, 11 Nov 2021 15:48:34 +0800")
Message-ID: <87zgqbm7cr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> We have some machines with multiple memory types like below, which
> have one fast (DRAM) memory node and two slow (persistent memory) memory
> nodes. According to current node demotion policy, if node 0 fills up,
> its memory should be migrated to node 1, when node 1 fills up, its
> memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.
>
> But this is not efficient and suitbale memory migration route
> for our machine with multiple slow memory nodes. Since the distance
> between node 0 to node 1 and node 0 to node 2 is equal, and memory
> migration between slow memory nodes will increase persistent memory
> bandwidth greatly, which will hurt the whole system's performance.
>
> Thus for this case, we can treat the slow memory node 1 and node 2
> as a whole slow memory region, and we should migrate memory from
> node 0 to node 1 and node 2 if node 0 fills up.
>
> This patch changes the node_demotion data structure to support multiple
> target nodes, and establishes the migration path to support multiple
> target nodes with validating if the node distance is the best or not.
>
> available: 3 nodes (0-2)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> node 0 size: 62153 MB
> node 0 free: 55135 MB
> node 1 cpus:
> node 1 size: 127007 MB
> node 1 free: 126930 MB
> node 2 cpus:
> node 2 size: 126968 MB
> node 2 free: 126878 MB
> node distances:
> node   0   1   2
>   0:  10  20  20
>   1:  20  10  20
>   2:  20  20  10
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 138 +++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 102 insertions(+), 36 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cf25b00..126e9e6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -50,6 +50,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
>  #include <linux/memory.h>
> +#include <linux/random.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1119,12 +1120,25 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   *
>   * This is represented in the node_demotion[] like this:
>   *
> - *	{  1, // Node 0 migrates to 1
> - *	   2, // Node 1 migrates to 2
> - *	  -1, // Node 2 does not migrate
> - *	   4, // Node 3 migrates to 4
> - *	   5, // Node 4 migrates to 5
> - *	  -1} // Node 5 does not migrate
> + *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> + *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> + *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> + *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> + *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> + *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> + *
> + * Moreover some systems may have multiple slow memory nodes.
> + * Suppose a system has one socket with 3 memory nodes, node 0
> + * is fast memory type, and node 1/2 both are slow memory
> + * type, and the distance between fast memory node and slow
> + * memory node is same. So the migration path should be:
> + *
> + *	0 -> 1/2 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> + *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> + *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
>   */
>  
>  /*
> @@ -1135,8 +1149,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   * must be held over all reads to ensure that no cycles are
>   * observed.
>   */
> -static int node_demotion[MAX_NUMNODES] __read_mostly =
> -	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
> +#define DEFAULT_DEMOTION_TARGET_NODES 15
> +struct demotion_nodes {
> +	unsigned short nr;
> +	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
> +};
> +
> +static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
>  
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
> @@ -1149,6 +1168,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   */
>  int next_demotion_node(int node)
>  {
> +	struct demotion_nodes *nd = &node_demotion[node];
> +	unsigned short target_nr, index;
>  	int target;
>  
>  	/*
> @@ -1161,9 +1182,25 @@ int next_demotion_node(int node)
>  	 * node_demotion[] reads need to be consistent.
>  	 */
>  	rcu_read_lock();
> -	target = READ_ONCE(node_demotion[node]);
> -	rcu_read_unlock();
> +	target_nr = READ_ONCE(nd->nr);
> +
> +	if (target_nr == 0) {
> +		target = NUMA_NO_NODE;
> +		goto out;
> +	} else if (target_nr == 1) {
> +		index = 0;
> +	} else {
> +		/*
> +		 * If there are multiple target nodes, just select one
> +		 * target node randomly.
> +		 */
> +		index = get_random_int() % target_nr;
> +	}

How about use "switch" here?

Best Regards,
Huang, Ying

> +
> +	target = READ_ONCE(nd->nodes[index]);
>  
> +out:
> +	rcu_read_unlock();
>  	return target;
>  }
>  

[snip]
