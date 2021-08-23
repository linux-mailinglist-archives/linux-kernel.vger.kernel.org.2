Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C43F43E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 05:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhHWDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWDaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:30:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB375C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:29:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r21so12710973qtw.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1SrQEEOFZMMo/eSl4drqliVt9Ow7U7huOQNUrdxIyA=;
        b=hZh0WKAn6o3Dl8dKAE86hkn9uIZvBGMt+GxXtf4SIxTVMH233cF8j9RDq4sjMcgNtc
         bjudzp56A2bzG0WnaB8EQLTMroOAcKgwS0ZpB/nfDEP+0bOIKqKk8kHCg2pEEnJej2Xz
         tnZtcupOJFL3k8yJJZ9HFH/aj+5apt5FcPzYVCdRBImhCmfe/KSn0Nqs2zLZZ+LVZCLu
         8s3X6OLQBu8S7SG2bCupe2lz3Scu5+0NFdyS+N8TdFoqmiZw4rNw6xr1Vn5P/s2i2naZ
         NEx7mzjEHvKd/56SpDwHH7BxOSk0UeXCb7fynoaWpCcz4u2fzJ/YsLFhy0fdzJMA9lf2
         NF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1SrQEEOFZMMo/eSl4drqliVt9Ow7U7huOQNUrdxIyA=;
        b=pnpoikm3W6IICD4CwChhYuMwj+vBQ5DtQ8J6knHJBxun1AnO0QyoeItekSdU4hAVwY
         a2TMYnwvTkmgEuY7Vj2quqlwNyTrbNamEpail09M3QZV0TpMpFkLGgUoKfPlPCMD1YV1
         t9mlim7LWycOFNul21vZwly/qg3JQzxkqjLPAToht0m4FMI90VlPxVx9qZvD5t7j1GTl
         Gp9x+OxcWlWOVMcKfwOgns/0RnER+owzPV3uAN3l+CGlBVn59XJoSG0kMalLFpnc2bLj
         /MGnxTRJ3CJ1AbPOv41lkIYrixhK2wqYU2ZU0b2whBSLIU78B3qEdZK51O8lpA0fw+XT
         jbWg==
X-Gm-Message-State: AOAM533TaKqxrChOm2+kG5aB8G5ps3ppFSh48SmZeKy28XiEAqK1ebql
        kCDMBJWqcOwwPo7m/F+LO02HdEM7L+M=
X-Google-Smtp-Source: ABdhPJwLqRB6rKXsF89O0Te1xXPDgEtI/r+jusgE7TJcAS5K0c9ysLMQWh57G0GMj4zVsXrmNry9TQ==
X-Received: by 2002:a05:622a:650:: with SMTP id a16mr7056327qtb.157.1629689357968;
        Sun, 22 Aug 2021 20:29:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q11sm7613889qkm.56.2021.08.22.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 20:29:17 -0700 (PDT)
From:   Ran Xiaokai <cgel.zte@gmail.com>
X-Google-Original-From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
To:     christian.brauner@ubuntu.com
Cc:     cgel.zte@gmail.com, dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: [PATCH] tests: add mqueue sysctl tests for user namespace
Date:   Sun, 22 Aug 2021 20:29:09 -0700
Message-Id: <20210823032909.45736-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803140133.vksebmgqhlbqipla@wittgenstein>
References: <20210803140133.vksebmgqhlbqipla@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when a ipc namespace is created in a user namespace, the mqueue sysctl
files should be writalbe to the owner of the user namespace. Even the
owner is not a global privileged user.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/mqueue_sysctl/Makefile     |   7 +
 tools/testing/selftests/mqueue_sysctl/config       |   2 +
 .../selftests/mqueue_sysctl/mq_sysctl_test.c       | 172 +++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/mqueue_sysctl/Makefile
 create mode 100644 tools/testing/selftests/mqueue_sysctl/config
 create mode 100644 tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc3299a..2031591 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,6 +36,7 @@ TARGETS += mincore
 TARGETS += mount
 TARGETS += mount_setattr
 TARGETS += mqueue
+TARGETS += mqueue_sysctl
 TARGETS += nci
 TARGETS += net
 TARGETS += net/forwarding
diff --git a/tools/testing/selftests/mqueue_sysctl/Makefile b/tools/testing/selftests/mqueue_sysctl/Makefile
new file mode 100644
index 0000000..44b6633
--- /dev/null
+++ b/tools/testing/selftests/mqueue_sysctl/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -O2
+LDLIBS = -lrt
+
+TEST_GEN_PROGS := mq_sysctl_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mqueue_sysctl/config b/tools/testing/selftests/mqueue_sysctl/config
new file mode 100644
index 0000000..68b2794
--- /dev/null
+++ b/tools/testing/selftests/mqueue_sysctl/config
@@ -0,0 +1,2 @@
+CONFIG_USER_NS=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
\ No newline at end of file
diff --git a/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c b/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c
new file mode 100644
index 0000000..48023d5
--- /dev/null
+++ b/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <mqueue.h>
+#include <sys/wait.h>
+#include <string.h>
+
+#include "../kselftest_harness.h"
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid = getuid();
+	gid = getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+				errno != ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+static int prepare_unpriv_mountns(void)
+{
+	if (create_and_enter_userns())
+		return -1;
+
+	if (unshare(CLONE_NEWNS))
+		return -1;
+
+	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
+		return -1;
+
+	if (unshare(CLONE_NEWIPC))
+		return -1;
+
+	return 0;
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+int get_mq_queues_max(void)
+{
+	int fd;
+	char buf[16];
+	int val = -1;
+
+	fd = open("/proc/sys/fs/mqueue/queues_max", O_RDONLY);
+	if (fd >= 0) {
+		if (read(fd, buf, sizeof(buf)) > 0)
+			val = atoi(buf);
+
+		close(fd);
+		return val;
+	}
+	return val;
+}
+
+TEST(mqueue_sysctl)
+{
+	pid_t pid;
+	int qmax1, qmax2;
+
+	chdir(getenv("HOME"));
+	/* read and stash the original sysctl value */
+	qmax1 = get_mq_queues_max();
+	ASSERT_GE(qmax1, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ASSERT_EQ(prepare_unpriv_mountns(), 0);
+
+		if (mkdir("./mqueue", 755) && errno != EEXIST)
+			SKIP(return, "mkdir /dev/mqueue failed");
+
+		ASSERT_EQ(mount("none", "./mqueue", "mqueue", MS_NOATIME, NULL), 0);
+
+		/* modify the sysctl value in new ipc namesapce */
+		ASSERT_EQ(write_file("/proc/sys/fs/mqueue/queues_max", "1", 1), 0);
+
+		ASSERT_GE(mq_open("/new_ns1",  O_RDWR | O_CREAT, 0644, NULL), 0);
+
+		/* mq_open() should fail as exceeding of queues_max */
+		ASSERT_EQ(mq_open("/new_ns2",  O_RDWR | O_CREAT, 0644, NULL), -1);
+
+		ASSERT_EQ(mq_unlink("/new_ns1"), 0);
+		ASSERT_EQ(umount("./mqueue"), 0);
+
+		exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	qmax2 = get_mq_queues_max();
+	ASSERT_EQ(qmax1, qmax2);
+}
+
+TEST_HARNESS_MAIN
-- 
2.15.2

