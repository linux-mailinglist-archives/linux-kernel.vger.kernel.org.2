Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B843B3A17A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhFIOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:46:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:46728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236867AbhFIOqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:46:05 -0400
IronPort-SDR: Y29RpTk9WaDNrw3RR46f5LZNMr4DbXOSkz+XbwytmSUra75JniQvxdnudMuYHC1muy7vPJ6B0/
 h49MHFTZ4W4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="185459884"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="185459884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:44:10 -0700
IronPort-SDR: VKhjsp8LxCzZLg2MpzTkmEXbT89DZLSwNBDJcUUxpOilZCuK2/UYwePpGYZEiPozEnP4b9wCka
 QrR5vT7FEX7g==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="419300967"
Received: from pmadadi-mobl.amr.corp.intel.com (HELO [10.254.191.7]) ([10.254.191.7])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:44:09 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
Message-ID: <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
Date:   Wed, 9 Jun 2021 09:44:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMBHj6PBzeHexXJb@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 11:46 PM, Vinod Koul wrote:
> Hi Pierre,
> 
> You might want to check your setting, this and some other mail (not all
> though) sent by you seem to have landed up in my spam folder, dont know
> why gmail is doing that...

I haven't changed any of my configurations, not sure what happens?

> On 01-06-21, 08:56, Pierre-Louis Bossart wrote:
>>
>>>> b) Vinod commented:
>>>>
>>>> "What I would like to see the end result is that sdw driver for Intel
>>>> controller here is a simple auxdev device and no additional custom setup
>>>> layer required... which implies that this handling should be moved into
>>>> auxdev or Intel code setting up auxdev..."
>>>>
>>>> I was unable to figure out what this comment hinted at: the auxbus is
>>>> already handled in the intel_init.c and intel.c files and the auxbus is used
>>>> to model a set of links/managers below the PCI device, not the controller
>>>> itself. There is also no such thing as a simple auxdev device used in the
>>>> kernel today, the base layer is meant to be extended with domain-specific
>>>> structures. There is really no point in creating a simple auxbus device
>>>> without extensions.
>>>
>>> <back from vacations>
>>
>> same here :-)
>>
>>> I would like to see that the init_init.c removed completely, that is my
>>> ask here
>>>
>>> This layer was created by me to aid in creating the platform devices.
>>> Also the mistake was not to use platform resources and instead pass a
>>> custom structure for resources (device iomem address, irq etc)
>>
>> We are 100% aligned on the ask to remove intel_init.c, this layer is
>> unnecessary and adds more work for developers/maintainers. We will move all
>> this in the SOF driver.
>>
>>> I would like to see is the PCI/SOF parent driver create the sdw aux
>>> device and that should be all needed to be done. The aux device would be
>>> probed by sdw driver. No custom resource structs for resources please.
>> I was following the previous paragraph but got stuck on the last sentence
>> 'no custom structs for resources', see below.
>>
>>> If that is not possible, I would like to understand technical details of
>>> why that would be that case. If required necessary changes should be
>>> made to aux bus to handle and not have sequencing issue which you had
>>> trouble with platform approach.
>>
>> I don't know what you are referring to with the 'sequencing issue which you
>> had trouble with platform approach'. We never had any technical issues with
>> platform devices, the solution works and has been productized. We are only
>> doing this iso-functionality transition because GregKH asked us to do only
>> use platform devices IF there is a real platform device (controlled by
>> DT/ACPI).
>>
>> I think we are also having language/specification issues here. I don't
>> understand what you describe as a 'resource' - there is no interaction with
>> firmware - nor how we can avoid being domain-specific for something that is
>> Intel-specific.
>>
>> Let's go back to the code to help the discussion: the auxiliary driver which
>> manages a SoundWire link needs to be provided with a 'custom' structure that
>> describes basic information provided by the PCI parent (link masks, quirks,
>> IO register bases) and contains internal fields needed for the link
>> management (mutex, ops, list, etc). This is the structure we use:
>>
>> struct sdw_intel_link_res {
>> 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
>> 	void __iomem *registers;
>> 	void __iomem *shim;
>> 	void __iomem *alh;
> 
> These are resources and any auxiliary_device should add this. That way
> while creating you can set up. Hint look at how platform_device sets up
> resources

If you look at the *existing* code, we don't handle any "resources" with 
the platform devices, we use the platform_device_info.data to pass the 
link information. It's a void pointer. We do not touch the resource 
field in the platform_device_into at all.

https://elixir.bootlin.com/linux/latest/source/drivers/soundwire/intel_init.c#L168

>> 	int irq;
> 
> irq is a generic field and should be again moved into auxiliary_device

It's information passed by the parent so that all links use the same 
irq. We added this maybe 1.5 years ago after spending months chasing 
race conditions that we could not root cause. there's nothing generic 
about this field.

>> 	const struct sdw_intel_ops *ops;
> 
> This is for callbacks right? Why cant the sdw aux driver call APIs
> exported by SOF driver?

this is part of the context, this could be moved to a different structure.

>> 	struct device *dev;
> 
> Why do you need a dev pointer here? Is this parent or something else?

for convenience for runtime_pm, there are cases where the link can 
suspend but the parent has to remain active due to power rail 
dependencies, so we need to handle pm_runtime_get_noresume() and 
pm_runtime_put_noidle().

https://elixir.bootlin.com/linux/latest/source/drivers/soundwire/intel.h#L25

We already use this field *today*, this isn't new. I guess we could use 
dev->parent but that'd be a different patch.

>> 	struct mutex *shim_lock; /* protect shared registers */
> 
> Okay so you serialize the access to shim across sdw and sof right?
> export an api from sof driver and get rid of lock here

this is again something we do today. This is not a new field.

see the description here:

https://elixir.bootlin.com/linux/latest/source/drivers/soundwire/intel.h#L25

This is not about serialization between SOF and SDW, only SDW drivers 
access the shim. It's about serialization between the different SDW 
driver instances accessing common hardware registers. Nothing new.

>> 	u32 *shim_mask;
>> 	u32 clock_stop_quirks;
>> 	u32 link_mask;
>> 	struct sdw_cdns *cdns;
>> 	struct list_head list;
> 
> 
> these sound as internal data to sdw instance, move into intel
> driver instances

what intel driver?

We have a PCI Intel driver for the parent (SOF) and a driver instance 
for each SoundWire link - probed when the parent creates the different 
SoundWire devices.

we need to have an Intel link driver which is different from the SOF 
driver used for the parent. This is information needed at the child level.

>> };
>>
>> We could if it was desired for architectural clarity split this structure in
>> what is provided by the parent and what is used inside of the auxiliary
>> driver as an internal context that the parent doesn't touch, but these
>> definitions are again Intel-specific.
> 
> So rather than think Intel specfic, I would suggest you think in generic
> terms. You have a child auxiliary_device (think like PCI etc), add
> the generic resources like iomem regions, irq etc and call into SOF
> driver. That would make sdw driver look neat and help you get rid of
> this bits

