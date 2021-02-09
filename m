Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B741314C96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBIKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:10:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhBIKCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZv71kCz9txgG;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b1NdZmK9w-ot; Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZv6GGHz9txg8;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E058C8B7D8;
        Tue,  9 Feb 2021 10:56:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 88NNZfUrkCL7; Tue,  9 Feb 2021 10:56:40 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FED88B7D6;
        Tue,  9 Feb 2021 10:56:40 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6C35267342; Tue,  9 Feb 2021 09:56:40 +0000 (UTC)
Message-Id: <f53c5fe97f52659bc6f37be9c5d6a9e9bb018106.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 16/41] powerpc/32: Statically initialise first
 emergency context
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check of the emergency context initialisation in
vmap_stack_overflow is buggy for the SMP case, as it
compares r1 with 0 while in the SMP case r1 is offseted
by the CPU id.

Instead of fixing it, just perform static initialisation
of the first emergency context.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h  | 6 +-----
 arch/powerpc/kernel/setup_32.c | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 88b02bd91e8e..15c6fc7cbbf5 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -205,11 +205,7 @@
 	lis	r1, emergency_ctx@ha
 #endif
 	lwz	r1, emergency_ctx@l(r1)
-	cmpwi	cr1, r1, 0
-	bne	cr1, 1f
-	lis	r1, init_thread_union@ha
-	addi	r1, r1, init_thread_union@l
-1:	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
+	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
 	EXCEPTION_PROLOG_2
 	SAVE_NVGPRS(r11)
 	addi	r3, r1, STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 8ba49a6bf515..d7c1f92152af 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -164,7 +164,7 @@ void __init irqstack_early_init(void)
 }
 
 #ifdef CONFIG_VMAP_STACK
-void *emergency_ctx[NR_CPUS] __ro_after_init;
+void *emergency_ctx[NR_CPUS] __ro_after_init = {[0] = &init_stack};
 
 void __init emergency_stack_init(void)
 {
-- 
2.25.0

