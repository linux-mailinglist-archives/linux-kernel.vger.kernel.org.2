Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19183483E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhCXVlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhCXVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01941C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f12so234250qtq.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gst9o8UtkgmMkXEVXAARecyVmyzz4x6sAx6aAzcWaPo=;
        b=HcVvtdRZE2eY2k7uA5+vpmbHREU1dHGTnsBiZAOsLMMqJoXXphGi321c+rLpDV3aDE
         5e9bfWJMt8pooeYQhOIHDWKDeP99PJudjtimeDsc0Aod9lPOnZ+JjI8qbfucEosnpPsd
         beTDE2cCpsrjzmXoGoOJT2tyM9Dx3Gkxbs3bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gst9o8UtkgmMkXEVXAARecyVmyzz4x6sAx6aAzcWaPo=;
        b=Ap9Nj++3Q+WJ7xekfPkSpK2GN4gKH3r4WGwsq1I3qTkVNrlpY6mAK6cpHWLKqyHJSN
         8X/Svh2af7g+GPHYRQLvPkl7HlaCB2jjTv1gQ6blphnTVDsEKjdzoGnZVYfmhkkBJeYk
         dMK0g9PSPOSL1kG6kK/mGS2YvI5uDeUkU5TePaRf9oeSm/mzIQYw9+C3FPLY7VVHFPqm
         FGqWX5By+IPOQAeE456anFDvKHDUyC5yRpYeE1qOHN6o/KNAuV4eA5WABn7azp3abR3R
         j0xkMXXbmzKz5Y+XIjXv1eja0g5V7bXVTGgRetNQP38hRjvTKmsHNI5PRg1CyY59csDf
         5T1w==
X-Gm-Message-State: AOAM531aJ028NJNQhmTSPK01a838vtsrs5LOW49Z9JHxLSjXtY213131
        Z1tTAuG5QC3dWJHSiJLiwYTn3g==
X-Google-Smtp-Source: ABdhPJwREJRXYD8tqrDeRfDiDujgKYVRJkk6WX0V+RIied4jX07Wyodn4i3AOpuBDuTIkC+rjUmM8A==
X-Received: by 2002:ac8:538f:: with SMTP id x15mr4917350qtp.47.1616622036064;
        Wed, 24 Mar 2021 14:40:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:35 -0700 (PDT)
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
Subject: [PATCH resend 6/8] kselftest: Add tests for core-sched interface
Date:   Wed, 24 Mar 2021 17:40:18 -0400
Message-Id: <20210324214020.34142-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
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
Signed-off-by: chris hyser <chris.hyser@oracle.com>
---
 tools/testing/selftests/sched/.gitignore      |   1 +
 tools/testing/selftests/sched/Makefile        |   4 +-
 .../testing/selftests/sched/test_coresched.c  | 812 ++++++++++++++++++
 3 files changed, 815 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched/test_coresched.c

diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
index 6996d4654d92..a4b4a1cdcd93 100644
--- a/tools/testing/selftests/sched/.gitignore
+++ b/tools/testing/selftests/sched/.gitignore
@@ -1 +1,2 @@
 cs_prctl_test
+test_coresched
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 10c72f14fea9..830766e12bed 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -8,7 +8,7 @@ CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
-TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+TEST_GEN_FILES := test_coresched cs_prctl_test
+TEST_PROGS := test_coresched cs_prctl_test
 
 include ../lib.mk
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
2.31.0.291.g576ba9dcdaf-goog

