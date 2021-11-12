Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73F644E0A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhKLDMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:12:20 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33345 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhKLDMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:12:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uw7AxVp_1636686566;
Received: from 30.21.164.32(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw7AxVp_1636686566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Nov 2021 11:09:26 +0800
Message-ID: <7f212c43-519a-ddcc-5cba-d23c487af321@linux.alibaba.com>
Date:   Fri, 12 Nov 2021 11:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] mm: migrate: Support multiple target nodes demotion
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <a31dc065a7901bcdca0d9642d0def0f57e865e20.1636683991.git.baolin.wang@linux.alibaba.com>
 <87y25uks84.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8af6715f-c65b-b73b-f863-2c72ebc8544e@linux.alibaba.com>
 <87tugikre3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87tugikre3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/12 11:02, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2021/11/12 10:44, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> We have some machines with multiple memory types like below, which
>>>> have one fast (DRAM) memory node and two slow (persistent memory) memory
>>>> nodes. According to current node demotion policy, if node 0 fills up,
>>>> its memory should be migrated to node 1, when node 1 fills up, its
>>>> memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.
>>>>
>>>> But this is not efficient and suitbale memory migration route
>>>> for our machine with multiple slow memory nodes. Since the distance
>>>> between node 0 to node 1 and node 0 to node 2 is equal, and memory
>>>> migration between slow memory nodes will increase persistent memory
>>>> bandwidth greatly, which will hurt the whole system's performance.
>>>>
>>>> Thus for this case, we can treat the slow memory node 1 and node 2
>>>> as a whole slow memory region, and we should migrate memory from
>>>> node 0 to node 1 and node 2 if node 0 fills up.
>>>>
>>>> This patch changes the node_demotion data structure to support multiple
>>>> target nodes, and establishes the migration path to support multiple
>>>> target nodes with validating if the node distance is the best or not.
>>>>
>>>> available: 3 nodes (0-2)
>>>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>>> node 0 size: 62153 MB
>>>> node 0 free: 55135 MB
>>>> node 1 cpus:
>>>> node 1 size: 127007 MB
>>>> node 1 free: 126930 MB
>>>> node 2 cpus:
>>>> node 2 size: 126968 MB
>>>> node 2 free: 126878 MB
>>>> node distances:
>>>> node   0   1   2
>>>>     0:  10  20  20
>>>>     1:  20  10  20
>>>>     2:  20  20  10
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> snip
>>
>>>>    	/*
>>>>    	 * 'next_pass' contains nodes which became migration
>>>> @@ -3192,6 +3281,14 @@ static int __init migrate_on_reclaim_init(void)
>>>>    {
>>>>    	int ret;
>>>>    +	/*
>>>> +	 * Ignore allocation failure, if this kmalloc fails
>>>> +	 * at boot time, we are likely in bigger trouble.
>>>> +	 */
>>>> +	node_demotion = kmalloc_array(nr_node_ids,
>>>> +				      sizeof(struct demotion_nodes),
>>>> +				      GFP_KERNEL);
>>>> +
>>> I think we should WARN_ON() here.
>>
>> In this unlikey case, I think the mm core will print more information,
>> IMHO WARN_ON() will help little. Anyway no strong opinion on
>> this. Other than that, can I get your reviewed-by tag with this nit
>> fixed? Thanks.
> 
> Yes.  Please add my "reviewed-by" after changing this.

OK. Thanks for your reviewing.
