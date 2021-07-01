Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB03B90EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhGALDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhGALDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:03:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD497C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:01:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v139so5550067qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBcqfbQyGbalbM7RTbeF9RMSGdAQoJ1lIsL3jRNxqaI=;
        b=h+bBi1Z+K3JQjRKZxX6GR7cR1+Ci8wd0SWZ/sVkN955M/cPih7hXazxPaYmI34EJrU
         b+2p7b6H7XV28/f9RZ105XArCVNuMIm9875s62cbR9KGprt/YhzsjUcjCBYqsfOjT5WC
         K7WVg3el8iSd0uhPa5eJ3pJ8igFqGS5QEEgMvklTFxvXnDZ7uRmDL1ssNo+Qfm0DqnTG
         q+Q0WfcjZWf/EHic9K3SyUDxKuqdf7Gp02WPsGugxGWBiWnOIlfKhoKjhmPNnV+Lpv3y
         QvSxTJ5JzpLa8IBHdBoKn8WaNgDyWg6mkXEs7Ek/QN/goZ1l7JMweBYa6xMRcqZnGY0i
         z7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBcqfbQyGbalbM7RTbeF9RMSGdAQoJ1lIsL3jRNxqaI=;
        b=g+rLMQl/XeQiP1B+e/UNlg8n4cqlCdL7DjouciPqPtbRfNhYUgspReBk/pK4sancNB
         bCPpjlmRmRddlLggEf7VlCi7FVxeh0+p7FnQUFQlR4/RQJr37kwdVPtpnQTwimyPp/AC
         2xY9ej8LUokTBue44XWxQ4dQja0Y5yarr4W562+rMqwFfy7rJEuZidPXDh03tCloRQKW
         w9oGv8rRLQ1s3Ze1s+H++Mg94/jbSrfKwQMqfH+XZRVBcw347xYpM4TPwmjI+f4Ld2xP
         4jhetnbSLkSl4woLtniWmU2XEXriYPo9jmGg+JebNIsHBOtYW2SCC042p87Ek2zKozv0
         qJbQ==
X-Gm-Message-State: AOAM532iiPS7giy/IXok/JbHoBolEWL2cDCPjiKHsF/5XjzBq0eq9xrI
        AMfkFmnG+tj8S1ea5acnwfjt/5JnzFGpNbCVXlg8fA==
X-Google-Smtp-Source: ABdhPJwZfG7SJQZmBCKuxUMPUO6+aTEmLMIowrCWVGnxTDMN0F6CAJLYmNky5pbY6OVjdNNlwfr/bntCR3K95SWUSN8=
X-Received: by 2002:a05:620a:6d5:: with SMTP id 21mr25370007qky.138.1625137281976;
 Thu, 01 Jul 2021 04:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga> <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
 <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org> <YNs3q0HI1WKrKOXx@yoga> <CAPDyKFqSwPn7wUXB9mayT78hshDFBK+DO7cqbmZRjXNAJDQfZw@mail.gmail.com>
In-Reply-To: <CAPDyKFqSwPn7wUXB9mayT78hshDFBK+DO7cqbmZRjXNAJDQfZw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 1 Jul 2021 14:01:10 +0300
Message-ID: <CAA8EJpoOFyFh8vp4Q5w0DMT7-1MrN930gQiv6dk-Mu05B2dT3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 13:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Jun 2021 at 17:09, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 28 Jun 14:55 CDT 2021, Dmitry Baryshkov wrote:
> >
> > > Hi,
> > >
> > > On 17/06/2021 12:07, Ulf Hansson wrote:
> > > > + Rajendra
> > > >
> > > > On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > [..]
> > > > > But I am unable to find a way for the gdsc driver to get hold of the
> > > > > struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> > > >
> > > > You don't need a handle to the struct generic_pm_domain, to assign a
> > > > parent/child domain. Instead you can use of_genpd_add_subdomain(),
> > > > which takes two "struct of_phandle_args*" corresponding to the
> > > > parent/child device nodes of the genpd providers and then let genpd
> > > > internally do the look up.
> > >
> > [..]
> > >
> > > I think I'd need this function anyway for the gdsc code. During gdsc_init()
> > > we check gdsc status and this requires register access (and thus powering on
> > > the parent domain) before the gdsc is registered itself as a power domain.
> > >
> >
> > But this is a register access in the dispcc block, which is the context
> > that our gdsc_init() operates. So describing that MMCX is the
> > power-domain for dispcc should ensure that the power-domain is enabled.
>
> Right.
>
> As a note, when we assign a child domain to a parent domain, via
> of_genpd_add_subdomain() for example - and the child domain has been
> powered on, this requires the parent domain to be turned on as well.

Most probably we should also teach genpd code to call pm_runtime
functions on respective devices when the genpd is powered on or off.
For now I had to do this manually.

>
> >
> > We do however need to make sure that dispcc doesn't hog its
> > power-domain, and that any register accesses in runtime is done with the
> > parenting power-domain enabled. E.g. the clock framework wraps all
> > operations in pm_runtime_get/put(), but I don't see anything in the
> > gnepd code for this.
> >
> >
> > And for gcc I'm worried that we might have some GDSCs that are parented
> > by CX and some by MX, but I do still think that the register accesses
> > are only related to one of these.
> >
> > But this seems like a continuation of the special case in dispcc, so I
> > think we should be able to focus on getting that right before we attempt
> > the general case (and I don't know if we have a need for this today).
> >
> > Regards,
> > Bjorn
>
> Unfortunately, I didn't understand all the above things.
>
> In any case, please tell me if there is anything else that blocks you
> from moving forward with the power domain conversion? I am happy to
> help.

Patch series was submitted:
https://lore.kernel.org/linux-arm-msm/20210630133149.3204290-1-dmitry.baryshkov@linaro.org/



-- 
With best wishes
Dmitry
