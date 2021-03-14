Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4401033A57A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhCNPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCNPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:40:26 -0700 (PDT)
Date:   Sun, 14 Mar 2021 15:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615736423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/HPVsiCj5B6gyAi5wLhM1FLMrG+6TiYn9pWgMuLKzB8=;
        b=n/oTY+zi80qDecfWUhQmX+iwFhbB7lqZaVnknaCby0ObLR8C1nL73KQVK5a2A83OYkFusJ
        njemltjSwXo372PmV/jc5EKwwuM2YYl5Zy1mriFEjSyajyusGUJBez5iA8FbRzDjQVTcxx
        kEJI2snpGhzQsMEtX2Pb0beVdpmc9V+jDP0/NMaz+BC3cNQOugHk61WgbUecG/nwLa6Cvk
        v3ILbVEPmInOBDeJt4vDRhNhYZcnpw+yln7jXw2A1brYKSGw1DAg6Ze32XDKzhYTG/yMvy
        lZm5dtPBDnkdF9aKw+lWFDXptTzWX7Fd6l5uaLbhuOHRZp4M5xQsaioJ+AyOpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615736423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/HPVsiCj5B6gyAi5wLhM1FLMrG+6TiYn9pWgMuLKzB8=;
        b=UDJSe+WSC9s6EbJ3EcyMk/0dDKXi0DBgwyn+vlK4JrPdbo8UbjQZ+yoTPI5sPMyAddOaUW
        RmiC3p5ENY9VvhAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for v5.12-rc3
References: <161573639668.27979.17827928369874291298.tglx@nanos>
Message-ID: <161573639789.27979.3143475584511547992.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-03-14

up to:  ba08abca66d4: objtool,x86: Fix uaccess PUSHF/POPF validation


A single objtool fix to handle the PUSHF/POPF validation correctly for the
paravirt changes which modified arch_local_irq_restore not to use popf.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      objtool,x86: Fix uaccess PUSHF/POPF validation


 arch/x86/include/asm/smap.h | 10 ++++------
 tools/objtool/check.c       |  3 +++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 8b58d6975d5d..0bc9b0895f33 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -58,9 +58,8 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
 
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
-		      "pushf; pop %0; " __ASM_CLAC "\n\t"
-		      "1:"
+		      ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC "\n\t",
+				  X86_FEATURE_SMAP)
 		      : "=rm" (flags) : : "memory", "cc");
 
 	return flags;
@@ -69,9 +68,8 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
-		      "push %0; popf\n\t"
-		      "1:"
+		      ALTERNATIVE("", "push %0; popf\n\t",
+				  X86_FEATURE_SMAP)
 		      : : "g" (flags) : "memory", "cc");
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068cdb41f76f..5e5388a38e2a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2442,6 +2442,9 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 		if (update_cfi_state(insn, &state->cfi, op))
 			return 1;
 
+		if (!insn->alt_group)
+			continue;
+
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
 				state->uaccess_stack = 1;

