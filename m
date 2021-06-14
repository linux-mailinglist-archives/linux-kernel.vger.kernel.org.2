Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C933A6C34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhFNQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhFNQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:45 -0400
Message-Id: <20210614155358.398680069@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=D6DGhgjhjXP0Deok4wCKLgyswZnQtSL8WbNQ5coXTiw=;
        b=IOu7FNH6mcKOvIHAsgBtPCkj+1npx/8iSgFgEf7vBSq5i1H6+JsmURexqwbjzO5g5Ih4kM
        QDJdK0xRKq5guB1PlWDwxsAe/abQtS6/AkAj/zHvYtweDY1MI4nEOxRVmMDd7NfuOV2Z0N
        wWMzrEwkiHomsmc9cNqlRM+j4L+x3OcbM+xhlmH6nltWHFVDljqvc9vZqnccLWTyD4QoLO
        o9WK1tDed+zcE3YX32zI/rkYnEhU1qODC5a7I/jrWrFoy1z6ROJnd+1hXoKdMX1IuYKDZn
        OLlZ6QKSlcbuJzk+sRaE0JGcrPWWswvXQnysXkUTsxvZXowO1QL+TBTXKk3BZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=D6DGhgjhjXP0Deok4wCKLgyswZnQtSL8WbNQ5coXTiw=;
        b=jqKtNyerULqqzk2hBut0J3ih6iTAZbP9I8ocnBmCDP4m5K2nQERu9v8FHGBRXFpHmdWO3J
        RPJWDRDa3NvLp2CA==
Date:   Mon, 14 Jun 2021 17:44:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 46/52] x86/fpu: Add PKRU storage outside of task XSAVE buffer
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

PKRU is currently partly XSAVE-managed and partly not.  It has space in the
task XSAVE buffer and is context-switched by XSAVE/XRSTOR.  However, it is
switched more eagerly than FPU because there may be a need for PKRU to be
up-to-date for things like copy_to/from_user() since PKRU affects
user-permission memory accesses, not just accesses from userspace itself.

This leaves PKRU in a very odd position.  XSAVE brings very little value to
the table for how Linux uses PKRU except for signal related XSTATE
handling.

Prepare to move PKRU away from being XSAVE-managed.  Allocate space in the
thread_struct for it and save/restore it in the context-switch path
separately from the XSAVE-managed features. task->thread_struct.pkru is
only valid when the task is scheduled out. For the current task the
authoritative source is the hardware, i.e. it has to be retrieved via
rdpkru().

Leave the XSAVE code in place for now to ensure bisectability.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    9 +++++++++
 arch/x86/kernel/process.c        |    7 +++++++
 arch/x86/kernel/process_64.c     |   25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,15 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+	/*
+	 * Protection Keys Register for Userspace.  Loaded immediately on
+	 * context switch. Store it in thread_struct to avoid a lookup in
+	 * the tasks's FPU xstate buffer. This value is only valid when a
+	 * task is scheduled out. For 'current' the authoritative source of
+	 * PKRU is the hardware itself.
+	 */
+	u32			pkru;
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -157,11 +157,18 @@ int copy_thread(unsigned long clone_flag
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
 		kthread_frame_init(frame, sp, arg);
 		return 0;
 	}
 
+	/*
+	 * Clone current's PKRU value from hardware. tsk->thread.pkru
+	 * is only valid when scheduled out.
+	 */
+	p->thread.pkru = rdpkru();
+
 	frame->bx = 0;
 	*childregs = *current_pt_regs();
 	childregs->ax = 0;
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -340,6 +340,29 @@ static __always_inline void load_seg_leg
 	}
 }
 
+/*
+ * Store prev's PKRU value and load next's PKRU value if they differ. PKRU
+ * is not XSTATE managed on context switch because that would require a
+ * lookup in the task's FPU xsave buffer and require to keep that updated
+ * in various places.
+ */
+static __always_inline void x86_pkru_load(struct thread_struct *prev,
+					  struct thread_struct *next)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	/* Stash the prev task's value: */
+	prev->pkru = rdpkru();
+
+	/*
+	 * PKRU writes are slightly expensive.  Avoid them when not
+	 * strictly necessary:
+	 */
+	if (prev->pkru != next->pkru)
+		wrpkru(next->pkru);
+}
+
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
@@ -589,6 +612,8 @@ void compat_start_thread(struct pt_regs
 
 	x86_fsgsbase_load(prev, next);
 
+	x86_pkru_load(prev, next);
+
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */

