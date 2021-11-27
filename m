Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F446015A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhK0UFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:05:31 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:34011 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356064AbhK0UD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:03:29 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J1j2C1p0qz9sSD;
        Sat, 27 Nov 2021 20:52:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kkc19jxKrOxi; Sat, 27 Nov 2021 20:52:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J1j1Z57xvz9sTb;
        Sat, 27 Nov 2021 20:52:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31FDE8B8D9;
        Sat, 27 Nov 2021 19:10:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fOQkdGixu2XF; Sat, 27 Nov 2021 19:10:30 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.42])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6DAA8B8DB;
        Sat, 27 Nov 2021 19:10:29 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ARIAP13636658
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 27 Nov 2021 19:10:25 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ARIAP2R636657;
        Sat, 27 Nov 2021 19:10:25 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/4] powerpc/inst: Define ppc_inst_t as u32 on PPC32
Date:   Sat, 27 Nov 2021 19:10:20 +0100
Message-Id: <6e02f04ee0258d810a7c6faa346d1bfd9a990714.1638036607.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <1a8623dce54a72c7af172027caa7c44b1fefa8c4.1638036607.git.christophe.leroy@csgroup.eu>
References: <1a8623dce54a72c7af172027caa7c44b1fefa8c4.1638036607.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638036620; l=2480; s=20211009; h=from:subject:message-id; bh=CeGP1uCMsgj54dqNTjeQuOLUnlIpjBJ4Krl2Tx40VRE=; b=79bii179L+l5dPITh+QKdgUbUSpjyjrsCGZiuf5skugDaDhGt8nUpOgAIuRNbKEMYSBbMrqWySBE GWrueC7NDKNw7hKEp2KXc9S4yZ2HH8m6uCH8Dz5/sQC9gnh5NMUz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike PPC64 ABI, PPC32 uses the stack to pass a parameter defined
as a struct, even when the struct has a single simple element.

To avoid that, define ppc_inst_t as u32 on PPC32.

Keep it as 'struct ppc_inst' when __CHECKER__ is defined so that
sparse can perform type checking.

Also revert commit 511eea5e2ccd ("powerpc/kprobes: Fix Oops by passing
ppc_inst as a pointer to emulate_step() on ppc32") as now the
instruction to be emulated is passed as a register to emulate_step().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Make it work with kprobes
---
 arch/powerpc/include/asm/inst.h | 15 +++++++++++++--
 arch/powerpc/kernel/optprobes.c |  8 ++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 055de1fa5d46..5c503816ebc0 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -34,6 +34,7 @@
  * Instruction data type for POWER
  */
 
+#if defined(CONFIG_PPC64) || defined(__CHECKER__)
 typedef struct {
 	u32 val;
 #ifdef CONFIG_PPC64
@@ -46,13 +47,23 @@ static inline u32 ppc_inst_val(ppc_inst_t x)
 	return x.val;
 }
 
+#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
+
+#else
+typedef u32 ppc_inst_t;
+
+static inline u32 ppc_inst_val(ppc_inst_t x)
+{
+	return x;
+}
+#define ppc_inst(x) (x)
+#endif
+
 static inline int ppc_inst_primary_opcode(ppc_inst_t x)
 {
 	return ppc_inst_val(x) >> 26;
 }
 
-#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
-
 #ifdef CONFIG_PPC64
 #define ppc_inst_prefix(x, y) ((ppc_inst_t){ .val = (x), .suffix = (y) })
 
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 378db980ded3..3b1c2236cbee 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -228,12 +228,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
-	if (IS_ENABLED(CONFIG_PPC64)) {
-		temp = ppc_inst_read(p->ainsn.insn);
-		patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
-	} else {
-		patch_imm_load_insns((unsigned long)p->ainsn.insn, 4, buff + TMPL_INSN_IDX);
-	}
+	temp = ppc_inst_read(p->ainsn.insn);
+	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
-- 
2.33.1

