Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C827B3C9F25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhGONOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:14:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD3C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XbSuj1brVP+cq3N2PvYqae31YYRIC5jdkBEN/lpsVMo=; b=Gf5bZ8SknhO6PZXd2NFu883BAw
        bUPLWo+Otlv63zBywaDyFSOrc4dJ5yZzzDiWLNAgrCtn5lpGlPOedxVihap00SXPj0rNFE/H/V5Lc
        vvGpoMmlvAU4ykspxlRla9xFne4QfaYd3FzbDlJvd7vGwzupbC3oz4YtIf4nN1IsczRcEKNF3hzZB
        cxQ/yb14EaijtXyuSjS5CYPMOKCA7ORF4sZvrIOhV777uW8MVFfjHJW2EByOC2NebwwLI1DPmLw/U
        bUvWezyr2l1H6tLx/KE9/ktLt/771qcSi75J8nmP11OHwtQNOD9WgKXg9PK7oeqfyAaBmE8WZte0W
        8zAFoiFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m418X-003MoK-So; Thu, 15 Jul 2021 13:10:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28A2F9877D2; Thu, 15 Jul 2021 15:10:44 +0200 (CEST)
Date:   Thu, 15 Jul 2021 15:10:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v3 1/2] irq: abstract irqaction handler invocation
Message-ID: <20210715131044.GB4717@worktop.programming.kicks-ass.net>
References: <20210715095031.41922-1-mark.rutland@arm.com>
 <20210715095031.41922-2-mark.rutland@arm.com>
 <20210715104954.GA4717@worktop.programming.kicks-ass.net>
 <20210715111531.GA56828@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715111531.GA56828@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:15:31PM +0100, Mark Rutland wrote:
> On Thu, Jul 15, 2021 at 12:49:54PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 15, 2021 at 10:50:30AM +0100, Mark Rutland wrote:
> > > diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> > > index 54363527feea..70a4694cc891 100644
> > > --- a/kernel/irq/internals.h
> > > +++ b/kernel/irq/internals.h
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/sched/clock.h>
> > >  
> > > +#include <trace/events/irq.h>
> > > +
> > >  #ifdef CONFIG_SPARSE_IRQ
> > >  # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> > >  #else
> > > @@ -107,6 +109,32 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
> > >  irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
> > >  irqreturn_t handle_irq_event(struct irq_desc *desc);
> > >  
> > > +static inline irqreturn_t __handle_irqaction(unsigned int irq,
> > > +					     struct irqaction *action,
> > > +					     void *dev_id)
> > > +{
> > > +	irqreturn_t res;
> > > +
> > > +	trace_irq_handler_entry(irq, action);
> > > +	res = action->handler(irq, dev_id);
> > > +	trace_irq_handler_exit(irq, action, res);
> > > +
> > > +	return res;
> > > +}
> > > +
> > > +static inline irqreturn_t handle_irqaction(unsigned int irq,
> > > +					   struct irqaction *action)
> > > +{
> > > +	return __handle_irqaction(irq, action, action->dev_id);
> > > +}
> > > +
> > > +static inline irqreturn_t handle_irqaction_percpu_devid(unsigned int irq,
> > > +							struct irqaction *action)
> > > +{
> > > +	return __handle_irqaction(irq, action,
> > > +				  raw_cpu_ptr(action->percpu_dev_id));
> > > +}
> > 
> > So I like this patch, it's a nice cleanup.
> > 
> > However, you could implement the next patch as a module that hooks into
> > those two tracepoints. Quite possibly the existing IRQ latency tracer
> > would already work for what you need and also provide you a function
> > trace of WTH the CPU was doing.
> 
> The issue with the existing tracers is that they're logging for
> later/concurrent analysis, whereas what I need is a notification (e.g. a
> WARN) when the maximum expected latency has been breached. That way it
> gets caught by Syzkaller or whatever without needing to specially manage
> the tracer.
> 
> If there's a way to do that (e.g. with boot-time options), I'm happy to
> use that instead; I just couldn't see hwo to do that today, and was
> under the impression that the existing tracepoints don't give quite what
> I need (e.g. since the entry/exit hooks are separate, so I'd have to
> store some state somewhere else).
> 
> I'm happy to take another look if you think I'm wrong on that. :)

For this particular thing I think you can use a simple per-cpu variable;
we don't do nested interrupts.

DEFINE_PER_CPU(u64, my_timestamp);

static notrace void my_entry(unsigned int irq, struct irq_action *action)
{
	this_cpu_write(my_timestamp, sched_clock());
}

static notrace void my_exit(unsigned int irq, struct irq_action *action)
{
	u64 delta = sched_clock() - this_cpu_read(my_timestamp);
	WARN_ON_ONCE(delta > biggie);
}

__init int mod_init(void)
{
	register_trace_irq_handler_exit(my_exit, NULL);
	register_trace_irq_handler_entry(my_entry, NULL);
}

Should work, no?
