Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9719A396676
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhEaRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:07:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhEaQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:32:28 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622478644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cefR/DtEcUyRZ8qc11g2NcI+aJPhU+kuvC8iQhInVMA=;
        b=Mk/taBgxowuo4I3RBEs+YxImg4/sI6Zr4+03Zx+d/LpWbdEMBYUa2TQF5IPIEnWqD8K4sR
        rmwewO+kYXUdcfT0fDRR83TP+yPI33o8yq/3r2Ud6S3eHEtLpMHDPbrMA0OyGBZyfc28as
        ai983E+pkcci1wPmFcIWtdC1QM8XFOluLt1kFDjBMS1+726dCSdb/bHe3DKqVP8dOJJR3v
        YaSUqyeq036LwYOJSsQidq1Sw4m4KZnc0KByZSTRW81VU/dT05rRdQRwwPBeMcTAcVWkMb
        ztNn2yNHfxVnV8aCj1NgTKKcTn+3wHagtNRYBaYCwz1UNCBS3VGXXgdclIjQKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622478644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cefR/DtEcUyRZ8qc11g2NcI+aJPhU+kuvC8iQhInVMA=;
        b=SZh3BUGPPABae9lerayRXuLT/DGm3svJi1sw8XUyfOFIRBxKnZdsCuGOlvpMse4wn7jSEP
        odIoz9/KJ5SpFrAA==
To:     Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <20210531162051.2325-2-john.ogness@linutronix.de>
References: <20210531162051.2325-1-john.ogness@linutronix.de> <20210531162051.2325-2-john.ogness@linutronix.de>
Date:   Mon, 31 May 2021 18:30:43 +0200
Message-ID: <87mtsayifg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-31, John Ogness <john.ogness@linutronix.de> wrote:
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
> +{
> +	unsigned int cpu;
> +
> +	for (;;) {
> +		cpu = get_cpu();
> +
> +		*cpu_store = atomic_read(&printk_cpulock_owner);
> +
> +		if (*cpu_store == -1) {
> +			local_irq_save(*flags);
> +
> +			/*
> +			 * Guarantee loads an stores from the previous lock
> +			 * owner are visible to this CPU once it is the lock
> +			 * owner. This pairs with cpu_lock:A.

The above paragraph is totally broken. It should read:

  +			 * Guarantee loads and stores from the previous lock
  +			 * owner are visible to this CPU once it is the lock
  +			 * owner. This pairs with cpu_unlock:B.

John Ogness

> +			 *
> +			 * Memory barrier involvement:
> +			 *
> +			 * If cpu_lock:A reads from cpu_unlock:B, then
> +			 * cpu_lock:B reads from cpu_unlock:A.
> +			 *
> +			 * Relies on:
> +			 *
> +			 * RELEASE from cpu_unlock:A to cpu_unlock:B
> +			 *    matching
> +			 * ACQUIRE from cpu_lock:A to cpu_lock:B
> +			 */
> +			if (atomic_try_cmpxchg_acquire(&printk_cpulock_owner,
> +						       cpu_store, cpu)) { /* LMM(cpu_lock:A) */
> +
> +				/* This CPU begins loading/storing data: LMM(cpu_lock:B) */
> +				break;
> +			}
> +
> +			local_irq_restore(*flags);
> +
> +		} else if (*cpu_store == cpu) {
> +			break;
> +		}
> +
> +		put_cpu();
> +		cpu_relax();
> +	}
> +}
> +EXPORT_SYMBOL(printk_cpu_lock);
> +
> +/*
> + * printk_cpu_unlock: Release the printk cpu-reentrant spinning lock.
> + * @cpu_store: The current lock state.
> + * @flags: The current irq state.
> + *
> + * Release the lock. The calling processor must be the owner of the lock.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void printk_cpu_unlock(unsigned int cpu_store, unsigned long flags)
> +{
> +	if (cpu_store == -1) {
> +		/* This CPU is finished loading/storing data: LMM(cpu_unlock:A) */
> +
> +		/*
> +		 * Guarantee loads an stores from this CPU when it is the lock
> +		 * owner are visible to the next lock owner. This pairs with
> +		 * cpu_lock:A.
> +		 */
> +		atomic_set_release(&printk_cpulock_owner, cpu_store); /* LMM(cpu_unlock:B) */
> +
> +		local_irq_restore(flags);
> +	}
> +
> +	put_cpu();
> +}
> +EXPORT_SYMBOL(printk_cpu_unlock);
> +#endif /* CONFIG_SMP */
> +
>  #endif
