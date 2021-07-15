Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2373A3C9D41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbhGOKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhGOKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:52:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91044C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jBldaLpoA+iBOiddlp6nepRAIyOxyG6Gerdq9QKt0fA=; b=Ww/2EgNq5GuI5aMgaxizDWWgId
        yjdQFbmZdi6Owcntzoxy3INg7/irSyt6ZLT0iMCUQQQRLDx3XxDLPStAwzm9g21lgv5O3iLr3FPqb
        9PP7dCBEzvoWr++oKtBB15Sfo/saBCKL8Uuq8yCz1U5X/AIb+gAFxQ30vC/snIb/o291OLZ5ktZJX
        F9eLBMafRrc2vJnGxp2w1MStNSggb4sw2/7/z9pn0sW9xejXnltCwLavub+7iOZMHIpicAhiyTFJt
        AeGAz36xXN+o5+vqUBHPCB/1zdMsBRCluCGvpDo84n/hUIs4A0wusECYfuHyYaP5DSZYzsSmoj1a6
        HoCNUnjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3ywG-0007ir-MI; Thu, 15 Jul 2021 10:49:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C95F9877D2; Thu, 15 Jul 2021 12:49:55 +0200 (CEST)
Date:   Thu, 15 Jul 2021 12:49:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v3 1/2] irq: abstract irqaction handler invocation
Message-ID: <20210715104954.GA4717@worktop.programming.kicks-ass.net>
References: <20210715095031.41922-1-mark.rutland@arm.com>
 <20210715095031.41922-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715095031.41922-2-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 10:50:30AM +0100, Mark Rutland wrote:
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index 54363527feea..70a4694cc891 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -11,6 +11,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/sched/clock.h>
>  
> +#include <trace/events/irq.h>
> +
>  #ifdef CONFIG_SPARSE_IRQ
>  # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
>  #else
> @@ -107,6 +109,32 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
>  irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
>  irqreturn_t handle_irq_event(struct irq_desc *desc);
>  
> +static inline irqreturn_t __handle_irqaction(unsigned int irq,
> +					     struct irqaction *action,
> +					     void *dev_id)
> +{
> +	irqreturn_t res;
> +
> +	trace_irq_handler_entry(irq, action);
> +	res = action->handler(irq, dev_id);
> +	trace_irq_handler_exit(irq, action, res);
> +
> +	return res;
> +}
> +
> +static inline irqreturn_t handle_irqaction(unsigned int irq,
> +					   struct irqaction *action)
> +{
> +	return __handle_irqaction(irq, action, action->dev_id);
> +}
> +
> +static inline irqreturn_t handle_irqaction_percpu_devid(unsigned int irq,
> +							struct irqaction *action)
> +{
> +	return __handle_irqaction(irq, action,
> +				  raw_cpu_ptr(action->percpu_dev_id));
> +}

So I like this patch, it's a nice cleanup.

However, you could implement the next patch as a module that hooks into
those two tracepoints. Quite possibly the existing IRQ latency tracer
would already work for what you need and also provide you a function
trace of WTH the CPU was doing.
