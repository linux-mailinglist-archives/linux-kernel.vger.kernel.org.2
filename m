Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55EB34D046
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhC2MnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:43:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhC2Mma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:42:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617021749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MD07HADXLC3/GOZUxS2FFQo7igF57C3e09wAtmaN2jw=;
        b=nuO9E8WS6enpBvNOmsNkXVnsjTJejRHibkw4Z/n3QvNUkPSUibYHHblV2qCeK61TLJP1oZ
        cYO5gHELKOXKB54ZIdsyNTcsHtfolsDGkrQ6wMhZT2789MiN01t2y+2ADpTM72JEch2Si+
        qztbVkTYdX9NIVMtTjVfQxug1zLRR9+1bkwA6/r1SgXQO+xC80fkr9n1A0G7qDZNuvdbL2
        KdNwOJoim6bykRHpiPvpOkGVrSNhZj7nTw5/esdmr8k4Xg5jUivw9M0c0K6UbLKSngrx49
        7kO6FJ5X2XpzX3/H2M37y0u/0Z7X5OA090ZvrjtfWSt3Pv3z1VeCu2KT3qu4OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617021749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MD07HADXLC3/GOZUxS2FFQo7igF57C3e09wAtmaN2jw=;
        b=Zw1DKJZHMibgzO9HoVM6bi3uaqCW3UODWJit7+ko/YucUzw/CmuC3Ocsx+0hAIQDBeeOnA
        cUI/zDE3pQZxGlDw==
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] x86/apic/vector: Move pr_warn() out of vector_lock
In-Reply-To: <20210329005236.1218-1-longman@redhat.com>
References: <20210329005236.1218-1-longman@redhat.com>
Date:   Mon, 29 Mar 2021 14:42:28 +0200
Message-ID: <87tuoub07f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman,

On Sun, Mar 28 2021 at 20:52, Waiman Long wrote:
> It was found that the following circular locking dependency warning
> could happen in some systems:
>
> [  218.097878] ======================================================
> [  218.097879] WARNING: possible circular locking dependency detected
> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted

Reports have to be against latest mainline and not against the random
distro frankenkernel of the day. That's nothing new.

Plus I was asking you to provide a full splat to look at so this can be
discussed _upfront_. Oh well...

> [  218.097914] -> #2 (&irq_desc_lock_class){-.-.}:
> [  218.097917]        _raw_spin_lock_irqsave+0x48/0x81
> [  218.097918]        __irq_get_desc_lock+0xcf/0x140
> [  218.097919]        __dble_irq_nosync+0x6e/0x110

This function does not even exist in mainline and never existed...

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
> [  218.097984]
> [  218.097985] 6 locks held by systemd/1:
> [  218.097986]  #0: ffff88822b5cc1e8 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x79/0x440
> [  218.097989]  #1: ffff88832ee00770 (&port->mutex){+.+.}, at: tty_port_open+0x85/0x190
> [  218.097993]  #2: ffff88813be85a88 (&desc->request_mutex){+.+.}, at: __setup_irq+0x249/0x1e60
> [  218.097996]  #3: ffff88813be858c0 (&irq_desc_lock_class){-.-.}, at: __setup_irq+0x2d9/0x1e60
> [  218.098000]  #4: ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
> [  218.098003]  #5: ffffffff84c27e20 (console_lock){+.+.}, at: vprintk_emit+0x13a/0x450

This is a more fundamental problem than just vector lock and the same
problem exists with any other printk over serial which is nested in the
interrupt activation chain not only on X86.

> -static int activate_reserved(struct irq_data *irqd)
> +static int activate_reserved(struct irq_data *irqd, char *wbuf, size_t wsize)
>  {

...

>  	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
>  			    irq_data_get_affinity_mask(irqd))) {
> -		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
> -			irqd->irq);
> +		snprintf(wbuf, wsize, KERN_WARNING
> +			 "irq %u: Affinity broken due to vector space exhaustion.\n",
> +			 irqd->irq);

This is not really any more tasteful than the previous one and it does
not fix the fundamental underlying problem.

But, because I'm curious and printk is a constant source of trouble, I
just added unconditional pr_warns into those functions under vector_lock
on 5.12-rc5.

Still waiting for the lockdep splat to show up while enjoying the
trickle of printks over serial.

If you really think this is an upstream problem then please provide a
corresponding lockdep splat on plain 5.12-rc5 along with a .config and
the scenario which triggers this. Not less, not more.

Thanks,

        tglx

