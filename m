Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE636FC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhD3OXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:23:49 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:3867 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhD3OXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:23:34 -0400
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
Subject: [PATCH 2/2] tracing: Align task.h to use __assing_str for strings.
Date:   Fri, 30 Apr 2021 16:22:23 +0200
Message-ID: <20210430142223.25500-3-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430142223.25500-1-peter.enderborg@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=3YhXtTcJ-WEA:10 a=z6gsHLkEAAAA:8 a=4oRWXRFbHDL5cu2236cA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the comm strings to use the tracing string functions
instead of char arrays so they all work in the same way.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 include/trace/events/task.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 2e977d2935e1..2bd314e60cb6 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -14,20 +14,20 @@ TRACE_EVENT(task_newtask,
 
 	TP_STRUCT__entry(
 		__field(	pid_t,	pid)
-		__array(	char,	comm, TASK_COMM_LEN)
+		__string(comm, task->comm)
 		__field( unsigned long, clone_flags)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__assign_str(comm, task->comm);
 		__entry->clone_flags = clone_flags;
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
 	TP_printk("pid=%d comm=%s clone_flags=%lx oom_score_adj=%hd",
-		__entry->pid, __entry->comm,
+		  __entry->pid, __get_str(comm),
 		__entry->clone_flags, __entry->oom_score_adj)
 );
 
@@ -39,21 +39,21 @@ TRACE_EVENT(task_rename,
 
 	TP_STRUCT__entry(
 		__field(	pid_t,	pid)
-		__array(	char, oldcomm,  TASK_COMM_LEN)
-		__array(	char, newcomm,  TASK_COMM_LEN)
+		__string(oldcomm, task->comm)
+		__string(newcomm, comm)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
-		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
+		__assign_str(oldcomm, task->comm);
+		__assign_str(newcomm, comm);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
 	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
-		__entry->pid, __entry->oldcomm,
-		__entry->newcomm, __entry->oom_score_adj)
+		__entry->pid, __get_str(oldcomm),
+		__get_str(newcomm), __entry->oom_score_adj)
 );
 
 TRACE_EVENT(task_exit,
-- 
2.17.1

