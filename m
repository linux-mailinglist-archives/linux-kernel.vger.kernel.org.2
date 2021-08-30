Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAAE3FB408
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhH3KqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:46:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhH3Kpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ofgGHowRpdaRTH7qF9scJttI4iHLKMgGKmwtr/BC4i0=;
        b=QM7AZOxENYyQoZilm7GTKX85uF2klSDVSWHRJqLOccGHuiYhzWxpplcQuHnrRJsRHA+LQV
        Mhm/s5GTmvuYYcGYWKW0d0nlDi5oTlODFHLrsfak3G5opWET3cU8xPeX5nTsZhF6v5EODm
        ZU6tmrm5/08gPa4xNQuMvIrcsvrZasHGT+4jkdpXyI/+C4J2rwqwBbTUKl04A2wwAlCR4B
        cfGOm9t0YFJIScKCokncf/J0dNhLHihgqYok7zsVbT0eYDIvBRtlMVxPywjso8Iuz7+Z+F
        pi2qLSE8yF4rCPi7aQF8B8JuTrGmk5fy8TkGJBsk0JPyIHTPP2eanDIgu8u/fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ofgGHowRpdaRTH7qF9scJttI4iHLKMgGKmwtr/BC4i0=;
        b=zA4ftP9cj7j8rTV5i+PkHbwLiQGXLejG5GqLeS2lTMkEgHHHXIHD1wC7wISmDDxdMq4t88
        IH4wf7/iMyEKJhBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cpu for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993742.58256.16683258988343657253.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:48 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/cpu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2021-08-=
30

up to:  b7fe54f6c2d4: Documentation: Add L1D flushing Documentation


A reworked version of the opt-in L1D flush mechanism:

  A stop gap for potential future speculation related hardware
  vulnerabilities and a mechanism for truly security paranoid=20
  applications.

  It allows a task to request that the L1D cache is flushed when the kernel
  switches to a different mm. This can be requested via prctl().

  Changes vs. the previous versions:

    - Get rid of the software flush fallback

    - Make the handling consistent with other mitigations
   =20
    - Kill the task when it ends up on a SMT enabled core which defeats the
      purpose of L1D flushing obviously

Thanks,

	tglx

------------------>
Balbir Singh (7):
      x86/smp: Add a per-cpu view of SMT state
      x86/mm: Refactor cond_ibpb() to support other use cases
      sched: Add task_work callback for paranoid L1D flush
      x86/process: Make room for TIF_SPEC_L1D_FLUSH
      x86/mm: Prepare for opt-in based L1D flush in switch_mm()
      x86, prctl: Hook L1D flushing in via prctl
      Documentation: Add L1D flushing Documentation


 Documentation/admin-guide/hw-vuln/index.rst     |   1 +
 Documentation/admin-guide/hw-vuln/l1d_flush.rst |  69 +++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt |  17 ++++
 Documentation/userspace-api/spec_ctrl.rst       |   8 ++
 arch/Kconfig                                    |   3 +
 arch/x86/Kconfig                                |   1 +
 arch/x86/include/asm/nospec-branch.h            |   2 +
 arch/x86/include/asm/processor.h                |   2 +
 arch/x86/include/asm/thread_info.h              |   6 +-
 arch/x86/include/asm/tlbflush.h                 |   2 +-
 arch/x86/kernel/cpu/bugs.c                      |  70 ++++++++++++++++
 arch/x86/kernel/smpboot.c                       |  10 ++-
 arch/x86/mm/tlb.c                               | 107 ++++++++++++++++++----=
--
 include/linux/sched.h                           |  10 +++
 include/uapi/linux/prctl.h                      |   1 +
 15 files changed, 281 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admi=
n-guide/hw-vuln/index.rst
index f12cda55538b..8cbc711cda93 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -16,3 +16,4 @@ are configurable at compile, boot or run time.
    multihit.rst
    special-register-buffer-data-sampling.rst
    core-scheduling.rst
