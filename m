Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAF39CBE8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFFAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:20 -0400
Message-Id: <20210606001323.954313826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=++UmkY4CXB23H0JK1wXdOjQblwdqjcQjMDM5vmPbdO8=;
        b=oCOG+f5a552g4r6nv+O28QKs6lZWHNz1qnPaPUX1MQtj+GifEyttPT5BxQtaE8KYvcOX2p
        Hofd/RfQsJviLLXL8kya45OpKnmbhA7j615cKjlXAcsjzmO948KS14u3qPkAqBVNXrfsoA
        tdC9SM1ELcYaRxkz5tjI1AENb3CNh21yUEtsC8i0c9kck7QGXl/RVYo04MBzA/bQUf0Ylt
        2Uxujo1OXvRiOg/EgjYyVknYeQEueRi/3CzGS3F5+g3a6J85a1Gg1jg9Bcp3HnfI21lZOd
        NXBzKvJUEk9WbBRWngly1fH4XzMnhJWJYdUXWCGdoLYuvR5XIsWtD6E5FOPYQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=++UmkY4CXB23H0JK1wXdOjQblwdqjcQjMDM5vmPbdO8=;
        b=qeXOUc5lXXq+ZmWf1JXEWS2CCVKvTKEOhw0yad3LkIAwXToV63jBJU9ez/pTAECLca1o7v
        DCru6v3D5e9bOrDw==
Date:   Sun, 06 Jun 2021 01:47:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 10/14] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
References: <20210605234742.712464974@linutronix.de>
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
@@ -402,9 +402,9 @@ void fpu__clear_user_states(struct fpu *
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

