Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C042FFDA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhJPDQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239436AbhJPDQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:16:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7712761027;
        Sat, 16 Oct 2021 03:14:48 +0000 (UTC)
Date:   Fri, 15 Oct 2021 23:14:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: [GIT PULL] tracing: Updates for 5.15
Message-ID: <20211015231446.56fd4d4b@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[ Note, the memblock leak in bootconfig was the leak that we all agreed
  on should be fixed in the memblock/bootconfig discussion, but I forgot
  to push it to you. ]

Tracing fixes for 5.15:

 - Fix defined but not use warning/error for osnoise function

 - Fix memory leak in event probe

 - Fix memblock leak in bootconfig

 - Fix the API of event probes to be like kprobes

 - Added test to check removal of event probe API

 - Fix recordmcount.pl for nds32 failed build


Please pull the latest trace-v5.15-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc3

Tag SHA1: daeed983b1dc670be0b075ad61858dc6b4d7bb32
Head SHA1: be358af1191b1b2fedebd8f3421cafdc8edacc7d


Colin Ian King (1):
      tracing: Fix missing * in comment block

Jackie Liu (1):
      tracing: Fix missing osnoise tracer on max_latency

Masami Hiramatsu (1):
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()

Steven Rostedt (1):
      nds32/ftrace: Fix Error: invalid operands (*UND* and *UND* sections) for `^'

Steven Rostedt (VMware) (2):
      tracing: Fix event probe removal from dynamic events
      selftests/ftrace: Update test for more eprobe removal process

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in eprobe_register()

----
 init/main.c                                        |  1 +
 kernel/trace/trace.c                               | 11 ++--
 kernel/trace/trace_eprobe.c                        | 61 ++++++++++++++++++++--
 kernel/trace/trace_events_hist.c                   |  2 +-
 scripts/recordmcount.pl                            |  2 +-
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    | 54 ++++++++++++++++++-
 6 files changed, 117 insertions(+), 14 deletions(-)
---------------------------
diff --git a/init/main.c b/init/main.c
index 81a79a77db46..3c4054a95545 100644
--- a/init/main.c
+++ b/init/main.c
@@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
 	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
+		memblock_free_ptr(new_cmdline, len + 1);
 		return NULL;
 	}
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..bc677cd64224 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1744,16 +1744,15 @@ void latency_fsnotify(struct trace_array *tr)
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
 
-/*
- * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
- *  defined(CONFIG_FSNOTIFY)
- */
-#else
+#elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
+	|| defined(CONFIG_OSNOISE_TRACER)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
 			  &tr->max_latency, &tracing_max_lat_fops)
 
+#else
+#define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
 #endif
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -9473,9 +9472,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 3044b762cbd7..c4a15aef36af 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -119,10 +119,58 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_eprobe *ep = to_trace_eprobe(ev);
+	const char *slash;
 
-	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
-	    trace_probe_match_command_args(&ep->tp, argc, argv);
+	/*
+	 * We match the following:
+	 *  event only			- match all eprobes with event name
+	 *  system and event only	- match all system/event probes
+	 *
+	 * The below has the above satisfied with more arguments:
+	 *
+	 *  attached system/event	- If the arg has the system and event
+	 *				  the probe is attached to, match
+	 *				  probes with the attachment.
+	 *
+	 *  If any more args are given, then it requires a full match.
+	 */
+
+	/*
+	 * If system exists, but this probe is not part of that system
+	 * do not match.
+	 */
+	if (system && strcmp(trace_probe_group_name(&ep->tp), system) != 0)
+		return false;
+
+	/* Must match the event name */
+	if (strcmp(trace_probe_name(&ep->tp), event) != 0)
+		return false;
+
+	/* No arguments match all */
+	if (argc < 1)
+		return true;
+
+	/* First argument is the system/event the probe is attached to */
+
+	slash = strchr(argv[0], '/');
+	if (!slash)
+		slash = strchr(argv[0], '.');
+	if (!slash)
+		return false;
+
+	if (strncmp(ep->event_system, argv[0], slash - argv[0]))
+		return false;
+	if (strcmp(ep->event_name, slash + 1))
+		return false;
+
+	argc--;
+	argv++;
+
+	/* If there are no other args, then match */
+	if (argc < 1)
+		return true;
+
+	return trace_probe_match_command_args(&ep->tp, argc, argv);
 }
 
 static struct dyn_event_operations eprobe_dyn_event_ops = {
@@ -632,6 +680,13 @@ static int disable_eprobe(struct trace_eprobe *ep,
 
 	trace_event_trigger_enable_disable(file, 0);
 	update_cond_flag(file);
+
+	/* Make sure nothing is using the edata or trigger */
+	tracepoint_synchronize_unregister();
+
+	kfree(edata);
+	kfree(trigger);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a6061a69aa84..f01e442716e2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2506,7 +2506,7 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * If a user specifies a field on an event that isn't the event the
  * histogram currently being defined (the target event histogram), the
  * only way that can be accomplished is if a new hist trigger is
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 8f6b13ae46bf..7d631aaa0ae1 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -189,7 +189,7 @@ if ($arch =~ /(x86(_64)?)|(i386)/) {
 $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
 $weak_regex = "^[0-9a-fA-F]+\\s+([wW])\\s+(\\S+)";
 $section_regex = "Disassembly of section\\s+(\\S+):";
-$function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
+$function_regex = "^([0-9a-fA-F]+)\\s+<([^^]*?)>:";
 $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s(mcount|__fentry__)\$";
 $section_type = '@progbits';
 $mcount_adjust = 0;
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index 5f5b2ba3e557..60c02b482be8 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -11,8 +11,8 @@ SYSTEM="syscalls"
 EVENT="sys_enter_openat"
 FIELD="filename"
 EPROBE="eprobe_open"
-
-echo "e:$EPROBE $SYSTEM/$EVENT file=+0(\$filename):ustring" >> dynamic_events
+OPTIONS="file=+0(\$filename):ustring"
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
 
 grep -q "$EPROBE" dynamic_events
 test -d events/eprobes/$EPROBE
@@ -37,4 +37,54 @@ echo "-:$EPROBE" >> dynamic_events
 ! grep -q "$EPROBE" dynamic_events
 ! test -d events/eprobes/$EPROBE
 
+# test various ways to remove the probe (already tested with just event name)
+
+# With group name
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With group name and system/event
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With just event name and system/event
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:$EPROBE $SYSTEM/$EVENT" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With just event name and system/event and options
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With group name and system/event and options
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# Finally make sure what is in the dynamic_events file clears it too
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+LINE=`sed -e '/$EPROBE/s/^e/-/' < dynamic_events`
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
 clear_trace
