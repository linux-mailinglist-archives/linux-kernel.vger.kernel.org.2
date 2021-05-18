Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90580388068
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351748AbhERTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:21:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46277 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244803AbhERTVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:21:11 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRp4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:13:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRp4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365585;
        bh=p5RX+26hQKFn68BqWdhicYW1IYMibX3gPuHGaPr2Thc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6ZPYRLwguX5TB2iQLl1IvHWmGubcHaOxKdJn3ZCIkRQ2DI0870ZG/tQ7/uZ1g4Cu
         HRVUiYerD+MgaSGmDgXocWp9gke3vb67sotWZdevQ7ZE0fCRWco3ZbPa/wu8NGOvjD
         RzLvJUbfmujZfifc9vYqbSzwP3XeP0MfD29pS72ZJb0cPUdzrA4DJ1l+p2XYJA+IEF
         lPKPAEzgWrC5MIB+G8lRx/enYqlsykVBDBcKVFLEbYRySaFljOxUn8QrulwyJRiT6y
         cOTimu2T5VwctSirjLorzPi3VQofse3Hx1SMpKAmpqZKaPibNyt4EUG07Z58ArOFfJ
         naMUitf8fbusg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/6] x86/syscall: add tests under ptrace to syscall_numbering.c
Date:   Tue, 18 May 2021 12:13:00 -0700
Message-Id: <20210518191303.4135296-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add tests running under ptrace for syscall_numbering_64. ptrace
stopping on syscall entry and possibly modifying the syscall number
(regs.orig_rax) or the default return value (regs.rax) can have
different results that the normal system call path.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 .../testing/selftests/x86/syscall_numbering.c | 244 +++++++++++++++---
 1 file changed, 212 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 03915cd48cfc..ef618f5ffb3b 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -16,6 +16,13 @@
 #include <string.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <signal.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+
+#include <linux/ptrace.h>
 
 /* Common system call numbers */
 #define SYS_READ	  0
@@ -32,13 +39,44 @@
 
 #define X32_BIT 0x40000000
 
-static unsigned int nerr = 0;	/* Cumulative error count */
 static int nullfd = -1;		/* File descriptor for /dev/null */
-static int indent = 0;
+static bool with_x32;		/* x32 supported on this kernel? */
+
+enum ptrace_pass {
+	PTP_NOTHING,
+	PTP_GETREGS,
+	PTP_WRITEBACK,
+	PTP_FUZZRET,
+	PTP_FUZZHIGH,
+	PTP_INTNUM,
+	PTP_DONE
+};
+
+static const char * const ptrace_pass_name[] =
+{
+	[PTP_NOTHING]	= "just stop, no data read",
+	[PTP_GETREGS]	= "only getregs",
+	[PTP_WRITEBACK]	= "getregs, unmodified setregs",
+	[PTP_FUZZRET]	= "modifying the default return",
+	[PTP_FUZZHIGH]	= "clobbering the top 32 bits",
+	[PTP_INTNUM]	= "sign-extending the syscall number",
+};
+
+/*
+ * Shared memory block between tracer and test
+ */
+struct shared {
+	unsigned int nerr;	/* Total error count */
+	unsigned int indent;	/* Message indentation level */
+	enum ptrace_pass ptrace_pass;
+	bool probing_syscall;	/* In probe_syscall() */
+};
+static volatile struct shared *sh;
 
 static inline unsigned int offset(void)
 {
-	return 8+indent*4;
+	unsigned int level = sh ? sh->indent : 0;
+	return 8+level*4;
 }
 
 #define msg(lvl, fmt, ...) printf("%-*s" fmt, offset(), "[" #lvl "]", \
@@ -48,19 +86,22 @@ static inline unsigned int offset(void)
 #define info(fmt, ...) msg(INFO, fmt, ## __VA_ARGS__)
 #define ok(fmt, ...)   msg(OK,   fmt, ## __VA_ARGS__)
 
