Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC0315CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhBJCMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhBJA44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:56:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CFC061793
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:42 -0800 (PST)
Message-Id: <20210210002513.289960691@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hj0MRfC3Qj3PKcksofMHXXfIeX7p3i3twCyRr8QegvA=;
        b=DajxyYBHvgT8co4f3keEmhP5LQ/DNhBZ5aln5b32BXThVCBmaMfvonRxMxESZKDYrk4VSn
        iPDkBT2LCCO2ceBhVGl8Hk6H0rkxJZagY/gKJKgiBjBc+OBDMWNcKurs14IhOgKqoqMngk
        zo931RIl+CebWRkwgBTF+Oon+B5NW1pxkLuUYY4nVVJHd8zu7YI5ckJ97vDl5NNBoK/d9M
        o031B31ZJAC4AtjvhxWXA21JzOfS5peoyQUyZ9LfoGPqBuTFnO+e/KWXWZDQz/aOwgltt9
        qIpCTgjWF//IZoa5Tr6c+YpqhV/7HH5qL1HmONerXyuWMw0Wm3NbyRCGjxHKow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hj0MRfC3Qj3PKcksofMHXXfIeX7p3i3twCyRr8QegvA=;
        b=PwXZAQFocVJgPiDS6N7KF3h2rCZirogyjF+ddWtIQyr3sY54bbJfpvEeg1BBfuRFayzMgg
        c4FvTnyBKpLvjsDA==
Date:   Wed, 10 Feb 2021 00:40:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 12/13] softirq: Move do_softirq_own_stack() to generic asm header
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid include recursion hell move the do_softirq_own_stack() related
content into a generic asm header and include it from all places in arch/
which need the prototype.

This allows architectures to provide an inline implementation of
do_softirq_own_stack() without introducing a lot of #ifdeffery all over the
place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
---
V2: New patch to get rid of the nested #ifdeffery - Lai
---
 arch/parisc/kernel/irq.c            |    1 +
 arch/powerpc/kernel/irq.c           |    1 +
 arch/s390/kernel/irq.c              |    1 +
 arch/sh/kernel/irq.c                |    1 +
 arch/sparc/kernel/irq_64.c          |    1 +
 arch/x86/kernel/irq_32.c            |    1 +
 arch/x86/kernel/irq_64.c            |    1 +
 include/asm-generic/Kbuild          |    1 +
 include/asm-generic/softirq_stack.h |   14 ++++++++++++++
 include/linux/interrupt.h           |    9 ---------
 kernel/softirq.c                    |    2 ++
 11 files changed, 24 insertions(+), 9 deletions(-)

--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
+#include <asm/softirq_stack.h>
 #include <asm/smp.h>
 #include <asm/ldcw.h>
 
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
 #include <asm/hw_irq.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/stacktrace.h>
+#include <asm/softirq_stack.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <asm/thread_info.h>
 #include <cpu/mmu_context.h>
+#include <asm/softirq_stack.h>
 
 atomic_t irq_err_count;
 
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -42,6 +42,7 @@
 #include <asm/head.h>
 #include <asm/hypervisor.h>
 #include <asm/cacheflush.h>
+#include <asm/softirq_stack.h>
 
 #include "entry.h"
 #include "cpumap.h"
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -22,6 +22,7 @@
 
 #include <asm/apic.h>
 #include <asm/nospec-branch.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/softirq_stack.h>
 #include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -51,6 +51,7 @@ mandatory-y += sections.h
 mandatory-y += serial.h
 mandatory-y += shmparam.h
 mandatory-y += simd.h
+mandatory-y += softirq_stack.h
 mandatory-y += switch_to.h
 mandatory-y += timex.h
 mandatory-y += tlbflush.h
--- /dev/null
+++ b/include/asm-generic/softirq_stack.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
+#define __ASM_GENERIC_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+void do_softirq_own_stack(void);
+#else
+static inline void do_softirq_own_stack(void)
+{
+	__do_softirq();
+}
+#endif
+
+#endif
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,15 +569,6 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
-void do_softirq_own_stack(void);
-#else
-static inline void do_softirq_own_stack(void)
-{
-	__do_softirq();
-}
-#endif
-
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -26,6 +26,8 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 
+#include <asm/softirq_stack.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
 

