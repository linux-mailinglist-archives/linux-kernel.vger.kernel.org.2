Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71BE42F16F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhJOMyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239191AbhJOMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79F0D60ED4;
        Fri, 15 Oct 2021 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302265;
        bh=niYdGlhnIOnlqO9uKbzVe3OozoWdJl8BUi/pR8B1qg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZH8JpWOr8Z1W1spY7vq9mKn4c82ctEym+xYt16Nx2bxK5wkxDdchbWrPIv9KVkc1g
         +xPlX3gfI1pF+wdZ/Av8SlvuFsuKK3xxytgvImMJzjU0h/trcbrN0BLX6ToJiN32Wp
         aaRa6BRX77F2gUIZ+xouGT4awOWApCzH40HM2EgLcwq/6rrVccPTCLD3JnmUjEYLpL
         wALgOXfI7w6EIryaFYRnjxqa9rrpM7gADXiNpzB0Kq76bPp1KlVCF0WV8+Z+DmbUxw
         oydcbXCLrJTI1VIvaRYzCnFnStjM03dweWb4NUyJ7x5VYKna2wyqYKsKpkvX82oPlm
         ch3UXH7iruvEg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/10] kprobes: Add a test case for stacktrace from kretprobe handler
Date:   Fri, 15 Oct 2021 21:51:02 +0900
Message-Id: <163430226192.459050.1792956015201221263.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163430224341.459050.2369208860773018092.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case for stacktrace from kretprobe handler and
nested kretprobe handlers.

This test checks both of stack trace inside kretprobe handler
and stack trace from pt_regs. Those stack trace must include
actual function return address instead of kretprobe trampoline.
The nested kretprobe stacktrace test checks whether the unwinder
can correctly unwind the call frame on the stack which has been
modified by the kretprobe.

Since the stacktrace on kretprobe is correctly fixed only on x86,
this introduces a meta kconfig ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
which tells user that the stacktrace on kretprobe is correct or not.

The test results will be shown like below;

 TAP version 14
 1..1
     # Subtest: kprobes_test
     1..6
     ok 1 - test_kprobe
     ok 2 - test_kprobes
     ok 3 - test_kretprobe
     ok 4 - test_kretprobes
     ok 5 - test_stacktrace_on_kretprobe
     ok 6 - test_stacktrace_on_nested_kretprobe
 # kprobes_test: pass:6 fail:0 skip:0 total:6
 # Totals: pass:6 fail:0 skip:0 total:6
 ok 1 - kprobes_test

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/Kconfig          |    8 ++
 arch/x86/Kconfig      |    1 
 kernel/test_kprobes.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..8378f83b462c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -191,6 +191,14 @@ config HAVE_OPTPROBES
 config HAVE_KPROBES_ON_FTRACE
 	bool
 
+config ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	bool
+	help
+	  Since kretprobes modifies return address on the stack, the
+	  stacktrace may see the kretprobe trampoline address instead
+	  of correct one. If the architecture stacktrace code and
+	  unwinder can adjust such entries, select this configuration.
+
 config HAVE_FUNCTION_ERROR_INJECTION
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22d274e..2049364b3981 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index e78f18144145..a902be1f4a96 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -17,6 +17,11 @@ static u32 (*target)(u32 value);
 static u32 (*target2)(u32 value);
 static struct kunit *current_test;
 
+static unsigned long (*internal_target)(void);
+static unsigned long (*stacktrace_target)(void);
+static unsigned long (*stacktrace_driver)(void);
+static unsigned long target_return_address[2];
+
 static noinline u32 kprobe_target(u32 value)
 {
 	return (value / div_factor);
@@ -58,6 +63,33 @@ static noinline u32 kprobe_target2(u32 value)
 	return (value / div_factor) + 1;
 }
 
+static noinline unsigned long kprobe_stacktrace_internal_target(void)
+{
+	if (!target_return_address[0])
+		target_return_address[0] = (unsigned long)__builtin_return_address(0);
+	return target_return_address[0];
+}
+
+static noinline unsigned long kprobe_stacktrace_target(void)
+{
+	if (!target_return_address[1])
+		target_return_address[1] = (unsigned long)__builtin_return_address(0);
+
+	if (internal_target)
+		internal_target();
+
+	return target_return_address[1];
+}
+
+static noinline unsigned long kprobe_stacktrace_driver(void)
+{
+	if (stacktrace_target)
+		stacktrace_target();
+
+	/* This is for preventing inlining the function */
+	return (unsigned long)__builtin_return_address(0);
+}
+
 static int kp_pre_handler2(struct kprobe *p, struct pt_regs *regs)
 {
 	preh_val = (rand1 / div_factor) + 1;
@@ -175,12 +207,134 @@ static void test_kretprobes(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, krph_val, rand1);
 	unregister_kretprobes(rps, 2);
 }
