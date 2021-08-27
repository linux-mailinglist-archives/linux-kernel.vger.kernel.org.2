Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634203F97AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbhH0Jv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhH0JvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:51:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:50:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y144so6550755qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sM0dn2UbOZ7v3n/GcQPeJKbcA/kcNqjIw3XvmYtI+kI=;
        b=WgeS0fhHWOVcZqsh3XYDOzpq7iZURszFVNIOse9D6DCblTICBe3LqVxBw3dwK/hUlT
         VxzKYWwgTEiRA8HedTKS3mCDMNU2//mr7BT6Fairasqixg+PWJkT7v5xgZeRBL64akVu
         vApEquNDTrzwsUDw94OCRbJN+3CBFIcYErZEEBULFe8Mv+0XBf+7aHIN3IyoSWbSW5MR
         Fe/GEsu5apRcXRjeKFPivqmV0jPKHs4dTZB3y3j3xXSC2Ia1+FeqUdK7eZpjTeXyOahN
         WOHHfqdKgPEBibMWRkyY2uwqDuaYJ22OwR7wKC+j2R7KiWkAozAByYpfWHGCsLSwnc+A
         PXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sM0dn2UbOZ7v3n/GcQPeJKbcA/kcNqjIw3XvmYtI+kI=;
        b=dOliqsG1pOWa12ACdZmVLfThzn/SAlmUw9dEqlj1rd0+UrNVKE8Qnpkp3nHT6dkVlV
         Irnhje62haCfqJD7N9TvZYl3zUtxEzHd9A/DDwcYa0rjiZr3eoh2toTCvuVYf27B6nvV
         tMUrgdX4ads5pbXVjifwQ9CBNh9oIlHG7rWpCQdkLqJanlxCBzfhTI0NSbT+7mNFmCNS
         UFiax+3vIlKKjypbZaGCtm9nOxQMYOyEwwbd8eCa7+QzmQo7ZXDnJwT/J6mm1ByhRvvI
         n2Dpi+gmF7veAgD3OvvC2pejJ4y2zritq/fWDiOCybf5kd8RLMMDzsASqlJwJTo9mjXp
         3zUw==
X-Gm-Message-State: AOAM531yIBZXYO49ulDxjQL0yVu+m+KqOmfgBvBMM0BQvb2SpFUY3Fe4
        FPc1t3tHF4Cnc1gX0T/3M3E=
X-Google-Smtp-Source: ABdhPJxPXy5gmZM2rP0lin+mEJ5Jjm/KUWdlKrFStAQzc8Hka5fRlGfBPIOj3lCD0IxtGMuUuOhlng==
X-Received: by 2002:a37:e14:: with SMTP id 20mr8164508qko.229.1630057835190;
        Fri, 27 Aug 2021 02:50:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h12sm3372673qth.1.2021.08.27.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:50:34 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <ran.xiaokai@zte.com.cn>
To:     christian.brauner@ubuntu.com, dbueso@suse.de
Cc:     cgel.zte@gmail.com, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: [PATCH V2] tests: add mqueue sysctl tests for user namespace
Date:   Fri, 27 Aug 2021 02:50:27 -0700
Message-Id: <20210827095027.5662-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

when a ipc namespace is created in a user namespace, the mqueue sysctl
files should be writalbe to the owner of the user namespace. Even the
owner is not a global privileged user.

v2
  - add .gitignore change
  - move this test codes to the existing mqueue directory
  - rename test file name
  - use mkdtemp() creating mountpoint
v1
  - initial patch

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 tools/testing/selftests/mqueue/.gitignore        |   1 +
 tools/testing/selftests/mqueue/Makefile          |   2 +-
 tools/testing/selftests/mqueue/mq_sysctl_tests.c | 175 +++++++++++++++++++++++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mqueue/mq_sysctl_tests.c

diff --git a/tools/testing/selftests/mqueue/.gitignore b/tools/testing/selftests/mqueue/.gitignore
index 72ad8ca..226fe58 100644
--- a/tools/testing/selftests/mqueue/.gitignore
+++ b/tools/testing/selftests/mqueue/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mq_open_tests
 mq_perf_tests
+mq_sysctl_tests
diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
index 8a58055..31becad 100644
--- a/tools/testing/selftests/mqueue/Makefile
+++ b/tools/testing/selftests/mqueue/Makefile
@@ -2,6 +2,6 @@
 CFLAGS += -O2
 LDLIBS = -lrt -lpthread -lpopt
 
-TEST_GEN_PROGS := mq_open_tests mq_perf_tests
+TEST_GEN_PROGS := mq_open_tests mq_perf_tests mq_sysctl_tests
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mqueue/mq_sysctl_tests.c b/tools/testing/selftests/mqueue/mq_sysctl_tests.c
new file mode 100644
index 0000000..931a915
--- /dev/null
+++ b/tools/testing/selftests/mqueue/mq_sysctl_tests.c
@@ -0,0 +1,175 @@
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
+static int get_mq_queues_max(void)
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
+	int dirfd;
+	char tmpdir[] = "/mqueue_sysctl_XXXXXX";
+
+	if (!mkdtemp(tmpdir))
+		SKIP(return, "create temp dir failed");
+
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
+		ASSERT_EQ(mount("none", tmpdir, "mqueue", MS_NOATIME, NULL), 0);
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
+		ASSERT_EQ(umount(tmpdir), 0);
+
+		exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	qmax2 = get_mq_queues_max();
+	ASSERT_EQ(qmax1, qmax2);
+
+	remove(tmpdir);
+}
+
+TEST_HARNESS_MAIN
-- 
2.15.2

