Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDF45E8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbhKZIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbhKZIDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:03:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:59:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so35428332edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xI7/7Qmq/8rziraYyi5hfmxS8XBzgKRuj2SZVAFPtY=;
        b=IwOcILYAYW/qN9TXAWOP1gxs0ryKVBNZkY8vHBVcgSJS10If/vrlp5iXr+QXjbr2t6
         kFxcRrW578+lv449f4REJz4oc6fuFGIoYXHlTNiu5v2+po02wpgUU3z74Tnym5ygThrp
         FcGHCteyJHYI+Zio7Qd/sEs9KVIvK/55xpr9OoYrV9fCVrXL38IGPpY8yyKvypNSP47w
         z+gHyfob4TBjWyc3EX7NXgJDL5YaNi6dmUYgHK5CTt69cMhctm9WEtlNU7t7r3+YSNDz
         Wu9uMKC2wGnXuvygA/l/lm8XVkJOlRRFOa+928saOsq0cd6g8CWjZKvxNEv4GgabDvae
         UNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xI7/7Qmq/8rziraYyi5hfmxS8XBzgKRuj2SZVAFPtY=;
        b=dN9SZQor6wvTNx/wAlkkvmG8/Q0MEgAL5dAjAQNTVr5IhTofy8AVWu1uNdkBlyfxOh
         IdqhLXtrTUE7KDc7tWZRStIYtA9DsMRnqiqrxU6kt9CDOmqmYlCsr3QLi6aYob3gn69k
         626X1A4J75ToCgJ5/6G7rhybW4JquvGbcVc5ZfmCg7LYz2fEOFs8Eje/Wq9LxU80387P
         kSMxp75f5CMiMNvWHhyYWQj2K4MBJ3/lPyait+6n9QD3mp4b6MNFcg3wwUIEqFLWrocm
         pWIxGSjqGwhREA3QhyFTU0rSk/PnMO7BP2cThUk4epD/JhNQNmiXLA98HKsEXVXipqCf
         tzHg==
X-Gm-Message-State: AOAM530GmN9SgVQd9v2u78wj9us6NrljICJYNHVgL5UBXI8tNXuY/n6m
        4tBfcHTA0HriCH+2Io7edr8uCm4PiWPMk8qKn3Rx4LicA/8=
X-Google-Smtp-Source: ABdhPJy0dhQqCWLBvB70vV5CG5ap8OQoHh9QoX/SBUn+4JoEA/zikBbSmzrwGhh4+/WLUQ1f0w/tazR2oPOIplZWcOk=
X-Received: by 2002:a17:907:2cc4:: with SMTP id hg4mr37551999ejc.112.1637913595861;
 Thu, 25 Nov 2021 23:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20211125150730.188487-1-sudeep.holla@arm.com> <20211125182543.GE56473@e120937-lin>
In-Reply-To: <20211125182543.GE56473@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 26 Nov 2021 08:59:45 +0100
Message-ID: <CAN5uoS_0crJm+ywd6Jg3NxtzO5gyREp35TTfbvFrpsuUyG6MLw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: optee: Drop the support for the OPTEE
 shared dynamic buffer
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

On Thu, 25 Nov 2021 at 19:25, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:07:30PM +0000, Sudeep Holla wrote:
> > The shared memory buffer allocated by the optee driver is normal cached
> > memory and can't be used with IOMEM APIs used in shmem_*.
> >
> > We currently support only IO memory for shared memory and supporting
> > normal cached memory needs more changes and needs to be thought through
> > properly. So for now, let us drop the support for this OPTEE shared buffer.
> >
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
>
> Hi,
>
>
> >  drivers/firmware/arm_scmi/optee.c | 19 +------------------
> >  1 file changed, 1 insertion(+), 18 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > index 901737c9f5f8..175b39bcd470 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -282,23 +282,6 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
> >       shmem_clear_channel(channel->shmem);
> >  }
> >
> > -static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
> > -{
> > -     const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
> > -
> > -     channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
> > -     if (IS_ERR(channel->tee_shm)) {
> > -             dev_err(channel->cinfo->dev, "shmem allocation failed\n");
> > -             return -ENOMEM;
> > -     }
> > -
> > -     channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
> > -     memset(channel->shmem, 0, msg_size);
> > -     shmem_clear_channel(channel->shmem);
> > -
> > -     return 0;
> > -}
> > -
> >  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> >                             struct scmi_optee_channel *channel)
> >  {
> > @@ -342,7 +325,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> >       if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
> >               return setup_static_shmem(dev, cinfo, channel);
> >       else
> > -             return setup_dynamic_shmem(dev, channel);
> > +             return -ENOMEM;
> >  }
> >

I would rather find an alternate way to support tee shared memory.
I think OP-TEE could use msg.c format when handling tee memory. Linux
and OP-TEE Scmi transport discovery negotiate the channel type and
support for msg format could allow OP-TEE to use its shm management. I
will prepare an implementation but if you prefer the current remove
support and later introduce back tee shm support, I'm fine.

Best regards,
Etienne

>
> LGTM.
>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>
> Thanks,
> Cristian
