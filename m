Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01E36FC49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhD3OXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:23:38 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:3843 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233135AbhD3OX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:23:27 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Minchan Kim <minchan@kernel.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH 1/2] tracing: Add a trace for task_exit
Date:   Fri, 30 Apr 2021 16:22:22 +0200
Message-ID: <20210430142223.25500-2-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430142223.25500-1-peter.enderborg@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=3YhXtTcJ-WEA:10 a=z6gsHLkEAAAA:8 a=NkeGOKhD0Io3lEhIEAYA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the peer functions to task_rename and task_newtask.
With this we get hole "life-cycle" of task and can easily
see short livied task and their exit status.

Format might look like:
            bash-1144    [006] ....  1306.601707: task_newtask: pid=1181 comm=bash clone_flags=1200000 oom_score_adj=0
           <...>-1181    [007] ....  1306.602080: task_rename: pid=1181 oldcomm=bash newcomm=ls oom_score_adj=0
            bash-1144    [006] d...  1306.785960: task_exit: pid=1181 oom_score_adj=0 exit_signal=17 exit_code=0 exit_state=0x10 comm=ls

For a sequence when a bash shell runs the ls command.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 include/trace/events/task.h | 32 ++++++++++++++++++++++++++++++++
 kernel/exit.c               |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 64d160930b0d..2e977d2935e1 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -56,6 +56,38 @@ TRACE_EVENT(task_rename,
 		__entry->newcomm, __entry->oom_score_adj)
 );
 
+TRACE_EVENT(task_exit,
+
+	TP_PROTO(struct task_struct *task),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__field(pid_t,	pid)
+		__field(short,	oom_score_adj)
+		__field(int,	exit_signal)
+		__field(int,	exit_code)
+		__field(int,	exit_state)
+		__string(comm, task->comm)
+
+	),
+
+	TP_fast_assign(
+		__entry->pid = task->pid;
+		__entry->oom_score_adj = task->signal->oom_score_adj;
+		__entry->exit_signal = task->exit_signal;
+		__entry->exit_code = task->exit_code;
+		__entry->exit_state = task->exit_state;
+		__assign_str(comm, task->comm);
+	),
+
+	TP_printk("pid=%d oom_score_adj=%hd exit_signal=%d exit_code=%d exit_state=0x%x comm=%s",
+		  __entry->pid,
+		  __entry->oom_score_adj, __entry->exit_signal,
+		  __entry->exit_code, __entry->exit_state,
+		  __get_str(comm))
+);
+
 #endif
 
 /* This part must be outside protection */
diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69a..3ab0944e5dfc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,7 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
+#include <trace/events/task.h>
 
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
@@ -107,6 +108,8 @@ static void __exit_signal(struct task_struct *tsk)
 		posix_cpu_timers_exit_group(tsk);
 #endif
 
+	trace_task_exit(tsk);
+
 	if (group_dead) {
 		tty = sig->tty;
 		sig->tty = NULL;
-- 
2.17.1

