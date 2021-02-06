Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6318B311CF3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:48:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30307 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBFLsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:48:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DXrB62Rsjz9v3fM;
        Sat,  6 Feb 2021 12:47:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AswnOSoe00OL; Sat,  6 Feb 2021 12:47:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DXrB56nPYz9v3fL;
        Sat,  6 Feb 2021 12:47:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16A5B8B784;
        Sat,  6 Feb 2021 12:47:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RE2WZVve7Alt; Sat,  6 Feb 2021 12:47:27 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D5A0A8B766;
        Sat,  6 Feb 2021 12:47:26 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9AF1C672EC; Sat,  6 Feb 2021 11:47:26 +0000 (UTC)
Message-Id: <72c7b9879e2e2e6f5c27dadda6486386c2b50f23.1612612022.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/3] powerpc/32s: Change mfsrin() into a static inline
 function
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  6 Feb 2021 11:47:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfsrin() is a macro.

Change in into an inline function to avoid conflicts in KVM
and make it more evolutive.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h    | 11 ++++++++---
 arch/powerpc/kvm/book3s_emulate.c |  4 ----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d05dca30604d..f0fb03c9f289 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1414,9 +1414,14 @@ static inline void msr_check_and_clear(unsigned long bits)
 }
 
 #ifdef CONFIG_PPC32
-#define mfsrin(v)	({unsigned int rval; \
-			asm volatile("mfsrin %0,%1" : "=r" (rval) : "r" (v)); \
-					rval;})
+static inline u32 mfsrin(u32 idx)
+{
+	u32 val;
+
+	asm volatile("mfsrin %0, %1" : "=r" (val): "r" (idx));
+
+	return val;
+}
 
 static inline void mtsrin(u32 val, u32 idx)
 {
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index b08cc15f31c7..fdb57be71aa6 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -61,10 +61,6 @@
 #define SPRN_GQR6		918
 #define SPRN_GQR7		919
 
-/* Book3S_32 defines mfsrin(v) - but that messes up our abstract
- * function pointers, so let's just disable the define. */
-#undef mfsrin
-
 enum priv_level {
 	PRIV_PROBLEM = 0,
 	PRIV_SUPER = 1,
-- 
2.25.0

