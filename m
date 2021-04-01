Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E9351901
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhDARs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhDARj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263AC08EC25
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8ih6Pt0SCa0yR0OV00SWa4Dg7Y0PrnPGdwb1NMrz2bk=; b=iGf2/N4X7bLZGJISszjhP9r1oW
        P4PAqrw2Rqj4uAeib1f4t5vLClZeU9Hews/ibJVijUCG8WGEnAhv4tNsZEb9//bpTtaB5rgsBA6qZ
        iZMlkoWbD4vzbKYRj6ycaH0hZTEQduPHrCp2J/NLQGblJsIQdJSsO/SmJI9ML56WM98QRZ45grHqD
        x1vQgwpNqaoRgGKdcKW3n/CRXhP82+iTso76b0KyAG2/UslQIAezdV0rBdumSuoveGFEI8Eg6Gw2s
        kOy0MnMOzEzKcb113NsRIhnTnvF9Ayq6q95Ml8kapTy4V7DuMDgkdhWFF3yALE6C2ctSush2uSLlE
        sxh3r7Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxap-006BoV-SI; Thu, 01 Apr 2021 13:42:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3832530705A;
        Thu,  1 Apr 2021 15:42:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DC87C24C1A53C; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.410324389@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 6/9] kselftest: Add test for core sched prctl interface
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Hyser <chris.hyser@oracle.com>

Provides a selftest and examples of using the interface.

[peterz: updated to not use sched_debug]
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210324214020.34142-5-joel@joelfernandes.org
---
 tools/testing/selftests/sched/.gitignore      |    1 
 tools/testing/selftests/sched/Makefile        |   14 +
 tools/testing/selftests/sched/config          |    1 
 tools/testing/selftests/sched/cs_prctl_test.c |  356 ++++++++++++++++++++++++++
 4 files changed, 372 insertions(+)
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c

