Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB345F150
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378182AbhKZQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbhKZQJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:09:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC0C0619E3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:55:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so40721416edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVAG8DQJC4rCd7x7ha15htXa16cgtJkAQ8INrwVD83Q=;
        b=qkqSi0FdGs4vbqwidDTaCEDdR9vKFSolH5hQu9bueFpfYxvmshD79L9yNMkJx3Cjvf
         HcqkV2j1pi77DzGGtauv/QXdkruuhLhVwsSGjoRl9D1dsDVDImla2IcHIkGeKDCfnDZ6
         Hr1Qnibwpluqns+wuOAyYT3VQGWMY0GVvv6BGmVtNX0ku41xS5Aj4WU55vVItUhFup81
         OhoYFjmAKNKz3So8EwlMhK96yfHsZkt23NSc8Nr0I9iVHA6JtgYjon/H5YEHxpFCq20C
         XsxBy4hXSms/wSX3W+xDVpVv+7EvOrMRPjfCRPNAfnbt7AoIa6qbMjME54Z3JzZ7Ix1d
         OXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVAG8DQJC4rCd7x7ha15htXa16cgtJkAQ8INrwVD83Q=;
        b=wlOgc/QFi93AyJ7iZ1R5aXSgGwRIsUnU5VtRsVSLZPlp3gl/xJ7kdqxNvYtbUaPSCv
         EMm031Zjo5YjRgFX2PD43u+OQZMAEYzwQv2yeQDGlKf++RW2I1umFqtAouOCBFwmTS5m
         FHzujN3yFHQt9/86gRXZLmbgb39A3BOaIwmv9POmKujRz4JEWAr5S+MYdd0SRyguTvfj
         dUdRKaWIGPEv6z8MD2AGLOD5WeFsSl8BEEjxTw+vUNGS2d0adGxUWNpSWKriqw990LLl
         BZ/bHShutNlylzySp+nuWF+FYlSx0lR4ElEUkVtoDgrwDsN/SixZlX/5/x3KsKguHnVM
         sIJQ==
X-Gm-Message-State: AOAM530wpYssozrucEcbWsrl5G3Ytn0be/sAC8n/9Cztf/ohcAmTMtXV
        ftSEleqTkTQ6PZ+AG7dFgPmRyhFs8+wdif1JPD+Juw==
X-Google-Smtp-Source: ABdhPJyjI5ThaIrGMAKN8amyIf8uYwZbN0o6SrpT2iX8J6fM7IZTU7p1ZPejGnBQVZXOu72ntwv3HEwp5hBf/4vUEC8=
X-Received: by 2002:a17:907:3f04:: with SMTP id hq4mr38634392ejc.202.1637942105957;
 Fri, 26 Nov 2021 07:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20211125150730.188487-1-sudeep.holla@arm.com> <20211125182543.GE56473@e120937-lin>
 <CAN5uoS_0crJm+ywd6Jg3NxtzO5gyREp35TTfbvFrpsuUyG6MLw@mail.gmail.com> <20211126142854.3ncyn6vjrn6s4fxr@bogus>
In-Reply-To: <20211126142854.3ncyn6vjrn6s4fxr@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 26 Nov 2021 16:54:55 +0100
Message-ID: <CAN5uoS8CUa4dqwEXRYb7TRau_MWAMT0C6nmvDV6pOf90j7Y9JQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: optee: Drop the support for the OPTEE
 shared dynamic buffer
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

(sorry, previous mail was empty)

On Fri, 26 Nov 2021 at 15:28, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Nov 26, 2021 at 08:59:45AM +0100, Etienne Carriere wrote:
> > Hello Sudeep,
> >
> > On Thu, 25 Nov 2021 at 19:25, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 03:07:30PM +0000, Sudeep Holla wrote:
> > > > The shared memory buffer allocated by the optee driver is normal cached
> > > > memory and can't be used with IOMEM APIs used in shmem_*.
> > > >
> > > > We currently support only IO memory for shared memory and supporting
> > > > normal cached memory needs more changes and needs to be thought through
> > > > properly. So for now, let us drop the support for this OPTEE shared buffer.
> > > >
> > > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > > Cc: Etienne Carriere <etienne.carriere@linaro.org>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > >
> > > Hi,
> > >
> > >
> > > >  drivers/firmware/arm_scmi/optee.c | 19 +------------------
> > > >  1 file changed, 1 insertion(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > > > index 901737c9f5f8..175b39bcd470 100644
> > > > --- a/drivers/firmware/arm_scmi/optee.c
> > > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > > @@ -282,23 +282,6 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
> > > >       shmem_clear_channel(channel->shmem);
> > > >  }
> > > >
> > > > -static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
> > > > -{
> > > > -     const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
> > > > -
> > > > -     channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
> > > > -     if (IS_ERR(channel->tee_shm)) {
> > > > -             dev_err(channel->cinfo->dev, "shmem allocation failed\n");
> > > > -             return -ENOMEM;
> > > > -     }
> > > > -
> > > > -     channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
> > > > -     memset(channel->shmem, 0, msg_size);
> > > > -     shmem_clear_channel(channel->shmem);
> > > > -
> > > > -     return 0;
> > > > -}
> > > > -
> > > >  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> > > >                             struct scmi_optee_channel *channel)
> > > >  {
> > > > @@ -342,7 +325,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> > > >       if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
> > > >               return setup_static_shmem(dev, cinfo, channel);
> > > >       else
> > > > -             return setup_dynamic_shmem(dev, channel);
> > > > +             return -ENOMEM;
> > > >  }
> > > >
> >
> > I would rather find an alternate way to support tee shared memory.
>
> Sure
>
> > I think OP-TEE could use msg.c format when handling tee memory.
>
> Okay
>
> > Linux and OP-TEE Scmi transport discovery negotiate the channel type and
> > support for msg format could allow OP-TEE to use its shm management.
>
> I am fine with that, just that what we have in for-next/scmi is broken and
> I want to remove the support just because it is buggy and not because I
> disagree with the requirement.
>
> > I will prepare an implementation but if you prefer the current remove
> > support and later introduce back tee shm support, I'm fine.
> >
>
> Sure, we may need to support this in a generic way. I mean in a way, other
> transport can also use them if they need it. I remember someone else had
> asked this in the past.
>
> So yes, I am happy to merge the support for tee shm when that is ready.
> What we have now is buggy and needs to be dropped. Sorry for not identifying
> it early.
>

Fine. Sorry for the burden.
`Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>` for the changes
By the way Yes I tested tee shm setup on read hardware, with tee
cached shared memory. shmem.c uses ioread()/iowrite() that adds some
memory barriers. I don't think it hurts to do so when accessing cached
memory.

br,
etienne


> --
> Regards,
> Sudeep
