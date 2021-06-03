Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCF39A48D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFCP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhFCP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:29:55 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B2C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:28:11 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f15so3182439vsq.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ns65Mhi2wf9tAfNPWwjzKe4odHUU9dQ6kXHd7I+WvxA=;
        b=LJ9HakICARzX4lf3jPKScGDIzI9RJS4PpOxXsCXsXqq+PjaGdEPF/ONw0Vqi1HIyMF
         I/U6fNvbLaCo/EL4bdWW72dzRyL/5DPezuWwYVRjJGVQBSWBx1eZvWxbZhPE4JsZgLli
         tGGyLX6g4Tf0b6TlYRkYC6k5fVRCervX9bOXImWgA2MvhCDKZvYAp67w+Rm4AH2yxK7L
         qg5+CfxJuTB5AqVVM4wun84JwVzCSNn+OXF5VGn933jJDc4jw79FjY8IMHmUjxbJPJCs
         4/YT8VUihkabdbzLOJzM/QjF6SEnmh6JwqX42jTlmNA3fI0OgI7QwibSCcT+Sz/w2+bo
         FSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns65Mhi2wf9tAfNPWwjzKe4odHUU9dQ6kXHd7I+WvxA=;
        b=GimKtXDaxgVeTOL1G1AbZ8HjvTk8stO9ht+5v9/LfAWQerC2duYZCrKR32tWmDEB+T
         2RDveT6u7YY3JBbzF4JJPJjLMswRMxTR/7y7yIDd5gT48MguwQ6V3yEUe3kG9uq+rb5l
         Recv+v3UO0W+caNF1YM9mvZl0crjS5QEhuwXfJI1xg2iaOoQLG7/bJWBhhcCWcOEwAaZ
         8RFEB7B53JW9d1thtgkNWJ605DhRV36tFurzJ+ZcHAs03oRAykou1nfVIJEkDIp3EKka
         /pM+mCSEOe0iGZwE80m3T7qd/9lM+ICc9qLtUdFr0WWvhlGjsCQyvwaycLctAuCXzJ1+
         ZGiA==
X-Gm-Message-State: AOAM532Vc4Ld9rGH3o7wz8gEy4AlHK9qu2A8Y8au/4bCWmgjRyUxEFPW
        j1vgiPWB3ceKMh5oL9Mo7VTFp5U1A/HN5GJ9FZqj4Q==
X-Google-Smtp-Source: ABdhPJySoaiRR0LkYEntFO25rA5JhuPTrugKjV+stU36B7F2Mhss1YKncr6iytmrFK5BUgI1dYXryhxzOiVvQQLtt0M=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr222885vsg.34.1622734087041;
 Thu, 03 Jun 2021 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org> <YLi5N06Qs+gYHgYg@gerhold.net>
In-Reply-To: <YLi5N06Qs+gYHgYg@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 17:27:30 +0200
Message-ID: <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in subsystem/drivers
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 13:13, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Jun 03, 2021 at 11:34:34AM +0200, Ulf Hansson wrote:
> > Various discussions on LKML have pointed out that many subsystem/drivers for
> > devices that may be attached to a genpd and which manages DVFS/OPP though the
> > genpd performance states, would need very similar updates.
> >
> > More precisely, they would likely have to call dev_pm_opp_set_rate|opp() to
> > drop and restore OPPs (which propagates upwards into performance states votes
> > in genpd), every time their devices should enter/exit a low power state, via
> > their device PM callbacks.
> >
> > Rather than having to add the boilerplate code for these things into the
> > subsystems/drivers, this series implements the logic internally into genpd.
> >
> > Concerns have been raised about this approach, mostly by myself, around that it
> > limits flexibility. On the other hand, it starts to look like more and more
> > people are requesting this to be manged internally in genpd, for good reasons.
> > So, I think it's worth to give this a try.
> >
> > In the long run, if it turns out that the flexibility was indeed needed, we can
> > always deal with that as special cases on top.
> >
>
> Do I understand your patch set correctly that you basically make the
> performance state votes conditional to the "power-on" vote of the device
> (which is automatically toggled during runtime/system PM)?

The series can be considered as a step in that direction, but no, this
series doesn't change that behaviour.

Users of dev_pm_genpd_set_performance_state() are still free to set a
performance state, orthogonally to whether the PM domain is powered on
or off.

>
> If yes, I think that's a good thing. It was always really confusing to me
> that a device can make performance state votes if it doesn't actually
> want the power domain to be powered on.

I share your view, it's a bit confusing.

Just adding the condition internally to genpd to prevent the caller of
dev_pm_genpd_set_performance() from succeeding to set a new state,
unless the genpd is powered on, should be a rather simple thing to
add.

However, to change this, we first need to double check that all the
callers are making sure they have turned on the PM domain (typically
via runtime PM).

>
> What happens if a driver calls dev_pm_genpd_set_performance_state(...)
> while the device is suspended? Will that mess up the performance state
> when the device resumes?

Good question. The idea is:

If genpd in genpd_runtime_suspend() are able to drop an existing vote
for a performance state, it should restore the vote in
genpd_runtime_resume(). This also means, if there is no vote to drop
in genpd_runtime_suspend(), genpd should just leave the vote as is in
genpd_runtime_resume().

When it comes to the system suspend/resume path, being implemented in
patch4, we should probably defer that patch from being merged. It
turned out that we probably need to think more about that approach.

>
> I think this might also go into the direction of my problem with the OPP
> core for CPU DVFS [1] since the OPP core currently does not "power-on"
> the power domains, it just sets a performance state. I got kind of stuck
> with all the complexity of power domains in Linux so I think we never
> solved that.

Hmm, that issue is in a way related.

Although, if I understand correctly, that was rather about at what
layer it makes best sense to activate the device (from runtime PM
point of view). And this was needed due to the fact that the
corresponding genpd provider, requires the PM domain to be power on to
allow changing a performance state for it. Did I get that correct?

>
> Stephan
>
> [1]: https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/

Kind regards
Uffe
