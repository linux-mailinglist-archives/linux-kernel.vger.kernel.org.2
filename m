Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA244E928
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhKLOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhKLOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:50:25 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0DC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:47:34 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v64so24260417ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TENmM+b+eVB4P/zDy3UnHYAYthCGpmUgpPD+yn3PYxo=;
        b=O+i3XUXHLL/m8rmepquFi+6eguZx4OkpUQPHVHCmZyUwQhlJaYMJKqxT5Jrvfe2DyL
         Sj0x2M4hfDfrD68DgP2J/V5fEqU12AyJi+ESItEbK9oaljgtKpCywmWdLJjukvSkXGbx
         Zp0iQ0BnF67J3MzTe1FXx8OAxqC9qJ9m7HYjMkind+iEjDAkFuSwUgFjbnfQHUDojSIe
         DWvXnNDycyB0UfoHC43IsnPR3TGapGjNlcb8WSrhlYR5BIORw6MNe9S3GwPBS1M6Rknj
         lvIaS9wnHwoahepz4lyHKEH6Vi2W1TZNWpcPXIQeUVRl3i8Yc2Y9wv4fx1XR6kQW4+PT
         XDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TENmM+b+eVB4P/zDy3UnHYAYthCGpmUgpPD+yn3PYxo=;
        b=4VDfY6UYU2WfWIfoe+v1Mpkvy3ZatnclDdApURPi/s3I7MSR1Ih8JxbTty5KmT5HOC
         oxSqqRv2ugUbn+WLOUkgc38hub6aHeRwdZ00ZB/t30GYJXgYIuACoSsXeaiSg6SFAz7l
         HyKUtZ05I72kyKkG7lB8KnKK+bZac/NlfiP/P0p20gh2SLZb5fLPdlLblSDNZ+1mvsRm
         UxMCCOmn7vNOaAx5FN+Z0lNhEEpwK32SU5MlH1MPZ4cssoGL4lKVMVvHsLBGqUv9K/7p
         P0CDjkToSxOcvIXx2p3fQtZ8JKXWARSYMcVWW5hI87Q+X8xCN0ycaUwOjzeF5QnCKe+t
         y16g==
X-Gm-Message-State: AOAM533zh/yvMBAmMpIxfmtH6b+Lsf4Xv0GKbNcFWM1v37ZZl93trW8p
        L/WI/5P2oHQ2bBzrrA0UKdLr9zPetSqlHXZAz9+dsA==
X-Google-Smtp-Source: ABdhPJyh5TF/DwwKqzgxh8Tkv3gOV8eNhc/bSA1ckZk9WWW2t6NPAlExmeAU4mO3ERQGTCNKQXOcOL+TucuVH7fVCaU=
X-Received: by 2002:a25:2157:: with SMTP id h84mr17857692ybh.425.1636728452458;
 Fri, 12 Nov 2021 06:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org> <YY56RBQR912S6ScC@hirez.programming.kicks-ass.net>
In-Reply-To: <YY56RBQR912S6ScC@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Nov 2021 15:47:21 +0100
Message-ID: <CAKfTPtCGnQc+knLbm=zR-a5T2yEJOZo3CWTJcwHgGdZQ0uYyog@mail.gmail.com>
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

On Fri, 12 Nov 2021 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 12, 2021 at 10:58:56AM +0100, Vincent Guittot wrote:
> > In case we skip the newly idle LB entirely or we abort it because we are
> > going to exceed the avg_idle, we have to make sure to not start an update
> > of the blocked load when entering idle
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 13950beb01a2..a162b0ec8963 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10861,7 +10861,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >       int this_cpu = this_rq->cpu;
> >       u64 t0, t1, curr_cost = 0;
> >       struct sched_domain *sd;
> > -     int pulled_task = 0;
> > +     int pulled_task = 0, early_stop = 0;
> >
> >       update_misfit_status(NULL, this_rq);
> >
> > @@ -10898,8 +10898,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >       if (!READ_ONCE(this_rq->rd->overload) ||
> >           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> >
> > -             if (sd)
> > +             if (sd) {
> >                       update_next_balance(sd, &next_balance);
> > +
> > +                     /*
> > +                      * We skip new idle LB because there is not enough
> > +                      * time before next wake up. Make sure that we will
> > +                      * not kick NOHZ_NEWILB_KICK
> > +                      */
> > +                     early_stop = 1;
> > +             }
> >               rcu_read_unlock();
> >
> >               goto out;
> > @@ -10918,8 +10926,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >               update_next_balance(sd, &next_balance);
> >
> > -             if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
> > +             if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> > +                     early_stop = 1;
> >                       break;
> > +             }
> >
> >               if (sd->flags & SD_BALANCE_NEWIDLE) {
> >
> > @@ -10969,7 +10979,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >       if (pulled_task)
> >               this_rq->idle_stamp = 0;
> > -     else
> > +     else if (!early_stop)
> >               nohz_newidle_balance(this_rq);
> >
> >       rq_repin_lock(this_rq, rf);
>
> Urgh code flow is a mess... Let me see if I can fix some of that.

yeah, I haven't find a better way

>
> Anyway, does nohz_newidle_balance() want to loose it's ->avg_idle test
> with this on?

This test still covers cases with short newly idle balance. Being
conservative, people never complained that the update of blocked load
average of idle CPUs doesn't happen often enough. It's most often the
opposite
