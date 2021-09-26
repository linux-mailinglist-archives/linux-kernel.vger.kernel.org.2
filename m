Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4166D41881D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhIZKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhIZKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:31:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6DC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 03:30:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632652210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OECXPz6HXc6s917ctb9xe2FHznKFBR7ehy/R6+rIpQg=;
        b=AEoRG5fkI172lKI6sT0LneSGMhSwDcaiLAzF0e0l6rTaz5t43K8wWXmjIFLelBBaKN1u5W
        yJOQCfftoy6JYWajppQPIVFxQDG+q700EFNsIcnTlPaNx7zedguwbU107hqTuzzuhS6hZC
        2wZYzAwQZ6b1ThgRP740f9vLAl3DlPwqTM+SM0IerMXd+p/+CmnqYkffOv2bY9cEGD1fJL
        Gt3XWIz7x4dou3O01ArG8flHTyiOIzVcWEWTBW+i70ifduLhzChQRFuMGZc1wvcUzdkoHK
        ps9mVRqgJVfPks/1olo+Y/ZHnOp9F2YNburh86J83M/fGkRDYqkZTDnCw6M3Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632652210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OECXPz6HXc6s917ctb9xe2FHznKFBR7ehy/R6+rIpQg=;
        b=qrWDQoCEu8nrXmFwfKpNbGqJRGW+fLqrnhh+o8yw0WYhy7ZxTVHsShqelf1GtRISGIw0dk
        IVB2tswwNeOsFFDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.15-rc3
References: <163265189226.178609.9712455554034472888.tglx@xen13>
Message-ID: <163265189517.178609.6605494600326137493.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 26 Sep 2021 12:30:09 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-=
09-26

up to:  5ba1071f7554: x86/insn, tools/x86: Fix undefined behavior due to pote=
ntial unaligned accesses


A set of fixes for X86:

 - Prevent sending the wrong signal when protection keys are enabled and
   the kernel handles a fault in the vsyscall emulation.

 - Invoke early_reserve_memory() before invoking e820_memory_setup() which
   is required to make the Xen dom0 e820 hooks work correctly.

 - Use the correct data type for the SETZ operand in the EMQCMDS
   instruction wrapper.

 - Prevent undefined behaviour to the potential unaligned accesss in the
   instroction decoder library.

Thanks,

	tglx

------------------>
Jiashuo Liang (1):
      x86/fault: Fix wrong signal when vsyscall fails with pkey

Juergen Gross (1):
      x86/setup: Call early_reserve_memory() earlier

Kees Cook (1):
      x86/asm: Fix SETZ size enqcmds() build failure

Numfor Mbiziwo-Tiapo (1):
      x86/insn, tools/x86: Fix undefined behavior due to potential unaligned =
accesses


 arch/x86/include/asm/pkeys.h         |  2 --
 arch/x86/include/asm/special_insns.h |  2 +-
 arch/x86/kernel/setup.c              | 26 ++++++++++++++------------
 arch/x86/lib/insn.c                  |  4 ++--
 arch/x86/mm/fault.c                  | 26 ++++++++++++++++++--------
 include/linux/pkeys.h                |  2 ++
 tools/arch/x86/lib/insn.c            |  4 ++--
 7 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 5c7bcaa79623..1d5f14aff5f6 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
=20
-#define ARCH_DEFAULT_PKEY	0
-
 /*
  * If more than 16 keys are ever supported, a thorough audit
  * will be necessary to ensure that the types that store key
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/spec=
ial_insns.h
index f3fbb84ff8a7..68c257a3de0d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const void *=
src)
 {
 	const struct { char _[64]; } *__src =3D src;
 	struct { char _[64]; } __iomem *__dst =3D dst;
-	int zf;
+	bool zf;
=20
 	/*
 	 * ENQCMDS %(rdx), rax
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 79f164141116..40ed44ead063 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -830,6 +830,20 @@ void __init setup_arch(char **cmdline_p)
=20
 	x86_init.oem.arch_setup();
=20
+	/*
+	 * Do some memory reservations *before* memory is added to memblock, so
+	 * memblock allocations won't overwrite it.
+	 *
+	 * After this point, everything still needed from the boot loader or
+	 * firmware or kernel text should be early reserved or marked not RAM in
+	 * e820. All other memory is free game.
+	 *
+	 * This call needs to happen before e820__memory_setup() which calls the
+	 * xen_memory_setup() on Xen dom0 which relies on the fact that those
+	 * early reservations have happened already.
+	 */
+	early_reserve_memory();
+
 	iomem_resource.end =3D (1ULL << boot_cpu_data.x86_phys_bits) - 1;
 	e820__memory_setup();
 	parse_setup_data();
@@ -876,18 +890,6 @@ void __init setup_arch(char **cmdline_p)
=20
 	parse_early_param();
=20
-	/*
-	 * Do some memory reservations *before* memory is added to
-	 * memblock, so memblock allocations won't overwrite it.
-	 * Do it after early param, so we could get (unlikely) panic from
-	 * serial.
-	 *
-	 * After this point everything still needed from the boot loader or
-	 * firmware or kernel text should be early reserved or marked not
-	 * RAM in e820. All other memory is free game.
-	 */
-	early_reserve_memory();
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 058f19b20465..c565def611e2 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
=20
 #define __get_next(t, insn)	\
-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); leXX_to_cp=
u(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D sizeof=
(t); leXX_to_cpu(t, r); })
=20
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r =3D *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
=20
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, in=
sn); })
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefdefc108..84a2c8c4af73 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -710,7 +710,8 @@ page_fault_oops(struct pt_regs *regs, unsigned long error=
_code,
=20
 static noinline void
 kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address, int signal, int si_code)
+			 unsigned long address, int signal, int si_code,
+			 u32 pkey)
 {
 	WARN_ON_ONCE(user_mode(regs));
=20
@@ -735,8 +736,12 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned =
long error_code,
=20
 			set_signal_archinfo(address, error_code);
=20
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
+			if (si_code =3D=3D SEGV_PKUERR) {
+				force_sig_pkuerr((void __user *)address, pkey);
+			} else {
+				/* XXX: hwpoison faults will set the wrong code. */
+				force_sig_fault(signal, si_code, (void __user *)address);
+			}
 		}
=20
 		/*
@@ -798,7 +803,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned lon=
g error_code,
 	struct task_struct *tsk =3D current;
=20
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGSEGV, si_code, pkey);
 		return;
 	}
=20
@@ -930,7 +936,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code,=
 unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGBUS, BUS_ADRERR, ARCH_DEFAULT_PKEY);
 		return;
 	}
=20
@@ -1396,7 +1403,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 */
 		if (!user_mode(regs))
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
 		return;
 	}
=20
@@ -1416,7 +1424,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
=20
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 0, 0, ARCH_DEFAULT_PKEY);
 		return;
 	}
=20
@@ -1424,7 +1433,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+						 SIGSEGV, SEGV_MAPERR,
+						 ARCH_DEFAULT_PKEY);
 			return;
 		}
=20
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 6beb26b7151d..86be8bf27b41 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -4,6 +4,8 @@
=20
 #include <linux/mm.h>
=20
+#define ARCH_DEFAULT_PKEY	0
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 #include <asm/pkeys.h>
 #else /* ! CONFIG_ARCH_HAS_PKEYS */
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index c41f95815480..797699462cd8 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
=20
 #define __get_next(t, insn)	\
-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); leXX_to_cp=
u(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D sizeof=
(t); leXX_to_cpu(t, r); })
=20
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r =3D *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
=20
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, in=
sn); })

