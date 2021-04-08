Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487F1358B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDHRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:21:11 -0400
Received: from foss.arm.com ([217.140.110.172]:55438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhDHRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D85313A1;
        Thu,  8 Apr 2021 10:20:53 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE743F792;
        Thu,  8 Apr 2021 10:20:51 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 01/24] x86/resctrl: Split struct rdt_resource
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
Message-ID: <fad1f8f7-0601-7472-2a98-f0906e88ba2c@arm.com>
Date:   Thu, 8 Apr 2021 18:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <a0d56d3d-95aa-e3c2-5dff-23b7c23e242d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 07/04/2021 00:42, Reinette Chatre wrote:
> On 4/6/2021 10:13 AM, James Morse wrote:
>> On 31/03/2021 22:35, Reinette Chatre wrote:
>>> On 3/12/2021 9:58 AM, James Morse wrote:
>>>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>>>> To support it on another architecture, it needs to be abstracted from
>>>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>>>
>>>> Start by splitting struct rdt_resource, (the name is kept to keep the noise
>>>> down), and add some type-trickery to keep the foreach helpers working.

>>>> Move everything that is particular to resctrl into a new header
>>>> file, keeping the x86 hardware accessors where they are. resctrl code
>>>> paths touching a 'hw' struct indicates where an abstraction is needed.
>>>
>>> This establishes the significance of this patch. Here the rdt_resource struct is split up
>>> and it is this split that guides the subsequent abstraction. Considering this I find that
>>> this description does not explain the resulting split sufficiently.
>>>
>>> Specifically, after reading the above summary I expect fs information in rdt_resource and
>>> hw information in rdt_hw_resource but that does not seem to be the case. For example,
>>> num_rmid is a property obtained from hardware but is found in rdt_resource while other
>>> hardware properties initialized at the same time are found in rdt_hw_resource. It is
>>> interesting to look at when the hardware is discovered (for example, functions like
>>> cache_alloc_hsw_probe(), __get_mem_config_intel(), __rdt_get_mem_config_amd(),
>>> rdt_get_cache_alloc_cfg()). Note how some of the discovered values end up in rdt_resource
>>> and some in rdt_hw_resource.
>>
>>> I was expecting these properties discovered from hardware to
>>> be in rdt_hw_resource.
>>
>> Not all values discovered from the hardware are private to the architecture. They only
>> need to be private if there is some further abstraction involved.

> ok, but rdt_hw_resource is described as "hw attributes of a resctrl resource" so this can
> be very confusing if rdt_hw_resource does _not_ actually contain (all of) the hw
> attributes of a resctrl resource.

Aha, right. I'm bad at naming things. This started as untangling the hardware (cough:
arch) specific bits, but some things have migrated back the other way.

Do you think either of arch_rdt_resource or rdt_priv_resource are clearer?


> Could you please expand the kernel doc for rdt_hw_resource to explain that, apart from
> @resctrl (that I just noticed is missing a description),

I'll add one for mbm_width too,

> it contains attributes needing
> abstraction for different architectures as opposed to the actual hardware attributes?

|/**
| * struct rdt_hw_resource - arch private attributes of a resctrl resource
| * @resctrl:		Attributes of the resource used directly by resctrl.
| * @num_closid:	Number of CLOSIDs available.
| * @msr_base:		Base MSR address for CBMs
| * @msr_update:	Function pointer to update QOS MSRs
| * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
| * @mbm_width:		Monitor width, to detect and correct for overflow.
| *
| * Members of this structure are either private to the architecture
| * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
| * msr_update and msr_base.
| */


>> On your specific example: the resctrl filesystem code allocates from num_rmid. Its meaning
>> doesn't change. num_closid on the other hand changes depending on whether CDP is in use.
>>
>> Putting num_closid in resctrl's struct rdt_resource would work, but the value is wrong
>> once CDP is enabled. This would be annoying to debug, hiding the hardware value and
>> providing it via a helper avoids this, as by the end of the series there is only one
>> consumer: schemata_list_create().
>>
>> For MPAM, the helper would return arm64's version of rdt_min_closid as there is only one
>> 'num_closid' for the system, regardless of the resource. The driver has to duplicate the
>> logic in closid_init() to find the minimum common value of all the resources, as not all
>> the resources are exposed to resctrl, and an out-of-range closid value triggers an error
>> interrupt.
>>
>>
>>> It is also not clear to me how these structures are intended to be used for related
>>> hardware properties. For example, rdt_resource keeps the properties
>>> alloc_capable/alloc_enabled/mon_capable/mon_enabled - but in this series companion
>>> properties of cdp_capable/cdp_enabled are introduced and placed in rdt_hw_resource.
>>
>> There needs to be further abstraction around cdp_enabled. For Arm's MPAM CDP is emulated
>> by providing different closid for data-access and instruction-fetch. This is done in the
>> equivalent to IA32_PQR_ASSOC, so it affects all the resources.
>>
>> For MPAM all resources would be cdp_capable, so the field doesn't need to exist.
> 
> Will it be removed?

It wouldn't exist in the MPAM version of rdt_hw_resource.

It is needed for Intel's RDT to ensure CDP can be supported and enabled per-resource,
which is how I read your no 'force enabling of CDP on all cache levels' comment from:
https://lore.kernel.org/lkml/fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com/

If you don't think per-resources tracking is needed, did I read that wrong?
(it only 'forced' CDP on for the L2 if it had been enabled for L3. My understanding is no
SoC today has both)


>> cdp_enabled has to be used via a helper, as its a global property for all the tasks that
>> resctrl is in control of, not a per-resource field.
>>
>> (this is the reason the previous version tried to make the CDP state global, on the
>> assumption it would never appear on both L2 and L3 for x86 systems)
>>
>> (The next patch after these removes alloc_enabled, as it no longer means anything once the
>> resources are merged. I didn't post it to try and keep the series small)
>>> That seems contradicting to me.
>>
>>> Since this change is so foundational it would be very helpful if the resulting split could
>>> be explained in more detail.
>>
>> Sure. I'll add a paragraph on where I think extra abstraction is needed for the members of
>> struct rdt_hw_resource. The two not described above are mon_scale and mbm_width.
>>
>> Currently rephrased as:
>>
>> | Move as much of the structure as possible into the common structure
>> | in the core code's header file. The x86 hardware accessors remain
>> | part of the architecture private code, as do num_closid, mon_scale
>> | and mbm_width.
>> | mon_scale and mbm_width are used to detect overflow of the hardware
>> | counters, and convert them from their native size to bytes. Any
>> | cross-architecture abstraction should be in terms of bytes, making
>> | these properties private.
>> | The hardware's num_closid is kept in the private structure to force
>> | the filesystem code to use a helper to access it. MPAM would return a
>> | single value for the system, regardless of the resource. Using the
>> | helper prevents this field from being confused with the version of
>> | num_closid that is being exposed to user-space (added in a later patch).

> This is very helpful. Thank you. I also think that adding a similar per-property summary
> to the kernel-doc of rt_hw_resource would be very helpful.

The problem is 'any cross-architecture abstraction' refers to patches that will show up
quite a bit later. I think this is fine for the motivation in the commit message as the
information is only relevant at the point of the change, but its decidedly weird to refer
to MPAM in the x86's header files.

I'll add the reason behind num_closid being odd to the patch that adds the helper.


Thanks,

James
