Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66753814DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhEOBMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:12:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49493 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234695AbhEOBMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:12:06 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1ANfe3208415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:10:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1ANfe3208415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621041033;
        bh=EWbuXT8VrYiElBygFqDjnUQOosqFKNB90somHLMigyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4TUoVJrdbWYw/0KeZ8O7IsxpwL2inmmA6whIDJkFXFl80T96cO5xF8TtxJgtOVWJ
         s/BQtcrEWwgZJTWlC00SL4xHOk+UCA23hQOt4yN6tdDWTqZhJgoYbbbZW/zC9bT8op
         R/QXKoQzODT2Sp040Z+vbvnLcyFUv3TW31JPVGscGzU7iXS4vjTJWICxiy/62o+fHP
         YLkyONj5Gf5GnRih6XYn+Kll0kf4bLe5Ar9mzCuJveBiacIhjr9nsSHVsqO/XHlW0s
         iRg3kmcy4UGW6+E6EECS3oYS7g8qF1je74bpY0aWKTLFueE/SA6i/T6i1BqCpF6sIz
         sv6x/R+t4vDJQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] x86/syscall: sign-extend system calls on entry to int
Date:   Fri, 14 May 2021 18:10:12 -0700
Message-Id: <20210515011015.2707542-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515011015.2707542-1-hpa@zytor.com>
References: <20210515011015.2707542-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Right now, *some* code will treat e.g. 0x00000001_00000001 as a system
call and some will not. Some of the code, notably in ptrace and
seccomp, will treat 0x00000001_ffffffff as a system call and some will
not.

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

