Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93645F13F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378227AbhKZQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378229AbhKZQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:03:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002FC0613B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:48:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so40357186eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxk5/EIF8zjmKJGiUld8EYOaKSNmv5xOoQi94nd9ZzY=;
        b=Q9sSszRs0oFyB2xZAznmgAqs3ThSsY4pIjl9E7VEz9IaUcbP2hWGqAjnBZhecSS0Sh
         TO0ny6R+nxZLtaaqvapgz4Vx5ZujjagNR7AgDEhqH8tKWHObC++aWCiJm6JCIxLThETi
         nPxpjAQcT/AcolEy3sLNtQIvJJcY4P996oSzq8+VAB/KJ+YY2vRwC2BhgPRHoUMmSYca
         Ta9UWd1XiLGfjILRPHG1JKKWXeD/+Qs2speD+9fwWhJuypMIrBtl0J110ZYTCqiZ3VV+
         AVrM9g2r1aFloTpk/dmeBkab+IA4B5RMEbiH+di0YNgxMHfHeg0KDh/wIIGQPJT5Nq/v
         iG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxk5/EIF8zjmKJGiUld8EYOaKSNmv5xOoQi94nd9ZzY=;
        b=lzVAo+Yiwdex3EYpMFf4vsSwansdziP8+9HebAAXnslpTjJGpUAzD3TVZUAE5ggc80
         L+hgTcUmt0wtFBjJExzlQbmhtPqAlzShcWF/J3ma8Zf4AZxQSDuCLHwlhgmyBxnphcJ7
         wlb1TeRPflVGqxTzfrNFeC0gAtRx72JmeR+OhJrj+XYPoOsLdHLMI/B00+qFdd3QW2b8
         xZfHczaAmnjNLMSkdL3TtCmi6E+rW8Q1iPY+a3I/IwlCvsZHpez1w6n9j+NRLFh6bwW5
         edR/WWLFKzgXMkBWWuqjIMp8GGVxlhwvYdR/Lw2JDWiNd+AQrTSpfMyyRpX0Tb+s2ODZ
         c0xQ==
X-Gm-Message-State: AOAM531GmOEJRdmvnLTSqjAOn782r8GO+Yu+AAILp6M5XLfvFacw39iW
        KDq1XpCUE1SFSQtCwMMYygjNgzxqFOWWNl00PxGRyfNCxlY=
X-Google-Smtp-Source: ABdhPJz3udKIuhAGmPsGt0ayMOxsmWMP8KV94xEXTcLzMfcda/9/cM7/BHlCc6ZusOLaLQfwrYl8WTL/oUnGZ12SnbY=
X-Received: by 2002:a05:6402:5208:: with SMTP id s8mr48343916edd.394.1637941734918;
 Fri, 26 Nov 2021 07:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20211125150730.188487-1-sudeep.holla@arm.com> <20211125182543.GE56473@e120937-lin>
 <CAN5uoS_0crJm+ywd6Jg3NxtzO5gyREp35TTfbvFrpsuUyG6MLw@mail.gmail.com> <20211126142854.3ncyn6vjrn6s4fxr@bogus>
In-Reply-To: <20211126142854.3ncyn6vjrn6s4fxr@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 26 Nov 2021 16:48:43 +0100
Message-ID: <CAN5uoS-u4fMK0KRExbTg441gKmajvAWiBg01TJpEMminV866bA@mail.gmail.com>
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
> --
> Regards,
> Sudeep
