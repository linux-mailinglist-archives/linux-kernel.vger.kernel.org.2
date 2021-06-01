Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34B9397897
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhFARBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:01:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234505AbhFARBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:01:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC446D;
        Tue,  1 Jun 2021 10:00:00 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5F843F719;
        Tue,  1 Jun 2021 09:59:58 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] sched: Plug race between SCA, hotplug and migration_cpu_stop()
In-Reply-To: <20210526205751.842360-3-valentin.schneider@arm.com>
References: <20210526205751.842360-1-valentin.schneider@arm.com> <20210526205751.842360-3-valentin.schneider@arm.com>
Date:   Tue, 01 Jun 2021 17:59:56 +0100
Message-ID: <87h7ihfrlf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/21 21:57, Valentin Schneider wrote:
> +		dest_cpu = arg->dest_cpu;
> +		if (task_on_rq_queued(p)) {
> +			/*
> +			 * A hotplug operation could have happened between
> +			 * set_cpus_allowed_ptr() and here, making dest_cpu no
> +			 * longer allowed.
> +			 */
> +			if (!is_cpu_allowed(p, dest_cpu))
> +				dest_cpu = select_fallback_rq(cpu_of(rq), p);
> +			/*
> +			 * dest_cpu can be victim of hotplug between is_cpu_allowed()
> +			 * and here. However, per the synchronize_rcu() in
> +			 * sched_cpu_deactivate(), it can't have gone lower than
> +			 * CPUHP_AP_ACTIVE, so it's safe to punt it over and let
> +			 * balance_push() route it elsewhere.
> +			 */
> +			update_rq_clock(rq);
> +			rq = move_queued_task(rq, &rf, p, dest_cpu);

So, while digesting this I started having doubts vs pcpu kthreads since
they're allowed on online CPUs. The bogus scenario here would be picking a
!active && online CPU, and see it go !online before the move_queued_task().

Now, to transition from online -> !online, we have to go through
take_cpu_down() which is issued via a stop_machine() call. This means the
transition can't happen until all online CPUs are running the stopper task
and reach MULTI_STOP_RUN.

migration_cpu_stop() being already a stopper callback should thus make it
"atomic" vs takedown_cpu(), meaning the above should be fine.

> +		} else {
> +			p->wake_cpu = dest_cpu;
> +		}
>       } else if (pending) {
>               /*
>                * This happens when we get migrated between migrate_enable()'s
> --
> 2.25.1
