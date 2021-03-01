Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F27327F47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhCANSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:18:21 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36802 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhCANSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:06 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7S026106;
        Mon, 1 Mar 2021 22:15:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7S026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604542;
        bh=Uj/w33doMEPc1pk+Fe2UT0I8Ph5yO71n2VzPawTfuH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLunmKlxWrVYRqwHlVtF+9PRaBM7Nflc+1Ro6uB8xFH/Iq2TePVYJsJrGiaHYc3tC
         9tEZuRSyjUPvB7F2GAkKVwfyYWrwrIf+eYkWC/KRV7HQ3rc5qYeAb3uqyhNk9GWubF
         8eSskNyktTdEQzNh/IwCGcaLiVDTEM8KZKSO9pndOlCMZaj4HN9tGIsvgbxEVME9i3
         2QFxHj/voDZ6LtNlODKOCJ3bVyfgCUVdo7QZDyKsQTsYqKWMhhjq1mt4WDSkTocSOZ
         +By/EV7s82q2Q9uzUTOm5Pw84KOeg3sncvXvkq/7YuFjdp2Y338aB1mnMqZALqb8aQ
         0Lf5/GSxbnNyg==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/7] x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
Date:   Mon,  1 Mar 2021 22:15:26 +0900
Message-Id: <20210301131533.64671-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
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

