Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973F23426F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCSUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCSUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:33:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F0C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l13so7784012qtu.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpPoJd2F7IbqGPXSIpvBmSHFT2X1G3ZwKLoht+xM9O8=;
        b=EddG8SYOIMsnU8ENDoLygAYZHtzmk8XPjJiYEPEzJs1gH+O1in2gS68ZBZR4r8COy/
         DEWrzEa/uV2Zdm5mOvh3bRWcTkwIyXptWhke6XlANpsMEZPHuR/Lcs2D/ueegC14nKH/
         2GJJ9KMra3zdqhOZdU85XwXlgZGtaav2g2QMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpPoJd2F7IbqGPXSIpvBmSHFT2X1G3ZwKLoht+xM9O8=;
        b=oS74gpmEy5Ga+MQOuMy4ieNNbBUPRyUIMdG4qE5PJnNh7MjR2rMzCIrgJ/wXIY3Q/r
         C0JAL/r6KJAtZqaN02aRyUVXiWwMBpkT8Sfhb/9f2vt8dvBPw+u1ZHmtsAtrjsuPRON3
         VOR22+8vgAMpHhAgs5B2Z2RAkSp2vNvGToPNGFRmc+d+Gogbz/9iXCjY7Js+9VVWNFsD
         OJNMG9caWJnMaWu0JnVnlvrhvTczhQKYgaWAudCMnPYFfWwmcI2yJkOxTXFv/bnjhysP
         gN5M/8kYe9YiwBVcPAS96bSLOaza7f6vfO6x6g0MzT/x5uxQNX5zEU7hF+BhFi8psZ/J
         a24w==
X-Gm-Message-State: AOAM531FtWB8Am5xsq6bx57g69hP/8//X3pJU1o1sGpjm7gtWZdthR8N
        SAWTHwLwGa0zdtilLscdZ0oSXA==
X-Google-Smtp-Source: ABdhPJxQJRswzJUgDwP03UD/oU12DQ/cMY5rutrOKVzhM6qTI/a774kR/7+L2bwMxvYbaOGhxeFKvw==
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr410319qtp.389.1616185985820;
        Fri, 19 Mar 2021 13:33:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:7422:5a6f:e616:23c9])
        by smtp.gmail.com with ESMTPSA id j26sm4588187qtp.30.2021.03.19.13.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:33:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 4/6] kselftest: Add tests for core-sched interface
Date:   Fri, 19 Mar 2021 16:32:51 -0400
Message-Id: <20210319203253.3352417-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319203253.3352417-1-joel@joelfernandes.org>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kselftest test to ensure that the core-sched interface is working
correctly.

Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/sched/.gitignore      |   1 +
 tools/testing/selftests/sched/Makefile        |  14 +
 tools/testing/selftests/sched/config          |   1 +
 tools/testing/selftests/sched/cs_prctl_test.c | 372 ++++++++
 .../testing/selftests/sched/test_coresched.c  | 812 ++++++++++++++++++
 5 files changed, 1200 insertions(+)
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c
 create mode 100644 tools/testing/selftests/sched/test_coresched.c

diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
new file mode 100644
index 000000000000..4660929b0b9a
--- /dev/null
+++ b/tools/testing/selftests/sched/.gitignore
@@ -0,0 +1 @@
+test_coresched
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
new file mode 100644
index 000000000000..830766e12bed
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
+TEST_GEN_FILES := test_coresched cs_prctl_test
+TEST_PROGS := test_coresched cs_prctl_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
new file mode 100644
index 000000000000..e8b09aa7c0c4
--- /dev/null
+++ b/tools/testing/selftests/sched/config
@@ -0,0 +1 @@
+CONFIG_SCHED_DEBUG=y
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
new file mode 100644
index 000000000000..9e51874533c8
--- /dev/null
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -0,0 +1,372 @@
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
+#ifndef PR_SCHED_CORE_SHARE
+#define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0
+# define PR_SCHED_CORE_CREATE		1
+# define PR_SCHED_CORE_SHARE_FROM	2
+# define PR_SCHED_CORE_SHARE_TO		3
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
+	char buf[4096];
+	char fn[512];
+	FILE *inf;
+	char *c;
+	int i;
+
+	if (pid == 0)
+		pid = getpid();
+	snprintf(fn, 512, "/proc/%d/sched", pid);
+
+	inf = fopen(fn, "r");
+	if (!inf)
+		return -2UL;
+
+	while (fgets(buf, 4096, inf)) {
+		if (!strncmp(buf, "core_cookie", 11)) {
+			for (i = 0, c = buf; *c != '\0' && *c != ':' && i < 4096; ++i, ++c)
+				;
+			if (*c == ':') {
+				fclose(inf);
+				return strtoul(c + 1, NULL, 10);
+			}
+		}
+	}
+	fclose(inf);
+	printf("Not a core sched system\n");
+	return -1UL;
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
+
+static int errors = 0;
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
+	if (!(0 < num_processes && num_processes <= MAX_PROCESSES))
+		handle_usage(1, "Bad processes value");
+
+	if (!(0 < num_threads && num_threads <= MAX_THREADS))
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
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
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
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
+		handle_error("core_sched create failed -- TGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) != get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
+	       getpid(), pid);
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share to itself failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
+	       procs[pidx].thr_tids[0], getpid());
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
+		   PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched share from thread failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Clear a cookie on a single task [%d]\n", pid);
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR, pid, PIDTYPE_PID, 0) < 0)
+		handle_error("core_sched clear failed -- PID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(pid) == 0);
+	validate(get_cs_cookie(procs[pidx].thr_tids[0]) != 0);
+
+	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
+		handle_error("core_sched share to self failed -- PGID");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(0) == get_cs_cookie(pid));
+	validate(get_cs_cookie(pid) != 0);
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Clear cookies on the entire process group\n");
+	if (_prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR, 0, PIDTYPE_PGID, 0) < 0)
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
diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
new file mode 100644
index 000000000000..9d47845e6f8a
--- /dev/null
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -0,0 +1,812 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Core-scheduling selftests.
+ *
+ * Copyright (C) 2020, Joel Fernandes.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#ifndef PR_SCHED_CORE_SHARE
+#define PR_SCHED_CORE_SHARE 59
+# define PR_SCHED_CORE_CLEAR            0
+# define PR_SCHED_CORE_CREATE           1
+# define PR_SCHED_CORE_SHARE_FROM       2
+# define PR_SCHED_CORE_SHARE_TO         3
+#endif
+
+#ifndef DEBUG_PRINT
+#define dprint(...)
+#else
+#define dprint(str, args...) printf("DEBUG: %s: " str "\n", __func__, ##args)
+#endif
+
+void print_banner(char *s)
+{
+	printf("coresched: %s:  ", s);
+}
+
+void print_pass(void)
+{
+	printf("PASS\n");
+}
+
+void assert_cond(int cond, char *str)
+{
+	if (!cond) {
+		printf("Error: %s\n", str);
+		abort();
+	}
+}
+
+char *make_group_root(void)
+{
+	char *mntpath, *mnt;
+	int ret;
+
+	mntpath = malloc(50);
+	if (!mntpath) {
+		perror("Failed to allocate mntpath\n");
+		abort();
+	}
+
+	sprintf(mntpath, "/tmp/coresched-test-XXXXXX");
+	mnt = mkdtemp(mntpath);
+	if (!mnt) {
+		perror("Failed to create mount: ");
+		exit(-1);
+	}
+
+	ret = mount("nodev", mnt, "cgroup", 0, "cpu");
+	if (ret == -1) {
+		perror("Failed to mount cgroup: ");
+		exit(-1);
+	}
+
+	return mnt;
+}
+
+void assert_group_tag(char *cgroup_path, char *tag)
+{
+	char tag_path[50] = {}, rdbuf[8] = {};
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_RDONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (read(tfd, rdbuf, 1) != 1) {
+		perror("Failed to enable coresched on cgroup: ");
+		abort();
+	}
+
+	if (strcmp(rdbuf, tag)) {
+		printf("Group tag does not match (exp: %s, act: %s)\n", tag,
+		       rdbuf);
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+}
+
+void tag_group(char *cgroup_path)
+{
+	char tag_path[50];
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (write(tfd, "1", 1) != 1) {
+		perror("Failed to enable coresched on cgroup: ");
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+
+	assert_group_tag(cgroup_path, "1");
+}
+
+void untag_group(char *cgroup_path)
+{
+	char tag_path[50];
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (write(tfd, "0", 1) != 1) {
+		perror("Failed to disable coresched on cgroup: ");
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+
+	assert_group_tag(cgroup_path, "0");
+}
+
+char *make_group(char *parent, char *name)
+{
+	char *cgroup_path;
+	int ret;
+
+	if (!parent && !name)
+		return make_group_root();
+
+	cgroup_path = malloc(50);
+	if (!cgroup_path) {
+		perror("Failed to allocate cgroup_path\n");
+		abort();
+	}
+
+	/* Make the cgroup node for this group */
+	sprintf(cgroup_path, "%s/%s", parent, name);
+	ret = mkdir(cgroup_path, 0644);
+	if (ret == -1) {
+		perror("Failed to create group in cgroup: ");
+		abort();
+	}
+
+	return cgroup_path;
+}
+
+static void del_group(char *path)
+{
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
+
+	free(path);
+}
+
+static void del_root_group(char *path)
+{
+	if (umount(path) != 0) {
+		perror("umount of cgroup failed\n");
+		abort();
+	}
+
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
+
+	free(path);
+}
+
+struct task_state {
+	int pid_share;
+	char pid_str[50];
+	pthread_mutex_t m;
+	pthread_cond_t cond;
+	pthread_cond_t cond_par;
+};
+
+struct task_state *add_task(char *p)
+{
+	struct task_state *mem;
+	pthread_mutexattr_t am;
+	pthread_condattr_t a;
+	char tasks_path[50];
+	int tfd, pid, ret;
+
+	sprintf(tasks_path, "%s/tasks", p);
+	tfd = open(tasks_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tasks path failed: ");
+		abort();
+	}
+
+	mem = mmap(NULL, sizeof(*mem), PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	memset(mem, 0, sizeof(*mem));
+
+	pthread_condattr_init(&a);
+	pthread_condattr_setpshared(&a, PTHREAD_PROCESS_SHARED);
+	pthread_mutexattr_init(&am);
+	pthread_mutexattr_setpshared(&am, PTHREAD_PROCESS_SHARED);
+
+	pthread_cond_init(&mem->cond, &a);
+	pthread_cond_init(&mem->cond_par, &a);
+	pthread_mutex_init(&mem->m, &am);
+
+	pid = fork();
+	if (pid == 0) {
+		while (1) {
+			pthread_mutex_lock(&mem->m);
+			while (!mem->pid_share)
+				pthread_cond_wait(&mem->cond, &mem->m);
+
+			pid = mem->pid_share;
+			mem->pid_share = 0;
+
+			if (pid == -1) {
+				if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR, getpid(), 0, 0))
+					perror("prctl() PR_SCHED_CORE_CLEAR failed");
+			} else {
+				if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CREATE, pid, 0, 0))
+					perror("prctl() PR_SCHED_CORE_CREATE failed");
+
+				if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, pid, 0, 0))
+					perror("prctl() PR_SCHED_CORE_SHARE_FROM failed");
+			}
+			pthread_mutex_unlock(&mem->m);
+			pthread_cond_signal(&mem->cond_par);
+		}
+	}
+
+	sprintf(mem->pid_str, "%d", pid);
+	dprint("add task %d to group %s", pid, p);
+
+	ret = write(tfd, mem->pid_str, strlen(mem->pid_str));
+	assert_cond(ret != -1, "Failed to write pid into tasks");
+
+	close(tfd);
+	return mem;
+}
+
+/* Move task to a new cgroup */
+void migrate_task(struct task_state *t, char *group)
+{
+	char tasks_path[50];
+	int tfd, ret;
+
+	sprintf(tasks_path, "%s/tasks", group);
+	tfd = open(tasks_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tasks path failed: ");
+		abort();
+	}
+
+	ret = write(tfd, t->pid_str, strlen(t->pid_str));
+	assert_cond(ret != -1, "Failed to write pid into tasks");
+
+	close(tfd);
+}
+
+/* Make t1 share with t2 */
+void make_tasks_share(struct task_state *t1, struct task_state *t2)
+{
+	int p2 = atoi(t2->pid_str);
+
+	dprint("task %s %s", t1->pid_str, t2->pid_str);
+
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = p2;
+	pthread_mutex_unlock(&t1->m);
+
+	pthread_cond_signal(&t1->cond);
+
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
+}
+
+/* Make t1 share with t2 */
+void reset_task_cookie(struct task_state *t1)
+{
+	dprint("task %s", t1->pid_str);
+
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = -1;
+	pthread_mutex_unlock(&t1->m);
+
+	pthread_cond_signal(&t1->cond);
+
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
+}
+
+char *get_task_core_cookie(char *pid)
+{
+	char proc_path[50];
+	int found = 0;
+	char *line;
+	int i, j;
+	FILE *fp;
+
+	line = malloc(1024);
+	assert_cond(!!line, "Failed to alloc memory");
+
+	sprintf(proc_path, "/proc/%s/sched", pid);
+
+	fp = fopen(proc_path, "r");
+	while ((fgets(line, 1024, fp)) != NULL) {
+		if (!strstr(line, "core_cookie"))
+			continue;
+
+		for (j = 0, i = 0; i < 1024 && line[i] != '\0'; i++)
+			if (line[i] >= '0' && line[i] <= '9')
+				line[j++] = line[i];
+		line[j] = '\0';
+		found = 1;
+		break;
+	}
+
+	fclose(fp);
+
+	if (found)
+		return line;
+
+	free(line);
+	printf("core_cookie not found. Enable SCHED_DEBUG?\n");
+	abort();
+	return NULL;
+}
+
+#define assert_tasks_share(t1, t2) _assert_tasks_share(__LINE__, t1, t2)
+void _assert_tasks_share(int line, struct task_state *t1, struct task_state *t2)
+{
+	char *c1, *c2;
+
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("(%d) check task (%s) cookie (%s) == task (%s) cookie (%s)",
+	       line, t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(!strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1);
+	free(c2);
+}
+
+#define assert_tasks_dont_share(t1, t2) _assert_tasks_dont_share(__LINE__, t1, t2)
+void _assert_tasks_dont_share(int line, struct task_state *t1, struct task_state *t2)
+{
+	char *c1, *c2;
+
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("(%d) check task (%s) cookie (%s) != task (%s) cookie (%s)",
+	       line, t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1);
+	free(c2);
+}
+
+void assert_task_has_cookie(char *pid)
+{
+	char *tk;
+
+	tk = get_task_core_cookie(pid);
+
+	assert_cond(strcmp(tk, "0"), "Task does not have cookie");
+
+	free(tk);
+}
+
+void assert_task_has_no_cookie(char *pid)
+{
+	char *tk;
+
+	tk = get_task_core_cookie(pid);
+
+	assert_cond(!strcmp(tk, "0"), "Task has cookie");
+
+	free(tk);
+}
+
+void kill_task(struct task_state *t)
+{
+	int pid = atoi(t->pid_str);
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+}
+
+/*
+ * Test that a group's children have a cookie inherrited
+ * from their parent group _after_ the parent was tagged.
+ *
+ *   p ----- c1 - c11
+ *     \ c2 - c22
+ */
+static void test_cgroup_parent_child_tag_inherit(char *root)
+{
+	char *p, *c1, *c11, *c2, *c22;
+	struct task_state *tsk_p, *tsk_c1, *tsk_c11, *tsk_c2, *tsk_c22;
+
+	print_banner("TEST-CGROUP-PARENT-CHILD-TAG");
+
+	p = make_group(root, "p");
+	tsk_p = add_task(p);
+	assert_task_has_no_cookie(tsk_p->pid_str);
+
+	c1 = make_group(p, "c1");
+	tsk_c1 = add_task(c1);
+	assert_group_tag(c1, "0");
+	assert_task_has_no_cookie(tsk_c1->pid_str);
+	assert_tasks_share(tsk_c1, tsk_p);
+
+	c11 = make_group(c1, "c11");
+	tsk_c11 = add_task(c11);
+	assert_group_tag(c11, "0");
+	assert_task_has_no_cookie(tsk_c11->pid_str);
+	assert_tasks_share(tsk_c11, tsk_p);
+
+	c2 = make_group(p, "c2");
+	tsk_c2 = add_task(c2);
+	assert_group_tag(c2, "0");
+	assert_task_has_no_cookie(tsk_c2->pid_str);
+	assert_tasks_share(tsk_c2, tsk_p);
+
+	tag_group(p);
+
+	/* Verify c1 got the cookie */
+	assert_group_tag(c1, "0");
+	assert_task_has_cookie(tsk_c1->pid_str);
+	assert_tasks_share(tsk_c1, tsk_p);
+
+	/* Verify c2 got the cookie */
+	assert_group_tag(c2, "0");
+	assert_task_has_cookie(tsk_c2->pid_str);
+	assert_tasks_share(tsk_c2, tsk_p);
+
+	/* Verify c11 got the cookie */
+	assert_group_tag(c11, "0");
+	assert_task_has_cookie(tsk_c11->pid_str);
+	assert_tasks_share(tsk_c11, tsk_p);
+
+	/*
+	 * Verify c22 which is a nested group created
+	 * _after_ tagging got the cookie.
+	 */
+	c22 = make_group(c2, "c22");
+	tsk_c22 = add_task(c22);
+
+	assert_group_tag(c22, "0");
+	assert_task_has_cookie(tsk_c22->pid_str);
+	assert_tasks_share(tsk_c22, tsk_c1);
+	assert_tasks_share(tsk_c22, tsk_c11);
+	assert_tasks_share(tsk_c22, tsk_c2);
+	assert_tasks_share(tsk_c22, tsk_p);
+
+	kill_task(tsk_p);
+	kill_task(tsk_c1);
+	kill_task(tsk_c11);
+	kill_task(tsk_c2);
+	kill_task(tsk_c22);
+	del_group(c22);
+	del_group(c11);
+	del_group(c1);
+	del_group(c2);
+	del_group(p);
+	print_pass();
+}
+
+/*
+ * Test that a tagged group's children have a cookie inherrited
+ * from their parent group.
+ */
+static void test_cgroup_parent_tag_child_inherit(char *root)
+{
+	char *p, *c1, *c2, *c3;
+	struct task_state *tsk_p, *tsk_c1, *tsk_c2, *tsk_c3;
+
+	print_banner("TEST-CGROUP-PARENT-TAG-CHILD-INHERIT");
+
+	p = make_group(root, "p");
+	tsk_p = add_task(p);
+	assert_task_has_no_cookie(tsk_p->pid_str);
+	tag_group(p);
+	assert_task_has_cookie(tsk_p->pid_str);
+
+	c1 = make_group(p, "c1");
+	tsk_c1 = add_task(c1);
+	assert_task_has_cookie(tsk_c1->pid_str);
+	/* Child tag is "0" but it inherits cookie from parent. */
+	assert_group_tag(c1, "0");
+	assert_tasks_share(tsk_c1, tsk_p);
+
+	c2 = make_group(p, "c2");
+	tsk_c2 = add_task(c2);
+	assert_group_tag(c2, "0");
+	assert_tasks_share(tsk_c2, tsk_p);
+	assert_tasks_share(tsk_c1, tsk_c2);
+
+	c3 = make_group(c1, "c3");
+	tsk_c3 = add_task(c3);
+	assert_group_tag(c3, "0");
+	assert_tasks_share(tsk_c3, tsk_p);
+	assert_tasks_share(tsk_c1, tsk_c3);
+
+	kill_task(tsk_p);
+	kill_task(tsk_c1);
+	kill_task(tsk_c2);
+	kill_task(tsk_c3);
+	del_group(c3);
+	del_group(c1);
+	del_group(c2);
+	del_group(p);
+	print_pass();
+}
+
+/* Test that the cookie is updated on cgroup migration */
+static void test_cgroup_inherit_on_migrate(char *root)
+{
+	char *c1, *c2, *c3;
+	struct task_state *tsk_c1, *tsk_c2, *tsk_c3;
+
+	print_banner("TEST-CGROUP-INHERIT-ON-MIGRATE");
+
+	c1 = make_group(root, "c1");
+	tsk_c1 = add_task(c1);
+	assert_task_has_no_cookie(tsk_c1->pid_str);
+
+	c2 = make_group(root, "c2");
+	tsk_c2 = add_task(c2);
+	tsk_c3 = add_task(c2);
+	assert_task_has_no_cookie(tsk_c2->pid_str);
+	assert_task_has_no_cookie(tsk_c3->pid_str);
+	tag_group(c2);
+	assert_task_has_cookie(tsk_c2->pid_str);
+	assert_task_has_cookie(tsk_c3->pid_str);
+	assert_tasks_share(tsk_c2, tsk_c3);
+	assert_tasks_dont_share(tsk_c1, tsk_c2);
+
+	c3 = make_group(root, "c3");
+	tag_group(c3);
+	assert_group_tag(c3, "1");
+	migrate_task(tsk_c3, c3);
+	assert_task_has_cookie(tsk_c3->pid_str);
+	assert_tasks_dont_share(tsk_c2, tsk_c3);
+	assert_tasks_dont_share(tsk_c1, tsk_c3);
+
+	migrate_task(tsk_c3, c2);
+	assert_tasks_share(tsk_c3, tsk_c3);
+
+	migrate_task(tsk_c3, c1);
+	assert_tasks_share(tsk_c3, tsk_c1);
+
+	kill_task(tsk_c1);
+	kill_task(tsk_c2);
+	kill_task(tsk_c3);
+	del_group(c1);
+	del_group(c2);
+	del_group(c3);
+	print_pass();
+}
+
+/* Test that group cookie is cleared when group is untagged */
+static void test_untag_group(char *root)
+{
+	char *c;
+	struct task_state *t;
+
+	print_banner("TEST-UNTAG-CGROUP");
+
+	c = make_group(root, "c");
+	t = add_task(c);
+	assert_task_has_no_cookie(t->pid_str);
+	tag_group(c);
+	assert_task_has_cookie(t->pid_str);
+	untag_group(c);
+	assert_task_has_no_cookie(t->pid_str);
+
+	kill_task(t);
+	del_group(c);
+	print_pass();
+}
+
+/* Test case when both cgroup and task cookies are used at the same time */
+static void test_cgroup_and_task_cookie(char *root)
+{
+	char *c1, *c2;
+	struct task_state *tsk_1, *tsk_2, *tsk_3;
+
+	print_banner("TEST-CGROUP-AND-TASK-COOKIE");
+
+	c1 = make_group(root, "c1");
+	c2 = make_group(root, "c2");
+	tag_group(c1);
+	tag_group(c2);
+	tsk_1 = add_task(c1);
+	tsk_2 = add_task(c1);
+	tsk_3 = add_task(c2);
+	assert_task_has_cookie(tsk_1->pid_str);
+	assert_task_has_cookie(tsk_2->pid_str);
+	assert_task_has_cookie(tsk_3->pid_str);
+	assert_tasks_share(tsk_1, tsk_2);
+	assert_tasks_dont_share(tsk_1, tsk_3);
+
+	/*
+	 * Two tasks in different cgroup but with the same task cookie;
+	 * should not share.
+	 */
+	make_tasks_share(tsk_1, tsk_3);
+	assert_tasks_dont_share(tsk_1, tsk_3);
+	reset_task_cookie(tsk_1);
+	reset_task_cookie(tsk_3);
+
+	/*
+	 * Two tasks in the same cgroup and with the same task cookie;
+	 * should share.
+	 */
+	make_tasks_share(tsk_1, tsk_2);
+	assert_tasks_share(tsk_1, tsk_2);
+	reset_task_cookie(tsk_1);
+	reset_task_cookie(tsk_2);
+
+	/*
+	 * Two tasks in the same cgroup but with different task cookies;
+	 * should not share.
+	 */
+	make_tasks_share(tsk_1, tsk_3);
+	assert_tasks_dont_share(tsk_1, tsk_2);
+	reset_task_cookie(tsk_1);
+	reset_task_cookie(tsk_3);
+
+	kill_task(tsk_1);
+	kill_task(tsk_2);
+	kill_task(tsk_3);
+	del_group(c1);
+	del_group(c2);
+	print_pass();
+}
+
+static void test_prctl_in_group(char *root)
+{
+	char *p;
+	struct task_state *tsk1, *tsk2, *tsk3;
+
+	print_banner("TEST-PRCTL-IN-GROUP");
+
+	p = make_group(root, "p");
+	tsk1 = add_task(p);
+	assert_task_has_no_cookie(tsk1->pid_str);
+	tag_group(p);
+	assert_task_has_cookie(tsk1->pid_str);
+
+	tsk2 = add_task(p);
+	assert_task_has_cookie(tsk2->pid_str);
+
+	tsk3 = add_task(p);
+	assert_task_has_cookie(tsk3->pid_str);
+
+	/* tsk2 share with tsk3 -- both get disconnected from CGroup. */
+	make_tasks_share(tsk2, tsk3);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_task_has_cookie(tsk3->pid_str);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+
+	/* now reset tsk3 -- get connected back to CGroup. */
+	reset_task_cookie(tsk3);
+	assert_task_has_cookie(tsk3->pid_str);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);	// tsk3 is back.
+	assert_tasks_dont_share(tsk1, tsk2);	// but tsk2 is still zombie
+
+	/* now reset tsk2 as well to get it connected back to CGroup. */
+	reset_task_cookie(tsk2);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);
+	assert_tasks_share(tsk1, tsk2);
+
+	/* Test the rest of the cases (2 to 4)
+	 *
+	 *          t1              joining         t2
+	 * CASE 1:
+	 * before   0                               0
+	 * after    new cookie                      new cookie
+	 *
+	 * CASE 2:
+	 * before   X (non-zero)                    0
+	 * after    0                               0
+	 *
+	 * CASE 3:
+	 * before   0                               X (non-zero)
+	 * after    X                               X
+	 *
+	 * CASE 4:
+	 * before   Y (non-zero)                    X (non-zero)
+	 * after    X                               X
+	 */
+
+	/* case 2: */
+	dprint("case 2");
+	make_tasks_share(tsk1, tsk1);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	assert_task_has_cookie(tsk1->pid_str);
+	make_tasks_share(tsk1, tsk2);	/* Will reset the task cookie. */
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+
+	/* case 3: */
+	dprint("case 3");
+	make_tasks_share(tsk2, tsk2);
+	assert_tasks_dont_share(tsk2, tsk1);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_task_has_cookie(tsk2->pid_str);
+	make_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	reset_task_cookie(tsk1);
+	reset_task_cookie(tsk2);
+
+	/* case 4: */
+	dprint("case 4");
+	assert_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	make_tasks_share(tsk1, tsk1);
+	assert_task_has_cookie(tsk1->pid_str);
+	make_tasks_share(tsk2, tsk2);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_dont_share(tsk1, tsk2);
+	make_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	reset_task_cookie(tsk1);
+	reset_task_cookie(tsk2);
+
+	kill_task(tsk1);
+	kill_task(tsk2);
+	kill_task(tsk3);
+	del_group(p);
+	print_pass();
+}
+
+int main(int argc, char *argv[])
+{
+	char *root;
+
+	if (argc > 1)
+		root = argv[1];
+	else
+		root = make_group(NULL, NULL);
+
+	test_cgroup_parent_tag_child_inherit(root);
+	test_cgroup_parent_child_tag_inherit(root);
+	test_cgroup_inherit_on_migrate(root);
+	test_untag_group(root);
+	test_cgroup_and_task_cookie(root);
+	test_prctl_in_group(root);
+
+	if (argc <= 1)
+		del_root_group(root);
+	return 0;
+}
-- 
2.31.0.rc2.261.g7f71774620-goog

