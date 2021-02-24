Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0435D32435D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhBXRvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhBXRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:51:29 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD59C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:51:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u4so3426876lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ay8VFNLJCcW6ITuDju9MjR/2sje2OxTEgOlv3Ly0CcY=;
        b=lCyvLtLYbt+QkOD05izVJUyuG3qaryzImuBF5w8wxwfxaPXfsIKKRGde8qTyHvdL0g
         j8BavobCo+X7pkbWEetsWHJiGNxe+DdThV+f+fuTvPB4Igfib8IL5XbMUwlenD3kEGhU
         UlaqYzINKcZgoQSQ7/Tm/PBWIBPGA5zNR6FUoBH9cAcxc5RvKkysTmAbMkBIHraJTNE0
         SD7dkxzGYfzDtoY18ZQ5mY/c8cSNcDV7x7/+B8y5T0MT7O1GQf+OJITAdD/vmbLx2VFV
         GT6DdfdNPrhORxR8Bt4pE1KNW9M4lTYWLU+NvxSKCPV9QpEWdUngNJH2VNLTxH+Enl7Q
         rwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ay8VFNLJCcW6ITuDju9MjR/2sje2OxTEgOlv3Ly0CcY=;
        b=lS2BoyZGBAXkLHBGe6krWHQT9MBG6eQSKYH97lDnc/P+OY7ZuB+Ww04FmyMqDDrOqy
         Ep3fIBDn+auUljwH5KYVW6qiaIb8UJGDxBt62ko33ABvyg0DDBd/r8qlMqwAC7iJ+iW5
         WhCbsYGAE7HolWAVC3du0Bf1LOfSemzOExL6L3pnf6puQwhPKxxe5RkLqeiH2474nF6V
         QE5p5pZMJh55kx20xULM1o3gYh7cP/ikFFt4OpgpoVZi5J5wRygFKyxr4uuaVVdcqMWl
         6+LhGAZH4t0Z+TmEzqlgC6E4UnkXjAn3knb40pr0wutBxrjjWQellL2D+rprwkErg4aU
         2WoA==
X-Gm-Message-State: AOAM531kTvNibBFKWHx+k83NqZL6VB01lwU+4Pet+BmwsrlMHIVlJgOH
        fuM8sbGdvNUaQiNYlLrd9zrg5u38p8+evUbjyzTaQw==
X-Google-Smtp-Source: ABdhPJy/oDif/2CYkfNRG0wRCqg3yMlCLAxKAbMFkjrRxfBnq4X56CS2bYRjGEjenLvCw338bxepFQmX/p7pFH52c6Q=
X-Received: by 2002:a2e:b355:: with SMTP id q21mr20228418lja.209.1614189072658;
 Wed, 24 Feb 2021 09:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
 <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net> <CAKfTPtCwmt9HHDuN7tVhZiy7R3e5XHuExU-PVOb++40fYzu-2Q@mail.gmail.com>
 <YDaPtc47NnB5BGEW@hirez.programming.kicks-ass.net>
In-Reply-To: <YDaPtc47NnB5BGEW@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Feb 2021 18:51:01 +0100
Message-ID: <CAKfTPtAa5wCUbNs4+6sTJmSi8wkoEdbtUyzSGpkA0OuRHB67GA@mail.gmail.com>
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

On Wed, 24 Feb 2021 at 18:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 24, 2021 at 04:57:15PM +0100, Vincent Guittot wrote:
> > On Wed, 24 Feb 2021 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Feb 24, 2021 at 02:30:00PM +0100, Vincent Guittot wrote:
> > > > Joel reported long preempt and irq off sequence in newidle_balance because
> > > > of a large number of CPU cgroups in use and having to be updated. This
> > > > patchset moves the update outside newidle_imblance. This enables to early
> > > > abort during the updates in case of pending irq as an example.
> > > >
> > > > Instead of kicking a normal ILB that will wakes up CPU which is already
> > > > idle, patch 6 triggers the update of statistics in the idle thread of
> > > > the CPU before selecting and entering an idle state.
> > >
> > > I'm confused... update_blocked_averages(), which calls
> > > __update_blocked_fair(), which is the one doing the cgroup iteration
> > > thing, runs with rq->lock held, and thus will have IRQs disabled any
> > > which way around we turn this thing.
> > >
> > > Or is the problem that we called nohz_idle_balance(), which does
> > > update_nohz_stats() -> update_blocked_averages() for evey NOHZ cpu from
> > > newidle balance, such that we get NR_NOHZ_CPUS * NR_CGROUPS IRQ latency?
> > > Which is now reduced to just NR_CGROUPS ?
> >
> > Yes we can now abort between each cpu update
>
> OK, shall I add something like:
>
> This reduces the IRQ latency from O(nr_cgroups * nr_nohz_cpus) to
> O(nr_cgroups).
>
> To the changelog of patch #1 ?

Yes, good point. This will clarify the range of improvement
