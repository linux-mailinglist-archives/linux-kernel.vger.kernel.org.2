Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144303B132F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFWFZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:25:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50665 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFWFZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:25:50 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G8s9w0JgnzBDb3;
        Wed, 23 Jun 2021 07:23:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bYOMyFCcoABL; Wed, 23 Jun 2021 07:23:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G8s9v59R8zBDZK;
        Wed, 23 Jun 2021 07:23:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A36AE8B7C1;
        Wed, 23 Jun 2021 07:23:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JK5fSF0_49QA; Wed, 23 Jun 2021 07:23:31 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C1578B767;
        Wed, 23 Jun 2021 07:23:31 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1BA1B6630E; Wed, 23 Jun 2021 05:23:30 +0000 (UTC)
Message-Id: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a pointer
 to emulate_step() on ppc32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 23 Jun 2021 05:23:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Trying to use a kprobe on ppc32 results in the below splat:
    BUG: Unable to handle kernel data access on read at 0x7c0802a6
    Faulting instruction address: 0xc002e9f0
    Oops: Kernel access of bad area, sig: 11 [#1]
    BE PAGE_SIZE=4K PowerPC 44x Platform
    Modules linked in:
    CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
    NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
    REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495fdb)
    MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
    DEAR: 7c0802a6 ESR: 00000000
    <snip>
    NIP [c002e9f0] emulate_step+0x28/0x324
    LR [c0011858] optinsn_slot+0x128/0x10000
    Call Trace:
     opt_pre_handler+0x7c/0xb4 (unreliable)
     optinsn_slot+0x128/0x10000
     ret_from_syscall+0x0/0x28

The offending instruction is:
    81 24 00 00     lwz     r9,0(r4)

Here, we are trying to load the second argument to emulate_step():
struct ppc_inst, which is the instruction to be emulated. On ppc64,
structures are passed in registers when passed by value. However, per
the ppc32 ABI, structures are always passed to functions as pointers.
This isn't being adhered to when setting up the call to emulate_step()
in the optprobe trampoline. Fix the same.

Fixes: eacf4c0202654a ("powerpc: Enable OPTPROBES on PPC32")
Cc: stable@vger.kernel.org
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: Rebased on powerpc/merge 7f030e9d57b8
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/optprobes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 2b8fe40069ad..53facb4b377f 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -228,8 +228,12 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
-	temp = ppc_inst_read(p->ainsn.insn);
-	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
+	if (IS_ENABLED(CONFIG_PPC64)) {
+		temp = ppc_inst_read(p->ainsn.insn);
+		patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
+	} else {
+		patch_imm_load_insns((unsigned long)p->ainsn.insn, 4, buff + TMPL_INSN_IDX);
+	}
 
 	/*
 	 * 4. branch back from trampoline
-- 
2.25.0

