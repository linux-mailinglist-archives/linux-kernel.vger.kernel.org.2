Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25F379736
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhEJSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:54:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37909 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhEJSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:46 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNlg2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNlg2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672812;
        bh=XW2xI9mQyvmteVzirDc4pCwKf03ZI3QdAzMh8DgfPMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/toyUaT3PGFUpMbk59NsiWK1PJDtKwGkdR4MmH7BzJF7A322GUNje9ExkBWI5RHn
         WL8uCdtNtwzPdE9Twz90WcnnOwA6/1c5kDHUvIz6rgHig9ZN6O4QBon62hqWgrfCsK
         /jb4mQaKBuMwmakCi+m+RfJpUWF/c5AQy6Ex1dHycfxM0PkBXjQdmdsICj9VQfYX/L
         Fs5miRmLXUKURgXhlI1Wt+PjaHIZwcZXd6zdbr+QQ1WY7MBvdRTKL0eX7JNu/x7cTE
         k6KROoiKqrDENvbTvr9ph8uStIhVMd2Dht+GkNCR7RcK4JOC37xhc7s1Eg/zcwY64w
         qH6vVf6jIuxYw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 4/7] x86/syscall: maximize MSR_SYSCALL_MASK
Date:   Mon, 10 May 2021 11:53:13 -0700
Message-Id: <20210510185316.3307264-5-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

It is better to clear as many flags as possible when we do a system
call entry, as opposed to the other way around. The fewer flags we
keep, the lesser the possible interference between the kernel and user
space.

The flags changed are:

CF, PF, AF, ZF, SF, OF: these are arithmetic flags which affect
branches, possibly speculatively. They should be cleared for the same
reasons we now clear all GPRs on entry.

RF: suppresses a code breakpoint on the subsequent instruction. It is
probably impossible to enter the kernel with RF set, but if it is
somehow not, it would break a kernel debugger setting a breakpoint on
the entry point. Either way, user space should not be able to control
kernel behavior here.

ID: this flag has no direct effect (it is a scratch bit only.)
However, there is no reason to retain the user space value in the
kernel, and the standard should be to clear unless needed, not the
other way around.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/kernel/cpu/common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c49a93..6cf697574661 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1773,10 +1773,16 @@ void syscall_init(void)
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
 #endif
 
-	/* Flags to clear on syscall */
+	/*
+	 * Flags to clear on syscall; clear as much as possible
+	 * to minimize user space-kernel interference.
+	 */
 	wrmsrl(MSR_SYSCALL_MASK,
-	       X86_EFLAGS_TF|X86_EFLAGS_DF|X86_EFLAGS_IF|
-	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
+	       X86_EFLAGS_CF|X86_EFLAGS_PF|X86_EFLAGS_AF|
+	       X86_EFLAGS_ZF|X86_EFLAGS_SF|X86_EFLAGS_TF|
+	       X86_EFLAGS_IF|X86_EFLAGS_DF|X86_EFLAGS_OF|
+	       X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_RF|
+	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
 #else	/* CONFIG_X86_64 */
-- 
2.31.1

