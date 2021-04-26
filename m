Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877036B2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhDZMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:21:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhDZMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:21:42 -0400
Date:   Mon, 26 Apr 2021 12:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619439660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=d5DaH8UNV9rUEwxIB7XT0nHQL7xliznkEFgY+k6mqSc=;
        b=FZ3II3CF9kJoxghgZA32Wmy4Qv1qDy3FkeLzp+kUEZCrYWWtSh/sZHBJLpAvCiJEKU2ukY
        DfXSH0rpl66D9k92KSaKEIWh2m87bcHII2Y3KKU1Rvm/vKLfZnX7zOQhSeEAUxUm7+md03
        fa00AiSFxv5nRnEfLMQ80imKIdjI6TVg9xCOkBt3kJNIObGpJNfdEGh4KkF+V4LTrUPwkf
        Nll83LL6a4g+0g5SJWe9YyoXVD3P7OJBdughXZM6UoM2ODuzXy0Be1mBaenQCYzLCQ1j1z
        N69b40dAoqGTL8t/6maV912lLq7FDF2QqAsJ3U7zhWYOu74kgKPqOHrp4Axb3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619439660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=d5DaH8UNV9rUEwxIB7XT0nHQL7xliznkEFgY+k6mqSc=;
        b=hOtsqMnFvEbyzlETcAEPuH8JOJi7gDi18CZ1e8dBx9nqSV8DMhrQgafarGxMfbnf671KqL
        5+iELuf7sEiVzpAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/splitlock for v5.13-rc1
References: <161943945302.1498.9201552430413038175.tglx@nanos>
Message-ID: <161943945543.1498.14355612614369904966.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/splitlock branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-04-26

up to:  ebca17707e38: Documentation/admin-guide: Change doc for split_lock_detect parameter


Support for enhanced split lock detection:

  Newer CPUs provide a second mechanism to detect operations with lock
  prefix which go accross a cache line boundary. Such operations have to
  take bus lock which causes a system wide performance degradation when
  these operations happen frequently.

  The new mechanism is not using the #AC exception. It triggers #DB and is
  restricted to operations in user space. Kernel side split lock access can
  only be detected by the #AC based variant. Contrary to the #AC based
  mechanism the #DB based variant triggers _after_ the instruction was
  executed. The mechanism is CPUID enumerated and contrary to the #AC
  version which is based on the magic TEST_CTRL_MSR and model/family based
  enumeration on the way to become architectural.


Thanks,

	tglx

------------------>
Fenghua Yu (3):
      x86/cpufeatures: Enumerate #DB for bus lock detection
      x86/traps: Handle #DB for bus lock
      Documentation/admin-guide: Change doc for split_lock_detect parameter


 Documentation/admin-guide/kernel-parameters.txt |  22 +++--
 arch/x86/include/asm/cpu.h                      |   7 +-
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/msr-index.h                |   1 +
 arch/x86/include/uapi/asm/debugreg.h            |   1 +
 arch/x86/kernel/cpu/common.c                    |   2 +-
 arch/x86/kernel/cpu/intel.c                     | 111 ++++++++++++++++++++----
 arch/x86/kernel/traps.c                         |   4 +
 8 files changed, 121 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..aef927cec602 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5100,27 +5100,37 @@
 	spia_peddr=
 
 	split_lock_detect=
-			[X86] Enable split lock detection
+			[X86] Enable split lock detection or bus lock detection
 
 			When enabled (and if hardware support is present), atomic
 			instructions that access data across cache line
-			boundaries will result in an alignment check exception.
+			boundaries will result in an alignment check exception
+			for split lock detection or a debug exception for
+			bus lock detection.
 
 			off	- not enabled
 
-			warn	- the kernel will emit rate limited warnings
+			warn	- the kernel will emit rate-limited warnings
 				  about applications triggering the #AC
-				  exception. This mode is the default on CPUs
-				  that supports split lock detection.
+				  exception or the #DB exception. This mode is
+				  the default on CPUs that support split lock
+				  detection or bus lock detection. Default
+				  behavior is by #AC if both features are
+				  enabled in hardware.
 
 			fatal	- the kernel will send SIGBUS to applications
-				  that trigger the #AC exception.
+				  that trigger the #AC exception or the #DB
+				  exception. Default behavior is by #AC if
+				  both features are enabled in hardware.
 
 			If an #AC exception is hit in the kernel or in
 			firmware (i.e. not while executing in user mode)
 			the kernel will oops in either "warn" or "fatal"
 			mode.
 
+			#DB exception for bus lock is triggered only when
+			CPL > 0.
+
 	srbds=		[X86,INTEL]
 			Control the Special Register Buffer Data Sampling
 			(SRBDS) mitigation.
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..0d7fc0e2bfc9 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -41,12 +41,13 @@ unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_CPU_SUP_INTEL
-extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+extern void handle_bus_lock(struct pt_regs *regs);
 #else
