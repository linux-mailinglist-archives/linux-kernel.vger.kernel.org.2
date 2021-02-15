Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392D531BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBOPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhBOPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:03:06 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB6C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:02:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v5so10604933lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBY4CasDBLFRa3xlpKrGTGWXThXij7fIUvpaK3E3y4s=;
        b=vbqlAG45NScbVqUBuXUA2C2fcYzGONXld7d/KN7XZLtkJx71hU4v9pSrulebj3QQOp
         Bcm0FgtOhnQoNlvLDOzKj2Lm55w9C0/0j2REX0EM7KRB6Sl5fzI6RcfUSAkNLNrw1H/y
         GAStlQNmLRBJBdwrBlzZiZ4H2HR8VTGDtHZVhNuX1EGMkiV8vwe8ziCSikUDCOexjf5u
         isdN8+jRsOUgZlELhCXQJApiQ2fEfH0IVMe1v1pVl1aACZaqFeDC/qSzyLgeYT6bEBLY
         4KiVyMgNwBfvYRqRAmkvH3KwCttI3C150aPWWDzy3B1VTDGC29zEaIr4vSTfeFGePbt9
         lb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBY4CasDBLFRa3xlpKrGTGWXThXij7fIUvpaK3E3y4s=;
        b=gPYNsDe62ijF5zseSdINmD4X2io0M+M6QuvUwDTDmS52FTcW297UMc1oQPUxTR+H6I
         Pvi2CIeKC9RTLE1BZ88JK3Rx7+/89nAaDTXrDzC7Ot8bMBUZ35TAQyEWKAOgTdXQIiEN
         m4QmE8oCUtR5161Ae8NuzG1kmV9XVWb9M+0okyrOG+V9E0BZ3tacFlUq523+MjJj8JnX
         Wov0C71ROTgSsKmIMsbl0NB2pex+a9eb0CiHDBMVVQIy/kfDd7j+Q+aFYs76AcQSPrl4
         EssuBeJ9pqlX00Dx3NF6l00jk3vKxV+6YdS33/6SYUhCCAa1P8yEwhPiDIRFH3AqUk7P
         Km0g==
X-Gm-Message-State: AOAM5310KlTaPbyXiunZI/L+2f/YSbfa1+m21jWBc5NRddpanOZOKcte
        HWSB8fRBFAMhfyK1VdKN9NVmpYgBF8p0UDfHOX201g==
X-Google-Smtp-Source: ABdhPJz9uvp6LftACX44h5xt7tMg7IaAt5J3Yu9FiQW8limxwrKGIm5rT0+U8Kv8zZ2BbDLqOKS69K8pW597Aio1RM4=
X-Received: by 2002:ac2:42d5:: with SMTP id n21mr9258548lfl.154.1613401344019;
 Mon, 15 Feb 2021 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
 <20210212141744.24284-7-vincent.guittot@linaro.org> <jhj5z2xt7oy.mognet@arm.com>
In-Reply-To: <jhj5z2xt7oy.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 Feb 2021 16:02:12 +0100
Message-ID: <CAKfTPtDpTEUdRcgJ3dwvD6Fz3D02E46xNtv9BpfFmkjCV1shyA@mail.gmail.com>
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

On Fri, 12 Feb 2021 at 20:19, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 12/02/21 15:17, Vincent Guittot wrote:
> > Instead of waking up a random and already idle CPU, we can take advantage
> > of this_cpu being about to enter idle to run the ILB and update the
> > blocked load.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c  | 24 +++++++++++++++++++++---
> >  kernel/sched/idle.c  |  6 ++++++
> >  kernel/sched/sched.h |  5 +++++
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5d285d93e433..cd0ea635225e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10453,6 +10453,24 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> >       return true;
> >  }
> >
> > +/*
> > + * Check if we need to run the ILB for updating blocked load before entering
> > + * idle state.
> > + */
> > +void nohz_run_idle_balance(int cpu)
> > +{
> > +     unsigned int flags;
> > +
> > +     flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
> > +
> > +     if (flags && !need_resched()) {
> > +             struct rq *rq = cpu_rq(cpu);
> > +
> > +             rq->nohz_idle_balance = flags;
> > +             nohz_idle_balance(rq, CPU_IDLE);
> > +     }
>
> So this can now run a full fledged nohz_idle_balance() if NOHZ_BALANCE_MASK
> is set.

Yes.
>
> I don't think there is anything inherently wrong with it - the
> nohz_idle_balance() call resulting from the kick_ilb() IPI will just bail
> out due to the flags being cleared here. This wasn't immediately clear to
> me however.

In fact, I forgot to replace the WARN_ON in nohz_csd_func() by a
simple return as reported by kernel test robot / oliver.sang@intel.com

>
> > +}
> > +
