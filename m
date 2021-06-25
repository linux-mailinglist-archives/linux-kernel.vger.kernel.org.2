Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93D3B4243
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFYLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:15:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5330 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYLPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:15:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBDrZ1xnvzBBh0;
        Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qizscpcGZpPC; Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBDrY124DzBBft;
        Fri, 25 Jun 2021 13:13:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C3AB8B802;
        Fri, 25 Jun 2021 13:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qjDWOupUbZba; Fri, 25 Jun 2021 13:13:16 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B3D8B7FF;
        Fri, 25 Jun 2021 13:13:16 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 49CB566377; Fri, 25 Jun 2021 11:13:16 +0000 (UTC)
Message-Id: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/ptrace: Move set_return_regs_changed() before
 regs_set_return_{msr/ip}
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jun 2021 11:13:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regs_set_return_msr() and regs_set_return_ip() have a copy
of the code of set_return_regs_changed().

Move up set_return_regs_changed() so it can be reused by
regs_set_return_{msr/ip}

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fcf63f559344..14b8105a1e27 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -135,26 +135,26 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 long do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
 
-static inline void regs_set_return_ip(struct pt_regs *regs, unsigned long ip)
+static inline void set_return_regs_changed(void)
 {
-	regs->nip = ip;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
 #endif
 }
 
-static inline void regs_set_return_msr(struct pt_regs *regs, unsigned long msr)
+static inline void regs_set_return_ip(struct pt_regs *regs, unsigned long ip)
 {
-	regs->msr = msr;
+	regs->nip = ip;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
 #endif
 }
 
-static inline void set_return_regs_changed(void)
+static inline void regs_set_return_msr(struct pt_regs *regs, unsigned long msr)
 {
+	regs->msr = msr;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
-- 
2.25.0

