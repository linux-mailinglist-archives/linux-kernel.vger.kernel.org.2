Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7453F3DFE6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhHDJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:53:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhHDJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:53:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC19E22149;
        Wed,  4 Aug 2021 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628070769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYcOI0WrEElgIslH4aKnjBiPq+5+gfy+9XKG/Vylt7g=;
        b=IUPYNUJuywUFufeSCWhDIbwMGXNB0beJHTNh0lHK8EmBRus/obSNGdqmT7mzT1acP+rNpi
        EZdoiha4bm1PJ0qGuf53C2g8s5+/80egTaUL7kpn9+2yaH5nVtFkXIuLePbJzg6s67pJEZ
        tvQBu5BG+yiWHnl7Uow1GR8ZotX3zqA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85E5AA3B89;
        Wed,  4 Aug 2021 09:52:49 +0000 (UTC)
Date:   Wed, 4 Aug 2021 11:52:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/10] printk: rename printk cpulock API and
 always disable interrupts
Message-ID: <YQpjcYSxUU0pjZhU@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 15:18:53, John Ogness wrote:
> The printk cpulock functions use local_irq_disable(). This means that
> hardware interrupts are also disabled on PREEMPT_RT. To make this
> clear, rename the functions to use the raw_ prefix:
> 
>     raw_printk_cpu_lock_irqsave(flags);
>     raw_printk_cpu_unlock_irqrestore(flags);
> 
> Also, these functions were a NOP for !CONFIG_SMP. But for !CONFIG_SMP
> they still need to disable hardware interrupts. So modify them
> appropriately for this.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/printk.h | 30 ++++++++++++++----------------
>  lib/dump_stack.c       |  4 ++--
>  lib/nmi_backtrace.c    |  4 ++--
>  3 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 259af4f97f50..ac738d1d9934 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -280,17 +280,22 @@ static inline void dump_stack(void)
>  extern int __printk_cpu_trylock(void);
>  extern void __printk_wait_on_cpu_lock(void);
>  extern void __printk_cpu_unlock(void);
> +#else
> +#define __printk_cpu_trylock()		1
> +#define __printk_wait_on_cpu_lock()
> +#define __printk_cpu_unlock()
> +#endif /* CONFIG_SMP */

IMHO, it is not obvious that

		while (!__printk_cpu_trylock())		\
			__printk_wait_on_cpu_lock();	\

does nothing in the !CONFIG_SMP case. Please, make it more obvious.
I suggest to define:

#ifdef CONFIG_SMP

#define __printk_cpu_lock()				\
	do {						\
		while (!__printk_cpu_trylock())		\
			__printk_wait_on_cpu_lock();	\
	} while (0)

#else

#define __printk_cpu_lock()

#endif

/**
 * raw_printk_cpu_lock_irqsave() - Disable interrupts and acquire the printk
 *                                 cpu-reentrant spinning lock.
 * @flags: Stack-allocated storage for saving local interrupt state,
 *         to be passed to raw_printk_cpu_unlock_irqrestore().
 *
 * If the lock is owned by another CPU, spin until it becomes available.
 */
#define raw_printk_cpu_lock_irqsave(flags)	\
	do {					\
		local_irq_save(flags);		\
		__printk_cpu_lock();		\
	} while (0)


Best Regards,
Petr