Not able to get what this means, sorry. the child device should not 
'call into the SOF driver', mixing parent and child layers leads to 
disaster in general.

The model is exactly the same as what we have today with the platform 
devices. We did not add ANY new fields or information, what is passed in 
that structure is exactly the same as what we do upstream today with the 
platform devices.

To make my point, here is the structure in intel.h as of v5.13-rc1

struct sdw_intel_link_res {
	struct platform_device *pdev;
	void __iomem *mmio_base; /* not strictly needed, useful for debug */
	void __iomem *registers;
	void __iomem *shim;
	void __iomem *alh;
	int irq;
	const struct sdw_intel_ops *ops;
	struct device *dev;
	struct mutex *shim_lock; /* protect shared registers */
	u32 *shim_mask;
	u32 clock_stop_quirks;
	u32 link_mask;
	struct sdw_cdns *cdns;
	struct list_head list;
};

and here's what we suggested in this patch:

struct sdw_intel_link_res {
	void __iomem *mmio_base; /* not strictly needed, useful for debug */
	void __iomem *registers;
	void __iomem *shim;
	void __iomem *alh;
	int irq;
	const struct sdw_intel_ops *ops;
	struct device *dev;
	struct mutex *shim_lock; /* protect shared registers */
	u32 *shim_mask;
	u32 clock_stop_quirks;
	u32 link_mask;
	struct sdw_cdns *cdns;
	struct list_head list;
};

You will notice that we removed the platform_device *pdev, but embedded 
this structure into a larger one to make use of container_of()

struct sdw_intel_link_dev {
	struct auxiliary_device auxdev;
	struct sdw_intel_link_res link_res;
};

That's it. We did not change anything else, all the other fields are 
identical. We are only changing the TYPE of device and the interfaces 
for probe/remove but using the same information and the same device 
hierarchy.

>> Then both types of information are included in the 'link_dev' extension of
>> the auxiliary device.
>>
>> struct sdw_intel_link_dev {
>> 	struct auxiliary_device auxdev;
>> 	struct sdw_intel_link_res link_res;
>> };
>>
>> That's the basic design of the auxiliary bus, domain-specific data
>> structures are not added inside of the auxiliary_device but are part of an
>> extension accessed with container_of(). That's what everyone using the
>> auxiliary bus is doing.
> 
> I would say resources (as illustrated above) are not domain-specific
> data but a generic stuff which any type of device object should contain

??

>> Vinod, if you can elaborate on what 'resources' refer to in your reply that
>> would help. We've been using the same approach as others relying on the
>> auxiliary bus and I am struggling to see what is wrong with the solution we
>> suggested, or what changes to the auxiliary bus core would be needed. I
>> don't mind doing something different but I just don't understand what the
>> suggestion is.
> 
> I think auxiliary_device needs to look more like a real device rather
> than a simple wrapper as it is now and put heavy onus on implementers.

The consensus for the auxiliary_device model was hard to reach, and the 
agreement was to align on a minimal model. If you disagree with the 
directions, you will have to convince Nvidia/Mellanox and Intel 
networking folks who contributed the solution to do something different.

I also don't see what's heavy, we are not adding new complexity compared 
to the use of the platform devices. It's the same code that implementers 
need to provide, there is no additional cost.

> Device drivers should be simple and boring. The details should be
> handled in bus

The auxiliary bus is minimal on purpose and cannot contain details if it 
used in areas as diverse as networking, SOF clients and SoundWire child 
devices. The 'details' need to be handled as domain-specific extensions.

This patch only suggests a modification from platform devices to 
auxiliary devices. That's it. Iso functionality. No new features or 
concepts. No new fields. No performance/footprint/cost change.

I did not ask to do this work and I don't have have any emotional 
attachment to this work. I was trying to make GregKH happy after he 
mentioned more than 2 years ago that plaform devices should not be used 
when there isn't an ACPI/DT description.

If you don't agree with the directions, we will withdraw this patch and 
stay with the platform devices. There are no negative impacts from a 
performance perspective, but it's not what GregKH wanted. I try to make 
both of you happy, if this doesn't happen then there's no solution, is 
there?
