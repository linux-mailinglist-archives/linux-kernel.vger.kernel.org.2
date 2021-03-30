Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309BF34E76E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhC3MWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhC3MWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:22:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34173C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:22:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f16so19683829ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJNbEb32RRFyVDLPn81JyD/bPBWZa/kNrAZr1BiSP1w=;
        b=jJXra8JyRr28Ri9Kh50Maf13vL8FqoOYMzvk4p27Ttgv5b7uNNe75UrU4iT0RBkfNm
         GUUyKhT1YMemKc0IuRfF2qPmA7IxyciKvNHD30bE9X8xGjZOwbqSBwypqrUQpqlB38zI
         kw5Y0xJI82YmGjMSuC+tevxrBrNBimLDeZG13Zf2BMJ0ktI6kNjcbBRAWszMEobrrz5e
         tpxx7uJAVkHvCI9ISzkaazvrGX/snyKDClOzQMLZRDkSAlplQBmQpiiWOMITSwBQpnSs
         xEcVWPOlbk4sK79Ux8EhDa4Ew6JR4MlSuWapxq7VaXXC6quyypuR6T43gxi69V4yiLPx
         i1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJNbEb32RRFyVDLPn81JyD/bPBWZa/kNrAZr1BiSP1w=;
        b=R+y0fqdugGbjs+Tu/4AcFvwJUHaqBLutuvBXjlowfMtxUVhGKX9SOyQiMiDlYDoo4p
         VUhi4z2Zklskw7B9SupYo27NrQQ7z+HgzJWD2zG1t5FigEIXykkACmNyNLvP01PSPWFR
         sqSOw/XYuCD/B8z1klkuVpKkdcmArYlNTE2S2hPUhnbaxj06VN5cbtKpWBlpqnWBR/TN
         HpsUoNEyjWGDD2T3Rjd369ge3twr83262+v0ih/TU3QRMmMRTaGf7+S91djWYOWbOWf+
         QQhZTIEaggfXFoVnY/FDo4TN0HQaKE6k3fR23cZwj2oJJkp6dFoy6q2YZlVUpPz/6Afq
         5WDg==
X-Gm-Message-State: AOAM530urFmRW3tyS8yW413K5rhiH5FTyqEbwGGLbR9DPc0uf4LBoReR
        dBZarh9n4U5QbiPwfBeMi7GpjFYh5qNCFx5PgeV4wg==
X-Google-Smtp-Source: ABdhPJwZCAdho/WBGi1nNYG0210SXgvGhNSwcDGCpqmZOA+NrWob4mXZndnEaF4yCuqPvMATbL4X1/KB+t4UUkIU2Vo=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr21678300ljj.284.1617106932675;
 Tue, 30 Mar 2021 05:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210330120657.54173-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210330120657.54173-1-wangkefeng.wang@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 Mar 2021 14:22:01 +0200
Message-ID: <CAKfTPtB54L4Eq+Fh2bfJfc24T603O5QRwZNH3_AVmFumMx6Uxw@mail.gmail.com>
Subject: Re: [PATCH -next] sched/fair: Move update_nohz_stats() under CONFIG_NO_HZ_COMMON
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 14:06, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> update_nohz_stats() only call _nohz_idle_balance() under CONFIG_NO_HZ_COMMON.

a similar patch has already been sent and reviewed :
20210329144029.29200-1-yuehaibing@huawei.com

>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6d73bdbb2d40..2a20ada83cbb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8395,28 +8395,6 @@ group_type group_classify(unsigned int imbalance_pct,
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
> @@ -10380,6 +10358,24 @@ void nohz_balance_enter_idle(int cpu)
>         WRITE_ONCE(nohz.has_blocked, 1);
>  }
>
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
>   * Internal function that runs load balance for all idle cpus. The load balance
>   * can be a simple update of blocked load or a complete load balance with
> --
> 2.26.2
>
