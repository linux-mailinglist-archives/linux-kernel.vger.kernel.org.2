Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4836806E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhDVM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhDVM2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9561661574;
        Thu, 22 Apr 2021 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094477;
        bh=fP29DG3NBsXSw/mOMG+IGXDEiWXAJ3rxrytILV+WtVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hK3t3bW+/iIxipJnxe9I6TLE22NYRford0WwCIAeQGh1SjTM8qYc+EbGcJJjDe8Oz
         5Jkenhy/Sqg9Mpj9JGoUa4s73zlFtUwDk1ustshaC0qB9GGJefRHFbJ1dTTVKC9zff
         zEQHWVjSz7d1cqvyIMF+3ede0vYUPzfzw933N+uyLDy5yIZ73uh49j8AaKc9Ynu2lS
         4Sa4nbc0zwPwtQWlpFlRwIDbGluohwObqZq8oKpqy2mnp07OdHJMEr/KyNHD2raNso
         YtMjaVSWXyeC3354rpBhOgk36g0SCSKiCZ8l/XlwnowxzAEXnFztZAyil1SI/MwYxF
         RnDJqGW7vPwOg==
From:   legion@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v11 8/9] kselftests: Add test to check for rlimit changes in different user namespaces
Date:   Thu, 22 Apr 2021 14:27:15 +0200
Message-Id: <28cafdcdd4abd8494b34a27f1970b666b30de8bf.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

The testcase runs few instances of the program with RLIMIT_NPROC=1 from
user uid=60000, in different user namespaces.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/rlimits/.gitignore    |   2 +
 tools/testing/selftests/rlimits/Makefile      |   6 +
 tools/testing/selftests/rlimits/config        |   1 +
 .../selftests/rlimits/rlimits-per-userns.c    | 161 ++++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/rlimits/.gitignore
 create mode 100644 tools/testing/selftests/rlimits/Makefile
 create mode 100644 tools/testing/selftests/rlimits/config
 create mode 100644 tools/testing/selftests/rlimits/rlimits-per-userns.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6c575cf34a71..a4ea1481bd9a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -48,6 +48,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += seccomp
diff --git a/tools/testing/selftests/rlimits/.gitignore b/tools/testing/selftests/rlimits/.gitignore
new file mode 100644
index 000000000000..091021f255b3
--- /dev/null
+++ b/tools/testing/selftests/rlimits/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+rlimits-per-userns
diff --git a/tools/testing/selftests/rlimits/Makefile b/tools/testing/selftests/rlimits/Makefile
new file mode 100644
index 000000000000..03aadb406212
--- /dev/null
+++ b/tools/testing/selftests/rlimits/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g
+TEST_GEN_PROGS := rlimits-per-userns
+
+include ../lib.mk
diff --git a/tools/testing/selftests/rlimits/config b/tools/testing/selftests/rlimits/config
new file mode 100644
index 000000000000..416bd53ce982
--- /dev/null
+++ b/tools/testing/selftests/rlimits/config
@@ -0,0 +1 @@
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
new file mode 100644
index 000000000000..26dc949e93ea
--- /dev/null
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
+ */
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include <signal.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <err.h>
+
+#define NR_CHILDS 2
+
+static char *service_prog;
+static uid_t user   = 60000;
+static uid_t group  = 60000;
+
+static void setrlimit_nproc(rlim_t n)
+{
+	pid_t pid = getpid();
+	struct rlimit limit = {
+		.rlim_cur = n,
+		.rlim_max = n
+	};
+
+	warnx("(pid=%d): Setting RLIMIT_NPROC=%ld", pid, n);
+
+	if (setrlimit(RLIMIT_NPROC, &limit) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC)", pid);
+}
+
+static pid_t fork_child(void)
+{
+	pid_t pid = fork();
+
+	if (pid < 0)
+		err(EXIT_FAILURE, "fork");
+
+	if (pid > 0)
+		return pid;
+
+	pid = getpid();
+
+	warnx("(pid=%d): New process starting ...", pid);
+
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL) < 0)
+		err(EXIT_FAILURE, "(pid=%d): prctl(PR_SET_PDEATHSIG)", pid);
+
+	signal(SIGUSR1, SIG_DFL);
+
+	warnx("(pid=%d): Changing to uid=%d, gid=%d", pid, user, group);
+
+	if (setgid(group) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setgid(%d)", pid, group);
+	if (setuid(user) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setuid(%d)", pid, user);
+
+	warnx("(pid=%d): Service running ...", pid);
+
+	warnx("(pid=%d): Unshare user namespace", pid);
+	if (unshare(CLONE_NEWUSER) < 0)
+		err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
+
+	char *const argv[] = { "service", NULL };
+	char *const envp[] = { "I_AM_SERVICE=1", NULL };
+
+	warnx("(pid=%d): Executing real service ...", pid);
+
+	execve(service_prog, argv, envp);
+	err(EXIT_FAILURE, "(pid=%d): execve", pid);
+}
+
+int main(int argc, char **argv)
+{
+	size_t i;
+	pid_t child[NR_CHILDS];
+	int wstatus[NR_CHILDS];
+	int childs = NR_CHILDS;
+	pid_t pid;
+
+	if (getenv("I_AM_SERVICE")) {
+		pause();
+		exit(EXIT_SUCCESS);
+	}
+
+	service_prog = argv[0];
+	pid = getpid();
+
+	warnx("(pid=%d) Starting testcase", pid);
+
+	/*
+	 * This rlimit is not a problem for root because it can be exceeded.
+	 */
+	setrlimit_nproc(1);
+
+	for (i = 0; i < NR_CHILDS; i++) {
+		child[i] = fork_child();
+		wstatus[i] = 0;
+		usleep(250000);
+	}
+
+	while (1) {
+		for (i = 0; i < NR_CHILDS; i++) {
+			if (child[i] <= 0)
+				continue;
+
+			errno = 0;
+			pid_t ret = waitpid(child[i], &wstatus[i], WNOHANG);
+
+			if (!ret || (!WIFEXITED(wstatus[i]) && !WIFSIGNALED(wstatus[i])))
+				continue;
+
+			if (ret < 0 && errno != ECHILD)
+				warn("(pid=%d): waitpid(%d)", pid, child[i]);
+
+			child[i] *= -1;
+			childs -= 1;
+		}
+
+		if (!childs)
+			break;
+
+		usleep(250000);
+
+		for (i = 0; i < NR_CHILDS; i++) {
+			if (child[i] <= 0)
+				continue;
+			kill(child[i], SIGUSR1);
+		}
+	}
+
+	for (i = 0; i < NR_CHILDS; i++) {
+		if (WIFEXITED(wstatus[i]))
+			warnx("(pid=%d): pid %d exited, status=%d",
+				pid, -child[i], WEXITSTATUS(wstatus[i]));
+		else if (WIFSIGNALED(wstatus[i]))
+			warnx("(pid=%d): pid %d killed by signal %d",
+				pid, -child[i], WTERMSIG(wstatus[i]));
+
+		if (WIFSIGNALED(wstatus[i]) && WTERMSIG(wstatus[i]) == SIGUSR1)
+			continue;
+
+		warnx("(pid=%d): Test failed", pid);
+		exit(EXIT_FAILURE);
+	}
+
+	warnx("(pid=%d): Test passed", pid);
+	exit(EXIT_SUCCESS);
+}
-- 
2.29.3

