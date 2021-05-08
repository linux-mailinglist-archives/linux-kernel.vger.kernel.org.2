Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD385377097
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhEHIIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:08:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A15C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 01:07:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p12so14530646ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiD0RndLunCz11cH/1AcDoRAlAd7QlgiJNfMkRGjhj0=;
        b=bBRv4fLGGy+pvV1/Th7e5HKTp8sRS1i9yZ+ygwaqrkuc7eOIheLr/C0h7XUY6VH+KN
         SWOk9ZPAVOMUjJzN0Wh803THFtrjR4fPMDnUxBbxEuaHs0DEryMrSI2ix2BGYbMqb3U4
         /ETkFv2E+Fton1CF41yRoclhrYv68faEKYxb8aXfwkC2uUUov5GIjK5tJ114c8ZEW45B
         ICHaRAn2lziccHTnuFtuPESqSPNSuE4Xn8uBnHTpEPfC3UCRvyGxAlHFuS6JUM6O4wR3
         ODu+sWFkN5QqI3P21SJHl60shBo05CX8FBGI4mXc08lNW/Foj9zuDGwEp+Rb62c2ErHB
         wa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiD0RndLunCz11cH/1AcDoRAlAd7QlgiJNfMkRGjhj0=;
        b=S/btpggldQkobmQRhFEPCZZ3iX+dnTnx2caG2+Uz1JJSR9fAerSsnX7XOiZv1EHf+5
         1snMDN8E6nfy4yxBMtvZP5oMLOloaiITtf4dtRODZh2QmCE2YoiiJCI7pl6kulkJg+bl
         O3XP7DVm5Jccri0AmeRJSqTw7uOMB72MNJf3XOt76doAwKHCYpNNwGoYkkMvbxbrVXcf
         lY7bFDz5DwcRxFWwKMHp39cuhne26IAMxx3MzQsLjsH6tZtr710RjbSzrJg/MGBGApvu
         7kDfpw/ViOwUm64651+6bzxiBXdoa6yqX81r9LmFbATHhBM5bCBugOxes6tc+qjbRiRb
         kvvQ==
X-Gm-Message-State: AOAM532ooBYjknEluqd0czdZlAOkqYmDXEv7un8ff/oUKpaPRr52fRGW
        nbndYIZV/hGzI55GEE90EQsD7m6KBpl3fOYlw+Q=
X-Google-Smtp-Source: ABdhPJxjazVcTDhq1m9ErkRUqK1I4eLq+dmxfm+VnnC+T64/DvtKChxZMBEi7uCGljgLo7qrYXebBSpmQBhxslNvW7Y=
X-Received: by 2002:a05:651c:3db:: with SMTP id f27mr11121023ljp.241.1620461267135;
 Sat, 08 May 2021 01:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <YJUNY0dmrJMD/BIm@hirez.programming.kicks-ass.net>
In-Reply-To: <YJUNY0dmrJMD/BIm@hirez.programming.kicks-ass.net>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 8 May 2021 16:07:35 +0800
Message-ID: <CAERHkrvBdFHWxXu=iHAPMe=1dB0qtG_HTMtUbvVviv7_7kc97Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 8:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> When switching on core-sched, CPUs need to agree which lock to use for
> their RQ.
>
> The new rule will be that rq->core_enabled will be toggled while
> holding all rq->__locks that belong to a core. This means we need to
> double check the rq->core_enabled value after each lock acquire and
> retry if it changed.
>
> This also has implications for those sites that take multiple RQ
> locks, they need to be careful that the second lock doesn't end up
> being the first lock.
>
> Verify the lock pointer after acquiring the first lock, because if
> they're on the same core, holding any of the rq->__lock instances will
> pin the core state.
>
> While there, change the rq->__lock order to CPU number, instead of rq
> address, this greatly simplifies the next patch.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Don Hiatt <dhiatt@digitalocean.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> ---
>  kernel/sched/core.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |   48 +++++++++++++++++-------------------------------
>  2 files changed, 63 insertions(+), 33 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
>
>  void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  {
> -       raw_spin_lock_nested(rq_lockp(rq), subclass);
> +       raw_spinlock_t *lock;
> +
> +       if (sched_core_disabled()) {
> +               raw_spin_lock_nested(&rq->__lock, subclass);
> +               return;
> +       }
> +
> +       for (;;) {
> +               lock = rq_lockp(rq);
> +               raw_spin_lock_nested(lock, subclass);
> +               if (likely(lock == rq_lockp(rq)))
> +                       return;
> +               raw_spin_unlock(lock);
> +       }
>  }
>
>  bool raw_spin_rq_trylock(struct rq *rq)
>  {
> -       return raw_spin_trylock(rq_lockp(rq));
> +       raw_spinlock_t *lock;
> +       bool ret;
> +
> +       if (sched_core_disabled())
> +               return raw_spin_trylock(&rq->__lock);
> +
> +       for (;;) {
> +               lock = rq_lockp(rq);
> +               ret = raw_spin_trylock(lock);
> +               if (!ret || (likely(lock == rq_lockp(rq))))
> +                       return ret;
> +               raw_spin_unlock(lock);
> +       }
>  }
>
>  void raw_spin_rq_unlock(struct rq *rq)
> @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
>         raw_spin_unlock(rq_lockp(rq));
>  }
>
> +#ifdef CONFIG_SMP
> +/*
> + * double_rq_lock - safely lock two runqueues
> + */
> +void double_rq_lock(struct rq *rq1, struct rq *rq2)

