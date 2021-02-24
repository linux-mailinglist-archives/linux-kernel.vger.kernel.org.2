Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166133241B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhBXQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbhBXP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:58:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A9C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:57:28 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m11so2098415lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLGrz3/Uw6AbL83VPY2iwaTGYzq9zF3B367Os3PAy3w=;
        b=y3gZXjFVqO69YD3O3IzLnWLvTxVrBEG8ErNbGpMknMp91Jy2GB2yFylvTnkrkxtAUi
         Qr+Rs81ZG2fZp+g6PdkDcWUIdFgu5QrLTUHg0XJhzDUY7uZG3Mk0A7tL5Ubmr+GmsyW6
         ybaZK4zPOgbjNZyDQ31M1ctWJUuiD42yJnVZRy7S4wXaplJ/IzLOS3Ti7o77caiaJjNP
         xtHY/+IQ2McBugh9Rh0iArWSYoLuwCq1h0Gfp9f4NuZmLoANJ2grnDfy+UrmgSh6AaKT
         dLygEyRCmVr6SgkxhtKyP3PJwnNozsD6qqbHGGrnGb6ouBxdWHPlaWzejhCuJi/HcePz
         spAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLGrz3/Uw6AbL83VPY2iwaTGYzq9zF3B367Os3PAy3w=;
        b=MoVqgBV8yeuqvev9EoF9SLZIEQS6P5w7aD8dA2bOPSgJcZs9vFFZzM4QmYADYz3VKd
         bohvrSiEkpbAkJZYNjVaD3zijU4kmMZVX8K4+R1mSr+csEr0UUDSEFhxdoi2bzhvYsLy
         cUIWpcvJxoJuH//IuhH9hBrvyJJsytokyZM85JEtT4l8vT68s1NX/u6zMosVO2qdiAw7
         SNiICd39MWqslcOCeN9N5SGKy6qO+ammgPccECaAtpnMud4yhS5BQVPn6I7wlnK5DFfl
         ONIAqGHGSycGstLLI75j5sSkk5CAbxnX2wx0F8lHZsttRPlXO56Hgd+UiNcdG199P4rp
         melQ==
X-Gm-Message-State: AOAM530AuDLGtxUvx7CsGA6Bh+pP6WyxPWFVXQOd8WXm8aheO/YVOkSM
        ghR3EUDQvHyH71hCMSIsAfdyQ5E1L4wQuOkPYQUopw==
X-Google-Smtp-Source: ABdhPJwjnsoPiGfWw24Y+2yE98FSTaqBd2PCu2i1zXb1PTSJaqtlrOkuI8fKmZFx6aMK2NPe0v8wnThwtnrUz1rjKt4=
X-Received: by 2002:a05:651c:124b:: with SMTP id h11mr1370153ljh.401.1614182247029;
 Wed, 24 Feb 2021 07:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20210224133007.28644-1-vincent.guittot@linaro.org> <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net>
In-Reply-To: <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Feb 2021 16:57:15 +0100
Message-ID: <CAKfTPtCwmt9HHDuN7tVhZiy7R3e5XHuExU-PVOb++40fYzu-2Q@mail.gmail.com>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 24, 2021 at 02:30:00PM +0100, Vincent Guittot wrote:
> > Joel reported long preempt and irq off sequence in newidle_balance because
> > of a large number of CPU cgroups in use and having to be updated. This
> > patchset moves the update outside newidle_imblance. This enables to early
> > abort during the updates in case of pending irq as an example.
> >
> > Instead of kicking a normal ILB that will wakes up CPU which is already
> > idle, patch 6 triggers the update of statistics in the idle thread of
> > the CPU before selecting and entering an idle state.
>
> I'm confused... update_blocked_averages(), which calls
> __update_blocked_fair(), which is the one doing the cgroup iteration
> thing, runs with rq->lock held, and thus will have IRQs disabled any
> which way around we turn this thing.
>
> Or is the problem that we called nohz_idle_balance(), which does
> update_nohz_stats() -> update_blocked_averages() for evey NOHZ cpu from
> newidle balance, such that we get NR_NOHZ_CPUS * NR_CGROUPS IRQ latency?
> Which is now reduced to just NR_CGROUPS ?

Yes we can now abort between each cpu update
