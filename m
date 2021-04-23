Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D6369697
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhDWQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbhDWQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:02:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:01:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p6so42219479wrn.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tg8TsdZ6f4teaWdB1jI75fuU+k2v8o46TGjD9kpr2mg=;
        b=BBHxAiWjQROixyN/KOp4/8+2nYc+yb83yVUZJAJMDx1qWCsSTxzp6ZxUpyrNFFlCQ5
         +15oMjOk2luKCIJHVRU2afiXREB4unUWPK3209tCSaGZmsO3pn/bUjGleegx/tFxbKvQ
         c4Y7zACGLUtBlRB/FHxeGWt1TH16GMufrwgcw9AilnRlaFgA7pT2KyUau2T1K01vFeux
         8S5aFtmjSUYIivLtuZFPGsGfsPwKyOtxc4KbmezoVqwxnl7gTKyiyu6DhOFBl+koxEcE
         sCZv+uwXrkXgjWFrkLzABkydKYSEeRB2Z+Nc7GdDBhSCXzFS/5C59tBGuNRXpaWRD9Nf
         kvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tg8TsdZ6f4teaWdB1jI75fuU+k2v8o46TGjD9kpr2mg=;
        b=IKL96v0pe0b3zmoY0yEf4R41zme41CHJOojPc3X4zxAsF/NC/TfkB6WodTwkjYrsQb
         dUPAG69Wpuy3WC2XN5Y51Hyg0F+nbVoei82m8gn71M21Y6tBpRlyieoDX7knngHjVT84
         g4/S18UxG8F4jzRGphna/Vmoy2mNadT1OtOOIDitC4vFcM5OcGBGbVIvaNBgs3ON+qr4
         u3vDv9aq4a3P0TXR+S/TlplruDpumVfeJRkF+lY7gyESUiIx1GJ6UTIe5hZyyBJCoROV
         w6MF7Fu/IQGhMS/VuxF8hvmDumFStqKFs6Le6cbo9741/S+azTwMNuHm838Ej7idkP+m
         qaCg==
X-Gm-Message-State: AOAM531JIbyV/M75ClF/l2ByWygw6kQdRwWi2pTTxE4J5S9T+iLDIXwM
        jTySDT+yUDjXNXv87Xbpibb60g==
X-Google-Smtp-Source: ABdhPJw3So2T4EKa9dN0zF/xr4XTme3ERUZJmOJfTfgSG2mggxaT88MGOayFpBsokpuNC/Yv6/vaFw==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr5684944wrt.291.1619193686139;
        Fri, 23 Apr 2021 09:01:26 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k22sm10341706wrh.5.2021.04.23.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:01:25 -0700 (PDT)
Date:   Fri, 23 Apr 2021 16:01:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Pierre.Gondois@arm.com
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        qperret@qperret.net
Subject: Re: [PATCH] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
Message-ID: <YILvUkgZXu4swVvj@google.com>
References: <20210420125604.15796-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420125604.15796-1-Pierre.Gondois@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Tuesday 20 Apr 2021 at 13:56:04 (+0100), Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() (feec()) searches the best energy CPU
> to place a task on. To do so, compute_energy() estimates the energy
> impact of placing the task on a CPU, based on CPU and task utilization
> signals.
> 
> Utilization signals can be concurrently updated while evaluating a
> perf_domain. In some cases, this leads to having a 'negative delta',
> i.e. placing the task in the perf_domain is seen as an energy gain.
> Thus, any further energy comparison is biased.
> 
> In case of a 'negative delta', return prev_cpu since:
> 1. a 'negative delta' happens in less than 0.5% of feec() calls,
>    on a Juno with 6 CPUs (4 little, 2 big)
> 2. it is unlikely to have two consecutive 'negative delta' for
>    a task, so if the first call fails, feec() will correctly
>    place the task in the next feec() call
> 3. EAS current behavior tends to select prev_cpu if the task
>    doesn't raise the OPP of its current perf_domain. prev_cpu
>    is EAS's generic decision
> 4. prev_cpu should be preferred to returning an error code.
>    In the latter case, select_idle_sibling() would do the placement,
>    selecting a big (and not energy efficient) CPU. As 3., the task
>    would potentially reside on the big CPU for a long time
> 
> The patch also:
> a. groups the compute_energy() calls to lower the chances of having
>    concurrent updates in between the calls
> b. skips the base_energy_pd computation if no CPU is available in a
>    perf_domain

Should these be separate patches? That would make things a little easier
to review.

