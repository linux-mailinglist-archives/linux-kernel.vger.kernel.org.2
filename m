Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3E410CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhISS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhISS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 14:29:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 11:28:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632076091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sVxmp2bJcSuLQ6jQMK2JI8+e3nUS5C2bfeq7OcAdKyc=;
        b=mo8Lml06zkg3eUEQv1sFLzI7+RkqWYOrmO1fFXJuaGsM00VCcJ+nhCI516yEjFDbeYKK95
        45Jeky0DO6TSjmPagTtAm+CBCbRCiSReNDEAo+5XYunfc1QvxNgaKxljty2Ei50aIYpz7i
        fMu2rxr8372hSQwNMS3NBFCzX1AbC26/BCt8Op14OeY5ZlEPpJSHXA/9wYLDh9zvBIoLpX
        bfAcxziCjGE26oU0hTkuWvZleH9xP4iRHCUgRUdcvN2QZ0eo1iRaTX51fYK2P9yTo2AbVa
        Af5ZZsKtnfGmHCwhFsiYLd5Vi0/IuQtni1HlU3LOxnvq/Pin6fXXylVURSzqfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632076091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sVxmp2bJcSuLQ6jQMK2JI8+e3nUS5C2bfeq7OcAdKyc=;
        b=wZUlypSpm0nyiQiY7aFoKNL9bYiYTtdSfvpOHjSlRY3vYcqcLojobAkniIPtTvZdV4fzl+
        WqNGOGD39M1Bf+AA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.15-rc2
References: <163207602242.947088.16824174748243890514.tglx@xen13>
Message-ID: <163207602540.947088.6038710845965846842.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Sep 2021 20:28:10 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-=
09-19

up to:  1c1046581f1a: x86/setup: Call early_reserve_memory() earlier


A set of x86 fixes:

  - Prevent a infinite loop in the MCE recovery on return to user space,
    which was caused by a second MCE queueing work for the same page and
    thereby creating a circular work list.

  - Make kern_addr_valid() handle existing PMD entries, which are marked not
    present in the higher level page table, correctly instead of blindly
    dereferencing them.

  - Invoke early_reserve_memory() earlier as the current place is too late
    for Xen dom0.

  - Pass a valid address to sanitize_phys(). This was caused by the mixture
    of inclusive and exclusive ranges. memtype_reserve() expect 'end' being
    exclusive, but sanitize_phys() wants it inclusive. This worked so far,
    but with end being the end of the physical address space the fail is
    exposed.=20

 - Increase the maximum supported GPIO numbers for 64bit. Newer SoCs exceed
   the previous maximum.

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      x86/platform: Increase maximum GPIO number for X86_64

Jeff Moyer (1):
      x86/pat: Pass valid address to sanitize_phys()

Juergen Gross (1):
      x86/setup: Call early_reserve_memory() earlier

Mike Rapoport (1):
      x86/mm: Fix kern_addr_valid() to cope with existing but not present ent=
ries

Tony Luck (1):
      x86/mce: Avoid infinite loop for copy from user recovery


 arch/x86/Kconfig               |  5 +++++
 arch/x86/kernel/cpu/mce/core.c | 43 +++++++++++++++++++++++++++++++---------=
--
 arch/x86/kernel/setup.c        | 26 +++++++++++++------------
 arch/x86/mm/init_64.c          |  6 +++---
 arch/x86/mm/pat/memtype.c      |  7 ++++++-
 include/linux/sched.h          |  1 +
 6 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 421fa9e38c60..10163887c5eb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -340,6 +340,11 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
=20
+config ARCH_NR_GPIO
+	int
+	default 1024 if X86_64
+	default 512
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
=20
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8cb7816d03b4..193204aee880 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1253,6 +1253,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_re=
gs *regs, struct mce *fin
=20
 static void kill_me_now(struct callback_head *ch)
 {
+	struct task_struct *p =3D container_of(ch, struct task_struct, mce_kill_me);
+
+	p->mce_count =3D 0;
 	force_sig(SIGBUS);
 }
=20
@@ -1262,6 +1265,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	int flags =3D MF_ACTION_REQUIRED;
 	int ret;
=20
+	p->mce_count =3D 0;
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_a=
ddr);
=20
 	if (!p->mce_ripv)
