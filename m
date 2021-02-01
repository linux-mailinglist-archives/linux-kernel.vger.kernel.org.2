Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170FD30AE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhBARtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232554AbhBARsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2QZcw737uLGTiPdv3q4iR6APpYNiirsYyKYW7Db+veQ=;
        b=BEenCds2OqvC3eX2+q6yPGaMJiQXRlK/j0ZW0hvq05kw+WnNcQP8jU4fMZtyl8L/boQOTk
        7dF/owV5bNrXYXVeI6kPvutuwcpd+dAAyCMCcdj/PXcQaCK9/jHFSQNUmoh/Iy2FSshGrw
        baQJM+9Xa8k/Oms0RZ62D21wgIsxjNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-u5H70VDuO2y8zG2cGtpjNw-1; Mon, 01 Feb 2021 12:47:18 -0500
X-MC-Unique: u5H70VDuO2y8zG2cGtpjNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F6615721;
        Mon,  1 Feb 2021 17:47:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id D28A71A8A6;
        Mon,  1 Feb 2021 17:47:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Feb 2021 18:47:16 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:47:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v4 3/4] x86: introduce TS_COMPAT_RESTART to fix
Message-ID: <20210201174709.GA17895@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174555.GA17819@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in get_nr_restart_syscall() says:

	 * The problem is that we can get here when ptrace pokes
	 * syscall-like values into regs even if we're not in a syscall
	 * at all.

Yes. but if we are not in syscall then the

	status & (TS_COMPAT|TS_I386_REGS_POKED)

check below can't really help:

	- TS_COMPAT can't be set

	- TS_I386_REGS_POKED is only set if regs->orig_ax was changed by
	  32bit debugger; and even in this case get_nr_restart_syscall()
	  is only correct if the tracee is 32bit too.

Suppose that 64bit debugger plays with 32bit tracee and

	* Tracee calls sleep(2)	// TS_COMPAT is set
	* User interrupts the tracee by CTRL-C after 1 sec and does
	  "(gdb) call func()"
	* gdb saves the regs by PTRACE_GETREGS
	* does PTRACE_SETREGS to set %rip='func' and %orig_rax=-1
	* PTRACE_CONT		// TS_COMPAT is cleared
	* func() hits int3.
	* Debugger catches SIGTRAP.
	* Restore original regs by PTRACE_SETREGS.
	* PTRACE_CONT

get_nr_restart_syscall() wrongly returns __NR_restart_syscall==219, the
tracee calls ia32_sys_call_table[219] == sys_madvise.

This patch adds the sticky TS_COMPAT_RESTART flag which survives after
return to user mode, hopefully it allows us to kill TS_I386_REGS_POKED
but this needs another patch.

Test-case:

  $ cvs -d :pserver:anoncvs:anoncvs@sourceware.org:/cvs/systemtap co ptrace-tests
  $ gcc -o erestartsys-trap-debuggee ptrace-tests/tests/erestartsys-trap-debuggee.c --m32
  $ gcc -o erestartsys-trap-debugger ptrace-tests/tests/erestartsys-trap-debugger.c -lutil
  $ ./erestartsys-trap-debugger
  Unexpected: retval 1, errno 22
  erestartsys-trap-debugger: ptrace-tests/tests/erestartsys-trap-debugger.c:421

Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/thread_info.h | 14 +++++++++++++-
 arch/x86/kernel/signal.c           | 24 +-----------------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index c2dc29e215ea..30d1d187019f 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -214,10 +214,22 @@ static inline int arch_within_stack_frames(const void * const stack,
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
 
+#ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
+#define TS_COMPAT_RESTART	0x0008
+
+#define arch_set_restart_data	arch_set_restart_data
+
+static inline void arch_set_restart_data(struct restart_block *restart)
+{
+	struct thread_info *ti = current_thread_info();
+	if (ti->status & TS_COMPAT)
+		ti->status |= TS_COMPAT_RESTART;
+	else
+		ti->status &= ~TS_COMPAT_RESTART;
+}
 #endif
-#ifndef __ASSEMBLY__
 
 #ifdef CONFIG_X86_32
 #define in_ia32_syscall() true
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ea794a083c44..6c26d2c3a2e4 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -766,30 +766,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
 {
-	/*
-	 * This function is fundamentally broken as currently
-	 * implemented.
-	 *
-	 * The idea is that we want to trigger a call to the
-	 * restart_block() syscall and that we want in_ia32_syscall(),
-	 * in_x32_syscall(), etc. to match whatever they were in the
-	 * syscall being restarted.  We assume that the syscall
-	 * instruction at (regs->ip - 2) matches whatever syscall
-	 * instruction we used to enter in the first place.
-	 *
-	 * The problem is that we can get here when ptrace pokes
-	 * syscall-like values into regs even if we're not in a syscall
-	 * at all.
-	 *
-	 * For now, we maintain historical behavior and guess based on
-	 * stored state.  We could do better by saving the actual
-	 * syscall arch in restart_block or (with caveats on x32) by
-	 * checking if regs->ip points to 'int $0x80'.  The current
-	 * behavior is incorrect if a tracer has a different bitness
-	 * than the tracee.
-	 */
 #ifdef CONFIG_IA32_EMULATION
-	if (current_thread_info()->status & (TS_COMPAT|TS_I386_REGS_POKED))
+	if (current_thread_info()->status & TS_COMPAT_RESTART)
 		return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
-- 
2.25.1.362.g51ebf55

