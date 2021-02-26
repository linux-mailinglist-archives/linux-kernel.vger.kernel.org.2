Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353083266C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhBZSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhBZSMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:12:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A88D064F0D;
        Fri, 26 Feb 2021 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614363125;
        bh=Hq9nQud27ajZQKgTqLPDkKCQ20aGL8YgtoWSdS1bxYM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H83hjdZwUr1CQdNx1CJmo9ueIjpSgNEYT57R8TgZxWrrFwhGasx5iLpy9YxoKuhfE
         oABEeeGWg3um4I5Egd0Eqg7l33rNI08U0jEn84L2A/r8ZMmEpHGJBbG/Sr/Nj3j3km
         ynMoqGeWYHsRPY9L77510BozuadAFnzlgcUVXEWk1lRPCqj4DMipgFfRuF+9nLPc6i
         QfvLUB0BEYgjvNPn0zqQNo8afVDexqYZZAZYUR8H/KVDgO6WkRbMqw9kFsI4WC21rT
         AxGdFDFhFUM8P7cTf8WL0gdPa231ywseFR2N0msr4zLUxdUhclrNxwEmBEmcTkmoRt
         H9VYLTZyqvlZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62F263522FAD; Fri, 26 Feb 2021 10:12:05 -0800 (PST)
Date:   Fri, 26 Feb 2021 10:12:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <20210226181205.GZ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
> 
> I hate all of this, but if this will finally catch the actual problem,
> we can then revert all this, so sure.

OK, I will bite...  What exactly do you hate about it?

							Thanx, Paul

> Also, I think this will conflict with the patches from Nadav that I have
> queued:
> 
>   https://lkml.kernel.org/r/20210220231712.2475218-1-namit@vmware.com
> 
> which I'll be pushing to tip/x86/mm once -rc1 happens.
> 
> On Fri, Feb 26, 2021 at 12:25:21PM +0100, Juergen Gross wrote:
> 
> > +static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
> > +{
> > +	unsigned int this_cpu = smp_processor_id();
> > +	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
> > +	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
> > +	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
> > +
> > +	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
> > +	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
> > +		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
> > +		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
> > +		send_call_function_single_ipi(cpu);
> > +		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
> > +	} else {
> > +		cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
> > +	}
> > +}
> >  #else
> > +#define cfd_seq_store(var, src, dst, type)
> > +
> >  static void csd_lock_record(call_single_data_t *csd)
> >  {
> >  }
> > @@ -290,6 +396,19 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
> >  
> >  void __smp_call_single_queue(int cpu, struct llist_node *node)
> >  {
> > +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > +	if (static_branch_unlikely(&csdlock_debug_extended)) {
> > +		unsigned int type;
> > +
> > +		type = CSD_TYPE(container_of(node, call_single_data_t,
> > +					     node.llist));
> > +		if (type == CSD_TYPE_SYNC || type == CSD_TYPE_ASYNC) {
> > +			__smp_call_single_queue_debug(cpu, node);
> > +			return;
> > +		}
> > +	}
> > +#endif
> 
> This is a bit weird, might as well put it in generic_exec_single()
> because there you still know the type matches.
> 
> 
> > @@ -712,12 +840,21 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
> >  		csd->node.src = smp_processor_id();
> >  		csd->node.dst = cpu;
> >  #endif
> > -		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
> > +		cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
> > +		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
> >  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> > +			cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
> > +		} else {
> > +			cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
> > +		}
> >  	}
> >  
> >  	/* Send a message to all CPUs in the map */
> > +	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->ping, this_cpu,
> > +		      CFD_SEQ_NOCPU, CFD_SEQ_PING);
> >  	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
> > +	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu,
> > +		      CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
> 
> Too bad we can't share with the single case, a well.
