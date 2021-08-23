Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59B3F4D86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhHWP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:29:58 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:41771 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhHWP35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:29:57 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gtbkd3YCSz9sWm;
        Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qx5fZBqh7l38; Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gtbkd2fm1z9sT5;
        Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D4138B7B3;
        Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DyLsmin7G7es; Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 120E98B7AF;
        Mon, 23 Aug 2021 17:29:13 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ACAC86BC79; Mon, 23 Aug 2021 15:29:12 +0000 (UTC)
Message-Id: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non
 volatile regs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 15:29:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instructions lmw/stmw are interesting for functions that are rarely
used and not in the cache, because only one instruction is to be
copied into the instruction cache instead of 19. However those
instruction are less performant than 19x raw lwz/stw as they require
synchronisation plus one additional cycle.

SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
mostly in interrupts entries/exits and in task switch so they are
likely already in the cache.

Using standard lwz improves null_syscall selftest by:
- 10 cycles on mpc832x.
- 2 cycles on mpc8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc_asm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ffe712307e11..349fc0ec0dbb 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -28,8 +28,8 @@
 #else
 #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
 #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
-#define SAVE_NVGPRS(base)	stmw	13, GPR0+4*13(base)
-#define REST_NVGPRS(base)	lmw	13, GPR0+4*13(base)
+#define SAVE_NVGPRS(base)	SAVE_GPR(13, base); SAVE_8GPRS(14, base); SAVE_10GPRS(22, base)
+#define REST_NVGPRS(base)	REST_GPR(13, base); REST_8GPRS(14, base); REST_10GPRS(22, base)
 #endif
 
 #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
-- 
2.25.0

