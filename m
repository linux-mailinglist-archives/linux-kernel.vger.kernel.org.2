Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3196C367052
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhDUQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:40:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:13829 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhDUQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:40:18 -0400
IronPort-SDR: Nz+ZPd5VMQIUGSru8EQyV3zNTXDSbrRStXDTBTHysJADuScuTTbAneBTTQ0LApIAYAtR5iNn05
 /0ukUyhXNZUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216374649"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="216374649"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 09:39:44 -0700
IronPort-SDR: TfC0u11ENZM9syBBn5lukl/+yBaNv9oK9eJCNPTw09IUAZKgHZP3UDTVaGbxlizNhTaWfnJeYl
 AuNuyhjULfDw==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="534926112"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.198.141]) ([10.212.198.141])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 09:39:44 -0700
Subject: Re: About add an A64FX cache control function into resctrl
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
Date:   Wed, 21 Apr 2021 09:39:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 4/21/2021 1:37 AM, tan.shaopeng@fujitsu.com wrote:
> Hi,
> 
> Ping... any comments&advice about add an A64FX cache control function into resctrl?

My apologies for the delay.

> 
> Best regards
> Tan Shaopeng
> 
>> Hello
>>
>>
>> I'm Tan Shaopeng from Fujitsu Limited.
>>
>> I’m trying to implement Fujitsu A64FX’s cache related features.
>> It is a cache partitioning function we called sector cache function that using
>> the value of the tag that is upper 8 bits of the 64bit address and the value of the
>> sector cache register to control virtual cache capacity of the L1D&L2 cache.
>>
>> A few days ago, when I sent a driver that realizes this function to
>> ARM64 kernel community, Will Deacon and Arnd Bergmann suggested an idea
>> to add the sector cache function of A64FX into resctrl.
>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5Oc
>> Z=As2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/
>>
>> Based on my study, I think the sector cache function of A64FX can be added
>> into the allocation features of resctrl after James' resctrl rework has finished.
>> But, in order to implement this function, more interfaces for resctrl are need.
>> The details are as follow, and could you give me some advice?
>>
>> [Sector cache function]
>> The sector cache function split cache into multiple sectors and control them
>> separately. It is implemented on the L1D cache and
>> L2 cache in the A64FX processor and can be controlled individually for L1D
>> cache and L2 cache. A64FX has no L3 cache. Each L1D cache and L2 cache
>> has 4 sectors. Which L1D sector is used is specified by the value of [57:56] bits
>> of address, how many ways of sector are specified by the value of register
>> (IMP_SCCR_L1_EL0).
>> Which L2 sector is used is specified by the value of [56] bits of address, and
>> how many ways of sector are specified by value of register
>> (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
>> IMP_SCCR_SET1_L2_EL1).
>>
>> For more details of sector cache function, see A64FX HPC extension
>> specification (1.2. Sector cache) in https://github.com/fujitsu/A64FX

The overview in section 12 was informative but very high level.
I was not able to find any instance of "IMP_SCCR" in this document to  
explore how this cache allocation works.

Are these cache sectors exposed to the OS in any way? For example, when  
the OS discovers the cache, does it learn about these sectors and expose  
the details to user space (/sys/devices/system/cpuX/cache)?

The overview of Sector Cache in that document provides details of how  
the size of the sector itself is dynamically adjusted to usage. That  
description is quite cryptic but it seems like a sector, since the  
number of ways associated with it can dynamically change, is more  
equivalent to a class of service or resource group in the resctrl  
environment.

I really may be interpreting things wrong here, could you perhaps point  
me to where I can obtain more details?


>> [Difference between resctrl(CAT) and this sector cache function]
>> L2/L3 CAT (Cache Allocation Technology) enables the user to specify some
>> physical partition of cache space that an application can fill.
>> A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function enables
>> a user to specify number of ways each sector uses.
>> Therefore, for CAT it is enough to specify a cache portion for each cache_id
>> (socket). On the other hand, sector cache needs to specify cache portion of
>> each sector for each cache_id, and following extension to resctrl interface is
>> needed to support sector cache.
>>
>> [Idear for A64FX sector cache function control interface (schemata file
>> details)]
>> L1:<cache_id0>=<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=<cw
>> bm>,<cwbm>,<cwbm>,<cwbm>;…
>> L2:<cache_id0>=>=<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=
>> <cwbm>,<cwbm>,<cwbm>,<cwbm>;…
>>
>> ・L1: Add a new interface to control the L1D cache.
>> ・<cwbm>,<cwbm>,<cwbm>,<cwbm>：Specify the number of ways for each
>> sector.
>> ・cwbm：Specify the number of ways in each sector as a bitmap (percentage),
>>    but the bitmap does not indicate the location of the cache.
>> * In the sector cache function, L2 sector cache way setting register is
>>    shared among PEs (Processor Element) in shared domain. If two PEs
>>    which share L2 cache belongs to different resource groups, one resource
>>    group's L2 setting will affect to other resource group's L2 setting.

In resctrl a "resource group" can be viewed as a class of service.

>> * Since A64FX does not support MPAM, it is not necessary to consider
>>    how to switch between MPAM and sector cache function now.
>>
>> Some questions:
>> 1.I'm still studying about RDT, could you tell me whether RDT has
>>    the similar mechanism with sector cache function?

This is not clear to me yet. One thing to keep in mind is that a bit in  
the capacity bitmask could correspond to some number of ways in a cache,  
but it does not have to. It is essentially a hint to hardware on how  
much cache space needs to be allocated while also indicating overlap and  
isolation from other allocations.

resctrl already supports the bitmask being interpreted differently  
between architectures and with the MPAM support there will be even more  
support for different interpretations.

>> 2.In RDT, L3 cache is shared among cores in socket. If two cores which
>>    share L3 cache belongs to different resource groups, one resource
>>    group's L3 setting will affect to other resource group's L3 setting?

This question is not entirely clear to me. Are you referring to the  
hardware layout or configuration changes via the resctrl "cpus" file?

Each resource group is a class of service (CLOS) that is supported by  
all cache instances. By default each resource group would thus contain  
all cache instances on the system (even if some cache instances do not  
support the same number of CLOS resctrl would only support the CLOS  
supported by all resources).

Reinette
