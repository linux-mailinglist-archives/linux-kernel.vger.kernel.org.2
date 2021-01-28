Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF113081E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhA1X3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhA1X30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:29:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 15:28:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611876521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlXAxbXj7j/Fx5JlKqov8jc5RYrzt5AOKGJ950O6mgM=;
        b=G3Ynr8NnoDbJRK11bORSk8lyOfzdw0dgIo4vWB8lK6Pv7B74YI8kKRSPtysyyi3GD5vBWS
        W3Dg1tT83vEUY5dyCHgO9WRtgvHKhlevEyIv9xPjjNtGKEXEddI1xA0Ok8s2QHbiSdSkr8
        ByoULIBtPyO35uJGQUbvxuW2SFgF1M4lKxoOenDAUH7iOIdSL9xAfchwZAMPexGtC2hmm1
        hI8JAbQ1dJBY/q6WRLC0DaqvxYBBcUwKKsDr1LXpthDBVEPnMYvsemPkFl0DAXiUR3xdpL
        dd7CXpM1fZ/Mgqa7hAmV0rZ4gaLK4L6QJeBfK8qCdV1Pb78J2WD8gf/M4wJDpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611876521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlXAxbXj7j/Fx5JlKqov8jc5RYrzt5AOKGJ950O6mgM=;
        b=xXrWrvfKba9WehVEw1ZTZXfvF69mve3Z2Mf94VOy8vVnKrjbLFnedXH+iSHHwitHIbHNN3
        sr2SOr6wbocj+TAQ==
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        tdevries@suse.de
Cc:     linux-kernel@vger.kernel.org, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] selftests: breakpoints: Add "WINE" test for x86
In-Reply-To: <20210128211627.GB4348@worktop.programming.kicks-ass.net>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net> <20210128211627.GB4348@worktop.programming.kicks-ass.net>
Date:   Fri, 29 Jan 2021 00:28:41 +0100
Message-ID: <87eei4d4k6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DR6 handling failure which made GDB upset was caused by a commit
which addressed a WINE test case regression. The test case runs a
trivial

        NOP; NOP; RET;

sequence in the tracee. The tracer runs the following steps:

 1 - Set data breakpoint on the first instruction in DR0
   - Continue tracee, wait for trap
   - Expect DR6::BS == 0 and DR6::BR0 == 1 and IP == first instruction

 2 - Clear DR6, set TF in EFLAGS
   - Set data breakpoint on the second instruction in DR0
   - Continue tracee, wait for trap
   - Expect DR6::BS == 1 and DR6::BR0 == X and IP == second instruction

 3 - Clear DR6, set TF in EFLAGS
   - Continue tracee, wait for trap
   - Expect DR6::BS == 0 and DR6::BR0 == 1 and IP == second instruction

 4 - Clear DR6, set TF in EFLAGS
   - Remove data breakpoint from DR0
   - Continue tracee, wait for trap
   - Expect DR6::BS == 1 and DR6::BR0 == 0 and IP == third instruction

The important step is #2. WINE does not care about the state of DR6::BR0
as Windows versions seem to be inconsistent. The offending commit just
excluded the BR bits when delivering the single step (BS == 1) which
made WINE happy, but broke GDB which expects the BR bits to be merged
when the single step resulted in triggering an armed data breakpoint at
the same time.

Add a test case which covers this scenario. This is modeled after the
WINE testcase, but changes the expect in step #2 to:

   - Expect DR6::BS == 1 and DR6::BR0 == 1 and IP == second instruction

to ensure that the GDB expectations are met as well.

Make it work for both 32 and 64 bit and fix the broken calculation of
number of tests for 32 bit as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/breakpoints/breakpoint_test.c |  115 ++++++++++++++++--
 1 file changed, 107 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -23,6 +23,13 @@
 #define COUNT_ISN_BPS	4
 #define COUNT_WPS	4
 
+#ifdef __i386__
+# define rip		eip
+# define COUNT_LEN	3
+#else
+# define COUNT_LEN	4
+#endif
+
 /* Breakpoint access modes */
 enum {
 	BP_X = 1,
@@ -50,6 +57,16 @@ static void set_breakpoint_addr(void *ad
 			strerror(errno));
 }
 
+static void set_dr7(unsigned long dr7)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_POKEUSER, child_pid,
+		     offsetof(struct user, u_debugreg[7]), dr7);
+	if (ret)
+		ksft_exit_fail_msg("Can't set dr7: %s\n", strerror(errno));
+}
+
 static void toggle_breakpoint(int n, int type, int len,
 			      int local, int global, int set)
 {
@@ -105,12 +122,7 @@ static void toggle_breakpoint(int n, int
 	else
 		dr7 &= ~vdr7;
 
-	ret = ptrace(PTRACE_POKEUSER, child_pid,
-		     offsetof(struct user, u_debugreg[7]), dr7);
-	if (ret) {
-		ksft_print_msg("Can't set dr7: %s\n", strerror(errno));
-		exit(-1);
-	}
+	set_dr7(dr7);
 }
 
 /* Dummy variables to test read/write accesses */
@@ -196,6 +208,13 @@ static void read_var(int len)
 	}
 }
 
