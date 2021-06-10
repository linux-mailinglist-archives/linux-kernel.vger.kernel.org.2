Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E013A22D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhFJDhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:37:19 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39463 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFJDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:37:18 -0400
Received: by mail-lf1-f52.google.com with SMTP id p17so729945lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SI2Cs/KC3jzMc8VUYVE4yg+hAWb5g2oHwl9sJaeR1I=;
        b=qowBlqPyceTtChCMAiT4qQyWnPbybMtSZiQgEPmQxgIYeHV802/3qRtz+w1EoHHCH6
         LPWDNXhD0+ErBL35VygsDvBiRzxoj+ucwz8q6JUFxXc8f2CQcF1/0uMGYdqpIivEnR/l
         XT7BRJUzQI4mTCOyxGLr/MFi1Ziohsl646mnIBQmrzBqbaaLAwtok0tvYoFcmj7o1mPj
         fLFIEQq8saXAlH/xJq4PDzj5sV7WevQ9EKbRCtETYmfF1vh24GMom5Rdq3a1VsVWl7CR
         0bSDkgqmEk0mYrVvj8frTqTKIcDywD/995y5c52G2cntTTPSW9iTlwJKiJVxkjaB3MCd
         4Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SI2Cs/KC3jzMc8VUYVE4yg+hAWb5g2oHwl9sJaeR1I=;
        b=POFlnF/xcN2dWnnZ0bYG8Q/qiKxaYCYlB+SpDSIOrp4e0EFehbruRWTbLYM7LZejJ5
         p8QrmQXNct2cMsPbLzbFgifQwacyyrYawvj97ej/+ddLWF1j61U/BggeAW6uMJv0m+lE
         KJK7No1CIi1NGSDTXcSZGOOqQgIAnd6IaNc38uFJMHzpIpEpB2egetsZ2db6v3MeXZ2c
         rK1bDmIulcOkIA8/3wknMtW2+gU3CIZnWQVEGnBYzViwVB1/zv0WJ7c2ViNHOT0od4lA
         Ut6vyMk9yofNwj5WXvF9XDCJTCunb2DqOOjxOf0Qmhk/DVwLXTzkFplCIy5M/5xuLXmN
         JxqQ==
X-Gm-Message-State: AOAM530h2BgnBaz5qFF4DI+qjh/R2qK0job5Vt7Iv6NmPWjk0cLhhVUl
        ZsTm6rp0IQ0lTayRhi2XQ+5xECaUWgJ8dwGh9Lg=
X-Google-Smtp-Source: ABdhPJwm4/DfJDamFH508ZT0a6Li0Tyd+gVYXQsUW0HZ4Ujd4TX65IUB1YkQVFURykcC3gOI5UQa2dYR3RGfXDSiFLE=
X-Received: by 2002:ac2:4d93:: with SMTP id g19mr540781lfe.622.1623296048728;
 Wed, 09 Jun 2021 20:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210609175901.1423553-1-qperret@google.com>
In-Reply-To: <20210609175901.1423553-1-qperret@google.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 10 Jun 2021 11:33:04 +0800
Message-ID: <CAB8ipk_LY=9G5E8TcE3b7i3Ntfj+vJUuqSR7LWYn8=yOaTtCEg@mail.gmail.com>
Subject: Re: [PATCH] sched: Make uclamp changes depend on CAP_SYS_NICE
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, rickyiu@google.com,
        wvw@google.com, Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 2:16 AM Quentin Perret <qperret@google.com> wrote:
>
> There is currently nothing preventing tasks from changing their per-task
> clamp values in anyway that they like. The rationale is probably that
> systems administrator are still able to limit those clamps thanks to the
> cgroup interface. However, this causes pain in a system where both
> per-task and per-cgroup clamps values are expected to be under the
> control of core system components (as is the case for Android).
>
> To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> values. This allows unprivileged tasks to lower their requests, but not
> increase them, which is consistent with the existing behaviour for nice
> values.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 48 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1d4aedbbcf96..1e5f9ae441a0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
>         if (util_min != -1 && util_max != -1 && util_min > util_max)
>                 return -EINVAL;
>
> +       return 0;
> +}
> +
> +static void uclamp_enable(void)
> +{
>         /*
>          * We have valid uclamp attributes; make sure uclamp is enabled.
>          *
> @@ -1438,8 +1443,25 @@ static int uclamp_validate(struct task_struct *p,
>          * scheduler locks.
>          */
>         static_branch_enable(&sched_uclamp_used);
> +}
>
> -       return 0;
> +static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
> +{
> +       int util_min, util_max;
> +
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +               util_min = p->uclamp_req[UCLAMP_MIN].value;
> +               if (attr->sched_util_min > util_min)
> +                       return false;
> +       }
> +
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +               util_max = p->uclamp_req[UCLAMP_MAX].value;
> +               if (attr->sched_util_max > util_max)
> +                       return false;

when the attr->sched_util_max = -1, and the util_max < 1024, here may
should return false, but it would return ture.

Thanks
xuewen
> +       }
> +
> +       return true;
>  }
>
>  static bool uclamp_reset(const struct sched_attr *attr,
> @@ -1580,6 +1602,11 @@ static inline int uclamp_validate(struct task_struct *p,
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline void uclamp_enable(void) { }
> +static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
> +{
> +       return true;
> +}
>  static void __setscheduler_uclamp(struct task_struct *p,
>                                   const struct sched_attr *attr) { }
>  static inline void uclamp_fork(struct task_struct *p) { }
> @@ -6116,6 +6143,13 @@ static int __sched_setscheduler(struct task_struct *p,
>             (rt_policy(policy) != (attr->sched_priority != 0)))
>                 return -EINVAL;
>
> +       /* Update task specific "requested" clamps */
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> +               retval = uclamp_validate(p, attr);
> +               if (retval)
> +                       return retval;
> +       }
> +
>         /*
>          * Allow unprivileged RT tasks to decrease priority:
>          */
> @@ -6165,6 +6199,10 @@ static int __sched_setscheduler(struct task_struct *p,
>                 /* Normal users shall not reset the sched_reset_on_fork flag: */
>                 if (p->sched_reset_on_fork && !reset_on_fork)
>                         return -EPERM;
> +
> +               /* Can't increase util-clamps */
> +               if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP && !uclamp_reduce(p, attr))
> +                       return -EPERM;
>         }
>
>         if (user) {
> @@ -6176,12 +6214,8 @@ static int __sched_setscheduler(struct task_struct *p,
>                         return retval;
>         }
>
> -       /* Update task specific "requested" clamps */
> -       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> -               retval = uclamp_validate(p, attr);
> -               if (retval)
> -                       return retval;
> -       }
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> +               uclamp_enable();
>
>         if (pi)
>                 cpuset_read_lock();
> --
> 2.32.0.272.g935e593368-goog
>
