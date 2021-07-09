Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DC3C24F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhGIN0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232910AbhGINZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:25:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1548613BC;
        Fri,  9 Jul 2021 13:22:57 +0000 (UTC)
Date:   Fri, 9 Jul 2021 09:22:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baokun Li <libaokun1@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fix for histogram and clean up in ftrace
Message-ID: <20210709092256.567f77a1@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fix for histograms and a clean up in ftrace

 - Fixed a bug that broke the .sym-offset modifier and added a test to make
   sure nothing breaks it again.

 - Replace a list_del/list_add() with a list_move()


Please pull the latest trace-v5.14-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-2

Tag SHA1: 153d0ceb33c062166324b79cde4ab67e534a0678
Head SHA1: 3ecda64475bccdfdcbfd5b9b7e4bf639d8b233da


Baokun Li (1):
      ftrace: Use list_move instead of list_del/list_add

Steven Rostedt (VMware) (2):
      tracing/histograms: Fix parsing of "sym-offset" modifier
      tracing/selftests: Add tests to test histogram sym and sym-offset modifiers

----
 kernel/trace/ftrace.c                                  |  3 +--
 kernel/trace/trace_events_hist.c                       |  7 +++++++
 .../selftests/ftrace/test.d/trigger/trigger-hist.tc    | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 72ef4dccbcc4..e6fb3e6e1ffc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4212,8 +4212,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 		if (!func) /* warn? */
 			continue;
 
-		list_del(&ftrace_mod->list);
-		list_add(&ftrace_mod->list, &process_mods);
+		list_move(&ftrace_mod->list, &process_mods);
 
 		/* Use the newly allocated func, as it may be "*" */
 		kfree(ftrace_mod->func);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba03b7d84fc2..0207aeed31e6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1555,6 +1555,13 @@ static int contains_operator(char *str)
 
 	switch (*op) {
 	case '-':
+		/*
+		 * Unfortunately, the modifier ".sym-offset"
+		 * can confuse things.
+		 */
+		if (op - str >= 4 && !strncmp(op - 4, ".sym-offset", 11))
+			return FIELD_OP_NONE;
+
 		if (*str == '-')
 			field_op = FIELD_OP_UNARY_MINUS;
 		else
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 2950bfbc6fce..adae72665500 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -39,6 +39,24 @@ grep "parent_comm: $COMM" events/sched/sched_process_fork/hist > /dev/null || \
 
 reset_trigger
 
+echo "Test histogram with sym modifier"
+
+echo 'hist:keys=call_site.sym' > events/kmem/kmalloc/trigger
+for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]* *}' events/kmem/kmalloc/hist > /dev/null || \
+    fail "sym modifier on kmalloc call_site did not work"
+
+reset_trigger
+
+echo "Test histogram with sym-offset modifier"
+
+echo 'hist:keys=call_site.sym-offset' > events/kmem/kmalloc/trigger
+for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]*+0x[0-9a-f][0-9a-f]*' events/kmem/kmalloc/hist > /dev/null || \
+    fail "sym-offset modifier on kmalloc call_site did not work"
+
+reset_trigger
+
 echo "Test histogram with sort key"
 
 echo 'hist:keys=parent_pid,child_pid:sort=child_pid.ascending' > events/sched/sched_process_fork/trigger
