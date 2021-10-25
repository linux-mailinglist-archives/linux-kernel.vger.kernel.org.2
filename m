Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D472E439506
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJYLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232207AbhJYLoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 144C860F22;
        Mon, 25 Oct 2021 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635162116;
        bh=HsfamybsHnbzl3D9cOD87RXOINZNyD9ox26uHQX7wb8=;
        h=From:To:Cc:Subject:Date:From;
        b=BO1o9YTlY2s+LDi7Khu9Ma7V/IELfZSOhUjiSKFkMDzuzbeOlB65xToFG7BdKY+zM
         6QgauThCBuPC5S/YPYd5JLR/nLGQ1Q9HdwUcwPJAo6E3Lcb/Smyj9tnd3P+jzJ1QEM
         VF400b58YDcJSKP+4HOUI3cZHchI0zrp9Gx8gsiNmVvwyyyq2KvZHcKx0WeQwpZilN
         V9i2Op4a+n4CLuebcg0cSQO7m1333yZgZrNPZiRGVWRSpDYjaNrc+B0UpLachw+kvv
         8gygO5bHUOOq46AUFR2+ydx8CMEpr8DScDkCS2xpUKHrr5fnKSbcczVh6c+ZES8Cy+
         MFKdlh23KaQwg==
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
Subject: [PATCH v4] kprobes: Add a test case for stacktrace from kretprobe handler
Date:   Mon, 25 Oct 2021 20:41:52 +0900
Message-Id: <163516211244.604541.18350507860972214415.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
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
 Changes in v4:
  - Enable stack_trace_save_regs() testcase only when the selftest
    is not a module.
  - Rebased on the latest ftrace/core.
---
 arch/Kconfig          |    8 ++
 arch/x86/Kconfig      |    1 
 kernel/test_kprobes.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

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
index e39e2bd6acc5..cc9ba6798848 100644
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
index e78f18144145..a5edc2ebc947 100644
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
@@ -175,12 +207,138 @@ static void test_kretprobes(struct kunit *test)
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
+#if !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+	/*
+	 * Test stacktrace from pt_regs at the return address. Thus the stack
+	 * trace must start from the target return address.
+	 */
+	ret = stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[0], target_return_address[1]);
+#endif
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
+#if !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+	/* Ditto for the regs version. */
+	ret = stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);
+	KUNIT_EXPECT_NE(current_test, ret, 0);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[0], target_return_address[0]);
+	KUNIT_EXPECT_EQ(current_test, stack_buf[1], target_return_address[1]);
+#endif
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
@@ -194,6 +352,10 @@ static struct kunit_case kprobes_testcases[] = {
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

