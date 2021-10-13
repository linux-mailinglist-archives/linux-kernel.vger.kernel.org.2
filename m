Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F742BFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhJMM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhJMM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:28:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68037C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:26:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e12so7801104wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYtAK9JsU8NvsfUzIORFj1zJZ80/FDtM2MJGuqYB5Gs=;
        b=husI3LlK08X5sKhBbabI5pB4IpPI+u7fc1CKTqglmgCM4ZVgvL3Kz74/kgOmH7pl97
         F1ex9/w0+MtoIyhBMLK5syu7pz2OqPjqT9/mYWQJJyZbCvTB9fwY2fVWDoaQJvUfH7Yg
         dNtOYdE/7dwoJ9EHvRlfGZKiyjXso40rtlhJtJYHSLNC4lFuhdUJZhK3vZLF4elFQUss
         P25udwEIqPpLP/l5DHcmfLJQYtmx6QnX/FHFqxPA6cRXm9iERHV8OsET7IuqiBUV/jRt
         qlD31/3ysKuvN1+LBW7/EblGsFMYNDR6TLSVHHHnKCgV4ZczCRwvMDg/vV2C6UdYjqdY
         h0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYtAK9JsU8NvsfUzIORFj1zJZ80/FDtM2MJGuqYB5Gs=;
        b=nWLwq7/B5u6AugGAtxmW9JsKj4mnR5RDkahno/oZ4Yo5qtghfLCvB1sBmtY55RPddh
         IN5ElympiOouv66S2j/k1Cb0Z4eTXLeWtxvy1j+b2uKFWHCzVR4hOrcKLTO+i43LuuML
         FlRr9nMlM9xhT/IwY0iF9k6FCr//KENYnxxQBRoSkckokAM/NzKSexAAhYlvdeBQ0R8o
         rIYh5A9ChwApsmtg1ThHgLCh9S9oVPZE+Ni4MFIb7Xtxz9+yg9kWIuahCpiCxnhIK+WL
         MqhbUX2aSqJ35BuN6hvmPnfjrLRzoimowqrkxZpHVOtO4su2s3ZqmugWyNywuNdceVvf
         9BzA==
X-Gm-Message-State: AOAM530Pg5nNaE707JYLhHrvQzQSWDqITZh7vnAZVhmupHS1F1wV8XoM
        xj8+1oRSMYKjQ7b4KxrM0X/bu/CY2rM8VFrkGAkTXg==
X-Google-Smtp-Source: ABdhPJy5ywX7TM9Mqw9cGWWYTS8Ma5+SQ2Q0j7ikuyatRNUe4IuK6xzO47WwQHlwYNjICAgwGmKehD8gD7KwIdjvSWQ=
X-Received: by 2002:adf:9bce:: with SMTP id e14mr39433777wrc.353.1634128005905;
 Wed, 13 Oct 2021 05:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211012073116.4156054-1-sumit.garg@linaro.org>
 <CAHUa44HW=7GhvWSd7LwG3wc+47bQWHHiFq+qA-8qMnDV1C0yBQ@mail.gmail.com> <CAFA6WYMcKLPj-ZHSBHPeg4TPmzutf-7VTffMyMbv+7ax+uJf1w@mail.gmail.com>
In-Reply-To: <CAFA6WYMcKLPj-ZHSBHPeg4TPmzutf-7VTffMyMbv+7ax+uJf1w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 Oct 2021 14:26:35 +0200
Message-ID: <CAHUa44FO1WWpDEad=+C-OEQa1yLktChFkXgrTz5==NvYD4uTVA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Tue, Oct 12, 2021 at 10:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Tue, 12 Oct 2021 at 13:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Tue, Oct 12, 2021 at 9:31 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > When OP-TEE driver is built as a module, OP-TEE client devices
> > > registered on TEE bus during probe should be unregistered during
> > > optee_remove. So implement optee_unregister_devices() accordingly.
> > >
> > > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> > > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  3 +++
> > >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> > >  drivers/tee/optee/optee_private.h |  1 +
> > >  3 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index ccad3c7c8f6d..3915dc574503 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
> > >  {
> > >         struct optee *optee = platform_get_drvdata(pdev);
> > >
> > > +       /* Unregister OP-TEE specific client devices on TEE bus */
> > > +       optee_unregister_devices();
> > > +
> > >         /*
> > >          * Ask OP-TEE to free all cached shared memory objects to decrease
> > >          * reference counters and also avoid wild pointers in secure world
> > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > > index ec1d24693eba..128a2d2a50a1 100644
> > > --- a/drivers/tee/optee/device.c
> > > +++ b/drivers/tee/optee/device.c
> > > @@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
> > >         return 0;
> > >  }
> > >
> > > +static void optee_release_device(struct device *dev)
> > > +{
> > > +       struct tee_client_device *optee_device = to_tee_client_device(dev);
> > > +
> > > +       kfree(optee_device);
> > > +}
> > > +
> > >  static int optee_register_device(const uuid_t *device_uuid)
> > >  {
> > >         struct tee_client_device *optee_device = NULL;
> > > @@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device_uuid)
> > >                 return -ENOMEM;
> > >
> > >         optee_device->dev.bus = &tee_bus_type;
> > > +       optee_device->dev.release = optee_release_device;
> > >         if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> > >                 kfree(optee_device);
> > >                 return -ENOMEM;
> > > @@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
> > >  {
> > >         return  __optee_enumerate_devices(func);
> > >  }
> > > +
> > > +static int __optee_unregister_device(struct device *dev, void *data)
> > > +{
> > > +       if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))
>
> The issue you described below should be handled by this check as we
> would register TAs with unique name corresponding to each OP-TEE
> driver.
>
> > > +               device_unregister(dev);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void optee_unregister_devices(void)
> > > +{
> > > +       bus_for_each_dev(&tee_bus_type, NULL, NULL,
> > > +                        __optee_unregister_device);
> >
> > I had something like this in mind too, but there's one potential
> > problem with this approach. What if there's more than one OP-TEE
> > driver with TAs here? It seems that we'll remove TAs from other
> > drivers too then.
>
> We should be able to easily differentiate among TAs associated with
> any of multiple OP-TEE drivers based on their unique device name.
>
> >
> > This is not likely to be a problem at upstream for the moment so I
> > might be enough just to keep this in mind if/when the OP-TEE driver is
> > extended in a way that there can be multiple OP-TEEs handled.
> >
>
> Given above comments, I think it should be easily handled.

OK, thanks. The patch looks good and it works when testing it on the
upstream kernel and also with the FF-A patch set.
I'm picking up this now.

Cheers,
Jens
