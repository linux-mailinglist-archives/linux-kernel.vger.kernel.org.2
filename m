Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B136B344547
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhCVNPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhCVNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:02:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04101C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VX78hMnVs57uUoMMLxteoeKe2tLkRLpBILM111S4zWs=; b=NrXCz+i8RaXMCmVQuF2ej6wSlh
        UG+1EotIaUE/eRFHO0lHzpr2MBdiZUEDl/DEFzQDzVlb7uRRAsD6+OMBgco9/pLbyfwDDhvGMoEig
        yJUvfBKkgRrPF93HAYQaY/8jwgfF8K9pZ89M1N2g4YWy884jx+9R3I10b0sI5dO+HGfEjqJoHsg0m
        wbH6SzqXfw5NVM4+oq9oAw/BoDkCiDWMPVSMedNdJqieA8ecbzl0AjozWvmaZwlpebElTcw9H4TAi
        Gwn5tFYGgzZIFOJ8YhK4AcyNnBLCZtm4G8KYviLK4iI6R60v8iXX7JYurAwFXOhzxKlxCUl/pCHcD
        4MLRKDEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOK6I-008Wny-CB; Mon, 22 Mar 2021 12:56:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 713E4307A52;
        Mon, 22 Mar 2021 13:56:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F5C02029F864; Mon, 22 Mar 2021 13:56:03 +0100 (CET)
Date:   Mon, 22 Mar 2021 13:56:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
Message-ID: <YFiT4/mmisnBFJ96@hirez.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
 <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
 <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
 <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
 <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
 <bb075bed-150c-8ea0-3035-0a8c3c98e572@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb075bed-150c-8ea0-3035-0a8c3c98e572@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:31:09PM +0800, Li, Aubrey wrote:
> Please let me know if I put cookie match check at the right position
> in task_hot(), if so, I'll obtain some performance data of it.
> 
> Thanks,
> -Aubrey
> 
> =======================================================
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7f2fb08..d4bdcf9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1912,6 +1912,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>  			continue;
>  
> +		/*
> +		 * Skip this cpu if source task's cookie does not match
> +		 * with CPU's core cookie.
> +		 */
> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> +			continue;
> +
>  		env->dst_cpu = cpu;
>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>  			break;

This one might need a little help too, I've not fully considered NUMA
balancing though.

> @@ -6109,7 +6120,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>  			return -1;
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +
> +		if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> +		    sched_cpu_cookie_match(cpu_rq(cpu), p))
>  			break;
>  	}
>  

This doesn't even apply... That code has changed.

> @@ -7427,6 +7440,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  
>  	if (sysctl_sched_migration_cost == -1)
>  		return 1;
> +
> +	/*
> +	 * Don't migrate task if the task's cookie does not match
> +	 * with the destination CPU's core cookie.
> +	 */
> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +		return 1;
> +
>  	if (sysctl_sched_migration_cost == 0)
>  		return 0;
>  

Should work I think, but you've put it in a weird spot for breaking up
that sysctl_sched_migration_cost thing. I'd have put it either in front
or after that other SMT thing we have there.