-static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
@@ -57,6 +58,8 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline void handle_bus_lock(struct pt_regs *regs) {}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..faec3d92d09b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -354,6 +354,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..32c496fb11b6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -265,6 +265,7 @@
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index d95d080b30e3..0007ba077c0c 100644
--- a/arch/x86/include/uapi/asm/debugreg.h
+++ b/arch/x86/include/uapi/asm/debugreg.h
@@ -24,6 +24,7 @@
 #define DR_TRAP3	(0x8)		/* db3 */
 #define DR_TRAP_BITS	(DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)
 
+#define DR_BUS_LOCK	(0x800)		/* bus_lock */
 #define DR_STEP		(0x4000)	/* single-step */
 #define DR_SWITCH	(0x8000)	/* task switch */
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..1a4e260b9027 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1330,7 +1330,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
-	cpu_set_core_cap_bits(c);
+	sld_setup(c);
 
 	fpu__init_system(c);
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a544835..e25e52bafeb6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -44,9 +44,9 @@ enum split_lock_detect_state {
 };
 
 /*
- * Default to sld_off because most systems do not support split lock detection
- * split_lock_setup() will switch this to sld_warn on systems that support
- * split lock detect, unless there is a command line override.
+ * Default to sld_off because most systems do not support split lock detection.
+ * sld_state_setup() will switch this to sld_warn on systems that support
+ * split lock/bus lock detect, unless there is a command line override.
  */
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
 static u64 msr_test_ctrl_cache __ro_after_init;
@@ -603,6 +603,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 }
 
 static void split_lock_init(void);
+static void bus_lock_init(void);
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
@@ -720,6 +721,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_disable();
 
 	split_lock_init();
+	bus_lock_init();
 
 	intel_init_thermal(c);
 }
@@ -1020,16 +1022,15 @@ static bool split_lock_verify_msr(bool on)
 	return ctrl == tmp;
 }
 
-static void __init split_lock_setup(void)
+static void __init sld_state_setup(void)
 {
 	enum split_lock_detect_state state = sld_warn;
 	char arg[20];
 	int i, ret;
 
-	if (!split_lock_verify_msr(false)) {
-		pr_info("MSR access failed: Disabled\n");
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
 				  arg, sizeof(arg));
@@ -1041,17 +1042,14 @@ static void __init split_lock_setup(void)
 			}
 		}
 	}
+	sld_state = state;
+}
 
-	switch (state) {
-	case sld_off:
-		pr_info("disabled\n");
+static void __init __split_lock_setup(void)
+{
+	if (!split_lock_verify_msr(false)) {
+		pr_info("MSR access failed: Disabled\n");
 		return;
-	case sld_warn:
-		pr_info("warning about user-space split_locks\n");
-		break;
-	case sld_fatal:
-		pr_info("sending SIGBUS on user-space split_locks\n");
-		break;
 	}
 
 	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
@@ -1061,7 +1059,9 @@ static void __init split_lock_setup(void)
 		return;
 	}
 
-	sld_state = state;
+	/* Restore the MSR to its cached value. */
+	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 }
 
@@ -1118,6 +1118,29 @@ bool handle_guest_split_lock(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(handle_guest_split_lock);
 
+static void bus_lock_init(void)
+{
+	u64 val;
+
+	/*
+	 * Warn and fatal are handled by #AC for split lock if #AC for
+	 * split lock is supported.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
+	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off)
+		return;
+
+	/*
+	 * Enable #DB for bus lock. All bus locks are handled in #DB except
+	 * split locks are handled in #AC in the fatal case.
+	 */
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+}
+
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
@@ -1126,6 +1149,21 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	return true;
 }
 
+void handle_bus_lock(struct pt_regs *regs)
+{
+	switch (sld_state) {
+	case sld_off:
+		break;
+	case sld_warn:
+		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid, regs->ip);
+		break;
+	case sld_fatal:
+		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
+		break;
+	}
+}
+
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
@@ -1166,7 +1204,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	{}
 };
 
-void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+static void __init split_lock_setup(struct cpuinfo_x86 *c)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
@@ -1193,5 +1231,40 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	}
 
 	cpu_model_supports_sld = true;
-	split_lock_setup();
+	__split_lock_setup();
+}
+
+static void sld_state_show(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return;
+
+	switch (sld_state) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+	case sld_warn:
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
+		else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: warning on user-space bus_locks\n");
+		break;
+	case sld_fatal:
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
+			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
+		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
+			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n",
+				boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ?
+				" from non-WB" : "");
+		}
+		break;
+	}
+}
+
+void __init sld_setup(struct cpuinfo_x86 *c)
+{
+	split_lock_setup(c);
+	sld_state_setup();
+	sld_state_show();
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a2a70e..7bb94a6edc04 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -978,6 +978,10 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 		goto out_irq;
 	}
 
+	/* #DB for bus lock can only be triggered from userspace. */
+	if (dr6 & DR_BUS_LOCK)
+		handle_bus_lock(regs);
+
 	/* Add the virtual_dr6 bits for signals. */
 	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)

