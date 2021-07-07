Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76083BE5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhGGJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhGGJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:53:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421FFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:51:17 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id g25so1265437vss.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6rPD/sKa+BkZRpKSHCWvpgW8QJBd+00NmlQ4lq6KSg=;
        b=kzqnU7WHk6p/P3UmOM/PQr73iE9gj82gP8285/A9VnIROK5oKpoCLJHgokWsqHFMVz
         eUw+UgaZnjPHrvwT/a6YM59NfyHdga5x9WpzFhIFDRQpFcX2Q2sYFgJ7tufjc1pQTIfz
         Bb5Zgf+DT7wuWaMfhLLWPC0QzSm+d2lXqfNAGNsid93s7dASUbhDELdnn0tbSvG6SEce
         S9nqb54QFIg7F9/iC6k9uGBqehob0MK4LLsA54TvWUTqtW1B67QI2jkIoP1bQaEG2CW9
         Cs4jcSjUnwEC9+SvuI6zID3Wy8dOs1HwD4Rsm12UX4HJzYjq2jnsfitjgtcaZOwz6m5H
         a/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6rPD/sKa+BkZRpKSHCWvpgW8QJBd+00NmlQ4lq6KSg=;
        b=N77rVdESjc0qzXtjRLE15rfmhdu5GrRSGZ4kN1FJGmsfnW7a/Q13HM8lZR7vNJDXdg
         2apgsRUFw17Q3UFzL60aep5zakeb+fLOHxEXgh2ljPJbh5Qb8XBopK05BqM5U3Q3BEnz
         qnGmBKgBoF/KFwCVD3IoRC8sJegt5sZDwbAtp2rsyX2hanS1flFzmXCcudzeuZNXH6vN
         f3mkKezVh9aO1t4QZ38SeDyAzOp03PZFijlMLT184ltnlZ4Q+lP2FNGg5kib7beVM2Z5
         8t+bAblSKRttfUNYiR/HJZND9nf2Rtxh8L6LpeGP/TjbN/AIsdCgwuYJTv2LveRcp39c
         nOew==
X-Gm-Message-State: AOAM531km3kBzLIV6rFH/IZ8oSV4A7plgBtXQnVWlZgvRHBVwI+tWfl1
        3Otwwj3WeUHGpSw8pOqiRM54Zi2IyrG3DAV9kFBjhQ==
X-Google-Smtp-Source: ABdhPJwPFlR6dgKqBISKWw8LuP+qPeUsGU+jC8mgHMHtrVgx9xq/axSVW0Pu8ekumW4g/McKQoAA2vDgSemkEKsEtWk=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr19710907vsp.55.1625651476443;
 Wed, 07 Jul 2021 02:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210706100519.13851-1-peng.fan@oss.nxp.com> <CAPDyKFo-r0b1+wwoAyi8VRQpeAbXaxnDeFXGrjZV-zaqWZ7ojQ@mail.gmail.com>
 <DB6PR0402MB2760C8EBCF384C19789BBBC5881B9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760C8EBCF384C19789BBBC5881B9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Jul 2021 11:50:39 +0200
Message-ID: <CAPDyKFrEbwya+nHZBhTsoPSrHaebibQEuPuSL_oPKjtXcbVbhg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: not update genpd status when power on fail
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 at 11:52, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> Hi Ulf,
>
> > Subject: Re: [PATCH] PM: domains: not update genpd status when power on
> > fail
> >
> > On Tue, 6 Jul 2021 at 11:31, <peng.fan@oss.nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > When _genpd_power_on fail, the generic power domain status should not
> > > be changed to GENPD_STATE_ON.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/base/power/domain.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index ab0b740cc0f1..754a5d384479 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1101,6 +1101,7 @@ static void genpd_sync_power_on(struct
> > generic_pm_domain *genpd, bool use_lock,
> > >                                 unsigned int depth)  {
> > >         struct gpd_link *link;
> > > +       int ret;
> > >
> > >         if (genpd_status_on(genpd))
> > >                 return;
> > > @@ -1117,8 +1118,9 @@ static void genpd_sync_power_on(struct
> > generic_pm_domain *genpd, bool use_lock,
> > >                         genpd_unlock(link->parent);
> > >         }
> > >
> > > -       _genpd_power_on(genpd, false);
> > > -       genpd->status = GENPD_STATE_ON;
> > > +       ret = _genpd_power_on(genpd, false);
> > > +       if (!ret)
> >
> > To support this error path, a lot more code needs to be added. Just
> > have a look at the callers of genpd_sync_power_on() and compare it
> > with genpd_power_on().
> >
> > In my opinion, supporting this error path isn't really worth it, at
> > least until someone comes with a valid use case. Do you have one - or
> > did you send the $subject patch based solely on code inspection?
>
> This is two patchset:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210629072941.7980-1-peng.fan@oss.nxp.com/
>
> I collected in github with a few fixes:
> https://github.com/MrVan/linux/tree/linux-next-master-628-blk-ctl-test

I looked at some of the changes there - and I especially don't quite
understand why you enable runtime PM for the genpd->dev. That looks
wrong to me. I am referring to:
"soc: imx: blk-ctl: fix to v8 patchset".

>
>
> In my test, when suspend/resume, I see
> pgc_vpu_h1/g1/g2 has status on, but actually they are not on in hardware.

That sounds like a bug somewhere. Did genpd fail to power off the PM
domain or what happened, more exactly?

> Because vpumix_blk_ctl bus domain is not on, pgc_vpu_h1/g1/g2 runtime
> power off will fail.

What is pgc_vpu_h1/g1/g2?

I am happy to help/guide you forward, but it sounds a bit that more
in-depth debugging is needed at your side. At least I need some stack
trace or kernel logs with debug messages enabled.

[...]

Kind regards
Uffe