Do we need the static lock checking here?
        __acquires(rq1->lock)
        __acquires(rq2->lock)

> +{
> +       lockdep_assert_irqs_disabled();
> +
> +       if (rq_order_less(rq2, rq1))
> +               swap(rq1, rq2);
> +
> +       raw_spin_rq_lock(rq1);
> +       if (rq_lockp(rq1) == rq_lockp(rq2)) {

And here?
                __acquire(rq2->lock);

> +               return;
}
> +
> +       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +}
> +#endif
> +
>  /*
>   * __task_rq_lock - lock the rq @p resides on.
>   */
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1113,6 +1113,11 @@ static inline bool is_migration_disabled
>  #endif
>  }
>
> +static inline bool sched_core_disabled(void)
> +{
> +       return true;
> +}
> +
>  static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>  {
>         return &rq->__lock;
> @@ -2231,10 +2236,17 @@ unsigned long arch_scale_freq_capacity(i
>  }
>  #endif
>
> +
>  #ifdef CONFIG_SMP
> -#ifdef CONFIG_PREEMPTION
>
> -static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
> +static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
> +{
> +       return rq1->cpu < rq2->cpu;
> +}
> +
> +extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
> +
> +#ifdef CONFIG_PREEMPTION
>
>  /*
>   * fair double_lock_balance: Safely acquires both rq->locks in a fair
> @@ -2274,14 +2286,13 @@ static inline int _double_lock_balance(s
>         if (likely(raw_spin_rq_trylock(busiest)))
>                 return 0;
>
> -       if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
> +       if (rq_order_less(this_rq, busiest)) {
>                 raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
>                 return 0;
>         }
>
>         raw_spin_rq_unlock(this_rq);
> -       raw_spin_rq_lock(busiest);
> -       raw_spin_rq_lock_nested(this_rq, SINGLE_DEPTH_NESTING);
> +       double_rq_lock(this_rq, busiest);
>
>         return 1;
>  }
> @@ -2334,31 +2345,6 @@ static inline void double_raw_lock(raw_s
>  }
>
>  /*
> - * double_rq_lock - safely lock two runqueues
> - *
> - * Note this does not disable interrupts like task_rq_lock,
> - * you need to do so manually before calling.
> - */
> -static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
> -       __acquires(rq1->lock)
> -       __acquires(rq2->lock)
> -{
> -       BUG_ON(!irqs_disabled());
> -       if (rq_lockp(rq1) == rq_lockp(rq2)) {
> -               raw_spin_rq_lock(rq1);
> -               __acquire(rq2->lock);   /* Fake it out ;) */
> -       } else {
> -               if (rq_lockp(rq1) < rq_lockp(rq2)) {
> -                       raw_spin_rq_lock(rq1);
> -                       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> -               } else {
> -                       raw_spin_rq_lock(rq2);
> -                       raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
> -               }
> -       }
> -}
> -
> -/*
>   * double_rq_unlock - safely unlock two runqueues
>   *
>   * Note this does not restore interrupts like task_rq_unlock,
> @@ -2368,11 +2354,11 @@ static inline void double_rq_unlock(stru
>         __releases(rq1->lock)
>         __releases(rq2->lock)
>  {
> -       raw_spin_rq_unlock(rq1);
>         if (rq_lockp(rq1) != rq_lockp(rq2))
>                 raw_spin_rq_unlock(rq2);
>         else
>                 __release(rq2->lock);
> +       raw_spin_rq_unlock(rq1);

This change seems not necessary, as the softlockup root cause is not
the misorder lock release.

Thanks,
-Aubrey
