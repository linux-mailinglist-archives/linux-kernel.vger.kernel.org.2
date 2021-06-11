Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5190D3A4863
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFKSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:45 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36601 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhFKSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:29 -0400
Received: by mail-wm1-f46.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so8656017wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/p/9eGT1B+K4ZIlz1Qxt98Bfdy/SrJfZDe5wrN1TjpI=;
        b=BgLA58MBug9EvhljlQ7xjuycO9wUkYLL6i6Uu6L5i0nSXOiot4Cmt1v3mrPfwtlmzV
         bkptIwI+8AXIp+vPomKEiHbhFTYbJC/Xevz9sS7mUQdc+7NTopsUi4wQkRqrLD1jVO6G
         /48yPZUQ2Ne06X2Pm/8fjh+PfiiFgHrdfTORF5SOSvA/SOjliY/t5FgJT2sfYrMmKkEz
         lOizvmYuQ/Ch9eH2iyFjm6ORMRa414FXblIdfxG1L5waWbg5qGkA5V+g/AhHI7zeA9D/
         oENqnSGSuzKwtS6WNCw/zPSjQwCyIpla7LReF7swGJM453624Ld7hfiNId40NZmOXzr9
         nBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/p/9eGT1B+K4ZIlz1Qxt98Bfdy/SrJfZDe5wrN1TjpI=;
        b=V1MFVfgkVhc91lGRhGv8wmdQdGzRQ39RgOidnaP+PI/7TjXoDBexgG5OSR1SXlzy+T
         i+GR+s2ffXbC+ejMStMoe0oZn1mUTCMYzPTwQvBQcPbqbX9L5vtleMaAlvCpWIiYO4uK
         orL00x7g5GoSEjEsNtJkzfkgXDMH97Leo8ujJ4Y3uksAwqgOG+c8T3afZ3+78WB91fQf
         1eQ3XXWYbxH4FM16EzvTYrWkx1bUjWRh33Pk7qCr1nk1hAZGgJnky++cTuU3knJLk/mz
         lf/GIzSsQYxoBrrIGVxNUpbAwDVG44/pyaXYtZzI8q5Ha37xb5FfcuqKK7cRhjSm7us0
         59/A==
X-Gm-Message-State: AOAM532sSJNAY4DRr3yFo79WeNXJfVRkQEbMlWrW+2HflzJMZCx+J4pu
        lIKCklRlQT4hdKl6dqXDfkg+DFiGH1gvZ4PJ
X-Google-Smtp-Source: ABdhPJxAMZnid/OtiS3TcJMnZiWqc09xhHLsL/UFmz/zvzzo+wKbzy+SFNVTywHN+E9brL0fbF7EoA==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr5142417wmg.44.1623434593723;
        Fri, 11 Jun 2021 11:03:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:13 -0700 (PDT)
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
Subject: [PATCH v3 15/23] x86/signal: Check if vdso_image_32 is mapped before trying to land on it
Date:   Fri, 11 Jun 2021 19:02:34 +0100
Message-Id: <20210611180242.711399-16-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide current_has_vdso(image) helper and check it apriory landing
attempt on vdso vma.
The helper is a macro, not a static inline funciton to avoid
linux/sched/task_stack.h inclusion in asm/vdso.h.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/common.c     | 10 +++++++++-
 arch/x86/ia32/ia32_signal.c |  4 ++--
 arch/x86/include/asm/vdso.h |  4 ++++
 arch/x86/kernel/signal.c    |  4 ++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b13ebd..385a1c4bf4c0 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -150,11 +150,19 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
 __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned long landing_pad;
+
+	if (!current_has_vdso(&vdso_image_32)) {
+		regs->ip = 0;
+		force_sigsegv(SIGSEGV);
+		syscall_exit_to_user_mode(regs);
+	}
+
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
+	landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
 
 	/*
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index adb6994c40f6..2af40ae53a0e 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -255,7 +255,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 		restorer = ksig->ka.sa.sa_restorer;
 	} else {
 		/* Return stub is in 32bit vsyscall page */
-		if (current->mm->context.vdso)
+		if (current_has_vdso(&vdso_image_32))
 			restorer = current->mm->context.vdso +
 				vdso_image_32.sym___kernel_sigreturn;
 		else
@@ -336,7 +336,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso(&vdso_image_32))
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..1ea7cb3f9b14 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -45,6 +45,10 @@ extern const struct vdso_image vdso_image_x32;
 extern const struct vdso_image vdso_image_32;
 #endif
 
+#define current_has_vdso(image)						\
+	(current->mm->context.vdso != 0 &&				\
+	current->mm->context.vdso_image == image)
+
 extern void __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 988cbc634949..77496ccb812d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -319,7 +319,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso(&vdso_image_32))
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
@@ -381,7 +381,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up to return from userspace.  */
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso(&vdso_image_32))
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
-- 
2.31.1