-#define fail(fmt, ...)					\
-	do {						\
-		msg(FAIL, fmt, ## __VA_ARGS__);		\
-		nerr++;					\
-	} while (0)
+#define fail(fmt, ...)                                 \
+       do {                                            \
+               msg(FAIL, fmt, ## __VA_ARGS__);         \
+               sh->nerr++;                             \
+       } while (0)
+
+#define crit(fmt, ...)				       \
+       do {                                            \
+               sh->indent = 0;                         \
+               msg(FAIL, fmt, ## __VA_ARGS__);         \
+               msg(SKIP, "Unable to run test\n");      \
+               exit(71); /* EX_OSERR */                \
+       } while (0)
 
-#define crit(fmt, ...)					\
-	do {						\
-		indent = 0;				\
-		msg(FAIL, fmt, ## __VA_ARGS__);		\
-		msg(SKIP, "Unable to run test\n");	\
-		exit(71); /* EX_OSERR */		\
-	} while (0)
+/* Sentinel for ptrace-modified return value */
+#define MODIFIED_BY_PTRACE	-9999
 
 /*
  * Directly invokes the given syscall with nullfd as the first argument
@@ -68,7 +109,7 @@ static inline unsigned int offset(void)
  * end up intercepting some system calls for some reason, or modify
  * the system call number itself.
  */
-static inline long long probe_syscall(int msb, int lsb)
+static long long probe_syscall(int msb, int lsb)
 {
 	register long long arg1 asm("rdi") = nullfd;
 	register long long arg2 asm("rsi") = 0;
@@ -79,11 +120,21 @@ static inline long long probe_syscall(int msb, int lsb)
 	long long nr = ((long long)msb << 32) | (unsigned int)lsb;
 	long long ret;
 
+	/*
+	 * We pass in an extra copy of the extended system call number
+	 * in %rbx, so we can examine it from the ptrace handler without
+	 * worrying about it being possibly modified. This is to test
+	 * the validity of struct user regs.orig_rax a.k.a.
+	 * struct pt_regs.orig_ax.
+	 */
+	sh->probing_syscall = true;
 	asm volatile("syscall"
 		     : "=a" (ret)
-		     : "a" (nr), "r" (arg1), "r" (arg2), "r" (arg3),
+		     : "a" (nr), "b" (nr),
+		       "r" (arg1), "r" (arg2), "r" (arg3),
 		       "r" (arg4), "r" (arg5), "r" (arg6)
 		     : "rcx", "r11", "memory", "cc");
+	sh->probing_syscall = false;
 
 	return ret;
 }
@@ -118,9 +169,9 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 {
 	unsigned int err = 0;
 
-	indent++;
+	sh->indent++;
 	if (start != end)
-		indent++;
+		sh->indent++;
 
 	for (int nr = start; nr <= end; nr++) {
 		long long ret = probe_syscall(msb, nr);
@@ -134,20 +185,19 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 	}
 
 	if (start != end)
-		indent--;
+		sh->indent--;
 
 	if (err) {
-		nerr += err;
 		if (start != end)
 			fail("%s had %u failure%s\n",
-			       syscall_str(msb, start, end),
-			       err, err == 1 ? "s" : "");
+			     syscall_str(msb, start, end),
+			     err, err == 1 ? "s" : "");
 	} else {
 		ok("%s returned %s as expected\n",
 		   syscall_str(msb, start, end), expect_str);
 	}
 
-	indent--;
+	sh->indent--;
 
 	return err;
 }
@@ -174,12 +224,11 @@ static bool test_x32(void)
 {
 	long long ret;
 	pid_t mypid = getpid();
-	bool with_x32;
 
 	run("Checking for x32 by calling x32 getpid()\n");
 	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
 
-	indent++;
+	sh->indent++;
 	if (ret == mypid) {
 		info("x32 is supported\n");
 		with_x32 = true;
@@ -187,15 +236,17 @@ static bool test_x32(void)
 		info("x32 is not supported\n");
 		with_x32 = false;
 	} else {
-		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
+		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, (long long)mypid);
 		with_x32 = false;
 	}
-	indent--;
+	sh->indent--;
 	return with_x32;
 }
 
 static void test_syscalls_common(int msb)
 {
+	enum ptrace_pass pass = sh->ptrace_pass;
+
 	run("Checking some common syscalls as 64 bit\n");
 	check_zero(msb, SYS_READ);
 	check_zero(msb, SYS_WRITE);
@@ -205,7 +256,11 @@ static void test_syscalls_common(int msb)
 	check_zero(msb, X64_WRITEV);
 
 	run("Checking out of range system calls\n");
-	check_for(msb, -64, -1, -ENOSYS);
+	check_for(msb, -64, -2, -ENOSYS);
+	if (pass >= PTP_FUZZRET)
+		check_for(msb, -1, -1, MODIFIED_BY_PTRACE);
+	else
+		check_for(msb, -1, -1, -ENOSYS);
 	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
 	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
 	check_for(msb, INT_MAX-64, INT_MAX-1, -ENOSYS);
@@ -248,7 +303,8 @@ static void test_syscall_numbering(void)
 		0, 1, -1, X32_BIT-1, X32_BIT, X32_BIT-1, -X32_BIT, INT_MAX,
 		INT_MIN, INT_MIN+1
 	};
-	bool with_x32 = test_x32();
+
+	sh->indent++;
 
 	/*
 	 * The MSB is supposed to be ignored, so we loop over a few
@@ -259,7 +315,7 @@ static void test_syscall_numbering(void)
 		run("Checking system calls with msb = %d (0x%x)\n",
 		    msb, msb);
 
-		indent++;
+		sh->indent++;
 
 		test_syscalls_common(msb);
 		if (with_x32)
@@ -267,12 +323,119 @@ static void test_syscall_numbering(void)
 		else
 			test_syscalls_without_x32(msb);
 
-		indent--;
+		sh->indent--;
+	}
+
+	sh->indent--;
+}
+
+static void syscall_numbering_tracee(void)
+{
+	enum ptrace_pass pass;
+
+	if (ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+		crit("Failed to request tracing\n");
+		return;
+	}
+	raise(SIGSTOP);
+
+	for (sh->ptrace_pass = pass = PTP_NOTHING; pass < PTP_DONE;
+	     sh->ptrace_pass = ++pass) {
+		run("Running tests under ptrace: %s\n", ptrace_pass_name[pass]);
+		test_syscall_numbering();
+	}
+}
+
+static void mess_with_syscall(pid_t testpid, enum ptrace_pass pass)
+{
+	struct user_regs_struct regs;
+
+	sh->probing_syscall = false; /* Do this on entry only */
+
+	/* For these, don't even getregs */
+	if (pass == PTP_NOTHING || pass == PTP_DONE)
+		return;
+
+	ptrace(PTRACE_GETREGS, testpid, NULL, &regs);
+
+	if (regs.orig_rax != regs.rbx) {
+		fail("orig_rax %#llx doesn't match syscall number %#llx\n",
+		     (unsigned long long)regs.orig_rax,
+		     (unsigned long long)regs.rbx);
+	}
+
+	switch (pass) {
+	case PTP_GETREGS:
+		/* Just read, no writeback */
+		return;
+	case PTP_WRITEBACK:
+		/* Write back the same register state verbatim */
+		break;
+	case PTP_FUZZRET:
+		regs.rax = MODIFIED_BY_PTRACE;
+		break;
+	case PTP_FUZZHIGH:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = regs.orig_rax | 0xffffffff00000000ULL;
+		break;
+	case PTP_INTNUM:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = (int)regs.orig_rax;
+		break;
+	default:
+		crit("invalid ptrace_pass\n");
+		break;
+	}
+
+	ptrace(PTRACE_SETREGS, testpid, NULL, &regs);
+}
+
+static void syscall_numbering_tracer(pid_t testpid)
+{
+	int wstatus;
+
+	do {
+		pid_t wpid = waitpid(testpid, &wstatus, 0);
+		if (wpid < 0 && errno != EINTR)
+			break;
+		if (wpid != testpid)
+			continue;
+		if (!WIFSTOPPED(wstatus))
+			break;	/* Thread exited? */
+
+		if (sh->probing_syscall && WSTOPSIG(wstatus) == SIGTRAP)
+			mess_with_syscall(testpid, sh->ptrace_pass);
+	} while (sh->ptrace_pass != PTP_DONE &&
+		 !ptrace(PTRACE_SYSCALL, testpid, NULL, NULL));
+
+	ptrace(PTRACE_DETACH, testpid, NULL, NULL);
+
+	/* Wait for the child process to terminate */
+	while (waitpid(testpid, &wstatus, 0) != testpid || !WIFEXITED(wstatus))
+		/* wait some more */;
+}
+
+static void test_traced_syscall_numbering(void)
+{
+	pid_t testpid;
+
+	/* Launch the test thread; this thread continues as the tracer thread */
+	testpid = fork();
+
+	if (testpid < 0) {
+		crit("Unable to launch tracer process\n");
+	} else if (testpid == 0) {
+		syscall_numbering_tracee();
+		_exit(0);
+	} else {
+		syscall_numbering_tracer(testpid);
 	}
 }
 
 int main(void)
 {
+	unsigned int nerr;
+
 	/*
 	 * It is quite likely to get a segfault on a failure, so make
 	 * sure the message gets out by setting stdout to nonbuffered.
@@ -287,7 +450,24 @@ int main(void)
 		crit("Unable to open /dev/null: %s\n", strerror(errno));
 	}
 
+	/*
+	 * Set up a block of shared memory...
+	 */
+	sh = mmap(NULL, sysconf(_SC_PAGE_SIZE), PROT_READ|PROT_WRITE,
+		  MAP_ANONYMOUS|MAP_SHARED, 0, 0);
+	if (sh == MAP_FAILED) {
+		crit("Unable to allocated shared memory block: %s\n",
+		     strerror(errno));
+	}
+
+	with_x32 = test_x32();
+
+	run("Running tests without ptrace...\n");
 	test_syscall_numbering();
+
+	test_traced_syscall_numbering();
+
+	nerr = sh->nerr;
 	if (!nerr) {
 		ok("All system calls succeeded or failed as expected\n");
 		return 0;
-- 
2.31.1

