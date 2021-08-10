Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945B73E5B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbhHJN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbhHJN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:26:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B8C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:26:30 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:26:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628601986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsEppXze0iYGBBAwq9fuQ2xQ8HIgTkcqcAnSquA4048=;
        b=I5YxYVz2YJ7n8BIjGEiAkuFqOV0wPTA+NOU3xACL1POCqPaQHssw70Ax8cckKHg5uGpq8H
        I/hqYcpICc3j1zlTK+NtR1jZiXGVWAjsp/xV7roYVUiwV2f594TrWnajVT2v61Bu1kcce6
        NUKKcdnTi5HxPQXvNTqJo3hDn1QXLfK9M77PQ2zL6j3EUD7H9JrTYwhBs+9JDjr0P3jl7j
        HdKEKic8eDtCaTbMtyUPXA+tn5EGjPPWZRifGgo60oLKNuD/+4S4e2HpUeoO7LhLSZ9yc4
        bH+pMMTcjpmxMvsvZzASQflSjTROK18xZ1bFzAgBW0iWSBI0yV5FsK9+z/kwIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628601986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsEppXze0iYGBBAwq9fuQ2xQ8HIgTkcqcAnSquA4048=;
        b=gSYIH53wrbRvqYRWbEhWLc2hRH/IiAQlCmgmDhusiv7zdaOPoFbWYVcxpXzaFhEJM4qcDi
        0V2mg3HUWhPfaICQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210810132625.ylssabmsrkygokuv@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
 <20210806135124.1279fc94@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210806135124.1279fc94@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom: Thomas Gleixner <tglx@linutronix.de>

migrate_disable() forbids task migration to another CPU. It is available
since v5.11 and has already users such as highmem or BPF. It is useful
to observe this task state in tracing which already has other states
like the preemption counter.

Instead of adding the migrate disable counter as a new entry to struct
trace_entry, which would extend the whole struct by four bytes, it is
squashed into the preempt-disable counter. The lower four bits represent
the preemption counter, the upper four bits represent the migrate
disable counter. Both counter shouldn't exceed 15 but if they do, there
is a safety net which caps the value at 15.

Add the migrate-disable counter to the trace entry so it shows up in the
trace. Due to the users mentioned above, it is already possible to
observe it:

|  bash-1108    [000] ...21    73.950578: rss_stat: mm_id=3D2213312838 curr=
=3D0 type=3DMM_ANONPAGES size=3D8192B
|  bash-1108    [000] d..31    73.951222: irq_disable: caller=3Dflush_tlb_m=
m_range+0x115/0x130 parent=3Dptep_clear_flush+0x42/0x50
|  bash-1108    [000] d..31    73.951222: tlb_flush: pages:1 reason:local m=
m shootdown (3)

The last value is the migrate-disable counter.

Things that popped up:
- trace_print_lat_context() does not print the migrate counter. Not sure
  if it should. It is used in "verbose" mode and uses 8 digits and I'm
  not sure ther is something processing the value.

- trace_define_common_fields() now defines a different variable. This
  probably breaks things. No ide what to do in order to preserve the old
  behaviour. Since this is used as a filter it should be split somehow
  to be able to match both nibbles here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: patch description.]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - use the upper nibble of the preemption counter for the migrate
    disable counter and the lower for the preemption counter. This
    avoids extending the struct by four bytes due to alignment /
    padding.

 include/linux/trace_events.h |  4 ++--
 kernel/trace/trace.c         | 26 +++++++++++++++++++-------
 kernel/trace/trace_events.c  |  3 ++-
 kernel/trace/trace_output.c  | 11 ++++++++---
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3ca..92680a59740e4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -67,7 +67,7 @@ void trace_event_printf(struct trace_iterator *iter, cons=
t char *fmt, ...);
 struct trace_entry {
 	unsigned short		type;
 	unsigned char		flags;
-	unsigned char		preempt_count;
+	unsigned char		preempt_mg_count;
 	int			pid;
 };
