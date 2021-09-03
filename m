Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079213FF933
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhICEBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:01:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhICEBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:01:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D69CCD6E;
        Thu,  2 Sep 2021 21:00:41 -0700 (PDT)
Received: from [10.163.72.65] (unknown [10.163.72.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3040B3F5A1;
        Thu,  2 Sep 2021 21:00:38 -0700 (PDT)
Subject: Re: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building
 node fallback list
To:     "Ramakrishnan, Krupa" <Krupa.Ramakrishnan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>,
        "lee.schermerhorn@hp.com" <lee.schermerhorn@hp.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-3-bharata@amd.com>
 <13dab5ac-03a3-e9b3-ff12-f819f7711569@arm.com>
 <SN6PR12MB2765859076BFE5B667A0C4719BCC9@SN6PR12MB2765.namprd12.prod.outlook.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a051f54f-7bec-ab7b-cfac-d427b2e0e4bb@arm.com>
Date:   Fri, 3 Sep 2021 09:31:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN6PR12MB2765859076BFE5B667A0C4719BCC9@SN6PR12MB2765.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/21 8:56 PM, Ramakrishnan, Krupa wrote:
> [AMD Official Use Only]
> 
> The bandwidth is limited by underutilization of cross socket links and not the  latency. Hotspotting on  one node will not engage all  hardware resources based on our routing protocol which results in the lower bandwidth. Distributing equally across nodes 0 and 1 will yield the best results as it stresses the full system capabilities.

Makes sense. Nonetheless this patch clearly solves a problem. 

> 
> Thanks
> Krupa Ramakrishnan
> 
> -----Original Message-----
> From: Anshuman Khandual <anshuman.khandual@arm.com> 
> Sent: 31 August, 2021 4:58
> To: Rao, Bharata Bhasker <bharata@amd.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Cc: akpm@linux-foundation.org; kamezawa.hiroyu@jp.fujitsu.com; lee.schermerhorn@hp.com; mgorman@suse.de; Ramakrishnan, Krupa <Krupa.Ramakrishnan@amd.com>; Srinivasan, Sadagopan <Sadagopan.Srinivasan@amd.com>
> Subject: Re: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building node fallback list
> 
> [CAUTION: External Email]
> 
> On 8/30/21 5:46 PM, Bharata B Rao wrote:
>> As an example, consider a 4 node system with the following distance 
>> matrix.
>>
>> Node 0  1  2  3
>> ----------------
>> 0    10 12 32 32
>> 1    12 10 32 32
>> 2    32 32 10 12
>> 3    32 32 12 10
>>
>> For this case, the node fallback list gets built like this:
>>
>> Node  Fallback list
>> ---------------------
>> 0     0 1 2 3
>> 1     1 0 3 2
>> 2     2 3 0 1
>> 3     3 2 0 1 <-- Unexpected fallback order
>>
>> In the fallback list for nodes 2 and 3, the nodes 0 and 1 appear in 
>> the same order which results in more allocations getting satisfied 
>> from node 0 compared to node 1.
>>
>> The effect of this on remote memory bandwidth as seen by stream 
>> benchmark is shown below:
>>
>> Case 1: Bandwidth from cores on nodes 2 & 3 to memory on nodes 0 & 1
>>       (numactl -m 0,1 ./stream_lowOverhead ... --cores <from 2, 3>) 
>> Case 2: Bandwidth from cores on nodes 0 & 1 to memory on nodes 2 & 3
>>       (numactl -m 2,3 ./stream_lowOverhead ... --cores <from 0, 1>)
>>
>> ----------------------------------------
>>               BANDWIDTH (MB/s)
>>     TEST      Case 1          Case 2
>> ----------------------------------------
>>     COPY      57479.6         110791.8
>>    SCALE      55372.9         105685.9
>>      ADD      50460.6         96734.2
>>   TRIADD      50397.6         97119.1
>> ----------------------------------------
>>
>> The bandwidth drop in Case 1 occurs because most of the allocations 
>> get satisfied by node 0 as it appears first in the fallback order for 
>> both nodes 2 and 3.
> 
> I am wondering what causes this performance drop here ? Would not the memory access latency be similar between {2, 3} --->  { 0 } and {2, 3} --->  { 1 }, given both these nodes {0, 1} have same distance from {2, 3} i.e 32 from the above distance matrix. Even if the preferred node order changes from { 0 } to { 1 } for the accessing node { 3 }, it should not change the latency as such.
> 
> Is the performance drop here, is caused by excessive allocation on node { 0 } resulting from page allocation latency instead.
> 
