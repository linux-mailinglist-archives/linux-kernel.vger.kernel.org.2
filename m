Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3F44D551
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhKKKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:55:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36645 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhKKKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:54:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uw0jzXP_1636627927;
Received: from 30.21.164.4(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw0jzXP_1636627927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 18:52:07 +0800
Subject: Re: [PATCH v2 1/2] mm: migrate: Support multiple target nodes
 demotion
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
 <ae040cf8152f085e216c5ad862e03f7d62464c0d.1636616548.git.baolin.wang@linux.alibaba.com>
 <87zgqbm7cr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <36f10306-28c7-6d9b-0cd8-2228ca42248e@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 18:52:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87zgqbm7cr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/11 16:20, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> We have some machines with multiple memory types like below, which
>> have one fast (DRAM) memory node and two slow (persistent memory) memory
>> nodes. According to current node demotion policy, if node 0 fills up,
>> its memory should be migrated to node 1, when node 1 fills up, its
>> memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.
>>
>> But this is not efficient and suitbale memory migration route
>> for our machine with multiple slow memory nodes. Since the distance
>> between node 0 to node 1 and node 0 to node 2 is equal, and memory
>> migration between slow memory nodes will increase persistent memory
>> bandwidth greatly, which will hurt the whole system's performance.
>>
>> Thus for this case, we can treat the slow memory node 1 and node 2
>> as a whole slow memory region, and we should migrate memory from
>> node 0 to node 1 and node 2 if node 0 fills up.
>>
>> This patch changes the node_demotion data structure to support multiple
>> target nodes, and establishes the migration path to support multiple
>> target nodes with validating if the node distance is the best or not.
>>
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>> node 0 size: 62153 MB
>> node 0 free: 55135 MB
>> node 1 cpus:
>> node 1 size: 127007 MB
>> node 1 free: 126930 MB
>> node 2 cpus:
>> node 2 size: 126968 MB
>> node 2 free: 126878 MB
>> node distances:
>> node   0   1   2
>>    0:  10  20  20
>>    1:  20  10  20
>>    2:  20  20  10
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 138 +++++++++++++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 102 insertions(+), 36 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index cf25b00..126e9e6 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -50,6 +50,7 @@
>>   #include <linux/ptrace.h>
>>   #include <linux/oom.h>
>>   #include <linux/memory.h>
>> +#include <linux/random.h>
>>   
>>   #include <asm/tlbflush.h>
>>   
>> @@ -1119,12 +1120,25 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>    *
>>    * This is represented in the node_demotion[] like this:
>>    *
>> - *	{  1, // Node 0 migrates to 1
>> - *	   2, // Node 1 migrates to 2
>> - *	  -1, // Node 2 does not migrate
>> - *	   4, // Node 3 migrates to 4
>> - *	   5, // Node 4 migrates to 5
>> - *	  -1} // Node 5 does not migrate
>> + *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
>> + *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
>> + *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
>> + *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
>> + *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
>> + *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
>> + *
>> + * Moreover some systems may have multiple slow memory nodes.
>> + * Suppose a system has one socket with 3 memory nodes, node 0
>> + * is fast memory type, and node 1/2 both are slow memory
>> + * type, and the distance between fast memory node and slow
>> + * memory node is same. So the migration path should be:
>> + *
>> + *	0 -> 1/2 -> stop
>> + *
>> + * This is represented in the node_demotion[] like this:
>> + *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
>> + *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
>> + *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
>>    */
>>   
>>   /*
>> @@ -1135,8 +1149,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>    * must be held over all reads to ensure that no cycles are
>>    * observed.
>>    */
>> -static int node_demotion[MAX_NUMNODES] __read_mostly =
>> -	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>> +#define DEFAULT_DEMOTION_TARGET_NODES 15
>> +struct demotion_nodes {
>> +	unsigned short nr;
>> +	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
>> +};
>> +
>> +static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
>>   
>>   /**
>>    * next_demotion_node() - Get the next node in the demotion path
>> @@ -1149,6 +1168,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>    */
>>   int next_demotion_node(int node)
>>   {
>> +	struct demotion_nodes *nd = &node_demotion[node];
>> +	unsigned short target_nr, index;
>>   	int target;
>>   
>>   	/*
>> @@ -1161,9 +1182,25 @@ int next_demotion_node(int node)
>>   	 * node_demotion[] reads need to be consistent.
>>   	 */
>>   	rcu_read_lock();
>> -	target = READ_ONCE(node_demotion[node]);
>> -	rcu_read_unlock();
>> +	target_nr = READ_ONCE(nd->nr);
>> +
>> +	if (target_nr == 0) {
>> +		target = NUMA_NO_NODE;
>> +		goto out;
>> +	} else if (target_nr == 1) {
>> +		index = 0;
>> +	} else {
>> +		/*
>> +		 * If there are multiple target nodes, just select one
>> +		 * target node randomly.
>> +		 */
>> +		index = get_random_int() % target_nr;
>> +	}
> 
> How about use "switch" here?

Sure, will do. Thanks.
