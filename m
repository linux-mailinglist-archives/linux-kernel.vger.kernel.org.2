Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FD3C2412
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhGINRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhGINRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:17:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85779C0613E7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 06:14:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o7so5559186vss.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9EPl92UQBGnDOxNu/QcWkjG83wsiY8R48D3cewHxNs=;
        b=HQVeuxVCbFCeuFQ9/tNfgKAM/LEISUuEzOujUT/HZsUaqI1qlTJqBvEA3W/cUr1SqA
         pwdLQexNv9j7akfJF5t3IxQfzMHPwR6vDUTBA9ARo+vH8/ZEBOcn5pErUdEE91wC/u60
         apGX1nvc8NDZi6VGKJrBGeisFZ6UnheAmzWq30UX3CLx8p1rMdJYvp0gsAwb/lIi94Rp
         zIqSkV/Vumznl2buLT5DOZk6MH5sUc3P7b0rfK7b/sTWy+T9PV5ncij172QvJQ0xUKSY
         2voifIKxnHUx8f7yoPHEqftTUvojwm+C2UAiSLg45PuZKKCsUkp+0B+YBB2cPJZvodDx
         dyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9EPl92UQBGnDOxNu/QcWkjG83wsiY8R48D3cewHxNs=;
        b=jrhjYny63llHXZ3ulSXqMoczwHcgdZMIVzHaOpGLiiiRhMA3NHA7pSqOeifFY4gL6y
         0mTynDpXFmn1SdaZ2yn6N0lMs1YfwliJ6QsDq6gRIKIgQkSGBBalcMtoLRmoeqD2Hyne
         IOGipzR3b4yRYY/7mq/Y2nnXw+hkT5ezha1v8XpN6C27A6QmlQGe2Lm6mDMQ77opWY7m
         MjhGteyUWzO/jZSI0kDHfY/ZyzlvXnGCy07sYfstaAXuKnuiaoPFRBA017HXAcr2XlfQ
         YGAICulQjlaBX4sxy77m73RaCN51lGw0wJ6gcHTdryk57jVANkW7wdkxTMs0MvtkMRLI
         JSrw==
X-Gm-Message-State: AOAM531cIKzd5ZT4PPVULVQM/rzs6e/POazFM8BO0RllDy/d1t/XokCH
        XBLiQzy5uXO5kzgXqJqX/C6eMHwUXhsm8Ay9Uc5Rug==
X-Google-Smtp-Source: ABdhPJwcigtsfgnzIItqj7rb3/YGAchwTPojiX8LXYTXgELezNek7ddbL6H4qNpMK1/jtFUh2b2TtcOKWrS6c3p5o0s=
X-Received: by 2002:a67:8783:: with SMTP id j125mr36033795vsd.42.1625836497789;
 Fri, 09 Jul 2021 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
 <20210709043136.533205-5-dmitry.baryshkov@linaro.org> <CAPDyKFprYK8bSk+rdnDt3xRUR9BRNdyRiBdefO+s7qzOwHf7hg@mail.gmail.com>
 <CAA8EJprrjz=o7Ymt1mNBZASzTeX==1ceRTeKA4f3QrVMcpO6xg@mail.gmail.com>
 <CAPDyKFoLcsYLisEiOF66dDsV+759c5k0PD64uxU11jc5VTdNYQ@mail.gmail.com> <CAA8EJpr2HEm4R+bGrH6DHA_z8bjN69Zam9UUiAeKAr5vsCKr3A@mail.gmail.com>
In-Reply-To: <CAA8EJpr2HEm4R+bGrH6DHA_z8bjN69Zam9UUiAeKAr5vsCKr3A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 15:14:21 +0200
Message-ID: <CAPDyKFr+-qXbi4z4_wzDRaMMLKSKM7zNr55Kt-AOk97mVKM+8A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 4/7] clk: qcom: gdsc: enable optional power
 domain support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 at 14:59, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 9 Jul 2021 at 15:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 9 Jul 2021 at 13:46, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Fri, 9 Jul 2021 at 12:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Fri, 9 Jul 2021 at 06:32, Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On sm8250 dispcc and videocc registers are powered up by the MMCX power
> > > > > domain. Currently we used a regulator to enable this domain on demand,
> > > > > however this has some consequences, as genpd code is not reentrant.
> > > > >
> > > > > Teach Qualcomm clock controller code about setting up power domains and
> > > > > using them for gdsc control.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > > > index 51ed640e527b..9401d01533c8 100644
> > > > > --- a/drivers/clk/qcom/gdsc.c
> > > > > +++ b/drivers/clk/qcom/gdsc.c
> > > > > @@ -427,6 +427,7 @@ int gdsc_register(struct gdsc_desc *desc,
> > > > >                         continue;
> > > > >                 scs[i]->regmap = regmap;
> > > > >                 scs[i]->rcdev = rcdev;
> > > > > +               scs[i]->pd.dev.parent = desc->dev;
> > > > >                 ret = gdsc_init(scs[i]);
> > > > >                 if (ret)
> > > > >                         return ret;
> > > > > @@ -439,6 +440,8 @@ int gdsc_register(struct gdsc_desc *desc,
> > > > >                         continue;
> > > > >                 if (scs[i]->parent)
> > > > >                         pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
> > > > > +               else if (!IS_ERR_OR_NULL(dev->pm_domain))
> > > >
> > > > So dev_pm_domain_attach() (which calls genpd_dev_pm_attach() is being
> > > > called for gdsc platform device from the platform bus', to try to
> > > > attach the device to its corresponding PM domain.
> > > >
> > > > Looking a bit closer to genpd_dev_pm_attach(), I realize that we
> > > > shouldn't really try to attach a device to its PM domain, when its OF
> > > > node (dev->of_node) contains a "#power-domain-cells" specifier. This
> > > > is because it indicates that the device belongs to a genpd provider
> > > > itself. In this case, a "power-domains" specifier tells that it has a
> > > > parent domain.
> > > >
> > > > I will post a patch that fixes this asap.
> > >
> > > I think there is nothing to fix here. The dispcc/videocc drivers
> > > provide clocks in addition to the gdsc power domain. And provided
> > > clocks would definitely benefit from having the dispcc device being
> > > attached to the power domain which governs clock registers (MMCX in
> > > our case). Thus I think it is perfectly valid to have:
> > >
> > > rpmhpd device:
> > >  - provides MMCX domain.
> > >
> > > dispcc device:
> > >  - is attached to the MMCX domain,
> >
> > We don't need this, it's redundant and weird to me.
> >
> > Also I am kind of worried that you will hit another new path in genpd,
> > causing locking issues etc, as it has not been designed to work like
> > this (a provider device and a child domain sharing the same "parent").
>
> So, which domain should the dispcc device belong to? It's registers
> are powered by the MMCX domain. I can not attach it to the child
> (GDSC) domain either: in the case of videocc there are 4 child
> domains.

The dispcc device should *not* be attached to a PM domain.

Instead it should be registered as a genpd provider and the
corresponding PM domains it provides, should be assigned as child
domains to the MMCX domain.

This is exactly what the child/parent domain support in genpd is there
to help with.

> An alternative would be to request that all users of the provided
> clocks power on one of the child domains. However this is also not
> perfect. If some generic code (e.g. clock framework) calls into
> provided clocks (e.g. because of assigned-clock-rates), this can
> happen w/o proper power domain being powered up yet.

Issues with power on/off synchronization during genpd initializations
and genpd provider registration, certainly need to be fixed and I am
happy to help. However, my point is that I think it's a bad idea to
fix it through modelling the PM domain hierarchy in an incorrect way.

[...]

Kind regards
Uffe
