Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BB33BED3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhCOOtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbhCOOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:24:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:24:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z8so16446594ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ycRI+EUL60Frat+dcTTqOlzXPNrC+V8NzgLq8y0+t0=;
        b=sbKOxNDEJsVSdxm5LxIMPOnKlwOt3XHq338W+CG1BuSo2dt43yu8WrmJ+ALvS5vtLD
         3UWrK69oAfrZXp5dSc2X6qFKpbZcioFNDOkBf18KB6o4FYAmVgapzXH36XCdDBcnmoW/
         ssg5LW/sbZIOcNdUm/Gi7DByCwnX15wmx4FjFzl5agHjP4jZ15LZrP+8RA0grOn0/BqH
         4GuaEP5JOYouofhpFS+mtuSMlDFBy1MLIsiJux8tIvtLDjaYfdhMZSCtGvpwFoF8Evr9
         wKiwislkFgFygZ+Oz4xZzP4a+i56XxmpuT2+217Fpb8zEMrwVV/ZLK2jbKEu2lpT+mr2
         w5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ycRI+EUL60Frat+dcTTqOlzXPNrC+V8NzgLq8y0+t0=;
        b=nEKpLr0l3CsV296spVKDeK46XY4YuCzUJK5fPZmDeSSkzHl3g0yLF+47KQY55RjohW
         48/xqTUgLrzSBAiZSBsW+/WRh52A8ONSCNFRnSci9+/fZhpnsmzWlGlF9WYLlSUm4BBG
         zni16fmJBZo/72def+UvQjzKyhft2Rfi+wTlFtL8fSOSP2wEYU0pRtLwZVVsHTg6StJF
         gsWx8GWa+F7OSqoZ/4Rt1mHDfyh8AOjNidAxCxEfYcmdm2uEWVEwTJEyyWuLJjnraPUj
         ZoaHjlqoY0jATQYcBIQUG0JG6GxwNtKfUSSOiWC2syobsF/8jycYyji5HQxbrvo/4P7w
         OPtQ==
X-Gm-Message-State: AOAM531TmmXzZHk+jeAyvFcLNAAB4M+EamScgDyRZy5ewaYr4OXUpLdI
        Ojokg3ceN8hTMeGFHSkOdN0EDlOvNvN1V/wm22ZyaA==
X-Google-Smtp-Source: ABdhPJxubPRm39mWekDQAH5iPq/iEp5fTgksQ+xD6c8nJD5fBg9o5wTwWFuOJunp/za59AYSXAQSrk6/0DXUpgPPtEs=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr10303034ljo.176.1615818289488;
 Mon, 15 Mar 2021 07:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-5-valentin.schneider@arm.com>
In-Reply-To: <20210311120527.167870-5-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 Mar 2021 15:24:36 +0100
Message-ID: <CAKfTPtCdT4Depo4BX4bT4tsYLxDRcfwx+znKpt7MU5GSTwEtDg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sched/fair: Introduce a CPU capacity comparison helper
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
>
>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
>
> which itself employs fits_capacity() to compare the sgc->max_capacity of
> both groups.
>
> Due to the underlying margin, fits_capacity(X, 1024) will return false for
> any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
> {261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
> CPUs, misfit migration will never intentionally upmigrate it to a CPU of
> higher capacity due to the aforementioned margin.
>
> One may argue the 20% margin of fits_capacity() is excessive in the advent
> of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
> is that fits_capacity() is meant to compare a utilization value to a
> capacity value, whereas here it is being used to compare two capacity
> values. As CPU capacity and task utilization have different dynamics, a
> sensible approach here would be to add a new helper dedicated to comparing
> CPU capacities.
>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index db892f6e222f..ddb2ab3edf6d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>   */
>  #define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
>
> +/*
> + * The margin used when comparing CPU capacities.
> + * is 'cap1' noticeably greater than 'cap2'
> + *
> + * (default: ~5%)
> + */
> +#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)

defined but not used.

Should be merged with next patch which start to use it

>  #endif
>
>  #ifdef CONFIG_CFS_BANDWIDTH
> --
> 2.25.1
>
