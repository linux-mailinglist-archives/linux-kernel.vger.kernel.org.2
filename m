Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712F3452A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCVWxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCVWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:53:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C46C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso11293041pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIOBeYfsLRdlk6IE9Mox6wnpSlCp4ziKMxvOh3LQGV0=;
        b=f+gHS/k3aPWr0JJ8C4fAHd/OxMpzlfqzOtzSMSDqaUhVVmzLuW6gCh/jfK5pEBM28k
         PL9Fis9GwrhhAs98EaAvcVPY1EikAsiEiT3wGtDdfs4dhc81aQHXOw+oFDbM5otgMJG/
         dxeCzFyoKFZJdpVWVf4OpheSnOI1slZE9ZJEBdBZ4l/aeSmtU8Rh7Sv0EL2+obSXXepe
         C3f+S3ygbdikFbs0Ejzq2S+agnW3+sqcgmH8g9PYbA9E1o2c+oquk3OuqLVPcWU9QBff
         hcsz2Zv7JGBwNdnR6LEA3SOiWIjUFUZrt9G8lXP0aNJ6QSQG4YLtxMp4tVbGAxHiJLXb
         9eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIOBeYfsLRdlk6IE9Mox6wnpSlCp4ziKMxvOh3LQGV0=;
        b=JPAgyveUJyPz73ZZTuFE7oYLaB3PweKjJtrEZKnW3wmn0s0PY+uRe/AjMi7SPtaPdt
         5+3KiGaOibb7AVEedknWxSJc8FW5YhOSMttpRlwLMiq1akSvZz6tKgw0mgjZAUX26G66
         2wSc8rg/IN3o6J946ECe6vokK0T/q+R2PxZ/4rhtsU4OnqzcwNBBjCW+q5yg6VF1EZdZ
         e3aWjiha++mUNRnLh5iOSE1/3AiADBFjDSw9LG8GpSge3A0mej3iZHebqsnETbMGe3ly
         OCg/RHFA1Z94PFPezf9h9C4kRcmr71kRVt+7kVw5XJFgfqW4Psy9nX6JRkkMQZDwvVgY
         f2/A==
X-Gm-Message-State: AOAM532LRlxCH3vQB7LzuNXasBY+8ltLIyNwx8TbD6Q4cT13qQRZssA+
        H+Hu+z+lugKoq/jrRXHjZz0=
X-Google-Smtp-Source: ABdhPJxe/yfdkp/SdhyhsEJL6O/SCgA66U19AgdI04G5R9seC5UAN6x44Ebnsx4PQkM2Bgdl2U0usQ==
X-Received: by 2002:a17:90b:1082:: with SMTP id gj2mr1299519pjb.155.1616453599974;
        Mon, 22 Mar 2021 15:53:19 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id j13sm8878211pfn.103.2021.03.22.15.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:53:19 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 4/4] selftest/arm64/ptrace: add a test for orig_x7
Date:   Mon, 22 Mar 2021 15:50:53 -0700
Message-Id: <20210322225053.428615-5-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322225053.428615-1-avagin@gmail.com>
References: <20210322225053.428615-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In system calls, x7 is used to indicate whether a tracee has been
stopped on syscall-enter or syscall-exit and the origin value of x7 is
saved in orig_x7.

Test output:
 $ ./ptrace_syscall_test
 1..4
 ok 1 x7: 0
 ok 2 x7: 1
 ok 3 x7: 686920776f726c64
 ok 4 The child exited with code 0.
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/arm64/ptrace/Makefile |   2 +-
 .../arm64/ptrace/ptrace_syscall_test.c        | 158 ++++++++++++++++++
 2 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_test.c

diff --git a/tools/testing/selftests/arm64/ptrace/Makefile b/tools/testing/selftests/arm64/ptrace/Makefile
index 1bc10e2d2ac8..ea02c1a63806 100644
--- a/tools/testing/selftests/arm64/ptrace/Makefile
+++ b/tools/testing/selftests/arm64/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -g -I../../../../../usr/include/
-TEST_GEN_PROGS := ptrace_restart_syscall_test
+TEST_GEN_PROGS := ptrace_restart_syscall_test ptrace_syscall_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/ptrace/ptrace_syscall_test.c b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_test.c
new file mode 100644
index 000000000000..ad55b44ae9f5
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_test.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+
+#include "../../kselftest.h"
+#include "lib.h"
+
+#define X7_TEST_VAL 0x686920776f726c64UL
+
+static long test_syscall(long *x7)
+{
+	register long x0 __asm__("x0") = 0;
+	register long *x1 __asm__("x1") = x7;
+	register long x8 __asm__("x8") = 0x555;
+
+	__asm__ (
+		"ldr x7, [x1, 0]\n"
+		"svc 0\n"
+		"str x7, [x1, 0]\n"
+			   : "=r"(x0)
+			   : "r"(x0), "r"(x1), "r"(x8)
+			   :
+	);
+	return x0;
+}
+
+static int child(void)
+{
+	long  val = X7_TEST_VAL;
+
+	if (test_syscall(&val)) {
+		ksft_print_msg("The test syscall failed\n");
+		return 1;
+	}
+	if (val != X7_TEST_VAL) {
+		ksft_print_msg("Unexpected x7: %lx\n", val);
+		return 1;
+	}
+
+	if (test_syscall(&val)) {
+		ksft_print_msg("The test syscall failed\n");
+		return 1;
+	}
+	if (val != ~X7_TEST_VAL) {
+		ksft_print_msg("Unexpected x7: %lx\n", val);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
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
+
+	ksft_set_plan(4);
+
+	pid = fork();
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		_exit(child());
+	}
+	if (pid < 0)
+		return 1;
+
+	if (ptrace_and_wait(pid, PTRACE_ATTACH, SIGSTOP))
+		return 1;
+	/* skip SIGSTOP */
+	if (ptrace_and_wait(pid, PTRACE_CONT, SIGSTOP))
+		return 1;
+
+	/* Resume the child to the next system call. */
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGTRAP))
+		return 1;
+
+	/* Check that x7 is 0 on syscall-enter. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.orig_x7 != X7_TEST_VAL)
+		return pr_fail("Unexpected orig_x7: %lx", regs.orig_x7);
+	if (regs.r.regs[7] != 0)
+		return pr_fail("Unexpected x7: %lx", regs.r.regs[7]);
+	ksft_test_result_pass("x7: %llx\n", regs.r.regs[7]);
+
+	if (ptrace_and_wait(pid, PTRACE_SYSCALL, SIGTRAP))
+		return 1;
+
+	/* Check that x7 is 1 on syscall-exit. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.r.regs[7] != 1)
+		return pr_fail("Unexpected x7: %lx", regs.r.regs[7]);
+	ksft_test_result_pass("x7: %llx\n", regs.r.regs[7]);
+
+	/* Check that the child will not see a new value of x7. */
+	regs.r.regs[0] = 0;
+	regs.r.regs[7] = ~X7_TEST_VAL;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't set child registers");
+
+	/* Resume the child to the next system call. */
+	if (ptrace_and_wait(pid, PTRACE_SYSEMU, SIGTRAP))
+		return 1;
+
+	/* Check that orig_x7 contains the actual value of x7. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.orig_x7 != X7_TEST_VAL)
+		return pr_fail("Unexpected orig_x7: %lx", regs.orig_x7);
+	ksft_test_result_pass("x7: %llx\n", regs.orig_x7);
+
+	/* Check that the child will see a new value of x7. */
+	regs.r.regs[0] = 0;
+	regs.orig_x7 = ~X7_TEST_VAL;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't set child registers");
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

