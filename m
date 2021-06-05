Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30F039C50D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFECaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhFECaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:30:20 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C824E61078;
        Sat,  5 Jun 2021 02:28:32 +0000 (UTC)
Date:   Fri, 4 Jun 2021 22:28:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] tracing: Add a verifier to check string pointers
 for trace events
Message-ID: <20210604222830.2505d67a@rorschach.local.home>
In-Reply-To: <YLrRUmwjjaozIt4K@google.com>
References: <20210226185909.100032746@goodmis.org>
        <20210226190705.871102407@goodmis.org>
        <YLrRUmwjjaozIt4K@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 01:20:18 +0000
Sean Christopherson <seanjc@google.com> wrote:

> +Paolo
> 
> On Fri, Feb 26, 2021, Steven Rostedt wrote:
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index f5e8e39d6f57..ff08c04de6cb 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -3551,6 +3551,154 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
> >  	return tmp;
> >  }
> >  
> > +/* Returns true if the string is safe to dereference from an event */
> > +static bool trace_safe_str(struct trace_iterator *iter, const char *str)
> > +{
> > +	unsigned long addr = (unsigned long)str;
> > +	struct trace_event *trace_event;
> > +	struct trace_event_call *event;
> > +
> > +	/* OK if part of the event data */
> > +	if ((addr >= (unsigned long)iter->ent) &&
> > +	    (addr < (unsigned long)iter->ent + iter->ent_size))
> > +		return true;
> > +
> > +	/* OK if part of the temp seq buffer */
> > +	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
> > +	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
> > +		return true;
> > +
> > +	/* Core rodata can not be freed */
> > +	if (is_kernel_rodata(addr))
> > +		return true;
> > +
> > +	/*
> > +	 * Now this could be a module event, referencing core module
> > +	 * data, which is OK.
> > +	 */  
> 
> Question on this: is it safe for a module to provide a string from its core data
> when invoking a tracepoint that is defined and exported by a different module or
> by the kernel proper?	

If it is in kernel proper, then it will be fine because all core read
only memory is fine to print. If it is not read only, then it can
change from the time it was recorded to the time it was printed which
is also considered unsafe.

Now I haven't thought about a module writing a string that is static
and read only from another module that the first module is dependent
on. That's new.

Now, are you talking about a built-in tracepoint referencing a module
string? If so, what happens if the trace happens, the module is
unloaded, and then the trace is read. That string is now unsafe. And
yes, that event will still exist in the buffer after the module is
unloaded. (Note, if a module events were enabled, unloading it will
clear the buffer, but if you only enabled the event that references the
module string and not events within the module, unloading the module
will *not* clear the buffer)

Same if there's not a dependency between modules. If one module
references a string from another module. If it is possible for the
other module to be unloaded between the time the event is recorded, but
the tracepoint module is not released, reading the string will be
stale, and that too is unsafe.

> 
> If that behavior is safe, then this will generate false positives on those use

I need to see the exact use case here, because it may very well not be
safe, thus not a false positive, and indeed a bug in the trace event.

> cases.  And AFAICT, it's not possible to fully fix the issue, at least not
> without plumbing in more crud.  E.g. if the tracepoint is built into the kernel,
> event->mod will be NULL and so even a hack-a-fix like walking source_list isn't
> an option (I used source_list to verify the address is indeed in the invoking
> module).
> 
> E.g. in KVM, all tracepoints are defined and exported by the common 'kvm' module
> (which can also be built-in), and used by 'kvm' and the vendor modules,
> 'kvm_intel' and 'kvm_amd'.  One tracepoint in particular takes a hardcoded string
> and does a direct fast assign to and from a 'const char *'.  This triggers the
> WARN and displays [UNSAFE-MEMORY] because the string is in 'kvm_intel', not the
> tracepoint owner.

What happens if you enable the trace, remove kvm_intel, then read the
trace? Sounds to me that string will no longer exist and you are then
referencing some undefined data. Which is *exactly* what this is trying
to prevent.

> 
> The bug is easy to workaround in KVM by converting to the __string() machinery,
> but I suspect there will be grumpy users on the horizon when a false positive
> breaks a tracepoint in a different module at the worst possible time.

What you described to me does not sound like a false positive, and
converting to __string() is not a workaround but an actual fix, and
would also need to be backported to stable.

-- Steve

> 
> > +	if (!iter->ent)
> > +		return false;
> > +
> > +	trace_event = ftrace_find_event(iter->ent->type);
> > +	if (!trace_event)
> > +		return false;
> > +
> > +	event = container_of(trace_event, struct trace_event_call, event);
> > +	if (!event->mod)
> > +		return false;
> > +
> > +	/* Would rather have rodata, but this will suffice */
> > +	if (within_module_core(addr, event->mod))
> > +		return true;
> > +
> > +	return false;
> > +}  

