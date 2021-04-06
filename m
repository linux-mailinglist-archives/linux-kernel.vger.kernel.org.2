Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A700355A13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbhDFRN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:13:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbhDFRN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:13:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499651063;
        Tue,  6 Apr 2021 10:13:47 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82B3C3F792;
        Tue,  6 Apr 2021 10:13:45 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <6a8ad187-119b-c279-3db9-0b074138fd9f@arm.com>
Date:   Tue, 6 Apr 2021 18:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4d2cabac-a3a8-68a1-381e-44df66b61345@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 31/03/2021 22:35, Reinette Chatre wrote:
> On 3/12/2021 9:58 AM, James Morse wrote:
>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>> To support it on another architecture, it needs to be abstracted from
>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>
>> Start by splitting struct rdt_resource, (the name is kept to keep the noise
>> down), and add some type-trickery to keep the foreach helpers working.

> Could you please replace "add some type-trickery" with a description of the
> changes(tricks?) referred to? Comments in the code would be helpful also ... helping to
> avoid frowning at what at first glance seems like an out-of-bounds access.

Sure, this paragraph is rephrased:
| Start by splitting struct rdt_resource, into an arch specific 'hw'
| struct, which contains the common resctrl structure that would be used
| by any architecture.
|
| The foreach helpers are most commonly used by the filesystem code,
| and should return the common resctrl structure. for_each_rdt_resource()
| is changed to walk the common structure in its parent arch specific
| structure.

and a comment above for_each_rdt_resource():
| /*
|  * To return the common struct rdt_resource, which is contained in struct
|  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
|  * This makes the limit the resctrl member past the end of the array.
|  */


>> Move everything that is particular to resctrl into a new header
>> file, keeping the x86 hardware accessors where they are. resctrl code
>> paths touching a 'hw' struct indicates where an abstraction is needed.
> 
> This establishes the significance of this patch. Here the rdt_resource struct is split up
> and it is this split that guides the subsequent abstraction. Considering this I find that
> this description does not explain the resulting split sufficiently.
> 
> Specifically, after reading the above summary I expect fs information in rdt_resource and
> hw information in rdt_hw_resource but that does not seem to be the case. For example,
> num_rmid is a property obtained from hardware but is found in rdt_resource while other
> hardware properties initialized at the same time are found in rdt_hw_resource. It is
> interesting to look at when the hardware is discovered (for example, functions like
> cache_alloc_hsw_probe(), __get_mem_config_intel(), __rdt_get_mem_config_amd(),
> rdt_get_cache_alloc_cfg()). Note how some of the discovered values end up in rdt_resource
> and some in rdt_hw_resource.

> I was expecting these properties discovered from hardware to
> be in rdt_hw_resource.

Not all values discovered from the hardware are private to the architecture. They only
need to be private if there is some further abstraction involved.

There is a trade-off here. Everything could be accessed via helpers, but I think that
would result in a lot of boiler plate.

On your specific example: the resctrl filesystem code allocates from num_rmid. Its meaning
doesn't change. num_closid on the other hand changes depending on whether CDP is in use.

Putting num_closid in resctrl's struct rdt_resource would work, but the value is wrong
once CDP is enabled. This would be annoying to debug, hiding the hardware value and
providing it via a helper avoids this, as by the end of the series there is only one
consumer: schemata_list_create().

For MPAM, the helper would return arm64's version of rdt_min_closid as there is only one
'num_closid' for the system, regardless of the resource. The driver has to duplicate the
logic in closid_init() to find the minimum common value of all the resources, as not all
the resources are exposed to resctrl, and an out-of-range closid value triggers an error
interrupt.


> It is also not clear to me how these structures are intended to be used for related
> hardware properties. For example, rdt_resource keeps the properties
> alloc_capable/alloc_enabled/mon_capable/mon_enabled - but in this series companion
> properties of cdp_capable/cdp_enabled are introduced and placed in rdt_hw_resource.

There needs to be further abstraction around cdp_enabled. For Arm's MPAM CDP is emulated
by providing different closid for data-access and instruction-fetch. This is done in the
equivalent to IA32_PQR_ASSOC, so it affects all the resources.

For MPAM all resources would be cdp_capable, so the field doesn't need to exist.
cdp_enabled has to be used via a helper, as its a global property for all the tasks that
resctrl is in control of, not a per-resource field.

(this is the reason the previous version tried to make the CDP state global, on the
assumption it would never appear on both L2 and L3 for x86 systems)

(The next patch after these removes alloc_enabled, as it no longer means anything once the
resources are merged. I didn't post it to try and keep the series small)


> That seems contradicting to me.

> Since this change is so foundational it would be very helpful if the resulting split could
> be explained in more detail.

Sure. I'll add a paragraph on where I think extra abstraction is needed for the members of
struct rdt_hw_resource. The two not described above are mon_scale and mbm_width.

Currently rephrased as:

| Move as much of the structure as possible into the common structure
| in the core code's header file. The x86 hardware accessors remain
| part of the architecture private code, as do num_closid, mon_scale
| and mbm_width.
| mon_scale and mbm_width are used to detect overflow of the hardware
| counters, and convert them from their native size to bytes. Any
| cross-architecture abstraction should be in terms of bytes, making
| these properties private.
| The hardware's num_closid is kept in the private structure to force
| the filesystem code to use a helper to access it. MPAM would return a
| single value for the system, regardless of the resource. Using the
| helper prevents this field from being confused with the version of
| num_closid that is being exposed to user-space (added in a later patch).


Thanks,

James
