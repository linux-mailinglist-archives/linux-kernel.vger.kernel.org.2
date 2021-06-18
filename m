Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5A3ACEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhFRPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:24:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhFRPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:25 -0400
Message-Id: <20210618143449.628751239@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SI7vuBe5CNvZMh7PC/sa2z16XJAs+KgTW4Ug4pWHXLs=;
        b=Z6lwNq98Kfa9zubZnNB2VPYog6lH+g7yN+EZ1nueTCjoNWdNNjxcprnWnKKAPrlJ8xiXqw
        5pPkDdBV9xT4CCnwNmoh8Gs3bL97wRomsf7qV3eP4D92drRYBpLUiZFPMvQ/9F+rAliR8c
        Aiz61Mr9oYZlnqKlNNevr24ehVJXnhWgDYEFNX+mtAb1d0sTGQ81kKauMoRAxCFGzi/7im
        rhpzXORSnHZg0M1vCouqzX5AX1/de03dbkye82QZkPjQjguXNbBCpOK0aaJW/qsIo4kUso
        3E/fW9PDO5IiJRTpOSXCVfzHV7EQPJXONHFql5+Mg5IK/5WAFaZKosODt/xuPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SI7vuBe5CNvZMh7PC/sa2z16XJAs+KgTW4Ug4pWHXLs=;
        b=ZFXfY1oJSJOepAIeJQsEXnNHUqDsrJ7VcviWKU4gjx7gb84KW7k7tYF84H+jzYx1NKIaZW
        qqOvnloxejxm9tDA==
Date:   Fri, 18 Jun 2021 16:19:09 +0200
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
Subject: [patch V3 46/66] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear what the function is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    3 ++-
 arch/x86/kernel/fpu/core.c          |    4 ++--
 arch/x86/kernel/process.c           |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -29,12 +29,13 @@
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
-extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
 extern void fpu_sync_fpstate(struct fpu *fpu);
 
+/* Clone and exit operations */
 extern int  fpu_clone(struct task_struct *dst);
+extern void fpu_flush_thread(void);
 
 /*
  * Boot time FPU initialization functions:
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -350,9 +350,9 @@ void fpu__clear_user_states(struct fpu *
 	fpu__clear(fpu, true);
 }
 
-void fpu__clear_all(struct fpu *fpu)
+void fpu_flush_thread(void)
 {
-	fpu__clear(fpu, false);
+	fpu__clear(&current->thread.fpu, false);
 }
 
 /*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -205,7 +205,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear_all(&tsk->thread.fpu);
+	fpu_flush_thread();
 }
 
 void disable_TSC(void)

