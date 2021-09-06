Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD8401F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhIFRfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbhIFRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:35:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A28C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:34:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s12so12468004ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZB7ptLKThIof5MsfSNoSfl71X/ddabBU4eJpmUp1LMw=;
        b=dtWU61OYshd3Y+OyFkWADvTWnBSQA2Zi2ywgF+75xJEs6qPUJbuyW+R1tYxseKO0We
         GugPP/jtoDGaMm2ncJI3NJyZNQ/Rrmz1nJlaVDhcVQQuWrV1eFvuAWcJ0TvqEbsbOGbd
         /pR0UPQolnoqcawWjNiHJgT5t5vQaTDSf6nfP++PvY4wG/EO6XTXCMJgPFjJvzD0NdsO
         DMdUV3ZdCYx3naKxM9BvAzneJPZ85TaO5cAhFRhFFDoj3MCnZUXsAUiJarx7bNWIZ/ja
         hYsIwfRuVWMAP3JDrLrrYg2D2JMoE34ZAm53ys9GTPxmQFpRXEj8s+zj7ZXWipYh/4hr
         UEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZB7ptLKThIof5MsfSNoSfl71X/ddabBU4eJpmUp1LMw=;
        b=E1FoaTfhqvPF40WlGb/yD+i7h3Um6SGsDCKovEAHQq7iSjuQKVP61xxq3qdkT3i0J7
         JJYOlo8B0oa/ZFZ/EJUAxMIFV+mr0unooSTQqdHsCGsjAs+D1u1SMQvGFpnodxX2B6ci
         zsou+ijTvq+o2PSk9HpfbQSx3ExagJTUQQl8eFbpOD5HDrnBZGy8rCSJE9RdGYwBkxaY
         nIxNws6cbe+j+uROppd2KW8Ega9ABI/a3v3cdtdra4kC6uovF9d/U+V5ofu9MlGlKRKt
         zKNUPmFEbtfZIcNjKBZd2bNClP677obbxCc8sGnVKosJIhSUaMt8sicnDtOJPxboU+JW
         fHKA==
X-Gm-Message-State: AOAM530JGPKHYOUmTcBI9SjUiPbzoszVf177HtoCk/aTNICeG/C4kwxN
        ljOxKqbgCE41FUF+gpDbsbWeqpZT2bIJWHaLAjOpMg==
X-Google-Smtp-Source: ABdhPJyXgpFtHdrPAIt5FCLdMhMDoTzeasiJqDqVPE4jUp7klgLZC2xlDbH7mXNUw8yIZTxY/8Vu3eI0B0yQUIZdeN0=
X-Received: by 2002:a05:651c:102d:: with SMTP id w13mr11588002ljm.229.1630949687405;
 Mon, 06 Sep 2021 10:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com> <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com> <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
 <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com>
In-Reply-To: <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:34:10 +0200
Message-ID: <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
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

On Mon, 6 Sept 2021 at 16:11, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.09.2021 13:24, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 5 Sept 2021 at 10:26, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 03.09.2021 17:03, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> 03.09.2021 11:22, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wr=
ote:
> >>>>>>
> >>>>>> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>> When a device is detached from its genpd, genpd loses track of th=
e device,
> >>>>>>> including its performance state vote that may have been requested=
 for it.
> >>>>>>>
> >>>>>>> Rather than relying on the consumer driver to drop the performanc=
e state
> >>>>>>> vote for its device, let's do it internally in genpd when the dev=
ice is
> >>>>>>> getting detached. In this way, we makes sure that the aggregation=
 of the
