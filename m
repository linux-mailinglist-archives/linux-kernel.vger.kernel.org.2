Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B62325E42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBZHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:23:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:22:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c8so9461595ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNO0Htm8xCelrNaO6KBr1YYMZtpaorqQRsRnHcTJ/qQ=;
        b=ABRWJc9D3L7ChseSsMkYamV4y06JyHrqtMG776Td97pgzHVah2ihx2cSSK8IfNlGjW
         P7njwHtI8q9Rq3KJQpmkt/rKpOXIH02yb0cyPRN7fY6X8EOY9OO4GAePOvht0nZ9B7ya
         R0vV7D1K5JELbciXiA/uB08s88XgPN9y5LTZFHE07gnrd9F4sOkQmhcR84T1GlgF5lQO
         wHFsvB5fr+okUgJ/cG7hDyOZAFNiT0vjnPjEDKCZ6Ny44DvQne8wSrEE8sHSENRjjrgV
         0BwKssLuOf18FhfCkjl+kR3NiUgV4Y+P8o2j3phfm0gatR+SJ45frm3m1IZs5NQn6a6v
         z8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNO0Htm8xCelrNaO6KBr1YYMZtpaorqQRsRnHcTJ/qQ=;
        b=skD0fSLflXTwSmuEsydjq8W1ZN5a9uE0T342LOV16KcjYWhNQ1ntuEGSEgaLxSJqfj
         pXGG9SBu7hxkCq6uivfg+T30WZWOoFeaE7U2wKZ9FEWr4oZPkmVJ6x+2+u6YXWft95T+
         81TNk3XLfOXWAHniH23YDJKcXABD3aUVuXi438g29RdEZtmZ4Sol/jT8Ng26Po74BrU9
         W4qcbtwHWAjLq5gWlcuXNSnsIq4Z2lyb07+nKL+foU+UkFbnbufRQz8U04QwO6p0DyhC
         8o5v75j/L4tkgJzUrMPmqmyqT/YwhV/aUi9lDlTykw7OdyU+cQCEQR6gbkkVQgjs2Lnb
         dKdg==
X-Gm-Message-State: AOAM532RRcRWKwYEtLPyWc42tcuB6H0MhDvFzAtDjOFNY89UMj4tzr15
        Oshx2SbQjfWlhq8EDM0UbSccs7ArQZU7sN89j3P3+RJKat4=
X-Google-Smtp-Source: ABdhPJxAd5M6b2aGObHZq+GGi4ANVaIJp/NODKfeUM7GlfzxAjEPcCbEZkCYun8DRcMRVrknf4Tb/8BLw9D/wYjhil8=
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr892225ljp.221.1614324173112;
 Thu, 25 Feb 2021 23:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
In-Reply-To: <20210225165820.1377125-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Feb 2021 08:22:41 +0100
Message-ID: <CAKfTPtCXEEQBXTzm7+HVUrmXbuJJKAwRZNr2PP72c55-TSZixg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/pelt: Fix task util_est update filtering
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@readhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 17:58, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
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
> stale value. Functional-wise, it isn't a problem, as the value is always
> accessed through max(enqueued, ewma).
>
> This problem has been observed using LISA's UtilConvergence:test_means on
> the sd845c board.
>
> No regression observed with Hackbench on sd845c and Perf-bench sched pipe
> on hikey/hikey960.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9e4104ae39ae..214e02862994 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3966,24 +3966,27 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
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
> @@ -4004,6 +4007,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         if (ue.enqueued & UTIL_AVG_UNCHANGED)
>                 return;
>
> +       last_enqueued_diff = ue.enqueued;
> +
>         /*
>          * Reset EWMA on utilization increases, the moving average is used only
>          * to smooth utilization decreases.
> @@ -4017,12 +4022,17 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
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
> +               if (!util_est_within_margin(last_enqueued_diff))
> +                       goto done;
> +
>                 return;
> +       }
>
>         /*
>          * To avoid overestimation of actual task utilization, skip updates if
> --
> 2.25.1
>
