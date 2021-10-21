Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7339843628F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJUNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:16:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16403C061243
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:14:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t9so135654lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NePYONMFEU/IgvPjlQq5mGqIVNN8rIJbdyS7zhYq95c=;
        b=tgWJYC2yVG4qF9LXlr5eGTrbMMy4F1WD4CU8HdOfiyJZB5DlV+bjbgOuD0mKh1pvnt
         8xP5R+ni9qLpzFY9RHKlLB6uz39XsLbTRStec8IIz2ZJNrazY6wkXwU7ICu1KOD9AcT0
         RK7FieKGmCL/ohXmPk/mdXdCBC+6m5VA5FXebcmEZuaS88XXh6ZxcIPKIDt1wIobI30D
         40xC1nLvNdY3MA/XxxabYVPd2fJ+QpeUdPKH0h+mG4ywnmbj5lELt7NJu4Foiuh2U/JU
         p9kTxd0JgCumAUAfcDRJWRL8YMj3q2usIP1CQ3dcIzQNTFsvFnO7Huc7TryP/7L1THDJ
         IAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NePYONMFEU/IgvPjlQq5mGqIVNN8rIJbdyS7zhYq95c=;
        b=GrNp8hbw2RR5gXj3bvvmXrtDCAV0+A5fw1SPA76ogoly6v+huj3OVmHedCROZ6ZEDE
         CPgsCRqqr0K2yudjJkkuW/8oI9guUXWpJTlJ1E4YeW8n/AYPJcBff14ZUzN4eeMo0WKM
         PWRMH59BDqDaddxEfSghhH0huD2dI8vWYULjG37RCT0gAVZK+IhaGpu8z22+6tZD9TOE
         nosYjRNP9jQiV7RTA4Pk4tzMDdNvPtdzXm6XJ/uKNMe/rByZwx1hOVCra0+YSx2U80gr
         NsvOm+E/bhfkyGdSqxRsa1OPbbXJ3qF+YSlbgL37I9zGegPx7JXaTNppBCJQS6mMxreG
         nh6Q==
X-Gm-Message-State: AOAM533OdMgYMBl1iLXzRU5ySJgVwRsy9yIb/ISA67mwZYFHUlSzFMT4
        vn5+gr76DtES8mpsdtN2WY/1dNn6rZnwhYDvqtJmwg==
X-Google-Smtp-Source: ABdhPJxBORV8J8KEyiOnhx/gqfL7NxtEDkrax+yFrBNut+8/I6xhTgbzYoa6A1+TwsrJ4AWjU+5cVVqtKKoDKEmTFfs=
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr5795476ljo.463.1634822047405;
 Thu, 21 Oct 2021 06:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus> <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <CAL_Jsq+Xb-MX4dkebARFJ_qHyFUWyPJ1WDZLQkUKA5ALsSHsgg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Xb-MX4dkebARFJ_qHyFUWyPJ1WDZLQkUKA5ALsSHsgg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 15:13:30 +0200