> >>>>>>> votes in genpd becomes correct.
> >>>>>>
> >>>>>> This is a dangerous behaviour in a case where performance state
> >>>>>> represents voltage. If hardware is kept active on detachment, say =
it's
> >>>>>> always-on, then it may be a disaster to drop the voltage for the a=
ctive
> >>>>>> hardware.
> >>>>>>
> >>>>>> It's safe to drop performance state only if you assume that there =
is a
> >>>>>> firmware behind kernel which has its own layer of performance mana=
gement
> >>>>>> and it will prevent the disaster by saying 'nope, I'm not doing th=
is'.
> >>>>>>
> >>>>>> The performance state should be persistent for a device and it sho=
uld be
> >>>>>> controlled in a conjunction with runtime PM. If platform wants to =
drop
> >>>>>> performance state to zero on detachment, then this behaviour shoul=
d be
> >>>>>> specific to that platform.
> >>>>>
> >>>>> I understand your concern, but at this point, genpd can't help to f=
ix this.
> >>>>>
> >>>>> Genpd has no information about the device, unless it's attached to =
it.
> >>>>> For now and for these always on HWs, we simply need to make sure th=
e
> >>>>> device stays attached, in one way or the other.
> >>>>
> >>>> This indeed requires to redesign GENPD to make it more coupled with =
a
> >>>> device, but this is not a real problem for any of the current API us=
ers
> >>>> AFAIK. Ideally the state should be persistent to make API more unive=
rsal.
> >>>
> >>> Right. In fact this has been discussed in the past. In principle, the
> >>> idea was to attach to genpd at device registration, rather than at
> >>> driver probe.
> >>>
> >>> Although, this is not very easy to implement - and it seems like the
> >>> churns to do, have not been really worth it. At least so far.
> >>>
> >>>>
> >>>> Since for today we assume that device should be suspended at the tim=
e of
> >>>> the detachment (if the default OPP state isn't used), it may be bett=
er
> >>>> to add a noisy warning message if pstate!=3D0, keeping the state unt=
ouched
> >>>> if it's not zero.
> >>>
> >>> That would just be very silly in my opinion.
> >>>
> >>> When the device is detached (suspended or not), it may cause it's PM
> >>> domain to be powered off - and there is really nothing we can do abou=
t
> >>> that from the genpd point of view.
> >>>
> >>> As stated, the only current short term solution is to avoid detaching
> >>> the device. Anything else, would just be papering of the issue.
> >>
> >> What about to re-evaluate the performance state of the domain after
> >> detachment instead of setting the state to zero?
> >
> > I am not suggesting to set the performance state of the genpd to zero,
> > but to drop a potential vote for a performance state for the *device*
> > that is about to be detached.
>
> By removing the vote of the *device*, you will drop the performance
> state of the genpd. If device is active and it's wrong to drop its
> state, then you may cause the damage.
>
> > Calling genpd_set_performance_state(dev, 0), during detach will have
> > the same effect as triggering a re-evaluation of the performance state
> > for the genpd, but after the detach.
>
> Yes
>
> >> This way PD driver may
> >> take an action on detachment if performance isn't zero, before hardwar=
e
> >> is crashed, for example it may emit a warning.
> >
> > Not sure I got that. Exactly when do you want to emit a warning and
> > for what reason?
> >
> > Do you want to add a check somewhere to see if
> > 'gpd_data->performance_state' is non zero - and then print a warning?
>
> I want to check the 'gpd_data->performance_state' from the detachment
> callback and emit the warning + lock further performance changes in the
> PD driver since it's a error condition.

Alright, so if I understand correctly, you intend to do the check for
the "error condition" of the device in the genpd->detach_dev()
callback?

What exactly do you intend to do beyond this point, if you detect the
"error condition"? Locking further changes of the performance state
seems fragile too, especially if some other device/driver requires the
performance state to be raised. It sounds like you simply need to call
BUG_ON() then?

Also note that a very similar problem exists, *before* the device gets
attached in the first place. More precisely, nothing prevents the
performance state from being set to a non-compatible value for an
always-on HW/device that hasn't been attached yet. So maybe you need
to set the maximum performance state at genpd initializations, then
use the ->sync_state() callback to very that all consumers have been
attached to the genpd provider, before allowing the state to be
changed/lowered?

Kind regards
Uffe
