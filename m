Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E703F75EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhHYNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:35:33 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:44021 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240898AbhHYNfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:35:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gvn5d6S7Kz9sTj;
        Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xfO4z1aiVt8q; Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gvn5d5WY9z9sTW;
        Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A348F8B85B;
        Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JgIVHkcI2S1c; Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BD9B8B858;
        Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 29D996BC7B; Wed, 25 Aug 2021 13:34:45 +0000 (UTC)
Message-Id: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Redefine HMT_xxx macros as empty on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 25 Aug 2021 13:34:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HMT_xxx macros are macros for adjusting thread priority
(hardware multi-threading) are macros inherited from PPC64
via commit 5f7c690728ac ("[PATCH] powerpc: Merged ppc_asm.h")

Those instructions are pointless on PPC32, but some common
fonctions like arch_cpu_idle() use them.

So make them empty on PPC32 to avoid those instructions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/processor.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
index e072577bc7c0..8d79f994b4aa 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -5,12 +5,21 @@
 #ifndef __ASSEMBLY__
 
 /* Macros for adjusting thread priority (hardware multi-threading) */
+#ifdef CONFIG_PPC64
 #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
 #define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
 #define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
 #define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
 #define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
 #define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+#else
+#define HMT_very_low()
+#define HMT_low()
+#define HMT_medium_low()
+#define HMT_medium()
+#define HMT_medium_high()
+#define HMT_high()
+#endif
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
-- 
2.25.0

