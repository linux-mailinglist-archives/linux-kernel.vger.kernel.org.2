Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB58444EAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhKLQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhKLQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:03:07 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD10C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:00:17 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id a129so24760377yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kuvcAeHiHatjdttFHUMAoTsa12O5exORlDW6m2trc4=;
        b=D/ix/Yv5kixXFeepiKqhxNkpxlIal/LHnHjrc2NPheNkTyh6hv11+Qd8yjAQ7573fQ
         vNXqDlgZkGDOAmwJAbYv5Dg9BvqF0ve6WQ5/DI2BeBFKcmY3seum2s8C1MOHiyUuJdT7
         LsxNetnL5mtiMBP2NTZKudYT+PxhSo61DndErZXQPMEeB1xO3uHSI+Je87jOMzRIcHjG
         PlGH1X+5DZzXxd9dAvpgk5QBxcTcUbId3q30Dsp5C6TtY82CqHGSmkN5jcRvhFgCg73r
         tZVdvMWjSqUuS3NSb/WomX2hQTUiFHRvWej53HNc9ATalCigyvTOV3BOusNldOQNqFpd
         GpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kuvcAeHiHatjdttFHUMAoTsa12O5exORlDW6m2trc4=;
        b=OrH2k3bAIg1xbJIgi0KxtmLCsMbm8xoonG6plE9i5FRwR/qM16+3rPXsdH11HqLUf/
         y7oMy0598XVHzUfNWqlr6ALYb/ovo1DgPhnE2hgkq9CA6tHDMuwV61THkqyIAoQHqfJ9
         D2PFMGjkxSl6PHAMXcr6mW1zQfSE15sn+KvEr5XMFNksngrYWwadum8aSUqzGKLzwomr
         SbC/fPyq5trRd7bhHnEKSAYmvsVHWfcLgKyzyX7IkVwyuS5S4P/qj0XmPjGchuw8/pR6
         nvyB6+kt7w3dE9hT3G2sf5BvGTOytc6pRAGbbAI8KVaXRVi+Cw1fifisrR2xeR41/Qid
         43vg==
X-Gm-Message-State: AOAM531Dz9k+QTh+oIN2PLj7dLi8nuJVszBlVuBMSFXSHjtd9exrywbg
        0O1it7PEp1SC6nPBZlxefPddK1Td5uFfipLFj+PmHw==
X-Google-Smtp-Source: ABdhPJz7rJSGULnlScVuX75SKBEnagj4ivksaL3q7GKG6N2+dfE2KVOwACac6cnWiuoZ1Q3i+gYggiO1VJmyDKvB5TQ=
X-Received: by 2002:a25:dc42:: with SMTP id y63mr16896314ybe.402.1636732815628;
 Fri, 12 Nov 2021 08:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org> <YY56RBQR912S6ScC@hirez.programming.kicks-ass.net>
 <CAKfTPtCGnQc+knLbm=zR-a5T2yEJOZo3CWTJcwHgGdZQ0uYyog@mail.gmail.com> <YY6IZZWuuNN12187@hirez.programming.kicks-ass.net>
In-Reply-To: <YY6IZZWuuNN12187@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Nov 2021 17:00:04 +0100
Message-ID: <CAKfTPtBmGCQKnjP4SBMskBLWXrYKkWRpjrdNpJua6aERa85Z_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 16:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 12, 2021 at 03:47:21PM +0100, Vincent Guittot wrote:
> > On Fri, 12 Nov 2021 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Nov 12, 2021 at 10:58:56AM +0100, Vincent Guittot wrote:
> > > > In case we skip the newly idle LB entirely or we abort it because we are
> > > > going to exceed the avg_idle, we have to make sure to not start an update
> > > > of the blocked load when entering idle
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  kernel/sched/fair.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 13950beb01a2..a162b0ec8963 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -10861,7 +10861,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > > >       int this_cpu = this_rq->cpu;
> > > >       u64 t0, t1, curr_cost = 0;
> > > >       struct sched_domain *sd;
> > > > -     int pulled_task = 0;
> > > > +     int pulled_task = 0, early_stop = 0;
> > > >
> > > >       update_misfit_status(NULL, this_rq);
> > > >
> > > > @@ -10898,8 +10898,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > > >       if (!READ_ONCE(this_rq->rd->overload) ||
> > > >           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> > > >
> > > > -             if (sd)
> > > > +             if (sd) {
> > > >                       update_next_balance(sd, &next_balance);
> > > > +
> > > > +                     /*
> > > > +                      * We skip new idle LB because there is not enough
> > > > +                      * time before next wake up. Make sure that we will
> > > > +                      * not kick NOHZ_NEWILB_KICK
> > > > +                      */
> > > > +                     early_stop = 1;
> > > > +             }
> > > >               rcu_read_unlock();
> > > >
> > > >               goto out;
>
> > > Anyway, does nohz_newidle_balance() want to loose it's ->avg_idle test
> > > with this on?
> >
> > This test still covers cases with short newly idle balance. Being
> > conservative, people never complained that the update of blocked load
> > average of idle CPUs doesn't happen often enough. It's most often the
> > opposite
>
> Well, per commit c5b0a7eefc70 ("sched/fair: Remove
> sysctl_sched_migration_cost condition") combined with the above change,
> we no longer call nohz_newidle_balance() in exactly that condition,
> right?
>
> Or are we worried about that !overload case?

we can do a complete newly idle LB but have this_rq->avg_idle <
sysctl_sched_migration_cost. In this case, the condition will continue
to skip update of other idle CPUs
