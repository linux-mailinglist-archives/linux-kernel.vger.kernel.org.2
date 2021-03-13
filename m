Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB53D339C49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 06:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCMFtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 00:49:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:62600 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbhCMFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 00:49:26 -0500
IronPort-SDR: rGkf7ov50xv0/II2WdZHJYxjQYmVi5S+O0qjYPGjzUm2FljmWOs3BPTZo62XRaOAOAr9+HN7hg
 Rpfzrrmwcjew==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176050568"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="176050568"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 21:49:25 -0800
IronPort-SDR: 0mc0eFnT7ayJ1X2KlxEOUcDKbbhCQTiZPpxCR8+YUxko9+YEruF8Hic3DwiinP+YJ3urpmrvwE
 VkOlzwO93bSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="372880404"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2021 21:49:25 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Date:   Sat, 13 Mar 2021 05:49:09 +0000
Message-Id: <20210313054910.2503968-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210313054910.2503968-1-fenghua.yu@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus locks degrade performance for the whole system, not just for the CPU
that requested the bus lock. Two CPU features "#AC for split lock" and
"#DB for bus lock" provide hooks so that the operating system may choose
one of several mitigation strategies.

#AC for split lock is already implemented. Add code to use the #DB for
bus lock feature to cover additional situations with new options to
mitigate.

split_lock_detect=
		#AC for split lock		#DB for bus lock

off		Do nothing			Do nothing

warn		Kernel OOPs			Warn once per task and
		Warn once per task and		and continues to run.
		disable future checking
	 	When both features are
		supported, warn in #AC

fatal		Kernel OOPs			Send SIGBUS to user.
		Send SIGBUS to user
		When both features are
		supported, fatal in #AC

ratelimit:N	Do nothing			Limit bus lock rate to
						N per second in the
						current non-root user.

Default option is "warn".

Hardware only generates #DB for bus lock detect when CPL>0 to avoid
nested #DB from multiple bus locks while the first #DB is being handled.
So no need to handle #DB for bus lock detected in the kernel.

#DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL MSR
while #AC for split lock is enabled by split lock detection bit 29 in
TEST_CTRL MSR.

Both breakpoint and bus lock in the same instruction can trigger one #DB.
The bus lock is handled before the breakpoint in the #DB handler.

Delivery of #DB for bus lock in userspace clears DR6[11]. To avoid
confusion in identifying #DB, #DB handler sets the bit to 1 before
returning to the interrupted task.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
v5:
Address all comments from Thomas:
- Merge patch 2 and patch 3 into one patch so all "split_lock_detect="
  options are processed in one patch.
- Change warn to #AC if both #AC and #DB are supported.
- Remove sld and bld variables and use boot_cpu_has() to check bus lock
  split lock support.
- Remove bus lock checking in handle_bus_lock().
- Remove bld_ratelimit < HZ/2 check.
- Add rate limit handling comment in bus lock #DB.
- Define bld_ratelimit only for Intel CPUs.

v3:
- Enable Bus Lock Detection when fatal to handle bus lock from non-WB
  (PeterZ).

v2:
- Send SIGBUS in fatal case for bus lock #DB (PeterZ).

v1::
- Check bus lock bit by its positive polarity (Xiaoyao).

RFC v3:
- Remove DR6_RESERVED change (PeterZ).

 arch/x86/include/asm/cpu.h           |  10 +-
 arch/x86/include/asm/msr-index.h     |   1 +
 arch/x86/include/uapi/asm/debugreg.h |   1 +
 arch/x86/kernel/cpu/common.c         |   2 +-
 arch/x86/kernel/cpu/intel.c          | 148 +++++++++++++++++++++++----
 arch/x86/kernel/traps.c              |   7 ++
 include/linux/sched/user.h           |   5 +-
 kernel/user.c                        |  13 +++
 8 files changed, 162 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..991de5f2a09c 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -41,12 +41,14 @@ unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_CPU_SUP_INTEL
-extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+extern void handle_bus_lock(struct pt_regs *regs);
+extern int bld_ratelimit;
 #else
-static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
@@ -57,6 +59,10 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline void handle_bus_lock(struct pt_regs *regs)
+{
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..558485965f21 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -265,6 +265,7 @@
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2) /* Bus lock detect */
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
index 0e422a544835..2bd680c0c9ae 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -10,6 +10,9 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/cred.h>
+#include <linux/delay.h>
+#include <linux/sched/user.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -41,12 +44,13 @@ enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
 	sld_fatal,
+	sld_ratelimit,
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
@@ -603,6 +607,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 }
 
 static void split_lock_init(void);
+static void bus_lock_init(void);
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
@@ -720,6 +725,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_disable();
 
 	split_lock_init();
