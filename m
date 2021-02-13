Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1631A9EE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 06:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBME74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 23:59:56 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:57396 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBME7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 23:59:48 -0500
Received: from localhost.localdomain (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11D4vMBT030692;
        Sat, 13 Feb 2021 13:57:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11D4vMBT030692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613192243;
        bh=Uj/w33doMEPc1pk+Fe2UT0I8Ph5yO71n2VzPawTfuH4=;
        h=From:To:Cc:Subject:Date:From;
        b=XCDPc/K4S7wB0UEBf5Yp58JRIyvSnB0qqu90hISkQtaa4aR4+AE5ASrklyPefdm8Z
         6sFrhdjwFs5+A+M5wHTZgVg8jXJBeBjWsagZbwyQr2HBpaTxjR0rbhS00vWBeRZKcT
         8HIHpqhYBCBSpupMAvMpDe0s772pwEWUoQ2G5oxRxJUM6dhkHIvMOtw4xAm/HwY7C+
         XWe9nsPzhgtE5fBMcE+elzuqYBEAC8b1RdMaA1hE58VvijOXpr47hVA/NOGvGE104/
         nL8+PfUfW6220BWERHihHAah1/gmW+dMRRuc6hHAWXc5nUJefNUb7p7PMm1/u1aXk6
         V6SPDxhemXS8w==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micka=8F=AB=B3l=20Sala=8F=AB=E4n?= 
        <mic@linux.microsoft.com>, Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/2] x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
Date:   Sat, 13 Feb 2021 13:57:19 +0900
Message-Id: <20210213045720.238157-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building kernel/sys_ni.c with W=1 emits tons of -Wmissing-prototypes
warnings.

$ make W=1 kernel/sys_ni.o
  [ snip ]
  CC      kernel/sys_ni.o
In file included from kernel/sys_ni.c:10:
./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
   83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
  100 |  __COND_SYSCALL(x64, sys_##name)
      |  ^~~~~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
  256 |  __X64_COND_SYSCALL(name)     \
      |  ^~~~~~~~~~~~~~~~~~
kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
   39 | COND_SYSCALL(io_setup);
      | ^~~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
   83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
  120 |  __COND_SYSCALL(ia32, sys_##name)
      |  ^~~~~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
  257 |  __IA32_COND_SYSCALL(name)
      |  ^~~~~~~~~~~~~~~~~~~
kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
   39 | COND_SYSCALL(io_setup);
      | ^~~~~~~~~~~~
  ...

__SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
declarations. Let's do likewise for __COND_SYSCALL() to fix the
warnings.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Mickaël Salaün <mic@linux.microsoft.com>
---

 arch/x86/include/asm/syscall_wrapper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..80c08c7d5e72 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	}
 
 #define __COND_SYSCALL(abi, name)					\
+	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
 	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
 	{								\
 		return sys_ni_syscall();				\
-- 
2.27.0

