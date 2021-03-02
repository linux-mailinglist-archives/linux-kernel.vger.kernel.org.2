Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740E32A37F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378938AbhCBJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:06:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52395 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240744AbhCBItT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:49:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqW4D4PSMz9txQj;
        Tue,  2 Mar 2021 09:48:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Uz34-VrBM9n8; Tue,  2 Mar 2021 09:48:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqW4D3d1Lz9txQg;
        Tue,  2 Mar 2021 09:48:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76A778B7AC;
        Tue,  2 Mar 2021 09:48:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pjmndtbJUwFo; Tue,  2 Mar 2021 09:48:13 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AF458B75F;
        Tue,  2 Mar 2021 09:48:13 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 958C1674AD; Tue,  2 Mar 2021 08:48:12 +0000 (UTC)
Message-Id: <f79f83b551b7c955dd2022552ff1c483f4401922.1614674882.git.christophe.leroy@csgroup.eu>
In-Reply-To: <1fc81f07cabebb875b963e295408cc3dd38c8d85.1614674882.git.christophe.leroy@csgroup.eu>
References: <1fc81f07cabebb875b963e295408cc3dd38c8d85.1614674882.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/2] powerpc: Use %y addressing on bitops
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  2 Mar 2021 08:48:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/bitops.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 11847b6a244e..264626b13ea8 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -70,12 +70,12 @@ static inline void fn(unsigned long mask,	\
 	unsigned long *p = (unsigned long *)_p;	\
 	__asm__ __volatile__ (			\
 	prefix					\
-"1:"	PPC_LLARX "%0,0,%3,0\n"			\
+"1:"	PPC_LLARX "%0,%y3,0\n"			\
 	stringify_in_c(op) "%0,%0,%2\n"		\
-	PPC_STLCX "%0,0,%3\n"			\
+	PPC_STLCX "%0,%y3\n"			\
 	"bne- 1b\n"				\
 	: "=&r" (old), "+m" (*p)		\
-	: "r" (mask), "r" (p)			\
+	: "r" (mask), "Z" (*p)			\
 	: "cc", "memory");			\
 }
 
@@ -115,13 +115,13 @@ static inline unsigned long fn(			\
 	unsigned long *p = (unsigned long *)_p;		\
 	__asm__ __volatile__ (				\
 	prefix						\
-"1:"	PPC_LLARX "%0,0,%3,%4\n"			\
+"1:"	PPC_LLARX "%0,%y3,%4\n"				\
 	stringify_in_c(op) "%1,%0,%2\n"			\
-	PPC_STLCX "%1,0,%3\n"				\
+	PPC_STLCX "%1,%y3\n"				\
 	"bne- 1b\n"					\
 	postfix						\
 	: "=&r" (old), "=&r" (t)			\
-	: "r" (mask), "r" (p), "i" (IS_ENABLED(CONFIG_PPC64) ? eh : 0)	\
+	: "r" (mask), "Z" (*p), "i" (IS_ENABLED(CONFIG_PPC64) ? eh : 0)	\
 	: "cc", "memory");				\
 	return (old & mask);				\
 }
@@ -170,12 +170,12 @@ clear_bit_unlock_return_word(int nr, volatile unsigned long *addr)
 
 	__asm__ __volatile__ (
 	PPC_RELEASE_BARRIER
-"1:"	PPC_LLARX "%0,0,%3,0\n"
+"1:"	PPC_LLARX "%0,%y3,0\n"
 	"andc %1,%0,%2\n"
-	PPC_STLCX "%1,0,%3\n"
+	PPC_STLCX "%1,%y3\n"
 	"bne- 1b\n"
 	: "=&r" (old), "=&r" (t)
-	: "r" (mask), "r" (p)
+	: "r" (mask), "Z" (*p)
 	: "cc", "memory");
 
 	return old;
-- 
2.25.0

