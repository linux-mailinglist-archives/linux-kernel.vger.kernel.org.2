Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9463483DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhCXVky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhCXVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A0C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so243668qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tu47D6rgPK5Ch8hxGqsY0MMWLz7AproMEYVk2VvxMPs=;
        b=EZNKOmm/yesJO4TFU1RQ5h9ztLddredYksOfiz2mYRoQ1oeS6zW6UtUQZIx6vZ8j9X
         jbbP+YLZ6LH+bOppdPhj6gkvz/rwXV70RVb3XPf1xboOuVhsk9tO+NuoMltK2UA/SbFG
         nAMxozpliyUgk52LdjNiL88e0oOKfHj7RpiFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tu47D6rgPK5Ch8hxGqsY0MMWLz7AproMEYVk2VvxMPs=;
        b=Q5eBYuQFmF2ACODRjBuWkgi21WEnaAiAzYIn4XkzXcloGfNsA114m2oKMJWRdABN6l
         uKa1Q1oH7zxIFJs46kRlmiSctcpOXSGOt0r24RHKGjre882Wo9vNxa7Rxnf+LY1Tc2R1
         7g2qA0SBScO0ZVLiXzomvyCXmocrwazec6w0nMkzzASDVwGBOWm9rhi2lFeenvTAXjSy
         jGkgwNf+uY7ZDwY9EbCf+2HdQJ3/XNbUI4Eqbs+rFv69gTK7jJLaaqyEaE7z6Ue1f1f3
         2hrDsCEZ+prX3YjC+YRzHqJeV8a02YXcQCtG2K1ABVl/k0l2nzvPtrlx9x90Q9gYiPDr
         OUHQ==
X-Gm-Message-State: AOAM531eWIX0oHC1NpvlSTiPD7WpoiA6xIx5P6MUd23SzAslpaH+AW0y
        dPCJ/cQUN11T0NBw4xeAFfs6Aw==
X-Google-Smtp-Source: ABdhPJzHdO3QsiAw55RaPADUjVlYqPpYSvv3fWD/LgR5d7oWm8tyNEnhAp91AnxAxuDkMobs4hIebw==
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr4820861qtw.43.1616622033304;
        Wed, 24 Mar 2021 14:40:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:32 -0700 (PDT)
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
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: [PATCH resend 4/8] kselftest: Add test for core sched prctl interface
Date:   Wed, 24 Mar 2021 17:40:16 -0400
Message-Id: <20210324214020.34142-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>

Provides a selftest and examples of using the interface.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 tools/testing/selftests/sched/.gitignore      |   1 +
 tools/testing/selftests/sched/Makefile        |  14 +
 tools/testing/selftests/sched/config          |   1 +
 tools/testing/selftests/sched/cs_prctl_test.c | 370 ++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c

diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
new file mode 100644
index 000000000000..6996d4654d92
--- /dev/null
+++ b/tools/testing/selftests/sched/.gitignore
@@ -0,0 +1 @@
+cs_prctl_test
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
new file mode 100644
index 000000000000..10c72f14fea9
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
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
new file mode 100644
index 000000000000..e8b09aa7c0c4
--- /dev/null
+++ b/tools/testing/selftests/sched/config
@@ -0,0 +1 @@
+CONFIG_SCHED_DEBUG=y
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
new file mode 100644
index 000000000000..03581e180e31
--- /dev/null
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -0,0 +1,370 @@
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
+#define PR_SCHED_CORE_SHARE		60
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
-- 
2.31.0.291.g576ba9dcdaf-goog

