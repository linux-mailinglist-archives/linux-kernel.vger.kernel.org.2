Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37A445EFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377813AbhKZOeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:34:21 -0500
Received: from foss.arm.com ([217.140.110.172]:34442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353566AbhKZOcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:32:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4870EED1;
        Fri, 26 Nov 2021 06:28:58 -0800 (PST)
Received: from bogus (unknown [10.57.33.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29BA13F66F;
        Fri, 26 Nov 2021 06:28:57 -0800 (PST)
Date:   Fri, 26 Nov 2021 14:28:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: optee: Drop the support for the
 OPTEE shared dynamic buffer
Message-ID: <20211126142854.3ncyn6vjrn6s4fxr@bogus>
References: <20211125150730.188487-1-sudeep.holla@arm.com>
 <20211125182543.GE56473@e120937-lin>
 <CAN5uoS_0crJm+ywd6Jg3NxtzO5gyREp35TTfbvFrpsuUyG6MLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_0crJm+ywd6Jg3NxtzO5gyREp35TTfbvFrpsuUyG6MLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 08:59:45AM +0100, Etienne Carriere wrote:
> Hello Sudeep,
> 
> On Thu, 25 Nov 2021 at 19:25, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 03:07:30PM +0000, Sudeep Holla wrote:
> > > The shared memory buffer allocated by the optee driver is normal cached
> > > memory and can't be used with IOMEM APIs used in shmem_*.
> > >
> > > We currently support only IO memory for shared memory and supporting
> > > normal cached memory needs more changes and needs to be thought through
> > > properly. So for now, let us drop the support for this OPTEE shared buffer.
> > >
> > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> >
> > Hi,
> >
> >
> > >  drivers/firmware/arm_scmi/optee.c | 19 +------------------
> > >  1 file changed, 1 insertion(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > > index 901737c9f5f8..175b39bcd470 100644
> > > --- a/drivers/firmware/arm_scmi/optee.c
> > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > @@ -282,23 +282,6 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
> > >       shmem_clear_channel(channel->shmem);
> > >  }
> > >
> > > -static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
> > > -{
> > > -     const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
> > > -
> > > -     channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
> > > -     if (IS_ERR(channel->tee_shm)) {
> > > -             dev_err(channel->cinfo->dev, "shmem allocation failed\n");
> > > -             return -ENOMEM;
> > > -     }
> > > -
> > > -     channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
> > > -     memset(channel->shmem, 0, msg_size);
> > > -     shmem_clear_channel(channel->shmem);
> > > -
> > > -     return 0;
> > > -}
> > > -
> > >  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> > >                             struct scmi_optee_channel *channel)
> > >  {
> > > @@ -342,7 +325,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> > >       if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
> > >               return setup_static_shmem(dev, cinfo, channel);
> > >       else
> > > -             return setup_dynamic_shmem(dev, channel);
> > > +             return -ENOMEM;
> > >  }
> > >
>
> I would rather find an alternate way to support tee shared memory.

Sure

> I think OP-TEE could use msg.c format when handling tee memory.

Okay

> Linux and OP-TEE Scmi transport discovery negotiate the channel type and
> support for msg format could allow OP-TEE to use its shm management.

I am fine with that, just that what we have in for-next/scmi is broken and
I want to remove the support just because it is buggy and not because I
disagree with the requirement.

> I will prepare an implementation but if you prefer the current remove
> support and later introduce back tee shm support, I'm fine.
>

Sure, we may need to support this in a generic way. I mean in a way, other
transport can also use them if they need it. I remember someone else had
asked this in the past.

So yes, I am happy to merge the support for tee shm when that is ready.
What we have now is buggy and needs to be dropped. Sorry for not identifying
it early.

--
Regards,
Sudeep
