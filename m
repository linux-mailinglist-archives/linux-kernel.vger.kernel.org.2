Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25D944E0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhKLDFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:05:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:22166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233752AbhKLDFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:05:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="232907556"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="232907556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:02:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="504707445"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:02:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: migrate: Support multiple target nodes demotion
References: <a31dc065a7901bcdca0d9642d0def0f57e865e20.1636683991.git.baolin.wang@linux.alibaba.com>
        <87y25uks84.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <8af6715f-c65b-b73b-f863-2c72ebc8544e@linux.alibaba.com>
Date:   Fri, 12 Nov 2021 11:02:44 +0800
In-Reply-To: <8af6715f-c65b-b73b-f863-2c72ebc8544e@linux.alibaba.com> (Baolin
        Wang's message of "Fri, 12 Nov 2021 10:58:42 +0800")
Message-ID: <87tugikre3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2021/11/12 10:44, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> We have some machines with multiple memory types like below, which
>>> have one fast (DRAM) memory node and two slow (persistent memory) memory
>>> nodes. According to current node demotion policy, if node 0 fills up,
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
>
> snip
>
>>>   	/*
>>>   	 * 'next_pass' contains nodes which became migration
>>> @@ -3192,6 +3281,14 @@ static int __init migrate_on_reclaim_init(void)
>>>   {
>>>   	int ret;
>>>   +	/*
>>> +	 * Ignore allocation failure, if this kmalloc fails
>>> +	 * at boot time, we are likely in bigger trouble.
>>> +	 */
>>> +	node_demotion = kmalloc_array(nr_node_ids,
>>> +				      sizeof(struct demotion_nodes),
>>> +				      GFP_KERNEL);
>>> +
>> I think we should WARN_ON() here.
>
> In this unlikey case, I think the mm core will print more information,
> IMHO WARN_ON() will help little. Anyway no strong opinion on
> this. Other than that, can I get your reviewed-by tag with this nit
> fixed? Thanks.

Yes.  Please add my "reviewed-by" after changing this.

Best Regards,
Huang, Ying