+
+#ifdef CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+#define STACK_BUF_SIZE 16
+static unsigned long stack_buf[STACK_BUF_SIZE];
+
+static int stacktrace_return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
+{
+	unsigned long retval = regs_return_value(regs);
+	int i, ret;
+
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, retval, target_return_address[1]);
+
+	/*
+	 * Test stacktrace inside the kretprobe handler, this will involves
+	 * kretprobe trampoline, but must include correct return address
+	 * of the target function.
+	 */
+	ret = stack_trace_save(stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+
+	for (i = 0; i < ret; i++) {
+		if (stack_buf[i] == target_return_address[1])
+			break;
+	}
+	KUNIT_EXPECT_NE(current_test, i, ret);
+
+	/*
+	 * Test stacktrace from pt_regs at the return address. Thus the stack
+	 * trace must start from the target return address.
+	 */
+	ret = stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[0], target_return_address[1]);
+
+	return 0;
+}
+
+static struct kretprobe rp3 = {
+	.handler	= stacktrace_return_handler,
+	.kp.symbol_name = "kprobe_stacktrace_target"
+};
+
+static void test_stacktrace_on_kretprobe(struct kunit *test)
+{
+	unsigned long myretaddr = (unsigned long)__builtin_return_address(0);
+
+	current_test = test;
+	rp3.kp.addr = NULL;
+	rp3.kp.flags = 0;
+
+	/*
+	 * Run the stacktrace_driver() to record correct return address in
+	 * stacktrace_target() and ensure stacktrace_driver() call is not
+	 * inlined by checking the return address of stacktrace_driver()
+	 * and the return address of this function is different.
+	 */
+	KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
+
+	KUNIT_ASSERT_EQ(test, 0, register_kretprobe(&rp3));
+	KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
+	unregister_kretprobe(&rp3);
+}
+
+static int stacktrace_internal_return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
+{
+	unsigned long retval = regs_return_value(regs);
+	int i, ret;
+
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, retval, target_return_address[0]);
+
+	/*
+	 * Test stacktrace inside the kretprobe handler for nested case.
+	 * The unwinder will find the kretprobe_trampoline address on the
+	 * return address, and kretprobe must solve that.
+	 */
+	ret = stack_trace_save(stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+
+	for (i = 0; i < ret - 1; i++) {
+		if (stack_buf[i] == target_return_address[0]) {
+			KUNIT_EXPECT_EQ(current_test, stack_buf[i + 1], target_return_address[1]);
+			break;
+		}
+	}
+	KUNIT_EXPECT_NE(current_test, i, ret);
+
+	/* Ditto for the regs version. */
+	ret = stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[0], target_return_address[0]);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[1], target_return_address[1]);
+
+	return 0;
+}
+
+static struct kretprobe rp4 = {
+	.handler	= stacktrace_internal_return_handler,
+	.kp.symbol_name = "kprobe_stacktrace_internal_target"
+};
+
+static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
+{
+	unsigned long myretaddr = (unsigned long)__builtin_return_address(0);
+	struct kretprobe *rps[2] = {&rp3, &rp4};
+
+	current_test = test;
+	rp3.kp.addr = NULL;
+	rp3.kp.flags = 0;
+
+	//KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
+
+	KUNIT_ASSERT_EQ(test, 0, register_kretprobes(rps, 2));
+	KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
+	unregister_kretprobes(rps, 2);
+}
+#endif /* CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE */
+
 #endif /* CONFIG_KRETPROBES */
 
 static int kprobes_test_init(struct kunit *test)
 {
 	target = kprobe_target;
 	target2 = kprobe_target2;
+	stacktrace_target = kprobe_stacktrace_target;
+	internal_target = kprobe_stacktrace_internal_target;
+	stacktrace_driver = kprobe_stacktrace_driver;
 
 	do {
 		rand1 = prandom_u32();
@@ -194,6 +348,10 @@ static struct kunit_case kprobes_testcases[] = {
 #ifdef CONFIG_KRETPROBES
 	KUNIT_CASE(test_kretprobe),
 	KUNIT_CASE(test_kretprobes),
+#ifdef CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	KUNIT_CASE(test_stacktrace_on_kretprobe),
+	KUNIT_CASE(test_stacktrace_on_nested_kretprobe),
+#endif
 #endif
 	{}
 };

