Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D70399EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFCKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCKdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:33:36 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489BC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 03:31:38 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 68so3016624uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4YAiHW3sIm0xCyuBUI1jzK6d0sxHFO4wUbiV3VRZ4A=;
        b=xK15/hQfEJKzTC2hthA8fgFyQnmC9wW5su8CzmaD/uHRBhOu4yI3vLRVB12uwwxPnU
         bjcJkwSiEb+b6RSSBxKypll9G5qCFXaXlN4Mr+WBzoFFRha+4BEO7zQvsPDtrTSNuyn4
         n5d6IIqaANq0z8Ofri6eTjZuTEO06aOudBaAO630ImOylAPqyaE3hmhEKyJD4jEwB/jB
         /YoedgjKJCJdLOskRmITGHi6STVWSDWXameyVT4I5x4Wk6PfLv5xsdFhEFAEjUaSTa8i
         GI6pVghBGYZK1r6ZvAW0M/Bqxc3JTGyG880JHhg5fC7TngvEpgXnMef2AOtL4E7Vkimm
         8WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4YAiHW3sIm0xCyuBUI1jzK6d0sxHFO4wUbiV3VRZ4A=;
        b=WCce3j0Qc395f+I5DPAi6UGz2ziHvyl/aahXBpT3u1dbSaFWUC6GxqbRqXAbr5aSxc
         8E45v0jvF+IQ5JYvl0C7KdhMUGMJb2HS9dIqDQuPsoKQeEo9FFZT6iqjqRPhRrs4TMuG
         4M+R79NQM6GPvQi4KAIMxp1v2Pf6vqoZR8XWkskb1gWKqSuA39AAgeWxzqY7B2UMvXui
         0e/qmVdHmxNdpfsFeUwQrzpX6IEPq25vJbZnnd8GHkfgMi4TyQ5XUJMOe8EsqHb8CuYl
         5A7AflSGjccHA4iSR8/WAMi7q8Jyyix41IuWWhYwiq8vxlw4IzdiB3oX1LCv+48hwlOe
         gu7Q==
X-Gm-Message-State: AOAM533TeZMkLCHoz0tctfY4coC9owi0ra72+BGr0XXBeQ0yOk0mCuIC
        ZbgHkXvt94kWJOn6dvi+H2vWgg0uI7PovzHynLqCbQ==
X-Google-Smtp-Source: ABdhPJxZEt+9slFbzsZTL70Z1t4U0DtUcpB3SGiSe7CGtPhWOnNHZQsy4Ru4msClyFlmOPH2cNbl4IUJo7VHm0ssxWw=
X-Received: by 2002:a05:6122:2219:: with SMTP id bb25mr26212299vkb.6.1622716297975;
 Thu, 03 Jun 2021 03:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org> <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
In-Reply-To: <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 12:31:02 +0200
Message-ID: <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 11:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-06-21, 11:34, Ulf Hansson wrote:
> > A subsystem/driver that need to manage OPPs for its device, should
> > typically drop its vote for the OPP when the device becomes runtime
> > suspended. In this way, the corresponding aggregation of the performance
> > state votes that is managed in genpd for the attached PM domain, may find
> > that the aggregated vote can be decreased. Hence, it may allow genpd to set
> > the lower performance state for the PM domain, thus avoiding to waste
> > energy.
> >
> > To accomplish this, typically a subsystem/driver would need to call
> > dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> > callback, to drop the vote for the OPP. Accordingly, it needs another call
> > to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> > ->runtime_resume() callback.
> >
> > To avoid boilerplate code in subsystems/driver to deal with these things,
> > let's instead manage this internally in genpd.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Rebased.
> >       - A few minor cosmetic changes.
> >       - Deal with the error path in genpd_runtime_resume().
> >
> > ---
> >  drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
> >  include/linux/pm_domain.h   |  1 +
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index ef25a5b18587..e5d97174c254 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -400,6 +400,23 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
> >       return ret;
> >  }
> >
> > +static int genpd_drop_performance_state(struct device *dev)
>
> What about passing the state pointer here? that will simplify the
> callers to just a call.

Not sure I get that. Can you elaborate a bit more?

>
> > +{
> > +     unsigned int prev_state = dev_gpd_data(dev)->performance_state;
> > +
> > +     if (!genpd_set_performance_state(dev, 0))
> > +             return prev_state;
> > +
> > +     return 0;
> > +}
> > +
> > +static void genpd_restore_performance_state(struct device *dev,
> > +                                         unsigned int state)
> > +{
> > +     if (state)
>
> I will skip this check, as we are checking it in
> genpd_set_performance_state() anyway ?

I don't want us to override OPP votes made by the subsystem/driver
level runtime PM callbacks. For example, if the drivers manage this
thing themselves, that should be preserved.

That said, by the check above I want to avoid setting the state to
zero internally by genpd, if the driver level ->runtime_resume()
callback has already restored the state.

>
> > +             genpd_set_performance_state(dev, state);
> > +}
> > +
> >  /**
> >   * dev_pm_genpd_set_performance_state- Set performance state of device's power
> >   * domain.
> > @@ -842,7 +859,8 @@ static int genpd_runtime_suspend(struct device *dev)
> >  {
> >       struct generic_pm_domain *genpd;
> >       bool (*suspend_ok)(struct device *__dev);
> > -     struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> > +     struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> > +     struct gpd_timing_data *td = &gpd_data->td;
> >       bool runtime_pm = pm_runtime_enabled(dev);
> >       ktime_t time_start;
> >       s64 elapsed_ns;
> > @@ -899,6 +917,7 @@ static int genpd_runtime_suspend(struct device *dev)
> >               return 0;
> >
> >       genpd_lock(genpd);
> > +     gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>
> So this will become:
>
>         genpd_drop_performance_state(dev, &gpd_data->rpm_pstate);
>
> and it can have return type of void.

See more above, about the reason why it looks like this. Hopefully
that explains it.

Kind regards
Uffe
