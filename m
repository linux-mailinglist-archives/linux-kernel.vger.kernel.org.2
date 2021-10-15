Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE32342ED6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhJOJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbhJOJUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:20:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50118C061753
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:17:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n8so38789970lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLC+HjhvviOBGNXg1rQh6EfG6uU7vueygwlcPXecPI8=;
        b=kQvb5ugQhUs4M3Tj42jrgEz3ieKCsMl6oQ9IJA5CodKTcxAckHP38oFW8Qe2n/VVXa
         bxu/qCFEiOiENW5kyEpjn6MTg7Bu8KbQaHTHQnqLvQ24ZJGGUVtb/xi1lFGM50/xTfaB
         9rkXZY1/vBrrxb8rE1GZ58kaFqZdkb+EbqScLG7jgj0EPwxzJlxI/sIqTAKsFupIAMeI
         b6DyNKJuLQRo51CpRuVxeaGQ2eT8MNV/MESVA9FOBWnVKCZiW+uuhikUD7f+YqxbG3oO
         lqgKYtlaQL+DBeGUUaRZDydlzL4Mv0XfNTsBQkBKZ+PlBvJTaNEvHWjHK0uLyS/9ksQk
         sIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLC+HjhvviOBGNXg1rQh6EfG6uU7vueygwlcPXecPI8=;
        b=KgAcKffspWdneAKKRbygfXp2gMEpcFgbkyIwytHi2DICkLe4SvrN7Gnahb3VjCK/5e
         sMR4NyJ7T9xdX1oZOSj22ywAWvX8Y2536KQck1OGG8YKpaMfUOGDlvLxwAXr7pgQh1g1
         Vd9QgemvKvsnNBXUBgMJA3FyWZhdpwVZ2wf2DdTDbfOn9NWpY6F7Dj3BqoxZoLVYKgAv
         UqGMvdIHaEJ/+O4yvN6UZyotozWIKDUDEze22/PPCNPPaoCV58pOe5H2gCye1MgIvr8/
         7iTbgzf5e8Jjmikcl3pecV+rL6LH8/0rNx9hpxBx5o3fpU/zYAld8sEKJDp/1tbNsIan
         OsPA==
X-Gm-Message-State: AOAM531Kj4f48LnD4vasA3XSc4Cak/4TRx14xQssF8Bb7Tdcl7ohn5SN
        hbknI4E9oMJaWfCRSixxDYKL5hoJd8fcIjkrV9zgNA==
X-Google-Smtp-Source: ABdhPJx+08Y1ljiMYn2qfkB9WndJlxkIzmmTo1z25sleCJELjtbRI9uqR33M/umWp8WjlfrAaIt5UdvDvARgk3oQ++U=
X-Received: by 2002:a05:651c:4c9:: with SMTP id e9mr11602393lji.229.1634289475532;
 Fri, 15 Oct 2021 02:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com> <20211014145555.uoi2hyoonrptrd5m@bogus>
In-Reply-To: <20211014145555.uoi2hyoonrptrd5m@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Oct 2021 11:17:18 +0200
Message-ID: <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 at 16:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 14, 2021 at 12:56:46PM +0200, Ulf Hansson wrote:
> > On Mon, 17 May 2021 at 18:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> > > implementations where untrusted software had direct access to clock and
> > > voltage hardware controls. In this attack, the malicious software was able to
> > > place the platform into unsafe overclocked or undervolted configurations. Such
> > > configurations then enabled the injection of predictable faults to reveal
> > > secrets.
> > >
> > > Many Arm-based systems used to or still use voltage regulator and clock
> > > frameworks in the kernel. These frameworks allow callers to independently
> > > manipulate frequency and voltage settings. Such implementations can render
> > > systems susceptible to this form of attack.
> > >
> > > Attacks such as CLKSCREW are now being mitigated by not having direct and
> > > independent control of clock and voltage in the kernel and moving that
> > > control to a trusted entity, such as the SCP firmware or secure world
> > > firmware/software which are to perform sanity checking on the requested
> > > performance levels, thereby preventing any attempted malicious programming.
> > >
> > > With the advent of such an abstraction, there is a need to replace the
> > > generic clock and regulator bindings used by such devices with a generic
> > > performance domains bindings.
> > >
> > > [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> > >
> > > Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Hi Sudeep/Viresh/Rob,
> >
> > I noticed this binding recently got accepted, so I guess I have missed
> > the opportunity to provide you with a few comments.
> >
>
> Sorry for not cc-ing you, wasn't aware of the below mentioned intersection,
> so assumed you are not one of the interested parties.
>
> > In any case, I would like to ask a few questions. In particular, am I
> > trying to understand why the power-domains bindings [1] can't be used
> > for this?
> >
>
> One reason I can think of is on some platforms, the power domains are
> completely controlled by the firmware and not exposed to the OSPM.
> This is mostly applicable for CPU devices(Platform co-ordinated PSCI)

See below.

>
> > The power-domains are capable of dealing with "performance" through
> > the "operating-points-v2" DT property, which maps to the generic OPP
> > bindings [2]. I wonder why that isn't sufficient here? Can you please
> > elaborate?
> >
>
> Even if the power domains are exposed to the OSPM, the OPPs can be
> firmware enumerated rather than DT. Not sure if it is possible to
> represent such systems in the above mentioned bindings. IIUC, the genpd
> uses clock and regulator apis to drive the performance, but these
> platforms have f/w interface to drive the OPPs(abstracted).

Genpd doesn't operate on clock rates or voltage levels. Instead
"performance" is just an integer value for genpd. What a performance
index means, is genpd provider specific.

In other words, it becomes the responsibility for the genpd provider
to map a performance state index to an OPP, for example. So far,
providers have used the generic OPP DT bindings to do this, but for
sure, we don't have to limit ourselves to this. So, if OPP tables can
be enumerated by FW, rather than specified in DT, that should
certainly be possible to support.

BTW, these are genpd provider callbacks, that needs to be implemented
to let it control performance. Perhaps that helps to understand
things.

int (*set_performance_state)(struct generic_pm_domain *genpd, unsigned
int state);
unsigned int (*opp_to_performance_state)(struct generic_pm_domain
*genpd, struct dev_pm_opp *opp);

>
> I am happy to know if there are ways to support such systems with the
> options you have mentioned above.

As far as I understand, the "performance domains" DT bindings that
$subject patch introduces, allows us to group devices into domains, to
let them be "performance controlled" together. Right?

Unless I am missing something, it looks like power domains DT bindings
already offer this for us. Yes, certainly, the DT doc [1] needs an
updated description to better explain this, but other than that we
should be fine, don't you think?

[1]
Documentation/devicetree/bindings/power/power-domain.yaml

>
> --
> Regards,
> Sudeep

Kind regards
Uffe
