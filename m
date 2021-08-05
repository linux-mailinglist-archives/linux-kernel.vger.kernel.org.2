Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E393E19A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhHEQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhHEQgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:36:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521CC61050;
        Thu,  5 Aug 2021 16:35:46 +0000 (UTC)
Date:   Thu, 5 Aug 2021 12:35:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hui Su <suhui@zeku.com>,
        Kamal Agrawal <kamaagra@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] tracing: Fixes for 5.14-rc4
Message-ID: <20210805123539.2a707e63@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various tracing fixes:

- Fix NULL pointer dereference caused by an error path

- Give histogram calculation fields a size, otherwise it breaks synthetic
  creation based on them.

- Reject strings being used for number calculations.

- Fix recordmcount.pl warning on llvm building RISC-V allmodconfig

- Fix the draw_functrace.py script to handle the new trace output

- Fix warning of smp_processor_id() in preemptible code


Please pull the latest trace-v5.14-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-rc4

Tag SHA1: c14d7983b2c0657a10beab4e237c6b5d1be58d7a
Head SHA1: 51397dc6f283bb570e1cf8226017d300d8ea1f5b


Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Kamal Agrawal (1):
      tracing: Fix NULL pointer dereference in start_creating

Masami Hiramatsu (1):
      tracing: Reject string operand in the histogram expression

Nathan Chancellor (1):
      scripts/recordmcount.pl: Remove check_objcopy() and $can_use_local

Steven Rostedt (VMware) (2):
      tracing / histogram: Give calculation hist_fields a size
      tracing: Quiet smp_processor_id() use in preemptable warning in hwlat

----
 Makefile                          |  1 -
 kernel/trace/trace.c              |  4 +++-
 kernel/trace/trace_events_hist.c  | 24 ++++++++++++++++++++++-
 kernel/trace/trace_hwlat.c        |  2 +-
 scripts/recordmcount.pl           | 40 ---------------------------------------
 scripts/tracing/draw_functrace.py |  6 +++---
 6 files changed, 30 insertions(+), 47 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index e4f5895badb5..d6915f361aa4 100644
--- a/Makefile
+++ b/Makefile
@@ -546,7 +546,6 @@ export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
 PHONY += scripts_basic
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
-	$(Q)rm -f .tmp_quiet_recordmcount
 
 PHONY += outputmakefile
 ifdef building_out_of_srctree
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c59dd35a6da5..33899a71fdc1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9135,8 +9135,10 @@ static int trace_array_create_dir(struct trace_array *tr)
 		return -EINVAL;
 
 	ret = event_trace_add_tracer(tr->dir, tr);
-	if (ret)
+	if (ret) {
 		tracefs_remove(tr->dir);
+		return ret;
+	}
 
 	init_tracer_tracefs(tr, tr->dir);
 	__update_tracer_options(tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 34325f41ebc0..949ef09dc537 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -65,7 +65,8 @@
 	C(INVALID_SORT_MODIFIER,"Invalid sort modifier"),		\
 	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
-	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),
+	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
+	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -2156,6 +2157,13 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(operand1);
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		/* String type can not be the operand of unary operator. */
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		destroy_hist_field(operand1, 0);
+		ret = -EINVAL;
+		goto free;
+	}
 
 	expr->flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
@@ -2257,6 +2265,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand1 = NULL;
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(operand1_str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	/* rest of string could be another expression e.g. b+c in a+b+c */
 	operand_flags = 0;
@@ -2266,6 +2279,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand2 = NULL;
 		goto free;
 	}
+	if (operand2->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	ret = check_expr_operands(file->tr, operand1, operand2);
 	if (ret)
@@ -2287,6 +2305,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
+
+	/* The operand sizes should be the same, so just pick one */
+	expr->size = operand1->size;
+
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
 	expr->type = kstrdup(operand1->type, GFP_KERNEL);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a6c0cdaf4b87..14f46aae1981 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -327,7 +327,7 @@ static void move_to_next_cpu(void)
 
 	get_online_cpus();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	next_cpu = cpumask_next(smp_processor_id(), current_mask);
+	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
 	put_online_cpus();
 
 	if (next_cpu >= nr_cpu_ids)
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index c17e48020ec3..8f6b13ae46bf 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -173,39 +173,6 @@ my $mcount_regex;	# Find the call site to mcount (return offset)
 my $mcount_adjust;	# Address adjustment to mcount offset
 my $alignment;		# The .align value to use for $mcount_section
 my $section_type;	# Section header plus possible alignment command
-my $can_use_local = 0; 	# If we can use local function references
-
-# Shut up recordmcount if user has older objcopy
-my $quiet_recordmcount = ".tmp_quiet_recordmcount";
-my $print_warning = 1;
-$print_warning = 0 if ( -f $quiet_recordmcount);
-
-##
-# check_objcopy - whether objcopy supports --globalize-symbols
-#
-#  --globalize-symbols came out in 2.17, we must test the version
-#  of objcopy, and if it is less than 2.17, then we can not
-#  record local functions.
-sub check_objcopy
-{
-    open (IN, "$objcopy --version |") or die "error running $objcopy";
-    while (<IN>) {
-	if (/objcopy.*\s(\d+)\.(\d+)/) {
-	    $can_use_local = 1 if ($1 > 2 || ($1 == 2 && $2 >= 17));
-	    last;
-	}
-    }
-    close (IN);
-
-    if (!$can_use_local && $print_warning) {
-	print STDERR "WARNING: could not find objcopy version or version " .
-	    "is less than 2.17.\n" .
-	    "\tLocal function references are disabled.\n";
-	open (QUIET, ">$quiet_recordmcount");
-	printf QUIET "Disables the warning from recordmcount.pl\n";
-	close QUIET;
-    }
-}
 
 if ($arch =~ /(x86(_64)?)|(i386)/) {
     if ($bits == 64) {
@@ -434,8 +401,6 @@ if ($filename =~ m,^(.*)(\.\S),) {
 my $mcount_s = $dirname . "/.tmp_mc_" . $prefix . ".s";
 my $mcount_o = $dirname . "/.tmp_mc_" . $prefix . ".o";
 
-check_objcopy();
-
 #
 # Step 1: find all the local (static functions) and weak symbols.
 #         't' is local, 'w/W' is weak
@@ -473,11 +438,6 @@ sub update_funcs
 
     # is this function static? If so, note this fact.
     if (defined $locals{$ref_func}) {
-
-	# only use locals if objcopy supports globalize-symbols
-	if (!$can_use_local) {
-	    return;
-	}
 	$convert{$ref_func} = 1;
     }
 
diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index 74f8aadfd4cb..7011fbe003ff 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -17,7 +17,7 @@ Usage:
 	$ cat /sys/kernel/debug/tracing/trace_pipe > ~/raw_trace_func
 	Wait some times but not too much, the script is a bit slow.
 	Break the pipe (Ctrl + Z)
-	$ scripts/draw_functrace.py < raw_trace_func > draw_functrace
+	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
 	Then you have your drawn trace in draw_functrace
 """
 
@@ -103,10 +103,10 @@ def parseLine(line):
 	line = line.strip()
 	if line.startswith("#"):
 		raise CommentLineException
-	m = re.match("[^]]+?\\] +([0-9.]+): (\\w+) <-(\\w+)", line)
+	m = re.match("[^]]+?\\] +([a-z.]+) +([0-9.]+): (\\w+) <-(\\w+)", line)
 	if m is None:
 		raise BrokenLineException
-	return (m.group(1), m.group(2), m.group(3))
+	return (m.group(2), m.group(3), m.group(4))
 
 
 def main():
