Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4497F40EBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhIPVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhIPVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:08:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N43Uhgo0DQNKmivJ+AXtrxW74Hb4By7l9dPAXojWeVc=; b=XrcTetY4cT0UHFn/qggyPEfWyM
        z3LnQwp1BkT1Y6330gBshWLxNOHkuXhvn5OHbYDdj1catBmE2Tf3h2QtwVY/dTyTDVYq+9N9F1ndL
        FsJJJPHZh/HyU1eMv3YQ0y44bKD/Ap8RyWoYn5sDu0cEv6AA3sYJN5PAzZjOWLOuaIRGk9mLahi0L
        tspgbyyehsvMljrPKevszqAfI8SOUC+iE6evVDOVo3wWkF5AtzDwUCM/46cdRWdd+9Ae4WBVCcr0S
        1kxYBomck1PsaWpbAK3nm4JrDvZpdckkG2j/g1+i5eyblI0JNJAVtB5P8arDLN7D9FvTM7nHlxsZr
        vtgAJaFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQyZC-00HFYv-H3; Thu, 16 Sep 2021 21:05:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B61DA98625E; Thu, 16 Sep 2021 23:05:09 +0200 (CEST)
Date:   Thu, 16 Sep 2021 23:05:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4
 servers
Message-ID: <20210916210509.GG4323@worktop.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <87pmt8a1mc.ffs@tglx>
 <202109162227.17415.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109162227.17415.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:27:17PM +0200, Ondrej Zary wrote:
> (gdb) run
> Starting program: /opt/hp/hp-health/bin/IrqRouteTbl
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xf7fc509b in ?? ()
> (gdb) bt
> #0  0xf7fc509b in ?? ()
> #1  0x08048848 in ?? ()
> #2  0x08048aa1 in ?? ()
> #3  0x08048e05 in ?? ()
> #4  0xf7df9e46 in __libc_start_main () from /lib32/libc.so.6
> #5  0xf7ffd000 in ?? () from /lib/ld-linux.so.2
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> (gdb) x/3i $pc
> => 0xf7fc509b:  cli
>    0xf7fc509c:  push   %ebp
>    0xf7fc509d:  mov    %esp,%ebp
> 
> OMG, maybe is it calling into the mmapped BIOS area?

Lol... does something like the below (which *really* wants to be behind
something like sysctl.iopl_fake_if) work for you?

---

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..55c3904e656d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,34 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+bool fixup_iopl_exception(struct pt_regs *regs)
+{
+	struct thread_struct *t = &current->thread;
+	unsigned char buf[MAX_INSN_SIZE];
+	struct insn insn;
+	int nr_copied;
+
+	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3 || !regs)
+		return false;
+
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (nr_copied <= 0)
+		return false;
+
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
+		return false;
+
+	if (insn.length != 1)
+		return false;
+
+	if (insn.opcode.bytes[0] != 0xfa &&
+	    insn.opcode.bytes[0] != 0xfb)
+		return false;
+
+	regs->ip += 1;
+	return true;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -553,6 +581,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	tsk = current;
 
 	if (user_mode(regs)) {
+		if (fixup_iopl_exception(regs))
+			goto exit;
+
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
