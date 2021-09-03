Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5E40010F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbhICOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349295AbhICOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:11:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E4C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:10:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s12so9862426ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NDS6YJmd/noHrYYtuM8pVUla/Klqh7LYxtrcl5B7ItY=;
        b=QBR2HY/QPe/Vl0J+eQhyqQ/usGN09vHnW7HmWPI2aWxrVEafw6jVIUut+6Lph1YHur
         mCTKHYIuieR6CxnvXgWgemrdgl+9/peFsPEWuWNcZeZ+54rua3xRGDcHPXzELcYkcXmC
         Qm43tRxLZwLQeSnXNXDFzhAZM7wyx2nNyxtKAnqvkO/7LE+wq2l4GjvLMdJ7oWGd1r6m
         B+uSmhJR5fiId2PQgxaYbrkpdOXDPb34GjZj90AyftqnFhUqg+IKc+f3RuCxvXY3hiJi
         evCr3FQBg7suCge/ZcEdX71qRGVvl1OBotAZRpP2GUgUPdOAZ1VmTQ43oWTUXU7b+uYw
         VZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NDS6YJmd/noHrYYtuM8pVUla/Klqh7LYxtrcl5B7ItY=;
        b=PB3GoNwamttq18RxJSZ4RZ1lwgpGnjmJi79VyF/rxKiX+SNGX+NuzF4l23vyvlwmAq
         RYDIbSeBD2av2JNWD+9oeVJcadU44oI9/GCSNxxdDI0DIFZCYP9rQ2X9Pfb1DZ3NyTSw
         WdjxmkDX55gTqqKcNCwJGQM8n5q51miTKvGxLfiRSxXLhJhZ78vGar4ZdHPLoz6EbfJC
         DoG9vYODaH/fZzV9N/wXoaenBMcUFwrI95aN9KEIVd0zAiZCmGE0lrjh/AX7gPVrJgsF
         GSivK0P6r7P3w/1dzJu0ueINxVD9Hq1j+PkcDUJLmBOoWC/iTii5RafV30fm5TVS3b31
         C80g==
X-Gm-Message-State: AOAM5329Vle5y/zwd60ZSt1CZsTzglE/mVLKeDWRA13D8ogapOnpkSZT
        RCD+d1U8Ev7MAVCViyj4IDj+AV7Rlj7yCBM5/ZyjxQ==
X-Google-Smtp-Source: ABdhPJwv/248n9Ft4WU8cznJsZHlnvsHtGB1e7bT+U/yuQFkx9KgXmnFzttHnM+hzuMrwDgOl9zmkhFyAT5IxAWEm/o=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr3027919lji.463.1630678222026;
 Fri, 03 Sep 2021 07:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org> <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com> <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
In-Reply-To: <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Sep 2021 16:09:45 +0200
Message-ID: <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 12:06, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.09.2021 11:55, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Hardware may be preprogrammed to a specific performance state, which =
may
> >>> not be zero initially during boot. This may lead to that genpd's curr=
ent
> >>> performance state becomes inconsistent with the state of the hardware=
. To
> >>> deal with this, the driver for a device that is being attached to its
> >>> genpd, need to request an initial performance state vote, which is
> >>> typically done by calling some of the OPP APIs while probing.
> >>>
> >>> In some cases this would lead to boilerplate code in the drivers. Let=
's
> >>> make it possible to avoid this, by adding a new optional callback to =
genpd
> >>> and invoke it per device during the attach process. In this way, the =
genpd
> >>> provider driver can inform genpd about the initial performance state =
that
> >>> is needed for the device.
> >>>
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> ---
> >>>  drivers/base/power/domain.c | 8 +++++---
> >>>  include/linux/pm_domain.h   | 2 ++
> >>>  2 files changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.=
c
> >>> index 800adf831cae..1a6f3538af8d 100644
> >>> --- a/drivers/base/power/domain.c
> >>> +++ b/drivers/base/power/domain.c
> >>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *=
dev)
> >>>       genpd_queue_power_off_work(pd);
> >>>  }
> >>>
> >>> -static int genpd_get_default_performance_state(struct device *dev,
> >>> +static int genpd_get_default_performance_state(struct generic_pm_dom=
ain *genpd,
> >>> +                                            struct device *dev,
> >>>                                              unsigned int index)
> >>>  {
> >>>       int pstate =3D of_get_required_opp_performance_state(dev->of_no=
de, index);
> >>>
> >>>       if (pstate =3D=3D -ENODEV || pstate =3D=3D -EOPNOTSUPP)
> >>> -             return 0;
> >>> +             pstate =3D genpd->dev_get_performance_state ?
> >>> +                      genpd->dev_get_performance_state(genpd, dev) :=
 0;
> >>>
> >>>       return pstate;
> >>>  }
> >>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device =
*dev, struct device *base_dev,
> >>>       }
> >>>
> >>>       /* Set the default performance state */
> >>> -     pstate =3D genpd_get_default_performance_state(dev, index);
> >>> +     pstate =3D genpd_get_default_performance_state(pd, dev, index);
> >>
> >> If base device is suspended, then its performance state is zero.
> >>
> >> When device will be rpm-resumed, then its performance should be set to
> >> the default state.
> >> You're setting performance state of the wrong device, it should be the
> Are you okay with my variant of handling the suspended device?

Not sure if you intended to post this line?

In any case, I am happy to help and review to move things forward.

>
>
> >> base device and not the virtual domain device.
> >
> > No I am not. :-) Let me elaborate.
> >
> > For the single PM domain case, 'dev' and 'base_dev' are pointing to
> > the same device. So this works fine.
> >
> > For the multiple PM domain case or when attaching goes via
> > genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered in
> > genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becoming
> > attached to genpd and not the 'base_dev'. Note also that, runtime PM
> > has not been enabled for 'dev' yet at this point and 'dev' has been
> > assigned the same OF node as 'base_dev", to allow OF parsing to work
> > as is for it.
> >
> > Moreover, to deal with runtime PM in the multiple PM domain case, the
> > consumer driver should create a device link. Along the lines of this:
> > device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
> > DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
> > supplier for its consumer device ('base_dev').
> >
> >>
> >> These all is handled properly by my patch [1]. Hence it's complicated
> >> for the reason.
> >
> > See above. It shouldn't have to be complicated. If it still is, there
> > is something to fix for the multiple PM domain case.
> >> [1]
> Alright, it actually works now on Tegra using the dev in the callback
> for the case of multiple domains, I re-checked it. Previously, when I
> tried that, there was a conflict in regards to OPP usage, I don't
> remember details anymore. Maybe the recent changes that were suggested
> by Viresh helped with that. So yes, there is no need to pass the base
> device anymore.

Great! So, it seems like $subject patch should be a way forward for you the=
n?

BTW, I forgot to add your Suggested-by: tag for the patch, you
certainly deserve at least that. Or perhaps you are fine with
co-developed by tag?

Kind regards
Uffe
