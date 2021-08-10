Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7DC3E7D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhHJQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:13:45 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:42817 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233707AbhHJQNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:13:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GkdKW2dxqz9sVq;
        Tue, 10 Aug 2021 18:13:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cKKJIg0SqOqw; Tue, 10 Aug 2021 18:13:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GkdKV56VZz9sVm;
        Tue, 10 Aug 2021 18:13:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5026D8B7C0;
        Tue, 10 Aug 2021 18:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Myg4jxzq8Hfv; Tue, 10 Aug 2021 18:13:18 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 179758B7B9;
        Tue, 10 Aug 2021 18:13:18 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DA93466271; Tue, 10 Aug 2021 16:13:17 +0000 (UTC)
Message-Id: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/interrupt: Do not call single_step_exception() from
 other exceptions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        userm57@yahoo.com, fthain@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 10 Aug 2021 16:13:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

single_step_exception() is called by emulate_single_step() which
is called from (at least) alignment exception() handler and
program_check_exception() handler.

Redefine it as a regular __single_step_exception() which is called
by both single_step_exception() handler and emulate_single_step()
function.

Fixes: 3a96570ffceb ("powerpc: convert interrupt handlers to use wrappers")
Cc: stable@vger.kernel.org
Cc: Stan Johnson <userm57@yahoo.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/traps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index dfbce527c98e..d56254f05e17 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1104,7 +1104,7 @@ DEFINE_INTERRUPT_HANDLER(RunModeException)
 	_exception(SIGTRAP, regs, TRAP_UNK, 0);
 }
 
-DEFINE_INTERRUPT_HANDLER(single_step_exception)
+static void __single_step_exception(struct pt_regs *regs)
 {
 	clear_single_step(regs);
 	clear_br_trace(regs);
@@ -1121,6 +1121,11 @@ DEFINE_INTERRUPT_HANDLER(single_step_exception)
 	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 }
 
+DEFINE_INTERRUPT_HANDLER(single_step_exception)
+{
+	__single_step_exception(regs);
+}
+
 /*
  * After we have successfully emulated an instruction, we have to
  * check if the instruction was being single-stepped, and if so,
@@ -1130,7 +1135,7 @@ DEFINE_INTERRUPT_HANDLER(single_step_exception)
 static void emulate_single_step(struct pt_regs *regs)
 {
 	if (single_stepping(regs))
-		single_step_exception(regs);
+		__single_step_exception(regs);
 }
 
 static inline int __parse_fpscr(unsigned long fpscr)
-- 
2.25.0

