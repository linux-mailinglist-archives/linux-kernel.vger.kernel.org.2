Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A47424F74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbhJGIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbhJGIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:52:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C22C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HZb5/J96pgBQ7MBiwWfbh1HIOjJ5t6jlkxYVGBfUxC8=; b=i2mXm14GwgnHra69l9ql5IDqvK
        hWq4fovGv5wBcKNDQmBKqYKuBR0dLZGWVbDhSF//1Tqy6e4p63ztd5ljO1chjEhE3E/FmvyaTpgyH
        L9SRlVaDUP19FQ/4FmVzt35qKRt0141ccVABO98WQZUiGVwgIX1mia1aA4Pn+w407aaVRix8B4/9U
        v+wixmAdPO1qVOrkVBahGPIxAAblFt8Bs+JxVIBUIddaytrKsDmA+cNxwA86B2Y4Pv6WOeOGwvX29
        l9dNyXlImJNGtpYChJJEq/Rp2pHwSHSlWXynKlv+WgW7p+phu9ehoADN7Ha4PncrqCaGyvIuq8HrW
        HuHe/s9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYP6e-008Rej-3F; Thu, 07 Oct 2021 08:50:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F56D98623C; Thu,  7 Oct 2021 10:50:23 +0200 (CEST)
Date:   Thu, 7 Oct 2021 10:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/4] irq_work: Handle some irq_work in a per-CPU
 thread on PREEMPT_RT
Message-ID: <20211007085023.GP174703@worktop.programming.kicks-ass.net>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
 <20211006111852.1514359-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006111852.1514359-4-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:18:51PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -104,7 +141,24 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>  	if (cpu != smp_processor_id()) {
>  		/* Arch remote IPI send/receive backend aren't NMI safe */
>  		WARN_ON_ONCE(in_nmi());
> -		__smp_call_single_queue(cpu, &work->node.llist);
> +
> +		/*
> +		 * On PREEMPT_RT the items which are not marked as
> +		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
> +		 * item is used on the remote CPU to wake the thread.
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ) &&
> +		    llist_add(&work->node.llist, &per_cpu(lazy_list, cpu))) {

So if the llist not empty, we'll fail here, and go to the else branch

> +			struct irq_work *wake_work;
> +
> +			wake_work = &per_cpu(irq_work_pending, cpu);
> +			if (irq_work_claim(wake_work))
> +				__smp_call_single_queue(cpu,
> +							&wake_work->node.llist);
> +		} else {

And do this,.. that seems wrong.

> +			__smp_call_single_queue(cpu, &work->node.llist);
> +		}
>  	} else {
>  		__irq_work_queue_local(work);
>  	}

How's this instead?

(work rename due to there already being a percpu variable of that same
name on a number or archs, per 0day)


Index: linux-2.6/kernel/irq_work.c
===================================================================
--- linux-2.6.orig/kernel/irq_work.c
+++ linux-2.6/kernel/irq_work.c
@@ -39,7 +39,7 @@ static void irq_work_wake(struct irq_wor
 	wake_irq_workd();
 }
 
-static DEFINE_PER_CPU(struct irq_work, irq_work_pending) =
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =
 	IRQ_WORK_INIT_HARD(irq_work_wake);
 
 static int irq_workd_should_run(unsigned int cpu)
@@ -148,20 +148,21 @@ bool irq_work_queue_on(struct irq_work *
 		 * item is used on the remote CPU to wake the thread.
 		 */
 		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
-		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ) &&
-		    llist_add(&work->node.llist, &per_cpu(lazy_list, cpu))) {
-			struct irq_work *wake_work;
-
-			wake_work = &per_cpu(irq_work_pending, cpu);
-			if (irq_work_claim(wake_work))
-				__smp_call_single_queue(cpu,
-							&wake_work->node.llist);
-		} else {
-			__smp_call_single_queue(cpu, &work->node.llist);
+		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work = &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(wake_work))
+				goto out;
 		}
+
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
 
 	return true;
