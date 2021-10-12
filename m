Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C31429FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhJLI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbhJLI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:29:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:27:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j5so84672229lfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApYBeTWI44dYIPB+lMACs1RUAes/aAO/lSyjzNwRlVk=;
        b=n0+29KyssdGUj5j2/MOijAI4inJEladscyYTuWVZuvc3jFM1iMQHvg+bo+5iL/2koo
         dpoh/hpFBlGOSK/pbGiyd6Ua9hJDxaVzBrlFnT68h4cF+Z07yngMQaxjsYYvoY00wtyI
         xhojnCmi7gZj5nvsHjDFUEogRtpBAy2DhL2MxMCuuibf4IwAyqH7BBr3Wr4aA1EUIOgZ
         0W1wTOVZoXKZFd60xKNYMrTdZ0hWAQd8DjByQQez8FcGHYB5VQzXIIPcTgdkdDn1W6A6
         bJ5Rjo3/jrTE7Y3IA7rRJbkso+42elodqb2SFtWyVveFrTSCrYlSn/Y9Tx6s02Nz+Z/R
         Gu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApYBeTWI44dYIPB+lMACs1RUAes/aAO/lSyjzNwRlVk=;
        b=yaaM7B4y7dd5lsrdCeeMMnNoM4Bw58tHDyrhUrYhxR6stx6tQ9PnpoBOSZoeNjNdtj
         ZznXdP9zCLlf9kxcdCyzewP7VbTzNtMFw94AM8V2Dt3LxWNNksOQ5NBfQ/+B97D15nDO
         j5ogtL1rRtYJ639Ky34nXgXO4t6k+dThNZ4hSJ8v0elsNCivIQFXfQV030723Qdag8L3
         wOJS2E4uGghzjbEiWaDV98EwBKNxFhgXLs6PS0UdOmdAdfGalbZ8AO3139tQT0uWSWXw
         TSRmCQluq2VCJdGaGqJXraNFQWQ1HK1GZff9Rdzv56n9Cbvk1Eq7nzJpcnnqqC+ABYAd
         tu/g==
X-Gm-Message-State: AOAM530nbO4euGpSn6NPSnKQq+2/jVtVTN3+42UMTxC1s73CMN2+PCqF
        /i0Ze/EUztUwWPRXVNi9QuVI3SuFW0TkV/3f3OBgkA==
X-Google-Smtp-Source: ABdhPJyc5JpKeOk2dvxL5D0VIZGL+TKr/0a4WVwHdy6an55o93p1ds7rrNSXcHsX5UItoS0g2dkZAOpNmEq8Ejd6Lrs=
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr33146156lfv.119.1634027248038;
 Tue, 12 Oct 2021 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211012073116.4156054-1-sumit.garg@linaro.org> <CAHUa44HW=7GhvWSd7LwG3wc+47bQWHHiFq+qA-8qMnDV1C0yBQ@mail.gmail.com>
In-Reply-To: <CAHUa44HW=7GhvWSd7LwG3wc+47bQWHHiFq+qA-8qMnDV1C0yBQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 12 Oct 2021 13:57:16 +0530
Message-ID: <CAFA6WYMcKLPj-ZHSBHPeg4TPmzutf-7VTffMyMbv+7ax+uJf1w@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Tue, 12 Oct 2021 at 13:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Tue, Oct 12, 2021 at 9:31 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > When OP-TEE driver is built as a module, OP-TEE client devices
> > registered on TEE bus during probe should be unregistered during
> > optee_remove. So implement optee_unregister_devices() accordingly.
> >
> > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/core.c          |  3 +++
> >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h |  1 +
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ccad3c7c8f6d..3915dc574503 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
> >  {
> >         struct optee *optee = platform_get_drvdata(pdev);
> >
> > +       /* Unregister OP-TEE specific client devices on TEE bus */
> > +       optee_unregister_devices();
> > +
> >         /*
> >          * Ask OP-TEE to free all cached shared memory objects to decrease
> >          * reference counters and also avoid wild pointers in secure world
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index ec1d24693eba..128a2d2a50a1 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >         return 0;
> >  }
> >
> > +static void optee_release_device(struct device *dev)
> > +{
> > +       struct tee_client_device *optee_device = to_tee_client_device(dev);
> > +
> > +       kfree(optee_device);
> > +}
> > +
> >  static int optee_register_device(const uuid_t *device_uuid)
> >  {
> >         struct tee_client_device *optee_device = NULL;
> > @@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device_uuid)
> >                 return -ENOMEM;
> >
> >         optee_device->dev.bus = &tee_bus_type;
> > +       optee_device->dev.release = optee_release_device;
> >         if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> >                 kfree(optee_device);
> >                 return -ENOMEM;
> > @@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
> >  {
> >         return  __optee_enumerate_devices(func);
> >  }
> > +
> > +static int __optee_unregister_device(struct device *dev, void *data)
> > +{
> > +       if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))

The issue you described below should be handled by this check as we
would register TAs with unique name corresponding to each OP-TEE
driver.

> > +               device_unregister(dev);
> > +
> > +       return 0;
> > +}
> > +
> > +void optee_unregister_devices(void)
> > +{
> > +       bus_for_each_dev(&tee_bus_type, NULL, NULL,
> > +                        __optee_unregister_device);
>
> I had something like this in mind too, but there's one potential
> problem with this approach. What if there's more than one OP-TEE
> driver with TAs here? It seems that we'll remove TAs from other
> drivers too then.

We should be able to easily differentiate among TAs associated with
any of multiple OP-TEE drivers based on their unique device name.

>
> This is not likely to be a problem at upstream for the moment so I
> might be enough just to keep this in mind if/when the OP-TEE driver is
> extended in a way that there can be multiple OP-TEEs handled.
>

Given above comments, I think it should be easily handled.

-Sumit

> Cheers,
> Jens
