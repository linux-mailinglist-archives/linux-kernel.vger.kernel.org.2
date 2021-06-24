Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB853B2EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFXMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:19:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C74C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:16:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id k8so7446452lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd2G7MEytYnI4W67in1ikvPZSnOK3PwT1ikArpu7gco=;
        b=WcFBE/AsZX87uV7wUy87EHLefUVJ0UMT74cgFOZKxanSipUOfmycTfbNfMbJSNN6yg
         YbkiGqZBtosEGCSfEYu+RgIFr1Xq5Dz6Z0JKBeKbT+B2tv21mQYkawc/YiRj4LLgznDY
         jNGT3OlJFSC3/FrOgsUMHE1NPd9Yt3MYNljK7j1yp8zCW4hppc2w25Z1cNS2QCXjT0CH
         XUT1GhS3VJiVt53Wm8Rpw+xc7E3PsmLif0CH6J+gigftZ+UqNKnoePNLbQyRr82MHYfn
         q1U0h/6ZuOlXkOVgFxQshBNu/F8qwZ1eUrjOGlbsMHGYsH6ARckYitB/nsxaA9WjNb80
         qZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd2G7MEytYnI4W67in1ikvPZSnOK3PwT1ikArpu7gco=;
        b=UuPQ36g3wbjfDHDDJDx8v9ADtQDUfZkx6DaKTATYcAof91m6bxHGIsjZuu90Fmny/h
         VPSSNGMpND7IBlgZEMODklvfk+seIlfHcPFBKg6eO39tlbOaY5iXVS9w6NwRpziB284y
         jxPUPcYGUFvhLPxrCow70STatwJ+20CGyJn83fRL2yqN5Q13g7FY3gY3iJAt0//xTswo
         n79ljOXSpunN40Tjx0tB+yg9osTjjxCx8wuF9pOTE+STP5ZzgOZQLJQZTf+y5WJdPZGk
         S/n0N3alRn9hAwR3MO5OfhIRGyo/oU5WkeUp6+Qn2sH80ZH4J4nmVpcedDwY0f3l4xzx
         6r+A==
X-Gm-Message-State: AOAM530SDRYGnw+3a4VXxaDe5QS/wr/CEqzOOKfxfvRtyZHw3oXvv9D4
        G2rEoOdQNemCvAhmcQmaQMCAcuUi4MoD1SIq03c9cA==
X-Google-Smtp-Source: ABdhPJyd1nY9igewmqR6GV5DMHGugxKGdvxQIkNT7Vul62AFBUU4MwPk2kiQYwK39u4JH7OL1c6vanQzb2gRRPZFKYY=
X-Received: by 2002:a2e:824e:: with SMTP id j14mr1450738ljh.445.1624537014742;
 Thu, 24 Jun 2021 05:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210624111815.57937-1-odin@uged.al>
In-Reply-To: <20210624111815.57937-1-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Jun 2021 14:16:43 +0200
Message-ID: <CAKfTPtCiq6jMZwp-9s8wN80rg57fphm5PxH_519XjfAt213tGg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
To:     Odin Ugedal <odin@uged.al>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 at 13:21, Odin Ugedal <odin@uged.al> wrote:
>
> The _sum and _avg values are in general sync together with the PELT
> divider. They are however not always completely in perfect sync,
> resulting in situations where _sum gets to zero while _avg stays
> positive. Such situations are undesirable.
>
> This comes from the fact that PELT will increase period_contrib, also
> increasing the PELT divider, without updating _sum and _avg values to
> stay in perfect sync where (_sum == _avg * divider). However, such PELT

_sum is always synced and updated with PELT contrib and _avg is only
updated when crossing the 1024us period boundary. The problem here is
that the contribution to _sum can be null (not running or sleeping
state) whereas the formula "_avg * divider" assumes that all
contributions in the current period are not null. So "_avg * divider"
overestimates _sum.

Another solution would be to underestimate _sum and use _avg
*LOAD_AVG_MAX - 1024" when subtracting some _sum and keep using
LOAD_AVG_MAX - 1024 + avg->period_contrib when adding _sum.  Note,
that this doesn't make any real difference at the end for the patch
below because we don't save any multiplication operation anyway

So after updating the commit message

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> change will never lower _sum, making it impossible to end up in a
> situation where _sum is zero and _avg is not.
>
> Therefore, we need to ensure that when subtracting load outside PELT,
> that when _sum is zero, _avg is also set to zero. This occurs when
> (_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
> or equal to the current _sum, while the subtracted _avg is smaller than
> the current _avg.
>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>
> Reports and discussion can be found here:
>
> https://lore.kernel.org/lkml/2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com/
> https://lore.kernel.org/lkml/CA+G9fYsMXELmjGUzw4SY1bghTYz_PeR2diM6dRp2J37bBZzMSA@mail.gmail.com/
>
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfaa6e1f6067..def48bc2e90b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3688,15 +3688,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>
>                 r = removed_load;
>                 sub_positive(&sa->load_avg, r);
> -               sub_positive(&sa->load_sum, r * divider);
> +               sa->load_sum = sa->load_avg * divider;
>
>                 r = removed_util;
>                 sub_positive(&sa->util_avg, r);
> -               sub_positive(&sa->util_sum, r * divider);
> +               sa->util_sum = sa->util_avg * divider;
>
>                 r = removed_runnable;
>                 sub_positive(&sa->runnable_avg, r);
> -               sub_positive(&sa->runnable_sum, r * divider);
> +               sa->runnable_sum = sa->runnable_avg * divider;
>
>                 /*
>                  * removed_runnable is the unweighted version of removed_load so we
> --
> 2.32.0
>