> Fixes: eb92692b2544d sched/fair: Speed-up energy-aware wake-up

Hmm, dunno if this really wants a Fixes: tag at all, but if it does I
don't think that will be this commit. We had the same 'issue' even
before this optimization no?

> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  kernel/sched/fair.c | 69 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0dba0ebc3657..577482aa8919 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6594,8 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
>  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> +	int cpu, best_energy_cpu = prev_cpu, target = -1;
>  	unsigned long cpu_cap, util, base_energy = 0;
> -	int cpu, best_energy_cpu = prev_cpu;
>  	struct sched_domain *sd;
>  	struct perf_domain *pd;
>  
> @@ -6614,19 +6614,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	if (!sd)
>  		goto fail;
>  
> +	target = prev_cpu;
> +
>  	sync_entity_load_avg(&p->se);
>  	if (!task_util_est(p))
> -		goto unlock;
> +		goto fail;

Maybe s/fail/unlock/ or something? This is not a failure per se, just an
optimization -- if the task util is 0, it's impact on the EM will always
be 0, so we'll pick prev_cpu every time.

>  
>  	for (; pd; pd = pd->next) {
>  		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +		bool compute_prev_delta = false;
>  		unsigned long base_energy_pd;
>  		int max_spare_cap_cpu = -1;
>  
> -		/* Compute the 'base' energy of the pd, without @p */
> -		base_energy_pd = compute_energy(p, -1, pd);
> -		base_energy += base_energy_pd;
> -
>  		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
>  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  				continue;
> @@ -6647,26 +6646,41 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (!fits_capacity(util, cpu_cap))
>  				continue;
>  
> -			/* Always use prev_cpu as a candidate. */
>  			if (cpu == prev_cpu) {
> -				prev_delta = compute_energy(p, prev_cpu, pd);
> -				prev_delta -= base_energy_pd;
> -				best_delta = min(best_delta, prev_delta);
> -			}
> -
> -			/*
> -			 * Find the CPU with the maximum spare capacity in
> -			 * the performance domain
> -			 */
> -			if (spare_cap > max_spare_cap) {
> +				/* Always use prev_cpu as a candidate. */
> +				compute_prev_delta = true;
> +			} else if (spare_cap > max_spare_cap) {
> +				/*
> +				 * Find the CPU with the maximum spare capacity
> +				 * in the performance domain.
> +				 */
>  				max_spare_cap = spare_cap;
>  				max_spare_cap_cpu = cpu;
>  			}
>  		}
>  
> +		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> +			continue;
> +
> +		/* Compute the 'base' energy of the pd, without @p */
> +		base_energy_pd = compute_energy(p, -1, pd);
> +		base_energy += base_energy_pd;
> +
> +		if (compute_prev_delta) {
> +			prev_delta = compute_energy(p, prev_cpu, pd);
> +			/* Prevent negative deltas and select prev_cpu */
> +			if (prev_delta < base_energy_pd)
> +				goto fail;
> +			prev_delta -= base_energy_pd;
> +			best_delta = min(best_delta, prev_delta);
> +		}
> +

Not that I disagree with the approach, just being curious: do we know
how much this is helping in practice to reduce the window by moving the
compute_energy() calls down here?

>  		/* Evaluate the energy impact of using this CPU. */
> -		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
> +		if (max_spare_cap_cpu >= 0) {
>  			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
> +			/* Prevent negative deltas and select prev_cpu */
> +			if (cur_delta < base_energy_pd)
> +				goto fail;
>  			cur_delta -= base_energy_pd;
>  			if (cur_delta < best_delta) {
>  				best_delta = cur_delta;
> @@ -6674,25 +6688,20 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			}
>  		}
>  	}
> -unlock:
> -	rcu_read_unlock();
>  
>  	/*
> -	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
> -	 * least 6% of the energy used by prev_cpu.
> +	 * Pick the best CPU if:
> +	 *  - prev_cpu cannot be used, or
> +	 *  - it saves at least 6% of the energy used by prev_cpu
>  	 */
> -	if (prev_delta == ULONG_MAX)
> -		return best_energy_cpu;
> -
> -	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> -		return best_energy_cpu;
> -
> -	return prev_cpu;
> +	if ((prev_delta == ULONG_MAX) ||
> +		(prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> +		target = best_energy_cpu;
>  
>  fail:
>  	rcu_read_unlock();
>  
> -	return -1;
> +	return target;
>  }

Otherwise this looks pretty good to me.

Thanks,
Quentin
