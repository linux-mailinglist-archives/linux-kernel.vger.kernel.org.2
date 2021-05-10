Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6F379734
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhEJSyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:54:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33959 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhEJSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:46 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNle2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNle2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672811;
        bh=2LKWBhmlryOyoH7c5b8z8yJCT3lhEHvp6CAA16dVfLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJQqwTQS/76LnMAMdRMmTljgMHuSXMCpZNJ0RdDY64vkeSzv1d+th7UGNopRTrjM5
         tkvoMEJ50YM3ukv56k8GqymfvY2ES5E0zqVkuaXk+POwyyPRQrRUfUociy/XZ2Vk9N
         JVuVFzv4RPN5lKP541zOPonc3sH+HNhNTHyEU7g2VD4I9HxeA5nuRDwkhjgMJYEj2b
         OT/oa2mFAOTYUOmyyZbFYyWxQKwqYr0M9szm0tBoIaqFkAIhioyyPZN14vIGyNrjG2
         hWt4cmulOpV8Hm+ilchult8WPpO2IrZi3zV5k/nXkDieaEZEB2E9XKHXtt+362v+Zj
         RKQvvqYteMiZg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 2/7] x86/entry: reverse arguments to do_syscall_64()
Date:   Mon, 10 May 2021 11:53:11 -0700
Message-Id: <20210510185316.3307264-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Reverse the order of arguments to do_syscall_64() so that the first
argument is the pt_regs pointer. This is not only consistent with
*all* other entry points from assembly, but it actually makes the
compiled code slightly better.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/common.c        | 2 +-
 arch/x86/entry/entry_64.S      | 4 ++--
 arch/x86/include/asm/syscall.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b13ebd..00da0f5420de 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,7 +36,7 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a16a5294d55f..1d9db15fdc69 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -107,8 +107,8 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	/* IRQs are off. */
-	movq	%rax, %rdi
-	movq	%rsp, %rsi
+	movq	%rsp, %rdi
+	movq	%rax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733d11af..4e20054d7533 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -160,7 +160,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(unsigned long nr, struct pt_regs *regs);
+void do_syscall_64(struct pt_regs *regs, unsigned long nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
-- 
2.31.1

