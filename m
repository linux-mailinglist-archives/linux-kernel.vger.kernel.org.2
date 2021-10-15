Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9515642E5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJOBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:17:05 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38388 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhJOBQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:16:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Us-zOa._1634260491;
Received: from 30.21.164.24(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Us-zOa._1634260491)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 09:14:51 +0800
Subject: Re: [PATCH v2] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <3ba7d5a3ce5002f6718ab2c16e10441eaaf7740a.1634182476.git.baolin.wang@linux.alibaba.com>
 <424eaeb5-f2b5-89f2-f3d9-fe386ec344e3@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <b27bd04c-7f25-e9e0-b577-e453ea3d9de0@linux.alibaba.com>
Date:   Fri, 15 Oct 2021 09:15:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <424eaeb5-f2b5-89f2-f3d9-fe386ec344e3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/15 5:48, Mike Kravetz wrote:
> On 10/13/21 11:08 PM, Baolin Wang wrote:
>> Now the size of CMA area for gigantic hugepages runtime allocation is
>> balanced for all online nodes, but we also want to specify the size of
>> CMA per-node, or only one node in some cases, which are similar with
>> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
>> parameter to support node allocation")[1].
> 
> I would not include the commit hash here.  IIUC, this can change as it
> is moved to Linus' tree in the next merge window.

Sure.

> 
>> For example, on some multi-nodes systems, each node's memory can be
>> different, allocating the same size of CMA for each node is not suitable
>> for the low-memory nodes. Meanwhile some workloads like DPDK mentioned by
>> Zhenguo in patch [1] only need hugepages in one node.
>>
>> On the other hand, we have some machines with multiple types of memory,
>> like DRAM and PMEM (persistent memory). On this system, we may want to
>> specify all the hugepages only on DRAM node, or specify the proportion
>> of DRAM node and PMEM node, to tuning the performance of the workloads.
>>
>> Thus this patch adds node format for 'hugetlb_cma' parameter to support
>> specifying the size of CMA per-node. An example is as follows:
>>
>> hugetlb_cma=0:5G,2:5G
>>
>> which means allocating 5G size of CMA area on node 0 and node 2
>> respectively. And the users should use the node specific sysfs file to
>> allocate the gigantic hugepages if specified the CMA size on that node.
>>
>> [1]
>> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Changes from v1:
>>   - Update the commit log.
>>   - Avoid changing the behavior for 'balanced' gigantic huge page pool
>>   allocations.
>>   - Catch the invalid node specified in hugetlb_cma_reserve().
>>   - Validate the size of CMA for each node in hugetlb_cma_reserve().
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  6 +-
>>   mm/hugetlb.c                                    | 98 ++++++++++++++++++++++---
>>   2 files changed, 93 insertions(+), 11 deletions(-)
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
>> index 6d2f4c2..ac9afc2 100644
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
>> @@ -3508,7 +3510,16 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>   		/*
>>   		 * Node specific request.  count adjustment happens in
>>   		 * set_max_huge_pages() after acquiring hugetlb_lock.
>> +		 *
>> +		 * If we've specified the size of CMA area per node for
>> +		 * gigantic hugepages, should catch the warning if the
>> +		 * nid is not in the 'hugetlb_cma_nodes_allowed' nodemask.
>>   		 */
>> +		if (hstate_is_gigantic(h) &&
>> +		    !nodes_empty(hugetlb_cma_nodes_allowed) &&
>> +		    !node_isset(nid, hugetlb_cma_nodes_allowed))
>> +			pr_warn("hugetlb_cma: no reservation on this node %d\n", nid);
>> +
> 
> I would prefer to drop this code and hugetlb_cma_nodes_allowed.  Why?
> 
> CMA is an alternative allocation mechanism for gigantic pages.  The
> allocator will fall back to the normal allocator (alloc_contig_pages) if
> allocation from CMA fails.

Yes.

> This warning implies that the user 'forgot' to reserve CMA on the
> specified node, or is perhaps allocating gigantic pages on the wrong
> node.  We can not be sure this is the case.
> 
> I agree that in most cases when a user requests node specific CMA
> reservations, they will likely want to perform gigantic page allocations
> on the same nodes.  However, that may not always be the case and in such
> cases the warning could be confusing.
> 
> We do not print warnings today when allocating huge pages via the
> proc/sysfs interfaces.  We should not add one unless there is a very
> good reason.

OK. Will remove this in next version.

> 
>>   		init_nodemask_of_node(&nodes_allowed, nid);
>>   		n_mask = &nodes_allowed;
>>   	}
>> @@ -6745,7 +6756,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
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
>> @@ -6754,6 +6796,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>>   void __init hugetlb_cma_reserve(int order)
>>   {
>>   	unsigned long size, reserved, per_node;
>> +	bool node_specific_cma_alloc = false;
>>   	int nid;
>>   
>>   	cma_reserve_called = true;
>> @@ -6761,26 +6804,61 @@ void __init hugetlb_cma_reserve(int order)
>>   	if (!hugetlb_cma_size)
>>   		return;
>>   
>> +	for (nid = 0; nid < MAX_NUMNODES; nid++) {
>> +		if (hugetlb_cma_size_in_node[nid] == 0)
>> +			continue;
>> +
>> +		if (!node_state(nid, N_ONLINE)) {
>> +			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
>> +			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
>> +			hugetlb_cma_size_in_node[nid] = 0;
>> +			continue;
>> +		}
>> +
>> +		if (hugetlb_cma_size_in_node[nid] < (PAGE_SIZE << order)) {
>> +			pr_warn("hugetlb_cma: cma area of node %d should be at least %lu MiB\n",
>> +				nid, (PAGE_SIZE << order) / SZ_1M);
>> +			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
>> +			hugetlb_cma_size_in_node[nid] = 0;
>> +		} else {
>> +			node_specific_cma_alloc = true;
>> +		}
>> +	}
>> +
>> +	/* Validate the CMA size again in case some invalid nodes specified. */
>> +	if (!hugetlb_cma_size)
>> +		return;
>> +
>>   	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
>>   		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
>>   			(PAGE_SIZE << order) / SZ_1M);
>>   		return;
>>   	}
> 
> The series "hugetlb: add demote/split page functionality"
> https://lore.kernel.org/linux-mm/20211007181918.136982-1-mike.kravetz@oracle.com/T/#mcb25f5edaa235b93dd0d0b8fb81ba15f0317feeb
> is in Andrew's tree and has modified the above to set hugetlb_cma_size
> to 0 before returning.
> 
> Code in that series uses the varialbe hugetlb_cma_size to determine if
> CMA was reserved and can possibly be used for huge pages.  If no CMA is
> reserved in this routine, it must be set to 0.
> 
> The code below should be fine as it checks 'reserved' at the end of
> routine and sets hugetlb_cma_size to zero if !reserved before returning.
> 
> Mostly wanted to point out the context conflict with Andrew's tree.  He
> or you will need to fix this for the patch to apply.

Thanks, I will rebase the code in next version.
