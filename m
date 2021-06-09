Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8D3A0BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhFIEsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhFIEsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:48:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 808B861351;
        Wed,  9 Jun 2021 04:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623213971;
        bh=AfXFtUXK4/KXMlXeRvkr2cFlV9MsCNjQaBiM0vboF/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cv23PnqznimKI6sizyWVJ4XmjlQ9gA0vMRo06je2fuszB/lBLWJP8rbTrhwQZ6wPw
         lo62WmqyjC6w/3TJbM69vdzT3AZcjKj6NeOFx8PLqE9fxZRGH5p/Uy1ZZf4iwLjo6z
         7jI7fq5OF3A6zdniOXb2mFcalFhbTZlv25d2zSVwzEloKEH9YX8OLd/voRiLj/uwI3
         dtByq/xhdYf2KXJOAfg+m9vNycpwNTXKsYyhbmMh8/mdpCeyGLBEZTYBNhKN7FdKWq
         a8FHvhL4A6U66mtt12nKTJCMlPVPDj4on5eaxEJmFaMRWLpC4oHvidghlaYKtrWyHp
         CVEG6k+Fn6wow==
Date:   Wed, 9 Jun 2021 10:16:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMBHj6PBzeHexXJb@vkoul-mobl>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

You might want to check your setting, this and some other mail (not all
though) sent by you seem to have landed up in my spam folder, dont know
why gmail is doing that...

On 01-06-21, 08:56, Pierre-Louis Bossart wrote:
> 
> > > b) Vinod commented:
> > > 
> > > "What I would like to see the end result is that sdw driver for Intel
> > > controller here is a simple auxdev device and no additional custom setup
> > > layer required... which implies that this handling should be moved into
> > > auxdev or Intel code setting up auxdev..."
> > > 
> > > I was unable to figure out what this comment hinted at: the auxbus is
> > > already handled in the intel_init.c and intel.c files and the auxbus is used
> > > to model a set of links/managers below the PCI device, not the controller
> > > itself. There is also no such thing as a simple auxdev device used in the
> > > kernel today, the base layer is meant to be extended with domain-specific
> > > structures. There is really no point in creating a simple auxbus device
> > > without extensions.
> > 
> > <back from vacations>
> 
> same here :-)
> 
> > I would like to see that the init_init.c removed completely, that is my
> > ask here
> > 
> > This layer was created by me to aid in creating the platform devices.
> > Also the mistake was not to use platform resources and instead pass a
> > custom structure for resources (device iomem address, irq etc)
> 
> We are 100% aligned on the ask to remove intel_init.c, this layer is
> unnecessary and adds more work for developers/maintainers. We will move all
> this in the SOF driver.
> 
> > I would like to see is the PCI/SOF parent driver create the sdw aux
> > device and that should be all needed to be done. The aux device would be
> > probed by sdw driver. No custom resource structs for resources please.
> I was following the previous paragraph but got stuck on the last sentence
> 'no custom structs for resources', see below.
> 
> > If that is not possible, I would like to understand technical details of
> > why that would be that case. If required necessary changes should be
> > made to aux bus to handle and not have sequencing issue which you had
> > trouble with platform approach.
> 
> I don't know what you are referring to with the 'sequencing issue which you
> had trouble with platform approach'. We never had any technical issues with
> platform devices, the solution works and has been productized. We are only
> doing this iso-functionality transition because GregKH asked us to do only
> use platform devices IF there is a real platform device (controlled by
> DT/ACPI).
> 
> I think we are also having language/specification issues here. I don't
> understand what you describe as a 'resource' - there is no interaction with
> firmware - nor how we can avoid being domain-specific for something that is
> Intel-specific.
> 
> Let's go back to the code to help the discussion: the auxiliary driver which
> manages a SoundWire link needs to be provided with a 'custom' structure that
> describes basic information provided by the PCI parent (link masks, quirks,
> IO register bases) and contains internal fields needed for the link
> management (mutex, ops, list, etc). This is the structure we use:
> 
> struct sdw_intel_link_res {
> 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
> 	void __iomem *registers;
> 	void __iomem *shim;
> 	void __iomem *alh;

These are resources and any auxiliary_device should add this. That way
while creating you can set up. Hint look at how platform_device sets up
resources

> 	int irq;

irq is a generic field and should be again moved into auxiliary_device

> 	const struct sdw_intel_ops *ops;

This is for callbacks right? Why cant the sdw aux driver call APIs
exported by SOF driver?

> 	struct device *dev;

Why do you need a dev pointer here? Is this parent or something else?

> 	struct mutex *shim_lock; /* protect shared registers */

Okay so you serialize the access to shim across sdw and sof right?
export an api from sof driver and get rid of lock here

> 	u32 *shim_mask;
> 	u32 clock_stop_quirks;
> 	u32 link_mask;
> 	struct sdw_cdns *cdns;
> 	struct list_head list;


these sound as internal data to sdw instance, move into intel
driver instances


> };
> 
> We could if it was desired for architectural clarity split this structure in
> what is provided by the parent and what is used inside of the auxiliary
> driver as an internal context that the parent doesn't touch, but these
> definitions are again Intel-specific.

So rather than think Intel specfic, I would suggest you think in generic
terms. You have a child auxiliary_device (think like PCI etc), add
the generic resources like iomem regions, irq etc and call into SOF
driver. That would make sdw driver look neat and help you get rid of
this bits

> 
> Then both types of information are included in the 'link_dev' extension of
> the auxiliary device.
> 
> struct sdw_intel_link_dev {
> 	struct auxiliary_device auxdev;
> 	struct sdw_intel_link_res link_res;
> };
> 
> That's the basic design of the auxiliary bus, domain-specific data
> structures are not added inside of the auxiliary_device but are part of an
> extension accessed with container_of(). That's what everyone using the
> auxiliary bus is doing.

I would say resources (as illustrated above) are not domain-specific
data but a generic stuff which any type of device object should contain

> Vinod, if you can elaborate on what 'resources' refer to in your reply that
> would help. We've been using the same approach as others relying on the
> auxiliary bus and I am struggling to see what is wrong with the solution we
> suggested, or what changes to the auxiliary bus core would be needed. I
> don't mind doing something different but I just don't understand what the
> suggestion is.

I think auxiliary_device needs to look more like a real device rather
than a simple wrapper as it is now and put heavy onus on implementers.

Device drivers should be simple and boring. The details should be
handled in bus

Thanks
-- 
~Vinod
