Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769BD32ECD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhCEONj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCEONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:13:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CF864F1D;
        Fri,  5 Mar 2021 14:13:14 +0000 (UTC)
Date:   Fri, 5 Mar 2021 09:13:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Jun <chenjun102@huawei.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Subject: [GIT PULL] tracing: Fixes for 5.12-rc1
Message-ID: <20210305091313.08f87d9d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Functional fixes:

 - Fix big endian conversion for arm64 in recordmcount processing

 - Fix timestamp corruption in ring buffer on discarding events

 - Fix memory leak in __create_synth_event()

 - Skip selftests if tracing is disabled as it will cause them to fail.

Non-functional fixes:

 - Fix help text in Kconfig

 - Remove duplicate prototype for trace_empty()

 - Fix stale comment about the trace_event_call flags.

Self test update:

 - Add more information to the validation output of when a
   corrupt timestamp is found in the ring buffer, and also
   trigger a warning to make sure that tests catch it.


Please pull the latest trace-v5.12-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-rc1

Tag SHA1: 29d3fbc3471e6abaa12e03234bf9fd79ff452e9a
Head SHA1: f9f344479d8b40b3b001c913fb992d85d19261d0


Chen Jun (1):
      ftrace: Have recordmcount use w8 to read relp->r_info in arm64_is_fake_mcount

Rolf Eike Beer (1):
      tracing: Fix help text of TRACEPOINT_BENCHMARK in Kconfig

Steven Rostedt (VMware) (4):
      ring-buffer: Force before_stamp and write_stamp to be different on discard
      ring-buffer: Add a little more information and a WARN when time stamp going backwards is detected
      tracing: Skip selftests if tracing is disabled
      tracing: Fix comment about the trace_event_call flags

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in __create_synth_event()

Yordan Karadzhov (VMware) (1):
      tracing: Remove duplicate declaration from trace.h

----
 include/linux/trace_events.h      | 11 ++---------
 kernel/trace/Kconfig              |  2 +-
 kernel/trace/ring_buffer.c        | 21 ++++++++++++++++++---
 kernel/trace/trace.c              |  6 ++++++
 kernel/trace/trace.h              |  1 -
 kernel/trace/trace_events_synth.c |  4 +++-
 scripts/recordmcount.c            |  2 +-
 7 files changed, 31 insertions(+), 16 deletions(-)
---------------------------
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7077fec653bb..28e7af1406f2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -349,15 +349,8 @@ struct trace_event_call {
 	struct event_filter	*filter;
 	void			*mod;
 	void			*data;
-	/*
-	 *   bit 0:		filter_active
-	 *   bit 1:		allow trace by non root (cap any)
-	 *   bit 2:		failed to apply filter
-	 *   bit 3:		trace internal event (do not enable)
-	 *   bit 4:		Event was enabled by module
-	 *   bit 5:		use call filter rather than file filter
-	 *   bit 6:		Event is a tracepoint
-	 */
+
+	/* See the TRACE_EVENT_FL_* flags above */
 	int			flags; /* static flags of different events */
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9c266b93cbc0..7fa82778c3e6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -694,7 +694,7 @@ config TRACEPOINT_BENCHMARK
 	help
 	 This option creates the tracepoint "benchmark:benchmark_event".
 	 When the tracepoint is enabled, it kicks off a kernel thread that
-	 goes into an infinite loop (calling cond_sched() to let other tasks
+	 goes into an infinite loop (calling cond_resched() to let other tasks
 	 run), and calls the tracepoint. Each iteration will record the time
 	 it took to write to the tracepoint and the next iteration that
 	 data will be passed to the tracepoint itself. That is, the tracepoint
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b9dad3500041..68744c51517e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2814,6 +2814,17 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 				       write_stamp, write_stamp - delta))
 			return 0;
 
+		/*
+		 * It's possible that the event time delta is zero
+		 * (has the same time stamp as the previous event)
+		 * in which case write_stamp and before_stamp could
+		 * be the same. In such a case, force before_stamp
+		 * to be different than write_stamp. It doesn't
+		 * matter what it is, as long as its different.
+		 */
+		if (!delta)
+			rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
@@ -3307,9 +3318,13 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 		atomic_inc(&cpu_buffer->record_disabled);
-		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld after:%lld\n",
-		       cpu_buffer->cpu,
-		       ts + info->delta, info->ts, info->delta, info->after);
+		/* There's some cases in boot up that this can happen */
+		WARN_ON_ONCE(system_state != SYSTEM_BOOTING);
+		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s\n",
+			cpu_buffer->cpu,
+			ts + info->delta, info->ts, info->delta,
+			info->before, info->after,
+			full ? " (full)" : "");
 		dump_buffer_page(bpage, info, tail);
 		atomic_dec(&ts_dump);
 		/* Do not re-enable checking */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e295c413580e..eccb4e1187cc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1929,6 +1929,12 @@ static int run_tracer_selftest(struct tracer *type)
 	if (!selftests_can_run)
 		return save_selftest(type);
 
+	if (!tracing_is_on()) {
+		pr_warn("Selftest for tracer %s skipped due to tracing disabled\n",
+			type->name);
+		return 0;
+	}
+
 	/*
 	 * Run a selftest on this tracer.
 	 * Here we reset the trace buffer, and set the current
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index dec13ff66077..a6446c03cfbc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -605,7 +605,6 @@ void trace_graph_function(struct trace_array *tr,
 void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
-int trace_empty(struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace);
 int trace_graph_entry(struct ftrace_graph_ent *trace);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2979a96595b4..8d71e6c83f10 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1225,8 +1225,10 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			goto err;
 		}
 
-		if (!argc)
+		if (!argc) {
+			argv_free(argv);
 			continue;
+		}
 
 		n_fields_this_loop = 0;
 		consumed = 0;
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index b9c2ee7ab43f..cce12e1971d8 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
 
 static int arm64_is_fake_mcount(Elf64_Rel const *rp)
 {
-	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
+	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
 }
 
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
