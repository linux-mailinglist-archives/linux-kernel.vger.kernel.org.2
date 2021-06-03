Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01539A187
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFCMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFCMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:53:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62012C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:52:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w33so8640746lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXSPFYUv+frq5B31P2+9676MnBddW3+j4BZ+XqvE/IU=;
        b=mkYMalVHjpfomaWeFWDWX9glGkJHhsdYkZIp8eFDb0kxyUonE980Dq+4l3iVMucOKv
         /EIKyQCKHFCEZXAQDj6hIR8Ot8arkMF1kblq7fAHcIzO+4g4wLM3PDocDRqhRHl1i4o4
         Laj2syzgyAjKpRqxjAPRCDZ8NpA6G/G8D5H8ie7sgttBLI1fdVjZuX87mGAX+BQXBavf
         lBCM2WVLrwLAC+pRRcQuAZ/tS0nAbzaUyaL7fKysEiKgSpXmeNuRqZniBgHzeaG7nSE1
         tkyZocErWj3cgE18KuwIy6uNfE6LUmri061DG2AeTM1pS6luFQPo6Fwb84sGOLr6ctSW
         nlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXSPFYUv+frq5B31P2+9676MnBddW3+j4BZ+XqvE/IU=;
        b=saXffkTtjFcTNfR6tnA97RBcF/Ln60KnR5OZDwAUSLMm6Y4Lhixqdk1L2RY/4HhcXy
         dAcpY3a37s6uGQO3rn7acfDkwxbfX5LR8NNl+X5dpg1nFMLeGJFg0ub9YkdmEhxODcmz
         Qr3uAHgvhWUlDlHSgXzVWZAs4TSyAzs8XwCavAA9k9z4h18hhEYy83ZqkilAgHWDdV2J
         EQ996FdmvadtNRBZNMIFBal4am4nnNcIiQEc0rDGPXZXbbbY2fUhxLaBH0Twe435/962
         57LdouW1rh0kV4dA8xpSEs9fi3bmGdNTgsLNx7+UfG57SZ15THyfqU1NDiYbuZXMnXEP
         UpmQ==
X-Gm-Message-State: AOAM532Jn/8EXB1oXajyz2KvQ7mPkEYkpmxAY7AShEBME24mAgNdgBBJ
        /unE7kZE7A2NHCnclcNzubGXeIcf2ZzR6r1rp64y0w==
X-Google-Smtp-Source: ABdhPJzeE0g2LtPg9P10vFEg0O/PtJxa3icrm3fDoEs1X0A5mi9Y9C/b8U/rqC9xceoyXFnUDn0hLMXtzITAqfeurG0=
X-Received: by 2002:a19:4810:: with SMTP id v16mr9307733lfa.254.1622724721651;
 Thu, 03 Jun 2021 05:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210603113847.163512-1-odin@uged.al>
In-Reply-To: <20210603113847.163512-1-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Jun 2021 14:51:50 +0200
Message-ID: <CAKfTPtAK3gEqChUmoUXo7KLqPAFo=shH4Yi=QLjrwpuu6Ow6-Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 13:41, Odin Ugedal <odin@uged.al> wrote:
>
> This fixes an issue where fairness is decreased since cfs_rq's can
> end up not being decayed properly. For two sibling control groups with
> the same priority, this can often lead to a load ratio of 99/1 (!!).
>
> This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
> will be removed from the leaf list. When they initial cfs_rq is
> unthrottled, it will currently only re add descendant cfs_rq's if they
> have one or more entities enqueued. This is not a perfect heuristic.
>
> Insted, we insert all cfs_rq's that contain one or more enqueued
> entities, or contributes to the load of the task group.
>
> Can often lead to sutiations like this for equally weighted control
> groups:
>
> $ ps u -C stress
> USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
> root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1
>
> Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>
> Original thread: https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/
> Changes since v1:
>  - Replaced cfs_rq field with using tg_load_avg_contrib
>  - Went from 3 to 1 pathces; one is merged and one is replaced
>    by a new patchset.
>
>  kernel/sched/fair.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..0f1b39ca5ca8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4719,8 +4719,11 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>                 cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
>                                              cfs_rq->throttled_clock_task;
>
> -               /* Add cfs_rq with already running entity in the list */
> -               if (cfs_rq->nr_running >= 1)
> +               /*
> +                * Add cfs_rq with tg load avg contribution or one or more
> +                * already running entities to the list
> +                */
> +               if (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running)

Out of curiosity, why did you decide to use
cfs_rq->tg_load_avg_contrib instead of !cfs_rq_is_decayed(cfs_rq)
which is used to delete the cfs_rq from the list when updating blocked
load ?

>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
>
> --
> 2.31.1
>
