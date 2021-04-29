Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1056436E679
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhD2IEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbhD2IEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:04:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D50C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:03:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n138so103596130lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gnd6O4oFr8eoxs7HqCftImAYJEiOnl1jHGhp+7KYeXA=;
        b=spnUp/PJZqWDOb5TdhiS/oWQjUgM2HfNnjWL6vqDv9elr2CfYoUHeB+4AmNkwcgNSW
         yIvfKRYyIrTDMkWlISdIvVv/elgUTTmRtWMm8SJAxwPa6036Vg01VbZ0cwuluQlQx2u8
         fbl9HsiQMeyu/4fzvmblfKCbJGfeW+R4cTEhbye7R4NRdEbOYMVL/qINngNTjWTVIky7
         Oz3hTuOs1YC1BxbCGT3tzAKoEaM08SlTf4peoZsifoW78PIVyLmU903pyTbqCYtXkd5y
         /OGgFJKlHdsxGAwQGxt5yAx/HLFBu3wvlqJhxLh1e7HqGulhu32V3RSqAlpVSozbgndj
         6c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gnd6O4oFr8eoxs7HqCftImAYJEiOnl1jHGhp+7KYeXA=;
        b=EO3zNa5GxBAIWqgDRTDqVRl5s4Ulq/FdCYJTY8ZoIh61GGhgba88iiwQVkYmwH8wlG
         bLIH9Ur02YcDILO4RqlWW7EzzfhRJV7pDetMbNGfq2Ym9J7f96U0+A2VCmk8M1MPweQu
         Hm3XtEXzKL5wlgSe6QZoKrFNKOK27Y96q16R67zek5Bp/e1nMTudnNpa4HO4bPenAnzb
         HEe/54+7Ohn8WQmWlOYnM9bNqP84rhHQh1aiyArcEsSoQqcJHXkuZwqN9Y7RMwjHemBf
         /8oDp//kQLbnwSMN1IogZQgA5hKvl/87gcfCy7ebo/yozzit0cNUPxZmnFOh2iY61yG/
         snOw==
X-Gm-Message-State: AOAM533ZFUkgHM32XBWwC9hccAWAaLY7odG2iv2Ahph/zzlJvlwjHJgT
        ASh5eNnT321iTOzLDyc8YC53ZTZGJc7ix8dF4E4=
X-Google-Smtp-Source: ABdhPJw6k2Vn1URyd/a1rHppgDi1WkjkK1jy/eN6LT88OSy8/8s4vCLjKJBWD0hcKdr4+jjnSBFoVzCAdt2TFCFQQfI=
X-Received: by 2002:ac2:4545:: with SMTP id j5mr24955603lfm.227.1619683421897;
 Thu, 29 Apr 2021 01:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
In-Reply-To: <20210422123308.196692074@infradead.org>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 29 Apr 2021 16:03:30 +0800
Message-ID: <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 8:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> When switching on core-sched, CPUs need to agree which lock to use for
> their RQ.
>
> The new rule will be that rq->core_enabled will be toggled while
> holding all rq->__locks that belong to a core. This means we need to
> double check the rq->core_enabled value after each lock acquire and
> retry if it changed.
>
> This also has implications for those sites that take multiple RQ
> locks, they need to be careful that the second lock doesn't end up
> being the first lock.
>
> Verify the lock pointer after acquiring the first lock, because if
> they're on the same core, holding any of the rq->__lock instances will
> pin the core state.
>
> While there, change the rq->__lock order to CPU number, instead of rq
> address, this greatly simplifies the next patch.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |   41 +++++++++++------------------------------
>  2 files changed, 57 insertions(+), 32 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
----snip----
> @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
>         raw_spin_unlock(rq_lockp(rq));
>  }
>
> +#ifdef CONFIG_SMP
> +/*
> + * double_rq_lock - safely lock two runqueues
> + */
> +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> +{
> +       lockdep_assert_irqs_disabled();
> +
> +       if (rq1->cpu > rq2->cpu)

It's still a bit hard for me to digest this function, I guess using (rq->cpu)
can't guarantee the sequence of locking when coresched is enabled.

- cpu1 and cpu7 shares lockA
- cpu2 and cpu8 shares lockB

double_rq_lock(1,8) leads to lock(A) and lock(B)
double_rq_lock(7,2) leads to lock(B) and lock(A)

change to below to avoid ABBA?
+       if (__rq_lockp(rq1) > __rq_lockp(rq2))

Please correct me if I was wrong.

Thanks,
-Aubrey

> +               swap(rq1, rq2);
> +
> +       raw_spin_rq_lock(rq1);
> +       if (rq_lockp(rq1) == rq_lockp(rq2))
> +               return;
> +
> +       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +}
> +#endif
> +
