Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB346358E01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhDHUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:04:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:34291 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhDHUE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:04:28 -0400
IronPort-SDR: ta19M2yu37vEPXJ8ADfKtkXW7/BIXKb8ZoaCCX+wzOQhyMmuOhLOHc0VS1wYuFRGCJtM6W3VPA
 SSS02nQrzQsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257602595"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="257602595"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 13:04:14 -0700
IronPort-SDR: zFaCEXbv2OWhzQdbW1SNFI2bzBB50EMwymKY9YMEYssvTkW5uT+dZTMcJtTSaiBeQNoSuTovRm
 1tIgCv5XEBMQ==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="422396136"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.185.130]) ([10.212.185.130])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 13:04:14 -0700
Subject: Re: [PATCH v2 01/24] x86/resctrl: Split struct rdt_resource
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <20210312175849.8327-2-james.morse@arm.com>
 <4d2cabac-a3a8-68a1-381e-44df66b61345@intel.com>
 <6a8ad187-119b-c279-3db9-0b074138fd9f@arm.com>
 <a0d56d3d-95aa-e3c2-5dff-23b7c23e242d@intel.com>
 <fad1f8f7-0601-7472-2a98-f0906e88ba2c@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0e80dd9b-02ee-eb51-394f-7a8d0041395f@intel.com>
Date:   Thu, 8 Apr 2021 13:04:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <fad1f8f7-0601-7472-2a98-f0906e88ba2c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/8/2021 10:20 AM, James Morse wrote:
> On 07/04/2021 00:42, Reinette Chatre wrote:
>> On 4/6/2021 10:13 AM, James Morse wrote:
>>> On 31/03/2021 22:35, Reinette Chatre wrote:
>>>> On 3/12/2021 9:58 AM, James Morse wrote:
>>>>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>>>>> To support it on another architecture, it needs to be abstracted from
>>>>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>>>>
>>>>> Start by splitting struct rdt_resource, (the name is kept to keep the noise
>>>>> down), and add some type-trickery to keep the foreach helpers working.
> 
>>>>> Move everything that is particular to resctrl into a new header
>>>>> file, keeping the x86 hardware accessors where they are. resctrl code
>>>>> paths touching a 'hw' struct indicates where an abstraction is needed.
>>>>
>>>> This establishes the significance of this patch. Here the rdt_resource struct is split up
>>>> and it is this split that guides the subsequent abstraction. Considering this I find that
>>>> this description does not explain the resulting split sufficiently.
>>>>
>>>> Specifically, after reading the above summary I expect fs information in rdt_resource and
>>>> hw information in rdt_hw_resource but that does not seem to be the case. For example,
>>>> num_rmid is a property obtained from hardware but is found in rdt_resource while other
>>>> hardware properties initialized at the same time are found in rdt_hw_resource. It is
>>>> interesting to look at when the hardware is discovered (for example, functions like
>>>> cache_alloc_hsw_probe(), __get_mem_config_intel(), __rdt_get_mem_config_amd(),
>>>> rdt_get_cache_alloc_cfg()). Note how some of the discovered values end up in rdt_resource
>>>> and some in rdt_hw_resource.
>>>
>>>> I was expecting these properties discovered from hardware to
>>>> be in rdt_hw_resource.
>>>
>>> Not all values discovered from the hardware are private to the architecture. They only
>>> need to be private if there is some further abstraction involved.
> 
>> ok, but rdt_hw_resource is described as "hw attributes of a resctrl resource" so this can
>> be very confusing if rdt_hw_resource does _not_ actually contain (all of) the hw
>> attributes of a resctrl resource.
> 
> Aha, right. I'm bad at naming things. This started as untangling the hardware (cough:
> arch) specific bits, but some things have migrated back the other way.

It was the description that really tripped me. I'm ok with the current 
naming if the description is clear and usage consistent.

> 
> Do you think either of arch_rdt_resource or rdt_priv_resource are clearer?
> 
> 
>> Could you please expand the kernel doc for rdt_hw_resource to explain that, apart from
>> @resctrl (that I just noticed is missing a description),
> 
> I'll add one for mbm_width too,
> 
>> it contains attributes needing
>> abstraction for different architectures as opposed to the actual hardware attributes?
> 
> |/**
> | * struct rdt_hw_resource - arch private attributes of a resctrl resource
> | * @resctrl:		Attributes of the resource used directly by resctrl.
> | * @num_closid:	Number of CLOSIDs available.
> | * @msr_base:		Base MSR address for CBMs
> | * @msr_update:	Function pointer to update QOS MSRs
> | * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> | * @mbm_width:		Monitor width, to detect and correct for overflow.
> | *
> | * Members of this structure are either private to the architecture
> | * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> | * msr_update and msr_base.
> | */
> 

