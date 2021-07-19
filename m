Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7411E3CD44A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhGSLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbhGSLXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:23:46 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5562C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 04:18:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b14so15708736ilf.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eHHRMBzl6YGWBbzF+HHHh8s2IJ/QMDseGQlU4DEhe4=;
        b=mQHgM6uFTtgExBbGmk3yG0Uk0RMYv8yOnaqqt8Fg8oCtejEwu9KDAzoRJpGkjoHz4Z
         L5KQKHi4Y+YrtzC1XSRGiGyJfjbIkg/ik3ZElMWT00OJs2OrTdEE6HSxtonMBT8WWVz0
         oXz3xlGRH68bjBllvan3y0ryDAZKXPGj3oF2gg/0wlNxmYUF8FDsnKvWrVkXfVe7wNhT
         NxkkDkKH5sEjWVffKiRVS6E+rxMGyqX96KCv+yn2gf2dpGtDbD3jhCAdcePC6Po0mawM
         lWfgn0AdW3JCbqSqk4+XHJxOyMGR/qUlMRoh3CkWooB9NdS+zVKIQb3PAp5a3CBQ4VTc
         aIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eHHRMBzl6YGWBbzF+HHHh8s2IJ/QMDseGQlU4DEhe4=;
        b=uijJcjqEhQ9k3tKXSZB7c7p5+cOR+h02JqBhZelR6y6K9vlBeEtPskY6xYx5e1hxr1
         TkRxsXQOLVRI0tUes/e6R7ln7Mj/6/HNP3HrXy1a1Kxtm6cN/uyuLt7dhL3DnA+JOzPL
         +ufV2ek4W/Ig2NJTVZ2kwQ9vuWqBN1jInXMwuSmvrD688K18AA7uBh8Dt8b1+BRU0v+A
         BQXmAanW9ZePT/xYf9cYQOooZiirriSmUmhQHcmo/3x9O3V0Rsa9Lp8KEYRWXDgnlfLB
         lVGd6PodV/cnRGNAOKRrgbrzuZjZSF0kSgDoUBSjdq0JZ60USMZxoxU1PXffCO9hS68S
         2qdA==
X-Gm-Message-State: AOAM532KWkZ07+KFGKqdTY7/iCl6WHIfiQJM6dQmD2fysN7VF7grDM2Q
        nOZjdCLOSSr+G9CfpOQV81sGm0BT2q9+8/3E2tM=
X-Google-Smtp-Source: ABdhPJwXWKAHgUPYTTPLrSHLV7JT3GhTz6HkYEgzQa7HqqVDf8Kw+dL4lDBvDzaP3h1UXAaAMUJOyDNdGt6Tj4vJO9M=
X-Received: by 2002:a05:6e02:1154:: with SMTP id o20mr16767199ill.168.1626696266434;
 Mon, 19 Jul 2021 05:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
 <87tukxm66r.mognet@arm.com>
In-Reply-To: <87tukxm66r.mognet@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 19 Jul 2021 20:03:50 +0800
Message-ID: <CALOAHbDkV3WmvcK=EuMbv4qSvJm1e=GvZhuVm=Ra6iOjaasE8g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched: do active load balance in balance callback
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 8:27 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 11/07/21 15:40, Yafang Shao wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4ca80df205ce..a0a90a37e746 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8208,6 +8208,7 @@ void __init sched_init(void)
> >                 rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
> >                 rq->balance_callback = &balance_push_callback;
> >                 rq->active_balance = 0;
> > +               rq->active_balance_target = NULL;
> >                 rq->next_balance = jiffies;
> >                 rq->push_cpu = 0;
> >                 rq->cpu = i;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 23663318fb81..9aaa75250cdc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7751,36 +7751,6 @@ static void detach_task(struct task_struct *p,
> > struct lb_env *env)
>
> Your mail client is breaking lines which pretty much wrecks the
> patch. Please use git send-email to submit patches, or look at
> Documentation/process/email-clients.rst to figure out how to tweak your
> client.

My mail client is broken.
I will fix it and resend.

-- 
Thanks
Yafang
