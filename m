Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0D38806A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351779AbhERTVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:21:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57173 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346055AbhERTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:21:12 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRr4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:19:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRr4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365587;
        bh=rEVPX4K+FRLCH9hy2XZJ9O+Ca0PlwLtYMKbAdX0fBGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFsyebiMQ+x0FB9TOGC/vAc/vN9reprMQj22h8MuMM2jYQrojnFVV1SV4lKtVCTaR
         xLphumyDPk3JFsd6RtPl2oSN2R0Uwb3bX4c7/gfDAPJ+im4ZT+qVqZZlPwEZLp6SJh
         LnNM3K9vzeVY7RhU4XlXwxOskRbdoMQTQ35l9GfdUINCjifRF+2UypcYuOHLBgqkdu
         XEyLJH2SCHWgHdGerLDlaIe9DQUK2w+jnftugsvVrI354f9Zk0Ne0+JO86QX7eEk7S
         x//a6+VD3pd4iHPrYb3Eb0foBmxylEbsuQaH7a4dYScYFM7avT0UyplL03vFDoht4U
         lXHayMsvoNzGA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] x86/syscall: treat out of range and gap system calls the same
Date:   Tue, 18 May 2021 12:13:02 -0700
Message-Id: <20210518191303.4135296-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
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

