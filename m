Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C01438382
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhJWLtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:49:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54660 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhJWLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:49:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4HbzwS2rbzz9s31;
        Sat, 23 Oct 2021 13:47:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JBZ3xh0Fk6TR; Sat, 23 Oct 2021 13:47:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by pegase1.c-s.fr (Postfix) with ESMTPS id 4HbzwQ3QH1z9s2q;
        Sat, 23 Oct 2021 13:47:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19NBlI0S441166
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 13:47:18 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19NBlIDO441165;
        Sat, 23 Oct 2021 13:47:18 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/10] powerpc/booke: Disable STRICT_KERNEL_RWX, DEBUG_PAGEALLOC and KFENCE
Date:   Sat, 23 Oct 2021 13:47:08 +0200
Message-Id: <8963b2a1fd432bc41f55af992987411c2733e59f.1634983809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
References: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634989633; l=2137; s=20211009; h=from:subject:message-id; bh=oWEDR8tps25yLNVilcNXK/8PTGoHv275uQ/WOazr/Kc=; b=CgI+FR9p5oDfTAtqK56zZahIVkya8d2XOd/cNaqDmSO+FkBpDlbM/9HDL8noc5L70InaD/h2O5xB ZAzrSCjpALWa6YV+/Rx9dE6T5VGTDqjGWslzOfZwkG2s37f1B7Tl
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl_booke and 44x are not able to map kernel linear memory with
pages, so they can't support DEBUG_PAGEALLOC and KFENCE, and
STRICT_KERNEL_RWX is also a problem for now.

Enable those only on book3s (both 32 and 64 except KFENCE), 8xx and 40x.

Fixes: 88df6e90fa97 ("[POWERPC] DEBUG_PAGEALLOC for 32-bit")
Fixes: 95902e6c8864 ("powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32")
Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: No change
---
 arch/powerpc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba5b66189358..6b9f523882c5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,7 +138,7 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx || 40x) && !HIBERNATION
 	select ARCH_HAS_STRICT_MODULE_RWX	if ARCH_HAS_STRICT_KERNEL_RWX && !PPC_BOOK3S_32
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
@@ -150,7 +150,7 @@ config PPC
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC32 || PPC_BOOK3S_64
+	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx || 40x
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_MEMTEST
@@ -190,7 +190,7 @@ config PPC
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
-	select HAVE_ARCH_KFENCE			if PPC32
+	select HAVE_ARCH_KFENCE			if PPC_BOOK3S_32 || PPC_8xx || 40x
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-- 
2.31.1

