Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0734BF89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 00:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhC1WEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 18:04:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhC1WEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 18:04:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616969075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMSDZxbZUdk3bc8y+nSC5JaiqgjkwXBno7O9/VX/IGM=;
        b=XOGKBRsXuU8MjqdvlbtmVCwXPtrCPvQKfQg0H5EAqX0/LtFgRZVe3HYRGLaXqUlk+fNrvj
        Vy3u1DW4xd5yA2mQIxrZj72E0kvVzhJyRKP59i34a/qfQiUTEOkCtFwKxuublH1W1wdhkP
        H3w0PJb8kXQ4Pkkg7oDbQhgs5tFX2zP0tZzgnoqPAF/ZiiW3nHrnoNkiBYfob7b3V83kIh
        /K4KikrDNzP3wG79HUhY18PTO9XusxWGhAXkm957dCU/eX7nMZyIe4Wu6eu/RUAxzIwC/t
        ZpLkWVJKjs6MkMJVz6hPmUlLmIw1OXtYrwq/vS9EEFdw/URpv13u5xRHXu02fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616969075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMSDZxbZUdk3bc8y+nSC5JaiqgjkwXBno7O9/VX/IGM=;
        b=pK4Ko5ppfmrWGqC5yYOfxVlujh1gHUNHIQivHsjXdPDTEfMhTIwqe19P1WZ4cgyFC4aF1U
        jmJBgKop2bD1lACw==
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] x86/apic/vector: Move pr_warn() outside of vector_lock
In-Reply-To: <20210328195811.32109-1-longman@redhat.com>
References: <20210328195811.32109-1-longman@redhat.com>
Date:   Mon, 29 Mar 2021 00:04:34 +0200
Message-ID: <871rbzc4ul.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman,

On Sun, Mar 28 2021 at 15:58, Waiman Long wrote:
> It was found that the following circular locking dependency warning
> could happen in some systems:
>
> [  218.097878] ======================================================
> [  218.097879] WARNING: possible circular locking dependency detected
> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
> [  218.097881] ------------------------------------------------------
> [  218.097882] systemd/1 is trying to acquire lock:
> [  218.097883] ffffffff84c27920 (console_owner){-.-.}, at: console_unlock+0x3fb/0x9f0
> [  218.097886]
> [  218.097887] but task is already holding lock:
> [  218.097888] ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
> [  218.097891]
> [  218.097892] which lock already depends on the new lock.
>     :
> [  218.097966] other info that might help us debug this:
> [  218.097967]
> [  218.097967] Chain exists of:
> [  218.097968]   console_oc_lock_class --> vector_lock
> [  218.097972]
> [  218.097973]  Possible unsafe locking scenario:
> [  218.097973]
> [  218.097974]        CPU0                    CPU1
> [  218.097975]        ----                    ----
> [  218.097975]   lock(vector_lock);
> [  218.097977]                                lock(&irq_desc_lock_class);
> [  218.097980]                                lock(vector_lock);
> [  218.097981]   lock(console_owner);
> [  218.097983]
> [  218.097984]  *** DEADLOCK ***

can you please post the full lockdep output?

> This lockdep warning was causing by printing of the warning message:
>
> [  218.095152] irq 3: Affinity broken due to vector space exhaustion.
>
> It looks that this warning message is relatively more common than
> the other warnings in arch/x86/kernel/apic/vector.c. To avoid this
> potential deadlock scenario, this patch moves all the pr_warn() calls
> in the vector.c file outside of the vector_lock critical sections.

Definitely not.

> -static int activate_reserved(struct irq_data *irqd)
> +static int activate_reserved(struct irq_data *irqd, unsigned long flags,
> +			     bool *unlocked)
>  {
>  	struct apic_chip_data *apicd = apic_chip_data(irqd);
>  	int ret;
> @@ -410,6 +411,8 @@ static int activate_reserved(struct irq_data *irqd)
>  	 */
>  	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
>  			    irq_data_get_affinity_mask(irqd))) {
> +		raw_spin_unlock_irqrestore(&vector_lock, flags);
> +		*unlocked = true;

What?

>  		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
>  			irqd->irq);
>  	}
> @@ -446,6 +449,7 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
>  {
>  	struct apic_chip_data *apicd = apic_chip_data(irqd);
>  	unsigned long flags;
> +	bool unlocked = false;
>  	int ret = 0;
>  
>  	trace_vector_activate(irqd->irq, apicd->is_managed,
> @@ -459,8 +463,9 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
>  	else if (apicd->is_managed)
>  		ret = activate_managed(irqd);
>  	else if (apicd->has_reserved)
> -		ret = activate_reserved(irqd);
> -	raw_spin_unlock_irqrestore(&vector_lock, flags);
> +		ret = activate_reserved(irqd, flags, &unlocked);
> +	if (!unlocked)
> +		raw_spin_unlock_irqrestore(&vector_lock, flags);

Even moar what?

>  	return ret;
>  }

This turns that code into complete unreadable gunk. No way.

Thanks,

        tglx
