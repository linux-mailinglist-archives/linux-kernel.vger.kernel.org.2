Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25463814DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhEOBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:12:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46137 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhEOBME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:12:04 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1ANfg3208415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:10:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1ANfg3208415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621041034;
        bh=Kb1O6t+m0dDz3AsUEA9nKOSClLRJdHVsJ9NbA5w0UCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxKjvgJ3vmqWaUjlnhT/0TCZTa5jGoTAiz9d5iDC31aEt9pBZhAeboDdcRqO5Ih68
         EZzksHEnw5eEbYTYaKkC1io0xlBv5FJ0Rqhba8iXvUWP7ZX6rMSJs50fswMjdL5Wg8
         TBsAJZw4XxijUDTxhNdDna9wQ0V1F1ZaAUuqu/BsNX6nC7SAOarFgs2AkElCe7LGVE
         X0hCB8ftnd285+OvHiuQ6gD0VYHKcrgVyf8phUcFviDNhawFGPoCfyIefo+Fn3zvex
         n4CSdqnSPYZrLlGqcXy+PUezYfmvlc/m1WMN5/u16KbK1Xrr3uiiiBpoOyneoGhW5J
         VvHp5IGh7hCaQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] x86/syscall: treat out of range and gap system calls the same
Date:   Fri, 14 May 2021 18:10:14 -0700
Message-Id: <20210515011015.2707542-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515011015.2707542-1-hpa@zytor.com>
References: <20210515011015.2707542-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The current 64-bit system call entry code treats out-of-range system
calls differently than system calls that map to a hole in the system
call table. This is visible to the user if system calls are
intercepted via ptrace or seccomp and the return value (regs->ax) is
modified: in the former case, the return value is preserved, and in
the latter case, sys_ni_syscall() is called and the return value is
forced to -ENOSYS.

For example, before this patch, 335 for x86-64 would force the exit
code to be set to -ENOSYS even if poked by ptrace, but 548 would not,
creating an observable difference between an out of range system call
and a system call number that falls outside the range of the tables.

The API spec in <asm-generic/syscalls.h> is very clear that only
(int)-1 is the non-system-call sentinel value, so make the system call
behavior consistent by calling sys_ni_syscall() for all invalid system
call numbers except for -1.

Although currently sys_ni_syscall() simply returns -ENOSYS, calling it
explicitly is friendly for tracing and future possible extensions, and
as this is an error path there is no reason to optimize it.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 00da0f5420de..f51bc17262db 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -52,6 +52,8 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
 					X32_NR_syscalls);
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
+	} else if (unlikely((int)nr != -1)) {
+		regs->ax = __x64_sys_ni_syscall(regs);
 	}
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
@@ -76,6 +78,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+	} else if (unlikely((int)nr != -1)) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
 
-- 
2.31.1

