Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38B42D055
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJNCZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:25:08 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39257 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhJNCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:25:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UrkNAwe_1634178180;
Received: from 30.21.164.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UrkNAwe_1634178180)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 10:23:01 +0800
Subject: Re: [PATCH] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
 <6bd3789f-4dee-a184-d415-4ad77f0f98b7@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <326ece39-a6f5-26ce-827b-68272525e947@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 10:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6bd3789f-4dee-a184-d415-4ad77f0f98b7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/14 6:06, Mike Kravetz wrote:
> On 10/9/21 10:24 PM, Baolin Wang wrote:
>> Now the size of CMA area for gigantic hugepages runtime allocation is
>> balanced for all online nodes, but we also want to specify the size of
>> CMA per-node, or only one node in some cases, which are similar with
>> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
>> parameter to support node allocation")[1].
>>
>> Thus this patch adds node format for 'hugetlb_cma' parameter to support
>> specifying the size of CMA per-node. An example is as follows:
>>
>> hugetlb_cma=0:5G,2:5G
>>
>> which means allocating 5G size of CMA area on node 0 and node 2
>> respectively.
>>
>> [1]
>> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  6 +-
>>   mm/hugetlb.c                                    | 79 +++++++++++++++++++++----
>>   2 files changed, 73 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 3ad8e9d0..a147faa5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1587,8 +1587,10 @@
>>   			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>>   
>>   	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
>> -			of gigantic hugepages.
>> -			Format: nn[KMGTPE]
>> +			of gigantic hugepages. Or using node format, the size
>> +			of a CMA area per node can be specified.
>> +			Format: nn[KMGTPE] or (node format)
>> +				<node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
>>   
>>   			Reserve a CMA area of given size and allocate gigantic
>>   			hugepages using the CMA allocator. If enabled, the
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 6d2f4c2..8b4e409 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -50,6 +50,7 @@
>>   
>>   #ifdef CONFIG_CMA
>>   static struct cma *hugetlb_cma[MAX_NUMNODES];
>> +static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
>>   static bool hugetlb_cma_page(struct page *page, unsigned int order)
>>   {
>>   	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
>> @@ -62,6 +63,7 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
>>   }
>>   #endif
>>   static unsigned long hugetlb_cma_size __initdata;
>> +static nodemask_t hugetlb_cma_nodes_allowed = NODE_MASK_NONE;
>>   
>>   /*
>>    * Minimum page order among possible hugepage sizes, set to a proper value
>> @@ -3497,9 +3499,15 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>   
>>   	if (nid == NUMA_NO_NODE) {
>>   		/*
>> +		 * If we've specified the size of CMA area per node,
>> +		 * should use it firstly.
>> +		 */
>> +		if (hstate_is_gigantic(h) && !nodes_empty(hugetlb_cma_nodes_allowed))
>> +			n_mask = &hugetlb_cma_nodes_allowed;
>> +		/*
> 
> IIUC, this changes the behavior for 'balanced' gigantic huge page pool
> allocations if per-node hugetlb_cma is specified.  It will now only
> attempt to allocate gigantic pages on nodes where CMA was reserved.
> Even if we run out of space on the node, it will not go to other nodes
> as before.  Is that correct?

Right.

> 
> I do not believe we want this change in behavior.  IMO, if the user is
> doing node specific CMA reservations, then the user should use the node
> specific sysfs file for pool allocations on that node.

Sounds more reasonable, will move 'hugetlb_cma_nodes_allowed' to the 
node specific allocation.

>>   		 * global hstate attribute
>>   		 */
>> -		if (!(obey_mempolicy &&
>> +		else if (!(obey_mempolicy &&
>>   				init_nodemask_of_mempolicy(&nodes_allowed)))
>>   			n_mask = &node_states[N_MEMORY];
>>   		else
>> @@ -6745,7 +6753,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>>   
>>   static int __init cmdline_parse_hugetlb_cma(char *p)
>>   {
>> -	hugetlb_cma_size = memparse(p, &p);
>> +	int nid, count = 0;
>> +	unsigned long tmp;
>> +	char *s = p;
>> +
>> +	while (*s) {
>> +		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
>> +			break;
>> +
>> +		if (s[count] == ':') {
>> +			nid = tmp;
>> +			if (nid < 0 || nid >= MAX_NUMNODES)
>> +				break;
> 
> nid can only be compared to MAX_NUMNODES because this an early param
> before numa is setup and we do not know exactly how many nodes there
> are.  Is this correct?

Yes.

> 
> Suppose one specifies an invaid node.  For example, on my 2 node system
> I use the option 'hugetlb_cma=2:2G'.  This is not flagged as an error
> during processing and 1G CMA is reserved on node 0 and 1G is reserved
> on node 1.  Is that by design, or just chance?

Actually we won't allocate any CMA area in this case, since in 
hugetlb_cma_reserve(), we will only iterate the online nodes to try to 
allocate CMA area, and node 2 is not in the range of online nodes in 
this case.

> We should be able to catch this in hugetlb_cma_reserve.  For the example
> above, I think we should flag this as an error and not reserve any CMA.

Sure, as I said above, it will not allocate CMA for the non-online nodes 
though these invalid nodes can be specified in the command line. But I 
can add a warning to catch the invalid nodes setting in 
hugetlb_cma_reserve().

>> +
>> +			s += count + 1;
>> +			tmp = memparse(s, &s);
>> +			hugetlb_cma_size_in_node[nid] = tmp;
>> +			hugetlb_cma_size += tmp;
>> +
>> +			/*
>> +			 * Skip the separator if have one, otherwise
>> +			 * break the parsing.
>> +			 */
>> +			if (*s == ',')
>> +				s++;
>> +			else
>> +				break;
>> +		} else {
>> +			hugetlb_cma_size = memparse(p, &p);
>> +			break;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -6754,6 +6793,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>>   void __init hugetlb_cma_reserve(int order)
>>   {
>>   	unsigned long size, reserved, per_node;
>> +	bool node_specific_cma_alloc = false;
>>   	int nid;
>>   
>>   	cma_reserve_called = true;
>> @@ -6767,20 +6807,37 @@ void __init hugetlb_cma_reserve(int order)
>>   		return;
>>   	}
> 
> Earlier in hugetlb_cma_reserve (not in the context here), there is this
> code:
> 
> 	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
> 		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
> 			(PAGE_SIZE << order) / SZ_1M);
> 		hugetlb_cma_size = 0;
> 		return;
> 	}
> 
> That causes an early exit if hugetlb_cma_size is too small for a
> gigantic page.
> 
> On my 2 node x86 system with 1G gigantic pages, I can specify
> 'hugetlb_cma=0:512M,1:512M'.  This does not trigger the above early exit
> because total hugetlb_cma_size is 1G.  It does end up reserving 1G on
> node 0 and nothing on node 1.  I do not believe this is by design.  We
> should validate the specified per-node sizes as well.

Sure. Will do in next version. Thanks for your comments.
