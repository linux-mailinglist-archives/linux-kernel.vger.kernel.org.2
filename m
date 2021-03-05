Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8382232EC8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCENxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:53:05 -0500
Received: from foss.arm.com ([217.140.110.172]:54536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhCENwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:52:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF59101E;
        Fri,  5 Mar 2021 05:52:45 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C48453F73B;
        Fri,  5 Mar 2021 05:52:43 -0800 (PST)
Date:   Fri, 5 Mar 2021 13:52:41 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com,
        fweisbec@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH 6/7 v4] sched/fair: trigger the update of blocked load on
 newly idle cpu
Message-ID: <20210305135241.ftnxhktb6ix5qkk5@e107158-lin.cambridge.arm.com>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
 <20210224133007.28644-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224133007.28644-7-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/21 14:30, Vincent Guittot wrote:
> +/*
> + * Check if we need to run the ILB for updating blocked load before entering
> + * idle state.
> + */
> +void nohz_run_idle_balance(int cpu)
> +{
> +	unsigned int flags;
> +
> +	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> +
> +	/*
> +	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
> +	 * (ie NOHZ_STATS_KICK set) and will do the same.
> +	 */
> +	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> +		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
> +}

nit: need_resched() implies this_cpu, but the function signature implies you
could operate on any CPU. Do need_resched() outside this function or make
the function read smp_processor_id() itself without taking an arg?

Thanks

--
Qais Yousef
