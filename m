Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35A3A6C25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhFNQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhFNQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:38 -0400
Message-Id: <20210614155357.768575720@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4ayP9qQjw12xaPI4juOhDbYrjAL9DCbVJJjGRENKtGI=;
        b=ZOc9PSkfSsqznqTLS7FdQOqm2Ys8kYagLH20uZQVGMJATIJBPD3nKJmwzwHScJotMxnQgt
        XnaRJzWKcUqxVhwDiv76PBqFos3+MyI68OOFNIrEKgEwtLqYQyknZ1kauwrIt4RwEN7ZlW
        vV4DQdtbOdOr4ljeQw9MNToysE+vnxGzdUVW8pLPt4bAzfYtE9cEsduRordPvgxPsJL4wg
        yYZk4uSsJUSZyAjriWeNchX5YcDMFT941yRHdJUouSoZbZsXxLvK0/XR3kWZIeMirjmKAh
        FFLHQ3xhqHGLLEKukBLNPt8/zQsx98EXY6lGgVplShLHkxJYg5H0zsH5Hastfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4ayP9qQjw12xaPI4juOhDbYrjAL9DCbVJJjGRENKtGI=;
        b=qxqqfbw/zhYzfFx/b1kKj00mWSi51WlGKh9f0m1x4Cr5de7Y1dnImDdj1ukY58ZL57m5vK
        pPqa87e6QQRA3EAQ==
Date:   Mon, 14 Jun 2021 17:44:48 +0200
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
Subject: [patch V2 40/52] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
References: <20210614154408.673478623@linutronix.de>
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
@@ -33,9 +33,10 @@ extern int  fpu__restore_sig(void __user
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
-extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
+extern void fpu_flush_thread(void);
+
 /*
  * Boot time FPU initialization functions:
  */
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -417,9 +417,9 @@ void fpu__clear_user_states(struct fpu *
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
@@ -206,7 +206,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear_all(&tsk->thread.fpu);
+	fpu_flush_thread();
 }
 
 void disable_TSC(void)

