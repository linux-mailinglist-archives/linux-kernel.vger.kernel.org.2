Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6686645EBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhKZK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:57:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234171AbhKZKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:55:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F021042;
        Fri, 26 Nov 2021 02:51:58 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 484D63F5A1;
        Fri, 26 Nov 2021 02:51:57 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
In-Reply-To: <20211125165233.1425633-1-qais.yousef@arm.com>
References: <20211125165233.1425633-1-qais.yousef@arm.com>
Date:   Fri, 26 Nov 2021 10:51:48 +0000
Message-ID: <87wnkvb35n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/21 16:52, Qais Yousef wrote:
> Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
> uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
> match the woken up task's uclamp_max when the rq is idle. This only
> impacts the first wake up after enabling the static key. And it only

Wouldn't that rather be all wakeups after enabling the static key, until
the rq goes idle and gains UCLAMP_FLAG_IDLE? e.g. if you enqueue N
uclamp_max=512 tasks, the first enqueue flips the static key and the rq
max-aggregate will stay at 1024 after the remaining enqueues.

> matters if the uclamp_max of this task is < 1024 since only then its
> uclamp_max will be effectively ignored.
>
> Fix it by properly initializing rq->uclamp_flags = UCLAMP_FLAG_IDLE to
> ensure we reset rq uclamp_max when waking up from idle.
>
> Fixes: d81ae8aac85c ("sched/uclamp: Fix initialization of struct uclamp_rq")

Looking at this again, I'm starting to think this actually stems from the
introduction of the flag:

  e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")

Before the commit you point at, we would still initialize ->uclamp_flags to
0. This was probably hidden by all the activity at boot-time (e.g. just
unparking smpboot threads) which yielded an nr_running>0 -> nr_running==0
transition, IOW we'd most likely get UCLAMP_FLAG_IDLE set on a rq before
any userspace task could get on there.

The static key would have only made this problem more visible.

> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Changelog nitpicking aside:
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index beaa8be6241e..52b0c7513a32 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1929,7 +1929,7 @@ static void __init init_uclamp_rq(struct rq *rq)
>               };
>       }
>
> -	rq->uclamp_flags = 0;
> +	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
>  }
>
>  static void __init init_uclamp(void)
> --
> 2.25.1
