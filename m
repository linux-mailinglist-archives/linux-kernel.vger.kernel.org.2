Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E339F992
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhFHOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhFHOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09539C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:49:34 -0700 (PDT)
Message-Id: <20210608144346.234764986@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HSiE2O6KFBOpT6Kb4cZTjcrtM1/7rzim6CIxeVHRjB0=;
        b=XilAwJbBDLdGOkaw0ccIgkjxN2Pq/M8zI9Ka1FQJAK91FIvrBj0xnoaWQVSGAzRE3oE/te
        TR+i8SidshGUCtJkt46ta2LosEYgsMaeRqhxPutv36HwR/baXH3IKinzOJJykajApnPybJ
        J+Zk+LNLLIuOOxdFswQbbfbzylK7d0AgkGqyRGFAjZlb/vc4NkxMR3X9pDoCd+0rd/T6IN
        IxSF13uFf2Ih+U1B5rmEcBsBH0D0x4L206Twye+XSdRkbiT4COq6yZCDRqN3HDX9txZHqy
        UAHeWxfiTKHxZrxlozQB/yKpnjadDq59hPKWQHI/ar62GiVH4nuY6OmS4MZyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HSiE2O6KFBOpT6Kb4cZTjcrtM1/7rzim6CIxeVHRjB0=;
        b=lvPNriY+BZVROVo7IoirT3v2QFlzzEBbkbu3BDSguz4QPIs6Mt/sIZUtF68FqeQqnq38At
        orOLB6xcVwH4t0Bg==
Date:   Tue, 08 Jun 2021 16:36:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: [patch V3 6/6] selftests/x86: Test signal frame XSTATE header
 corruption handling
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This is very heavily based on some code from Thomas Gleixner.  On a system
without XSAVES, it triggers the WARN_ON():

    Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: main() -> main(void) - Borislav
---
 tools/testing/selftests/x86/Makefile                |    3 
 tools/testing/selftests/x86/corrupt_xstate_header.c |  114 ++++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/corrupt_xstate_header.c

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -17,7 +17,8 @@ TARGETS_C_BOTHBITS := single_step_syscal
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
+			corrupt_xstate_header
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
--- /dev/null
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Corrupt the XSTATE header in a signal frame
+ *
+ * Based on analysis and a test case from Thomas Gleixner.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include <signal.h>
+#include <err.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/wait.h>
+
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	asm volatile(
+		"cpuid;"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+static inline int xsave_enabled(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	eax = 0x1;
+	ecx = 0x0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Is CR4.OSXSAVE enabled ? */
+	return ecx & (1U << 27);
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sigusr1(int sig, siginfo_t *info, void *uc_void)
+{
+	ucontext_t *uc = uc_void;
+	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
+	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
+
+	printf("\tWreckage XSTATE header\n");
+	/* Wreckage the first reserved byte in the header */
+	*(xfeatures + 2) = 0xfffffff;
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *uc_void)
+{
+	printf("\tGot SIGSEGV\n");
+}
+
+int main(void)
+{
+	cpu_set_t set;
+
+	sethandler(SIGUSR1, sigusr1, 0);
+	sethandler(SIGSEGV, sigsegv, 0);
+
+	if (!xsave_enabled()) {
+		printf("[SKIP] CR4.OSXSAVE disabled.\n");
+		return 0;
+	}
+
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+
+	/*
+	 * Enforce that the child runs on the same CPU
+	 * which in turn forces a schedule.
+	 */
+	sched_setaffinity(getpid(), sizeof(set), &set);
+
+	printf("[RUN]\tSend ourselves a signal\n");
+	raise(SIGUSR1);
+
+	printf("[OK]\tBack from the signal.  Now schedule.\n");
+	pid_t child = fork();
+	if (child < 0)
+		err(1, "fork");
+	if (child == 0)
+		return 0;
+	if (child)
+		waitpid(child, NULL, 0);
+	printf("[OK]\tBack in the main thread.\n");
+
+	/*
+	 * We could try to confirm that extended state is still preserved
+	 * when we schedule.  For now, the only indication of failure is
+	 * a warning in the kernel logs.
+	 */
+
+	return 0;
+}