As I commented in patch 7, where num_closid is stored in the schema, I 
think the descriptions can be improved to help understand the 
differences between the two num_closid instances. The two num_closid 
descriptions (found in struct resctrl_schema and  struct 
rdt_hw_resource) should be complimentary to help somebody have clear 
understanding of their difference. Currently they are mostly a copy of 
the same description not helping to understand what the difference is. 
Perhaps something here like "Number of CLOSIDs supported by 
hardware/architecture"?  Please feel free to improve.

The rest looks good, thank you.

>>> On your specific example: the resctrl filesystem code allocates from num_rmid. Its meaning
>>> doesn't change. num_closid on the other hand changes depending on whether CDP is in use.
>>>
>>> Putting num_closid in resctrl's struct rdt_resource would work, but the value is wrong
>>> once CDP is enabled. This would be annoying to debug, hiding the hardware value and
>>> providing it via a helper avoids this, as by the end of the series there is only one
>>> consumer: schemata_list_create().
>>>
>>> For MPAM, the helper would return arm64's version of rdt_min_closid as there is only one
>>> 'num_closid' for the system, regardless of the resource. The driver has to duplicate the
>>> logic in closid_init() to find the minimum common value of all the resources, as not all
>>> the resources are exposed to resctrl, and an out-of-range closid value triggers an error
>>> interrupt.
>>>
>>>
>>>> It is also not clear to me how these structures are intended to be used for related
>>>> hardware properties. For example, rdt_resource keeps the properties
>>>> alloc_capable/alloc_enabled/mon_capable/mon_enabled - but in this series companion
>>>> properties of cdp_capable/cdp_enabled are introduced and placed in rdt_hw_resource.
>>>
>>> There needs to be further abstraction around cdp_enabled. For Arm's MPAM CDP is emulated
>>> by providing different closid for data-access and instruction-fetch. This is done in the
>>> equivalent to IA32_PQR_ASSOC, so it affects all the resources.
>>>
>>> For MPAM all resources would be cdp_capable, so the field doesn't need to exist.
>>
>> Will it be removed?
> 
> It wouldn't exist in the MPAM version of rdt_hw_resource.
> 
> It is needed for Intel's RDT to ensure CDP can be supported and enabled per-resource,
> which is how I read your no 'force enabling of CDP on all cache levels' comment from:
> https://lore.kernel.org/lkml/fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com/
> 
> If you don't think per-resources tracking is needed, did I read that wrong?
> (it only 'forced' CDP on for the L2 if it had been enabled for L3. My understanding is no
> SoC today has both)

Thank you for clarifying. No, you did not read my earlier comments 
wrong. Intel RDT does support and enable CDP per-resource.


>>> cdp_enabled has to be used via a helper, as its a global property for all the tasks that
>>> resctrl is in control of, not a per-resource field.
>>>
>>> (this is the reason the previous version tried to make the CDP state global, on the
>>> assumption it would never appear on both L2 and L3 for x86 systems)
>>>
>>> (The next patch after these removes alloc_enabled, as it no longer means anything once the
>>> resources are merged. I didn't post it to try and keep the series small)
>>>> That seems contradicting to me.
>>>
>>>> Since this change is so foundational it would be very helpful if the resulting split could
>>>> be explained in more detail.
>>>
>>> Sure. I'll add a paragraph on where I think extra abstraction is needed for the members of
>>> struct rdt_hw_resource. The two not described above are mon_scale and mbm_width.
>>>
>>> Currently rephrased as:
>>>
>>> | Move as much of the structure as possible into the common structure
>>> | in the core code's header file. The x86 hardware accessors remain
>>> | part of the architecture private code, as do num_closid, mon_scale
>>> | and mbm_width.
>>> | mon_scale and mbm_width are used to detect overflow of the hardware
>>> | counters, and convert them from their native size to bytes. Any
>>> | cross-architecture abstraction should be in terms of bytes, making
>>> | these properties private.
>>> | The hardware's num_closid is kept in the private structure to force
>>> | the filesystem code to use a helper to access it. MPAM would return a
>>> | single value for the system, regardless of the resource. Using the
>>> | helper prevents this field from being confused with the version of
>>> | num_closid that is being exposed to user-space (added in a later patch).
> 
>> This is very helpful. Thank you. I also think that adding a similar per-property summary
>> to the kernel-doc of rt_hw_resource would be very helpful.
> 
> The problem is 'any cross-architecture abstraction' refers to patches that will show up
> quite a bit later. I think this is fine for the motivation in the commit message as the
> information is only relevant at the point of the change, but its decidedly weird to refer
> to MPAM in the x86's header files.

ok, I think I see where you are going ...  MPAM is not expected to have 
mon_scale and mbm_width?

> 
> I'll add the reason behind num_closid being odd to the patch that adds the helper.

Thank you

Reinette