+   l1d_flush.rst
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/=
admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 000000000000..210020bc3f56
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,69 @@
+L1D Flushing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For applications
+the mechanism keeps them safe from vulnerabilities, related to leaks
+(snooping of) from the L1D cache.
+
+
+Related CVEs
+------------
+The following CVEs can be addressed by this
+mechanism
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    CVE-2020-0550       Improper Data Forwarding     OS related aspects
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Usage Guidelines
+----------------
+
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst
+<set_spec_ctrl>` for details.
+
+**NOTE**: The feature is disabled by default, applications need to
+specifically opt into the feature to enable it.
+
+Mitigation
+----------
+
+When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+performed when the task is scheduled out and the incoming task belongs to a
+different process and therefore to a different address space.
+
+If the underlying CPU supports L1D flushing in hardware, the hardware
+mechanism is used, software fallback for the mitigation, is not supported.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+The kernel command line allows to control the L1D flush mitigations at boot
+time with the option "l1d_flush=3D". The valid arguments for this option are:
+
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  on            Enables the prctl interface, applications trying to use
+                the prctl() will fail with an error if l1d_flush is not
+                enabled
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+By default the mechanism is disabled.
+
+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
+
+**NOTE** : The opt-in of a task for L1D flushing works only when the task's
+affinity is limited to cores running in non-SMT mode. If a task which
+requested L1D flushing is scheduled on a SMT-enabled core the kernel sends
+a SIGBUS to the task.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index bdb22006f713..b105db25f7a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2421,6 +2421,23 @@
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
=20
+	l1d_flush=3D	[X86,INTEL]
+			Control mitigation for L1D based snooping vulnerability.
+
+			Certain CPUs are vulnerable to an exploit against CPU
+			internal buffers which can forward information to a
+			disclosure gadget under certain conditions.
+
+			In vulnerable processors, the speculatively
+			forwarded data can be used in a cache side channel
+			attack, to access data to which the attacker does
+			not have direct access.
+
+			This parameter controls the mitigation. The
+			options are:
+
+			on         - enable the interface for the mitigation
+
 	l1tf=3D           [X86] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
=20
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/usersp=
ace-api/spec_ctrl.rst
index 7ddd8f667459..5e8ed9eef9aa 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE,=
 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE=
, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_D=
ISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH: Flush L1D Cache on context switch out of the task
+                        (works only when tasks run on non SMT cores)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE, 0, 0=
);
diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..98db63496bab 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1282,6 +1282,9 @@ config ARCH_SPLIT_ARG64
 config ARCH_HAS_ELFCORE_COMPAT
 	bool
=20
+config ARCH_HAS_PARANOID_L1D_FLUSH
+	bool
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49270655e827..d8a2c3fe492a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index 3ad8c6d3cbb3..ec2d5c8c6694 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -252,6 +252,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
=20
+DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
+
 #include <asm/segment.h>
=20
 /**
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index f3020c54e2cb..1e0d13c9fda6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -136,6 +136,8 @@ struct cpuinfo_x86 {
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
+	/*  Is SMT active on this core? */
+	bool			smt_active;
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread=
_info.h
index de406d93b515..cf132663c219 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,7 +81,7 @@ struct thread_info {
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context =
switch */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context =
switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -104,7 +105,7 @@ struct thread_info {
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -115,6 +116,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index fa952eadbc2e..b587a9ee9cb2 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -83,7 +83,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
=20
 	u16 loaded_mm_asid;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..ecfca3bbcd96 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -43,6 +43,7 @@ static void __init mds_select_mitigation(void);
 static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init l1d_flush_select_mitigation(void);
=20
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
 u64 x86_spec_ctrl_base;
@@ -76,6 +77,13 @@ EXPORT_SYMBOL_GPL(mds_user_clear);
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
=20
+/*
+ * Controls whether l1d flush based mitigations are enabled,
+ * based on hw features and admin setting via boot parameter
+ * defaults to false
+ */
+DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -111,6 +119,7 @@ void __init check_bugs(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	srbds_select_mitigation();
+	l1d_flush_select_mitigation();
=20
 	/*
 	 * As MDS and TAA mitigations are inter-related, print MDS
@@ -491,6 +500,34 @@ static int __init srbds_parse_cmdline(char *str)
 }
 early_param("srbds", srbds_parse_cmdline);
=20
+#undef pr_fmt
+#define pr_fmt(fmt)     "L1D Flush : " fmt
+
+enum l1d_flush_mitigations {
+	L1D_FLUSH_OFF =3D 0,
+	L1D_FLUSH_ON,
+};
+
+static enum l1d_flush_mitigations l1d_flush_mitigation __initdata =3D L1D_FL=
USH_OFF;
+
+static void __init l1d_flush_select_mitigation(void)
+{
+	if (!l1d_flush_mitigation || !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return;
+
+	static_branch_enable(&switch_mm_cond_l1d_flush);
+	pr_info("Conditional flush on switch_mm() enabled\n");
+}
+
+static int __init l1d_flush_parse_cmdline(char *str)
+{
+	if (!strcmp(str, "on"))
+		l1d_flush_mitigation =3D L1D_FLUSH_ON;
+
+	return 0;
+}
+early_param("l1d_flush", l1d_flush_parse_cmdline);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V1 : " fmt
=20
@@ -1215,6 +1252,24 @@ static void task_update_spec_tif(struct task_struct *t=
sk)
 		speculation_ctrl_update_current();
 }
=20
+static int l1d_flush_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (!static_branch_unlikely(&switch_mm_cond_l1d_flush))
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		set_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+		return 0;
+	case PR_SPEC_DISABLE:
+		clear_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+		return 0;
+	default:
+		return -ERANGE;
+	}
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode !=3D SPEC_STORE_BYPASS_PRCTL &&
@@ -1324,6 +1379,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, =
unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1340,6 +1397,17 @@ void arch_seccomp_spec_mitigate(struct task_struct *ta=
sk)
 }
 #endif
=20
+static int l1d_flush_prctl_get(struct task_struct *task)
+{
+	if (!static_branch_unlikely(&switch_mm_cond_l1d_flush))
+		return PR_SPEC_FORCE_DISABLE;
+
+	if (test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH))
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1390,6 +1458,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, =
unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9320285a5e29..85f6e242b6b4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -610,6 +610,9 @@ void set_cpu_sibling_map(int cpu)
 	if (threads > __max_smt_threads)
 		__max_smt_threads =3D threads;
=20
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active =3D threads > 1;
+
 	/*
 	 * This needs a separate iteration over the cpus because we rely on all
 	 * topology_sibling_cpumask links to be set-up.
@@ -1552,8 +1555,13 @@ static void remove_siblinginfo(int cpu)
=20
 	for_each_cpu(sibling, topology_die_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
-	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+		if (cpumask_weight(topology_sibling_cpumask(sibling)) =3D=3D 1)
+			cpu_data(sibling).smt_active =3D false;
+	}
+
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cfe6b1e85fa6..59ba2968af1b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,11 +8,13 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/smt.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
=20
@@ -43,10 +45,15 @@
  */
=20
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_L1D_FLUSH	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
+
+/* Bits to set when tlbstate and flush is (re)initialized */
+#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
=20
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -317,20 +324,70 @@ void switch_mm(struct mm_struct *prev, struct mm_struct=
 *next,
 	local_irq_restore(flags);
 }
=20
-static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+/*
+ * Invoked from return to user/guest by a task that opted-in to L1D
+ * flushing but ended up running on an SMT enabled core due to wrong
+ * affinity settings or CPU hotplug. This is part of the paranoid L1D flush
+ * contract which this task requested.
+ */
+static void l1d_flush_force_sigbus(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
+				struct task_struct *next)
+{
+	/* Flush L1D if the outgoing task requests it */
+	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+
+	/* Check whether the incoming task opted in for L1D flush */
+	if (likely(!(next_mm & LAST_USER_MM_L1D_FLUSH)))
+		return;
+
+	/*
+	 * Validate that it is not running on an SMT sibling as this would
+	 * make the excercise pointless because the siblings share L1D. If
+	 * it runs on a SMT sibling, notify it with SIGBUS on return to
+	 * user/guest
+	 */
+	if (this_cpu_read(cpu_info.smt_active)) {
+		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
+		next->l1d_flush_kill.func =3D l1d_flush_force_sigbus;
+		task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
+	}
+}
+
+static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif =3D task_thread_info(next)->flags;
-	unsigned long ibpb =3D (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_bits =3D (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_M=
ASK;
=20
-	return (unsigned long)next->mm | ibpb;
+	/*
+	 * Ensure that the bit shift above works as expected and the two flags
+	 * end up in bit 0 and 1.
+	 */
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH !=3D TIF_SPEC_IB + 1);
+
+	return (unsigned long)next->mm | spec_bits;
 }
=20
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigation(struct task_struct *next)
 {
+	unsigned long prev_mm, next_mm;
+
 	if (!next || !next->mm)
 		return;
=20
+	next_mm =3D mm_mangle_tif_spec_bits(next);
+	prev_mm =3D this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+
 	/*
+	 * Avoid user/user BTB poisoning by flushing the branch predictor
+	 * when switching between processes. This stops one process from
+	 * doing Spectre-v2 attacks on another.
+	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
 	 * same process. Using the mm pointer instead of mm->context.ctx_id
@@ -340,8 +397,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -371,20 +426,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm =3D mm_mangle_tif_spec_ib(next);
-		prev_mm =3D this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm !=3D prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
=20
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -393,11 +442,22 @@ static void cond_ibpb(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) !=3D next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=3D
+					(unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	if (static_branch_unlikely(&switch_mm_cond_l1d_flush)) {
+		/*
+		 * Flush L1D when the outgoing task requested it and/or
+		 * check whether the incoming task requested L1D flushing
+		 * and ended up on an SMT sibling.
+		 */
+		if (unlikely((prev_mm | next_mm) & LAST_USER_MM_L1D_FLUSH))
+			l1d_flush_evaluate(prev_mm, next_mm, next);
+	}
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
=20
 #ifdef CONFIG_PERF_EVENTS
@@ -531,11 +591,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct =
mm_struct *next,
 		need_flush =3D true;
 	} else {
 		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
+		 * Apply process to process speculation vulnerability
+		 * mitigations if applicable.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
=20
 		/*
 		 * Stop remote flushes for the previous mm.
@@ -643,7 +702,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
=20
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d88641..c048e59d3fbd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,16 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
=20
+#ifdef CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH
+	/*
+	 * If L1D flush is supported on mm context switch
+	 * then we use this callback head to queue kill work
+	 * to kill tasks that are not running on SMT disabled
+	 * cores
+	 */
+	struct callback_head		l1d_flush_kill;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c55323d..964c41ed303e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)

