Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6331836F0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhD2UMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhD2UMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:12:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:12:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o5so68547740qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++EODJiJxV25BQ3AEEp16UM9PRLRdEm7IoKfrTAnw74=;
        b=johxANWaew3UMG4UtKwIR4iBXKiKvIqDXk0sYU4dvPSJ23vRoStYPju23FTtfvngkR
         n3F4214kCvldeMs84sMCZxACM0TEjZj3bMh/+aIvOXSxovpUksvsS1DvFLEBWr8vu1aT
         kQIlAKujisvlyldgfVFMKz80J8ECP/8xO1fB1g4Rr8h6La06B+T+B6a+L+8Og68Kwqgm
         0oOtMeCf6NFRF/H7SJ8s0cckOgnhiN0kPMT4irHQmql+FPTLIO9yU0I5hE3iP5uRw5Wl
         9zsE6AWNCPnt2RxjCPvFo47mxz6IBsM6VsnA73z6LZO8x/tY8Q7/CU0v0MYaUs+KmopU
         hGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++EODJiJxV25BQ3AEEp16UM9PRLRdEm7IoKfrTAnw74=;
        b=LfnhisrZOhOjPlA/lLZeVXY/JZQCqTpWcoDH1kvkk9g7nv23wNwgAGWgT6xlhbEO5z
         zxveqUQCEn94lnH8peEifoaxUi/lAEQoNxGUmrAiVn4Ai5zOUtA6sBR1LUAh4CNHMbfm
         TQJjk6ua9BsqhjCGVjYl906dLmX32fwIWbZwYaVXAPZ8+QoAGD+ApWP96ANYizb0dl20
         H+gpaohMKapacHjcSrACMMN9tSpd9QODYh82CiKQyOOjUnuwwd55pl5sMIZgz1aoXHjp
         Fl1+PN8m3p9Y3G9/7WEzJ5d1scaMI3k0TGmjtL0xnG5LSf2J74PWC5fOAIdb+OHPwpeQ
         pfmw==
X-Gm-Message-State: AOAM533ZB41zf10AXYKrC/fpdpOHr384xG4396sBxTmGJIJqUwFE7Im7
        RoLQVRRM5A6e/R+bU4Vfs4xKtRC9WKaRXE78jW22JA==
X-Google-Smtp-Source: ABdhPJzlm6n+ZtlmGEGBa8Xcg9CvBPzELY3a8t/HWBP/3xWH8y1kjITfs1sNO4qQl9orVdXLdUvLCIEkq/a2QU21hGU=
X-Received: by 2002:a37:a6d2:: with SMTP id p201mr1554986qke.146.1619727126108;
 Thu, 29 Apr 2021 13:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com> <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
In-Reply-To: <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 29 Apr 2021 13:11:54 -0700
Message-ID: <CABk29Nu84zOGexUdT41MLssxnh1wN_1bGvEa699-gfuZtBj12Q@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 27, 2021 at 04:30:02PM -0700, Josh Don wrote:
>
> > Also, did you mean to have a preempt_enable_no_resched() rather than
> > prempt_enable() in raw_spin_rq_trylock?
>
> No, trylock really needs to be preempt_enable(), because it can have
> failed, at which point it will not have incremented the preemption count
> and our decrement can hit 0, at which point we really should reschedule.

Ah yes, makes sense. Did you want to use preempt_enable_no_resched()
at all then? No chance of preempt_count() being 1 at the point of
enable, as you comment below.

> > I went over the rq_lockp stuff again after Don's reported lockup. Most
> > uses are safe due to already holding an rq lock. However,
> > double_rq_unlock() is prone to race:
> >
> > double_rq_unlock(rq1, rq2):
> > /* Initial state: core sched enabled, and rq1 and rq2 are smt
> > siblings. So, double_rq_lock(rq1, rq2) only took a single rq lock */
> > raw_spin_rq_unlock(rq1);
> > /* now not holding any rq lock */
> > /* sched core disabled. Now __rq_lockp(rq1) != __rq_lockp(rq2), so we
> > falsely unlock rq2 */
> > if (__rq_lockp(rq1) != __rq_lockp(rq2))
> >         raw_spin_rq_unlock(rq2);
> > else
> >         __release(rq2->lock);
> >
> > Instead we can cache __rq_lockp(rq1) and __rq_lockp(rq2) before
> > releasing the lock, in order to prevent this. FWIW I think it is
> > likely that Don is seeing a different issue.
>
> Ah, indeed so.. rq_lockp() could do with an assertion, not sure how to
> sanely do that. Anyway, double_rq_unlock() is simple enough to fix, we
> can simply flip the unlock()s.
>
> ( I'm suffering a cold and am really quite slow atm )

No worries, hope it's a mild one.

> How's this then?

Looks good to me (other than the synchronize_sched()->synchronize_rcu()).

For these locking patches,
Reviewed-by: Josh Don <joshdon@google.com>

I'll see if I can repro  that lockup.

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f732642e3e09..3a534c0c1c46 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
>  static void __sched_core_enable(void)
>  {
>         static_branch_enable(&__sched_core_enabled);
> +       /*
> +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> +        */
> +       synchronize_sched();
>         __sched_core_flip(true);
>         sched_core_assert_empty();
>  }
> @@ -449,16 +453,23 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  {
>         raw_spinlock_t *lock;
>
> +       /* Matches synchronize_sched() in __sched_core_enabled() */
> +       preempt_disable();
>         if (sched_core_disabled()) {
>                 raw_spin_lock_nested(&rq->__lock, subclass);
> +               /* preempt-count *MUST* be > 1 */
> +               preempt_enable_no_resched();
>                 return;
>         }
>
>         for (;;) {
>                 lock = __rq_lockp(rq);
>                 raw_spin_lock_nested(lock, subclass);
> -               if (likely(lock == __rq_lockp(rq)))
> +               if (likely(lock == __rq_lockp(rq))) {
> +                       /* preempt-count *MUST* be > 1 */
> +                       preempt_enable_no_resched();
>                         return;
> +               }
>                 raw_spin_unlock(lock);
>         }
>  }
> @@ -468,14 +479,21 @@ bool raw_spin_rq_trylock(struct rq *rq)
>         raw_spinlock_t *lock;
>         bool ret;
>
> -       if (sched_core_disabled())
> -               return raw_spin_trylock(&rq->__lock);
> +       /* Matches synchronize_sched() in __sched_core_enabled() */
> +       preempt_disable();
> +       if (sched_core_disabled()) {
> +               ret = raw_spin_trylock(&rq->__lock);
> +               preempt_enable();
> +               return ret;
> +       }
>
>         for (;;) {
>                 lock = __rq_lockp(rq);
>                 ret = raw_spin_trylock(lock);
> -               if (!ret || (likely(lock == __rq_lockp(rq))))
> +               if (!ret || (likely(lock == __rq_lockp(rq)))) {
> +                       preempt_enable();
>                         return ret;
> +               }
>                 raw_spin_unlock(lock);
>         }
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6a905fe19eef..c9a52231d58a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2568,11 +2568,12 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
>         __releases(rq1->lock)
>         __releases(rq2->lock)
>  {
> -       raw_spin_rq_unlock(rq1);
>         if (__rq_lockp(rq1) != __rq_lockp(rq2))
>                 raw_spin_rq_unlock(rq2);
>         else
>                 __release(rq2->lock);
> +
> +       raw_spin_rq_unlock(rq1);
>  }
>
>  extern void set_rq_online (struct rq *rq);
