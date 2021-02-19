Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3931F79B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBSKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBSKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:49:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:48:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id j6so17846924ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88GPIqf7tAbxRYDNa8rg2hEPN3u09m6K7jZsA3wYX2Y=;
        b=V1qskuH6P8G30S5E4TskcwPFuqPjnjDUvSE5oKYfIV6NyKouPPKyRTZMY59+O4TObi
         E4hAvdgy57deQ6891EjQNLllSEEz79bg4OM38R9BiUePggvjbtQ2NJ98mfba36CYpnF0
         afCH8flluP8LA1RoGHu5JgtW4obsYWP+ZrchH1bV9sxyZaafoZdTol//uBKeL08q2Fjg
         CJbBhUdaFZlnlEMnN+MAXScWxhb1C75aq2avdaQQwMVd2qwVyvbruR/+LfEU+pLpRJXk
         XUJpyygAACs9R9qotChVK5weLKEFYNM3qa7qnl6uyw3z2r055nfdCGU7mAqcXj1Hhn6U
         61oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88GPIqf7tAbxRYDNa8rg2hEPN3u09m6K7jZsA3wYX2Y=;
        b=HT5RKxvSJtceuXbrXhbV6i7gob8zmz4Q9Di1jR7xb0+SZWQw9Mx/r15tG203nciaqN
         tJ9E1ScWwhOehSR1poVvYEUO629fO7pEFU80HDyHGbGYhAOZfwOE314boO5Nlgan6C+l
         CX4TlcmMWwUhWAt8zWLgte8wPsA5qEsrxT+YFGesYH+KBW+bh4/2WuPdHDg5+nxhSsP6
         /I5+BU4ialaPFY2VYODlUEqA6qahUMeROBwyHciHREPqg3W2pTglEvvBGRaD9JxE4MEB
         BlNj1qNiRW0a1ZklCMz/en8/fnyBnCb+ee3Ph0fexG/beaddVCqFVC5MXWo619iMh3S1
         kr3g==
X-Gm-Message-State: AOAM5339EdEGFH2gFH+UIlzovCpLdt8pUot1HSU7rXMglpHpaBEEizlK
        k9KfW3eZR7dcQXyWe/75tLSfXuL6vDVfAFVr6pQQFw==
X-Google-Smtp-Source: ABdhPJxoXQZ42wvz1FdNCC4xGkwQAhdfmhi2Gwb0UCvXBjn4dTtvW0w0TXXFkXbryimxogZFKj35T61fuC2Qt/p2twM=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr5222600ljg.221.1613731720197;
 Fri, 19 Feb 2021 02:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20210216163921.572228-1-vincent.donnefort@arm.com>
In-Reply-To: <20210216163921.572228-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Feb 2021 11:48:28 +0100
Message-ID: <CAKfTPtDC1GYV_7zoUtZa5MNLdt0Lx=X_UgB=Q8UtsGf8=Kd3iQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Fix task util_est update filtering
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 at 17:39, <vincent.donnefort@arm.com> wrote:
>
> From: Vincent Donnefort <vincent.donnefort@arm.com>
>
> Being called for each dequeue, util_est reduces the number of its updates
> by filtering out when the EWMA signal is different from the task util_avg
> by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
> decay from a previous high util_avg, EWMA might now be close enough to
> the new util_avg. No update would then happen while it would leave
> ue.enqueued with an out-of-date value.
>
> Taking into consideration the two util_est members, EWMA and enqueued for
> the filtering, ensures, for both, an up-to-date value.
>
> This is for now an issue only for the trace probe that might return the
> stale value. Functional-wise, it isn't (yet) a problem, as the value is

What do you mean by "it isn't (yet) a problem" ? How could this become
a problem ?

> always accessed through max(enqueued, ewma).
>

This adds more tests and or update of  struct avg.util_est. It would
be good to have an idea of the perf impact. Especially because this
only fixes a tracing problem


> This problem has been observed using LISA's UtilConvergence:test_means on
> the sd845c board.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..9008e0c42def 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3941,24 +3941,27 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>         trace_sched_util_est_cfs_tp(cfs_rq);
>  }
>
> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> +
>  /*
> - * Check if a (signed) value is within a specified (unsigned) margin,
> + * Check if a (signed) value is within the (unsigned) util_est margin,
>   * based on the observation that:
>   *
>   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
>   *
> - * NOTE: this only works when value + maring < INT_MAX.
> + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
>   */
> -static inline bool within_margin(int value, int margin)
> +static inline bool util_est_within_margin(int value)
>  {
> -       return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> +       return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> +               (2 * UTIL_EST_MARGIN - 1));
>  }
>
>  static inline void util_est_update(struct cfs_rq *cfs_rq,
>                                    struct task_struct *p,
>                                    bool task_sleep)
>  {
> -       long last_ewma_diff;
> +       long last_ewma_diff, last_enqueued_diff;
>         struct util_est ue;
>
>         if (!sched_feat(UTIL_EST))
> @@ -3979,6 +3982,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         if (ue.enqueued & UTIL_AVG_UNCHANGED)
>                 return;
>
> +       last_enqueued_diff = ue.enqueued;
> +
>         /*
>          * Reset EWMA on utilization increases, the moving average is used only
>          * to smooth utilization decreases.
> @@ -3992,12 +3997,19 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         }
>
>         /*
> -        * Skip update of task's estimated utilization when its EWMA is
> +        * Skip update of task's estimated utilization when its members are
>          * already ~1% close to its last activation value.
>          */
>         last_ewma_diff = ue.enqueued - ue.ewma;
> -       if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> +       last_enqueued_diff -= ue.enqueued;
> +       if (util_est_within_margin(last_ewma_diff)) {
> +               if (!util_est_within_margin(last_enqueued_diff)) {
> +                       ue.ewma = ue.enqueued;
> +                       goto done;
> +               }
> +
>                 return;
> +       }
>
>         /*
>          * To avoid overestimation of actual task utilization, skip updates if
> --
> 2.25.1
>
