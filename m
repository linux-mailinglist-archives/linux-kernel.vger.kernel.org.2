Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA1341B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCSLHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43855 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhCSLG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LQ0rPfz9tx8y;
        Fri, 19 Mar 2021 12:06:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0VCYq4XgH91C; Fri, 19 Mar 2021 12:06:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LP6nRPz9tx8s;
        Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83E5C8B975;
        Fri, 19 Mar 2021 12:06:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VTg0wwmbtZAW; Fri, 19 Mar 2021 12:06:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F14668B974;
        Fri, 19 Mar 2021 12:06:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CD3EA675FB; Fri, 19 Mar 2021 11:06:53 +0000 (UTC)
Message-Id: <8cef43607e5b35a7fd0829dec812d88beb570df2.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 04/10] powerpc/signal32: Rename save_user_regs_unsafe() and
 save_general_regs_unsafe()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:06:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convention is to prefix functions with __unsafe_ instead of
suffixing it with _unsafe.

Rename save_user_regs_unsafe() and save_general_regs_unsafe()
accordingly, that is respectively __unsafe_save_general_regs() and
__unsafe_save_user_regs().

Suggested-by: Christopher M. Riedl <cmr@codefail.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c505b444a613..3b78748d6d85 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -94,7 +94,7 @@ static inline int get_sigset_t(sigset_t *set,
 #define from_user_ptr(p)	compat_ptr(p)
 
 static __always_inline int
-save_general_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame)
+__unsafe_save_general_regs(struct pt_regs *regs, struct mcontext __user *frame)
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int val, i;
@@ -151,7 +151,7 @@ static inline int get_sigset_t(sigset_t *set, const sigset_t __user *uset)
 #define from_user_ptr(p)	((void __user *)(p))
 
 static __always_inline int
-save_general_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame)
+__unsafe_save_general_regs(struct pt_regs *regs, struct mcontext __user *frame)
 {
 	WARN_ON(!FULL_REGS(regs));
 	unsafe_copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE, failed);
@@ -177,7 +177,7 @@ static inline int restore_general_regs(struct pt_regs *regs,
 #endif
 
 #define unsafe_save_general_regs(regs, frame, label) do {	\
-	if (save_general_regs_unsafe(regs, frame))	\
+	if (__unsafe_save_general_regs(regs, frame))		\
 		goto label;					\
 } while (0)
 
@@ -260,8 +260,8 @@ static void prepare_save_user_regs(int ctx_has_vsx_region)
 #endif
 }
 
-static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				 struct mcontext __user *tm_frame, int ctx_has_vsx_region)
+static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -338,7 +338,7 @@ static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f
 }
 
 #define unsafe_save_user_regs(regs, frame, tm_frame, has_vsx, label) do { \
-	if (save_user_regs_unsafe(regs, frame, tm_frame, has_vsx))	\
+	if (__unsafe_save_user_regs(regs, frame, tm_frame, has_vsx))	\
 		goto label;						\
 } while (0)
 
@@ -350,7 +350,7 @@ static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f
  * We also save the transactional registers to a second ucontext in the
  * frame.
  *
- * See save_user_regs_unsafe() and signal_64.c:setup_tm_sigcontexts().
+ * See __unsafe_save_user_regs() and signal_64.c:setup_tm_sigcontexts().
  */
 static void prepare_save_tm_user_regs(void)
 {
@@ -441,7 +441,7 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* SPE regs are not checkpointed with TM, so this section is
-	 * simply the same as in save_user_regs_unsafe().
+	 * simply the same as in __unsafe_save_user_regs().
 	 */
 	if (current->thread.used_spe) {
 		unsafe_copy_to_user(&frame->mc_vregs, current->thread.evr,
-- 
2.25.0

