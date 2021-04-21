Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D603366DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbhDUOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241496AbhDUOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:20:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C54D6144E;
        Wed, 21 Apr 2021 14:20:10 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:20:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Message-ID: <20210421102008.411af7c5@gandalf.local.home>
In-Reply-To: <5d191e26-bd00-c338-e366-b4855ac08053@rasmusvillemoes.dk>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
        <877hc64klm.fsf@rustcorp.com.au>
        <20130813111442.632f3421@gandalf.local.home>
        <87siybk8yl.fsf@rustcorp.com.au>
        <20130814233228.778f25d0@gandalf.local.home>
        <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
        <20210419181111.5eb582e8@gandalf.local.home>
        <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
        <20210420085532.4062b15e@gandalf.local.home>
        <CAPcyv4gHHPdCYPzLeNzX0KMoNrOf8H0N5PBiWam0wF+WhV-Jpg@mail.gmail.com>
        <20210420163243.45293c9a@gandalf.local.home>
        <5d191e26-bd00-c338-e366-b4855ac08053@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 09:30:01 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 20/04/2021 22.32, Steven Rostedt wrote:
> > On Tue, 20 Apr 2021 12:54:39 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> >> On Tue, Apr 20, 2021 at 5:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:  
> >>>>
> >>>> The dev_dbg() filter language is attractive, it's too bad    
> >>>
> >>> Not sure what you mean by that. What filter language. Tracepoints do have a
> >>> pretty good filtering too.    
> >>  
> 
> > But you can add your own trace point, and even make it generic. That's what
> > bpf did for their bpf_trace_printk. You could convert dev_dbg() into a
> > tracepoint!
> > 
> > 
> > static __printf(2, 3) int __dev_dbg(const struct device *dev, char *fmt, ...)
> > {
> > 	static char buf[DEV_DEBUG_PRINTK_SIZE];
> > 	unsigned long flags;
> > 	va_list ap;
> > 	int ret;
> > 
> > 	raw_spin_lock_irqsave(&dev_dbg_printk_lock, flags);
> > 	va_start(ap, fmt);
> > 	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> > 	va_end(ap);
> > 	/* vsnprintf() will not append null for zero-length strings */
> > 	if (ret == 0)
> > 		buf[0] = '\0';  
> 
> Wrong. snprintf(buf, 16, "") will work just fine and cause a '\0' to be
> written to buf[0]. As will snprintf(buf, 16, "%s", ""), and any other
> case where there ends up being no characters printed.

I just cut and pasted the bpf_trace_printk() code and modified it for here.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/bpf_trace.c#n404


> 
> The only case where snprintf does not guarantee nul-termination is when
> the _buffer size_ is 0, in which case vsnprintf obviously cannot and
> must not write anything at all (that's used for the "how much do I need
> to allocate" situation).
> 
> > 
> > #define dev_dbg(dev, fmt, ...) 					\
> > 	do {							\
> > 		if (trace_dev_dbg_printk_enabled())		\
> > 			__dev_dbg(dev, fmt, ##__VA_ARGS__);	\
> > 	} while (0)
> > 
> > Note, the "trace_dev_dbg_printk_enabled()" is a static branch, which means
> > it is a nop when the dev_dbg_printk tracepoint is not enabled, and is a jmp
> > to the __dev_dbg() logic when it is enabled. It's not a conditional branch.  
> 
> dynamic_debug has been implemented in terms of static_keys for a long
> time. And that's a per-dev_dbg invocation static key. IIUC, the above
> would cause every single dev_dbg in the kernel to pass through the "grab
> a raw spin lock and do the snprintf" thing even when one is just
> interested in the dev_dbgs inside a single driver or function.

If you want to make it per device, I'm sure three's a way. Or allocate a
per-cpu buffer for the sprintf storage, and then you only need to disable
interrupts. And if you make the storage 4 levels deep per CPU (like
trace_printk does), then you only need to disable preemption and not even
interrupts.

The above wasn't a patch submission. It was a proof of concept. Everything
you brought up can be trivially dealt with.

-- Steve
