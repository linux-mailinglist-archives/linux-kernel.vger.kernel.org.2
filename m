Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC18C3EA4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhHLMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:31:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13417 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhHLMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:31:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GlmCY3sVLzcmmZ;
        Thu, 12 Aug 2021 20:27:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 20:30:45 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 20:30:44 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-hexagon@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-um@lists.infradead.org>,
        <linux-mm@kvack.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "Jonas Bonn" <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <palmerdabbelt@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next] trap: Cleanup trap_init()
Date:   Thu, 12 Aug 2021 20:36:02 +0800
Message-ID: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some empty trap_init() in different ARCHs, introduce
a new weak trap_init() function to cleanup them.

Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Walmsley <palmerdabbelt@google.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arc/kernel/traps.c      | 5 -----
 arch/arm/kernel/traps.c      | 5 -----
 arch/h8300/kernel/traps.c    | 4 ----
 arch/hexagon/kernel/traps.c  | 4 ----
 arch/nds32/kernel/traps.c    | 5 -----
 arch/nios2/kernel/traps.c    | 5 -----
 arch/openrisc/kernel/traps.c | 5 -----
 arch/parisc/kernel/traps.c   | 4 ----
 arch/powerpc/kernel/traps.c  | 5 -----
 arch/riscv/kernel/traps.c    | 5 -----
 arch/um/kernel/trap.c        | 4 ----
 init/main.c                  | 2 ++
 12 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 57235e5c0cea..6b83e3f2b41c 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -20,11 +20,6 @@
 #include <asm/unaligned.h>
 #include <asm/kprobes.h>
 
-void __init trap_init(void)
-{
-	return;
-}
-
 void die(const char *str, struct pt_regs *regs, unsigned long address)
 {
 	show_kernel_fault_diag(str, regs, address);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 64308e3a5d0c..e9b4f2b49bd8 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -781,11 +781,6 @@ void abort(void)
 	panic("Oops failed to kill thread");
 }
 
-void __init trap_init(void)
-{
-	return;
-}
-
 #ifdef CONFIG_KUSER_HELPERS
 static void __init kuser_init(void *vectors)
 {
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index 5d8b969cd8f3..bdbe988d8dbc 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -39,10 +39,6 @@ void __init base_trap_init(void)
 {
 }
 
-void __init trap_init(void)
-{
-}
-
 asmlinkage void set_esp0(unsigned long ssp)
 {
 	current->thread.esp0 = ssp;
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 904134b37232..edfc35dafeb1 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -28,10 +28,6 @@
 #define TRAP_SYSCALL	1
 #define TRAP_DEBUG	0xdb
 
-void __init trap_init(void)
-{
-}
-
 #ifdef CONFIG_GENERIC_BUG
 /* Maybe should resemble arch/sh/kernel/traps.c ?? */
 int is_valid_bugaddr(unsigned long addr)
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index ee0d9ae192a5..f06421c645af 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -183,11 +183,6 @@ void __pgd_error(const char *file, int line, unsigned long val)
 }
 
 extern char *exception_vector, *exception_vector_end;
-void __init trap_init(void)
-{
-	return;
-}
-
 void __init early_trap_init(void)
 {
 	unsigned long ivb = 0;
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index b172da4eb1a9..596986a74a26 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -105,11 +105,6 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	printk("%s\n", loglvl);
 }
 
-void __init trap_init(void)
-{
-	/* Nothing to do here */
-}
-
 /* Breakpoint handler */
 asmlinkage void breakpoint_c(struct pt_regs *fp)
 {
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 4d61333c2623..aa1e709405ac 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -231,11 +231,6 @@ void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 	die("Oops", regs, 9);
 }
 
-void __init trap_init(void)
-{
-	/* Nothing needs to be done */
-}
-
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 8d8441d4562a..747c328fb886 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -859,7 +859,3 @@ void  __init early_trap_init(void)
 
 	initialize_ivt(&fault_vector_20);
 }
-
-void __init trap_init(void)
-{
-}
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e103b89234cd..91efb5c6f2f3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2209,11 +2209,6 @@ DEFINE_INTERRUPT_HANDLER(kernel_bad_stack)
 	die("Bad kernel stack pointer", regs, SIGABRT);
 }
 
-void __init trap_init(void)
-{
-}
-
-
 #ifdef CONFIG_PPC_EMULATED_STATS
 
 #define WARN_EMULATED_SETUP(type)	.type = { .name = #type }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0a98fd0ddfe9..0daaa3e4630d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -199,11 +199,6 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-/* stvec & scratch is already set from head.S */
-void __init trap_init(void)
-{
-}
-
 #ifdef CONFIG_VMAP_STACK
 static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
 		overflow_stack)__aligned(16);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ad12f78bda7e..3198c4767387 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -311,7 +311,3 @@ void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	do_IRQ(WINCH_IRQ, regs);
 }
-
-void trap_init(void)
-{
-}
diff --git a/init/main.c b/init/main.c
index 4b4897b791fd..863e5087263d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -775,6 +775,8 @@ void __init __weak poking_init(void) { }
 
 void __init __weak pgtable_cache_init(void) { }
 
+void __init __weak trap_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
-- 
2.26.2