--- /dev/null
+++ b/tools/testing/selftests/sched/.gitignore
@@ -0,0 +1 @@
+cs_prctl_test
--- /dev/null
+++ b/tools/testing/selftests/sched/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
+CLANG_FLAGS += -no-integrated-as
+endif
+
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \
+	  $(CLANG_FLAGS)
+LDLIBS += -lpthread
+
+TEST_GEN_FILES := cs_prctl_test
+TEST_PROGS := cs_prctl_test
+
+include ../lib.mk
--- /dev/null
+++ b/tools/testing/selftests/sched/config
@@ -0,0 +1 @@
+CONFIG_SCHED_DEBUG=y
--- /dev/null
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Use the core scheduling prctl() to test core scheduling cookies control.
+ *
+ * Copyright (c) 2021 Oracle and/or its affiliates.
+ * Author: Chris Hyser <chris.hyser@oracle.com>
+ *
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, see <http://www.gnu.org/licenses>.
+ */
+
+#define _GNU_SOURCE
+#include <sys/eventfd.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <time.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#if __GLIBC_PREREQ(2, 30) == 0
+#include <sys/syscall.h>
+static pid_t gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+#endif
+
+#ifndef PR_SCHED_CORE
+#define PR_SCHED_CORE			60
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CLEAR		1 /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_CREATE		2 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		3 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	4 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		5
+#endif
+
+#define MAX_PROCESSES 128
+#define MAX_THREADS   128
+
+static const char USAGE[] = "cs_prctl_test [options]\n"
+"    options:\n"
+"	-P  : number of processes to create.\n"
+"	-T  : number of threads per process to create.\n"
+"	-d  : delay time to keep tasks alive.\n"
+"	-k  : keep tasks alive until keypress.\n";
+
+enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
+
+const int THREAD_CLONE_FLAGS = CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | CLONE_VM | CLONE_FILES;
+
+static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
+		  unsigned long arg5)
+{
+	int res;
+
+	res = prctl(option, arg2, arg3, arg4, arg5);
+	printf("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
+	       (long)arg4, arg5);
+	return res;
+}
+
+#define STACK_SIZE (1024 * 1024)
+
+#define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
+static void __handle_error(char *fn, int ln, char *msg)
+{
+	printf("(%s:%d) - ", fn, ln);
+	perror(msg);
+	exit(EXIT_FAILURE);
+}
+
+static void handle_usage(int rc, char *msg)
+{
+	puts(USAGE);
+	puts(msg);
+	putchar('\n');
+	exit(rc);
+}
+
+static unsigned long get_cs_cookie(int pid)
+{
+	unsigned long long cookie;
+	int ret;
+
+	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
+		    (unsigned long)&cookie);
+	if (ret) {
+		printf("Not a core sched system\n");
+		return -1UL;
+	}
+
+	return cookie;
+}
+
+struct child_args {
+	int num_threads;
+	int pfd[2];
+	int cpid;
+	int thr_tids[MAX_THREADS];
+};
+
+static int child_func_thread(void __attribute__((unused))*arg)
+{
+	while (1)
+		usleep(20000);
+	return 0;
+}
+
+static void create_threads(int num_threads, int thr_tids[])
+{
+	void *child_stack;
+	pid_t tid;
+	int i;
+
+	for (i = 0; i < num_threads; ++i) {
+		child_stack = malloc(STACK_SIZE);
+		if (!child_stack)
+			handle_error("child stack allocate");
+
+		tid = clone(child_func_thread, child_stack + STACK_SIZE, THREAD_CLONE_FLAGS, NULL);
+		if (tid == -1)
+			handle_error("clone thread");
+		thr_tids[i] = tid;
+	}
+}
+
+static int child_func_process(void *arg)
+{
+	struct child_args *ca = (struct child_args *)arg;
+
+	close(ca->pfd[0]);
+
+	create_threads(ca->num_threads, ca->thr_tids);
+
+	write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
+	close(ca->pfd[1]);
+
+	while (1)
+		usleep(20000);
+	return 0;
+}
+
+static unsigned char child_func_process_stack[STACK_SIZE];
+
+void create_processes(int num_processes, int num_threads, struct child_args proc[])
+{
+	pid_t cpid;
+	int i;
+
+	for (i = 0; i < num_processes; ++i) {
+		proc[i].num_threads = num_threads;
+
+		if (pipe(proc[i].pfd) == -1)
+			handle_error("pipe() failed");
+
+		cpid = clone(child_func_process, child_func_process_stack + STACK_SIZE,
+			     SIGCHLD, &proc[i]);
+		proc[i].cpid = cpid;
+		close(proc[i].pfd[1]);
+	}
+
+	for (i = 0; i < num_processes; ++i) {
+		read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
+		close(proc[i].pfd[0]);
+	}
+}
+
+void disp_processes(int num_processes, struct child_args proc[])
+{
+	int i, j;
+
+	printf("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
+	       get_cs_cookie(getpid()));
+
+	for (i = 0; i < num_processes; ++i) {
+		printf("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
+		       getpgid(proc[i].cpid), get_cs_cookie(proc[i].cpid));
+		for (j = 0; j < proc[i].num_threads; ++j) {
+			printf("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
+			       proc[i].cpid, getpgid(0), get_cs_cookie(proc[i].thr_tids[j]));
+		}
+	}
+	puts("\n");
+}
+
+static int errors;
+
+#define validate(v) _validate(__LINE__, v, #v)
+void _validate(int line, int val, char *msg)
+{
+	if (!val) {
+		++errors;
+		printf("(%d) FAILED: %s\n", line, msg);
+	} else {
+		printf("(%d) PASSED: %s\n", line, msg);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct child_args procs[MAX_PROCESSES];
+
+	int keypress = 0;
+	int num_processes = 2;
+	int num_threads = 3;
+	int delay = 0;
+	int res = 0;
+	int pidx;
+	int pid;
+	int opt;
+
+	while ((opt = getopt(argc, argv, ":hkT:P:d:")) != -1) {
+		switch (opt) {
+		case 'P':
+			num_processes = (int)strtol(optarg, NULL, 10);
+			break;
+		case 'T':
+			num_threads = (int)strtoul(optarg, NULL, 10);
+			break;
+		case 'd':
+			delay = (int)strtol(optarg, NULL, 10);
+			break;
+		case 'k':
+			keypress = 1;
+			break;
+		case 'h':
+			printf(USAGE);
+			exit(EXIT_SUCCESS);
+		default:
+			handle_usage(20, "unknown option");
+		}
+	}
+
+	if (num_processes < 1 || num_processes > MAX_PROCESSES)
+		handle_usage(1, "Bad processes value");
+
+	if (num_threads < 1 || num_threads > MAX_THREADS)
+		handle_usage(2, "Bad thread value");
+
+	if (keypress)
+		delay = -1;
+
+	srand(time(NULL));
+
+	/* put into separate process group */
+	if (setpgid(0, 0) != 0)
+		handle_error("process group");
+
+	printf("\n## Create a thread/process/process group hiearchy\n");
+	create_processes(num_processes, num_threads, procs);
+	disp_processes(num_processes, procs);
+	validate(get_cs_cookie(0) == 0);
+
+	printf("\n## Set a cookie on entire process group\n");
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched create failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) != 0);
+
+	/* get a random process pid */
+	pidx = rand() % num_processes;
+	pid = procs[pidx].cpid;
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
+		handle_error("core_sched create failed -- TGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) != get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
+	       getpid(), pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share to itself failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
+	       procs[pidx].thr_tids[0], getpid());
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
+		   PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share from thread failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Clear a cookie on a single task [%d]\n", pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CLEAR, pid, PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched clear failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(pid) == 0);
+	validate(get_cs_cookie(procs[pidx].thr_tids[0]) != 0);
+
+	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched share to self failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Clear cookies on the entire process group\n");
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CLEAR, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched clear failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == 0);
+	validate(get_cs_cookie(pid) == 0);
+	validate(get_cs_cookie(procs[pidx].thr_tids[0]) == 0);
+
+	if (errors) {
+		printf("TESTS FAILED. errors: %d\n", errors);
+		res = 10;
+	} else {
+		printf("SUCCESS !!!\n");
+	}
+
+	if (keypress)
+		getchar();
+	else
+		sleep(delay);
+
+	for (pidx = 0; pidx < num_processes; ++pidx)
+		kill(procs[pidx].cpid, 15);
+
+	return res;
+}


