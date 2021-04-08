Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4A358343
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhDHM2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhDHM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617884909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKcZ0VqbPmHrFkm52IOoyg6DVy6p648HX0NLKXQWU3U=;
        b=FgaYCTKDLHv7vbJbIb3AXY5jjS6lDHjWYVCMWt/sghZXjo0AV6D3sIKtKgB/QOfjTYmB9c
        m+4Vg3JzAC42WgMHnl3YMZsIZ5JYgBjc97p+fs+fCC5/ZhF+B0l6E59Bcoa8chwwIel4Vb
        nC33L6O2+98fktzlh+5qWMse2MwQXdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-69HdSCEmMrqUBQflRxkdCA-1; Thu, 08 Apr 2021 08:28:27 -0400
X-MC-Unique: 69HdSCEmMrqUBQflRxkdCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A66107ACC7;
        Thu,  8 Apr 2021 12:28:26 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDDAB1972B;
        Thu,  8 Apr 2021 12:28:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 803BB41807CE; Thu,  8 Apr 2021 09:27:34 -0300 (-03)
Date:   Thu, 8 Apr 2021 09:27:34 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210408122734.GA66926@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
 <20210407221457.GA56249@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407221457.GA56249@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:14:57AM +0200, Frederic Weisbecker wrote:
> On Wed, Apr 07, 2021 at 10:53:01AM -0300, Marcelo Tosatti wrote:
> > 
> > Setting the realtime clock triggers an IPI to all CPUs to reprogram
> > hrtimers.
> > 
> > However, only base, boottime and tai clocks have their offsets updated
> > (and therefore potentially require a reprogram).
> > 
> > If the CPU is a nohz_full one, check if it only has 
> > monotonic active timers, and in that case update the 
> > realtime base offsets, skipping the IPI.
> > 
> > This reduces interruptions to nohz_full CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index 743c852e10f2..b42b1a434b22 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -853,6 +853,28 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
> >  	tick_program_event(expires, 1);
> >  }
> >  
> > +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\
> > +			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
> > +			 (1U << HRTIMER_BASE_BOOTTIME)|		\
> > +			 (1U << HRTIMER_BASE_BOOTTIME_SOFT)|	\
> > +			 (1U << HRTIMER_BASE_TAI)|		\
> > +			 (1U << HRTIMER_BASE_TAI_SOFT))
> > +
> > +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> > +{
> > +	unsigned int active = 0;
> > +
> > +	if (!cpu_base->softirq_activated)
> > +		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;

If cpu_base->softirq_activated == 1, should IPI as well.

> > +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
> > +
> > +	if ((active & CLOCK_SET_BASES) == 0)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  /*
> >   * Clock realtime was set
> >   *
> > @@ -867,9 +889,41 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
> >  void clock_was_set(void)
> >  {
> >  #ifdef CONFIG_HIGH_RES_TIMERS
> > -	/* Retrigger the CPU local events everywhere */
> > -	on_each_cpu(retrigger_next_event, NULL, 1);
> > +	cpumask_var_t mask;
> > +	int cpu;
> > +
> > +	if (!tick_nohz_full_enabled()) {
> > +		/* Retrigger the CPU local events everywhere */
> > +		on_each_cpu(retrigger_next_event, NULL, 1);
> > +		goto set_timerfd;
> > +	}
> > +
> > +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> > +		on_each_cpu(retrigger_next_event, NULL, 1);
> > +		goto set_timerfd;
> > +	}
> > +
> > +	/* Avoid interrupting nohz_full CPUs if possible */
> > +	preempt_disable();
> > +	for_each_online_cpu(cpu) {
> > +		if (tick_nohz_full_cpu(cpu)) {
> > +			unsigned long flags;
> > +			struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> > +
> > +			raw_spin_lock_irqsave(&cpu_base->lock, flags);
> > +			if (need_reprogram_timer(cpu_base))
> > +				cpumask_set_cpu(cpu, mask);
> > +			else
> > +				hrtimer_update_base(cpu_base);
> > +			raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
> > +		}
> 
> You forgot to add the housekeeping CPUs to the mask.

So people are using:

console=tty0 console=ttyS0,115200n8 skew_tick=1 nohz=on rcu_nocbs=8-31 tuned.non_isolcpus=000000ff intel_pstate=disable nosoftlockup tsc=nowatchdog intel_iommu=on iommu=pt isolcpus=managed_irq,8-31 systemd.cpu_affinity=0,1,2,3,4,5,6,7 default_hugepagesz=1G hugepagesz=2M hugepages=128 nohz_full=8-31

And using the nohz_full= CPUs (or subsets of nohz_full= CPUs) in two modes:

Either "generic non-isolated applications" 
(with load-balancing enabled for those CPUs), or for 
latency sensitive applications. And switching between the modes.

In this case, it would only be possible to check for
housekeeping CPUs of type MANAGED_IRQ, which would be strange.

> As for the need_reprogram_timer() trick, I'll rather defer to Thomas review...
> 
> Thanks.

Thanks!

> 
> > +	}
> > +
> > +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
> > +	preempt_enable();
> > +	free_cpumask_var(mask);
> >  #endif
> > +set_timerfd:
> >  	timerfd_clock_was_set();
> >  }
> >  
> > 

