Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0470A36EF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhD2RnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:43:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:27281 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhD2RnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:43:07 -0400
IronPort-SDR: LLzlh/oKVCsKawRsmSg7sqWJFeEVYzZ1+NXOb3ehRwLCC3AflOPCACdlytOxX1J0QNgMv5D9GB
 rUliNRixupcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="282413260"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="282413260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:42:20 -0700
IronPort-SDR: rGxoQqgtr2qWXW9UFdqyYRzXQ2jmRIasW04rGsgYLHn//VGI3ZdLMiNqfXJ+e5+WLSKV579vgR
 NmQW0DYc/jMw==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537448690"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.251.29.105]) ([10.251.29.105])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:42:20 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
Date:   Thu, 29 Apr 2021 10:42:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 4/28/2021 1:16 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 4/21/2021 1:37 AM, tan.shaopeng@fujitsu.com wrote:
>>> Hi,
>>>
>>> Ping... any comments&advice about add an A64FX cache control function
>> into resctrl?
>>
>> My apologies for the delay.
>>
>>>
>>> Best regards
>>> Tan Shaopeng
>>>
>>>> Hello
>>>>
>>>>
>>>> I'm Tan Shaopeng from Fujitsu Limited.
>>>>
>>>> I’m trying to implement Fujitsu A64FX’s cache related features.
>>>> It is a cache partitioning function we called sector cache function
>>>> that using the value of the tag that is upper 8 bits of the 64bit
>>>> address and the value of the sector cache register to control virtual cache
>> capacity of the L1D&L2 cache.
>>>>
>>>> A few days ago, when I sent a driver that realizes this function to
>>>> ARM64 kernel community, Will Deacon and Arnd Bergmann suggested an
>>>> idea to add the sector cache function of A64FX into resctrl.
>>>>
>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5Oc
>>>> Z=As2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/
>>>>
>>>> Based on my study, I think the sector cache function of A64FX can be
>>>> added into the allocation features of resctrl after James' resctrl rework has
>> finished.
>>>> But, in order to implement this function, more interfaces for resctrl are
>> need.
>>>> The details are as follow, and could you give me some advice?
>>>>
>>>> [Sector cache function]
>>>> The sector cache function split cache into multiple sectors and
>>>> control them separately. It is implemented on the L1D cache and
>>>> L2 cache in the A64FX processor and can be controlled individually
>>>> for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache and
>>>> L2 cache has 4 sectors. Which L1D sector is used is specified by the
>>>> value of [57:56] bits of address, how many ways of sector are
>>>> specified by the value of register (IMP_SCCR_L1_EL0).
>>>> Which L2 sector is used is specified by the value of [56] bits of
>>>> address, and how many ways of sector are specified by value of
>>>> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
>>>> IMP_SCCR_SET1_L2_EL1).
>>>>
>>>> For more details of sector cache function, see A64FX HPC extension
>>>> specification (1.2. Sector cache) in https://github.com/fujitsu/A64FX
>>
>> The overview in section 12 was informative but very high level.
> 
> I'm considering how to answer your questions from your email which
> I received before, when I check the email again, I am sorry that
> the information I provided before are insufficient.
> 
> To understand the sector cache function of A64FX, could you please see
> A64FX_Microarchitecture_Manual - section 12. Sector Cache
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Microarchitecture_Manual_en_1.4.pdf
> and,
> A64FX_Specification_HPC_Extension ? section 1.2. Sector Cache
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Specification_HPC_Extension_v1_EN.pdf

Thank you for the direct links - I missed that there are two documents  
available.

After reading the spec portion it does seem to me even more as though  
"sectors" could be considered the same as the resctrl "classes of  
service". The Fujitsu hardware supports four sectors that can be  
configured with different number of ways using the registers you mention  
above. In resctrl this could be considered as hardware that supports  
four classes of service and each class of service can be allocated a  
different number of ways.

The other part is how hardware knows which sector is being used at any  
moment in time. In resctrl that is programmed by writing the active  
class of service into needed register at the time the application is  
context switched (resctrl_sched_in()). This seems different here since  
as you describe the sector is chosen by bits in the address. Even so,  
which bits to set in the address needs to be programmed also and I also  
understand that there is a "default" sector that can be programmed via  
register. Could these be equivalent to what is done currently in resctrl?

