Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E964423CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbhJFLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbhJFLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:37:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09602C06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:35:32 -0700 (PDT)
Date:   Wed, 6 Oct 2021 13:35:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633520130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a90TXWVbNkdsb6SphKwWspeEcuqjOB6t/fVIksdcNeQ=;
        b=jQxZYIOog4h/qnHLEFhyxjgAhWspZSAwPbMnPURWZSFwyW9XhALj8MBfgT6TeAmU5EoXDO
        2MJyukg/A3oudELeXJb5VeMsg8ub5wduCnGDJxfnsA+gjoDRaWn4VDLH4+tTDZzI488bD1
        GRdWIGvNR6EWfcg5M+AGDu7JH+T0+WysR+tuykvdML9Nv9dA3SDwg6tR09XSHqUG3aWpzL
        Nxla1UGKLGrvG78bdP36CqpuvhKnboVkNYAbgw6mZ8nOjJ5hU/E/gVfDzzgRx3JSImJbNP
        mQKfXz7XVZX42y3bjm05VDZeEDxVcuaXBajcPA7sJixtVOoVzvGm1rYVRx3jEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633520130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a90TXWVbNkdsb6SphKwWspeEcuqjOB6t/fVIksdcNeQ=;
        b=NvZZO0IRTcCWRIfLk64CGhU8f+Bti5ExLzN+TJidg25pbONNvPxsIl0wYdlfTxV02pciz/
        PyfyK88Cnt8rGbBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/4] irq_work: Handle some irq_work in a per-CPU
 thread on PREEMPT_RT
Message-ID: <20211006113529.xgieqegb6u3nxjvx@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
 <20211006111852.1514359-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006111852.1514359-4-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-06 13:18:51 [+0200], To linux-kernel@vger.kernel.org wrote:
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index e789beda8297d..daa5d12522faa 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -18,11 +18,34 @@
>  #include <linux/cpu.h>
>  #include <linux/notifier.h>
>  #include <linux/smp.h>
> +#include <linux/smpboot.h>
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
>  
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> +static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> +
> +static void wake_irq_workd(void)
> +{
> +	struct task_struct *tsk = __this_cpu_read(irq_workd);
> +
> +	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
> +		wake_up_process(tsk);
> +}

#ifdef CONFIG_SMP

> +static void irq_work_wake(struct irq_work *entry)
> +{
> +	wake_irq_workd();
> +}
> +
> +static DEFINE_PER_CPU(struct irq_work, irq_work_pending) =
> +	IRQ_WORK_INIT_HARD(irq_work_wake);

#endif

> +static int irq_workd_should_run(unsigned int cpu)
> +{
> +	return !llist_empty(this_cpu_ptr(&lazy_list));
> +}
>  
>  /*
>   * Claim the entry so that no one else will poke at it.

Sebastian
