Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BD3B906E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhGAKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhGAKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:21:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48925C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UdZboICZf8o4ae/I+gO5TMQsOiUDrucrN6mubvfJJWE=; b=Nn5jzLaSAG6LgeprasRlyRU0l3
        DqAAF2aZqgWVUzkvr73tSze4J5IPClixryFVq98f2n7djb1aQNa39BUtE1tuDKZK1mZKbKH2sHXhT
        9JSdatm7puj7qxnCjZfvnlhFtkP9J8fKqQ9ztQpN0ls5B/JJqyiZ80lcXHjb6RXqeoGVpggi7SrZe
        8SyQj2OpPKcyjcMT9BDx6ExR2t1jGMwwWxgdNMnsP0CyMh/oZ+pYQpAS9v6BKZ+cCpWn9ivRSLzQt
        XXnDsoLtNS3Xy8L5XNJ0voNu/aGicAC5x7oEy2v4UuDIbm+lDgBeSFVNJ8cImu0WOrhmFpUzTq8HJ
        RdJ8Ba6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lytm0-006RIQ-VQ; Thu, 01 Jul 2021 10:18:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B502D3001DC;
        Thu,  1 Jul 2021 12:18:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8893620261075; Thu,  1 Jul 2021 12:18:18 +0200 (CEST)
Date:   Thu, 1 Jul 2021 12:18:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
Message-ID: <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
References: <20210701055323.2199175-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701055323.2199175-1-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 03:53:23PM +1000, Nicholas Piggin wrote:
> Currently a single nohz idle CPU is designated to perform balancing on
> behalf of all other nohz idle CPUs in the system. Implement a per node
> nohz balancer to minimize cross-node memory accesses and runqueue lock
> acquisitions.
> 
> On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
> with 32 clients/jobs (which is about where throughput maxes out due to
> IO and contention in postgres).

Hmm, Suresh tried something like this around 2010 and then we ran into
trouble that when once node went completely idle and another node was
fully busy, the completely idle node would not run ILB and the node
would forever stay idle.

I've not gone through the code to see if that could still happen -- lots
has changed since, but it is something to consider.

Some further nits below..

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fb469b26b00a..832f8673bba1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5722,13 +5722,27 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>  
>  #ifdef CONFIG_NO_HZ_COMMON
>  
> -static struct {
> +struct nohz {
>  	cpumask_var_t idle_cpus_mask;
>  	atomic_t nr_cpus;
>  	int has_blocked;		/* Idle CPUS has blocked load */
>  	unsigned long next_balance;     /* in jiffy units */
>  	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
> -} nohz ____cacheline_aligned;
> +} ____cacheline_aligned;
> +
> +static struct nohz **nohz_nodes __ro_after_init;
> +
> +static struct nohz *get_nohz(void)
> +{
> +#ifdef CONFIG_CPU_ISOLATION
> +	/*
> +	 * May not have a house keeping CPU per node, do global idle balancing.
> +	 */
> +	if (static_branch_unlikely(&housekeeping_overridden))
> +		return nohz_nodes[0];
> +#endif
> +	return nohz_nodes[numa_node_id()];
> +}

*urgh* I'm not a fan of that isolation/hk behaviour. Even when the HK
mask allows for a CPU per node, this code won't DTRT. Do we want a
KERN_INFO message that performance will suffer here?

>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> @@ -10291,14 +10305,14 @@ static void nohz_balancer_kick(struct rq *rq)
>  	 * None are in tickless mode and hence no need for NOHZ idle load
>  	 * balancing.
>  	 */
> -	if (likely(!atomic_read(&nohz.nr_cpus)))
> +	if (likely(!atomic_read(&get_nohz()->nr_cpus)))
>  		return;
>  
> -	if (READ_ONCE(nohz.has_blocked) &&
> -	    time_after(now, READ_ONCE(nohz.next_blocked)))
> +	if (READ_ONCE(get_nohz()->has_blocked) &&
> +	    time_after(now, READ_ONCE(get_nohz()->next_blocked)))
>  		flags = NOHZ_STATS_KICK;
>  
> -	if (time_before(now, nohz.next_balance))
> +	if (time_before(now, get_nohz()->next_balance))
>  		goto out;
>  
>  	if (rq->nr_running >= 2) {

Also, stuff like the above, will result in horrific code-gen, because
it cannot CSE get_nohz().
