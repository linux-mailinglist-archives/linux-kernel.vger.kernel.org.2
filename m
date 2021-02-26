Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7203265B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBZQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:39:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87BC06174A;
        Fri, 26 Feb 2021 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nm4khSh0bKFhxk1r0BlEoBUvtSkHO0c2Y7hbZV61JR8=; b=nPSju8JU7vBXX3kruXvSLHeziZ
        S8lINxs+syQf2YVCw1PsLv6zWiMerA8fUzIr1OWQ2gmSr9K0NxAufT7PRSz4JWbrrte0vcVRzGs1W
        RYwzdFet7yL9rHFVKoiTudDleqPpMpS1gyPQwrh1ge1kHRJhwkC9Eq5CJu8FcfqC1levS426zLOy+
        ehcge+yrnqszaAQ1MlLtq0thbKAghv65XXqSGVm78IK9K+rPplNxcZiMB/xpvJqmUQiJcD3mnAeKy
        KGAKL9JPjMu4kY8Womd9svGt6cxn23O6fQEWR0qlPRVdy1I8A1/4OGdk+jX0Gnd+O2WjKajAkk1E+
        pfcp1zGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFg8c-00CFL1-5a; Fri, 26 Feb 2021 16:38:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B57223011F0;
        Fri, 26 Feb 2021 17:38:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0ED720BC9288; Fri, 26 Feb 2021 17:38:44 +0100 (CET)
Date:   Fri, 26 Feb 2021 17:38:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226112521.8641-4-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I hate all of this, but if this will finally catch the actual problem,
we can then revert all this, so sure.

Also, I think this will conflict with the patches from Nadav that I have
queued:

  https://lkml.kernel.org/r/20210220231712.2475218-1-namit@vmware.com

which I'll be pushing to tip/x86/mm once -rc1 happens.

On Fri, Feb 26, 2021 at 12:25:21PM +0100, Juergen Gross wrote:

> +static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
> +{
> +	unsigned int this_cpu = smp_processor_id();
> +	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
> +	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
> +	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
> +
> +	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
> +	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
> +		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
> +		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
> +		send_call_function_single_ipi(cpu);
> +		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
> +	} else {
> +		cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
> +	}
> +}
>  #else
> +#define cfd_seq_store(var, src, dst, type)
> +
>  static void csd_lock_record(call_single_data_t *csd)
>  {
>  }
> @@ -290,6 +396,19 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
>  
>  void __smp_call_single_queue(int cpu, struct llist_node *node)
>  {
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +	if (static_branch_unlikely(&csdlock_debug_extended)) {
> +		unsigned int type;
> +
> +		type = CSD_TYPE(container_of(node, call_single_data_t,
> +					     node.llist));
> +		if (type == CSD_TYPE_SYNC || type == CSD_TYPE_ASYNC) {
> +			__smp_call_single_queue_debug(cpu, node);
> +			return;
> +		}
> +	}
> +#endif

This is a bit weird, might as well put it in generic_exec_single()
because there you still know the type matches.


> @@ -712,12 +840,21 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  		csd->node.src = smp_processor_id();
>  		csd->node.dst = cpu;
>  #endif
> -		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
> +		cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
> +		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
>  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> +			cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
> +		} else {
> +			cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
> +		}
>  	}
>  
>  	/* Send a message to all CPUs in the map */
> +	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->ping, this_cpu,
> +		      CFD_SEQ_NOCPU, CFD_SEQ_PING);
>  	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
> +	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu,
> +		      CFD_SEQ_NOCPU, CFD_SEQ_PINGED);

Too bad we can't share with the single case, a well.
