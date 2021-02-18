Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449831E914
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhBRLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:13:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:58033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhBRKJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:09:13 -0500
IronPort-SDR: tu4VoRaSB5EC8LWs/KwLVvgerWKTchBVasF43fiQQhj7AZqFJPsAXfOBUQF3/vx5LXZBGwH6uq
 ouUCSPGk4LkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127939"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:17 -0800
IronPort-SDR: c/LYlWXI7bGDba5slxeRxkT8Rxs2AE6Ml7tZmuBaoGbZOHX76iyFQ2tWpzGYqlD/anDCsVb1SC
 WabmepP+o6DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427648"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:15 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] perf machine: Factor out machine__idle_thread()
Date:   Thu, 18 Feb 2021 11:57:56 +0200
Message-Id: <20210218095801.19576-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out machine__idle_thread() so it can be re-used for guest machines.

A thread is needed to find executable code, even for the guest kernel. To
avoid possible future pid number conflicts, the idle thread can be used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 18 ++++++++++++++++++
 tools/perf/util/machine.h |  1 +
 tools/perf/util/session.c | 25 +++----------------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 90703b7ca6de..b5c2d8be4144 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -598,6 +598,24 @@ struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 	return th;
 }
 
+/*
+ * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
+ * So here a single thread is created for that, but actually there is a separate
+ * idle task per cpu, so there should be one 'struct thread' per cpu, but there
+ * is only 1. That causes problems for some tools, requiring workarounds. For
+ * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
+ */
+struct thread *machine__idle_thread(struct machine *machine)
+{
+	struct thread *thread = machine__findnew_thread(machine, 0, 0);
+
+	if (!thread || thread__set_comm(thread, "swapper", 0) ||
+	    thread__set_namespaces(thread, 0, NULL))
+		pr_err("problem inserting idle task for machine pid %d\n", machine->pid);
+
+	return thread;
+}
+
 struct comm *machine__thread_exec_comm(struct machine *machine,
 				       struct thread *thread)
 {
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 022c19ecd287..7377ed6efdf1 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -106,6 +106,7 @@ u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
 
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
+struct thread *machine__idle_thread(struct machine *machine);
 struct comm *machine__thread_exec_comm(struct machine *machine,
 				       struct thread *thread);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7b0d0c9e3dd1..859832a82496 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1789,32 +1789,13 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
 	return machine__findnew_thread(&session->machines.host, -1, pid);
 }
 
-/*
- * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
- * So here a single thread is created for that, but actually there is a separate
- * idle task per cpu, so there should be one 'struct thread' per cpu, but there
- * is only 1. That causes problems for some tools, requiring workarounds. For
- * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
- */
 int perf_session__register_idle_thread(struct perf_session *session)
 {
-	struct thread *thread;
-	int err = 0;
-
-	thread = machine__findnew_thread(&session->machines.host, 0, 0);
-	if (thread == NULL || thread__set_comm(thread, "swapper", 0)) {
-		pr_err("problem inserting idle task.\n");
-		err = -1;
-	}
+	struct thread *thread = machine__idle_thread(&session->machines.host);
 
-	if (thread == NULL || thread__set_namespaces(thread, 0, NULL)) {
-		pr_err("problem inserting idle task.\n");
-		err = -1;
-	}
-
-	/* machine__findnew_thread() got the thread, so put it */
+	/* machine__idle_thread() got the thread, so put it */
 	thread__put(thread);
-	return err;
+	return thread ? 0 : -1;
 }
 
 static void
-- 
2.17.1

