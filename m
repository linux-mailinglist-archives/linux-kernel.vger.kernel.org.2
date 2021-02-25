Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0071D3252B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhBYPse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhBYPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:48:00 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:47:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 2so2451021ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7472uxom7Z481F7tt+sw25AU0eSjfsKwR5ygScta5fE=;
        b=ucEMhlq3ICGBXoXl+yoOqxsahXkZ7soa6DZWHnqcb0KC+aBz5uSY4JJZa3uTqu0NHV
         SI0ypf1zXlu33/ULK1id3FGFPFM1TvqWampmZBs3dMuSfkQheYPxKXk7S8m6AzEvcomL
         8tiHz+JHta16LwKh17alBVsTbCRGNRy60NzlJ6f0FcX+ROx7F+MfCEpPmktudIk2FRf1
         dDCAjOUhbF7H2ha3QpnzNEnkj/JZ6yl3UbWUn1P1cMq22kThwkpaI92JhgScOev+VzLq
         9ce+0Z2a/iDd1UzXeQ6Z4XVlWZZFQiVJQlbQtbLUZvVzqoSgTdV1Q6zYFNg4bzo7e86f
         Vw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7472uxom7Z481F7tt+sw25AU0eSjfsKwR5ygScta5fE=;
        b=pT4t495XNShS4TWH9brMRfeBbto0Tq811TXajBPQ5o4O9tBwPmKGrxEO9L86DtfmWt
         BzDHqLKd7CdZAVg3RcJb2Hd8SULsUbtG11n9RKBlirrz+S/OtF/BqAxqRLuhWLqCHvru
         IEVr7UWWDhQiWpnEchD4/BAUYdSW9FZ5IUKwrCXRZI/z7nYyN2uybqdq/BKF/EReJOqL
         9zMZT4Cv/pvZZaSZSGDCJBBBcFRz1lbCRrl2BE+SUEKraDKuDnJv/m1LJUpCwA4Fu59v
         6l70Vw6HqGEsRFlC2qvJ+kEOK/sG9PfHQMXZ+X8V98K/k53nthy3fqilbGACgnUY7ssh
         HWWg==
X-Gm-Message-State: AOAM533/3xIS3Ok8VD3V3mFW0jGVDZ9A+Fecqoch1viJ8Xf+XxXRIyEK
        f1xaQJ0zf5kVw0zR4scL/pta9bYdIbSiBexI32498Q==
X-Google-Smtp-Source: ABdhPJznwYHF+hZ7N9WA49Pvn/TEevBL3qSxo1/FA6akdJpPaZTdxHVU3Pii9f5PrgxBc/2STVauNtXkfZ+/l8TFaUE=
X-Received: by 2002:a2e:b5b4:: with SMTP id f20mr1905904ljn.445.1614268032239;
 Thu, 25 Feb 2021 07:47:12 -0800 (PST)
MIME-Version: 1.0
References: <1613979200-9707-1-git-send-email-ultrachin@163.com>
In-Reply-To: <1613979200-9707-1-git-send-email-ultrachin@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Feb 2021 16:47:01 +0100
Message-ID: <CAKfTPtAUwPv9p+LPEX5x1PfkCxL+pXJvS4UQOaj3L+sTV2CNHA@mail.gmail.com>
Subject: Re: [PATCH V2] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     chin <ultrachin@163.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        heddchen@tencent.com,
        =?UTF-8?B?eGlhb2dnY2hlbijpmYjlsI/lhYkp?= <xiaoggchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 08:35, <ultrachin@163.com> wrote:
>
> From: Chen Xiaoguang <xiaoggchen@tencent.com>
>
> In order to use the computer efficiently we usually deploy online
> tasks and offline tasks in the same computer.
>
> The online tasks are more important than the offline tasks and are
> latency sensitive we should make sure the online tasks preempt the
> offline tasks as soon as possible while there are online tasks
> waiting to run.
>
> Online tasks using the SCHED_NORMAL policy and offline tasks using
> the SCHED_ILDE policy. This patch decrease the latency of online
> tasks by doing a load balance before a offline tasks to run.
>
> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> Signed-off-by: Chen He <heddchen@tencent.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

> ---
> v1 -> v2:
>  - Add checking in balance_fair
>  - Remove task state checking in pick_next_task_fair
>  - Add comment about the change
> ---
>  kernel/sched/fair.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b..80b69a2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6833,7 +6833,13 @@ static void task_dead_fair(struct task_struct *p)
>  static int
>  balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> -       if (rq->nr_running)
> +       /*
> +        * Return if SCHED_NORMAL tasks exist.
> +        * Else if only SCHED_IDLE tasks in rq then do a load balance trying
> +        * to pull SCHED_NORMAL tasks to run so as to reduce the latency of
> +        * SCHED_NORMAL task.
> +        */
> +       if (rq->nr_running && !sched_idle_rq(rq))
>                 return 1;
>
>         return newidle_balance(rq, rf) != 0;
> @@ -7013,6 +7019,14 @@ struct task_struct *
>         struct task_struct *p;
>         int new_tasks;
>
> +       /*
> +        * Before a CPU switches from running SCHED_NORMAL task to SCHED_IDLE
> +        * task, do a load balance trying to pull SCHED_NORMAL tasks to run
> +        * so as to reduce the latency of SCHED_NORMAL task.
> +        */
> +       if (sched_idle_rq(rq) && prev && prev->policy != SCHED_IDLE)
> +               goto idle;
> +
>  again:
>         if (!sched_fair_runnable(rq))
>                 goto idle;
> --
> 1.8.3.1
>
