Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFB35A409
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhDIQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233993AbhDIQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617987140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCu0+DF88Wk6o8aei13qcs/Jp5CBCeFghEs6UqaNMcY=;
        b=A7MBDpqpf9a0vyv6hSd/yOjN08+HbCWuSB8nMMO/qCOmBU/y0jM2JTQrsqs9pmOrY8Ie+4
        5YjmR/9wpPa8jnAVyje3+jxNhNZ52x0aawuP+BHzl6fiUgeKkc0qMlEVIlq5ZYIR6Nh5dV
        Jf7opPYrqupuOAV5IF3UciThnFytTjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-umjNdYwrNHK4Pz1fDCdm0w-1; Fri, 09 Apr 2021 12:52:18 -0400
X-MC-Unique: umjNdYwrNHK4Pz1fDCdm0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE726414C;
        Fri,  9 Apr 2021 16:52:17 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 225325D9C0;
        Fri,  9 Apr 2021 16:52:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2444941807D2; Fri,  9 Apr 2021 13:51:46 -0300 (-03)
Date:   Fri, 9 Apr 2021 13:51:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210409165146.GA40118@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
 <87o8en4k9a.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8en4k9a.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC Anna-Maria.

On Fri, Apr 09, 2021 at 04:15:13PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 07 2021 at 10:53, Marcelo Tosatti wrote:
> > Setting the realtime clock triggers an IPI to all CPUs to reprogram
> > hrtimers.
> >
> > However, only base, boottime and tai clocks have their offsets updated
> 
> base clock? 

Heh...

> And why boottime? Boottime is not affected by a clock
> realtime set. It's clock REALTIME and TAI, nothing else.

OK!

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

Again, if (cpu_base->softirq_activated), need to IPI (will resend).

> > +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
> > +
> > +	if ((active & CLOCK_SET_BASES) == 0)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> Errm. 

What?

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
> > +	}
> 
> How is that supposed to be correct?
> 
> CPU0                    	CPU1
> 
> clock_was_set()                 hrtimer_start(CLOCK_REALTIME)
> 
>   if (!active_mask[CPU1] & XXX)
>   	continue;
>                                 active_mask |= REALTIME;
> 
> ---> fail because that newly started timer is on the old offset.

CPU0								CPU1


clock_was_set()
							Case-1: CPU-1 grabs base->lock before CPU-0:
							CPU-0 sees active_mask[CPU1] and IPIs.

							base = lock_hrtimer_base(timer, &flags);
        						if (__hrtimer_start_range_ns(timer, tim, ...
                						hrtimer_reprogram(timer, true);

        						unlock_hrtimer_base(timer, &flags);


raw_spin_lock_irqsave(&cpu_base->lock, flags);
if (need_reprogram_timer(cpu_base))
        cpumask_set_cpu(cpu, mask);
else
        hrtimer_update_base(cpu_base);
raw_spin_unlock_irqrestore(&cpu_base->lock, flags);

							Case-2: CPU-1 grabs base->lock after CPU-0:
							CPU-0 will have updated the offsets remotely.

							base = lock_hrtimer_base(timer, &flags);
        						if (__hrtimer_start_range_ns(timer, tim, ...
                						hrtimer_reprogram(timer, true);

        						unlock_hrtimer_base(timer, &flags);


No?

