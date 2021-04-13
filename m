Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE135DE22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhDML61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:58:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240873AbhDML6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:58:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78FAF113E;
        Tue, 13 Apr 2021 04:58:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2776D3F694;
        Tue, 13 Apr 2021 04:58:03 -0700 (PDT)
Date:   Tue, 13 Apr 2021 12:58:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mpe@ellerman.id.au, paulmck@kernel.org,
        npiggin@gmail.com, frederic@kernel.org, ethp@qq.com,
        joe.jin@oracle.com
Subject: Re: [PATCH v2 1/1] kernel/cpu: to track which CPUHP callback is
 failed
Message-ID: <20210413115800.lfgrcsh3xv6v5hy2@e107158-lin.cambridge.arm.com>
References: <20210409055316.1709-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210409055316.1709-1-dongli.zhang@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/21 22:53, Dongli Zhang wrote:
> During bootup or cpu hotplug, the cpuhp_up_callbacks() or
> cpuhp_down_callbacks() call many CPUHP callbacks (e.g., perf, mm,
> workqueue, RCU, kvmclock and more) for each cpu to online/offline. It may
> roll back to its previous state if any of callbacks is failed. As a result,
> the user will not be able to know which callback is failed and usually the
> only symptom is cpu online/offline failure.
> 
> This patch is to print more debug log to help user narrow down where is the
> root cause.
> 
> Below is the example that how the patch helps narrow down the root cause
> for the issue fixed by commit d7eb79c6290c ("KVM: kvmclock: Fix vCPUs > 64
> can't be online/hotpluged").
> 
> We will have below dynamic debug log once we add
> dyndbg="file kernel/cpu.c +p" to kernel command line and when issue is
> reproduced.

You can also enable it at runtime

echo "file kernel/cpu.c +p" > /sys/kernel/debug/dynamic_debug/control

> 
> "CPUHP up callback failure (-12) for cpu 64 at kvmclock:setup_percpu (66)"
> 
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

I don't see the harm in adding the debug if some find it useful.

FWIW

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Cheers

--
Qais Yousef

> Changed since v1 RFC:
>   - use pr_debug() but not pr_err_once() (suggested by Qais Yousef)
>   - print log for cpuhp_down_callbacks() as well (suggested by Qais Yousef)
> 
>  kernel/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1b6302ecbabe..bcd4dd7de9c3 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -621,6 +621,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
>  		st->state++;
>  		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
>  		if (ret) {
> +			pr_debug("CPUHP up callback failure (%d) for cpu %u at %s (%d)\n",
> +				 ret, cpu, cpuhp_get_step(st->state)->name,
> +				 st->state);
> +
>  			if (can_rollback_cpu(st)) {
>  				st->target = prev_state;
>  				undo_cpu_up(cpu, st);
> @@ -990,6 +994,10 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
>  	for (; st->state > target; st->state--) {
>  		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
>  		if (ret) {
> +			pr_debug("CPUHP down callback failure (%d) for cpu %u at %s (%d)\n",
> +				 ret, cpu, cpuhp_get_step(st->state)->name,
> +				 st->state);
> +
>  			st->target = prev_state;
>  			if (st->state < prev_state)
>  				undo_cpu_down(cpu, st);
> -- 
> 2.17.1
> 
