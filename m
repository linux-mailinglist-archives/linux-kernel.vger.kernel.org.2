Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539536A0A6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhDXKfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 06:35:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36244 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhDXKfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 06:35:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FS6wf0yQ5z9tvrL;
        Sat, 24 Apr 2021 12:34:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id i8t7Nss1EpfW; Sat, 24 Apr 2021 12:34:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FS6wd74yTz9tvrF;
        Sat, 24 Apr 2021 12:34:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97F6D8B76E;
        Sat, 24 Apr 2021 12:34:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JbBAbgqlwU61; Sat, 24 Apr 2021 12:34:43 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CA5E8B75F;
        Sat, 24 Apr 2021 12:34:43 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 342BB63977; Sat, 24 Apr 2021 10:34:43 +0000 (UTC)
Message-Id: <c68163065163f303f5af1e4bbdd9f1ce69f0543e.1619260465.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/kasan: Fix shadow start address with modules
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 24 Apr 2021 10:34:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modules are now located before kernel, KASAN area has to
be extended accordingly.

Fixes: 80edc68e0479 ("powerpc/32s: Define a MODULE area below kernel text all the time")
Fixes: 9132a2e82adc ("powerpc/8xx: Define a MODULE area below kernel text")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 7355ed05e65e..3c478e5ef24c 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -19,7 +19,7 @@
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_MODULES) && defined(CONFIG_STRICT_KERNEL_RWX)
+#ifdef CONFIG_MODULES
 #define KASAN_KERN_START	ALIGN_DOWN(PAGE_OFFSET - SZ_256M, SZ_256M)
 #else
 #define KASAN_KERN_START	PAGE_OFFSET
-- 
2.25.0

