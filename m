Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15613371E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhCKL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhCKL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:57:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=koF1sgaPtBGi5gEpR0MtXvHtGkghU8CuWBVUbqTefHM=; b=BalhLNT/FI7NEFEsZr111zdUtb
        yQ3wwpRHuBButeBrWTOSny3cJHWMAHRTnr9dUol+c2zxxBdidPrVUI8B0kvyCAMHmQ8FZpg5Nxif4
        gfsimLMjT7inN6bsauoz/hlny/0COHQ4RFATUf3IQUHTmzRHEP0GJPjmwOp2/cC4qLnZnA3YDkUSP
        02irssnNIFrJrntpEZEWfdqdAozTLErdK4e3mGRxqW4iI+NIO9jIwg9MnlF4bf1gFWHfa0ZfZBU/g
        tt2dXmCVXHY6mB/bzEQz//iE2ZiCzCcYXNiZx+wsgmSTjM1Fi5WFpHi8K5lmmaJAZCPl++yyDj+C9
        vA0f2TAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKJw3-007H5S-Qv; Thu, 11 Mar 2021 11:57:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9483300455;
        Thu, 11 Mar 2021 12:56:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A894C29A42B87; Thu, 11 Mar 2021 12:56:58 +0100 (CET)
Date:   Thu, 11 Mar 2021 12:56:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEoFitWfyKOkx61M@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:52AM -0800, kan.liang@linux.intel.com wrote:
> +static void init_hybrid_pmu(int cpu)
> +{
> +	unsigned int fixed_mask, unused_eax, unused_ebx, unused_edx;
> +	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> +	u8 cpu_type = get_hybrid_cpu_type(cpu);
> +	struct x86_hybrid_pmu *pmu = NULL;
> +	struct perf_cpu_context *cpuctx;
> +	int i;
> +
> +	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> +		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
> +			pmu = &x86_pmu.hybrid_pmu[i];
> +			break;
> +		}
> +	}
> +	if (WARN_ON_ONCE(!pmu))
> +		return;
> +
> +	cpuc->pmu = &pmu->pmu;
> +
> +	/* Only register PMU for the first CPU */
> +	if (!cpumask_empty(&pmu->supported_cpus)) {
> +		cpumask_set_cpu(cpu, &pmu->supported_cpus);
> +		goto end;
> +	}
> +
> +	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
> +		return;
> +
> +	if ((pmu->pmu.type == -1) &&
> +	    perf_pmu_register(&pmu->pmu, pmu->name, x86_get_hybrid_pmu_type(pmu->cpu_type)))
> +		return;
> +
> +	/*
> +	 * Except for ECX, other fields have been stored in the x86 struct
> +	 * at boot time.
> +	 */
> +	cpuid(10, &unused_eax, &unused_ebx, &fixed_mask, &unused_edx);
> +
> +	intel_pmu_check_num_counters(&pmu->num_counters,
> +				     &pmu->num_counters_fixed,
> +				     &pmu->intel_ctrl,
> +				     (u64)fixed_mask);
> +
> +	pr_info("%s PMU driver: ", pmu->name);
> +
> +	if (pmu->intel_cap.perf_metrics) {
> +		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
> +		pmu->intel_ctrl |= INTEL_PMC_MSK_FIXED_SLOTS;
> +	}
> +
> +	if (pmu->intel_cap.pebs_output_pt_available) {
> +		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
> +		pr_cont("PEBS-via-PT ");
> +	}
> +
> +	intel_pmu_check_event_constraints(pmu->event_constraints,
> +					  pmu->num_counters,
> +					  pmu->num_counters_fixed,
> +					  pmu->intel_ctrl);
> +
> +	intel_pmu_check_extra_regs(pmu->extra_regs);
> +
> +	pr_cont("\n");
> +
> +	x86_pmu_show_pmu_cap(pmu->num_counters, pmu->num_counters_fixed,
> +			     pmu->intel_ctrl);
> +
> +	cpumask_set_cpu(cpu, &pmu->supported_cpus);
> +end:
> +	/*
> +	 * The cpuctx of all CPUs are allocated when registering the
> +	 * boot CPU's PMU. At that time, the PMU for other hybrid CPUs
> +	 * is not registered yet. The boot CPU's PMU was
> +	 * unconditionally assigned to each cpuctx->ctx.pmu.
> +	 * Update the cpuctx->ctx.pmu when the PMU for other hybrid
> +	 * CPUs is known.
> +	 */
> +	cpuctx = per_cpu_ptr(pmu->pmu.pmu_cpu_context, cpu);
> +	cpuctx->ctx.pmu = &pmu->pmu;
> +}
> +
>  static void intel_pmu_cpu_starting(int cpu)
>  {
>  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>  	int core_id = topology_core_id(cpu);
>  	int i;
>  
> +	if (is_hybrid())
> +		init_hybrid_pmu(cpu);
> +
>  	init_debug_store_on_cpu(cpu);
>  	/*
>  	 * Deal with CPUs that don't clear their LBRs on power-up.

This is buggered. CPU_STARTING is the initial IRQs disabled part of
hotplug, but you're calling perf_pmu_register() which does mutex_lock().
