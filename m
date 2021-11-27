Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F06460153
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhK0T7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:59:23 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:44845 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241630AbhK0T5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:57:21 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J1j1v3zjSz9sS0;
        Sat, 27 Nov 2021 20:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gr0eoazxPXUD; Sat, 27 Nov 2021 20:52:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J1j1Z4FnBz9sTF;
        Sat, 27 Nov 2021 20:52:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 296A38B8DD;
        Sat, 27 Nov 2021 19:10:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0gj20X6FUT11; Sat, 27 Nov 2021 19:10:30 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.42])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B25B98B8D9;
        Sat, 27 Nov 2021 19:10:29 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ARIANsK636650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 27 Nov 2021 19:10:23 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ARIALXv636649;
        Sat, 27 Nov 2021 19:10:21 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/4] powerpc/inst: Refactor ___get_user_instr()
Date:   Sat, 27 Nov 2021 19:10:18 +0100
Message-Id: <1a8623dce54a72c7af172027caa7c44b1fefa8c4.1638036607.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638036620; l=1409; s=20211009; h=from:subject:message-id; bh=zIo/9aHkNL26PXcoL1CcR42y7+ImikzNzgYR0PCbPKI=; b=XIAHc1DNWM1NAGMOagRHCBIimecJQMvJvJtp/dSLCXz0BU87HyIT1WHBUSxyjI9psvzT4PaJJ/9U xU1f+EUvDxBd5A37G1V0tfGjlMURb+MZhC74kDbOOBUs9h6Yt6d0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 version of ___get_user_instr() can be used for PPC32 as well,
by simply disabling the suffix part with IS_ENABLED(CONFIG_PPC64).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index b11c0e2f9639..fea4d46155a9 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -4,8 +4,6 @@
 
 #include <asm/ppc-opcode.h>
 
-#ifdef CONFIG_PPC64
-
 #define ___get_user_instr(gu_op, dest, ptr)				\
 ({									\
 	long __gui_ret;							\
@@ -16,7 +14,7 @@
 	__chk_user_ptr(ptr);						\
 	__gui_ret = gu_op(__prefix, __gui_ptr);				\
 	if (__gui_ret == 0) {						\
-		if ((__prefix >> 26) == OP_PREFIX) {			\
+		if (IS_ENABLED(CONFIG_PPC64) && (__prefix >> 26) == OP_PREFIX) { \
 			__gui_ret = gu_op(__suffix, __gui_ptr + 1);	\
 			__gui_inst = ppc_inst_prefix(__prefix, __suffix); \
 		} else {						\
@@ -27,13 +25,6 @@
 	}								\
 	__gui_ret;							\
 })
-#else /* !CONFIG_PPC64 */
-#define ___get_user_instr(gu_op, dest, ptr)				\
-({									\
-	__chk_user_ptr(ptr);						\
-	gu_op((dest).val, (u32 __user *)(ptr));				\
-})
-#endif /* CONFIG_PPC64 */
 
 #define get_user_instr(x, ptr) ___get_user_instr(get_user, x, ptr)
 
-- 
2.33.1

