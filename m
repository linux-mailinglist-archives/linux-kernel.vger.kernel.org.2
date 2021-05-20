Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3500938A8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhETKxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:53:23 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34621 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236909AbhETKhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:37:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fm5RJ0lHDz9sW2;
        Thu, 20 May 2021 12:23:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qT7pTu5q6uJI; Thu, 20 May 2021 12:23:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RH6xq7z9sVn;
        Thu, 20 May 2021 12:23:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0DF58B811;
        Thu, 20 May 2021 12:23:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hmdyHtCwcKIT; Thu, 20 May 2021 12:23:07 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EC528B80D;
        Thu, 20 May 2021 12:23:07 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6895C64C44; Thu, 20 May 2021 10:23:07 +0000 (UTC)
Message-Id: <c1887623e91e8b4da36e669e4c74de86320a5092.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 08/12] powerpc/ebpf64: Use PPC_RAW_MFLR()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 10:23:07 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PPC_RAW_MFLR() instead of open coding with PPC_INST_MFLR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 3 +--
 arch/powerpc/net/bpf_jit_comp64.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 2c97ee3e0db1..9cf8575e00d6 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -285,7 +285,6 @@
 #define PPC_INST_TSR			0x7c0005dd
 #define PPC_INST_LD			0xe8000000
 #define PPC_INST_STD			0xf8000000
-#define PPC_INST_MFLR			0x7c0802a6
 #define PPC_INST_ADDIS			0x3c000000
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_DIVD			0x7c0003d2
@@ -479,7 +478,7 @@
 #define PPC_RAW_BLR()			(0x4e800020)
 #define PPC_RAW_BLRL()			(0x4e800021)
 #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
-#define PPC_RAW_MFLR(t)			(PPC_INST_MFLR | ___PPC_RT(t))
+#define PPC_RAW_MFLR(t)			(0x7c0802a6 | ___PPC_RT(t))
 #define PPC_RAW_BCTR()			(0x4e800420)
 #define PPC_RAW_BCTRL()			(0x4e800421)
 #define PPC_RAW_MTCTR(r)		(0x7c0903a6 | ___PPC_RT(r))
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 57a8c1153851..7ec9c852f105 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -94,7 +94,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		 * save/restore LR unless we call other functions
 		 */
 		if (ctx->seen & SEEN_FUNC) {
-			EMIT(PPC_INST_MFLR | __PPC_RT(R0));
+			EMIT(PPC_RAW_MFLR(_R0));
 			PPC_BPF_STL(0, 1, PPC_LR_STKOFF);
 		}
 
-- 
2.25.0

