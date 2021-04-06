Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF2355FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbhDFXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:42:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:2818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhDFXmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:42:51 -0400
IronPort-SDR: MqhIwWER+BprRSXEc6RgQZnbEr8DlXAl5RAWCBFcnNie++jaSrpuWze0ueKu2CnmYmWmU4XP4n
 wXwZ2gyRyeeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192718855"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192718855"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:42:43 -0700
IronPort-SDR: DkcPvtxojHJVkntwpT9KU/HMKuS3RVxVSTgrNSu9VDA9bYM/3Qd1Qb4gjAFeNCzqL7wFCMaFWA
 YapiBsF4YR9w==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="418544647"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.211.218]) ([10.212.211.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:42:43 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a0d56d3d-95aa-e3c2-5dff-23b7c23e242d@intel.com>
Date:   Tue, 6 Apr 2021 16:42:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <6a8ad187-119b-c279-3db9-0b074138fd9f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/6/2021 10:13 AM, James Morse wrote:
> On 31/03/2021 22:35, Reinette Chatre wrote:
>> On 3/12/2021 9:58 AM, James Morse wrote:
>>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>>> To support it on another architecture, it needs to be abstracted from
>>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>>
>>> Start by splitting struct rdt_resource, (the name is kept to keep the noise
>>> down), and add some type-trickery to keep the foreach helpers working.
> 
>> Could you please replace "add some type-trickery" with a description of the
>> changes(tricks?) referred to? Comments in the code would be helpful also ... helping to
>> avoid frowning at what at first glance seems like an out-of-bounds access.
> 
> Sure, this paragraph is rephrased:
> | Start by splitting struct rdt_resource, into an arch specific 'hw'
> | struct, which contains the common resctrl structure that would be used
> | by any architecture.
> |
> | The foreach helpers are most commonly used by the filesystem code,
> | and should return the common resctrl structure. for_each_rdt_resource()
> | is changed to walk the common structure in its parent arch specific
> | structure.
> 
> and a comment above for_each_rdt_resource():
> | /*
> |  * To return the common struct rdt_resource, which is contained in struct
> |  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> |  * This makes the limit the resctrl member past the end of the array.
> |  */

Thank you.


>>> Move everything that is particular to resctrl into a new header
>>> file, keeping the x86 hardware accessors where they are. resctrl code
>>> paths touching a 'hw' struct indicates where an abstraction is needed.
>>
>> This establishes the significance of this patch. Here the rdt_resource struct is split up
>> and it is this split that guides the subsequent abstraction. Considering this I find that
>> this description does not explain the resulting split sufficiently.
>>
>> Specifically, after reading the above summary I expect fs information in rdt_resource and
>> hw information in rdt_hw_resource but that does not seem to be the case. For example,
>> num_rmid is a property obtained from hardware but is found in rdt_resource while other
>> hardware properties initialized at the same time are found in rdt_hw_resource. It is
>> interesting to look at when the hardware is discovered (for example, functions like
>> cache_alloc_hsw_probe(), __get_mem_config_intel(), __rdt_get_mem_config_amd(),
>> rdt_get_cache_alloc_cfg()). Note how some of the discovered values end up in rdt_resource
>> and some in rdt_hw_resource.
> 
>> I was expecting these properties discovered from hardware to
>> be in rdt_hw_resource.
> 
> Not all values discovered from the hardware are private to the architecture. They only
> need to be private if there is some further abstraction involved.

ok, but rdt_hw_resource is described as "hw attributes of a resctrl 
resource" so this can be very confusing if rdt_hw_resource does _not_ 
actually contain (all of) the hw attributes of a resctrl resource.

Could you please expand the kernel doc for rdt_hw_resource to explain 
that, apart from @resctrl (that I just noticed is missing a 
description), it contains attributes needing abstraction for different 
architectures as opposed to the actual hardware attributes?

> There is a trade-off here. Everything could be accessed via helpers, but I think that
> would result in a lot of boiler plate.
> 

I see.

> On your specific example: the resctrl filesystem code allocates from num_rmid. Its meaning
> doesn't change. num_closid on the other hand changes depending on whether CDP is in use.
> 
> Putting num_closid in resctrl's struct rdt_resource would work, but the value is wrong
> once CDP is enabled. This would be annoying to debug, hiding the hardware value and
> providing it via a helper avoids this, as by the end of the series there is only one
> consumer: schemata_list_create().
> 
> For MPAM, the helper would return arm64's version of rdt_min_closid as there is only one
> 'num_closid' for the system, regardless of the resource. The driver has to duplicate the
> logic in closid_init() to find the minimum common value of all the resources, as not all
> the resources are exposed to resctrl, and an out-of-range closid value triggers an error
> interrupt.
> 
> 
>> It is also not clear to me how these structures are intended to be used for related
>> hardware properties. For example, rdt_resource keeps the properties
>> alloc_capable/alloc_enabled/mon_capable/mon_enabled - but in this series companion
>> properties of cdp_capable/cdp_enabled are introduced and placed in rdt_hw_resource.
> 
> There needs to be further abstraction around cdp_enabled. For Arm's MPAM CDP is emulated
> by providing different closid for data-access and instruction-fetch. This is done in the
> equivalent to IA32_PQR_ASSOC, so it affects all the resources.
> 
> For MPAM all resources would be cdp_capable, so the field doesn't need to exist.

Will it be removed?

> cdp_enabled has to be used via a helper, as its a global property for all the tasks that
> resctrl is in control of, not a per-resource field.
> 
> (this is the reason the previous version tried to make the CDP state global, on the
> assumption it would never appear on both L2 and L3 for x86 systems)
> 
> (The next patch after these removes alloc_enabled, as it no longer means anything once the
> resources are merged. I didn't post it to try and keep the series small)
>> That seems contradicting to me.
> 
>> Since this change is so foundational it would be very helpful if the resulting split could
>> be explained in more detail.
> 
> Sure. I'll add a paragraph on where I think extra abstraction is needed for the members of
> struct rdt_hw_resource. The two not described above are mon_scale and mbm_width.
> 
> Currently rephrased as:
> 
> | Move as much of the structure as possible into the common structure
> | in the core code's header file. The x86 hardware accessors remain
> | part of the architecture private code, as do num_closid, mon_scale
> | and mbm_width.
> | mon_scale and mbm_width are used to detect overflow of the hardware
> | counters, and convert them from their native size to bytes. Any
> | cross-architecture abstraction should be in terms of bytes, making
> | these properties private.
> | The hardware's num_closid is kept in the private structure to force
> | the filesystem code to use a helper to access it. MPAM would return a
> | single value for the system, regardless of the resource. Using the
> | helper prevents this field from being confused with the version of
> | num_closid that is being exposed to user-space (added in a later patch).
> 

This is very helpful. Thank you. I also think that adding a similar 
per-property summary to the kernel-doc of rt_hw_resource would be very 
helpful.

Reinette

