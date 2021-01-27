Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078CB3058BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhA0KpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhA0Kke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:40:34 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760ACC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:39:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t8so1476888ljk.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kynONSqCbqdcdiah54rWGTqQzykbjM1cg4MBwXEB1H8=;
        b=iJDPLKg6uKjqwHR3jX23Avi06ct0dryd2wx/ddYmg3k4eScn844B2XKnDt2iHO7eKF
         /mezplxCHVF9hd6KPY0a0mj625TfjDdtpcZeNL1icY8e55PY7P8SRdv73ubmAH8U0q1V
         Db/QNLAuHPeVMRF3/qfPve4Pg1YgtHJFy72WFP40nPINwFsK6vKwAmwAyfMUj5wm8eTZ
         93a0VT671e+yqFxa9+XCnrQRdyouoASfhMMuitS9Y7fKf1v8iU8OMSMyV383EqRKg+/v
         HNp1bdPn0QaThgDlQyHxrcasxUNYl15xTaZGXvbyuP7GoLNxHPSqj8zMlLQAY8zyVnc3
         SNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kynONSqCbqdcdiah54rWGTqQzykbjM1cg4MBwXEB1H8=;
        b=L7X94kGLh8Lgjop/mT2FpouiCWnsdciXGMxzxsG1doUq+WG9PDCauWSTKRaoU48ubC
         ERn9YDUKNp876vDveqGFdh2mNPPgWavAUGsUb+jpTb0YzKqHmgkuYAqvny//JjbLHG2g
         qvaHmqSALU1pBpmaAMagbrPepFA1Qf5wDCAf7zsgGzN3JZeiD9GPIBB2mrGBRx5jyfy6
         hB0Z0I+VLJcUOLSkedPFYn5BAb0gmNmjFdZOLKsd0pt0sZpnsBhN1QV6kWB/TzHC7ujG
         0eduC/M8WeAUR0biM7KpaPQpAxyiyhaLlyXB3ycQ6obPmIPsSP78899wrenhlXo+cdFM
         DKBw==
X-Gm-Message-State: AOAM530R2t4QIzTR7hdEAZ9ufthXth+XOkXEIiUD3yWH1LiGNBx9sf8J
        sURueRJcSre21z4Q49ugGATba+GeudCue246jLdZVA==
X-Google-Smtp-Source: ABdhPJzbKSwPkXZnuJDhuDNWIslaKQJpEoGEa0ZfbWEIcK60fI/L5xGq57v09mVH4pXgOopy4NgjHKdsielgFzuXLGk=
X-Received: by 2002:a2e:9548:: with SMTP id t8mr4669192ljh.284.1611743992878;
 Wed, 27 Jan 2021 02:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20210125085909.4600-1-mgorman@techsingularity.net> <20210125085909.4600-4-mgorman@techsingularity.net>
In-Reply-To: <20210125085909.4600-4-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 11:39:41 +0100
Message-ID: <CAKfTPtBLVHkdBKJetToWpGoFQemd6dQ9xF8Uj07sipKNUjE+sA@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/fair: Remove select_idle_smt()
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
> From: Peter Zijlstra <peterz@infradead.org>
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> In order to make the next patch more readable, and to quantify the
> actual effectiveness of this pass, start by removing it.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8d8e185cf3b..fe587350ea14 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6101,27 +6101,6 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>         return -1;
>  }
>
> -/*
> - * Scan the local SMT mask for idle CPUs.
> - */
> -static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> -{
> -       int cpu;
> -
> -       if (!static_branch_likely(&sched_smt_present))
> -               return -1;
> -
> -       for_each_cpu(cpu, cpu_smt_mask(target)) {
> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> -                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> -                       continue;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       return cpu;
> -       }
> -
> -       return -1;
> -}
> -
>  #else /* CONFIG_SCHED_SMT */
>
>  static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> @@ -6129,11 +6108,6 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>         return -1;
>  }
>
> -static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> -{
> -       return -1;
> -}
> -
>  #endif /* CONFIG_SCHED_SMT */
>
>  /*
> @@ -6323,10 +6297,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> -       i = select_idle_smt(p, sd, target);
> -       if ((unsigned)i < nr_cpumask_bits)
> -               return i;
> -
>         return target;
>  }
>
> --
> 2.26.2
>
