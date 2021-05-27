Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6753926F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhE0FoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhE0FoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:44:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 22:42:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 131so4733048ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3A8Wu20LVhHZPUAbAH/POgPCjh6m8JaHFzzhcoaWR9Q=;
        b=SFD7nJ2FBuct7Hwadco4SuDXi5xGKBi2g9y79sY1ssDLObAmpU2qmPiPLUDzWv7U7A
         ILWkvZFCHRGVltjWnmmYtlBgftRtkOnGnI6KHurW5vzBMtrBhxZyoEydErfCfxqCsMgy
         Qpdzz4zl7ufGmj9XGwOUHrYKp3N0hhgq23tmO2ioMkWXhEAIX3d4g7Xux6McyuphmLbq
         gCBVeMfCahq830dEj2aAJwiNX2iL6OmjnjIOylyqXj+ArqCQFAOpNRRlvYVdJqTpwJgb
         cnPeCaK6nJASvJEXzU+3VkOaqVyLcJQSiTbpk7YmXMyVg8hLYGZ6aUnWL21ixmL8z4vm
         NFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3A8Wu20LVhHZPUAbAH/POgPCjh6m8JaHFzzhcoaWR9Q=;
        b=C8Y57R/scWntZB6APFJqK33j/F6U+ml/ustWECamoFURjDkiVm4orL6LEQ+NODYEJi
         +24Dts4LOR7mfYy9KkJV5+AImEDsb0Bzod8/FyzVs6otp0tO0tnAG/oSvaxHkea5NOTC
         m+1hQxmHpUFa7v1XzfzycHSZJm/Xvw9PL33EK1JzQytzuWZu/Ygk0hrE0ZuZZsjPwJeP
         wzkIYQvfWoxu1A4t7VU4jmlDSH+e891YQ4Cc784BX+hOVD5xDUcFGqDGV5+1UNdz+qYR
         LZCCGH/jKlqT5UqsaGMJPWx/Kj7C9HE15eaM9+kH1EBN/4GkDG1lfbJqoKVGj95q/UCk
         qgbQ==
X-Gm-Message-State: AOAM532TXCzf5ow1c22Z/HXkPgie7HhRKSsQHUBcF/fB/hDKbql6TrBF
        vIWN1c57qVsZSOU/ZI8gO0op9LI9rsbt2in1ja0=
X-Google-Smtp-Source: ABdhPJyEN9h/jzkSk4Vit6W/c/DoeEUGK/qmyt4F8953mUmmtVauvTWI/nnqUTjp3JqanCotjfMsjEKSx//xm/cOLG8=
X-Received: by 2002:a05:651c:54a:: with SMTP id q10mr1237293ljp.420.1622094146534;
 Wed, 26 May 2021 22:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
 <20210519160633.GA230499@e120877-lin.cambridge.arm.com> <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
