Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE70C394B14
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhE2ISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhE2ISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9AC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f22so5058628pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64Ppw+8eZr45mQzRPA9wYcPQX7DF6Dz0wSFq/bdSzpE=;
        b=e7S4yq13r4Jwerr2tCohAEOYlKqRdhP/fAr776R10rw/1Zfc9s1eamLPrxXiAV3t+A
         TR++7c4Uu/I6mWy6oWYo/+fovw/iGAcVkU0N5dvHZ2FCqc+4h39l1GRfJ2Fs5N4Ulljt
         alxvecf3u1uvMJdTs5gRmal3gKYDl9RFn0mJXxwP6UMIrqQZRG7OhDUBl+2SsFdB+G91
         ZVH9YkO9LOLVqJegs8bVG0zPuvfgR9nOMx7BPDiJN65LVft0QNT1ioeAXT9/8nd9ybxi
         Tl6TO1XMG6InoDAPbtqUHqklIB/lwei0H3dexPhaVqFThGUT8o5Rr8ikH5ei3kwkgXPi
         +u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64Ppw+8eZr45mQzRPA9wYcPQX7DF6Dz0wSFq/bdSzpE=;
        b=gMNRmWBPZTCemPgeLRToAp53cmEkrc+OAfbkZqIKiJwF/9G1nb/kpzFt8gEcBS+WAW
         tUEzKAy8V417dT658n5fdlcV+XgQ971R3lGNluzYq/z4BBBaZolbOmUzAzctGO3DkDY2
         /k30IjU35BbE/nwqn9FEb/bOhpMoQmKv11/6tfN7ooauUdaYHkJIS9ASvzZdXCuRayoE
         T3qiotd1BEZBafRvDpbFI2y7ZShOTEQY1ICUjubEDRjO+69vcoNYJUzzFTG2/nc6cuS0
         qPFAIwo2dZUukL9IaLtbtzu46TvD7+lQ4qyIx5DSo32W04dFwHG0Kh77aoKbgSlUR97t
         HFUQ==
X-Gm-Message-State: AOAM531TMNYk/5Ou+356OQ1UgtTtp3oMbGgylA3bKaw0oTRGYfSu3BIu
        G5zspQs76eFLz76CSZZDnHLMUhp2fI3DgsXY
X-Google-Smtp-Source: ABdhPJwhDMnKUowMWXMtS3G0p7CW15qs4CgC7ZIj6ZCZTTEXvqNiSnMW3Izk7Ii80iKkpiGSt7XB8A==
X-Received: by 2002:a62:3106:0:b029:25c:cd66:3be1 with SMTP id x6-20020a6231060000b029025ccd663be1mr7632405pfx.29.1622276214039;
        Sat, 29 May 2021 01:16:54 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id b12sm6613960pgs.52.2021.05.29.01.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:16:53 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: [PATCH 3/4] arm64: Enable userspace syscall dispatch
Date:   Sat, 29 May 2021 01:16:19 -0700
Message-Id: <20210529081620.164422-4-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Houdek.Ryan@fex-emu.org>

When `PR_SET_SYSCALL_USER_DISPATCH` is used this will set the thread's
flags to enable `TIF_SYSCALL_USER_DISPATCH`.

This allows us to support userspace dispatch of syscalls through SIGSYS.
This has feature parity with what is available on x86-64

Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/syscall.h     |  2 ++
 arch/arm64/include/asm/thread_info.h |  4 +++-
 arch/arm64/kernel/ptrace.c           | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/syscall.c          |  9 +++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..8c5f2d1c7053 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -220,6 +220,7 @@ config ARM64
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
+	select SYSCALL_USER_DISPATCH
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..8f6417822139 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -94,4 +94,6 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6623c99f0984..7b9c6225c3c7 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -81,6 +81,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_SYSCALL_USER_DISPATCH 27 /* Allow userspace syscall dispatch */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -97,6 +98,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_SYSCALL_USER_DISPATCH (1 << TIF_SYSCALL_USER_DISPATCH)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
@@ -105,7 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU | _TIF_SYSCALL_USER_DISPATCH)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index eb2f73939b7b..ddff7d916592 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
+#include <linux/syscall_user_dispatch.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
 #include <linux/smp.h>
@@ -1836,6 +1837,16 @@ int syscall_trace_enter(struct pt_regs *regs)
 {
 	unsigned long flags = READ_ONCE(current_thread_info()->flags);
 
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (flags & _TIF_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return NO_SYSCALL;
+	}
+
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 		if (flags & _TIF_SYSCALL_EMU)
@@ -1859,6 +1870,19 @@ void syscall_trace_exit(struct pt_regs *regs)
 {
 	unsigned long flags = READ_ONCE(current_thread_info()->flags);
 
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (flags & _TIF_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 263d6c1a525f..2630cffe5725 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -15,6 +15,7 @@
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 long compat_arm_syscall(struct pt_regs *regs, int scno);
 long sys_ni_syscall(void);
@@ -191,3 +192,11 @@ void do_el0_svc_compat(struct pt_regs *regs)
 		       compat_sys_call_table);
 }
 #endif
+
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	if (regs->pc == (unsigned long)VDSO_SYMBOL(current->mm->context.vdso,
+		vdso_sigreturn_landing_pad))
+		return true;
+	return false;
+}
-- 
2.30.2

