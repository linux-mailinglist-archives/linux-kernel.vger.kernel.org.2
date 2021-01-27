Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DE3058B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhA0Kpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhA0KkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:40:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AACC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:39:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p21so1943232lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4lOVt6ZKP6X65zmcQnK/fTCLUDcVKs75zqu4Rk/goo=;
        b=EuR5hlL1WDbKVmfFqJ2XhAFRLSg4OxybvOarE3EXYcqPCMXlKYSu65UdJyrWRw4TNK
         DkTKXLz1vImwdxiZ5KWdqhBJhZHi82Quxr3nsroNkub0QcOS/AVcm2OTxxTstFUUId4O
         eiaGl6sny1clqiU6xhqXdWu8FUReXoNpTx4MxQpsCU+dETKGM9M9k3D9fCuYnb5vMpb4
         tuB6uXv94s6RJD7JGY7SwTlsc1Y4qgev+v6JlUa8c0DMewkvH9fGosNrXb2kRu+vuQhv
         vTvcGY8JNcte6xk7uYOr6xCoiOkuJmb3zZuzQcjRMlRkQMZDENsAYQYpPl0VGllzO4UX
         Eweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4lOVt6ZKP6X65zmcQnK/fTCLUDcVKs75zqu4Rk/goo=;
        b=q2hoS5R37Aqpd58EpmIGH9tPG4YfVI68h6pClW57ssiNbSqmnb85FTdPgcnrHVR///
         0qgjMLu2Myz+CgRU+750ZKEqtgKTH0qOur00ZQzULNtP0e1X+3KBRJNdBrQVfS12acdG
         OXH2nXohQrusJtNlR9sOJ2xk7B/qjrsQa9DlT8eUF/prQacW52wLKJrsM1pE7wwwYyC2
         L4awkymQiIr2NBB/Iu3Rf7gaQwzKeI+kDhYGLivhYeESMoBKIKYHGHBVV8dmCSiPPd9r
         lj/pBkfW3De0zFlh2N1vPig8maiLJ3VZPIlplUKpV8WyGD9WJcJQh8/kh1wGGRFEckqP
         taOA==
X-Gm-Message-State: AOAM533TVP0wDnypP++hnDv8kYoNng/+FPQIKrDS97NvZzPXsoDWjhrz
        4nS5yey6DV+jZMUzldhhH1+a1EfTOpNZZw9a8Gdmbw==
X-Google-Smtp-Source: ABdhPJwGMekstctKpOsuXjs8DjGFT2ro5YAYYi+FiaLL95LqLgf1Pt7ScBb4SY6NPcj7lNQgNhIKIXnjV47Hq3C6jKM=
X-Received: by 2002:a19:ac45:: with SMTP id r5mr5192707lfc.305.1611743974915;
 Wed, 27 Jan 2021 02:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20210125085909.4600-1-mgorman@techsingularity.net> <20210125085909.4600-3-mgorman@techsingularity.net>
In-Reply-To: <20210125085909.4600-3-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 11:39:23 +0100
Message-ID: <CAKfTPtCuUdr+Q++MbbVafEx9wEoJYQGm9maoJ4RCX7ny+=qA5w@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under SIS_PROP
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 09:59, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> check and while we are at it, exclude the cost of initialising the CPU
> mask from the average scan cost.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9f5682aeda2e..c8d8e185cf3b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         if (!this_sd)
>                 return -1;
>
> +       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
>         if (sched_feat(SIS_PROP)) {
>                 u64 avg_cost, avg_idle, span_avg;
>
> @@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         nr = div_u64(span_avg, avg_cost);
>                 else
>                         nr = 4;
> -       }
> -
> -       time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +               time = cpu_clock(this);
> +       }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
> @@ -6181,8 +6181,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         break;
>         }
>
> -       time = cpu_clock(this) - time;
> -       update_avg(&this_sd->avg_scan_cost, time);
> +       if (sched_feat(SIS_PROP)) {
> +               time = cpu_clock(this) - time;
> +               update_avg(&this_sd->avg_scan_cost, time);
> +       }
>
>         return cpu;
>  }
> --
> 2.26.2
>
