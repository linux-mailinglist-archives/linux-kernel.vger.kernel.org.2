Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C023E5BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbhHJNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbhHJNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:34:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:33:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c24so14814607lfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msymKCQZINlKEMpC5ZqSfQlATdPMpj35mgpdhh0Xh80=;
        b=L08MBnkZq7Q+tas3/qiaTHgOznfO6u5wKDNFQnFqOXk9aszvtvgzeONnYVTp7k4Gok
         1uu0HIsBfGX9xU/jyN2Xc7VMAUtplVxpcLhkv7NTwCjpmzBauFOm0/GiUsce0Sw31woy
         YgqtHY8XTIwtABr+Re19Lz74LDxUQrRJR3o4CcbtaIszOOPlXOxKW+dyki1y0mV6cQwS
         +LyuGVq5CiTHRrKbeHRzTGXJ6aYR+0IQgm2VLm4cUNxhtbMV492KGX9vghNcDdMJ/x/R
         YTOg3JNX+Bh+K1d0MlO2115wn2FnLRVCvowL4jgvOvNto4bq20YkbX5YeD4F8IbwO94X
         QlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msymKCQZINlKEMpC5ZqSfQlATdPMpj35mgpdhh0Xh80=;
        b=TSToS7lieOyFz4kvGko+3UfBNDSMAIn2jOgIOcPNBI63LfwMVa6D5ujyeviQwt6OJl
         K+0zE2dEjdEV1mqj7erHKwP+/Drzbk8hDtxGF1r9ZQc9AHuLBNNAuypBHqtlJkzhIRSk
         czLR4yZ7LaecW0HgV2VGdylZrUHKwdx9BDu02S/nlKqlDQX5yHwpw2bw+QEzLINFX1/s
         VeVMsQk2LjzL+VbcD1nLO9b85Xr9C9Ox/a269XMapDSoMY4JncAQ6UhNC7EmqmVJDMJS
         deLQswTEceZ6qrFfrpbrGjA1x6grL26ReTiY54CQP7HhTtoZ+BAmUuNimEqQEZO1A7zY
         ELZg==
X-Gm-Message-State: AOAM533pLa/2qPo1lmwW7prdNvfrTAVHzP46wYY9kwm8KMibvNC0vPO8
        Hvo5s4DEzhDft/A11qyuX+hb6ImX3wACY9+sS1NeXA==
X-Google-Smtp-Source: ABdhPJyaOUdgmhj+9Ka4ZRaZN4+SS4B3RItXau0EkrhnMlke/0/JlXVXe+clWABFXjuAFMcTsSlD4tHGaGLtSOoK0Co=
X-Received: by 2002:a05:6512:228c:: with SMTP id f12mr22208052lfu.154.1628602427476;
 Tue, 10 Aug 2021 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210719103117.3624936-1-valentin.schneider@arm.com> <20210719103117.3624936-2-valentin.schneider@arm.com>
In-Reply-To: <20210719103117.3624936-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Aug 2021 15:33:36 +0200
Message-ID: <CAKfTPtB3ZTACegVSUtMnjR8kLGKFJB04wu4wgD81gWKcXi2tBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 12:31, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> A following patch will trigger NOHZ idle balances as a means to update
> nohz.next_balance. Vincent noted that blocked load updates can have
> non-negligible overhead, which should be avoided if the intent is to only
> update nohz.next_balance.
>
> Add a new NOHZ balance kick flag, NOHZ_NEXT_KICK. Gate NOHZ blocked load
> update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
> kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
> expected.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c  | 9 ++++++---
>  kernel/sched/sched.h | 8 +++++++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11d22943753f..5c88698c3664 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10506,7 +10506,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>          * setting the flag, we are sure to not clear the state and not
>          * check the load of an idle cpu.
>          */
> -       WRITE_ONCE(nohz.has_blocked, 0);
> +       if (flags & NOHZ_STATS_KICK)
> +               WRITE_ONCE(nohz.has_blocked, 0);
>
>         /*
>          * Ensures that if we miss the CPU, we must see the has_blocked
> @@ -10528,13 +10529,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                  * balancing owner will pick it up.
>                  */
>                 if (need_resched()) {
> -                       has_blocked_load = true;
> +                       if (flags & NOHZ_STATS_KICK)
> +                               has_blocked_load = true;
>                         goto abort;
>                 }
>
>                 rq = cpu_rq(balance_cpu);
>
> -               has_blocked_load |= update_nohz_stats(rq);
> +               if (flags & NOHZ_STATS_KICK)
> +                       has_blocked_load |= update_nohz_stats(rq);
>
>                 /*
>                  * If time for next balance is due,

You forgot to skip the update of nohz.next_blocked if NOHZ_STATS_KICK
is not set:

                 WRITE_ONCE(nohz.next_blocked,
                                  now + msecs_to_jiffies(LOAD_AVG_PERIOD));


> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9a1c6aeb9165..b0f38b5d2550 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2695,12 +2695,18 @@ extern void cfs_bandwidth_usage_dec(void);
>  #define NOHZ_BALANCE_KICK_BIT  0
>  #define NOHZ_STATS_KICK_BIT    1
>  #define NOHZ_NEWILB_KICK_BIT   2
> +#define NOHZ_NEXT_KICK_BIT     3
>
> +/* Run rebalance_domains() */
>  #define NOHZ_BALANCE_KICK      BIT(NOHZ_BALANCE_KICK_BIT)
> +/* Update blocked load */
>  #define NOHZ_STATS_KICK                BIT(NOHZ_STATS_KICK_BIT)
> +/* Update blocked load when entering idle */
>  #define NOHZ_NEWILB_KICK       BIT(NOHZ_NEWILB_KICK_BIT)
> +/* Update nohz.next_balance */
> +#define NOHZ_NEXT_KICK         BIT(NOHZ_NEXT_KICK_BIT)
>
> -#define NOHZ_KICK_MASK (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
> +#define NOHZ_KICK_MASK (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
>
>  #define nohz_flags(cpu)        (&cpu_rq(cpu)->nohz_flags)
>
> --
> 2.25.1
>
