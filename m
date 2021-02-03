Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68630E3D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBCUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBCUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:08:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:07:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84001e2b7e52dd5f0f2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:1e2b:7e52:dd5f:f2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 883071EC0257;
        Wed,  3 Feb 2021 21:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612382851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38wSyikznTFpte5lV/T1Lvh18Tw8swoxpSZ+gkgknlo=;
        b=dZvypFna//c08ncXVryx5AG5dIQVW6R8A6tN+ZysYxCtfKs50ZtzAG1NcgGqazKDVQp0rf
        hVREjyKrmXWgaigc7Z6YwhO5vM0IUgQm1yyEhs+7PR2wyKZkkLmOPzOct/jqzVF6MTYTcN
        hqv6wzxiu1w+aY7YA7lc06BxT8HBwok=
Date:   Wed, 3 Feb 2021 21:07:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to
 kernelmode_fixup_or_oops()
Message-ID: <20210203200729.GL13819@zn.tnic>
References: <20210203193949.GI13819@zn.tnic>
 <88AA1DD6-615B-4049-B335-F2F40F85EF08@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88AA1DD6-615B-4049-B335-F2F40F85EF08@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:53:03AM -0800, Andy Lutomirski wrote:
> I feel like that would be more obfuscated — then the function would
> return without fixing anything for usermode faults, return after
> fixing it for kernel mode faults, or oops.

You practically pretty much have it already with the WARN_ON_ONCE. And
you can make the thing return 1 to denote it was in user_mode() and 0
otherwise. IINMSO, something like this:

---
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 08f5f74cf989..2b86d541b181 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -692,11 +692,12 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
-static noinline void
+static noinline int
 kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 			 unsigned long address, int signal, int si_code)
 {
-	WARN_ON_ONCE(user_mode(regs));
+	if (WARN_ON_ONCE(user_mode(regs)))
+		return 1;
 
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
@@ -706,7 +707,7 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 		 * task context.
 		 */
 		if (in_interrupt())
-			return;
+			return 0;
 
 		/*
 		 * Per the above we're !in_interrupt(), aka. task context.
@@ -726,7 +727,7 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 		/*
 		 * Barring that, we can do the fixup and be happy.
 		 */
-		return;
+		return 0;
 	}
 
 	/*
@@ -734,9 +735,11 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 	 * instruction.
 	 */
 	if (is_prefetch(regs, error_code, address))
-		return;
+		return 0;
 
 	page_fault_oops(regs, error_code, address);
+
+	return 0;
 }
 
 /*
@@ -781,10 +784,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 {
 	struct task_struct *tsk = current;
 
-	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
+	if (!kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code))
 		return;
-	}
 
 	if (!(error_code & X86_PF_USER)) {
 		/* Implicit user access to kernel memory -- just oops */
@@ -913,10 +914,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
 	/* Kernel mode? Handle exceptions or die: */
-	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
+	if (!kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR))
 		return;
-	}
 
 	/* User-space => ok to do another page fault: */
 	if (is_prefetch(regs, error_code, address))
@@ -1378,10 +1377,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * Quick path to respond to signals.  The core mm code
 		 * has unlocked the mm for us if we get here.
 		 */
-		if (!user_mode(regs))
-			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
-		return;
+		if (!kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR))
+			return;
 	}
 
 	/*
@@ -1399,18 +1396,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
-	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
-		return;
+	if (fatal_signal_pending(current)) {
+		if (!kernelmode_fixup_or_oops(regs, error_code, address, 0, 0))
+			return;
 	}
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
-		if (!user_mode(regs)) {
-			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+		if (!kernelmode_fixup_or_oops(regs, error_code, address, SIGSEGV, SEGV_MAPERR))
 			return;
-		}
 
 		/*
 		 * We ran out of memory, call the OOM killer, and return the

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
