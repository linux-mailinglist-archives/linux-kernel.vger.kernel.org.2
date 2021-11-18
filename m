Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78A1455D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKRN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhKRN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:57:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28677C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 05:54:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so26224024lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4q9DAjsmZKwFuALby9TwAbuHEt2R8Th0XT3W3M1Jgj8=;
        b=Y2jezDvNc4YPSXZq3Ga4UJTnjKhETBFj0/sS+DACbpreoFQmSVQUwe42LpJJFmNCbv
         UsBVJZpSbJwADD+RkGne9wcklUBZAfPMXPTo4ihNdDH9ifZxFOMknDj7rzxRXewqRbqC
         61np5xZZ5K6fSkMH7USHWLq49r5s9kRDfKls3O/U2Q2vA/JDxoAhL/2YR1aA8ZAzUEnY
         wvwsPmglsdX1dWMP5okeKAmzoyvD0GfHB8wYrKcG33/bZoMd+dJ88aAxP1YwpQ3ae2CY
         RRTR2QC3yOn2XWsDnzQB4IxKiJpz4BeDJAHyT6Q9EaCMMscC/+rnIQmm9FKM8HKc646p
         62gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4q9DAjsmZKwFuALby9TwAbuHEt2R8Th0XT3W3M1Jgj8=;
        b=A8pB7FRoWDRi/B77e09Ts7caVbZcnt9dbRApLWicyKrwF86FsVHBr21dsev1EBtoyt
         htuOdFw5h0woX08ZU8xXxW29gIStMTRNikLC3t3YqlQrdq5Ngl4PHJM89EpDvM2ANgv7
         HAEu4tpDJnnY+9OZPmopIlPYQGki4yNM1qgRNzQXYXd4eCn53tekGkBbnc0hukS9M9kO
         ABuc2fLGPTAwQ8JzRICLEuzUtN3hojnQWjCeoj5I8NTwZRnxmkO161e7eTYQXq+IUSGk
         Js/7i7UZs8H43dBF5ocYX6jbObizdcK6ScOw5D3sQRv8SoFzlveUJOvo2jI9KJqihZwC
         8RsQ==
X-Gm-Message-State: AOAM531Y7gI6oV/NGuEfIU5uhG4rVeZpqagb/SBrlDhqlOAzdqwIC7wa
        YKcowo7jfvAp+W4FXauFe+ah1NyPY3x7S70KUnfa/w==
X-Google-Smtp-Source: ABdhPJwjWpN2gg73aG3t4ARK3RSmdrc3qVWo9tmmg3bKl/vdwosPLRBTlDSd5ZuWKTwuGifrMBSv7h0ihQGkKwIYQ00=
X-Received: by 2002:a19:fc08:: with SMTP id a8mr24436167lfi.645.1637243689462;
 Thu, 18 Nov 2021 05:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20211118110152.2598200-1-vincent.donnefort@arm.com>
In-Reply-To: <20211118110152.2598200-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 18 Nov 2021 14:54:37 +0100
Message-ID: <CAKfTPtAU9t=X8e3WiVh=pd-JwQwCroGz6xiyuj-WwqsEwOcMxA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix asym_fits_capacity() task_util type
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 at 12:02, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> task_util is an unsigned long value, compared with a CPU capacity which is
> unsigned long as well. There's no need for an intermidiate implicit int

s/intermidiate/intermediate/

> cast.

I can't remember how I end up using int instead of unsigned long

Side note: similarly task_fits_capacity uses long instead of unsigned
long for cpu's capacity parameter

>
> Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945d987246c5..8fde6e10e24b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6346,7 +6346,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         return best_cpu;
>  }
>
> -static inline bool asym_fits_capacity(int task_util, int cpu)
> +static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
>  {
>         if (static_branch_unlikely(&sched_asym_cpucapacity))
>                 return fits_capacity(task_util, capacity_of(cpu));
> --
> 2.25.1
>
