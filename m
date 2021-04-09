Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949435A0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhDIOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:15:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD7C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:15:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617977714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WkXn31OvwcKivi5nSOB8jsWp1dYiKivw1SB0BEXTP4=;
        b=Mo4DmzBJmL/H93vPojF1SI7s/j81/oVrAL8cluu83Z2LJVJGfVgj0fG/sUT9sAYMB1wteV
        ToXDlnPUKZY8IsUtdMAugUXcjQo11Wp2LeJoQlO2QpWIpGYCA5/QPIDCgTrz69GHY0Ckgs
        e3QPTwCJVD8MDVnbVAaZB4WQnzZPUfah48BGNGEptNYDyhialgZmIVqZj7nbJ9ONYXFo9J
        UvrOov7K5c/dxDRSGZulUuPt0e/YYZiPTwvZvuAwQ6DadutewI3BYhdB3jl8GUPPVgbXTf
        DYWBAfscEwGIvGTddapLlIbTG4n6nrIVDEY95bmcRXIbm2eA46AemUIVwMHkjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617977714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WkXn31OvwcKivi5nSOB8jsWp1dYiKivw1SB0BEXTP4=;
        b=Q8CoIDYDlEmmgsW29bv9/3OrPe1miDQqfRTaGQmjHdVtZeWJDFXkhxhgH6dNfKMK60EWOp
        XUIzdkPnwfHtK8Cg==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210407135301.GA16985@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
Date:   Fri, 09 Apr 2021 16:15:13 +0200
Message-ID: <87o8en4k9a.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07 2021 at 10:53, Marcelo Tosatti wrote:
> Setting the realtime clock triggers an IPI to all CPUs to reprogram
> hrtimers.
>
> However, only base, boottime and tai clocks have their offsets updated

base clock? And why boottime? Boottime is not affected by a clock
realtime set. It's clock REALTIME and TAI, nothing else.

> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\
> +			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
> +			 (1U << HRTIMER_BASE_BOOTTIME)|		\
> +			 (1U << HRTIMER_BASE_BOOTTIME_SOFT)|	\
> +			 (1U << HRTIMER_BASE_TAI)|		\
> +			 (1U << HRTIMER_BASE_TAI_SOFT))
> +
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	unsigned int active = 0;
> +
> +	if (!cpu_base->softirq_activated)
> +		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
> +
> +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
> +
> +	if ((active & CLOCK_SET_BASES) == 0)
> +		return false;
> +
> +	return true;
> +}

Errm. 

> +	/* Avoid interrupting nohz_full CPUs if possible */
> +	preempt_disable();
> +	for_each_online_cpu(cpu) {
> +		if (tick_nohz_full_cpu(cpu)) {
> +			unsigned long flags;
> +			struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +
> +			raw_spin_lock_irqsave(&cpu_base->lock, flags);
> +			if (need_reprogram_timer(cpu_base))
> +				cpumask_set_cpu(cpu, mask);
> +			else
> +				hrtimer_update_base(cpu_base);
> +			raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
> +		}
> +	}

How is that supposed to be correct?

CPU0                    	CPU1

clock_was_set()                 hrtimer_start(CLOCK_REALTIME)

  if (!active_mask[CPU1] & XXX)
  	continue;
                                active_mask |= REALTIME;

---> fail because that newly started timer is on the old offset.

Thanks,

        tglx


