Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076F03C9D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhGOLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:18:33 -0400
Received: from foss.arm.com ([217.140.110.172]:51256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240870AbhGOLSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE5C931B;
        Thu, 15 Jul 2021 04:15:39 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905613F694;
        Thu, 15 Jul 2021 04:15:38 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:15:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v3 1/2] irq: abstract irqaction handler invocation
Message-ID: <20210715111531.GA56828@C02TD0UTHF1T.local>
References: <20210715095031.41922-1-mark.rutland@arm.com>
 <20210715095031.41922-2-mark.rutland@arm.com>
 <20210715104954.GA4717@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715104954.GA4717@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:49:54PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 15, 2021 at 10:50:30AM +0100, Mark Rutland wrote:
> > diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> > index 54363527feea..70a4694cc891 100644
> > --- a/kernel/irq/internals.h
> > +++ b/kernel/irq/internals.h
> > @@ -11,6 +11,8 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/sched/clock.h>
> >  
> > +#include <trace/events/irq.h>
> > +
> >  #ifdef CONFIG_SPARSE_IRQ
> >  # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> >  #else
> > @@ -107,6 +109,32 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
> >  irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
> >  irqreturn_t handle_irq_event(struct irq_desc *desc);
> >  
> > +static inline irqreturn_t __handle_irqaction(unsigned int irq,
> > +					     struct irqaction *action,
> > +					     void *dev_id)
> > +{
> > +	irqreturn_t res;
> > +
> > +	trace_irq_handler_entry(irq, action);
> > +	res = action->handler(irq, dev_id);
> > +	trace_irq_handler_exit(irq, action, res);
> > +
> > +	return res;
> > +}
> > +
> > +static inline irqreturn_t handle_irqaction(unsigned int irq,
> > +					   struct irqaction *action)
> > +{
> > +	return __handle_irqaction(irq, action, action->dev_id);
> > +}
> > +
> > +static inline irqreturn_t handle_irqaction_percpu_devid(unsigned int irq,
> > +							struct irqaction *action)
> > +{
> > +	return __handle_irqaction(irq, action,
> > +				  raw_cpu_ptr(action->percpu_dev_id));
> > +}
> 
> So I like this patch, it's a nice cleanup.
> 
> However, you could implement the next patch as a module that hooks into
> those two tracepoints. Quite possibly the existing IRQ latency tracer
> would already work for what you need and also provide you a function
> trace of WTH the CPU was doing.

The issue with the existing tracers is that they're logging for
later/concurrent analysis, whereas what I need is a notification (e.g. a
WARN) when the maximum expected latency has been breached. That way it
gets caught by Syzkaller or whatever without needing to specially manage
the tracer.

If there's a way to do that (e.g. with boot-time options), I'm happy to
use that instead; I just couldn't see hwo to do that today, and was
under the impression that the existing tracepoints don't give quite what
I need (e.g. since the entry/exit hooks are separate, so I'd have to
store some state somewhere else).

I'm happy to take another look if you think I'm wrong on that. :)

Thanks,
Mark.
