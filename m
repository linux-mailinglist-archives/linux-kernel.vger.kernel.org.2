Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F733CF00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhCPH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:57:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9049 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhCPH5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:57:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F05Gx4N5Hz9v025;
        Tue, 16 Mar 2021 08:57:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sr1BLlSXAvKU; Tue, 16 Mar 2021 08:57:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F05Gx39xXz9v023;
        Tue, 16 Mar 2021 08:57:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 488118B789;
        Tue, 16 Mar 2021 08:57:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nJVA84T61O5U; Tue, 16 Mar 2021 08:57:14 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FAE58B782;
        Tue, 16 Mar 2021 08:57:14 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CD39D675C0; Tue, 16 Mar 2021 07:57:13 +0000 (UTC)
Message-Id: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/4] powerpc: Activate HAVE_RELIABLE_STACKTRACE for all
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 16 Mar 2021 07:57:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_RELIABLE_STACKTRACE is applicable to all, no
reason to limit it to book3s/64le

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig             | 2 +-
 arch/powerpc/kernel/stacktrace.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 67c47b60cc84..bb7ca6fee885 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -235,7 +235,7 @@ config PPC
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
+	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index b6440657ef92..a2a050551109 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -88,7 +88,6 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
 
-#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 /*
  * This function returns an error if it detects any unreliable features of the
  * stack.  Otherwise it guarantees that the stack trace is reliable.
@@ -220,7 +219,6 @@ int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 
 	return ret;
 }
-#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
 
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
 static void handle_backtrace_ipi(struct pt_regs *regs)
-- 
2.25.0