=20
@@ -156,7 +156,7 @@ static inline void tracing_generic_entry_update(struct =
trace_entry *entry,
 						unsigned short type,
 						unsigned int trace_ctx)
 {
-	entry->preempt_count		=3D trace_ctx & 0xff;
+	entry->preempt_mg_count		=3D trace_ctx & 0xff;
 	entry->pid			=3D current->pid;
 	entry->type			=3D type;
 	entry->flags =3D			trace_ctx >> 16;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c59dd35a6da5c..ea9082fdcc69a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2603,6 +2603,15 @@ enum print_line_t trace_handle_return(struct trace_s=
eq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
=20
+static unsigned short migration_disable_value(void)
+{
+#if defined(CONFIG_SMP)
+	return current->migration_disabled;
+#else
+	return 0;
+#endif
+}
+
 unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
 	unsigned int trace_flags =3D irqs_status;
@@ -2621,7 +2630,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status)
 		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
-	return (trace_flags << 16) | (pc & 0xff);
+	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
+		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
=20
 struct ring_buffer_event *
@@ -4177,9 +4187,10 @@ static void print_lat_help_header(struct seq_file *m)
 		    "#                  | / _----=3D> need-resched    \n"
 		    "#                  || / _---=3D> hardirq/softirq \n"
 		    "#                  ||| / _--=3D> preempt-depth   \n"
-		    "#                  |||| /     delay            \n"
-		    "#  cmd     pid     ||||| time  |   caller      \n"
-		    "#     \\   /        |||||  \\    |   /         \n");
+		    "#                  |||| / _-=3D> migrate-disable \n"
+		    "#                  ||||| /     delay           \n"
+		    "#  cmd     pid     |||||| time  |   caller     \n"
+		    "#     \\   /        ||||||  \\    |    /       \n");
 }
=20
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -4217,9 +4228,10 @@ static void print_func_help_header_irq(struct array_=
buffer *buf, struct seq_file
 	seq_printf(m, "#                            %.*s / _----=3D> need-resched=
\n", prec, space);
 	seq_printf(m, "#                            %.*s| / _---=3D> hardirq/soft=
irq\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=3D> preempt-dept=
h\n", prec, space);
-	seq_printf(m, "#                            %.*s||| /     delay\n", prec,=
 space);
-	seq_printf(m, "#           TASK-PID  %.*s CPU#  ||||   TIMESTAMP  FUNCTIO=
N\n", prec, "     TGID   ");
-	seq_printf(m, "#              | |    %.*s   |   ||||      |         |\n",=
 prec, "       |    ");
+	seq_printf(m, "#                            %.*s||| / _-=3D> migrate-disa=
ble\n", prec, space);
+	seq_printf(m, "#                            %.*s|||| /     delay\n", prec=
, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  |||||  TIMESTAMP  FUNCTIO=
N\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   |||||     |         |\n",=
 prec, "       |    ");
 }
=20
 void
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 80e96989770ed..5817d14e8095f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -181,7 +181,8 @@ static int trace_define_common_fields(void)
=20
 	__common_field(unsigned short, type);
 	__common_field(unsigned char, flags);
-	__common_field(unsigned char, preempt_count);
+	/* XXX */
+	__common_field(unsigned char, preempt_mg_count);
 	__common_field(int, pid);
=20
 	return ret;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0bf446bb0348..def0d8de2df6f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -492,8 +492,13 @@ int trace_print_lat_fmt(struct trace_seq *s, struct tr=
ace_entry *entry)
 	trace_seq_printf(s, "%c%c%c",
 			 irqs_off, need_resched, hardsoft_irq);
=20
-	if (entry->preempt_count)
-		trace_seq_printf(s, "%x", entry->preempt_count);
+	if (entry->preempt_mg_count & 0xf)
+		trace_seq_printf(s, "%x", entry->preempt_mg_count & 0xf);
+	else
+		trace_seq_putc(s, '.');
+
+	if (entry->preempt_mg_count & 0xf0)
+		trace_seq_printf(s, "%x", entry->preempt_mg_count >> 4);
 	else
 		trace_seq_putc(s, '.');
=20
@@ -656,7 +661,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_seq_printf(
 			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
-			entry->preempt_count, iter->idx);
+			entry->preempt_mg_count & 0xf, iter->idx);
 	} else {
 		lat_print_generic(s, entry, iter->cpu);
 	}
--=20
2.32.0