In-Reply-To: <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 27 May 2021 13:41:30 +0800
Message-ID: <CAB8ipk8POOzM2Dut0gcqsgNO0r2585GGv4SG+a1mOmMnrW=Vrw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, May 26, 2021 at 10:59 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19/05/2021 18:06, Vincent Donnefort wrote:
> > On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:
> >> The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
> >> unnecessary util_est updates uses the LSB of util_est.enqueued. It is
> >> exposed via _task_util_est() (and task_util_est()).
> >>
> >> Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
> >> mentions that the LSB is lost for util_est resolution but
> >> find_energy_efficient_cpu() checks if task_util_est() returns 0 to
> >> return prev_cpu early.
> >>
> >> _task_util_est() returns the max value of util_est.ewma and
> >> util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
> >> So task_util_est() returning the max of task_util() and
> >> _task_util_est() will never return 0 under the default
> >> SCHED_FEAT(UTIL_EST, true).
> >>
> >> To fix this use the MSB of util_est.enqueued instead and keep the flag
> >> util_est internal, i.e. don't export it via _task_util_est().
> >>
> >> The maximal possible util_avg value for a task is 1024 so the MSB of
> >> 'unsigned int util_est.enqueued' isn't used to store a util value.
> >>
> >> As a caveat the code behind the util_est_se trace point has to filter
> >> UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
> >> be easy to do.
> >>
> >> This also fixes an issue report by Xuewen Yan that util_est_update()
> >> only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:
> >>
> >>   last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)
> >>
> >> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > I don't believe this made it through our integration branch testing, so I gave a
> > try manually on my Hikey with LISA's UtilConvergence test. 20 iterations of that
> > test passed without any problem.
> >
> >> ---
> >>  kernel/sched/fair.c |  5 +++--
> >>  kernel/sched/pelt.h | 13 +++++++------
> >>  2 files changed, 10 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 161b92aa1c79..0150d440b0a2 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -3856,7 +3856,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
> >>  {
> >>      struct util_est ue = READ_ONCE(p->se.avg.util_est);
> >>
> >> -    return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
> >> +    return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> >>  }
> >
> >
> > Shall we also update proc_sched_show_task() to avoid reading this flag there?
>
> Ah yes, forgot about this one! Thanks for the review.
>
> This can be fixed by fixed by moving UTIL_AVG_UNCHANGED from
> kernel/sched/pelt.h into include/linux/sched.h (next to the already
> existing util_est stuff there) and using it in proc_sched_show_task()
> for se.avg.util_est.enqueued.
>
> What do you think?
>
> --8<--
> Subject: [PATCH] Fix proc_sched_show_task()
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  include/linux/sched.h | 10 ++++++++++
>  kernel/sched/debug.c  |  3 ++-
>  kernel/sched/pelt.h   | 10 ----------
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c7e7d50e2fdc..0a0bca694536 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -357,6 +357,16 @@ struct util_est {
>  #define UTIL_EST_WEIGHT_SHIFT          2
>  } __attribute__((__aligned__(sizeof(u64))));
>
> +/*
> + * This flag is used to synchronize util_est with util_avg updates.
> + * When a task is dequeued, its util_est should not be updated if its util_avg
> + * has not been updated in the meantime.
> + * This information is mapped into the MSB bit of util_est.enqueued at dequeue
> + * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
> + * for a task) it is safe to use MSB.
> + */
> +#define UTIL_AVG_UNCHANGED 0x80000000
> +

IMHO, Maybe it would be better to put it in the util_est structure
just like UTIL_EST_WEIGHT_SHIFT?

BR
xuewen.yan
>  /*
>   * The load/runnable/util_avg accumulates an infinite geometric series
>   * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 3bdee5fd7d29..0c5ec2776ddf 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -885,6 +885,7 @@ static const struct seq_operations sched_debug_sops = {
>  #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
>  #define __P(F) __PS(#F, F)
>  #define   P(F) __PS(#F, p->F)
> +#define   PM(F, M) __PS(#F, p->F & (M))
>  #define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
>  #define __PN(F) __PSN(#F, F)
>  #define   PN(F) __PSN(#F, p->F)
> @@ -1011,7 +1012,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>         P(se.avg.util_avg);
>         P(se.avg.last_update_time);
>         P(se.avg.util_est.ewma);
> -       P(se.avg.util_est.enqueued);
> +       PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
>  #endif
>  #ifdef CONFIG_UCLAMP_TASK
>         __PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 178290a8d150..e06071bf3472 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -42,16 +42,6 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
>         return LOAD_AVG_MAX - 1024 + avg->period_contrib;
>  }
>
> -/*
> - * When a task is dequeued, its estimated utilization should not be updated if
> - * its util_avg has not been updated in the meantime.
> - * This flag is used to synchronize util_avg updates with util_est updates.
> - * We map this information into the MSB bit of util_est.enqueued at dequeue
> - * time. Since max value of util_est.enqueued for a task is 1024 (PELT
> - * util_avg for a task) it is safe to use MSB here.
> - */
> -#define UTIL_AVG_UNCHANGED 0x80000000
> -
>  static inline void cfs_se_util_change(struct sched_avg *avg)
>  {
>         unsigned int enqueued;
> --
> 2.25.1
