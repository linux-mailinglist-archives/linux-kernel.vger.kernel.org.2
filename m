Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC03FB326
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhH3JcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhH3JcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:32:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oHHxXfQ4s/sK6iYvTSSy1pAoUvbaKX/xTZYkOsjcAvc=; b=i16/66sUJhlmrvWrizI4izfrTT
        x44vbCKs1PNHkg4efofgMwG+SA34W8M3a4GV3qXkUCYgOQiVmJEYTDy92Ut7L3/ho7VmhvVGXEykE
        8iUJgCTH1ijJLFhovVOx6HW0zvIYjy7uQh7Qo5yITsvIxXapGxsNBXrcimKrEi6Jz5L/ibRk2Y3y7
        gO6Sj01zrTb5IbWXWYVM1n/vGNseKkaET6Yv9ZPyLD/4V/cPtgOb6ndmW75FMJ8ZV7tJgx/SCFGpg
        rO1sc3nlQ6zTJvFxaD2Tw89kQa3NZ/e86MkTp51QNpNEGlDyn/I4bbGoFZwQbSD7It1zXuu6uxEnP
        436vEVIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKddB-00EMwU-2T; Mon, 30 Aug 2021 09:31:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D90FA98186D; Mon, 30 Aug 2021 11:31:03 +0200 (CEST)
Date:   Mon, 30 Aug 2021 11:31:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, juri.lelli@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, frederic@kernel.org
Subject: Re: [PATCH] sched/core: Bypass arch_scale_freq_tick() on nohz_full
 CPUs
Message-ID: <20210830093103.GH4353@worktop.programming.kicks-ass.net>
References: <20210827184910.2163948-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827184910.2163948-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:49:10PM +0200, Nicolas Saenz Julienne wrote:
> arch_scale_freq_tick() calculations generally track the increment of
> frequency performance counters in between scheduler ticks to provide
> estimations on how DVFS swayed frequency on that CPU. This information
> eventually allows for more precise scheduling decisions. It's all fine
> and good, but nohz_full CPUs are capable of disabling the tick
> indefinitely and potentially trigger overflows in
> arch_scale_freq_tick()'s calculations once it's eventually re-enabled.
> 
> This will happen for both users of this interface: x86 and arm64. And
> it's also relevant that the heuristic on what to do in case of
> operations overflowing varies depending on the implementation. It goes
> from fully disabling frequency invariance scaling on all CPUS, to
> ignoring this is a possibility.
> 
> It's arguable that nohz_full CPUs are unlikely to benefit much from this
> feature, since their aim is to allow for uninterrupted execution of a
> single task, effectively getting the scheduler out of the way. Also,
> DVFS itself is also unlikely be used on most nohz_full systems, given
> its effects on latency.
> 
> So get around this by not calling arch_scale_freq_tick() on nohz_full
> CPUs.
> 
> Note that tick_nohz_full_cpu() relies on a static branch, which avoids
> degrading performance on the rest of systems.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  kernel/sched/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2fd623b2270d..8c04ec0e073a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5016,7 +5016,13 @@ void scheduler_tick(void)
>  	unsigned long thermal_pressure;
>  	u64 resched_latency;
>  
> -	arch_scale_freq_tick();
> +	/*
> +	 * nohz_full CPUs are capable of disabling the scheduler tick
> +	 * indefinitely, potentially overflowing arch_scale_freq_tick()
> +	 * calculations once it's re-enabled.
> +	 */
> +	if (!tick_nohz_full_cpu(smp_processor_id()))
> +		arch_scale_freq_tick();
>  	sched_clock_tick();
>  
>  	rq_lock(rq, &rf);

Hurmph,.. I'm not too happy with this.. Fundamentally the whole
NOHZ_FULL state should be dynamic, it currently isn't but that's
arguably a bug of the current implementation.

As such the above doesn't really dtrt, since a CPU disabling NOHZ_FULL
will then still suffer all them overflows you mentioned.

Frederic, how should this be done right? Is there a place where upon
entering/exiting NOHZ_FULL we can do fixups?
