Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D450334AB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCZPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCZPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:37:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96FC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:37:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w37so8246384lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM0xK7r+mkYw/U2QBelKOZgWr9rGnvKjDd94IUIIsGo=;
        b=dHyHUhqlXqrVKX2LPdnfaccS6R4PrBAipe0TKaeIDS/e/nW54Kzepu5jSDXycg8XGw
         jOU6c+B5hmLi5WizIg+9vZbuUy4FOTGRHcxBObzdCVNQGWQRuRBq32rqWBHtcJcBHJP8
         bURYtVWTV18ZN+ey/Lowh7gnBV5YwzKTWpFu111wCeMvdngrOEB1EuNk4Nb8vy5whgS5
         BpOsOrANya4/Gsb/juJQ8CBiH+2+JmUE86Zbtlqc/Wbu53WnhwawzInc2/RJ49znlRbl
         XAKvbEgN51xJXaIKPeISY6PzA83OahSZ0Do8yKU1zvXWEM9NE2fa+3SyNCC9jeaTHBIj
         Pn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM0xK7r+mkYw/U2QBelKOZgWr9rGnvKjDd94IUIIsGo=;
        b=JOSlJsrlDkkx6EPCld3ab9XXDhgihaBOMsYZV64nSDCd+gGQqAUwWNFkFg4F+O6FxW
         r4uGB5m+qi6+NciC73XJDm8wzo2idSgvw3ooRh/1VPjE5FPK+sTTT6KFfJPtuXf4Uc8l
         8Ln5dW+tJwfl7gdThu9ivPwWuJlks6JByPByqJsg5NKzSDmcZPrRZfjaDw567461za4r
         TPmbe1q2YFg/BALz2/gqevde9fUHt53Nx8KbAE4/DRBbbmBAYRNNE8GQpfDZvBKOeWPZ
         MJoN4/SCT5n9ePpQs4Q7DWrGpCqIIcS5MgRaMtKuGL5aUx06CPEhXGoS5I/Aok/D4CLu
         jplw==
X-Gm-Message-State: AOAM532if5Hcd+GRnkL0PT8DcbUN7P/yV6jaZO649XtHHsJFqw76Juec
        8ML1ukL5t3qo015BJFdURZVxgM365B78J+8EBhs8dMfp4VUQ9g==
X-Google-Smtp-Source: ABdhPJypaf1aeDE+EVcnxRpuKJpd3+qERNvpAbyFQgw3EFmGr1EWZCSFDGscp1gkYZs+GFxdS8xpN60MEjeNH16Aexg=
X-Received: by 2002:ac2:53a7:: with SMTP id j7mr9195260lfh.305.1616773034195;
 Fri, 26 Mar 2021 08:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210326103352.603456266@infradead.org> <20210326103935.444833549@infradead.org>
In-Reply-To: <20210326103935.444833549@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Mar 2021 16:37:03 +0100
Message-ID: <CAKfTPtB0NEQhuphhYXDZTQvgmLxoLFvbT17gcz6aTrdMUf-_Vg@mail.gmail.com>
Subject: Re: [PATCH 9/9] sched,fair: Alternative sched_slice()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Don <joshdon@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 at 11:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The current sched_slice() seems to have issues; there's two possible
> things that could be improved:
>
>  - the 'nr_running' used for __sched_period() is daft when cgroups are
>    considered. Using the RQ wide h_nr_running seems like a much more
>    consistent number.
>
>  - (esp) cgroups can slice it real fine, which makes for easy
>    over-scheduling, ensure min_gran is what the name says.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |   15 ++++++++++++++-
>  kernel/sched/features.h |    3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -680,7 +680,16 @@ static u64 __sched_period(unsigned long
>   */
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> +       unsigned int nr_running = cfs_rq->nr_running;
> +       u64 slice;
> +
> +       if (sched_feat(ALT_PERIOD))
> +               nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
> +
> +       slice = __sched_period(nr_running + !se->on_rq);
> +
> +       if (sched_feat(BASE_SLICE))
> +               slice -= sysctl_sched_min_granularity;
>
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
> @@ -697,6 +706,10 @@ static u64 sched_slice(struct cfs_rq *cf
>                 }
>                 slice = __calc_delta(slice, se->load.weight, load);
>         }
> +
> +       if (sched_feat(BASE_SLICE))
> +               slice += sysctl_sched_min_granularity;

Why not only doing a max of slice and sysctl_sched_min_granularity
instead of scaling only the part above sysctl_sched_min_granularity ?

With your change, cases where the slices would have been in a good
range already, will be modified as well

> +
>         return slice;
>  }
>
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -90,3 +90,6 @@ SCHED_FEAT(WA_BIAS, true)
>   */
>  SCHED_FEAT(UTIL_EST, true)
>  SCHED_FEAT(UTIL_EST_FASTUP, true)
> +
> +SCHED_FEAT(ALT_PERIOD, true)
> +SCHED_FEAT(BASE_SLICE, true)
>
>
