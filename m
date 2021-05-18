Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B0388069
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351766AbhERTVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:21:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34281 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245640AbhERTVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:21:11 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRq4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:19:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRq4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365586;
        bh=XUvDPrh0Jj+2YNXinVNeh9+bG2huq575EoX7onR3xdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irvxk992d8SuismCuuYP82J3S5UkK0Z8rCw9DSw76rmXHmLdw/yxpx84Q8xVlsofK
         n+4ls2+cqpAJyYkbdzZhRzRz2SYEsveM4j+q0RFZDe6guuVaPO/QvXiOj9zJVs5hEl
         KwVELd2hOAe+jr8o1X1PxodO0S9LhvCRmG8ENlcf7RCX+qVqG8ZKjO146RT+0bI6Eq
         23+hi0scSBpSjrbUl4XH5qTHa4IRwR5Bw1OZY9QpOGet58blztdVgiSJHEDmgqZYS3
         +Q8qCpuJlNjx8ZEvWxnL231MJQhQ01xX82lnE5fTPJpzkyOkdA7mcDLGVeDX9hemVd
         JuMN2iHhgeO6w==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] x86/syscall: sign-extend system calls on entry to int
Date:   Tue, 18 May 2021 12:13:01 -0700
Message-Id: <20210518191303.4135296-5-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Right now, *some* code will treat e.g. 0x0000000100000001 as a system
call and some will not. Some of the code, notably in ptrace, will
treat 0x000000018000000 as a system call and some will not. Finally,
right now, e.g. 335 for x86-64 will force the exit code to be set to
-ENOSYS even if poked by ptrace, but 548 will not, because there is an
observable difference between an out of range system call and a system
call number that falls outside the range of the table.

This is visible to the user: for example, the syscall_numbering_64
test fails if run under strace, because as strace uses ptrace, it ends
up clobbering the upper half of the 64-bit system call number.

The arch-independent code all assumes that a system call is "int" that
the value -1 specifically and not just any negative value is used for
a non-system call. This is the case on x86 as well when
arch-independent code is involved. The arch-independent API is
defined/documented (but not *implemented*!) in
<asm-generic/syscall.h>.

This is an ABI change, but is in fact a revert to the original x86-64
ABI. The original assembly entry code would zero-extend the system
call number; this patch uses sign extend to be explicit that this is
treated as a signed number (although in practice it makes no
difference, of course) and to avoid people getting the idea of
"optimizing" it, as has happened on at least two(!) separate
occasions.

Do not store the extended value into regs->orig_ax, however: on
x86-64, the ABI is that the callee is responsible for extending
parameters, so only examining the lower 32 bits is fully consistent
with any "int" argument to any system call, e.g. regs->di for
write(2). The full value of %rax on entry to the kernel is thus still
available.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1d9db15fdc69..85f04ea0e368 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -108,7 +108,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 
 	/* IRQs are off. */
 	movq	%rsp, %rdi
-	movq	%rax, %rsi
+	movslq	%eax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
-- 
2.31.1

