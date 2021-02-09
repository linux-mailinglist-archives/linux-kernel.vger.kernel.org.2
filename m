Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B33159E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhBIXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:09:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40328 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233495AbhBITvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:51:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZtHr4swQz9v023;
        Tue,  9 Feb 2021 20:29:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rPYpfhSM1kL7; Tue,  9 Feb 2021 20:29:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZtHr274tz9v021;
        Tue,  9 Feb 2021 20:29:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A0078B7EA;
        Tue,  9 Feb 2021 20:29:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K6FQxBvXI5xg; Tue,  9 Feb 2021 20:29:28 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3FB58B764;
        Tue,  9 Feb 2021 20:29:27 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8F74767382; Tue,  9 Feb 2021 19:29:27 +0000 (UTC)
Message-Id: <fb87b205ae8eb8c623f33bb316801acf95a831e6.1612898425.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612898425.git.christophe.leroy@csgroup.eu>
References: <cover.1612898425.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 1/2] powerpc/syscall: Do not check unsupported scv vector
 on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 19:29:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only book3s/64 has scv. No need to check the 0x7ff0 trap on 32 or 64e.
For that, add a helper trap_is_unsupported_scv() similar to
trap_is_scv().

And ignore the scv parameter in syscall_exit_prepare (Save 14 cycles
346 => 332 cycles)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: Added a helper trap_is_unsupported_scv()
v6: Still set r5 when calling syscall_exit_prepare() and introduce a local bool 'is_not_scv'
---
 arch/powerpc/include/asm/ptrace.h | 5 +++++
 arch/powerpc/kernel/interrupt.c   | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 8236c5e749e4..975ba260006a 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -232,6 +232,11 @@ static inline bool trap_is_scv(struct pt_regs *regs)
 	return (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) == 0x3000);
 }
 
+static inline bool trap_is_unsupported_scv(struct pt_regs *regs)
+{
+	return IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) == 0x7ff0;
+}
+
 static inline bool trap_is_syscall(struct pt_regs *regs)
 {
 	return (trap_is_scv(regs) || TRAP(regs) == 0xc00);
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 107ec39f05cb..75d657b63332 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -88,7 +88,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	local_irq_enable();
 
 	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
-		if (unlikely(regs->trap == 0x7ff0)) {
+		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 			return regs->gpr[3];
@@ -111,7 +111,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		r8 = regs->gpr[8];
 
 	} else if (unlikely(r0 >= NR_syscalls)) {
-		if (unlikely(regs->trap == 0x7ff0)) {
+		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 			return regs->gpr[3];
@@ -220,6 +220,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long ti_flags;
 	unsigned long ret = 0;
+	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
 
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
@@ -234,7 +235,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	ti_flags = *ti_flagsp;
 
-	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && !scv) {
+	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
 			r3 = -r3;
 			regs->ccr |= 0x10000000; /* Set SO bit in CR */
@@ -305,7 +306,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	user_enter_irqoff();
 
 	/* scv need not set RI=0 because SRRs are not used */
-	if (unlikely(!__prep_irq_for_enabled_exit(!scv))) {
+	if (unlikely(!__prep_irq_for_enabled_exit(is_not_scv))) {
 		user_exit_irqoff();
 		local_irq_enable();
 		local_irq_disable();
-- 
2.25.0

