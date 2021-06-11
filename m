Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94D3A4860
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhFKSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:37 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39572 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhFKSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:20 -0400
Received: by mail-wr1-f49.google.com with SMTP id l2so6980979wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfAcIuTq5CnuWyntpoGNkE4Sv+IHXRUzDJ1kHDVBenA=;
        b=F3E9sLQ/TNaE7Foj6Qak44P8HwY9udmbPsCEKFmUm/cEnO5z1aOTqCHxIhOfd2sB8O
         JLc7wFm9Agp8MWZqdK/oIads5vR89YzyVpzAA84E0BJ0XEzmdDeynjWJ86icHA0lVVYa
         VL447yP5sexGyYeYtTChQR9bAD6QtfodW/HWATLsOWrrdtRrK8k2A9bA7+x2FwrNk4+M
         btoedNv8N/USjdvAgsgHnayfJH9+8wWp8kKq0RiEERrmsrFM51f0ZFiyohkXFIY1iZCa
         zuZRwUIx1pE5GqgJRLzEJmmmlIyUtk0giVlIgPMFwlflR4VeUb1ldRXu1C+2r2D1ucqu
         2ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfAcIuTq5CnuWyntpoGNkE4Sv+IHXRUzDJ1kHDVBenA=;
        b=M3Q1gFIw6wmhwmffjpjD2q8ldPDkUAzozKDh02pdfQImsQ6PnJpMCsrCq4flEqf4F9
         S4E1HVIleTxBZdv4tqmpBsGsoJUfE6MFNF2nWkTgbg/5ZEaYxx+KMbl6gtZcFjDP8w5o
         13efJYNndnh8vlPaTqn4ucK7sFMFK82i1BCZ+8FUfCKarpArCzu50HVYAypNjDze9408
         5byUt+5GIJAUL7yL/YrdeTUyzXvh8Cvv5aYgqQ0zqu+DKVbB8RamwjX/l3gZ7ACmLQ8o
         R1yeUEbjj2mxUGUe4ldSjXd7I6qi6+uFFmK2cwd433GSEbnP4TZUmlsQj/KSSfG1m98B
         1sag==
X-Gm-Message-State: AOAM530KHoI3fVlcdz70+k/Nf+Q1RHt98JJQ1q64phvxaYfC6sgFVZPb
        NsepMOvwfeC0Wrmy6nZVV/BF/pQwSMj6Fyb6
X-Google-Smtp-Source: ABdhPJwj/HXwAnqhQ1YtRNPfR5r0TuGqP/fXy0LZN5ynyw4mmmc/fKfUbgjixans+DsRO0+ZAItPig==
X-Received: by 2002:adf:f044:: with SMTP id t4mr5432844wro.73.1623434591944;
        Fri, 11 Jun 2021 11:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:11 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 14/23] x86/signal: Land on &frame->retcode when vdso isn't mapped
Date:   Fri, 11 Jun 2021 19:02:33 +0100
Message-Id: <20210611180242.711399-15-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
a.out signals") after processing 32-bit signal if there is no vdso
mapped frame->retcode is used as a landing.
Do the same for rt ia32 signals.
It also makes the ia32 compat signals match the native ia32 case.

This shouldn't be mistaken for encouragement for running binaries with
executable stack, rather something to do in hopefully very rare
situation with disabled or unmapped vdso and absent SA_RESTORER.
For non-executable stack it'll segfault on attempt to land, rather than
land on a random address where vdso was previously mapped.
For programs with executable stack it'll just do the same for rt signals
as for non-rt.

Discouraging users to run with executable stack is done separately in
commit 47a2ebb7f505 ("execve: warn if process starts with executable
stack").

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/ia32/ia32_signal.c | 12 +++++++-----
 arch/x86/kernel/signal.c    | 23 ++++++++++-------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7fd5fb..adb6994c40f6 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -270,8 +270,8 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 	/*
-	 * These are actually not used anymore, but left because some
-	 * gdb versions depend on them as a marker.
+	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	user_access_end();
@@ -336,14 +336,16 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else
+	else if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
+	else
+		restorer = &frame->retcode;
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 
 	/*
-	 * Not actually used anymore, but left because some gdb
-	 * versions need it.
+	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..988cbc634949 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -317,23 +317,20 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	unsafe_put_user(sig, &frame->sig, Efault);
 	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	if (current->mm->context.vdso)
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
 		restorer = &frame->retcode;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
 
 	/* Set up to return from userspace.  */
 	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
 	/*
 	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
 	user_access_end();
@@ -382,18 +379,18 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
 	/* Set up to return from userspace.  */
-	restorer = current->mm->context.vdso +
-		vdso_image_32.sym___kernel_rt_sigreturn;
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
+	else if (current->mm->context.vdso)
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+	else
+		restorer = &frame->retcode;
 	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
 	/*
 	 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-- 
2.31.1

