Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5430F7B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhBDQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:24:52 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:37495 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237904AbhBDQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:24:33 -0500
X-Halon-ID: 58f64f36-6705-11eb-a076-005056917f90
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 58f64f36-6705-11eb-a076-005056917f90;
        Thu, 04 Feb 2021 17:23:46 +0100 (CET)
From:   Andreas Larsson <andreas@gaisler.com>
To:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: [PATCH] sparc32: Preserve clone syscall flags argument for restarts due to signals
Date:   Thu,  4 Feb 2021 17:23:41 +0100
Message-Id: <20210204162341.4218-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug where a clone syscall that is restarted due to a
pending signal is restarted with garbage in the register %o0 that holds
the clone flags.

This keep the original %i0 of a syscall (as seen from the trap handler)
in %l6 rather than %l5. This is done because for clone (and also qfork)
%l5 is used as a temporary variable in the same register window. Before
this, that temporary value would be the value that was then incorrectly
used as the orig_i0 argument to do_notify_resume.

In order to preserve %l6, the temporary usage of %l6 in ret_sys_call is
changed to use %l5 instead and the setting %l6 to 0 or 1 was removed.
The use of that 0 or 1 value in %l6 was removed in commit
28e6103665301ce60634e8a77f0b657c6cc099de.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/entry.S    | 8 +++-----
 arch/sparc/kernel/rtrap_32.S | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index d58940280f8d..a269ad2fe6df 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -994,7 +994,7 @@ do_syscall:
 	andcc	%l5, _TIF_SYSCALL_TRACE, %g0
 	mov	%i4, %o4
 	bne	linux_syscall_trace
-	 mov	%i0, %l5
+	 mov	%i0, %l6
 2:
 	call	%l7
 	 mov	%i5, %o5
@@ -1003,16 +1003,15 @@ do_syscall:
 	st	%o0, [%sp + STACKFRAME_SZ + PT_I0]
 
 ret_sys_call:
-	ld	[%curptr + TI_FLAGS], %l6
+	ld	[%curptr + TI_FLAGS], %l5
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	ld	[%sp + STACKFRAME_SZ + PT_PSR], %g3
 	set	PSR_C, %g2
 	bgeu	1f
-	 andcc	%l6, _TIF_SYSCALL_TRACE, %g0
+	 andcc	%l5, _TIF_SYSCALL_TRACE, %g0
 
 	/* System call success, clear Carry condition code. */
 	andn	%g3, %g2, %g3
-	clr	%l6
 	st	%g3, [%sp + STACKFRAME_SZ + PT_PSR]	
 	bne	linux_syscall_trace2
 	 ld	[%sp + STACKFRAME_SZ + PT_NPC], %l1 /* pc = npc */
@@ -1027,7 +1026,6 @@ ret_sys_call:
 	sub	%g0, %o0, %o0
 	or	%g3, %g2, %g3
 	st	%o0, [%sp + STACKFRAME_SZ + PT_I0]
-	mov	1, %l6
 	st	%g3, [%sp + STACKFRAME_SZ + PT_PSR]
 	bne	linux_syscall_trace2
 	 ld	[%sp + STACKFRAME_SZ + PT_NPC], %l1 /* pc = npc */
diff --git a/arch/sparc/kernel/rtrap_32.S b/arch/sparc/kernel/rtrap_32.S
index dca8ed810046..8931fe266346 100644
--- a/arch/sparc/kernel/rtrap_32.S
+++ b/arch/sparc/kernel/rtrap_32.S
@@ -75,7 +75,7 @@ signal_p:
 	 ld	[%sp + STACKFRAME_SZ + PT_PSR], %t_psr
 
 	mov	%g2, %o2
-	mov	%l5, %o1
+	mov	%l6, %o1
 	call	do_notify_resume
 	 add	%sp, STACKFRAME_SZ, %o0	! pt_regs ptr
 
-- 
2.17.1

