Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E847391E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhEZRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:38:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:50177 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhEZRi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:38:29 -0400
IronPort-SDR: /DM/pHuLOKMKXnoGhzqceDgz4T9pFIGXH71WmUuWqCyzbMJtSP5gSLibtjlRyEM1CQpP8zAOmF
 Ed3syG7jSEbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189644745"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189644745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 10:36:57 -0700
IronPort-SDR: KpTc1WpgeJraDqWuwVA+QrtcVXwoILqTJFMP0CYgXAh/TFh70ASmuaEb2YN7tmX15W4OQiuI3E
 6HvxpNPxnXoA==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="472085913"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.251.4.127]) ([10.251.4.127])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 10:36:56 -0700
Subject: Re: About add an A64FX cache control function into resctrl
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
Date:   Wed, 26 May 2021 10:36:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 5/25/2021 1:45 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
> Sorry, I have not explained A64FX's sector cache function well yet.
> I think I need explain this function from different perspective.

You have explained the A64FX's sector cache function well. I have also  
read both specs to understand it better. It appears to me that you are  
not considering the resctrl architecture as part of your solution but  
instead just forcing your architecture onto the resctrl filesystem. For  
example, in resctrl the resource groups are not just a directory  
structure but has significance in what is being represented within the  
directory (a class of service). The files within a resource group's  
directory build on that. From your side I have not seen any effort in  
aligning the sector cache function with the resctrl architecture but  
instead you are just changing resctrl interface to match the A64FX  
architecture.

Could you please take a moment to understand what resctrl is and how it  
could be mapped to A64FX in a coherent way?

> 
>> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:

> --------
> A64FX NUMA-PE-Cache Architecture:
> NUMA0:
>    PE0:
>      L1sector0,L1sector1,L1sector2,L1sector3
>    PE1:
>      L1sector0,L1sector1,L1sector2,L1sector3
>    ...
>    PE11:
>      L1sector0,L1sector1,L1sector2,L1sector3
>    
>    L2sector0,1/L2sector2,3
> NUMA1:
>    PE0:
>      L1sector0,L1sector1,L1sector2,L1sector3
>    ...
>    PE11:
>      L1sector0,L1sector1,L1sector2,L1sector3
>    
>    L2sector0,1/L2sector2,3
> NUMA2:
>    ...
> NUMA3:
>    ...
> --------
> In A64FX processor, one L1 sector cache capacity setting register is
> only for one PE and not shared among PEs. L2 sector cache maximum
> capacity setting registers are shared among PEs in same NUMA, and it is
> to be noted that changing these registers in one PE influences other PE.

Understood. cache affinity is familiar to resctrl. When a CPU becomes  
online it is discovered which caches/resources it has affinity to.  
Resources then have CPU mask associated with them to indicate on which  
CPU a register could be changed to configure the resource/cache. See  
domain_add_cpu() and struct rdt_domain.

> The number of ways for L2 Sector ID (0,1 or 2,3) can be set through
> any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at
> the same time in same NUMA.
> 
> 
> I think, in your idea, a resource group will be created for each sector ID.
> (> "sectors" could be considered the same as the resctrl "classes of service")
> Then, an example of resource group is created as follows.
> ・ L1: NUMAX-PEY-L1sector0 (X = 0,1,2,3.Y = 0,1,2 ... 11),
> ・ L2: NUMAX-L2sector0 (X = 0,1,2,3)
> 
> In this example, sector with same ID(0) of all PEs is allocated to
> resource group. The L1D caches are numbered from NUMA0_PE0-L1sector0(0)
> to NUMA4_PE11-L1sector0(47) and the L2 caches numbered from
> NUMA0-L2sector0(0) to NUM4-L2sector0(3).
> (NUMA number X is from 0-4, PE number Y is from 0-11)
> (1) The number of ways of NUMAX-PEY-L1sector0 can be set independently
>      for each PEs (0-47). When run a task on this resource group,
>      we cannot control on which PE the task is running on and how many
>      cache ways the task is using.

resctrl does not control the affinity on which PE/CPU a task is run.  
resctrl is an interface with which to configure how resources are  
allocated on the system. resctrl could thus provide interface with which  
each sector of each cache instance is assigned a number of cache ways.  
resctrl also provides an interface to assign a task with a class of  
service (sector id?). Through this the task obtains access to all  
resources that is allocated to the particular class of service (sector  
id?). Depending on which CPU the task is running it may indeed  
experience different performance if the sector id it is running with  
does not have the same allocations on all cache instances. The affinity  
of the task needs to be managed separately using for example taskset.  
Please see Documentation/x86/resctrl.rst "Examples for RDT allocation usage"

> (2) Since L2 can only use 2 sectors at a time, when creating more than
>      2 resource groups, L2setctor0 will have to be allocated to a
>      different resource group. If the L2sector0 is shared by different
>      resource groups, the L2 sector settings on resource group will be
>      influenced by each other.
> etc... there are various problems, and no merit to using resctrl.
> 
> 
> In my idea, in order to allocate the L1 and L2 cache to a resource
> group, allocate NUMA to the resource group.
> An example of resource group is as follows.
> ・ NUMA0-PEY-L1sectorZ (Y = 0,1,2...11. Z = 0,1,2,3)
> ・ NUMA0-L2sectorZZ (ZZ = 0,1,2,3)
> 
>    #cat /sys/fs/resctrl/p0/cpus
>    0-11 *1
>    #cat /sys/fs/resctrl/p0/schemata
>    L1:0=0xF,0x3,0x1,x0x0 *2
>    L2:0=0xFFF,0xF,0,0 *3
> 
> *1: PEs belong one NUMA. (Of course, multiple NUMAs can also be
>      specified in one resource group)
> *2: The number of ways for L1sector0,1,2,3. On this resource group
>      the number of ways of all sector0 is the same(0xF). If 0 way is
>      specified for one sector, this sector cannot be used. If 4(0xF)
>      ways are specified for one sector, this sector can use cache fully.
>      If 4 ways are specified for each sector, there will be no
>      restriction for using cache.
> *3: The number of ways for L2 sector 0,1. If L2sector0,1 is used,
>      the number of ways of L2sector2,3 must be set to 0.
> 
> All sectors with the same ID on the same resource group were set to
> the same number of ways, and when running a task on A64FX, the sector
> ID used by task is determined by [56:57] bits of virtual address.
> By specifying the PID to /sys/fs/resctrl/tasks, the task will be bound
> to the resource group, and then, the cache size used by task will not
> be changed never.

This completely ignores how this directory and files are currently used.  
What is missing how this implementation maps to the current resctrl  
architecture.

Reinette


