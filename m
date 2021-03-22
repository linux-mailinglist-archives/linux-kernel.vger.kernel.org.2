Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34B3452A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCVWxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCVWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:53:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j25so12234807pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=972JgSIF2IIo8wEKlvKAl0BK+0XizAKsSmH5/nQePh4=;
        b=kyFRzjmyQNZ2Bjps4L5M0EhjRIv/RBgAPaxob3JGH3c9LC2wAXReZaM5iNFpVBAp+p
         oJM5qZQjZZQwFcR8eFRhltYD68lbnwWZPjn28HPgNI2OgK13kT77b9RMobozUskZL8MW
         41QvaM7ZoQUL+1lZpR1oJUqMhFDZWNFhAn5LCVnX5Sk6kiirqiUGjVTtwP3ncP5eXqM1
         RGiuniUiRDmJ3gzjoZ/SvDXMr7ezlJ5hrJ6qwZTa9J/1niNMtKNhVe+1My9NiKTvGl6g
         t/wBDHOpO97ENzhqOhJVJ8JmiVo3IT2drAG4lpt/YSbN9yEi7VJfmFuA+58ZSoTuDpmC
         F1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=972JgSIF2IIo8wEKlvKAl0BK+0XizAKsSmH5/nQePh4=;
        b=iTnpyJET7rig6K4AZnvP5pawmV3728dOXiL5fXzY6MHnIxdau20+YC4iuWhtsymOxz
         6tPcjl0fpR7GbyCwM6ITk1iOJ2QejHDek3P6FUBlMpCYGEFIBcyF1yjPwCwwcQ45Mb9h
         JID76o9XwJwfvwLYiTE7x3xh7GorRoW00zFBdUhv3S1ExAFFiHbubq+Ul9ngW0/jw/SQ
         NbohiPgJUwhYEoR0z4Aaxp0HgE1GCdnYugDSetJhvXisGItekWLYN1lFXirq+a9EiNDb
         IH4hcpj31LIovB6qXbjqkezKANp71h3z6QOhgZ//e44hnJmSL+RNeE2vnuoUhSM1gjjI
         mGGg==
X-Gm-Message-State: AOAM532YdthlbbZC9ZBRD5Hdy6JRKfJd4QFPuw7h6TsjqFbTz2VIEcU7
        kPuaA0cgRLS0L/ViSHUdVog=
X-Google-Smtp-Source: ABdhPJz52tT2nDR6QszbXNEnhRIexqy8hazMx7QWwYZkK74s9rdjv9EC4jYt7FLr0O944sg0Cr404w==
X-Received: by 2002:a17:903:1c3:b029:e6:a15:751f with SMTP id e3-20020a17090301c3b02900e60a15751fmr1888188plh.44.1616453598632;
        Mon, 22 Mar 2021 15:53:18 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id j13sm8878211pfn.103.2021.03.22.15.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:53:17 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 3/4] selftest/arm64/ptrace: add a test for orig_x0
Date:   Mon, 22 Mar 2021 15:50:52 -0700
Message-Id: <20210322225053.428615-4-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322225053.428615-1-avagin@gmail.com>
References: <20210322225053.428615-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test creates two processes where one traces another one.  The tracee
executes a system call, the tracer traps it, changes orig_x0, triggers a
signal and checks that the syscall is restarted with the setted
argument.

Test output:
 $ ./ptrace_restart_syscall_test
 1..3
 ok 1 orig_x0: 0x3
 ok 2 x0: 0x5
 ok 3 The child exited with code 0.
 # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 tools/testing/selftests/arm64/ptrace/lib.h    |  36 ++++++
 .../ptrace/ptrace_restart_syscall_test.c      | 122 ++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/lib.h
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_restart_syscall_test.c

diff --git a/tools/testing/selftests/arm64/ptrace/Makefile b/tools/testing/selftests/arm64/ptrace/Makefile
new file mode 100644
index 000000000000..1bc10e2d2ac8
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -g -I../../../../../usr/include/
+TEST_GEN_PROGS := ptrace_restart_syscall_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/ptrace/lib.h b/tools/testing/selftests/arm64/ptrace/lib.h
new file mode 100644
index 000000000000..14f4737188a3
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/lib.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __PTRACE_TEST_LOG_H
+#define __PTRACE_TEST_LOG_H
+
+#define pr_p(func, fmt, ...) func("%s:%d: " fmt ": %m", \
+				  __func__, __LINE__, ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);	\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt "\n", ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+static inline int ptrace_and_wait(pid_t pid, int cmd, int sig)
+{
+	int status;
+
+	/* Stop on syscall-exit. */
+	if (ptrace(cmd, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (!WIFSTOPPED(status) || WSTOPSIG(status) != sig)
+		return pr_err("Unexpected status: %x", status);
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/selftests/arm64/ptrace/ptrace_restart_syscall_test.c b/tools/testing/selftests/arm64/ptrace/ptrace_restart_syscall_test.c
new file mode 100644
index 000000000000..ce59657f41be
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/ptrace_restart_syscall_test.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/stat.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+
+#include "../../kselftest.h"
+#include "lib.h"
+
+static int child(int fd)
+{
+	char c;
+
+	if (read(fd, &c, 1) != 1)
+		return 1;
+
+	return 0;
+}
+
+int main(int argc, void **argv)
+{
+	union {
+		struct user_regs_struct r;
+		struct {
+			char __regs[272];
+			unsigned long long orig_x0;
+			unsigned long long orig_x7;
+		};
+	} regs = {};
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(regs),
+	};
+	int status;
+	pid_t pid;
+	int p[2], fdzero;
+
+	ksft_set_plan(3);
+
+	if (pipe(p))
+		return pr_perror("Can't create a pipe");
+	fdzero = open("/dev/zero", O_RDONLY);
+	if (fdzero < 0)
+		return pr_perror("Can't open /dev/zero");
+
+	pid = fork();
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		return child(p[0]);
+	}
+	if (pid < 0)
+		return 1;
+
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return pr_perror("Can't attach to the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	/* Skip SIGSTOP */
+	if (ptrace_and_wait(pid, PTRACE_CONT, SIGSTOP))
+		return 1;
+
+	/* Resume the child to the next system call. */
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGTRAP))
+		return 1;
+
+	/* Send a signal to interrupt the system call. */
+	kill(pid, SIGUSR1);
+
+	/* Stop on syscall-exit. */
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGTRAP))
+		return 1;
+
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.orig_x0 != p[0])
+		return pr_fail("Unexpected x0: 0x%lx", regs.r.regs[0]);
+	ksft_test_result_pass("orig_x0: 0x%llx\n", regs.orig_x0);
+
+	/* Change orig_x0 that will be x0 for the restarted system call. */
+	regs.orig_x0 = fdzero;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+
+	/* Trap the signal and skip it. */
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGUSR1))
+		return 1;
+
+	/* Trap the restarted system call. */
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGTRAP))
+		return 1;
+
+	/* Check that the syscall is started with the right first argument. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.r.regs[0] != fdzero)
+		return pr_fail("unexpected x0: %lx", regs.r.regs[0]);
+	ksft_test_result_pass("x0: 0x%llx\n", regs.r.regs[0]);
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (status != 0)
+		return pr_fail("Child exited with code %d.", status);
+
+	ksft_test_result_pass("The child exited with code 0.\n");
+	ksft_exit_pass();
+	return 0;
+}
+
-- 
2.29.2

