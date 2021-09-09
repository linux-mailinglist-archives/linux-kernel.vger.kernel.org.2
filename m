Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB683405912
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbhIIOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbhIIOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:32:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF2C143FAF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:30:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l10so3772096lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2N2XAXe41X1Tmhc3wqaraQJwWRPXNKcJHIP8jIhexto=;
        b=UYrqH8JcQm00Cd2FcV/FsVhdwaqA42YUDr7DZ1SBY9wWZQrI0tBG69sjfLF/qbPrXe
         9mTNXqinwtc4Sk61nxqpS4uYKpVQt3bgTlT/YgD/G1DWqBy7nyTZKJuaKLKTD+DJgfmV
         ceqdmBysaEyGMuEqEoF8Upb3ftd0aKhBJQEiHygAf1l729O6bnlphKI0S0XW1QaSR3+Q
         X1Cm/dfG31rCua8lzzNmasydQU7qHviFOf8eOB1qOlvjRO8LFU3xzxSngE46O4zVyoDj
         iAIf2fpBkD6i+5crlmSm0C66kBkUY/hxNwH9tjkAUFKhOa9nVquzgCDd8Z1zlRXKp8Od
         Flmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2N2XAXe41X1Tmhc3wqaraQJwWRPXNKcJHIP8jIhexto=;
        b=hUOZY7uOsYhAiQs6CaaNnOZavmXV+4ivgjVIzF8EPgMTB9BPp97rYDo6VFdrBbxj9X
         2b4HB0GjLMkeYZSdkt4koqOr0V3vmjFBz9Idi0KEj2c2HYtGn6MyTZyUzVbtzwgJOWbG
         frh9eGae5IqdkRpClFo+7nvsSen2FX4tga0HL2SXoyknGZuUYSvizM4q1WwnMCHcSIa4
         GPJxICI8eOhvcwlbpUMt6XiaZv3fHu/m0vdmixS9k7ayPeg74bKkEDbxkHVfVc4D+px4
         RdZvp7iuDxz5Hme0i/TBD3V71a2vHhkb8Zv6B5KW69mqPDVZG8HratWPX6+XDxihzMME
         AxTg==
X-Gm-Message-State: AOAM533Fr6E8pCzLd9k7jqTrYmlObXHOXC/XfZj5kD52sERdbI9l1uss
        m7DVsTMcG7dabQAWi/oGXucDQ7sR0lt6HQRZFHytrw==
X-Google-Smtp-Source: ABdhPJx2afs5kx4tcI/D3lwlm+Gfwu7MUbeDRR+Ij9lNLEoMEn/fi6wSzL5CMCsN03VjQD3PI3mbUBkeJCXbzeENsi0=
X-Received: by 2002:a05:6512:4003:: with SMTP id br3mr2366173lfb.465.1631194233363;
 Thu, 09 Sep 2021 06:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
In-Reply-To: <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 9 Sep 2021 06:30:23 -0700
Message-ID: <CAAYoRsVX76Ey9FHhZXdwKWiMdmf0Oi6SKrP2J=XnNgB92sZW1A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 11:33 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > If HWP has been already been enabled by BIOS, it may be
> > necessary to override some kernel command line parameters.
> > Once it has been enabled it requires a reset to be disabled.
> >
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index bb4549959b11..073bae5d4498 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> >                  */
> >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> >                     intel_pstate_hwp_is_enabled()) {
> > -                       hwp_active++;
> > +                       hwp_active = 1;
> Why this change?

It was just to keep it at 1, but I agree not absolutely needed.

>
> >                         hwp_mode_bdw = id->driver_data;
> >                         intel_pstate.attr = hwp_cpufreq_attrs;
> >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> >
> >  static int __init intel_pstate_setup(char *str)
> >  {
> > +       /*
> > +        * If BIOS is forcing HWP, then parameter
> > +        * overrides might be needed. Only print
> > +        * the message once, and regardless of
> > +        * any overrides.
> > +        */
> > +       if(!hwp_active
> This part of code is from early_param, Is it possible that
> hwp_active is not 0?

Not at this point, in any testing I did.
But I do not know the authoritative answer
to your question.

>
> > && boot_cpu_has(X86_FEATURE_HWP))
> > +               if(intel_pstate_hwp_is_enabled()){
> > +                       pr_info("HWP enabled by BIOS\n");
> > +                       hwp_active = 1;
> > +               }
> >         if (!str)
> >                 return -EINVAL;
> >
> > -       if (!strcmp(str, "disable"))
> > +       if (!strcmp(str, "disable") && !hwp_active)
> >                 no_load = 1;
> > -       else if (!strcmp(str, "active"))
> > +       if (!strcmp(str, "active"))
> >                 default_driver = &intel_pstate;
> > -       else if (!strcmp(str, "passive"))
> > +       if (!strcmp(str, "passive"))
> >                 default_driver = &intel_cpufreq;
>
> Why "else if" changed to "if" ?

Because it doesn't matter anyway and I would
have had to figure out another qualifier.
This way, and given that this executes once per
intel_pstate command line parameter, the code
executes the way it used to, overall.

>
>
> Thanks,
> Srinivas
>
> > -
> > -       if (!strcmp(str, "no_hwp")) {
> > +       if (!strcmp(str, "no_hwp") && !hwp_active) {
> >                 pr_info("HWP disabled\n");
> >                 no_hwp = 1;
> >         }
>
>
