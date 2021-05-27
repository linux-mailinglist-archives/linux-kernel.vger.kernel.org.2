Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FC3939DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhE0X7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:59:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:10250 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235419AbhE0X7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:13 -0400
IronPort-SDR: ZNhtzg/XlkKFSbn5plCL3jxz7KEiQoJIciMqdR4nN5xzkyx/Cqo3v1bpbm+6+n9i7wVlbKx0lm
 nRzP/9vaB9Cw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="190229900"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="190229900"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:39 -0700
IronPort-SDR: u94T1XDD7Dmcee1joPlPmeDtJMVGzdmoKzdBUrssqKMN9paNoZiQy0TBxCBQ52Mfx8PnK8C2Eh
 8vMcaG1ZArXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="398394082"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2021 16:57:39 -0700
Subject: [PATCH 4/5] x86/pkeys: replace PKRU modification infrastructure
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:18 -0700
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Message-Id: <20210527235118.88C9831B@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

There are two points in the kernel which write to PKRU in a buggy way:

 * In switch_fpu_finish(), where having xfeatures[PKRU]=0 will result
   in PKRU being assigned 'init_pkru_value' instead of 0x0.
 * In write_pkru(), xfeatures[PKRU]=0 will result in PKRU having the
   correct value, but the XSAVE buffer will remain stale because
   xfeatures is not updated.

Both of them screw up the fact that get_xsave_addr() will return NULL
for PKRU when it is in the XSAVE "init state".  This went unnoticed
until now because on Intel hardware XINUSE[PKRU] is never 0 because
of the kernel policy around 'init_pkru_value'.  AMD hardware, on the
other hand, can set XINUSE[PKRU]=0 via a normal WRPKRU(0).  The
handy selftests somewhat accidentally produced a case[2] where
WRPKRU(0) occurs.

get_xsave_addr() is a horrible interface[1], especially when used for
writing state.  It is too easy for callers to be tricked into thinking:
 1. On a NULL return that they have no work to do
 2. On a valid pointer return that they *can* safely write state
    without doing more work like setting an xfeatures bit.

Wrap get_xsave_addr() with some additional infrastructure.  Ensure
that callers must declare their intent to read or write to the state.
Inject the init state into both reads *and* writes.  This ensures
that writers never have to deal with detritus from previous state.

The new common xstate infrastructure:

	xstatebuf_get_write_ptr()
and
	xfeature_init_space()

should be quite usable for other xfeatures with trivial updates to
xfeature_init_space().  My hope is that we can move away from
all use of get_xsave_addr(), replacing it with things like
xstate_read_pkru().

The new BUG_ON()s are not great.  But, they do represent a severe
violation of expectations and XSAVE state can be security-sensitive
and these represent a truly dazed-and-confused situation.

1. I know, I wrote it.  I'm really sorry.
2. https://lore.kernel.org/linux-kselftest/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 0d714dba1626 ("x86/fpu: Update xstate's PKRU value on write_pkru()")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

 b/arch/x86/include/asm/fpu/internal.h |    8 --
 b/arch/x86/include/asm/fpu/xstate.h   |  111 +++++++++++++++++++++++++++++++---
 b/arch/x86/include/asm/processor.h    |    7 ++
 b/arch/x86/kernel/cpu/common.c        |    6 -
 b/arch/x86/mm/pkeys.c                 |    6 -
 5 files changed, 115 insertions(+), 23 deletions(-)