(Could you please also consider my original questions?)

> 
> In addition, Japan will be on a long holiday about one week from
> April 29th, I will answer your other questions after the holidays.
> 
>> I was not able to find any instance of "IMP_SCCR" in this document to explore
>> how this cache allocation works.
>>
>> Are these cache sectors exposed to the OS in any way? For example, when the
>> OS discovers the cache, does it learn about these sectors and expose the
>> details to user space (/sys/devices/system/cpuX/cache)?
>>
>> The overview of Sector Cache in that document provides details of how the size
>> of the sector itself is dynamically adjusted to usage. That description is quite
>> cryptic but it seems like a sector, since the number of ways associated with it
>> can dynamically change, is more equivalent to a class of service or resource
>> group in the resctrl environment.
>>
>> I really may be interpreting things wrong here, could you perhaps point me to
>> where I can obtain more details?
>>
>>
>>>> [Difference between resctrl(CAT) and this sector cache function]
>>>> L2/L3 CAT (Cache Allocation Technology) enables the user to specify
>>>> some physical partition of cache space that an application can fill.
>>>> A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function
>>>> enables a user to specify number of ways each sector uses.
>>>> Therefore, for CAT it is enough to specify a cache portion for each
>>>> cache_id (socket). On the other hand, sector cache needs to specify
>>>> cache portion of each sector for each cache_id, and following
>>>> extension to resctrl interface is needed to support sector cache.
>>>>
>>>> [Idear for A64FX sector cache function control interface (schemata
>>>> file details)]
>>>>
>> L1:<cache_id0>=<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=<cw
>>>> bm>,<cwbm>,<cwbm>,<cwbm>;…
>>>>
>> L2:<cache_id0>=>=<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=
>>>> <cwbm>,<cwbm>,<cwbm>,<cwbm>;…
>>>>
>>>> ・L1: Add a new interface to control the L1D cache.
>>>> ・<cwbm>,<cwbm>,<cwbm>,<cwbm>：Specify the number of ways for
>> each
>>>> sector.
>>>> ・cwbm：Specify the number of ways in each sector as a bitmap
>> (percentage),
>>>>     but the bitmap does not indicate the location of the cache.
>>>> * In the sector cache function, L2 sector cache way setting register is
>>>>     shared among PEs (Processor Element) in shared domain. If two PEs
>>>>     which share L2 cache belongs to different resource groups, one
>> resource
>>>>     group's L2 setting will affect to other resource group's L2 setting.
>>
>> In resctrl a "resource group" can be viewed as a class of service.
>>
>>>> * Since A64FX does not support MPAM, it is not necessary to consider
>>>>     how to switch between MPAM and sector cache function now.
>>>>
>>>> Some questions:
>>>> 1.I'm still studying about RDT, could you tell me whether RDT has
>>>>     the similar mechanism with sector cache function?
>>
>> This is not clear to me yet. One thing to keep in mind is that a bit in the capacity
>> bitmask could correspond to some number of ways in a cache, but it does not
>> have to. It is essentially a hint to hardware on how much cache space needs to
>> be allocated while also indicating overlap and isolation from other allocations.
>>
>> resctrl already supports the bitmask being interpreted differently between
>> architectures and with the MPAM support there will be even more support for
>> different interpretations.
>>
>>>> 2.In RDT, L3 cache is shared among cores in socket. If two cores which
>>>>     share L3 cache belongs to different resource groups, one resource
>>>>     group's L3 setting will affect to other resource group's L3 setting?
>>
>> This question is not entirely clear to me. Are you referring to the hardware layout
>> or configuration changes via the resctrl "cpus" file?
>>
>> Each resource group is a class of service (CLOS) that is supported by all cache
>> instances. By default each resource group would thus contain all cache
>> instances on the system (even if some cache instances do not support the
>> same number of CLOS resctrl would only support the CLOS supported by all
>> resources).
> 

Reinette
