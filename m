Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66553FFC74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbhICI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbhICI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:57:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E34C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:56:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s3so8479414ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mvq8U6y/pu3nW+n6GX86moOVAEJ1Ykf9BPxJyUnZWYE=;
        b=kIyPuQTR5iIFIGJ6vSVLz/xctn6SLPW/bAMTMQPQ6eIItWEJ2vGql2TCCdkkcVDA3+
         5nwgzo6KAsF95m8mJy+sdAm1PLDOjJR8R+emqLaTha5uxBjrBCNUzIlSqu5YcsMCDSL2
         Dhgida5IgaPX6kvoydyuvtQh1B89REDTEe3Svp+/U6i9KjOuIpVusP44QbOGjHrEedwd
         1gGiZWI02OJPZz+R6nwxmHGIdRkfcsf8wmx8DylPPgOqMhocTDeqn8ScQQrR8/5ckfW+
         kL8yC1xolfGUtySd7EJKulstMB4RLb6Ekybmr1Yz/mJJbZFtROeldycEyy4tKjGSSaCw
         2ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mvq8U6y/pu3nW+n6GX86moOVAEJ1Ykf9BPxJyUnZWYE=;
        b=hwFbI59jQNsY0vK30mb4ZJ9A3XbyQH3dkOLribK1/YE1vq5mZCQv3BPtMA+j5zvrTn
         cYEsUg40X76yEvgz1pAjYTUcHwQSCkkM0lpGPGcC2A3JaG1qF07cgjG4Gb6RaUvVy+SI
         zyx0sIYR2vbrcwlN2lirabQSZXajnwUezKqKBRkCFRFSWP+5BH4gUaFM80eNiD9cNgmO
         pSSJN51qD9zPOULY0rOwsOjieFeh9vGMXBtfpTcgXnoIXd5502Y5KE7OxpjRdt18r2MA
         4DvgEufqU6/VNXjVxItIW6E0wCAbhju5yaWItcUvvadYiMVrRYU/JGUogUMgbXGC/waA
         0i4w==
X-Gm-Message-State: AOAM531VfUyUpUUJYygoVt66RZ3J9N13e+c4M5EgM4bGZSZHGEWO1L+s
        K3qwmB1TOvNOv8qrugB+DwN06eg71V19gK0yx5yykxkveKhdiA==
X-Google-Smtp-Source: ABdhPJya+YDjtPmVAJl7irytS5sbvq0GD6y/hAdjpHvMPwLBfpphbAtcY9DI9u+o0gqS9fbRojcv+b9g9JzljX+VdKk=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr2109657ljq.341.1630659375777;
 Fri, 03 Sep 2021 01:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org> <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
In-Reply-To: <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Sep 2021 10:55:39 +0200
Message-ID: <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
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

On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hardware may be preprogrammed to a specific performance state, which ma=
y
> > not be zero initially during boot. This may lead to that genpd's curren=
t
> > performance state becomes inconsistent with the state of the hardware. =
To
> > deal with this, the driver for a device that is being attached to its
> > genpd, need to request an initial performance state vote, which is
> > typically done by calling some of the OPP APIs while probing.
> >
> > In some cases this would lead to boilerplate code in the drivers. Let's
> > make it possible to avoid this, by adding a new optional callback to ge=
npd
> > and invoke it per device during the attach process. In this way, the ge=
npd
> > provider driver can inform genpd about the initial performance state th=
at
> > is needed for the device.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 8 +++++---
> >  include/linux/pm_domain.h   | 2 ++
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 800adf831cae..1a6f3538af8d 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *de=
v)
> >       genpd_queue_power_off_work(pd);
> >  }
> >
> > -static int genpd_get_default_performance_state(struct device *dev,
> > +static int genpd_get_default_performance_state(struct generic_pm_domai=
n *genpd,
> > +                                            struct device *dev,
> >                                              unsigned int index)
> >  {
> >       int pstate =3D of_get_required_opp_performance_state(dev->of_node=
, index);
> >
> >       if (pstate =3D=3D -ENODEV || pstate =3D=3D -EOPNOTSUPP)
> > -             return 0;
> > +             pstate =3D genpd->dev_get_performance_state ?
> > +                      genpd->dev_get_performance_state(genpd, dev) : 0=
;
> >
> >       return pstate;
> >  }
> > @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *d=
ev, struct device *base_dev,
> >       }
> >
> >       /* Set the default performance state */
> > -     pstate =3D genpd_get_default_performance_state(dev, index);
> > +     pstate =3D genpd_get_default_performance_state(pd, dev, index);
>
> If base device is suspended, then its performance state is zero.
>
> When device will be rpm-resumed, then its performance should be set to
> the default state.
>
> You're setting performance state of the wrong device, it should be the
> base device and not the virtual domain device.

No I am not. :-) Let me elaborate.

For the single PM domain case, 'dev' and 'base_dev' are pointing to
the same device. So this works fine.

For the multiple PM domain case or when attaching goes via
genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered in
genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becoming
attached to genpd and not the 'base_dev'. Note also that, runtime PM
has not been enabled for 'dev' yet at this point and 'dev' has been
assigned the same OF node as 'base_dev", to allow OF parsing to work
as is for it.

Moreover, to deal with runtime PM in the multiple PM domain case, the
consumer driver should create a device link. Along the lines of this:
device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
supplier for its consumer device ('base_dev').

>
> These all is handled properly by my patch [1]. Hence it's complicated
> for the reason.

See above. It shouldn't have to be complicated. If it still is, there
is something to fix for the multiple PM domain case.

>
> [1]
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20210831135450.260=
70-5-digetx@gmail.com/

Kind regards
Uffe
