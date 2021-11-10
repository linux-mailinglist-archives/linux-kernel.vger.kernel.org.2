Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50B44B9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhKJAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:50:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:28883 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhKJAuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:50:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232416777"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="232416777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 16:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="503736131"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 16:47:21 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm: migrate: Support multiple target nodes demotion
References: <f6d68800ff2efcb0720599ae092d30765a640232.1636428988.git.baolin.wang@linux.alibaba.com>
        <875yt1vk7i.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1bf154f0-951f-ce20-26f2-9ca7dda4bb77@linux.alibaba.com>
Date:   Wed, 10 Nov 2021 08:47:19 +0800
In-Reply-To: <1bf154f0-951f-ce20-26f2-9ca7dda4bb77@linux.alibaba.com> (Baolin
        Wang's message of "Tue, 9 Nov 2021 17:54:58 +0800")
Message-ID: <871r3ovnu0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2021/11/9 15:53, Huang, Ying writes:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> We have some machines with multiple memory types like below, which
>>> have one fast (DRAM) memory node and two slow (persistent memory) memory
>>> nodes. According to current node demotion, if node 0 fills up,
>>> its memory should be migrated to node 1, when node 1 fills up, its
>>> memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.
>>>
>>> But this is not efficient and suitbale memory migration route
>>> for our machine with multiple slow memory nodes. Since the distance
>>> between node 0 to node 1 and node 0 to node 2 is equal, and memory
>>> migration between slow memory nodes will increase persistent memory
>>> bandwidth greatly, which will hurt the whole system's performance.
>>>
>>> Thus for this case, we can treat the slow memory node 1 and node 2
>>> as a whole slow memory region, and we should migrate memory from
>>> node 0 to node 1 and node 2 if node 0 fills up.
>>>
>>> This patch changes the node_demotion data structure to support multiple
>>> target nodes, and establishes the migration path to support multiple
>>> target nodes with validating if the node distance is the best or not.
>>>
>>> available: 3 nodes (0-2)
>>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>> node 0 size: 62153 MB
>>> node 0 free: 55135 MB
>>> node 1 cpus:
>>> node 1 size: 127007 MB
>>> node 1 free: 126930 MB
>>> node 2 cpus:
>>> node 2 size: 126968 MB
>>> node 2 free: 126878 MB
>>> node distances:
>>> node   0   1   2
>>>    0:  10  20  20
>>>    1:  20  10  20
>>>    2:  20  20  10
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> Changes from RFC v1:
>>>   - Re-define the node_demotion structure.
>>>   - Set up multiple target nodes by validating the node distance.
>>>   - Add more comments.
>>> ---
>>>   mm/migrate.c | 132 +++++++++++++++++++++++++++++++++++++++++++----------------
>>>   1 file changed, 96 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index cf25b00..95f170d 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1119,12 +1119,25 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>>    *
>>>    * This is represented in the node_demotion[] like this:
>>>    *
>>> - *	{  1, // Node 0 migrates to 1
>>> - *	   2, // Node 1 migrates to 2
>>> - *	  -1, // Node 2 does not migrate
>>> - *	   4, // Node 3 migrates to 4
>>> - *	   5, // Node 4 migrates to 5
>>> - *	  -1} // Node 5 does not migrate
>>> + *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
>>> + *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
>>> + *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
>>> + *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
>>> + *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
>>> + *	{  nr=0, nodes[0]=-1} // Node 5 does not migrate
>>> + *
>>> + * Moreover some systems may have multiple same class memory
>>> + * types. Suppose a system has one socket with 3 memory nodes,
>>> + * node 0 is fast memory type, and node 1/2 both are slow memory
>>> + * type, and the distance between fast memory node and slow
>>> + * memory node is same. So the migration path should be:
>>> + *
>>> + *	0 -> 1/2 -> stop
>>> + *
>>> + * This is represented in the node_demotion[] like this:
>>> + *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
>>> + *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
>>> + *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
>>>    */
>>>     /*
>>> @@ -1135,8 +1148,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>>    * must be held over all reads to ensure that no cycles are
>>>    * observed.
>>>    */
>>> -static int node_demotion[MAX_NUMNODES] __read_mostly =
>>> -	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>>> +#define DEMOTION_TARGET_NODES 15
>>> +struct demotion_nodes {
>>> +	unsigned short nr;
>>> +	int nodes[DEMOTION_TARGET_NODES];
>> Why we cannot use "unsigned short" for nodes[]?
>
> I think the default value of target node should be NUMA_NO_NODE(-1),
> so a signed type is more suitable. I can change to 'short' type.

Yes.  'short' is better.

>> 
>>> +};
>>> +
>>> +static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
>>>     /**
>>>    * next_demotion_node() - Get the next node in the demotion path
>>> @@ -1149,7 +1167,9 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>>    */
>>>   int next_demotion_node(int node)
>>>   {
>>> -	int target;
>>> +	struct demotion_nodes *current_node_demotion = &node_demotion[node];
>>> +	int target, i;
>>> +	nodemask_t target_nodes = NODE_MASK_NONE;
>>>     	/*
>>>   	 * node_demotion[] is updated without excluding this
>>> @@ -1161,9 +1181,21 @@ int next_demotion_node(int node)
>>>   	 * node_demotion[] reads need to be consistent.
>>>   	 */
>>>   	rcu_read_lock();
>>> -	target = READ_ONCE(node_demotion[node]);
>>> +	for (i = 0; i < DEMOTION_TARGET_NODES; i++) {
>>> +		target = READ_ONCE(current_node_demotion->nodes[i]);
>>> +		if (target == NUMA_NO_NODE)
>>> +			break;
>>> +
>>> +		node_set(target, target_nodes);
>> Why do we need a nodemask?  Why not just find a target node from
>> current_node_demotion->nodes[] randomly and directly?
>
> I think nodemask is scalable in future if we want to add more
> requirements to select the target node if necessary. Anyway now I have 
> no strong preference with the nodemask, and can change to select the
> target node randomly and directly, which are something like below.
>
> +       target_nr = READ_ONCE(current_node_demotion->nr);
> +
> +       if (target_nr == 0) {
> +               target = NUMA_NO_NODE;
> +               goto out;
> +       } else if (target_nr == 1) {
> +               index = 0;
> +       } else {
> +               /*
> +                * If there are multiple target nodes, just select one
> +                * target node randomly.
> +                */
> +               index = get_random_int() % target_nr;
> +       }
> +
> +       target = READ_ONCE(current_node_demotion->nodes[index]);

This looks generally OK.  You may consider about memory order.

Best Regards,
Huang, Ying
