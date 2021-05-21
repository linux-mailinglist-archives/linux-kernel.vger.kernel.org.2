Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCEE38CC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhEURpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:45:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:45295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238318AbhEURpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:45:40 -0400
IronPort-SDR: SMplKDsGPYL0FQ60mPaZSbn1b9enB4d/NL3zbXkfwJx9UVEeQcKHg/WQXdsAaIAT586NnrKGsU
 dIOxkDXB8BjA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="181827071"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="181827071"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 10:44:17 -0700
IronPort-SDR: gvnEUf6Vjjxvl2tUzpPfZaSP7K1YGdrnk2i0Bv+p7RzDInaWRMVrvleET4+uhyD94IFEmDLQ09
 Fo6FzmNwtX3A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="475821472"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.131.185]) ([10.212.131.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 10:44:16 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
Date:   Fri, 21 May 2021 10:44:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
> I’m sorry for the late reply.
> I think I could not explain A64FX’s sector cache function well in
> my first mail. While answering the question, I will also explain
> this function in more detail. Though maybe you have already learned
> more about this function by reading specification and manual,
> in order to better understand this function, some contents may have
> duplicate explanations.
> 
>>>> The overview in section 12 was informative but very high level.
>>>
>>> I'm considering how to answer your questions from your email which I
>>> received before, when I check the email again, I am sorry that the
>>> information I provided before are insufficient.
>>>
>>> To understand the sector cache function of A64FX, could you please see
>>> A64FX_Microarchitecture_Manual - section 12. Sector Cache
>>>
>> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Microarchitectu
>>> re_Manual_en_1.4.pdf
>>> and,
>>> A64FX_Specification_HPC_Extension ? section 1.2. Sector Cache
>>>
>> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Specification_H
>>> PC_Extension_v1_EN.pdf
>>
>> Thank you for the direct links - I missed that there are two documents available.
>>
>> After reading the spec portion it does seem to me even more as though
>> "sectors" could be considered the same as the resctrl "classes of service". The
>> Fujitsu hardware supports four sectors that can be configured with different
>> number of ways using the registers you mention above. In resctrl this could be
>> considered as hardware that supports four classes of service and each class of
>> service can be allocated a different number of ways.
> 
> Fujitsu hardware supports four sectors that can be configured with
> different number of ways by using "IMP_SCCR" registers, and when this
> function is added into resctrl, the maximum ways of each sector are
> indicated by bitmap.
> 
> However, A64FX's L2 cache setting registers are shared among PEs
> (Processor Element) in NUMA. If two PEs in the same NUMA are assigned
> to different resource groups, changing one PE's L2 setting on one
> resource group, the other PE's L2 setting on other resource groups
> will be influenced. So, adding this function into resctrl, we will
> assign NUMA to the resource group. (On F64FX, each NUMA has 12 PEs,
> and each PE has L1 cache setting registers, but these registers are
> not shared.) There are 4 NUMAs on A64FX, 4 NUMAs could be considered
> as hardware that supports four classes of service at most, and each
> class of service has 4 sectors (4 L1 sectors& 4 L2 sectors),
> and each sector can be allocated a different number of ways.
> And, when a running task on resource group, the [56:57] bits of
> virtual address are used for sector selection (cache affinity).

It is not clear to me why NUMA needs to be involved.

Processors sharing a cache, either L2 or L3 cache, is familiar and well  
supported by resctrl.

My understanding of the sector cache feature is that each cache can be  
split into multiple (4) sectors. It thus seems to me something specific  
to the cache itself.

Let me try and give an example of my understanding based on the cache  
architecture described in the A64FX Microarchitecture Manual.

I see in Figure 9-2 that each processor has an L1D as well as L1I Cache,  
and twelve processors share an L2 cache. The L1D cache has 4 ways (0xF  
bitmask) and L2 cache has 16 (0xFFFF bitmask) ways. From what I  
understand the sector cache function is supported on L1D and L2.

First, the goal would be to discover all the caches on the system -  
since it is the sectors need to be programmed on each cache. On the  
system with 48 cores there would thus be 48 L1D caches, and 4 L2 caches.

Let's start by assigning the caches IDs: the L1D caches are numbered  
from 0 to 47 and the L2 caches numbered from 0 to 3.

My understanding is that the goal is to program these sectors using  
resctrl. Each cache instance can have maximum four sectors, they cannot  
overlap. (I do not know if each sector has to have some portion of cache  
associated with it or if a sector is allowed to be "empty").

So, what is needed is, for example, to have a way to say: "sector 0 on  
cache L1D with id X is assigned Y ways", "sector 1 on cache L2 with id Z  
is assigned XX ways". Is this correct?

If my understanding is correct then you can do this with resctrl as  
follows (I am making many assumptions on behavior here, especially  
regarding how many ways a sector is required to have, but I hope this  
could be a baseline to evaluate and correct my understanding and build  
on how this could be supported):

On boot all cache ways on all cache instances belong to sector 0:

# cd /sys/fs/resctrl/
# cat schemata
L1D:0=0xf;1=0xf;2=0xf;.....;47=0xf
L2:0=0xffff;1=0xffff;2=0xffff;3=0xffff

Create sector2 and assign half of all cache ways to it:
(In support of this it would be required that resctrl resource groups  
are exclusive. Exclusive resource groups are already supported but not  
the default as it needed here.)

First, to provide cache ways to sector 1, the cache ways needs to be  
removed from sector 0:
(I am not sure if specific ways can be assigned to a sector or just a  
number of ways, both could be supported)
# echo 'L1D:0=0x3;1=0x3;...;47=0x3' > /sys/fs/resctrl/schemata
# echo 'L2:0=0xff;1=0xff;2=0xff;3=0xff'> /sys/fs/resctrl/schemata

Now create sector2 (alternatively all sectors could exist on boot for  
this system):
# mkdir /sys/fs/resctrl/sector2
# echo 'L1D:0=0x3;1=0x3;...;47=0x3' > /sys/fs/resctrl/sector2/schemata
# echo 'L2:0=0xff;1=0xff;2=0xff;3=0xff'> /sys/fs/resctrl/sector2/schemata

At this point there are two sectors configured. Configuration of sector0  
can be found in /sys/fs/resctrl/schemata and configuration of sector1 in  
/sys/fs/resctrl/sector1/schemata

>> The other part is how hardware knows which sector is being used at any
>> moment in time. In resctrl that is programmed by writing the active class of
>> service into needed register at the time the application is context switched
>> (resctrl_sched_in()). This seems different here since as you describe the
>> sector is chosen by bits in the address. Even so, which bits to set in the
>> address needs to be programmed also and I also understand that there is a
>> "default" sector that can be programmed via register. Could these be equivalent
>> to what is done currently in resctrl?
> 
> Adding this function into resctrl, there is no need to write active
> class of service into needed register. When running a task, the sector
> id is decided by [56:57] bits of virtual address, and these bits are
> programed by users. When creating a resource group, the maximum number
> of ways of each sector are set by "IMP_SCCR" setting registers.
> As long as the task is running in a certain resource group, the sector
> and the maximum number of ways of sectors are used will not be changed.
> Therefore, we need not consider context switches on A64FX.
> 

The current interface would associate a "tasks" file with each sector to  
indicate which tasks run with the particular sector id. I thought there  
was a way to program the default sector id in a register, which is  
something that could be done when a task is context switched in.  
Otherwise there would need to be some re-architecting to remove the  
"tasks" association. This would be a significant change.

Reinette

