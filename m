Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F23939DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhE0X7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:59:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:51095 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235437AbhE0X7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:41 -0400
IronPort-SDR: EBxQa1/syJaKF41qD1IIL5kq/43cLMLgUQ1Movzo3Ucb4ihfiZ8xi3tKa1oBXdhdPs+mWumEyG
 dm1VnDILqAyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="200969205"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="200969205"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:33 -0700
IronPort-SDR: yD/NbNm0YpzjCdn1XHFOqeXCAlkAigTM8S/w8sGOQLElDaLB+al68vr387z6prMfvaj6YU57xc
 eytDWg4WXIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="397944347"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2021 16:57:33 -0700
Subject: [PATCH 1/5] x86/pkeys: move read_pkru() and write_pkru()
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:11 -0700
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Message-Id: <20210527235111.11857E30@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

write_pkru() was originally used just to write to the PKRU register.  It
was mercifully short and sweet and was not out of place in pgtable.h with
some other pkey-related code.

But, later work included a requirement to also modify the task XSAVE
buffer when updating the register.  This really is more related to the
XSAVE architecture than to paging.

Move the read/write_pkru() to asm/fpu/xstate.h.  pgtable.h won't miss them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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

 b/arch/x86/include/asm/fpu/xstate.h |   29 +++++++++++++++++++++++++++++
 b/arch/x86/include/asm/pgtable.h    |   29 -----------------------------
 b/arch/x86/kernel/process_64.c      |    1 +
 b/arch/x86/kvm/svm/sev.c            |    1 +
 b/arch/x86/kvm/x86.c                |    1 +
 b/arch/x86/mm/pkeys.c               |    1 +
 6 files changed, 33 insertions(+), 29 deletions(-)

diff -puN arch/x86/include/asm/fpu/xstate.h~move-write_pkru arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~move-write_pkru	2021-05-27 16:40:23.110705472 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:23.132705472 -0700
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/processor.h>
+#include <asm/fpu/api.h>
 #include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
@@ -116,4 +117,32 @@ void copy_kernel_to_dynamic_supervisor(s
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr);
 
+static inline u32 read_pkru(void)
+{
+	if (boot_cpu_has(X86_FEATURE_OSPKE))
+		return rdpkru();
+	return 0;
+}
+
+static inline void write_pkru(u32 pkru)
+{
+	struct pkru_state *pk;
+
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
+
+	/*
+	 * The PKRU value in xstate needs to be in sync with the value that is
+	 * written to the CPU. The FPU restore on return to userland would
+	 * otherwise load the previous value again.
+	 */
+	fpregs_lock();
+	if (pk)
+		pk->pkru = pkru;
+	__write_pkru(pkru);
+	fpregs_unlock();
+}
+
 #endif
diff -puN arch/x86/include/asm/pgtable.h~move-write_pkru arch/x86/include/asm/pgtable.h
--- a/arch/x86/include/asm/pgtable.h~move-write_pkru	2021-05-27 16:40:23.114705472 -0700
+++ b/arch/x86/include/asm/pgtable.h	2021-05-27 16:40:23.135705472 -0700
@@ -126,35 +126,6 @@ static inline int pte_dirty(pte_t pte)
 	return pte_flags(pte) & _PAGE_DIRTY;
 }
 
-
-static inline u32 read_pkru(void)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return rdpkru();
-	return 0;
-}
-
-static inline void write_pkru(u32 pkru)
-{
-	struct pkru_state *pk;
-
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
-	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
-	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
-}
-
 static inline int pte_young(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_ACCESSED;
diff -puN arch/x86/kernel/process_64.c~move-write_pkru arch/x86/kernel/process_64.c
--- a/arch/x86/kernel/process_64.c~move-write_pkru	2021-05-27 16:40:23.117705472 -0700
+++ b/arch/x86/kernel/process_64.c	2021-05-27 16:40:23.138705472 -0700
@@ -41,6 +41,7 @@
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
+#include <asm/fpu/xstate.h>
 #include <asm/fpu/internal.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
diff -puN arch/x86/kvm/svm/sev.c~move-write_pkru arch/x86/kvm/svm/sev.c
--- a/arch/x86/kvm/svm/sev.c~move-write_pkru	2021-05-27 16:40:23.121705472 -0700
+++ b/arch/x86/kvm/svm/sev.c	2021-05-27 16:40:23.142705472 -0700
@@ -16,6 +16,7 @@
 #include <linux/swap.h>
 #include <linux/processor.h>
 #include <linux/trace_events.h>
+#include <asm/fpu/xstate.h>
 #include <asm/fpu/internal.h>
 
 #include <asm/trapnr.h>
diff -puN arch/x86/kvm/x86.c~move-write_pkru arch/x86/kvm/x86.c
--- a/arch/x86/kvm/x86.c~move-write_pkru	2021-05-27 16:40:23.125705472 -0700
+++ b/arch/x86/kvm/x86.c	2021-05-27 16:40:23.150705472 -0700
@@ -66,6 +66,7 @@
 #include <asm/desc.h>
 #include <asm/mce.h>
 #include <linux/kernel_stat.h>
+#include <asm/fpu/xstate.h>
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
 #include <asm/div64.h>
diff -puN arch/x86/mm/pkeys.c~move-write_pkru arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~move-write_pkru	2021-05-27 16:40:23.128705472 -0700
+++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:23.151705472 -0700
@@ -10,6 +10,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/fpu/xstate.h>		/* read/write_pkru()		*/
 #include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
_
