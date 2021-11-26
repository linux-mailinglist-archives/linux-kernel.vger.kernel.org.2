Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F045E896
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359285AbhKZHpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:45:01 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:48253 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359299AbhKZHnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:43:00 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0mq711b1z9sSM;
        Fri, 26 Nov 2021 08:39:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PwVp3kA8u1IL; Fri, 26 Nov 2021 08:39:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0mq70CFlz9sS3;
        Fri, 26 Nov 2021 08:39:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA8DB8B77D;
        Fri, 26 Nov 2021 08:39:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qMo3RkB0FNgG; Fri, 26 Nov 2021 08:39:46 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A110D8B763;
        Fri, 26 Nov 2021 08:39:46 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AQ7ddvm428780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 08:39:39 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AQ7daHR428778;
        Fri, 26 Nov 2021 08:39:36 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/code-patching: Relax verification of patchability
Date:   Fri, 26 Nov 2021 08:39:23 +0100
Message-Id: <68d7d57675e0963fe5e2c4b84b0cb2390c78638c.1637912333.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637912362; l=1793; s=20211009; h=from:subject:message-id; bh=uH60GDNc5x57OmrWqmFlrPAq1iGxm4Gf783DcGypKvc=; b=GmcP09nvIVJNypv1zTf7MfA8mUoT2I0qz8rQ5QQuaVgZKz0tlf8kN7ew318Jw5FIiuar3phHZAcq /XuW2ppeCKeEjHUFSWwiAsbMvULWlYFKbi9tDheojeOGiGdndDqN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8b8a8f0ab3f5 ("powerpc/code-patching: Improve verification of
patchability") introduced a stricter verification of the patched
area by checking it is proper kernel text.

But as least two usages of patch_instruction() fall outside:
- Code patching selftests, which use stack and vmalloc space.
- Ftrace

So for the time being, partially revert commit 8b8a8f0ab3f5 and add
a onetime warning:

  Running code patching self-tests ...
  patch_instruction() called on invalid text address 0xe1011e58 from test_code_patching+0x34/0xd6c

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Fixes: 8b8a8f0ab3f5 ("powerpc/code-patching: Improve verification of patchability")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 1dd636a85cc1..c87eea773930 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -190,9 +190,13 @@ static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
 int patch_instruction(u32 *addr, struct ppc_inst instr)
 {
 	/* Make sure we aren't patching a freed init section */
-	if (!kernel_text_address((unsigned long)addr))
+	if (system_state >= SYSTEM_FREEING_INITMEM && init_section_contains(addr, 4))
 		return 0;
 
+	if (!kernel_text_address((unsigned long)addr))
+		pr_warn_once("%s() called on invalid text address 0x%p from %pS\n",
+			     __func__, addr, __builtin_return_address(0));
+
 	return do_patch_instruction(addr, instr);
 }
 NOKPROBE_SYMBOL(patch_instruction);
-- 
2.33.1