+	bus_lock_init();
 
 	intel_init_thermal(c);
 }
@@ -995,13 +1001,24 @@ static const struct {
 	{ "off",	sld_off   },
 	{ "warn",	sld_warn  },
 	{ "fatal",	sld_fatal },
+	{ "ratelimit:", sld_ratelimit },
 };
 
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
-	int len = strlen(opt);
 
-	return len == arglen && !strncmp(arg, opt, len);
+	int len = strlen(opt), ratelimit;
+
+	if (strncmp(arg, opt, len))
+		return false;
+
+	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0) {
+		bld_ratelimit = ratelimit;
+
+		return true;
+	}
+
+	return len == arglen;
 }
 
 static bool split_lock_verify_msr(bool on)
@@ -1020,16 +1037,15 @@ static bool split_lock_verify_msr(bool on)
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
@@ -1041,17 +1057,14 @@ static void __init split_lock_setup(void)
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
@@ -1061,7 +1074,9 @@ static void __init split_lock_setup(void)
 		return;
 	}
 
-	sld_state = state;
+	/* Restore the MSR to its cached value. */
+	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 }
 
@@ -1082,6 +1097,15 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
+	/*
+	 * #DB for bus lock handles ratelimit and #AC for split lock is
+	 * disabled.
+	 */
+	if (sld_state == sld_ratelimit) {
+		split_lock_verify_msr(false);
+		return;
+	}
+
 	if (cpu_model_supports_sld)
 		split_lock_verify_msr(sld_state != sld_off);
 }
@@ -1118,6 +1142,29 @@ bool handle_guest_split_lock(unsigned long ip)
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
+	 * split locks are handled in #AC in fatal case.
+	 */
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+}
+
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
@@ -1126,6 +1173,26 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
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
+	case sld_ratelimit:
+		/* Enforce no more than bld_ratelimit bus locks/sec. */
+		while (!__ratelimit(&get_current_user()->bld_ratelimit))
+			msleep(1000 / bld_ratelimit);
+		break;
+	}
+}
+
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
@@ -1166,7 +1233,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	{}
 };
 
-void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+static void __init split_lock_setup(struct cpuinfo_x86 *c)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
@@ -1193,5 +1260,44 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
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
+	case sld_ratelimit:
+		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: setting rate limit to %d/sec per user on non-root user-space bus_locks\n", bld_ratelimit);
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
index 7f5aec758f0e..21f885a1609d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -979,6 +979,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 		goto out_irq;
 	}
 
+	/*
+	 * Handle bus lock. #DB for bus lock can only be triggered from
+	 * userspace. The bus lock bit was flipped to positive polarity.
+	 */
+	if (dr6 & DR_BUS_LOCK)
+		handle_bus_lock(regs);
+
 	/* Add the virtual_dr6 bits for signals. */
 	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index a8ec3b6093fc..af8ec609910e 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -40,8 +40,11 @@ struct user_struct {
 	atomic_t nr_watches;	/* The number of watches this user currently has */
 #endif
 
-	/* Miscellaneous per-user rate limit */
+	/* Miscellaneous per-user rate limits */
 	struct ratelimit_state ratelimit;
+#ifdef CONFIG_CPU_SUP_INTEL
+	struct ratelimit_state bld_ratelimit;
+#endif
 };
 
 extern int uids_sysfs_init(void);
diff --git a/kernel/user.c b/kernel/user.c
index a2478cddf536..654aefb7ce8f 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -103,6 +103,9 @@ struct user_struct root_user = {
 	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
 	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
+#ifdef CONFIG_CPU_SUP_INTEL
+	.bld_ratelimit	= RATELIMIT_STATE_INIT(root_user.bld_ratelimit, 0, 0),
+#endif
 };
 
 /*
@@ -172,6 +175,11 @@ void free_uid(struct user_struct *up)
 		free_user(up, flags);
 }
 
+#ifdef CONFIG_CPU_SUP_INTEL
+/* Some Intel CPUs may set this for rate-limited bus locks. */
+int bld_ratelimit;
+#endif
+
 struct user_struct *alloc_uid(kuid_t uid)
 {
 	struct hlist_head *hashent = uidhashentry(uid);
@@ -190,6 +198,11 @@ struct user_struct *alloc_uid(kuid_t uid)
 		refcount_set(&new->__count, 1);
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
+#ifdef CONFIG_CPU_SUP_INTEL
+		ratelimit_state_init(&new->bld_ratelimit, HZ, bld_ratelimit);
+		ratelimit_set_flags(&new->bld_ratelimit,
+				    RATELIMIT_MSG_ON_RELEASE);
+#endif
 
 		/*
 		 * Before adding this, check whether we raced
-- 
2.30.2

