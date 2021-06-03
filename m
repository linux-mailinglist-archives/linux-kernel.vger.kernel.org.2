Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C539A16B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFCMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFCMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:50:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D7C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:48:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m3so6925302lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/bqvFSNlYcsQMxGwW2sWc/nWXkNp0eHoJCmT6oU2oU=;
        b=vxPHa8lzGE1+C0aSbz/mgDtadlkvGpcJLXp6zIkUZpnBo90Uo0IPXjp8hh2e8AF4xw
         brDtJ0okp5jgBdmJ8scDQnHuTj9WpYCmGO9IFg+RcLxskK2sH3XKFoj+VsXxrRan85V2
         bbkggPviGMT0R32Y5eSJOonovmB57a7QthOHSxgzYeQqvBmnylhMwf04ocV/+WvVBkl2
         6+xfSFAl9HyGsGMr4/Ko5GABnmU6B5szqVowVCQ/y+0P0ZKj4e8CTXzhoEuDAEe6MO6Y
         NEHxa3hgTjc6c306gUlICSGBoRSsPcNTbY+L3TZnjCcGzcy/dfVOnu0QuW1LUGmgFM2v
         5NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/bqvFSNlYcsQMxGwW2sWc/nWXkNp0eHoJCmT6oU2oU=;
        b=PllDaEM/s2M1gP19k9CS1iQDBQWk6OoZAYt6JtnlP1s2iSIfAlRieKpi7Z0tr+Cr7S
         cF4uCfvb4UELgObkHFR6Ac2GDlh06won1//4agJFTMziChyEbXUrCsJrcn7EyuUC9HNr
         8j8FAEffQyntBHOmdqB1MfNVSzNP1FjtC3fVm+R6a205j4lI/1k6HIwmNP4G5sh0LPR7
         QkPyGqlJ3HPUtgLEDJQUQSULDcSx3Dai8YCOL3vzEpfJsCGWCY5y8LBohQwqj70ZTjRG
         d/RSc24152OBNm+Vvkhe5qCtbP41unoL+sKizKvVnpOpTnbKlK45L6UcBPv2Gh7o5/5N
         kmEQ==
X-Gm-Message-State: AOAM531GYC9QpqNehIRVjIuv0yc/Z8hCKLIdw3n8GudNr8rLGqPLYtT/
        Jb3zoq6uFb25sLlEduWViQN+AWRslyv4NYjhcis0lA==
X-Google-Smtp-Source: ABdhPJwhhH+24D8m0jWGUOdc/sAStvfRj4FyYRn6f3tMlg9egnnwsZ4S8SANUjzxj2zaAyWHT3DEc7TOKVS7XFtTOUc=
X-Received: by 2002:a2e:858a:: with SMTP id b10mr6979970lji.445.1622724538203;
 Thu, 03 Jun 2021 05:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210602145808.1562603-1-dietmar.eggemann@arm.com>
In-Reply-To: <20210602145808.1562603-1-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Jun 2021 14:48:47 +0200
Message-ID: <CAKfTPtB_w7FCnm1V9MFnw1foZ=PTSFAMWEcHv2bSdLKwcYj=DA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 at 16:58, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
> unnecessary util_est updates uses the LSB of util_est.enqueued. It is
> exposed via _task_util_est() (and task_util_est()).
>
> Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
> mentions that the LSB is lost for util_est resolution but
> find_energy_efficient_cpu() checks if task_util_est() returns 0 to
> return prev_cpu early.
>
> _task_util_est() returns the max value of util_est.ewma and
> util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
> So task_util_est() returning the max of task_util() and
> _task_util_est() will never return 0 under the default
> SCHED_FEAT(UTIL_EST, true).
>
> To fix this use the MSB of util_est.enqueued instead and keep the flag
> util_est internal, i.e. don't export it via _task_util_est().
>
> The maximal possible util_avg value for a task is 1024 so the MSB of
> 'unsigned int util_est.enqueued' isn't used to store a util value.
>
> As a caveat the code behind the util_est_se trace point has to filter
> UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
> be easy to do.
>
> This also fixes an issue report by Xuewen Yan that util_est_update()
> only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:
>
>   last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)
>
> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> v1->v2:
>
> 1) Move UTIL_AVG_UNCHANGED definition into struct util_est.
> 2) Hide UTIL_AVG_UNCHANGED in proc_sched_show_task().
>
>  include/linux/sched.h |  8 ++++++++
>  kernel/sched/debug.c  |  3 ++-
>  kernel/sched/fair.c   |  5 +++--
>  kernel/sched/pelt.h   | 11 +----------
>  4 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c7e7d50e2fdc..ac5a7d29fd4f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -350,11 +350,19 @@ struct load_weight {
>   * Only for tasks we track a moving average of the past instantaneous
>   * estimated utilization. This allows to absorb sporadic drops in utilization
>   * of an otherwise almost periodic task.
> + *
> + * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
> + * updates. When a task is dequeued, its util_est should not be updated if its
> + * util_avg has not been updated in the meantime.
> + * This information is mapped into the MSB bit of util_est.enqueued at dequeue
> + * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
> + * for a task) it is safe to use MSB.
>   */
>  struct util_est {
>         unsigned int                    enqueued;
>         unsigned int                    ewma;
>  #define UTIL_EST_WEIGHT_SHIFT          2
> +#define UTIL_AVG_UNCHANGED             0x80000000
>  } __attribute__((__aligned__(sizeof(u64))));
>
>  /*
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
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a2c30e52de76..56747df3f796 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3856,7 +3856,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
>  {
>         struct util_est ue = READ_ONCE(p->se.avg.util_est);
>
> -       return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
> +       return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
>  }
>
>  static inline unsigned long task_util_est(struct task_struct *p)
> @@ -3956,7 +3956,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>          * Reset EWMA on utilization increases, the moving average is used only
>          * to smooth utilization decreases.
>          */
> -       ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> +       ue.enqueued = task_util(p);
>         if (sched_feat(UTIL_EST_FASTUP)) {
>                 if (ue.ewma < ue.enqueued) {
>                         ue.ewma = ue.enqueued;
> @@ -4005,6 +4005,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         ue.ewma  += last_ewma_diff;
>         ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
>  done:
> +       ue.enqueued |= UTIL_AVG_UNCHANGED;
>         WRITE_ONCE(p->se.avg.util_est, ue);
>
>         trace_sched_util_est_se_tp(&p->se);
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 9ed6d8c414ad..e06071bf3472 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -42,15 +42,6 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
>         return LOAD_AVG_MAX - 1024 + avg->period_contrib;
>  }
>
> -/*
> - * When a task is dequeued, its estimated utilization should not be update if
> - * its util_avg has not been updated at least once.
> - * This flag is used to synchronize util_avg updates with util_est updates.
> - * We map this information into the LSB bit of the utilization saved at
> - * dequeue time (i.e. util_est.dequeued).
> - */
> -#define UTIL_AVG_UNCHANGED 0x1
> -
>  static inline void cfs_se_util_change(struct sched_avg *avg)
>  {
>         unsigned int enqueued;
> @@ -58,7 +49,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
>         if (!sched_feat(UTIL_EST))
>                 return;
>
> -       /* Avoid store if the flag has been already set */
> +       /* Avoid store if the flag has been already reset */
>         enqueued = avg->util_est.enqueued;
>         if (!(enqueued & UTIL_AVG_UNCHANGED))
>                 return;
> --
> 2.25.1
>
