Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67EB40085F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350784AbhICXnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350681AbhICXnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:43:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9D960F9C;
        Fri,  3 Sep 2021 23:42:18 +0000 (UTC)
Date:   Fri, 3 Sep 2021 19:42:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing
 output.
Message-ID: <20210903194216.1392b62e@gandalf.local.home>
In-Reply-To: <20210810132625.ylssabmsrkygokuv@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
        <20210806135124.1279fc94@oasis.local.home>
        <20210810132625.ylssabmsrkygokuv@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW,

When doing a v2, always create a new thread. Never send it as a reply to
the previous patch. The reason I missed this is because replies to previous
patches do not end up in my internal patchwork. And I only look at that for
patches. Not my INBOX.


On Tue, 10 Aug 2021 15:26:25 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -181,7 +181,8 @@ static int trace_define_common_fields(void)
>  
>  	__common_field(unsigned short, type);
>  	__common_field(unsigned char, flags);
> -	__common_field(unsigned char, preempt_count);
> +	/* XXX */
> +	__common_field(unsigned char, preempt_mg_count);
>  	__common_field(int, pid);
>  
>  	return ret;

I'm going to have to nuke this hunk of the patch, and update all the other
locations that have preempt_mg_count in it. Because I just tested it, and
this breaks user space.

 # trace-cmd record -e all sleep 1
 # trace-cmd report -l

   sleep-1903    2...ffffffff   743.721748: lock_release:         0xffffffffb1a2f428 trace_types_lock
   sleep-1903    2...ffffffff   743.721749: lock_release:         0xffff89b981318430 sb_writers
   sleep-1903    2d..ffffffff   743.721749: irq_disable:          caller=rcu_irq_enter_irqson+0x25 parent=0x0
   sleep-1903    2d..ffffffff   743.721749: irq_enable:           caller=rcu_irq_enter_irqson+0x2f parent=0x0
   sleep-1903    2...ffffffff   743.721750: preempt_disable:      caller=vfs_write+0x13a parent=vfs_write+0x13a
   sleep-1903    2d..ffffffff   743.721750: irq_disable:          caller=rcu_irq_exit_irqson+0x25 parent=0x0
   sleep-1903    2d..ffffffff   743.721750: irq_enable:           caller=rcu_irq_exit_irqson+0x2f parent=0x0
   sleep-1903    2d..ffffffff   743.721750: irq_disable:          caller=rcu_irq_enter_irqson+0x25 parent=0x0
   sleep-1903    2d..ffffffff   743.721750: irq_enable:           caller=rcu_irq_enter_irqson+0x2f parent=0x0
   sleep-1903    2...ffffffff   743.721750: preempt_enable:       caller=vfs_write+0x15c parent=vfs_write+0x15c
   sleep-1903    2d..ffffffff   743.721751: irq_disable:          caller=rcu_irq_exit_irqson+0x25 parent=0x0
   sleep-1903    2d..ffffffff   743.721751: irq_enable:           caller=rcu_irq_exit_irqson+0x2f parent=0x0
   sleep-1903    2...ffffffff   743.721751: lock_release:         0xffff89b8a144e4f0 &f->f_pos_lock
   sleep-1903    2...ffffffff   743.721751: sys_exit:             NR 1 = 1
   sleep-1903    2...ffffffff   743.721751: sys_exit_write:       0x1
   sleep-1903    2d..ffffffff   743.721752: irq_disable:          caller=syscall_exit_to_user_mode+0xe parent=0x0
   sleep-1903    2d..ffffffff   743.721752: irq_enable:           caller=syscall_exit_to_user_mode+0x1b parent=0x0

Because to parse the preempt portion, libtraceevent searches for
"common_preempt_count". When it's not found, -1 is used.

As the migrate disable is an offset, we can at least filter that.

And if and old libtraceevent is used, the preempt counts will be the
combination of both, and although it may be a little confusing, at least,
it can be figured out.

I'm going to fold the below patch into this patch if that's OK with you?

-- Steve

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5a679315fbed..0a0144580bbd 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -67,7 +67,7 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 struct trace_entry {
 	unsigned short		type;
 	unsigned char		flags;
-	unsigned char		preempt_mg_count;
+	unsigned char		preempt_count;
 	int			pid;
 };
 
@@ -156,7 +156,7 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 						unsigned short type,
 						unsigned int trace_ctx)
 {
-	entry->preempt_mg_count		= trace_ctx & 0xff;
+	entry->preempt_count		= trace_ctx & 0xff;
 	entry->pid			= current->pid;
 	entry->type			= type;
 	entry->flags =			trace_ctx >> 16;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index d3715e2f6707..830b3b9940f4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -181,8 +181,8 @@ static int trace_define_common_fields(void)
 
 	__common_field(unsigned short, type);
 	__common_field(unsigned char, flags);
-	/* XXX */
-	__common_field(unsigned char, preempt_mg_count);
+	/* Holds both preempt_count and migrate_disable */
+	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
 
 	return ret;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index def0d8de2df6..c2ca40e8595b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -492,13 +492,13 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 	trace_seq_printf(s, "%c%c%c",
 			 irqs_off, need_resched, hardsoft_irq);
 
-	if (entry->preempt_mg_count & 0xf)
-		trace_seq_printf(s, "%x", entry->preempt_mg_count & 0xf);
+	if (entry->preempt_count & 0xf)
+		trace_seq_printf(s, "%x", entry->preempt_count & 0xf);
 	else
 		trace_seq_putc(s, '.');
 
-	if (entry->preempt_mg_count & 0xf0)
-		trace_seq_printf(s, "%x", entry->preempt_mg_count >> 4);
+	if (entry->preempt_count & 0xf0)
+		trace_seq_printf(s, "%x", entry->preempt_count >> 4);
 	else
 		trace_seq_putc(s, '.');
 
@@ -661,7 +661,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_seq_printf(
 			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
-			entry->preempt_mg_count & 0xf, iter->idx);
+			entry->preempt_count & 0xf, iter->idx);
 	} else {
 		lat_print_generic(s, entry, iter->cpu);
 	}