+void __wine_test(void);
+
+static void wine_test(void)
+{
+	asm volatile (".global __wine_test; __wine_test: nop; nop; ret\n");
+}
+
 /*
  * Do the r/w/x accesses to trigger the breakpoints. And run
  * the usual traps.
@@ -258,6 +277,11 @@ static void trigger_tests(void)
 	asm("int $3\n");
 	check_trapped();
 
+	/*
+	 * The wine test: NOP, NOP, RET with singlestep and data breakpoint.
+	 */
+	wine_test();
+
 	kill(getpid(), SIGUSR1);
 }
 
@@ -327,6 +351,76 @@ static void launch_watchpoints(char *buf
 	}
 }
 
+static void wine_test_step(int step, void *ip, int bs, int b0, char *buf)
+{
+	unsigned long eflags, dr6, child_ip, ipoffs;
+	int dr6_bs, dr6_b0, status;
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	wait(&status);
+
+	if (WSTOPSIG(status) != SIGTRAP)
+		ksft_exit_fail_msg("Expected SIGTRAP got %d\n", status);
+
+	/* Get DR6 from the child and clear it */
+	dr6 = ptrace(PTRACE_PEEKUSER, child_pid,
+		     offsetof(struct user, u_debugreg[6]), 0),
+	ptrace(PTRACE_POKEUSER, child_pid,
+	       offsetof(struct user, u_debugreg[6]), 0);
+
+	/* Get the IP from the child */
+	child_ip = ptrace(PTRACE_PEEKUSER, child_pid,
+			  offsetof(struct user, regs.rip), 0);
+
+	/* Except for the last step, set TF in eflags */
+	if (step < 3) {
+		eflags = ptrace(PTRACE_PEEKUSER, child_pid,
+				offsetof(struct user, regs.eflags), 0);
+		ptrace(PTRACE_POKEUSER, child_pid,
+		       offsetof(struct user, regs.eflags), eflags | 0x100);
+	}
+
+	/* Calculate the IP offset and isolate the DR6 bits to check */
+	ipoffs = (unsigned long) ip - child_ip;
+	dr6_bs = !!(dr6 & 0x4000);
+	dr6_b0 = !!(dr6 & 0x0001);
+
+	sprintf(buf, "Test wine_test step: %d dr6_bs: %d (%d) dr6_b0: %d (%d) ipoffs: %lx\n",
+		step, dr6_bs, bs, dr6_b0, b0, ipoffs);
+
+	nr_tests++;
+
+	/* Fail if IPOFFS != 0 or BS, B0 are not matching */
+	if (ipoffs || bs != dr6_bs || b0 != dr6_b0)
+		ksft_test_result_fail(buf);
+	else
+		ksft_test_result_pass(buf);
+}
+
+static void launch_wine_test(char *buf)
+{
+	void *addr = __wine_test;
+
+	/* Data break point (RW) on first instruction */
+	set_breakpoint_addr(addr, 0);
+	set_dr7(0x03);
+	/* Expect: DR6::BS == 0 DR6::BR0 == 1 IP == instr[0] */
+	wine_test_step(0, addr, 0, 1, buf);
+	/* Data break point (RW) on second instruction */
+	set_breakpoint_addr(++addr, 0);
+	/*
+	 * Expect: DR6::BS == 1 DR6::BR0 == 1  IP == instr[1]
+	 * Wine does not care about BR0 here but GDB does ...
+	 */
+	wine_test_step(1, addr, 1, 1, buf);
+	/* Expect: DR6::BS == 0 DR6::BR0 == 1  IP == instr[1] */
+	wine_test_step(2, addr, 0, 1, buf);
+	/* Remove the data breakpoint
+	set_breakpoint_addr(NULL, 0);
+	/* Expect: DR6::BS == 1 DR6::BR0 == 0 IP == instr[2] */
+	wine_test_step(3, ++addr, 1, 0, buf);
+}
+
 /* Set the breakpoints and check the child successfully trigger them */
 static void launch_tests(void)
 {
@@ -335,9 +429,12 @@ static void launch_tests(void)
 	int len, local, global, i;
 
 	tests += 3 * COUNT_ISN_BPS;
-	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
-	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
+	tests += COUNT_LEN * 3 * COUNT_WPS;
+	tests += COUNT_LEN * 3 * COUNT_WPS;
+	/* ICEBP, INT3 */
 	tests += 2;
+	/* WINE test */
+	tests += 4;
 	ksft_set_plan(tests);
 
 	/* Instruction breakpoints */
@@ -381,6 +478,8 @@ static void launch_tests(void)
 	ptrace(PTRACE_CONT, child_pid, NULL, 0);
 	check_success("Test int 3 trap\n");
 
+	launch_wine_test(buf);
+
 	ptrace(PTRACE_CONT, child_pid, NULL, 0);
 }
 

