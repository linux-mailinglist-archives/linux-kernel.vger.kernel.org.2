Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD637911B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhEJOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:40:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237522AbhEJOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:38:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8602B31B;
        Mon, 10 May 2021 07:36:57 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D53CB3F719;
        Mon, 10 May 2021 07:36:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yejune Deng <yejune.deng@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH v2] lib/smp_processor_id: Use is_percpu_thread() check affinity
In-Reply-To: <1620654238-1410-1-git-send-email-yejunedeng@gmail.com>
References: <87pmxyj1tr.mognet@arm.com> <1620654238-1410-1-git-send-email-yejunedeng@gmail.com>
Date:   Mon, 10 May 2021 15:36:50 +0100
Message-ID: <87mtt2irjx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/21 21:43, Yejune Deng wrote:
> Use is_percpu_thread() instead of 'current->nr_cpus_allowed == 1',
> and add PF_NO_SETAFFINITY flag in init_idle().This would be nice to
> the sched_setaffinity(), and it also more readable.
>
> v1->v2:
>   - add PF_NO_SETAFFINITY flag in init_idle().
>
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> ---
>  kernel/sched/core.c    | 2 +-
>  lib/smp_processor_id.c | 6 +-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9143163..82e21ea 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7446,7 +7446,7 @@ void init_idle(struct task_struct *idle, int cpu)
>
>       idle->state = TASK_RUNNING;
>       idle->se.exec_start = sched_clock();
> -	idle->flags |= PF_IDLE;
> +	idle->flags |= PF_IDLE | PF_NO_SETAFFINITY;

Thanks for spinning a v2!

Peter reminded me that it's not the only flag the idle task is missing, so
I went and wrote something to make the idle task really look like a run of
the mill pcpu kthread. I'll bundle your v1 with it.
