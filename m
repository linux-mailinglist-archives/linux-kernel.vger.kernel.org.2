Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0902F3974C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhFAOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:01:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:01:00 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AA3281FD2A;
        Tue,  1 Jun 2021 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622555958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvK2aV1k6fqfz3NNbUZjZyUfepr3RhH8MyL7tlfw1ag=;
        b=W10wK2gMAj2r0R6Fw3jknL9OXxKuBw+HsJ4licSHMGLRLYM2mwqtozsGEyov8evpkaT7/W
        74wAGHAHAAdws5NQmvrAbqGyvT5MXJtGMVP4GQrjeaoVeGcRPC44MGOtKzafAnb1pivJtN
        R2qR+wQG8hyDA7ygBkrIakFW4HujKe4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C83AEA3B83;
        Tue,  1 Jun 2021 13:59:17 +0000 (UTC)
Date:   Tue, 1 Jun 2021 15:59:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YLY9NR7C1IFuNI4A@alley>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
 <20210531162051.2325-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531162051.2325-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-31 18:20:50, John Ogness wrote:
> dump_stack() implements its own cpu-reentrant spinning lock to
> best-effort serialize stack traces in the printk log. However,
> there are other functions (such as show_regs()) that can also
> benefit from this serialization.
> 
> Move the cpu-reentrant spinning lock (cpu lock) into new helper
> functions printk_cpu_lock()/printk_cpu_unlock() so that it is
> available for others as well. For !CONFIG_PRINTK or !CONFIG_SMP
> the cpu lock is a NOP.
> 
> Note that having multiple cpu locks in the system can easily
> lead to deadlock. Code needing a cpu lock should use the
> printk cpu lock, since the printk cpu lock could be acquired
> from any code and any context.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 114e9963f903..98feead621ff 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3531,4 +3531,96 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
> +#ifdef CONFIG_SMP
> +static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> +
> +/*
> + * printk_cpu_lock: Acquire the printk cpu-reentrant spinning lock.
> + * @cpu_store: A buffer to store lock state.
> + * @flags: A buffer to store irq state.
> + *
> + * If no processor has the lock, the calling processor takes the lock and
> + * becomes the owner. If the calling processor is already the owner of the
> + * lock, this function succeeds immediately. If the lock is locked by another
> + * processor, that function spins until the calling processor becomes the
> + * owner.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)

I think about calling this printk_cpu_lock_irqsave() to make it clear
that it disables interrupts.

Strictly speaking, it should be enough to disable preemption. If it is
safe when interrupted by NMI, it must be safe also when interrupted
by a normal interrupt.

I guess that the interrupts are disabled because it reduces the risk
of nested (messed) backtraces.

Anyway, I would keep the current approach (disabled irqs) unless we
have a good reason to change it. Well, enabled irqs might be better
for RT.

Best Regards,
Petr
