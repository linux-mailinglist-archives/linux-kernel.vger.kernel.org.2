Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5B35E7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348283AbhDMUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348277AbhDMUsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:48:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C327C61139;
        Tue, 13 Apr 2021 20:48:26 +0000 (UTC)
Date:   Tue, 13 Apr 2021 16:48:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH v3 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210413164825.79c583f4@gandalf.local.home>
In-Reply-To: <20210413151736.36ec77eb@gandalf.local.home>
References: <20210409181031.26772-1-y.karadz@gmail.com>
        <20210409181031.26772-2-y.karadz@gmail.com>
        <20210413151736.36ec77eb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 15:17:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Running this with trace-cmd record, this displays:
> 
>           <idle>-0     [001]   261.848848: function:                            next_zone
>           <idle>-0     [001]   261.848849: func_repeats:          next_zone <-need_update       (repeats:3  delta_ts: -189)
> 
> Which is confusing in a number of ways.
> 
> 1. It would be better to have it be the actual timestamp of the last repeat.
>    But that can be done in a trace-cmd plugin (like the function trace has).
> 
> 2. It should be "delta_ns:" because it is not -189 from the timestamp, as
>    the above time stamp is truncated to microseconds and this is not
>    obvious to the user.

With the below patch to libtraceevent, I now see this:

          <idle>-0     [001]   261.848847: function:                      quiet_vmstat
          <idle>-0     [001]   261.848847: function:                         need_update
          <idle>-0     [001]   261.848848: function:                            first_online_pgdat
          <idle>-0     [001]   261.848848: function:                            next_zone
          <idle>-0     [001]   261.848849: func_repeats:                        next_zone (count: 3  last_ts:   261.848849)
          <idle>-0     [001]   261.848849: function:                   hrtimer_start_range_ns
          <idle>-0     [001]   261.848849: function:                      _raw_spin_lock_irqsave
          <idle>-0     [001]   261.848849: function:                         preempt_count_add

And because I made the format used weak, it can be overwritten by the
application, in which I had trace-cmd update it with the format it uses to
produce the timestamp:

	if (tracecmd_get_flags(handle) & TRACECMD_FL_RAW_TS) {
		tep_func_repeat_format = "%d";
	} else if (tracecmd_get_flags(handle) & TRACECMD_FL_IN_USECS) {
		if (tep_test_flag(tracecmd_get_tep(handle), TEP_NSEC_OUTPUT))
			tep_func_repeat_format = "%9.1d";
		else
			tep_func_repeat_format = "%6.1000d";
	} else {
		tep_func_repeat_format = "%12d";
	}

Which produces this when I add "-t" (to see the full timestamp)

          <idle>-0     [001]   261.848847195: function:                      quiet_vmstat
          <idle>-0     [001]   261.848847431: function:                         need_update
          <idle>-0     [001]   261.848847654: function:                            first_online_pgdat
          <idle>-0     [001]   261.848848109: function:                            next_zone
          <idle>-0     [001]   261.848848740: func_repeats:                        next_zone (count: 3  last_ts:   261.848848551)
          <idle>-0     [001]   261.848849014: function:                   hrtimer_start_range_ns
          <idle>-0     [001]   261.848849254: function:                      _raw_spin_lock_irqsave
          <idle>-0     [001]   261.848849481: function:                         preempt_count_add

I was able to reuse the function code thanks to you for having the same
fields as the function event ;-)

And because it only requires updating a weak variable, new code can set
that variable without requiring the library to support it, and we do not
need to change the patch version of the library!

-- Steve

diff --git a/plugins/plugin_function.c b/plugins/plugin_function.c
index 93bdcc2..7777569 100644
--- a/plugins/plugin_function.c
+++ b/plugins/plugin_function.c
@@ -10,6 +10,11 @@
 #include "event-utils.h"
 #include "trace-seq.h"
 
+#define __weak __attribute__((weak))
+
+/* Export this for applications to override it */
+__weak const char *tep_func_repeat_format = "%6.1000d";
+
 static struct func_stack {
 	int size;
 	char **stack;
@@ -169,6 +174,36 @@ static int function_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+static int trace_func_repeat_handler(struct trace_seq *s, struct tep_record *record,
+				    struct tep_event *event, void *context)
+{
+	struct tep_handle *tep = event->tep;
+	unsigned long long count, top_delta, bottom_delta;
+	struct tep_record dummy;
+
+	function_handler(s, record, event, context);
+
+	if (tep_get_field_val(s, event, "count", record, &count, 1))
+		return trace_seq_putc(s, '!');
+
+	if (tep_get_field_val(s, event, "top_delta_ts", record, &top_delta, 1))
+		return trace_seq_putc(s, '!');
+
+	if (tep_get_field_val(s, event, "bottom_delta_ts", record, &bottom_delta, 1))
+		return trace_seq_putc(s, '!');
+
+	trace_seq_printf(s, " (count: %lld  last_ts: ", count);
+
+	memcpy(&dummy, record, sizeof(dummy));
+	dummy.ts -= (top_delta << 32) | bottom_delta;
+
+	tep_print_event(tep, s, &dummy, tep_func_repeat_format, TEP_PRINT_TIME);
+
+	trace_seq_puts(s, ")");
+
+	return 0;
+}
+
 static int
 trace_stack_handler(struct trace_seq *s, struct tep_record *record,
 		    struct tep_event *event, void *context)
@@ -256,6 +291,9 @@ int TEP_PLUGIN_LOADER(struct tep_handle *tep)
 	tep_register_event_handler(tep, -1, "ftrace", "raw_data",
 				      trace_raw_data_handler, NULL);
 
+	tep_register_event_handler(tep, -1, "ftrace", "func_repeats",
+				      trace_func_repeat_handler, NULL);
+
 	tep_plugin_add_options("ftrace", plugin_options);
 
 	return 0;
