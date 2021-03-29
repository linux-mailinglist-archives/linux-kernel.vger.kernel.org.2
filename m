Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926A34D02C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhC2MgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhC2Mfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:35:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09557C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:35:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so18194997lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n1IncH0o+Fbn3l3HmjK+H5MF2/RPQONn5amAdScKdNE=;
        b=QVsEe5lWyfXAcX2wfBOXkhtl56eNC3CrPHVpXJuZsXUsKRjp8YWrwOacO+tdzxAD4a
         Lf3E/cCTbatm4a+3j9ioIbb8yZnhcSUAN1n7hVZ1ygwMyBkT649cd/FPz451/KBe9N7W
         RVyTE5nYZ92LSqYgNccbfx7RAAsHbTF4KgAPoCh+dI85/ck8gyRSDoKzTK+nTxoH9k6o
         JL4q3gVNAniEu5FKxL9YP4TGlzkmP7MO1nPQVVJU71AMGlWlGflUBW8lYpqIFcZF3rGG
         h/9M/974WYnX6dKTugPLTxEp71BAydtGLv+b/tvDjfRfs8TPP+X9I6MvmeA31jAmeEcY
         pLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n1IncH0o+Fbn3l3HmjK+H5MF2/RPQONn5amAdScKdNE=;
        b=A4hGEa+HF3EEKVBnK/uEseXaAMyFhmdi14SPTD4RYScgp+my9U117lfRyD8hRtY9vW
         hi1nPT3rIdd55w0jjqML2d2l847GjgoJ1WuQxK/EPFqthz86Puj4JGQHxHrbZ4nCmJO5
         lT7OjK+Vs59PFm9H2khZoV0lD14pgv4PYcDLjahAr1g17dFFrQoXm+4D641txloK11/i
         X1LqcdzVwmOyLfrS+38mpusE3E3RDKq5sq3WjheNakdhQvmoDOhyupse7ZAGThq0Khby
         DEAp95Mn75mwbaKl7BaZpjshyRmV4zfxdAJicxcycHq7YIIG0xpeD+7NWgRjX/DweZRO
         MNCg==
X-Gm-Message-State: AOAM533n3lMFrwyfdiUScTmK8VFUCGnPlFWh0rIGYF5EEYE3tEZz9rPV
        XHyb/3k4tmBTBckIKnQo2z65u8J9qh2j1kuGHh01RFm73PzyNA==
X-Google-Smtp-Source: ABdhPJzA9qkF5Zo4NEI1gmtTvoNWNLwSTVFUbI7qlMepk+VbxYaqJ8m3aB1cd6o2cx4pnBa6OOjxHxG9xewEQYgsruE=
X-Received: by 2002:a19:f812:: with SMTP id a18mr16865082lff.254.1617021340508;
 Mon, 29 Mar 2021 05:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210327135600.27836-1-yuehaibing@huawei.com>
In-Reply-To: <20210327135600.27836-1-yuehaibing@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 29 Mar 2021 14:35:29 +0200
Message-ID: <CAKfTPtDtfD2B+5AeTYaZCGJZiRtqvnGBdK0Hp4AqC40r5=3=Dw@mail.gmail.com>
Subject: Re: [PATCH -next] sched/fair: Fix unused function warning
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 27 Mar 2021 at 14:59, YueHaibing <yuehaibing@huawei.com> wrote:
>
> while CONFIG_NO_HZ_COMMON is not enabled, gcc warn this:
>
> kernel/sched/fair.c:8398:13: warning: =E2=80=98update_nohz_stats=E2=80=99=
 defined but not used [-Wunused-function]
>  static bool update_nohz_stats(struct rq *rq)
>              ^~~~~~~~~~~~~~~~~
>
> Move update_nohz_stats() to #ifdef block fix this.

Could you add a fix tag  ?
Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from
newidle_balance")

Also could you move update_nohz_stats() closer to its only caller
_nohz_idle_balance()

With these small nits above:

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6d73bdbb2d40..c7a7ef97d167 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8395,28 +8395,6 @@ group_type group_classify(unsigned int imbalance_p=
ct,
>         return group_has_spare;
>  }
>
> -static bool update_nohz_stats(struct rq *rq)
> -{
> -#ifdef CONFIG_NO_HZ_COMMON
> -       unsigned int cpu =3D rq->cpu;
> -
> -       if (!rq->has_blocked_load)
> -               return false;
> -
> -       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> -               return false;
> -
> -       if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_t=
ick)))
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
>   * update_sg_lb_stats - Update sched_group's statistics for load balanci=
ng.
>   * @env: The load balancing environment.
> @@ -10097,6 +10075,24 @@ static inline int on_null_domain(struct rq *rq)
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
> +static bool update_nohz_stats(struct rq *rq)
> +{
> +       unsigned int cpu =3D rq->cpu;
> +
> +       if (!rq->has_blocked_load)
> +               return false;
> +
> +       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> +               return false;
> +
> +       if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_t=
ick)))
> +               return true;
> +
> +       update_blocked_averages(cpu);
> +
> +       return rq->has_blocked_load;
> +}
> +
>  /*
>   * idle load balancing details
>   * - When one of the busy CPUs notice that there may be an idle rebalanc=
ing
> --
> 2.17.1
>