Message-ID: <CAPDyKFosEGWpCEGOEpym_COFNhUr7_Qa=rzst3ObUUqcgdSnqA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 at 14:11, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 4:17 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 14 Oct 2021 at 16:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Oct 14, 2021 at 12:56:46PM +0200, Ulf Hansson wrote:
> > > > On Mon, 17 May 2021 at 18:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> > > > > implementations where untrusted software had direct access to clock and
> > > > > voltage hardware controls. In this attack, the malicious software was able to
> > > > > place the platform into unsafe overclocked or undervolted configurations. Such
> > > > > configurations then enabled the injection of predictable faults to reveal
> > > > > secrets.
> > > > >
> > > > > Many Arm-based systems used to or still use voltage regulator and clock
> > > > > frameworks in the kernel. These frameworks allow callers to independently
> > > > > manipulate frequency and voltage settings. Such implementations can render
> > > > > systems susceptible to this form of attack.
> > > > >
> > > > > Attacks such as CLKSCREW are now being mitigated by not having direct and
> > > > > independent control of clock and voltage in the kernel and moving that
> > > > > control to a trusted entity, such as the SCP firmware or secure world
> > > > > firmware/software which are to perform sanity checking on the requested
> > > > > performance levels, thereby preventing any attempted malicious programming.
> > > > >
> > > > > With the advent of such an abstraction, there is a need to replace the
> > > > > generic clock and regulator bindings used by such devices with a generic
> > > > > performance domains bindings.
> > > > >
> > > > > [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> > > > >
> > > > > Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > >
> > > > Hi Sudeep/Viresh/Rob,
> > > >
> > > > I noticed this binding recently got accepted, so I guess I have missed
> > > > the opportunity to provide you with a few comments.
> > > >
> > >
> > > Sorry for not cc-ing you, wasn't aware of the below mentioned intersection,
> > > so assumed you are not one of the interested parties.
> > >
> > > > In any case, I would like to ask a few questions. In particular, am I
> > > > trying to understand why the power-domains bindings [1] can't be used
> > > > for this?
> > > >
> > >
> > > One reason I can think of is on some platforms, the power domains are
> > > completely controlled by the firmware and not exposed to the OSPM.
> > > This is mostly applicable for CPU devices(Platform co-ordinated PSCI)
> >
> > See below.
> >
> > >
> > > > The power-domains are capable of dealing with "performance" through
> > > > the "operating-points-v2" DT property, which maps to the generic OPP
> > > > bindings [2]. I wonder why that isn't sufficient here? Can you please
> > > > elaborate?
> > > >
> > >
> > > Even if the power domains are exposed to the OSPM, the OPPs can be
> > > firmware enumerated rather than DT. Not sure if it is possible to
> > > represent such systems in the above mentioned bindings. IIUC, the genpd
> > > uses clock and regulator apis to drive the performance, but these
> > > platforms have f/w interface to drive the OPPs(abstracted).
> >
> > Genpd doesn't operate on clock rates or voltage levels. Instead
> > "performance" is just an integer value for genpd. What a performance
> > index means, is genpd provider specific.
> >
> > In other words, it becomes the responsibility for the genpd provider
> > to map a performance state index to an OPP, for example. So far,
> > providers have used the generic OPP DT bindings to do this, but for
> > sure, we don't have to limit ourselves to this. So, if OPP tables can
> > be enumerated by FW, rather than specified in DT, that should
> > certainly be possible to support.
> >
> > BTW, these are genpd provider callbacks, that needs to be implemented
> > to let it control performance. Perhaps that helps to understand
> > things.
> >
> > int (*set_performance_state)(struct generic_pm_domain *genpd, unsigned
> > int state);
> > unsigned int (*opp_to_performance_state)(struct generic_pm_domain
> > *genpd, struct dev_pm_opp *opp);
> >
> > >
> > > I am happy to know if there are ways to support such systems with the
> > > options you have mentioned above.
> >
> > As far as I understand, the "performance domains" DT bindings that
> > $subject patch introduces, allows us to group devices into domains, to
> > let them be "performance controlled" together. Right?
> >
> > Unless I am missing something, it looks like power domains DT bindings
> > already offer this for us. Yes, certainly, the DT doc [1] needs an
> > updated description to better explain this, but other than that we
> > should be fine, don't you think?
>
> 'power domains' in DT is supposed to mean physical power islands in
> the h/w where as genpd can be whatever you want. Are power and
> performance domains always 1:1?

I wouldn't say that "power domains" *must* correspond to physical
power islands. At least, that's not the way the bindings are being
used. For example, if it makes better sense to keep some of the logic
in FW, rather than describing a complete topology in DT, that should
be perfectly fine.

Additionally, I am not suggesting that "performance domains" and
"power domains" must map 1:1. A device can be performance managed
through one domain and power managed by another, that would be
perfectly fine to me.

Kind regards
Uffe
