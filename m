Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D188366DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhDUOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhDUOQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:16:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:16:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o5so14828694ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuRT+cEX13GmBZjn01jGHuNHCegjg0HPoMc2IxBEC8U=;
        b=CxHRZ8FsK9JWepAcL+oNT6/LVYtAnnddsBle9wkW6b1+p+gH6x/FgxpahOREFGmul6
         pfFd0tb4RYHmhnDuCRXtqHJJY1GlYC4ZZ35pgMfGs4q4cLEvsc3dh2FGpiM/ioaNlPN4
         fTuR3LTmwqdH7goZPNAlnEMwJ5FOWCH3lmf8bKYiXoj5f4s10M2mTZ0ivZfKX7Q5hMYV
         ACCFEjtp/ItVy8EzR/D9fSJtJ1ZvD4DaeqguEHQzxOCEkL2eJ/6S4I/CJaKCTIEfAYAY
         qQGqiYP487jHjOYgHxa9XcJypHXORbvUb8OJoXIjtCJetlAV8Dz5VXPl9T1Bo0AvH32O
         Xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuRT+cEX13GmBZjn01jGHuNHCegjg0HPoMc2IxBEC8U=;
        b=eqIpaPwKQYQs6MVhWqQoM7NMBLV53jUS8fzCRoLx6zTuagImZHWHoLj0IFTtBXWggw
         k5sKrgeN8kM8Tp4JrxEXcvFA+lnbYQ8E88Vs9q6nzIo1w5LXN/DZ181iSq1+xk6ohJys
         MNdCV6OS5xIE7FaJTfDbcZSLvJ/v+P4J2s5AQjtgJ4UkL7y1f84dHyO5QuZMD2a4h6e4
         VJDgcGPA6JgClSjS6JM0ycWOnj1UrJP5dVi6qTtzFPfv4QQ8NkFCh3Nai3IYbs579NQD
         5FBuuZVJ/Du6fWFXGS3BOqJBQCooYDdweuvv+Lm2MfP9yIOHICeSKppe0lWU9b06+hlY
         SmVw==
X-Gm-Message-State: AOAM531rJAzF9fJmOG9UnPKyHei7SvPp2ix4khe1zXO1dGXTaE2ZhIp5
        gDPqMNEk0iyjW902W1Ba+luALz/rfvriO5afeXpIXg==
X-Google-Smtp-Source: ABdhPJzruxVqOIMJnQM93Da/KN02ukS13SXDE5ttNgQy6sZ4BWo0YNp4sbmmtQDS0RTs0w3YzjHG4DhGBaZW9mYWsvc=
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr18610826ljp.209.1619014559481;
 Wed, 21 Apr 2021 07:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210421140145.3767949-1-arnd@kernel.org>
In-Reply-To: <20210421140145.3767949-1-arnd@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Apr 2021 16:15:48 +0200
Message-ID: <CAKfTPtD3t4MDj1CBstTuN6XivdrVgu8ETpwpbJvbTEyKhJSd9w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix an unused function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

A similar patch has already been merged in tip/sched/core:
161890837554.29796.9442405099846421634.tip-bot2@tip-bot2

Regards,
Vincent

On Wed, 21 Apr 2021 at 16:01, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_NO_HZ_COMMON, there is now a warning about update_nohz_stats
> after the last caller outside the #ifdef was removed
>
> kernel/sched/fair.c:8433:13: error: 'update_nohz_stats' defined but not used [-Werror=unused-function]
>  8433 | static bool update_nohz_stats(struct rq *rq)
>
> Simplify the function by removing the #ifdef inside it and move it into
> the block in which it gets called.
>
> Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from newidle_balance")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df2083d2dd0c..7c3edbb5ec70 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8430,28 +8430,6 @@ group_type group_classify(unsigned int imbalance_pct,
>         return group_has_spare;
>  }
>
> -static bool update_nohz_stats(struct rq *rq)
> -{
> -#ifdef CONFIG_NO_HZ_COMMON
> -       unsigned int cpu = rq->cpu;
> -
> -       if (!rq->has_blocked_load)
> -               return false;
> -
> -       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> -               return false;
> -
> -       if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
> -               return true;
> -
> -       update_blocked_averages(cpu);
> -
> -       return rq->has_blocked_load;
> -#else
> -       return false;
> -#endif
> -}
> -
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -10123,6 +10101,24 @@ static inline int on_null_domain(struct rq *rq)
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
> +static bool update_nohz_stats(struct rq *rq)
> +{
> +       unsigned int cpu = rq->cpu;
> +
> +       if (!rq->has_blocked_load)
> +               return false;
> +
> +       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> +               return false;
> +
> +       if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
> +               return true;
> +
> +       update_blocked_averages(cpu);
> +
> +       return rq->has_blocked_load;
> +}
> +
>  /*
>   * idle load balancing details
>   * - When one of the busy CPUs notice that there may be an idle rebalancing
> --
> 2.29.2
>
