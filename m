Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8835C5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhDLME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhDLMEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:04:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jE5PXGC65L/nbD8CH6oCJ9zdGMAFC2mSOx1780VgauQ=; b=i4AKSFTCTEfa0/T8S4eb+8QQRi
        qO0fAGcQs2acJq6kASsjK3MgpbdSxG7zsU2IEczLyy7u2TcjngG9FHYEhE5f7UAVTSFEfPB4kKXPU
        H/RVWDVpcST4CTO8r/j74uP/IN5shazvIB7a0IjoAZeS/+/JSuR5SAcbSesF/ugJTPHkNE8LT81kZ
        +n8p4qluvWFGGE4Rx2DEOrGQsOA8PlLLLKPuMJP+0tnYZ919nDivL8MLSPOll866ySwnq8e34ie8I
        ZkFOQHBYB5BamdFRLvPvMEKFSHlPcucec2dS4JnzWeM+Qj2AkAbKbjd7tDDWIa9lpOZ9oIgTMAuty
        +dHpKWEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVvIC-006djf-PN; Mon, 12 Apr 2021 12:03:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2598B300036;
        Mon, 12 Apr 2021 14:03:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B55720224202; Mon, 12 Apr 2021 14:03:47 +0200 (CEST)
Date:   Mon, 12 Apr 2021 14:03:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:13:04PM +0000, Valentin Schneider wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > @@ -7883,14 +7889,6 @@ int sched_cpu_deactivate(unsigned int cp
> >  	set_cpu_active(cpu, false);
> >  
> >  	/*
> > -	 * From this point forward, this CPU will refuse to run any task that
> > -	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> > -	 * push those tasks away until this gets cleared, see
> > -	 * sched_cpu_dying().
> > -	 */
> > -	balance_push_set(cpu, true);
> > -
> > -	/*
> >  	 * We've cleared cpu_active_mask / set balance_push, wait for all
> >  	 * preempt-disabled and RCU users of this state to go away such that
> >  	 * all new such users will observe it.
> > @@ -7910,6 +7908,14 @@ int sched_cpu_deactivate(unsigned int cp
> >  	}
> >  	rq_unlock_irqrestore(rq, &rf);
> >  
> > +	/*
> > +	 * From this point forward, this CPU will refuse to run any task that
> > +	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> > +	 * push those tasks away until this gets cleared, see
> > +	 * sched_cpu_dying().
> > +	 */
> > +	balance_push_set(cpu, true);
> > +
> 
> AIUI with cpu_dying_mask being flipped before even entering
> sched_cpu_deactivate(), we don't need this to be before the
> synchronize_rcu() anymore; is there more than that to why you're punting it
> back this side of it?

I think it does does need to be like this, we need to clearly separate
the active=true and balance_push_set(). If we were to somehow observe
both balance_push_set() and active==false, we'd be in trouble.

> >  #ifdef CONFIG_SCHED_SMT
> >  	/*
> >  	 * When going down, decrement the number of cores with SMT present.
> 
> > @@ -8206,7 +8212,7 @@ void __init sched_init(void)
> >  		rq->sd = NULL;
> >  		rq->rd = NULL;
> >  		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
> > -		rq->balance_callback = NULL;
> > +		rq->balance_callback = &balance_push_callback;
> >  		rq->active_balance = 0;
> >  		rq->next_balance = jiffies;
> >  		rq->push_cpu = 0;
> > @@ -8253,6 +8259,7 @@ void __init sched_init(void)
> >  
> >  #ifdef CONFIG_SMP
> >  	idle_thread_set_boot_cpu();
> > +	balance_push_set(smp_processor_id(), false);
> >  #endif
> >  	init_sched_fair_class();
> >
> 
> I don't get what these two changes do - the end result is the same as
> before, no?

Not quite; we have to make sure the state of the offline CPUs matches
that of a CPU that's been offlined. For consistency if nothing else, but
it's actually important for a point below.

> Also, AIUI this patch covers the cpu_dying -> !cpu_dying rollback case
> since balance_push gets numbed down by !cpu_dying. What about the other way
> around (hot-plug failure + rollback)? We may have allowed !pcpu tasks on the
> now-dying CPU, and we'd need to re-install the balance_push callback. 

This is in fact handled. Note how the previous point initialized the
offline CPU to have the push_callback installed.

Also note how balance_push() re-instates itself unconditionally.

So the thing is, we install the push callback on deactivate() and leave
it in place until activate, it is always there, regardless what way
we're moving.

However, it is only effective whild going down, see the early exit.
