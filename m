Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D113A446CE5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhKFHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhKFHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:44:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD28C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 00:41:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h14so9319570qtb.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQ6S1hA/qSpBacaCcbjcd1nTEY2NkWgXRI06DO8+tqc=;
        b=Zu/2sG3a1Lr0Lb9H1iSFAx2gwtZgnMniYrl0WZO8Lse4tYnjuL9QL9bD9a5/SaNI/8
         h6Hz+YSCS5hCHOBNQaBhzVxqb6AZT9Zv4QajAvO5lWnaD6gF8Nxno9u58+EX6ltmxRHr
         uEdd6p9I1ljG3+d166Fl75oTAHJmG15DwhFZDKSZH2JZ0OFWbF2RWuK1EQ9HhAmCuYv7
         1jzUAADcNnOQgWOgnZPNGrrxiSximd1hx1JhZy2tBVFiiO1vnwM6lIjOFWJ3x+oYLPFR
         IlALU1KOGLLVOpRpXzD/Q4zLtMHodFtzznW1dVTe9+FWQq2hpZI72gMSOBK1h/NC3Ra0
         RQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQ6S1hA/qSpBacaCcbjcd1nTEY2NkWgXRI06DO8+tqc=;
        b=Q5L5lOlm9DiRLe/7SM21P6ty9X2MlvVcHZZHmtkHxIAP03fYjVv2huumbtfRdH2hPg
         ZnqvvgR4kr10t5+GhZOF3/hHzGWHIL+iCvOQc7t5gWGH25tIZ9PaY8M/y9Uh4abDo9hv
         fz7xAss6Vemg65QNX3lxQcaVPCFevb8TZz/ZhVZhunOdM0VN20YtHXBL6pPwjVXgRhkY
         ZtmbqyOMvMPykaSeZHcu73BF/zKjlJ7KS/Les69DTJC0LDPkVxjMt+dReqI2odbprDi7
         fZ5301LTVe63ktun13BH1vjPNCaDvmE8ZcOzucBafRZqaGIdmWQFq5N16icxh2nGjfBt
         YA2g==
X-Gm-Message-State: AOAM5310VNCIxfqBT3UhUnO4lw4uLPHQl8s4VSgSraqloi4WJ6KW1rh8
        +zU3ZsL7OffebWEHWRAcIomK4DZO7a1i0ThaR6g=
X-Google-Smtp-Source: ABdhPJwp8Xwf4z8B1FN0Nsu0TskHZPssLLD7mfy1IvcTBh12gtGOIk0m2zyUuyuBsUrtidPrv7WqDEmbl3CbQwIkuFs=
X-Received: by 2002:ac8:5c08:: with SMTP id i8mr68209780qti.181.1636184488937;
 Sat, 06 Nov 2021 00:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-5-laoar.shao@gmail.com>
 <878ry2tu1m.mognet@arm.com>
In-Reply-To: <878ry2tu1m.mognet@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 6 Nov 2021 15:40:53 +0800
Message-ID: <CALOAHbDZMiLR-3NQHYPJ707Hk-3X+yjrxk_YA0xyxa40Sj7SEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] sched/core: Do numa balance in cfs_migration
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 6, 2021 at 1:02 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/11/21 14:57, Yafang Shao wrote:
> > Similar to active load balance, the numa balance work is also applied to
> > cfs tasks only and it should't preempt other FIFO tasks. We'd better assign
> > cfs_migration to the numa balance as well.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/core.c  |  2 +-
> >  kernel/sched/fair.c  | 13 +++++++++++++
> >  kernel/sched/sched.h |  2 ++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9cb81ef8acc8..4a37b06715f4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8724,7 +8724,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
> >       /* TODO: This is not properly updating schedstats */
> >
> >       trace_sched_move_numa(p, curr_cpu, target_cpu);
> > -     return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
> > +     return wakeup_cfs_migrater(curr_cpu, migration_cpu_stop, &arg);
>
> So that one I find really icky - migration_cpu_stop() really is meant to be
> run from a CPU stopper (cf. cpu_stop suffix). IMO this is the opportunity
> to make NUMA balancing reuse the logic for CFS active balance here, but per
> previous email I'd say it could be done as a second step.
>

Sure.

> >  }
> >
> >  /*
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 932f63baeb82..b7a155e05c98 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11960,6 +11960,19 @@ static void wakeup_cfs_migrater_nowait(unsigned int cpu, cpu_stop_fn_t fn, void
> >       cfs_migration_queue_work(cpu, work_buf);
> >  }
> >
> > +bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
> > +{
> > +     struct cpu_stop_done done;
> > +     struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
> > +
> > +     cpu_stop_init_done(&done, 1);
> > +     cfs_migration_queue_work(cpu, &work);
> > +     cond_resched();
> > +     wait_for_completion(&done.completion);
> > +
> > +     return done.ret;
> > +}
> > +
> >  static int cfs_migration_should_run(unsigned int cpu)
> >  {
> >       struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a00fc7057d97..7b242c18a6d8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3055,6 +3055,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
> >
> >       return true;
> >  }
> > +
> > +bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
> >  #endif
> >
> >  extern void swake_up_all_locked(struct swait_queue_head *q);
> > --
> > 2.17.1



-- 
Thanks
Yafang
