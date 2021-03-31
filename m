Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9086F35027F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhCaOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235842AbhCaOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:37:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E945D60FF3;
        Wed, 31 Mar 2021 14:37:50 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:37:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: User stacktrace garbage when USER_STACKTRACE_SUPPORT is not
 enabled
Message-ID: <20210331103749.01a7c283@gandalf.local.home>
In-Reply-To: <your-ad-here.call-01617191565-ext-9692@work.hours>
References: <your-ad-here.call-01617191565-ext-9692@work.hours>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 13:52:45 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Hi Steven,
> 
> At least on s390 since commit cbc3b92ce037 ("tracing: Set kernel_stack's
> caller size properly") kernel stack trace contains 8 garbage values in the end.
> I assume those are supposed to be filled by ftrace_trace_userstack, which is
> only implemented on x86.

You assume wrong ;-)

No, the kernel_stack trace does not do anything for user stack unless the
architecture does something with it, and x86 does not do anything with it
when running kernel stack.


> 
>             sshd-804   [050]  1997.252608: kernel_stack:         <stack trace>
> => trampoline_probe_handler (549628c94)
> => kprobe_handler (549629260)
> => kprobe_exceptions_notify (549629370)
> => notify_die (549686e5e)
> => illegal_op (54960d440)
> => __do_pgm_check (54a106b08)
> => pgm_check_handler (54a112cc8)
> => kretprobe_trampoline (549629438)
> => kretprobe_trampoline (549629436)
> => do_syscall (549611ee6)
> => __do_syscall (54a106ccc)
> => system_call (54a112b5a)
> => 769010000000322
> => 22125e4d8
> => 22125e8f8
> => e000054100040100
> => _end (3220000000c)
> => 2
> => 20f892ec00000002
> => 20f898b800000002  
> 
> kernel/trace/trace_entries.h:
> 159 #define FTRACE_STACK_ENTRIES    8
> 160
> 161 FTRACE_ENTRY(kernel_stack, stack_entry,
> 162
> 163         TRACE_STACK,
> 164
> 165         F_STRUCT(
> 166                 __field(        int,            size    )
> 167                 __array(        unsigned long,  caller, FTRACE_STACK_ENTRIES    )
> 168         ),
> 
> Is there any reason to keep those 8 extra values in the caller array if
> CONFIG_USER_STACKTRACE_SUPPORT is not enabled? Any advice how to fix that
> gracefully? It seems to work if I simply set FTRACE_STACK_ENTRIES to 0 when
> CONFIG_USER_STACKTRACE_SUPPORT is not enabled.

Note, the above is just a holder for user space parsing. It plays no role
in how the kernel reports the data from the /sys/kernel/tracing/trace file.

Here's the code that does the actual work (from kernel/tracing/trace.c)

	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
	size = ARRAY_SIZE(fstack->calls);

	if (regs) {
		nr_entries = stack_trace_save_regs(regs, fstack->calls,
						   size, skip);
	} else {
		nr_entries = stack_trace_save(fstack->calls, size, skip);
	}

	size = nr_entries * sizeof(unsigned long);
	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
					    sizeof(*entry) + size, trace_ctx);
	if (!event)
		goto out;
	entry = ring_buffer_event_data(event);

	memcpy(&entry->caller, fstack->calls, size);
	entry->size = nr_entries;

ftrace_stacks.stacks is a per cpu variable of size PAGE_SIZE and divided by
4, so it can be used in normal, softirq, interrupt and NMI context.
Depending on if regs is passed in (and I'll assume it is not here), then
stack_trace_save() is called. Which looks like this:

unsigned int stack_trace_save(unsigned long *store, unsigned int size,
			      unsigned int skipnr)
{
	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
	struct stacktrace_cookie c = {
		.store	= store,
		.size	= size,
		.skip	= skipnr + 1,
	};

	arch_stack_walk(consume_entry, &c, current, NULL);
	return c.len;
}

arch_stack_walk() is arch specific, and it does whatever s390 does for
stack walks, and the number of entries is returned by c.len, and that value
determines what is seen.

But after writing all of the above, I think I found a bug! It's this:

	size = nr_entries * sizeof(unsigned long);
	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
					    sizeof(*entry) + size, trace_ctx);


I said the above commit did not play a role in output, but it does play a
role in creating the struct stack_trace entry. And by making it a fixed
array (even though it's not used) it added 8 more entries to the stack!

This should fix the problem:

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3c605957bb5c..507a30bf26e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2985,7 +2985,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 
 	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-					    sizeof(*entry) + size, trace_ctx);
+				    (sizeof(*entry) - sizeof(entry->caller)) + size,
+				    trace_ctx);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
