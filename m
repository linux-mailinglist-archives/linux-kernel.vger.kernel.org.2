Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866FD3A46E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFKQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhFKQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4CC06124A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:35 -0700 (PDT)
Message-Id: <20210611163114.234412917@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Wxay/23O/RVynWHnicvwKy8g3lkrS4Et+OOphzguBok=;
        b=Xu8KzehfgE1wJbar/6ozHvGd2M9/BwT/kbYryZe/O6/hphy5kQXkpIVLEIw+hvx+ZiHiHT
        SlSbA3RAGzkxGhSeFsPHP/CKPVR0DWptuTPsAHg0R5gew70QhMc3tpLp1HUpWimb6Jy4v6
        YOt8/Z6E8+zEeQBS9yjcPvkcXSG+CneGCABsEGLCQMeE2WN9Wyb9eETcbiMD8mNGFrxY/A
        npjlfYf8iPjMhqRooosTLY68Sv2sQ+qlnrmNR8G/GoPv1/mkZH5YabDXj7215uDBzWFWlB
        mZp1IcpHEIa5AG6IXzuAFl2mdNmb7LCNMRIy3LEOYgcJNdwSWxfNA/cZLXkZNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Wxay/23O/RVynWHnicvwKy8g3lkrS4Et+OOphzguBok=;
        b=AkL7s7aSYhcBmsf0g5D/j0cRlQsNxy2H2MbNPXe0bXeTZpATzT5zkLZMP5Q4VkCiMAob4T
        1ZowwwVc2fM+ANCw==
Date:   Fri, 11 Jun 2021 18:15:53 +0200
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
Subject: [patch 30/41] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear what the function is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
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
@@ -407,9 +407,9 @@ void fpu__clear_user_states(struct fpu *
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