diff -puN arch/x86/include/asm/fpu/internal.h~write_pkru arch/x86/include/asm/fpu/internal.h
--- a/arch/x86/include/asm/fpu/internal.h~write_pkru	2021-05-27 16:40:26.903705463 -0700
+++ b/arch/x86/include/asm/fpu/internal.h	2021-05-27 16:40:26.919705463 -0700
@@ -564,7 +564,6 @@ static inline void switch_fpu_prepare(st
 static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
 	u32 pkru_val = init_pkru_value;
-	struct pkru_state *pk;
 
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
@@ -578,11 +577,8 @@ static inline void switch_fpu_finish(str
 	 * PKRU state is switched eagerly because it needs to be valid before we
 	 * return to userland e.g. for a copy_to_user() operation.
 	 */
-	if (current->mm) {
-		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		if (pk)
-			pkru_val = pk->pkru;
-	}
+	if (current->mm)
+		pkru_val = xstate_read_pkru(&new_fpu->state.xsave);
 	__write_pkru(pkru_val);
 
 	/*
diff -puN arch/x86/include/asm/fpu/xstate.h~write_pkru arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~write_pkru	2021-05-27 16:40:26.906705463 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:26.919705463 -0700
@@ -124,27 +124,124 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
+static inline void xfeature_mark_non_init(struct xregs_state *xstate,
+					  int xfeature_nr)
+{
+	/*
+	 * Caller will place data in the @xstate buffer.
+	 * Mark the xfeature as non-init:
+	 */
+	xstate->header.xfeatures |= BIT_ULL(xfeature_nr);
+}
+
+
+/* Set the contents of @xfeature_nr to the hardware init state */
+static inline void xfeature_init_space(struct xregs_state *xstate,
+					     int xfeature_nr)
+{
+	void *state = get_xsave_addr(xstate, xfeature_nr);
+
+	switch (xfeature_nr) {
+	case XFEATURE_PKRU:
+		/* zero the whole state, including reserved bits */
+		memset(state, 0, sizeof(struct pkru_state));
+		break;
+	default:
+		BUG();
+	}
+}
+
+/*
+ * Called when it is necessary to write to an XSAVE
+ * component feature.  Guarantees that a future
+ * XRSTOR of the 'xstate' buffer will not consider
+ * @xfeature_nr to be in its init state.
+ *
+ * The returned buffer may contain old state.  The
+ * caller must be prepared to fill the entire buffer.
+ *
+ * Caller must first ensure that @xfeature_nr is
+ * enabled and present in the @xstate buffer.
+ */
+static inline void *xstatebuf_get_write_ptr(struct xregs_state *xstate,
+					    int xfeature_nr)
+{
+	bool feature_was_init = xstate->header.xfeatures & BIT_ULL(xfeature_nr);
+
+	/*
+	 * xcomp_bv represents whether 'xstate' has space for
+	 * features.  If not, something is horribly wrong and
+	 * a write would corrupt memory.  Perhaps xfeature_nr
+	 * was not enabled.
+	 */
+	BUG_ON(!(xstate->header.xcomp_bv & BIT_ULL(xfeature_nr)));
+
+	/*
+	 * Ensure a sane xfeature_nr, including avoiding
+	 * confusion with XCOMP_BV_COMPACTED_FORMAT.
+	 */
+	BUG_ON(xfeature_nr >= XFEATURE_MAX);
+
+	/* Prepare xstate for a write to the xfeature: */
+	xfeature_mark_non_init(xstate, xfeature_nr);
+
+	/*
+	 * If xfeature_nr was in the init state, update the buffer
+	 * to match the state. Ensures that callers can safely
+	 * write only a part of the state, they are not forced to
+	 * write it in its entirety.
+	 */
+	if (feature_was_init)
+		xfeature_init_space(xstate, xfeature_nr);
+
+	return get_xsave_addr(xstate, xfeature_nr);
+}
+
+/* Caller must ensure X86_FEATURE_OSPKE is enabled. */
+static inline void xstate_write_pkru(struct xregs_state *xstate, u32 pkru)
+{
+	struct pkru_state *pk;
+
+	pk = xstatebuf_get_write_ptr(xstate, XFEATURE_PKRU);
+	pk->pkru = pkru;
+}
+
+/*
+ * What PKRU value is represented in the 'xstate'?  Note,
+ * this returns the *architecturally* represented value,
+ * not the literal in-memory value.  They may be different.
+ */
+static inline u32 xstate_read_pkru(struct xregs_state *xstate)
+{
+	struct pkru_state *pk;
+
+	pk = get_xsave_addr(xstate, XFEATURE_PKRU);
+	/*
+	 * If present, pull PKRU out of the XSAVE buffer.
+	 * Otherwise, use the hardware init value.
+	 */
+	if (pk)
+		return pk->pkru;
+	else
+		return PKRU_HW_INIT_VALUE;
+}
+
 /*
  * Update all of the PKRU state for the current task:
  * PKRU register and PKRU xstate.
  */
 static inline void current_write_pkru(u32 pkru)
 {
-	struct pkru_state *pk;
-
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
 		return;
 
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
+	fpregs_lock();
 	/*
 	 * The PKRU value in xstate needs to be in sync with the value that is
 	 * written to the CPU. The FPU restore on return to userland would
 	 * otherwise load the previous value again.
 	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
+	xstate_write_pkru(&current->thread.fpu.state.xsave, pkru);
 	__write_pkru(pkru);
 	fpregs_unlock();
 }
diff -puN arch/x86/include/asm/processor.h~write_pkru arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~write_pkru	2021-05-27 16:40:26.908705463 -0700
+++ b/arch/x86/include/asm/processor.h	2021-05-27 16:40:26.921705463 -0700
@@ -854,4 +854,11 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+/*
+ * The XSAVE architecture defines an "init state" for
+ * PKRU.  PKRU is set to this value by XRSTOR when it
+ * tries to restore PKRU but has on value in the buffer.
+ */
+#define PKRU_HW_INIT_VALUE	0x0
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff -puN arch/x86/kernel/cpu/common.c~write_pkru arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~write_pkru	2021-05-27 16:40:26.912705463 -0700
+++ b/arch/x86/kernel/cpu/common.c	2021-05-27 16:40:26.924705463 -0700
@@ -466,8 +466,6 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	struct pkru_state *pk;
-
 	/* check the boot processor, plus compile options for PKU: */
 	if (!cpu_feature_enabled(X86_FEATURE_PKU))
 		return;
@@ -478,9 +476,7 @@ static __always_inline void setup_pku(st
 		return;
 
 	cr4_set_bits(X86_CR4_PKE);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (pk)
-		pk->pkru = init_pkru_value;
+	xstate_write_pkru(&current->thread.fpu.state.xsave, init_pkru_value);
 	/*
 	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
diff -puN arch/x86/mm/pkeys.c~write_pkru arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~write_pkru	2021-05-27 16:40:26.914705463 -0700
+++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:26.926705463 -0700
@@ -155,7 +155,6 @@ static ssize_t init_pkru_read_file(struc
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -178,10 +177,7 @@ static ssize_t init_pkru_write_file(stru
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (!pk)
-		return -EINVAL;
-	pk->pkru = new_init_pkru;
+	xstate_write_pkru(&init_fpstate.xsave, new_init_pkru);
 	return count;
 }
 
_
