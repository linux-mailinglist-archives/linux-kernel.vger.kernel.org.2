Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA89397659
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhFAPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:18:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:19914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234446AbhFAPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:18:08 -0400
IronPort-SDR: a9Xklkh+LrULaYSbVVsW3UKGOOoYziFjZI3WE5zCSbx4OcNQjZWBDVov937FRO3NRs5riSDqWm
 0zVOBOf+lHiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="289187310"
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="289187310"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 08:16:17 -0700
IronPort-SDR: HfugIjzz+TuveULpkvJ6K4aNtbCekIzdv/A4On58D9IBGY20HdDP3V9jaiD1w8hQFiodMK/YH4
 1RvDqlhIjBUQ==
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="635531307"
Received: from rplucero-mobl2.amr.corp.intel.com (HELO [10.212.39.206]) ([10.212.39.206])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 08:16:16 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
Date:   Tue, 1 Jun 2021 08:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> b) Vinod commented:
>>
>> "What I would like to see the end result is that sdw driver for Intel
>> controller here is a simple auxdev device and no additional custom setup
>> layer required... which implies that this handling should be moved into
>> auxdev or Intel code setting up auxdev..."
>>
>> I was unable to figure out what this comment hinted at: the auxbus is
>> already handled in the intel_init.c and intel.c files and the auxbus is used
>> to model a set of links/managers below the PCI device, not the controller
>> itself. There is also no such thing as a simple auxdev device used in the
>> kernel today, the base layer is meant to be extended with domain-specific
>> structures. There is really no point in creating a simple auxbus device
>> without extensions.
> 
> <back from vacations>

same here :-)

> I would like to see that the init_init.c removed completely, that is my
> ask here
> 
> This layer was created by me to aid in creating the platform devices.
> Also the mistake was not to use platform resources and instead pass a
> custom structure for resources (device iomem address, irq etc)

We are 100% aligned on the ask to remove intel_init.c, this layer is 
unnecessary and adds more work for developers/maintainers. We will move 
all this in the SOF driver.

> I would like to see is the PCI/SOF parent driver create the sdw aux
> device and that should be all needed to be done. The aux device would be
> probed by sdw driver. No custom resource structs for resources please.
I was following the previous paragraph but got stuck on the last 
sentence 'no custom structs for resources', see below.

> If that is not possible, I would like to understand technical details of
> why that would be that case. If required necessary changes should be
> made to aux bus to handle and not have sequencing issue which you had
> trouble with platform approach.

I don't know what you are referring to with the 'sequencing issue which 
you had trouble with platform approach'. We never had any technical 
issues with platform devices, the solution works and has been 
productized. We are only doing this iso-functionality transition because 
GregKH asked us to do only use platform devices IF there is a real 
platform device (controlled by DT/ACPI).

I think we are also having language/specification issues here. I don't 
understand what you describe as a 'resource' - there is no interaction 
with firmware - nor how we can avoid being domain-specific for something 
that is Intel-specific.

Let's go back to the code to help the discussion: the auxiliary driver 
which manages a SoundWire link needs to be provided with a 'custom' 
structure that describes basic information provided by the PCI parent 
(link masks, quirks, IO register bases) and contains internal fields 
needed for the link management (mutex, ops, list, etc). This is the 
structure we use:

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

We could if it was desired for architectural clarity split this 
structure in what is provided by the parent and what is used inside of 
the auxiliary driver as an internal context that the parent doesn't 
touch, but these definitions are again Intel-specific.

Then both types of information are included in the 'link_dev' extension 
of the auxiliary device.

struct sdw_intel_link_dev {
	struct auxiliary_device auxdev;
	struct sdw_intel_link_res link_res;
};

That's the basic design of the auxiliary bus, domain-specific data 
structures are not added inside of the auxiliary_device but are part of 
an extension accessed with container_of(). That's what everyone using 
the auxiliary bus is doing.

Vinod, if you can elaborate on what 'resources' refer to in your reply 
that would help. We've been using the same approach as others relying on 
the auxiliary bus and I am struggling to see what is wrong with the 
solution we suggested, or what changes to the auxiliary bus core would 
be needed. I don't mind doing something different but I just don't 
understand what the suggestion is.

Thanks!