@@ -1290,17 +1294,34 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 }
=20
-static void queue_task_work(struct mce *m, int kill_current_task)
+static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 {
-	current->mce_addr =3D m->addr;
-	current->mce_kflags =3D m->kflags;
-	current->mce_ripv =3D !!(m->mcgstatus & MCG_STATUS_RIPV);
-	current->mce_whole_page =3D whole_page(m);
+	int count =3D ++current->mce_count;
=20
-	if (kill_current_task)
-		current->mce_kill_me.func =3D kill_me_now;
-	else
-		current->mce_kill_me.func =3D kill_me_maybe;
+	/* First call, save all the details */
+	if (count =3D=3D 1) {
+		current->mce_addr =3D m->addr;
+		current->mce_kflags =3D m->kflags;
+		current->mce_ripv =3D !!(m->mcgstatus & MCG_STATUS_RIPV);
+		current->mce_whole_page =3D whole_page(m);
+
+		if (kill_current_task)
+			current->mce_kill_me.func =3D kill_me_now;
+		else
+			current->mce_kill_me.func =3D kill_me_maybe;
+	}
+
+	/* Ten is likely overkill. Don't expect more than two faults before task_wo=
rk() */
+	if (count > 10)
+		mce_panic("Too many consecutive machine checks while accessing user data",=
 m, msg);
+
+	/* Second or later call, make sure page address matches the one from first =
call */
+	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) !=3D (m->addr >> PAGE_SH=
IFT))
+		mce_panic("Consecutive machine checks to different user pages", m, msg);
+
+	/* Do not call task_work_add() more than once */
+	if (count > 1)
+		return;
=20
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
@@ -1438,7 +1459,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
=20
-		queue_task_work(&m, kill_current_task);
+		queue_task_work(&m, msg, kill_current_task);
=20
 	} else {
 		/*
@@ -1456,7 +1477,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
=20
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, msg, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bff3a784aec5..90951587a247 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -766,6 +766,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned=
 long v, void *p)
=20
 void __init setup_arch(char **cmdline_p)
 {
+	/*
+	 * Do some memory reservations *before* memory is added to memblock, so
+	 * memblock allocations won't overwrite it.
+	 *
+	 * After this point, everything still needed from the boot loader or
+	 * firmware or kernel text should be early reserved or marked not RAM in
+	 * e820. All other memory is free game.
+	 *
+	 * This call needs to happen before e820__memory_setup() which calls
+	 * xen_memory_setup() on Xen dom0 which relies on the fact that those
+	 * early reservations have happened already.
+	 */
+	early_reserve_memory();
+
 #ifdef CONFIG_X86_32
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
=20
@@ -885,18 +899,6 @@ void __init setup_arch(char **cmdline_p)
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
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ddeaba947eb3..879886c6cc53 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1433,18 +1433,18 @@ int kern_addr_valid(unsigned long addr)
 		return 0;
=20
 	p4d =3D p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
+	if (!p4d_present(*p4d))
 		return 0;
=20
 	pud =3D pud_offset(p4d, addr);
-	if (pud_none(*pud))
+	if (!pud_present(*pud))
 		return 0;
=20
 	if (pud_large(*pud))
 		return pfn_valid(pud_pfn(*pud));
=20
 	pmd =3D pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
+	if (!pmd_present(*pmd))
 		return 0;
=20
 	if (pmd_large(*pmd))
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 3112ca7786ed..4ba2a3ee4bce 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -583,7 +583,12 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_=
mode req_type,
 	int err =3D 0;
=20
 	start =3D sanitize_phys(start);
-	end =3D sanitize_phys(end);
+
+	/*
+	 * The end address passed into this function is exclusive, but
+	 * sanitize_phys() expects an inclusive address.
+	 */
+	end =3D sanitize_phys(end - 1) + 1;
 	if (start >=3D end) {
 		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
 				start, end - 1, cattr_name(req_type));
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1780260f237b..361c7bc72cbb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1468,6 +1468,7 @@ struct task_struct {
 					mce_whole_page : 1,
 					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
+	int				mce_count;
 #endif
=20
 #ifdef CONFIG_KRETPROBES

