Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4A3754BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhEFNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:31:55 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50859 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233461AbhEFNbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:31:51 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FbZGM6mnrz9sVL;
        Thu,  6 May 2021 15:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h5Q48sXS11rc; Thu,  6 May 2021 15:30:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FbZGM5vv8z9sV0;
        Thu,  6 May 2021 15:30:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E8018B801;
        Thu,  6 May 2021 15:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mlQERwmhUEX4; Thu,  6 May 2021 15:30:51 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D3068B800;
        Thu,  6 May 2021 15:30:51 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0AB966489F; Thu,  6 May 2021 13:30:51 +0000 (UTC)
Message-Id: <d536bbc46094f66b24d3017343be25164f232933.1620307840.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Only pad struct pt_regs when needed
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 May 2021 13:30:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If neither KUAP nor PPC64 is selected, there is nothing in the second
union of struct pt_regs, so the alignment padding is waste of memory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9c9ab2746168..4fd3a3bd5272 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -47,7 +47,7 @@ struct pt_regs
 			unsigned long result;
 		};
 	};
-
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
 	union {
 		struct {
 #ifdef CONFIG_PPC64
@@ -67,6 +67,7 @@ struct pt_regs
 		};
 		unsigned long __pad[4];	/* Maintain 16 byte interrupt stack alignment */
 	};
+#endif
 };
 #endif
 
-- 
2.25.0

