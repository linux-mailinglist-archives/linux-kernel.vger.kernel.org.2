Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD638B084
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbhETNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:53:42 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235053AbhETNxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:53:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB372KN3z9sW7;
        Thu, 20 May 2021 15:50:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F-56nO9M-OXf; Thu, 20 May 2021 15:50:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2w73WGz9sTp;
        Thu, 20 May 2021 15:50:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E13F78B815;
        Thu, 20 May 2021 15:50:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UtQ2-JkR5yOo; Thu, 20 May 2021 15:50:48 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AC338B767;
        Thu, 20 May 2021 15:50:48 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7D92564C40; Thu, 20 May 2021 13:50:48 +0000 (UTC)
Message-Id: <8ebbd977ea8cf8d706d82458f2a21acd44562a99.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 11/12] powerpc/optprobes: Compact code source a bit.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that lines can be up to 100 chars long, minimise the
amount of split lines to increase readability.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/optprobes.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 8c08ca15faf3..9c1c8de8c06d 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -18,18 +18,12 @@
 #include <asm/ppc-opcode.h>
 #include <asm/inst.h>
 
-#define TMPL_CALL_HDLR_IDX	\
-	(optprobe_template_call_handler - optprobe_template_entry)
-#define TMPL_EMULATE_IDX	\
-	(optprobe_template_call_emulate - optprobe_template_entry)
-#define TMPL_RET_IDX		\
-	(optprobe_template_ret - optprobe_template_entry)
-#define TMPL_OP_IDX		\
-	(optprobe_template_op_address - optprobe_template_entry)
-#define TMPL_INSN_IDX		\
-	(optprobe_template_insn - optprobe_template_entry)
-#define TMPL_END_IDX		\
-	(optprobe_template_end - optprobe_template_entry)
+#define TMPL_CALL_HDLR_IDX	(optprobe_template_call_handler - optprobe_template_entry)
+#define TMPL_EMULATE_IDX	(optprobe_template_call_emulate - optprobe_template_entry)
+#define TMPL_RET_IDX		(optprobe_template_ret - optprobe_template_entry)
+#define TMPL_OP_IDX		(optprobe_template_op_address - optprobe_template_entry)
+#define TMPL_INSN_IDX		(optprobe_template_insn - optprobe_template_entry)
+#define TMPL_END_IDX		(optprobe_template_end - optprobe_template_entry)
 
 DEFINE_INSN_CACHE_OPS(ppc_optinsn);
 
@@ -280,8 +274,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 */
 	patch_branch(buff + TMPL_RET_IDX, nip, 0);
 
-	flush_icache_range((unsigned long)buff,
-			   (unsigned long)(&buff[TMPL_END_IDX]));
+	flush_icache_range((unsigned long)buff, (unsigned long)(&buff[TMPL_END_IDX]));
 
 	op->optinsn.insn = buff;
 
@@ -319,10 +312,8 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		 * Backup instructions which will be replaced
 		 * by jump address
 		 */
-		memcpy(op->optinsn.copied_insn, op->kp.addr,
-					       RELATIVEJUMP_SIZE);
-		create_branch(&instr, op->kp.addr,
-			      (unsigned long)op->optinsn.insn, 0);
+		memcpy(op->optinsn.copied_insn, op->kp.addr, RELATIVEJUMP_SIZE);
+		create_branch(&instr, op->kp.addr, (unsigned long)op->optinsn.insn, 0);
 		patch_instruction(op->kp.addr, instr);
 		list_del_init(&op->list);
 	}
@@ -333,8 +324,7 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	arch_arm_kprobe(&op->kp);
 }
 
-void arch_unoptimize_kprobes(struct list_head *oplist,
-			     struct list_head *done_list)
+void arch_unoptimize_kprobes(struct list_head *oplist, struct list_head *done_list)
 {
 	struct optimized_kprobe *op;
 	struct optimized_kprobe *tmp;
@@ -345,8 +335,7 @@ void arch_unoptimize_kprobes(struct list_head *oplist,
 	}
 }
 
-int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-				 unsigned long addr)
+int arch_within_optimized_kprobe(struct optimized_kprobe *op, unsigned long addr)
 {
 	return ((unsigned long)op->kp.addr <= addr &&
 		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
-- 
2.25.0

