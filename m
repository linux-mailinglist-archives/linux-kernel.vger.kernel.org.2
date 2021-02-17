Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54731DC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBQPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhBQPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:35:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:34:52 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c8so14495212ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0Q0YlYb3SFKWHRSvkx56oEjHKyRItUPKhnGvy/vxRE=;
        b=S0uaTHepPSMTQ27lthS2NsnbY+5uv9wOhj0/Iq1qzRhmMBr8DThMcsDnhMIUqUfiap
         2Vlw+SoReWjaKHBMPxjXDq1SHFwHnsQdClbpRjg4jhNTnuBoAWGtwNcT8h5iRfUmIPHk
         tc9P27RgPzxBAqMieopc/0n4YcJWJScLhQ7BLH9osxaohBsfRWbokGreIYvSqRzIbwG+
         f0Vv7FnnDbv/Pn8Wok1NhsVl6Z1jw4ZXT70YG2uGIhyfKSmyhaZKVdQETOPw0iJRr1Rl
         KMfOjde2no0GFmDknMJjKF+vj4famfi+FvrkZvOnMVmBwmSSQSH4pQmWQt4zDrdieKHB
         /PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0Q0YlYb3SFKWHRSvkx56oEjHKyRItUPKhnGvy/vxRE=;
        b=VKABjdhstJYqFMLhGJzQmemwFyab0CHu8cAmdQ5Xq90uRczYWK+2fxntC7Oo2cd6nL
         JZ8F+l2HEH88aeDc/iKaP3FBlxJ4w3ZJazShLZtkUedBuEgSy9GcmJ1seUAPGf7fQNwu
         ksJVGhKi4FJeKg4pDST4Ad36sXqFvttuUIarGRtxLmLkok38s4iE837Oa/+c+ZYtwK3Z
         fTuDrlsSATBdOBFcXY8xYJJ67kl7G9bFTj52FaNU3p2ycnUquwFqz2H9zrJywaE9zJm8
         RRudm/36tpq5fXBlXMdpo2QkJu464gR9Ntxi0mJXrarvZYlEIvA97XFIWXH8SmRyfMZ0
         +qXg==
X-Gm-Message-State: AOAM530piCCnPk8t/rb3M0L3NquDKTpK98z4nW+Yo1V10CyRrngg/lsl
        tDQSsq5RjBUfeWjtNZBYCnuxgDgIjS4lhJK1ImwAtQ==
X-Google-Smtp-Source: ABdhPJyRUpfI1jLFHHL8LK0eRUEXJdw+G0uwEVndmcJ9w3ZnCQH+pNkqeKGQ6wxC0tmOqIBM7P1ueWlow6x11tLcAuo=
X-Received: by 2002:a2e:a305:: with SMTP id l5mr13746762lje.401.1613576090412;
 Wed, 17 Feb 2021 07:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
 <20210212141744.24284-7-vincent.guittot@linaro.org> <jhj5z2xt7oy.mognet@arm.com>
 <CAKfTPtDpTEUdRcgJ3dwvD6Fz3D02E46xNtv9BpfFmkjCV1shyA@mail.gmail.com> <jhjmtw2syjd.mognet@arm.com>
In-Reply-To: <jhjmtw2syjd.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Feb 2021 16:34:39 +0100
Message-ID: <CAKfTPtARniU+N2yDFcuHyXdr0verHxm4N6vsf06ECrh59XNe1g@mail.gmail.com>
Subject: Re: [PATCH 6/7 v3] sched/fair: trigger the update of blocked load on
 newly idle cpu
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 at 12:51, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 15/02/21 16:02, Vincent Guittot wrote:
> > On Fri, 12 Feb 2021 at 20:19, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> I don't think there is anything inherently wrong with it - the
> >> nohz_idle_balance() call resulting from the kick_ilb() IPI will just bail
> >> out due to the flags being cleared here. This wasn't immediately clear to
> >> me however.
> >
> > In fact, I forgot to replace the WARN_ON in nohz_csd_func() by a
> > simple return as reported by kernel test robot / oliver.sang@intel.com
> >
>
> Can't that actually be a problem? kick_ilb() says:
>
>          * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
>          * the first flag owns it; cleared by nohz_csd_func().
>
> So if you have:
>
>   kick_ilb() -> kicks CPU42
>
> And then said CPU42 goes through, before nohz_csd_func(),:
>
>   do_idle() -> nohz_run_idle_balance()
>
> you could have yet another CPU do:
>
>   kick_ilb() -> kicks CPU42
>
> which would break rq->nohz_csd serialization.

Yeah there are ever further problems and I get some rcu_sched log on
my large server with one benchmark with one specific parameter which I
can't reproduce on my smaller system. Right now, I'm working on making
both exclusive which should be mainly about testing if this_cpu is set
in nohz.idle_cpus_mask

>
> >>
> >> > +}
> >> > +
