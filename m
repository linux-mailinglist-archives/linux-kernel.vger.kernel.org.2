Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7A31554E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhBIRkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhBIRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:39:19 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F17C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:38:39 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a25so23541846ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3orZpWdug0f9quA4oMsfVU6EwcvGm7MwS2NLp2fo9gQ=;
        b=eUkaXfqRN7us0ZhZcYCEEhfhenfdn1VGxrKN73JckOW2poO3D65/tjZqxiOfiHtg2C
         +SuCQnyERHUqGbTjFiu9JyCESrpaaDVwtjiqnMU1XRAzbh58annVQLss/FCk8yz6YcBI
         7iOVdSVPNSgiBxfsGIMG8bS+5vk5pRgOUs+9MpazyZBrraSMhlStxvqfUJ4z9i1a8e8e
         6jqsh0c97crQJtJe10dxVoJVTOlbgtGFfgP1UoHsT9j8V4m+67SuCnggoZvomhV3CQ8F
         SXvhqKfq7f7WZz5sSr7dgmUWPoxZ+r6tAkndnZBYVDeQv8ecCjJTe7Fc2NIwG64J3Amj
         8YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3orZpWdug0f9quA4oMsfVU6EwcvGm7MwS2NLp2fo9gQ=;
        b=SXKfHBL2p8yh5qAfocgmLnA2ttX0sbBN50ueLK2F+gCy4lriBx40x0O/lOjD3tnUHN
         LNYk18sEY3zBsqx1rOvn990LjFalMK1P/qYvEZKlzTN9eb4j6oazKLjpIcn3piUYk5Pv
         97fu0d3uht5hcMLkpeoaDgLTU6XZhTkChsYS8l6R3/YJhlfYQ6cJ20lnwdj7JT+7YlkT
         R3lL2cZWfN820mjgyeipFrhIuzxJuWLOggHuhfaADhxzaDoipAP5t+IzlgPZh39/508j
         QCFI9OCi9wJjMKTufWTO3ZKs8XtH/3vJDIfBZjxvUmAP0JaTLYoLgO/kJoOj8HG2IDy6
         W24g==
X-Gm-Message-State: AOAM532RUQSGA2kUIRaElQmTHQBE6fYBzqSrSS3f7roagnnTXtBv0cMo
        4x2JoIAd0jMgZFiNk9+fqkhX8T3KJdZbfsfhoAALYQ==
X-Google-Smtp-Source: ABdhPJycyF8tAiYcUbN9GviurRxMHXuiIGnuVk7l1MtRoB3WiVy3qZEHNjbawXAojXoKmoti714YY8mSFfpMdjyvT6g=
X-Received: by 2002:a2e:7007:: with SMTP id l7mr7556509ljc.176.1612892317942;
 Tue, 09 Feb 2021 09:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-3-vincent.guittot@linaro.org> <a5083b2f-31b7-f23d-092b-6442c01ef23a@arm.com>
In-Reply-To: <a5083b2f-31b7-f23d-092b-6442c01ef23a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 18:38:26 +0100
Message-ID: <CAKfTPtBCyjt+T33uc-p40fyvY3LU8FkAswifngGxaBFFgdM=Tg@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched/fair: remove unused parameter of update_nohz_stats
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 14:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/02/2021 12:48, Vincent Guittot wrote:
> > idle load balance is the only user of update_nohz_stats and doesn't use
> > force parameter. Remove it
>
> Wasn't the 'force=true' from ilb eclipsing the jiffy resolution rate
> limiting '!time_after(jiffies, rq->last_blocked_load_update_tick)' of
> update_blocked_averages()?
>
> So IMHO this has the (maybe intended) side effect that (formerly forced
> updates) are now rate limited on one jiffy resolution too.

Calls to _nohz_idle_balance were already rate limited by load balance
interval and nohz.next_blocked.
This tick rate limit has been originally added for newidle_balance
case but there were some corner cases for _nohz_idle_balance that
could benefit of this too

>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bfe1e235fe01..60b8c1c68ab9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8352,7 +8352,7 @@ group_type group_classify(unsigned int imbalance_pct,
> >       return group_has_spare;
> >  }
> >
> > -static bool update_nohz_stats(struct rq *rq, bool force)
> > +static bool update_nohz_stats(struct rq *rq)
> >  {
> >  #ifdef CONFIG_NO_HZ_COMMON
> >       unsigned int cpu = rq->cpu;
> > @@ -8363,7 +8363,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> >       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> >               return false;
> >
> > -     if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > +     if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> >               return true;
> >
> >       update_blocked_averages(cpu);
> > @@ -10404,7 +10404,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >
> >               rq = cpu_rq(balance_cpu);
> >
> > -             has_blocked_load |= update_nohz_stats(rq, true);
> > +             has_blocked_load |= update_nohz_stats(rq);
> >
> >               /*
> >                * If time for next balance is due,
> >
>
